Received: from mail-pl1-f182.google.com (mail-pl1-f182.google.com [209.85.214.182])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 021B9430CE3
	for <stable@vger.kernel.org>; Tue, 21 Jul 2026 22:59:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.182
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1784674750; cv=none; b=D5ju9kN+88qCV29Sq/BZnmML3K5DFwoNDqknr+uKGRvxOtc/7GJh2+uiXd9BCh1O4LCLb2Ds56a+CYpOOT7u+qrQyeAH3jJrHntQ7V98Onj6ZrlYHpFSL/1IfEAfMlJNEb+z5m8jktgxirvUKREPRK0V+lPJfGs7L+xeTHXWvFY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1784674750; c=relaxed/simple;
	bh=avwoA1EVgx48S2/IPJLWt3D6QxNvxs9Y9c29OuIuk2o=;
	h=Content-Type:MIME-Version:Subject:From:To:Cc:Date:Message-ID; b=svTJ9yZP6dsqwLYU88w32+e3XWewtPY7NpQl2LWOVoNw0xFgY2vGICGmJXAGbh86s2pffXow1loQmoDldA+WJLXxkpkXjHI2r8aIuWVUeCunlHHRJ+5mtNUVWHONZ56rRio9zDj13Fo0sX9ekG2h6b/zDnh1E0nmJUTVBBSXuE4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=kernelci.org; spf=pass smtp.mailfrom=kernelci.org; dkim=pass (2048-bit key) header.d=kernelci.org header.i=@kernelci.org header.b=NoVBnAhA; arc=none smtp.client-ip=209.85.214.182
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=kernelci.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=kernelci.org
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernelci.org header.i=@kernelci.org header.b="NoVBnAhA"
Received: by mail-pl1-f182.google.com with SMTP id d9443c01a7336-2cc97653887so129803875ad.1
        for <stable@vger.kernel.org>; Tue, 21 Jul 2026 15:59:08 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=kernelci.org; s=google; t=1784674748; x=1785279548; darn=vger.kernel.org;
        h=message-id:date:reply-to:cc:to:from:subject
         :content-transfer-encoding:mime-version:content-type:from:to:cc
         :subject:date:message-id:reply-to:content-type;
        bh=NMmBHjmA1xmFilZdStWI02AD14rZoVKCLaJgoN/Y8WA=;
        b=NoVBnAhAAT+gN/a3wqyjtJfFre0wCnhwZPf8gTEQtxXxfdni6BuhjrCCQoPV2cirUY
         IebGuN/F+0wBo8xGMT2u0NFCiMw6syk263vxqV25UxWXm0QmqZZoK2AeRl1uuCW3sRFh
         LIS3P+X9EfU7uTKSaOtenJ2dwSHH71BjyD8Cr1dqoFdwFja0zUUkLV0SXRz8pxi1+zMz
         jWBYimKWy6RHGMi1BlmDlzsgGa5ppvbk1BWUPtdjvZQrlygchCuBHmvXn6NP6pKGAglQ
         QVvSQCU6RijC2OQGIyV00triF/zjqVZU4YYwKx28RFWTTfBJQf2i9gvLJVUgFzGc8avp
         2Bzw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1784674748; x=1785279548;
        h=message-id:date:reply-to:cc:to:from:subject
         :content-transfer-encoding:mime-version:content-type:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=NMmBHjmA1xmFilZdStWI02AD14rZoVKCLaJgoN/Y8WA=;
        b=E5h75NKloWL+fINER62xPaofIFyOeTJ4RJuDPjWUY0eUjJpI6QERXiICbIxzad3teC
         aBNtvnuHKW6vdNAWrm4Gn4B7jmkR/K4CRmaJzyK94ef8ht/QIKb9UpE70H5Yfvv08HeB
         Keqmv5G21A/PYpYiQT9WET+D9IuEPvfXXMj2cne7UpnMKlY8e9TUT7g43Mn+BKpbCxzB
         1oVIEwmX50vIHE04ULLZmFInVTqDv58LkRtYk+ULRJxeRFKfZlu/bOCIhaT6jfSbRu2o
         Lh3S8nAwNeYRuoyt+sXU4/Qjjp2inXmjMdjkuCjzaj7/D611v1K3kUee5ybUptLKxgEI
         NjQQ==
