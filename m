Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=74.125.82.47
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1795487455;
	b=AsnfbXwkuw5WmMDMZsjoKmzzgQiQ1+4FoNWUHi4Q/5NJLH6iAuDNfCclvUHKWh6Hcfiq
	 XGdsVw1lC0pYPHacITVE/l9lr4ibiaZEb7ldfSidEg6FtOgXczpLX9I9wZOVPz2p8Xl63
	 WjOTBoSUYfN0GMeNXBEK+AAdDTYiImh7B68hHi3PQ+TwTbL7ikZwuomd2r4YbZ12T0rT8
	 zvwBR2BiFLe6hIlnGjnV6LgqeX4gF3IJB+DJr6BWsdli3oZPkM7TLMz/NPbYH5XQIfNA1
	 S3Lz1SS9Lhmd2FccyiAXOzMgtJHy1Udop1GNDNSQmeCyYSaoKGDeROfF2M4DtuLmexA==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1795487455;
	h=DMARC-Filter:Received:DKIM-Signature:X-Google-DKIM-Signature:
	 X-Gm-Message-State:X-Gm-Gg:X-Received:Received:Content-Type:
	 MIME-Version:Content-Transfer-Encoding:Subject:From:To:Cc:Reply-To:
	 Date:Message-ID;
	bh=9yZMeK8ILbEGS7w4Bl6DNaIt/+VWz7cPdqWUCUq87jw=;
	b=myISlKR+OhS75pbI6JmkWz+j3yJUUXUXO2T22SMv6GF/XPkg+Cy4Szk/B5JpMu5OX+to
	 3rSxgr1wuJyEduKVkVq92YxZmHk2o9yo+jicP1TAtQwmyY8piCo9lfL1iiP0oNVp+08m/
	 CwzuVrxSseOWDUqz6wRug8RfmdLBJSSgamJ1Tquy3FCs5j7/r3pZogcuVY3J7pLrEAzYg
	 H6AUcwQ+FpmOJvB1JjzHOyGPmKFP684HQhd+JqdjiKNa7jQgudwyzjH5kJpdPD+S3JvLr
	 n0kL7OtBqG4Y6kgwUT2xyPR+QJJiP/fI6q7HBmEPikAjh2oR0T9c4fWVOXHUJjevrUQ==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=kernelci.org;
	spf=pass smtp.mailfrom=kernelci.org;
	dkim=pass header.d=kernelci.org header.i=@kernelci.org header.a=rsa-sha256 header.s=google header.b=DRkLWopr;
	arc=none smtp.remote-ip=74.125.82.47
Received: from mail-dl1-f47.google.com (mail-dl1-f47.google.com [74.125.82.47])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0F0C1606A31E
	for <stable@vger.kernel.org>; Tue, 24 Nov 2026 02:30:54 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 0F0C1606A31E
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=kernelci.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=kernelci.org
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernelci.org header.i=@kernelci.org header.a=rsa-sha256 header.s=google header.b=DRkLWopr
Received: by mail-dl1-f47.google.com with SMTP id a92af1059eb24-170135e43c7so5729899c88.0
        for <stable@vger.kernel.org>; Mon, 23 Nov 2026 18:30:54 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=kernelci.org; s=google; t=1795487454; x=1796092254; darn=vger.kernel.org;
        h=message-id:date:reply-to:cc:to:from:subject
         :content-transfer-encoding:mime-version:content-type:from:to:cc
         :subject:date:message-id:reply-to:content-type;
        bh=9yZMeK8ILbEGS7w4Bl6DNaIt/+VWz7cPdqWUCUq87jw=;
        b=DRkLWoprTRad+hODIj18JUVPAQ3lHixleGXSVjx0+5HLcvZLmujhuTFe4ukVS6b9+p
         Uhv9Jfrk9FeTs8fR2mEtSNbjxR27FNs8FZMZFjnP3lCa4w365XmUnxTJUtOzSaXZogzV
         OH1b+JFo5rMMuI/QbIE1jxSpsxADEErTGcxHS4pycki4015s2BQ1MGn+eofkzVCWBsgD
         2IJp+zLsTC2pdXRHZVPC+qAQ/zHVcqJinxd7BIb5BNHsfFxAS8yBWN27w25bPKnvMUGj
         KZ7ONhy8C1EASjHFKHkWCaZsnRsp60Nj5GkYm/EO4J/WCXT8aW3IzXer6dci+L29ZGOQ
         N6zg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1795487454; x=1796092254;
        h=message-id:date:reply-to:cc:to:from:subject
         :content-transfer-encoding:mime-version:content-type:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=9yZMeK8ILbEGS7w4Bl6DNaIt/+VWz7cPdqWUCUq87jw=;
        b=azQWJXoHCyU2kJiSQU1nkQa/hqwHqH0ABWFBW0yCNzCrcM0va6zz64OMIU0wdZM3oc
         hoxqXXFiC4V7z9/w3Bd6nHnsZVq56jhPqSB0jzW/o4bfKfN+O6zWt6D6T79pS6CpcxV8
         qK4y7u75qont+3fmabCN4LNTbfpVD6j6V9oT+DVzVOrMu43BadkkUPS1EkUce2b3lw2W
         g8zRuq6BxDOEGOo6qnlYJ486ZPuJkSZT7I1l6c178IWNJy0sx6c75asbddUOatYq9S+p
         pq685A7ITLGQ7rIfm4m0M83cUkO9wUPk9Aks1W1Ch4rbeT6z2HEtcuo1yAR7R/t4vTyM
         RguA==
