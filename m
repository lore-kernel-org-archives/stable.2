Received: from mail-pj1-f51.google.com (mail-pj1-f51.google.com [209.85.216.51])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A7ECA33689D
	for <stable@vger.kernel.org>; Fri, 28 Aug 2026 02:30:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.216.51
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1787884234; cv=none; b=peRb2FYqwef08aRop15vKdkQy6UI84mqjFwAlXIWLcYRZGUZ93K1V3xPoqyF+NrBdd7X1C71vgedr9WnQC13b8F72othXrKIky4006mffqAZptlJ4oVFNE3jAHlgMziQqBUWIUrBxxIIEPD+8cMPxDck+zAmfuKTUuGGwiV9jGs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1787884234; c=relaxed/simple;
	bh=2QDqh5ZX+5QgaZxXzeceHWlvgYeyXCx+Vc+KZqcuXbE=;
	h=Content-Type:MIME-Version:Subject:From:To:Cc:Date:Message-ID; b=lrmlCaLamxurX/ZaHzPTOp+fuFKxFHRdBUFyoeEWYlctRPSkoZOm4uga4w3FXMx9Df88yzGz06Wy5rSGBQ5e2VIPYdzA+jgihOUDr0O6f5YmXBSWjk8N7Z5qb2FP7UcgakUomGTBb80wyraZm4P7J9GgxOFzPt4KpmXrSkVaHRE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=kernelci.org; spf=pass smtp.mailfrom=kernelci.org; dkim=pass (2048-bit key) header.d=kernelci.org header.i=@kernelci.org header.b=Rzzrkytb; arc=none smtp.client-ip=209.85.216.51
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=kernelci.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=kernelci.org
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernelci.org header.i=@kernelci.org header.b="Rzzrkytb"
Received: by mail-pj1-f51.google.com with SMTP id 98e67ed59e1d1-38f620399a0so632429a91.2
        for <stable@vger.kernel.org>; Thu, 27 Aug 2026 19:30:33 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=kernelci.org; s=google; t=1787884233; x=1788489033; darn=vger.kernel.org;
        h=message-id:date:reply-to:cc:to:from:subject
         :content-transfer-encoding:mime-version:content-type:from:to:cc
         :subject:date:message-id:reply-to:content-type;
        bh=NpEd3wspzwYqN5cSYegVp1muS7WtBeDlqrS5q+0Z0Cg=;
        b=RzzrkytbI37/qk990H87zZQQuvmsvsTF04McpZ8/rlNnUAA3ga4EiIQPzQuEu0kWvr
         CQmI3D8fcBjkGFkBgrvfpf880jb3BCL0xyFhcWB2eegu1ZTyTB2IUxEGP48a46UHHH/y
         aCmpbjmu8SvvZN8MetHFT4T7bP6LuHYfalJ1aTy4u4iDxXdl05Vt2O2Fc8Ix1bVRqxYp
         3Nkmi7RFIlcdlE+h7PHioazXRcRjb3y00Cx8tbj3f9R/JF8E4w0LLXJNDFORjPeNvPD/
         trC9pzkiEl+Xqm1b2W23Syl3LQTMpqZo1xVQ89/MOzTikiNcGfn/zK6cBORWl98hBi0r
         6Hww==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1787884233; x=1788489033;
        h=message-id:date:reply-to:cc:to:from:subject
         :content-transfer-encoding:mime-version:content-type:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=NpEd3wspzwYqN5cSYegVp1muS7WtBeDlqrS5q+0Z0Cg=;
        b=S5XfAmcypQLdnA1KB2hW6tY4yT6neR/mcbmodfPJVrqxLfKWz2jlquTEiM6LTe8MEa
         1noDJbu11VKOd8JBoImTl4+YCK4/3FzRvgEyrC1lzmHt6eRyMcZFqwp+mX38caRZcRZp
         FX9naOLi9HZMtYq8OrRJPfDdS+EOfFLYBeslD3M/RBLDl86I8T2C6JRm1vTkv3iGVv6u
         IFRWcpx/JUsLuA2LGstgndPobaDHt5CaVLA8O03IaJxQY4Dont9J1qFy1c7D0RCXuJPS
         W61anpgl4yoStXlv4W3LDNQAOU0Ql9fmSMbqGFBle+Dm51MEuR4FdRZF0h9rkc9PKNNQ
         8E+A==
X-Gm-Message-State: AFuF++mTy7fwVgg59obZEPaKidJWMw8BCMUKPQEZkR+c8Foa/nFgf6Dz
	7uUImTA4Hf2F+y3+hiLr59AhVU7dXtuQUtDFUu2MHUVM/kihlCAVHDnPFnEkDOBvAQM=
