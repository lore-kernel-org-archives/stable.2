Received: from mail-dy2-f43.google.com (mail-dy2-f43.google.com [74.125.229.43])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6D7BD54705C
	for <stable@vger.kernel.org>; Tue, 29 Sep 2026 02:59:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=74.125.229.43
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1790650748; cv=none; b=q5/gJkQJF/ZRRrnrcKfTqILphJV+oRpXkvWeux+T13OBktJ0mib1IkknbZzC5ZjTJIEzeppNgKB5FQoyJMKQJAp492ue0nDbgEsPXve2vh3Fm7FzMUwVUGRELIi6OmivgvcZ5bs1OmMzBaX38mA3ID49iUe5NiZlVC0E9BAR72A=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1790650748; c=relaxed/simple;
	bh=kXrjLhbsK2Ocn4zMaQ96UrnybhAn/fYYRhsUrgKCtIs=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=YXgA++ezfl1opx79QMxutwgI308B++umshAjQphV7Lnmm1F2HeIeDreGXTYGb+jfO9qKt4fw89bW/QWHF0V37fxeLxEu0oy7qqvaP6vnN/XxXU98MWBQ+FtFF7N1HhQ2Qs1roWSEG9dpZF5tNUgCS+SkhroYsxdfTVpK2jAG7HE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=trailofbits.com; spf=pass smtp.mailfrom=trailofbits.com; dkim=pass (2048-bit key) header.d=trailofbits.com header.i=@trailofbits.com header.b=CWsPMkz0; arc=none smtp.client-ip=74.125.229.43
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=trailofbits.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=trailofbits.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=trailofbits.com header.i=@trailofbits.com header.b="CWsPMkz0"
Received: by mail-dy2-f43.google.com with SMTP id 5a478bee46e88-33c24422d4dso4325611eec.2
        for <stable@vger.kernel.org>; Mon, 28 Sep 2026 19:59:05 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=trailofbits.com; s=google; t=1790650744; x=1791255544; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=RjnvcjGV1fxpLT6EIE5odbTgRtwNmnowIubP3qX9FiY=;
        b=CWsPMkz0svNA+FvS9DwtqJNEVTY4hMUxZhBZ124gzHRKCiguggmTnvwGkwYqblYSqa
         vZ+YR6KqPLBtXckLODkJF3hwaAHDv0xRFmzMhddnxlQnkqnr4rZQ2JKvMSF7vsbq4ZxV
         ZtmAyc6V/3QJ+Rw6+0Khcr/Opo9bCufo6n3krRi7c4d6NpBwSEOEqCURf7nn9NYfeEFp
         qH53FmmttwQ9OKbHYSo0yyu17nxfl6cSZOIohtqfERUm0zB2vI5LLf13fip/ENowHxI3
         X7ASRuEbi+ene09g4O5dTj/XY0VKZM8NJkK+iA4WqbQDqoxa6XtKtFudFJoooJCpCBiL
         NiOw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1790650744; x=1791255544;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to:content-type;
        bh=RjnvcjGV1fxpLT6EIE5odbTgRtwNmnowIubP3qX9FiY=;
        b=o2szsj9UtWUwCv9WuGtiPAz0+XNlgOapqp42c+fYXho+h0yy13eJB62p+Gc4QQaF7g
         OiikOzz4WU/l9mSGKHFCfG04g8VNd2rjygeV+PHFmx6rwVq4ffZPUwwKchAnThM03PBY
         Ub3fsv/tTIuWe7nJYmOC+8HU4sk63H7lk7A/qF5l8p/nP154tJDVMcTNcWhlZgFJEc9u
         knGlpg5j5Zp8C5zEGXkZh7jygbCoU5P12xOoLuO49VHNycoEeXwHtaHt7xI04JFnSa91
         51Gk4tSIMnLE/uZZTA6W9HXwfclS2/WT1M34Llmw+SVaZYEuMeuN4CszqHem8HTrLKAq
         3qgg==
X-Gm-Message-State: AFq9FYLwK3KAxgKuKWeNblj70gs7g/0Lze4/RnMagXiJyVAEmU/o5pRz
	ak2EmpHKBSHPH76g5y7CcrmN19yXup7pLAmyalsz+TRRvivnft2TFeKKPt89htPUmcG0SnRaG0S
	t8xL4jV8=
