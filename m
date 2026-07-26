Received: from mail-pl1-f176.google.com (mail-pl1-f176.google.com [209.85.214.176])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 234E41A6809
	for <stable@vger.kernel.org>; Sun, 26 Jul 2026 02:30:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.176
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1785033028; cv=none; b=dcS4+sEYwISVDJOo5ymU1+C57V+va1LzTp3l3q5rocCTErDkO/kTbygkg2JHakfQJkeqZcxMK1IwKC6M8HKsxH34UM7FGdiWMNFR99NWJTxHNUzedfO251CR4ZXzUBNpZGJ/JIa3bFgSPE84oDJ+WCN+0gr8mBFTxu4Iy4+V7Qw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1785033028; c=relaxed/simple;
	bh=QyLMxtkfypfTotWLFYlbEkgz1iQ0zdixNdrfqJpD5Zc=;
	h=Content-Type:MIME-Version:Subject:From:To:Cc:Date:Message-ID; b=fS9HhmwuQjrtXfEky5GQOzuUAemh0I/NMSojRlwe6h5IIkHtIIroisaSmsR+cGfo7TJNrYScK2SjQ/rES4+I0yPtLHytgPgnhT9JROEXLJAwQx1tBy2K9ztUm8y92XjRqXEfY9XmZqJ9YBe3I7/u+KFIoaXGnzsd74e8zon0a/0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=kernelci.org; spf=pass smtp.mailfrom=kernelci.org; dkim=pass (2048-bit key) header.d=kernelci.org header.i=@kernelci.org header.b=fPma47c2; arc=none smtp.client-ip=209.85.214.176
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=kernelci.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=kernelci.org
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernelci.org header.i=@kernelci.org header.b="fPma47c2"
Received: by mail-pl1-f176.google.com with SMTP id d9443c01a7336-2cf6d65d8a7so24878195ad.0
        for <stable@vger.kernel.org>; Sat, 25 Jul 2026 19:30:26 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=kernelci.org; s=google; t=1785033026; x=1785637826; darn=vger.kernel.org;
        h=message-id:date:reply-to:cc:to:from:subject
         :content-transfer-encoding:mime-version:content-type:from:to:cc
         :subject:date:message-id:reply-to:content-type;
        bh=4uhEkXuPBfb7eHgRjPjeCdS/Nrqf/nP68xih9nV6mXM=;
        b=fPma47c2M7MKr439on7yazVCjI1LmY8qg15TVCBd/10UHvwxP78/aCB2Vu4+d2YUL0
         d/JHXUVqAgY+FLzwKOQxbtH/I0Gwvqto2n3RnCEowDGhnhqSdP0R3i0aSCp6aq9N9OYK
         U/IhS1QVYsVEzWbmElIUdcBNXDYupvLROs5a0UUWxB8C+dFu3AMhnAtVQsjPJ22GLexv
         vBVe/yMQEy9Tx6OLtgC26yK1a/jjfdLowDkw7J5OblRp1iPRunvD6ccQjaRmixjSovls
         vLOcOxFILJ0ZOWF8tTvlf79F+G+ktp+D1dj9NsZDUmY7H+ftSgTdrJZMUP8iwVtPkCPW
         B0Rg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1785033026; x=1785637826;
        h=message-id:date:reply-to:cc:to:from:subject
         :content-transfer-encoding:mime-version:content-type:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=4uhEkXuPBfb7eHgRjPjeCdS/Nrqf/nP68xih9nV6mXM=;
        b=gdXUBOUQcdGhyAAOYANzpBFb+crsqlG6pzY3NK4V9//PELdvmaohIQOZmnixyC93Vl
         KsV9GqiGtPQzzZR/KRf9MxHwijpe0Oud7Nu8sQQkn7ZYow8EyphQbHuSg9ayQPom5DIc
         ZLjmCgMTitHN3brU4pCOwfcB3UY840XzM4WBzI/m3NL22BzHl6vUcVwKabQoM8S50rat
         kVfbk09HGwrGkBzflYKYk6ofq0dU7B2fIqx8v946O0j4bFv2LLD3iK/VZsMW6+mUGrBZ
         gKnkQIF4kvEROjEE/LcXeeO7CEAz5FXJD34NMrkij3pQSc8izcsdlLZLdK/jiJEZOYh0
         DbEQ==
