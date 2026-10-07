Received: from mail-dl1-f47.google.com (mail-dl1-f47.google.com [74.125.82.47])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A11134503E4
	for <stable@vger.kernel.org>; Wed,  7 Oct 2026 08:59:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=74.125.82.47
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1791363549; cv=none; b=NIJSE6NUe81NPsgGNK07+U8W6bnUCZYkQT45S7i8co42bzG/lQf+0Pbo8JJlkRVbDh774aPA/arfuKh0tHXO0qjTRbkX/8xEdtNBRb0ZphtBljbsI+vwHEWfg1jmXfvTmGkrdDptLAq35MmumG3INkPHFGFWZ+IlNhu7bV68gCM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1791363549; c=relaxed/simple;
	bh=/dIqfKjVf67jH+pSP4lDZBcRp+ejLM9kPuu5c5t4xug=;
	h=Content-Type:MIME-Version:Subject:From:To:Cc:Date:Message-ID; b=TKJ4g+e51/Cqu6CQmKwTJ2LpiPr0Qz9o0EH4t1U1KkKNajxZyecMfVek0CXWGMYtJk+ppczL5FjTf9O54NzIxe9Ipi9+FoQrNXubvpxDkJlca8Ie0Nu8Y2JZnb5CzgDOZLImN84BEQlL5exBA9pFET9fHvbvg9wRyyvt5Z7V/AE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=kernelci.org; spf=pass smtp.mailfrom=kernelci.org; dkim=pass (2048-bit key) header.d=kernelci.org header.i=@kernelci.org header.b=BJEHFs0e; arc=none smtp.client-ip=74.125.82.47
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=kernelci.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=kernelci.org
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernelci.org header.i=@kernelci.org header.b="BJEHFs0e"
Received: by mail-dl1-f47.google.com with SMTP id a92af1059eb24-15ea896ddc8so2390479c88.0
        for <stable@vger.kernel.org>; Wed, 07 Oct 2026 01:59:07 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=kernelci.org; s=google; t=1791363546; x=1791968346; darn=vger.kernel.org;
        h=message-id:date:reply-to:cc:to:from:subject
         :content-transfer-encoding:mime-version:content-type:from:to:cc
         :subject:date:message-id:reply-to:content-type;
        bh=g4he5a4AkqAY/ivQE77EMilGNT+cbv05TAN9AGeGBbI=;
        b=BJEHFs0ebgGhr0lTMUIHvbuz84YJ8o/ixbelRsZws8/5QaKY5ibiXAoIlMkvVChUK0
         5DnpYYUt1rhJJOZdS420NlMtwCmMnkP9c94FHmoW9uMe2obONc6u9W7WlNxIhQGUZKdj
         Y9AV2DWhpgZ5cXKIjSTNOLGOPtH5snIRWOIIYWR2/zUOO66u+qixlqn3v0JnmeNWSx0R
         Tu6Np5KU5ZZ4Uabe0cMsyxOQgHsa54uj0XyhY8bHTN+sB17ybGDjzZ4W1QlcvOXZFycy
         bgubQ+jdGpM1HOam7lXR2ZJsj76QUq5v5dKmy1tTB5Gz1gmcte0Vj+QFVfOeTonbxWrP
         STRw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1791363546; x=1791968346;
        h=message-id:date:reply-to:cc:to:from:subject
         :content-transfer-encoding:mime-version:content-type:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=g4he5a4AkqAY/ivQE77EMilGNT+cbv05TAN9AGeGBbI=;
        b=wdpG42wMJF2KSe/mDxNaRRvMiznBlr4AzSOFwn3T6sI1ecAb7RkV0v/vhSVhn1QEOD
         p4v74LOJ4JGZCnwMq/8SUHAIsF7Q6hvZbSP3WdIL86S5o3qv+iZ5qTRmHp1KcTBcuC2m
         XorsMVYhBWy0t2/4fxUYqPHPoEmmfnHSyZosmeHIhtm/pQJpmww05qlp//hNrWKv620L
         eHIaWus2MEDA116DqV9JJZFA0jey/fQCY4lXQNr7DEMQRCBT7mBqI+uMMjj/LnVA1K35
         C4g21dxW1dSuQaLmFSMuY0Uxa77amEEQ44MLxdXBvlQshl6UKp4j6codTEB5NHYfW3Bt
         qDgw==