X-Gm-Gg: AYBFou00rRwbIDQeW7rGp/NFfWT7agCOW5lMU1x5zUuEjF87oFfpNNDkP0ntK2xwogZ
	tqLsQx6u+ZllugTd/J+7rPxWYjIFLb83tzAiUn839SG9gjMdIZTsbqsFX+52v/tJuTqH0Yh2vWM
	rMUvSAOg0f61gahDvUz0mqAGpnoNAqJUhXh6CWRErj+yP9D7L1zY63eyT+dJKKxsgdVraJLGxKI
	eXcy8aUpyzeIvkJFKpkvDwEhm5b1csQDGZI2S14NkBREPbyHZYd+WT1Irt10pqP9BMgvNvnreod
	iWKvChqVayQbC1ygL0t9LhLXUVqGE4W9o91ewWWdm4UnJyLB8FhdShaMNjln1A46hVat3Ht5iWj
	pDAkD/xPhY+F2QThh0owcdl4qkY3pZaqg6igJU1j7QXLePzhIjrRdkSjLQ0jzVxEUWHhvwbATVp
	WiVedaTUrDgLO9jm89m6d88sSaJW3ZZZ5kqzO5s3flq266ntYjpOvWh7pbCzGUHdyc0xXE0lhhb
	9juaau6Tcnj465e0OSIfbqIqOQaqC8qMspm9SSkRmGqcz+a/PzMSHH4owsplg5XYrATBQo=
X-Received: by 2002:a05:7300:e11c:b0:33e:633c:7f70 with SMTP id 5a478bee46e88-34272b3bbb7mr13637894eec.35.1790650744286;
        Mon, 28 Sep 2026 19:59:04 -0700 (PDT)
Received: from localhost.localdomain ([2603:8001:5f01:8bab:3481:cbb6:f339:9e4e])
        by smtp.gmail.com with ESMTPSA id 5a478bee46e88-34571658054sm13111683eec.8.2026.09.28.19.59.03
        (version=TLS1_3 cipher=TLS_CHACHA20_POLY1305_SHA256 bits=256/256);
        Mon, 28 Sep 2026 19:59:03 -0700 (PDT)
From: Artem Dinaburg <artem@trailofbits.com>
To: stable@vger.kernel.org
Cc: Artem Dinaburg <artem@trailofbits.com>,
	Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
	Sasha Levin <sashal@kernel.org>,
	Baochen Qiang <quic_bqiang@quicinc.com>,
	Jeff Johnson <jjohnson@kernel.org>,
	Kalle Valo <kvalo@kernel.org>,
	ath12k@lists.infradead.org,
	linux-wireless@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	quic_jjohnson@quicinc.com,
	Kalle Valo <quic_kvalo@quicinc.com>
Subject: [PATCH 6.6.y 2/2] wifi: ath12k: check M3 buffer size as well whey trying to reuse it
Date: Mon, 28 Sep 2026 22:58:54 -0400
Message-ID: <20260929025856.85683-3-artem@trailofbits.com>
X-Mailer: git-send-email 2.55.0
In-Reply-To: <20260929025856.85683-1-artem@trailofbits.com>
References: <20260929025856.85683-1-artem@trailofbits.com>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

From: Baochen Qiang <quic_bqiang@quicinc.com>

[ Upstream commit 05090ae82f44570fefddb4e1be1d7e5770d6de40 ]

Currently in recovery/resume cases, we do not free M3 buffer but
instead will reuse it. This is done by checking m3_mem->vaddr: if it
is not NULL we believe M3 buffer is ready and go ahead to reuse it.

Note that m3_mem->size is not checked. This is safe for now because
currently M3 reuse logic only gets executed in recovery/resume cases
and the size keeps unchanged in either of them.

However ideally the size should be checked as well, to make the code
safer. So add the check there. Now if that check fails, free old M3
buffer and reallocate a new one.

Tested-on: WCN6855 hw2.0 PCI WLAN.HSP.1.1-03125-QCAHSPSWPL_V1_V2_SILICONZ_LITE-3.6510.30

[ Backport to 6.6.y: mapped the M3 size validation onto the target's
  older QMI allocation layout. ]

