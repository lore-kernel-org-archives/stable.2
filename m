Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=209.85.167.42
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1793376734;
	b=BAoYf0NmYbfKqyCIqJ8UyZlfynFSRw0pA6cY0+A1Swkv9MQF6aPY0Z3NBTeG9M0U7Lqh
	 ZSODQZYODk0Dkp1wfQtfDCI8jnpFRfuN2xs3ww/1LMO6eciz8rkrSGip8gLES4gD2/fiY
	 dcfRcwQhmt0oP1zNPlWTBtbNuGsmFYxhV/BHl0ciBkn2xFi3LiYEjq5Pcq47kK764Nj0c
	 49VDVtufjp3cGDw13CbneDiUoJyit8mE8IjeiyZlFGXh9cvmsMIoEvH3cJcjKVoUtMeGj
	 e8wApch3SZKk4BuybSD8WQbAsLw3yApJoM8d/T/P1CsHilPffwgrau20BLPATHrQPbQ==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1793376734;
	h=DMARC-Filter:Received:DKIM-Signature:X-Google-DKIM-Signature:
	 X-Forwarded-Encrypted:X-Gm-Message-State:X-Gm-Gg:X-Received:Received:
	 From:To:Cc:Subject:Date:Message-ID:X-Mailer:MIME-Version:
	 Content-Transfer-Encoding;
	bh=eNGYBiGMglhPQnZEli3lO3EUz21PsnQzOy3maSp1K8E=;
	b=pCP52ew799nqx4ALFm/xb7yn8nDFrYQ9NE2MbYdDxhGd2K/wxs60kB56TsXN6KXHU8hs
	 FgWlakV1OusE8sLlrxfEYHmBfV3JRtK2O8FyTkfyM4nnZEPlT6BwmkjwmTf/Jvi093Kio
	 Zd1kwQ4rj9uX0fZsZLER1a/gl07UxIpmis56TmCh4q7WQutwli+rCoOnMDYe9G1C5j+rr
	 Nc4nHWSzWOoYWuuYE6hfJXw9e9peHJWJJidIbynCGnzwKpeywH/pJ0H8xeOsZOGxs9ih8
	 SjLclo4rWrAUWbrL1Oq3ac3uHB8OvI+6NSpS1K+EeAo55oUMFzYs7KW1D6puyLej/ig==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=none header.from=gourry.net;
	spf=pass smtp.mailfrom=gourry.net;
	dkim=pass header.d=gourry.net header.i=@gourry.net header.a=rsa-sha256 header.s=google header.b=R7G91VpJ;
	arc=none smtp.remote-ip=209.85.167.42
Received: from mail-lf1-f42.google.com (mail-lf1-f42.google.com [209.85.167.42])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 168FB606A31E
	for <stable@vger.kernel.org>; Fri, 30 Oct 2026 16:12:13 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 168FB606A31E
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=gourry.net
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gourry.net
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=gourry.net header.i=@gourry.net header.a=rsa-sha256 header.s=google header.b=R7G91VpJ
Received: by mail-lf1-f42.google.com with SMTP id 2adb3069b0e04-5be4b61fd3dso786099e87.3
        for <stable@vger.kernel.org>; Fri, 30 Oct 2026 09:12:13 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gourry.net; s=google; t=1793376732; x=1793981532; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to:content-type;
        bh=eNGYBiGMglhPQnZEli3lO3EUz21PsnQzOy3maSp1K8E=;
        b=R7G91VpJZO/V27isXGK073Q0ni7+dfJaQBx+kloxQrZjC+aUzgZhjMYMzhR/sxIPRo
         Uvcdh3l4vNND25xOjJemajP9PTCJSFruztsGi4DXooDmbZkjHs3f7CgpKYc1sjTPVqiE
         46O2m1UZ2J0QkdGYEX8ZKtU4MErQCPLMgZ82UFd4+mfXTSJx3IJ3CRNbvMzHWKRMveXj
         EVDhfMO8HQuIFGm/QctzsHzBrrQZstbtNB+AdXYguRYD1QYFHVI/md+icYWZvz0e+1Rj
         L/UkH/eplslkniA9KNdcTyyCMoyr6L2E+jwRMCK1hvSUCMwcrCymQssxy3jr7oD4fhDz
         vq3A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1793376732; x=1793981532;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=eNGYBiGMglhPQnZEli3lO3EUz21PsnQzOy3maSp1K8E=;
        b=f+e4F0a31s5AWOOHZLXGEvDynw8O4JmtERgynYMAMJZYR1IGr2dCBwEesuwNXdk0Zy
         bQf3yH1cSmRq5YWAsv/Jpb+66S5sePwnHMIbJgEpCT6j2lxoH9O9xNqvVvOSRxeT58T3
         pSG+jlhzEc5iGt4KPyyMz6WW5zEjiUQSKn0XoOjsnNZUsyQXprx+eqKeHg+jJiP7i1Ec
         UzQxMbUUxUAGwl06E4Vu6cgl9H66WYVHCf0W7rhAzajKnDCy9WCIk+8CdPJk/CKQfWBf
         Ql+8hZIoYwNAMz6C7t+pD/febB6yEl3nh3fYugFPGPiWhrhuDbwmOBwFfARbL0ibYvOn
         +VUQ==
