Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=100.103.45.18
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1794050712;
	b=G9+9AQ0qVuqFyEIVAGt7TKsmCyhV686OrZktL+RjWmkMnF1jUnwbwdXBX/pV8/syyLH3
	 qAHH74sx58b0vkVEFpyz3AJV+v+7Ur7Sq4lrirMdCKMTN576ej3DE1XmvRdEkKQQ54y+g
	 pPnRG49xiv2AyEX0r4g3QTiEP4Q2Avp+y8AVfIVVQoke+WGB10BtitZOunkE4DqYcbWMo
	 YbjggroUMrqTmpgiPLOINRget+BVC1KBikTWLJdCQAwP0ZpufcSoWHMjHD/veGmbRCHB7
	 NyZKgVlYyBN3BDSibmXFI6VHp3N2gc2Y//J0Jrq17h530pTgbaxjp7qBit22q5HnfcA==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1794050712;
	h=Received:DKIM-Signature:From:To:Cc:Subject:Date:Message-ID:X-Mailer:
	 MIME-Version:Content-Type:Content-Transfer-Encoding;
	bh=cpzRiL/TPyvkhfML9OpfRWY95rfp3RGPq1O7mg2c+dg=;
	b=VKT1p8Zkd8GTEv2Wwu+MOkNaRvDzI/E7xuv2KDGcINn3c7hxoYuqdlcx/r+b3eVJDvuK
	 3sp1tL3sGE37YkMAKiZDsfqiiGulJRqSR5gVsrTWlNXK7GqG1oBQ59anz3b3HMQ3oen/y
	 z9sJqB+o/o0M7H84HEgmCtrL7CDKhr3Bs1nBnQ/j1xTzFbMHa4qNwwJ+94sGL4sGAfJhF
	 YWQwUaPbkLX3D3mR7+yr4UYYEZmk0ippOCIK18QW92lIFLV04+JBeN90mmBQqgpPI4xWz
	 UuPraZmaKOeNeS4LOyo4asBdROlL7/GNsfl8PMBwvVHPd6OYqOuY75u16Kvm787nO7Q==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dkim=pass header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=IGgbTxq9;
	arc=none smtp.remote-ip=100.103.45.18
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 849F9606A326
	for <stable@vger.kernel.org>; Sat,  7 Nov 2026 11:25:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=IGgbTxq9
Received: by smtp.kernel.org (Postfix) with ESMTPSA id CA02A1F0089F;
	Sat,  7 Nov 2026 11:25:11 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1794050712;
	bh=cpzRiL/TPyvkhfML9OpfRWY95rfp3RGPq1O7mg2c+dg=;
	h=From:To:Cc:Subject:Date;
	b=IGgbTxq9URuVuJEPk+x8A9846mgbLrcNXXv7Le5YDT8iOGnhAOJYwxr1TuJjs/Cwo
	 w4wWZf8l0sOweyir+7JtyU90JpYq9w+d5x0fiJ3U8qpx8W2EKJGzAcHulxnLi9fSn4
	 29oilu+8QzXpB7evmWeX6vn9fB/NeymdlN99nmZlGVY7Y6PLLZkxQisOxdz6uyiJL6
	 vx0SRP3gqFjXgRUaQxEY//bQFubzQb+eCE/X1OI8MgoVQlnd8xvr4Ncj6jNmJoiOn2
	 nYNGQenJX3LHwhvPW1G9LDu5NxuiVwpN5O7gt/QYEk2/NitF7m4U6INqrlhd6gEYYq
	 oFtSc8PjEU9nQ==
From: Sasha Levin <sashal@kernel.org>
To: liuc63@xiaopeng.com,
	liuwb@xiaopeng.com,
	fw@strlen.de,
	pablo@netfilter.org
Cc: stable@vger.kernel.org
Subject: FAILED: patch "[PATCH] netfilter: nf_conntrack_netlink: fix inverted IPv6 tuple filter" failed to apply to 5.10-stable tree
Date: Sat,  7 Nov 2026 06:25:10 -0500
Message-ID: <20261107062510-failed-5.10-cd37ab22a74e@kernel.org>
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

The patch below does not apply to the 5.10-stable tree.
If someone wants it applied there, or to any other stable or longterm
tree, then please email the backport, including the original git commit
id to <stable@vger.kernel.org>.

To reproduce the conflict and resubmit, you may use the following commands:

git fetch https://git.kernel.org/pub/scm/linux/kernel/git/stable/linux.git/ linux-5.10.y
git checkout FETCH_HEAD
git cherry-pick -x cd37ab22a74e05aae5c16c67295cbf5188b16268
# <resolve conflicts, build, test, etc.>
git commit -s
git send-email --to '<stable@vger.kernel.org>' --in-reply-to '20261107062510-failed-5.10-cd37ab22a74e@kernel.org' --subject-prefix 'PATCH 5.10.y' 'HEAD^..'

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




