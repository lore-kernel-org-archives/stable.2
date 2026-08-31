Received: from mail-pj1-f52.google.com (mail-pj1-f52.google.com [209.85.216.52])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8B65346EC7C
	for <stable@vger.kernel.org>; Mon, 31 Aug 2026 15:28:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.216.52
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1788190105; cv=none; b=BKn9ItIAewyT2fbj7kiXu/SeoeVcUv6F/I9bdJhFzg+BlOsxzZBJsXPBnqm4HNUyS7jYLCTPA19j+43sk2ECh+EDMFJP0BwZgoqJUaRwKQse1FleaC4/1UtPUblbbc4fIH2BuuGBFBpIBSjvMVjs3Oiwi0JtHJ51J8h3ayzepNM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1788190105; c=relaxed/simple;
	bh=UVaSnAntsnidTQyQIAWkdDSWDG/mfhc9FkANFMl71lU=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:To:Cc; b=Vg4mvpG8nHbFg3ft2knRy5UmPq9012vXKelDNari5u3qbrsbvdyqRZG1KzzDpJLSbNkIsmDSQ3P8eG/9gfTtwwWhg10hvJuJufN4afE4RMphzGuNpA14/uGht7k3HpfBO4MlYr9MXhCla5duU4OVO3ti22u2WZ1WGW8f3rgn4lc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=Dv+VGBAV; arc=none smtp.client-ip=209.85.216.52
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="Dv+VGBAV"
Received: by mail-pj1-f52.google.com with SMTP id 98e67ed59e1d1-38759bcd877so3520043a91.2
        for <stable@vger.kernel.org>; Mon, 31 Aug 2026 08:28:24 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1788190104; x=1788794904; darn=vger.kernel.org;
        h=cc:to:message-id:content-transfer-encoding:content-type
         :mime-version:subject:date:from:from:to:cc:subject:date:message-id
         :reply-to:content-type;
        bh=LzXEuTigiTiPkrsvsB4lTws1Gv1eiCRXL/HMjZW3pgA=;
        b=Dv+VGBAV+xNPvTURXvUpAquidUdVTNnjzTCKqfdp3UJJpd65cXNMzBLMld+TUnvsvl
         3M0/jI5cJ0vlK0OvYcMcdMIhufAk84ePXu3TYpWsJznaP8cEVyf/WClCnPigPZaM5Any
         0URwA8aZgD0LzdsRTDDZY16Za0XcuJ86s2Pcq6NjV417uBgzHnSy1OuSmZ9qa5uru/xc
         B/Q+vXyk63e1558Jw8yUDgBGShTXpJKa0bXGhJx1zzL2Thn+AVwkePtfltOxY7D/+/g2
         6p1j2xjRt/20Be9q2YeElAx8j5H0+HiUJ21ImopC0ZJA5WRP1EIF4cAyxhdL5XmR7JQm
         yvpg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1788190104; x=1788794904;
        h=cc:to:message-id:content-transfer-encoding:content-type
         :mime-version:subject:date:from:x-gm-gg:x-gm-message-state:from:to
         :cc:subject:date:message-id:reply-to:content-type;
        bh=LzXEuTigiTiPkrsvsB4lTws1Gv1eiCRXL/HMjZW3pgA=;
        b=Z2qNVQ6By53wTne2NIGBzVZH5U98yJRjTHwAsaaqNB0DCIy+XG/MRgs5GAxh9tvoi6
         7c9R4aNpHsjKvmRzvvVXGGauXPIs+MnF+F6Vod3st9cRcxZx9GDG4yxvTPd9AJfB5VN8
         GZ1PjBaNg51eMi/J3HH+lzYoEGztMI7hi941jKTdrIPOdPlAAvM1DwK5f+OyCHmf0Ihx
         pRt9SdUcoRYGCJeAx7X939kHOMSsDOC3TyWqa/felIPQ8pu9/aJLACTCHFdZObwvkWOD
         T++wSu2x/mqxbCEukGnsYoN/E+4eHXVDPl99qSXhyCF/MYoeThpvC0h1qigVvGb/+j4a
         8Yuw==
X-Forwarded-Encrypted: i=1; AKwUvBxLdIrGFiKJq4h1fT3Uv7nHVJC+ecjHWHjJSpsByyCDzzBZm59lbwATXL9T/M14L764do+I9Eo=@vger.kernel.org
X-Gm-Message-State: AFuF++no8DxBkDOegTaarEWHR7UxJUVB6Y166n3sjRM3gVRn4UHYGJbU
	4cbon6H+gQ/AqpUXVjmAGreZwBOHnMZ6nq4STDO1E1k7bi4IuiFdc6wQ
