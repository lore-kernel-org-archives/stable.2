Received: from mail-pl1-f169.google.com (mail-pl1-f169.google.com [209.85.214.169])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7980910F1
	for <stable@vger.kernel.org>; Fri, 31 Jul 2026 02:30:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.169
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1785465028; cv=none; b=mCZn5xUuQODbhS4yFg1lFdEDXz+s3sU9G8f/FrYP7sBi3BLDGqw//v18anW+tXXSoQrqV9YuRLP6uFKRk1QNH40YzOjG3cLa1TLhh6RZntdoGkBA4GLbwly/Hrm1NdmCoUAF+yCwpim09/dSrjkb3/eIerbdwUk0vQCTVWBTz98=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1785465028; c=relaxed/simple;
	bh=/3Mp9l1+wa8G1SNk7ylXB/vxpH6hpGDZd8quYJztsRg=;
	h=Content-Type:MIME-Version:Subject:From:To:Cc:Date:Message-ID; b=ANUAzGtV08354WvWK/s84Msys1wc1nYJAfzlzYukEc9Cyj+lastnnxMwWIxd1schnyMrpJlD8dgUrWYFhYTWKxwav0yg0kRqV5zSg/fjLB87CpqyN5dIGP73wQop4mWQ/8yHGcq1zAcovOP0Bw2CPsMQzhNopyxfPmN0hZsNCTE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=kernelci.org; spf=pass smtp.mailfrom=kernelci.org; dkim=pass (2048-bit key) header.d=kernelci.org header.i=@kernelci.org header.b=La9G1saF; arc=none smtp.client-ip=209.85.214.169
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=kernelci.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=kernelci.org
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernelci.org header.i=@kernelci.org header.b="La9G1saF"
Received: by mail-pl1-f169.google.com with SMTP id d9443c01a7336-2cc97653887so4781525ad.1
        for <stable@vger.kernel.org>; Thu, 30 Jul 2026 19:30:26 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=kernelci.org; s=google; t=1785465026; x=1786069826; darn=vger.kernel.org;
        h=message-id:date:reply-to:cc:to:from:subject
         :content-transfer-encoding:mime-version:content-type:from:to:cc
         :subject:date:message-id:reply-to:content-type;
        bh=KoIeCBtRkzBtFGG6bADnVScOvR5FdcUHC0/DAlWqTk8=;
        b=La9G1saFj1knx49DoYgu5ON+VQkJsJ5Jmh7vFu9Y0D9Fdqx9LEXRxChG7vNgfhBZPF
         FH0w+89Sgb59o5zV6UbxEK//zHL3egCpiU7piU4X+I17BSq4PEjjIQVyb3E+QGTRIy/1
         naw7ALENxEWS7714pELLPCXV/X9xbxiKWtnf3mLYY8lLADiS/Lyhf/2z8NRpibs9vvIi
         AmdIMsY6WDTniD36DC8p1Q0s8yz49sbFQ5VeMcsTOo8LxS+tUx0ViubwebwqOjgdef+s
         H9lk5KCWSXdXLTliR3FIG/A7BGP+PgJDueBUI877tpieiswNCN5ybf7IOPfshEzMMzNo
         5vYw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1785465026; x=1786069826;
        h=message-id:date:reply-to:cc:to:from:subject
         :content-transfer-encoding:mime-version:content-type:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=KoIeCBtRkzBtFGG6bADnVScOvR5FdcUHC0/DAlWqTk8=;
        b=qIk17fo8fSIOEF5iBD7e1AzqOq1GGAXAyR18e/lecYZAO0Ch50bP3b4HVubEhbDBGU
         y10qM8xYquhX/xhV0a7bCKNJUBpnkd0aVuUjSSXTqv98nLuyf0Di7+k/+C5gMTeOZu8m
         rCcV7Gql01ep6CPyGL7j+04yIIORkcy2PJM66drVui59mSzG93GEZd89xr+xNkXvF5CH
         smL07HX2GaAwJmvE0y6KqnRMU+PixkXStsONRm7ZXUFO7ptKbqQUsivs3N0dSUUUux7b
         KfOOiANiIvUQ1XhYE5tO406o2tyUDuZHyTle8Ee3n0h9NYIQ+OVDxxkPXqtw2BswJIJa
         KUkQ==
X-Gm-Message-State: AOJu0YzNhKfvaFfjTg9jaL9bZuqlb2ba30IZ2LjfO3d8dYcEGZwS3Bk+
	Qm+/EYOosvf1FALahkowQg45staunY/wFdAxhtUyQBgA/eAgRavKcb3UHnv54rC+a5/MNd6vIFA
	iVKBx
X-Gm-Gg: AR+sD13facL3FytBpWNRPCtcK+Jv2FPuwvOWskfPmr/m7CB4oCl/OvJvL15yeYp+2V0
	kbYwXxgM+9IS+/0m5KzrEg5H92ooK82V7Jtu+FjHOETvU0mOIJSHUr3C6pcgnWylI3ByOJVOJaM
	Y+HM9oAXsA5sakrLV3fvWR9tfr4GpwB/U6fuSK3VsLHjSjI9SkKlGvCCYFRiGK1Agi7wFzqTQNl
	czXEDD5R8r1U4R1rvnOmMgPLpE/Dv7ey1cGU/5xjg0usZ/DHTK2BtraJDtPbKmhNW6Lk9mw82ZZ
	2Qe81G6gWqp41T+cvE6MOzbPJx8u8EmxB4vt9Nt5zG4gXnxdAV8K1SAxdYnviktfqPtEIA5YN2k
	SLQ45v2j0IfJE8neP6ZFTMZtmOBdF8D3QLSce8J/RNYiU7uVNKTBZXACNbWKv7pZ2HLUd8mc0IZ
	YNxSkX7Rz8FO2Y6s7zGd2crBhQIvsCkPrNv6cZt3dM3QaYfkNg3KNB2IzsuU8UI75RTw==
