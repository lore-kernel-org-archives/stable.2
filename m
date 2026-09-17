Received: from mail-pz2-f42.google.com (mail-pz2-f42.google.com [74.125.228.42])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D693B5A985E
	for <stable@vger.kernel.org>; Thu, 17 Sep 2026 14:59:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=74.125.228.42
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1789657167; cv=none; b=WZI07irxxwgVQYCIIC02aB78dPDsWAS404nnBqI0MFm5zTpOS7kDknIUqH7YbaIN2FfqReXf+/IPIHy9ybPdVhRDxp2LYGvsuV6ZdWuEQvlhqTdYe9qxwmWmJmdD+ZHgyy+P+grO71KvUSl34m/Mb9VC/RV9ecXHRF4JWEUBQcA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1789657167; c=relaxed/simple;
	bh=l6GF0LBTXTcTQOzhnoBqLiRaA/R8K4MshdC2WgAlke8=;
	h=Content-Type:MIME-Version:Subject:From:To:Cc:Date:Message-ID; b=FOrGYVJxa+4JLjuh+N4bm59FDjO8JteoO+n9XHGfw43WXiVakRkiqFTFe0OeYCNrs+ggngxgLP7OOPmYLuMOS/snNp9wUeTqu938JFJFR3HzqcdqOk3OHj0wmfMDZ7a2iuKyDIzVNTCt7ulTSAf5l8NtYP66YUHfTuDJRRnnAJY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=kernelci.org; spf=pass smtp.mailfrom=kernelci.org; dkim=pass (2048-bit key) header.d=kernelci.org header.i=@kernelci.org header.b=hu17Ww72; arc=none smtp.client-ip=74.125.228.42
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=kernelci.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=kernelci.org
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernelci.org header.i=@kernelci.org header.b="hu17Ww72"
Received: by mail-pz2-f42.google.com with SMTP id 41be03b00d2f7-cc1cea4bfd1so715287a12.0
        for <stable@vger.kernel.org>; Thu, 17 Sep 2026 07:59:07 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=kernelci.org; s=google; t=1789657145; x=1790261945; darn=vger.kernel.org;
        h=message-id:date:reply-to:cc:to:from:subject
         :content-transfer-encoding:mime-version:content-type:from:to:cc
         :subject:date:message-id:reply-to:content-type;
        bh=eT2GVBW23/SaQVfxZb7L/ZcZcqlvwBUvkBE0j4TSJqo=;
        b=hu17Ww72FhXildRezN0u6uoA1YCqAEQQql+N80uARWKm9+DQ7AutXecAN/M1/M9b3M
         7o8Jqv+JPPlbL82dahXipIFsZyrChB4ltH5rY7r0p52/Xk7XtKvEitA5DVwJpbxx5/3m
         YdM1rvNB38B9Gh7BCWzAQBziGPjgBBdoBOA8n/Xf607VHCU3Gpg6tLHGwvWi0PtxtyKS
         N+kGR3Qw7l9pIVYrtxqOYyLxQesWrOPN2E+OR0S6dyApH/ur7LLe2AV3t/Pk/J60duCF
         vm3/GkYPIDDMJkO263voROPp2bBoOyuNWVbWxopOKWbG+yrfALya6zPVU0PWL4MDffuR
         BkCg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1789657145; x=1790261945;
        h=message-id:date:reply-to:cc:to:from:subject
         :content-transfer-encoding:mime-version:content-type:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=eT2GVBW23/SaQVfxZb7L/ZcZcqlvwBUvkBE0j4TSJqo=;
        b=tIPbOqDmX5WxRtl/f6Vt40IHUQ/OkjjRqW1YBIUsor/6iY6CkBuZw70R1/sm85EIxs
         P1U3PyVpxvllJ+WZbMWTx1+2zC6zEIz4c7Lhm/Jcat/m9LYvoQKnN70vCfUPBEcdxMEZ
         EZDMuWjC6aKbtxXvl16VCe5YztUQJT8yUyifpa6zrl4UEcBiHb/umWpgpNSDjTExxQgX
         LM6OuF7Wn/IIgROONhpxAL2yW4CDSyf3C3vymwbo7HJ1Ch8a+hCaWZylmzTMxQzjSYCa
         TpyqC+P3a7wYXHsmEjCTj7uLNJO2hOOMhAbT7I9IqrzGtPJR4skT/5Lhaj+E+4GH6Yv1
         BAhA==
X-Gm-Message-State: AFuF++k4lQgmNoCc0AGJs2xsWFLsKy4naP9f5/dmBcxU/E6Gjs6sKAjV
	3wNXP1CyQbji6juFqBP3Y18fXpz/9jU4bQA4KOYDBLkNUhpMV1L0EojSFzJwekgxGFQ+3QCN0fp
	Euq+C
