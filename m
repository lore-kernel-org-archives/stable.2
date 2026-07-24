Received: from mail-pj1-f46.google.com (mail-pj1-f46.google.com [209.85.216.46])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D643537F748
	for <stable@vger.kernel.org>; Fri, 24 Jul 2026 05:57:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.216.46
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1784872635; cv=none; b=O+HYM47+Fuq5+aOxxSCd4b9yJS1OlrhIujNfRvVTG70Whj5LZuHjAns+VIky+sOnKA59bufTLpOS5j71s4Jaa9CUZPvZ4CiVkeD/BMMnFGGSeuD1ztHn79uDV7G/wsHFQcO7AVvmvVFiw0uzKBs0epxClFhe+cGCw8sf1K8Ea5o=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1784872635; c=relaxed/simple;
	bh=5VQ5qEgjfV+x1bJA338EF1x7CKCne9vZqWb10Xzk4xM=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=Rk8nbvFRJgTa40KUp493bFCN+gjAno7Bd8xdk1nhH064bTDNwPHcwj+9cAsM20eXrR0F1qigIKSxTkXPYKKwGAtkQPi1D4t7MWwT79B6VU0SXbpQadlptbo5imW064FCmWWiqZdcQsbvaFM6D0Oyeu9AU7DPtw4HKISRlWeFds8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=dl8bZR0c; arc=none smtp.client-ip=209.85.216.46
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="dl8bZR0c"
Received: by mail-pj1-f46.google.com with SMTP id 98e67ed59e1d1-38e07ebd263so25873a91.1
        for <stable@vger.kernel.org>; Thu, 23 Jul 2026 22:57:13 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1784872633; x=1785477433; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=vBIjQNaON2nZxvkXi4BWxprH/Lx5mlLUomPvJOc+EtA=;
        b=dl8bZR0cK1yH1dOGuO9acav92tdPQpP9InnzhwgcT5jRnohCh9l22mdl9ND8SCHQYw
         ttcTOYiOMBMBSbHJVxsJPBfXywUUP/tOAocX6xvIJYFYFT90ImaPW+vqHgBsLUsPksZY
         0Wy36pgHF6wDiESBBFVYoBfZ8701IIZDKUAhaFqvLmk4AGWu1MYjKk0xwx/4XdJcp349
         WLGs7Jh6SQYAdsszA3VmAtmiQgQq8XyhM9C7BbDuR7qOAmQW3idjGbkjQcrrydoZyZvb
         DSDFw9cYQweBWiEEK8C1TafrH2R80ieWJcNKVlFX1dKeJ/DPRyyxyCVrSHkmIMcAq4M7
         GXPA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1784872633; x=1785477433;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to:content-type;
        bh=vBIjQNaON2nZxvkXi4BWxprH/Lx5mlLUomPvJOc+EtA=;
        b=jGuxZVrEkh2u8SfknbDrEJnDU4nZu27izJzW+iuh8Rxi9dyz8/94ZtZPGdEwHaSWqE
         HPUa98b6UFB3lq1b8ty0IdIAMWzUxM2H180XU09w1gDlrsVI72x8xbch50vgbU5NmoKl
         2dUYNVigVSnQyZHP8zJRLmvOzV8DMYI8D4bSU5u1h1YCaAxh8WdDlS8v6RlVLPmkiJ62
         D8VdWeN5MxSVsacVx7GUVCyqqrMKVeJfD1BTyGEC0jsYTAuUKIMfm6iUBqV6wOYVK64u
         Kd/D3rUUaIL4MTJEN/rHpt0eZgvdmYq3wORPQO6GkzAr6T0L+aKu0zRi2vNCITjKCYDK
         /0qA==
X-Gm-Message-State: AOJu0YyikjhbhdAM1MkcRthw4YuOmPI4XJ8h2fGEwP44znHE2qGguV08
	jDgD+I6EyZ5e+4PyGtWBVouTAr8DmCxkMsGhBYN2QiCv+fiARHbGl7p2wEGvFTE7A8yNww==
