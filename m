Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=74.125.229.132
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1793734902;
	b=TxEkTXwz2Ah6yePTjnU0yELMqwzYBbZDvo3popBBXdFe89Ihaa1Gi4Hj+JkTgqwYRlD4
	 nIZsjWKvWqquUfYTFPk8pkuouAbI1QjIPZK0Hd1qNldGn8u4B7SctF9jOIEwFdI95vO6c
	 RVHUbg7/Q/KNUG9otZX1XZdMn/sWNYJ7CBbJZ0hVyFl9AKo9To7f6NhLXnNwtZN196p5c
	 k+yn0KIPJ7g/dBsPPvwngciKgTsi8z0dMUE/Na11zCExBgmxcy4PQ8Ommmg42jlG3TPNs
	 pf5X54//oQ/FvvaT/GfSfTsB0Lhokt697SuEeBBvLsLN+J3JHV+DYpZZ8bK0AG9zkFQ==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1793734902;
	h=DMARC-Filter:Received:DKIM-Signature:X-Google-DKIM-Signature:
	 X-Forwarded-Encrypted:X-Gm-Message-State:X-Gm-Gg:X-Received:Received:
	 From:To:Cc:Subject:Date:Message-ID:X-Mailer:MIME-Version:
	 Content-Transfer-Encoding;
	bh=xezF0fn8IDQBSoJVFqpD27Lisy+bsjzUf+Sl1jGurIk=;
	b=b7qVTt2U+KqsrDYmRkamhS66OhLyivp/I66mWNBu/Zs8CXzbcquk/wr3sD1TQ3qX+Kt2
	 AkVmubYu9SOj02/h1g9I3jWMBTgXbaRJi4P+nE6B8mF2BhZUodTysh1zJjGtJHDqfyeVd
	 coXofAG8ncgSZxRruLvLtGfb88la9Q7W3bTBpJ8zT4W+UDRfCRCFgiOl0dJL2OsDNG50C
	 yLrzVKPfdTWx64psMHDnT2ZZrxnjjzRr7CbEFrG8DRUChzKLmIK4QT7pfsqLxtT+IGOKV
	 9NaeHzL1G78qSWkiAmzPkRgknc5VwsZoh2Xo17v7eupjt5l/Tzq5bUp/sg+I8nMheKw==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=gmail.com;
	spf=pass smtp.mailfrom=gmail.com;
	dkim=pass header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20260707 header.b=o8nbt7Kg;
	arc=none smtp.remote-ip=74.125.229.132
Received: from mail-dl2-f4.google.com (mail-dl2-f4.google.com [74.125.229.132])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id ED89B606A324
	for <stable@vger.kernel.org>; Tue,  3 Nov 2026 19:41:41 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org ED89B606A324
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20260707 header.b=o8nbt7Kg
Received: by mail-dl2-f4.google.com with SMTP id a92af1059eb24-1b2459d36aaso992c88.1
        for <stable@vger.kernel.org>; Tue, 03 Nov 2026 11:41:41 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20260707; t=1793734901; x=1794339701; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to:content-type;
        bh=xezF0fn8IDQBSoJVFqpD27Lisy+bsjzUf+Sl1jGurIk=;
        b=o8nbt7Kg4VLEAVGwOT3wfSMSaYrtKlxDWnrkTwbt16DwdSREle9viHmSI61W/yEHJ4
         wva+9xyktj9klqdIbCed9fiX6W7X7j/t7YVxMeY6blmFgg0dRRsLH3CXgoLCjViBVCvK
         X83Onfo09mrcdfTkHUvwXHM6eatj+m3dnpxW0im2hhcdKyfMpPrgjUo6M90Rar18p08m
         Le0mXuEgSmxASxlHveGZJPhCbZj9yZiZy0Q4BHJimV0PSg0T9IKX23jNfIcjM6S8iOVt
         fm0MfMcu5JTlvEr2l1dq2um8Msr7j/k0coAHQqT5pZBz0PGK71L6Za9Ewd2oCBlKkTuj
         upOA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1793734901; x=1794339701;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=xezF0fn8IDQBSoJVFqpD27Lisy+bsjzUf+Sl1jGurIk=;
        b=FOMFXnYEx836cI0fiSnPHT4SPq835B79Y03iXPd/QM3Ah1ZJtTHlkHmYMXe4XvUWBV
         s+LDz/gHxfbVZp9IrDb+zSC7Jmty0bQAHc/4P21nI340vGf9PXWsyHpuMg6Co/ZQhksO
         6LuZ67aroECtN7gpa5LVtqY1SiQ/QsnGjNCvmZAmRGr4wgx/s65QE3L6FnmTd8wgk0/2
         f8p6kFmQnNWjDYFaZUh8yX4Tt2qz0G6kjf4taswqXyHGiCZcblklYH5c9Jc4oU0mpWHL
         23JJmnihztIg6CtP+nG+pCh4crNk2hFtAGVwIqsylbhkPnMNTFAmPElu8ox/2/B03ehb
         52Lw==