X-Gm-Gg: AR+sD11CHPwWJzfX8ILMVEn4oi+WAVfP6jh4+SxQCJGjHjOWQhIchglgmAikWdLQfD/
	V1zHYpsc9L9awLK1dansb15ek5G7wZ8jkBfdA6t3PZwZNr9AiZSTl4jd2YQdqoKYyIHD8JcdRC1
	m6L5/WtX157L5g2L44+WIRto9GMTonQepmy+/m8D85kNbR79KWogT4VgnWT6+R+TkfEDzdvxKSB
	qheZw5SQaqPXPIsWRs/7jTmTP3jsDX7P0ghjPHn2g+OXM8BwW8Axuj7i3R9+0DQDGexZIXGtJDh
	SmBphUTNgbk3jJqLqvSw96zzGu9LUz14tU08DxdjSvTamrsjhPFQ93d3qPOhTYcuJt4wxbqpgiQ
	KJ1VFJdaFof96sVStsaGRtiXwbDaOah+XsRIlm0AfX5UrHljtiYkj2nu+XlGAmVaTxmacnsOmos
	AgSXd1rbrWr6NWlx2GLWarEhWOorvs7HlkgD5LjnCyalaWeknVILDv
X-Received: by 2002:a17:90b:2dc5:b0:395:4290:46e0 with SMTP id 98e67ed59e1d1-396d0e83c28mr7468409a91.5.1787884232918;
        Thu, 27 Aug 2026 19:30:32 -0700 (PDT)
Received: from b455de3d9de8 ([20.38.40.137])
        by smtp.gmail.com with ESMTPSA id a92af1059eb24-142e0de4d92sm1265281c88.13.2026.08.27.19.30.32
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 27 Aug 2026 19:30:32 -0700 (PDT)
Content-Type: text/plain; charset="utf-8"
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Subject: [STATUS] stable/linux-6.6.y -
 93e0c9521fa8e477120cde68ae56932c379b853b
From: KernelCI bot <bot@kernelci.org>
To: kernelci-results@groups.io
Cc: stable@vger.kernel.org
Reply-To: kernelci@lists.linux.dev
Date: Fri, 28 Aug 2026 02:30:32 -0000
Message-ID: <178788423191.5582.6783347297792704791@b455de3d9de8>



Hello,

Status summary for stable/linux-6.6.y

Dashboard:
https://d.kernelci.org/c/stable/linux-6.6.y/93e0c9521fa8e477120cde68ae56932c379b853b/

giturl: https://git.kernel.org/pub/scm/linux/kernel/git/stable/linux.git
branch: linux-6.6.y
commit hash: 93e0c9521fa8e477120cde68ae56932c379b853b
origin: maestro
test start time: 2026-08-27 13:10:47.261000+00:00

Builds:	   56 ✅    0 ❌    0 ⚠️
Boots: 	   42 ✅    0 ❌    0 ⚠️
Tests: 	 5319 ✅ 1851 ❌   90 ⚠️

### POSSIBLE REGRESSIONS
    
Hardware: mt8195-cherry-tomato-r2
  > Config: defconfig+lab-setup+arm64-chromebook+CONFIG_MODULE_COMPRESS=n+CONFIG_MODULE_COMPRESS_NONE=y
    - Architecture/compiler: arm64/gcc-14
      - kernelci_watchdog_reset.wdt-reset.wdt-get-timeout
      last run: https://d.kernelci.org/test/maestro:6a904a85c5867fba94648042
      history:  > ✅  > ❌  
            


### FIXED REGRESSIONS
    
Hardware: mt8183-kukui-jacuzzi-juniper-sku16
  > Config: defconfig+lab-setup+arm64-chromebook+CONFIG_MODULE_COMPRESS=n+CONFIG_MODULE_COMPRESS_NONE=y
    - Architecture/compiler: arm64/gcc-14
      - kernelci_watchdog_reset.wdt-reset.wdt-get-timeout
      last run: https://d.kernelci.org/test/maestro:6a9049e9c5867fba94647c14
      history:  > ❌  > ✅  
            


### UNSTABLE TESTS
    
Hardware: qemu-arm64
  > Config: defconfig+netdev+nfs-root-boot+kselftest
    - Architecture/compiler: arm64/gcc-15
      - ltp
      last run: https://d.kernelci.org/test/maestro:6a906405c5867fba946516e9
      history:  > ✅  > ❌  > ✅  > ✅  > ✅  
            


Sent every day if there were changes in the past 24 hours.
Legend: ✅ PASS   ❌ FAIL  ⚠️ INCONCLUSIVE

--
This is an experimental report format. Please send feedback in!
Talk to us at kernelci@lists.linux.dev

Made with love by the KernelCI team - https://kernelci.org
