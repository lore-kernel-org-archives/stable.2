Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=74.125.82.52
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1795618749;
	b=GBTuqvRIxV7/xg1A/pxXDaXTv3StwZ/mBLrncjmbdHNIiv3iXHVrAQRDArG4Wcl++y3P
	 zgixrQsFv+NAfuT7OvKisEoFY02R891Zvmv+CH84nznPlFNIAf2c1eaPrfuUBsN/UPX1i
	 Bj58CWlvXwTSnCUpYLeKFr0A6/atVNZLwXPRrsA+Ywq+uAHB0eLMmsu+mBl5pG9G2mGbV
	 MPrnXdoFQDL7c7FQx7+pGFGOJqATuPdNOEbeq7f3rFzVgEUpxqt/iP9Oh7WQ136AFoLuZ
	 toVyYhT8kidyd2tX5Xs6itvAnmbvI6KK0usZyMW6GyFJqpNdIpo+2hNennCuJt7u3xA==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1795618749;
	h=DMARC-Filter:Received:DKIM-Signature:X-Google-DKIM-Signature:
	 X-Gm-Message-State:X-Gm-Gg:X-Received:Received:Content-Type:
	 MIME-Version:Content-Transfer-Encoding:Subject:From:To:Cc:Reply-To:
	 Date:Message-ID;
	bh=WaBB5B/if+G2CrxRviqNKyS6myrOTSCbwtrsP+UqNzI=;
	b=iHF8XTYOK0ghkMO+SxR+heJ5cb7oxfsF/zXVdPSCiJtuJ9jlsjPqc12q0THSG6lyyUTE
	 lJqOmDdyeoD6yQV9ssNxj5wCIsAqPrRlH+PPHuWCogudH9nE4kWpgtgiWzHUYPteEgtNt
	 Ryo7+NqH8oxUQT1ohkt7Lo+fSkbEGRNmN8Xe5YCkqZdvi46AL8h3v0a54dFzvjd4wYU4m
	 enzirNcJND8OtU/h5UIB4Px4G/Y7Z6xtXYkGiJN/10Bwsl3Z6H1Elf+z29dee85AbjAA3
	 MOfNQ9agmWkkcqB6XtgKHw8wNfJB7b5EYaVGSwoPhnYYap3N6RqxhplXTOfZAuYa37w==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=kernelci.org;
	spf=pass smtp.mailfrom=kernelci.org;
	dkim=pass header.d=kernelci.org header.i=@kernelci.org header.a=rsa-sha256 header.s=google header.b=daZqjra7;
	arc=none smtp.remote-ip=74.125.82.52
