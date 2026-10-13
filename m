Received: from mail-dy1-f171.google.com (mail-dy1-f171.google.com [74.125.82.171])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0CC0E3F0A8C
	for <stable@vger.kernel.org>; Tue, 13 Oct 2026 13:59:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=74.125.82.171
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1791899951; cv=none; b=FQqv+6T7t5df/eQkwyUU7Iu/bybgprdAg/+Qh16+I1r3fqddFTS0lvWQIo5Gb/Ln0WLoCi6cGuRn5Pf2vR/sAnt4RrFP4sHlnmn7NJAx8sXFr7h4vBW5jnI0GrDteyHbspUPvAipAXVmSV0JNjTQ0kCe8w63g4Ce2+85yXEZNdo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1791899951; c=relaxed/simple;
	bh=OpSn9n9dq7uOUvPbiFHQ2KL/LHAm9RykzJvbZJG0VP8=;
	h=Content-Type:MIME-Version:Subject:From:To:Cc:Date:Message-ID; b=uHizt3uD+5chNIsQOuc7b72MdM6m7oBnEb0hONZAWHJRYlG7hmGka0EnK5yfhvW1jjSfirpdUjbn4pOoGcIGRK+IG54Gcmu5yVSvMIgkKeltAuf4AEpFnbYlrwgqOjm+zF6ViZQeGywhi6u7TAcxe9upxxxm8qFHaYhGynfUhkA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=kernelci.org; spf=pass smtp.mailfrom=kernelci.org; dkim=pass (2048-bit key) header.d=kernelci.org header.i=@kernelci.org header.b=cemjMCqK; arc=none smtp.client-ip=74.125.82.171
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=kernelci.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=kernelci.org
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernelci.org header.i=@kernelci.org header.b="cemjMCqK"
Received: by mail-dy1-f171.google.com with SMTP id 5a478bee46e88-35a31bb9fb6so2275221eec.1
        for <stable@vger.kernel.org>; Tue, 13 Oct 2026 06:59:06 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=kernelci.org; s=google; t=1791899946; x=1792504746; darn=vger.kernel.org;
        h=message-id:date:reply-to:cc:to:from:subject
         :content-transfer-encoding:mime-version:content-type:from:to:cc
         :subject:date:message-id:reply-to:content-type;
        bh=z43N0k78xY9u1gk2XeCAGA5BfApKPDk2XmED9O8gcHM=;
        b=cemjMCqK6md7lD8YRxZff8Tt5s2qun9yZHDraPcnxX5FWQZvFI+W2EAy0To3fVgMsq
         IDKCrIjTacoMgY/Rx+/rXE+BBu21iZBuxWvKa7trDBgI7/zHrTGoIi9xQ1j8fGiyK5no
         1qeX09MpwBQlEDiSnd6vQuL39sgOxrP2qA1URDuuMqeDkK7YLCA3XF7/2FQgzc681azk
         De2b47hh7jnKDrhVfpRy8mYW9Is/BvmjxDhoqQYHXKtHc8oPGhVuQj3CZnSjz9DZPus/
         pNRff8Adcc/5EMaMbl20+5HZnhKtwJ8kAMVGmWClPImHHRt/0eVsT79sB8YLSqTuwhGs
         Cwnw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1791899946; x=1792504746;
        h=message-id:date:reply-to:cc:to:from:subject
         :content-transfer-encoding:mime-version:content-type:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=z43N0k78xY9u1gk2XeCAGA5BfApKPDk2XmED9O8gcHM=;
        b=zyYN4kJzhhPG5NBLqlADNcOD63x/zy4H59iLgWjh7ByNhPUXUfyV5HT4gqEHTDEWYn
         p84Mt8ewuv51hukMeJAGSBXiT8QPolXkb8sasp0AjsR3IA23CufKouFumEfgQrTq/wgi
         RZTdEJ/z7rG63cQFS6ZfoxzazI4DRXsmtAkIxQUg776pukvLP5KO67EdyEWSBOlZlUpg
         EIZuiYoq2TBzlNOYeksPnqaivR/wtTd0BczsdbHGC81fdBnbWU4vgJcBNZcQ/CnalFYg
         2DDLXDR3yoW1hPKkAw4/ela2AQeLQXCwEtIpSYClOsCkvm8ADj7ZW5WxNxbd5x4WQ9tg
         r5Xw==
X-Gm-Message-State: AFq9FYK3GiSI9d2aiS7N0+NK6+Dq0qy7LYXCluGQ4Wd98+mV8AeRLQI+
	AWKk4vnjb4JkLvIxjomBFm1gThNvLRL+mXtAwRBPf5o/EmccAd0pE/TlGglUyfplGRs=
