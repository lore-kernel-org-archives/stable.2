Received: from mail-pz2-f42.google.com (mail-pz2-f42.google.com [74.125.228.42])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 830995A987E
	for <stable@vger.kernel.org>; Thu, 17 Sep 2026 14:59:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=74.125.228.42
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1789657166; cv=none; b=Iwut//loe/Iy170G1gJrMUR2Q1z+9UcqTE5ZDNpU+0Y+26/rhdQvQw5EUvfIQreJPEZo4egnGuaT+P1cXVFcCNoioAitUr8Vaq6sKlBzHgUGGpF4H7F7pdrsen8+tMNzArGFUTaiz6h8pMOVulDVnuqrc/EmVJgZnd7VQX/GJs8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1789657166; c=relaxed/simple;
	bh=bhg55tGKiii2LiAEACbai14yUfKg3gcA2xzapun1keQ=;
	h=Content-Type:MIME-Version:Subject:From:To:Cc:Date:Message-ID; b=BuQcfRI7q1r7QwaZKjyBARb1ZyeD7ZPsik0Tf1PmXLhimchOKLS11hiRBTAhpviYFXb8U0JdVvwGumW6Wnh1kMpBnaFe5AJwrsorv1NOXp8d5we+Fj8rpE+pLsrbx1oMOx/tspooQU2QuEMLOdhu7cpfB4EzsSXc8USGVx3QVHU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=kernelci.org; spf=pass smtp.mailfrom=kernelci.org; dkim=pass (2048-bit key) header.d=kernelci.org header.i=@kernelci.org header.b=EHUSShbW; arc=none smtp.client-ip=74.125.228.42
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=kernelci.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=kernelci.org
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernelci.org header.i=@kernelci.org header.b="EHUSShbW"
Received: by mail-pz2-f42.google.com with SMTP id 41be03b00d2f7-cc1cea4c7a0so589108a12.1
        for <stable@vger.kernel.org>; Thu, 17 Sep 2026 07:59:07 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=kernelci.org; s=google; t=1789657145; x=1790261945; darn=vger.kernel.org;
        h=message-id:date:reply-to:cc:to:from:subject
         :content-transfer-encoding:mime-version:content-type:from:to:cc
         :subject:date:message-id:reply-to:content-type;
        bh=v5OdbnTzwZ01QCoaorca0fX8yrx8CEAKk+8to/NEgM8=;
        b=EHUSShbWYT3+iJin6fy3DtNYcw8zAvrZ6V8nj3YJGyrOlCQNY88eqFHxZVXsDuuIe0
         7DrN58Yvml+T7En9xoyd8Uox9ji9mrsgZDjQfpZDRKsk4T+iJDcwAMH2Z0Oz2CqFg1JJ
         c3xohkJaDUB7d0iLqVxTbgjXytfb2xAm0V/FF03PrlLhHAk1U2M3O5Opv2h0mI1hsek7
         SSfSUM0S9sIdTMCKCJq3m9/NHG96JfokjSQxMwTSReMy2jJrk9WrSddtMv3/Qq++KSjL
         qxWFfP9bOzhFQ6NLFOVLlvgL1F3a++su7bkuTMVzP8sEhfb+JB+gPiOJIiqlRf5qXei2
         FIGQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1789657145; x=1790261945;
        h=message-id:date:reply-to:cc:to:from:subject
         :content-transfer-encoding:mime-version:content-type:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=v5OdbnTzwZ01QCoaorca0fX8yrx8CEAKk+8to/NEgM8=;
        b=fEl9bKoCOO4I7d1MG6MZl030fZBqFBQ4BWLg4T1nTDlpLrll9aQ/UOQb2dMPYbg4ky
         9M8qDsM9/dQmnCxHhyi/Q5+wn8vHLT/cOBs0N6LyEntxyLM4/iy3kdxKgNUxZflG7zec
         Nm30qS4BmtPlkqkYvNvkXpwpYMakxXxHeo4fuRayMGMRqvwrRLHuwE5xisVrvhN/CVUL
         kYzdzLpEL5ng48CZ0fktfd6upyZ76ImY05sihZcAnYcWU8jWDDkxzZBdGAOHIytPUiax
         qHyH6u8l6dHYcC+kC7UjueexJd2V3Gei9AmRSRTRg7FICVM7To34V5x9BaILJa3Yu64h
         eUBg==
