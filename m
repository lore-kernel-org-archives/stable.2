Received: from mail-pj1-f48.google.com (mail-pj1-f48.google.com [209.85.216.48])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A5D5537E5EF
	for <stable@vger.kernel.org>; Fri, 11 Sep 2026 15:59:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.216.48
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1789142347; cv=none; b=k3tZc9u/lypzsR0oWzaegfoXuagH3hVVbnu6+kNukz9IzfX8ADId+Y8weiM/XDYz8+giHSKuDgKpYA+UQfqxBlbYp81BKfL66LzHBtTCZcrVFrp0PNnJfnyHBLKE7RCPKSKBM8Zy2Kyh9vHx2+9YLYvr/LsnxgW983ImD3/MyII=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1789142347; c=relaxed/simple;
	bh=/JfE4Lg7oqdAKUZHEbu+3XZvfmZUnSxqKdtfyOAYB9Y=;
	h=Content-Type:MIME-Version:Subject:From:To:Cc:Date:Message-ID; b=p5sRujkRWX5pwGPzGeq9r2mToDOXK36EAaJs5T2ZGv0DYIQC8eERfBYcFrTtntoik6eWimiajwV9ZNAbEUaBYwPLByO4VyNVwDeFW0Qw371P3BirbbVykWU4Tjauk8IRx8b0kQLUwkiy4/PSJ5AGZYpAXsk6yNGdKNxq4QWDsRs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=kernelci.org; spf=pass smtp.mailfrom=kernelci.org; dkim=pass (2048-bit key) header.d=kernelci.org header.i=@kernelci.org header.b=E7/YGICm; arc=none smtp.client-ip=209.85.216.48
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=kernelci.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=kernelci.org
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernelci.org header.i=@kernelci.org header.b="E7/YGICm"
Received: by mail-pj1-f48.google.com with SMTP id 98e67ed59e1d1-381b831d535so1886831a91.0
        for <stable@vger.kernel.org>; Fri, 11 Sep 2026 08:59:05 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=kernelci.org; s=google; t=1789142345; x=1789747145; darn=vger.kernel.org;
        h=message-id:date:reply-to:cc:to:from:subject
         :content-transfer-encoding:mime-version:content-type:from:to:cc
         :subject:date:message-id:reply-to:content-type;
        bh=o8Om3hw5f11FgvCXzdAphMqGPzWl9znXaV8BHa6FwBA=;
        b=E7/YGICme6wuBroWTIHsSKRORIErS9EdGZ/K7EBdiy9aY0TukabXRkOrb2Yicj3kp7
         2t2CyhEMptuaK3JN2lMrTHfeJpsJb6g7hXhUUEJ4eVdQSmuH6ZaSaz/QwRl5Z4qoSm50
         YNafMsQ5LBKXZr8a4jr/lH5khmecYQBelrRsbJbaDFD1tNd/Jd6MMgetHfdRAwoGZL4s
         uMBS0gb4rYr1tJ34/oLi7mZ/Jswwv+MBig21TSNElMvtQ26gC85d5k8AjhtH0D3GXHP3
         gxCHnP8JWL++Y9sEuaRcf8s6T4kHgFkPEdCDXkK4Li2X3EbQRsXVPTivkrtSxb77s60j
         m84Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1789142345; x=1789747145;
        h=message-id:date:reply-to:cc:to:from:subject
         :content-transfer-encoding:mime-version:content-type:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=o8Om3hw5f11FgvCXzdAphMqGPzWl9znXaV8BHa6FwBA=;
        b=NKmInQ4uxg69gfAJzYwj0SQyli4Av1rXhV1Enfna3hbcb+nU82JnJCa7dOHrEER8o6
         HFMl9Y5rrTQFLbXOCvdIP/310+AIC9vtbuiLm+Jfp/B5kNNU8o6kv4k0qIvHtFIGOnK3
         1Po2vMdFP2LKQeIFL2lPTawOK+X8tZhuYqxSIBV7ImRXMxZfW+/bVIYJOEUL5JTJ5e0Y
         K4QOQ2EI7UJ0St/NrXfTBuKWY/Dz43Ok9YASJc6vjcDOD7jvwJrQwlNRV0zLCV1LPHn2
         0TYk3c3XWyYxtIc8v4VXImHhewm0zQfyJX3ptqQrQUmikGODL8eiXfKYmyaA9wtCg6mk
         W5hw==
