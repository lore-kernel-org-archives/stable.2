Received: from mail-pg1-f179.google.com (mail-pg1-f179.google.com [209.85.215.179])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 53D1022A4E1
	for <stable@vger.kernel.org>; Fri, 28 Aug 2026 02:30:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.215.179
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1787884231; cv=none; b=CKa8/7pMtYckY3B0gwVA82e6wCWzi4pj5MSnzM653lmC3q6o7ZsSINLvbC+JKOc69K6sADJbmrEzYZV2/QBY3WGh/jax1OIIuPL4yyEfuluy730XPkyfQA/np7iLdKKj9MOfw/1vYIKA6QS82p3ZMTlWMdUnk22S6mul/bVLfGs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1787884231; c=relaxed/simple;
	bh=84zXg62ENGNT6uLCYPJYYPiXMEKGguYVxFHj23c7sw8=;
	h=Content-Type:MIME-Version:Subject:From:To:Cc:Date:Message-ID; b=QzTLaAsv0VDUVAdLESJcOdoCjqeyEkxBiEOV7iHmSeU+5U0oLBqRQVO7pY+TIIASqDfHEPgcd8FGoZ3TMlP67cf5ViGQ4ItM5zPIBNvRzW1svwu3i+SDuGxGJ+aBKyzmyry493/k9KH/ivf1b8sS94bFxQuuHWuuFqrjp0GjpcA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=kernelci.org; spf=pass smtp.mailfrom=kernelci.org; dkim=pass (2048-bit key) header.d=kernelci.org header.i=@kernelci.org header.b=DXSHNMC4; arc=none smtp.client-ip=209.85.215.179
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=kernelci.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=kernelci.org
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernelci.org header.i=@kernelci.org header.b="DXSHNMC4"
Received: by mail-pg1-f179.google.com with SMTP id 41be03b00d2f7-c9e7391839cso587859a12.0
        for <stable@vger.kernel.org>; Thu, 27 Aug 2026 19:30:30 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=kernelci.org; s=google; t=1787884230; x=1788489030; darn=vger.kernel.org;
        h=message-id:date:reply-to:cc:to:from:subject
         :content-transfer-encoding:mime-version:content-type:from:to:cc
         :subject:date:message-id:reply-to:content-type;
        bh=U2ZhFsRzcCrZ6/cSrpc1CKMBUefqDsIuxoaZ6O299i0=;
        b=DXSHNMC44UuczzzxPvQHsjI/4/329oBIt6yUU/zTSZg0v0QaoT72BSt0S2YFrrTPzo
         /PxltypqCoVKNFm63SJSzUPSQkh6bohj9G4B5UFIFQy3tlW8AHI9HSYRg6uwbYgT+pcP
         7x9afK1LzmfE7kh8lsNbLPN/b/P3SXQFP/5gJL5fvwct6LAjCWzmrQJQW/nFJLbnLbHb
         ikW99/SpVkPngay376el5rnetywcXoWuG41FqCl8uQmJkeU3SxPxF/ATwyN0XeFu88eZ
         Lv2UCzPUSp2WJf/6PEx3DlDDZaImsmqq5Xt8T9SXuLgUO5AX+wOP6Z89nBD9YBqrTgj9
         ZeEQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1787884230; x=1788489030;
        h=message-id:date:reply-to:cc:to:from:subject
         :content-transfer-encoding:mime-version:content-type:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=U2ZhFsRzcCrZ6/cSrpc1CKMBUefqDsIuxoaZ6O299i0=;
        b=pblMr0bib2yCOLoYnhBtyWgjuDfAUacBAglkVd4YkJD8zMhB0Vqtz1yg17hmetFlIM
         9/UUfMu8B/MTqND85CssTeg6Cb2sTLQdu6q/qsahjP183YWqGakwVoknZ9yv2Si2eqQh
         ZoD/RaTvmiuT031kxv3Eg3B2OSoyeJlWF1SYpwnoYT6HLePs5v9Dc6myIjtfWUN/7vxd
         TGFqFQMCWyb8961Ml+uJ8q1bK8VYCGiQL5YTWZcfXuDyoUj38eeuHiQUeCxHt5TyNeIf
         CDE+KQA4DeYj5GUz0OFaMGwOTo+RCry6RmCj4P8n5N+LOn37nS/4BbBIQRxMZCGeQKeD
         iUdw==
