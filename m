Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=74.125.82.172
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1794364253;
	b=grGt0O8R8gfoFwws7aMWqslncF/H37S9viH1r+CBxY7U//pGMkhBiNC62T3iOAsogTod
	 dBXQU7m84KnyTODDzrfKxBThi6OtqTJe5mpfpfb+Pe6rUosSTLBG6yLfwIBM8EwQqsxfm
	 /kMvxXznq7t3kc6fM980vyudIr4js2Mbd5l9293ey69IGIk/WRmXZTRRmRRroQB74o5QJ
	 XPWnS+OgWq45D/ryLus28LTf+YVt7rrOZ0QdzTdFsMeTpfihyEp2E3WrOTpPyN9BBrm2h
	 7f+IBRSFAY5sJ9z27IutLSHs9HaEBJgQ3JxMCRJPQPQS+ndjIXgsIeeT82iVWLKLrcw==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1794364253;
	h=DMARC-Filter:Received:DKIM-Signature:X-Google-DKIM-Signature:
	 X-Gm-Message-State:X-Gm-Gg:X-Received:Received:Content-Type:
	 MIME-Version:Content-Transfer-Encoding:Subject:From:To:Cc:Reply-To:
	 Date:Message-ID;
	bh=YkV0izQiz5Jn8l0UrO1Aylp+uLyNs5mpCDpqaSNGMd0=;
	b=RQE+aKb5j/ON9AQyHVqLWexdilJOu75tQcyjIhLQAs65QMV+8Qxu8LrPO08CK6ejg3IG
	 n9NnJw7ppVCjVFoMOuuLkDGivnWIMMDRVTOk9A4alnsBp7Kl/7SM/s+zIXtIqDP9sT3mv
	 DB+AU+zX8pSqlja4vPH752wCLuE/38Krk6+FNLdvMVft/viNYxSoRWwHPRg9DqOpW9nJ4
	 jZIaHUQ/2WId4BKKB/1bMz7xh0iDt1Dimy60vYMtueEa8yPkzboJ9QbAicl0JV7waV8Hu
	 tGHFr0DctnQsDb8KJvXaTAM9gifjsGyplxeAP4Dvcz8iZnslyYJqo5BvXlX9mZ06WXA==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=kernelci.org;
	spf=pass smtp.mailfrom=kernelci.org;
	dkim=pass header.d=kernelci.org header.i=@kernelci.org header.a=rsa-sha256 header.s=google header.b=QDk9PUCw;
	arc=none smtp.remote-ip=74.125.82.172
Received: from mail-dy1-f172.google.com (mail-dy1-f172.google.com [74.125.82.172])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0F5E9606A330
	for <stable@vger.kernel.org>; Wed, 11 Nov 2026 02:30:52 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 0F5E9606A330
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=kernelci.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=kernelci.org
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=kernelci.org header.i=@kernelci.org header.a=rsa-sha256 header.s=google header.b=QDk9PUCw
Received: by mail-dy1-f172.google.com with SMTP id 5a478bee46e88-37000e7234bso191046eec.1
        for <stable@vger.kernel.org>; Tue, 10 Nov 2026 18:30:52 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=kernelci.org; s=google; t=1794364252; x=1794969052; darn=vger.kernel.org;
        h=message-id:date:reply-to:cc:to:from:subject
         :content-transfer-encoding:mime-version:content-type:from:to:cc
         :subject:date:message-id:reply-to:content-type;
        bh=YkV0izQiz5Jn8l0UrO1Aylp+uLyNs5mpCDpqaSNGMd0=;
        b=QDk9PUCwZe9ZdiSW7a25orN4W85/22+haD+jowc3Hk6RHaNEyrdUm0mXAN5YJ1pCMC
         hAD9c3fBYlWApT/a74jHOdLb3Xy3+d20v/xuPzql0+5lzVy8tilWxdJu6ueUgB1TAmOX
         vc3XAdh4JR0PkcBagcegYpEVaC00yKGEJEIqUq4SiHAaFEy3nVsbKpjHCJ6omnAq90pO
         liWBb+G7ddFov3yNlZr6gHfm2dNGNl6wt083LLzagMhLIj+LY28JvKoVlIcDeizDymy2
         kjncEF4TcnSfTWxwKvgwdKLMExO+XexChtkoanVxQS5xbTpXlb6nPSNwMvuMug2sr0a6
         pNCw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1794364252; x=1794969052;
        h=message-id:date:reply-to:cc:to:from:subject
         :content-transfer-encoding:mime-version:content-type:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=YkV0izQiz5Jn8l0UrO1Aylp+uLyNs5mpCDpqaSNGMd0=;
        b=YfvowBWg6dehi4EBxUQ1Gvy7aEVpxfHyaQTo7+JFg8ouD9oRF8TCHB62BH+bMdfPVf
         dfyaLMZgvDsYnugr9TND1iRnFcre/UXdAS2RjO2Y+5U/vL6fTc/1YYIPMOyb3WzHTCmw
         adgcY8+JLX4QJGHF22pGvy8QIqYFkr1i004dtmAq/LGI46+oK5ap8MsKEO3Y9hUnrZCG
         6b+Tyb1SQzG7sDdqKmIdanmaBl0GW+QuF4O10fNHSLYFJRXwmB4lKwfIcOy4rLNAsFUL
         qbwdr/Hmduvie8k3xOnV7YLQ4qboqY8ncQSTQmaJWj3hOxybem6lbht7F18Sl1vHWapx
         JMhg==
