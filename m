Received: from mail-pj1-f53.google.com (mail-pj1-f53.google.com [209.85.216.53])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8853D3451C8
	for <stable@vger.kernel.org>; Fri, 11 Sep 2026 14:59:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.216.53
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1789138769; cv=none; b=OIx9s0RHbUhmN5LhzI6JP0f6lSyRxhRMlRh4/q3wZc9uah23uNycNoZ5br8xMd9uGBCtZjNZ0t74CB7j4GCeSgp993Sawuipbu8m2tUM//0urId25daKQeBjLsLSmR/waycLG270jyn+EXE7G1hWNzVTqriQtihjBzFPuH7Ju/I=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1789138769; c=relaxed/simple;
	bh=bb8oKxe36Ti7rMlix03nCM+atiKMxu3l/186Zy1Q+OY=;
	h=Content-Type:MIME-Version:Subject:From:To:Cc:Date:Message-ID; b=MYDg5Sm3RVNkNNOT8cMXF82d1h2bRHoSTZLYHjr6bWAltD+U3avkJXr2HCVrCWBoxRuEJXTtfpNFGR3KNxqrgwXQ5TvXgYHfyquKwqki9TMEGpG45bjY/eRGSxplnbaKAIfD5PKVjW95O/9JI6pBz3DrJ11+X/DRrFWf63+LSp0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=kernelci.org; spf=pass smtp.mailfrom=kernelci.org; dkim=pass (2048-bit key) header.d=kernelci.org header.i=@kernelci.org header.b=EHMjXPA8; arc=none smtp.client-ip=209.85.216.53
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=kernelci.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=kernelci.org
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernelci.org header.i=@kernelci.org header.b="EHMjXPA8"
Received: by mail-pj1-f53.google.com with SMTP id 98e67ed59e1d1-3856d6fbcb3so946532a91.2
        for <stable@vger.kernel.org>; Fri, 11 Sep 2026 07:59:23 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=kernelci.org; s=google; t=1789138761; x=1789743561; darn=vger.kernel.org;
        h=message-id:date:reply-to:cc:to:from:subject
         :content-transfer-encoding:mime-version:content-type:from:to:cc
         :subject:date:message-id:reply-to:content-type;
        bh=tdb4J+k/bWkLPlfBk4HJxGfVgpYUl59vg+hEytiVjhs=;
        b=EHMjXPA8WWFlYNutLr3L6iMZjsp5LPGMPrRRMnsVmG2FeAn3z8euSOURRlO7WcuIcn
         utYYOM5OCVp6rpaiFOULQ8tEGiZYnbWHeOCiLL8i/EXfGhWyH+t+dCFo/W8/qgj00cFp
         KG/42cDUgvn86PvFbMD+Rd9oFsgrWz0iJbzEJWiKHX/bWhwfHO/a6cPqdT0TpnB56e/P
         qxCp0esplUIC1K2OR9MdHQLRkk3h9L8vq71kg45xz29eI5mOU8IHZ21jE7AGQemYaBV3
         /wGZftCB9vQFZlzI86m7/4u8qBrs7/T6ug0hjl4VIR8q/ESB42FIpVBbYy74u7vgWXXu
         DjQw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1789138761; x=1789743561;
        h=message-id:date:reply-to:cc:to:from:subject
         :content-transfer-encoding:mime-version:content-type:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=tdb4J+k/bWkLPlfBk4HJxGfVgpYUl59vg+hEytiVjhs=;
        b=Sak93juMqo2n3prJIDwzdSo6HEsre3TXcFa/NBJh/Hf28Y+q32j5nr4CHI4h5EwdSh
         UNQHeI+wh2kvgsB2lgy58Mf0e++Uz9h4zdTI8fRCahi/glW0JGE+2LVX7nffVDlusbeP
         KMG+NMR0aDbuEPWckn8Ra3mXEDxNl1QpeTXucclNOsHEuJzzjZyHhnQdYRHShsXd5TBh
         rIdd2CZhMhbbLKzvYvdz6IhmmuY3dyyLYLRC39YrkwBvYIAqeoGqZ8XL05Eqp/gceg8q
         jBBpTaFoBi5zypd8+Dx1sK18xBcagf/1L9lBgA2uz2qVegTk0jwXErMANhV+vQz25mU7
         7Y2g==
