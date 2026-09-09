Received: from mail-wm1-f50.google.com (mail-wm1-f50.google.com [209.85.128.50])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5CFA7179A3
	for <stable@vger.kernel.org>; Wed,  9 Sep 2026 02:09:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.50
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1788919756; cv=none; b=ds6y599A4M32lydIH21prPXFxK/Q8jCc1lQ0jzcrS22VAjlPkrgx1ACqr9wBJIy6WWXStqRYZbgXPyyDBJj8K45AyOpNDeQwex+jAd4147aThEUcsZdWPvmckIeinE2M9fjPN6sd6j8GOZuORXh4j5I1FL71rKYbUNwYFaz9Ouw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1788919756; c=relaxed/simple;
	bh=wY2UUoE1T7xq3crC/CYY8twJ3TUNCwk5ZX5M0xIRVKk=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=H8AqvSQIQQoNO3E7lyChaAGN3iDhsqI+PufHSqIGpKWWbHNHJRZhmUl6wzDcKkNuW6z83DR3R++oQiI/Xafk1Kbj0y7o+oHpHf86xRK2jjJfrMGxjtKmmFeXv8n+2qtoS90CfFGisLAc8wXFYd02KtKsMc0WtiE8uccmWETkNOE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=fireburn.co.uk; spf=none smtp.mailfrom=fireburn.co.uk; dkim=pass (2048-bit key) header.d=fireburn-co-uk.20251104.gappssmtp.com header.i=@fireburn-co-uk.20251104.gappssmtp.com header.b=PcUmy8rp; arc=none smtp.client-ip=209.85.128.50
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=fireburn.co.uk
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=fireburn.co.uk
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=fireburn-co-uk.20251104.gappssmtp.com header.i=@fireburn-co-uk.20251104.gappssmtp.com header.b="PcUmy8rp"
Received: by mail-wm1-f50.google.com with SMTP id 5b1f17b1804b1-49b392ccaacso77762335e9.2
        for <stable@vger.kernel.org>; Tue, 08 Sep 2026 19:09:14 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=fireburn-co-uk.20251104.gappssmtp.com; s=20251104; t=1788919752; x=1789524552; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to:content-type;
        bh=Q9Xayl9dx51mDNzYzQJokyIz5EKoLm+Ut42MJBF6ftI=;
        b=PcUmy8rp0XeC7+GiYWyCqg9SGJxH/jOetGVVuHskgAr6A+UXg2x/8CLBNb8C/zdEeK
         yRZmRt86/20vOcJC+3ZO7AoC4hCe9V6/Km1M76l85/OsnZUEFHFBeu0KCOkSGPgFYC1E
         XElYTh9USGLGT0xtxVL+lEM4axswVSLBtmkm9qCBO5VQaIghRhErEO8kse5nbAmcxoBQ
         98tv5H7g7wQ6pqp/8BgxNrkpm+ymdHJfRnZ2xU2dZjZ83ln0HhcGBEoO9GwUUG6qylsh
         KEvVIpQpHqqLJ+q0VOGYDzUAXb2G/rqBRlm56KlsWaHOvwTadpXGy8jQ0BnRN1zQg5Qb
         2/Pg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1788919752; x=1789524552;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=Q9Xayl9dx51mDNzYzQJokyIz5EKoLm+Ut42MJBF6ftI=;
        b=WoDZmOC43xuwffFrI9k5rbTbsEgomxcTx/ABQPOg4smjnxHcuhdTTh09ntemlGRjgG
         rYrJK7hiDSAyMpWNGvfdLz6EAiHjTEYRIHfVV82vIyYcRcTQ2GruASAGTpnipGfoQMMf
         NWYf4O1Q8qRtAiiNiz4JDJ+0zN8nd/qGZ8EFyr/yexjDNiGy7T8Kw5NI/dyCvMTNTaN6
         lGUYGd6nA3ehSDc6L0x+1WkP5smVCFWspisRpYOLKdLUvadVIhIiQHqAxZPe5XbxCrD7
         ZzK+PmTzcX6DceCjg1HL34kiwgBXxJIZEL+g0VTye8BJWnK/nuGfFZu6r4PX25jTeyMC
         w3Iw==
X-Forwarded-Encrypted: i=1; AKwUvBwxvVVuvxQwjeh6auFAuTI4jRd6sZI+O9ztCBVijPQPD2veQuuDhz3+3e9OcvKb3E8JUfyX/5Q=@vger.kernel.org
X-Gm-Message-State: AFuF++mNDkYp0+e283sdH3miQCjwhdf7iMe82BOV5aytN6H+pxQHzw9x
	LAs91p7nKHW7QfNGKL+OTH+/HTNzhmCNTYQZ+Zzk8xtDGCOhb7W8N9e+vtIxCDNuzg==
X-Gm-Gg: AYBFou1Z18Qq4ZEBOrTy98Ou+rXBxWpOW+c1r2Mqnlp8Unka2NHziSciUYkSv0M+0aD
	AllT1tn8NAcnjqrgLH9IZ7z/PWu3LTOhmGbTA7icq6CPSxDA1TVL6zq500SsvWN0s5XUMMEjFFl
	XL9eejgY7CdN275QvQh3d94S0BSRsU0c6UWsvJQWb+vn+iYd/reQI97Le+3YD5sjAz3aaaEvuMZ
	l0bnhokML+iC9cFPFMJp21raYkAKaC/jeGCb8shecX+By0uqGjHVMxEzMNU46v1r0cbm7oQoM2+
	th2q9NJt4N+kEquB+E4tb7STNu2xcDaduWtGk4KvQTsKADlKsoOZUa6R7xRUOHe4LWDix8ss19Y
	1troB5t3SZftblD7VOgXqcSEXSx1OWpAC1hjK04xDmlNRKoZKO2i9DXz4abmHJEwD1Jhbklp7iZ
	jDtzQ3u+9FhrM0kTRAG2ThB9uvC9woSIjug0XZh0rObBK5PT+bmD4NyzKnqQovv7jYxfR3n0+6Q
	v0hD4Bgzy6/8cBK7npiYrRYARc=