X-Gm-Message-State: APuU4Z/y1t1Jnc+s2f22IbmsuJoLrwJReUE/S6MFACKNt+Mda/bYnPa0
	aR88D7NQ6c09BLdcugSMwj4kopRuFa/NnGkM0aEhGV35p9SKvUOelU2PE5eDR/RatM8FCoSUbno
	vR7Hc
X-Gm-Gg: AYBFou0hJwZd7v4iP+2lLmiDxAHD67ebLiB20aFzRVDbs/07eobhOA5gAOY9ddXN+4U
	YCQ1VfD7qmhuv0bdjRdJSHSekRNOztf2hQ80nwHvVPRtkYj5NA709RrQeztHC+8qMraSTvIwLas
	DA0xbxfSsV3YKsJxI7kti+Ka9i7BUJ1ZyCNX5dRLdwlaKI+qOCBYTLjeBqgkC4/+fVrXBTX9Bhq
	8fuv8mVgtExTh+cvucGXCJdQzI+IVN54CPTt5Jx+mJsbspRlwFnZ742lo91m98to2e7OFXzhcc/
	ha3WpmhgRRaPxsqgpxkruwa8uj97+5FbecHWLijl3c8Hfg3VkEqdEIg2iEhRvZQpN374Tb+f9tn
	l4Pj/d/Sg9KUscA/IVZlEUtAihiUVeyDMXtkOhxeOiyaBeG/Fw8ank2uzzk1r1/m6WRqKDMSRaZ
	55iZNf6agnD9KrUhGWEwkHOQ2dHM+LZcwu+yvpJH98+Ojx7FuIQg6Udfb7kQX8atNV8patEiQeO
	V5IVfLH1RPFvZTrRu0trEIWAMr03XSjP7KJ84gYMfHOasjBZ9K0C02+1GBu9CxWHZDb7C6nBbhx
	PG0MrY2mglbjUvbgYHg2HcayxYDisRVgUNVparoaFAhB
X-Received: by 2002:a05:693c:8951:20b0:35d:d9a9:e455 with SMTP id 5a478bee46e88-37686754f45mr2075244eec.21.1794364251703;
        Tue, 10 Nov 2026 18:30:51 -0800 (PST)
Received: from a3f41c651398 ([20.38.40.137])
        by smtp.gmail.com with ESMTPSA id 5a478bee46e88-3766146551asm3228107eec.1.2026.11.10.18.30.41
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 10 Nov 2026 18:30:41 -0800 (PST)
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
 d3417611a3b40b7f04a29e558cebac2bf69889d7
From: KernelCI bot <bot@kernelci.org>
To: kernelci-results@groups.io
Cc: stable@vger.kernel.org
Reply-To: kernelci@lists.linux.dev
Date: Wed, 11 Nov 2026 02:30:41 -0000
Message-ID: <179436424074.67662.10872213237250950606@a3f41c651398>



Hello,

Status summary for stable/linux-6.12.y

Dashboard:
https://d.kernelci.org/c/stable/linux-6.12.y/d3417611a3b40b7f04a29e558cebac2bf69889d7/

giturl: https://git.kernel.org/pub/scm/linux/kernel/git/stable/linux.git
branch: linux-6.12.y
commit hash: d3417611a3b40b7f04a29e558cebac2bf69889d7
origin: maestro
test start time: 2026-11-10 18:16:21.573000+00:00

Builds:	   59 ✅    0 ❌    0 ⚠️
Boots: 	  109 ✅    0 ❌    0 ⚠️
Tests: 	13724 ✅ 1166 ❌ 2858 ⚠️

### POSSIBLE REGRESSIONS
    