X-Gm-Gg: AR+sD11hr7bBbIUyVyMdNeekosBWMefprOuRAqeWvb9Y3vibisYaG93oSGWc/IqeSvY
	r0vVO4fOxmEoVp9rbahLmyHKewq30eY5xUaE0FesDcucYXatz5YBQgcDNs6/T0JOz+IJpMWuQYe
	DN0WViZJt2NED/h+h9rvPKR3kjlDabqcUGzclO/8/LHj0kthTchDqdsxo5f8BDv6pOxa9sfDL7w
	OEty50ES9MhhpkRvxQfoMW5+evvxrffbtghiQxu2CvHlKf0eFBj2dErOc+KsWX4JqAaNITtPdtw
	bXBr5uKuPpP4xic4O8FDRpZnUi7jcVgVbXX1ES4CeHbQZg4r/5uwhx4JPUgHFl15+xe7YbwYXdq
	vsD77fXXtcZDh50ZIoVxJ4EPZWKEyFJS+813bq7dfFXFXQ/E8ZT3dzF2Yd+pk1yrHWYbCvYNRWu
	yJZ6ZlnO0oce05YcvB0lmQGkWwSBnN
X-Received: by 2002:a17:90b:1350:b0:37f:a915:1c29 with SMTP id 98e67ed59e1d1-38ec64c1ab0mr6264093a91.19.1784872632934;
        Thu, 23 Jul 2026 22:57:12 -0700 (PDT)
Received: from lenovo-thinkbook.lan ([114.143.209.22])
        by smtp.gmail.com with ESMTPSA id a92af1059eb24-13d2d1d0d1esm1531930c88.0.2026.07.23.22.57.09
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 23 Jul 2026 22:57:11 -0700 (PDT)
From: Raushan Patel <raushan.jhon@gmail.com>
To: stable@vger.kernel.org
Cc: Jhonraushan <raushan.jhon@gmail.com>,
	Karol Wachowski <karol.wachowski@linux.intel.com>
Subject: [PATCH 6.6.y] accel/ivpu: Reject firmware log with size smaller than header
Date: Fri, 24 Jul 2026 11:23:40 +0530
Message-ID: <20260724055341.200840-1-raushan.jhon@gmail.com>
X-Mailer: git-send-email 2.53.0
In-Reply-To: <2026072050-fragment-movie-d688@gregkh>
References: <2026072050-fragment-movie-d688@gregkh>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

From: Jhonraushan <raushan.jhon@gmail.com>

fw_log_from_bo() validates the tracing buffer header_size and that the
log fits within the BO, but never checks that log->size is at least
log->header_size. fw_log_print_buffer() then computes:

  u32 data_size = log->size - log->header_size;

which underflows to a near-U32_MAX value when firmware reports a log whose
size is smaller than its header. That huge data_size defeats the
log_start/log_end bounds clamps added by commit dd1311bcf0e6 ("accel/ivpu:
Add bounds checks for firmware log indices"), so fw_log_print_lines() reads
far past the small real data region of the BO. A size of 0 also makes
fw_log_from_bo() advance the offset by 0, causing the callers to loop
forever on the same header.

Reject logs whose size is smaller than the header (which also rejects
size == 0).

Fixes: d4e4257afa6e ("accel/ivpu: Add firmware tracing support")
Cc: stable@vger.kernel.org
Signed-off-by: Jhonraushan <raushan.jhon@gmail.com>
Reviewed-by: Karol Wachowski <karol.wachowski@linux.intel.com>
Signed-off-by: Karol Wachowski <karol.wachowski@linux.intel.com>
Link: https://patch.msgid.link/20260715074206.867712-1-raushan.jhon@gmail.com
(cherry picked from commit ddb44baed257560f192b145ed36cf8c0a412de47)
Signed-off-by: Raushan Patel <raushan.jhon@gmail.com>
---
 drivers/accel/ivpu/ivpu_fw_log.c | 4 ++++
 1 file changed, 4 insertions(+)

diff --git a/drivers/accel/ivpu/ivpu_fw_log.c b/drivers/accel/ivpu/ivpu_fw_log.c
index 95065cac9fbd..ccad9aa99e5d 100644
--- a/drivers/accel/ivpu/ivpu_fw_log.c
+++ b/drivers/accel/ivpu/ivpu_fw_log.c
@@ -43,6 +43,10 @@ static int fw_log_ptr(struct ivpu_device *vdev, struct ivpu_bo *bo, u32 *offset,
 		ivpu_dbg(vdev, FW_BOOT, "Invalid header size 0x%x\n", log->header_size);
 		return -EINVAL;
 	}
+	if (log->size < log->header_size) {
+		ivpu_dbg(vdev, FW_BOOT, "Invalid log size 0x%x\n", log->size);
+		return -EINVAL;
+	}
 	if ((char *)log + log->size > (char *)bo->kvaddr + bo->base.size) {
 		ivpu_dbg(vdev, FW_BOOT, "Invalid log size 0x%x\n", log->size);
 		return -EINVAL;
-- 
2.53.0

