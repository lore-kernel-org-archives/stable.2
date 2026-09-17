Received: from mail-pj2-f12.google.com (mail-pj2-f12.google.com [74.125.227.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B959A525A92
	for <stable@vger.kernel.org>; Thu, 17 Sep 2026 13:59:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=74.125.227.140
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1789653548; cv=none; b=ATEcnj8yLLy+Rn+pMir9w8ZwsL7haMgXSysi2GCz7qNpJKVhWAVOSgxtdHZqvIjsPdc/4pSnoIPNld2PjKeqXEf1XeiJ9k81HZEuXy1iSORey9mekIugAblsRzOWVdBSXyR80mTYC1a2k1c7gE21pCuQqDtZDbRWZ2rnMm9C9OU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1789653548; c=relaxed/simple;
	bh=fuXuZe4ld7mCyUCU3MhMOfvazrvbKSh0jyF7gxNpiWY=;
	h=Content-Type:MIME-Version:Subject:From:To:Cc:Date:Message-ID; b=Y5F9BoXaOlmWr67HTY6uTQpHP3+PURg0L2gZdBKb4a6DmAaidTLCiSE5LUqG1wXB2POqwI5Nj4rGU7tdcov/PBsgKQew7QUK7kqbAUc4WYulDG5Q5L9JTUKSDXkEscm/WXGzsdVK4sLUNssfvlsIsH1HlmFN6S33tLRDf497J7s=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=kernelci.org; spf=pass smtp.mailfrom=kernelci.org; dkim=pass (2048-bit key) header.d=kernelci.org header.i=@kernelci.org header.b=AKCeMMia; arc=none smtp.client-ip=74.125.227.140
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=kernelci.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=kernelci.org
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernelci.org header.i=@kernelci.org header.b="AKCeMMia"
Received: by mail-pj2-f12.google.com with SMTP id 98e67ed59e1d1-39b2ad83dc6so750690a91.0
        for <stable@vger.kernel.org>; Thu, 17 Sep 2026 06:59:05 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=kernelci.org; s=google; t=1789653545; x=1790258345; darn=vger.kernel.org;
        h=message-id:date:reply-to:cc:to:from:subject
         :content-transfer-encoding:mime-version:content-type:from:to:cc
         :subject:date:message-id:reply-to:content-type;
        bh=LNxF3set+KrKZMcR1YYzpNH7BaF13ZasgNsEzida8VM=;
        b=AKCeMMiaa1/EGsveptOyStkeldA6KnnQPxJOONh/w/XtWwHiH93WUAj7BoTUSuwNx2
         AoAzbrUllYbwAGQKqWI/ucGlelcaEsRS3/XRTxGppyG6ktg32bpHW7UIfrheZeJVO/tL
         o9F6inFBS9WStKK7nS23+a/LMiUOpyB5VeuFu0ZRC6g/4jS0ao2wcWXngpDSxHURDUxy
         eIgGnDQvJ34Zm0qPTb0YL33DSFVzjf+V0cLGU6WbnZ2srSBSgBgEW+q6E+1v1wWUjDWM
         S59TGLkD8SRYibhzuDH+STgzZHOd1stIsQx5xKwZrEa2/w4DpjvLYPrsDxo3s98ymyMk
         B6sg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1789653545; x=1790258345;
        h=message-id:date:reply-to:cc:to:from:subject
         :content-transfer-encoding:mime-version:content-type:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=LNxF3set+KrKZMcR1YYzpNH7BaF13ZasgNsEzida8VM=;
        b=WjNT5meMPe4FkLdaXgcmFI1qLV0bRevFtHL4cmqSHv3yUL+vN+z28P/fzALRYc2qSw
         iBjsd95L9mLr53FhF3HQj+C2O7dG9tnIRU1/rpmx7/vTqOLsJniZr3iZy77nL9FCU2bL
         hZZp/hfVZD8bvVKCnxkZ+S+Tw+E167sQoaxyrEcJwdIDSmQ3Qrx1dGcf/0eP+diGPbVW
         4kZg45cZpJDziKNDMFXAQ00r2eqWU5OfmP2lYw5kZ51rIwcwbHhJGYdzq8xrS3Yth7jC
         4qMZ2NDXY3eDIqOIkPN+YSSDhEWX9tOazjXcApENgcbLVXT7cmFk5SHw9zQAhe07U13L
         Y+5g==
X-Gm-Message-State: AFuF++nA5bM3kJSljVU6rUgUy+ANA30DayTyufhRIhbG9XUxEdSk52dx
	vgsPqSyn119bplqfAWQAtPSOOxL13BK8a71NJrazmXAgBGB9PIJfPVblSWuW+5TcZ86f8zax45d
	Ebl39
X-Gm-Gg: AYBFou0cTcomFve+j9BysLouhQC28aISiimKwS4xqMPMiSXeFf7Abgmzr9/b6enDU3+
	3+BXvRHss1KI55AG60u9VEk1LnQ0P1kMji4Mp368SkfNTw5YAfrhaOfNq8YQkgECVuIor8lXryG
	vj9mmFqjXomwWbDUWbqmxQ4SlTCuug+2I0coeR8b2WHKdWqHqv4Wk+rVh4q3Gy9Mnj8rvrHVw4Y
	Uub20X+N0B+9gC7QBvgURigbbBxOJPHjNTbnZc2PjYVqa+KitWIJ3cQxWrB8J76kb3lS4c2wA3R
	L0vHhEb7tKli+VKuBjWazPRDhIXO5slMRP5IyoSq5yicZiesVD8i1erGdByzwj+B1BoYoBpatwW
	5znqKUAjw8huLPnmer+DA/dFZ1XUx+DhHRNLIQg2KYyv1lmukuvot/B3ADlNeJb60Ir76wlzL+G
	Cdx8iCLY1WKec4jHn1v0aZ8MP+sCJZiPq0Nu7GAiyi4FScoXNPooVnIRlYPogux18=
X-Received: by 2002:a17:90b:4408:b0:39d:ec24:5ffe with SMTP id 98e67ed59e1d1-39e1e284fd8mr14343989a91.9.1789653544880;
        Thu, 17 Sep 2026 06:59:04 -0700 (PDT)
Received: from ec7b70f3a45c ([20.38.40.137])
        by smtp.gmail.com with ESMTPSA id a92af1059eb24-14395d13ee7sm15017017c88.8.2026.09.17.06.59.04
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 17 Sep 2026 06:59:04 -0700 (PDT)
Content-Type: text/plain; charset="utf-8"
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Subject: 
 =?utf-8?q?=5BREGRESSION=5D_stable-rc/linux-6=2E6=2Ey=3A_=28build=29in_expans?=
 =?utf-8?q?ion_of_macro_=E2=80=98container=5Fof=E2=80=99_in_drivers/net/ethe?=
 =?utf-8?q?rnet/ti/cps=2E=2E=2E?=
From: KernelCI bot <bot@kernelci.org>
To: kernelci-results@groups.io
Cc: stable@vger.kernel.org
Reply-To: kernelci@lists.linux.dev
Date: Thu, 17 Sep 2026 13:59:04 -0000
Message-ID: <178965354369.144182.3820631599752867786@kernelci.org>

New build issue found on stable-rc/linux-6.6.y:

---
in expansion of macro ‘container_of’ in drivers/net/ethernet/ti/cpsw.o (drivers/net/ethernet/ti/cpsw.c) [logspec:kbuild,kbuild.compiler.note]
---

Log excerpt:
=====================================================
/tmp/kci/linux/drivers/net/ethernet/ti/cpsw.c:310:34: note: in expansion of macro ‘container_of’
  310 |         struct cpsw_priv *priv = container_of(work, struct cpsw_priv, rx_mode_work);
      |                                  ^~~~~~~~~~~~
/tmp/kci/linux/include/linux/compiler_types.h:415:27: error: expression in static assertion is not an integer
  415 | #define __same_type(a, b) __builtin_types_compatible_p(typeof(a), typeof(b))
      |                           ^~~~~~~~~~~~~~~~~~~~~~~~~~~~
/tmp/kci/linux/include/linux/build_bug.h:78:56: note: in definition of macro ‘__static_assert’
   78 | #define __static_assert(expr, msg, ...) _Static_assert(expr, msg)
      |                                                        ^~~~
/tmp/kci/linux/include/linux/container_of.h:20:9: note: in expansion of macro ‘static_assert’
   20 |         static_assert(__same_type(*(ptr), ((type *)0)->member) ||       \
      |         ^~~~~~~~~~~~~
/tmp/kci/linux/include/linux/container_of.h:20:23: note: in expansion of macro ‘__same_type’
   20 |         static_assert(__same_type(*(ptr), ((type *)0)->member) ||       \
      |                       ^~~~~~~~~~~
/tmp/kci/linux/drivers/net/ethernet/ti/cpsw.c:310:34: note: in expansion of macro ‘container_of’
  310 |         struct cpsw_priv *priv = container_of(work, struct cpsw_priv, rx_mode_work);
      |                                  ^~~~~~~~~~~~
In file included from /tmp/kci/linux/include/uapi/linux/posix_types.h:5,
                 from /tmp/kci/linux/include/uapi/linux/types.h:14,
                 from /tmp/kci/linux/include/linux/types.h:6,
                 from /tmp/kci/linux/include/linux/kasan-checks.h:5,
                 from /tmp/kci/linux/include/asm-generic/rwonce.h:26,
                 from ./arch/arm/include/generated/asm/rwonce.h:1,
                 from /tmp/kci/linux/include/linux/compiler.h:262,
                 from /tmp/kci/linux/include/linux/array_size.h:5,
                 from /tmp/kci/linux/include/linux/kernel.h:16:
/tmp/kci/linux/include/linux/stddef.h:16:33: error: ‘struct cpsw_priv’ has no member named ‘rx_mode_work’
   16 | #define offsetof(TYPE, MEMBER)  __builtin_offsetof(TYPE, MEMBER)
      |                                 ^~~~~~~~~~~~~~~~~~
/tmp/kci/linux/include/linux/container_of.h:23:28: note: in expansion of macro ‘offsetof’
   23 |         ((type *)(__mptr - offsetof(type, member))); })
      |                            ^~~~~~~~
/tmp/kci/linux/drivers/net/ethernet/ti/cpsw.c:310:34: note: in expansion of macro ‘container_of’
  310 |         struct cpsw_priv *priv = container_of(work, struct cpsw_priv, rx_mode_work);
      |                                  ^~~~~~~~~~~~
/tmp/kci/linux/drivers/net/ethernet/ti/cpsw.c: In function ‘cpsw_ndo_set_rx_mode’:
/tmp/kci/linux/drivers/net/ethernet/ti/cpsw.c:352:28: error: ‘struct cpsw_priv’ has no member named ‘rx_mode_work’
  352 |         schedule_work(&priv->rx_mode_work);
      |                            ^~
In file included from /tmp/kci/linux/include/linux/srcu.h:21,
                 from /tmp/kci/linux/include/linux/notifier.h:16,
                 from /tmp/kci/linux/include/linux/clk.h:14,
                 from /tmp/kci/linux/drivers/net/ethernet/ti/cpsw.c:11:
/tmp/kci/linux/drivers/net/ethernet/ti/cpsw.c: In function ‘cpsw_probe_dual_emac’:
/tmp/kci/linux/drivers/net/ethernet/ti/cpsw.c:1466:28: error: ‘struct cpsw_priv’ has no member named ‘rx_mode_work’
 1466 |         INIT_WORK(&priv_sl2->rx_mode_work, cpsw_ndo_set_rx_mode_work);
      |                            ^~
/tmp/kci/linux/include/linux/workqueue.h:288:30: note: in definition of macro ‘__INIT_WORK_KEY’
  288 |                 __init_work((_work), _onstack);                         \
      |                              ^~~~~
/tmp/kci/linux/include/linux/workqueue.h:303:9: note: in expansion of macro ‘__INIT_WORK’
  303 |         __INIT_WORK((_work), (_func), 0)
      |         ^~~~~~~~~~~
/tmp/kci/linux/drivers/net/ethernet/ti/cpsw.c:1466:9: note: in expansion of macro ‘INIT_WORK’
 1466 |         INIT_WORK(&priv_sl2->rx_mode_work, cpsw_ndo_set_rx_mode_work);
      |         ^~~~~~~~~
/tmp/kci/linux/drivers/net/ethernet/ti/cpsw.c:1466:28: error: ‘struct cpsw_priv’ has no member named ‘rx_mode_work’
 1466 |         INIT_WORK(&priv_sl2->rx_mode_work, cpsw_ndo_set_rx_mode_work);
      |                            ^~
/tmp/kci/linux/include/linux/workqueue.h:289:18: note: in definition of macro ‘__INIT_WORK_KEY’
  289 |                 (_work)->data = (atomic_long_t) WORK_DATA_INIT();       \
      |                  ^~~~~
/tmp/kci/linux/include/linux/workqueue.h:303:9: note: in expansion of macro ‘__INIT_WORK’
  303 |         __INIT_WORK((_work), (_func), 0)
      |         ^~~~~~~~~~~
/tmp/kci/linux/drivers/net/ethernet/ti/cpsw.c:1466:9: note: in expansion of macro ‘INIT_WORK’
 1466 |         INIT_WORK(&priv_sl2->rx_mode_work, cpsw_ndo_set_rx_mode_work);
      |         ^~~~~~~~~
/tmp/kci/linux/drivers/net/ethernet/ti/cpsw.c:1466:28: error: ‘struct cpsw_priv’ has no member named ‘rx_mode_work’
 1466 |         INIT_WORK(&priv_sl2->rx_mode_work, cpsw_ndo_set_rx_mode_work);
      |                            ^~
/tmp/kci/linux/include/linux/workqueue.h:290:34: note: in definition of macro ‘__INIT_WORK_KEY’
  290 |                 INIT_LIST_HEAD(&(_work)->entry);                        \
      |                                  ^~~~~
/tmp/kci/linux/include/linux/workqueue.h:303:9: note: in expansion of macro ‘__INIT_WORK’
  303 |         __INIT_WORK((_work), (_func), 0)
      |         ^~~~~~~~~~~
/tmp/kci/linux/drivers/net/ethernet/ti/cpsw.c:1466:9: note: in expansion of macro ‘INIT_WORK’
 1466 |         INIT_WORK(&priv_sl2->rx_mode_work, cpsw_ndo_set_rx_mode_work);
      |         ^~~~~~~~~
/tmp/kci/linux/drivers/net/ethernet/ti/cpsw.c:1466:28: error: ‘struct cpsw_priv’ has no member named ‘rx_mode_work’
 1466 |         INIT_WORK(&priv_sl2->rx_mode_work, cpsw_ndo_set_rx_mode_work);
      |                            ^~
/tmp/kci/linux/include/linux/workqueue.h:291:18: note: in definition of macro ‘__INIT_WORK_KEY’
  291 |                 (_work)->func = (_func);                                \
      |                  ^~~~~
/tmp/kci/linux/include/linux/workqueue.h:303:9: note: in expansion of macro ‘__INIT_WORK’
  303 |         __INIT_WORK((_work), (_func), 0)
      |         ^~~~~~~~~~~
/tmp/kci/linux/drivers/net/ethernet/ti/cpsw.c:1466:9: note: in expansion of macro ‘INIT_WORK’
 1466 |         INIT_WORK(&priv_sl2->rx_mode_work, cpsw_ndo_set_rx_mode_work);
      |         ^~~~~~~~~
/tmp/kci/linux/drivers/net/ethernet/ti/cpsw.c: In function ‘cpsw_probe’:
/tmp/kci/linux/drivers/net/ethernet/ti/cpsw.c:1648:24: error: ‘struct cpsw_priv’ has no member named ‘rx_mode_work’
 1648 |         INIT_WORK(&priv->rx_mode_work, cpsw_ndo_set_rx_mode_work);
      |                        ^~
/tmp/kci/linux/include/linux/workqueue.h:288:30: note: in definition of macro ‘__INIT_WORK_KEY’
  288 |                 __init_work((_work), _onstack);                         \
      |                              ^~~~~
/tmp/kci/linux/include/linux/workqueue.h:303:9: note: in expansion of macro ‘__INIT_WORK’
  303 |         __INIT_WORK((_work), (_func), 0)
      |         ^~~~~~~~~~~
/tmp/kci/linux/drivers/net/ethernet/ti/cpsw.c:1648:9: note: in expansion of macro ‘INIT_WORK’
 1648 |         INIT_WORK(&priv->rx_mode_work, cpsw_ndo_set_rx_mode_work);
      |         ^~~~~~~~~
/tmp/kci/linux/drivers/net/ethernet/ti/cpsw.c:1648:24: error: ‘struct cpsw_priv’ has no member named ‘rx_mode_work’
 1648 |         INIT_WORK(&priv->rx_mode_work, cpsw_ndo_set_rx_mode_work);
      |                        ^~
/tmp/kci/linux/include/linux/workqueue.h:289:18: note: in definition of macro ‘__INIT_WORK_KEY’
  289 |                 (_work)->data = (atomic_long_t) WORK_DATA_INIT();       \
      |                  ^~~~~
/tmp/kci/linux/include/linux/workqueue.h:303:9: note: in expansion of macro ‘__INIT_WORK’
  303 |         __INIT_WORK((_work), (_func), 0)
      |         ^~~~~~~~~~~
/tmp/kci/linux/drivers/net/ethernet/ti/cpsw.c:1648:9: note: in expansion of macro ‘INIT_WORK’
 1648 |         INIT_WORK(&priv->rx_mode_work, cpsw_ndo_set_rx_mode_work);
      |         ^~~~~~~~~
/tmp/kci/linux/drivers/net/ethernet/ti/cpsw.c:1648:24: error: ‘struct cpsw_priv’ has no member named ‘rx_mode_work’
 1648 |         INIT_WORK(&priv->rx_mode_work, cpsw_ndo_set_rx_mode_work);
      |                        ^~
/tmp/kci/linux/include/linux/workqueue.h:290:34: note: in definition of macro ‘__INIT_WORK_KEY’
  290 |                 INIT_LIST_HEAD(&(_work)->entry);                        \
      |                                  ^~~~~
/tmp/kci/linux/include/linux/workqueue.h:303:9: note: in expansion of macro ‘__INIT_WORK’
  303 |         __INIT_WORK((_work), (_func), 0)
      |         ^~~~~~~~~~~
/tmp/kci/linux/drivers/net/ethernet/ti/cpsw.c:1648:9: note: in expansion of macro ‘INIT_WORK’
 1648 |         INIT_WORK(&priv->rx_mode_work, cpsw_ndo_set_rx_mode_work);
      |         ^~~~~~~~~
/tmp/kci/linux/drivers/net/ethernet/ti/cpsw.c:1648:24: error: ‘struct cpsw_priv’ has no member named ‘rx_mode_work’
 1648 |         INIT_WORK(&priv->rx_mode_work, cpsw_ndo_set_rx_mode_work);
      |                        ^~
/tmp/kci/linux/include/linux/workqueue.h:291:18: note: in definition of macro ‘__INIT_WORK_KEY’
  291 |                 (_work)->func = (_func);                                \
      |                  ^~~~~
/tmp/kci/linux/include/linux/workqueue.h:303:9: note: in expansion of macro ‘__INIT_WORK’
  303 |         __INIT_WORK((_work), (_func), 0)
      |         ^~~~~~~~~~~
/tmp/kci/linux/drivers/net/ethernet/ti/cpsw.c:1648:9: note: in expansion of macro ‘INIT_WORK’
 1648 |         INIT_WORK(&priv->rx_mode_work, cpsw_ndo_set_rx_mode_work);
      |         ^~~~~~~~~
/tmp/kci/linux/drivers/net/ethernet/ti/cpsw.c: In function ‘cpsw_remove’:
/tmp/kci/linux/drivers/net/ethernet/ti/cpsw.c:1766:17: error: implicit declaration of function ‘disable_work_sync’; did you mean ‘disable_irq_nosync’? [-Wimplicit-function-declaration]
 1766 |                 disable_work_sync(&priv->rx_mode_work);
      |                 ^~~~~~~~~~~~~~~~~
      |                 disable_irq_nosync
/tmp/kci/linux/drivers/net/ethernet/ti/cpsw.c:1766:40: error: ‘struct cpsw_priv’ has no member named ‘rx_mode_work’
 1766 |                 disable_work_sync(&priv->rx_mode_work);
      |                                        ^~

=====================================================

When fixing this issue, please attribute this report according to the
patch submission rules:

Reported-by: kernelci.org bot <bot@kernelci.org>

For complete logs and details about the environment used, see the issue
on the KernelCI dashboard:

- dashboard: https://d.kernelci.org/i/maestro:90753278e76c487a72fba54a64fc3be4b1e64280
- giturl: https://git.kernel.org/pub/scm/linux/kernel/git/stable/linux-stable-rc.git
- commit HEAD:  02cc578650bea44d7dbb965be9f8bfb13b1ea8de

# Builds where the incident occurred:

## multi_v7_defconfig on (arm):
- compiler: gcc-15
- config: None
- dashboard: https://d.kernelci.org/build/maestro:6aabea0ffc1857a999df0c27

#kernelci issue maestro:90753278e76c487a72fba54a64fc3be4b1e64280

--
This is an experimental report format. Please send feedback in!
Talk to us at kernelci@lists.linux.dev

Made with love by the KernelCI team - https://kernelci.org
