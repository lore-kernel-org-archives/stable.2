Received: from mail-pl1-f170.google.com (mail-pl1-f170.google.com [209.85.214.170])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 29E10370D5A
	for <stable@vger.kernel.org>; Mon, 24 Aug 2026 02:30:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.170
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1787538642; cv=none; b=Sw3Rhm1BBgbnIJYgRoCe0Qd+7ddAUNWC5h00az/q0LLM8Kvx/EhTPteSJMndSsM9H1lWc8nFZuPLiIXJgsWdTVMcwCcjrrBHZQ0tfn43lc3PHnuaEWUfT4bL1Etx9lhgoHalBjMwSqzMlRr4VTHO1fudMEEesRJ7QwO/55Z85yc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1787538642; c=relaxed/simple;
	bh=KHhJE/rAW9rtHo2LQzheerjsdwx/iXVAt907sfX/0tw=;
	h=Content-Type:MIME-Version:Subject:From:To:Cc:Date:Message-ID; b=YbrrecfWtPymjw4eobxqIhCrlTJo5DY6r0Wq07wdGOFprAkkdiiu8UgSdDXauOUx8enoHtM/tm/N4qmMKRcenjWMtlb4LCggP5aDCe0/1XU3s6sUA9urN0PIWVQRI4h16tmL3HlbrMwakfMeYPt0gOxTKl2gLjI81Cthx5Rriuw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=kernelci.org; spf=pass smtp.mailfrom=kernelci.org; dkim=pass (2048-bit key) header.d=kernelci.org header.i=@kernelci.org header.b=AD9CioId; arc=none smtp.client-ip=209.85.214.170
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=kernelci.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=kernelci.org
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernelci.org header.i=@kernelci.org header.b="AD9CioId"
Received: by mail-pl1-f170.google.com with SMTP id d9443c01a7336-2ce98cb8165so27805495ad.1
        for <stable@vger.kernel.org>; Sun, 23 Aug 2026 19:30:38 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=kernelci.org; s=google; t=1787538637; x=1788143437; darn=vger.kernel.org;
        h=message-id:date:reply-to:cc:to:from:subject
         :content-transfer-encoding:mime-version:content-type:from:to:cc
         :subject:date:message-id:reply-to:content-type;
        bh=MHzy1UOK6Fif463AtRJbfZop0Pp9NadA4R3DGh9O4VA=;
        b=AD9CioId+Sio5Z5SMzEG9VAt+Jwh6UQGn5PpNHorofYq7PrLT8JN2sBUumhQ9w9acD
         qOMjvN1hZL5Z+/jzL5xnW+aVNxzKwLMf3Wc63K9KmleldxDAhQAEQblNr4pULW7ERiAs
         Irp5Wge6QB/ocLXgfjAHoOOA9ULE74xPYcwvasOSeScjKXEwW2zFhvUYYoD064HNW7Fm
         1zmAnNP5ETxGOMzWZi703cLcMeWIwu/MVJbFw/pjvS4Hzw8Ij2UxfY3M/j9Tp5ATGqrx
         n1tpQaKbSqXDMowwLaasNDAbq5UhU/GG0YPtV/jNu/UMIiaGh91dD6CqDcW1C0x6hJp+
         xG5A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1787538637; x=1788143437;
        h=message-id:date:reply-to:cc:to:from:subject
         :content-transfer-encoding:mime-version:content-type:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=MHzy1UOK6Fif463AtRJbfZop0Pp9NadA4R3DGh9O4VA=;
        b=YcaggG7l1+3e3KrIoL5xwsZ54JHElLkn+N5B17LuwdAZ0hyj8dhrTbQ3uTm/LYMR0C
         PlNgr9dxlbjPQwECw6wT3wNS+9amVqDhiALx2gSt0g3DIGuLfsg4CcdCWmFvwiM8X96Y
         SkP3g6n/TZcDCXBp22V+NaqbbVBMMj0o/f/f+RkNrDARnL/GX/C8iwEmyEKc8+ofzyEQ
         4OtJunAwSiVEUTbY4Hq4F7mipmuCUS0/bbBebMRYrkxlZSoCibmcFjwv3Ov1wSU+1ZyF
         fMqoUDN3UjRHPDW/WP5MNGYhmaldqJYZ5XN4t1UbzG6wqBIj5SeTzQb4yAGAPbwCgJWY
         WqhQ==
