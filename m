Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=100.103.45.18
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1794048674;
	b=yObh0E+K5l+YE2IbXIVRDHA/NlTawVHQGZW0XYtxVemB8I5elxQnlYY5ToxYIiRpPVTL
	 nwyKwuCbrI6DHRVYGaRDC9/t/5B52KCiIvP10IvY73kgRVd1YLrrxkYcSBSrM9NWVdaKT
	 17fYom/qxjoCxFj++Yz0AcxNZh3oH0d4Xk8D6AbtNuBsaTeeKgn8MyGNkIid27f8/U/G2
	 KN9GJtKYLE1ry3tx31YTLuCTe/oC7t4U0avl7vTUWDNpTGmaSozWeNwsqNTuzN/GBvZeA
	 TofHhf2XSe6In/l+i39bNtR4tRHshY0E7RunsJ6fsprzKKhThDbozKAFjMfCx62WfIw==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1794048674;
	h=Received:DKIM-Signature:From:To:Cc:Subject:Date:Message-ID:X-Mailer:
	 MIME-Version:Content-Type:Content-Transfer-Encoding;
	bh=uXUNCXk7bXKsicpJHXFGCCC6DJD+3icvfMnax00aUig=;
	b=o3c+1OFSvocI16pBf7QM1//tOcLer6uvffEo23IWdmFqzML2jq/xtIoxj0U0/5AALZ2G
	 AIqvc81Y5PEd0qoZlsfM/lMCo+AoGwKPJjp/iDWpJ7WS4+OnjQzR+xGxXO/rJtpQXRyt2
	 6iH5xhf4aWYjwW0eO/cSc7xdi/eFnNa/TSXJiCm0BRAvd6Vfnq4HhU01tD/fnQnwbAFLp
	 PWeMvS48R49vWb2RD6nwmQzv5Jyv9qvI/eORaFuRSgmt8CkBgX3PQz9Fqs1SQxTWq62S+
	 /aQZBdI6G+2OXzr9y8NM1Db0TVT/CEPP93LNOL821BAjAJ2G7ZLkDD4N1J1XFKyT1EQ==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dkim=pass header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=KkeNixNc;
	arc=none smtp.remote-ip=100.103.45.18
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5A909606EE92
	for <stable@vger.kernel.org>; Sat,  7 Nov 2026 10:51:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=KkeNixNc
Received: by smtp.kernel.org (Postfix) with ESMTPSA id E6B111F0089F;
	Sat,  7 Nov 2026 10:51:12 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1794048673;
	bh=uXUNCXk7bXKsicpJHXFGCCC6DJD+3icvfMnax00aUig=;
	h=From:To:Cc:Subject:Date;
	b=KkeNixNcHtNi66KaUL2VREZhl6gRN+PaDQ9mQmW+BfyVftlrsTeOvb9lt8ArQh7PH
	 /ceZbip+ViJfyi5z/f1uGGKePhEcNp7XvL9i8s69rpjt5hKfx39mcFz47Tm+5FuSEb
	 M2J2iDpzdV6ypDqDiuSmr+VkZHVOOyW4mCvpaWlsgjEUE5vGYXYCsabcL5qmuJGpTD
	 NZqq8K1MN8pVURC77pbj4sMW1ajJL+l1GNnDZtveqJgGMTpAnuYVunKhSeYK2UZRJX
	 QIB3WVA4dSP3xJzyQjkfz4HtaWBLo+GZaFnvYDjwmOhMfgF+kh5Zj8H3Gi0a0ngLiO
	 Wc8pGMRjTjJtA==
From: Sasha Levin <sashal@kernel.org>
To: liuc63@xiaopeng.com,
	liuwb@xiaopeng.com,
	fw@strlen.de,
	pablo@netfilter.org
Cc: stable@vger.kernel.org
Subject: FAILED: patch "[PATCH] netfilter: nf_conntrack_netlink: fix inverted IPv6 tuple filter" failed to apply to 6.1-stable tree
Date: Sat,  7 Nov 2026 05:51:11 -0500
Message-ID: <20261107055111-failed-6.1-cd37ab22a74e@kernel.org>
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

The patch below does not apply to the 6.1-stable tree.
If someone wants it applied there, or to any other stable or longterm
tree, then please email the backport, including the original git commit
id to <stable@vger.kernel.org>.

To reproduce the conflict and resubmit, you may use the following commands:

git fetch https://git.kernel.org/pub/scm/linux/kernel/git/stable/linux.git/ linux-6.1.y
git checkout FETCH_HEAD
git cherry-pick -x cd37ab22a74e05aae5c16c67295cbf5188b16268
# <resolve conflicts, build, test, etc.>
git commit -s
git send-email --to '<stable@vger.kernel.org>' --in-reply-to '20261107055111-failed-6.1-cd37ab22a74e@kernel.org' --subject-prefix 'PATCH 6.1.y' 'HEAD^..'

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