X-Gm-Message-State: AFuF++nNGfjMeWf62/KuOI+u8u+eNQlc9hJ1+9PUzABIQJBqS6btx8Gj
	tCT87pD0uVFeg+x0FlsthjFV3AJDJ0gWoEpwjGw1ZH4OkwelIz/OkYBVbIXyTJ+mDTI=
X-Gm-Gg: AYBFou109gRPQ3Ujy9LQrXbZD3SZsbmifrp+cPzi0+RazzqmnI1qF8+NGp9C2vZmCH+
	5mGb/cZX9e5fzbB11wq5nUi2lrdtUx5fHG8U55NzvpVyBTjWehofBCtn0/BhcmIfgg8dG0nHD4t
	c6woLfWpBj7DMkeaCv7ECEcyv12W8On85OOvruVnyRRhozfUrpefcTd2wnj5evHQ+RAz3vwV9Ck
	H+9AxiD0Xzeib/tC+TdP4vMil5ReUY4VVk52yPc2x5E/JXqllQIo8rGrLZnMZZwNiX7mQk/Py5s
	zIQhOrNqTSFgo6IAGNeFRjTAHlJBSf4EUtzLH+FH+c3wRVGrkhD1VatmOZ51w0Rz5kIybdqPMNT
	fMzMfe5w6iRxolnM3Ab4ydg7R7EuUGqEDZZTpoOvdgPdESj8EiW1ESfFl299V3KfymH/6mlHrNe
	aueSil3kHGeyk5MIEVGOpBQ+CVnq2gmsRNeSoWK8iXanf8PG//2zHxYWyAEXgdrojR
X-Received: by 2002:a17:90b:3a0c:b0:366:10f1:3d91 with SMTP id 98e67ed59e1d1-39d9bc10065mr7823199a91.1.1789138761057;
        Fri, 11 Sep 2026 07:59:21 -0700 (PDT)
Received: from 41049dfc76e5 ([20.38.40.137])
        by smtp.gmail.com with ESMTPSA id 5a478bee46e88-33ba4f0feaasm6943199eec.21.2026.09.11.07.59.20
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 11 Sep 2026 07:59:20 -0700 (PDT)
Content-Type: text/plain; charset="utf-8"
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Subject: [REGRESSION] stable-rc/linux-6.1.y: (build)fs/ext4/extents.o: in
 function
 `__ext4_ext_check': in fs/ext4/bitma...
From: KernelCI bot <bot@kernelci.org>
To: kernelci-results@groups.io
Cc: stable@vger.kernel.org
Reply-To: kernelci@lists.linux.dev
Date: Fri, 11 Sep 2026 14:59:20 -0000
Message-ID: <178913875993.4387.1446578689296028740@kernelci.org>

New build issue found on stable-rc/linux-6.1.y:

---
fs/ext4/extents.o: in function `__ext4_ext_check': in fs/ext4/bitmap (mips-linux-gnu-ld) [logspec:kbuild,kbuild.compiler.linker_error]
---

Log excerpt:
=====================================================
fs/ext4/bitmap.c:(.text+0x244): undefined reference to `crc32c'
mips-linux-gnu-ld: fs/ext4/extents.o: in function `__ext4_ext_check':
fs/ext4/extents.c:(.text+0x814): undefined reference to `crc32c'
mips-linux-gnu-ld: fs/ext4/extents.o:fs/ext4/extents.c:(.text+0xae0): more undefined references to `crc32c' follow

=====================================================

When fixing this issue, please attribute this report according to the
patch submission rules:

Reported-by: kernelci.org bot <bot@kernelci.org>

For complete logs and details about the environment used, see the issue
on the KernelCI dashboard:

- dashboard: https://d.kernelci.org/i/maestro:8b883d211f23fdc2e1b60022a8c76a580490d223
- giturl: https://git.kernel.org/pub/scm/linux/kernel/git/stable/linux-stable-rc.git
- commit HEAD:  9f5e4631f281f1f3c92f33dcb2dc004f416196a0

# Builds where the incident occurred:

## 32r2el_defconfig on (mips):
- compiler: gcc-14
- config: https://files.kernelci.org/kbuild-gcc-14-mips-32r2el_defconfig-6aa40bc320239ade90229c4c/.config
- dashboard: https://d.kernelci.org/build/maestro:6aa40bc320239ade90229c4c

#kernelci issue maestro:8b883d211f23fdc2e1b60022a8c76a580490d223

--
This is an experimental report format. Please send feedback in!
Talk to us at kernelci@lists.linux.dev

Made with love by the KernelCI team - https://kernelci.org