X-Gm-Message-State: AFuF++lZyAOQa76waCa870tsZC6ljWJPYO6YPK6MxPIu75oKE8zEFIkd
	W1UDrOBB95wm/bWt1KGEWmF8RGrwk8QbQTuBAyCbhIrHcBiF3jnB/IBpTpSN7tt9lWh71eZYrvq
	051Ve
X-Gm-Gg: AYBFou0oON6g59ozc6Qge9ejBGTgxHKO4ZfCRxi2XvjVuR5/xTGd45H8Vs5yPJCfWBu
	Jt1hez8TV9e41ILLQ1Eth/dVdwsoq6Gd4ccxjptBWphPin2XhX/QatkL3HUkwOmrj8x6TOU/nhc
	QhwZ35xIAAtTWNH5BcOLMG68vKAJxLEeVZVNyO1JXtskojvA4BYvkcc67+nkz8Bho7d14g5RlgG
	BN2qCbgLAZv+LgtRLcEOXX91EMaOuu7w6YQhJqGzE0yN04H3VkCS2X1LXea0q8elNDQfBUEio9H
	fNS56RXMSyO50qplwAeEBdEKg8XNKPg2sN5T5nwaSv6CevG9k5u76UhNBHfn+w4DFe1Qu9sFRuX
	heJfMbEyzSEjEV4bkV7WbHQ1bzYqx8Inep2rhR5w3Xt6oQHqpwZnRYiBkRKmBBmhJZG/hG23Vkj
	7avr4QWNK76G8nPxbA1l4r3GCTcs6KrjN1hEsHnFRNrgjKKaH7EM/Kr6vQRI69JDg=
X-Received: by 2002:a05:6a20:1603:b0:3d3:ae1f:d7f5 with SMTP id adf61e73a8af0-3dd5f74d9b2mr18600184637.21.1789657144502;
        Thu, 17 Sep 2026 07:59:04 -0700 (PDT)
Received: from ec7b70f3a45c ([20.38.40.137])
        by smtp.gmail.com with ESMTPSA id a92af1059eb24-14395d5d0f3sm14133968c88.12.2026.09.17.07.59.03
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 17 Sep 2026 07:59:04 -0700 (PDT)
Content-Type: text/plain; charset="utf-8"
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Subject: [REGRESSION] stable-rc/linux-5.15.y: (build)no member named
 'rx_mode_work' in
 'struct cpsw_priv' in drivers/net...
From: KernelCI bot <bot@kernelci.org>
To: kernelci-results@groups.io
Cc: stable@vger.kernel.org
Reply-To: kernelci@lists.linux.dev
Date: Thu, 17 Sep 2026 14:59:03 -0000
Message-ID: <178965714353.146356.379759468955752828@kernelci.org>

New build issue found on stable-rc/linux-5.15.y:

---
no member named 'rx_mode_work' in 'struct cpsw_priv' in drivers/net/ethernet/ti/cpsw.o (drivers/net/ethernet/ti/cpsw.c) [logspec:kbuild,kbuild.compiler.error]
---

Log excerpt:
=====================================================
/tmp/kci/linux/drivers/net/ethernet/ti/cpsw.c:310:64: error: no member named 'rx_mode_work' in 'struct cpsw_priv'
  310 |         struct cpsw_priv *priv = container_of(work, struct cpsw_priv, rx_mode_work);
      |                                  ~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~^~~~~~~~~~~~~
/tmp/kci/linux/include/linux/kernel.h:490:53: note: expanded from macro 'container_of'
  490 |         BUILD_BUG_ON_MSG(!__same_type(*(ptr), ((type *)0)->member) &&   \
      |         ~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~^~~~~~~~~~~~~~
  491 |                          !__same_type(*(ptr), void),                    \
      |                          ~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~
  492 |                          "pointer type mismatch in container_of()");    \
      |                          ~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~
