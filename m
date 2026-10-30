Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=111.22.67.139
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1793369693;
	b=A1DcQRZEiOkScgU1Oq6B6aq5Xy3XoRojgBra9w/Be9n4YwwYIMInWZOYwG3JJjrOilhD
	 FRlEJJiWN/4z/lfLk3BxpXKyrz+vr/Z723JAJ+W3h+vlndoWL7Mv7vf/V2m/u5Yq5mWKP
	 dTQEsUD3OnK2T4SA9G81ESpZvS+kZC4CB3LFDs0ljdAp8mD9HzNlHzcNgTGTITihNJI/E
	 i/8l9C9Uc3zTRwUD+cGxlLLeSzcUGAmUBZn5ZiPzZRojzxQD/HZ/SgtOU37d8xtIaK/ma
	 wXai8syckRXzZy24ysOy+DX4Q/x99I9iR4q+fkIgJGI8B6Jg5G7RbvRRkp0baQMvBQw==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1793369693;
	h=DMARC-Filter:DKIM-Signature:X-RM-TagInfo:X-RM-SPAM-FLAG:Received:
	 X-RM-TRANSID:X-RM-TagInfo:X-RM-SPAM-FLAG:Received:X-RM-TRANSID:From:
	 To:Cc:Subject:Date:Message-ID:X-Mailer:MIME-Version:
	 Content-Transfer-Encoding;
	bh=uSWkWu0paLSVigzrw+dyHl6X7hCrziDcX3CFcmRfIi4=;
	b=lASsNfH5PwCYEhW6+ICkCqA/WnH9ojAX9/Qo3Q5OzDB1RYOTHrDVoZey+S51e61DKFRV
	 Inju0U0qDrIXnwEz8WzqZNEvzNGg46HoyA9jxobS1mRqDbojmwWdH5io9Aj+9dAYnGMNU
	 GxFBU/I+cZns0zAlgWoopJtPqifw6Okat5GPJognlCTNfQY0+selz7zJsM17UKg6FCI8L
	 /OZeplbEhcarNgfyXt43iKXQmIwERBBwRY7rwfQMF33+q3L9TbLmjs1AenlVk85Twa5a7
	 0GY0W2YlMVB9/udOA7PhDlWpfAV6xcFeNYrjDtlxFdNAw7LV45TFNYtdZVo3IgsQatw==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=cmss.chinamobile.com;
	spf=pass smtp.mailfrom=cmss.chinamobile.com;
	dkim=pass header.d=cmss.chinamobile.com header.i=@cmss.chinamobile.com header.a=rsa-sha256 header.s=default header.b="Lm/VmcDW";
	arc=none smtp.remote-ip=111.22.67.139
Received: from cmccmta6.chinamobile.com (cmccmta6.chinamobile.com [111.22.67.139])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 822D4606A31A;
	Fri, 30 Oct 2026 14:14:50 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 822D4606A31A
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=cmss.chinamobile.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=cmss.chinamobile.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key, unprotected) header.d=cmss.chinamobile.com header.i=@cmss.chinamobile.com header.a=rsa-sha256 header.s=default header.b=Lm/VmcDW
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=cmss.chinamobile.com; s=default; l=0;
	h=from:subject:message-id:to:cc:mime-version;
	bh=47DEQpj8HBSa+/TImW+5JCeuQeRkm5NMpJWZG3hSuFU=;
	b=Lm/VmcDWU28tEi+s9Wt6fhNwmihn6RsXswUjsNaq8BLTR993hTPqh4Q4oAl+xDB2Q2cXEaD+Vmj2T
	 Q90ykTShJyc6QpLXAT+tNSSSHIkUsZbqv5tKPC9hVa1fVF2IwMWMtFeqxKIwne/N/MtT3JKWEh9siQ
	 7pzUVTyq0KFwu86U=
X-RM-TagInfo: emlType=0                                       
X-RM-SPAM-FLAG:00000000
Received:from spf.mail.chinamobile.com (unknown[10.188.0.87])
	by rmmx-syy-dmz-app05-12005 (RichMail) with SMTP id 2ee56ae4a657acc-73a14;
	Fri, 30 Oct 2026 22:14:48 +0800 (CST)
