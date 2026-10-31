Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=74.125.82.177
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1793413809;
	b=x/2qxRnON/LRRpzCQa6vIx2K6Eq78UeVVNFea3Pg7XdnJ3i/Kk07UdxytISwFJ8WDFUH
	 YKmhuiej82BZLFhaSBYpN7CFrasYOOwZsxdmxzSJvbvm0k0x/NeFSs/rr92DhTvlLNnxb
	 OPaflsVs00ZReqqdFoxVzjrZ5ny9u/0E9TPbWiWRpiwyy5enM4Um/FZ7XhExjDYqFb+IU
	 dRgEmVEXLKjQuquRTn4e47t0WA4a3KVxjj4ZT7356PGklt5y3bRtXF8mnXUQvpjZe+em2
	 7YTOdZzLnw2I4PkalmDzn0NZ+cOsoeHqv4FwqGKKY7avHYDFiUpTQmoKP3M16I8ZuIA==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1793413809;
	h=DMARC-Filter:Received:DKIM-Signature:X-Google-DKIM-Signature:
	 X-Gm-Message-State:X-Gm-Gg:X-Received:Received:Content-Type:
	 MIME-Version:Content-Transfer-Encoding:Subject:From:To:Cc:Reply-To:
	 Date:Message-ID;
	bh=dfXxa0EL8pn6gumiSg81+VRLbt60h5w2lsLAdhXJtqY=;
	b=HVyYx5ff87lOrNwh/J+QicoR3JqXE+srncWyylEJu1lH5HIyhW7OUdzaBPz4Hj9EW0TA
	 EkU3lsIFRrSyW6caV6IiVdG18ujfHE6pCad3++HLvjBqv6zvU+ElAjc0ETlu5sDSPYQwx
	 5Uqk9TRi6Q1wmrZgeIrLRKttkE9ubob3+UOOcCJQ5o/Mrxcb9XfXXXLV7PRSc292UZxk9
	 ahVZQsiyH9XPlD+y61gt2HAkdMCSMg49eQWQx14NKE60uGVIrlmY3h2o1YMA0Entn1vs9
	 /+Cms4sA47rhjoq89wZ6DgTPFCKDqlSdtzfuY1vqVaSXxFfzJ39SSwAECIGcCMGm+aA==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=kernelci.org;
	spf=pass smtp.mailfrom=kernelci.org;
	dkim=pass header.d=kernelci.org header.i=@kernelci.org header.a=rsa-sha256 header.s=google header.b=RjPjG34C;
	arc=none smtp.remote-ip=74.125.82.177
Received: from mail-dy1-f177.google.com (mail-dy1-f177.google.com [74.125.82.177])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E8A51606A320
	for <stable@vger.kernel.org>; Sat, 31 Oct 2026 02:30:08 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org E8A51606A320
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=kernelci.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=kernelci.org
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=kernelci.org header.i=@kernelci.org header.a=rsa-sha256 header.s=google header.b=RjPjG34C
Received: by mail-dy1-f177.google.com with SMTP id 5a478bee46e88-33fb4680717so635893eec.1
        for <stable@vger.kernel.org>; Fri, 30 Oct 2026 19:30:08 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=kernelci.org; s=google; t=1793413808; x=1794018608; darn=vger.kernel.org;
        h=message-id:date:reply-to:cc:to:from:subject
         :content-transfer-encoding:mime-version:content-type:from:to:cc
         :subject:date:message-id:reply-to:content-type;
        bh=dfXxa0EL8pn6gumiSg81+VRLbt60h5w2lsLAdhXJtqY=;
        b=RjPjG34CvUwzF0KVGMANsFl6l7t3lB1SCnR6tmGHPUGXczd5J3T/NTbEGf4kWZFSg4
         iiegRBi5senrLTM+V5gE0yA47L1VgBqRnjD3LhQTXrYo2yp3pMOY1xMOwUZP/EtQoKcn
         uDfPhV902CLBC6K7J9vr/inlsT7Wt14nuUk0i9VmoAF+EmBwqrrndT/rG80xVqFC/kxd
         ILu4wQpPeUkMQN7OJ3/fQALVKbfqQj/gmXRFoab7Tuv7pxJUpD9+IcOTkCTbYQ2xneVj
         ocuoBTfumfowZY1xy+SM/H+1Xfg/nWdKUsC/3Qkds7LR5Cwr3G0lTaMnBRPGANhKZQq0
         lOdA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1793413808; x=1794018608;
        h=message-id:date:reply-to:cc:to:from:subject
         :content-transfer-encoding:mime-version:content-type:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=dfXxa0EL8pn6gumiSg81+VRLbt60h5w2lsLAdhXJtqY=;
        b=X1g1cq/pHBDF4lkGdXMFhzR/aYnabauT1HhzqxDAYituL8BonwfMXFD0eWEUfn6noM
         pid96aN9sNfv7PU3J7/m9MgQ1DcQipUKhU5fxVUUSLRh9yzmH3fcZ2hrzQFOk+emdKNP
         3QRcM3RYtW3kxO57Oj+xxfMO0pa1gDEx5sEsDvoizBzDw2xT4bbvmsaIQ/jm+jMvs54V
         MydP2ROJwmdE1Z4YCq3OagmxvmDquWpyftgmt19E8Xfft9mpJq58NEdutQwwLfQmcFqb
         Pv6zYYW4HzDpT7p3Ov+yCiy7zUjWtPTqtympWcTs+wUFC8m3zs5Pmrk9mhOowNwV+yq1
         ORsg==
