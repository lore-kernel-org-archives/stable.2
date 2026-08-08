Received: from mail-pj1-f43.google.com (mail-pj1-f43.google.com [209.85.216.43])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 26E0E313E21
	for <stable@vger.kernel.org>; Sat,  8 Aug 2026 02:30:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.216.43
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1786156216; cv=none; b=sP/dS1HHyHPXuYfk9UTjHBoulqqOU1KjEpV1jVW0un2cGQ5MwNYeHyHZdjPxMHJj506SgUNMGpPUWsA1Op4elyCB+jLDCbgUx/AJxGwYXoQwXRHotr8vL71LSjuMF/k79kclrq7qwbSEyhv5iFx23OToOk46Y4/5wLMVVrGhuO8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1786156216; c=relaxed/simple;
	bh=3WPXcfcYb+MVEbq1iCQUcMC4WsoG0JdazP2MowICTow=;
	h=Content-Type:MIME-Version:Subject:From:To:Cc:Date:Message-ID; b=AjKHobBz/ZAWa0O26iwBO0CUvKJePjrmoMTMdBsqjpPNQQljlSVBQdIXkFKkzGyMaXA671u+uB5FeGfdEyAs2gyPo1NiohmEF8l+epix6+UMy2KIvq84U7LxfQR4W3M3V83VeXMdg/qiiigXm6rrbWr40s/Sd+WpKbGH+d/DTj4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=kernelci.org; spf=pass smtp.mailfrom=kernelci.org; dkim=pass (2048-bit key) header.d=kernelci.org header.i=@kernelci.org header.b=Be6M0q7i; arc=none smtp.client-ip=209.85.216.43
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=kernelci.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=kernelci.org
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernelci.org header.i=@kernelci.org header.b="Be6M0q7i"
Received: by mail-pj1-f43.google.com with SMTP id 98e67ed59e1d1-38125cebfdaso177692a91.1
        for <stable@vger.kernel.org>; Fri, 07 Aug 2026 19:30:14 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=kernelci.org; s=google; t=1786156213; x=1786761013; darn=vger.kernel.org;
        h=message-id:date:reply-to:cc:to:from:subject
         :content-transfer-encoding:mime-version:content-type:from:to:cc
         :subject:date:message-id:reply-to:content-type;
        bh=jSpdiseAlF+JBlwl5Sya+XcYKQ6QylQuELbUku/nF+s=;
        b=Be6M0q7idCA+DI1S1jwQ9SMBHUjmtGDL+5Ol7MC91/aUJcD4/rQcoK/2V5+9EpZdtT
         ZUx6E5n3JLDQn9Ke/HB3pNGa40gBpP3GfKdFrACqWPD2r09deP1iPtPEHQ5+dJDP8f/C
         bMCZS7BBfLCwsuRuL/wBVayn6hvYa8PnOPNrC1We1scDfKWQqjNafzN643kVNnnvSiSb
         w3x/1vVD2i8czckMM9iUJeDX86TNrAb7AWW4S/RMfoGm85psVJ75Yb4gEFZiX4FXQOmP
         dikAB9iEtlMRGZQUlvkW1Wq7YoBfeEflTmUKMROYSMhIyG8ltmqv9+tIaNKqTxUHFg5E
         9S0A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1786156213; x=1786761013;
        h=message-id:date:reply-to:cc:to:from:subject
         :content-transfer-encoding:mime-version:content-type:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=jSpdiseAlF+JBlwl5Sya+XcYKQ6QylQuELbUku/nF+s=;
        b=X6uCk7YNA0g3FEEI75eGAbwPIrG3KS4VVK/SAlg2FKeU5kk33hofELsG9jbT8z3I/5
         DiwNsUWKLawDOjH47M8FUrmKVYSwAIGLYvRRzsFkv7K+ujtMjAn9qrTAmcR5vfK7XuIB
         5ZMaCeIw2o0Q2GpgC5GunDmsXolA59505niRWIEQYls0ORbHk6obuZ9rls2xttqy0QUy
         anJNzaYoi5Q4abqvhCkwVal8hADYvaTwOulmeGegDn43zK8A8xznzmtyHe99UqM4w/o0
         M8F9zGGJAhOKKCSJ3fuQrmmDbp5XGD+bX7/E4qbxfRQtSwavQau/CrwPFSTFrz/ip0ea
         4DLA==
