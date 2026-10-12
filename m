Received: from mail-dy1-f180.google.com (mail-dy1-f180.google.com [74.125.82.180])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 104724B66EA
	for <stable@vger.kernel.org>; Mon, 12 Oct 2026 16:59:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=74.125.82.180
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1791824377; cv=none; b=YTwyuko1/Xd73iP2fC/XzVw9cYLVPSbIiOufK8yw3DsS2S/y6jOJ009fLmEemT8Z2MjVhJJWgxNqbkjX2FjJhLBQA1/F7FJOHuJvR3esHvg1Q4lZ2Ezow5jGtt02QDMXZVQHcGSO+eOQ+K8IG3FvzAuVZNVtajcnNPgvrpdIEaU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1791824377; c=relaxed/simple;
	bh=aN+xbxj0aCkAihbURhNM4JHsv/Tq2X9x16GY4E9Hcek=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=gZXvsaXQIm8eRLb4DXwQJWpyLwMHuCO20Qq8pE9VyXazzTTKI2NPbaNf5F1clezQcyF6JjS/qUv8BhzjeFJj0/DJ+GHgGU872Rsd/ZTJiSwcQQV1+7XE2+3opqOFPNPXvQVtsnY3cbSb2gvZ+g0KuRcupW3/IGiLS4V7SFSRAH0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=trailofbits.com; spf=pass smtp.mailfrom=trailofbits.com; dkim=pass (2048-bit key) header.d=trailofbits.com header.i=@trailofbits.com header.b=Fajt2Zgt; arc=none smtp.client-ip=74.125.82.180
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=trailofbits.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=trailofbits.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=trailofbits.com header.i=@trailofbits.com header.b="Fajt2Zgt"
Received: by mail-dy1-f180.google.com with SMTP id 5a478bee46e88-33bf40b0c8bso289239eec.0
        for <stable@vger.kernel.org>; Mon, 12 Oct 2026 09:59:31 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=trailofbits.com; s=google; t=1791824371; x=1792429171; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=B50ZIxaB0P1k35+NQhIdQPJS8AyS5zQSlPA1ktBSYzg=;
        b=Fajt2ZgtncbSzzBY2Ju3Jj7YIs/NLO8mirQlV84+hg7Ue/PGIcmCgxzlbGpPbEGDRl
         43raNW/5y0ZVFvjFyDuFXqUfCL38ygMJQJZ2Nr/CH+uf0E3VsUNhUvNj+i2h4vOrbDj3
         JhYatY/fOJpbE0/5hgLmc9B6S34pNTibMS/MhObPlFAQhYrOL4yNa/NnwgUwJ/CsXLjV
         zn9kuZQNRICxcWIfWpzksnYZ7ef6+XrQfUXc+RyHMHnYUsQnasLurv4SwRGK9rExkTZg
         oLuCs3K3LWiEulqNwDKBECZslN0ndSc3EZmorNXYLZaJzV0qtfJ5GEuqDVyr1x1KVSP5
         QWCA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1791824371; x=1792429171;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to:content-type;
        bh=B50ZIxaB0P1k35+NQhIdQPJS8AyS5zQSlPA1ktBSYzg=;
        b=Ie/sm8VE+70BBPr2jCUSPzxYAEiFEvkPr9Q8D8r46l24XvB2PgBTfPTqpVLLETv12/
         b0i4mOO6yu9v+zTu4+XdmI+0RSq6pa7ypR0wlGVncPmCl0/mT3VtI9DAWMN2Q1qTHpPc
         M2X5qWE6998QqB1LFTW7NQrcyVWB6+xWCtcuAqrABwHXg/Li+lO2orIkP/99xuZ5mb6q
         I9UyNscJcmTpf3b1k4e4fPnRd/ZE1FSuBC+brclR8ZBWgdCOmUc6YARVyoELRL+5elmD
         B2vJhN/HHw2d75jzZm1wmvsom7N0Mf5EUIEC/zoX6da9p5qBvFHR7vygDaYTKGAXPUOH
         w1DQ==
