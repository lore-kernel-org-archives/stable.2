Received: from mail-pj1-f49.google.com (mail-pj1-f49.google.com [209.85.216.49])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 327EC378D71
	for <stable@vger.kernel.org>; Thu, 20 Aug 2026 02:30:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.216.49
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1787193009; cv=none; b=IEKXT/9HfM7zRj6T0JCbC3Bn6RhjirM/h1cHXbZdmA1+qZXaijqgGaVULv4ZxClb49OPH6lfOLuiCO1eummjYsrEG102Brm0/IuPs3A6P5UgRGDnk25gb37p2f8Ezh5vP5YlY25X7h6Di+xGK29gBHdxiBsPIBEsWrzViuicidc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1787193009; c=relaxed/simple;
	bh=I96efj2UiYa4vj9vgZjeZLHt3Qd0IMH/mDWVj7JF1Jw=;
	h=Content-Type:MIME-Version:Subject:From:To:Cc:Date:Message-ID; b=BfiJaBiKNQTNBgFKkHlqfRZXQ3xmAT0znDSCJlAuORfciXTqMW+lhf4CUpC0l3gMBBI1OfjAAJz4owXWDIPEUOO+inJKI4TgAXM+Wr094ymvi/ZrZ4lj+fV5jtCSHMN0IUZSflxNDJFLPtGzXBpwbz6nCkDkHiM5BsImhBSyVrU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=kernelci.org; spf=pass smtp.mailfrom=kernelci.org; dkim=pass (2048-bit key) header.d=kernelci.org header.i=@kernelci.org header.b=IiZ+iE/o; arc=none smtp.client-ip=209.85.216.49
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=kernelci.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=kernelci.org
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernelci.org header.i=@kernelci.org header.b="IiZ+iE/o"
Received: by mail-pj1-f49.google.com with SMTP id 98e67ed59e1d1-383cb94f742so1928008a91.3
        for <stable@vger.kernel.org>; Wed, 19 Aug 2026 19:30:07 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=kernelci.org; s=google; t=1787193007; x=1787797807; darn=vger.kernel.org;
        h=message-id:date:reply-to:cc:to:from:subject
         :content-transfer-encoding:mime-version:content-type:from:to:cc
         :subject:date:message-id:reply-to:content-type;
        bh=UDvj+olRoVGe5M6LpfTFfETzGAwNf4Y0tZ4kxaeaAzM=;
        b=IiZ+iE/o4Rs7aTzF/78eyulu86I1LHHpACzh6VTcTO+n9QMQWvEWl2qCxoY0u1FNYJ
         sHdf9ubrHBaoBQDWGSSI0bw503Jkz7hX6EiYeaPMh8L5rkLLMP+lbv6tjDYGS4/TZjwe
         Fw7j/L7Zc6AsvcAgndo3zR+5yYs+jNelx58c77x5EH86I7TiroKcIxMmo7MCSmOa2+4E
         Z7G7Xe/sCliHYZrweMdxjTFq0VrVnlgZIqIhYc7aEsCk5dXfvk+TlXFrOJG90zonnkSt
         FWX2LXiRG6JD0fX61i1NOB38jZeqM5HBKeNf/0hse58Ge4YqaKBIGdXhgTgUblooKm9f
         /Mlw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1787193007; x=1787797807;
        h=message-id:date:reply-to:cc:to:from:subject
         :content-transfer-encoding:mime-version:content-type:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=UDvj+olRoVGe5M6LpfTFfETzGAwNf4Y0tZ4kxaeaAzM=;
        b=siKkkKa/FMMlOSTP6WYVHJ8EFGefd4RcFhxgH0xsATdiWXMGF2ehHTrYVusMKhMTxP
         AHhh6sP2x+5/jMPSiZoSTcW5m8E8/gMT+YorHX4O6jXXALUYJdbN86FwAuZzwK8tLnE9
         KvQKjUGMiWx6ve39RdEe5k183ab9Ey+K/Zo1StxN2FDekf9HB3d/QjgQpRVXedhkLupM
         Yy77YyuG7jZ1JPpnrID1XyAHrMTIqXfrAJPIAme/0rqZadxekcZND2xQQBuQ8f1yhYmw
         qxd8H+WVmKqy9zi9mqIEqOAHT18ifTD3FuGHIU1xaUQCwr2GuR2h1kTo0nnfPVVzOD8b
         URyA==