X-Gm-Message-State: AFuF++k/xm1Fz/6vP55M9rSnFP5C13qV2PPRs34VVgvYRmpBpHKz1elJ
	znnR3gf6NOlAfjYeYIXFe+81lXuA2rfCUouzCc3pJ58Ne2gECpUAJ9H32zBdtThQdaM7wMuc14v
	bJvuG
X-Gm-Gg: AR+sD10JxGUrQWKpUvjlhIZPNoWN/vH8loqAw01B/flHccck6YsgtVt8bacm6Q4RySB
	vdwmIranKsGZJ2M3VCM6RLzoWrLKcA9ho/Zun8OXO5p0rMo03iV4/xeIRjGBrLgu4gsbDNFS6m9
	KjEoMVS8ESJCM9ia2PiR2zJ/8nXmXq7pJcDyGDTwhSPdCqPC8+cPdPVvrYc4w74bu7K90DNsntc
	R9PuX+E3bxjfR9YCIz0HCqeDwQ3QWlNfzS1YYlJQfNxI2/vBIFnh90IRvbZq3iGXGH2fbFN+bNj
	Af+Hj0LQVkA7TcdPMG/+0TLTQ/Yn2IIQpnsT7o/W9pweYFtWc/dpoQNARzL89O0s+1f+TPjX4xN
	g1bjMSjcwjfstoKz4c9Ar6rY2W4Gg7+S/oTPgiVG/ntAh/7sYppRxDvI4MMDBntJ1+Utty+RqOS
	ruPeui/RXoCsgJkrULj9Kf6nowtQhIs5uPM+CoM075z1DkhPuvzrGS
X-Received: by 2002:a05:6a21:6004:b0:3d1:9166:5c68 with SMTP id adf61e73a8af0-3d265f403d0mr7652956637.8.1787884228418;
        Thu, 27 Aug 2026 19:30:28 -0700 (PDT)
Received: from b455de3d9de8 ([20.38.40.137])
        by smtp.gmail.com with ESMTPSA id a92af1059eb24-142e0d2e465sm1954948c88.4.2026.08.27.19.30.27
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 27 Aug 2026 19:30:27 -0700 (PDT)
Content-Type: text/plain; charset="utf-8"
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Subject: [STATUS] stable/linux-6.1.y -
 79a9660d699e69fa523d2c3d1d8af95d6b857c93
From: KernelCI bot <bot@kernelci.org>
To: kernelci-results@groups.io
Cc: stable@vger.kernel.org
Reply-To: kernelci@lists.linux.dev
Date: Fri, 28 Aug 2026 02:30:27 -0000
Message-ID: <178788422752.5582.2420132993224360146@b455de3d9de8>



Hello,

Status summary for stable/linux-6.1.y

Dashboard:
https://d.kernelci.org/c/stable/linux-6.1.y/79a9660d699e69fa523d2c3d1d8af95d6b857c93/

giturl: https://git.kernel.org/pub/scm/linux/kernel/git/stable/linux.git
branch: linux-6.1.y
commit hash: 79a9660d699e69fa523d2c3d1d8af95d6b857c93
origin: maestro
test start time: 2026-08-27 13:10:46.826000+00:00

Builds:	   48 ✅    1 ❌    0 ⚠️
Boots: 	   29 ✅    0 ❌    0 ⚠️
Tests: 	 3168 ✅  230 ❌  120 ⚠️

### POSSIBLE REGRESSIONS

  No possible regressions observed.


### FIXED REGRESSIONS
    
Hardware: imx8mp-verdin-nonwifi-dahlia
  > Config: defconfig+arm64-chromebook+kselftest
    - Architecture/compiler: arm64/gcc-14
      - kselftest.kvm.shardfile-kvm
      last run: https://d.kernelci.org/test/maestro:6a90e128c5867fba9469ba7a
      history:  > ❌  > ✅  
            


### UNSTABLE TESTS
    
Hardware: qemu-arm64
  > Config: defconfig+netdev+nfs-root-boot+kselftest
    - Architecture/compiler: arm64/gcc-15
      - ltp
      last run: https://d.kernelci.org/test/maestro:6a9042b7c5867fba94641a93
      history:  > ✅  > ❌  > ✅  > ✅  > ✅  
            



This branch has 1 pre-existing build issues. See details in the dashboard.

Sent every day if there were changes in the past 24 hours.
Legend: ✅ PASS   ❌ FAIL  ⚠️ INCONCLUSIVE

--
This is an experimental report format. Please send feedback in!
Talk to us at kernelci@lists.linux.dev

Made with love by the KernelCI team - https://kernelci.org
