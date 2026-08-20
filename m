Received: from mail-pj1-f45.google.com (mail-pj1-f45.google.com [209.85.216.45])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4CD8B25B08E
	for <stable@vger.kernel.org>; Thu, 20 Aug 2026 22:59:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.216.45
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1787266748; cv=none; b=roJeXlHZDCQJ7CBrAKyNYw9HXl1h+JYBr1+Aao7/riL/xWen2GaxNXEI5hDPcuSsc1p2EKxQenoN1kmn+77PuCkc5wVcIVChTQUZJHKyFCq+9oihSx2axJEO5Jy/ZqULL5MILnAJFOU/VEM6gmWgdFVbjvYM9VN3OQCbdh3ELk8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1787266748; c=relaxed/simple;
	bh=ngByA10emgdxM5UHa+RxRnlSjddvX5xzkeSS1kMjDqo=;
	h=Content-Type:MIME-Version:Subject:From:To:Cc:Date:Message-ID; b=KXabdUqgNXYteBQgGB3kTZ2JrJuhWBA/WouzVV8/u7RQuSFw7Cxjc5YuSaLLmyOGbgYhCcA7+0KZtqEGuGIrM/i2p/ptaJ7/Z7+bsTfeQXROah7XQU7zRtMmVjVBcoICpI2cqVTwzghNNl7vRD9UmEoHGKhukhUkMkZjz7Y8LFc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=kernelci.org; spf=pass smtp.mailfrom=kernelci.org; dkim=pass (2048-bit key) header.d=kernelci.org header.i=@kernelci.org header.b=izQmt5uj; arc=none smtp.client-ip=209.85.216.45
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=kernelci.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=kernelci.org
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernelci.org header.i=@kernelci.org header.b="izQmt5uj"
Received: by mail-pj1-f45.google.com with SMTP id 98e67ed59e1d1-38ea87caafeso226503a91.3
        for <stable@vger.kernel.org>; Thu, 20 Aug 2026 15:59:05 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=kernelci.org; s=google; t=1787266745; x=1787871545; darn=vger.kernel.org;
        h=message-id:date:reply-to:cc:to:from:subject
         :content-transfer-encoding:mime-version:content-type:from:to:cc
         :subject:date:message-id:reply-to:content-type;
        bh=qVhhbTAHPzZGUGcmSE3WnC31BC/4bNVQtIpJ4+qTvoc=;
        b=izQmt5ujbA7hmhnMCJgO/1Vx4Hw+7xsVHTfFUes+F8SY08lnTC6oGziTK6IyBYpcW3
         8k7GuaDQ0UpvhLv/U/Nk4DQeBz6Yr+183FGtBg96c37JXliW+MHbxuolTEAr645GMIRV
         pn7aNHUk5PSdJVqr2a7o0y//jeio4bpJ+uEmzSDQjQcpnyZ+tHHeGoSTtcdyvVNY+Ay/
         bRl9VOPc7nu/TgvUz7xh1G4g6bFjMWtndoDsOXIakeVgofXaB1XoLiW6yZVthqtZVaiv
         cN6EvvEKwo2h3P6YmJppKNrqHpiZIFjB6A+pOXx3DCxDMjzM2hO9dgPieqYwgL5Y0BRZ
         2cxA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1787266745; x=1787871545;
        h=message-id:date:reply-to:cc:to:from:subject
         :content-transfer-encoding:mime-version:content-type:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=qVhhbTAHPzZGUGcmSE3WnC31BC/4bNVQtIpJ4+qTvoc=;
        b=qZyf9g8X/1eF8zf3PJgAUmKmmOudGs4ZK8t82cJOOdJlL/zYmmRMt6d3vOe7Ok5ox7
         YGIjobUMK5d3InWRo0QhTA0ILcdwIJnZg1zQ5dLvYdV3pZhK3gaJ23WM4rs6P91RXN1D
         VgfiE/r8X1K8COyxwXbjglJtcFPb+kMzlEF/Nwjg3DoueV3/qb7MUYAqLFOFOVAffc4W
         EblMIniUOAsFWWCoEAnibNUTXLlUC8qLkkp8bn6WYOixG9ELDfvLspCCocxaNHdzCy0O
         9k4gEHslaH9UEf4JBLvVl12bXrnqtpcnhKgugHeRvPuI9m+EV5TClQ9D/z6Zjl1YJtOd
         od9A==
X-Gm-Message-State: AFuF++kYovNxP8UECzcFkJj0aItkYazRJhRXDoYbXRe1pKCOVCwChSZy
	ia2fGrzk7zhOIzJYJm2Evx9pSXC4eSmufDeC9BNATfTX6804QN8eamD63mD6FgpGPVw=
