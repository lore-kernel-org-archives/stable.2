Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=100.103.45.18
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1794047036;
	b=IC0S05nFpv471E5CIg/zMM96zoyUFOjf6J6ZV//dA8kv1Q3OQpumSl5RRD9KNvGocpJ5
	 KxAFdRzcr6ezk5LnWikXeg8NxGlYaOShtJk6pjLbAZR4bAMHTJhqwobQo47auU22pswEc
	 4Sa3tZAj1Qx7S+7BLIWQuw363nH/GjPzNHL3Tkd/OB9VvI25zqv/DkayBUm4sEGzxqK4d
	 lZv1d/H59qxMWKhwTOTaMfdwUDW3qSS6mp4J6Kkqzaz3p3MRGU1KZd/Qbt//5FvvbUiNt
	 T0dYVoJGAXtJqQqhhlGrkxjmVNEX0NgAlC8v/OJnPHrEvdeTzhORO1KA3C0Z0NpTsqQ==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1794047036;
	h=Received:DKIM-Signature:From:To:Cc:Subject:Date:Message-ID:X-Mailer:
	 MIME-Version:Content-Type:Content-Transfer-Encoding;
	bh=yZm42HIXhsIYl/iBYenMZ7F2TLaU2LVrRcKkOv7/CiI=;
	b=OCqoLKdZRou0K3sf7RXpBiHe8pq2qCxJvfa/cEDKPXNJNa9Z4l6yz1HxQLHXKARFh1EY
	 NNio30G1ASkastunjAMR4XCqBNTkWGVjFRfHVDGDUakmMcQAcE9FkAr8/FbjfWv1wlFGO
	 21k5qH+76MwLK1CxvXde10mhAyOt7zcXHcrxtfxNtlhzLlVYWI58Zk9GIYQtksAQxYAj5
	 ywqYjvTieYIPQawGWFkQAbfA6pyEQVPHOqNGRnLXuQGR1d+tXcQO3+9/FP8vQYVe+Ybvv
	 +l1J5CCRm8YANKpemBJNBAlztRgitXe7WT4xM/ThAhRS6HFd7vNsMls6wbCu8s6hdjg==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dkim=pass header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=WJYJ4sAx;
	arc=none smtp.remote-ip=100.103.45.18
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CDEFB606A326
	for <stable@vger.kernel.org>; Sat,  7 Nov 2026 10:23:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=WJYJ4sAx
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 1D6CA1F0089F;
	Sat,  7 Nov 2026 10:23:55 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1794047035;
	bh=yZm42HIXhsIYl/iBYenMZ7F2TLaU2LVrRcKkOv7/CiI=;
	h=From:To:Cc:Subject:Date;
	b=WJYJ4sAxpbM48eCFe7/KAXUV6Pagc0aEiwanOJR/SLxosMt3L/+4UQ+kqpUvK4c6Y
	 3xCZs6O158YcP7iRouf6X+/SHjDWXxfwvz/yovBA2d76fxV3BlsYW//Syx+eWklP01
	 uqy8xPBaBeNL9AWeZ72M3CuNQR4qIs5C/2tYsZm14k2awjY6P+JZJ0lOOywcUD48pZ
	 cVx7sPlzMRvGT539Azx8G8dPqd8ZhegzrGKUzafHy+hq31Z6a9vittKf+ib7bXj4Nh
	 pmVZqK8L0nVruJs2whbZrFiKKmaVgpB+baOvz3z1TttMx7N5XaLZf11GJQ+rBCe7FC
	 6DdIzEZbbztzQ==
From: Sasha Levin <sashal@kernel.org>
To: liuc63@xiaopeng.com,
	liuwb@xiaopeng.com,
	fw@strlen.de,
	pablo@netfilter.org