Fixes: 303c017821d8 ("wifi: ath12k: fix kernel crash during resume")
Signed-off-by: Baochen Qiang <quic_bqiang@quicinc.com>
Acked-by: Jeff Johnson <quic_jjohnson@quicinc.com>
Signed-off-by: Kalle Valo <quic_kvalo@quicinc.com>
Link: https://msgid.link/20240425021740.29221-1-quic_bqiang@quicinc.com
Assisted-by: LLM
Signed-off-by: Artem Dinaburg <artem@trailofbits.com>
---
Hi Greg, Sasha, and wifi ath12k maintainers,

I am working through the small CVE backports still missing from 6.6.y.
This one addresses CVE-2024-40979. It also validates the reusable M3 buffer
size and reallocates an undersized buffer.

The fix is already present in 6.12.y, 6.18.y, and 7.2.y, but not in 6.6.y.
The target-specific adjustment is recorded in the bracketed note above.

Could you please queue it for 6.6.y?

CVE: CVE-2024-40979
Upstream: 05090ae82f44570fefddb4e1be1d7e5770d6de40

AI assistance: An LLM helped identify, adapt, and validate this backport; I
reviewed the resulting code and validation evidence.

Thanks,
Artem Dinaburg

 drivers/net/wireless/ath/ath12k/qmi.c | 39 ++++++++++++++++-----------
 1 file changed, 24 insertions(+), 15 deletions(-)

diff --git a/drivers/net/wireless/ath/ath12k/qmi.c b/drivers/net/wireless/ath/ath12k/qmi.c
index 7a9868dbab02d7..48d0043fcee93b 100644
--- a/drivers/net/wireless/ath/ath12k/qmi.c
+++ b/drivers/net/wireless/ath/ath12k/qmi.c
@@ -2511,6 +2511,19 @@ static int ath12k_qmi_load_bdf_qmi(struct ath12k_base *ab,
 	return ret;
 }
 
+static void ath12k_qmi_m3_free(struct ath12k_base *ab)
+{
+	struct m3_mem_region *m3_mem = &ab->qmi.m3_mem;
+
+	if (!m3_mem->vaddr)
+		return;
+
+	dma_free_coherent(ab->dev, m3_mem->size,
+			  m3_mem->vaddr, m3_mem->paddr);
+	m3_mem->vaddr = NULL;
+	m3_mem->size = 0;
+}
+
 static int ath12k_qmi_m3_load(struct ath12k_base *ab)
 {
 	struct m3_mem_region *m3_mem = &ab->qmi.m3_mem;
@@ -2518,9 +2531,6 @@ static int ath12k_qmi_m3_load(struct ath12k_base *ab)
 	char path[100];
 	int ret;
 
-	if (m3_mem->vaddr || m3_mem->size)
-		return 0;
-
 	fw = ath12k_core_firmware_request(ab, ATH12K_M3_FILE);
 	if (IS_ERR(fw)) {
 		ret = PTR_ERR(fw);
@@ -2530,6 +2540,17 @@ static int ath12k_qmi_m3_load(struct ath12k_base *ab)
 		return ret;
 	}
 
+	/* In recovery/resume cases, M3 buffer is not freed, try to reuse that */
+	if (m3_mem->vaddr) {
+		if (m3_mem->size >= fw->size) {
+			release_firmware(fw);
+			return 0;
+		}
+
+		/* Old buffer is too small, free and reallocate */
+		ath12k_qmi_m3_free(ab);
+	}
+
 	m3_mem->vaddr = dma_alloc_coherent(ab->dev,
 					   fw->size, &m3_mem->paddr,
 					   GFP_KERNEL);
@@ -2547,18 +2568,6 @@ static int ath12k_qmi_m3_load(struct ath12k_base *ab)
 	return 0;
 }
 
-static void ath12k_qmi_m3_free(struct ath12k_base *ab)
-{
-	struct m3_mem_region *m3_mem = &ab->qmi.m3_mem;
-
-	if (!m3_mem->vaddr)
-		return;
-
-	dma_free_coherent(ab->dev, m3_mem->size,
-			  m3_mem->vaddr, m3_mem->paddr);
-	m3_mem->vaddr = NULL;
-}
-
 static int ath12k_qmi_wlanfw_m3_info_send(struct ath12k_base *ab)
 {
 	struct m3_mem_region *m3_mem = &ab->qmi.m3_mem;
-- 
2.39.5

