Received: from mail-pl1-f173.google.com (mail-pl1-f173.google.com [209.85.214.173])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 36125353A75
	for <stable@vger.kernel.org>; Fri, 11 Sep 2026 14:59:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.173
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1789138754; cv=none; b=GXz03Mk6dvbDNFIUCvEl3fE1TAaqgqi/iDYUswVxTQi0R8K8tpap3Gw1zk1Zt9Dzrg219g7ROS4pMXjoPw+2H16W1FMkXkhFCzY3rHK+XMGENaAYKXcQUMP3icNwA0T+Un40WsDJ7+mknT8ILK+X4nfzqWfWs6+2s43marVq4aw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1789138754; c=relaxed/simple;
	bh=YT6fdcwJ2oY8sBXOi6OzVDatdpWdaFddchD5Y7tFvd0=;
	h=Content-Type:MIME-Version:Subject:From:To:Cc:Date:Message-ID; b=BYlr/OFaBEKmbaJAYKnusTGHB2NQ0s8UC4mPOr5ick961rNAJZpAtJ3PaTzSyvy1JI5IhR/LWfj1YHa4IZ8aEMnFZbqOxhcrcSqjX8MfMLhls/+QJV0m86MPmZxpz/cYPQkczSRSFAlrrNyATFSC+HzslhDKgEjHqdyD+AtAur8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=kernelci.org; spf=pass smtp.mailfrom=kernelci.org; dkim=pass (2048-bit key) header.d=kernelci.org header.i=@kernelci.org header.b=ahVZrxvY; arc=none smtp.client-ip=209.85.214.173
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=kernelci.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=kernelci.org
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernelci.org header.i=@kernelci.org header.b="ahVZrxvY"
Received: by mail-pl1-f173.google.com with SMTP id d9443c01a7336-2db710396ffso19042675ad.1
        for <stable@vger.kernel.org>; Fri, 11 Sep 2026 07:59:09 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=kernelci.org; s=google; t=1789138748; x=1789743548; darn=vger.kernel.org;
        h=message-id:date:reply-to:cc:to:from:subject
         :content-transfer-encoding:mime-version:content-type:from:to:cc
         :subject:date:message-id:reply-to:content-type;
        bh=sjPJqCY5Zvx1uJ0EZr6t2o7w7mwBOplsQsUuvN0DXiY=;
        b=ahVZrxvYqkxRT8T/lKIrMWFP9nF4VlfInuOa2tP8xlvTZTVIsH1czeLPLBgJx85AiS
         h8cSKwbpM7nJMp7V6Scu1Kox+61yA8VPa5Eq1pkwnCLmvp9HSs+nrXiBPoh1Rdu0KZzG
         45mxCej8ytHuEUwYESzqYIcvRoBg4yEGiBT10sH5MjKkLGFV+6dKlrXeKPgseW4MWHg+
         UhCzBcJyzi/TQOMOSISBY9OL+7C406fOrIPYFhxWIl9uNrE6nEkgcrdfS0Dwjv5TnmqE
         wSuX1kRlSOsBPv7lTFW5kPnVIL9QHGeSOMRQZCZV5Mob6HHpumh0vJESCldWq4xSJ5yL
         SeYw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1789138748; x=1789743548;
        h=message-id:date:reply-to:cc:to:from:subject
         :content-transfer-encoding:mime-version:content-type:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=sjPJqCY5Zvx1uJ0EZr6t2o7w7mwBOplsQsUuvN0DXiY=;
        b=Qpkl/QLVLlXVl9iywB46lFCHFeA81hxzO/zoeCE/Lt0p6EIdv+szTL1VyJwDmF/tKt
         3onYYe7fYtq2zKwueB7A8toN8xyInRpeWdo3jndv9zWXYMIb5sLGPDD2wMe5KBrd8vb/
         lgsiRK8RfZHTQN/fXVU+2u+iLTbD5RsnYwZLwcNmzOsQJAT6yLd4AuaYuG0X6fRNt2a/
         28TvcTKKmTH7xn/bftl+DhBbCzQB2uAh4t09qgyDy/bHeZ8S2ACZ5T2B4XplE90+2p3H
         1jVNKLcSuydcF1HjRfcEILBJyJBRl+NYJF33EBYrhc7Awv2Re68XDVEVT54Q3cKikehl
         UzJw==
X-Gm-Message-State: AFuF++nWlcwqtsZJF1Oy85ZTIhusrMT7dYwtiubb+2/2d3uVnwmfybrL
	oZZMzvV8VAAYYOhLWMLq6hNWnp9Ecs2LGYk4mFaG2Ap/e508HbrfLTN0ZhquJJEwVsk=