X-Forwarded-Encrypted: i=1; AKwUvByaCK2Ppe/4pzSyrRU7unHyJdVgZmP/Vxh1/1RhEy1fAM89zcDCFZSToqemygRYZDBdxhjd3VY=@vger.kernel.org
X-Gm-Message-State: APuU4Z+tf6vYpjQKwqJxpfK3r/oafDfT7fRFF9C8rclwHD38kaWAtAnZ
	w0+Lgi4VEi6qApkJeqVgwC3r5DrKLbl3dsAswHIHU5uU9DmqwFjPyOHf
X-Gm-Gg: AYBFou1r1GWL9GUC+C064QT9/yTiIqI9t//4O5p3HqKALiWoNgUlp2k3ZzTPYdscxja
	8wlNOCLUl0Jqqn9C4GRDeF5kr84/CyAM6L6I03TxZowIZ9vvYEXOk7cY8fQk7Zc+W9DyEeBBCDb
	L6mO4EZZFj2rkAPzATsSeimM7i+4A6DcUv5D+MPIJKb/yjf2AJ1Rw68OpXAoVd5CcdHbsniIISv
	PTtNrMwQ9lAGkTMSFHC8gvbtU0Ruqh/7IgI5zVyvWNDeN0xTkvjXGBkMaoMgWrz8MjXcFZsxnM4
	ZNj3gqtKhMZS7hiFciMH8rDQiQHOQwobn1w/2ipTUB6td+G6TBcQE55V8Q4855ZBMnnZF6SR/wo
	hyAeYcWX33afgzFO7zgGQJWM+pD85GP58FpO6INYOwW/CU5wCJgz4oSzM2WU/Bf0hXxShm+aVC1
	+/jrJ3gohh5ds9BnuWpg8Tz6fQcqwvcwZ8X6qS+ZmjzWOqmBPCB0PxAW3cmmgZRFCLkjjz3JM7B
	JVfF010Fh6HqWtuGHwm/cqDTwaanZOR8kKIXlNttQREWE3rqqcFaatVaTYvzo5mV5p2dvrQPxTC
	1VTfxmsNuZWpuponlRDeCfpYO13y0H7Zr2m2G7XeamchQJLxG7X4XxYd
X-Received: by 2002:a05:7022:1402:b0:193:9568:b42a with SMTP id a92af1059eb24-1ac5c45fd35mr19813397c88.8.1793734901021;
        Tue, 03 Nov 2026 11:41:41 -0800 (PST)
Received: from localhost.localdomain ([98.148.34.5])
        by smtp.gmail.com with ESMTPSA id 5a478bee46e88-36ca38a54ccsm304564eec.4.2026.11.03.11.41.40
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 03 Nov 2026 11:41:40 -0800 (PST)
From: Hungyu Lin <dennylin0707@gmail.com>
To: akpm@linux-foundation.org
Cc: willy@infradead.org,
	jack@suse.cz,
	shr@devkernel.io,
	linux-mm@kvack.org,
	linux-fsdevel@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	sashiko-bot@kernel.org,
	stable@vger.kernel.org,
	dennylin0707@gmail.com
Subject: [PATCH] mm/page-writeback: avoid overflow when reporting BDI byte limits
Date: Tue,  3 Nov 2026 19:36:26 +0000
Message-ID: <20261103193627.71959-1-dennylin0707@gmail.com>
X-Mailer: git-send-email 2.43.0
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

bdi_get_bytes() multiplies unsigned long operands before assigning the
result to u64. On 32-bit kernels, the intermediate product wraps and
min_bytes and max_bytes report incorrect limits. For example, with
vm.dirty_bytes set to 104857600 and max_ratio set to 100, max_bytes
reports 268 instead of 104857600.

Convert the page count to bytes in u64 and use mul_u64_u32_div() to avoid
overflow in the subsequent multiplication. This also handles large dirty
limits on systems with larger pages. Combining the two divisions keeps
the existing rounding behavior.

Fixes: 00df7d51263b ("mm: add bdi_get_max_bytes() function")
Cc: stable@vger.kernel.org
Signed-off-by: Hungyu Lin <dennylin0707@gmail.com>
---
 mm/page-writeback.c | 3 ++-
 1 file changed, 2 insertions(+), 1 deletion(-)

diff --git a/mm/page-writeback.c b/mm/page-writeback.c
index 499a35473e4f..ddebec79d8d9 100644
--- a/mm/page-writeback.c
+++ b/mm/page-writeback.c
@@ -665,7 +665,8 @@ static u64 bdi_get_bytes(unsigned int ratio)
 	u64 bytes;
 
 	global_dirty_limits(&background_thresh, &dirty_thresh);
-	bytes = (dirty_thresh * PAGE_SIZE * ratio) / BDI_RATIO_SCALE / 100;
+	bytes = mul_u64_u32_div((u64)dirty_thresh << PAGE_SHIFT, ratio,
+				100 * BDI_RATIO_SCALE);
 
 	return bytes;
 }
-- 
2.43.0

