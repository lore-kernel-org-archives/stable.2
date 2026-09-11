Received: from mail-pj1-f53.google.com (mail-pj1-f53.google.com [209.85.216.53])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 987E6360EF7
	for <stable@vger.kernel.org>; Fri, 11 Sep 2026 14:59:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.216.53
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1789138758; cv=none; b=dPssH0GlsFi6WFHxj8s4O0dBKXjudEAJ+8ga2zsBTBkILqndXy9pud//LIqzOgQBQcFiNmkKpGLb+tQDe0/zMtmJGXuNHabCywHkOQHF1/uuioHgiDYCDWzRmqhlthHyTu35Nq991E+3npLBgE5AE87zgQYoXBGtZNzIt4VslAQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1789138758; c=relaxed/simple;
	bh=lneKoTgHExIaaUFVQrwuOSyolzJ4zUGIxi+7Wap8bJk=;
	h=Content-Type:MIME-Version:Subject:From:To:Cc:Date:Message-ID; b=Sg8nf3oRY9p+4mPp3Kx7XRWvInInaGTtqndl96XvhjOBznUtQ7Lbr0o/qvP7e1thr88EXVYKqyPcLnHPkGbdv4J1Bcka15LQcgyNfUS7VYOEZnIQhaINEg32w9rxEjnw88gsv59g0DCAJnfs40UQGur0WJK6JmZb4tVkjyI94oU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=kernelci.org; spf=pass smtp.mailfrom=kernelci.org; dkim=pass (2048-bit key) header.d=kernelci.org header.i=@kernelci.org header.b=g7BWH+3d; arc=none smtp.client-ip=209.85.216.53
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=kernelci.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=kernelci.org
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernelci.org header.i=@kernelci.org header.b="g7BWH+3d"
Received: by mail-pj1-f53.google.com with SMTP id 98e67ed59e1d1-38759bcd877so1121992a91.2
        for <stable@vger.kernel.org>; Fri, 11 Sep 2026 07:59:13 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=kernelci.org; s=google; t=1789138752; x=1789743552; darn=vger.kernel.org;
        h=message-id:date:reply-to:cc:to:from:subject
         :content-transfer-encoding:mime-version:content-type:from:to:cc
         :subject:date:message-id:reply-to:content-type;
        bh=f0uRZCJWEQ9hCKjaKM/0p/Jwo3143vIn0UDpgoWeGao=;
        b=g7BWH+3dBpFUVsLVJvwMFHg74A1fsbkkuvonx2H2U6Uzx39kR831+QBtWa6u9XDn02
         4AhEJeZqnAgFTEqXQmcLwfN+e5Ttsx3ExJnlaleVUmkklud6dM8pN9Dno64Wawsdr1XF
         5Va7EOsjgPy9nPyZcB1P6ZmVIxdrwVIFEjLrIrPhkb7W7tNnnFZyuglYw1Q5pW5KK1/1
         nnA2QzOfXQ+CrRQV86g0tYLT8YeyC/BiUh9u/jhfxpMwB9iexkfE+YRviGnLD3CRA5AA
         th1FTzttg4a28toYXzfS/SCCpKMYiUEbnpKkf2vwsl+UrFXiCfSdLwRPhBEOetkBE3jK
         QciA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1789138752; x=1789743552;
        h=message-id:date:reply-to:cc:to:from:subject
         :content-transfer-encoding:mime-version:content-type:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=f0uRZCJWEQ9hCKjaKM/0p/Jwo3143vIn0UDpgoWeGao=;
        b=UXvrv/DCEEdj1go57pUGneAcRn4/qzK8VroTvYvA2+fdM/0bQBu99yKKtCdzn5zRqe
         B7YxrGuxwE98wylEwXUqMdswp0+k5Ky/fUTMAZfv5sadaHieYLIz9+urJeOsozNuaD0f
         RRpNqny3EG7A2ttrF2gmPHHK50EVMNMu1SOi7DQEiBkdYslY0Z5KFKCbqR8vz4GGSLT9
         zYg1VXt/ZNezXO1eB9rc5BrIGemOUSgq6KftjQ9rL0St7d3HQe1SkhhTu4OqeCHU08Wr
         InrWYOohrV8jmyEjLiBltyIXMXDvkXR1cAjsRpN5/9Y8g07QCpYmBO15foQp3sZ2F3Wb
         ZN0Q==
