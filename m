Received: from mail-pz2-f38.google.com (mail-pz2-f38.google.com [74.125.228.38])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id EB2043F44C9
	for <stable@vger.kernel.org>; Wed, 30 Sep 2026 06:59:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=74.125.228.38
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1790751569; cv=none; b=LkeD+SYAx8MPuJSro2h7eeRuPxmyAPd7eaoPvG3gxIjfES6odKWKwZdUFMSF/d2RKGGkmG59E8awtaZwxlwSr8BXeo03s+5mYVshSMKgOT5JDXCc1mKU3qheTR7ZSmClSm7onfshRBQCdCQRun2vpuDJ1B/2eboknolJLcsR3JQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1790751569; c=relaxed/simple;
	bh=rC1ugp4pLgWT56yd5RPOOwAWDNvddmaY6HAuuf0J2hs=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=Anw30+bT8ncDEVBxzgEFa4usg+1dbtnRIzfKqbxdlbcDeDX3De5yV1xEHX6K99HU8tO2B5+aAV+morFt4H3QVhMpYoCaWXkM2r2o1VhMIN2vqB5M0+nhKpPhPGohty1Jfq7JHuq7A3pjwBsR1AMsTPq8RxRdSd/IisBz/3xU3tI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=DbIihsKG; arc=none smtp.client-ip=74.125.228.38
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="DbIihsKG"
Received: by mail-pz2-f38.google.com with SMTP id 41be03b00d2f7-cc79a5bdf9fso829223a12.1
        for <stable@vger.kernel.org>; Tue, 29 Sep 2026 23:59:19 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1790751558; x=1791356358; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=MxNiWg+dHE1TqlcRBrYL3310bHI3Y0J25afbuRgW4f0=;
        b=DbIihsKGDEBOcpW/moYnAyoTISAh4D0eHup/yugzqrKTXLIrFjJ/nuGot4koW2biME
         6Hva7V605hI7aqOHj9ExIrpHleD05lFq+TcJsM7uyWu9YcrchpFgZwnWp/av+/fkcqKV
         QrXV7qmUlHZiqGSegcJxOG73N8vMr9Urlxw6pkAC18RMQK2TmhNEsZyFG+57Y/NZd70r
         QgTmP02cSegMUDtt1yDiMfN0F6GtL9YERhhyq81ZdnrfR7hg5VxNeRvNZeI8SHspF953
         gAxmZ7xOYsHey84yUrgdwlCHpu6s1yrbw3oJio+IBlWQ9bvi32NsKtbVUST603zHyNxe
         AZsA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1790751558; x=1791356358;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to:content-type;
        bh=MxNiWg+dHE1TqlcRBrYL3310bHI3Y0J25afbuRgW4f0=;
        b=ZsMqMhE3GPOevQ9HjI2cVqPBTBhYV3Z9ZFfTVdOsGNDUvbVFuA4Sl47C57DSGXLXKq
         MDM48tM69dhBZmkZ1QCgspXfGe75Fbd3VdXuLSPZDwEjHFun6rziBze0jYMJHC5QYWxJ
         4/eIFgqC2MHHok5wEUnLb2D79bWKQbVyKC9VhfH02v0IFP3tFJsxYN6n0ePBwtEiv3jA
         W+O/C0uMSp/y96baqnY9lxGsPQMFV5Ao+2JHqZfXNFCJ2Wb4Cy4nYKN9ZQSCW/9qkNV5
         btoS2vOUU4y92/KrSiRAG5w48U2Ibo2KXAiHTSD+Oilo3EKvUIMipXrhugNKhzqUINoU
         SyQA==
X-Forwarded-Encrypted: i=1; AKwUvBy7KiKrRwJ01FDKD5Qbq/4sEyrvE4Y1GGS0ufNMAJ07X165bMbSo7B0qHMp/q+LfxGAEFc8sJw=@vger.kernel.org
X-Gm-Message-State: AFq9FYKjB5oxOFCYdH0KPf6ctqLqMMV2utICFbxrUiLvcKU5erMBaJjw
	UA2R0q6Ce1QdQhf8h2dZi/u3qqGKojoucSJhSYnnCYZz/pAEN1VbGDxCp1H260QM
X-Gm-Gg: AYBFou1AbkvfVEfgLIcUlAv2b4eFn6PHKK7ZIIJdW0YhRGAFb9JmJqWpN/MJCOVzB+g
	pDWMCM9axRyAtO5lrclLZgKuhtPYOTicas3a8rYwRLwM+YNU0EPirLIxULVNRhRprcdI3FZ/QqD
	lOM9XBrK2geCBCL3DTMp8idJDEI+XB6m+cYpUsNAF32rCdGYC1z1O3i61iCEghshDm0zhadLlAN
	agtO7nQDzL6bQAVocxg9437Ofq5Hu8f2QrnyOz/gOLEmauCCvi3egcofT1XiBX5h+JMKHMaeRQJ
	2jnIZkdmlJKwlUYalNkzbGAe4pj92+3DUsQWVr+Mg0L314lAfHjB2jDDxYuOVDfDf01FVkvBu6X
	xP7Eo5LBfmhWmj6qMhNwMKBPRl01JvVsgQEwlYDCnfKQveQRfW0I/eqEzol0xnoZQGom3hMRlcu
	LnH9QQiUDriA6fRLaVtD8kh3VbE4MOXFOzBzlPIR0+Nib5v74gJD4Jw+aMEeWA9cSoqf9MrJmGk
	ei31224lE5334Dsh8+0QxqA71/upX/xsCFfRlS/UaqnT/3LuWnbobwdjGK9RMByhJfgKGcsXyAM
	Ui69FgEWoQ==
