Received: from mail-wm1-f42.google.com (mail-wm1-f42.google.com [209.85.128.42])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1BAAF3491E1
	for <stable@vger.kernel.org>; Mon, 13 Jul 2026 17:30:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.42
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1783963848; cv=none; b=mqBD/Aw2jk1E0dmo05ON6NGFGiBDr/impR/UaxdLPyPixx97kSGl2+dEBHD2yfjuKoEPN+6EFfrbcHoWpvQuo+HdtMiMUtC8hUiOUbofnf+05+xrCSfOIjUDzuZCF/YL+KzNuHOn1GD0mwtZ1IoUHreCgNNULtxrGEPZc4yXew0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1783963848; c=relaxed/simple;
	bh=1die7bI0OcCIcn1bppUSBazJU6X5SGKun1KXOThfxSQ=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=Gta8B6KrtferRPIRng7Np9rv+3cawv13MpEKauLb4seG0Jvmnpg127flbd1rgISfpwtXMDuzyIJAc/3dwBWW8evQww1y7jyvgRUTl8L5bFxMrC6WqReMfNPeuwnLfjX1bzzHIiS/h4Ae3ZcAlWxI8ae0KZiQR2i1OviwQMNQu08=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=0sec.ai; spf=pass smtp.mailfrom=0sec.ai; dkim=temperror (0-bit key) header.d=0sec.ai header.i=@0sec.ai header.b=PXUAqGMG; arc=none smtp.client-ip=209.85.128.42
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=0sec.ai
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=0sec.ai
Authentication-Results: smtp.subspace.kernel.org;
	dkim=temperror (0-bit key) header.d=0sec.ai header.i=@0sec.ai header.b="PXUAqGMG"
Received: by mail-wm1-f42.google.com with SMTP id 5b1f17b1804b1-493c52cde9eso30584705e9.3
        for <stable@vger.kernel.org>; Mon, 13 Jul 2026 10:30:36 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=0sec.ai; s=google; t=1783963835; x=1784568635; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=bhFRmtEAl63b5XEQYkBemzUeown6Ez5I0lj5DtalopQ=;
        b=PXUAqGMGt9VdATqyXceiAh1SejsxG5hJ3b/DFrxKlOMynHIb7j1rxTZudsGZu6laFG
         kTZRi1Ml3G7gDQXTgrjfd1oN+qZZBew6/oQSx+HuPI9tzzZ8eEtGJthJNn5yyZRbqefK
         3nFkELcDsNxCOVAsDf4Er8Lx5trgNdtRM/+ZY419GOnhlbOVunb+itoM4Cwvhk4R2XtM
         AAhDllS39/XpSku1k44zwf5qnP5+V79OJYzqTokB41U75PcEYq4WYD2q8pVYR92fz5pD
         a6uTw7Vx+NkqjXk/tKcDqKqXdlL9MK+TJ5+TRcUG8OQipWT5o10Pm5878M0gVh0HttiB
         A+ZA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1783963835; x=1784568635;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to:content-type;
        bh=bhFRmtEAl63b5XEQYkBemzUeown6Ez5I0lj5DtalopQ=;
        b=oVb2mPmxH+RjELKPhtd1OQMyPGyzn4Ze+MkjHSAH+dj/7O5qzeGaLL5gyr92L0nuNT
         awTfLtxu7HWgILUAWyqwMnsIRhITCDqGy+fizWRhn2zU4+OFj8/E1Vcm7Kcg+I5RDYyD
         OasVdNzqu/LF4hvW+LhCjuxFZv411ocqJtRik3ICsGPhYwLsTrjNa/N/Zn5tw5NWIltO
         tT0shZFYw4ITk3CV1O2VKAQSVqvX+sCcUpEPCeMhbhyBo2stSP6a5YgLyvR84jFjrKU6
         wgRbpVuES9wj6cjpE7ERI0K3KKe4vVmRUy0xwb5RjKkHUxcJY6ZQRlQnC44omeuJlujs
         1h/g==
X-Forwarded-Encrypted: i=1; AHgh+Rq/fd6ZMP1HT7shKPP+xI/1oe9isVfsopemIt3hEgfjv6q5Gu/YYlDwbPPvOJxSfxXDu1cyhD8=@vger.kernel.org
X-Gm-Message-State: AOJu0YyWs1hobOJ4PM2DaVPf+sMeBauKUv7x4Q6Z7zKUoO+bGO7qGTU1
	Z8AAldhWuls+wdLO4aLTS1w7zaiLMoXjViUc6g+1XaWcH/ffTvc6bKPmuqCueDsTMC85
