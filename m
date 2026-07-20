Received: from mail-wm1-f53.google.com (mail-wm1-f53.google.com [209.85.128.53])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9CCAA3921FB
	for <stable@vger.kernel.org>; Mon, 20 Jul 2026 19:20:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.53
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1784575250; cv=none; b=MuZYmwP8YkMpRKhESrMYSTkGQsskVgVpz1efU926i5cHnkHm0hHZ5Lt/ag/nCh0u0lQE4cZy9fYBz/vNXieOKgN9GTLVt4rfVkvxWNedtvXmekKdVXcgEN6EmdtcGVyb3uVib414MirVYd56MvHpCGViDDAY9RxcTCSGlHxKRzU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1784575250; c=relaxed/simple;
	bh=J1w26FLrr9rgN5g4mHDYN1XQg8tMpZaHbtu1Q+Vy3YA=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=Q4jcE9VGIttP4zohiRvGnyl7aIba/EkcrGnMUNIEpVhU7G2Mgp81VjIq6s5yKaf0a9EPRCcGbWGbKUF9IBUzFY1Oyg1EVq/3WwM/SqbTdC0Vas6MHKPEl4hGv9Z/06AoAvoCjUt/BInu1opaaFTYvLBihLIYcKyXPQ102eeXBM0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=0sec.ai; spf=pass smtp.mailfrom=0sec.ai; dkim=temperror (0-bit key) header.d=0sec.ai header.i=@0sec.ai header.b=MoPyqmBo; arc=none smtp.client-ip=209.85.128.53
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=0sec.ai
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=0sec.ai
Authentication-Results: smtp.subspace.kernel.org;
	dkim=temperror (0-bit key) header.d=0sec.ai header.i=@0sec.ai header.b="MoPyqmBo"
Received: by mail-wm1-f53.google.com with SMTP id 5b1f17b1804b1-495590dde14so17809735e9.0
        for <stable@vger.kernel.org>; Mon, 20 Jul 2026 12:20:47 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=0sec.ai; s=google; t=1784575246; x=1785180046; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to:content-type;
        bh=Nn308Uc42Dl57RP6Xi6iEgaOKqgEpx9JiKwuLvZ7d4o=;
        b=MoPyqmBoo9obTE9jpij7lW+fFlvB8geKCWBM3GcuB/XlePqVQpq/a+tIlfexrfJrJo
         xRS3IreWOUQxvHD3o+m99Op2biSBu9ZNJF6jQkCodf7yrasX7aFKZmTRidDm426oa3PW
         lR/89lgnmNaJ5ulynbNhNm77CoWotivx9HVRCWaqofgoa2IsIvK8IYE7cbPLb4eEEtUx
         9gqerD42bbnHrw5XJBaEio2YXZYrKsJ1jPo/mPRVgUKDNgk2VqTPgfPE4i2OQcyMj8VK
         Txxl0kMt+b6APzFjvtijXbDEQNT75cZ9gJ1js64u0Qiuwbj1gbRVt5ebtwWgPv50E8mT
         zzAg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1784575246; x=1785180046;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=Nn308Uc42Dl57RP6Xi6iEgaOKqgEpx9JiKwuLvZ7d4o=;
        b=Fryhu1bWw4BgtRR6NDRGDZU0n5hXXkxjqt01gP16kgf9i84akc2RcxMRdER/CwIAzF
         aJZqBiS44JXexR32d8j0CLOuLQuk6w8cwo5gGBhY3Fc+A8aTLAbMSk3YGmNsHNc4Yr2t
         5zm7R54egABMo/1671iLyK/VCm0wVBN6NESfpwvsvqBR50EqOkgdAHpaki91Ny5PfIvf
         gv+K8CjctN5ljC9yzx02fW7NKuNQbQWMBAY5xWZp80IUyMFaRlPlrjOUzy9L4exwmc1T
         pp2qtx1gEZd2dAf7X8ukwb55n2O0sZvYYNSOypO1UqkCd6hgP/Ent+ryVFtfmRVRfVcb
         ggUQ==
X-Forwarded-Encrypted: i=1; AHgh+RqdsHWw9sA+P0tEvOSbNAPp89TVjWGCIA3zWJkdLiWW02ERCdfPPQRE4Gg9UzI+OQ+qS2LeM1o=@vger.kernel.org
X-Gm-Message-State: AOJu0YygEYWR7lr5nr5Y344cBio6RrmeJUpMxHZALluW0lZXb/2HfTsu
	IRvaDhXtU93JXJr9CERZ6A6osi+O04yfTwwTX1TCfOwv29jt62coeRCSr0IUVKpyHHVU