X-Received: by 2002:a17:90b:1811:b0:3a2:bb9f:f87d with SMTP id 98e67ed59e1d1-3a4d2803bdcmr293672a91.21.1790751558335;
        Tue, 29 Sep 2026 23:59:18 -0700 (PDT)
Received: from phui-2.c.googlers.com.com (25.187.82.34.bc.googleusercontent.com. [34.82.187.25])
        by smtp.gmail.com with ESMTPSA id 98e67ed59e1d1-3a4cae9ffaesm2010442a91.16.2026.09.29.23.59.17
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 29 Sep 2026 23:59:17 -0700 (PDT)
From: Hui Peng <benquike@gmail.com>
To: =?UTF-8?q?Noralf=20Tr=C3=B8nnes?= <noralf@tronnes.org>,
	Maarten Lankhorst <maarten.lankhorst@linux.intel.com>,
	Maxime Ripard <mripard@kernel.org>,
	Thomas Zimmermann <tzimmermann@suse.de>,
	David Airlie <airlied@gmail.com>,
	Simona Vetter <simona@ffwll.ch>
Cc: dri-devel@lists.freedesktop.org,
	linux-kernel@vger.kernel.org,
	stable@vger.kernel.org,
	Hui Peng <benquike@gmail.com>
Subject: [PATCH v2 2/5] drm/gud: Align both x1 and x2 to block_width in gud_flush_damage()
Date: Wed, 30 Sep 2026 06:59:11 +0000
Message-ID: <20260930065914.393939-3-benquike@gmail.com>
X-Mailer: git-send-email 2.56.0.rc1.315.gc6ed9934b7-goog
In-Reply-To: <20260930065914.393939-1-benquike@gmail.com>
References: <20260930065914.393939-1-benquike@gmail.com>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

In gud_flush_damage(), applying ALIGN_DOWN to damage->x1 without adjusting
damage->x2 causes the rectangle width (x2 - x1) to become unaligned when
block_width > 1, breaking rendering on block-compressed display formats.

Align damage->x1 with ALIGN_DOWN and damage->x2 with ALIGN to ensure the
resulting rectangle width remains an exact multiple of block_width.

Tested in QEMU against Linux 7.3.0-rc3 with R1 (monochrome)
block-compressed format damage updates: on the unfixed kernel damage->x1
alignment alone produced unaligned rectangle width (x2 - x1) causing
corrupted block flushes; whereas with this fix applied, both x1 and x2 are
aligned to block_width, maintaining exact block-aligned damage bounds.

Fixes: 40e1a70b4aed ("drm: Add GUD USB Display driver")
Cc: stable@vger.kernel.org
Assisted-by: LLM
Signed-off-by: Hui Peng <benquike@gmail.com>
---
 drivers/gpu/drm/gud/gud_pipe.c | 9 ++++++++-
 1 file changed, 8 insertions(+), 1 deletion(-)

diff --git a/drivers/gpu/drm/gud/gud_pipe.c b/drivers/gpu/drm/gud/gud_pipe.c
index aa7792966287..f8726e3d849f 100644
--- a/drivers/gpu/drm/gud/gud_pipe.c
+++ b/drivers/gpu/drm/gud/gud_pipe.c
@@ -327,7 +327,7 @@ static void gud_flush_damage(struct gud_device *gdrm, struct drm_framebuffer *fb
 {
 	struct drm_format_conv_state fmtcnv_state = DRM_FORMAT_CONV_STATE_INIT;
 	const struct drm_format_info *format;
-	unsigned int i, lines;
+	unsigned int i, lines, block_width;
 	size_t pitch;
 	int ret;

@@ -335,6 +335,13 @@ static void gud_flush_damage(struct gud_device *gdrm, struct drm_framebuffer *fb
 	if (format->format == DRM_FORMAT_XRGB8888 && gdrm->xrgb8888_emulation_format)
 		format = gdrm->xrgb8888_emulation_format;

+	block_width = drm_format_info_block_width(format, 0);
+	if (block_width > 1) {
+		damage->x1 = ALIGN_DOWN(damage->x1, block_width);
+		damage->x2 = ALIGN(damage->x2, block_width);
+	}
+
 	/* Split update if it's too big */
 	pitch = drm_format_info_min_pitch(format, 0, drm_rect_width(damage));
 	lines = drm_rect_height(damage);