Cc: stable@vger.kernel.org
Subject: FAILED: patch "[PATCH] netfilter: nf_conntrack_netlink: fix inverted IPv6 tuple filter" failed to apply to 6.12-stable tree
Date: Sat,  7 Nov 2026 05:23:54 -0500
Message-ID: <20261107052354-failed-6.12-cd37ab22a74e@kernel.org>
X-Mailer: git-send-email 2.53.0
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Post: <mailto:stable@vger.kernel.org>
List-Help: <mailto:stable+help@vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
List-Owner: <mailto:stable+owner@vger.kernel.org>
Precedence: list
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit

The patch below does not apply to the 6.12-stable tree.
If someone wants it applied there, or to any other stable or longterm
tree, then please email the backport, including the original git commit
id to <stable@vger.kernel.org>.

To reproduce the conflict and resubmit, you may use the following commands:

git fetch https://git.kernel.org/pub/scm/linux/kernel/git/stable/linux.git/ linux-6.12.y
git checkout FETCH_HEAD
git cherry-pick -x cd37ab22a74e05aae5c16c67295cbf5188b16268
# <resolve conflicts, build, test, etc.>
git commit -s
git send-email --to '<stable@vger.kernel.org>' --in-reply-to '20261107052354-failed-6.12-cd37ab22a74e@kernel.org' --subject-prefix 'PATCH 6.12.y' 'HEAD^..'

Thanks,
Sasha

------------------ original commit in Linus's tree ------------------

From cd37ab22a74e05aae5c16c67295cbf5188b16268 Mon Sep 17 00:00:00 2001
From: Liu Chao <liuc63@xiaopeng.com>
Date: Mon, 19 Oct 2026 15:56:26 +0800
Subject: [PATCH] netfilter: nf_conntrack_netlink: fix inverted IPv6 tuple
 filter

ctnetlink_filter_match_tuple() returns 0 (no match) when the IPv6
source or destination address differs from the filter, because the
!ipv6_addr_cmp() test is inverted.  ipv6_addr_cmp() returns 0 when
the addresses are equal, so the negation makes the branch trigger on
a match instead of a mismatch, which is the opposite of the IPv4
path above.

Drop the '!' so the IPv6 branch returns 0 only when the addresses
differ, matching the IPv4 semantics and the caller's expectation.

Fixes: cb8aa9a3affb ("netfilter: ctnetlink: add kernel side filtering for dump")
Cc: stable@vger.kernel.org
Signed-off-by: Liu Chao <liuc63@xiaopeng.com>
Reviewed-by: Weibin Liu <liuwb@xiaopeng.com>
Reviewed-by: Florian Westphal <fw@strlen.de>
Signed-off-by: Pablo Neira Ayuso <pablo@netfilter.org>
---
 net/netfilter/nf_conntrack_netlink.c | 8 ++++----
 1 file changed, 4 insertions(+), 4 deletions(-)

diff --git a/net/netfilter/nf_conntrack_netlink.c b/net/netfilter/nf_conntrack_netlink.c
index 4e5d7c7014368..cc8695d5356d2 100644
--- a/net/netfilter/nf_conntrack_netlink.c
+++ b/net/netfilter/nf_conntrack_netlink.c
@@ -1098,13 +1098,13 @@ static int ctnetlink_filter_match_tuple(struct nf_conntrack_tuple *filter_tuple,
 		break;
 	case NFPROTO_IPV6:
 		if ((flags & CTA_FILTER_FLAG(CTA_IP_SRC)) &&
-		    !ipv6_addr_cmp(&filter_tuple->src.u3.in6,
-				   &ct_tuple->src.u3.in6))
+		    ipv6_addr_cmp(&filter_tuple->src.u3.in6,
+				  &ct_tuple->src.u3.in6))
 			return 0;
 
 		if ((flags & CTA_FILTER_FLAG(CTA_IP_DST)) &&
-		    !ipv6_addr_cmp(&filter_tuple->dst.u3.in6,
-				   &ct_tuple->dst.u3.in6))
+		    ipv6_addr_cmp(&filter_tuple->dst.u3.in6,
+				  &ct_tuple->dst.u3.in6))
 			return 0;
 		break;
 	}
-- 
2.53.0




