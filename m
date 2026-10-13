Received: from mail-dl1-f42.google.com (mail-dl1-f42.google.com [74.125.82.42])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2043952BE53
	for <stable@vger.kernel.org>; Tue, 13 Oct 2026 17:59:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=74.125.82.42
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1791914348; cv=none; b=jXYv2Ox+O1H/DRIxlAK09OW+qkT5isgZenVQzrLoW+NGTbU96wLtSdtppzaFqkodPilEwOhMKDwgjUeqMcqMxbWm5jPuB4cH0aFCM3uhGeevFMKd9bxzXI8eQxoJtpp2Tpb9nGlZDm6nAqB3+4IOsMnLIusWiEok8cfeRDOc9Ao=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1791914348; c=relaxed/simple;
	bh=6pfPbi/Wkd4DhUyqEvpBarmM6KLSGC9efq3aoBxrf04=;
	h=Content-Type:MIME-Version:Subject:From:To:Cc:Date:Message-ID; b=EiAKIEU2BAeIu+AZFDfS3mO0pI9wn1B2xznLAKAtdgpcGqp8Wn9XmfIeCDUvF3sPwapUc0vfO2KSdNnuixIukfPhH1k0iQIUutXSq7bQv/47UlFlaLqDRB+psaU3U2fDBkTwdMIIrmWSeN0PiqRwEul/faZXwvR6E6Fx18EymVY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=kernelci.org; spf=pass smtp.mailfrom=kernelci.org; dkim=pass (2048-bit key) header.d=kernelci.org header.i=@kernelci.org header.b=GEn6o8Jg; arc=none smtp.client-ip=74.125.82.42
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=kernelci.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=kernelci.org
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernelci.org header.i=@kernelci.org header.b="GEn6o8Jg"
Received: by mail-dl1-f42.google.com with SMTP id a92af1059eb24-141395927feso6272821c88.0
        for <stable@vger.kernel.org>; Tue, 13 Oct 2026 10:59:06 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=kernelci.org; s=google; t=1791914346; x=1792519146; darn=vger.kernel.org;
        h=message-id:date:reply-to:cc:to:from:subject
         :content-transfer-encoding:mime-version:content-type:from:to:cc
         :subject:date:message-id:reply-to:content-type;
        bh=UB7YwH9UMo6ocIPwvGQ9Gv6RDNORnP2iRPaKNDxyTzo=;
        b=GEn6o8JgJx/7xH6d+/jWcBzlZVLXBRF4XQzqdS+dFrrP77fTbVBBI6u7Og/pIUeLfG
         1SENSEo+dajwfuP3mFpDgntx24yT+OsVp7xYW1bx7wUc9BmcApM/OiwIvFqlPmvS4WHT
         deJIhDsfQyUTO6w+pigklRXh72ZexV/wMu2XVJg9QLBqTx9YuyOeXoa89fjdKm2dXNt3
         3+XmOF02UUmZQH9YCRbf6VMWlh1GIXLSXc9VG+g7yGe5a8ayS6QRCI/l8zQl8D/7hkp3
         BOz8ANdKOEDSD4YulF6oNE3dK9qTXrCQqZzF7TkkZ1xZajRNDPbJfULzz14OLChRtobz
         Q6HQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1791914346; x=1792519146;
        h=message-id:date:reply-to:cc:to:from:subject
         :content-transfer-encoding:mime-version:content-type:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=UB7YwH9UMo6ocIPwvGQ9Gv6RDNORnP2iRPaKNDxyTzo=;
        b=fEYRwltWTHgaUnNtrCiu/ONjX2ubSBTDW01f1+b5oPz271NAdoBPxMoLZ5NG8ToZUx
         NliX6ryefmITtnP7FNiq16jjq2AClf5QuS7oLTsZy67EjiW1zGZCYP2r1ZH3KQu0yHbw
         iT0uBxEWY5XA0j7D6fhiatoikOt25qM78vhpx56ok5ugml1CluIVXDRG8JP4UoQX2RZY
         xlpu8jHJpIe9Vzsjf1GPj9iHzMJo42eK+VJwDl5uiQQ127JM1k0UfnS3bgrsnkethtqf
         yN6TSW3zI5jEfHLOalM2DfCEJPNM1aofAq6RbNLTY34gdeqt4CRps4arTuIfyVvYnola
         EaYw==
