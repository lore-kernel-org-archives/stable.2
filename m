Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 27AC14D6C41
	for <stable@vger.kernel.org>; Wed, 16 Sep 2026 16:12:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1789575143; cv=none; b=ubXVmVwcqFi5CnreGMkixWMqXQ6jV2PBZVZzpdpqigxolVJUMWoXBKGFwVU3bzGkfLDhT1O1iJQLimr5CegzU+50V8zwW7BnHFttEoU6f23OCNOxAxRnmo7TIvU79Joq5E7ogXTlABmZJCgT1867VvL17n80/2EW0w/p3H5UAAk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1789575143; c=relaxed/simple;
	bh=w9zb6qbW3G9prfiDWvIuNaz51No33CuFiuj/FT1KvgA=;
	h=Subject:To:Cc:From:Date:Message-ID:MIME-Version:Content-Type; b=lzSH3mn4vdQ3CHqxJo36N3qxqtFO1F50e0nzlhSGxNsVs28rUkXqeHtqzwq/9MdVF8pw2kIbaF6xNem4ECPrHrxPIkIczt/IaektjW2hl5s2MT+pnAG+oPr8aSZsjHvlyCkUUbM9ssSgi2s43/YOyCBLI2+Qd2D1g7DkeGJz19s=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b=mUwjXseX; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b="mUwjXseX"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 725531F000FF;
	Wed, 16 Sep 2026 16:12:20 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linuxfoundation.org;
	s=korg; t=1789575141;
	bh=eV+Rekjj67OwWavJVNF/otdueZueBrdzs1CRJiRXoko=;
	h=Subject:To:Cc:From:Date;
	b=mUwjXseXAgGw5H+3DUy1VRTYIhblfUd/18z93wfbD5W3wLfaOM0PYuC0LErh1TFyY
	 7Kpuy1jEfsurMxaK0szpIR9UutqeGafX+w949M2Vaul/Xt1bumOGgikf2M/JqQWhAw
	 UA8P/VD5DPalvpi417/2NKWi4HTr9COvza/Icb0M=
Subject: FAILED: patch "[PATCH] ipv6: flowlabel: cap duplicate leases per socket" failed to apply to 6.12-stable tree
To: zhilinz@nebusec.ai,edumazet@google.com,idosch@nvidia.com,kuba@kernel.org,vega@nebusec.ai
Cc: <stable@vger.kernel.org>
From: <gregkh@linuxfoundation.org>
Date: Wed, 16 Sep 2026 16:59:55 +0100
Message-ID: <2026091655-dejected-hammock-755e@gregkh>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=ANSI_X3.4-1968
Content-Transfer-Encoding: 8bit


The patch below does not apply to the 6.12-stable tree.
If someone wants it applied there, or to any other stable or longterm
tree, then please email the backport, including the original git commit
id to <stable@vger.kernel.org>.

To reproduce the conflict and resubmit, you may use the following commands:

git fetch https://git.kernel.org/pub/scm/linux/kernel/git/stable/linux.git/ linux-6.12.y
git checkout FETCH_HEAD
git cherry-pick -x 8d6cd188508513503805c156165de38e4e4a8615
# <resolve conflicts, build, test, etc.>
git commit -s
git send-email --to '<stable@vger.kernel.org>' --in-reply-to '2026091655-dejected-hammock-755e@gregkh' --subject-prefix 'PATCH 6.12.y' 'HEAD^..'

Possible dependencies:



thanks,

greg k-h

------------------ original commit in Linus's tree ------------------

From 8d6cd188508513503805c156165de38e4e4a8615 Mon Sep 17 00:00:00 2001
From: Zhiling Zou <zhilinz@nebusec.ai>
Date: Thu, 3 Sep 2026 14:23:03 +0800
Subject: [PATCH] ipv6: flowlabel: cap duplicate leases per socket

ipv6_flowlabel_get() allocates an ipv6_fl_socklist entry for every
successful GET. The recheck path for a compatible existing flowlabel
links another lease without applying any lease admission check. Repeated
GET requests for one shareable label can therefore grow a socket's lease
list without bound.

Reject a new unprivileged lease once the socket already holds
FL_MAX_PER_SOCK leases. Check this on the shared recheck path so reuse
of a globally interned label, including the fl_intern() collision path,
is covered as well. New-label admission remains under the existing
mem_check() policy.

Use capable(CAP_NET_ADMIN) rather than ns_capable(), matching
mem_check(). An unprivileged user must not bypass the cap by creating a
user namespace and a netns where they have CAP_NET_ADMIN, which would
still consume host memory.

Check the capability only when the socket reaches the limit, so
successful unprivileged GET requests below the cap do not generate a
capability audit. Do the admission check before updating linger and
expires so a rejected GET does not refresh the shared label, matching
the existing socket-list allocation failure path.

Fixes: 1da177e4c3f4 ("Linux-2.6.12-rc2")
Cc: stable@vger.kernel.org
Reported-by: Vega <vega@nebusec.ai>
Suggested-by: Ido Schimmel <idosch@nvidia.com>
Signed-off-by: Zhiling Zou <zhilinz@nebusec.ai>
Reviewed-by: Eric Dumazet <edumazet@google.com>
Reviewed-by: Ido Schimmel <idosch@nvidia.com>
Link: https://patch.msgid.link/83f8535972ff6e3741548476a1d50dec24c758be.1788415194.git.zhilinz@nebusec.ai
Signed-off-by: Jakub Kicinski <kuba@kernel.org>

diff --git a/net/ipv6/ip6_flowlabel.c b/net/ipv6/ip6_flowlabel.c
index 1ab5ad0dcf24..006585dc8b5c 100644
--- a/net/ipv6/ip6_flowlabel.c
+++ b/net/ipv6/ip6_flowlabel.c
@@ -461,6 +461,21 @@ fl_create(struct net *net, struct sock *sk, struct in6_flowlabel_req *freq,
 	return NULL;
 }
 
+static bool fl_sock_at_lease_limit(const struct sock *sk)
+{
+	const struct ipv6_fl_socklist *sfl;
+	int count = 0;
+
+	rcu_read_lock();
+	for_each_sk_fl_rcu(sk, sfl) {
+		if (++count >= FL_MAX_PER_SOCK)
+			break;
+	}
+	rcu_read_unlock();
+
+	return count >= FL_MAX_PER_SOCK;
+}
+
 static int mem_check(struct sock *sk)
 {
 	const int unpriv_total_limit = FL_MAX_SIZE - (FL_MAX_SIZE / 4);
@@ -679,6 +694,10 @@ static int ipv6_flowlabel_get(struct sock *sk, struct in6_flowlabel_req *freq,
 			err = -ENOMEM;
 			if (!sfl1)
 				goto release;
+			err = -ENOBUFS;
+			if (fl_sock_at_lease_limit(sk) &&
+			    !capable(CAP_NET_ADMIN))
+				goto release;
 			if (fl->linger > fl1->linger)
 				fl1->linger = fl->linger;
 			if ((long)(fl->expires - fl1->expires) > 0)