X-Gm-Message-State: AFq9FYJwDN9Wd2R/u1FZvvYZOmcBEzWyK+4bz4Y535PEysVhnOtyoi5y
	dR+7UM08i9HXjnnNNUHBKBkkvkOknU8tOl632OuhDngkj4jLeFcI5cCHxiRpWpq1/PVjD0mcUae
	V2S7jkQan6g==
X-Gm-Gg: AYBFou2K56WhXW8jHop+RkylxTJYsWpsNHs6LYIAeaMaOtqiesGdjoCSk8ARG/+xRR1
	8LyVyGaXtxmWhiLzxXDQGmtX+L0K0lYyu4mvBCSS8/lfFkgKd+2zTwUcMzohieXxyNArDBeCe+z
	xNsNoP/javXyfzLbf1w8x4DvC1gPr0lz4mW1s0WHDVsTIOvXaJp8kgw1lc9P3YCZmt+THzECcjP
	uAKoeSPrVXyDtSn0kE0Vu8VC3fJ8xmzII4ckPL2atu8L+LprZRenuvMIcO5yGl4W9nxgN/vgBWp
	6cKdd4//TkTBwN695GxmbjQeyvO/g/Wb/VzsP4FyZ7OqcWehBrymieZmbAX0ueEOL2TzRKmmF9e
	9yCM0g8UIeO9z+sOkxHESQWhyphFl/F1iWkUFkX/hVdteI3haUkkV3e00lPX+CnkfG4tr2tc8V0
	D9WNDu4SDjPMPohpE5xu/9CAxzVO+5Eduk4d2kLqhM7GthksMtXc+6ZcaRrva+A9QrqjUoCum5l
	2GEwVpLybQFv/Rz26+oY/0BzfXJcDuTpwfMiEZ6XKTB9Dy7VCTonC4n6M80j3ZTNQ==
X-Received: by 2002:a05:701b:2058:20b0:15c:20b8:7964 with SMTP id a92af1059eb24-16a63386d86mr14785713c88.27.1791824370766;
        Mon, 12 Oct 2026 09:59:30 -0700 (PDT)
Received: from localhost.localdomain ([2603:8001:5f01:8bab:1464:826f:d188:9e33])
        by smtp.gmail.com with ESMTPSA id 5a478bee46e88-3537cb2fd33sm34296900eec.28.2026.10.12.09.59.29
        (version=TLS1_3 cipher=TLS_CHACHA20_POLY1305_SHA256 bits=256/256);
        Mon, 12 Oct 2026 09:59:30 -0700 (PDT)
From: Artem Dinaburg <artem@trailofbits.com>
To: stable@vger.kernel.org
Cc: Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
	Sasha Levin <sashal@kernel.org>,
	Baochen Qiang <baochen.qiang@oss.qualcomm.com>,
	Kalle Valo <kvalo@kernel.org>,
	Jeff Johnson <jjohnson@kernel.org>,
	Jeff Johnson <jeff.johnson@oss.qualcomm.com>,
	Vasanthakumar Thiagarajan <vasanthakumar.thiagarajan@oss.qualcomm.com>,
	ath12k@lists.infradead.org,
	linux-wireless@vger.kernel.org,
	linux-kernel@vger.kernel.org
Subject: [PATCH 6.6.y 1/2] wifi: ath12k: fix reusing m3 memory
Date: Mon, 12 Oct 2026 12:59:24 -0400
Message-ID: <20261012165925.32575-2-artem@trailofbits.com>
X-Mailer: git-send-email 2.55.0
In-Reply-To: <20261012165925.32575-1-artem@trailofbits.com>
References: <20261012165925.32575-1-artem@trailofbits.com>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

From: Baochen Qiang <baochen.qiang@oss.qualcomm.com>

[ Upstream commit 00575bb44b2c2aa53d0a768de2b80c9c1af0174d ]

During firmware recovery or suspend/resume, m3 memory could be reused if
the size of the new m3 binary is equal to or less than that of the
existing memory. There will be issues for the latter case, since
m3_mem->size will be updated with a smaller value and this value is
eventually used in the free path, where the original total size should be
used instead.