/tmp/kci/linux/include/linux/compiler_types.h:275:74: note: expanded from macro '__same_type'
  275 | #define __same_type(a, b) __builtin_types_compatible_p(typeof(a), typeof(b))
      |                                                                          ^
/tmp/kci/linux/include/linux/build_bug.h:39:58: note: expanded from macro 'BUILD_BUG_ON_MSG'
   39 | #define BUILD_BUG_ON_MSG(cond, msg) compiletime_assert(!(cond), msg)
      |                                     ~~~~~~~~~~~~~~~~~~~~~^~~~~~~~~~~
/tmp/kci/linux/include/linux/compiler_types.h:333:22: note: expanded from macro 'compiletime_assert'
  333 |         _compiletime_assert(condition, msg, __compiletime_assert_, __COUNTER__)
      |         ~~~~~~~~~~~~~~~~~~~~^~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~
/tmp/kci/linux/include/linux/compiler_types.h:321:23: note: expanded from macro '_compiletime_assert'
  321 |         __compiletime_assert(condition, msg, prefix, suffix)
      |         ~~~~~~~~~~~~~~~~~~~~~^~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~
/tmp/kci/linux/include/linux/compiler_types.h:313:9: note: expanded from macro '__compiletime_assert'
  313 |                 if (!(condition))                                       \
      |                       ^~~~~~~~~
/tmp/kci/linux/drivers/net/ethernet/ti/cpsw.c:310:27: error: no member named 'rx_mode_work' in 'cpsw_priv'
  310 |         struct cpsw_priv *priv = container_of(work, struct cpsw_priv, rx_mode_work);
      |                                  ^                                    ~~~~~~~~~~~~
/tmp/kci/linux/include/linux/kernel.h:493:21: note: expanded from macro 'container_of'
  493 |         ((type *)(__mptr - offsetof(type, member))); })
      |                            ^              ~~~~~~
/tmp/kci/linux/include/linux/stddef.h:17:32: note: expanded from macro 'offsetof'
   17 | #define offsetof(TYPE, MEMBER)  __compiler_offsetof(TYPE, MEMBER)
      |                                 ^                         ~~~~~~
/tmp/kci/linux/include/linux/compiler_types.h:140:35: note: expanded from macro '__compiler_offsetof'
  140 | #define __compiler_offsetof(a, b)       __builtin_offsetof(a, b)
      |                                         ^                     ~
/tmp/kci/linux/drivers/net/ethernet/ti/cpsw.c:352:23: error: no member named 'rx_mode_work' in 'struct cpsw_priv'
  352 |         schedule_work(&priv->rx_mode_work);
      |                        ~~~~  ^
/tmp/kci/linux/drivers/net/ethernet/ti/cpsw.c:1475:23: error: no member named 'rx_mode_work' in 'struct cpsw_priv'
 1475 |         INIT_WORK(&priv_sl2->rx_mode_work, cpsw_ndo_set_rx_mode_work);
      |                    ~~~~~~~~  ^
/tmp/kci/linux/drivers/net/ethernet/ti/cpsw.c:1475:23: error: no member named 'rx_mode_work' in 'struct cpsw_priv'
 1475 |         INIT_WORK(&priv_sl2->rx_mode_work, cpsw_ndo_set_rx_mode_work);
      |                    ~~~~~~~~  ^
/tmp/kci/linux/drivers/net/ethernet/ti/cpsw.c:1475:23: error: no member named 'rx_mode_work' in 'struct cpsw_priv'
 1475 |         INIT_WORK(&priv_sl2->rx_mode_work, cpsw_ndo_set_rx_mode_work);
      |                    ~~~~~~~~  ^
