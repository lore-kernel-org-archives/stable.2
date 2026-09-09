Received: from mail-pj1-f43.google.com (mail-pj1-f43.google.com [209.85.216.43])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CC38858E2CB
	for <stable@vger.kernel.org>; Wed,  9 Sep 2026 14:59:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.216.43
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1788965954; cv=none; b=jemdQyKgYq4Udb+HtyoiRWC+FQq8tujtm1SbGaD/g/ZcSnFqwLbob/+Pw9RNaHZGzO26DGaWPMcNAGSAOeuv1tgLIXArHni4eWWvGEJsCufWjuOeIRasAfx+SkHlako9KwDESfr3OFJ8lSspLQHG3b6qsqstTmGpwQafbnh9kds=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1788965954; c=relaxed/simple;
	bh=IuMDGW8jPN+xSwA+IdreaqnYI9/Omcwbduf33sTQIts=;
	h=Content-Type:MIME-Version:Subject:From:To:Cc:Date:Message-ID; b=g7xLSGOUmDhaFKhyr26fxANhlDQYBcDk4XhAhtNdtPl/ixJPu0Ghm7/S6xxG3eb4wQtvhWhX3wzRRWJIVTq5vEPhXC1bScSQcGz0kfJ0L7NNqtIP6uyso71d8UvjTuBZ7/t5XyEWhPGzRzHudOYQrrjf6+8Gs9O6u9VBBpXiejI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=kernelci.org; spf=pass smtp.mailfrom=kernelci.org; dkim=pass (2048-bit key) header.d=kernelci.org header.i=@kernelci.org header.b=EU8Cr6d6; arc=none smtp.client-ip=209.85.216.43
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=kernelci.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=kernelci.org
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernelci.org header.i=@kernelci.org header.b="EU8Cr6d6"
Received: by mail-pj1-f43.google.com with SMTP id 98e67ed59e1d1-38ec1402b05so5917612a91.2
        for <stable@vger.kernel.org>; Wed, 09 Sep 2026 07:59:12 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=kernelci.org; s=google; t=1788965952; x=1789570752; darn=vger.kernel.org;
        h=message-id:date:reply-to:cc:to:from:subject
         :content-transfer-encoding:mime-version:content-type:from:to:cc
         :subject:date:message-id:reply-to:content-type;
        bh=DlEh4Q/pRNzkykBu6EL/wHNG6KcrtP5yD/Ju7OavwhE=;
        b=EU8Cr6d6qgKcd3f+Yuu7geLN59q6dmJ64HuB5Rjyf2i+dzke54QLZM4gY3036Fj42U
         M9SPV8HaXQCKISaRm7M0OjFaUJcQamvwWmRQk8v0tF3rPGXNshukTdR+Y/VxBNo3b55a
         HMntEJjM4bbtBMvoUOwo74DrMRx2+wz9x3hdJ+bIQb4K8IPKuNrsBgZF/sX7ZzQE/RuR
         4OkBo7rz18WFujTx4MHg0dWIfBeKcJ6PyuZ46UYs0ttfg+nl4JGxCz8tMctIb+NB9cq9
         AYUE0PZHT2pvlFJAVFs66fVQK4Xle86+h9Jp2QkbfyC43KbC0QUCZ4gfafYiOO5TEQJ9
         VAkQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1788965952; x=1789570752;
        h=message-id:date:reply-to:cc:to:from:subject
         :content-transfer-encoding:mime-version:content-type:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=DlEh4Q/pRNzkykBu6EL/wHNG6KcrtP5yD/Ju7OavwhE=;
        b=FvxOfC39//DjQxxufzM62qleIcnxnvpEwzzX9HSHMYnPGQd87tYimYKVjF9Pt0Uqo6
         uyTsgwU9NvJe0p1PVhVSjN6ivQMDeuWNs6h5BZ3ZuQlm86wmfn13az3FG8uDtrHnPvgd
         TQ/M8jFY9vF7kXMZz0UBPdDaQnIwBVklW8Q9Xdxw5hiNgfdSXn4X57uLGXU42dCKSfs+
         jNJaWMkQqmOL5n+wrc7nIFUY95yMwb8FbzgTDofvi11alK7opR5U55OdAFqZ8o5VvXQ+
         DNtF6J2ECrshOcmBEBjYuqcKg8+LihfG/A3Y9aSXobCUp6DQRXr8OYJWoBuaChXXuNPo
         MLtQ==