X-Gm-Message-State: AFq9FYIqyalqIko8LiZNHN2nTZmygskYGTg57KEbQNwL0M+AKU5gea9E
	uHR+kgJtrOrK7FUEetMhgRawSLMkFHKwVyY5SXGDjvTMsZxSOrelidn8+WsUUUAiIHo0ivNrxhz
	q9eJM
X-Gm-Gg: AYBFou3d/beXXu42+pb249dibQnBZ9DuXxIi46lm9QE+2AViWsoxiYbSADtVMMEzITm
	gmDEspd9NU5fICD8+XI33XHtBBZ3EY9BPSv2KR7epjbsz9ySwYFMXNeQ17hps/n/HY7nLAcDPex
	FfvKiWlgelBlTbE9bXpAMV+4GmlObbbhg8nPqeooVx2NP0SwhBxIiVTWjjo0RG3vMVndtVgNKOB
	eyUVCGdidQ217/jkeD4mQaXmNvSwRCPado8qOIW/pUtjU9rZAkVMcxrBrWfvBnED6vqWJtHSmek
	sNsTpist6Nnb53fsgy4a7RjL7rR/SWi8vs2LpiWWHfVJ/7l527QMsFTWolRTtb77l6fhrC9pGFV
	KTWMlUG+dgNZz4KbXyhFB7VDqyjhzBMv38fsG4J8nG+O54lpejodfjCxKyJ7ry8ZXHUaEWq0LPL
	nSys63z+Cusy8TF7wSixloOfwJOY0Kn9biJtBQcg/aF03yDbNi5pqnsqvJqmXvayFayGPwXhtJp
	LCB6LXVAN4k8eHrF/upWTF3MBkz/c5jbqPxBK7n5IELvB67BgtB9TaApVPTQFXfuA0mYH69/K2n
	ZCl/HhVvAV22bIZrmq2jHg==
X-Received: by 2002:a05:693c:41c6:20b0:368:c6b9:d3c0 with SMTP id 5a478bee46e88-36a423cfcd3mr5991383eec.28.1793413807998;
        Fri, 30 Oct 2026 19:30:07 -0700 (PDT)
Received: from 34406640b1f4 ([20.38.40.137])
        by smtp.gmail.com with ESMTPSA id 5a478bee46e88-36a428aed76sm12049771eec.9.2026.10.30.19.30.07
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 30 Oct 2026 19:30:07 -0700 (PDT)
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
Subject: [STATUS] stable/linux-6.1.y -
 08889840163ebcdb7e24bf7ec311bc2e6fc3aaea
From: KernelCI bot <bot@kernelci.org>
To: kernelci-results@groups.io
Cc: stable@vger.kernel.org
Reply-To: kernelci@lists.linux.dev
Date: Sat, 31 Oct 2026 02:30:07 -0000
Message-ID: <179341380713.70610.15895173293782149848@34406640b1f4>



Hello,

Status summary for stable/linux-6.1.y

Dashboard:
https://d.kernelci.org/c/stable/linux-6.1.y/08889840163ebcdb7e24bf7ec311bc2e6fc3aaea/

giturl: https://git.kernel.org/pub/scm/linux/kernel/git/stable/linux.git
branch: linux-6.1.y
commit hash: 08889840163ebcdb7e24bf7ec311bc2e6fc3aaea
origin: maestro
test start time: 2026-10-30 12:34:37.324000+00:00

Builds:	   50 ✅    0 ❌    0 ⚠️
Boots: 	   54 ✅    0 ❌    0 ⚠️
Tests: 	 3265 ✅  242 ❌  142 ⚠️

### POSSIBLE REGRESSIONS

  No possible regressions observed.


### FIXED REGRESSIONS

  No fixed regressions observed.


### UNSTABLE TESTS
    
Hardware: qemu-arm64
  > Config: defconfig+netdev+nfs-root-boot+ltp
    - Architecture/compiler: arm64/gcc-15
      - ltp
      last run: https://d.kernelci.org/test/maestro:6ae4bb8c6eff83db85cd7c40
      history:  > ✅  > ✅  > ❌  > ✅  > ❌  
            


Sent every day if there were changes in the past 24 hours.
Legend: ✅ PASS   ❌ FAIL  ⚠️ INCONCLUSIVE

--
This is an experimental report format. Please send feedback in!
Talk to us at kernelci@lists.linux.dev

Made with love by the KernelCI team - https://kernelci.org
