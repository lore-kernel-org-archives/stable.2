Received: from mail-qv2-f43.google.com (mail-qv2-f43.google.com [74.125.230.171])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2B7ED4E01E3
	for <stable@vger.kernel.org>; Thu, 17 Sep 2026 19:25:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=74.125.230.171
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1789673127; cv=none; b=mQArkaiRubOypO1up3oIxQoPPrEbkJyK44rmvZcznPf1/ylHUccXU8bZM2ckrjLuY5EUZbcR9dJCkQR55KGGJyfLTAe0bRbWWbIpzMTqPOPgVfSu3+JArkVH3aPAS1lBxEutrKHf+u4n6D7bnsA1KPzUwKqg81/x1sRb+UMlECY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1789673127; c=relaxed/simple;
	bh=cOo2RXzJ2/nxsXrqUlX1wSI+6jcHi8/GvdFnePFjaeA=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=LGf+T2t9xE5/qu21aeh0AYBv2jBK2Z8aeY+xkj8c9yYjtZwotTa3/rxt76ctmtUwV7BADRiWJagPuDcR3mWlYzR2w/G7RLLZ3F3LrqMOONwnpGskYNH5RToEDOOHQIbik8uKXIgLGkAxQGvb11eFOGIMSXTd4jQoJC4/hu5Lwnc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=tBpZTHyK; arc=none smtp.client-ip=74.125.230.171
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="tBpZTHyK"
Received: by mail-qv2-f43.google.com with SMTP id 6a1803df08f44-912408b2b2dso261886d6.2
        for <stable@vger.kernel.org>; Thu, 17 Sep 2026 12:25:25 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1789673125; x=1790277925; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to:content-type;
        bh=NWTMcQH1C+AONjQx5Jl8m1ayn/JT2ZnanuB0BziOVNY=;
        b=tBpZTHyKm7VcYVIZlwSuMVi5h+irdDC4nQIfeUrYq71fOSJgTbm3363Wjjtb6ycIqZ
         vNKsTOx7sgdluslFHQEYv+dTT5EkRoOAqBiFlS5iwbtZoFydB3adeQRwEKXZ6tQaTHS6
         mdP+91KvsZOL0BKwIYo+YxOc0NAxt/9mIFw/Dru69LMGelAsrA+CIOnF8BCYEmgyEt7M
         SMYePzJqgOJBxxzP8czoxhlY8iM8PcXyh5+hZafvYBo8b+zOPYccQlwmW0KaraA0mhRU
         3UWOBxuUzXlFR+ODQGfyK7anHO4WO8X3Yfl99StkuKm/QMVo3hMvfRzpK0NjL7E8PkNQ
         nkBw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1789673125; x=1790277925;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=NWTMcQH1C+AONjQx5Jl8m1ayn/JT2ZnanuB0BziOVNY=;
        b=1RLOzkV0NM9pLG6KRnG3TCFwhXOJqyCPnPuhtVgJdaRnjW1sOs2vicgypkFwy8PYHX
         2alo/C9VTCHoEJYaePylRXN8xANqJMAGKk5T+oOf0skZ8me1p6QN2v4wPlqSwLN6kfuI
         zZwX1Bxl16HfS7n+pDmwiqeuftwW0EVdrXRd/crKpa6D/N9M00iiSu0Tpy6P5HdW5UUp
         cjN4vZMHnnrChp5q+WZzsDvIO/vIkkln8ijXO7DTgcFy+angK2Akw78A25OLDyP1qSVW
         XC+/fAinlP5ozWDzmr8DFBx+eJNeDDwpDaLVTUAjrZ4TCY6fj5iO9aXp9El3L2H5wJaI
         Z+YA==
X-Forwarded-Encrypted: i=1; AKwUvBy74JtaWGJUlxIhzRfB2ztiYedX6fjCsykrUynItz+g6AY4bnpnW4VEvImd2Ggxya43izTlRso=@vger.kernel.org
X-Gm-Message-State: AFuF++kU0iB4HrETzOLEglWBFqnmKpNjw6T5Fqa3TPPF7CaNBTiOmqrC
	6dVid5tEsG/RbMNiHW1D4CGivz0xe+8oozkBSe12lEjMYxPXGLf+b14=
