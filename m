Received: from linux.microsoft.com (linux.microsoft.com [13.77.154.182])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 9C70338E5E9;
	Thu,  8 Oct 2026 19:48:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=13.77.154.182
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1791488924; cv=none; b=qGXEX5R5Em0OZO/gXMKShlRZqJd5ZW42y5aJx7FsuI5JRidwJyyL2yv1ZzF+RYknKW1kWSC1/jZSpD2NIlTl2oGwljynzUm3+4qO2XjWhN8Acoy4+TvTFfj+yaGrWbebyp9nEXQgagfX94umZqsrUJKDXSSosV74/mnRT5RavIg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1791488924; c=relaxed/simple;
	bh=+Al8iAM4S2p4vBygCdBdTA3YKZzHNUtQxaLYd9uWWSA=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=XXEBsjNibm2/FEP3Y66F8yln7/AJ1TBElPFJG3Ypytzi7HXWu+eOg2s9aEUfVQR5540X8ChH6zfMydRx68zD/G7i6bI7dBeXXFKSKPvENs+ntpzvVFh9LyMra1tS/VOLOcWAkNeQxDPkzcMuSvomcqLVBnDt5/1E33uGiYwR3Hc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.microsoft.com; spf=pass smtp.mailfrom=linux.microsoft.com; dkim=pass (1024-bit key) header.d=linux.microsoft.com header.i=@linux.microsoft.com header.b=atZfvnKI; arc=none smtp.client-ip=13.77.154.182
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.microsoft.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.microsoft.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux.microsoft.com header.i=@linux.microsoft.com header.b="atZfvnKI"
Received: from mac.lan (unknown [4.194.122.162])
	by linux.microsoft.com (Postfix) with ESMTPSA id 111ED20B7168;
	Thu,  8 Oct 2026 12:47:35 -0700 (PDT)
DKIM-Filter: OpenDKIM Filter v2.11.0 linux.microsoft.com 111ED20B7168
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linux.microsoft.com;
	s=default; t=1791488866;
	bh=9+lNjYpny4CcV0G2OLWLWcCQ9nD5E2Jh4vrTh6nPu7Q=;
	h=From:To:Cc:Subject:Date:From;
	b=atZfvnKIhS80uvYsEYHKu0H14DPKwyA+ixEixhMdPRdAaQsxUewoe+vK7aGVIZtzC
	 YULtkQhO8L9AATcTq9NXn28pS5lLUfAISIXX+pQl9bYgIA1lhRto7SrmKbYu9J7xWp
	 5DavYgMMo77hnm+ttF6PiGsJFVOE4QMOMV7jx2qw=
From: "Cen Zhang (Microsoft)" <cenzhang@linux.microsoft.com>
To: "David S. Miller" <davem@davemloft.net>,
	Eric Dumazet <edumazet@kernel.org>,
	Jakub Kicinski <kuba@kernel.org>,
	Paolo Abeni <pabeni@redhat.com>
Cc: Simon Horman <horms@kernel.org>,
	Kees Cook <kees@kernel.org>,
	Jeff Layton <jlayton@kernel.org>,
	Nicolas Dichtel <nicolas.dichtel@6wind.com>,
	Ilya Maximets <i.maximets@ovn.org>,
	Kexin Sun <kexinsun@smail.nju.edu.cn>,
	Enrico Pozzobon <enrico.pozzobon@dissecto.com>,
	Breno Leitao <leitao@debian.org>,
	David Rheinsberg <david@readahead.eu>,
	netdev@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	stable@vger.kernel.org,
	AutonomousCodeSecurity@microsoft.com,
	tgopinath@linux.microsoft.com,
	Cen Zhang <cenzhang@linux.microsoft.com>
Subject: [PATCH net] netlink: do not copy to user space under netlink_lock_table()
Date: Thu,  8 Oct 2026 15:48:24 -0400
Message-ID: <20261008194824.52351-1-cenzhang@linux.microsoft.com>
X-Mailer: git-send-email 2.55.0
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