X-Gm-Message-State: AFuF++n4kdBl5fkPwA0H3zewLTvy5HlFqUf1GPpJ8qMOUeemI/UVEPMI
	cu/AiaOQDzFJ1ssnuLNaPpOo0rnuOtRkWmqgNDbHIvNtm2MzE1UMinkSA0uZKwulzE2tliUzDJN
	/k1GY
X-Gm-Gg: AYBFou3zhqxKls3oxsrAV5IfGJ0y50OzvT5IaU0Fh6hrnhgXeUpgHdk6ozSdHi2/2w7
	UUTCgBMBMr+HIzGjNaMNdFaEHwpMUky22JcRkoCtoDoFrt4DPVrTJ77W5zfRDyOtKhWqgUydt6/
	uiJWGgcAXH1iWuZXy66NBLBBLVKmHAOHVhfUE8RfISKQEvK/LETZG03bbdkJJY1n9TnehWrNmk/
	0p7KcqoAhiDK9iE03YHDfS/HJgt+6NHnHcIF6JoXja3CzoWmtlGBshh2lOppExUN4Z/SIei4+bM
	DqCtr8+IPuNFMbQxdcLTzK4IkfORkLZNdX8b038C4bRhJH1LsZfbdRb7q8zzRl3Q7Ipkltfk4VM
	NhEu3VEqVcC3+bOxnlnx8LFxzCJ8sRR9Duyc5i0/3NEkhF+yXUDtMTvIxe3qgreq5WGucQQWkp6
	MNom/NOdxQeLpGuUqpbCzfMfsNVWPLUPM5v+AYzbZOGqGBfvjONVAYu1sm/VArA+E=
X-Received: by 2002:a17:90b:518f:b0:38e:97f0:aa4b with SMTP id 98e67ed59e1d1-39d9c1bef27mr8316966a91.13.1789138752308;
        Fri, 11 Sep 2026 07:59:12 -0700 (PDT)
Received: from 41049dfc76e5 ([20.38.40.137])
        by smtp.gmail.com with ESMTPSA id a92af1059eb24-14365b345a4sm6946926c88.5.2026.09.11.07.59.11
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 11 Sep 2026 07:59:12 -0700 (PDT)
Content-Type: text/plain; charset="utf-8"
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Subject: [REGRESSION] stable-rc/linux-6.6.y: (build)Error in vmlinux
 (/tmp/kci/linux/scripts/Makefile.vmlinux:37) [logs...
From: KernelCI bot <bot@kernelci.org>
To: kernelci-results@groups.io
Cc: stable@vger.kernel.org
Reply-To: kernelci@lists.linux.dev
Date: Fri, 11 Sep 2026 14:59:11 -0000
Message-ID: <178913875167.4387.10776491424232293680@kernelci.org>

New build issue found on stable-rc/linux-6.6.y:

---
Error in vmlinux (/tmp/kci/linux/scripts/Makefile.vmlinux:37) [logspec:kbuild,kbuild.other]
---

Log excerpt:
=====================================================
make[3]: *** [/tmp/kci/linux/scripts/Makefile.vmlinux:37: vmlinux] Error 1

=====================================================

When fixing this issue, please attribute this report according to the
patch submission rules:

Reported-by: kernelci.org bot <bot@kernelci.org>

For complete logs and details about the environment used, see the issue
on the KernelCI dashboard:

- dashboard: https://d.kernelci.org/i/maestro:0dc31b4882255aacf50a24a5d040070890a166ff
- giturl: https://git.kernel.org/pub/scm/linux/kernel/git/stable/linux-stable-rc.git
- commit HEAD:  c33bbcf64a1d0e2170b7cdee977e2c00e258a70f

# Builds where the incident occurred:

## multi_v7_defconfig on (arm):
- compiler: gcc-15
- config: None
- dashboard: https://d.kernelci.org/build/maestro:6aa40c1f20239ade90229eab

#kernelci issue maestro:0dc31b4882255aacf50a24a5d040070890a166ff

--
This is an experimental report format. Please send feedback in!
Talk to us at kernelci@lists.linux.dev

Made with love by the KernelCI team - https://kernelci.org
