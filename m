Received: from mail-dy1-f181.google.com (mail-dy1-f181.google.com [74.125.82.181])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 209764334B9
	for <stable@vger.kernel.org>; Wed,  7 Oct 2026 08:59:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=74.125.82.181
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1791363548; cv=none; b=TDRG/BAh3+btIAB2NZqVWHjX2Ko4ynQOZCYARXX5wKpXYXHrBSxUzDQyRsuCtPKeJxj1Kmq1jsGgYNpMuf87sJpbeo0bsTu6rxKSkVa5MIAzc/Ct8O5lyE9mfejUwsEBz3k5ye1fq97Y3qDIqIm9ZeOHxhDX0JccqEirmL2Ea6k=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1791363548; c=relaxed/simple;
	bh=uPsf4oJY/SzTMLcVvjKGhsITHTgG3dSBO80iE6hzCck=;
	h=Content-Type:MIME-Version:Subject:From:To:Cc:Date:Message-ID; b=rpJ/xhhDr0KI/Xti2t241iJx2HlzUd9XTQ1Dow/DYJkyFxJo3pYQQPZmrb23OH7LloxsIO4cU0KQSBCMfaxtMR4trXAjksHv/fEqF7GNM7qG7/0jmOadRIzZgvyTkl9ibgx7UcERK7xcPbFMgzaBsy+H3A1yR4o5DTKvjyVmMOo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=kernelci.org; spf=pass smtp.mailfrom=kernelci.org; dkim=pass (2048-bit key) header.d=kernelci.org header.i=@kernelci.org header.b=Wojzp6mQ; arc=none smtp.client-ip=74.125.82.181
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=kernelci.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=kernelci.org
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernelci.org header.i=@kernelci.org header.b="Wojzp6mQ"
Received: by mail-dy1-f181.google.com with SMTP id 5a478bee46e88-35127e848feso3090091eec.0
        for <stable@vger.kernel.org>; Wed, 07 Oct 2026 01:59:05 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=kernelci.org; s=google; t=1791363545; x=1791968345; darn=vger.kernel.org;
        h=message-id:date:reply-to:cc:to:from:subject
         :content-transfer-encoding:mime-version:content-type:from:to:cc
         :subject:date:message-id:reply-to:content-type;
        bh=FJ7OmcWf/5pCT8D1BWCXf9V7vzys5BebKTgyVz5b1qs=;
        b=Wojzp6mQ5lrJiWBR/0EQleTxK9+xy/aeeIOHIn37o66ZP7BUUkGcURicj5W+lYo+FQ
         EXIdR7Hi2GZg1V7ofy098MG3CPYcMqcHm/r420X4dWAHSbcH1+FDMehTo6hcqwdONRro
         A07nMOQABQBGHt9SUs/3eLgRSQBShaa5c6q4NY6hR8R6X3E6yeWGY15F7Ld+RHRYbsX7
         iuEmaHFfSk7W1O4jaO2ZYWXX3XpSAp6+JWyBf5xew0pipV9sgTUXZwAPyxNv9GGcswBG
         Oqs7ETWjy/oirZMGvzKIw5NfZIDN353P0ZDpXdMfb+alAXLosmG2C2gkXPw3ymkBtgDS
         hXhQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1791363545; x=1791968345;
        h=message-id:date:reply-to:cc:to:from:subject
         :content-transfer-encoding:mime-version:content-type:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=FJ7OmcWf/5pCT8D1BWCXf9V7vzys5BebKTgyVz5b1qs=;
        b=gbGra4f2kosd0RdY2qnvo3RQAT5Pbp6XJYWubJkb+4h2t0AMK5AsSUR7+13hGCauoA
         hBWxY9OZAM2O5Gp+Lf8bOmVZC3vn/5bIFEwbZ81o/vbJ7SwiAFTukElbYxrdIlEuNeqs
         GaZ7on/OQGoce4WVc49yEucTaFfN0QuAywKcDh4xzl+aNKnJRksBbu16fQ5eXC1MuHph
         saO8dh0pVMRG1nQJdKjlyO7BotpCyJbtZMwYFR/E7DXCBvBZSLX/rPgD5MIyPsQ1tEz8
         nJhQvlMSVXFmEy9BYQk5MhvvZ4M9CKMgTxkk9NMMtlQMaO7Mpm7DaXCXw/0XNahkO5vd
         MwEw==
X-Gm-Message-State: AFq9FYLNJ+5gRUHlltTRgkTLuChgFwV66h4B6S73w14QgdV9Y86u4dlX
	oqvVuT+B/SPrVJMYteAxyB7D9fsy/KZmNqa18p21YlkKGrXzhv76zEnuvAZIr/hfDKA=