X-Gm-Message-State: AFq9FYKFGBVbepiId85DXsEkbs5oFPwh8GNiU/4herQZx5v2nkrACeK9
	UmBcUxhR7zozUzNKmhMbcK8uM0+12Y826yXxeWXcs9VCi6xlbyVLY1IVioqnPj1728BPmr1XPEB
	tqNze
X-Gm-Gg: AYBFou1/K9dXBKIbJuEEopXkdElotjBOGkz0+g5E+NMD/k8dNB1alc7uPFciSXDLktj
	R3hE4DyWAvJ+wuTFSzlNwiEwNmf+UuCoTKSIMnNrl6i0N6l34bFZFIJcXA8elwmRwOeNoxsuT/3
	5x3lkf7f8LGVBgR9LHX3JeJIUbx0r680ST9ODbcfjs6gN/+PEn+xEJ8ITz8RjbE8rfAvsvqzTcD
	GeuP2f2As4qx0VfgyV2J8iOmSb3aILWPNa8n1tolCqotq8VRgnViJZ7QZZKfSNbwuvK9wLVXPRp
	8b14lIHBIUF9g0gqi8RO7V2JRp3TsF/RaPNB/uTeF5nFSLJpXFMcsUpfyNOLGZLUORJV/Y+IarW
	6uFBM82mNvSLjX3G/+vIp9WZng7nQXAyLQdNtlP0nFqrzFDF66bB/8I9IcBSBe+PafOonIfqG79
	SVmONy2HHYUWlAKYBqD26e3bYWLmZPL2sO4VsM2qHvzyJ/j12mFQU1DY1kDU2SiMM=
X-Received: by 2002:a05:701b:291c:b0:141:4951:f150 with SMTP id a92af1059eb24-16a5ea5d6famr17016087c88.18.1791914345841;
        Tue, 13 Oct 2026 10:59:05 -0700 (PDT)
Received: from 244668f92ec4 ([20.38.40.137])
        by smtp.gmail.com with ESMTPSA id a92af1059eb24-169a567aef5sm39301704c88.19.2026.10.13.10.59.04
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 13 Oct 2026 10:59:04 -0700 (PDT)
Content-Type: text/plain; charset="utf-8"
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Subject: [REGRESSION] stable-rc/linux-5.10.y: (build)implicit declaration of
 function
 'timer_shutdown_sync' [-Werror,-Wi...
From: KernelCI bot <bot@kernelci.org>
To: kernelci-results@groups.io
Cc: stable@vger.kernel.org
Reply-To: kernelci@lists.linux.dev
Date: Tue, 13 Oct 2026 17:59:04 -0000
Message-ID: <179191434384.270170.743076822009670118@kernelci.org>

New build issue found on stable-rc/linux-5.10.y:

---
implicit declaration of function 'timer_shutdown_sync' [-Werror,-Wimplicit-function-declaration] in drivers/usb/gadget/udc/at91_udc.o (drivers/usb/gadget/udc/at91_udc.c) [logspec:kbuild,kbuild.compiler.error]
---

Log excerpt:
=====================================================
/tmp/kci/linux/drivers/usb/gadget/udc/at91_udc.c:1815:2: error: implicit declaration of function 'timer_shutdown_sync' [-Werror,-Wimplicit-function-declaration]
 1815 |         timer_shutdown_sync(&udc->vbus_timer);
      |         ^
1 error generated.

=====================================================

When fixing this issue, please attribute this report according to the
patch submission rules:

Reported-by: kernelci.org bot <bot@kernelci.org>

For complete logs and details about the environment used, see the issue
on the KernelCI dashboard:

- dashboard: https://d.kernelci.org/i/maestro:734fa1707d5c4b4d4521135b415fa88e8118ab9d
- giturl: https://git.kernel.org/pub/scm/linux/kernel/git/stable/linux-stable-rc.git
- commit HEAD:  1757ae41a94814c347aa9db18b08da11b3a7e7be

# Builds where the incident occurred:

## defconfig+allmodconfig+CONFIG_FRAME_WARN=2048 on (arm):
- compiler: clang-21
- config: None
- dashboard: https://d.kernelci.org/build/maestro:6ace24eba3f195e1aa75624f

#kernelci issue maestro:734fa1707d5c4b4d4521135b415fa88e8118ab9d

--
This is an experimental report format. Please send feedback in!
Talk to us at kernelci@lists.linux.dev

Made with love by the KernelCI team - https://kernelci.org
