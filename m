Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=100.103.45.18
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1794045912;
	b=ImA0aE1r0sLqbE91l3a1XINw0wmIIKTF67e3D3+ZflqZ6FmkoRysrcQyI2P7mQNM4HH9
	 ZIZ32R1Q6lxNW6j4GxooL5ILpD8z7j/pSxFs95HzTyiFZaILnSehs5BUuLyG84udsFUM/
	 fGzfwh7+OZyZ2VSJ5XqCCf9zDO3AhmZuMjqIraEBJQjIx1kp54wO6YOpZd3/TlOzcN3Uk
	 nVZMbQoTkOzpw1jnpPWaO6KALlYvg6Uw5Ws4QEOGosvg1aV8O/QsVh5luvoMscXMgVrm3
	 CKeuSgt8y41udw08QF9ZYJsQWpohaI2Uj+rxWx1j0qGQE3XqT8LivemgI5B4NZF7DmQ==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1794045912;
	h=Received:DKIM-Signature:From:To:Cc:Subject:Date:Message-ID:X-Mailer:
	 MIME-Version:Content-Type:Content-Transfer-Encoding;
	bh=cTY8rPmRBPU8CX8BzTG+kXUzmM9qBp8BSl23xwSsjC0=;
	b=F3m+oT/YWs+CKsTViIg2bobS/CZM99DRPj1vxHI7MhOJ2nTjfz8M4KkCAB/6QC7EF++b
	 4uCuPPdnBNEITzJCcGbz+Kj7U+I3+7qjPPRKM/xH9ae+fEn51P/Hx6fK4ZwUUCtYw8+ak
	 0oDp9+y4Mq1Jj+Emcd/2le9GgszmwPz5JRTUyZqA+T0w+xuhL+s/iSiB02y4UN14u5Lix
	 ZmGg48qOecmFqI+xjSgrCQnmpt4fsw/wj4cLrLg+KB1FKws7HR4l9AI3PHsxD4zIdltyJ
	 iAl9+BgOkB29NBg1XfKG8eCvzap4+C6dj6awEKLyB3GwqnFi7zjhyzj8FIOHakL2bww==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dkim=pass header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=egJnWgvZ;
	arc=none smtp.remote-ip=100.103.45.18
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C6E64606A32D
	for <stable@vger.kernel.org>; Sat,  7 Nov 2026 10:05:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=egJnWgvZ
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 154DD1F008A1;
	Sat,  7 Nov 2026 10:05:10 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1794045911;
	bh=cTY8rPmRBPU8CX8BzTG+kXUzmM9qBp8BSl23xwSsjC0=;
	h=From:To:Cc:Subject:Date;
	b=egJnWgvZRtEiAa0tdwcVWmwhaS0Dz2U0lxeDP6FUTXeHpF1Ig6kuvbl0qheSCAnQY
	 kfc/509ukN2i8Euf2VhrgX1MKeB/qhA6JZIM0L0BU1Un4REJLJBTcvLYrNBtvuWYqT
	 lxMDX2D63gevHnnh6C/1NO2inSq/E2AYLwbByvELuw2VXHMBEP78KX7HB7Nw/EeHyE
	 mgVakFrjgy/HLtTWc5R3yKGmenK139RrMOIGhgoavbzjMOT2NewuEKcVBP+ge45kvO
	 6Gj/S9CRFqGhmjzMnTt8da7ZzSCoSbca8pGTMtM/qO0FQUMU714M66jBazRCr21fYX
	 dpdfoGmALx7Tg==
From: Sasha Levin <sashal@kernel.org>
To: liuc63@xiaopeng.com,
	liuwb@xiaopeng.com,
	fw@strlen.de,
	pablo@netfilter.org
Cc: stable@vger.kernel.org
Subject: FAILED: patch "[PATCH] netfilter: nf_conntrack_netlink: fix inverted IPv6 tuple filter" failed to apply to 7.3-stable tree
Date: Sat,  7 Nov 2026 05:05:09 -0500
Message-ID: <20261107050509-failed-7.3-cd37ab22a74e@kernel.org>
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

The patch below does not apply to the 7.3-stable tree.
If someone wants it applied there, or to any other stable or longterm
tree, then please email the backport, including the original git commit
id to <stable@vger.kernel.org>.

To reproduce the conflict and resubmit, you may use the following commands:

git fetch https://git.kernel.org/pub/scm/linux/kernel/git/stable/linux.git/ linux-7.3.y
git checkout FETCH_HEAD
git cherry-pick -x cd37ab22a74e05aae5c16c67295cbf5188b16268
# <resolve conflicts, build, test, etc.>
git commit -s
git send-email --to '<stable@vger.kernel.org>' --in-reply-to '20261107050509-failed-7.3-cd37ab22a74e@kernel.org' --subject-prefix 'PATCH 7.3.y' 'HEAD^..'

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




