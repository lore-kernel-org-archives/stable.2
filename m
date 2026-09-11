Received: from mail-pj1-f44.google.com (mail-pj1-f44.google.com [209.85.216.44])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id AA758367F31
	for <stable@vger.kernel.org>; Fri, 11 Sep 2026 14:59:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.216.44
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1789138769; cv=none; b=iL2NoVr4NLx/6J5uaWRNBLmGiONHuCc26EPTZjGpgAHTHsgNwmRHKkjbqfE7NrXbT4bxtGEbHGMOlEUIqzjxsqKxq33D5/rOHy0T++JUcuUrxjNWjVwxq3njUFS2Znj5Eoyin1mXoceuHft7nsYNnbybDPlvtMm0PsIM8KPZ3Rk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1789138769; c=relaxed/simple;
	bh=y5PDDgbvI8JDIV5c+ixgp0TvLVEig2hfmyI4vNZJveg=;
	h=Content-Type:MIME-Version:Subject:From:To:Cc:Date:Message-ID; b=nsCvsN1Bl7Q9QToztBstlz+VO7CCvMI4YxZ3btQZPEfVX7gQamAhXgEiolxoOcFPNsMr05KlZs6GFQHxFCweottz5i0hK3n8qwqT6S2rxiK9nyEss1ho+GtbjQb9YPO8oY40eVpuuyfKR6s6LulP/pHxFVB7raZchWAWq0RNwkY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=kernelci.org; spf=pass smtp.mailfrom=kernelci.org; dkim=pass (2048-bit key) header.d=kernelci.org header.i=@kernelci.org header.b=RAbLGKxl; arc=none smtp.client-ip=209.85.216.44
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=kernelci.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=kernelci.org
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernelci.org header.i=@kernelci.org header.b="RAbLGKxl"
Received: by mail-pj1-f44.google.com with SMTP id 98e67ed59e1d1-38ea87caafeso992989a91.3
        for <stable@vger.kernel.org>; Fri, 11 Sep 2026 07:59:24 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=kernelci.org; s=google; t=1789138762; x=1789743562; darn=vger.kernel.org;
        h=message-id:date:reply-to:cc:to:from:subject
         :content-transfer-encoding:mime-version:content-type:from:to:cc
         :subject:date:message-id:reply-to:content-type;
        bh=a3BJnV+GuBB/QWN6Xmzk+Ui/xHnWjwZDHhPx+6hkD2g=;
        b=RAbLGKxlXkIcucvfCPeJ8FfOo+PX0hxQsSvpg6MfTnUWFPLyiBvl9agmF7viD8cuox
         4ss85V/HyOCSrfSNaiuVLtefL5AxYajn9BcpNT/A/eBjmNrHbgfzlYmkPmCDEiP5qBou
         uLQeS6PIuc+ZFJagO/YVGG3MKt0gUrLTToTKEuB/JgFsmEX2bh9xiGyys85qOctDrTVF
         wZMSWmgUEzyr3BzI1zk9wsggmNNP+jbAGIKfAcOq+/zhunNmD7aeMBENfnn7UDqDZwGv
         8bnRskpjm+4kho8xwIOVNqyketTpUWQ8r/xTWJyIJNDrUFyMg/BflfzF+eeMcG8/f73O
         gMeQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1789138762; x=1789743562;
        h=message-id:date:reply-to:cc:to:from:subject
         :content-transfer-encoding:mime-version:content-type:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=a3BJnV+GuBB/QWN6Xmzk+Ui/xHnWjwZDHhPx+6hkD2g=;
        b=tIIRH+NGSqNDOUgmFVXWWdg796eAJ5k6GL9NPkuiZ841RaX4sGEeGoI7pZ3/6UhETx
         LMNmrX0bkYJyWlg59lUKhShttnE6cnvH0UqWOLQuMFqTC3TcB5m2qNixfguolXKUzDjf
         R1Baa/phkvn1DCFlfvDZXYne+lA98ZVZeS1wCIUredi2Evx8S3yP5S/kj7AlRbGci3ND
         TwMZsXdAch4bVSxEXr2VkftAKg+lxq62cJaNkFT+TNE9N1JifsmRokz4QASVrV3uY5E4
         6yn2h0wxLWTCaaNqC93bRxK8pn65f5kHxbczw6sSEi0O7ho7Kzm/SB9mT2SB+jEsSy44
         /Z1A==
X-Gm-Message-State: AFuF++mdLsrncKG2wCC9oPDONESC5qgqjx9VxKHjLGp5QtAD21uErjkm
	EI4a1OJeuzE7YuX//FRh/CJQx82VWrGGxNYhq0hwu4J/uz/wq+Q+y3up+C8eJCEjVsJXt6d/3C6
	LSGQY
