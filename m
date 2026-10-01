Received: from mail-qv2-f41.google.com (mail-qv2-f41.google.com [74.125.230.169])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 605D252BE5E
	for <stable@vger.kernel.org>; Thu,  1 Oct 2026 17:55:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=74.125.230.169
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1790877323; cv=none; b=CiVTpyBp2PSAPC34K/nPo6xAR8HCT+C1/MnCjis0uRttnoZOshr7wsYKAULhbQYuHy6r/t7NXS7OTSTtSbuKN0NQbrpda69gm2qS7ETCnxlpvEeknjwk5D+U3ZIdUpCGFfbuS+UfZaePNyzfvFRYfttlYu6LJHTAgMYo37GDzwU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1790877323; c=relaxed/simple;
	bh=j5qbuXrDX2plwlT/z3lSzoNInbPkdLmaRYkhQoo2lGM=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=DDC20cE1QTseVi+ZmMHPbNRJwgmLeYZogeI4WfEUGYANvZBy6c5L+8YtE58pvQEDHxu0Yn2Yh7uj5v5VtnHHpv/+OGjVId1u0JTZ5hXeYEVZz9VH1SWAapNHF2ZdBoh4rIozmmtBuypHn0duLi9xhZ7kJQgXnAqVRPxTbiXx+kA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=qIPTZDM0; arc=none smtp.client-ip=74.125.230.169
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="qIPTZDM0"
Received: by mail-qv2-f41.google.com with SMTP id 6a1803df08f44-91788e38a27so32161536d6.3
        for <stable@vger.kernel.org>; Thu, 01 Oct 2026 10:55:15 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1790877308; x=1791482108; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=Lfjo9pAawGhp175tsWiMgt+u8R0WsNzuMBsHkL3MrJQ=;
        b=qIPTZDM0c/Gj6EXjjDOZV3mYA0aDWCjPwJar//JToJ1LZ5D11gltJ9OJJetbSryOu0
         AejFTNqt2ER9Pd3f2mQFUCAFqlTBqNoP5uqhx+gfkW1DXrY/ayQRZwuV4tpPa4mSp/Ij
         fElMqfqDoksjJ+unPLXT4o3XNxDpEcw8Hokq8MOTaV/FOexBlLPyayEyfcrpVSC2tgBl
         is+A0BmfBhGSQfcEU8RudiDd/OktcUniDscZJEiSV8yzEEXuRRfrWJJn+anMl3jkfsuI
         auNZmBFHn689J2FcTXmqHLIvNRb/KPRfqJiz13oyTcr7D6RcMk3QZz78ePjXzSn3W74r
         DcXA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1790877308; x=1791482108;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to:content-type;
        bh=Lfjo9pAawGhp175tsWiMgt+u8R0WsNzuMBsHkL3MrJQ=;
        b=VtpoXbLXlbqu3HWM1TzYCZWXdKwUpb2/XWAvPr/RmyEfktj5Ykr4dR488Hq/zELfvX
         3mS/YNttmfJz6y+ehQc/Jai7EZLpjwZ4EcJDUdEh0sx9tUeZO2ymlXlXEobAkpW5AIB/
         D5KDy+Zd11N0J5cxCvoLumCzu0wu0zp9kvqK2U5zTayam32fbWt+WS8/RaA28XDvCgkJ
         1kYk4zrJjSqcrngzH6dbPmciLFQOY2QKS8HFDFJ0WAzfOCl2PlT+bngpinOo40MXChj2
         YWzqZXCg2m0mdppLPQITxdTZW1zWIQsBGgmXpKp3WG6ovZdjqHF13q2gP2W98+HqJZ2F
         F7nw==
X-Forwarded-Encrypted: i=1; AKwUvBxZBgy7G8+EjNkU3VNNSaOpJBfYKmc2CVowbLfMWdXgDM8iVpRLeAVo4/5QbpWREbGJ3lFOKb0=@vger.kernel.org
X-Gm-Message-State: AFq9FYI4i/6e9DP2XG+nhxOFcd9jdDFANquziYfjJ1lAiHN21YRZSVRq
	HsL3/fNXqaEZnKqx9UZSqCxLovN0CSxP/AtO6tcYU36TK0PBIU391cQ=
