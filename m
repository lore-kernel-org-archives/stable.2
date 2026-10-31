Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=74.125.82.174
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1793413840;
	b=XM4ostGO8zLIXIN0t0ypaCNO4obvYwpPtgfvbQSZDxFpvEHqNPq5OKoLJptZ4TvG1VXs
	 Sf3T7OhrZ0s4hbzN67J3BjxhLnbp6NLry9KD8DfotJNWYjXXvRNjrS7hzNyL5ONjEUMgS
	 uRtOd+/lROK/9o36qaaWHNZxt3KHs+wWktXpER9BWpH5mHMK/7COvQsD3pw0bcHKZIsBy
	 PfpAwHLR7EFX4GaTqFcJYEAX4ARgInAEoz7u9i5rg2CtI9F614K1mUfh5R6UDqzNz3XiH
	 QGquyKuGXeMK83wybOKGYTBe+dtrkU8gGjdMUcenDz7+ExOWXoLqmGp8C3Bqn8rQOAg==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1793413840;
	h=DMARC-Filter:Received:DKIM-Signature:X-Google-DKIM-Signature:
	 X-Gm-Message-State:X-Gm-Gg:X-Received:Received:Content-Type:
	 MIME-Version:Content-Transfer-Encoding:Subject:From:To:Cc:Reply-To:
	 Date:Message-ID;
	bh=nCQYA+IcWBv8VCwPkqlx05CvAL4kBL5VsPabXs4CRGI=;
	b=N/rZad61AzbR5FExf+fLqwrjU1B2grjD9b5vCC+Fc++/drXqTDAM5FAlUYg4wqJx2sMZ
	 MONZ7CZDkh17T5nQDXBm/scdFzlmC9qi3hhWtbDrapORSAnaQbyjyglsc69RCeLrlubzD
	 TCsiLoc5VpvyydRQP3mty12db3usPuTLmFDCpQ4vcOOAEPf5BgLWkgFb+dg/K5t9R2fNx
	 aUMx82AmIbHGUUj6a/RS4h94+tdFNPKxtT6Rn8vFbCKF+WAFotdFkyzj6Z2QfPfETUxOA
	 ljI6TBbDRj4PXR2GIiL0bteXk0T4O71Ya9i6ruEXmqDwtxaEjF1rf+OnQOzSe3tUJPg==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=kernelci.org;
	spf=pass smtp.mailfrom=kernelci.org;
	dkim=pass header.d=kernelci.org header.i=@kernelci.org header.a=rsa-sha256 header.s=google header.b="BcX6D/Lw";
	arc=none smtp.remote-ip=74.125.82.174
Received: from mail-dy1-f174.google.com (mail-dy1-f174.google.com [74.125.82.174])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E6ED1606A31A
	for <stable@vger.kernel.org>; Sat, 31 Oct 2026 02:30:39 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org E6ED1606A31A
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=kernelci.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=kernelci.org
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=kernelci.org header.i=@kernelci.org header.a=rsa-sha256 header.s=google header.b=BcX6D/Lw
Received: by mail-dy1-f174.google.com with SMTP id 5a478bee46e88-36a0f27c9f4so2276820eec.1
        for <stable@vger.kernel.org>; Fri, 30 Oct 2026 19:30:39 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=kernelci.org; s=google; t=1793413839; x=1794018639; darn=vger.kernel.org;
        h=message-id:date:reply-to:cc:to:from:subject
         :content-transfer-encoding:mime-version:content-type:from:to:cc
         :subject:date:message-id:reply-to:content-type;
        bh=nCQYA+IcWBv8VCwPkqlx05CvAL4kBL5VsPabXs4CRGI=;
        b=BcX6D/LwZCcxBK6ly+VOmKekaUHgaEvvbKNrl/GXZBS29l9FysUVKIJcSWb3TcGdN7
         o9EVy671seWTPZEcWq+SaVmt1zkv+QzxgiMbwUqGfI+ER6vfamJSISnj47aSh6AfnDbY
         7qfoNoZqMK2Qsnb4nMpZutwChYfdE/jelgVGTbFg7GJDlhS+bghxyfKSyaofQ5cXJTdL
         jwJP47UhzxZUMq4yDmsdKQpObk8IKa1C2y3UewVDp8tR5DV/raHe9veehaf1Xq8kCWLY
         OrMuFPhz6hgqL/D1l4bC/AAeqq1FjHpBFO2Qvb7JlmjqZGK7IaIu9EcZleW8A+aC+uox
         Lvfg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1793413839; x=1794018639;
        h=message-id:date:reply-to:cc:to:from:subject
         :content-transfer-encoding:mime-version:content-type:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=nCQYA+IcWBv8VCwPkqlx05CvAL4kBL5VsPabXs4CRGI=;
        b=wSojXM4oza5tiLulzotloecQh0rew40bqVTGqSwBW2Dc1G/HbfIyO35j/6bY+vQgNV
         goDG+/qmFPQ8bvN/B+hXeF1ZPdZ1rLZJM2vxlBEnwx9zPnvvbIs1elZeNKA6lixAURjX
         mG68ndM9bb60JqE2XCyxvLmwY4DEp2xyNkhMGdX0u2fsXr6Hkx0Rg4g35lJmpw/y/6Le
         GrWEEKA9/xhIPaic4Ao1Z7QDz8cxN91NS/WrosPmB1dPGZDeEBwOMXniC+eZA9q3wIX/
         B6zd3MpmUc8SzCXF87+RaQ/6aAKKHOvFeRiOcL3VHVLgzWDhgiFHqE7lulWPVUX3wf8f
         6tBQ==
