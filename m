Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=100.103.45.18
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1794049700;
	b=zxZab4xLQthfomTXq+AkHv226pcF4Ele0iCwcX/u9jqS5Xfx+hSptJWT/cqO1usFJtY9
	 x6o/AoyGtiFRThO+FfTMA9z3UjqktmaQBdBJbmuNA+Q5qdH5DaTAD1KLW5nFBZ1FBlW8v
	 Zvd8GVSLfAJt0GY4fWr1ZkrUA9KIPpzFkgjlq1odr2wCEu4qtu++Drck9Bs1A+H9YBDyC
	 ttsKgs+WhhuxXsB4StbGAA4P1vtvHI2c5AS947pK2gshvTg6JrXSwPyyf5CXKhpvH0D+W
	 IpuAT6C5aMo3lvkY7ffpERycv1e9M55Ly12bcobbY/7es5eCuoiDsMLJ1id25u073Hg==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1794049700;
	h=Received:DKIM-Signature:From:To:Cc:Subject:Date:Message-ID:X-Mailer:
	 MIME-Version:Content-Type:Content-Transfer-Encoding;
	bh=fDXHQQ+q3dbxOWmPuRSBMl/u12tF0EB5QCnDRBGLJNc=;
	b=fTkXwFgJyQfYl+RVgQxiPpcQk402SmwRwvZjskfpwF2z1f+IjdoLN4waItZwn13Jj92+
	 jVTyi7ehlggdDFyIOyV8Gx6w74GyAmGYT3kw6ODCzqp3c3iOZSs3N0PAGnN/eh3kZi/ds
	 CRuboT/t3VxQNP3zzazTF2PYqdAleLuVUe81MYaqtyRUtvLEDGJNyVrlq6poALwoL4lBw
	 pUdzMH0WDM7MvZ/HLMB8pL0/DqvI/x0y4VtrPdY7j7gyqWr3iH4n/LN1EBcbgJfam+q/O
	 s7+eKqiFP2749Xn7CsEuAstKp5VmrP2X9nv06qeR2s0fh+7N0fSCUDOyF/aPbEUGT0g==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dkim=pass header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=aImm+US9;
	arc=none smtp.remote-ip=100.103.45.18
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2043B606A326
	for <stable@vger.kernel.org>; Sat,  7 Nov 2026 11:08:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=aImm+US9
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 673361F0089F;
	Sat,  7 Nov 2026 11:08:19 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1794049700;
	bh=fDXHQQ+q3dbxOWmPuRSBMl/u12tF0EB5QCnDRBGLJNc=;
	h=From:To:Cc:Subject:Date;
	b=aImm+US9PKphhPTmCz2GIQ6Uc8g1amvrYyE3Jw5xWGHYRl42zCuRmj3GFc3wINllo
	 AlN8RJdWO46kJL1vH3rqhYTZM/eV4vrWU+Uq2bp3Si+6nU8Vh2r4cyg7mkQOk+C+SL
	 17XjFPqmK2VG5aUW4Vp83b2Mlwz2e5QQPjItRGElmOMzD8a0PPUnn/2qNI0HIQCPcE
	 PITBStjGbXS7TzwZaRleDoDqAooDJ8jGxm/OF3Xn5lEkIUibz1p4AgLAOKCOo5tB2O
	 s0gPt1KBxE7AXlBGY5x5yeM0cMOCj05l1UvJ3xZ1I2Hr6Ih6W3PuhcgBvEW7cWGQbN
	 urIAC1cOV7R7A==
From: Sasha Levin <sashal@kernel.org>
To: liuc63@xiaopeng.com,
	liuwb@xiaopeng.com,
	fw@strlen.de,
	pablo@netfilter.org
Cc: stable@vger.kernel.org
Subject: FAILED: patch "[PATCH] netfilter: nf_conntrack_netlink: fix inverted IPv6 tuple filter" failed to apply to 5.15-stable tree
Date: Sat,  7 Nov 2026 06:08:18 -0500
Message-ID: <20261107060818-failed-5.15-cd37ab22a74e@kernel.org>
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

The patch below does not apply to the 5.15-stable tree.
If someone wants it applied there, or to any other stable or longterm
tree, then please email the backport, including the original git commit
id to <stable@vger.kernel.org>.

To reproduce the conflict and resubmit, you may use the following commands:

git fetch https://git.kernel.org/pub/scm/linux/kernel/git/stable/linux.git/ linux-5.15.y
git checkout FETCH_HEAD
git cherry-pick -x cd37ab22a74e05aae5c16c67295cbf5188b16268
# <resolve conflicts, build, test, etc.>
git commit -s
git send-email --to '<stable@vger.kernel.org>' --in-reply-to '20261107060818-failed-5.15-cd37ab22a74e@kernel.org' --subject-prefix 'PATCH 5.15.y' 'HEAD^..'

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




