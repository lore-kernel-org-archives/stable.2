Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 709073A1E96
	for <stable@vger.kernel.org>; Thu, 17 Sep 2026 04:08:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1789618102; cv=none; b=dbB4b/rgeR+hV5mZL9E42I3VsdwqwBttWc/BrbBkuXp+E188dJl1GtOAysmcSN3ZuW7upHs/aKeMs68bQeZbgWLXEQKjWWdHUc+A1BPtV5+kO6J0GmMs3hhE56bKfbSv5hmoY1hh1B66LvlVVx9oBNHsYfDeDw2wc767Lu9VSXI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1789618102; c=relaxed/simple;
	bh=YkcyDvQogK0utZkN38nJNgBpnVQc2ttxyIdtujdZtvg=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=loyeZDa5eYwuqOH4CwqotT1UNDV/37VL/kTZzCEcZ/N0XaS35euAoCwd8olxPBWTUxRmPydVYgzUK6hAXmibYDm7qcD+LS+le0s/8ytggxwfE84XtfpT8Od3ljCPrZ4ctIhIGNzILdHcvqck14/RGURzFwsf3qYe38mASmzKLzI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=olozN+c/; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="olozN+c/"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 8B4DA1F00893;
	Thu, 17 Sep 2026 04:08:20 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1789618101;
	bh=T1PjajoyJ1T+DSxixRF0gd7wQql5R8EFcyJ4jT0THJI=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References;
	b=olozN+c/A7HTZODq8zsB8qD4/IItEo52/j5d/n+DJzSato6M8N3kSCc7Q/K9dK4gT
	 QMWAsXqI5NRhhCq/TqOmujwan2t9CAHM8RbdNTtHn9dJSj787xFQi0At3knf+KxoBa
	 Fu/Ef4liNE5XPtSA9wXGrv18+xmW5n2ADMO8zu2a+iOJ9kg3p28lvNvRMUhmzI8jGh
	 Gv7Wi+l4aY+8J0/NV46B0DP1oF+Mo6SAmFC4/9R3+ARxyM+cnSpMHQYSaGc3mYX7mT
	 FfV8JivagiyqpY782gbeY8fkHvnz2WKheDuxUo5D6KvJhKwROpMitB9NSTxYsLHVyj
	 QasIz9ubYmd6g==
From: Sasha Levin <sashal@kernel.org>
To: stable@vger.kernel.org
Cc: Zhiling Zou <zhilinz@nebusec.ai>,
	Vega <vega@nebusec.ai>,
	Ido Schimmel <idosch@nvidia.com>,
	Eric Dumazet <edumazet@google.com>,
	Jakub Kicinski <kuba@kernel.org>,
	Sasha Levin <sashal@kernel.org>
Subject: [PATCH 5.15.y 5/5] ipv6: flowlabel: cap duplicate leases per socket
Date: Thu, 17 Sep 2026 00:08:15 -0400
Message-ID: <20260917040815.4171498-5-sashal@kernel.org>
X-Mailer: git-send-email 2.53.0
In-Reply-To: <20260917040815.4171498-1-sashal@kernel.org>
References: <2026091657-voter-although-5ad8@gregkh>
 <20260917040815.4171498-1-sashal@kernel.org>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

From: Zhiling Zou <zhilinz@nebusec.ai>

[ Upstream commit 8d6cd188508513503805c156165de38e4e4a8615 ]

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
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 net/ipv6/ip6_flowlabel.c | 19 +++++++++++++++++++
 1 file changed, 19 insertions(+)

diff --git a/net/ipv6/ip6_flowlabel.c b/net/ipv6/ip6_flowlabel.c
index 731d28be6e304..073fe6486824a 100644
--- a/net/ipv6/ip6_flowlabel.c
+++ b/net/ipv6/ip6_flowlabel.c
@@ -459,6 +459,21 @@ fl_create(struct net *net, struct sock *sk, struct in6_flowlabel_req *freq,
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
@@ -671,6 +686,10 @@ static int ipv6_flowlabel_get(struct sock *sk, struct in6_flowlabel_req *freq,
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
-- 
2.53.0

