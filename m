Received: from mail-pg1-f182.google.com (mail-pg1-f182.google.com [209.85.215.182])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id EE27931E84B
	for <stable@vger.kernel.org>; Wed, 29 Jul 2026 04:57:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.215.182
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1785301078; cv=none; b=PmCKEveLVTqKA6nMga55B+enZ0G3T0O5kZJ2mB8XHDtNPdClCaC4LtC4I8iPQyz/DmH0yd8i9obEbOASL0Ux2GWzzYuH9LrxEVk5Ah0nn6R9ZZIIwzLFZNBUT9ex1AUtvdCNTuK7J5ha/kKLriiZKmmpA17GN1RSNjoivT23Cpo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1785301078; c=relaxed/simple;
	bh=aMSGu6twbkJjRdATYcZyvyhEUDWkIvFu5IhvQvcAceE=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=rXAlCUDbqrddenFvZ5Rh275hQo8+cig8Scodnh1t8j1jZWOLn4upaIpn/hM/EjHkDo9W4X8dEkGk5rBxFw+jC4Cc6SXR93uVqFnIGh32DMqq1A96LwjUQ1IthMVZ+KPC/u9TwTJomIWyazo/xno1bApO/JW5PFTXWzR58nkc0ZM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=chromium.org; spf=pass smtp.mailfrom=chromium.org; dkim=pass (1024-bit key) header.d=chromium.org header.i=@chromium.org header.b=fRq219vM; arc=none smtp.client-ip=209.85.215.182
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=chromium.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=chromium.org
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=chromium.org header.i=@chromium.org header.b="fRq219vM"
Received: by mail-pg1-f182.google.com with SMTP id 41be03b00d2f7-c9aea40d799so267467a12.0
        for <stable@vger.kernel.org>; Tue, 28 Jul 2026 21:57:56 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google; t=1785301076; x=1785905876; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=QwE/Kwnr9BPCU8EkGjoplXuRnm52TdDRkTVQHOPaAmg=;
        b=fRq219vMxb6jkkX/01QWrwRDohY6h2JJDCF6RWJ3UvydjJEpmS5fjZJn1h7FGZtLVl
         FTK+6Ng1Bhk5VoXrF+nAYWEaEF0t3kYZDMBaWPrUzqvd/qWeyEOv2PoH6633HoHfV4Fb
         UxpZIjFvXvpnFQyj6CrT8wqwiUc1x+77JLEuk=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1785301076; x=1785905876;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to:content-type;
        bh=QwE/Kwnr9BPCU8EkGjoplXuRnm52TdDRkTVQHOPaAmg=;
        b=hF2Ih5iZVoGW14nqKN1+Cv3sPAGbeRsrNqNKGahw3xmTZVfKDEdSTxbSaEz1yLrORq
         CMG31tnClMSj1IiELkxPcBqmHtaNwnwK8IaPUVN84S2NRh2CExJB0LEj4NrlUghXa5/v
         wzb+MNImSuOICQXX2+D1uj8ny3Qa3one6oQefsxyU1rqFQNeEzofA8ZI9V6GJWu6aQd7
         MgPOZ6MVmo7MjzATci1pjw5rVehLIrg3fHLVW1w8KjapBm9la+YedSmM4zhHuTf4YSdG
         mdUhQ+Bit4iA7kWNUyQ0+XSmUVSN46wnc8Y4C+jTm18AckAN13tVNasgP6lRJLVfQmi6
         xJSg==
X-Forwarded-Encrypted: i=1; AHgh+RpLiYgtVQ67Aeh/UGyzt2GMLrrPJOrzScHbhnTBrbXNZ5mbPli93k25ty5+MtfPfgSIAf3Y52M=@vger.kernel.org
X-Gm-Message-State: AOJu0YxpH2WgE3pNJRGveR4WHORMZT3onNkxYb3W4Cze2TQxGDaZvJHV
	RaqXDD4NpxhCsMWKFbYig3n0/GUKpBfbaAxLn87wA8JnyGCKLgGKVvMPBNziYMozaQ==
