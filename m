Received: from mail-pj1-f50.google.com (mail-pj1-f50.google.com [209.85.216.50])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7797936B92C
	for <stable@vger.kernel.org>; Fri, 11 Sep 2026 14:59:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.216.50
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1789138749; cv=none; b=EEG0DoTnp/wdPvElWw2nXKSfQG9hZnRh2T2xW3lyODJ/ATnC+cb8r21C/wswtYIVwNU6zLYuDakCE17c8ZNIXVl0njNSnv9RobdmxvAyToC9U2y/1vNRG6YcSXKyUBWdcUvZVMcsK225LmI4mIiOAV5n7eDM60S6bYa4rA9LPEQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1789138749; c=relaxed/simple;
	bh=vshJV32wKvCzx+JzhlpC8ZF+0QSlDOPjwJ5dQVyWwbQ=;
	h=Content-Type:MIME-Version:Subject:From:To:Cc:Date:Message-ID; b=eLSYVOYgXcViLFFlc7z9NM6l93e6ZMpz0snZ31jxOa83kiv9MEVNtfEgnCNZ9ZKsqntK57Zfl2OlDvhacomjUfyfIAdM0rj+TwCkvk+k9tiF1+b/jMcp78drQicBjdzee7QD8kluzRuqir4kI1sDo8yghs7N/pBDE4EOdJJwQlw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=kernelci.org; spf=pass smtp.mailfrom=kernelci.org; dkim=pass (2048-bit key) header.d=kernelci.org header.i=@kernelci.org header.b=blDVsYri; arc=none smtp.client-ip=209.85.216.50
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=kernelci.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=kernelci.org
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernelci.org header.i=@kernelci.org header.b="blDVsYri"
Received: by mail-pj1-f50.google.com with SMTP id 98e67ed59e1d1-398b1e63c49so1861744a91.0
        for <stable@vger.kernel.org>; Fri, 11 Sep 2026 07:59:05 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=kernelci.org; s=google; t=1789138745; x=1789743545; darn=vger.kernel.org;
        h=message-id:date:reply-to:cc:to:from:subject
         :content-transfer-encoding:mime-version:content-type:from:to:cc
         :subject:date:message-id:reply-to:content-type;
        bh=CMooXcW+X+VxYx8KkULIIBophb0OKQDX7Sgp83LSpmg=;
        b=blDVsYriPSEnd1vHdp64bm5Ma6ScPXrOYqx1qUJPJg/huYcRn5cbWYSYId1Q0y3rh8
         XX0aaQVncL5ZMGrHTZof1rUBnuYEtvvgnhXLF8IbMIk68T0Wn0L8dUIbO4t56XkQ9nUT
         TVHF9HiSolUHGX5gWMHhCaZGCwWhxqnxCN2WEzSpQDjLDQqPV8st1rUifQa1aNcuGOx8
         uIGs0wQQDPQLCvAwSYYpmmIKyghY58I7CxFXaLYMx+8RAAfEw5k77lpqMKH1/3udgx5c
         OLHXa3iomkMLr6H6lpbipO1GboIRxh0jUj3zDp6rb7o3balXJSlKT5ftwVjaopuEreQH
         wx1w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1789138745; x=1789743545;
        h=message-id:date:reply-to:cc:to:from:subject
         :content-transfer-encoding:mime-version:content-type:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=CMooXcW+X+VxYx8KkULIIBophb0OKQDX7Sgp83LSpmg=;
        b=rnRmawUbSyVk6xwJsiqIhSAZgPTVe+bJEQRKKGhqdVfCmCw3J84D9HXNu377Ksdu9M
         Qfr9LfRB+Xh7q1xJqDZtxUczHooi+klCAtdxTjH5DHfbjfMO5k4hsacLUfwsN9/jLQCe
         P9c0F8xqe1d3DS9l0jiUeZHp6ISLK0JzOirsoUlrkt4i4wUOdxk0SlNQcHWJxhC7ys4V
         kIHDx/UtA82UVM0e1JSSMUcStju9d+bQgUpjcCWLucufdopfUwUEXpSu2QTRfu/pXzZE
         Ty4JZfb3crK6JlmT1iF7fVIHx5W6jejelXVZkR/caEekghSN6fzJQlHrZcrxHUiS3sur
         24kA==