X-Gm-Gg: AfdE7clNKGhgX8rd5j5iLlBdlag305IzwfoqsEhw5GgITn4C6xLsJEDrxRKKKXqLP3O
	Wcfr0J8e5AXkBIFOdkWfvcIGfrcK2LDURnfooqP8JMHG9LlPbeqU5gUSS0zBHS/Z+xJYZT7exq4
	QjD6rsfIDUwrt9SNb+YLIREBp44rWopDbrI3y1kR85z8QEgsz0n3pW2U4AMOnIrwfM3OjsqQjYS
	mDNmhapazV22hCMnSemll3yjVV5oFRum9K2Cg9QS03Nbcac/lThfuehvuqn2QfJMyedzpRv3swl
	YHnvqAmCqU9ellY8I51VggxVBW+PnHUgA2dn5yTkanOLINfDuAXfjhpg34hK7XVMPZFsrws9zAD
	76Z5h6TN4TwbQTllrZCbe/OBc0eCgraJhq2IlxQ2PfQb+k4xvLA/ik1PGtl5AY/xpOHhnhhTwPN
	dBuq3bmXlJP3TLg+UkELLFXpne3/9g2P28lwXYDcIdSOdMA/pVQUsB2DbgGoQhujr7IxF/v2K9B
	QyiFg71/vhso/wZfH4QHJ/EDezxZ1QMYzAajQroHiEBLg==
X-Received: by 2002:a05:600c:8718:b0:493:c1a1:68f0 with SMTP id 5b1f17b1804b1-493f881f0f1mr96584005e9.20.1783963834676;
        Mon, 13 Jul 2026 10:30:34 -0700 (PDT)
Received: from PeakBook-Mini.tail8e484.ts.net ([178.197.218.188])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-493f3a60404sm260075855e9.1.2026.07.13.10.30.33
        (version=TLS1_3 cipher=TLS_CHACHA20_POLY1305_SHA256 bits=256/256);
        Mon, 13 Jul 2026 10:30:34 -0700 (PDT)
From: Doruk Tan Ozturk <doruk@0sec.ai>
To: Min Ma <mamin506@gmail.com>,
	Lizhi Hou <lizhi.hou@amd.com>,
	Oded Gabbay <ogabbay@kernel.org>
Cc: dri-devel@lists.freedesktop.org,
	linux-kernel@vger.kernel.org,
	Doruk Tan Ozturk <doruk@0sec.ai>,
	stable@vger.kernel.org
Subject: [PATCH 2/2] accel/amdxdna: reject command submission on devices without a submit op
Date: Mon, 13 Jul 2026 19:30:29 +0200
Message-ID: <20260713173030.87541-3-doruk@0sec.ai>
X-Mailer: git-send-email 2.53.0
In-Reply-To: <20260713173030.87541-1-doruk@0sec.ai>
References: <20260713173030.87541-1-doruk@0sec.ai>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

amdxdna_cmd_submit() calls xdna->dev_info->ops->cmd_submit()
unconditionally, but only aie2_dev_ops defines that callback.
aie4_vf_ops (the AIE4 SR-IOV virtual function) does not, so a user
AMDXDNA_EXEC_CMD ioctl on an AIE4 device reaches a NULL function-pointer
call and oopses the kernel. AIE4 submits work through a mapped user queue
and doorbell, not this ioctl path.

Reject the submission early with -EOPNOTSUPP when the device provides no
cmd_submit op, so the shared EXEC ioctl is a clean no-op on such devices.

Fixes: aac243092b70 ("accel/amdxdna: Add command execution")
Cc: stable@vger.kernel.org
Found by 0sec automated security-research tooling (https://0sec.ai).
Assisted-by: 0sec:claude-opus-4-8
Signed-off-by: Doruk Tan Ozturk <doruk@0sec.ai>
---
 drivers/accel/amdxdna/amdxdna_ctx.c | 4 ++++
 1 file changed, 4 insertions(+)

diff --git a/drivers/accel/amdxdna/amdxdna_ctx.c b/drivers/accel/amdxdna/amdxdna_ctx.c
index a5c8c2c4de6d..bdbd3db12a6c 100644
--- a/drivers/accel/amdxdna/amdxdna_ctx.c
+++ b/drivers/accel/amdxdna/amdxdna_ctx.c
@@ -590,6 +590,10 @@ int amdxdna_cmd_submit(struct amdxdna_client *client,
 	int ret, idx;
 
 	XDNA_DBG(xdna, "Command BO hdl %d, Arg BO count %d", cmd_bo_hdl, arg_bo_cnt);
+
+	if (!xdna->dev_info->ops->cmd_submit)
+		return -EOPNOTSUPP;
+
 	job = kzalloc_flex(*job, bos, arg_bo_cnt);
 	if (!job)
 		return -ENOMEM;
-- 
2.43.0

