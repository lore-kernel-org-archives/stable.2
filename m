Received: from mail-dy1-f176.google.com (mail-dy1-f176.google.com [74.125.82.176])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C6F09211A28
	for <stable@vger.kernel.org>; Sat, 30 May 2026 12:59:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=74.125.82.176
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1780145947; cv=none; b=JV2uW5RvZCCrvKaZIIUucn6GiaJ6cYpA/dEPi1b4ZAcH3xnZjllAaToTrEkUaSaItyM0vXVE9wXuYs4KioEAeZBq4fBYZFYIg8S/uueEs483IRJe0+zZcOxmg1gN42zbQPFoF35k8jlwrLW7M3bOF8PfMSIha+7GMX31PnB2Dyw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1780145947; c=relaxed/simple;
	bh=X9RNIh0lfRMijZLlhENR50gLkiONe6KP6F6XUisWTSc=;
	h=Content-Type:MIME-Version:Subject:From:To:Cc:Date:Message-ID; b=hmWZ567zqIPvI0DyYQwHYVdIyntOZO6j996lPlhdcT3UOF9kgzG7iD9kitlddorLRn6b2Hz0r8GhP2soQ4WpV5a/LZbEAMmNQM5NWL4en7SkSNnbrEzr7hNiex5ac/QA8+z9gF1y/0Kmfqi+mLRSYa4YU1ekuz8ER3ROlkLRuJk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=kernelci.org; spf=pass smtp.mailfrom=kernelci.org; dkim=pass (2048-bit key) header.d=kernelci.org header.i=@kernelci.org header.b=L6x2NnZe; arc=none smtp.client-ip=74.125.82.176
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=kernelci.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=kernelci.org
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernelci.org header.i=@kernelci.org header.b="L6x2NnZe"
Received: by mail-dy1-f176.google.com with SMTP id 5a478bee46e88-304fb780deaso845125eec.1
        for <stable@vger.kernel.org>; Sat, 30 May 2026 05:59:05 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=kernelci.org; s=google; t=1780145945; x=1780750745; darn=vger.kernel.org;
        h=message-id:date:reply-to:cc:to:from:subject
         :content-transfer-encoding:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=TWdrAgxyeasts3O7WRZtWgbPLgF6U/dZCNefg9Aqsws=;
        b=L6x2NnZeuhkub13UQ/N0eMuDW7t4r40D1rtX8PsLeftphEglmqwAs6rmOV2B8EuikQ
         Q53yUvz/kFsKyY5+HiV04uXFZLfrwy14E2l5xrSA8cWcvG+3K2wbBISkYQxCbucCOzdk
         d6Y10Dm05EMT6LV9v7vWdQQU0ULIzCrk6tFZB6RQwexrpZSeAccaykrALA7r0FoSVq/n
         +x517TiYGNZwvuylnA11VJuuYh2Us7FnSeyOt9ryu5GrGA0BuugUmgGetxLi32aSMJCM
         0BlvpUFuidkfSYOuV5du+WMg63FcP8uKoVfW9rPI9i0CXvpak8zDeeGszYcwyyWS6Fix
         aK9Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1780145945; x=1780750745;
        h=message-id:date:reply-to:cc:to:from:subject
         :content-transfer-encoding:mime-version:x-gm-gg:x-gm-message-state
         :from:to:cc:subject:date:message-id:reply-to;
        bh=TWdrAgxyeasts3O7WRZtWgbPLgF6U/dZCNefg9Aqsws=;
        b=LrzQbtWhjxUkLqjBqAwhY9BnOu8sBJA7Epa5KQLXI6C7A3GxeFtvxByn7d51PcBwxv
         mCfc/hzZXRmUe797iENVc4kuLDBKAPJ1qYCgOl3yW5GjQgORG3NbmllEWOPequtGTQhw
         NiY7bM/GTzcgfWAycYcmmQN2K1KudhT/kqBhsWrm07L2xpO470CwMSiNwAGfhHwNl5A9
         V52do0Loce6xLoGfYS9VquzS8pnXrU2Ez9/NxpmrpeL3g2VzxAwXavO0uWd6TV3sBynT
         fJmgnBid4GAJCiZvNKEdiF8usT9H6WIk537h6/I1thKOyFu3ghvj6BeeLGqUTgUI/tkB
         798Q==
