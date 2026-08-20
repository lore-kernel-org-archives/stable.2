Received: from mail-pg1-f170.google.com (mail-pg1-f170.google.com [209.85.215.170])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2A5DD47D92E
	for <stable@vger.kernel.org>; Thu, 20 Aug 2026 16:59:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.215.170
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1787245147; cv=none; b=gzyBlbXzgOS/nR4/67yAYNiMuWMT8c5BEUX6H0bc33y3kenBLqXvqkeTo38M2jIknrzZBhk6pHLJPi5/rWbxQiXgOEwFtlresFC/ZznODBZ9JVxiqROHWrY5hLzpz0OLjrGbqsea0q10UbMoAR0t+CnKHHIIcEv6nrNA7ZCFN+Q=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1787245147; c=relaxed/simple;
	bh=g7LzAuK2LOv99pymj27NbqyBqTriUpGB4sSudd53pnA=;
	h=Content-Type:MIME-Version:Subject:From:To:Cc:Date:Message-ID; b=rHBseZaoIErAao/sTSSdKifAtLeoEMvFnvtxXfpDTioeRwlXz+y7tfm4zR30mKIHxWRkgBrFg6cgPmMifdyfkQTMWr6MVm0qp9RLYAprLaOuhHEdjVuhuiLhMQHzxtAKB9rSf2WQ985oKpfR7siC3HK9kZ9Yc8wWHdNWygna7Qw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=kernelci.org; spf=pass smtp.mailfrom=kernelci.org; dkim=pass (2048-bit key) header.d=kernelci.org header.i=@kernelci.org header.b=ZbHJ9HWW; arc=none smtp.client-ip=209.85.215.170
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=kernelci.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=kernelci.org
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernelci.org header.i=@kernelci.org header.b="ZbHJ9HWW"
Received: by mail-pg1-f170.google.com with SMTP id 41be03b00d2f7-c9cf07d2df6so85562a12.2
        for <stable@vger.kernel.org>; Thu, 20 Aug 2026 09:59:05 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=kernelci.org; s=google; t=1787245145; x=1787849945; darn=vger.kernel.org;
        h=message-id:date:reply-to:cc:to:from:subject
         :content-transfer-encoding:mime-version:content-type:from:to:cc
         :subject:date:message-id:reply-to:content-type;
        bh=bl++BI8L/JYh+VPKL8SUK1hPKnphWEe+DHbUpZbMtS4=;
        b=ZbHJ9HWWMTjvVQ70HTxFkSA8G6oMA0AvMyNgi+aXGZSg4Z2zd59QJ+D29GPa0SeIuL
         XFnTcU7s/YCvwah9rU5Mk3ikEsD2Jcf6lcDR5CrYhXZ/jqWXctG4WLfE/uftOzzs9Mgi
         Ot/f8zAMDuugOxdH7hiF3zTXDPEv1ghnXj8fu4OBA1PMVR2T/0L9aJ0z9grBCttsQWRN
         ijlKqKhT1N0r7yWBBw/AcDajSqJ9eEENtFE+0JfIdDJ2C6K+UFPhFnfKjugKs9fGk7il
         hCgXdM9J+qph+ygNGYw2j83ehGWWiblHV6abPr2YlmTciWyqi0e+Gp4HMqf1yr+J0fr9
         ucrg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1787245145; x=1787849945;
        h=message-id:date:reply-to:cc:to:from:subject
         :content-transfer-encoding:mime-version:content-type:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=bl++BI8L/JYh+VPKL8SUK1hPKnphWEe+DHbUpZbMtS4=;
        b=LujTz/LDFd/t1jVh3OLC4nwLYk/20g7AZzoa47Tz3D1dxFXHZKGe18Ca5o5uPhGBO1
         v2KPktL0CGcLHF3DRmWHpyRdThpcd9RyHr1uG7LIr3jTdEu/guGZKKNYmHTYF/NREnsi
         dA9womuOaI0BpW75Rk2x4ktIRIFpGSEqpxgxDBmIKQL0EGwthb0mbU9Cll1e6rsB4/hR
         PBjRcoBqrL/pvWdHaL3KLDGo7IQqJNLhDoMiFrw8QrO8NCovHoM4kvu9ni/QpUHPg6iE
         EAh9+71IV2up15UsFiVNd1RFXDWPp2HKIb9R0vNHFBVhj4B8zXWowkQj3DoldDpYGq0m
         P3PQ==
X-Gm-Message-State: AOJu0YxpTt1fk/GHf+6cMW9RjfXIyyWafcc8CoN6C/EkYcxYKB3LKBQF
	U3Df/KKzwuTuHuvgfmqFTtNmX65UyCORpoEdVtlkWFMEmajpEYBx9kRefacEOYME9Gsz49yolrf
	a+Fr8