netlink_getsockopt() handles NETLINK_LIST_MEMBERSHIPS by copying the
socket's group bitmap to user space with copy_to_iter() under
netlink_lock_table(). However, copy_to_iter() writes to a user address
and can trigger a page fault, and how long that fault takes is up to the
owner of the page. An unprivileged user can make it take as long as they
want, e.g. by mapping a memfd page and keeping it hole punched from
another thread. While the fault is pending, the caller still counts as a
holder of nl_table_users.

nl_table_users is one global counter shared by every netlink protocol
and every network namespace, and netlink_table_grab() waits for it to
drop to zero in TASK_UNINTERRUPTIBLE with no timeout and no signal
check. Therefore, by holding one page fault open, an unprivileged user
blocks every task on the machine that needs netlink_table_grab(): e.g.,
close of a netlink socket, multicast group join, and network namespace
creation. The blocked tasks stay in an unkillable D state until the
attacker lets the fault finish, and hung task detector reports is as
following:

  INFO: task V1-nl-close:103 blocked for more than 122 seconds.
  task:V1-nl-close     state:D stack:14448 pid:103 ...
  Call Trace:
   schedule+0x36/0xf0
   netlink_table_grab.part.0+0x66/0xe0
   netlink_release+0x6d4/0x780
   __x64_sys_close+0x38/0x80

Fix this by taking a kmemdup() snapshot of the bitmap under
netlink_lock_table() and copying the snapshot to user space after the
lock is released.

Fixes: 47191d65b647 ("netlink: fix locking around NETLINK_LIST_MEMBERSHIPS")
Reported-by: AutonomousCodeSecurity@microsoft.com
Signed-off-by: Cen Zhang (Microsoft) <cenzhang@linux.microsoft.com>
---
 net/netlink/af_netlink.c | 20 ++++++++++++++++----
 1 file changed, 16 insertions(+), 4 deletions(-)

diff --git a/net/netlink/af_netlink.c b/net/netlink/af_netlink.c
index 9fdf964224ab..f61ff699761f 100644
--- a/net/netlink/af_netlink.c
+++ b/net/netlink/af_netlink.c
@@ -1767,24 +1767,36 @@ static int netlink_getsockopt(struct socket *sock, int level, int optname,
 		flag = NETLINK_F_RECV_NO_ENOBUFS;
 		break;
 	case NETLINK_LIST_MEMBERSHIPS: {
+		unsigned long *groups = NULL;
 		int pos, idx, shift, err = 0;
+		unsigned int ngroups;
 
+		/* copy_to_iter() may sleep in a page fault, do it unlocked. */
 		netlink_lock_table();
-		for (pos = 0; pos * 8 < nlk->ngroups; pos += sizeof(u32)) {
+		ngroups = nlk->ngroups;
+		if (ngroups)
+			groups = kmemdup(nlk->groups, NLGRPSZ(ngroups),
+					 GFP_KERNEL);
+		netlink_unlock_table();
+
+		if (ngroups && !groups)
+			return -ENOMEM;
+
+		for (pos = 0; pos * 8 < ngroups; pos += sizeof(u32)) {
 			if (len - pos < sizeof(u32))
 				break;
 
 			idx = pos / sizeof(unsigned long);
 			shift = (pos % sizeof(unsigned long)) * 8;
-			group = (u32)(nlk->groups[idx] >> shift);
+			group = (u32)(groups[idx] >> shift);
 			if (copy_to_iter(&group, sizeof(u32),
 					 &opt->iter_out) != sizeof(u32)) {
 				err = -EFAULT;
 				break;
 			}
 		}
-		opt->optlen = ALIGN(BITS_TO_BYTES(nlk->ngroups), sizeof(u32));
-		netlink_unlock_table();
+		opt->optlen = ALIGN(BITS_TO_BYTES(ngroups), sizeof(u32));
+		kfree(groups);
 		return err;
 	}
 	case NETLINK_LISTEN_ALL_NSID:
-- 
2.55.0
