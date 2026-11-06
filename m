Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=74.125.82.177
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1793990613;
	b=vGPVpXbM9rwgvOwQqfwwbbFfRyHlANc56lGHNTQ1kfXA2+eeGNXpCme9ikryHXCVsd+Q
	 oQbUmZwuB9BqePuA70DIjoSjKvcSfz5Mp012QR80XBFkj30Pt741qVHE8As5PmsSYKqRz
	 1IWqAOUtJmrO9Bhx/KHRmYRW7yHcv0FbAfXWZda6ad6aParzqEntMmEOGetlHLXv+obw+
	 CM61w2ty+yL09JsI0/S6UNFemrvHJdxDCTYTHmECNKBZagN94J4kPq6MPWizeeeOl3AUl
	 NNOITX80M6s2U+/XMd0FXKaBpEOTb0gcbQNoDONFdbADNM3X7bdPgXWlPisZKHq7fjg==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1793990613;
	h=DMARC-Filter:Received:DKIM-Signature:X-Google-DKIM-Signature:
	 X-Forwarded-Encrypted:X-Gm-Message-State:X-Gm-Gg:X-Received:Received:
	 From:To:Cc:Subject:Date:Message-ID:X-Mailer:In-Reply-To:References:
	 MIME-Version:Content-Transfer-Encoding;
	bh=XsmSmsWKQODtDVmAU1jLzUrhG4gQLD90xJrz79Q20oc=;
	b=a4kiSTkKEp+ZdRVvzeKyCHayRdFL1A2i3DqJvJ9spo+zhDT51LEfGPDvwFHmRk0FNxzX
	 ZdTvBu4PoIfVmBfCnEf+onz1v8Chgt1NlQfTriIpxU8urOTX5a3dX6q/6VKl0vXn/vfcL
	 1QH4fxXCgq9xpci087ufgxujN6cBaPS2KumbTJgvs/gtNJADlOvNhRVqU+PAsUPy+5Zyf
	 ceL229HP6aXN92VZQfJsoiHtATW5NUKcqvt+0k94QfUm0sZiBqPBe4DoKR4bfCmQdcIXj
	 uZ4sJj72PvpZMti5L/fLMhDp/xYE3JgxYWwBvFGRrIplCQHmMkQzyrpgG1OIxQ/Gurg==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=gmail.com;
	spf=pass smtp.mailfrom=gmail.com;
	dkim=pass header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20260707 header.b=BMWL8YiI;
	arc=none smtp.remote-ip=74.125.82.177
Received: from mail-dy1-f177.google.com (mail-dy1-f177.google.com [74.125.82.177])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A64C3606A333
	for <stable@vger.kernel.org>; Fri,  6 Nov 2026 18:43:32 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org A64C3606A333
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20260707 header.b=BMWL8YiI
Received: by mail-dy1-f177.google.com with SMTP id 5a478bee46e88-33bf40b0c8bso488083eec.0
        for <stable@vger.kernel.org>; Fri, 06 Nov 2026 10:43:32 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20260707; t=1793990612; x=1794595412; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=XsmSmsWKQODtDVmAU1jLzUrhG4gQLD90xJrz79Q20oc=;
        b=BMWL8YiI++mvB2+iBIl7SxpDY70MvHgOpCS3VUgI8aa3d4A19vIjQ9kG4X36UKlpIL
         PvPbBpBn6lQN+f1BWsYsMt26DLPA6BydGxvfCR4ilo5BkyPF9Z0iDXCuq+dteIBtWI+k
         O79B8sl/Cr8D/C+BxicSkv4d7j/j1yn4H/HeBW9xXu5XihcfbQISkMEEwUe3P3nZg4sm
         bA/qlesPeqFwbhnunxXRb4ozrQSqAA/oJ2MDMu8c4ydu7BhNutywIXGQdmRk0ON21+U2
         e+q18qTOVblBKlyKvbDof31/hQykNmbNB4sOgA1fgTBx1a1wZDlg2pM+JemOJsruILh1
         SPCA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1793990612; x=1794595412;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to:content-type;
        bh=XsmSmsWKQODtDVmAU1jLzUrhG4gQLD90xJrz79Q20oc=;
        b=xdUJlDI5lwOg0vnG4ghh/Ok3p26/x1iSLVmtPlchrRBW3ilPnfGv7/i4D2SQwAXGkk
         4d2F+uHzA4Ff71uevYg5yoHDxqYn/16JMaGG4M7BRVUGdN3bKGvgniw3+R0Ihej0IFwJ
         eTwfssMMs+FjZlYS/PYxfBFY3eOmx1MZioyb0y7PNAtGEvGVm/5xJd2Uh9K/JkF00E3R
         JR6076e6rwyeLNoDC1Tf2Kz/1f7XuLH3pCHcY53gXV5UCiGOsQfkuiYYtnxEeR2xX6Ra
         qz8CcamUf/HsBYcYAvs6Z64aHVekbMkG8wC/wy8+pGq6LKL/2M8okjLxbIN9SddBpvR6
         S8Dw==
X-Forwarded-Encrypted: i=1; AL+hErF4b0s7RbgfiRIH+ywYwVS00DFAcig/zetZvK0CMQ/LrIbpuA9FYlqad+cK/T3gmDOO/HW+A6g=@vger.kernel.org
X-Gm-Message-State: APuU4Z8BhHwiUymnfxo5iZweZAN0FUM+kfBzeZjBtzNYcruQFTXqphMr
	hWz5gcWAdYBTh2XUahCWlJWqhEywTr4tTtjRfTUvB26AwFJLUg0rtgdh