X-Gm-Gg: AYBFou3D4nVicx0Q4A/3MGib5gQ+MMCVl++jCAhW0Xzndpe9SRaUETciP+nrsSSE9w4
	SN54VC7tZA8MIsvMb2nOsPQfxZ8P2Og+UB0S+jQ8zhEhLegWEWNh7nH0Leb7AL9CySXdPwzlObC
	ijCY0QKXrFcuvPHjUvis3wGI0vFqYgXvQaCIrfDJWs2PSFRHZOBHQEDktsmJYfiL6MAU4i14Olv
	XwRF4OuIP0xnpTz60XQ7rE9Z/s1GNcOkprabXAnpHJIWRNkXMXxQ4ZTGQq93uqYYUIPS0K+hwXt
	6Wl38XWyx1C69sdgSijPk0j+R+q2X28V5TGMhmzSGAGP7inqKG3ILjIEqpKlMe+cFTmM9OamS2z
	Bb2brAbi/fk7y41XLpb7aRfGIdGJ+jqyv/Z4lKhVAAXuun4X0N8SiMew+qSf5PCLYRY7XdTrfpI
	fZ3jYWYw3pzrIrIF1YaoYdhEwYvDf7MVNDU5lLHM6KEj96N942gpOG8niub3/ldOpSLmpdPQ8Nz
	Q==
X-Received: by 2002:a05:693c:87c4:10b0:356:4b46:9393 with SMTP id 5a478bee46e88-3564b46940amr14743780eec.24.1791899945848;
        Tue, 13 Oct 2026 06:59:05 -0700 (PDT)
Received: from 244668f92ec4 ([20.38.40.137])
        by smtp.gmail.com with ESMTPSA id 5a478bee46e88-3537c841648sm49971991eec.3.2026.10.13.06.59.04
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 13 Oct 2026 06:59:05 -0700 (PDT)
Content-Type: text/plain; charset="utf-8"
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Subject: 
 =?utf-8?q?=5BREGRESSION=5D_stable-rc/linux-6=2E18=2Ey=3A_=28build=29implicit?=
 =?utf-8?q?_declaration_of_function_=E2=80=98bpf=5Fatomic=5Fload=5Freg?=
 =?utf-8?q?=E2=80=99=3B_did_you_mea=2E=2E=2E?=
From: KernelCI bot <bot@kernelci.org>
To: kernelci-results@groups.io
Cc: stable@vger.kernel.org
Reply-To: kernelci@lists.linux.dev
Date: Tue, 13 Oct 2026 13:59:04 -0000
Message-ID: <179189994404.261652.13159578693708911661@kernelci.org>

New build issue found on stable-rc/linux-6.18.y:

---
implicit declaration of function ‘bpf_atomic_load_reg’; did you mean ‘bpf_atomic_is_load_acq’? [-Wimplicit-function-declaration] in arch/s390/net/bpf_jit_comp.o (arch/s390/net/bpf_jit_comp.c) [logspec:kbuild,kbuild.compiler.error]
---

Log excerpt:
=====================================================
/tmp/kci/linux/arch/s390/net/bpf_jit_comp.c:790:20: error: implicit declaration of function ‘bpf_atomic_load_reg’; did you mean ‘bpf_atomic_is_load_acq’? [-Wimplicit-function-declaration]
  790 |         load_reg = bpf_atomic_load_reg(insn);
      |                    ^~~~~~~~~~~~~~~~~~~
      |                    bpf_atomic_is_load_acq

=====================================================

When fixing this issue, please attribute this report according to the
patch submission rules:

Reported-by: kernelci.org bot <bot@kernelci.org>

For complete logs and details about the environment used, see the issue
on the KernelCI dashboard:

- dashboard: https://d.kernelci.org/i/maestro:8b4d37814a498128289dbab602b54c227d5c1d15
- giturl: https://git.kernel.org/pub/scm/linux/kernel/git/stable/linux-stable-rc.git
- commit HEAD:  b12a02dd090ec1b0b00fc16d1be95e7b53677ceb

# Builds where the incident occurred:

## defconfig on (s390):
- compiler: gcc-14
- config: None
- dashboard: https://d.kernelci.org/build/maestro:6ace294aa3f195e1aa7583cc

#kernelci issue maestro:8b4d37814a498128289dbab602b54c227d5c1d15

--
This is an experimental report format. Please send feedback in!
Talk to us at kernelci@lists.linux.dev

Made with love by the KernelCI team - https://kernelci.org
