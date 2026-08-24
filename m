Received: from mail-pf1-f174.google.com (mail-pf1-f174.google.com [209.85.210.174])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 09B1D370AEB
	for <stable@vger.kernel.org>; Mon, 24 Aug 2026 02:30:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.210.174
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1787538640; cv=none; b=NyOgHWPlfK42O22JkrRLY/nKHmeBEWend7QXRpr25gs5FD6X/w/mJAtQzlkLcxn0LPjbHT8Si68pc4BtrJdjzJT5DvQkGrsdUdw4L6XfT7WDb3Musbq2ExsP+2tdyeaI4UjwTbGJUb0Hq5ZX5sUJtkcmYurzrX3sB8I1yksls7E=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1787538640; c=relaxed/simple;
	bh=RZzPe/hQ2mJk7w4htOBACc9H1pptqQ04xnxK0WURLx8=;
	h=Content-Type:MIME-Version:Subject:From:To:Cc:Date:Message-ID; b=rdOTq4foQNUq7uCGrkLXrfZ1PFkJRJbKJ7l1URYmwRi2FfPip7QMN6696yIbf2dwc3S8fIFAcKcbxwkejKz0lSKDqenahXHxR5j4dOoWTeDtqgTb0dp448Rotul+QwU0uj9g2yanZ+cme+diSKi15NW53MTn9lml1QjroxG76Yo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=kernelci.org; spf=pass smtp.mailfrom=kernelci.org; dkim=pass (2048-bit key) header.d=kernelci.org header.i=@kernelci.org header.b=BExTThtI; arc=none smtp.client-ip=209.85.210.174
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=kernelci.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=kernelci.org
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernelci.org header.i=@kernelci.org header.b="BExTThtI"
Received: by mail-pf1-f174.google.com with SMTP id d2e1a72fcca58-84f3ab8750cso1997407b3a.0
        for <stable@vger.kernel.org>; Sun, 23 Aug 2026 19:30:36 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=kernelci.org; s=google; t=1787538635; x=1788143435; darn=vger.kernel.org;
        h=message-id:date:reply-to:cc:to:from:subject
         :content-transfer-encoding:mime-version:content-type:from:to:cc
         :subject:date:message-id:reply-to:content-type;
        bh=31YwN7QOx5PZoKLOvhS0b8HK8OQ9SK0vMOcjKumUgGs=;
        b=BExTThtItfroJkEdM7rwgElvZtbe90++X0Gno90r/Bz1M4VJ2zzITrP6kDGHMlogDa
         WdcCboclwMJ6PeA7fEmfnuwF4vP5igXjxuVp6ixZ4yajGLSSeeLfy/n5wiSYrL60XTmT
         FTId8KQ01TOaUfbwPYeIRE2QcnrDDzauKacuJ2zAumt7hcK9Eby3bJcyFTUaBrv0aNQS
         7CzK/mgm33OGJhyKhf6xrM6WcD0p3eg9fhG7Q9RfMOq0r0YyhDaZJtZ6auOgHFaHHzUU
         EBRszHzYz5rgraLzw55IQyWgkSMRCt+C4foXgZAXyjbQ0ljKYOUEo3lgDSEt8gqy+Rd7
         kfCQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1787538635; x=1788143435;
        h=message-id:date:reply-to:cc:to:from:subject
         :content-transfer-encoding:mime-version:content-type:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=31YwN7QOx5PZoKLOvhS0b8HK8OQ9SK0vMOcjKumUgGs=;
        b=ixso1P2TCocPkqxtN5q3IGKG8nllTbrnca0wZclZjt46h4uW/KlT+zidaYTXhRW3xe
         SkbYHKMoIXpIk7MGDNeztCcZ0e6hdjxQI24H1f3IpmRcP8XimxbtdI12Awkp1nXJUTv9
         +mUSZ1cdFwt0GS6SbcUajSvDdXnYeuFfnDj4OyifKgyrgn6Lgpx0sA1VCkdErlsOafHd
         q6/7qvKMWXSczk/bPsPKbd36mo48wqwn9oMieUn27h1yJPju372D2bxDeIt1yjDY9GzA
         Cwo5C5CAmktAKR8IGXiGjG9r8uS5TcEM1PzAtJPrp88KHqe1/C5iekgRwOTKBNAMn+iX
         AtLg==
