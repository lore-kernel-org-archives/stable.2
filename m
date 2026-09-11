Received: from mail-pf1-f172.google.com (mail-pf1-f172.google.com [209.85.210.172])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D9D5536920D
	for <stable@vger.kernel.org>; Fri, 11 Sep 2026 14:59:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.210.172
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1789138750; cv=none; b=IPlnxtkPBzbjpgW51YeI2hfPuWx3gdQf31X8qGMCys85FEPbVEEKIEOOm5z3vK6r/yXNpKp/29dHz6AX4QSm2z3Wq0fku9jJgSDxSxBOCP3G5RqOM6s91EDf5dUyR5laF+jUH/6Or/XQeSUpyCVzHUFAiOfdWwri4f0FKS3dXWg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1789138750; c=relaxed/simple;
	bh=qBl+kMF/qvo9mszduPsTkTd7BB4U/dtuc7fefTEht28=;
	h=Content-Type:MIME-Version:Subject:From:To:Cc:Date:Message-ID; b=g4qtGIVZf2aOJ1q94boDq95Yrr875lPc5ZNmkcFo52kSINyrasD02U5Ll+n/7b6BIZbjjxejG2xG8/ivKDX7eaX9GpMcHiGD7ZeHPmINdToq+LhRjMNtY3mYZQJeusxyKTJa2KKf+UFAhcnSUG90nguv5IlbmUjo6eT/+oSc0KY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=kernelci.org; spf=pass smtp.mailfrom=kernelci.org; dkim=pass (2048-bit key) header.d=kernelci.org header.i=@kernelci.org header.b=OsoyCAtu; arc=none smtp.client-ip=209.85.210.172
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=kernelci.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=kernelci.org
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernelci.org header.i=@kernelci.org header.b="OsoyCAtu"
Received: by mail-pf1-f172.google.com with SMTP id d2e1a72fcca58-869fe350825so1212373b3a.1
        for <stable@vger.kernel.org>; Fri, 11 Sep 2026 07:59:07 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=kernelci.org; s=google; t=1789138746; x=1789743546; darn=vger.kernel.org;
        h=message-id:date:reply-to:cc:to:from:subject
         :content-transfer-encoding:mime-version:content-type:from:to:cc
         :subject:date:message-id:reply-to:content-type;
        bh=w4yyiBqB0sp/5dIoaBva/TCgVPoh7GZb6TIIT6yHyNs=;
        b=OsoyCAtuTzmJPGz2GwN21tXS/0+lWUdaam109KGqfDuAH9tnfLe05TiP5ls6MT1z+U
         TIv4k/YGCzaWini16uyHc12ts5iVciDsNo58yxd/iiKANTyHNE/Q5HKsu7mpgNtYbfUq
         PfSMYbgt4FX3vL9T6EczZMcTnvVaoHwZ66U/6Lj/x+S+c+SKdas+RgwL9LlFDuWzPs0N
         ouNSqtiZrlb+OopLiJyAc8HuRYbd0RD78GLFxm3a0SjcBdfnZwLlWrx5pMkmgCif7Fc7
         KkCuw75t2k6uOZdgq9nm//4nG5BtAQ1Vf2dpSsqRgwxt2nzZr1Qgo3refPhrq/s5Ycno
         c2jA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1789138746; x=1789743546;
        h=message-id:date:reply-to:cc:to:from:subject
         :content-transfer-encoding:mime-version:content-type:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=w4yyiBqB0sp/5dIoaBva/TCgVPoh7GZb6TIIT6yHyNs=;
        b=isj/ZHBbxC17hBwVMnka13X8jx7EVK0oTMo0zi8vwFenT62GMLKqE6rmsXHCniJYbG
         vS6XAjC3gtOIeCjFu2kUOWsnCfzs828JcoaAeUTGae4djVVhjiQ07d2bpWbSEzF7cJzC
         wOP9xOBv6eSSt3dUYJ4esf+/AiPXsuE2ED+L0W9FZ9RyQnfkOsLY8Dd1t7WgGVFfr9Id
         c4e48wqs75XA7pXoMey42SYoMPrTuyXEZeX9TKI72kRK3begOx8xWgxH1BvHvwZJ7Pke
         ggL87AZifGLH7zVaciG1AG381Y+j2wKssGNfba5IIehgSpnqAynRN7W78UOZrLlA5AhN
         tW/A==
X-Gm-Message-State: AFuF++l4fzeF3Ze/ju3uj+zFNHp3jYVcyTfLD0KxtHAKYzxRTjEiimFl
	FOf37O/c+s2R0Fpu9xHRTO0sS90+X4sAoTvfL/TtiwvCYMEQ3IhZ6jTwADypyB0UOq7PaTyHjo0
	0zR/0