To fix it, add a new member in m3_mem_region structure to track the original
memory size and use it in free path.

Tested-on: WCN7850 hw2.0 PCI WLAN.HMT.1.1.c5-00302-QCAHMTSWPL_V1.0_V2.0_SILICONZ-1.115823.3

[ Backport to 6.6.y: 6.6.y only loads the separate m3.bin, so use
  fw->size where upstream uses m3_len. The upstream change to the
  allocation-failure message only matters for the firmware-N.bin path,
  which 6.6.y lacks, so it is dropped. The copyright lines are left as
  they are.
  On its own this changes nothing in 6.6.y, because the reuse path
  currently returns before m3_mem->size is updated. It is needed by the
  following fix to my 6.6.y backport of 05090ae82f44, which copies a
  possibly smaller image into the reused buffer as upstream does. ]

Fixes: 05090ae82f44 ("wifi: ath12k: check M3 buffer size as well whey trying to reuse it")
Signed-off-by: Baochen Qiang <baochen.qiang@oss.qualcomm.com>
Reviewed-by: Vasanthakumar Thiagarajan <vasanthakumar.thiagarajan@oss.qualcomm.com>
Link: https://patch.msgid.link/20251029-ath12k-fix-m3-reuse-v1-1-69225bacfc5d@oss.qualcomm.com
Signed-off-by: Jeff Johnson <jeff.johnson@oss.qualcomm.com>
Assisted-by: LLM
Signed-off-by: Artem Dinaburg <artem@trailofbits.com>
---
 drivers/net/wireless/ath/ath12k/qmi.c | 7 +++++--
 drivers/net/wireless/ath/ath12k/qmi.h | 3 +++
 2 files changed, 8 insertions(+), 2 deletions(-)

diff --git a/drivers/net/wireless/ath/ath12k/qmi.c b/drivers/net/wireless/ath/ath12k/qmi.c
index 48d0043fcee9..86cc61dba094 100644
--- a/drivers/net/wireless/ath/ath12k/qmi.c
+++ b/drivers/net/wireless/ath/ath12k/qmi.c
@@ -2518,9 +2518,10 @@ static void ath12k_qmi_m3_free(struct ath12k_base *ab)
 	if (!m3_mem->vaddr)
 		return;
 
-	dma_free_coherent(ab->dev, m3_mem->size,
+	dma_free_coherent(ab->dev, m3_mem->total_size,
 			  m3_mem->vaddr, m3_mem->paddr);
 	m3_mem->vaddr = NULL;
+	m3_mem->total_size = 0;
 	m3_mem->size = 0;
 }
 
@@ -2542,7 +2543,7 @@ static int ath12k_qmi_m3_load(struct ath12k_base *ab)
 
 	/* In recovery/resume cases, M3 buffer is not freed, try to reuse that */
 	if (m3_mem->vaddr) {
-		if (m3_mem->size >= fw->size) {
+		if (m3_mem->total_size >= fw->size) {
 			release_firmware(fw);
 			return 0;
 		}
@@ -2561,6 +2562,8 @@ static int ath12k_qmi_m3_load(struct ath12k_base *ab)
 		return -ENOMEM;
 	}
 
+	m3_mem->total_size = fw->size;
+
 	memcpy(m3_mem->vaddr, fw->data, fw->size);
 	m3_mem->size = fw->size;
 	release_firmware(fw);
diff --git a/drivers/net/wireless/ath/ath12k/qmi.h b/drivers/net/wireless/ath/ath12k/qmi.h
index a996c6d57aa7..62c7a526f111 100644
--- a/drivers/net/wireless/ath/ath12k/qmi.h
+++ b/drivers/net/wireless/ath/ath12k/qmi.h
@@ -119,6 +119,9 @@ struct target_info {
 };
 
 struct m3_mem_region {
+	/* total memory allocated */
+	u32 total_size;
+	/* actual memory being used */
 	u32 size;
 	dma_addr_t paddr;
 	void *vaddr;