X-Gm-Gg: AYBFou0I/c3ol0LLYQ8K2pqycUvP68KAPggqSxxanUiJvO5CC5pH12B+quCtdhF6V2Y
	kg4Lg+zdkTT8qblI3lHVEvak/wMCRQn5iNAelYRT28k6tr4MNL3gX7vlt+DqXbv9oSyzs18ANf1
	CfoebSFE7+y8cgyAXicDnBXNgCtreFsDVMhZyTLXao9iUUxXxbG8mia696lqvBpPintl9pCoO0k
	EA6aDSJGeKvnyxVlH8UkkZeTziYf/95R91QeTTtwPT7mug0sh4yfmpByrF4CFFrZoZgApzbGmLK
	yngwX9SITnNEtar/XxZFu+frHTyb8SRJZFm0Bz8pePfbr3AoQWwSY6AiGNB2tQZ+VUfB8G087aU
	WCd+uazMsgKiUgC04OunRLfmr1ee4ppRm1fmALuw3c60ZnShz2k9mCnpABRMDXLhcjSL2lcrHl6
	WjoqZAYz+WyZAV+DYSnbYe82vt01xr7af2yFFUf7BLuTb4XjaCgFWmJtdGNuVJLyQ=
X-Received: by 2002:a17:90a:bb83:b0:39d:8b8c:3783 with SMTP id 98e67ed59e1d1-39d8b8c3f9bmr5890025a91.6.1789138747820;
        Fri, 11 Sep 2026 07:59:07 -0700 (PDT)
Received: from 41049dfc76e5 ([20.38.40.137])
        by smtp.gmail.com with ESMTPSA id 5a478bee46e88-33ba4e9a3casm7220766eec.12.2026.09.11.07.59.07
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 11 Sep 2026 07:59:07 -0700 (PDT)
Content-Type: text/plain; charset="utf-8"
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Subject: 
 =?utf-8?q?=5BREGRESSION=5D_stable-rc/linux-6=2E6=2Ey=3A_=28build=29/tmp/kci/?=
 =?utf-8?q?linux/include/linux/fortify-string=2Eh=3A80=3A33=3A_error=3A_?=
 =?utf-8?q?=E2=80=98=5F=5Fbuil=2E=2E=2E?=
From: KernelCI bot <bot@kernelci.org>
To: kernelci-results@groups.io
Cc: stable@vger.kernel.org
Reply-To: kernelci@lists.linux.dev
Date: Fri, 11 Sep 2026 14:59:07 -0000
Message-ID: <178913874709.4387.7490198504895505836@kernelci.org>

New build issue found on stable-rc/linux-6.6.y:

---
/tmp/kci/linux/include/linux/fortify-string.h:80:33: error: ‘__builtin_strncat’ specified bound 18446744073709551609 exceeds maximum object size 9223372036854775807 [-Werror=stringop-overread] in kernel/trace/trace_events_hist.o (kernel/trace/trace_events_hist.c) [logspec:kbuild,kbuild.compiler.error]
---

Log excerpt:
=====================================================
    inlined from ‘event_hist_trigger_parse’ at /tmp/kci/linux/kernel/trace/trace_events_hist.c:6776:3:
/tmp/kci/linux/include/linux/fortify-string.h:80:33: error: ‘__builtin_strncat’ specified bound 18446744073709551609 exceeds maximum object size 9223372036854775807 [-Werror=stringop-overread]
   80 | #define __underlying_strncat    __builtin_strncat
      |                                 ^
/tmp/kci/linux/include/linux/fortify-string.h:479:24: note: in expansion of macro ‘__underlying_strncat’
  479 |                 return __underlying_strncat(p, q, count);
      |                        ^~~~~~~~~~~~~~~~~~~~
cc1: all warnings being treated as errors

=====================================================

When fixing this issue, please attribute this report according to the
patch submission rules:

Reported-by: kernelci.org bot <bot@kernelci.org>

For complete logs and details about the environment used, see the issue
on the KernelCI dashboard:

- dashboard: https://d.kernelci.org/i/maestro:e9879d2cf5ad796b1982f5eff70fc707a4312f3c
- giturl: https://git.kernel.org/pub/scm/linux/kernel/git/stable/linux-stable-rc.git
- commit HEAD:  c33bbcf64a1d0e2170b7cdee977e2c00e258a70f

# Builds where the incident occurred:

## x86_64_defconfig+lab-setup+x86-board+kselftest on (x86_64):
- compiler: gcc-15
- config: None
- dashboard: https://d.kernelci.org/build/maestro:6aa40c9520239ade9022a48f

#kernelci issue maestro:e9879d2cf5ad796b1982f5eff70fc707a4312f3c

--
This is an experimental report format. Please send feedback in!
Talk to us at kernelci@lists.linux.dev

Made with love by the KernelCI team - https://kernelci.org
