Received: from mail-vs2-f40.google.com (mail-vs2-f40.google.com [74.125.227.40])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E3EF052E07E
	for <stable@vger.kernel.org>; Wed, 23 Sep 2026 13:50:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=74.125.227.40
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1790171415; cv=none; b=TqmznM3qtKRNz/gyw/B+bOolYFdm352Q+Wt+jfWrOgwpe1bm5PuOmouUAuR0uMsU2D0BzrimcjQM165lEVFTQ/ZaR4zN7pmBZvXn6beJUobKuvBaWJz9O4tfLgRdenKuLI/wBWoP6jCCHcq5OjII4loDRnBWt21HnZzSc44+AXo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1790171415; c=relaxed/simple;
	bh=7Le+bSKS4i++0atX4ob/re5jRUUIa9YEDMNPqlpG9Jk=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=mK/1FoShrucYvVbUecaiRGZwQUwKxARfmscncBDgpt7PJGf+yjBi4j2p07vQabLbeW8qblMaMsdW/1iR6AeR+DbCmdRA1Pp+2iivH+jwUrfU1fZVdq/67vyq5Q7aCy0Ho2Gm26B4LktQ7WH+4FOVr8QmnrM+BpYuVdCzibHBpZM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=nwUuVJfc; arc=none smtp.client-ip=74.125.227.40
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="nwUuVJfc"
Received: by mail-vs2-f40.google.com with SMTP id ada2fe7eead31-7a4fb331cc0so372437137.3
        for <stable@vger.kernel.org>; Wed, 23 Sep 2026 06:50:13 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1790171412; x=1790776212; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to:content-type;
        bh=GIg/ABLVf9+aKRgVLx2ojwBZLXuVOVgsPgIbjXHaOXw=;
        b=nwUuVJfcFlhL2tisYdWPm2B2ybSS3KewGxpETOGXr3m6tE2TMvFDIZtvREjIS3NBYT
         E+K7wlUri4ZNaNWc8M5hxcAceFIqAKCvKXbJVq4kIZGh7ZrVpneBo3yEP1LJB7a/YY/F
         wXebYTL1y83zjW+RKrXzs5B8y/y8TDBxOPoGw4ZsyIfYuxRPaK/LL/0cEFQt7Gt09fKQ
         4bHysMqt0Lb779iO980dNWkYkDdL8U6FYF/67hTaX0Hq0Ojq2wiBizR8AUF8r58vr2QP
         yVq/c5N9bFLn3DvsH0nNP44pQWLDTrdtag+bA09L4x7uXbSuGr5is9Oa01hgZsleAhy8
         eliQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1790171412; x=1790776212;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=GIg/ABLVf9+aKRgVLx2ojwBZLXuVOVgsPgIbjXHaOXw=;
        b=Vv1lnIubxZE7o53DajxGMQuVDvgjlFM6C1lFUgZNlfDnqOve/GHG4AXT95uHO101ji
         oiRi4Ed5rgd0aKurWM3hbRL4aO+t0asop+l1h4U2FYywKokQLgsGrMr/+9fGPfTZ76je
         Pho8fiWbGUUnRIVcUbtYaQRPabBDoVH7Pbdk7RiLshH3hN/qNEAQ944oHy0wVi8nPdr9
         Vd/a28rMF7mcRfZi81c9QWCxEiQZn8/+mGtoyq3Z3POewTZv/50+qG3qV3sQugWv13YG
         CRWdXdC2dPHyLXRkXRhLRUKj/gTDNyZPc/ch7uN/8ynFo8yUveNBdkzt6HlCePrQMKjp
         PoaQ==
X-Forwarded-Encrypted: i=1; AKwUvByo0F+GG+yI/au/K+00kXInQxhl21wYVHunWxS2HCNg8XIIL2Vs3vz6UwnSpyix/wcFrAzHcEw=@vger.kernel.org
X-Gm-Message-State: AFuF++nHfOQ8owliAQ1My29K50hqhlOTgrlsxc6LoCRCdSMbpa1OVwNT
	NNWfHS5zSN433tuniMFzBE+dOvx5kbhp3CnuxMdavEBu7HMAF4C/Q0EU
