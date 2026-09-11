Received: from mail-pj2-f12.google.com (mail-pj2-f12.google.com [74.125.227.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 061F44A4990
	for <stable@vger.kernel.org>; Fri, 11 Sep 2026 16:59:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=74.125.227.140
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1789145964; cv=none; b=RmyBD5Li9EOjUOzXL89Zg8r1MftSn/7kug5PYPiepaPY/UYOLV5z34Vmp/3lGbnEKsuoV0+kLYOBoNUmuTnPSLkbKKHNjmVZTRLaPupZpKF3w0bq2kGo8Vpf6HEQhygoqeoUDY8FQ20qWV+96t9eVomVPti1Pesewg5rJATRDLI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1789145964; c=relaxed/simple;
	bh=RhDHroWEwfdQkTmTncMYtLL7HAOerQk5AoJHYAVzRjA=;
	h=Content-Type:MIME-Version:Subject:From:To:Cc:Date:Message-ID; b=gAM7yRpJH+ga1eYG4fGkafAmB76ej3nLOGRA5UTG35laB3LC3Ow9fNU0SMlDYJXGEXDvnjFFHMzB+sGpvRrRi2l+GfWsbr2rwGG6TXi8T56qtBwZDXnc0bzgh2JErx0jxAGE5q8V5R9gnZ7gC5A8w4nCz45ggy6noECTAWAHroI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=kernelci.org; spf=pass smtp.mailfrom=kernelci.org; dkim=pass (2048-bit key) header.d=kernelci.org header.i=@kernelci.org header.b=SiCMZCDl; arc=none smtp.client-ip=74.125.227.140
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=kernelci.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=kernelci.org
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernelci.org header.i=@kernelci.org header.b="SiCMZCDl"
Received: by mail-pj2-f12.google.com with SMTP id 98e67ed59e1d1-396ccafb751so1155484a91.2
        for <stable@vger.kernel.org>; Fri, 11 Sep 2026 09:59:12 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=kernelci.org; s=google; t=1789145950; x=1789750750; darn=vger.kernel.org;
        h=message-id:date:reply-to:cc:to:from:subject
         :content-transfer-encoding:mime-version:content-type:from:to:cc
         :subject:date:message-id:reply-to:content-type;
        bh=VR1VrPzB7g89j5Lob5Tszs4sJli0jSp9tSma6aXfsvE=;
        b=SiCMZCDldnWwYjaffcGbxsc+L/pLZupcYd9HiSR/8BDdkYvq+mHk32VPicpHbbErC0
         08qXLCeyBDZe1mmKPlbax4v88zO00x/cQWLtlqsnciW6qkd55eB9z3mqjaHs8hiaZhxv
         r90nTQ7gm8FaAuBwjdsABWp59Fo6NeRvmEdIst0LvKbvYhpjvyunVo0WorCkfL+F8BXI
         juzs9hVCTEVxwuTWJpbl9MQqLelTPmoCI+oSE7M8dZ2qgfZulBME+FUALEPk9dvnY1d+
         ByMQ4ZrKYWce8WVe0UdIgY5gJy3K5edP8pI2T+ub+qJC6Loop1DkDMni95su3QK8XvqU
         s8BQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1789145950; x=1789750750;
        h=message-id:date:reply-to:cc:to:from:subject
         :content-transfer-encoding:mime-version:content-type:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=VR1VrPzB7g89j5Lob5Tszs4sJli0jSp9tSma6aXfsvE=;
        b=JLiKNnmD95NF1wta6gmUlUep48ihbawZcfPVH5HFWkk4J6M7zjI0Dvjz33DZLiOKrf
         Cx/LgNrMd7g0ruMztg/pkod1HiNS8FDDCzgpUG7HaOk8H9nTrEyTQGivBxMzqr/SlA1y
         cWvrFy4od2jIoWqB3vz4ew3QEVfFrnkrZ1JADKlDBRy9iRImywB4uBraavi+a3YSE7re
         GJyY56H/Obph9QtfxpG/LuRXHtl9MhmyhR08K19fKKeyNdPknQoTFHF+NHU5RPgr7DiQ
         0xQOhSIw9sMrDv29QsQVghPUz2yWdS7lfcnLXzgPkfycpGLrHFGlJ+PkrljP3QVFa4TI
         9QZQ==
X-Gm-Message-State: AFuF++m0h7aInVSYSXLgnoRULnMZWIl2B4siyYnZD2HSVoJrpI8phCD1
	0LJxsHXfdKMiYzurXR6Coq7gm2HbbucilSdD4BNhVrK6ZJ2CnEqqchzIsZpFfSARZ3q7o/sb4mR
	wr+0F
X-Gm-Gg: AYBFou32sXm+h91pjz0lsmPslySaxHsCIAERQKJ2QE/pNLvRRUJmlytj2ZXmurCpprU
	wpc2PPrR7BFCtnSCpl1NTVJutrE432i67U6S1sx/rGJiaVWnhjXmal8Dljp6HlD6QzKlyNhV1Kt
	8FMG3N5L+8m9Eg8MWfoL5seN7rFcxr5Q6JXUopj9NEV+si1JO0RWajgIMyzIv4kIpvIswhHcBkv
	638sdM9zsynkDYPliWAf/K+qm0ZSZA4tu70jeFW0K7QNGpEnwzCIq0XjEZGyxq36bTBoG2bC7nu
	GG/zPfv/F/2c4oKI4qwzONba1g8Qnpo/HyQDMuHHKRMOQtlYz8IsqWZqOJUU40493E3zUMm+gst
	cfIRVPYiUyjiYgfk6SC2MiuiEqBHZWa59kmXBpBB8S556lW9DDN5qqEvcxTcitJLg5/TjpVclaL
	s59ATBS4KAEniCwJFgzuUJULC4IO/9QoUkJ2MI2Kzo+BTsVDNZSKObL0nV+hyrLEVHLfTsE6auK
	g==
X-Received: by 2002:a17:90b:3810:b0:398:9be8:ea68 with SMTP id 98e67ed59e1d1-39d9c35dddemr9103598a91.21.1789145949822;
        Fri, 11 Sep 2026 09:59:09 -0700 (PDT)
Received: from 41049dfc76e5 ([20.38.40.137])
        by smtp.gmail.com with ESMTPSA id 5a478bee46e88-33ba4e51449sm6730103eec.5.2026.09.11.09.59.09
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 11 Sep 2026 09:59:09 -0700 (PDT)
Content-Type: text/plain; charset="utf-8"
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Subject: [REGRESSION] stable-rc/linux-6.18.y: (build)variable
 'an7583_pinctrl_drive_e2_conf' is not needed and will not ...
From: KernelCI bot <bot@kernelci.org>
To: kernelci-results@groups.io
Cc: stable@vger.kernel.org
Reply-To: kernelci@lists.linux.dev
Date: Fri, 11 Sep 2026 16:59:09 -0000
Message-ID: <178914594888.4423.12746346238335762828@kernelci.org>

New build issue found on stable-rc/linux-6.18.y:

---
variable 'an7583_pinctrl_drive_e2_conf' is not needed and will not be emitted [-Werror,-Wunneeded-internal-declaration] in drivers/pinctrl/mediatek/pinctrl-airoha.o (drivers/pinctrl/mediatek/pinctrl-airoha.c) [logspec:kbuild,kbuild.compiler.error]
---

Log excerpt:
=====================================================
/tmp/kci/linux/drivers/pinctrl/mediatek/pinctrl-airoha.c:2282:41: error: variable 'an7583_pinctrl_drive_e2_conf' is not needed and will not be emitted [-Werror,-Wunneeded-internal-declaration]
 2282 | static const struct airoha_pinctrl_conf an7583_pinctrl_drive_e2_conf[] = {
      |                                         ^~~~~~~~~~~~~~~~~~~~~~~~~~~~
1 error generated.

=====================================================

When fixing this issue, please attribute this report according to the
patch submission rules:

Reported-by: kernelci.org bot <bot@kernelci.org>

For complete logs and details about the environment used, see the issue
on the KernelCI dashboard:

- dashboard: https://d.kernelci.org/i/maestro:d34f40a56abf007e0e3f161c3a1f6c32c03677e2
- giturl: https://git.kernel.org/pub/scm/linux/kernel/git/stable/linux-stable-rc.git
- commit HEAD:  ee209bfcc3ce037908356ac4632c57a7e422a024

# Builds where the incident occurred:

## defconfig+allmodconfig+CONFIG_FRAME_WARN=2048 on (arm):
- compiler: clang-21
- config: None
- dashboard: https://d.kernelci.org/build/maestro:6aa40d8220239ade9022b402

## i386_defconfig+allmodconfig+CONFIG_FRAME_WARN=2048 on (i386):
- compiler: clang-21
- config: https://files.kernelci.org/kbuild-clang-21-i386-allmodconfig-6aa40dec20239ade9022b606/.config
- dashboard: https://d.kernelci.org/build/maestro:6aa40dec20239ade9022b606

#kernelci issue maestro:d34f40a56abf007e0e3f161c3a1f6c32c03677e2

--
This is an experimental report format. Please send feedback in!
Talk to us at kernelci@lists.linux.dev

Made with love by the KernelCI team - https://kernelci.org