Received: from mail-dl1-f52.google.com (mail-dl1-f52.google.com [74.125.82.52])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id ADE05606A323
	for <stable@vger.kernel.org>; Wed, 25 Nov 2026 14:59:08 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org ADE05606A323
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=kernelci.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=kernelci.org
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=kernelci.org header.i=@kernelci.org header.a=rsa-sha256 header.s=google header.b=daZqjra7
Received: by mail-dl1-f52.google.com with SMTP id a92af1059eb24-1b546061d58so13301081c88.1
        for <stable@vger.kernel.org>; Wed, 25 Nov 2026 06:59:08 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=kernelci.org; s=google; t=1795618748; x=1796223548; darn=vger.kernel.org;
        h=message-id:date:reply-to:cc:to:from:subject
         :content-transfer-encoding:mime-version:content-type:from:to:cc
         :subject:date:message-id:reply-to:content-type;
        bh=WaBB5B/if+G2CrxRviqNKyS6myrOTSCbwtrsP+UqNzI=;
        b=daZqjra7dNqbDdDJK1n958jCExjfzMjs2M6ts+BO3bm1vzUh4t35s3+QICgmuqqqIb
         hDnEfVIFL4iFK6Y+Xjv3W/TgeBJ4OWy67ZpikdMI67U1WCN/QBBm5EEfCvnDXSYimKbf
         OFLzzTAhTU/BsiBukRbiAJns5CmvvFwUlKNFoXzK25G/RVap7TLaWfCejDoO9CAxzOu4
         RDbhg2UkxHnen8ER1PWUtmsg1eK6tXvrxLakUjj4FH2hTUcWyZcxL+CRWemQ9pmMJDlN
         k7JV9xGPIhpAp85tHjbM2ZeaR5/hvXAOsxkVuR+wJlvzjM6URQ6LpGMblQyvyXfJXthN
         1zaA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1795618748; x=1796223548;
        h=message-id:date:reply-to:cc:to:from:subject
         :content-transfer-encoding:mime-version:content-type:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=WaBB5B/if+G2CrxRviqNKyS6myrOTSCbwtrsP+UqNzI=;
        b=jW5TaM1VP3WUf8fne+mK3tqWjVJPgUFENcK7LnFb8Av4/IWgfjB++6TroCq8OsSzd1
         SpI40v9CEk/8IrMdfSSYMO3CeHIXAfyBnUwOS2jjigia5yHLYz37Guzrq7fcq2oB+Mdi
         VakBCDYj6RSJHjI9hVHjvJPPGSXGApJ0LoYckpFCfl7Ml8P+7eTEsA5SGL+oQD73IH94
         zdZVxdduJVidwpWO1Qy36aHegwUCwqC9CNdKra4dhPLqQI3CGquM70seSuOt9BLbZGrZ
         qBz9s2WsaZer7rxdgGhP1LmPsMyCSfxM2wDpc1+Q3/06m+2t7j8AptP6Ab5eVvAussUL
         UbzA==
X-Gm-Message-State: APuU4Z9Iaz0BcdyyGqI87Po8+hcb4i0rZ1VzrhKJfuBK+NBqw3cX1yQy
	kstbyh9Jbg6Ww0qheEzK1tRgNeNRgsHhruY/RzSIDnAOgv8MClkOKKPUMFcSZVaCXx4nRyICclm
	XgSfR
X-Gm-Gg: AZFdTZdDW+uIrO/iR2ddK4fcG8bOeBdSAr7Sqy3mHFIEBckZs3AE31Tm0TV3kaMYF3k
	iBcLocHXK6bWJ6gUQwGTyAO781J9lD3x5LnjiQ2s3Xqf43MXu2E43Dub5xl99TpD9biCcYX5uRI
	X634RCOSvJlCnS1iqk9y9oFqxkewGpt1EXyaOf+mz5yTeGMGFfrkImv8ldlmLoZODaDfYwOPcj6
	9b+PBeU9Kws2tnC9UoPtd2g7sAGIK4kx828BT8tVBEIWh/3LmdSmcSxtBaRSU39IusapQ5N2+uc
	YFcth65vwATIdlX7n9wD/85nEej8ErAzby0YNQUPLBfvpivZDbq1UA8MkIq6coZvgRW//DuVrCM
	X2Ev9yYGJUilUW6vi9yMn4FzLiWSt54cRp+h48go26pPrFBZVxEb80EcB0OVWv4RtxbPA7pWXP8
	oNmUkflhYOius5AkdxJkDliKzTy38FRnfcfr2Gi2cNcbT8o/ruNYqA4TV1cwcM1MyuuVQapb6PA
	Q7lsYThdp+3PfGmq0t3VZNRKu2VWG0WAjubYfrFfsKyrCDOp+Kuo1CTPycajL0U6rmXBq+7JiP9
	mUcFaaMs5u9AuEU8fgT3EictCJJe8IRRfaPMiD2khC7t
X-Received: by 2002:a05:701b:428a:20b0:1b5:1a0d:b544 with SMTP id a92af1059eb24-1b5568a145bmr19987619c88.7.1795618747430;
        Wed, 25 Nov 2026 06:59:07 -0800 (PST)
