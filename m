Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=100.103.45.18
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1794047795;
	b=y1BPUoL442kAJ2xkHGPD7e0TJmsy3ukQKwc/cnMNa6J4LWczRSPeNtgkl97HplHE9K1G
	 qCPI/cV3ZrOfEcvTGFrzY3v4GfsOqmNYx+LuVexOYRh3OPAwpXsMO2iWC/fdwJB1EqKSL
	 RQnz2g+Z7kiiza+YJthD1Ng+qb8oBNEtqkL4FQuWm9Hg9O38KusZkyxONwFhD2QOzM9CN
	 kD3cAufR30cbaiAUYOa3dIIQF6ySvtxUNlcaxGVuq1PtER4zTg7GRzLYTjWLiKds+oYuo
	 wGFqJmIRe8q8iO7ESdwUzIzxTQbSkY/ZCBj21jafZR82eR1jPE+RFFEjNds1FOymMig==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1794047795;
	h=Received:DKIM-Signature:From:To:Cc:Subject:Date:Message-ID:X-Mailer:
	 MIME-Version:Content-Type:Content-Transfer-Encoding;
	bh=X+71VzOz9p5mjcyYR4hbLZZB3nv079FLG4vCDGs/f0w=;
	b=PIB4TYfqYu9PadawIz4mJNYED2cVOgooY1zJfbW1hr5xWEHjakOZNtlCXygl1ecgRg3u
	 Tu9R1Sm1nI48KbboBqHECSHc8e2bFmdoat0KTX7ytXdybQYWEP6K6tT11iKCaL8pWXA4m
	 9dd9BquDPdJsUvIwvI0mCOkQ2nnT9oJOXOsMefDR9q5IF4NwS3q/m05GV5pv6klKanelr
	 hlOPomIS7z52nH89K92DsuzgVli1yuHgWHyDtNbWGbKpsjmBSP+GpzG/eV+YkTescTG5J
	 WULspgmfZXAMad7qMT23OK7yJ/KW6Ea2xkcRI3VhnaP+5+Rf85Gji9N+ueMUEwYdKGQ==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dkim=pass header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=U7+wCNt8;
	arc=none smtp.remote-ip=100.103.45.18
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3ECA3606A326
	for <stable@vger.kernel.org>; Sat,  7 Nov 2026 10:36:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=U7+wCNt8
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 819531F0089F;
	Sat,  7 Nov 2026 10:36:34 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1794047795;
	bh=X+71VzOz9p5mjcyYR4hbLZZB3nv079FLG4vCDGs/f0w=;
	h=From:To:Cc:Subject:Date;
	b=U7+wCNt8988difoa2fG1suBxmVItHXbFb1jWdUhASWT7Uo5Us2edAf+dQdDNBA5Or
	 EX4Z6UIhJu3y6NEdKfA1fnFfSMONjPAAOhXWrkSzrw4Zt0WYdSDDSJ1iCOFWzKD4P3
	 uc9Tw93l/rP5xf3OT0ZiEAxPvWljqOsxKumGxH8EoH1Hnq27IQCvv9EmnYGmN+95j2
	 PCPMF7IMB9dgOy+7Ragk93ERPyvK+GhbGHoVBd6z8BV8uqQN2Kzr6sIVnEhWjRn+Sz
	 nYcmGErS8Gl8AGdgukq0R3MMYdpG1Ef+yfWYSkA/rD5rn5SlQY+iv3PyVVTK3vyV/V
	 ArgpoRd7jOc2Q==
From: Sasha Levin <sashal@kernel.org>
To: liuc63@xiaopeng.com,
	liuwb@xiaopeng.com,
	fw@strlen.de,
	pablo@netfilter.org
Cc: stable@vger.kernel.org
Subject: FAILED: patch "[PATCH] netfilter: nf_conntrack_netlink: fix inverted IPv6 tuple filter" failed to apply to 6.6-stable tree
Date: Sat,  7 Nov 2026 05:36:33 -0500
Message-ID: <20261107053633-failed-6.6-cd37ab22a74e@kernel.org>
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

The patch below does not apply to the 6.6-stable tree.
If someone wants it applied there, or to any other stable or longterm
tree, then please email the backport, including the original git commit
id to <stable@vger.kernel.org>.

To reproduce the conflict and resubmit, you may use the following commands:

git fetch https://git.kernel.org/pub/scm/linux/kernel/git/stable/linux.git/ linux-6.6.y
git checkout FETCH_HEAD
git cherry-pick -x cd37ab22a74e05aae5c16c67295cbf5188b16268
# <resolve conflicts, build, test, etc.>
git commit -s
git send-email --to '<stable@vger.kernel.org>' --in-reply-to '20261107053633-failed-6.6-cd37ab22a74e@kernel.org' --subject-prefix 'PATCH 6.6.y' 'HEAD^..'

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