X-Gm-Gg: AfdE7ckSOasrshiYotSpBDfU6petiP6FaD0TV1CLIL3vVuaDCnCw0k0iewix+VY25Os
	JJeTok0TYPytTyGv8Oe91JrA3JSuqTmaGljQgtZdg6vbRktsgOtq6vBWLt/QrDcL+UEf8FjllZ5
	BcHSMfMc1RgqD+q+dVzbGwEX0Fcg5rYgipdF1vn9DOHLraJ8vRdCIUybPhW23M1wS5Y5tKDs5RC
	Fxtf+mfMpOKyKwFTTQwoMtxJb/GQsrFA+TQCl6+hS/TkO9VLBwd9uL1IxBoN8RbT5YbV/TSE+Rm
	lLIzAKDqnoT5MKhHpLhix+8tHal/hZnkSocOe9J1gf9DWLW5WPZMnvltJSNfsYiXs1DQhBu1M6C
	9dkGFudH0EVI/yJiOpkVosuPcHUgwLPPKueaenyqL9e8ogyMqnfqcjnmZRO9/quZYAOvAKE09eK
	PXhKljhKUkeoCG4JrHT7xPoTUoo9Yqdavg6KEkhyNyRSos2ve961XndUiYyCFvFQBTFiELAGj8W
	dIciLiROaFo3eYsWBBiHLuY
X-Received: by 2002:a05:600c:1509:b0:495:3f5e:e7a with SMTP id 5b1f17b1804b1-4954a51dee6mr121496285e9.34.1784575246312;
        Mon, 20 Jul 2026 12:20:46 -0700 (PDT)
Received: from PeakBook-Mini.tail8e484.ts.net ([178.197.218.14])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-495653bffefsm9693325e9.9.2026.07.20.12.20.45
        (version=TLS1_3 cipher=TLS_CHACHA20_POLY1305_SHA256 bits=256/256);
        Mon, 20 Jul 2026 12:20:45 -0700 (PDT)
From: Doruk Tan Ozturk <doruk@0sec.ai>
To: robh@kernel.org,
	tomeu@tomeuvizoso.net
Cc: dri-devel@lists.freedesktop.org,
	ogabbay@kernel.org,
	linux-kernel@vger.kernel.org,
	stable@vger.kernel.org
Subject: [PATCH] accel/ethosu: validate all tiles and the packed-channel peak in the cmdstream verifier
Date: Mon, 20 Jul 2026 21:20:44 +0200
Message-ID: <20260720192044.19557-1-doruk@0sec.ai>
X-Mailer: git-send-email 2.53.0
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

The command-stream verifier records region_size[], the maximum byte
offset the NPU will touch in each buffer object, and the submit path
rejects a job whose region_size exceeds the bound BO
(region_size[i] > gem->size). feat_matrix_length() computed that maximum
by evaluating the touched address at a single presumed-worst corner
(x = width, y = height, c = depth). That is the true maximum only when
the address is monotonic in x/y/c and the feature matrix occupies a
single tile. Neither always holds:

 - Storage modes 0 and 1 split the feature matrix into up to four tiles,
   each with an independent, user-supplied base (base[0..3]) into the
   same region. feat_matrix_length() is evaluated once, so only the tile
   containing the (max x, max y) corner is bounded; a large offset placed
   in any other tile base is never accounted for.

 - In the nhcwb16 packed format the channel term
   (c / 16) * stride_c + (c & 0xf) * element_size is not monotonic in c
   when stride_c is small, so the largest offset can lie at an interior
   channel rather than at c = depth.

An unprivileged process able to open the accelerator node can therefore
craft a cmdstream whose real maximum output offset exceeds the computed
region_size, pass the submit check with an undersized output buffer, and
have the NPU DMA-write past the end of that buffer (up to ~1 MiB out of
bounds in the tiling case).

Evaluate the extent at every corner that can bound the populated tiles
and at the packed-channel peak, take the maximum, and reject the stream
if any reachable tile base is left unset. Well-formed single-tile,
monotonic streams are unchanged: the computed size is identical.

