Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6361630DEBE
	for <stable@vger.kernel.org>; Tue, 30 Jun 2026 15:08:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1782832100; cv=none; b=ljbzvKPHX2RZklfgvBRMH3olRNcE7LkTq5unZoPlmLqWd65EH9RZryJtoyNuXDTCEsydjyJswaxnwcorDRM+jb2g5uEbsCQCJa4RXHZh+ncoDEBUJNIlcaMV1pvvt4rUZKwB4KYDe45OhRL/w0O0upThswWVI1kIvFbZ78AVHcI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1782832100; c=relaxed/simple;
	bh=lvgzVHd8xmq+ZFJ3B41MXnvMhzO2v8n51MqmChy4uOo=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=b/nKrGYctLUkkjB9+V5c635pOXsM6MPMUV8J+k9uBn0XEk4DiCjnlD0VwU03fLnZJ1mVwdbu+vKNRM+IqrBPiYCu3jGxdo3DeErZ0OwsPjGrvx5BvE2L8smOrpKAiOMtC9519/ZTiaTpDKx+hYMteFV8/HkjORKVB7X3bi7nzjU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=kDY90qwS; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="kDY90qwS"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 935BE1F00A3A;
	Tue, 30 Jun 2026 15:08:17 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1782832099;
	bh=1q5BW/mbdi3JHVhqZhzf/6C8nWV+HxHxbjoKP/q4ZWg=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References;
	b=kDY90qwSHF0ssSox3pM80yCAKa/JcLC1BlDtVY4Zzc7Wo7AUj3rkd6SOqkTckqR/E
	 Mu9GqALYcrmLo5domxFR5RS+UOnpZPXIFditcwdnlecA8ILv24uOZqNidTKmQKimr5
	 pBs/utD58Sl+R49hU+3n3DaSRoQ9xT2dHtanKqQ0d7MRXH+Bngizl3Bn4vq4Vu1qFI
	 xM0PqEiuhLv86u3Cd4WMgDJmvrj66ut7oW4E2NmKEvkciO508HK7DKpYtdQQppM4cj
	 /YjSUtj5hcgRpTlTcANc0ip7a68HvH1HWso8HI8BByz/5CaM0rf60XnYk4nV0GKMgL
	 Tzs4isog52hng==
From: Sasha Levin <sashal@kernel.org>
To: stable@vger.kernel.org
Cc: Wongi Lee <qw3rtyp0@gmail.com>,
	Jungwoo Lee <jwlee2217@gmail.com>,
	Ido Schimmel <idosch@nvidia.com>,
	Jakub Kicinski <kuba@kernel.org>,
	Sasha Levin <sashal@kernel.org>
Subject: [PATCH 6.1.y] ipv6: account for fraggap on the paged allocation path
Date: Tue, 30 Jun 2026 11:08:14 -0400
Message-ID: <20260630150814.2524002-1-sashal@kernel.org>
X-Mailer: git-send-email 2.53.0
In-Reply-To: <2026063005-reorder-clubhouse-6def@gregkh>
References: <2026063005-reorder-clubhouse-6def@gregkh>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

From: Wongi Lee <qw3rtyp0@gmail.com>

[ Upstream commit 736b380e28d0480c7bc3e022f1950f31fe53a7c5 ]

In __ip6_append_data(), when the paged-allocation branch is taken
(MSG_MORE / NETIF_F_SG / large fraglen), alloclen and pagedlen are
computed as

	alloclen = fragheaderlen + transhdrlen;
	pagedlen = datalen - transhdrlen;

datalen already includes fraggap (datalen = length + fraggap). When
fraggap is non-zero, this is not the first skb and transhdrlen is zero.
The fraggap bytes carried over from the previous skb are copied just past
the fragment headers in the new skb's linear area. The linear area is
therefore undersized by fraggap bytes while pagedlen is overstated by the
same amount, and the copy writes past skb->end into the trailing
skb_shared_info.

An unprivileged user can trigger this via a UDPv6 socket using
MSG_MORE together with MSG_SPLICE_PAGES.

The bad accounting was introduced by commit 773ba4fe9104 ("ipv6:
avoid partial copy for zc"). Before commit ce650a166335 ("udp6: Fix
__ip6_append_data()'s handling of MSG_SPLICE_PAGES"), the negative
copy value caused -EINVAL to be returned. That later commit allowed
MSG_SPLICE_PAGES to proceed in this case, making the corruption
triggerable.

The non-paged branch sets alloclen to fraglen, which already accounts
for fraggap because datalen does. Bring the paged branch in line by
adding fraggap to alloclen and subtracting it from pagedlen.

After this adjustment, copy no longer collapses to -fraggap on the
paged path, so remove the stale comment describing that old arithmetic.
Since a negative copy is no longer expected for a valid MSG_SPLICE_PAGES
case, remove the MSG_SPLICE_PAGES exception from the negative copy check.

Fixes: 773ba4fe9104 ("ipv6: avoid partial copy for zc")
Signed-off-by: Jungwoo Lee <jwlee2217@gmail.com>
Signed-off-by: Wongi Lee <qw3rtyp0@gmail.com>
Reviewed-by: Ido Schimmel <idosch@nvidia.com>
Link: https://patch.msgid.link/ajFTqRljatR17fFy@DESKTOP-19IMU7U.localdomain
Signed-off-by: Jakub Kicinski <kuba@kernel.org>
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 net/ipv6/ip6_output.c | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/net/ipv6/ip6_output.c b/net/ipv6/ip6_output.c
index 1e491fa7793ad8..d8ce708fcb3c45 100644
--- a/net/ipv6/ip6_output.c
+++ b/net/ipv6/ip6_output.c
@@ -1622,8 +1622,8 @@ static int __ip6_append_data(struct sock *sk,
 				  !(rt->dst.dev->features & NETIF_F_SG)))
 				alloclen = fraglen;
 			else {
-				alloclen = fragheaderlen + transhdrlen;
-				pagedlen = datalen - transhdrlen;
+				alloclen = fragheaderlen + transhdrlen + fraggap;
+				pagedlen = datalen - transhdrlen - fraggap;
 			}
 			alloclen += alloc_extra;
 
-- 
2.53.0

