Received: from mail-dl1-f41.google.com (mail-dl1-f41.google.com [74.125.82.41])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8D0AA39B4A6
	for <stable@vger.kernel.org>; Fri, 16 Oct 2026 02:30:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=74.125.82.41
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1792117827; cv=none; b=GjEs35hNjriN9g5IGsINdhHxA4eOhyttkhABfcgM8IfR5G79UBJyK0XT+LeCBPPyRo/5xfXZB9Y4LCrEg04TfFg9IyniwU3Oqr6x/DE+h+7ePvJt8aQywN/qngK3Z6eKgThJHq9mhFaY0+iUre8XYytvAVz+l/o4umfW2OOl1So=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1792117827; c=relaxed/simple;
	bh=rM8WUQ7qmi1bMmVa7ulOm63nw13MRTiO0HVKORdKVyY=;
	h=Content-Type:MIME-Version:Subject:From:To:Cc:Date:Message-ID; b=rL/LYP4iwJmSSeKzt8w/zW2ScdvHtRYMCQitqrI/TR59CDw38zZCnXJV93wbweCq17xJusET3UOB+NiIpu/YjtcPA0ZiROcjqSFYhzGEGWTYCiBSXBUFarZJ9YXb/WPrdDj9ZZ4oYfh8elyrEK2O8RXK1VH/nGKkgM6fO6aHZ3w=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=kernelci.org; spf=pass smtp.mailfrom=kernelci.org; dkim=pass (2048-bit key) header.d=kernelci.org header.i=@kernelci.org header.b=h1EaIH1R; arc=none smtp.client-ip=74.125.82.41
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=kernelci.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=kernelci.org
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernelci.org header.i=@kernelci.org header.b="h1EaIH1R"
Received: by mail-dl1-f41.google.com with SMTP id a92af1059eb24-15dd124bbe7so50069c88.1
        for <stable@vger.kernel.org>; Thu, 15 Oct 2026 19:30:25 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=kernelci.org; s=google; t=1792117824; x=1792722624; darn=vger.kernel.org;
        h=message-id:date:reply-to:cc:to:from:subject
         :content-transfer-encoding:mime-version:content-type:from:to:cc
         :subject:date:message-id:reply-to:content-type;
        bh=bmc8Z2MU4ehiQtWRhWpf4kaRyM8DH0cgpVyu2g48cCo=;
        b=h1EaIH1ReNw+2FbwwFHF2eUewH+kmgkNHtHQsOWfVcvo3iCh/X4cGM8jYFdH2gRwqA
         bZ+Q2a1RdwuJLumKbHEwE6jN3Sx8qKupYL0dphssImRe+s1w33gpw+4Hs9Shn5k08O9o
         ABYoMTXezNa2KWU6X8f7TY74u21Vw90LdiEnZaZsgJn2ELHadw2PXIp2uk3hmVB9aDXt
         uCkb9irgmu/QaGIo0ulDddQu/99j+aN97k3t7KunzR/Ys6jhL5Q8EfUnAEJii6TU7iFU
         KlfsYpm4rUp+6e2rTmFzFCBCfh0GIVcdc/LfD/XyTIsYM2LSk+Cv1fjwOxnX7gXO693Y
         /byQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1792117824; x=1792722624;
        h=message-id:date:reply-to:cc:to:from:subject
         :content-transfer-encoding:mime-version:content-type:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=bmc8Z2MU4ehiQtWRhWpf4kaRyM8DH0cgpVyu2g48cCo=;
        b=H2/h4X7dGvHWyLcdrYz2cl34SqdGyxzkf144nV17H7sASmz3KcW8Zp/6ECnXJbX97y
         7cnrc4Cpqsv8TCsEIeD1BuD+hdo0cRI4FJzEk/UybKKFX6fqELLCmvumYehyejUH2DFf
         Hi7Je+8J6d6CRDxiae4k8itYgBVKqTFB6Vxb6eu7PRM5xXhnBe9OTYJ13P6L6TzCdtRf
         Kd0Am5WVPYttmcHJvMniPJMK8fXwIpJNyYSUdk3nR5mlp/fZrpoOS+yrcHNyaLn6JnEu
         vd+X3rZpAtbI7mPgdIFAWpNZ6SYny049h04rnDtuxFR0ypRbkqFccLPkKxiqhl1exLqR
         P38w==
