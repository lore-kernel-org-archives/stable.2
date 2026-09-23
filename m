Received: from mail-dl2-f17.google.com (mail-dl2-f17.google.com [74.125.229.145])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 231CB493649
	for <stable@vger.kernel.org>; Wed, 23 Sep 2026 10:59:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=74.125.229.145
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1790161160; cv=none; b=cW0KFGL+HB3ns3Md02Cr4zyrfHp3aauUDFCl0uU8LjKnTWJeG2QsmkFU8dgAVYVORXzT+O5xrBiBUEUzcy8fJPt5RfcKclMjYX+BV2A6i6MAaco+e/8jCOWoosxkmhjVcLB0W/J9QqhPWElH+ArgDwVpSDoN3EO/h6IUQkxbZOQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1790161160; c=relaxed/simple;
	bh=8sxQBUTlNCzFikH2/f+ZlPnMoVhNsv5ROh8+GPYCB/8=;
	h=Content-Type:MIME-Version:Subject:From:To:Cc:Date:Message-ID; b=lG8FJSUjePuMn8ChZUE+SHNQ7D8CKL/csTbcRs248qNEiXCp4wzb8wXZwh6poITliSv0/U+vLBSGzhOgTXXj3Ye6W3RbBKMRY3dru93kIMCWc63a+cWpRXqOAJ5pIjwNwB28+lRLAlEdusLjtjpq+N1JxgPbxNatfgHieaE5RBw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=kernelci.org; spf=pass smtp.mailfrom=kernelci.org; dkim=pass (2048-bit key) header.d=kernelci.org header.i=@kernelci.org header.b=CP6j9JbD; arc=none smtp.client-ip=74.125.229.145
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=kernelci.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=kernelci.org
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernelci.org header.i=@kernelci.org header.b="CP6j9JbD"
Received: by mail-dl2-f17.google.com with SMTP id a92af1059eb24-143859f5737so1059875c88.2
        for <stable@vger.kernel.org>; Wed, 23 Sep 2026 03:59:08 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=kernelci.org; s=google; t=1790161147; x=1790765947; darn=vger.kernel.org;
        h=message-id:date:reply-to:cc:to:from:subject
         :content-transfer-encoding:mime-version:content-type:from:to:cc
         :subject:date:message-id:reply-to:content-type;
        bh=6kLbMNH1P1gcCdhV+pCeaj8QiO5ubMNnd2ZGoSmSd2k=;
        b=CP6j9JbDU/mPkEcDG4fcmVw1tf8h8p3eF8Pv512vlIEO8LkL5lftPNlcn4sOWSLBZu
         3ZNnn5ZOs+0El2tIDmwp2/RJViEvtHVfKFUg615OuVnjqv9lrjlGHNTYtFtKtbVJspn6
         uH5tMeeFGL5z2TIewkEMZuYcPUg1DgBbQZBpC43uoV6IGTMF5AaaRNEDsm+Jlfee5IwF
         qXgfXhEbC/pblkBrINkyd3t5dAvgWqnVlEofYhhzV24UaYINT5vXxPYEgPOyZhg8EAbN
         SGZ4QNzmG5nm9Vbo0YRpm5JHxE8S/GamlPGqZdlZAPeYRp9dLE1AHxEaAPL1lGYfpDmD
         aurQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1790161147; x=1790765947;
        h=message-id:date:reply-to:cc:to:from:subject
         :content-transfer-encoding:mime-version:content-type:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=6kLbMNH1P1gcCdhV+pCeaj8QiO5ubMNnd2ZGoSmSd2k=;
        b=0AbgwEcvvYS5gAQwRXU5OWE/TYhnbCjd88rTuAA/dBaysxiwsgoYzGbhVA46BaXhEL
         VJ8CRi57JX/zhJ3LRoohIJyDO6+hM6PlXmPb0Nb7iffju3ATdTCtod/8EA581XVOKRS7
         Nsg1mebHCSeW01PeF+/SAAmBCL5c+8YZHN7R6Yd9x9aTo6KUkB3CuVgDf1UAQzgT76Cs
         /MNsHlVFbk6sMCBPuEl8S31DJBlT5SuxJNFyBDqgNf7omkhNSYMKjvqjF4RPZlUWg7D3
         oik1Nr1tQqdl+9EwZF53K+o4BXmPOtU0FWXnJ5h4KTCa/6jar6u4kmYKy4CcXgyXvAAW
         SKVA==