Found by 0sec automated security-research tooling (https://0sec.ai).
Fixes: 5a5e9c0228e6 ("accel: Add Arm Ethos-U NPU driver")
Cc: stable@vger.kernel.org
Assisted-by: 0sec:multi-model
Signed-off-by: Doruk Tan Ozturk <doruk@0sec.ai>
---
 drivers/accel/ethosu/ethosu_gem.c | 73 +++++++++++++++++++++++++++----
 1 file changed, 65 insertions(+), 8 deletions(-)

diff --git a/drivers/accel/ethosu/ethosu_gem.c b/drivers/accel/ethosu/ethosu_gem.c
index 3401883e207f..dfc499d7fb0c 100644
--- a/drivers/accel/ethosu/ethosu_gem.c
+++ b/drivers/accel/ethosu/ethosu_gem.c
@@ -192,17 +192,19 @@ static u64 dma_length(struct ethosu_validated_cmdstream_info *info,
 	return len;
 }
 
-static u64 feat_matrix_length(struct ethosu_validated_cmdstream_info *info,
-			      struct feat_matrix *fm,
-			      u32 x, u32 y, u32 c)
+/*
+ * Compute the byte offset the NPU addresses for one feature-matrix coordinate
+ * (x, y, c). Storage modes 0 and 1 route disjoint (x, y) sub-rectangles to up
+ * to four independent tile bases; the caller must only pass coordinates whose
+ * tiles it means to bound. Returns U64_MAX if the coordinate lands on a tile
+ * whose base was never set by the command stream.
+ */
+static u64 feat_matrix_addr(struct feat_matrix *fm, u32 x, u32 y, u32 c)
 {
 	u32 element_size, storage = fm->precision >> 14;
 	int tile = 0;
 	u64 addr;
 
-	if (fm->region < 0)
-		return U64_MAX;
-
 	switch (storage) {
 	case 0:
 		if (x >= fm->width0 + 1) {
@@ -240,11 +242,66 @@ static u64 feat_matrix_length(struct ethosu_validated_cmdstream_info *info,
 		break;
 	}
 
-	info->region_size[fm->region] = max(info->region_size[fm->region], addr + 1);
-
 	return addr;
 }
 
+/*
+ * Bound the region a feature matrix touches over the coordinate box
+ * [0, x] x [0, y] x [0, c].
+ *
+ * The address is separable and, as the strides are unsigned 40-bit quantities,
+ * non-decreasing in x and y, so their maxima sit at the box edge and, for the
+ * tiled storage modes, just below each split (width0, height[]) where an
+ * independent tile base takes over. Only nhcwb16 packing is non-monotonic in c:
+ * crossing a 16-lane group adds stride_c but resets the in-group term, so the
+ * peak may sit at the top of the last full group instead of at c. Evaluating
+ * every such extremal corner bounds all up-to-four tiles, whereas a single
+ * presumed-max corner undercounts the other tiles and the channel peak.
+ */
+static u64 feat_matrix_length(struct ethosu_validated_cmdstream_info *info,
+			      struct feat_matrix *fm,
+			      u32 x, u32 y, u32 c)
+{
+	u32 storage = fm->precision >> 14;
+	u32 xs[2], ys[3], cs[2];
+	int nx = 0, ny = 0, nc = 0, i, j, k;
+	u64 max_addr = 0;
+
+	if (fm->region < 0)
+		return U64_MAX;
+
+	xs[nx++] = x;
+	if (storage == 0)
+		xs[nx++] = min_t(u32, x, fm->width0);
+
+	ys[ny++] = y;
+	if (storage == 0 || storage == 1) {
+		ys[ny++] = min_t(u32, y, fm->height[0]);
+		ys[ny++] = min_t(u32, y, fm->height[1]);
+	}
+
+	cs[nc++] = c;
+	if (((fm->precision >> 6) & 0x3) == 1 && c >= 16)
+		cs[nc++] = (c & ~0xfu) - 1;
+
+	for (i = 0; i < nx; i++) {
+		for (j = 0; j < ny; j++) {
+			for (k = 0; k < nc; k++) {
+				u64 addr = feat_matrix_addr(fm, xs[i], ys[j], cs[k]);
+
+				if (addr == U64_MAX)
+					return U64_MAX;
+				max_addr = max(max_addr, addr);
+			}
+		}
+	}
+
+	info->region_size[fm->region] =
+		max(info->region_size[fm->region], max_addr + 1);
+
+	return max_addr;
+}
+
 static int calc_sizes(struct drm_device *ddev,
 		      struct ethosu_validated_cmdstream_info *info,
 		      u16 op, struct cmd_state *st,
-- 
2.43.0

