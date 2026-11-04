Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=74.125.82.54
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1793833152;
	b=fp2fw3ViiVTCWJp8gdN6Vt46PyKKjCmfKvaIL/9vipfAT074OECaLY7ocObQcuIiPGZ9
	 KXye+R7f3UCTGVPV0vVatOlj7CZCnXpiS5s4vP3d37Li9ttZGYxMxLB/DJnnwpfE9l22L
	 cYuGSoqPoIASRWT/zPWNxpiVx1aTbYHVoKmmyJQJXpNUBJvBBu9heYuPPjz22zCBMM1lF
	 OKk+Wvz/KmLfXq/pS/AmkEmshX77bgXyS5px/g36MOk+W2C5HAGT3/hAIUEngb2s0D7oW
	 7kgc/NfWE86LzIVudTHQ+SgOWGJOIXzlMd9eh8K8XuJweW9nlOqoGMdBOeMxQKUzt2g==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1793833152;
	h=DMARC-Filter:Received:DKIM-Signature:X-Google-DKIM-Signature:
	 X-Gm-Message-State:X-Gm-Gg:X-Received:Received:Content-Type:
	 MIME-Version:Content-Transfer-Encoding:Subject:From:To:Cc:Reply-To:
	 Date:Message-ID;
	bh=oXP7nEwO1wAcRxLsxDe5G6mWoIhFZ0z8cXo110/ekCA=;
	b=pBGiXAmA/V7AO98XThmahiEj/jwJ+qHIislyQrikoLROuSId7w/lGpPRB970nTBG5oJx
	 h0r4Lc32SyA0FI1h4cZlpHnp7OcL74kMrw+VlI0UDgvWhy9RE4X5+DMdJK2Uz/aSDWxBQ
	 KTc7zZBAYwokw4pxS8ec8OUE9UVZElW6KfJvnKCMK1Ix7MeRH5onrhI1+PKAdxll3dga5
	 WRtYwKSIzxn/+69/LFUf/cf8i51MGjw4ecDi4EaYsIHzJDwFZ9t6fdCZERFZT0i01TwgR
	 n9pRs1sAfZ47EeYJiDwEQGX17V+mxtqR3AfjF9LC0QxuqvO0ehwoFEY6ia1tc8JB+CA==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=kernelci.org;
	spf=pass smtp.mailfrom=kernelci.org;
	dkim=pass header.d=kernelci.org header.i=@kernelci.org header.a=rsa-sha256 header.s=google header.b=evHs+6wf;
	arc=none smtp.remote-ip=74.125.82.54
