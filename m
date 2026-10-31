Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=74.125.82.177
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1793413808;
	b=o3K6Mwq4J7AMoUIISalfBIPd0Wci708SBrU+Ivi16wkrmYmsqex0jODMy2PsJBarBiUl
	 mjgPdEaqRmE/3nqHOMN92FNoItcZvupd1IA+t9T6uEisCbpWAG8Ltf10nq4ElXmDw6kev
	 BJvmvsYiEFpxDN0jm6ZaefA/bJGU4KTRmXQrURHI3ZY03gWHBJZcJDLxKMyCnJzljcd1d
	 cL9bdKrlBXVAJbGGWDCDomBGFCC8J9mLACKfgf60BZfEm/lxQzuAdb4wnYgvAkGHsxXci
	 amDiY5TsbK2qAcTwVJXqBcD5HPIrq95uDFurukWKq9x2Bc2AOn+eL5BlF8XO+qoPGMw==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1793413808;
	h=DMARC-Filter:Received:DKIM-Signature:X-Google-DKIM-Signature:
	 X-Gm-Message-State:X-Gm-Gg:X-Received:Received:Content-Type:
	 MIME-Version:Content-Transfer-Encoding:Subject:From:To:Cc:Reply-To:
	 Date:Message-ID;
	bh=Z3CNLjag7BH03/sOS3AVgDeb2aF/1YIioOVICGukiMg=;
	b=LV1b+W1aI2oYrll52BBCqyYQIiCNWSq75+yuvH99hI0FLYRn6gUHPxjNwkGLlzS4x/5D
	 RDSSMaACaUe8SP0Y2cjrG1Ouh400P8i6YSIn1n2wAfcbbT5gt6m7TdJpUik+Oc9srBGNb
	 FIhS70OP9VelPfIAd4th9EPSMVPtY4TdVuvOHAxKN8/WZeZhYGJGQ1rmz3Izo11CYgXzO
	 qcrmXb4Wm2qHsvjwkVkPj0nsmGYPUHEjjUig3v7f64YF/lFylv768nr3tguacmedBQ/kM
	 A7Gu6gez0Kn4iaa5Kz/0kDhBet7jWcIn2qxl5goD98aqm3xE6llQERvFV9SrH8x/mTw==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=kernelci.org;
	spf=pass smtp.mailfrom=kernelci.org;
	dkim=pass header.d=kernelci.org header.i=@kernelci.org header.a=rsa-sha256 header.s=google header.b="PVLD/ox8";
	arc=none smtp.remote-ip=74.125.82.177
Received: from mail-dy1-f177.google.com (mail-dy1-f177.google.com [74.125.82.177])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 343AE606A31A
	for <stable@vger.kernel.org>; Sat, 31 Oct 2026 02:30:07 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 343AE606A31A
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=kernelci.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=kernelci.org
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=kernelci.org header.i=@kernelci.org header.a=rsa-sha256 header.s=google header.b=PVLD/ox8
Received: by mail-dy1-f177.google.com with SMTP id 5a478bee46e88-3535a54bed9so2027108eec.1
        for <stable@vger.kernel.org>; Fri, 30 Oct 2026 19:30:07 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=kernelci.org; s=google; t=1793413807; x=1794018607; darn=vger.kernel.org;
        h=message-id:date:reply-to:cc:to:from:subject
         :content-transfer-encoding:mime-version:content-type:from:to:cc
         :subject:date:message-id:reply-to:content-type;
        bh=Z3CNLjag7BH03/sOS3AVgDeb2aF/1YIioOVICGukiMg=;
        b=PVLD/ox8Dk8rsjPD0Zw13GyLjFdy3y1AdEgyg9lIq3n7drmDC9uKlvjLcD41q4vXk6
         SzvGxcwi+Y4umUSmc/dHakwbU6/yxanC7jfT3dK40veukaETt0wXu34QU5kg1QSq5O+9
         3p7p0wfAxERoueUYoM0qQftXUxS+9xZR0mTA4X1wQmvrjx3+4NtZ+Yuq9JisT6eM+1wB
         hX1MMSFbqJqJkvOqmvwh5ve4Vaj/jJCg2RlVzEaz08cwF1QH6BIqPpTyGmC/zYKgcraU
         KHFDq9FyTMGuK4yxGlEo2yIdwZfqIeyezm8ieisjYrXmvDAOdv/Zs/hSzLNzGEci1Snc
         1ABw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1793413807; x=1794018607;
        h=message-id:date:reply-to:cc:to:from:subject
         :content-transfer-encoding:mime-version:content-type:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=Z3CNLjag7BH03/sOS3AVgDeb2aF/1YIioOVICGukiMg=;
        b=TWItTBf71iikIoLiOao4+ma1ZUKo2cnrolczGNoyjk1QDQia2UT8kBKpNh85JMgyP/
         wwI8BGppeADALImroGZ1cLZtA1Ql2nrbbU8yUE6XBW5f093qtnbHmmOhDnAfFQUJGusL
         1WSs3vANV+g4TLit97dNgAMYaqmiY71hpVGGMVeOlF67URJYM44UEkIlDLXmAwCpY2Fk
         BV82ou8CxMtW/wd0DhGs9eTcf5SFeXvnAIt4lfZl5Ny7d5XGwkekSDPXWwAqj2T+F3LL
         RtU4mAloneXp/GoebLR81si84XcULVYGdmQgbFNy9K0Hx+3jEgtDg4SoTP025b++rRA/
         iVMg==