X-Gm-Gg: AYBFou3qJDQzalSBlBXu+OifF3VD+8XDQhw3GZn3ytZwCqsiHNyGD60kd5p5FTD3KwP
	IyC8uXnMLuRWh9Us6mIPJKcPxHAaVhxci82IFfse7errYQ3Fit96I0REb+C3PY+k7tTg5+hzW4j
	4VV+QPrl0d3k3bwmlQTwsSqMAi7lCO7VeloUOnSd3jefKV+EZBNQoyQsuYoTtICY0f8oYArxLfx
	grBUrj+dMH2lAiIjR7+gP512ES5Z8OQbFff/kW/ejS7gjGNTJ2RqwcM3lEY/CVKsBcsg9oQgba8
	XhGdnUpG/+3gyDnkuAwC/rbRNozxXj1nUUqCcMi/plUOn72OTtbwWBPXxNbK1691QCqglvaKCQ6
	1HQwmjRih24Ss0BYjnwasj5PIYJjJkqee0CmaeEKyOrP8UH7FSTNctLux0vw+XU3QePwx7QFKvB
	whz8+qB5pVCKuz3ImtkD3hWtSIkYlG3aWocTIoCrHeA/ngOgsXiFQAH+8R2lliuYRUphR7M1S5T
	w==
X-Received: by 2002:a05:6a20:43ac:b0:3d3:ae40:51e5 with SMTP id adf61e73a8af0-3daed3f74bamr7690840637.25.1789138745962;
        Fri, 11 Sep 2026 07:59:05 -0700 (PDT)
Received: from 41049dfc76e5 ([20.38.40.137])
        by smtp.gmail.com with ESMTPSA id 5a478bee46e88-33ba4b1f409sm8383111eec.0.2026.09.11.07.59.05
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 11 Sep 2026 07:59:05 -0700 (PDT)
Content-Type: text/plain; charset="utf-8"
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Subject: 
 =?utf-8?b?W1JFR1JFU1NJT05dIHN0YWJsZS1yYy9saW51eC02LjEyLnk6IChidWlsZCnigJhr?=
 =?utf-8?b?bmF2X3FkZXbigJkgdW5kZWNsYXJlZCAoZmlyc3QgdXNlIGluIHRoaXMgZnVuY3Rp?=
 =?utf-8?b?b24pOyBkaWQgeW91IG1lYW4g4oCYLi4u?=
From: KernelCI bot <bot@kernelci.org>
To: kernelci-results@groups.io
Cc: stable@vger.kernel.org
Reply-To: kernelci@lists.linux.dev
Date: Fri, 11 Sep 2026 14:59:05 -0000
Message-ID: <178913874515.4387.1325769727350387401@kernelci.org>

New build issue found on stable-rc/linux-6.12.y:

---
‘knav_qdev’ undeclared (first use in this function); did you mean ‘knav_queue’? in drivers/soc/ti/knav_qmss_queue.o (drivers/soc/ti/knav_qmss_queue.c) [logspec:kbuild,kbuild.compiler.error]
---

Log excerpt:
=====================================================
/tmp/kci/linux/drivers/soc/ti/knav_qmss_queue.c:1874:9: error: ‘knav_qdev’ undeclared (first use in this function); did you mean ‘knav_queue’?
 1874 |         knav_qdev->debugfs_file =
      |         ^~~~~~~~~
      |         knav_queue
/tmp/kci/linux/drivers/soc/ti/knav_qmss_queue.c:1874:9: note: each undeclared identifier is reported only once for each function it appears in

=====================================================

When fixing this issue, please attribute this report according to the
patch submission rules:

Reported-by: kernelci.org bot <bot@kernelci.org>

For complete logs and details about the environment used, see the issue
on the KernelCI dashboard:

- dashboard: https://d.kernelci.org/i/maestro:413c55141537fe4d2ae45aa4df30f177201ca4cd
- giturl: https://git.kernel.org/pub/scm/linux/kernel/git/stable/linux-stable-rc.git
- commit HEAD:  f97429de1ef3e1b6f7986abbcb45bb115b876977

# Builds where the incident occurred:

## multi_v7_defconfig on (arm):
- compiler: gcc-14
- config: None
- dashboard: https://d.kernelci.org/build/maestro:6aa40cdd20239ade9022acd7

## multi_v7_defconfig+kselftest on (arm):
- compiler: gcc-14
- config: None
- dashboard: https://d.kernelci.org/build/maestro:6aa40cea20239ade9022aceb

#kernelci issue maestro:413c55141537fe4d2ae45aa4df30f177201ca4cd

--
This is an experimental report format. Please send feedback in!
Talk to us at kernelci@lists.linux.dev

Made with love by the KernelCI team - https://kernelci.org