X-Gm-Gg: AYBFou2t0TIOEQDKtNLpTdg/+wRVLXxEoZT9gnEWZ9+RHFEaHur7acJGCvelDEdTSKo
	fEQEX4gcwxkYzkENgW3EFVt4p+wCQEZTmJp4rr6G81z2RkNJXXrUB5qXJYYbiix8UtesLy00+MZ
	wUUU2pxRO0LpqJjw0IIlocOnnKuVb5cPaNEtHfzhqVpWjiSPFaAb83xnKxju5ib4MvfA/Lxu10/
	5dd+9np80pAYsLlG965brIzwt7JSBcWMzFMQorCwIR86tnCw6+1af6hna0tKcZ4pmoOYU7jdQqi
	Fw6d2nTDTRKJlrnui3jW+VTpNCYPoL5ibDLvlONla9svOZvtVUcO40tNQbhtoEtt0FCVLroJ3xB
	bttfOJ0/z89emumvuRF4RiBL88LAkCtqs86KfQB1+3nfj8oJNxWDaoyC6iU3GmXNqvt4S94Ibav
	x9JQ4uJaZ14Lkq1RuI7SCfgk+JBDz7ZYgOnC6Bj6XVuxrxY37n8ozIHHYsZicc5/7PJqO8zCpFB
	N6r1TSYyD7L5AAtfXe2didjVrC86O8h8rpDB3XA668P4hdD8n/TYK8WscKKDdODPy5TbUNRCu1B
	W/evNCt1Y/xeOduBP+ZHI5qRf7LC8xUurc8XfWw=
X-Received: by 2002:ad4:5fc7:0:b0:917:8aaf:bb9a with SMTP id 6a1803df08f44-917c0087891mr4797716d6.22.1790877308033;
        Thu, 01 Oct 2026 10:55:08 -0700 (PDT)
Received: from i4-gl-tmk5904-1.ad.psu.edu ([130.203.156.90])
        by smtp.gmail.com with ESMTPSA id 6a1803df08f44-917a8a22f96sm32077796d6.32.2026.10.01.10.55.06
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 01 Oct 2026 10:55:07 -0700 (PDT)
From: Myeonghun Pak <mhun512@gmail.com>
To: Vikash Garodia <vikash.garodia@oss.qualcomm.com>,
	Dikshita Agarwal <dikshita.agarwal@oss.qualcomm.com>
Cc: mhun512@gmail.com,
	Bryan O'Donoghue <bod@kernel.org>,
	Mauro Carvalho Chehab <mchehab@kernel.org>,
	linux-media@vger.kernel.org,
	linux-arm-msm@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	Sashiko <sashiko-bot@kernel.org>,
	stable@vger.kernel.org,
	Ijae Kim <ae878000@gmail.com>
Subject: [PATCH v4 1/2] media: venus: hfi: disable IRQ before freeing HFI device
Date: Thu,  1 Oct 2026 13:55:01 -0400
Message-ID: <20261001175502.4045853-2-mhun512@gmail.com>
X-Mailer: git-send-email 2.53.0
In-Reply-To: <20261001175502.4045853-1-mhun512@gmail.com>
References: <20260925191653.3144006-1-mhun512@gmail.com>
 <20261001175502.4045853-1-mhun512@gmail.com>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

venus_hfi_destroy() releases the interface queues and frees hdev before
calling disable_irq(). An IRQ handler that has already read core->priv
can continue to access hdev and its queues after they are freed. Clearing
core->priv does not revoke the handler's local pointer.

Commit 640803003cd9 ("media: venus: hfi: explicitly release IRQ during
teardown") added disable_irq(), but placed it after kfree(hdev), too late
to protect a handler already using hdev.

Disable the IRQ first so that both the hard IRQ and threaded handler have
completed before clearing core->priv or releasing hdev.

Fixes: d96d3f30c0f2 ("[media] media: venus: hfi: add Venus HFI files")
Reported-by: Sashiko <sashiko-bot@kernel.org>
Closes: https://lore.kernel.org/all/20260612103333.5585D1F000E9@smtp.kernel.org/
Cc: stable@vger.kernel.org
Assisted-by: LLM
Co-developed-by: Ijae Kim <ae878000@gmail.com>
Signed-off-by: Ijae Kim <ae878000@gmail.com>
Signed-off-by: Myeonghun Pak <mhun512@gmail.com>
---
 drivers/media/platform/qcom/venus/hfi_venus.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/media/platform/qcom/venus/hfi_venus.c b/drivers/media/platform/qcom/venus/hfi_venus.c
index bd82066bb6e7..e7e4e78a186a 100644
--- a/drivers/media/platform/qcom/venus/hfi_venus.c
+++ b/drivers/media/platform/qcom/venus/hfi_venus.c
@@ -1689,11 +1689,11 @@ void venus_hfi_destroy(struct venus_core *core)
 {
 	struct venus_hfi_device *hdev = to_hfi_priv(core);
 
+	disable_irq(core->irq);
 	core->priv = NULL;
 	venus_interface_queues_release(hdev);
 	mutex_destroy(&hdev->lock);
 	kfree(hdev);
-	disable_irq(core->irq);
 	core->ops = NULL;
 }
 
-- 
2.53.0