X-Gm-Gg: AYBFou2FFql6zF4GtsPjb1hLwtTfgmOonjTNSXB/tuUOmmwOodqUiyfXqsG6RQzRXRP
	VPtCB6nKaw0XlgOaNT64e/beumyivdzs3HSuZ7gKEkocuoSXjnzQ7FsEbQ/6Y3gPr1j6bWkqBmM
	eQOHnKpXxotTLk6PlZAX0CIUd9S76RvxREorzcxqpWeVUScrhGzYkXZilzL3O9/xzbK+vr9ZRU5
	dNoCNlFxVeXCTq/wGUUBT/7iTLkC0LubUrCKuSU3al5XKK7wW7QLAXDsuNLBYocRVwQRoo3q3BQ
	qRFRb48zsZ/eO0uY7uhhRp1kkQWccu0G4sQMYp6My3RUuGj9UaGpfRuinhz/WFDFYKpCyhYMu+P
	CKbo/3/ajZSeKVss8Y0GGMOJCqZsjIcmxGZB2ua2zzmmlaY/MjQtwITGBW6nRZMsMwvGtgVz1K/
	/x/eCAi9n80jPabfwul/4VAJY1Uz4TUdDv+aBNWT8rdH48084yMMqpfhRH/8C28hIHJK5xL+Tk3
	sl0el//SqbQ6s3khBMJ2WNgPQHEB79TWW8NeakJ7be8MBpFauKwFVzXAI2skUsKHTfbB9wn3QFW
	kOsm0PIL9V33Hjz8mc3r217ORsEO
X-Received: by 2002:a05:693c:2808:b0:36a:13df:749d with SMTP id 5a478bee46e88-36f76a1cc4bmr3692769eec.24.1793990611603;
        Fri, 06 Nov 2026 10:43:31 -0800 (PST)
Received: from JMD ([2405:201:d028:10ff:eceb:5028:6b10:da7c])
        by smtp.gmail.com with ESMTPSA id 5a478bee46e88-36fa9aea414sm8278073eec.16.2026.11.06.10.43.27
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 06 Nov 2026 10:43:31 -0800 (PST)
From: Atul Akella <atul.akella@gmail.com>
To: andersson@kernel.org,
	mathieu.poirier@linaro.org,
	sibi.sankar@oss.qualcomm.com,
	quic_srichara@quicinc.com
Cc: linux-remoteproc@vger.kernel.org,
	linux-arm-msm@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	Atul Akella <atul.akella@gmail.com>,
	stable@vger.kernel.org
Subject: [PATCH 1/4] remoteproc: qcom: Fix bounds check in adsp_da_to_va()
Date: Sat,  7 Nov 2026 00:13:08 +0530
Message-ID: <20261106184312.100-2-atul.akella@gmail.com>
X-Mailer: git-send-email 2.51.0.windows.1
In-Reply-To: <20261106184312.100-1-atul.akella@gmail.com>
References: <20261106184312.100-1-atul.akella@gmail.com>
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

offset is calculated as da - adsp->mem_reloc and stored in a
32 bit signed int, while da and adsp->mem_reloc are both u64.
For a sufficiently small da, the 64bit difference is truncated
into the 32 bit int, bypassing the offset < 0 underflow check
with a small positive value. Additionally, offset + len >
adsp->mem_size can itself overflow when offset and len are both
large, providing a second bypass.

da and len come from firmware's ELF program headers via
rproc_da_to_va(), and the result is used by the ELF loader
to write firmware segments, so a malformed firmware image can
cause writes outside the carveout.

Rewrite the bounds check entirely in u64 arithmetic. Reject
underflow before computing offset (da < adsp->mem_reloc).
Replace the addition based overflow check with a
subtraction based one (len > adsp->mem_size - offset) so no
intermediate sum can wrap.

Fixes: dc160e449122 ("remoteproc: qcom: Introduce Non-PAS ADSP PIL driver")
Cc: stable@vger.kernel.org
Signed-off-by: Atul Akella <atul.akella@gmail.com>
---
 drivers/remoteproc/qcom_q6v5_adsp.c | 6 ++++--
 1 file changed, 4 insertions(+), 2 deletions(-)

diff --git a/drivers/remoteproc/qcom_q6v5_adsp.c b/drivers/remoteproc/qcom_q6v5_adsp.c
index 46d9169a37f6..1bf87cd0e9dd 100644
--- a/drivers/remoteproc/qcom_q6v5_adsp.c
+++ b/drivers/remoteproc/qcom_q6v5_adsp.c
@@ -486,10 +486,12 @@ static int adsp_stop(struct rproc *rproc)
 static void *adsp_da_to_va(struct rproc *rproc, u64 da, size_t len, bool *is_iomem)
 {
 	struct qcom_adsp *adsp = rproc->priv;
-	int offset;
+	u64 offset;
 
+	if (da < adsp->mem_reloc)
+		return NULL;
 	offset = da - adsp->mem_reloc;
-	if (offset < 0 || offset + len > adsp->mem_size)
+	if (offset > adsp->mem_size || len > adsp->mem_size - offset)
 		return NULL;
 
 	return (__force void *)adsp->mem_region + offset;
-- 
2.43.0