X-Gm-Gg: AYBFou3MbsiANKPoUNVQ1ewxPiFamfaZnObI1cq4egsdRaX/m4W4m3RlR4F8+SjuCaQ
	oxi80Sw7XKXWYK2/fboKqH7wiOQXZVCiXmIC2kRxFJbtSftr02KMToSJTA4rL8kykg9fO1k+7QN
	R5SuUdtZvs5xlvPaRd788vdwsdlkrt9Aj+1iDOcL5OB5EK3db5hYuHmpnHisNQwlhEy7LmAqaPZ
	cBsbV4CWLhIXmXwin4vYn57m6Cdt8/9NUVmwOhcDomFF0uwPAqqY2QzKzSwT2c5ym2PpFW/TUJO
	+THgnFrFdVQX8KDZIB2LL2w8XI9FzDjauE8JvczC0vHC53Wk/li7HcwRhDUQJfkhaTlSDeD4zBR
	zh+mXSWIz7Vs/mDRjd0yJSZYEA/LR5/taPDyMxc4k6ZiChRO21YykryzreEqZDYmdwVrelyoMWF
	1D9p8hXRgUuoGE/aznNamK+zSMCILl1FyDxBGng1daBr6iW4H5Hb6ehOf4iT3r45c=
X-Received: by 2002:a05:693c:65d5:b0:33b:5b1b:134c with SMTP id 5a478bee46e88-3515de899a6mr1687335eec.38.1791363544828;
        Wed, 07 Oct 2026 01:59:04 -0700 (PDT)
Received: from 5a6d9a2c18a2 ([20.38.40.137])
        by smtp.gmail.com with ESMTPSA id 5a478bee46e88-3515b04b185sm6012905eec.31.2026.10.07.01.59.04
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 07 Oct 2026 01:59:04 -0700 (PDT)
Content-Type: text/plain; charset="utf-8"
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Subject: [REGRESSION] stable-rc/linux-6.12.y:
 (build)./arch/arc/include/asm/atomic64-arcv2.h:166:16: error: implicit dec...
From: KernelCI bot <bot@kernelci.org>
To: kernelci-results@groups.io
Cc: stable@vger.kernel.org
Reply-To: kernelci@lists.linux.dev
Date: Wed, 07 Oct 2026 08:59:04 -0000
Message-ID: <179136354338.28057.9498051362957290811@kernelci.org>

New build issue found on stable-rc/linux-6.12.y:

---
./arch/arc/include/asm/atomic64-arcv2.h:166:16: error: implicit declaration of function 'arch_cmpxchg64_relaxed'; did you mean 'arch_cmpxchg_relaxed'? [-Werror=implicit-function-declaration] in kernel/bounds.s (kernel/bounds.c) [logspec:kbuild,kbuild.compiler.error]
---

Log excerpt:
=====================================================
                 from kernel/bounds.c:13:
./arch/arc/include/asm/atomic64-arcv2.h: In function 'arch_atomic64_cmpxchg_relaxed':
./arch/arc/include/asm/atomic64-arcv2.h:166:16: error: implicit declaration of function 'arch_cmpxchg64_relaxed'; did you mean 'arch_cmpxchg_relaxed'? [-Werror=implicit-function-declaration]
  166 |         return arch_cmpxchg64_relaxed(&v->counter, old, new);
      |                ^~~~~~~~~~~~~~~~~~~~~~
      |                arch_cmpxchg_relaxed
cc1: some warnings being treated as errors

=====================================================

When fixing this issue, please attribute this report according to the
patch submission rules:

Reported-by: kernelci.org bot <bot@kernelci.org>

For complete logs and details about the environment used, see the issue
on the KernelCI dashboard:

- dashboard: https://d.kernelci.org/i/maestro:fed7fd58d6e948a617e91504d95f27709c91009a
- giturl: https://git.kernel.org/pub/scm/linux/kernel/git/stable/linux-stable-rc.git
- commit HEAD:  e8d1764e8b54306cc3502262d5e5ad8b8e899be2

# Builds where the incident occurred:

## haps_hs_smp_defconfig on (arc):
- compiler: gcc-14
- config: https://files.kernelci.org/kbuild-gcc-14-arc-haps_hs_smp_defconfig-6ac5fceaa3f195e1aa47256c/.config
- dashboard: https://d.kernelci.org/build/maestro:6ac5fceaa3f195e1aa47256c

#kernelci issue maestro:fed7fd58d6e948a617e91504d95f27709c91009a

--
This is an experimental report format. Please send feedback in!
Talk to us at kernelci@lists.linux.dev

Made with love by the KernelCI team - https://kernelci.org