X-Gm-Message-State: AOJu0YzvuVooGbXU9W7cFDGSLxYpUIWc+p9lsWxxaq0QZcCMzu9qftMy
	Mlr2wVerPiSl2pIWTGPfKV8YIHYFLdqNfF5ppeshbuyE1Ukln9rxwObsWX50TNuVRLqmComs5ze
	Y8SjL
X-Gm-Gg: AR+sD11t+2ilZQ5ObmVMwwAmbPy2dthvlX/nfwAlZnvI5d8kOHZ+gK/T0bmQmuT8YJL
	DsMD5+N8PM+HhbSsuc9L5MOS6qGzuwDv8rF4dp0oQqS3ayIsMX9YqiUjWTqeHGw2dx56vCtXXNK
	uvEqFukVBVmB8kFMa//P/TlunjA849FEesKRNo7qtjJRD6gHz0pt7eDXvYbpBYr7G1DKY8PbUe1
	1SP1gBfx7Xrfp3kQSzVAg+yIk2kkvIzOlcGgnvoLcwMEZybpfoNo+BfkcodQrf4vNNZhZvD/mG6
	dDsTLSrwjnVX8PkUQCqzGE4e/JiVbNCltmkCuvOK0D4pDDLHwbUx/4VvPi7cMCKdC00foeiy2jj
	bCL8kXbbpVXHvoT/0TrwVgkQO7BXBVeTG6aIgky6op4xIJLlrs45XkvTeYqOoRTaJE57AGjK1xa
	GxnAz5gQ==
X-Received: by 2002:a17:902:e544:b0:2bd:c925:3a16 with SMTP id d9443c01a7336-2cfde796a32mr39880235ad.2.1785033026401;
        Sat, 25 Jul 2026 19:30:26 -0700 (PDT)
Received: from 92650adf53de ([20.38.40.137])
        by smtp.gmail.com with ESMTPSA id 5a478bee46e88-314bc549cacsm15648886eec.16.2026.07.25.19.30.25
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sat, 25 Jul 2026 19:30:25 -0700 (PDT)
Content-Type: text/plain; charset="utf-8"
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Subject: [STATUS] stable/linux-6.12.y -
 588b2d2beb4b3d1878a7fd9cdc876bab53326476
From: KernelCI bot <bot@kernelci.org>
To: kernelci-results@groups.io
Cc: stable@vger.kernel.org
Reply-To: kernelci@lists.linux.dev
Date: Sun, 26 Jul 2026 02:30:25 -0000
Message-ID: <178503302532.1822.18065822045272102751@92650adf53de>



Hello,

Status summary for stable/linux-6.12.y

Dashboard:
https://d.kernelci.org/c/stable/linux-6.12.y/588b2d2beb4b3d1878a7fd9cdc876bab53326476/

giturl: https://git.kernel.org/pub/scm/linux/kernel/git/stable/linux.git
branch: linux-6.12.y
commit hash: 588b2d2beb4b3d1878a7fd9cdc876bab53326476
origin: maestro
test start time: 2026-07-25 06:18:41.304000+00:00

Builds:	   56 ✅    0 ❌    0 ⚠️
Boots: 	   98 ✅    0 ❌    0 ⚠️
Tests: 	13590 ✅ 1175 ❌ 2821 ⚠️

### POSSIBLE REGRESSIONS

  No possible regressions observed.


### FIXED REGRESSIONS
    
Hardware: mt8195-cherry-tomato-r2
  > Config: defconfig+lab-setup+arm64-chromebook+CONFIG_MODULE_COMPRESS=n+CONFIG_MODULE_COMPRESS_NONE=y
    - Architecture/compiler: arm64/gcc-14
      - kernelci_watchdog_reset.wdt-reset.wdt-get-timeout
      last run: https://d.kernelci.org/test/maestro:6a645d9b798ea6c1ef6ea7a0
      history:  > ❌  > ✅  
            


### UNSTABLE TESTS

  No unstable tests observed.


Sent every day if there were changes in the past 24 hours.
Legend: ✅ PASS   ❌ FAIL  ⚠️ INCONCLUSIVE

--
This is an experimental report format. Please send feedback in!
Talk to us at kernelci@lists.linux.dev

Made with love by the KernelCI team - https://kernelci.org
