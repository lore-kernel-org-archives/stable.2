Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=74.125.82.48
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1794067148;
	b=4uNIGIroC9dzPYHNjecnVEPhKS8IN6KIeIxw6GJsA3FDDDZFORvDhhZEZg8BrZyiTuBV
	 BWMQB9DMBnSKORdvu7/F7wS+UEj7lA/gWZiD1bz4gFjEWbhdzj+tFqdZ9KRUAe7Hb3OL/
	 hFcXSFRblG0T+KpDtF4zlbXe7kKB921wyLI7I7ehZL8e20zuqCVeSY6kPbbRcquawWamz
	 8brH0aePQQKR1T0uXwoA7lLKjmd33lbeTpdpZtTEF3V8ra4wBRSXq+YW2g9CmzI9aLTUE
	 vvLgDmgZsduOyOX5zGUDZabyXjAjhoWl+4SyrMr2qiwtBBdWSZ8dESRizaAFgbZZJFQ==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1794067148;
	h=DMARC-Filter:Received:DKIM-Signature:X-Google-DKIM-Signature:
	 X-Gm-Message-State:X-Gm-Gg:X-Received:Received:Content-Type:
	 MIME-Version:Content-Transfer-Encoding:Subject:From:To:Cc:Reply-To:
	 Date:Message-ID;
	bh=HmF5aQCEoGAo5IV9jjianFx5IUHYA5kIpPSWwR16ud8=;
	b=NReTz7wHMd49K0LmCVwbtvoWnRcV/mTRauyPcxZc75jUqw/x7F+x+an89+2FLb5+7w2c
	 Ss74XajkCDk78xaFgLLHzS88hmDABPQKkt/mMYbfoa3vunbX4UlAl9MLfnc+0VKfUWA3z
	 oaCIVHnzHqGiFTZCG6M9SerILHH1ZmEo8/YSp4AjgDMy3JkXcpxWwEGK4aPWZHBV1zRu1
	 3btCvc5aBfqDxmkEvtF++x5ChiD4OBdQIBoVFWdK5cCPovuyXRRlyDRYtW7sJ2RmCeq5H
	 Y+TAC56sNlVlgZa3ykL2p0AK0gEhK3E+RN5etpv2czEsEX11QWpYRAfcri2RFt255Tw==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=kernelci.org;
	spf=pass smtp.mailfrom=kernelci.org;
	dkim=pass header.d=kernelci.org header.i=@kernelci.org header.a=rsa-sha256 header.s=google header.b=iD69AaO0;
	arc=none smtp.remote-ip=74.125.82.48
Received: from mail-dl1-f48.google.com (mail-dl1-f48.google.com [74.125.82.48])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 51C98606A326
	for <stable@vger.kernel.org>; Sat,  7 Nov 2026 15:59:08 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 51C98606A326
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=kernelci.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=kernelci.org
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernelci.org header.i=@kernelci.org header.a=rsa-sha256 header.s=google header.b=iD69AaO0
Received: by mail-dl1-f48.google.com with SMTP id a92af1059eb24-1a3c08d6928so2843082c88.0
        for <stable@vger.kernel.org>; Sat, 07 Nov 2026 07:59:08 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=kernelci.org; s=google; t=1794067147; x=1794671947; darn=vger.kernel.org;
        h=message-id:date:reply-to:cc:to:from:subject
         :content-transfer-encoding:mime-version:content-type:from:to:cc
         :subject:date:message-id:reply-to:content-type;
        bh=HmF5aQCEoGAo5IV9jjianFx5IUHYA5kIpPSWwR16ud8=;
        b=iD69AaO0lDdinSZzU+hQlosXHHLSuxBueuFpN75uLQkAj7aMdFR9fHyd4+A9AI0u+X
         F7DifDW47uJ+SfeCr9cfdOAAJoIJgnyijuguE8Y8rB4UM9x404rXikZdmGcgunRItWuv
         JgWG0YU6jKw2kvOA7j6QJoevOf+abOyUEiRbVnUydPoV3aFcpE5EOBCr8Et9T/HIrvkC
         Bqi8Hu4rViTmoYhQgt9nFErUnbnubj+uHc/7e8vumTHr19GesHWebzwmcOh0LbEQRqfG
         5sTP2RhEb/k1UbiFBdyWi2cm0CVd/ifirU9ELdn65/7QTx52ptJCrU7XacjBqmTi8tgo
         hXSw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1794067147; x=1794671947;
        h=message-id:date:reply-to:cc:to:from:subject
         :content-transfer-encoding:mime-version:content-type:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=HmF5aQCEoGAo5IV9jjianFx5IUHYA5kIpPSWwR16ud8=;
        b=JINc5iuQnzzTnqFq6CGPErO+HyHG2jUDBBrkuEB4ZNZxAyqUbOKUpOUI40BToKJ4Y/
         8l7i77cG080pe38JCypMde8iaG55yWLjA/xk9pzFzddfJCpjoQUR5tNnjhAFLUKV7Lgw
         2CNDA9+CIkCDonFq6ROf+MaAcr1w8Nxxb8gwBn7JgOHc5hsHq7sA7W/SxcFhLkyLzP8V
         R6z26gBYPQs048SURPreum5XsON8WrAEDZn5uG8aO1EPIjvMGq792YtaRRc7bOnO71hg
         lE58Ry14+X8T5l1Uxp5pAHqEn8558+TcBdipvbJlwhqMfrhLfW7rbNxGDbL5b7xTS3UF
         ipMw==
