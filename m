Received: from mail-lj1-f178.google.com (mail-lj1-f178.google.com [209.85.208.178])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BD15847A0B2
	for <stable@vger.kernel.org>; Tue, 16 Jun 2026 17:27:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.208.178
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1781630867; cv=none; b=a/+8ZCeS1tEvREYOQbTirYxP31dnDm0zutEiTeyEf8Oz1W66iBsR55qtJqI/pzAYe2m0cd46XegZO6qwSyRfB1BVx2Y/7w+8uIZF42CYRtrQHLk9SpnuBMjZtcGE0Y7E6kKyWUZBiyBT8JHEX97RTU7SmSHreN+OUlNLZrjT4xc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1781630867; c=relaxed/simple;
	bh=O8cbjHqHqtkMgHfh7cfL3XvH7d1YL05sNt3MZ69NqSk=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=AoFWOuCEe2OtDHWj3GJKXhTjfOaataxoRbvA3UPDCs1UBjAo1hczwhPt/FGO88au7iYiTktwCGKLGZvDipMDalN4zMggt/OVb4PZBWX1TY1wCSPkJRGabNmEIJvtl01eBgb471anMReilpjGZhtDIk1laRzhm3Ruys51I5AxJHo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=qF3V3AJP; arc=none smtp.client-ip=209.85.208.178
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="qF3V3AJP"
Received: by mail-lj1-f178.google.com with SMTP id 38308e7fff4ca-3967717c951so59941091fa.1
        for <stable@vger.kernel.org>; Tue, 16 Jun 2026 10:27:42 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1781630861; x=1782235661; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=8ihatTAgtIM75Y72cnH9JImL7Y6UJlEwRW9iaLN7oWc=;
        b=qF3V3AJPMBkAunfzp6smDuq50T8vfHKKgXaMbD+DMCaFiLRiAUbOxUSTvux5azhrVS
         GdrLW6Zn37NC3jvHHlg+/nPtMtiS+Eep73n6zefZHlGUZlla/C8Vn2EoJDhO/BpOgfLx
         DTSacEVcL72kOZ3UxHFbB9+hsZPMYH+wrZmCwVxwkhy0r+0tbUlbCpP099GWTOFit6+/
         XuD43zN6zqsu8WcJJRIUKX82lMJftJAGLgrk23PRGLrKF3i4Mtgqcsr9jzdrBBy/E4Xb
         hTLZ21rhWnB0U3274ZDhzJZaD1SV+/w6lVSztDo4918TMm57pdwQYyfHQYkrlAnKQvzQ
         m7/g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1781630861; x=1782235661;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=8ihatTAgtIM75Y72cnH9JImL7Y6UJlEwRW9iaLN7oWc=;
        b=QmDd8gsYe3mKhcmYN1S8XvoeeV1nY5s6uibtE4XzNtdKmwBa+p5WimEK2UGQpGxbpz
         Rpfe53oZFnqGYXze1yV3M3LaM9ko95y1ueAPg5pasME81XbsgxX/zwKuFPOZTU2TlWHX
         zF7BIr2W6h/4zH+3/lAZYgpTQW2xaqTtL6tkS/2soT2/C+jB56R/Vi2x6eYklP6b6IyK
         VuY01P/feyI7ytEUtlMSmhGa+rBLExDk0oR+XE6t3DNwgw92bgaW8od9Wz6KxWctWCIU
         u6vxI6/GWRhjS02jSHupW9HbX4jGdca+dnbCLRj2JN4zU4BGsTsLfbfZTC6cs1xGr8MF
         3Rdw==
X-Gm-Message-State: AOJu0YxxFqH1jQ32nWx49/W5VX9lSx4Ica4JFPFMAXStp2/TlYB8JQs/
	FVO/EVSqL+BDkjxaq7Az5zx2z6AHDBpaOSJr3ZsDaTpsO5TWxlaWLi+y/RFxTt6c5XEEKw==
X-Gm-Gg: Acq92OEs0f/Io2zz2bEHniQ32tbFrT9VJL+Q7kqeDL7VfUBhK4X+CHEpw+nWuYmhFlY
	+Kz6ANidJovRmE0P474yNm3ZSCpNR2pH/YGQnc+uue7lbMoWmt44U7nMWdj2QJcOCHhtv6KAyKE
	mUd/MJPa88fDU9psTQszs702WZ5p9DEa+XleBY5pT3Qm70byFM93laE3qZQB4US+eVtepbTFVK7
	6tjtx2SBZS2aE5Rmq2SJYw+TNfpi6tfXYI4Rby4A2bbhccU3/12J8rOFfLc/4tUy6sLMMsmCxVO
	RAm6cHneR5qqHYsFLQiLvDv+oUJCySMD1FdnykbW32xlgMOjAE11QZxeXXXJWQIbHQAuqgMNnZp
	MXJFohbyNYAIYJq02//JnWBewWPqNosrInDGjVRhB4lgSspBllpIFPmnyGGmwxcaLv3+zT+GV4/
	N4qxYarCGmWOY+mGNDcND/UrGdEleAoPW6K6OM3KM=
