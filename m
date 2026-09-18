Received: from mail-pj2-f13.google.com (mail-pj2-f13.google.com [74.125.227.141])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6FD0F30566B
	for <stable@vger.kernel.org>; Fri, 18 Sep 2026 04:13:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=74.125.227.141
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1789704815; cv=none; b=PdI9kIyZ/nYVVey2b7ZQOOPuFmblSHY9fsSSGKNAgq3xrYp2Mu37jf93hDeLYTzZgtgKG3U1jXnVNyM/iLI9FlBftTEYXcq4zFevrPe/kws95DFjAIk60+qrlam+HL+Whe8UqLGYI9dQACR4fbIWkjnWsxwXLb9js1nz03riihU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1789704815; c=relaxed/simple;
	bh=OKrfEhyS4xgdQEe0LXUQkgF5uAJ4IWaVJVHfo24HVdk=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=e7twX9Ly1kz733X8FY2BiAcJoslUlnOWh1A7GwWyVvOmtYTjdUfexZgUvTf7/DxMW6KtDzKWR/8gLMz8ePrqam8wdxSTyJbhOPomEcKqE4sBT1FMewXBmagy/Mr47sSNxj3T4c3LjENLsYyY29KVfMrclZvIX8/Qa2VeOBBh7Vw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=cgnf4pW4; arc=none smtp.client-ip=74.125.227.141
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="cgnf4pW4"
Received: by mail-pj2-f13.google.com with SMTP id 98e67ed59e1d1-396ccda24a3so254559a91.0
        for <stable@vger.kernel.org>; Thu, 17 Sep 2026 21:13:34 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1789704814; x=1790309614; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to:content-type;
        bh=/O+JJPulgpyE95v4SkCXpautxEmSkN9/7e6v8gJj86o=;
        b=cgnf4pW4oq6IU1Ka0jGjtiVEsZlReY30cCm6OOChxOWchgJ+cbYV7ZF6hqXMwKhQQt
         dxWdId0Ghl3N6uRigqgjkXhwfo7Eyo44fyZ0TdYwQbMWFj2kncYCGpNJUOTao3kxTzxa
         KT4060q4WBgrNgSKrn/sFg23zNBNPIVaFL7Zym2jdMFGKVkWY2vTs0IvwG8jNJLWQj3C
         1eTgy9bn3ZrqN6ubQoSd3k8az2pR8F3bvA1xG5/09M9hhRBIl73jJDePXzIo+ixdmfRT
         rApOD1zaJ2HXxi6wavzFomAc93bdQgDsbgXjnRq/KfE42n6J2KMbGeYVmCN6du146Bm4
         d/9g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1789704814; x=1790309614;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=/O+JJPulgpyE95v4SkCXpautxEmSkN9/7e6v8gJj86o=;
        b=IaQEynjkgE+YBIURcB9M5P5yVC+S7ch7LmMp6rFN2RCZ+l+2sxDbu5ARSQy8bbkfSl
         0vCO3d2tmPidbFSaRS3rEOlaX6scsd7wsJEHQTVY8/sRPT9CPL4KcuFD0sv7UhI10rWl
         lD+Ih3dAF71IglyshGnVX7oZ3s0WbMk4aR5UpZAXCNBLNJ8skLrGh7JveEy4IGbQJrdX
         emJNJOHzsz9lR0+kCcpQLnEor++Hbj2kwqjdgwBUIx61sQKIg0Y/WfkmWeRoqxXZnUYe
         1ALJdU/LNAhFhVOANxzS7YGzgLg7NX/ukh3Vpkv5p9z2Yb3SQF1xJcyf3pusrr697YdG
         rC4g==
X-Forwarded-Encrypted: i=1; AKwUvBxk8b7c1LmmJmwD8fy1mE+xvmU0ZNyMvZ0rLYin7M3EOnnN78dmgvvZM10HeUlzCIr6bpxOpHo=@vger.kernel.org
X-Gm-Message-State: AFuF++m5R1WXJFEY/ubk9OSZgqU+h/z9MFerqwvUR29Qk5cfgFdXs1U8
	LPXjgar1LvaDSiAva2eFGgkO0UTRoQp390C6LEQP97YgrVqBg7+5NbOW
