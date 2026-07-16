Received: from mail-pj1-f43.google.com (mail-pj1-f43.google.com [209.85.216.43])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6F5FC25F98A
	for <stable@vger.kernel.org>; Thu, 16 Jul 2026 14:59:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.216.43
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1784213948; cv=none; b=cWDP7DnVNoYOVLQ0sgBDA73ikJlUn1rPcRpSMqB0OIhLnIaD8eSUiTvd/q+9Z0oeYcu8vhKpRMP88oXcASwczVSD9rBnTB9m9QptCQE+fgaWRcgXzREonSjoyY7bUOHVYQzTxMZqf9sBLbMvSBlExh12OPV/BppnaDxL6H2sRpY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1784213948; c=relaxed/simple;
	bh=61OhyX3JpqqBT08BBusLA1YdnJ1BrOZQm9sDjEr3ZVM=;
	h=Content-Type:MIME-Version:Subject:From:To:Cc:Date:Message-ID; b=Z9BjOab6h72wVZ0l/Gr6CeaVjxLhgwi+cdu1UmNidgNdeSrUxsRfY2LneyAN3vjzwklgvQ890hDVUaBH4Wl1c/UaaGQwVQ/OleNNELsq/kf5n9D5CUpVAiyvzmobRIWrOzE8ZF2XMkFiOfwyhpNFzwzHstY0W3/dYo0GhdHh5ds=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=kernelci.org; spf=pass smtp.mailfrom=kernelci.org; dkim=pass (2048-bit key) header.d=kernelci.org header.i=@kernelci.org header.b=QXYAwKc6; arc=none smtp.client-ip=209.85.216.43
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=kernelci.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=kernelci.org
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernelci.org header.i=@kernelci.org header.b="QXYAwKc6"
Received: by mail-pj1-f43.google.com with SMTP id 98e67ed59e1d1-383cb94f742so6367229a91.3
        for <stable@vger.kernel.org>; Thu, 16 Jul 2026 07:59:05 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=kernelci.org; s=google; t=1784213945; x=1784818745; darn=vger.kernel.org;
        h=message-id:date:reply-to:cc:to:from:subject
         :content-transfer-encoding:mime-version:content-type:from:to:cc
         :subject:date:message-id:reply-to:content-type;
        bh=ShpmxKivp57aPPxKNf0+62J9Nh88sumVmGbahRKm3NY=;
        b=QXYAwKc6MnPAEwqh04gPih2gq9CAO6Q0Q9V5IWlq+dZoIMb/jIvAtQjkldPKkNWLpt
         X+28roSyAW1bTb37ctn2dNDQpTMdJc2KF2+/uJStkrFi/esXlwvbuOB1T2vb6be+A49U
         FJu5f4v85oWfbPUriLbAPONqtrQdJS5DUgQeL1VmvJ9Nl9FoWvOMJ8K96UQBklbFPTEq
         X698ZxBOBlMJkRoS+8jbZti1zRJcoljTA8zqxbGowXms6zv+ev2fA77INavyKAtRMcTV
         L06fJbAXQAEl7VauC52btXjwuYyhuLYQirm2lv7FjB/XDMyhtQq/04Zb/MKyzpdH/xDJ
         EK2w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1784213945; x=1784818745;
        h=message-id:date:reply-to:cc:to:from:subject
         :content-transfer-encoding:mime-version:content-type:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=ShpmxKivp57aPPxKNf0+62J9Nh88sumVmGbahRKm3NY=;
        b=c7v/EflqSspnLtBjFqsJy3bOsnbOAK+7oWX2txgwfmxreqFsiraeCi8dZWNgfZJTxw
         1H+rSMsgYVz0O2EX3veK/eUpidAGbhmhzxVI97u++FboeMdklYKOJQ8t++pMaCMqFcQi
         WOt7fpdEISP1oBBmd8mO6xaLF7VhZris9JR4w0IfsLG8C5QexKktTS1dkmHEaAabRP0J
         +B0QGL/0xnlhXSMeMTwBAnNnZYyW1k5YxxqmO/A65T3ZK/m5Kmq6yshgK8o9yv4vonNj
         et2S0VvJQXdoZ+3+Yhv3W+sqhXXK+x6yRYceDzbUKS1gyM4tnWglbrUnPSlXYCknzWWT
         c/TQ==
X-Gm-Message-State: AOJu0YyHfJ/MjZlyczymQkVDMXcto8FD0J2Y99IhiHSZZkZCO/CO7aHd
	aAxqYRd3sMS5B5usTpH4h6DoQ11tppdI4hkvPKvxN2bSZmPgD/VkQWfgm8drp4Hk25I=