X-RM-TRANSID:2ee56ae4a657acc-73a14
X-RM-TagInfo: emlType=0                                       
X-RM-SPAM-FLAG:00000000
Received:from localhost.localdomain (unknown[112.23.104.16])
	by rmsmtp-syy-appsvr02-12002 (RichMail) with SMTP id 2ee26ae4a6574be-625e7;
	Fri, 30 Oct 2026 22:14:48 +0800 (CST)
X-RM-TRANSID:2ee26ae4a6574be-625e7
From: Xia Yan <yanxia@cmss.chinamobile.com>
To: netdev@vger.kernel.org
Cc: dsahern@kernel.org,
	idosch@nvidia.com,
	davem@davemloft.net,
	edumazet@kernel.org,
	kuba@kernel.org,
	pabeni@redhat.com,
	horms@kernel.org,
	willemdebruijn.kernel@gmail.com,
	linux-kernel@vger.kernel.org,
	stable@vger.kernel.org,
	yana06070@163.com
Subject: [PATCH net] ipv6: fix cached route reuse for SO_MARK control messages
Date: Fri, 30 Oct 2026 22:14:35 +0800
Message-ID: <20261030141435.779302-1-yanxia@cmss.chinamobile.com>
X-Mailer: git-send-email 2.43.0
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Post: <mailto:stable@vger.kernel.org>
List-Help: <mailto:stable+help@vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
List-Owner: <mailto:stable+owner@vger.kernel.org>
Precedence: list
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit

A connected IPv6 UDP socket can reuse its cached route when a SO_MARK
control message supplies a different mark. The packet then takes the
route selected for the socket mark instead of the per-message mark.

udpv6_sendmsg() sets flowi6_mark from the control message and clears
connected. However, ip6_sk_dst_lookup_flow() still tries the cached dst;
connected only controls whether a newly looked-up route is stored.
ip6_sk_dst_check() checks the addresses and output interface, but not
the mark.

Commit 42dcfd850e51 ("udp6: allow SO_MARK ctrl msg to affect routing")
fixed the mark used for fresh route lookups; connected sockets still
reuse the route cached before the control message.

Reject the cached dst when flowi6_mark differs from sk_mark so that
the packet goes through a new route lookup with the requested mark.

Found during code review of IPv6 UDP route caching. Reproduced in UML
with a connected socket and a fwmark rule pointing to a prohibit route:
marked sends succeeded before the fix and return EACCES after it.
A two-interface test also confirms that marked sends use the selected
interface and subsequent sends without a control message still use the
socket mark. cmsg_so_mark.sh passes before and after.

Fixes: c6af0c227a22 ("ip: support SO_MARK cmsg")
Cc: stable@vger.kernel.org
Signed-off-by: Xia Yan <yanxia@cmss.chinamobile.com>
---

Tested on net 5838f10563d58afca6711edb5e4eda968ca181d9. The relevant
send and route-cache code is unchanged at the base commit.

Full x86_64 W=1 builds completed before and after with no new
diagnostics, using configurations based on allmodconfig and
allyesconfig. WERROR was disabled for both; allyesconfig also had
KASAN disabled. Both used LD_ORPHAN_WARN_LEVEL="warn" and
DRM_WERROR=n.

 net/ipv6/ip6_output.c | 1 +
 1 file changed, 1 insertion(+)

diff --git a/net/ipv6/ip6_output.c b/net/ipv6/ip6_output.c
index 25fe0ba98b1a6..843bb95e635b9 100644
--- a/net/ipv6/ip6_output.c
+++ b/net/ipv6/ip6_output.c
@@ -1125,6 +1125,7 @@ static struct dst_entry *ip6_sk_dst_check(struct sock *sk,
 	    ip6_rt_check(&rt->rt6i_src, &fl6->saddr,
 			 np->saddr_cache ? &np->saddr : NULL) ||
 #endif
+	    fl6->flowi6_mark != READ_ONCE(sk->sk_mark) ||
 	   (fl6->flowi6_oif && fl6->flowi6_oif != dst_dev(dst)->ifindex)) {
 		dst_release(dst);
 		dst = NULL;

base-commit: d8a4f4c59da52b7c31ae337243b8473a19a3f819
-- 
2.39.0.windows.2