X-Gm-Message-State: AFuF++kpycYRcQ4KQSM6DdNSXmdAuY0AaxH6UNvEZm+BqGYxTwETqSMO
	5wJse5AKs4X4FizqK9RgAGqhIjY8cX9qnwOwVRX+c+Bs9l1wVesxQXWHG+jiqeUCvNA=
X-Gm-Gg: AR+sD12CpiA/Zwyb1B6cX8FnpvM15upQFn/eRY139cRu4pNaOdBgXr4+vrixNIxXNg6
	DNeeZItkf/XuV17er8dAFw8fVqPfUWsjHcnQw3ArJ7V82wucPlFzF6/eT8jrDR5ZHDGNoetVXfK
	/wFdhPKJOVOPAhvV9ClYREYqc03qAuE6hGnNPHLW4kxkipuJ1BXmkO0Bu3gdr8O47XMK6v8VXcR
	bg3Lreue/qdSelKHF5lYy35LcC+X2cfMzUwMfr5qr2YCk4R/Pe2CRTY7DcZrbY2DnUy4b3O366b
	vRdC3c/tZE7HLGKCgnCIo7bsL9qxlVowBNYePAivxHiIh461RDAk8JeC6/Nn3Uakr0HRTU2LCHh
	GTM4aUHf7vfbV6R+j1eh0/pB5DJ2RE5tSHxmQTBvRpXSNqgiIGVJaw63r6bnMGGAS0HPAQIiSbJ
	hh8qPp4CeDeqgPvEXRB7SJOXyBuPn+C0ihKhFPmg1zPNE8A4dt7+9n
X-Received: by 2002:a17:903:388c:b0:2cc:db7a:251 with SMTP id d9443c01a7336-2d61a033188mr341267665ad.2.1787538636735;
        Sun, 23 Aug 2026 19:30:36 -0700 (PDT)
Received: from b455de3d9de8 ([20.38.40.137])
        by smtp.gmail.com with ESMTPSA id 5a478bee46e88-32801d7f812sm16990500eec.1.2026.08.23.19.30.35
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 23 Aug 2026 19:30:35 -0700 (PDT)
Content-Type: text/plain; charset="utf-8"
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Subject: [STATUS] stable/linux-5.15.y -
 945fa863f02cf8b1638546907f72dd0fc4d6ba85
From: KernelCI bot <bot@kernelci.org>
To: kernelci-results@groups.io
Cc: stable@vger.kernel.org
Reply-To: kernelci@lists.linux.dev
Date: Mon, 24 Aug 2026 02:30:35 -0000
Message-ID: <178753863525.2405.17058401600949268698@b455de3d9de8>



Hello,

Status summary for stable/linux-5.15.y

Dashboard:
https://d.kernelci.org/c/stable/linux-5.15.y/945fa863f02cf8b1638546907f72dd0fc4d6ba85/

giturl: https://git.kernel.org/pub/scm/linux/kernel/git/stable/linux.git
branch: linux-5.15.y
commit hash: 945fa863f02cf8b1638546907f72dd0fc4d6ba85
origin: maestro
test start time: 2026-08-23 12:29:44.839000+00:00

Builds:	   49 ✅    1 ❌    0 ⚠️
Boots: 	   37 ✅    0 ❌    0 ⚠️
Tests: 	 2729 ✅  503 ❌  330 ⚠️

### POSSIBLE REGRESSIONS

  No possible regressions observed.


### FIXED REGRESSIONS

  No fixed regressions observed.


### UNSTABLE TESTS
    
Hardware: qemu-arm64
  > Config: defconfig+netdev+nfs-root-boot+kselftest
    - Architecture/compiler: arm64/gcc-15
      - ltp
      last run: https://d.kernelci.org/test/maestro:6a8aede962f33761c0054ff4
      history:  > ✅  > ❌  > ✅  > ✅  > ✅  
            



This branch has 1 pre-existing build issues. See details in the dashboard.

Sent every day if there were changes in the past 24 hours.
Legend: ✅ PASS   ❌ FAIL  ⚠️ INCONCLUSIVE

--
This is an experimental report format. Please send feedback in!
Talk to us at kernelci@lists.linux.dev

Made with love by the KernelCI team - https://kernelci.org