X-Received: by 2002:a05:600c:a01:b0:499:7219:122f with SMTP id 5b1f17b1804b1-49cf8222d53mr323280465e9.4.1788919751903;
        Tue, 08 Sep 2026 19:09:11 -0700 (PDT)
Received: from quark ([2a01:4b00:d309:1c00:7807:3ba6:3446:4db2])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-49d1fd5959fsm13203405e9.1.2026.09.08.19.09.10
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 08 Sep 2026 19:09:10 -0700 (PDT)
From: Mike Lothian <mike@fireburn.co.uk>
To: amd-gfx@lists.freedesktop.org
Cc: alexander.deucher@amd.com,
	christian.koenig@amd.com,
	kevinyang.wang@amd.com,
	dri-devel@lists.freedesktop.org,
	stable@vger.kernel.org,
	Mike Lothian <mike@fireburn.co.uk>
Subject: [PATCH] drm/amdgpu: don't migrate a dma-buf into VRAM while runtime suspended
Date: Wed,  9 Sep 2026 03:08:54 +0100
Message-ID: <20260909020854.58462-1-mike@fireburn.co.uk>
X-Mailer: git-send-email 2.55.0
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

amdgpu_dma_buf_map() adds VRAM to the allowed domains for a peer2peer
attachment, so ttm_bo_validate() can migrate the buffer from GTT into
VRAM.  While the exporting device is runtime suspended its SDMA rings
are down and the move fails:

  amdgpu: Move buffer fallback to memcpy unavailable

An importer on a second GPU reaches this holding no runtime PM
reference on the exporter, e.g. a compositor on the APU submitting a
frame that references a buffer exported by an idle dGPU:

  amdgpu_cs_ioctl -> amdgpu_cs_parser_bos -> amdgpu_cs_bo_validate
    -> ttm_bo_validate -> amdgpu_bo_move -> dma_buf_map_attachment
      -> amdgpu_dma_buf_map -> ttm_bo_validate -> amdgpu_bo_move

Taking a reference here would deadlock: the reservation is held across
these callbacks and is also taken during resume, which is why
commit 030631e97b20 ("drm/amdgpu: revert "take runtime pm reference
when we attach a buffer" v2") removed it.  GTT stays accessible while
the GPU is powered down, so leaving the buffer there is safe.

Only request VRAM when the device can perform the move.

Fixes: 030631e97b20 ("drm/amdgpu: revert "take runtime pm reference when we attach a buffer" v2")
Cc: stable@vger.kernel.org
Signed-off-by: Mike Lothian <mike@fireburn.co.uk>
Assisted-by: Claude:Opus-5 [Claude Code]
---

Is this the failure that commit c52feb436539 ("drm/amdgpu: Disable
runtime PM for externally attached dGPUs") was working around?  That
commit explains how to detect external attachment but not what breaks,
so I can't tell which.

If it is the same thing, could the pci_is_thunderbolt_attached() ||
dev_is_removable() check there be narrowed or dropped on top of this,
so eGPU users keep runtime PM?

I can't test that here: this box hits the bug by missing that check.
The dGPU is on an oculink port off a native AMD root port, so
pci_is_thunderbolt_attached() is false, dev_is_removable() is empty,
and runtime PM stays enabled.

Reproduced on a HawkPoint APU [1002:1900] driving the display with a
Navi 48 [Radeon AI PRO R9700] [1002:7551] on oculink for render
offload.  Without the patch kwin_wayland hits the call chain above
within a minute of the dGPU autosuspending and the desktop stops
repainting until it resumes.  With the patch the map stays in GTT
(ttm_bo_validate() returns 0, mem_type TTM_PL_TT) and the dGPU keeps
autosuspending.

 drivers/gpu/drm/amd/amdgpu/amdgpu_dma_buf.c | 3 ++-
 1 file changed, 2 insertions(+), 1 deletion(-)

diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_dma_buf.c b/drivers/gpu/drm/amd/amdgpu/amdgpu_dma_buf.c
index b33c300e26e2..d1dae5f3fee5 100644
--- a/drivers/gpu/drm/amd/amdgpu/amdgpu_dma_buf.c
+++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_dma_buf.c
@@ -191,7 +191,8 @@ static struct sg_table *amdgpu_dma_buf_map(struct dma_buf_attachment *attach,
 		unsigned int domains = AMDGPU_GEM_DOMAIN_GTT;
 
 		if (bo->preferred_domains & AMDGPU_GEM_DOMAIN_VRAM &&
-		    attach->peer2peer) {
+		    attach->peer2peer &&
+		    adev->mman.buffer_funcs_enabled) {
 			bo->flags |= AMDGPU_GEM_CREATE_CPU_ACCESS_REQUIRED;
 			domains |= AMDGPU_GEM_DOMAIN_VRAM;
 		}
-- 
2.55.0

