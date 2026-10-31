Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=74.125.82.170
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1793413813;
	b=hA/EfmZtodDSZHDpWipgcpKTFoyVagsbe8vMYEEkGI+qnWsAGTiV1EZs5TUvWdtM0DxR
	 b30zBO6S9qT+CE19gd/CNsUYaiu0X1G5N3dNdmhn2g6gVNIEmUvIUPue4EO1lXTpRVf0p
	 ppwqphHhLgagVb3Opcys8Zn/CAb13HZao+YichEAo/ayy4neV5N9MzunaIlNdzy6+oZQ4
	 OKgw/MkVLnaSbxU8Lpm006cvgaWiHTjmfA+MCgBAyRq3/osNda4yqnohQn+tpSxEjYrf9
	 7XZ3Onx6q65Suz301JdONGYFDD8NqU+IXHkDGx8QlMx9nu4P38/s3JbU9WYUXQUygDA==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1793413813;
	h=DMARC-Filter:Received:DKIM-Signature:X-Google-DKIM-Signature:
	 X-Gm-Message-State:X-Gm-Gg:X-Received:Received:Content-Type:
	 MIME-Version:Content-Transfer-Encoding:Subject:From:To:Cc:Reply-To:
	 Date:Message-ID;
	bh=m1WUfwpZtaapZ0zBUumBDcHuJ8Agp5r971eFB6Tts1w=;
	b=EfpWRLzNnJVFfxRn+wpzESjevCFTgzD85PR6G6/Jw9LBbCIdVWtrKTjqGbEhYCcqBY/g
	 RdmB+cyONR22P+nsNbHALWDFT5xv7wFAE9HMRi2SJPzhtqCNm94fEPoUAv/lzQaVUjPw4
	 2bFvwYAM5cpsHq0+uPOaQMBTJOWJRkKZuSxcBVaDhUxc9kXz5Yt5GTy35TYUzpDed6Vu8
	 w7FlVMqZLZmmPawtnDD1SRAlNpZVFD1K+3twnL0ynaw8Paa3GuEtU5n1svMkwsoNhRimg
	 TnmtRZWcE8rpekvCG2tNtOdrhuyGEZ9O0yYwxN+BsbVRHc5vXqtT8WGqXj1wM1NVHpA==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=kernelci.org;
	spf=pass smtp.mailfrom=kernelci.org;
	dkim=pass header.d=kernelci.org header.i=@kernelci.org header.a=rsa-sha256 header.s=google header.b=ZyibJdug;
	arc=none smtp.remote-ip=74.125.82.170
Received: from mail-dy1-f170.google.com (mail-dy1-f170.google.com [74.125.82.170])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D5230606A31E
	for <stable@vger.kernel.org>; Sat, 31 Oct 2026 02:30:12 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org D5230606A31E
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=kernelci.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=kernelci.org
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=kernelci.org header.i=@kernelci.org header.a=rsa-sha256 header.s=google header.b=ZyibJdug
Received: by mail-dy1-f170.google.com with SMTP id 5a478bee46e88-36661f953e4so2021485eec.1
        for <stable@vger.kernel.org>; Fri, 30 Oct 2026 19:30:12 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=kernelci.org; s=google; t=1793413812; x=1794018612; darn=vger.kernel.org;
        h=message-id:date:reply-to:cc:to:from:subject
         :content-transfer-encoding:mime-version:content-type:from:to:cc
         :subject:date:message-id:reply-to:content-type;
        bh=m1WUfwpZtaapZ0zBUumBDcHuJ8Agp5r971eFB6Tts1w=;
        b=ZyibJdug+Yw/v1sygSDnGWouZEDdBqfOc/pPdBXkT8uULJuIbgm2tXzTm6hB2H2iCP
         5NAiSUXZ/RAw8+OYB+95foX0QsynFY407NnVX6v2CPwnv7g6mwn9bN0FUpxa0gn09IgM
         AELTfddI4sMHB2wD8ppS4s3tQKI8Jv5Pe6mEmh5n7DJzGP/8nMynCLalw8JUe8q5dCcE
         VBaq+c6wwVrsK3r0OQSbWqF8p+Q9q6EDBx1x0oFhUMv+O0zExiICllpc4PCXmzgiNeuA
         bc4A8kopPyC9kMOuM/zPAvENKuFDDUC+XFnpqTt008SnxxIG4NfuFGBdsR+u71pcplgI
         YCBA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1793413812; x=1794018612;
        h=message-id:date:reply-to:cc:to:from:subject
         :content-transfer-encoding:mime-version:content-type:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=m1WUfwpZtaapZ0zBUumBDcHuJ8Agp5r971eFB6Tts1w=;
        b=BS4un2ygQyMUDZfnbgtzMNCIpJQK4xOJwykqEVKD7ti5R648PvX6mh+qFoTmJJLHME
         DTCBiQFDL8cnZ5PNZ5V6pKPbstrYtwXXzzWr6QpnPpPSHloTt8sgogf97MyOfiHC1ljj
         D9yU82tD9GLa8IPkzL1GAuZNnxZQBQEdnsMWITBdPik+qWr0ffck8vkslEL4KCdBupxf
         LfyLFQnzitM6zYLYWSKwCiYRh6nFdIUD8kkgfH4JaebEsWNCK+InqbpaFzoQvL3V2eZ4
         P2Hj3IjTTaUZ1W0aP2eqXDgW3AMZJLaN5ewO/1DnIKtcyYh8dXYprUw6H/V/sfPANjV1
         BphQ==