X-Forwarded-Encrypted: i=1; AKwUvBxdOgpwkJLZvbSnp6ucMbWr6G8MtxVEWKFXf9pyxiNjGfxMZX+cNe97FeqPseF8w5Q2Tt2PBPg=@vger.kernel.org
X-Gm-Message-State: AFq9FYI62pQBhRGL1AYsEBQSqUcEHr9ejZnnh0qIjcKqIwYQpGRwmBDH
	9nEeIe+vF0tCF9Qw67MynBCgWRI9hDinUhZ+tB39VgILm7MkfahCIE3cflJb1su4JT0=
X-Gm-Gg: AYBFou2oXk9RSNwGZofRK2XGV3Ep2yLfNk6tATKf2+uvOhVmI8bEBIscfmkZrzSY+47
	nPfvUuQeRe1ZVh4eg5oTgv97u4xni41o5KB8+toTzcGfFzz5w91drKL0d3VgGdZuHBR2GQM9sWl
	933iFKeF7UP49VUo55km8iLuKfzK7/Yl99JTil+57tygDeOQOm+qWMV78XaRsOyrUfvQUfq674Z
	hTCOsixOETQ+ya/f/Z1gbJzQFf7Xg9wF4ii3rDAZoY9+O17mpegSPeKzlCHMUpv5tgEItwY/7eX
	LspfZTxAExcqSb6IhSwXaKNgxUYQ0qzvQgLXlEY+kxi8BNRQyOX9mbE6VRX0dXpuwi2Hr5cUXkj
	NXQBk4KKDOF52TtKFCSW7awB6wCaxlOuU+QS7zJIbONRAKWnR8mi0YXeItkrPKFLFW08pGaZMja
	eVBAeSYj6CRdmnhQlRQVv8s4lxpRwCMqlMmnBQlvmZEKOtlCxNliIGwNwyStqbFOPlTK9dXLJ9H
	Vt8W9FjV9hvIvLk9sJTsZlCbMYWnLV0gurBjWrsXAn0Qq9cPnNxINBNsFuVc/TzDClXysru8h1o
	s+MdJkK2TcAhCojZ1uKiGT8qIIbiy4+cXWEetBDxh6gtGT+JzhxpY9TOt2iTqPaqF87Ce9C48bF
	nSUJLNE4gGwFqRBM=
X-Received: by 2002:a05:6512:1392:b0:5bf:c9c7:eae2 with SMTP id 2adb3069b0e04-5bfd9596876mr1035390e87.66.1793376731947;
        Fri, 30 Oct 2026 09:12:11 -0700 (PDT)