/tmp/kci/linux/drivers/net/ethernet/ti/cpsw.c:1475:23: error: no member named 'rx_mode_work' in 'struct cpsw_priv'
 1475 |         INIT_WORK(&priv_sl2->rx_mode_work, cpsw_ndo_set_rx_mode_work);
      |                    ~~~~~~~~  ^
/tmp/kci/linux/drivers/net/ethernet/ti/cpsw.c:1475:23: error: no member named 'rx_mode_work' in 'struct cpsw_priv'
 1475 |         INIT_WORK(&priv_sl2->rx_mode_work, cpsw_ndo_set_rx_mode_work);
      |                    ~~~~~~~~  ^
/tmp/kci/linux/drivers/net/ethernet/ti/cpsw.c:1657:19: error: no member named 'rx_mode_work' in 'struct cpsw_priv'
 1657 |         INIT_WORK(&priv->rx_mode_work, cpsw_ndo_set_rx_mode_work);
      |                    ~~~~  ^
/tmp/kci/linux/drivers/net/ethernet/ti/cpsw.c:1657:19: error: no member named 'rx_mode_work' in 'struct cpsw_priv'
 1657 |         INIT_WORK(&priv->rx_mode_work, cpsw_ndo_set_rx_mode_work);
      |                    ~~~~  ^
/tmp/kci/linux/drivers/net/ethernet/ti/cpsw.c:1657:19: error: no member named 'rx_mode_work' in 'struct cpsw_priv'
 1657 |         INIT_WORK(&priv->rx_mode_work, cpsw_ndo_set_rx_mode_work);
      |                    ~~~~  ^
/tmp/kci/linux/drivers/net/ethernet/ti/cpsw.c:1657:19: error: no member named 'rx_mode_work' in 'struct cpsw_priv'
 1657 |         INIT_WORK(&priv->rx_mode_work, cpsw_ndo_set_rx_mode_work);
      |                    ~~~~  ^
/tmp/kci/linux/drivers/net/ethernet/ti/cpsw.c:1657:19: error: no member named 'rx_mode_work' in 'struct cpsw_priv'
 1657 |         INIT_WORK(&priv->rx_mode_work, cpsw_ndo_set_rx_mode_work);
      |                    ~~~~  ^
/tmp/kci/linux/drivers/net/ethernet/ti/cpsw.c:1777:3: error: implicit declaration of function 'disable_work_sync' [-Werror,-Wimplicit-function-declaration]
 1777 |                 disable_work_sync(&priv->rx_mode_work);
      |                 ^
/tmp/kci/linux/drivers/net/ethernet/ti/cpsw.c:1777:3: note: did you mean 'disable_irq_nosync'?
/tmp/kci/linux/include/linux/interrupt.h:244:13: note: 'disable_irq_nosync' declared here
  244 | extern void disable_irq_nosync(unsigned int irq);
      |             ^
/tmp/kci/linux/drivers/net/ethernet/ti/cpsw.c:1777:28: error: no member named 'rx_mode_work' in 'struct cpsw_priv'
 1777 |                 disable_work_sync(&priv->rx_mode_work);
      |                                    ~~~~  ^
15 errors generated.

=====================================================

When fixing this issue, please attribute this report according to the
patch submission rules:

Reported-by: kernelci.org bot <bot@kernelci.org>

For complete logs and details about the environment used, see the issue
on the KernelCI dashboard:

- dashboard: https://d.kernelci.org/i/maestro:5129a258b08b659911f223eb436ab8f0acee69bb
- giturl: https://git.kernel.org/pub/scm/linux/kernel/git/stable/linux-stable-rc.git
- commit HEAD:  0cda336e90e56636d2f94cdb84fec866ee662db8

# Builds where the incident occurred:

## defconfig+allmodconfig on (arm64):
- compiler: clang-21
- config: None
- dashboard: https://d.kernelci.org/build/maestro:6aabe85cfc1857a999df053d

#kernelci issue maestro:5129a258b08b659911f223eb436ab8f0acee69bb

--
This is an experimental report format. Please send feedback in!
Talk to us at kernelci@lists.linux.dev

Made with love by the KernelCI team - https://kernelci.org