X-Gm-Message-State: AFuF++kaij0WiByRRTF+aeixwnfaJbiFwZeNvUvIvyEx7sR0eAdaaX4B
	E23LOnYmdbEPWji/cfY+fYNE+xtCD5naz+ZdJu972DtVLqaWwFjgdnKUy8JSCpDXKkE=
X-Gm-Gg: AR+sD11geBnJg0oSfqqnfS4LLqFip9zBzFz6aoxu/1CoZgn/QUE/je8FknxNXBoG19s
	fOz05VfSsLuR5TXOz8n75fFsiT6Axo65VRZHrn5NsqnKYwoXlXjdGASHBpj4OzPRFw5kJc4O88/
	zXaUf7cNP5Xcq53MiDZhpiVnbf1OlkPqw9YHax25bTXXnDPeCPdKq7EnbU5OC2Crvnh5+FHhF/C
	IPFaRFh2DJdm1hsg+I9K8l0V5/95OFE1ev5ISVdYVn9LUD2YnAZCnpy9HATHVeUvdYezJVT1Jbk
	4jEKPnD9b58EfW7/Zb9EA1cLrOoSg53TAReXgOOduMkrimjIdESz328TffM3z04ORL8zFS6PiE6
	rZ9hAKqu5WDFkFtKtObooqmMGn6ytBJcZX7peSGk1KDk2hc9D0K2rNG6jWPTVcVQ9EtbYhb0jQV
	RjAiSxym1Z+QwbXVr1ldouCvRdSss9AJlM1QWo/TKN+kFMn0HzI5vy
X-Received: by 2002:a05:6a21:9d48:b0:3cc:fe21:bf6c with SMTP id adf61e73a8af0-3cd3009d046mr46207458637.11.1787538634932;
        Sun, 23 Aug 2026 19:30:34 -0700 (PDT)
Received: from b455de3d9de8 ([20.38.40.137])
        by smtp.gmail.com with ESMTPSA id a92af1059eb24-1418617378bsm18929829c88.11.2026.08.23.19.30.33
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 23 Aug 2026 19:30:33 -0700 (PDT)
Content-Type: text/plain; charset="utf-8"
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Subject: [STATUS] stable/linux-5.10.y -
 78ed1e47aca1a79488df010fd584502de6aef744
From: KernelCI bot <bot@kernelci.org>
To: kernelci-results@groups.io
Cc: stable@vger.kernel.org
Reply-To: kernelci@lists.linux.dev
Date: Mon, 24 Aug 2026 02:30:33 -0000
Message-ID: <178753863337.2405.13251791545127447678@b455de3d9de8>



Hello,

Status summary for stable/linux-5.10.y

Dashboard:
https://d.kernelci.org/c/stable/linux-5.10.y/78ed1e47aca1a79488df010fd584502de6aef744/

giturl: https://git.kernel.org/pub/scm/linux/kernel/git/stable/linux.git
branch: linux-5.10.y
commit hash: 78ed1e47aca1a79488df010fd584502de6aef744
origin: maestro
test start time: 2026-08-23 12:29:44.443000+00:00

Builds:	   50 ✅    0 ❌    0 ⚠️
Boots: 	   38 ✅    0 ❌    0 ⚠️
Tests: 	 2240 ✅  578 ❌   42 ⚠️

### POSSIBLE REGRESSIONS

  No possible regressions observed.


### FIXED REGRESSIONS

  No fixed regressions observed.


### UNSTABLE TESTS
    
Hardware: qemu-arm64
  > Config: defconfig+netdev+nfs-root-boot+kselftest
    - Architecture/compiler: arm64/gcc-15
      - ltp
      last run: https://d.kernelci.org/test/maestro:6a8af8b962f33761c005a993
      history:  > ✅  > ❌  > ✅  > ✅  > ✅  
            


Sent every day if there were changes in the past 24 hours.
Legend: ✅ PASS   ❌ FAIL  ⚠️ INCONCLUSIVE

--
This is an experimental report format. Please send feedback in!
Talk to us at kernelci@lists.linux.dev

Made with love by the KernelCI team - https://kernelci.org