X-Gm-Message-State: AFuF++mFEBYSiCNSK7TQGl84wXnosyTsR1QApJm6S1jQvnhdsdi6i0Om
	vvD3yj80UEu3FF3zONswdOaboo8uCGjx0PFGhpudjQB5dDCimUlfDDRzURHsX5z9BN5L72ZOfpS
	Xwez7
X-Gm-Gg: AYBFou2VWARr2PheY2AcnlQ98Q7b1+7YJ2WOVJckj+6H1WI1FAq1edDSEsvv7Iq2d6k
	d8KAbsQb/SrgBoY2LYCCIbxDtR2As1DE4BliQBKIHzFyFkJrOoMJHUCg2f8ofP6Ge/djbhcshkF
	g4Mf/2ov4OHFEahH+FHtiguAQ04Jmc8ZH8FWeS3BGaUecPPaWcmoK0ms2k8/PAMh3W8tn1VXz83
	Zq723SyUz6EcGCxJ+Pa2b85BhnqFljKZXchHOjetexm8ARPSJXFnHPUxN1+AyssU52JPbs/1eZk
	OLBcNCWL31k6COAoalSeH08G78KId7TMdJEmYZRzVSn9FqEkRic4U6RYfIqFAn+VTV9ka9mKty9
	glfq6O8m/OKpskf51hdWmIr0Kfc0Ja+Q+EQUlCVhv310vHfiGhBcjUo/KVedQsh5La/oPvyHY+x
	Hw+1oN06bZHL1embU1EatHH5PdPczK9W6bLVp6dFpDKAqBhNak3Ya2eCAws/ocAQqK77LPT1d2T
	w==
X-Received: by 2002:a05:7022:2524:b0:136:b50c:c0e9 with SMTP id a92af1059eb24-1620665f5ebmr2101209c88.21.1791363546286;
        Wed, 07 Oct 2026 01:59:06 -0700 (PDT)
Received: from 5a6d9a2c18a2 ([20.38.40.137])
        by smtp.gmail.com with ESMTPSA id a92af1059eb24-1616b01c2b4sm4845777c88.20.2026.10.07.01.59.05
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 07 Oct 2026 01:59:05 -0700 (PDT)
Content-Type: text/plain; charset="utf-8"
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Subject: [REGRESSION] stable-rc/linux-5.15.y:
 (build)./arch/arc/include/asm/cmpxchg.h:11:10: fatal error: linux/cmpxchg-...
From: KernelCI bot <bot@kernelci.org>
To: kernelci-results@groups.io
Cc: stable@vger.kernel.org
Reply-To: kernelci@lists.linux.dev
Date: Wed, 07 Oct 2026 08:59:05 -0000
Message-ID: <179136354500.28057.4657619027829945990@kernelci.org>

New build issue found on stable-rc/linux-5.15.y:

---
./arch/arc/include/asm/cmpxchg.h:11:10: fatal error: linux/cmpxchg-emu.h: No such file or directory in kernel/bounds.s (kernel/bounds.c) [logspec:kbuild,kbuild.compiler.error]
---

Log excerpt:
=====================================================
                 from kernel/bounds.c:13:
./arch/arc/include/asm/cmpxchg.h:11:10: fatal error: linux/cmpxchg-emu.h: No such file or directory
   11 | #include <linux/cmpxchg-emu.h>
      |          ^~~~~~~~~~~~~~~~~~~~~
compilation terminated.

=====================================================

When fixing this issue, please attribute this report according to the
patch submission rules:

Reported-by: kernelci.org bot <bot@kernelci.org>

For complete logs and details about the environment used, see the issue
on the KernelCI dashboard:

- dashboard: https://d.kernelci.org/i/maestro:8e01ee42bc22174ddb2fc5cb395e5cf49ccc07e9
- giturl: https://git.kernel.org/pub/scm/linux/kernel/git/stable/linux-stable-rc.git
- commit HEAD:  5a64cd2b9ae82e07560b5079921ad6c564e1c09c

# Builds where the incident occurred:

## haps_hs_smp_defconfig on (arc):
- compiler: gcc-14
- config: https://files.kernelci.org/kbuild-gcc-14-arc-haps_hs_smp_defconfig-6ac5fc29a3f195e1aa472256/.config
- dashboard: https://d.kernelci.org/build/maestro:6ac5fc29a3f195e1aa472256

#kernelci issue maestro:8e01ee42bc22174ddb2fc5cb395e5cf49ccc07e9

--
This is an experimental report format. Please send feedback in!
Talk to us at kernelci@lists.linux.dev

Made with love by the KernelCI team - https://kernelci.org