X-Gm-Message-State: AFq9FYIJo2Eyzk64ds9egp6RU8mW7YfUkS3QSzZcCHUXU3kNh8iN09Qy
	yyeKB6LQ4KCHr5ApQ9tv2wSzt/NqQ3+NCGc8EhqMe90aw9n/eGCFvvCZ4Ntp5u1mg34=
X-Gm-Gg: AYBFou2KbFtapL/jzZjxsHimseXSV8Y6YvnWM9jKqOZPg3we1nxrOXF/iDi/cbGDgkp
	DknAydUf67Et/bnLSLtE3EpQp5gljK4IKmbFVOxs8m3cz6yNupX8SMdp9j4hQuOtqkXbsjhpik4
	236hniC87J4RmbGLC8U4SX7PxaLyBh0nSoUoFpmZieiuHvYqtHRAZLJ3v3/tzZvOOleTnuRHFAt
	ww22Rp3r+9Kj/J/RKPE8NxyFoyj3OMFdHhvB3Zj46IclCDt2fm9GDfV1cre8fJL6CKmeGGQMYdB
	i4dKRgErlIa1YMwGDoMkL5dSu8g7xuW4vqEFl8UUoyAdDuRdTVZXWBsrIyeVqKEiTU4HCeWpUXc
	Usqesp5Q/10/h6VO4JSrg60gHQ7qoVZbjD6DCB5FbM5vPrWHvwHmQZlyUlAYrTjPfVTeNPDceVP
	DGg4LRl7KOkbPqKTLAwQm/XPAI2G182meFiHWJ0jeqZYRv4YGiPEr4THk6wVz9Ul32qqWbvrWUC
	S0dDIaTyDxWyrtQEa9A35SXv427iPA3R6pOF2Wm+3aJHfFSWu2lZvqh5StIVYXXcnoTA3ZXTnA2
	8sn+iBWJJSm3l735Xumj0g==
X-Received: by 2002:a05:7301:78ce:b0:34b:5ab2:e200 with SMTP id 5a478bee46e88-36a4242b0e7mr5913834eec.14.1793413806928;
        Fri, 30 Oct 2026 19:30:06 -0700 (PDT)
Received: from 34406640b1f4 ([20.38.40.137])
        by smtp.gmail.com with ESMTPSA id 5a478bee46e88-36a42a6f7f9sm13262553eec.25.2026.10.30.19.30.05
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 30 Oct 2026 19:30:06 -0700 (PDT)
Content-Type: text/plain; charset="utf-8"
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Post: <mailto:stable@vger.kernel.org>
List-Help: <mailto:stable+help@vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
List-Owner: <mailto:stable+owner@vger.kernel.org>
Precedence: list
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Subject: [STATUS] stable/linux-6.12.y -
 03bae623ec326c2738198739625832aab0eb120a
From: KernelCI bot <bot@kernelci.org>
To: kernelci-results@groups.io
Cc: stable@vger.kernel.org
Reply-To: kernelci@lists.linux.dev
Date: Sat, 31 Oct 2026 02:30:05 -0000
Message-ID: <179341380559.70610.11161311157376552848@34406640b1f4>



Hello,

Status summary for stable/linux-6.12.y

Dashboard:
https://d.kernelci.org/c/stable/linux-6.12.y/03bae623ec326c2738198739625832aab0eb120a/

giturl: https://git.kernel.org/pub/scm/linux/kernel/git/stable/linux.git
branch: linux-6.12.y
commit hash: 03bae623ec326c2738198739625832aab0eb120a
origin: maestro
test start time: 2026-10-30 12:34:38.128000+00:00

Builds:	   54 ✅    2 ❌    0 ⚠️
Boots: 	  106 ✅    0 ❌    0 ⚠️
Tests: 	 8668 ✅  458 ❌  438 ⚠️

### POSSIBLE REGRESSIONS

  No possible regressions observed.


### FIXED REGRESSIONS

  No fixed regressions observed.


### UNSTABLE TESTS
    
Hardware: qemu-arm64
  > Config: defconfig+netdev+nfs-root-boot+ltp
    - Architecture/compiler: arm64/gcc-15
      - ltp
      last run: https://d.kernelci.org/test/maestro:6ae4a25b6eff83db85cbca4e
      history:  > ✅  > ✅  > ❌  > ✅  > ❌  
            



This branch has 2 pre-existing build issues. See details in the dashboard.

Sent every day if there were changes in the past 24 hours.
Legend: ✅ PASS   ❌ FAIL  ⚠️ INCONCLUSIVE

--
This is an experimental report format. Please send feedback in!
Talk to us at kernelci@lists.linux.dev

Made with love by the KernelCI team - https://kernelci.org
