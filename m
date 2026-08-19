Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8F3C23D16FD
	for <stable@vger.kernel.org>; Wed, 19 Aug 2026 19:08:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1787166522; cv=none; b=u+NQrgpICiWD4wpIiXlABXQVP7yQnFN20htvdZ6ags1WXnZzf8UyLAUIXl8vBPI5E+GzieQpu8//D9+PzNEXYfRHs6Fdx8zz9quMVoQk0wUyhA1bB7MmdmM5ksB1DfHyTnmFdEEgYNqwkHvd7ChyVK8nSIKYusLon4jtiAgQTWA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1787166522; c=relaxed/simple;
	bh=uymZB6nmeU0hvWNE4Ay5ekqSfj0vJTEB6edE39uSdn8=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=PIhKkgWZY3CVrl14HcdPXk09oNWI/YfgK4D2pZlgVXUYfvoCRwvZiS3We7NxFgrmo6XP17mbQJJyqGeS4kwcq3WK8VfKGBVPsSKAlTe8tAH2PYWmW0logo/RgQEEh3o+vAo9D9Sw38DOHwPbxdDJVMo/efO3d87GnYiWE4APD7Y=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=OvIghG6w; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="OvIghG6w"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id BDB041F00A3A;
	Wed, 19 Aug 2026 19:08:40 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1787166521;
	bh=qwytPuUy4/dDUElKmUdiXUP9JSkdlOOow1HOW4gS0Yg=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References;
	b=OvIghG6wlqW/f4Cajzx9zBR1HPhJ4GstUYpHZH/mVOGuUN2h8ddJDWPu4AnduotYH
	 q2+X2FMWh1Il0fCgyz2Py/9wv9wOkvVJuDdqM2SZd+XnHDeNtq8LUWg21/Wt4LRXsI
	 kt72CSHtnp2osGyadL5OXzH4EurNXobC7tgRN8IjQnMpOzgQLgfq00crsiNRu1RvGN
	 b8SeUD0cA64WQoRTcTLvcUavt6EioH3h/hdJHKJUWln1lhYvnVIr6KfBeoajZPQUjO
	 mTpZpct+sp6MjSv1ZLPpDC9hnXfQWJ8cEhVIE4V9SWdAGD/+qcw8I+/EJADRClIECj
	 DcVXWREm6F65w==
From: Sasha Levin <sashal@kernel.org>
To: stable@vger.kernel.org
Cc: Xin Long <lucien.xin@gmail.com>,
	Eric Dumazet <edumazet@google.com>,
	Jakub Kicinski <kuba@kernel.org>,
	Sasha Levin <sashal@kernel.org>
Subject: [PATCH 6.1.y 2/4] net: sched: use skb_ip_totlen and iph_totlen
Date: Wed, 19 Aug 2026 15:08:34 -0400
Message-ID: <20260819190836.561493-2-sashal@kernel.org>
X-Mailer: git-send-email 2.53.0
In-Reply-To: <20260819190836.561493-1-sashal@kernel.org>
References: <2026081753-suffix-dill-686c@gregkh>
 <20260819190836.561493-1-sashal@kernel.org>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

From: Xin Long <lucien.xin@gmail.com>

[ Upstream commit 043e397e48c58b4442ea5124dc1bdc95367a0a33 ]

There are 1 action and 1 qdisc that may process IPv4 TCP GSO packets
and access iph->tot_len, replace them with skb_ip_totlen() and
iph_totlen() accordingly.

Note that we don't need to replace the one in tcf_csum_ipv4(), as it
will return for TCP GSO packets in tcf_csum_ipv4_tcp().

Signed-off-by: Xin Long <lucien.xin@gmail.com>
Reviewed-by: Eric Dumazet <edumazet@google.com>
Signed-off-by: Jakub Kicinski <kuba@kernel.org>
Stable-dep-of: 8a7ed561671a ("net/sched: act_ct: fix sk_buff leak when the header checks reject a packet")
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 net/sched/act_ct.c   | 2 +-
 net/sched/sch_cake.c | 2 +-
 2 files changed, 2 insertions(+), 2 deletions(-)

diff --git a/net/sched/act_ct.c b/net/sched/act_ct.c
index 651701a186fec..81c023f8433cc 100644
--- a/net/sched/act_ct.c
+++ b/net/sched/act_ct.c
@@ -789,7 +789,7 @@ static int tcf_ct_skb_network_trim(struct sk_buff *skb, int family)
 
 	switch (family) {
 	case NFPROTO_IPV4:
-		len = ntohs(ip_hdr(skb)->tot_len);
+		len = skb_ip_totlen(skb);
 		break;
 	case NFPROTO_IPV6:
 		len = sizeof(struct ipv6hdr)
diff --git a/net/sched/sch_cake.c b/net/sched/sch_cake.c
index e210a676dc340..91927d44d2d7c 100644
--- a/net/sched/sch_cake.c
+++ b/net/sched/sch_cake.c
@@ -1269,7 +1269,7 @@ static struct sk_buff *cake_ack_filter(struct cake_sched_data *q,
 			    iph_check->daddr != iph->daddr)
 				continue;
 
-			seglen = ntohs(iph_check->tot_len) -
+			seglen = iph_totlen(skb, iph_check) -
 				       (4 * iph_check->ihl);
 		} else if (iph_check->version == 6) {
 			ipv6h = (struct ipv6hdr *)iph;
-- 
2.53.0