X-Gm-Gg: AYBFou2saFISa8W2xPh3THqhToo6+NaWEXfOazB9eBBCgNEUQ7gK/yAsc26lbUjLen3
	7uZuqMMhOMuwjcj210Zn2iKkGW6WEQ/aV9h8WPm7Fx+R1rPtcFlNMCEaus3jZavpq8tdS1No2uL
	W1YVzdxcsISopFAmhBfCMqKiLFOVeukRibmZwBYHwcU14i1TB2bxEejetUXFTlQroEJLQ/Uw3Ce
	nqROu8qEaD27D3S2x2OVrIvRpA00IDhfAWJn2m7oINnm4aYUHpN1IEAbOlul7+3OE+xap36k+6j
	yMVL/7F+oORymj77FA3vntrYJfGYJ0wu1+7MEuie0kzPQIbvbuEmPewIz3L9LwcAFtmh0+/fSNr
	ix7lY3s7c3DCcue3EH3HWbyxEXbwomt6Fh+EkdSppGo/H7TdGePoQ2OZo0GjOl69+Y31bq2IA5W
	22UFSi7sx0DaLXC9J+IFMximKzBlPAxnnQGHlKskl8aYD7NFnOL5sqyw==
X-Received: by 2002:a17:90b:224c:b0:39d:f317:44cd with SMTP id 98e67ed59e1d1-39e54eab3dbmr4403783a91.14.1789704813699;
        Thu, 17 Sep 2026 21:13:33 -0700 (PDT)
Received: from lgs.. ([2001:250:5800:1002::de93])
        by smtp.gmail.com with ESMTPSA id 98e67ed59e1d1-39e35dab2e9sm9475500a91.1.2026.09.17.21.13.28
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 17 Sep 2026 21:13:33 -0700 (PDT)
From: Guangshuo Li <lgs201920130244@gmail.com>
To: Bjorn Andersson <andersson@kernel.org>,
	Mathieu Poirier <mathieu.poirier@linaro.org>,
	Sivaprakash Murugesan <sivaprak@codeaurora.org>,
	Gokul Sriram Palanisamy <quic_gokulsri@quicinc.com>,
	Govind Singh <govinds@codeaurora.org>,
	linux-arm-msm@vger.kernel.org,
	linux-remoteproc@vger.kernel.org,
	linux-kernel@vger.kernel.org
Cc: Guangshuo Li <lgs201920130244@gmail.com>,
	stable@vger.kernel.org
Subject: [PATCH] remoteproc: qcom: q6v5-wcss: remove all subdevices on unbind
Date: Fri, 18 Sep 2026 12:13:21 +0800
Message-ID: <20260918041321.3532355-1-lgs201920130244@gmail.com>
X-Mailer: git-send-email 2.43.0
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

q6v5_wcss_probe() registers GLINK, PDM and SSR remoteproc subdevices,
and may also register a sysmon subdevice. The probe failure path
removes all of these subdevices, but q6v5_wcss_remove() only removes
the PDM subdevice.

As a result, GLINK, SSR and sysmon resources and registrations can
remain after the WCSS driver is removed.

Call rproc_del() before tearing down the Qualcomm-specific resources,
matching the teardown order used by the other Qualcomm Q6 remoteproc
drivers, and remove the GLINK, sysmon and SSR subdevices together with
the existing PDM cleanup.

This issue was found by manual code inspection.

Fixes: 8a226e2c71bb ("remoteproc: wcss: add support for rpmsg communication")
Fixes: 0af65b9b915e ("remoteproc: qcom: wcss: Add non pas wcss Q6 support for QCS404")
Cc: stable@vger.kernel.org
Signed-off-by: Guangshuo Li <lgs201920130244@gmail.com>
---
 drivers/remoteproc/qcom_q6v5_wcss.c | 6 +++++-
 1 file changed, 5 insertions(+), 1 deletion(-)

diff --git a/drivers/remoteproc/qcom_q6v5_wcss.c b/drivers/remoteproc/qcom_q6v5_wcss.c
index b391724cfd08..4d3a1adbf6c1 100644
--- a/drivers/remoteproc/qcom_q6v5_wcss.c
+++ b/drivers/remoteproc/qcom_q6v5_wcss.c
@@ -1042,9 +1042,13 @@ static void q6v5_wcss_remove(struct platform_device *pdev)
 	struct rproc *rproc = platform_get_drvdata(pdev);
 	struct q6v5_wcss *wcss = rproc->priv;
 
+	rproc_del(rproc);
+
 	qcom_q6v5_deinit(&wcss->q6v5);
+	qcom_remove_glink_subdev(rproc, &wcss->glink_subdev);
 	qcom_remove_pdm_subdev(rproc, &wcss->pdm_subdev);
-	rproc_del(rproc);
+	qcom_remove_sysmon_subdev(wcss->sysmon);
++	qcom_remove_ssr_subdev(rproc, &wcss->ssr_subdev);
 }
 
 static const struct wcss_data wcss_ipq8074_res_init = {
-- 
2.43.0