X-Gm-Message-State: AFuF++nfpeU9p7MYzf3WcquD37+G0eCkkR2PfBrwEQbpapj2oY1bgQSv
	ea3nzjeMRITcx0s7aX/EQkNeFgOz5VoR4LrTj77fBuIi6SzjFL7NdLCP7KeXI35uQh3W5tYjuUc
	UawGw
X-Gm-Gg: AYBFou1pvjzNP7Z8SMINRXCB3kcZrERa1BMrQntC45qCJh0gsR0NR4ADkid+PS8LwJ4
	dE8LotiAnCmlPvDIhEDB11r0ZUL5mp8LSdLqStoPvsy/t84pGl31AUsmMJBCIjDh35UjDiJ84EI
	tJ5j5Sx9Asyzyv2cOfNyKGyHYMP4HFBYDmfyuNDWcG8F0or8Lukm7WoPIIyH4Ze+ZTKp5yw7Du3
	jqZDRfwNus5DPcbXN44zp4OOl9Fjl5bUT7+6PK8JV27dCLeo3usoX3VKLkFuvE4WHYbfUvt7ybO
	65k9/QjXNba0bBEhnkqIOCA2JPg/90qMdP28rdOsJ4YTqqBZ9q5CzdA/b+vXH1MmKDO9Nf9676l
	43mGPGuPHPB1R0uNoL1R/IFNYNOu7L1Aj6WoQwnCdCZaD9Y2+hPmiY3fsdVR1bPaUDs6qhYqN4J
	RORaQjy97Ydq6Pqri52+E3LiyySqXbCbDPFD3lJKa0iPORbhiPLNHrG0nPT1fWsZwwF/5sZmccn
	Q==
X-Received: by 2002:a17:90b:1ccc:b0:396:d28e:b53 with SMTP id 98e67ed59e1d1-39d77b1d009mr13588262a91.20.1789138744974;
        Fri, 11 Sep 2026 07:59:04 -0700 (PDT)
Received: from 41049dfc76e5 ([20.38.40.137])
        by smtp.gmail.com with ESMTPSA id 5a478bee46e88-33ba4f82c69sm7760451eec.27.2026.09.11.07.59.04
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 11 Sep 2026 07:59:04 -0700 (PDT)
Content-Type: text/plain; charset="utf-8"
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Subject: [REGRESSION] stable-rc/linux-6.18.y: (build)use of undeclared
 identifier
 'knav_qdev' in drivers/soc/ti/knav_qms...
From: KernelCI bot <bot@kernelci.org>
To: kernelci-results@groups.io
Cc: stable@vger.kernel.org
Reply-To: kernelci@lists.linux.dev
Date: Fri, 11 Sep 2026 14:59:04 -0000
Message-ID: <178913874409.4387.14615772113741156329@kernelci.org>

New build issue found on stable-rc/linux-6.18.y:

---
use of undeclared identifier 'knav_qdev' in drivers/soc/ti/knav_qmss_queue.o (drivers/soc/ti/knav_qmss_queue.c) [logspec:kbuild,kbuild.compiler.error]
---

Log excerpt:
=====================================================
/tmp/kci/linux/drivers/soc/ti/knav_qmss_queue.c:1871:2: error: use of undeclared identifier 'knav_qdev'
 1871 |         knav_qdev->debugfs_file =
      |         ^~~~~~~~~
1 error generated.

=====================================================

When fixing this issue, please attribute this report according to the
patch submission rules:

Reported-by: kernelci.org bot <bot@kernelci.org>

For complete logs and details about the environment used, see the issue
on the KernelCI dashboard:

- dashboard: https://d.kernelci.org/i/maestro:7951fd23b58ecb73a38a4b9e4b24c594695c25a9
- giturl: https://git.kernel.org/pub/scm/linux/kernel/git/stable/linux-stable-rc.git
- commit HEAD:  ee209bfcc3ce037908356ac4632c57a7e422a024

# Builds where the incident occurred:

## multi_v7_defconfig on (arm):
- compiler: clang-21
- config: None
- dashboard: https://d.kernelci.org/build/maestro:6aa40d7e20239ade9022b3fb

#kernelci issue maestro:7951fd23b58ecb73a38a4b9e4b24c594695c25a9

--
This is an experimental report format. Please send feedback in!
Talk to us at kernelci@lists.linux.dev

Made with love by the KernelCI team - https://kernelci.org
