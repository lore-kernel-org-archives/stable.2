Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=74.125.82.45
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1793836747;
	b=DYC0aZDc1GhIw4U42Qw8syqhAoEJf4V7ywMW6Xg6NHr4eM4n9v/NcPvjMej4J9ntx3Ih
	 AvP6lyE9tj8zvMpwBBoSqKWOnfmycNrluTD39X7Ycq9bQ3BeDPSqpfMXtxAVTuRwTH6FB
	 98Lm9dgpaxsqs+3l3T0AsQCFFNfQEoqKnFcQrBJ82tVeDYu8CB5fi3hxKfRQ21msY/VLS
	 p79P/iAvYwEGhcByjfGLPbjl6GLiTZ8jN6vau8GbQBOh98LaEhux7/miAWzaJ4F1R66EA
	 UiHgH5dZY9mnM5SnatUrqBiPDz+hwKn/pnbp/1yKBBO3ygRSJbqD6N/Kzt/t51Tynaw==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1793836747;
	h=DMARC-Filter:Received:DKIM-Signature:X-Google-DKIM-Signature:
	 X-Gm-Message-State:X-Gm-Gg:X-Received:Received:Content-Type:
	 MIME-Version:Content-Transfer-Encoding:Subject:From:To:Cc:Reply-To:
	 Date:Message-ID;
	bh=ZAW49mrPjmSavDhvBlC4enHbMMcUKzrQPNMyElFcGuw=;
	b=36tVHJK8HvXixPci1F9dI1j8I/k2XJU4eRMeGBeig0+Bdxn3uVfyxDkefwXHC+XcOE6D
	 Dw5qtBC1bPP+fesumINRKDDRbHzVis8ZJvoHAfglaZCyMb0sJmgYMdwps+rNpyl63dhAK
	 gaHM5Pm5vpFVOSldY29/KqoQ3u/XkGYsCgl8m4xiayFJmRFzyZfH8ZUz69XHhvZpF2TJl
	 pZz7jcmAFHzV8WbEWnGYtTRelb0MLIZg921UMyGL6IrnyhYACeEBymst4uUIM1RZwo5fy
	 GY1Vpty5xmACNDkd20NHL8w5wephU+ywHjt2L9yFbFW9Yh99z8uYWZo5x4mkmmybWeg==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=kernelci.org;
	spf=pass smtp.mailfrom=kernelci.org;
	dkim=pass header.d=kernelci.org header.i=@kernelci.org header.a=rsa-sha256 header.s=google header.b=VavxQai3;
	arc=none smtp.remote-ip=74.125.82.45
Received: from mail-dl1-f45.google.com (mail-dl1-f45.google.com [74.125.82.45])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6F7ED606A326
	for <stable@vger.kernel.org>; Wed,  4 Nov 2026 23:59:06 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 6F7ED606A326
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=kernelci.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=kernelci.org
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=kernelci.org header.i=@kernelci.org header.a=rsa-sha256 header.s=google header.b=VavxQai3
Received: by mail-dl1-f45.google.com with SMTP id a92af1059eb24-1a3c08d6928so1993794c88.0
        for <stable@vger.kernel.org>; Wed, 04 Nov 2026 15:59:06 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=kernelci.org; s=google; t=1793836746; x=1794441546; darn=vger.kernel.org;
        h=message-id:date:reply-to:cc:to:from:subject
         :content-transfer-encoding:mime-version:content-type:from:to:cc
         :subject:date:message-id:reply-to:content-type;
        bh=ZAW49mrPjmSavDhvBlC4enHbMMcUKzrQPNMyElFcGuw=;
        b=VavxQai3WWx3pEtPpcg2d4H8fLzICkAuKvCbfOa/Xp5Z2q0WgRzwaMSdMuw23HPOWK
         7t2rVJ03ACysWJbZL1OqvoDsuseqT2oJVbSxRo8ASrUHegLU+pudaG59ujdfwjyi2jBS
         zDcIEowq7CjTia1BcYnvIyqR6Tu3yNrcYWNlgVAkKqRV8SknNtjbPjAJkFhuXJtzvpSI
         vowtGLtwpnaS3cp5yXDn3KHAiuVB9XMQWdtTXeUenwNWHpp/55SV9rNL/+SglfLaVtbZ
         LJacCkOs4uKwZ0EAP8GQ3AdOPGwkDpYePkGtYNzOuP48JqXqKIdRPMPIneuiXHWuWDMz
         rd7g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1793836746; x=1794441546;
        h=message-id:date:reply-to:cc:to:from:subject
         :content-transfer-encoding:mime-version:content-type:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=ZAW49mrPjmSavDhvBlC4enHbMMcUKzrQPNMyElFcGuw=;
        b=w/6rHaECvqwiZEVkTxl8++h0YAOhA9r3dkm2V+YpAOGc4nlV4aimSUfoUdjase+94k
         aXAWmZhBvd9jwlGnsOMFGSrS8GLsqYC7CZFWYPM/MUv9R1B/OScRsuaLJ3JhkugSZIB6
         wxsjQZd7Y1V2+tfwSM5lw0CHnHpnWUUahAzDroAeCjh14IG+3w5L8MwkKP/JGssXGhyd
         1gpoNXFGfY/poB4X81+tZAnfnHjELOBUA7wsKcinyYFXHvnyrz+xgJ2F/r4BrFEjdx17
         A6c4Rtf7SmhM0HMm+u+ej2jBIaZEuUMuXS2DNUE0BFARjzty7f/w6sI08ovx7eFVZO6E
         D7vA==