X-Gm-Message-State: AFq9FYK8XxPP69neiuZP/9neO2n/Wrl+cJGbbKyJQOSc7wAXdq2SzhNO
	CC/GFFoXKVvjgaEh7tilanJHRpswTPC1sbpjNxL+kr7j8K4XWg98R2QDPFbhaqHlqz/9N+e8R77
	Fboq7
X-Gm-Gg: AYBFou0ELD20c+jVxnCM0WvCtKzbLCmuASk6zxKm4BGmgZgMXeA/ApjHWG6nSodqqo8
	5ge8nC/C+c8rDmDZ8PutkzaurxRNUJxnhRLV2vSWrLi259Nom0Il7OzyoMIIyKmE8An5Wm167OQ
	cK2EqE+7RghbUcW6t/pg+kOt+0w8ClbRbIKnfRB3v03XwxnvS+Qt1NMtVX8q8ICcT3jbM2CqDtx
	cp9ZNhCHGUeJzZ+M5S0+5eGlDpgvMynFmvd8gYjRSScq+y6iXxMpyuggt6o+IrxiWLxJo5jte84
	Fgpsa66PfqD9DkfvUYbUu8h+2M0yjfRYcfzRJRg9EIqyJqrU6kzm054UT3pvywMRBEV8GCjCeVO
	3Snf6WXxUB8xsyiFPBx/X6CwYsXBiphDAkgTf8dIV6cWu06mOXSiWMJ7uvlz0pAdtE8aYWShioe
	bRQYNEc07iEnQL4WfaahwQrSVIqJhvkRWBJ2xVu0uaDw6u90dy96NWutuCNV7eqKc=
X-Received: by 2002:a05:7022:f51b:b0:14c:be8e:69f2 with SMTP id a92af1059eb24-16a5da14bbemr26903061c88.21.1792117824360;
        Thu, 15 Oct 2026 19:30:24 -0700 (PDT)
Received: from 244668f92ec4 ([20.38.40.137])
        by smtp.gmail.com with ESMTPSA id a92af1059eb24-1831a6f5a13sm1629075c88.12.2026.10.15.19.30.23
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 15 Oct 2026 19:30:23 -0700 (PDT)
Content-Type: text/plain; charset="utf-8"
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Subject: [STATUS] stable/linux-6.1.y -
 79807e970724c1f90cee1316361d61b80db4eef6
From: KernelCI bot <bot@kernelci.org>
To: kernelci-results@groups.io
Cc: stable@vger.kernel.org
Reply-To: kernelci@lists.linux.dev
Date: Fri, 16 Oct 2026 02:30:23 -0000
Message-ID: <179211782335.391248.7134551740784181695@244668f92ec4>



Hello,

Status summary for stable/linux-6.1.y

Dashboard:
https://d.kernelci.org/c/stable/linux-6.1.y/79807e970724c1f90cee1316361d61b80db4eef6/

giturl: https://git.kernel.org/pub/scm/linux/kernel/git/stable/linux.git
branch: linux-6.1.y
commit hash: 79807e970724c1f90cee1316361d61b80db4eef6
origin: maestro
test start time: 2026-10-15 13:13:48.391000+00:00

Builds:	   46 ✅    0 ❌    0 ⚠️
Boots: 	   41 ✅    0 ❌    0 ⚠️
Tests: 	 3538 ✅  249 ❌  563 ⚠️

### POSSIBLE REGRESSIONS

  No possible regressions observed.


### FIXED REGRESSIONS

  No fixed regressions observed.


### UNSTABLE TESTS
    
Hardware: qemu-arm64
  > Config: defconfig+netdev+nfs-root-boot+ltp
    - Architecture/compiler: arm64/gcc-15
      - ltp
      last run: https://d.kernelci.org/test/maestro:6ad0f5a0a3f195e1aa8b205e
      history:  > ✅  > ✅  > ❌  > ✅  > ❌  
            


Sent every day if there were changes in the past 24 hours.
Legend: ✅ PASS   ❌ FAIL  ⚠️ INCONCLUSIVE

--
This is an experimental report format. Please send feedback in!
Talk to us at kernelci@lists.linux.dev

Made with love by the KernelCI team - https://kernelci.org
