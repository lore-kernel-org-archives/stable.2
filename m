Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=209.85.221.49
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1793207348;
	b=5MbieBraZQ6H9dOiYZPAiRBqk8ZGqAOSAPuRPZ7JRg3LeStCwQpcMKFGGrhPqgy3HhmD
	 MoqycNenfeLTh2u2iMOcANnlgDQozTV4QVBtYSVbbw2PICPOw7HgmInt6C/JoM+nRxsqI
	 GjmtdtU4t8w7HluHYZDhFx10hcHphaYaJJ27fT9CDlThXdrXI8pykPZZ3wStJzPEHvQep
	 oTopW2v0ziwkqT9UPQMrmsYTxLQsjEaS5Ay6hjxymHXmEuXHJIwtbM1TJMf5bp0BGjGW8
	 OpnGLU9LB0DTFomoQSp11PwFdFOeRcYXr6skMhphc0J659oK7QFcJVVBSkPeg2Kte5w==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1793207348;
	h=DMARC-Filter:Received:DKIM-Signature:X-Google-DKIM-Signature:
	 X-Forwarded-Encrypted:X-Gm-Message-State:X-Gm-Gg:X-Received:Received:
	 From:To:Cc:Subject:Date:Message-ID:X-Mailer:MIME-Version:
	 Content-Transfer-Encoding;
	bh=O0UDAqKLczseG5vwWb+qcEkII4ga7mybPYBMC/i9NRo=;
	b=hQJOBM/JHV5bAk42N1RtnMOHPMvTMe6oug4MsD1/S5VMWbJDu4fUw7XavoXOD/NbGqvZ
	 WHoZcGC9rgzyLlJRhQ5qi0xxODBHqWBdKvmJh+9jr/fpTJBZj/1LkVOccoy3ZyAxcEXc0
	 gUpWmtFL//bB6vTzHfkJbm0Np6LPQy27HwH+s7b+d1x1sYpfJMYpYM365S8m/WTNhdDo3
	 vgkqd0XpnyUd5nYKwd4k90/G0fTlJttog6rD+OQt+BgLY0Tw6LnyxHwAPAfh+ClxdgXHD
	 vSfuMaTAahnrrwG0RuJRl4vbRHXlL14Py/EvIrJCC2Bn8axHH6ZCZPhZm9dyIou0uRA==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=gmail.com;
	spf=pass smtp.mailfrom=gmail.com;
	dkim=pass header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20260707 header.b=R9kDxjlf;
	arc=none smtp.remote-ip=209.85.221.49
Received: from mail-wr1-f49.google.com (mail-wr1-f49.google.com [209.85.221.49])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A566E606A327
	for <stable@vger.kernel.org>; Wed, 28 Oct 2026 17:09:07 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org A566E606A327
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20260707 header.b=R9kDxjlf
Received: by mail-wr1-f49.google.com with SMTP id ffacd0b85a97d-48e0d1c095dso669430f8f.1
        for <stable@vger.kernel.org>; Wed, 28 Oct 2026 10:09:07 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20260707; t=1793207346; x=1793812146; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to:content-type;
        bh=O0UDAqKLczseG5vwWb+qcEkII4ga7mybPYBMC/i9NRo=;
        b=R9kDxjlfeabjIAx9+fZ+Ftk4ce9PFZEliXk2DS7GHjIEYyta3iN1PbHpEdpzeCTqrs
         RHo5TOba4alpQcNlbsyIng/dYlKgt0O8qk1eGitHEjgpYsVgJCBhyEijtDLucI7jS3gY
         Pk72CP7dxVPxcs+7IZ7yqxB+S9bn8b6u97hLKMClRB85F3wceZXNJswZ3vEkgM3DThl2
         g5fl8DNp4bqopHUhumldknslkfSWAMthLRZlQ+JeKXB3CBgcatUwm3dqbSNXCqQv7MrO
         XZVTAJvKHSW9hW+dr5TXxTBF4Owd8wNvBebOfD+o9v1IMHJRX0pTGu++U4MfWi3tmqGX
         Yi8A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1793207346; x=1793812146;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=O0UDAqKLczseG5vwWb+qcEkII4ga7mybPYBMC/i9NRo=;
        b=GVwI6L+VS1EUAdrvNEm7KRdZf9ajgQcqWzKXFb5s7XkKMyVdEiZkN2mLVm3dl7a4HD
         CLlWx6kNU1K9MCO0jDMFl9Hd/M65Urjd/ZtkxaUzUmP57EhxRwcm4TjwnmRQUcdPlxQM
         /bzm8JMlPw2fKY3drrOgIyANYg8nB6ck8CXvevRsepg1z1xFeA3lQrGf0R4to8qO8VfX
         5/rzJCnlQEPqS3MbRw+dFY10+vhylsVvaKXmO1yQsWyaYj1rF5wwABHileyGsVoUkGoa
         Xp0rK9mbKmcAdtFcnNQH64eRHDLZRhM8WQfp/NT65K4clSAajF1hDQkE3EezfNjABft5
         QCUg==