X-Gm-Message-State: AOJu0YxFD+8r4CMi3I+/qUxdShe5cri9HRMqEPqQubcqkQF3BYGUhhjF
	PjgfanCVC5HTKbnvSGSF16pL8/0cHVSyJvVmQk41PzcyYNIk07BGd7UPuehk7CaozsgsSTN6748
	E5jQO
X-Gm-Gg: AR+sD10dYGEUCaSYQyOBwhg7/cKqouj/OcG1AgVXx0uPydXHXnpaosk44X8jK4uG3MG
	Nd/C/J62R5KiEoW68DfiXv6anpPvmp0Un8JvB/cWF29I3XyADmVkCl+d8LKHFj8Vv7DVLfSIzXn
	7K4YdsGiRAzy4obdoomrj9tN2C4ozuav2/085CZIsm+Klz/6ts7bJNZLDdyrHiXg3kpPIS2XNRa
	YzssDAmL2WEan5OAhj3DnvSy5UX27qkTA+CaPcy64wiUT+Ktre2GeECDG9nF4f7L3Z+5ZnAvUb4
	tUxkfX60yEzjSpSvxGqZahHlsC5FZqhotVJi+YRfHdTZYs22bTPagaJPzBsQDOVHxbIdwKnQvYf
	/giEgXehr015u/jK2taiwgPZw0pWhWaniZsBmvMgFqdjG0L/uKe+2dW4x4JJePPlRIxBe1xg=
X-Received: by 2002:a17:903:2ec6:b0:2ca:6c8:abd8 with SMTP id d9443c01a7336-2cf34887260mr212108045ad.12.1784674748275;
        Tue, 21 Jul 2026 15:59:08 -0700 (PDT)
Received: from 4104846f2ebf ([20.38.40.137])
        by smtp.gmail.com with ESMTPSA id 5a478bee46e88-3147dc193f8sm5284994eec.1.2026.07.21.15.59.07
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 21 Jul 2026 15:59:07 -0700 (PDT)
Content-Type: text/plain; charset="utf-8"
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Subject: [REGRESSION] stable-rc/linux-6.6.y: (build) incompatible function
 pointer
 types initializing 'void (*)(struct ...
From: KernelCI bot <bot@kernelci.org>
To: kernelci-results@groups.io
Cc: stable@vger.kernel.org
Reply-To: kernelci@lists.linux.dev
Date: Tue, 21 Jul 2026 22:59:07 -0000
Message-ID: <178467474625.1334.6331115540835663024@kernelci.org>

New build issue found on stable-rc/linux-6.6.y:

---
 incompatible function pointer types initializing 'void (*)(struct cpufreq_policy *)' with an expression of type 'int (struct cpufreq_policy *)' [-Wincompatible-function-pointer-types] in drivers/cpufreq/cpufreq-nforce2.o (drivers/cpufreq/cpufreq-nforce2.c) [logspec:kbuild,kbuild.compiler.error]
---

Log excerpt:
=====================================================
drivers/cpufreq/cpufreq-nforce2.c:376:10: error: incompatible function pointer types initializing 'void (*)(struct cpufreq_policy *)' with an expression of type 'int (struct cpufreq_policy *)' [-Wincompatible-function-pointer-types]
  376 |         .exit = nforce2_cpu_exit,
      |                 ^~~~~~~~~~~~~~~~
1 error generated.

=====================================================

When fixing this issue, please attribute this report according to the
patch submission rules:

Reported-by: kernelci.org bot <bot@kernelci.org>

For complete logs and details about the environment used, see the issue
on the KernelCI dashboard:

- dashboard: https://d.kernelci.org/i/maestro:b41ef2d63eb41045cf02fd8039a4bbd582611f85
- giturl: https://git.kernel.org/pub/scm/linux/kernel/git/stable/linux-stable-rc.git
- commit HEAD:  5b1c90a58c8928f66eb8b2599574ea802cdb060f

# Builds where the incident occurred:

## i386_defconfig+allmodconfig+CONFIG_FRAME_WARN=2048 on (i386):
- compiler: clang-21
- config: https://files.kernelci.org/kbuild-clang-21-i386-allmodconfig-6a5f9ea675cb84fb216f9d44/.config
- dashboard: https://d.kernelci.org/build/maestro:6a5f9ea675cb84fb216f9d44

#kernelci issue maestro:b41ef2d63eb41045cf02fd8039a4bbd582611f85

--
This is an experimental report format. Please send feedback in!
Talk to us at kernelci@lists.linux.dev

Made with love by the KernelCI team - https://kernelci.org