X-Received: by 2002:a2e:9a0f:0:b0:396:7b20:1a77 with SMTP id 38308e7fff4ca-3993575584fmr52468591fa.22.1781630860527;
        Tue, 16 Jun 2026 10:27:40 -0700 (PDT)
Received: from grower.astra-academy.ru ([185.32.135.49])
        by smtp.gmail.com with ESMTPSA id 38308e7fff4ca-3995c05acfcsm7978201fa.13.2026.06.16.10.27.39
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 16 Jun 2026 10:27:40 -0700 (PDT)
From: Alexander Martyniuk <alexevgmart@gmail.com>
To: stable@vger.kernel.org,
	Greg Kroah-Hartman <gregkh@linuxfoundation.org>
Cc: Alexander Martyniuk <alexevgmart@gmail.com>,
	Manivannan Sadhasivam <manivannan.sadhasivam@linaro.org>,
	Hemant Kumar <hemantk@codeaurora.org>,
	Krishna chaitanya chundru <quic_krichai@quicinc.com>,
	Jeffrey Hugo <quic_jhugo@quicinc.com>,
	linux-arm-msm@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	Manivannan Sadhasivam <mani@kernel.org>,
	Jeff Hugo <jeff.hugo@oss.qualcomm.com>,
	Loic Poulain <loic.poulain@oss.qualcomm.com>,
	Youssef Samir <quic_yabdulra@quicinc.com>,
	Vivek Pernamitta <quic_vpernami@quicinc.com>,
	mhi@lists.linux.dev,
	lvc-project@linuxtesting.org
Subject: [PATCH 5.10] bus: mhi: host: Add alignment check for event ring read pointer
Date: Tue, 16 Jun 2026 20:27:42 +0000
Message-ID: <20260616202743.84303-1-alexevgmart@gmail.com>
X-Mailer: git-send-email 2.43.0
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

From: Krishna chaitanya chundru <quic_krichai@quicinc.com>

commit eff9704f5332a13b08fbdbe0f84059c9e7051d5f upstream.

Though we do check the event ring read pointer by "is_valid_ring_ptr"
to make sure it is in the buffer range, but there is another risk the
pointer may be not aligned.  Since we are expecting event ring elements
are 128 bits(struct mhi_ring_element) aligned, an unaligned read pointer
could lead to multiple issues like DoS or ring buffer memory corruption.

So add a alignment check for event ring read pointer.

Fixes: ec32332df764 ("bus: mhi: core: Sanity check values from remote device before use")
cc: stable@vger.kernel.org
Signed-off-by: Krishna chaitanya chundru <quic_krichai@quicinc.com>
Reviewed-by: Jeffrey Hugo <quic_jhugo@quicinc.com>
Reviewed-by: Manivannan Sadhasivam <manivannan.sadhasivam@linaro.org>
Link: https://lore.kernel.org/r/20231031-alignment_check-v2-1-1441db7c5efd@quicinc.com
Signed-off-by: Manivannan Sadhasivam <manivannan.sadhasivam@linaro.org>
Signed-off-by: Alexander Martyniuk <alexevgmart@gmail.com>
---
Backport fix for CVE-2023-52494
 drivers/bus/mhi/host/main.c | 3 ++-
 1 file changed, 2 insertions(+), 1 deletion(-)

diff --git a/drivers/bus/mhi/host/main.c b/drivers/bus/mhi/host/main.c
index 49c0f5ad0b73..57c8d15b687c 100644
--- a/drivers/bus/mhi/host/main.c
+++ b/drivers/bus/mhi/host/main.c
@@ -222,7 +222,8 @@ static void mhi_del_ring_element(struct mhi_controller *mhi_cntrl,
 
 static bool is_valid_ring_ptr(struct mhi_ring *ring, dma_addr_t addr)
 {
-	return addr >= ring->iommu_base && addr < ring->iommu_base + ring->len;
+	return addr >= ring->iommu_base && addr < ring->iommu_base + ring->len &&
+			!(addr & (sizeof(struct mhi_tre) - 1));
 }
 
 int mhi_destroy_device(struct device *dev, void *data)
-- 
2.47.3
