Received: from mail-pz2-f18.google.com (mail-pz2-f18.google.com [74.125.228.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6A6D04A99D4
	for <stable@vger.kernel.org>; Fri, 11 Sep 2026 17:59:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=74.125.228.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1789149549; cv=none; b=YJCPSoTy9S1+7G/sumfULTFEUQjd/krhye4PEHEVx2OQtg/BjQ6qT+pFGb9LCNMWgJ30A09shYQ9cLmlgJIFJMuSoNcE5Pftem+FiNIz7O6uz2N7OpJc7Ox/EsgAN5I5MN5OaQffT9ElLdmlQ/i6fQOpgOo/cLX28276Ap+8BHU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1789149549; c=relaxed/simple;
	bh=qD47CF6gMhrM1kILkkfZeGotlWRqG8+4NAl6QMSlpN8=;
	h=Content-Type:MIME-Version:Subject:From:To:Cc:Date:Message-ID; b=XO9ZAClZXFLixgA6EcA7BVXz85XJNxHH+HdUYcx8z3zLVMm1IdjA3SgQQlGXoTBLT1rDH7+ebFMPK0Y41qwZ3FgKw++6GhnXN0M1CX0cSEpZ3tKdNG3nrf3nvu7uWUwNGxJZGQMAFibJGkw5fPiDo9sXVn9BG/xQYDUpuwqc2y8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=kernelci.org; spf=pass smtp.mailfrom=kernelci.org; dkim=pass (2048-bit key) header.d=kernelci.org header.i=@kernelci.org header.b=MMMGn7l/; arc=none smtp.client-ip=74.125.228.18
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=kernelci.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=kernelci.org
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernelci.org header.i=@kernelci.org header.b="MMMGn7l/"
Received: by mail-pz2-f18.google.com with SMTP id 41be03b00d2f7-cc4bdf8abaaso274000a12.2
        for <stable@vger.kernel.org>; Fri, 11 Sep 2026 10:59:08 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=kernelci.org; s=google; t=1789149548; x=1789754348; darn=vger.kernel.org;
        h=message-id:date:reply-to:cc:to:from:subject
         :content-transfer-encoding:mime-version:content-type:from:to:cc
         :subject:date:message-id:reply-to:content-type;
        bh=NG12zH8wn5Fqd9Q2oW1gzTnhAvaniJ4DT43BjEHvrAU=;
        b=MMMGn7l/9RViWy4ySTRv3ApgDVfX+eaVOQGBzJqAoi17AWmm5oCySWN11ky3bQbVZ0
         BhruJXUjdy7wKRddlBmuW4BAIggEVmd6TrZCIgA0YGKZ6N0XRZaILmpBX6V0T2HMimZI
         DX4pqewoVSEWRPdeBCSX2SdvrfnFwqTuYhBDgZ6ZfWtRUpXOhR4DROTeVPhygPLvpjWQ
         jpsRMyqnc78IPKfuAExxtV41i9DvGTEQzah725sZdGkJ8wfW9B90oivlAPF686jZU9Ok
         5BD1fyIV5uHCXrYij/XXLT4okzDUH+mTZ8ziE8n7P3XIN4cylDCwk0MXPGxPua0CeJaF
         0AVQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1789149548; x=1789754348;
        h=message-id:date:reply-to:cc:to:from:subject
         :content-transfer-encoding:mime-version:content-type:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=NG12zH8wn5Fqd9Q2oW1gzTnhAvaniJ4DT43BjEHvrAU=;
        b=nJfSdtK0SYGJGVwcakhiv4cUpbF/g+jDxB5f/5vZBpL9eOeP0tju4FEGFisGQjhODm
         DR2TqSVNR/sI5tD4GBjEYY+CERbsG1/+vb7ae+NHyUTp8sRxOK2rq/xzLgVYbKpQFChi
         pjU/M6kBuyElowLBkdadNh3xKtCQpZzN7B28wzTFXZhOlEbSiDYMIzgy18aeF03pgN9O
         HqmPJKg9KpX7zmyRWqOElDe3HC1fWAZ6xDVHUkb5ii0milI6pk+AGKjG40zFZLWFqc60
         vwWB9hh3luRyQuIfjuR/NSYFRUk/858mx+BJG26EHy0sf3Di0B9+DhaMTkCbY0xhZ6Tb
         SWnw==
X-Gm-Message-State: AFuF++nsID8GBYEB+PEBizQSAEjE8koqSQFg1D+vaAq/vXml/odbukqP
	b0nSNp3yMYrTDLRPURAQiz1hu4qtcEvvAwQIdbYCIw2rsf4RixwZIdaxB4dwZHEodolBAdzlLV9
	MYiCH
X-Gm-Gg: AYBFou1npnFZRU+6Kt9rtfDPklUDoUww80hPwlGvOYkaaPhwRbsb+TiSkxz+lctayfA
	JqzbA/UPjryeoaaEGr7rKi3G3P3ZzayFQ0j0MLvlSco8MlN4gL1+DAZNQuVyIjESvjj+ZwOcLOf
	0LkykVBSV/FISLBxczbZ5WKLiP19M9Nm0k/LXfCovoUQylc8Av3YZW7beua6LwU4WQ0lnd17PQe
	mneQYZjfnmwN+H0x662GrVHu8ZAbx9fyDHd8wy56etWV/LY5wnYHNJ73x+7V/EBQS1o0JlnOeOB
	iP9XeXs6/Y4n+9SL8xd28CjxpNwZQlr4JESiMbo6umU0BjZQ/ymI1b47Y2H0p/1zktVrlBOlz0g
	Diou2HnO/+c2Z/VM73fYSXK2SyESFBf0a8YmPQl1hsc7c4+bD+ydwj0Ry9nQ3wCRXvi3/KuNKld
	4Thc/6Pnvx2/dS7Sg86fT7bE+aAaq5dmGB/fXm9uZL+sujqyEsjSlogCr+dqcXmWidkQ9hzUYm9
	A==
X-Received: by 2002:a17:90b:274b:b0:381:a766:efcb with SMTP id 98e67ed59e1d1-39d9bc6767cmr8659237a91.4.1789149547652;
        Fri, 11 Sep 2026 10:59:07 -0700 (PDT)
Received: from 41049dfc76e5 ([20.38.40.137])
        by smtp.gmail.com with ESMTPSA id a92af1059eb24-14365ba71cesm7988743c88.13.2026.09.11.10.59.06
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 11 Sep 2026 10:59:07 -0700 (PDT)
Content-Type: text/plain; charset="utf-8"
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Subject: [REGRESSION] stable-rc/linux-6.12.y: (build)unused function
 'hw_breakpoint_cfi_handler' [-Werror,-Wunused-funct...
From: KernelCI bot <bot@kernelci.org>
To: kernelci-results@groups.io
Cc: stable@vger.kernel.org
Reply-To: kernelci@lists.linux.dev
Date: Fri, 11 Sep 2026 17:59:06 -0000
Message-ID: <178914954652.4461.15832732054536039571@kernelci.org>

New build issue found on stable-rc/linux-6.12.y:

---
unused function 'hw_breakpoint_cfi_handler' [-Werror,-Wunused-function] in arch/arm/kernel/hw_breakpoint.o (arch/arm/kernel/hw_breakpoint.c) [logspec:kbuild,kbuild.compiler.error]
---

Log excerpt:
=====================================================
/tmp/kci/linux/arch/arm/kernel/hw_breakpoint.c:908:13: error: unused function 'hw_breakpoint_cfi_handler' [-Werror,-Wunused-function]
  908 | static void hw_breakpoint_cfi_handler(struct pt_regs *regs)
      |             ^~~~~~~~~~~~~~~~~~~~~~~~~
1 error generated.

=====================================================

When fixing this issue, please attribute this report according to the
patch submission rules:

Reported-by: kernelci.org bot <bot@kernelci.org>

For complete logs and details about the environment used, see the issue
on the KernelCI dashboard:

- dashboard: https://d.kernelci.org/i/maestro:f4698a1d9ed868307f47bc5d6953b068245c13e5
- giturl: https://git.kernel.org/pub/scm/linux/kernel/git/stable/linux-stable-rc.git
- commit HEAD:  f97429de1ef3e1b6f7986abbcb45bb115b876977

# Builds where the incident occurred:

## defconfig+allmodconfig+CONFIG_FRAME_WARN=2048 on (arm):
- compiler: clang-21
- config: None
- dashboard: https://d.kernelci.org/build/maestro:6aa40cbd20239ade9022a8bd

#kernelci issue maestro:f4698a1d9ed868307f47bc5d6953b068245c13e5

--
This is an experimental report format. Please send feedback in!
Talk to us at kernelci@lists.linux.dev

Made with love by the KernelCI team - https://kernelci.org