X-Gm-Message-State: APuU4Z+m1qTn7juTlLq+CVDZLxYOxZWCZmm9SzwPoL0ENqaifMiLAFXb
	kA0ATCQX+jjYHuZizp3hM/VcXAx0VpOpVPo8tvqs4kiGaDq11lL4RJqvQHGQihRzBe8=
X-Gm-Gg: AZFdTZcOwq4LBaLKOXz9s9bjIsPKrjw/9Eo55uKgqaMTbNfOyQMrd85EUedp4CY/Dna
	Q2GLCaUN4LS8Y7C6znq0LXAp99ikIO8Ksp7I+vpMYbIyYYtYqwbb/BGw9KfrAZnLhiBIrwGr/3T
	Xz6Ab2fcFeMJ9yN8Tau0jNmFKUiCVLtn2cAyLhUTyFpduub35+55Z7IddileFgzESdUkeLzgaAW
	9sDRczE1w427lQx25aADCcgbUy3OeHGgBhfeD4VnzKbHQG0AwilN9XivJrjrXltRBZVrpm93Np6
	sAdK5HENWQRGunIbTMCc+5MLR14q4cGWiiY0hpV73ynE0zgxroffWA2345Juc3dqDOzTevFWR/L
	ahLXZMkK3r6+sE8Uvu085f6rryiIee4xDojBXdpyV2DBEdmy/56xYK0FuVDhWtkKknEI6f11nLo
	+NER0OGjXQ8yNu/yhqbgD2Pju3d/++qm1g+yk/xcr1Nb3No1TSFKll1smAaLfwNqLfUXIxnff3T
	wbjIb5ppDoPw5E1yNi1FyVK/qI6oVo5ZUzVudqyHk2IxH8Zz40oPKZNFYPltSrsZ+CW83SWCXXY
	BGwbjwUSJNl8Eg2YRNnH7w==
X-Received: by 2002:a05:7022:150e:b0:1ac:9da7:e881 with SMTP id a92af1059eb24-1b55690bc2fmr15124756c88.36.1795487454040;
        Mon, 23 Nov 2026 18:30:54 -0800 (PST)
Received: from 52d83ede7c60 ([20.38.40.137])
        by smtp.gmail.com with ESMTPSA id 5a478bee46e88-38567abb870sm33551957eec.25.2026.11.23.18.30.53
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 23 Nov 2026 18:30:53 -0800 (PST)
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
 e2e4b92c2b2a3ae78423cb343951cb5d2241b405
From: KernelCI bot <bot@kernelci.org>
To: kernelci-results@groups.io
Cc: stable@vger.kernel.org
Reply-To: kernelci@lists.linux.dev
Date: Tue, 24 Nov 2026 02:30:53 -0000
Message-ID: <179548745321.20463.6640842739553570028@52d83ede7c60>



Hello,

Status summary for stable/linux-6.12.y

Dashboard:
https://d.kernelci.org/c/stable/linux-6.12.y/e2e4b92c2b2a3ae78423cb343951cb5d2241b405/

giturl: https://git.kernel.org/pub/scm/linux/kernel/git/stable/linux.git
branch: linux-6.12.y
commit hash: e2e4b92c2b2a3ae78423cb343951cb5d2241b405
origin: maestro
test start time: 2026-11-23 08:27:20.087000+00:00

Builds:	   59 ✅    0 ❌    0 ⚠️
Boots: 	  109 ✅    0 ❌    0 ⚠️
Tests: 	11722 ✅  656 ❌ 1244 ⚠️

### POSSIBLE REGRESSIONS
    
Hardware: mt8195-cherry-tomato-r2
  > Config: defconfig+lab-setup+arm64-chromebook+CONFIG_MODULE_COMPRESS=n+CONFIG_MODULE_COMPRESS_NONE=y
    - Architecture/compiler: arm64/gcc-14
      - kernelci_watchdog_reset.wdt-reset.wdt-get-timeout
      last run: https://d.kernelci.org/test/maestro:6b042b8e99c74e1a99b3ae61
      history:  > ✅  > ❌  
            


### FIXED REGRESSIONS
    
Hardware: acer-cp514-2h-1160g7-volteer
  > Config: x86_64_defconfig+lab-setup+x86-board+kselftest
    - Architecture/compiler: x86_64/gcc-14
      - kernelci_wifi_basic
      last run: https://d.kernelci.org/test/maestro:6b040ae899c74e1a99b2b97f
      history:  > ❌  > ✅  
            
Hardware: mt8183-kukui-jacuzzi-juniper-sku16
  > Config: defconfig+lab-setup+arm64-chromebook+CONFIG_MODULE_COMPRESS=n+CONFIG_MODULE_COMPRESS_NONE=y
    - Architecture/compiler: arm64/gcc-14
      - kernelci_watchdog_reset.wdt-reset.wdt-trigger-reset
      last run: https://d.kernelci.org/test/maestro:6b042c9b99c74e1a99b3b3e5
      history:  > ❌  > ✅  
            


### UNSTABLE TESTS
    
Hardware: qemu-arm64
  > Config: defconfig+netdev+nfs-root-boot+ltp+crypto+ima
    - Architecture/compiler: arm64/gcc-15
      - ltp
      last run: https://d.kernelci.org/test/maestro:6b04349999c74e1a99b461a8
      history:  > ✅  > ✅  > ❌  > ✅  > ❌  
            


Sent every day if there were changes in the past 24 hours.
Legend: ✅ PASS   ❌ FAIL  ⚠️ INCONCLUSIVE

--
This is an experimental report format. Please send feedback in!
Talk to us at kernelci@lists.linux.dev

Made with love by the KernelCI team - https://kernelci.org