X-Gm-Gg: AfdE7cnBnwWwo0bRwacdHhTRzEjpTT9WKooP040cQcRCipWLctO6o/U55yXZFzRyhQj
	vGeDH5T694CDq+2ShgSLjm916NbIfO3csXiO1yMDm6Stdk+TIfcO5HDEVg1jzf+2mTXHlQiPk1n
	JOPHPP0Sm3ZEyg7FC9//L4oDyipTU/ylKGP7FdNrLxWWtngasce3uEgpyTk4QM0Y57OtaEfG564
	b0vfbrgcVL1mzD6tUcXEwy7Yp1S56heZ9K1KDnSVka+QwOCWzenHuW/po54yx2KjZ0WilBUtQ5h
	HOUC3rTrEVVcJI0kll7l0JQsc9tXNTVbv0E4XeHqWVx0iBJoK4wLt6lLXu3IUXJxbe/zYetOxYQ
	ik0HPsNj+Ia3rjNbMdTANuniopXmvwTkiThn0y+BdSTtV8Zy6HF7bgDRcIeFAFW0DUTQcLYe5FK
	cKLYFJvQ==
X-Received: by 2002:a17:90b:528d:b0:380:ced0:ecf9 with SMTP id 98e67ed59e1d1-38e29ff9736mr6851705a91.4.1784213945202;
        Thu, 16 Jul 2026 07:59:05 -0700 (PDT)
Received: from 963b246bc1b3 ([20.38.40.137])
        by smtp.gmail.com with ESMTPSA id 5a478bee46e88-3140e4fd3e9sm12458373eec.1.2026.07.16.07.59.04
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 16 Jul 2026 07:59:04 -0700 (PDT)
Content-Type: text/plain; charset="utf-8"
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Subject: [REGRESSION] stable-rc/linux-5.10.y: (build) implicit declaration of
 function
 'reset_control_rearm' [-Werror,-W...
From: KernelCI bot <bot@kernelci.org>
To: kernelci-results@groups.io
Cc: stable@vger.kernel.org
Reply-To: kernelci@lists.linux.dev
Date: Thu, 16 Jul 2026 14:59:04 -0000
Message-ID: <178421394341.11493.847396226916387335@kernelci.org>

New build issue found on stable-rc/linux-5.10.y:

---
 implicit declaration of function 'reset_control_rearm' [-Werror,-Wimplicit-function-declaration] in drivers/usb/dwc3/dwc3-meson-g12a.o (drivers/usb/dwc3/dwc3-meson-g12a.c) [logspec:kbuild,kbuild.compiler.error]
---

Log excerpt:
=====================================================
/tmp/kci/linux/drivers/usb/dwc3/dwc3-meson-g12a.c:946:2: error: implicit declaration of function 'reset_control_rearm' [-Werror,-Wimplicit-function-declaration]
  946 |         reset_control_rearm(priv->reset);
      |         ^
/tmp/kci/linux/drivers/usb/dwc3/dwc3-meson-g12a.c:946:2: note: did you mean 'reset_control_reset'?
/tmp/kci/linux/include/linux/reset.h:15:5: note: 'reset_control_reset' declared here
   15 | int reset_control_reset(struct reset_control *rstc);
      |     ^
1 error generated.

=====================================================

When fixing this issue, please attribute this report according to the
patch submission rules:

Reported-by: kernelci.org bot <bot@kernelci.org>
Link: https://lore.kernel.org/all/178421394341.11493.847396226916387335@kernelci.org/

For complete logs and details about the environment used, see the issue
on the KernelCI dashboard:

- dashboard: https://d.kernelci.org/i/maestro:503b25a066b964e688f73911e95e470932773dd3
- giturl: https://git.kernel.org/pub/scm/linux/kernel/git/stable/linux-stable-rc.git
- commit HEAD:  6bb9d231b054d4343f7d9fa35fb4333ed9ace2d6

# Builds where the incident occurred:

## defconfig+arm64-chromebook+kselftest on (arm64):
- compiler: clang-21
- config: None
- dashboard: https://d.kernelci.org/build/maestro:6a58e67d3427a5b0fbe2c792

## multi_v7_defconfig on (arm):
- compiler: clang-21
- config: None
- dashboard: https://d.kernelci.org/build/maestro:6a58e6723427a5b0fbe2c788

#kernelci issue maestro:503b25a066b964e688f73911e95e470932773dd3

--
This is an experimental report format. Please send feedback in!
Talk to us at kernelci@lists.linux.dev

Made with love by the KernelCI team - https://kernelci.org