X-Gm-Gg: AYBFou1O4ehlQlYRqRBFQMA+R9jELsiNEuXxJDUrJS9S3DOAGK4nXlXn3Lg9RjOlmhO
	XK0pYzn22LqGz1/hw2LYmdjQ0FooonZDpFeA0KKb0rPSs2TVlqF3/qG1BqTNmOtkOEaqcIgemck
	Nnlpc8ONAboKur85lF01+gWbKuA6emv2186voxRViZnoVyChSMqCZFxZ3oniXHdv2CQ0IQ8vrVz
	gZXEkf8ZPLiwieg+av4zhiSP+eaT1ydRPVw8YSyCsrZyOErChquasBq7bLGndDrzG+qvh1UX03S
	PbY2Dj4OeC3xoAl+BWAN6Qs3EzYUpwcUGBtjvEwIKvcmQEKEN+t1mGYtfnAJYXGTCGx9IdkX5an
	Fouem0Wbfhzzxf9QbD8hXuUggVOLPIxJUsKGUUBL396Egq6JEPsIFL+izSNv3g4mAD0Oom52n9b
	t0tBrLiQJ3m02ip7OD4HGCS6tWqsnS0+2VahvwNStYHnGC0du4VuU+ZzDRKrryj3HcVttkB7L9c
	1finayg4q8RPKwLyqRMvFFm89ApIOZT2mly93Ybfto7OmBR5U23SX5Fou+foV8X1Q2FO+BzF8YA
	PLqZgjQxUniPbW6jbzY6dQNseCyT4Y6mmd8DFg==
X-Received: by 2002:a05:6214:14a1:b0:910:3453:9011 with SMTP id 6a1803df08f44-91254cb14b3mr2393886d6.35.1789673124900;
        Thu, 17 Sep 2026 12:25:24 -0700 (PDT)
Received: from localhost.localdomain ([104.39.169.225])
        by smtp.gmail.com with ESMTPSA id 6a1803df08f44-91252a794acsm5546826d6.0.2026.09.17.12.25.22
        (version=TLS1_3 cipher=TLS_CHACHA20_POLY1305_SHA256 bits=256/256);
        Thu, 17 Sep 2026 12:25:24 -0700 (PDT)
From: Myeonghun Pak <mhun512@gmail.com>
To: Jeff Hugo <jeff.hugo@oss.qualcomm.com>,
	Oded Gabbay <ogabbay@kernel.org>
Cc: Carl Vanderlip <carl.vanderlip@oss.qualcomm.com>,
	linux-arm-msm@vger.kernel.org,
	dri-devel@lists.freedesktop.org,
	linux-kernel@vger.kernel.org,
	stable@vger.kernel.org,
	Ijae Kim <ae878000@gmail.com>
Subject: [PATCH] accel/qaic: Cancel Sahara read data work on removal
Date: Thu, 17 Sep 2026 15:25:12 -0400
Message-ID: <20260917192512.56205-1-mhun512@gmail.com>
X-Mailer: git-send-email 2.47.1
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Sahara removal cancels fw_work and dump_work, but leaves read_data_work
pending or running. The latter accesses the firmware and the device-managed
context and transfer buffer, which are released during removal.

Cancel read_data_work after fw_work, which can schedule it, and before
releasing the firmware. The MHI core suspends and resets the channels
before invoking the driver's remove callback.

This issue was identified during our ongoing static-analysis research
while reviewing kernel code. The same omission was also reported by the
Sashiko bot while reviewing the Sahara relocation series.

Fixes: 7fb19ea1ec6a ("accel/qaic: Support the new READ_DATA implementation")
Cc: stable@vger.kernel.org
Link: https://lore.kernel.org/all/20260701105055.8D4371F00A3A@smtp.kernel.org/
Assisted-by: LLM
Co-developed-by: Ijae Kim <ae878000@gmail.com>
Signed-off-by: Ijae Kim <ae878000@gmail.com>
Signed-off-by: Myeonghun Pak <mhun512@gmail.com>
---
Validated with static source review, apply checks and strict checkpatch.
No build or runtime testing was performed.

 drivers/accel/qaic/sahara.c | 1 +
 1 file changed, 1 insertion(+)

diff --git a/drivers/accel/qaic/sahara.c b/drivers/accel/qaic/sahara.c
index c7c0b3eb4b65fb7776a6c724cb3105046cf6f7eb..6487961bbf14a1c284caf91f500968b90a064ef4 100644
--- a/drivers/accel/qaic/sahara.c
+++ b/drivers/accel/qaic/sahara.c
@@ -879,6 +879,7 @@ static void sahara_mhi_remove(struct mhi_device *mhi_dev)
 	struct sahara_context *context = dev_get_drvdata(&mhi_dev->dev);
 
 	cancel_work_sync(&context->fw_work);
+	cancel_work_sync(&context->read_data_work);
 	cancel_work_sync(&context->dump_work);
 	vfree(context->mem_dump);
 	sahara_release_image(context);
-- 
2.47.1
