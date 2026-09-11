Received: from mail-pg1-f169.google.com (mail-pg1-f169.google.com [209.85.215.169])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 08EFA372B5E
	for <stable@vger.kernel.org>; Fri, 11 Sep 2026 14:59:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.215.169
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1789138763; cv=none; b=OOqgDUs3dYcV/ASgQc6cQ1mcLCVyBKcALSQyS/WOWODHWj4iukNOtGWbzxEyjvmcUXZGvNAxN1Bx8yBRcR1Da+cTWPQ+1eqpx1mug+3L6ixlRxvrmsA9b6Ac6Yx2fsxZIDVzpJGXnOMNgIoqUTbWXDwSXnBrdVATqthuI4fg6Qo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1789138763; c=relaxed/simple;
	bh=0yItS7XOXHK7KrMwUB/4d9yQcPiUhfVgWkIydtRce8c=;
	h=Content-Type:MIME-Version:Subject:From:To:Cc:Date:Message-ID; b=PJ+Q/FA373TEej5D87r3NJJ12WueN5zhDZQ2/IaHyNvv20wKHXWDRAB3jr99UGKUjJFPp5LsWzvAu1gXC2QAYahcxFNdnogRbW8vFjvWbrsGm7kAndc7c9IZyjJDv765BLLnfBsYIYRDZfxDxh3uDCXLkmQ7nQfzeQJ6xxbfGFo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=kernelci.org; spf=pass smtp.mailfrom=kernelci.org; dkim=pass (2048-bit key) header.d=kernelci.org header.i=@kernelci.org header.b=P2i4MlTY; arc=none smtp.client-ip=209.85.215.169
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=kernelci.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=kernelci.org
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernelci.org header.i=@kernelci.org header.b="P2i4MlTY"
Received: by mail-pg1-f169.google.com with SMTP id 41be03b00d2f7-cc4aa0248cfso1093347a12.1
        for <stable@vger.kernel.org>; Fri, 11 Sep 2026 07:59:20 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=kernelci.org; s=google; t=1789138758; x=1789743558; darn=vger.kernel.org;
        h=message-id:date:reply-to:cc:to:from:subject
         :content-transfer-encoding:mime-version:content-type:from:to:cc
         :subject:date:message-id:reply-to:content-type;
        bh=z2SRDkYqa+MW/krXyIKcUPfMynBDIYQQ4z3PB6OmudE=;
        b=P2i4MlTY3wA6ARtBZuQwzAIv8709VyxYxSEipF3GMUl6Ytk3hSIR3AcHyx+3lyeqCR
         c198FD0qW43ModQ3lYm50hQm/8mo6XjJ02bj5rOEqYosBG8ifd5nRAbyxoSiYPZSUuzo
         ize0Bp1Vnnt0A86ardUj5F1bpxRecnHHP6apeJywrropbFYsWPjQgOJR+vqUEmkxdmSx
         SdsWPx9LYXK5GeRDPy9Am2l8Vjgygw9xJksx+YAn66BWWcYWMpX12e1Vhlg+JhhNUwIx
         0tYqTdAa7RE6xdtmVb1kohFFJvWf7QLFtgCRP14vfOLqCNBToIucrIIdq5dnb1qDgRN6
         ROIQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1789138758; x=1789743558;
        h=message-id:date:reply-to:cc:to:from:subject
         :content-transfer-encoding:mime-version:content-type:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=z2SRDkYqa+MW/krXyIKcUPfMynBDIYQQ4z3PB6OmudE=;
        b=k3Md57rIYXZBgMFW0tLIcBvD/QEM/5dJ26p1trzFihvWsitbmqUIvkHeyVd3RZuf1d
         Kobq3t+HgujFKzef3nF7JuJSDAmu+M9wUent0LW6nLAnOI6rMpnCC+C8LrThQrmLmIsY
         d6J6IvRn0CCDMM33J0NNefwzHF4pwjAA/w2ZZl5MakiPxNvja6FkG0XAugHaMWQ9AEI0
         o3siEG+/t6f+4dkanCOlEqOUjhiXsiuJWbphrIZrYfv1GkIEJxxXFvQT6scTCaETd0i9
         XPZLrDb4b5BEVzVUbC/+51sRnvgZNVlfvGMihh7iGBE0lISuUHWs7O5FEgfShpdtQMgn
         iHTA==