X-Gm-Message-State: AFuF++ltK+OiJryKpGLN0fEsHVS0OTUk1CYArVPy78kjmLp/q7gQNoiC
	itCcQdBUkoIM5Y2uttzBZ/EyWnPxeyj2gKKDxO6pD9AJMTivLwpv6tGTxjkubJ+6pro=
X-Gm-Gg: AR+sD135XzrpWyu2VekXHjW1Zry4k5QDenmOgA3L6Ib9CbtNPCx/gE79ErOO6nJAcZB
	lX4xwDM2HPoPqAPl+V/K7K9FdmYy4uDdX1gkBQQIBeQuRTGFEuqK56vR48K6mGbdI2IaURJ7ASu
	lbsyF9lddrGGv6G6UytL4aODAkIHgH3wnFfK0/StiJh8GS7XNYBGJlr3oo8mlU+zixjnLTnSwVm
	4KdN6Bxpkd9cW1TKjW0ZXa2chqfUR9PxbRZ4H6b7zQgzwWC2veKB4IFYK2/TXbOZXVd5Ru9nQnW
	0+Ea97LoxajB1EdsDHQJ8Fgo7Ifl57mlfmc3aVoGCyU+S5Umf+EmWskzP2vQtAi6OS57x4mnPA3
	JuPsxwDrbuQoCPuJivy8G9mc4aREC1cc1QCRQdOGhVwHrqEzPcqnLnd0lg2s4Gp1qNRbO5ndmu1
	hHGgPrg4ahjaeP77y52woWyUjBXnSRJSHM3E7oOs/R8qMRhDJw3AAf
X-Received: by 2002:a17:90b:2b8e:b0:38e:75f3:ad4d with SMTP id 98e67ed59e1d1-39580f03c97mr17471438a91.7.1787193007203;
        Wed, 19 Aug 2026 19:30:07 -0700 (PDT)
Received: from b455de3d9de8 ([20.38.40.137])
        by smtp.gmail.com with ESMTPSA id a92af1059eb24-1416ad69638sm10331425c88.7.2026.08.19.19.30.06
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 19 Aug 2026 19:30:06 -0700 (PDT)
Content-Type: text/plain; charset="utf-8"
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Subject: [STATUS] stable/linux-6.12.y -
 3696cfb7acec262a298e60f9fc0da59d8fc2451e
From: KernelCI bot <bot@kernelci.org>
To: kernelci-results@groups.io
Cc: stable@vger.kernel.org
Reply-To: kernelci@lists.linux.dev
Date: Thu, 20 Aug 2026 02:30:06 -0000
Message-ID: <178719300587.432.3636055905704635840@b455de3d9de8>



Hello,

Status summary for stable/linux-6.12.y

Dashboard:
https://d.kernelci.org/c/stable/linux-6.12.y/3696cfb7acec262a298e60f9fc0da59d8fc2451e/

giturl: https://git.kernel.org/pub/scm/linux/kernel/git/stable/linux.git
branch: linux-6.12.y
commit hash: 3696cfb7acec262a298e60f9fc0da59d8fc2451e
origin: maestro
test start time: 2026-08-19 16:33:05.846000+00:00

Builds:	   56 ✅    0 ❌    0 ⚠️
Boots: 	   95 ✅    0 ❌    0 ⚠️
Tests: 	11879 ✅  769 ❌ 1551 ⚠️

### POSSIBLE REGRESSIONS

  No possible regressions observed.


### FIXED REGRESSIONS

  No fixed regressions observed.


### UNSTABLE TESTS
    
Hardware: qemu-arm64
  > Config: defconfig+netdev+nfs-root-boot+kselftest
    - Architecture/compiler: arm64/gcc-15
      - ltp
      last run: https://d.kernelci.org/test/maestro:6a85f4cb62f33761c0e795d9
      history:  > ✅  > ❌  > ✅  > ✅  > ✅  
            


Sent every day if there were changes in the past 24 hours.
Legend: ✅ PASS   ❌ FAIL  ⚠️ INCONCLUSIVE

--
This is an experimental report format. Please send feedback in!
Talk to us at kernelci@lists.linux.dev

Made with love by the KernelCI team - https://kernelci.org