X-Gm-Gg: AR+sD11GbhDrP5nuyjmfWgYG2qRAY8ZKnW+WkyY7r6Hzk7vZAvb2fEGNqLb9xH/A6NM
	Xow3PHBT36AbsewZWPLvqh8ZH43TCyQUwYS0tH0KsTy/yz4XKDffnvOnMXQHwqfnJt1ZYamS1bK
	6wisMATj94v6yCqgluokTVeBeHoT7j0FW530iVpksnntaiyBO0JW5F9IKLmkfBOF6YRNlK8/xFz
	/3Ktu4wboKuRjzcDoMu89Z2BmxwXJHICrIMEnHOOs8Q8gDDUx20Eao7N3N/XhA4iei81vBHZxXw
	7w1iM8/9VWADf5u8pz76IgOIxGquZvvtBe0ZmcvKKTUiG/bIMeem6MpmS/lTvqdOUe2jI/mSuHz
	O0EaSVUALQStgXlO4i/l1VYN9k9vr/JEGnhXb1P45YkWyHG3Vr5dSyVQAX0dNEWHBQGAJesMiqS
	/1jQdaCSOjajdMXnQjupEDSKfUI7mPlcOuBfM46FEk51dLOvv06+1/
X-Received: by 2002:a05:6a21:3295:b0:398:c0ba:9ceb with SMTP id adf61e73a8af0-3cd011f4081mr25902843637.12.1787245145328;
        Thu, 20 Aug 2026 09:59:05 -0700 (PDT)
Received: from b455de3d9de8 ([20.38.40.137])
        by smtp.gmail.com with ESMTPSA id a92af1059eb24-1416ae89189sm18438006c88.14.2026.08.20.09.59.04
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 20 Aug 2026 09:59:04 -0700 (PDT)
Content-Type: text/plain; charset="utf-8"
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Subject: [REGRESSION] stable-rc/linux-6.6.y: (build) call to undeclared
 function
 '__struct_size'; ISO C99 and later do ...
From: KernelCI bot <bot@kernelci.org>
To: kernelci-results@groups.io
Cc: stable@vger.kernel.org
Reply-To: kernelci@lists.linux.dev
Date: Thu, 20 Aug 2026 16:59:04 -0000
Message-ID: <178724514348.764.5467634857434251479@kernelci.org>

New build issue found on stable-rc/linux-6.6.y:

---
 call to undeclared function '__struct_size'; ISO C99 and later do not support implicit function declarations [-Wimplicit-function-declaration] in lib/overflow_kunit.o (lib/overflow_kunit.c) [logspec:kbuild,kbuild.compiler.error]
---

Log excerpt:
=====================================================
lib/overflow_kunit.c:1128:24: error: call to undeclared function '__struct_size'; ISO C99 and later do not support implicit function declarations [-Wimplicit-function-declaration]
 1128 |         KUNIT_EXPECT_EQ(test, __struct_size(two),
      |                               ^
lib/overflow_kunit.c:1130:24: error: call to undeclared function '__struct_size'; ISO C99 and later do not support implicit function declarations [-Wimplicit-function-declaration]
 1130 |         KUNIT_EXPECT_EQ(test, __struct_size(eight), 24);
      |                               ^
lib/overflow_kunit.c:1131:24: error: call to undeclared function '__struct_size'; ISO C99 and later do not support implicit function declarations [-Wimplicit-function-declaration]
 1131 |         KUNIT_EXPECT_EQ(test, __struct_size(empty), sizeof(struct foo));
      |                               ^
  CC [M]  drivers/phy/mediatek/phy-mtk-mipi-dsi-mt8183.o
  CC [M]  arch/x86/kvm/svm/svm.o
  CC [M]  sound/core/seq/seq_clientmgr.o
3 errors generated.
  CC [M]  net/sched/act_gact.o

=====================================================

When fixing this issue, please attribute this report according to the
patch submission rules:

Reported-by: kernelci.org bot <bot@kernelci.org>

For complete logs and details about the environment used, see the issue
on the KernelCI dashboard:

- dashboard: https://d.kernelci.org/i/maestro:d6e00b8a47b68998c5952401dafcb399cd60b7fe
- giturl: https://git.kernel.org/pub/scm/linux/kernel/git/stable/linux-stable-rc.git
- commit HEAD:  0ce9d61969cfccff44a3ac2fa8345f2915ffe708

# Builds where the incident occurred:

## i386_defconfig+allmodconfig+CONFIG_FRAME_WARN=2048 on (i386):
- compiler: clang-21
- config: https://files.kernelci.org/kbuild-clang-21-i386-allmodconfig-6a871ffc62f33761c0f11088/.config
- dashboard: https://d.kernelci.org/build/maestro:6a871ffc62f33761c0f11088

#kernelci issue maestro:d6e00b8a47b68998c5952401dafcb399cd60b7fe

--
This is an experimental report format. Please send feedback in!
Talk to us at kernelci@lists.linux.dev

Made with love by the KernelCI team - https://kernelci.org