X-Gm-Message-State: AFuF++nI6IaAIckMuTiYi42VIHwX68+311uPFj2mGDm42YpdBFOHRkeZ
	P5ZjJGt9lAZPoZj7g64sDqTXHAjC6LAipunPGXE2HyJpliZNwUE+dSQ0H1Hc2/OBxHg=
X-Gm-Gg: AYBFou3svS2rbYl21jFXnAWyme4triA3f7KLaxmh9/zVj5eet3jyjsgplgIi4KB2I38
	D8A9nJwdx++1NiIuBReTkf7h3IuXgl7MaJzH+5hU1PTIqptZ/ABkuKeaDkOmgzlxAmfL2/7IgNF
	lR3xfnt1uanhpLFdl1M4L2p8Tn6xkU8VYVlFfN73+g5rH1aAPlevcdLjW4IFPkDMCGL3rS6eMBA
	xFQzu7FZ2IzKEmW7vzc9Oju+ZgVR9jcAaGvqy+4/GzuYy8DfUgt3JPQT7lPAVOxrBQ7PQaHbjH5
	xRWSJ9U3+Jn96x9sFwMF/NiYk6AdhaVHeccUa+mwg3m1Kl2h6v6gDBJnQwNrIU2sjo7OXXWxrRo
	oNrwn1tF/OjVhjKDgWLb6A8Ou1Ywde5q96D5jNfKZMziBwz+fIVQq5J1I1AGvYCi5vPuzBTq4Vu
	yk+iiWAmuSZFMI2g2vcDcPRPuh0wVAgLQgtLopJuqhmMdsGp+2KxsKYa1l7aFLxgA=
X-Received: by 2002:a05:6a21:113:b0:3da:e7dd:45d5 with SMTP id adf61e73a8af0-3daed3b5fefmr9045122637.20.1789138758276;
        Fri, 11 Sep 2026 07:59:18 -0700 (PDT)
Received: from 41049dfc76e5 ([20.38.40.137])
        by smtp.gmail.com with ESMTPSA id 5a478bee46e88-33ba4ee07f2sm6379618eec.18.2026.09.11.07.59.17
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 11 Sep 2026 07:59:17 -0700 (PDT)
Content-Type: text/plain; charset="utf-8"
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Subject: [REGRESSION] stable-rc/linux-6.6.y: (build)undefined reference to
 `irq_domain_alloc_generic_chips' in kernel/i...
From: KernelCI bot <bot@kernelci.org>
To: kernelci-results@groups.io
Cc: stable@vger.kernel.org
Reply-To: kernelci@lists.linux.dev
Date: Fri, 11 Sep 2026 14:59:17 -0000
Message-ID: <178913875712.4387.5050700830687653719@kernelci.org>

New build issue found on stable-rc/linux-6.6.y:

---
undefined reference to `irq_domain_alloc_generic_chips' in kernel/irq/irqdomain (kernel/irq/irqdomain.c) [logspec:kbuild,kbuild.compiler.linker_error]
---

Log excerpt:
=====================================================
riscv64-linux-gnu-ld: kernel/irq/irqdomain.o: in function `__irq_domain_create':
irqdomain.c:(.text+0xc94): undefined reference to `irq_domain_alloc_generic_chips'
riscv64-linux-gnu-ld: irqdomain.c:(.text+0xcb8): undefined reference to `irq_domain_remove_generic_chips'

=====================================================

When fixing this issue, please attribute this report according to the
patch submission rules:

Reported-by: kernelci.org bot <bot@kernelci.org>

For complete logs and details about the environment used, see the issue
on the KernelCI dashboard:

- dashboard: https://d.kernelci.org/i/maestro:a4bc0e53f50a025659422b950b9cd86e992dcb16
- giturl: https://git.kernel.org/pub/scm/linux/kernel/git/stable/linux-stable-rc.git
- commit HEAD:  c33bbcf64a1d0e2170b7cdee977e2c00e258a70f

# Builds where the incident occurred:

## nommu_k210_defconfig on (riscv):
- compiler: gcc-14
- config: None
- dashboard: https://d.kernelci.org/build/maestro:6aa40c8720239ade9022a147

#kernelci issue maestro:a4bc0e53f50a025659422b950b9cd86e992dcb16

--
This is an experimental report format. Please send feedback in!
Talk to us at kernelci@lists.linux.dev

Made with love by the KernelCI team - https://kernelci.org