X-Forwarded-Encrypted: i=1; AFNElJ+2UdjANEq/eAbu1uepp4wob3Dq+7dZH2XxH4BkforWMmTDkpxHNmRywcKai95TebQ2L72FyCE=@vger.kernel.org
X-Gm-Message-State: AOJu0YxqUwyMm7VydOF3bfyDCNzwBzfFvzfziAx0X5KfgaQut9u9z3HL
	5CT1XpCPydXaIhkXigKIez4kiwOCdfEN0zPIHhWDPQdG//cRqjSfqc7LH1AJ2qHiTDA=
X-Gm-Gg: Acq92OGJeoQ2hycOKSMX/LYcU9AXdV+KCOKQyTT79PCgo7YgQMRRqKF6M6JGgX94Zkt
	DRKk4NDlQION7E0C4fkhEkljsJhcpNPBeS4COh80Km1C1Cy8RjEWUncBudMQjFBqnYt/FEBPAUh
	YqZWD9+l5wm+uOQIcHV0qMWZe+v7r3g46Vb6jhoNQY7KLuQpsjgthiKjjV4cQxTvoophPYeLESK
	I8/DzMt9Bg3heVr8y+3xDV5DxDt+agLR3Io98j6Aa5j8HeNez6UUYRcToFpKLddfsaemlM4IPW0
	c/ntcJcXR+0nvPGmPWL15ozB6eKM9kwbLcz+D/3s+IJVWPRF6wUNxu8U72J8Fl0lXAnw8yKW60v
	DxPrAA4S+EneHzjUUrsOni83wLknTAIUZfhfODb/+ss0SC6pfm1bPOwx7KP+p5q60tXkilkXsWJ
	qNpzxUKK65S+Wc63xllOVESy6nONJhrKiJCNyN3Q==
X-Received: by 2002:a05:7300:72cc:b0:304:835e:fd25 with SMTP id 5a478bee46e88-304fa4c8209mr1812243eec.4.1780145944788;
        Sat, 30 May 2026 05:59:04 -0700 (PDT)
Received: from 330cfa3079ca ([20.38.40.137])
        by smtp.gmail.com with ESMTPSA id 5a478bee46e88-304ed5a9d27sm3929976eec.25.2026.05.30.05.59.04
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sat, 30 May 2026 05:59:04 -0700 (PDT)
Content-Type: text/plain; charset="utf-8"
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Subject: [REGRESSION] stable-rc/linux-5.15.y: (build) mixing declarations and
 code is a
 C99 extension [-Werror,-Wdeclara...
From: KernelCI bot <bot@kernelci.org>
To: kernelci-results@groups.io
Cc: gus@collabora.com, stable@vger.kernel.org
Reply-To: kernelci@lists.linux.dev
Date: Sat, 30 May 2026 12:59:04 -0000
Message-ID: <178014594367.7862.7999857847041901052@330cfa3079ca>





Hello,

New build issue found on stable-rc/linux-5.15.y:

---
 mixing declarations and code is a C99 extension [-Werror,-Wdeclaration-after-statement] in drivers/gpu/drm/sun4i/sun4i_backend.o (drivers/gpu/drm/sun4i/sun4i_backend.c) [logspec:kbuild,kbuild.compiler.error]
---

- dashboard: https://d.kernelci.org/i/maestro:b88e04d5e82ea9d31baaa986d3bdde82d8cbe1c9
- giturl: https://git.kernel.org/pub/scm/linux/kernel/git/stable/linux-stable-rc.git
- commit HEAD:  7d04e65adb8f77e1495a808e731537e67ec04e8a


Please include the KernelCI tag when submitting a fix:

Reported-by: kernelci.org bot <bot@kernelci.org>


Log excerpt:
=====================================================
/tmp/kci/linux/drivers/gpu/drm/sun4i/sun4i_backend.c:513:29: error: mixing declarations and code is a C99 extension [-Werror,-Wdeclaration-after-statement]
  513 |                 struct sun4i_layer_state *layer_state =
      |                                           ^
1 error generated.

=====================================================


# Builds where the incident occurred:

## defconfig+allmodconfig on (arm64):
- compiler: clang-21
- config: None
- dashboard: https://d.kernelci.org/build/maestro:6a1ac110ee38c2a863f01d7e

## defconfig+allmodconfig+CONFIG_FRAME_WARN=2048 on (arm):
- compiler: clang-21
- config: None
- dashboard: https://d.kernelci.org/build/maestro:6a1ac10cee38c2a863f01d7b


#kernelci issue maestro:b88e04d5e82ea9d31baaa986d3bdde82d8cbe1c9

--
This is an experimental report format. Please send feedback in!
Talk to us at kernelci@lists.linux.dev

Made with love by the KernelCI team - https://kernelci.org