Hardware: acer-chromebox-cxi5-brask
  > Config: x86_64_defconfig+lab-setup+x86-board+kselftest
    - Architecture/compiler: x86_64/gcc-14
      - kernelci_wifi_basic
      last run: https://d.kernelci.org/test/maestro:6af36e1f5b429d354e2eefea
      history:  > ✅  > ❌  
            
Hardware: acer-cp514-2h-1130g7-volteer
  > Config: x86_64_defconfig+lab-setup+x86-board+kselftest
    - Architecture/compiler: x86_64/gcc-14
      - kernelci_wifi_basic
      last run: https://d.kernelci.org/test/maestro:6af36d3a5b429d354e2ee3b9
      history:  > ✅  > ❌  
            
Hardware: bcm2711-rpi-4-b
  > Config: defconfig+netdev+nfs-root-boot+ltp+crypto+ima
    - Architecture/compiler: arm64/gcc-15
      - ltp
      last run: https://d.kernelci.org/test/maestro:6af368fd5b429d354e2ea608
      history:  > ✅  > ✅  > ❌  > ❌  > ❌  
            
Hardware: k3-am625-verdin-wifi-mallow
  > Config: defconfig+arm64-chromebook+kselftest
    - Architecture/compiler: arm64/gcc-14
      - kselftest.kvm.kvm_arch_timer_edge_cases
      last run: https://d.kernelci.org/test/maestro:6af3b8445b429d354e32296d
      history:  > ✅  > ❌  
            
Hardware: qcs6490-rb3gen2
  > Config: defconfig+lab-setup+kselftest
    - Architecture/compiler: arm64/gcc-14
      - kselftest.proc
      last run: https://d.kernelci.org/test/maestro:6af36fb15b429d354e2f0cd7
      history:  > ✅  > ❌  
            
      - kselftest.proc.proc_read
      last run: https://d.kernelci.org/test/maestro:6af3852a5b429d354e30e048
      history:  > ✅  > ❌  
            


### FIXED REGRESSIONS
    
Hardware: acer-chromebox-cxi5-brask
  > Config: x86_64_defconfig+lab-setup+x86-board+kselftest
    - Architecture/compiler: x86_64/gcc-14
      - kselftest.exec
      last run: https://d.kernelci.org/test/maestro:6af36b495b429d354e2ec566
      history:  > ❌  > ❌  > ✅  
            
      - kselftest.exec.exec_binfmt_script_py
      last run: https://d.kernelci.org/test/maestro:6af36d115b429d354e2ee07b
      history:  > ❌  > ✅  
            
Hardware: bcm2711-rpi-4-b
  > Config: defconfig+netdev+nfs-root-boot+ltp+crypto+ima
    - Architecture/compiler: arm64/gcc-15
      - ltp.msgstress01
      last run: https://d.kernelci.org/test/maestro:6af3c55c5b429d354e328fa0
      history:  > ❌  > ✅  
            
      - ltp.shmctl01
      last run: https://d.kernelci.org/test/maestro:6af3c55c5b429d354e328f01
      history:  > ❌  > ✅  
            
Hardware: qcs6490-rb3gen2
  > Config: defconfig+lab-setup+kselftest
    - Architecture/compiler: arm64/gcc-14
      - kselftest.device-error-logs
      last run: https://d.kernelci.org/test/maestro:6af36f8b5b429d354e2f0848
      history:  > ❌  > ✅  
            
Hardware: sun50i-a64-pine64-plus
  > Config: defconfig+lab-setup+kselftest
    - Architecture/compiler: arm64/gcc-14
      - kselftest.alsa.alsa_pcm-test_default_time4_sun50ia64audio_0_0_CAPTURE
      last run: https://d.kernelci.org/test/maestro:6af37e205b429d354e305159
      history:  > ❌  > ✅  
            
      - kselftest.alsa.alsa_pcm-test_default_time7_sun50ia64audio_0_0_CAPTURE
      last run: https://d.kernelci.org/test/maestro:6af37e205b429d354e305156
      history:  > ❌  > ✅  
            


### UNSTABLE TESTS
    
Hardware: qemu-arm64
  > Config: defconfig+netdev+nfs-root-boot+ltp+crypto+ima
    - Architecture/compiler: arm64/gcc-15
      - ltp
      last run: https://d.kernelci.org/test/maestro:6af367e75b429d354e2e7bde
      history:  > ✅  > ✅  > ❌  > ✅  > ❌  
            


Sent every day if there were changes in the past 24 hours.
Legend: ✅ PASS   ❌ FAIL  ⚠️ INCONCLUSIVE

--
This is an experimental report format. Please send feedback in!
Talk to us at kernelci@lists.linux.dev

Made with love by the KernelCI team - https://kernelci.org