X-Gm-Message-State: AFuF++mfBtUzc57MdbIvtMFRUls6ieA7Q+deZXM12e30i9N9EOT1Engd
	Yuu1rN4El5W2bDAazuP0LCgrHo1Jvrx1KJ4uxZ7NUVFg4js3/pYQKOpSkRd361WLgSc6m+WPL6I
	WnD/V
X-Gm-Gg: AYBFou1P0aX9AsITi6OP8VSFoLijrihHA2DrV+e6madsMq/nKEz+ILVTZ6xYh7uHpte
	1X7IEosr9w+t1n2T+5GRSzzvs/xcikvY5Y2bUGE8yDdmE0IJ3aAbGLWWVGYyU4RfAMmv3rtbaBo
	VUl1+FpjAOcZT5TZyt57704nXjBfUnR6H4DalgRA/+Ka+CsKJZ1By4gDfXJj+1ilA0l0PTwQjR9
	gF0Oq8l350wYPodDBdiP+y6rE7wmo6GEs5jvdyv2qU8eyYIgg4Un2KqOxVJDItWAYJ1BBOSBjsv
	W2LCr0DMBNN2xUpdoIpcJbzNH3rQUEGGjZaTiVVrXvmD+c0QwBhECAx89Fn+FMg8oLfHIo+31dl
	FHiPHvdck5FPZepNMV7EvWjkPP952DvoaRn8V9dYqtxCok9OLttYULMFJNhH/k73rqztUC6qZ+Z
	2DzxCndIPL/7thEcUPgqHFiwcwnYBrhJVYp9EPyL785mruBT1aehjYjLq8rdW1eGo=
X-Received: by 2002:a17:90b:384d:b0:398:e1f4:bda1 with SMTP id 98e67ed59e1d1-39d9c22ccc0mr7674547a91.21.1789142344863;
        Fri, 11 Sep 2026 08:59:04 -0700 (PDT)
Received: from 41049dfc76e5 ([20.38.40.137])
        by smtp.gmail.com with ESMTPSA id a92af1059eb24-14365ba729dsm11677423c88.14.2026.09.11.08.59.04
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 11 Sep 2026 08:59:04 -0700 (PDT)
Content-Type: text/plain; charset="utf-8"
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Subject: [REGRESSION] stable-rc/linux-6.6.y: (build)Error in
 kernel/irq/irqdomain
 (kernel/irq/irqdomain.c) [logspec:kbu...
From: KernelCI bot <bot@kernelci.org>
To: kernelci-results@groups.io
Cc: stable@vger.kernel.org
Reply-To: kernelci@lists.linux.dev
Date: Fri, 11 Sep 2026 15:59:04 -0000
Message-ID: <178914234393.4405.14635753584190290248@kernelci.org>

New build issue found on stable-rc/linux-6.6.y:

---
Error in kernel/irq/irqdomain (kernel/irq/irqdomain.c) [logspec:kbuild,kbuild.compiler]
---

Log excerpt:
=====================================================
/tmp/kci/linux/kernel/irq/irqdomain.c:361:(.text+0x160a): undefined reference to `irq_domain_remove_generic_chips'
pahole: .tmp_vmlinux.btf: Invalid argument
.btf.vmlinux.bin.o: file not recognized: file format not recognized

=====================================================

When fixing this issue, please attribute this report according to the
patch submission rules:

Reported-by: kernelci.org bot <bot@kernelci.org>

For complete logs and details about the environment used, see the issue
on the KernelCI dashboard:

- dashboard: https://d.kernelci.org/i/maestro:af915bdb03e59523461e04025b059c64247c7293
- giturl: https://git.kernel.org/pub/scm/linux/kernel/git/stable/linux-stable-rc.git
- commit HEAD:  c33bbcf64a1d0e2170b7cdee977e2c00e258a70f

# Builds where the incident occurred:

## allnoconfig+kselftest on (x86_64):
- compiler: gcc-14
- config: None
- dashboard: https://d.kernelci.org/build/maestro:6aa40ca220239ade9022a6fc

#kernelci issue maestro:af915bdb03e59523461e04025b059c64247c7293

--
This is an experimental report format. Please send feedback in!
Talk to us at kernelci@lists.linux.dev

Made with love by the KernelCI team - https://kernelci.org
