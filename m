Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 80BB63D47D4
	for <stable@vger.kernel.org>; Sat, 18 Jul 2026 16:31:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1784392278; cv=none; b=uZCQItJuI8HGbH+uQdnlbOHNUBUeDTnQ0Xy+ZZiz17nymwrdvOnfQWAUD8pAIyD0IfOJ23Uzkls1TWlnZ0a6l5oSL5UJ0tqKDEZjXdvj99uKzuZqHjD9wx2+jiQM7uli6sKShRRyIySEPO1UPTLgSHKlOFa1n5h5uzeGt8Far7A=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1784392278; c=relaxed/simple;
	bh=20XgUvmyNkMrnfFhf5cC0jI0efs7tY0aKrq5axwpm/g=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=o+FAutNm120SlbqWiVTmyvtJ6k47msZd/z8V3ggUspllbMyL4iWB2xqr0pplR4QF5FAVun4e2wXYV7yrYH+lTg8nl9FiaK2oAbUtxhd86poVooWFQ2zHFIs+/+li3iKWcBtkF6xPqOpeOVDaYtrJDnoigvt6XwXs7SIh6rh3GwE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=gUJsPHbe; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="gUJsPHbe"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 18F001F00A3A;
	Sat, 18 Jul 2026 16:31:15 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1784392276;
	bh=6qxG1fAzLAWv7AhckQ28r+CAfSRWT/fAfGSvlxZtm9M=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References;
	b=gUJsPHbeLm/i3AefoGCGeiw4qO4Z12O/AuHrqQ4AJgkM11el2IVMWr0v4oB120BP1
	 3RZd4bgTOB9oCAI8QqaaCV7E59Hy5UPER5NxJJRJXl3HGgITBKq/M+MncKoHzzz8oV
	 Uy+ZisCb7RiGR+YXPjxALm1oPrFTrU7Vg4NyLNuJSZlGdw8Iw6O3v5Bj/eyTy4KUGO
	 86hP+vlFD0CaoNVsorug+ydiHiFRwDjTn1iHTUK+TIpObhj+M5rBjOz0lJCv2ho6vg
	 ussECkUCSbEcVgr1TUuqWTFnhuAE1hEgZfHHqvT5g57l8Eaw0+RljY7fOgmK3IhJcC
	 lnsbfTynv9/qw==
From: Sasha Levin <sashal@kernel.org>
To: stable@vger.kernel.org
Cc: Zhao Zhang <zzhan461@ucr.edu>,
	stable@kernel.org,
	Yuan Tan <yuantan098@gmail.com>,
	Zhengchuan Liang <zcliangcn@gmail.com>,
	Xin Liu <bird@lzu.edu.cn>,
	Ren Wei <n05ec@lzu.edu.cn>,
	Emil Tsalapatis <emil@etsalapatis.com>,
	=?UTF-8?q?Toke=20H=C3=B8iland-J=C3=B8rgensen?= <toke@redhat.com>,
	Alexei Starovoitov <ast@kernel.org>,
	Sasha Levin <sashal@kernel.org>
Subject: [PATCH 5.15.y 2/2] bpf: Reject fragmented frames in devmap
Date: Sat, 18 Jul 2026 12:31:12 -0400
Message-ID: <20260718163112.3339166-2-sashal@kernel.org>
X-Mailer: git-send-email 2.53.0
In-Reply-To: <20260718163112.3339166-1-sashal@kernel.org>
References: <2026071421-video-bucket-8e49@gregkh>
 <20260718163112.3339166-1-sashal@kernel.org>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit

From: Zhao Zhang <zzhan461@ucr.edu>

[ Upstream commit aa496720618f1a6054f1c870bf10b4f6c99bf656 ]

Devmap broadcast redirects clone the packet for all but the last
destination.

For native XDP, that clone path copies only the linear xdp_frame data,
while fragmented frames keep skb_shared_info in tailroom outside the
linear area. Cloning such a frame leaves XDP_FLAGS_HAS_FRAGS set but
without valid frag metadata, and the later free path can interpret
uninitialized tail data as skb_shared_info, leading to an out-of-bounds
access during frame return.

Reject fragmented native XDP frames in dev_map_enqueue_clone().

Add the same restriction to the generic XDP clone path in
dev_map_redirect_clone(). Generic XDP represents fragmented packets as
nonlinear skbs, and rejecting them here keeps clone-based broadcast
support aligned between native and generic XDP.

Fixes: e624d4ed4aa8 ("xdp: Extend xdp_redirect_map with broadcast support")
Cc: stable@kernel.org
Reported-by: Yuan Tan <yuantan098@gmail.com>
Reported-by: Zhengchuan Liang <zcliangcn@gmail.com>
Reported-by: Xin Liu <bird@lzu.edu.cn>
Assisted-by: Codex:GPT-5.4
Signed-off-by: Zhao Zhang <zzhan461@ucr.edu>
Signed-off-by: Ren Wei <n05ec@lzu.edu.cn>
Reviewed-by: Emil Tsalapatis <emil@etsalapatis.com>
Reviewed-by: Toke Høiland-Jørgensen <toke@redhat.com>
Link: https://lore.kernel.org/r/21c2d153dd25603d359069a02bf06779b51f6423.1780385378.git.zzhan461@ucr.edu
Signed-off-by: Alexei Starovoitov <ast@kernel.org>
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 kernel/bpf/devmap.c | 7 +++++++
 1 file changed, 7 insertions(+)

diff --git a/kernel/bpf/devmap.c b/kernel/bpf/devmap.c
index 6ad4b068abc770..713e2627850a47 100644
--- a/kernel/bpf/devmap.c
+++ b/kernel/bpf/devmap.c
@@ -551,6 +551,10 @@ static int dev_map_enqueue_clone(struct bpf_dtab_netdev *obj,
 {
 	struct xdp_frame *nxdpf;
 
+	/* Frags live outside the linear frame and cannot be cloned safely. */
+	if (unlikely(xdp_frame_has_frags(xdpf)))
+		return -EOPNOTSUPP;
+
 	nxdpf = xdpf_clone(xdpf);
 	if (!nxdpf)
 		return -ENOMEM;
@@ -696,6 +700,9 @@ static int dev_map_redirect_clone(struct bpf_dtab_netdev *dst,
 	struct sk_buff *nskb;
 	int err;
 
+	if (unlikely(skb_is_nonlinear(skb)))
+		return -EOPNOTSUPP;
+
 	nskb = skb_clone(skb, GFP_ATOMIC);
 	if (!nskb)
 		return -ENOMEM;
-- 
2.53.0