Received: from mail-dl1-f54.google.com (mail-dl1-f54.google.com [74.125.82.54])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 47D60606A31B
	for <stable@vger.kernel.org>; Wed,  4 Nov 2026 22:59:12 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 47D60606A31B
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=kernelci.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=kernelci.org
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=kernelci.org header.i=@kernelci.org header.a=rsa-sha256 header.s=google header.b=evHs+6wf
Received: by mail-dl1-f54.google.com with SMTP id a92af1059eb24-1a2af4c8d00so2767078c88.0
        for <stable@vger.kernel.org>; Wed, 04 Nov 2026 14:59:12 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=kernelci.org; s=google; t=1793833151; x=1794437951; darn=vger.kernel.org;
        h=message-id:date:reply-to:cc:to:from:subject
         :content-transfer-encoding:mime-version:content-type:from:to:cc
         :subject:date:message-id:reply-to:content-type;
        bh=oXP7nEwO1wAcRxLsxDe5G6mWoIhFZ0z8cXo110/ekCA=;
        b=evHs+6wfs26veKQ6/ZoJPI4xPOhQ+vlxI5Wmr3lSczhXYUoGcW3xsW7rrD+J3K1sRU
         9ZQO+5CApEE9lpyyEXyA/8cvMPfHsiarugSZP8b7gYTELUxJMRHayUYnq9uiMO+0lN8j
         B4offnXn/2X5KFBS6YoBWsk/ftkP61DQfQWbplRIdXNx1Vla3k4o1lmoWAaHAVAIH6p3
         uQdEgtXLhnZnG/ZizMWbHstpKUKye3e1ldXV2Nrc0bziZHtGpfbbky5nHjNDAYi6uG/q
         TDo+47EzFln6HXZ0ej9/rDTVwgMIZCvdWJeoPNQekbapZJQffJ3IAjyD/83W7zZBNsho
         bq7Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1793833151; x=1794437951;
        h=message-id:date:reply-to:cc:to:from:subject
         :content-transfer-encoding:mime-version:content-type:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=oXP7nEwO1wAcRxLsxDe5G6mWoIhFZ0z8cXo110/ekCA=;
        b=pluwOffWQGEpmiau1uMKEyxYuKYGcRejGq5ZflVGYK9pfUKnR2u13cEeyOA0ngZTjF
         pbtFEd1g/iS2ICFn79XoeWbvI31mv++6/v54scgulzm2XQCZHHXhagB8o4ZOK2MwzbmN
         3OjRe2R6dvWVB01iGI2IRjNDhTjCeMXc51aH9TrgE5T2wnJr/tTMZXiHPcJ6DekCOH+l
         FpNH0louvvcQcmtYnVp34Mwn3tdOAsas+VnigssQktiHzImM9Cd0uP2Y+HR39pCv0CBO
         4gT8PGFENL02oEgCHRAAON39WlgN+6JPJNICbw8UDqep/JfkDPuqmLArqZgnwUBQ5J7B
         Dx1g==
X-Gm-Message-State: APuU4Z+RNBWa8RKRrDH4WuptAIrfSAMn0g182kZeZhr+fpWYJVzhM7ep
	cYe/VQhmTh83Fedvb3e8ASrlQTEadSvcw082m4iz31BNmWM88o8jfUXGF48kXyvWqtJyr4QVll/
	n+C4l
X-Gm-Gg: AYBFou1z+HAwJpvAxOlBbH1FVKLAbvBICuh6OtLISF2K3pMK2vMOsh1ospkid+h7hFN
	kdEfkH5j0LQRJZOzrmGP4Cfh68sMUNt4a5yBoFnhAZKhxc8K0lBkS0lZhp1dF+KfAnYdZ9OLCSM
	JEbsWXdDWL3Q+1VT3Gq2jR0vOh8OTmojxSFpAE/Y+R6776PaRU1KbGSmcl8orrLIdD4Yg1aH3B4
	KI7NrXnRUt+MjLBTfSvGjUWQZpNrw+KAIiv1OGQFggpPoK1/VJ6vLddHa2lpGMDj9nfp/zbdmXl
	gfMtqYmq+kl8oiNvlAK7tyz1yPiHCLUcAkpRbSvU07iDoZ7ctkdKDboyM6n2AlTCUqwmYkDuNzt
	WfxlOr71Zqy9HwlVVNr1GwbztWG+3cLy2INB1caa0js8ytHfJUUnVrQDwSW6siNhGo3N7zeSgpp
	BxJ56Q4aIH63zNOOUujIvsa8oY0eCvC5Gohh1wJJA0vYfmH6e0W+jQBhPVJUS1MfSl7XH4B9ng6
	G7vdamu1MZUpaIhoRp86pAEoZxsIdfdngF2tAIAhRsWryEwOd978m9CpnNKEvoJdgrRx0j5CDD1
	25kPSF2C3JcjUS3DxEdxhx1yd8RpmT3EUqOzYRvRTbQ=
X-Received: by 2002:a05:7022:f903:b0:13b:2f26:6881 with SMTP id a92af1059eb24-1ac55f2d154mr26396875c88.4.1793833151133;
        Wed, 04 Nov 2026 14:59:11 -0800 (PST)