X-Gm-Gg: AR+sD12zWe9ZcIzcWLgowr6w5BBZpcZZ7XMJV4nF8wvbFQndGEJ/kf96191vNTDfFB/
	cgiXcaUf+FIUzY6d89lKXBlb7VQ+MKJCoWuNCKPymlFUId1yD4k3kzmO1jQBzChBGWXbAlI/b0z
	KVUHB2dCBQpwJ+p2qMDwGrbTCrd+4oNG7WZHAr7n1BXOmyozblqPjxdHbv8mSOT2ugqWq73tehP
	g9isw1DmbZZlouWaNi4xhj5zh3XJYeSaiFjNEz+VjM/np0O0SEpsDOaDqhlSkCKVz7PatVAzTh0
	rmjucs+SimnJFEyFK7Mu3bBj8ymafr8n4gfNi1iW+6xXvBm+9A6lN8Z/8js8gGtz7rDV7mclBzk
	aAindATgtbQDSv+iC5Fm7CEp1WkcyHjkeE48NCu8dfiS2bE8S3yKpNeH5dAIDyi/XYN0Duq6WKo
	eanswiEdIRFFuF3uKlRGiFFYfET6LgfC5V0KwDEQgwUkw2CPZ2lct2
X-Received: by 2002:a17:90b:2c87:b0:392:7f74:58c9 with SMTP id 98e67ed59e1d1-395c3a43766mr3258455a91.15.1787266745294;
        Thu, 20 Aug 2026 15:59:05 -0700 (PDT)
Received: from b455de3d9de8 ([20.38.40.137])
        by smtp.gmail.com with ESMTPSA id a92af1059eb24-1416ad69638sm18248948c88.7.2026.08.20.15.59.03
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 20 Aug 2026 15:59:04 -0700 (PDT)
Content-Type: text/plain; charset="utf-8"
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Subject: [REGRESSION] stable-rc/linux-7.1.y: (build) stack frame size (2096)
 exceeds
 limit (2048) in 'dml314_ModeSuppor...
From: KernelCI bot <bot@kernelci.org>
To: kernelci-results@groups.io
Cc: stable@vger.kernel.org
Reply-To: kernelci@lists.linux.dev
Date: Thu, 20 Aug 2026 22:59:03 -0000
Message-ID: <178726674343.934.9433374333508551644@kernelci.org>

New build issue found on stable-rc/linux-7.1.y:

---
 stack frame size (2096) exceeds limit (2048) in 'dml314_ModeSupportAndSystemConfigurationFull' [-Werror,-Wframe-larger-than] in drivers/gpu/drm/amd/amdgpu/../display/dc/dml/dcn314/display_mode_vba_314.o (drivers/gpu/drm/amd/amdgpu/../display/dc/dml/dcn314/display_mode_vba_314.c) [logspec:kbuild,kbuild.compiler.error]
---

Log excerpt:
=====================================================
/tmp/kci/linux/drivers/gpu/drm/amd/amdgpu/../display/dc/dml/dcn314/display_mode_vba_314.c:3892:6: error: stack frame size (2096) exceeds limit (2048) in 'dml314_ModeSupportAndSystemConfigurationFull' [-Werror,-Wframe-larger-than]
 3892 | void dml314_ModeSupportAndSystemConfigurationFull(struct display_mode_lib *mode_lib)
      |      ^
1 error generated.

=====================================================

When fixing this issue, please attribute this report according to the
patch submission rules:

Reported-by: kernelci.org bot <bot@kernelci.org>

For complete logs and details about the environment used, see the issue
on the KernelCI dashboard:

- dashboard: https://d.kernelci.org/i/maestro:2318f8492f6acdd68704ab04516d4812b0caff15
- giturl: https://git.kernel.org/pub/scm/linux/kernel/git/stable/linux-stable-rc.git
- commit HEAD:  89a96476cd72dc1e1fc0e617e4fad9f5f68546a9

# Builds where the incident occurred:

## x86_64_defconfig+kselftest+x86-board on (x86_64):
- compiler: clang-21
- config: None
- dashboard: https://d.kernelci.org/build/maestro:6a87162962f33761c0f0cae3

#kernelci issue maestro:2318f8492f6acdd68704ab04516d4812b0caff15

--
This is an experimental report format. Please send feedback in!
Talk to us at kernelci@lists.linux.dev

Made with love by the KernelCI team - https://kernelci.org