X-Gm-Message-State: APuU4Z9qB2oMXUk7m5DTirkuNhqpNl4oZfI9DRhfsZ8FhkY1kUV5B7vc
	tuiV4pOY4vJig/x0/ChExSgQe1epNCe6bWPahoJpjCNRv+Bo3Qi3h5CQ7xJjJRoZgTM=
X-Gm-Gg: AYBFou0j9o2nTFxJ9IXo4pWEJOoljyggdqQYM6e1B3eujP3KugR4vYYVPL0vuSZlADY
	/VMiF8bUl6sk0nDQEun6aO4PILdVAMCXEGJ9CT1zTZS7PjPhoPThi6A7/zNAcx3N0JW3ClncJy7
	eVWeVBmqP0HvVMKR3jsQPUNaRN7IwAZ3V3/an4p5QnRhL6E8gQZNydbZ1xvaAdHq6RWKFmYEGg/
	nbro39WMjbhRHMDzdZb4ekLGHmUXXJ4TZunl9IU82d8L7WDKhSpibWTE5bruS6AId3m8NDsTwWd
	/UPrJzwyaL8L41aeIhZuRUhGmOWh/KyWEuPu9x++aQkxt3D+RjvjxvLdR3aUxPXpY4wDrj7Ldif
	cTHKH3nRFDQrVwnM5xUdiaO4mVCa6W0xDXL7gA6W9iZ7PaGGePrHBmrFMj54rVXEdFEd7OPXLHF
	I1e3DnYVcEtOL5lSfrItcFDxWYUAUfAwLw1RNP/1VP8aLn5UVMIm/WbKXJsvFLQEKVZXeCaGE6P
	RtetVsp3qxkTkCZ67rFgPXECkLgZpimtKcuAisQvZsLH9hNAS4Q+6jNtUspu0l1Q0LjVaIWRJxv
	UaHke5Wl0E+NYVQuZPuIQA==
X-Received: by 2002:a05:701b:2094:10b0:1a9:f3d2:6262 with SMTP id a92af1059eb24-1ac5d69f68amr26356080c88.36.1793836745379;
        Wed, 04 Nov 2026 15:59:05 -0800 (PST)
Received: from 34406640b1f4 ([20.38.40.137])
        by smtp.gmail.com with ESMTPSA id a92af1059eb24-1b245b86fbesm11537444c88.1.2026.11.04.15.59.04
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 04 Nov 2026 15:59:04 -0800 (PST)
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
Content-Transfer-Encoding: 7bit
Subject: [REGRESSION] stable-rc/linux-6.12.y: (build)variable 'error' is used
 uninitialized whenever 'if' condition is t...
From: KernelCI bot <bot@kernelci.org>
To: kernelci-results@groups.io
Cc: stable@vger.kernel.org
Reply-To: kernelci@lists.linux.dev
Date: Wed, 04 Nov 2026 23:59:04 -0000
Message-ID: <179383674392.336012.5392884383674920352@kernelci.org>

New build issue found on stable-rc/linux-6.12.y:

---
variable 'error' is used uninitialized whenever 'if' condition is true [-Werror,-Wsometimes-uninitialized] in fs/xfs/scrub/agheader.o (fs/xfs/scrub/agheader.c) [logspec:kbuild,kbuild.compiler.error]
---

Log excerpt:
=====================================================
/tmp/kci/linux/fs/xfs/scrub/agheader.c:119:6: error: variable 'error' is used uninitialized whenever 'if' condition is true [-Werror,-Wsometimes-uninitialized]
  119 |         if (agno == 0)
      |             ^~~~~~~~~
/tmp/kci/linux/fs/xfs/scrub/agheader.c:386:9: note: uninitialized use occurs here
  386 |         return error;
      |                ^~~~~
/tmp/kci/linux/fs/xfs/scrub/agheader.c:119:2: note: remove the 'if' if its condition is always false
  119 |         if (agno == 0)
      |         ^~~~~~~~~~~~~~
  120 |                 goto out_xref;
      |                 ~~~~~~~~~~~~~
/tmp/kci/linux/fs/xfs/scrub/agheader.c:107:13: note: initialize the variable 'error' to silence this warning
  107 |         int                     error;
      |                                      ^
      |                                       = 0
1 error generated.

=====================================================

When fixing this issue, please attribute this report according to the
patch submission rules:

Reported-by: kernelci.org bot <bot@kernelci.org>

For complete logs and details about the environment used, see the issue
on the KernelCI dashboard:

- dashboard: https://d.kernelci.org/i/maestro:57b87afb5e3ac481ec23c2895df52d264d72ec7a
- giturl: https://git.kernel.org/pub/scm/linux/kernel/git/stable/linux-stable-rc.git
- commit HEAD:  466b74dd0dfcfa0b6103a22a0031605f1c61a067

# Builds where the incident occurred:

## x86_64_defconfig+allmodconfig on (x86_64):
- compiler: clang-21
- config: None
- dashboard: https://d.kernelci.org/build/maestro:6aebb1d55b429d354eef1d93

#kernelci issue maestro:57b87afb5e3ac481ec23c2895df52d264d72ec7a

--
This is an experimental report format. Please send feedback in!
Talk to us at kernelci@lists.linux.dev

Made with love by the KernelCI team - https://kernelci.org