X-Gm-Message-State: AFuF++l9Q7xO1VzdANdKGdB2SnebI2OfzIJ9wYdmFLBtc4OUcJAf0ZYT
	1vTkiJYqB56MSC9yrrw1dEnFNQbP8IymnoJhzmRrlnCu5RRTELjKdETcArp9zJhzMPM=
X-Gm-Gg: AYBFou3LEFfRR+4o+6cSWfcs/OaHRfaItcY/HFIck5OG6/waBnWlz0VONvuSJo5x+3k
	nMbiCspWVyEGljUHnoNh2NXMbGg3eejPX4JLRLbyNnUW7ZeJovXemhekOfcXAvqRSfMrQ9CLTam
	l3LU3hP/aRLBWsQ4W7xnPu1/D3Txiz0/9T57RHgM3Ns8poCEAmTsGqILTgXZu83NRb46Pyxu068
	6hESl2Ju6QwEufV9OpiZFUO+bMEwkff1OYnducgBZwkL+4VhhzBzp5J0eYYy75l/DV/9iVsTo/z
	mg3ZwrA2bTDYpTnSAGODLuHVB9RZouaxGE1jXGfUbh/n7phDHuZGRJMbixNt09FqlsgkLworg+/
	XO+OYTotMga0cNDdpPJpKdP5LlZHbuA5c9Igl1PL+UeCC/LwFUXsi66vuH5NoT0DChgiwZ8lB8Y
	PgGzmL9NluLI0b1l3gh9NOpcrBYm+78rCb9+iV4xSwz7Y4t2H1
X-Received: by 2002:a17:90b:578c:b0:398:e6b6:acc2 with SMTP id 98e67ed59e1d1-39b261e7649mr56433817a91.12.1788965951753;
        Wed, 09 Sep 2026 07:59:11 -0700 (PDT)
Received: from 41049dfc76e5 ([20.38.40.137])
        by smtp.gmail.com with ESMTPSA id a92af1059eb24-1432435648esm54398028c88.5.2026.09.09.07.59.11
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 09 Sep 2026 07:59:11 -0700 (PDT)
Content-Type: text/plain; charset="utf-8"
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Subject: 
 =?utf-8?q?=5BREGRESSION=5D_stable-rc/linux-6=2E1=2Ey=3A_=28build=29=E2=80=98?=
 =?utf-8?q?apm=5Ffiltered=E2=80=99_undeclared_=28first_use_in_this_function?=
 =?utf-8?q?=29_in_drivers/s=2E=2E=2E?=
From: KernelCI bot <bot@kernelci.org>
To: kernelci-results@groups.io
Cc: stable@vger.kernel.org
Reply-To: kernelci@lists.linux.dev
Date: Wed, 09 Sep 2026 14:59:11 -0000
Message-ID: <178896595060.3462.13081047962470568725@kernelci.org>

New build issue found on stable-rc/linux-6.1.y:

---
‘apm_filtered’ undeclared (first use in this function) in drivers/s390/crypto/vfio_ap_ops.o (drivers/s390/crypto/vfio_ap_ops.c) [logspec:kbuild,kbuild.compiler.error]
---

Log excerpt:
=====================================================
/tmp/kci/linux/drivers/s390/crypto/vfio_ap_ops.c:2276:21: error: ‘apm_filtered’ undeclared (first use in this function)
 2276 |         bitmap_zero(apm_filtered, AP_DEVICES);
      |                     ^~~~~~~~~~~~
/tmp/kci/linux/drivers/s390/crypto/vfio_ap_ops.c:2276:21: note: each undeclared identifier is reported only once for each function it appears in

=====================================================

When fixing this issue, please attribute this report according to the
patch submission rules:

Reported-by: kernelci.org bot <bot@kernelci.org>

For complete logs and details about the environment used, see the issue
on the KernelCI dashboard:

- dashboard: https://d.kernelci.org/i/maestro:04650ba69bcdfacc0271c8c10746d04065e01864
- giturl: https://git.kernel.org/pub/scm/linux/kernel/git/stable/linux-stable-rc.git
- commit HEAD:  73c3a49cbd7ef9a5fb689a3625b01178f041fe17

# Builds where the incident occurred:

## defconfig on (s390):
- compiler: gcc-14
- config: None
- dashboard: https://d.kernelci.org/build/maestro:6aa16b6be41d7f97d61b21dd

#kernelci issue maestro:04650ba69bcdfacc0271c8c10746d04065e01864

--
This is an experimental report format. Please send feedback in!
Talk to us at kernelci@lists.linux.dev

Made with love by the KernelCI team - https://kernelci.org