Received: from gourry-fedora-PF4VCD3F.lan (pool-173-79-60-52.washdc.fios.verizon.net. [173.79.60.52])
        by smtp.gmail.com with ESMTPSA id 38308e7fff4ca-3acbbc07f98sm3944031fa.2.2026.10.30.09.12.09
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 30 Oct 2026 09:12:11 -0700 (PDT)
From: "Gregory Price (Meta)" <gourry@gourry.net>
To: linux-mm@kvack.org
Cc: linux-kernel@vger.kernel.org,
	kernel-team@meta.com,
	akpm@linux-foundation.org,
	david@kernel.org,
	gourry@gourry.net,
	ziy@nvidia.com,
	joshua.hahnjy@gmail.com,
	rakie.kim@sk.com,
	ying.huang@linux.alibaba.com,
	harry@kernel.org,
	stable@vger.kernel.org
Subject: [PATCH] mm/mempolicy: use one node set for interleave weights
Date: Fri, 30 Oct 2026 12:10:46 -0400
Message-ID: <20261030161046.1497894-1-gourry@gourry.net>
X-Mailer: git-send-email 2.56.0
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Post: <mailto:stable@vger.kernel.org>
List-Help: <mailto:stable+help@vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
List-Owner: <mailto:stable+owner@vger.kernel.org>
Precedence: list
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

From: Andrew Morton <akpm@linux-foundation.org>

From: Andrew Morton <akpm@linux-foundation.org>

Switching weighted interleave back to automatic mode while memory is
being onlined can cause a kernel divide error on x86, and a panic if
panic_on_oops is set.

reduce_interleave_weights() scans N_MEMORY three times, but hotplug
can cause N_MEMORY to change at runtime - and torn reads on that
nodemask can cause a total sum of zero bandwidth.  A node that
was hot-unplugged and then hotplugged back can then cause this
loop to generate a div/0.

Record the nodes visited while summing their bandwidth, then use
that same set when scaling and reducing the weights.  This gives
us a consistent state even if N_MEMORY changes.

Fixes: e341f9c3c841 ("mm/mempolicy: Weighted Interleave Auto-tuning")
Cc: <stable@vger.kernel.org>
Signed-off-by: Andrew Morton <akpm@linux-foundation.org>
Signed-off-by: Gregory Price (Meta) <gourry@gourry.net>
---
 mm/mempolicy.c | 13 ++++++++++---
 1 file changed, 10 insertions(+), 3 deletions(-)

 [gregory: recieved off-list, separately validated and tested)

diff --git a/mm/mempolicy.c b/mm/mempolicy.c
index 6f92621e9135..26a1a21be65d 100644
--- a/mm/mempolicy.c
+++ b/mm/mempolicy.c
@@ -207,15 +207,22 @@ static u8 get_il_weight(int node)
  */
 static void reduce_interleave_weights(unsigned int *bw, u8 *new_iw)
 {
+	nodemask_t nodes = NODE_MASK_NONE;
 	u64 sum_bw = 0;
 	unsigned int cast_sum_bw, scaling_factor = 1, iw_gcd = 0;
 	int nid;
 
-	for_each_node_state(nid, N_MEMORY)
+	/*
+	 * N_MEMORY can change while wi_state_lock is held. Remember the
+	 * nodes contributing to sum_bw so all passes use the same set.
+	 */
+	for_each_node_state(nid, N_MEMORY) {
+		node_set(nid, nodes);
 		sum_bw += bw[nid];
+	}
 
 	/* Scale bandwidths to whole numbers in the range [1, weightiness] */
-	for_each_node_state(nid, N_MEMORY) {
+	for_each_node_mask(nid, nodes) {
 		/*
 		 * Try not to perform 64-bit division.
 		 * If sum_bw < scaling_factor, then sum_bw < U32_MAX.
@@ -234,7 +241,7 @@ static void reduce_interleave_weights(unsigned int *bw, u8 *new_iw)
 	}
 
 	/* 1:2 is strictly better than 16:32. Reduce by the weights' GCD. */
-	for_each_node_state(nid, N_MEMORY)
+	for_each_node_mask(nid, nodes)
 		new_iw[nid] /= iw_gcd;
 }
 
-- 
2.56.0

