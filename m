Received: from mail-dy2-f12.google.com (mail-dy2-f12.google.com [74.125.229.12])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E9FC0490C10
	for <stable@vger.kernel.org>; Wed, 23 Sep 2026 10:59:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=74.125.229.12
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1790161153; cv=none; b=RIqv0UjVsDsPLZSAvyJVNzeWOeyNf7u2489qiX/syy+LxB4QM01Hi5V5xFzLfRCoKMsDe0/B9FlZnhqux5SwHbuZWFvUo2CyauPChdjCe6O0116Kyjk+Apk7pzXUaSzTFGrcjsog/oOdS7b8hUJ8Mp3Pw+aBTHMUAwWXmqF6UNI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1790161153; c=relaxed/simple;
	bh=w1XqH7KTxn4LHR8Inn9AhQ35JkVhR0yAgbop8ri+YxQ=;
	h=Content-Type:MIME-Version:Subject:From:To:Cc:Date:Message-ID; b=FLo+U4kGVA6xC1X+RlLpZ/dngXE+toW1rRbOmMigX+yt5aqo8wDJQMpv5d9iDW/eHaXuKQShQTqvposj+OhlWMb3gVnaVU0q/LtoPgt+nBFI3gd63yJXaCL5wB90LN/lOWwqd7kGu2uP5bui3uLYfgrQ0MCfmmaz3ZN2kxLaoqo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=kernelci.org; spf=pass smtp.mailfrom=kernelci.org; dkim=pass (2048-bit key) header.d=kernelci.org header.i=@kernelci.org header.b=cD5SQpXD; arc=none smtp.client-ip=74.125.229.12
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=kernelci.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=kernelci.org
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernelci.org header.i=@kernelci.org header.b="cD5SQpXD"
Received: by mail-dy2-f12.google.com with SMTP id 5a478bee46e88-33be7dfcfc1so846890eec.1
        for <stable@vger.kernel.org>; Wed, 23 Sep 2026 03:59:08 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=kernelci.org; s=google; t=1790161146; x=1790765946; darn=vger.kernel.org;
        h=message-id:date:reply-to:cc:to:from:subject
         :content-transfer-encoding:mime-version:content-type:from:to:cc
         :subject:date:message-id:reply-to:content-type;
        bh=2q8ipXz3P7s9DSg/YMKYX+otCBV45na4I1PdQUCIDHU=;
        b=cD5SQpXDg8FQft7GnLiwNP8D3R1m8UbM5qVo40/x44m1FfQBqIIMPZKoQX0q9KUBzL
         MVu6UEwhMU2lQxIVRPFxYMylmOsgP9R8eA2ZSIqqFD2E/OuHmyd/z3q1EeQn4Ss+PBl7
         I2bsT7eymnc0JXLsVMGa+yzr4rJ59TMOq4/vKFMzbPmDcN5p65yk/kiZGcppbzDAXMRV
         uySh5L7e8ibyQMFi6C9DQ6Bb8McoY3O5+SktYid9wp9G1L0q787lSmcdFYgC8qAlDdoD
         Vb4XQbfuc7E2NUwwF+N22oZdxZNFDWG4559U3Km5bnWvB9vEhM+oexp1CRVrwH91Empp
         amnQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1790161146; x=1790765946;
        h=message-id:date:reply-to:cc:to:from:subject
         :content-transfer-encoding:mime-version:content-type:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=2q8ipXz3P7s9DSg/YMKYX+otCBV45na4I1PdQUCIDHU=;
        b=v/R9itwHcnm1aUrwiBOQv1W/9he/2fR60R0O/s3TmTw+yqgGiCmsN4kU2XnRQw0KPX
         jt67lKW5czgPqtQBitocmTlFcNmOTSLelxajzTSNZiz5BRVDj4VDrleroysXAlagaCmo
         Qms9csxJAn5poUEDxWeBxoiN9GDDEC9GExwlg+jxyWwChgBLKQYUSg/tg4pPjUsO9XJo
         JzIKIztVTYfUHZB9DSXAxi1syK3wLfHU0EQ9cMshoJYqWwjWpqpxiJ7xifmSDeYTNW+3
         Uej9YQR8e/7wvSFiXferTU0ZB6kpFcCIOEPL3AXK3upK2m5/9+GR55BrLQ3MikLN6b5X
         ViZQ==