X-Forwarded-Encrypted: i=1; AKwUvByVoCXZok0uO4f5fWafK/XmjEyaw8bzRlgK7uTzJ/8Wz9X6h5MRlYYkBXcnBxmV7Nren763Stc=@vger.kernel.org
X-Gm-Message-State: AFq9FYIPDiIoRADzejbsI0K6SMxC+pzyIKFy4Md+0ecuF8Fggn6ZcZW/
	ArAY10Uu+gIAQVGKNlANb99TX1630ruhhI7jrQlmBPlU2v0il1wFJ+0=
X-Gm-Gg: AYBFou10VAbIEj26JqS+rB8HKjN0RhXwKItd5AzUa5l8d1wY5CipPGJc9O0jr+U7t3h
	YlVNBAYtkej5yvCivoiB1WCmX8tOytX6L0LRxmKi28hpD54q0mqkDhBTIwKK6Q1Rvng0spV/MxV
	enHNtdGylW9wvfCDdhHncbM9lf16i58xoP55Nafe7+yqfUpC1vMzCEUIhrVFoYSVnYlYSCVD3Vy
	y99gPEQh+xrIWV7EBcFszicjudoCa2coi5EjUEeXIf9hfS9v7WmT77ub5Gdq1dWIW466rpRMtTB
	fNxfhY5FUe/cp1XF3KgkIxZqE9QStHst91SY8/EVK2rTjWWph0grsgDSB4hwf3dQ3CGaL40PyHd
	NlweG7jmaws3rAE+pVIU9Hr+HLTYumTk4co1BqSyheNJnuaN50WCRdcX8j1oUCXEaD9PPcMMMO9
	ugyr3ZuPhmzMaGqDX/TA4FYCgwzncVpPVnYeuLQFGnw5QX4BhqIIf2xihGAMzQ/AadYVdY12pR4
	BmLbjasFH9dm1VGdUYG/VhGNfhQMM9n2afNVMpyZPATiq86KXT0pxw7Juu298pTS5d+450vBQ==
X-Received: by 2002:a05:6000:288b:b0:48d:fbf4:895e with SMTP id ffacd0b85a97d-48e5d2e6cd2mr6765330f8f.11.1793207345780;
        Wed, 28 Oct 2026 10:09:05 -0700 (PDT)
Received: from debian.. ([2001:41d0:303:db6b::])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-48e3ebd4ba7sm29732715f8f.33.2026.10.28.10.09.04
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 28 Oct 2026 10:09:05 -0700 (PDT)
From: Tristan Madani <tristmd@gmail.com>
To: Mauro Carvalho Chehab <mchehab@kernel.org>,
	Hans Verkuil <hverkuil+cisco@kernel.org>
Cc: Steven Toth <stoth@kernellabs.com>,
	linux-media@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	stable@vger.kernel.org,
	tristan@talencesecurity.com
Subject: [PATCH] media: saa7164: cancel workcmd after disabling IRQ in saa7164_finidev
Date: Wed, 28 Oct 2026 17:09:04 +0000
Message-ID: <20261028170904.1183502-1-tristmd@gmail.com>
X-Mailer: git-send-email 2.47.3
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

From: Tristan Madani <tristan@talencesecurity.com>

saa7164_finidev() does not cancel the workcmd work item that the IRQ
handler schedules via schedule_work() for command responses.  If the
work is still pending when the device structure is freed, the work
callback runs on stale memory.

Add cancel_work_sync() for workcmd after free_irq() so the interrupt
source is fully stopped before draining the remaining work.

Fixes: 443c1228d505 ("V4L/DVB (12923): SAA7164: Add support for the NXP SAA7164 silicon")
Cc: stable@vger.kernel.org
Signed-off-by: Tristan Madani <tristan@talencesecurity.com>
---
 drivers/media/pci/saa7164/saa7164-core.c | 2 ++
 1 file changed, 2 insertions(+)

diff --git a/drivers/media/pci/saa7164/saa7164-core.c b/drivers/media/pci/saa7164/saa7164-core.c
index ac5eb6b923e21..8c6dd8dfd9a1e 100644
--- a/drivers/media/pci/saa7164/saa7164-core.c
+++ b/drivers/media/pci/saa7164/saa7164-core.c
@@ -1518,6 +1518,8 @@ static void saa7164_finidev(struct pci_dev *pci_dev)
 	/* unregister stuff */
 	free_irq(pci_dev->irq, dev);
 
+	cancel_work_sync(&dev->workcmd);
+
 	if (dev->msi) {
 		pci_disable_msi(pci_dev);
 		dev->msi = false;
-- 
2.47.3