X-Gm-Gg: AYBFou0kxtTnXXUBWgFU8KbWs7eiQO6S80bJtRjQhWLcZMKCKmGFVpLdak3/zoM2UGe
	zEvP2gNOagPOd+auMJpdTcZCb1gU81MvbpORa5CHqF22DObDLQ2P9jwjE+sysF0doClRuCF3M6F
	Lbhf+r6zO4cTbob04vmLdBK37dwy7Z1NAYzvoK8eg9LcwES3Tj9E2wZHz9B+4q4phMFVskgxf8R
	UbSsMSGArv8a21ApdXLX91q2lBZ4zutBbG5lGQzlOtyVAq1OTZv6TmoDcZVKZ14oR8fffPfyfPs
	pgruFh2pgW2r5HWnFGhyzb0zrDntS4J6a/WWU+qNdg1zp5xO71kZtAT590Bw5MGPChElxDt2Kwl
	EyiohyzYt4elFppz6g1PfDzPRjywYnkHyK8qkyPMS1CXMnFdEFi7vPxCBtnA2/vQ+4PtnKutP5b
	eaMKGHerybylkiUTNBwopiadqp5Kacf3iwt7KLPDTwcu8iZGAGIbjKE/GMZEYFdkCw8iYR7fINq
	g==
X-Received: by 2002:a17:90b:4a8b:b0:38f:240d:b857 with SMTP id 98e67ed59e1d1-39d9bbc81cfmr7254073a91.2.1789138762230;
        Fri, 11 Sep 2026 07:59:22 -0700 (PDT)
Received: from 41049dfc76e5 ([20.38.40.137])
        by smtp.gmail.com with ESMTPSA id a92af1059eb24-14365b97994sm13326360c88.12.2026.09.11.07.59.21
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 11 Sep 2026 07:59:21 -0700 (PDT)
Content-Type: text/plain; charset="utf-8"
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Subject: [REGRESSION] stable-rc/linux-6.1.y: (build)Error in fs/ext4/bitmap
 (arm-linux-gnueabihf-ld) [logspec:kbuild,kb...
From: KernelCI bot <bot@kernelci.org>
To: kernelci-results@groups.io
Cc: stable@vger.kernel.org
Reply-To: kernelci@lists.linux.dev
Date: Fri, 11 Sep 2026 14:59:21 -0000
Message-ID: <178913876125.4387.4550791845141337702@kernelci.org>

New build issue found on stable-rc/linux-6.1.y:

---
Error in fs/ext4/bitmap (arm-linux-gnueabihf-ld) [logspec:kbuild,kbuild.compiler.linker_error]
---

Log excerpt:
=====================================================
arm-linux-gnueabihf-ld: fs/ext4/bitmap.o: in function `ext4_chksum':
/tmp/kci/linux/fs/ext4/ext4.h:2466:(.text+0x48): undefined reference to `crc32c'
arm-linux-gnueabihf-ld: /tmp/kci/linux/fs/ext4/ext4.h:2466:(.text+0x98): undefined reference to `crc32c'
arm-linux-gnueabihf-ld: /tmp/kci/linux/fs/ext4/ext4.h:2466:(.text+0xec): undefined reference to `crc32c'
arm-linux-gnueabihf-ld: /tmp/kci/linux/fs/ext4/ext4.h:2466:(.text+0x140): undefined reference to `crc32c'
arm-linux-gnueabihf-ld: fs/ext4/extents.o: in function `ext4_chksum':
/tmp/kci/linux/fs/ext4/ext4.h:2466:(.text+0x258): undefined reference to `crc32c'
arm-linux-gnueabihf-ld: fs/ext4/extents.o:/tmp/kci/linux/fs/ext4/ext4.h:2466: more undefined references to `crc32c' follow

=====================================================

When fixing this issue, please attribute this report according to the
patch submission rules:

Reported-by: kernelci.org bot <bot@kernelci.org>

For complete logs and details about the environment used, see the issue
on the KernelCI dashboard:

- dashboard: https://d.kernelci.org/i/maestro:f4bc30d8e5f6b517dfd5386d8b9a25bade392079
- giturl: https://git.kernel.org/pub/scm/linux/kernel/git/stable/linux-stable-rc.git
- commit HEAD:  9f5e4631f281f1f3c92f33dcb2dc004f416196a0

# Builds where the incident occurred:

## defconfig+arm64-chromebook+kcidebug+kcidebug-arm64+lab-setup on (arm64):
- compiler: gcc-14
- config: None
- dashboard: https://d.kernelci.org/build/maestro:6aa40c5320239ade90229f8e

## defconfig+lab-setup+arm64-chromebook+CONFIG_MODULE_COMPRESS=n+CONFIG_MODULE_COMPRESS_NONE=y on (arm64):
- compiler: gcc-14
- config: https://files.kernelci.org/kbuild-gcc-14-arm64-chromebook-6aa40bef20239ade90229d8e/.config
- dashboard: https://d.kernelci.org/build/maestro:6aa40bef20239ade90229d8e

## vexpress_defconfig on (arm):
- compiler: gcc-14
- config: None
- dashboard: https://d.kernelci.org/build/maestro:6aa40b8b20239ade902299a9

#kernelci issue maestro:f4bc30d8e5f6b517dfd5386d8b9a25bade392079

--
This is an experimental report format. Please send feedback in!
Talk to us at kernelci@lists.linux.dev

Made with love by the KernelCI team - https://kernelci.org