X-Gm-Message-State: AFuF++ndQlJ6G3Ke7q01n4p3FVrHIgeLDRpcwfCq3MUfxXFn2UgU9CRr
	y3x3MOV7qrMJf6sKoBMqj/sXkOaycKd1zqAn5m5QsubZr2KV4ajXPSDrq2/YxivkaUOW/k9E7Td
	98qRJ
X-Gm-Gg: AYBFou1/wlc1Tm3pfCgHxkLt9gpR+Oralyhac+zYtDUmFuXq/fIpe9Rf5ed07v+A7+f
	drwueNzeoyRrdRN/y9cVwcucB7du5pr6HnxI6YDpcHhUR6KyBrmFp8pPfvDqdcBr4uf417cY6UD
	NaKtZx0bjVTW1X3T8V+cE/YEheS9kiQuJ+GlkTPL8uW44ZUUh9bC91Zhd0xPLvUYJqHIthQgiZt
	sIl+PRHXR0pLhFdUTdcrKXjaDgSsR3TqfNVDa+yK/jjBGBf1c9veB2N2xWLJTXwUyAvjiyc5FHl
	m1q9KNOivoK2hQPCaJBLfkffFDRkUPKqOTC5jzomSZQbtq+Xu1BlTl+vcL4GnWykrGKRmOIBK6q
	ZW3BEsCB2WP0a4NB9lieCdAyNXNpzzJOAPN+qdGl4ZgREeU9uRdvsyY2M/IarcFJbhYhpFx7GdA
	xfDu6MWb7oLRiId99Sll+GIWcAz/OLCuVQc6jaW6bvzlxI1ggie0ucMZvA9VT0FFGJxrYohPUb/
	Q==
X-Received: by 2002:a05:701b:2089:20b0:144:c11c:3710 with SMTP id a92af1059eb24-144f91794ffmr2772402c88.31.1790161147391;
        Wed, 23 Sep 2026 03:59:07 -0700 (PDT)
Received: from ec7b70f3a45c ([20.38.40.137])
        by smtp.gmail.com with ESMTPSA id a92af1059eb24-144f983c5a1sm9718633c88.7.2026.09.23.03.59.06
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 23 Sep 2026 03:59:06 -0700 (PDT)
Content-Type: text/plain; charset="utf-8"
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Subject: [REGRESSION] stable-rc/linux-6.18.y: (build)"do_timens_ktime_to_host"
 [drivers/misc/ntsync.ko] undefined! "init...
From: KernelCI bot <bot@kernelci.org>
To: kernelci-results@groups.io
Cc: stable@vger.kernel.org
Reply-To: kernelci@lists.linux.dev
Date: Wed, 23 Sep 2026 10:59:06 -0000
Message-ID: <179016114636.454291.10412763598292369896@kernelci.org>

New build issue found on stable-rc/linux-6.18.y:

---
"do_timens_ktime_to_host" [drivers/misc/ntsync.ko] undefined! "init_time_ns" [drivers/misc/ntsync.ko] undefined! in Module.symvers (/tmp/kci/linux/scripts/Makefile.modpost:147) [logspec:kbuild,kbuild.modpost]
---

Log excerpt:
=====================================================
ERROR: modpost: "do_timens_ktime_to_host" [drivers/misc/ntsync.ko] undefined!
ERROR: modpost: "init_time_ns" [drivers/misc/ntsync.ko] undefined!

=====================================================

When fixing this issue, please attribute this report according to the
patch submission rules:

Reported-by: kernelci.org bot <bot@kernelci.org>

For complete logs and details about the environment used, see the issue
on the KernelCI dashboard:

- dashboard: https://d.kernelci.org/i/maestro:4b26eea0602675b355b59a86260e45ab159d4bba
- giturl: https://git.kernel.org/pub/scm/linux/kernel/git/stable/linux-stable-rc.git
- commit HEAD:  eccdbf0d3a832ccf6c732cdb37c3b39ea88fb4f3

# Builds where the incident occurred:

## defconfig+allmodconfig+CONFIG_FRAME_WARN=2048 on (arm):
- compiler: clang-21
- config: None
- dashboard: https://d.kernelci.org/build/maestro:6ab38f98d96a8203de845fd4

#kernelci issue maestro:4b26eea0602675b355b59a86260e45ab159d4bba

--
This is an experimental report format. Please send feedback in!
Talk to us at kernelci@lists.linux.dev

Made with love by the KernelCI team - https://kernelci.org