X-Gm-Gg: AYBFou3Vatk0I0oEzaGNEZsAJG9p94CbeS9THY/cNxsiaxsGQoRUXt4bMVExuie5RHb
	QAUTQQe3hmbPizNLhsTDTXZjK4VAp+ANn6F73F5d5YAhTXZYIwZ23z6edUTgBGkR6/N743LImwl
	jx6qWeC49qO4nGET8uTDn1MS6hVckZN6dzYHmtTTMIQQ53lhyNF1oo87yJT5958l84TxDbFGYXN
	K/lZWDfBfsuZceSdHrJBr+XTLvzqjfUiJEV8jvlMgaJfa3Avy3qarf7jDVSWBlABy+MkH63zH0G
	uk+YMF8NinQHvWlrPjk6rhg9U23qdax3KedlRB1WB+bJrd8iHwXxJXb4mZ3zZYF0LUeI0jPl5lA
	KG9Er5tSw7ndemJwaGNMcfmAbYfmpFJdPdPVpLLyhrl2Ye8YW3rBMVLMwAeyKW0lpUyv77VfHec
	qVbPkQbRrDlHbmPtxn6kXa27+O7q7AFdumPtpZyBIUi8OG31nXB4heOEdB+eFpIgXoSUh3eF6N9
	dmczyWYSbyTCs48K/nyEaOhJ2Cqrw==
X-Received: by 2002:a17:90b:2551:b0:37d:f983:7b5 with SMTP id 98e67ed59e1d1-396d0fe384cmr47180926a91.9.1788190103615;
        Mon, 31 Aug 2026 08:28:23 -0700 (PDT)
Received: from urmom.urmom ([14.170.170.155])
        by smtp.gmail.com with ESMTPSA id 98e67ed59e1d1-3990bcf7ca7sm8891a91.4.2026.08.31.08.28.20
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 31 Aug 2026 08:28:23 -0700 (PDT)
From: Lucas Sproule <lucas.sproule.42@gmail.com>
Date: Mon, 31 Aug 2026 22:28:08 +0700
Subject: [PATCH v2] remoteproc: qcom_wcnss: Fix error check after
 devm_ioremap_wc() switch
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20260831-wcnss-is-err-fix-v2-1-5520fd4c6b50@gmail.com>
X-B4-Tracking: v=1; b=H4sIAAAAAAAC/yXMwQ6CQAyE4VchPdMEligur0I8QB21HlbTqpAQ3
 p0Vj98k8y/kMIVTVyxk+KrrM2WEsiC5D+kG1ks2hSocq1NT8yTJndUZZnzVmdsQJdZAbA9C+fY
 y5HlP9ue//TM+IO9fh9Z1AzHfXE90AAAA
X-Change-ID: 20260831-wcnss-is-err-fix-729c91ee975c
To: Bjorn Andersson <andersson@kernel.org>, 
 Mathieu Poirier <mathieu.poirier@linaro.org>, 
 "Rob Herring (Arm)" <robh@kernel.org>
Cc: linux-arm-msm@vger.kernel.org, linux-remoteproc@vger.kernel.org, 
 linux-kernel@vger.kernel.org, stable@vger.kernel.org, 
 Lucas Sproule <lucas.sproule.42@gmail.com>, 
 Konrad Dybcio <konrad.dybcio@oss.qualcomm.com>
X-Mailer: b4 0.16.0

Commit f9b888599418 ("remoteproc: qcom_wcnss: Fix reserved region
mapping failure") switched back from devm_ioremap_resource_wc() to
devm_ioremap_wc(), but kept the IS_ERR() check that had been added to
match the resource variant.

devm_ioremap_wc() returns NULL on failure rather than an error pointer,
so IS_ERR() never fires and wcnss_alloc_memory_region() returns success
with wcnss->mem_region left NULL.  Probe completes, and every subsequent
firmware boot then fails with a bare -EINVAL from qcom_mdt_load_no_init(),
masking the real mapping failure.

Check for NULL instead, and return -ENOMEM to match the other remoteproc
drivers.

Fixes: f9b888599418 ("remoteproc: qcom_wcnss: Fix reserved region mapping failure")
Cc: stable@vger.kernel.org # v7.0+
Signed-off-by: Lucas Sproule <lucas.sproule.42@gmail.com>
Reviewed-by: Konrad Dybcio <konrad.dybcio@oss.qualcomm.com>
---
Changes in v2:
- Collect Konrad's Reviewed-by.
- Resend using b4; v1 was whitespace-damaged in transit.
---
 drivers/remoteproc/qcom_wcnss.c | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/drivers/remoteproc/qcom_wcnss.c b/drivers/remoteproc/qcom_wcnss.c
index c856a92af43c..90747af237f7 100644
--- a/drivers/remoteproc/qcom_wcnss.c
+++ b/drivers/remoteproc/qcom_wcnss.c
@@ -542,9 +542,9 @@ static int wcnss_alloc_memory_region(struct qcom_wcnss *wcnss)
 	wcnss->mem_phys = wcnss->mem_reloc = res.start;
 	wcnss->mem_size = resource_size(&res);
 	wcnss->mem_region = devm_ioremap_wc(wcnss->dev, wcnss->mem_phys, wcnss->mem_size);
-	if (IS_ERR(wcnss->mem_region)) {
+	if (!wcnss->mem_region) {
 		dev_err(wcnss->dev, "unable to map memory region: %pR\n", &res);
-		return PTR_ERR(wcnss->mem_region);
+		return -ENOMEM;
 	}
 
 	return 0;

---
base-commit: 73e3f0710014fe6d4ed98cfc02292f6121db7558
change-id: 20260831-wcnss-is-err-fix-729c91ee975c

Best regards,
--  
Lucas Sproule <lucas.sproule.42@gmail.com>

