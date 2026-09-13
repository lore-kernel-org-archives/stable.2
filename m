Received: from mail-ej2-f12.google.com (mail-ej2-f12.google.com [74.125.228.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 97F7C3932DB
	for <stable@vger.kernel.org>; Sun, 13 Sep 2026 22:30:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=74.125.228.140
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1789338631; cv=none; b=sK3EF28dWqc5/fpfQmcNOLROBmwdSGBVZbvkuNGR5HFRj2/RJt4csapwz6GT2OjknzF77xZFXGD5VulDj3FLWXKst79FHctsvVZ2cjxyzXeHW0PrXIErB6lvEcZT+VhTlOzhfZxiPmp435ZlRSxA6AuAYwPH2HaV8hFcAkS9Vfs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1789338631; c=relaxed/simple;
	bh=sXUqDyJxFGmwl9m/al7UHte/Yxo06rGpWhMwgm2Z+Yw=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=FhjSc+jxTKs/FDCy1RzWUafZX5KqvQ8t4wy9bCeZTuvEuC+YDPgDIK4nGDUE2HfDldoeK1bjXNpcH7PhYpR/Ze/j0y2mKmI/cnIeopnV8wuM8c67qyxh307IHofTz0u85Lz/LRqgzUKuTdqXimq5WnocnvYqV7phOYsO7vUycFw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=VrgB86ZF; arc=none smtp.client-ip=74.125.228.140
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="VrgB86ZF"
Received: by mail-ej2-f12.google.com with SMTP id a640c23a62f3a-c294496989aso264085166b.3
        for <stable@vger.kernel.org>; Sun, 13 Sep 2026 15:30:29 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1789338628; x=1789943428; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=nuWBi8AkRdSYh4XWJN0FA1URQDZsOkE/8z/h99tbMSo=;
        b=VrgB86ZFGaC3DCTgJqvCLHQ5YcsJOICvWspAKJWHMaKxGFUIyO8X9tBK6IrADI7pu6
         Gfoi9mhJF2wbgie0KL18WFy5TdsHADf1GAH1oc2pNQ2KGc6pHtNKH1sj+wqC3C1os9zc
         DdjwOYiBHezfRj9ETu4SbXD5YGvfRyd6leZwJUboJ6RdZ3lTiRwVt7BRsSCjXyuIH2Wg
         FMkjW8/dCHpq+1dnmhMHGU97uXG/SJk4dmjQRZ6u9ZN1r9g77Rcthr9dEMF21ShetAil
         0+p3XabPS66IeBh/nRLjXRZJAiWNcoKCZ3KiN25zrPgq25h1zhkzIUTlXArVWFT8lpV5
         FIDg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1789338628; x=1789943428;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to:content-type;
        bh=nuWBi8AkRdSYh4XWJN0FA1URQDZsOkE/8z/h99tbMSo=;
        b=W3T8XYccBc9XPMbpFUYPsn/Et8kQAz47NqkE9EJqX5gAJTC+29rda9s5wXLElJPJVZ
         O62GYcu94JoVBns7QNH/1J6KjGzGK5Rtq1hB8dYMQrgpw1ygUzwq8mG46TcPlV7qMYxn
         7C8oRWhR8MltdActO3wUP1HIjHtdhiLlrfalod3dMUi2Vlv9g8GK7AkKFhuIKT+68Kze
         w8jZE/kOySGcAZKHwIx6pK9O1z2jcn66ND++VUstM1p/HDaD+tDJax4POGiFb7hnI1eY
         QUBxUBtjJsYqzvgb4joVf8Pen0oeJdu7ySR4W0TgtP/84xSUxBEUMVrs4rGbsSw/0OPX
         G6qw==
X-Forwarded-Encrypted: i=1; AKwUvBwYOs+5JuRDAAroW000ZeRapGF8POM+y6a3OLa0q/haavZ1HdqU6c+977P10WEQ9cxdK+4MGrg=@vger.kernel.org
X-Gm-Message-State: AFuF++mBoELVO+DfIe72uPYZHSJJgs4AHM0N5qicT4hUK39uS9c9ibwn
	5pAOOfAywPI5pyhTr0F5iZ8d8EK/8FLpTyeAL/VbZV7oalBOxuQTocVZpwUrIT45pE4=
X-Gm-Gg: AYBFou06YdxpZDl53g2aPmUEP6wmlbASbMClGC7wVWH70CumnYgB0/jG6nhuVmmIV+t
	W3q4ACkoBWAcZfOD7J3w7Bp55IKp4W080Xt1lpEy50C9IE1NeuBmHcqr5Fc1gcFuH90h9WSGisL
	dwH2bMHhggqC00JyK1zylhPVYkmIGbrIYUBRYdJ3wgGCJLyoq5DsojDPbkQdCrvUlqtW2AoUUHg
	d5v5wVpyPFbqU3JyLOHyvvw5O3/oxksiUlhtR64P99jNIwLJm48o7aWmvltBER81CeuccGovrh7
	dTkY9uvyIh31FXBGR3qo7s7mmvZWAPqFVKzuRbC8OcHRJUzJajoxGRSfrlae7aW8Tah8VWOrYkk
	2w5pimTcnyCF9h+VUS/MN1q37jTxwPMBZXWHuEptPp+DgYsgmRs5e9n9aET6z3UTIPMxIrwcIx6
	a9l1slR04/DQUB0M/Qx49xu4FMz06w/3oUTHEQl+USHPQh+VptzFTgU/hDHCoJxQ9T
X-Received: by 2002:a17:907:18c4:b0:c26:1648:a06e with SMTP id a640c23a62f3a-c29b87725e0mr3301666b.41.1789338627747;
        Sun, 13 Sep 2026 15:30:27 -0700 (PDT)
Received: from beelink.. ([186.247.78.13])
        by smtp.gmail.com with ESMTPSA id a640c23a62f3a-c29ad3e033asm48063066b.47.2026.09.13.15.30.25
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 13 Sep 2026 15:30:27 -0700 (PDT)
From: Aldo Ariel Panzardo <qwe.aldo@gmail.com>
To: airlied@redhat.com,
	kraxel@redhat.com
Cc: dri-devel@lists.freedesktop.org,
	stable@vger.kernel.org,
	Aldo Ariel Panzardo <qwe.aldo@gmail.com>
Subject: [PATCH v2 3/4] drm/qxl: reject relocations whose writes cross a page boundary
Date: Sun, 13 Sep 2026 19:29:59 -0300
Message-ID: <20260913223000.695299-4-qwe.aldo@gmail.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20260913223000.695299-1-qwe.aldo@gmail.com>
References: <20260913223000.695299-1-qwe.aldo@gmail.com>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

apply_reloc() and apply_surf_reloc() map a single page via
qxl_bo_kmap_atomic_page() and then write 8 or 4 bytes at the
page-relative offset (dst_offset & ~PAGE_MASK).  When the offset is
near the end of the page the write extends past the mapped region into
adjacent kernel virtual address space.

For example, a BO relocation at page offset 4092 writes bytes 4092-4099,
crossing the 4096-byte page boundary.  The fixmap slot only covers one
page, so bytes 4096-4099 corrupt whatever virtual page follows in the
kernel's fixmap area.

Reject any relocation whose page-relative offset plus write width
exceeds PAGE_SIZE.

Fixes: f64122c1f6ad ("drm: add qxl driver.")
Cc: stable@vger.kernel.org
Signed-off-by: Aldo Ariel Panzardo <qwe.aldo@gmail.com>
---
 drivers/gpu/drm/qxl/qxl_ioctl.c | 6 ++++++
 1 file changed, 6 insertions(+)

diff --git a/drivers/gpu/drm/qxl/qxl_ioctl.c b/drivers/gpu/drm/qxl/qxl_ioctl.c
index e727a35c9..9fba6e26d 100644
--- a/drivers/gpu/drm/qxl/qxl_ioctl.c
+++ b/drivers/gpu/drm/qxl/qxl_ioctl.c
@@ -247,6 +247,12 @@ static int qxl_process_single_command(struct qxl_device *qdev,
 			goto out_free_bos;
 		}
 
+		if ((reloc_info[i].dst_offset & ~PAGE_MASK) + write_size >
+		    PAGE_SIZE) {
+			ret = -EINVAL;
+			goto out_free_bos;
+		}
+
 		/* reserve and validate the reloc dst bo */
 		if (reloc.reloc_type == QXL_RELOC_TYPE_BO || reloc.src_handle) {
 			ret = qxlhw_handle_to_bo(file_priv, reloc.src_handle, release,
-- 
2.43.0