X-Gm-Message-State: AFq9FYLqJwdKX1IaLhw+EegkHZMBoTBqloAQOIu2mCZO6LHskRoemF6k
	j6hA4okPTXyr5YDerhHovv+7IDa8qlprZA/4bNYaWA4RsPZlpt4fpT0XjvSkcZ1h6dWyswGe2oN
	DMIpp
X-Gm-Gg: AYBFou3yhFjjWN7bPblUWOSvWPhxhw8njAGneqNmMgcI5CUajPUye4cRt1Xk5LVYXqV
	7xIRdeH9fV2MdAZ7nQmyfS7X8yo8Q0+XsHGlr6xvk2UEMRd7MzeOnwoyEXlD1yEpDpoytNWevP7
	cHXCzhAOu91qv//VB2KonI5CHdBk+dZoB4L+SFTLlpA5aRmZTOANBhWJgMffGuRN6543mrMxti8
	Hqb3r2gfdXFQScXTwJH1u+aMdQmpboxvnOZeUpkcUcZt5YQPDQfd9zpIBv3riPJg1EvcQsU8By8
	rigwhirsnnzfCZS7xt1BTHdemdVXRfmqebk7VBEsdagibOPEkZBsyDH99uJ2dHbVF2LL5lp+5vA
	ii5dE+xeEarBbcGqZp60NupsbfHcU3T3bUYC1gcgFglZy4dGuBr6yrVmN444GDg8VfQFN2bjIYV
	hChQqCUp30MHsdMt13VwQF9tclAoyTs5uO3Ff4Lbd342bD6WPeKg+BH3gmyigy43sjpt1eBgmuO
	d3Du79l40IgnWiYQ2icyN2h4hIJiMqNhXG6w0jWA7rusjRKXTtJNBxxVtPouCgBUKAlELJfJkyw
	9vm7JkcjasIgSOoJUi47xg==
X-Received: by 2002:a05:7022:eb46:10b0:193:1148:64fe with SMTP id a92af1059eb24-1ac56ca032bmr5769007c88.6.1793413838986;
        Fri, 30 Oct 2026 19:30:38 -0700 (PDT)
Received: from 34406640b1f4 ([20.38.40.137])
        by smtp.gmail.com with ESMTPSA id a92af1059eb24-1aed79b3dfcsm2041939c88.12.2026.10.30.19.30.38
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 30 Oct 2026 19:30:38 -0700 (PDT)
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
Subject: [STATUS] stable/linux-5.10.y -
 f23b568f7597f98a241454018a34361ce2523c05
From: KernelCI bot <bot@kernelci.org>
To: kernelci-results@groups.io
Cc: stable@vger.kernel.org
Reply-To: kernelci@lists.linux.dev
Date: Sat, 31 Oct 2026 02:30:38 -0000
Message-ID: <179341383784.70610.5262130198599897768@34406640b1f4>



Hello,

Status summary for stable/linux-5.10.y

Dashboard:
https://d.kernelci.org/c/stable/linux-5.10.y/f23b568f7597f98a241454018a34361ce2523c05/

giturl: https://git.kernel.org/pub/scm/linux/kernel/git/stable/linux.git
branch: linux-5.10.y
commit hash: f23b568f7597f98a241454018a34361ce2523c05
origin: maestro
test start time: 2026-10-30 12:34:36.513000+00:00

Builds:	   49 ✅    0 ❌    0 ⚠️
Boots: 	   29 ✅    0 ❌    0 ⚠️
Tests: 	 2113 ✅  259 ❌   22 ⚠️

### POSSIBLE REGRESSIONS

  No possible regressions observed.


### FIXED REGRESSIONS

  No fixed regressions observed.


### UNSTABLE TESTS
    
Hardware: qemu-arm64
  > Config: defconfig+netdev+nfs-root-boot+ltp
    - Architecture/compiler: arm64/gcc-15
      - ltp
      last run: https://d.kernelci.org/test/maestro:6ae498ec6eff83db85cb32dc
      history:  > ✅  > ✅  > ❌  > ✅  > ❌  
            


Sent every day if there were changes in the past 24 hours.
Legend: ✅ PASS   ❌ FAIL  ⚠️ INCONCLUSIVE

--
This is an experimental report format. Please send feedback in!
Talk to us at kernelci@lists.linux.dev

Made with love by the KernelCI team - https://kernelci.org
