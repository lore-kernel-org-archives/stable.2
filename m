Received: from mail-pz2-f12.google.com (mail-pz2-f12.google.com [74.125.228.12])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7592D43B6D3
	for <stable@vger.kernel.org>; Fri, 11 Sep 2026 15:59:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=74.125.228.12
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1789142351; cv=none; b=fDpODJbaMs6HvjadNLGXKv/6fvEKRIV7a1chtX1WT0YlIoIDqdw5Akcvd9WP3JMRCXuUGLKvkvJMOGiWPrQnyV8j7ZbP4NWq0zJF2qCcEqpan/QqX8OsN1C7YlwCutR4ajKg2V9Rd1iwwahGAwN2WqRVN6GiTM82nds+3qwGNjo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1789142351; c=relaxed/simple;
	bh=d6iGVjhH2v0Mj6DRSpZE+1cRyBvb/DjrSYCG4PxL3dE=;
	h=Content-Type:MIME-Version:Subject:From:To:Cc:Date:Message-ID; b=m5SR4hdQZHgsLj9hzRhY+jDyglbiZx2a3GgHZ14HHnSQT4/91mqlGJZzFfUS6nU6Y8aEJsEVjQCe4etfgwE9v26q9Aj0DZ+4PMko54WezGaIE6MO5m3u6I6gIfpmT+JACZyN3mcJL0ruPvzS/uSmcGbxJ6xoDGuHwpf+Qx7YJXA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=kernelci.org; spf=pass smtp.mailfrom=kernelci.org; dkim=pass (2048-bit key) header.d=kernelci.org header.i=@kernelci.org header.b=OP9c0jEh; arc=none smtp.client-ip=74.125.228.12
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=kernelci.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=kernelci.org
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernelci.org header.i=@kernelci.org header.b="OP9c0jEh"
Received: by mail-pz2-f12.google.com with SMTP id 41be03b00d2f7-cc1cea4bfb6so62717a12.3
        for <stable@vger.kernel.org>; Fri, 11 Sep 2026 08:59:08 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=kernelci.org; s=google; t=1789142348; x=1789747148; darn=vger.kernel.org;
        h=message-id:date:reply-to:cc:to:from:subject
         :content-transfer-encoding:mime-version:content-type:from:to:cc
         :subject:date:message-id:reply-to:content-type;
        bh=P7U5KJaNNilqEdSKkgrsH0qsLXBtbY03DQWkCf1oecU=;
        b=OP9c0jEhmwZOa7rHDF9OBaf9M0F52YdJqApWF0kTyRh3XZz2pDgTgPpyjzs+aVGouA
         ggTarXkN8aixSwnLZ1MS2T48r6L7amHEPInJQeEfvLKif0dilEAhaQHqad1pZP1yMZ4l
         dPU1WIQ51yI40TeI9UoiJTAaUTRmrkdmnacTSiXiOgx9fCRgnxRHxeyioYI3X2Z1uaMF
         50F4l7//6QgcHOlDK2pVufqx9FVXzC7bhTJ8EHXkq+V9Id8J8kU5NofTWF8Lz/DwW8l2
         3EKX6a2DL10j50/FroP3cdKJbIyQGte/qZhdCIPeUT81ivNPU12z4vFn89rjI1MsPdes
         u0vQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1789142348; x=1789747148;
        h=message-id:date:reply-to:cc:to:from:subject
         :content-transfer-encoding:mime-version:content-type:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=P7U5KJaNNilqEdSKkgrsH0qsLXBtbY03DQWkCf1oecU=;
        b=dXfk9qHIBwHMUQXYvm7UFmcbXWto79Fdb9mV2kYP5np7PAn97KTjr/GNgbQyaWa6jN
         J9WYlvAeqAR6kFSWUHGEMJ0lXnJowRWJCmb5MLoAG+qPDrWChH37kw2ihLieviYivbDU
         N6u2cpjU+a8t3d8G7g2eghkJaTu4lfgJXzNK56PtFutxjNptAocJrbotDl75+8zGK1e8
         7yvvzD8uPA35qP5mWGUGZ2yqchWyH6RdixZKh30DMgH4rvIMws7rOahQlAGesg9+d7tH
         wA2vBm7fZ4M+SqkpZTPP7q6ZlQYHFDo73bF+QzV6A+nr0OAOjK+LEu2VKlDsSOALgmol
         xfOA==