X-Gm-Message-State: AFq9FYIJ02F8RTqN9/96Yn59491WGJLYqCFgHfVsHQhfOANsndBJ7fAQ
	coNMFXGyw5kFudJUE8ssFEUCxVxHVoY/geEGemOTCp0XpiBB/H7vHVp7ZrjoqsiC83j0rDdcPBs
	KsYxc
X-Gm-Gg: AYBFou1pErOiow81vUVfI7FAQWN7yDYsx0APHeLb51clIhI1bRfMCJd227JHY7btDrT
	9rHYUGxFCE3HX4BbDZnTw+XXPvisoSQaKCwIEQ7Nzd/uxjElir9G83YLoAO/n9b+dnvRMlahtJk
	lLk2GLUAeeT4x/icKkxvTuGKkDMumPNgx54A0zlsFam5R4JngVWTxLF8j+q0446ZnN6RVdw3Fis
	q2G9m1WZFoV/TFlqaXMzKsOkqfSgFhd50gjQakGYPAf1agtwHcToovv4L3oA4ji+IIyet2rKzG1
	o2dkOJpXghf2AXItrkVG5z3SjciOyVsVBP+UUNXML7NhuUcQe3fBvUZFYzp2U8KaXpEpiNzf0r8
	znwC9+Xae1oYefw/35geFVsVI0FtebH6dvfWP5wVNlBHpkM8JQv9LKbrp4DBy65uUZST3Abn/CK
	w0Wn3NJH8QkGOgltyAqB9wb3EJZAyVSy3NXbEtAQI74qohJErfkiAzyD4zQO9IHaRVvbImnQ3OU
	fd/KO03F5O9WSJZMLLFQdvqVkfuJmA/TaX6YnmhMWtwLHBXChTA1NWVDs/lPcdixKlQF95s1DwJ
	Dp4EGIEaJOKENNhqLXsm1Q==
X-Received: by 2002:a05:7300:d511:b0:36a:373f:6e29 with SMTP id 5a478bee46e88-36a423312f0mr7185860eec.13.1793413811860;
        Fri, 30 Oct 2026 19:30:11 -0700 (PDT)
Received: from 34406640b1f4 ([20.38.40.137])
        by smtp.gmail.com with ESMTPSA id 5a478bee46e88-36a42a6f7f9sm13263336eec.25.2026.10.30.19.30.11
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 30 Oct 2026 19:30:11 -0700 (PDT)
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
Subject: [STATUS] stable/linux-5.15.y -
 700e62ea909a70b9f72692d8b7a192ac7ebde0aa
From: KernelCI bot <bot@kernelci.org>
To: kernelci-results@groups.io
Cc: stable@vger.kernel.org
Reply-To: kernelci@lists.linux.dev
Date: Sat, 31 Oct 2026 02:30:11 -0000
Message-ID: <179341381109.70610.6605223594247303631@34406640b1f4>



Hello,

Status summary for stable/linux-5.15.y

Dashboard:
https://d.kernelci.org/c/stable/linux-5.15.y/700e62ea909a70b9f72692d8b7a192ac7ebde0aa/

giturl: https://git.kernel.org/pub/scm/linux/kernel/git/stable/linux.git
branch: linux-5.15.y
commit hash: 700e62ea909a70b9f72692d8b7a192ac7ebde0aa
origin: maestro
test start time: 2026-10-30 12:34:36.912000+00:00

Builds:	   48 ✅    0 ❌    0 ⚠️
Boots: 	   36 ✅    0 ❌    0 ⚠️
Tests: 	 2471 ✅  227 ❌   68 ⚠️

### POSSIBLE REGRESSIONS

  No possible regressions observed.


### FIXED REGRESSIONS

  No fixed regressions observed.


### UNSTABLE TESTS
    
Hardware: qemu-arm64
  > Config: defconfig+netdev+nfs-root-boot+ltp
    - Architecture/compiler: arm64/gcc-15
      - ltp
      last run: https://d.kernelci.org/test/maestro:6ae4aeef6eff83db85cc6528
      history:  > ✅  > ✅  > ❌  > ✅  > ❌  
            


Sent every day if there were changes in the past 24 hours.
Legend: ✅ PASS   ❌ FAIL  ⚠️ INCONCLUSIVE

--
This is an experimental report format. Please send feedback in!
Talk to us at kernelci@lists.linux.dev

Made with love by the KernelCI team - https://kernelci.org