Received: from 34406640b1f4 ([20.38.40.137])
        by smtp.gmail.com with ESMTPSA id a92af1059eb24-1b245c1c127sm10764355c88.6.2026.11.04.14.59.10
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 04 Nov 2026 14:59:10 -0800 (PST)
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
Subject: 
 =?utf-8?b?W1JFR1JFU1NJT05dIHN0YWJsZS1yYy9saW51eC02LjEueTogKGJ1aWxkKWltcGxp?=
 =?utf-8?b?Y2l0IGRlY2xhcmF0aW9uIG9mIGZ1bmN0aW9uIOKAmGh1Z2VfcGFnZV9tYXNrX2Fs?=
 =?utf-8?b?aWdu4oCZOyBkaWQgeW91IG1lLi4u?=
From: KernelCI bot <bot@kernelci.org>
To: kernelci-results@groups.io
Cc: stable@vger.kernel.org
Reply-To: kernelci@lists.linux.dev
Date: Wed, 04 Nov 2026 22:59:10 -0000
Message-ID: <179383315016.333747.12031097040366202746@kernelci.org>

New build issue found on stable-rc/linux-6.1.y:

---
implicit declaration of function ‘huge_page_mask_align’; did you mean ‘huge_page_mask’? [-Wimplicit-function-declaration] in arch/arm/mm/mmap.o (arch/arm/mm/mmap.c) [logspec:kbuild,kbuild.compiler.error]
---

Log excerpt:
=====================================================
/tmp/kci/linux/arch/arm/mm/mmap.c:77:35: error: implicit declaration of function ‘huge_page_mask_align’; did you mean ‘huge_page_mask’? [-Wimplicit-function-declaration]
   77 |                 info.align_mask = huge_page_mask_align(filp);
      |                                   ^~~~~~~~~~~~~~~~~~~~
      |                                   huge_page_mask

=====================================================

When fixing this issue, please attribute this report according to the
patch submission rules:

Reported-by: kernelci.org bot <bot@kernelci.org>

For complete logs and details about the environment used, see the issue
on the KernelCI dashboard:

- dashboard: https://d.kernelci.org/i/maestro:4de1a0f513d0d2bdfbefe3b4f820fc3bcca6f8e8
- giturl: https://git.kernel.org/pub/scm/linux/kernel/git/stable/linux-stable-rc.git
- commit HEAD:  5444176e86225bbe9484411fcdeb5812a7588dab

# Builds where the incident occurred:

## imx_v6_v7_defconfig on (arm):
- compiler: gcc-14
- config: None
- dashboard: https://d.kernelci.org/build/maestro:6aebb1155b429d354eef1a4d

## multi_v5_defconfig on (arm):
- compiler: gcc-14
- config: None
- dashboard: https://d.kernelci.org/build/maestro:6aebb1fb5b429d354eef1dbc

## multi_v7_defconfig on (arm):
- compiler: gcc-14
- config: None
- dashboard: https://d.kernelci.org/build/maestro:6aebb1075b429d354eef1a3c

## multi_v7_defconfig on (arm):
- compiler: gcc-15
- config: None
- dashboard: https://d.kernelci.org/build/maestro:6aebb04c5b429d354eeefa1b

## multi_v7_defconfig+kselftest on (arm):
- compiler: gcc-14
- config: None
- dashboard: https://d.kernelci.org/build/maestro:6aebb05a5b429d354eeefa29

## multi_v7_defconfig+netdev+nfs-root-boot+ltp+crypto+ima on (arm):
- compiler: gcc-15
- config: None
- dashboard: https://d.kernelci.org/build/maestro:6aebb0505b429d354eeefa1f

## vexpress_defconfig on (arm):
- compiler: gcc-14
- config: None
- dashboard: https://d.kernelci.org/build/maestro:6aebb1275b429d354eef1aa8

#kernelci issue maestro:4de1a0f513d0d2bdfbefe3b4f820fc3bcca6f8e8

--
This is an experimental report format. Please send feedback in!
Talk to us at kernelci@lists.linux.dev

Made with love by the KernelCI team - https://kernelci.org