X-Gm-Gg: AYBFou3sVEOfDt2V+3wS42D+ZIptOWy++RgoaAHsUkR74bNGT+Ycn1kuKBilTR9fECi
	azogUpdLMJCX1SF1dkjcb31528F4vHqjgq4ZUypD0LkJcGcCmgtCzpmgFYveALPJnCIdzTzZFnv
	e8ibbX/pcLT+yR+dWes9FZhR6FUH9T8XJzFg6Pwa1JvQI+kgcIgvZb7HxU2mUNQVQu2gy8jQXGG
	CBv0zq2q3vLJTbHAXXDsiH9cwu4r4QYF8kLMwPp15Q5Yh1cKpbU03lT18XC8D2YF8HX+xHHMKlI
	57DiKnDMUTogG1fLpyTUAP7jauPHfylwazXRCzAB6R8EHB1/lwDjQCMdhZX0abFB6dr4JKLxdaO
	iIsGFOrSigEocozLy787NT7CG0rDHU3sbL2wdc78f59khcBOJmGjhUNAU6bmYcQ27CJ2jpXMeSG
	0nUkp+gb2Zg6WJ7qcUAedBkOOFFBquHEBuSXGBYMLGEB0R33NOd0JF0Nni6GV7myw=
X-Received: by 2002:a05:6a20:72a1:b0:3d0:8cbb:8c2d with SMTP id adf61e73a8af0-3dd5f40594amr16717201637.4.1789657145562;
        Thu, 17 Sep 2026 07:59:05 -0700 (PDT)
Received: from ec7b70f3a45c ([20.38.40.137])
        by smtp.gmail.com with ESMTPSA id 5a478bee46e88-33bf5b1d335sm18002955eec.28.2026.09.17.07.59.05
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 17 Sep 2026 07:59:05 -0700 (PDT)
Content-Type: text/plain; charset="utf-8"
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Subject: 
 =?utf-8?b?W1JFR1JFU1NJT05dIHN0YWJsZS1yYy9saW51eC02LjEyLnk6IChidWlsZCkvdG1w?=
 =?utf-8?b?L2tjaS9saW51eC9rZXJuZWwvc2NoZWQvZXh0LmM6MzgzODoxMzogZXJyb3I6IA==?=
 =?utf-8?b?4oCYc2N4X2luaXRfdGFza19lbi4uLg==?=
From: KernelCI bot <bot@kernelci.org>
To: kernelci-results@groups.io
Cc: stable@vger.kernel.org
Reply-To: kernelci@lists.linux.dev
Date: Thu, 17 Sep 2026 14:59:05 -0000
Message-ID: <178965714466.146356.8020338956930266179@kernelci.org>

New build issue found on stable-rc/linux-6.12.y:

---
/tmp/kci/linux/kernel/sched/ext.c:3838:13: error: ‘scx_init_task_enabled’ undeclared (first use in this function); did you mean ‘scx_ops_init_task_enabled’? in kernel/sched/build_policy.o (kernel/sched/build_policy.c) [logspec:kbuild,kbuild.compiler.error]
---

Log excerpt:
=====================================================
In file included from /tmp/kci/linux/kernel/sched/build_policy.c:63:
/tmp/kci/linux/kernel/sched/ext.c: In function ‘scx_cancel_fork’:
/tmp/kci/linux/kernel/sched/ext.c:3838:13: error: ‘scx_init_task_enabled’ undeclared (first use in this function); did you mean ‘scx_ops_init_task_enabled’?
 3838 |         if (scx_init_task_enabled) {
      |             ^~~~~~~~~~~~~~~~~~~~~
      |             scx_ops_init_task_enabled
/tmp/kci/linux/kernel/sched/ext.c:3838:13: note: each undeclared identifier is reported only once for each function it appears in

=====================================================

When fixing this issue, please attribute this report according to the
patch submission rules:

Reported-by: kernelci.org bot <bot@kernelci.org>

For complete logs and details about the environment used, see the issue
on the KernelCI dashboard:

- dashboard: https://d.kernelci.org/i/maestro:b3e766fec13f3a11b28bb597ecbdb890fe4bf6d6
- giturl: https://git.kernel.org/pub/scm/linux/kernel/git/stable/linux-stable-rc.git
- commit HEAD:  09da4c7d441294e4264cc4804d8bc76433d5e0c1

# Builds where the incident occurred:

## tinyconfig+kselftest on (x86_64):
- compiler: gcc-14
- config: None
- dashboard: https://d.kernelci.org/build/maestro:6aabeb99fc1857a999df143b

#kernelci issue maestro:b3e766fec13f3a11b28bb597ecbdb890fe4bf6d6

--
This is an experimental report format. Please send feedback in!
Talk to us at kernelci@lists.linux.dev

Made with love by the KernelCI team - https://kernelci.org