X-Gm-Gg: AR+sD13Vmau28N85ZJWRNqDjYOWw8OOOdSDM+/+oT0bhnk5reJfHa7YRmvvA6w6fftM
	pKD/pnPYbEw1GQG/PbsiJMslCwh6jFaxnYjq4BoKLJd2tAdc4ijWcg8YGc5/VjL67L9oawNrGHM
	2Lcai+148NZNOiLPjPTby5z/O6Jb0/hA/bxf4ojNVWVCSXUkece1BqKe9wgruyxKriBUnipl9eY
	lYeCWJCmRa2l2ndFLA59mIZ2tP9w7V5dE+LKWv5XKMxOWPWPMYasHHI4ednCJRoUKQEVczkAZux
	IMPsg1Ue81LhYVfnPMxvZvquGN30Yw9990FPM9VVNa1cG/MV+PmctaW8KPDcMRbstrKabpC/CPG
	Vb86zxfiHX77oW8yaStB971B4EwnpA19tkm1UWl0w7WwrqyS0Z6pK2/PcGc8NdlW7+vrlV+FCLF
	t6MTKeCgRrE67zRX5QreFu8xjUA87B7pJowuNlAhGDj2L3YRioGMBfBPIo38AZnyJDJY1G0wxXI
	BaHbAK/ocLGF3aDJdeXDM8lPR99eQXMEFw/U2iGCN90jfDJZbVV
X-Received: by 2002:a05:6a21:3204:b0:3c6:5673:2bd1 with SMTP id adf61e73a8af0-3c8ba5da101mr5924466637.42.1785301076232;
        Tue, 28 Jul 2026 21:57:56 -0700 (PDT)
Received: from tigerii.tok.corp.google.com ([2a00:79e0:2031:6:65c1:52a3:f6d3:37dc])
        by smtp.gmail.com with ESMTPSA id 41be03b00d2f7-cbdba63c743sm335183a12.26.2026.07.28.21.57.53
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 28 Jul 2026 21:57:54 -0700 (PDT)
From: Sergey Senozhatsky <senozhatsky@chromium.org>
To: Andrew Morton <akpm@linux-foundation.org>
Cc: Minchan Kim <minchan@kernel.org>,
	Haoqin Huang <haoqinhuang7@gmail.com>,
	linux-kernel@vger.kernel.org,
	linux-mm@kvack.org,
	Sergey Senozhatsky <senozhatsky@chromium.org>,
	stable@vger.kernel.org
Subject: [PATCH v2 1/2] zram: set default primary compressor in zram_destroy_comps()
Date: Wed, 29 Jul 2026 13:57:35 +0900
Message-ID: <20260729045745.775973-2-senozhatsky@chromium.org>
X-Mailer: git-send-email 2.55.0.508.g3f0d502094-goog
In-Reply-To: <20260729045745.775973-1-senozhatsky@chromium.org>
References: <20260729045745.775973-1-senozhatsky@chromium.org>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

zram_destroy_comps() resets all compressors and leaves them
set to NULL, including the primary one, which is invalid
device state, as now comp_algorithm_show()->strcmp() can
be called on a NULL compressor.  Set default primary
compressor in zram_destroy_comps().

Fixes: 486fd58af7ac ("zram: don't free statically defined names")
Link: https://sashiko.dev/#/patchset/20260728092935.31139-1-haoqinhuang7@gmail.com
Cc: stable@vger.kernel.org
Signed-off-by: Sergey Senozhatsky <senozhatsky@chromium.org>
---
 drivers/block/zram/zram_drv.c | 3 +--
 1 file changed, 1 insertion(+), 2 deletions(-)

diff --git a/drivers/block/zram/zram_drv.c b/drivers/block/zram/zram_drv.c
index ace65c586072..ebe2da955182 100644
--- a/drivers/block/zram/zram_drv.c
+++ b/drivers/block/zram/zram_drv.c
@@ -2836,6 +2836,7 @@ static void zram_destroy_comps(struct zram *zram)
 		zram->comp_algs[prio] = NULL;
 
 	zram_comp_params_reset(zram);
+	comp_algorithm_set(zram, ZRAM_PRIMARY_COMP, default_compressor);
 }
 
 static void zram_reset_device(struct zram *zram)
@@ -2853,8 +2854,6 @@ static void zram_reset_device(struct zram *zram)
 	zram_destroy_comps(zram);
 	memset(&zram->stats, 0, sizeof(zram->stats));
 	reset_bdev(zram);
-
-	comp_algorithm_set(zram, ZRAM_PRIMARY_COMP, default_compressor);
 }
 
 static ssize_t disksize_store(struct device *dev, struct device_attribute *attr,
-- 
2.55.0.508.g3f0d502094-goog