Received: from 52d83ede7c60 ([20.38.40.137])
        by smtp.gmail.com with ESMTPSA id a92af1059eb24-1b55ff0e4e6sm35646615c88.11.2026.11.25.06.59.06
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 25 Nov 2026 06:59:07 -0800 (PST)
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
Subject: [REGRESSION] stable-rc/linux-7.3.y:
 (build)kernel/sched/ext/ext.c:4223:17:
 error: implicit declaration of func...
From: KernelCI bot <bot@kernelci.org>
To: kernelci-results@groups.io
Cc: stable@vger.kernel.org
Reply-To: kernelci@lists.linux.dev
Date: Wed, 25 Nov 2026 14:59:06 -0000
Message-ID: <179561874650.101431.4430229759480466436@kernelci.org>

Cc from: regression/stable-rc.yaml

New build issue found on stable-rc/linux-7.3.y:

---
kernel/sched/ext/ext.c:4223:17: error: implicit declaration of function ‘scx_reset_task_fields’; did you mean ‘scx_set_task_sched’? [-Wimplicit-function-declaration] in kernel/sched/build_policy.o (kernel/sched/build_policy.c) [logspec:kbuild,kbuild.compiler.error]
---

Log excerpt:
=====================================================
In file included from kernel/sched/build_policy.c:71:
kernel/sched/ext/ext.c: In function ‘__scx_disable_and_exit_task’:
kernel/sched/ext/ext.c:4223:17: error: implicit declaration of function ‘scx_reset_task_fields’; did you mean ‘scx_set_task_sched’? [-Wimplicit-function-declaration]
 4223 |                 scx_reset_task_fields(task_rq(p), p);
      |                 ^~~~~~~~~~~~~~~~~~~~~
      |                 scx_set_task_sched
  CC      block/blk-cgroup-rwstat.o
  CC      fs/stack.o
kernel/sched/ext/ext.c: In function ‘scx_bpf_dsq_reenq_task’:
kernel/sched/ext/ext.c:10432:20: error: implicit declaration of function ‘kf_switch_rq_lock’; did you mean ‘switch_rq_lock’? [-Wimplicit-function-declaration]
10432 |         entry_rq = kf_switch_rq_lock(src_rq, &flags);
      |                    ^~~~~~~~~~~~~~~~~
      |                    switch_rq_lock
kernel/sched/ext/ext.c:10432:18: error: assignment to ‘struct rq *’ from ‘int’ makes pointer from integer without a cast [-Wint-conversion]
10432 |         entry_rq = kf_switch_rq_lock(src_rq, &flags);
      |                  ^
  CC      arch/arm64/mm/init.o
  CC      security/integrity/ima/ima_appraise.o
kernel/sched/ext/ext.c:10450:9: error: implicit declaration of function ‘kf_restore_rq_lock’ [-Wimplicit-function-declaration]
10450 |         kf_restore_rq_lock(src_rq, entry_rq, flags);
      |         ^~~~~~~~~~~~~~~~~~
  CC      crypto/krb5/krb5_api.o

=====================================================

When fixing this issue, please attribute this report according to the
patch submission rules:

Reported-by: kernelci.org bot <bot@kernelci.org>

For complete logs and details about the environment used, see the issue
on the KernelCI dashboard:

- dashboard: https://d.kernelci.org/i/maestro:d8297e60fdf63bc24ae0a50880622d674e44b036
- giturl: https://git.kernel.org/pub/scm/linux/kernel/git/stable/linux-stable-rc.git
- commit HEAD:  15fae5bad807ac3cbe5fa7319a897a72db112bd7

# Builds where the incident occurred:

## defconfig+netdev+nfs-root-boot+kselftest on (arm64):
- compiler: gcc-14
- config: https://files.kernelci.org/kbuild-gcc-14-arm64-nfsboot-6b06f369286e1965ecb3ace1/.config
- dashboard: https://d.kernelci.org/build/maestro:6b06f369286e1965ecb3ace1

#kernelci issue maestro:d8297e60fdf63bc24ae0a50880622d674e44b036

--
This is an experimental report format. Please send feedback in!
Talk to us at kernelci@lists.linux.dev

Made with love by the KernelCI team - https://kernelci.org