X-Received: by 2002:a05:6a20:cf8f:b0:3c3:69d0:c57c with SMTP id adf61e73a8af0-3c91b1764d4mr64309637.32.1785465025701;
        Thu, 30 Jul 2026 19:30:25 -0700 (PDT)
Received: from 92650adf53de ([20.38.40.137])
        by smtp.gmail.com with ESMTPSA id 5a478bee46e88-3153ae94d98sm723626eec.20.2026.07.30.19.30.25
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 30 Jul 2026 19:30:25 -0700 (PDT)
Content-Type: text/plain; charset="utf-8"
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Subject: [STATUS] stable/linux-6.12.y -
 52a355b23cd2dd77b683ed1a1bbe2b7408bd9c74
From: KernelCI bot <bot@kernelci.org>
To: kernelci-results@groups.io
Cc: stable@vger.kernel.org
Reply-To: kernelci@lists.linux.dev
Date: Fri, 31 Jul 2026 02:30:24 -0000
Message-ID: <178546502459.4267.1921529734759622429@92650adf53de>



Hello,

Status summary for stable/linux-6.12.y

Dashboard:
https://d.kernelci.org/c/stable/linux-6.12.y/52a355b23cd2dd77b683ed1a1bbe2b7408bd9c74/

giturl: https://git.kernel.org/pub/scm/linux/kernel/git/stable/linux.git
branch: linux-6.12.y
commit hash: 52a355b23cd2dd77b683ed1a1bbe2b7408bd9c74
origin: maestro
test start time: 2026-07-30 11:31:39.278000+00:00

Builds:	   55 ✅    0 ❌    0 ⚠️
Boots: 	   94 ✅    0 ❌    0 ⚠️
Tests: 	10424 ✅  750 ❌  945 ⚠️

### POSSIBLE REGRESSIONS
    
Hardware: qcs6490-rb3gen2
  > Config: defconfig+lab-setup+kselftest
    - Architecture/compiler: arm64/gcc-14
      - kselftest.breakpoints
      last run: https://d.kernelci.org/test/maestro:6a6b6083798ea6c1ef919606
      history:  > ✅  > ✅  > ❌  
            
      - kselftest.breakpoints.breakpoints_step_after_suspend_test
      last run: https://d.kernelci.org/test/maestro:6a6b7853798ea6c1ef92fecd
      history:  > ✅  > ✅  > ❌  
            


### FIXED REGRESSIONS
    
Hardware: k3-am625-verdin-wifi-mallow
  > Config: defconfig+arm64-chromebook+kselftest
    - Architecture/compiler: arm64/gcc-14
      - kselftest.kvm.kvm_memslot_perf_test
      last run: https://d.kernelci.org/test/maestro:6a6b97ce798ea6c1ef945eac
      history:  > ❌  > ❌  > ❌  > ✅  
            


### UNSTABLE TESTS
    
Hardware: mt8183-kukui-jacuzzi-juniper-sku16
  > Config: defconfig+lab-setup+arm64-chromebook+CONFIG_MODULE_COMPRESS=n+CONFIG_MODULE_COMPRESS_NONE=y
    - Architecture/compiler: arm64/gcc-14
      - kernelci_watchdog_reset
      last run: https://d.kernelci.org/test/maestro:6a6b5b7f798ea6c1ef916b3a
      history:  > ✅  > ✅  > ❌  > ✅  
            
      - kernelci_watchdog_reset.wdt-reset.wdt-trigger-reset
      last run: https://d.kernelci.org/test/maestro:6a6b5cd2798ea6c1ef917cd8
      history:  > ✅  > ✅  > ❌  > ✅  
            
Hardware: mt8195-cherry-tomato-r2
  > Config: defconfig+lab-setup+arm64-chromebook+CONFIG_MODULE_COMPRESS=n+CONFIG_MODULE_COMPRESS_NONE=y
    - Architecture/compiler: arm64/gcc-14
      - kernelci_watchdog_reset.wdt-reset.wdt-get-timeout
      last run: https://d.kernelci.org/test/maestro:6a6b5d1e798ea6c1ef917e29
      history:  > ❌  > ✅  > ✅  > ❌  
            
Hardware: qcs6490-rb3gen2
  > Config: defconfig+lab-setup+kselftest
    - Architecture/compiler: arm64/gcc-14
      - kselftest.proc
      last run: https://d.kernelci.org/test/maestro:6a6b901e798ea6c1ef9414af
      history:  > ❌  > ✅  > ❌  
            
      - kselftest.proc.proc_read
      last run: https://d.kernelci.org/test/maestro:6a6b901e798ea6c1ef9414b6
      history:  > ❌  > ✅  > ❌  
            


Sent every day if there were changes in the past 24 hours.
Legend: ✅ PASS   ❌ FAIL  ⚠️ INCONCLUSIVE

--
This is an experimental report format. Please send feedback in!
Talk to us at kernelci@lists.linux.dev

Made with love by the KernelCI team - https://kernelci.org