X-Gm-Message-State: AOJu0YxEN2aI3FstFzVdWCzQ0NhSLXLuhW8DKWjfFTBOnfA+10AcfDhs
	/wbJtKlhoSOZpb5MGBrPMnOrVALNoLYjdMcN80wgAP3TwoorDSc0bTbTbKFQ0LJjrXsRmMPt3E9
	CTWEw
X-Gm-Gg: AR+sD13DCh/3y4Wcy33NTsmifthY8STBXfzw6yOSZkHIcp00fOBMvwY38RkC5x9IY6j
	emM5K/pvOZuo9rIKoFw3ZA2AZb4l5hnaIOgcrdkXuKSTl36FLiINcph2lzPO6tKD2nkpSgKocYj
	UQu97IQVwq8y/bP+qSgH9kOizmRNuUMW/K40la78zQ4xKP0qPC31ds8lAnLzZDLub31QRxAbTp/
	Od06+Vy4n5UlqHvHAzy+4f0oaOBFHfFTo9gJXCjD79oWuPJb6tw3xu41tRl2C3YAcCxLkj3joeo
	slwr2A5LhTPYM74yyrrYltb4zr6vpSNVWcID+TNJ1P4DRJIVpoLy0SvdF8rLy3pPf1+1V4rNdg8
	thswy6vmHA0HQbfpdsBZ/2339Uam4DVI+UW79avI8j1K1Or0xsNVN40+B4pPwoZi/i06GkgATfq
	WknOa8VfH7zaVTFhAMp/PLFqXRMLjBFL6GiWkBL2tMuVWH+6NfYDdEhA==
X-Received: by 2002:a17:90b:2585:b0:38e:bbf1:de34 with SMTP id 98e67ed59e1d1-39261fdab5amr10038058a91.7.1786156213378;
        Fri, 07 Aug 2026 19:30:13 -0700 (PDT)
Received: from 9a65d8f5b626 ([20.38.40.137])
        by smtp.gmail.com with ESMTPSA id 5a478bee46e88-315bec26a5dsm12506392eec.26.2026.08.07.19.30.12
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 07 Aug 2026 19:30:12 -0700 (PDT)
Content-Type: text/plain; charset="utf-8"
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Subject: [STATUS] stable/linux-6.12.y -
 7351870f56cba79097a2ab57e609469719ea4f73
From: KernelCI bot <bot@kernelci.org>
To: kernelci-results@groups.io
Cc: stable@vger.kernel.org
Reply-To: kernelci@lists.linux.dev
Date: Sat, 08 Aug 2026 02:30:12 -0000
Message-ID: <178615621227.286.3093765408899224537@9a65d8f5b626>



Hello,

Status summary for stable/linux-6.12.y

Dashboard:
https://d.kernelci.org/c/stable/linux-6.12.y/7351870f56cba79097a2ab57e609469719ea4f73/

giturl: https://git.kernel.org/pub/scm/linux/kernel/git/stable/linux.git
branch: linux-6.12.y
commit hash: 7351870f56cba79097a2ab57e609469719ea4f73
origin: maestro
test start time: 2026-08-07 05:47:14.209000+00:00

Builds:	   55 ✅    0 ❌    0 ⚠️
Boots: 	   88 ✅    0 ❌    0 ⚠️
Tests: 	10465 ✅  761 ❌  930 ⚠️

### POSSIBLE REGRESSIONS
    
Hardware: acer-chromebox-cxi5-brask
  > Config: x86_64_defconfig+lab-setup+x86-board+kselftest
    - Architecture/compiler: x86_64/gcc-14
      - kselftest.cpufreq
      last run: https://d.kernelci.org/test/maestro:6a7576b162f33761c08d91b3
      history:  > ✅  > ❌  
            
      - kselftest.cpufreq.cpufreq_main_sh
      last run: https://d.kernelci.org/test/maestro:6a7577be62f33761c08da593
      history:  > ✅  > ❌  
            


### FIXED REGRESSIONS

  No fixed regressions observed.


### UNSTABLE TESTS

  No unstable tests observed.


Sent every day if there were changes in the past 24 hours.
Legend: ✅ PASS   ❌ FAIL  ⚠️ INCONCLUSIVE

--
This is an experimental report format. Please send feedback in!
Talk to us at kernelci@lists.linux.dev

Made with love by the KernelCI team - https://kernelci.org