X-Gm-Gg: AYBFou1bpYAcNVS+WRTIhAw3CZ7cWhgu1uBB3w/b/QteD5EXpIWPlUWVR9WhysJxShe
	BlEC6xJUiwpQD0ucrrE8v0uqbDNy9cqkIvjpY99ESDxCQLQsWBWyROPzR4C3XwMoSyz5ANkm17a
	tKFOZ80PMVMTMWaiKh7y31h6heoLcJpIaZijPVR43ef4sxvsiVMZzJIoLaqusSX3C4PCkImFuhk
	KtfHpyLQJRJ0jGd924vXtYl1CZ9ikgRdxRKfc7H7eLAyeqPn2RBeLdH+/2wRhlRqIafqFOMTMeT
	guzg3fJZG8Eo9III0ylEBHC2iJk7wGu4rGKUnT/HfvXYhTJTxL3Ceys7h+YNBiabebVZ/dKHEAD
	H76ySgvF5kYLZavft4F5F0b1tjcDYgSTcEeeYMbGgqMhjbbRrlJx4lTuUQOFWQUSZ8Pc5P5ddO1
	I1EqYZAWA249POO4PNRhMQQn0Hs6uJbbaZgahsBhbc78hVrkBO4QOTZuY8ROOx8D4=
X-Received: by 2002:a05:6102:291e:b0:7a7:ad9f:53c6 with SMTP id ada2fe7eead31-7ac1bb4a3f7mr2276292137.13.1790171411528;
        Wed, 23 Sep 2026 06:50:11 -0700 (PDT)
Received: from beelink.. ([187.13.30.172])
        by smtp.gmail.com with ESMTPSA id a1e0cc1a2514c-9852407d1f2sm113126241.6.2026.09.23.06.50.07
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 23 Sep 2026 06:50:10 -0700 (PDT)
From: Aldo Ariel Panzardo <qwe.aldo@gmail.com>
To: airlied@redhat.com,
	kraxel@redhat.com
Cc: dri-devel@lists.freedesktop.org,
	linux-kernel@vger.kernel.org,
	stable@vger.kernel.org,
	virtualization@lists.linux.dev,
	spice-devel@lists.freedesktop.org,
	Aldo Ariel Panzardo <qwe.aldo@gmail.com>,
	Sashiko <sashiko-bot@kernel.org>
Subject: [PATCH] drm/qxl: remove double page-size scaling in kmap fallback paths
Date: Wed, 23 Sep 2026 10:49:52 -0300
Message-ID: <20260923134952.1750600-1-qwe.aldo@gmail.com>
X-Mailer: git-send-email 2.43.0
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

qxl_bo_kmap_atomic_page() takes a page_offset parameter that callers
compute as a byte offset aligned to a page boundary:

    reloc_page = qxl_bo_kmap_atomic_page(qdev, info->dst_bo,
                                         info->dst_offset & PAGE_MASK);

The VRAM/PRIV path adds it directly to the mapping base (both in
bytes), which is correct:

    offset = bo->tbo.resource->start << PAGE_SHIFT;
    return io_mapping_map_atomic_wc(map, offset + page_offset);

But the two system-memory fallback paths multiply it by PAGE_SIZE
again:

    rptr = bo->kptr + (page_offset * PAGE_SIZE);

For page_offset = 0x5000 (page 5), this computes
0x5000 * 0x1000 = 0x5000000, a 80 MiB offset instead of 20 KiB,
producing a massive out-of-bounds access into kernel memory.

Remove the spurious multiplication so the fallback paths use the
same byte-offset semantics as the io_mapping path.

Fixes: f64122c1f6ad ("drm: add new QXL driver. (v1.4)")
Cc: stable@vger.kernel.org
Reported-by: Sashiko <sashiko-bot@kernel.org>
Signed-off-by: Aldo Ariel Panzardo <qwe.aldo@gmail.com>
---
 drivers/gpu/drm/qxl/qxl_object.c | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/drivers/gpu/drm/qxl/qxl_object.c b/drivers/gpu/drm/qxl/qxl_object.c
index XXXXXXX..YYYYYYY 100644
--- a/drivers/gpu/drm/qxl/qxl_object.c
+++ b/drivers/gpu/drm/qxl/qxl_object.c
@@ -223,7 +223,7 @@ void *qxl_bo_kmap_atomic_page(struct qxl_device *qdev,
 	return io_mapping_map_atomic_wc(map, offset + page_offset);
 fallback:
 	if (bo->kptr) {
-		rptr = bo->kptr + (page_offset * PAGE_SIZE);
+		rptr = bo->kptr + page_offset;
 		return rptr;
 	}

@@ -232,7 +232,7 @@ void *qxl_bo_kmap_atomic_page(struct qxl_device *qdev,
 		return NULL;
 	rptr = bo_map.vaddr; /* TODO: Use mapping abstraction properly */

-	rptr += page_offset * PAGE_SIZE;
+	rptr += page_offset;
 	return rptr;
 }

--
2.43.0