X-Gm-Message-State: AFuF++mWtB3rguTolE6fdI3wT+f9fGv9KvXhiVBicj+759AMvxd8LY1K
	PO1hFY05R0aUB1IDsEDc3mQkPsn60TZz350qEeLd9N2J2r+gn+wl+YalF6+op6uU4H4iQwLk87V
	wGKFP
X-Gm-Gg: AYBFou1jBJMb6nBPCB/rvFWTt7K29GRtL6ZbhibkKON8+M1B/YKi8IF3bxIrR/oTEw4
	1esTKwdq57GyQZARiDwHMhghAV7okV3aNvwemcPIEIa2WEu0+EztABY7kJ66+WpmbfbfywDl8W2
	Q7gfa5Cm+hW7dxOi8kHd9xtQkHJChXUwzGyPsaDZGM2hG0u7PSNgCsHLcDmIZZ7MQslosfiZs2k
	82pKY5jZAJk0qasYJw6lqT4KvbnSuFasx3gP94ldiRM0KplxQX6L2mj1x8j5iJyfCPzRGFLmB3V
	a2KFsJgtwR6GKKbmucdoLkzLxHuIy9v2KtymSLr3mSPu6P8XtyXeh8bmaqTRf2OjNilZQDHMkB/
	hTZONFEP/7uWAzXvKp0+a8ZVkVPTbLLx+fGrX1AdLd202aCxhQQlV4PhGmERC/lpaYpSnL7TXYj
	tX8BbNRb5prcrRupSwzkOxgJO2zLzRK15f/QLbhi3vW6Sc4BqCFqep9y5lUItp7R0=
X-Received: by 2002:a17:90b:4ad2:b0:398:9be6:f996 with SMTP id 98e67ed59e1d1-39d9c34a241mr7835226a91.21.1789142347339;
        Fri, 11 Sep 2026 08:59:07 -0700 (PDT)
Received: from 41049dfc76e5 ([20.38.40.137])
        by smtp.gmail.com with ESMTPSA id a92af1059eb24-14365b347e6sm6735879c88.4.2026.09.11.08.59.06
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 11 Sep 2026 08:59:07 -0700 (PDT)
Content-Type: text/plain; charset="utf-8"
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Subject: [REGRESSION] stable-rc/linux-6.6.y: (build)use of undeclared
 identifier
 'knav_qdev' in drivers/soc/ti/knav_qms...
From: KernelCI bot <bot@kernelci.org>
To: kernelci-results@groups.io
Cc: stable@vger.kernel.org
Reply-To: kernelci@lists.linux.dev
Date: Fri, 11 Sep 2026 15:59:06 -0000
Message-ID: <178914234635.4405.659388976121085003@kernelci.org>

New build issue found on stable-rc/linux-6.6.y:

---
use of undeclared identifier 'knav_qdev' in drivers/soc/ti/knav_qmss_queue.o (drivers/soc/ti/knav_qmss_queue.c) [logspec:kbuild,kbuild.compiler.error]
---

Log excerpt:
=====================================================
/tmp/kci/linux/drivers/soc/ti/knav_qmss_queue.c:1873:2: error: use of undeclared identifier 'knav_qdev'
 1873 |         knav_qdev->debugfs_file =
      |         ^~~~~~~~~
1 error generated.

=====================================================

When fixing this issue, please attribute this report according to the
patch submission rules:

Reported-by: kernelci.org bot <bot@kernelci.org>

For complete logs and details about the environment used, see the issue
on the KernelCI dashboard:

- dashboard: https://d.kernelci.org/i/maestro:9a37ad140ca46d9c24495dc1ff520c7822b236c3
- giturl: https://git.kernel.org/pub/scm/linux/kernel/git/stable/linux-stable-rc.git
- commit HEAD:  c33bbcf64a1d0e2170b7cdee977e2c00e258a70f

# Builds where the incident occurred:

## defconfig+allmodconfig+CONFIG_FRAME_WARN=2048 on (arm):
- compiler: clang-21
- config: None
- dashboard: https://d.kernelci.org/build/maestro:6aa40bfc20239ade90229dd9

#kernelci issue maestro:9a37ad140ca46d9c24495dc1ff520c7822b236c3

--
This is an experimental report format. Please send feedback in!
Talk to us at kernelci@lists.linux.dev

Made with love by the KernelCI team - https://kernelci.org