X-Gm-Message-State: AFuF++kNkcR8g9GevsBX+3vorG3xAW2nVk8d84h6v3sANPOpoRfyyQX2
	J4IEcAk6+W6smqXWxdy1ArFsbA04+T3cLSnW5uC899SZ5QE6gRLndECkadZmrSHGYcc=
X-Gm-Gg: AYBFou3w82Oiluaj3CEATVMtY/PVL+/mpohINmQEYuX/8UAXTn1ebDFGpvDecAdg266
	yXL2Yr+o9uYAQhxJBM3CLWLt8BBa+6p4TkCd5URdq9aeccA8CJXT5gJ5Dw//NdoTjNLpxV0vhGx
	txn2Vp4+eGjhk5ljld68qbLRfbeTiAS5lAB6283bZ2K2SfOOJgxLsfKkUCUu98fddSI4zXHnBKB
	WmcPJF1bvk2W1CM3jLjOAkfi1IG8AiaAx2h5DkXdiAzWHIEVvx0DFQREyhzl6Pmn4NrlTHBIqHr
	jJoEG0gI8E36IkbAutTi2J/CJyjEDiOWYzvu2LtRIcrxxGP02bOPwSap4qds3wodfwZBiUpt12Q
	Y0FDbjQJwdcJZCwt6mN9nG3c5VIC0ZNXvMypxd6ufxxfWQq4sLcvAbHjHee8VrmPiAm2yjY/r4d
	t962fnpqTMUrntMq0oAHwebSfx5JR/DdVjiS0ChLE9Fzq/Ds+UKphxM3c2PE+duwH4TukCyw4cE
	Q==
X-Received: by 2002:a05:7301:2522:b0:33e:a0c3:4172 with SMTP id 5a478bee46e88-33ea0c34599mr2113139eec.33.1790161146195;
        Wed, 23 Sep 2026 03:59:06 -0700 (PDT)
Received: from ec7b70f3a45c ([20.38.40.137])
        by smtp.gmail.com with ESMTPSA id 5a478bee46e88-33e9625825asm5878870eec.13.2026.09.23.03.59.05
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 23 Sep 2026 03:59:05 -0700 (PDT)
Content-Type: text/plain; charset="utf-8"
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Subject: [REGRESSION] stable-rc/linux-6.18.y: (build)"init_time_ns"
 [drivers/misc/ntsync.ko] undefined! "do_timens_ktime...
From: KernelCI bot <bot@kernelci.org>
To: kernelci-results@groups.io
Cc: stable@vger.kernel.org
Reply-To: kernelci@lists.linux.dev
Date: Wed, 23 Sep 2026 10:59:05 -0000
Message-ID: <179016114512.454291.6121765089884248577@kernelci.org>

New build issue found on stable-rc/linux-6.18.y:

---
"init_time_ns" [drivers/misc/ntsync.ko] undefined! "do_timens_ktime_to_host" [drivers/misc/ntsync.ko] undefined! in Module.symvers (scripts/Makefile.modpost:147) [logspec:kbuild,kbuild.modpost]
---

Log excerpt:
=====================================================
ERROR: modpost: "init_time_ns" [drivers/misc/ntsync.ko] undefined!
ERROR: modpost: "do_timens_ktime_to_host" [drivers/misc/ntsync.ko] undefined!

=====================================================

When fixing this issue, please attribute this report according to the
patch submission rules:

Reported-by: kernelci.org bot <bot@kernelci.org>

For complete logs and details about the environment used, see the issue
on the KernelCI dashboard:

- dashboard: https://d.kernelci.org/i/maestro:39c90032527d25bd47ffed84b9833ea2c1326689
- giturl: https://git.kernel.org/pub/scm/linux/kernel/git/stable/linux-stable-rc.git
- commit HEAD:  eccdbf0d3a832ccf6c732cdb37c3b39ea88fb4f3

# Builds where the incident occurred:

## i386_defconfig+allmodconfig+CONFIG_FRAME_WARN=2048 on (i386):
- compiler: clang-21
- config: https://files.kernelci.org/kbuild-clang-21-i386-allmodconfig-6ab38ff3d96a8203de846035/.config
- dashboard: https://d.kernelci.org/build/maestro:6ab38ff3d96a8203de846035

#kernelci issue maestro:39c90032527d25bd47ffed84b9833ea2c1326689

--
This is an experimental report format. Please send feedback in!
Talk to us at kernelci@lists.linux.dev

Made with love by the KernelCI team - https://kernelci.org