X-Gm-Message-State: APuU4Z+TLOe3jN14C6DUFJUNSLHYZUsc0qnQLYiraosM2Vaf7vIIdgF+
	dGlVgWCmgg2lUDyxaL4THCvIiS7gj/j9M+4aEBulMIeBvioEbsEkfE+tOdq4mGJMmBoLdmYFDQU
	56BvZ
X-Gm-Gg: AYBFou1xW190kR19ymkQaFQOvgWOH2XgD7cbIO+Fn3LpO9REbYrpybbk2AsC5n6wAtk
	iNQR+lYlOWtYxGFuWJOK7KqY2gazORHSF0htbnm0Su7eZN8ZF5NiEJLlz4/KSHp7xkaYGkcTm5x
	TW2+A17BBuFjkfn7Jmph9/b1y1AOV44CFnvXxLCCyrYsScONyIJtr9PCBascK6P5xIKcyG7w2OQ
	SUe0v8t8bBSKrwjN+/07rFta4OfFrCBvR2sJ3Q1FXNvE+UzZ0IfmZgfJvaFbAhElUAI00J2px75
	LJzdtJSOL+pUR4NMEPLsIjEmpD10X/pZX9eVqFHfjgde7PRLFeV0/Z650OTnrl4r4bnMjg88OFV
	p7JqBAnkeLCfijU2gRkPkzZlqZoHfdX4o9IKqGqbCT/Ym5JcE5KmDpQX9PxZo9t/dKuBMiOp7kB
	oM21cBcTnEJSkcSu3IAYS36hHSogx9axtTMhGWOadVV2gS0oM0qpMAwXOs9C0w2hwhKnyGR5Fk5
	M/22ZLwAM9AUXBuyRlWIfU7jtdb4d86JFx/qrTo36hy/8Cmv+GQk9ojNPFP1RSpvyWoPQUqTipa
	6Amp0MHyRKKPSHJllFmehP5VAodfh4D/sbJPdQ6wqr8=
X-Received: by 2002:a05:7022:f513:b0:149:1b5b:1f25 with SMTP id a92af1059eb24-1b25d31ec18mr6403316c88.15.1794067147306;
        Sat, 07 Nov 2026 07:59:07 -0800 (PST)
Received: from 34406640b1f4 ([20.38.40.137])
        by smtp.gmail.com with ESMTPSA id a92af1059eb24-1b25e40d2d3sm14920280c88.2.2026.11.07.07.59.06
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sat, 07 Nov 2026 07:59:06 -0800 (PST)
Content-Type: text/plain; charset="utf-8"
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
Subject: [REGRESSION] stable-rc/linux-5.10.y: (build)data definition has no
 type or
 storage class in drivers/gpio/gpio-v...
From: KernelCI bot <bot@kernelci.org>
To: kernelci-results@groups.io
Cc: stable@vger.kernel.org
Reply-To: kernelci@lists.linux.dev
Date: Sat, 07 Nov 2026 15:59:06 -0000
Message-ID: <179406714587.479450.17408394661904427407@kernelci.org>

New build issue found on stable-rc/linux-5.10.y:

---
data definition has no type or storage class in drivers/gpio/gpio-vf610.o (drivers/gpio/gpio-vf610.c) [logspec:kbuild,kbuild.compiler.warning]
---

Log excerpt:
=====================================================
/tmp/kci/linux/drivers/gpio/gpio-vf610.c:73:1: warning: data definition has no type or storage class
   73 | MODULE_DEVICE_TABLE(of, vf610_gpio_dt_ids);
      | ^~~~~~~~~~~~~~~~~~~
/tmp/kci/linux/drivers/gpio/gpio-vf610.c:73:1: error: type defaults to ‘int’ in declaration of ‘MODULE_DEVICE_TABLE’ [-Werror=implicit-int]
/tmp/kci/linux/drivers/gpio/gpio-vf610.c:73:1: warning: parameter names (without types) in function declaration [-Wdeclaration-missing-parameter-type]
cc1: some warnings being treated as errors

=====================================================

When fixing this issue, please attribute this report according to the
patch submission rules:

Reported-by: kernelci.org bot <bot@kernelci.org>

For complete logs and details about the environment used, see the issue
on the KernelCI dashboard:

- dashboard: https://d.kernelci.org/i/maestro:d4af565c38629b35a3a8f40c21e24b237a5ac3a4
- giturl: https://git.kernel.org/pub/scm/linux/kernel/git/stable/linux-stable-rc.git
- commit HEAD:  7a87f3505170e2196b67ec5e2713c06767ef1601

# Builds where the incident occurred:

## imx_v6_v7_defconfig on (arm):
- compiler: gcc-14
- config: None
- dashboard: https://d.kernelci.org/build/maestro:6aef38e05b429d354e114f02

#kernelci issue maestro:d4af565c38629b35a3a8f40c21e24b237a5ac3a4

--
This is an experimental report format. Please send feedback in!
Talk to us at kernelci@lists.linux.dev

Made with love by the KernelCI team - https://kernelci.org
