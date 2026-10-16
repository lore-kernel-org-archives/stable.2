Received: from mail-dy1-f181.google.com (mail-dy1-f181.google.com [74.125.82.181])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id AF060283FD4
	for <stable@vger.kernel.org>; Fri, 16 Oct 2026 02:30:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=74.125.82.181
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1792117842; cv=none; b=SuMsAF96WKF5RVTlV3DNsEyr+VuMMv7QFNVOn3PyGGYdCPX3rdHCuqz1qIid5HaqQO9/v69D1wCDBHlkHxZaNtz0g5bdQq/kysPyX1DCaQeLq6Vgi4CiehLksMp77AUf2VzQQ2yc0N7MOQcqTN8TW6BXcWyT/2nbuoX4VFE0c7Y=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1792117842; c=relaxed/simple;
	bh=MdQbvLuOPr6WAutucNcaDbG6QgegyUBAjYgKGs5jCPY=;
	h=Content-Type:MIME-Version:Subject:From:To:Cc:Date:Message-ID; b=tFZtaQtp/r6DzbCsZ+pgkHJyiZCQbHQmFi2LTcPmRXjxfoAb+ay5oeer93A13F2CAkya8Jf41h/i9XkphIbByBqcj8hgwU+ndMYB8hSgVMN15Nm3rohbRmGsosM3jgPktlI+m9uxKjfPHCYTH/CM0v+GJ3HGYA7XSZ8TYd6whTQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=kernelci.org; spf=pass smtp.mailfrom=kernelci.org; dkim=pass (2048-bit key) header.d=kernelci.org header.i=@kernelci.org header.b=MayTpZuN; arc=none smtp.client-ip=74.125.82.181
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=kernelci.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=kernelci.org
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernelci.org header.i=@kernelci.org header.b="MayTpZuN"
Received: by mail-dy1-f181.google.com with SMTP id 5a478bee46e88-35829219da8so647463eec.0
        for <stable@vger.kernel.org>; Thu, 15 Oct 2026 19:30:41 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=kernelci.org; s=google; t=1792117841; x=1792722641; darn=vger.kernel.org;
        h=message-id:date:reply-to:cc:to:from:subject
         :content-transfer-encoding:mime-version:content-type:from:to:cc
         :subject:date:message-id:reply-to:content-type;
        bh=hhhpbx9/4xxOFUY9dl6g4m9rt8XKsm9h3ppQ/KQAD8Y=;
        b=MayTpZuNOpAzguZmu1FLtV3vxZ3lxlu6dwGtT+HX3IF2Q0CJfjN4tdyWB4l7yusEfr
         KF8roFvdbSLyksLquuAPAqAVV9X9ubc+93LTPGAKcOvdj9WxX8e8v+bf+bn+bglPUyY3
         Rt3k6n9hgFrbh9gX1dk9+iCijEYQRlnj44y+H8sqhIHhYQWIQ6Iqbo5vlPrI9yKuzbIT
         q85M2qEmWUqeaYXCXUl6MgcIG1/stl+0Gzbf4NYXiiG8wk35WEh3CZl21Y188IxvZyHe
         Hq0kT1SUvpQkY8PSLWhwO5D3X1/lIqmeRu0WDbUJtpQZufkhZ4Opnb8NybUS7IDHsx9P
         rSqQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1792117841; x=1792722641;
        h=message-id:date:reply-to:cc:to:from:subject
         :content-transfer-encoding:mime-version:content-type:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=hhhpbx9/4xxOFUY9dl6g4m9rt8XKsm9h3ppQ/KQAD8Y=;
        b=SJcV1r6Bqn/cgr2r1HdDdf9TTVgZBtMQrAe9W1uK8v7ViHT2lfHuYB/AMZBuRPuL3C
         YrZ9U0Ame8nTWpl2R1IranmfQodlqksDpPSCzJECOGrYdy/lsDluQJOQaCmXKApEvdOw
         PrAYqlHvBMkUaCnv+z2kjyhnBngd/6ynDYPGFVTGqjCTyiBJm6MKkKJ3abwRvIGfXkal
         ttU4iLevWnZ2BxVRXR0E+SdA1wzgRP94xWVAvGYn4tMOBgkw2QO0YEA5VAsqnid5mGvx
         NoZ3HBupVJYyy+4WXNtJDZobYMKkFRRh+Am6SKSEDKoCP3jREKdbDhnmSwTj4LSUrAWL
         kk+A==
X-Gm-Message-State: AFq9FYIHWEaRquTNuAFdZQJPfQ3SN6Uow6Ll0vDtiMnaD+dUSL48hlo+
	GUmFRLf+M/lvp+dlQ60x4dmaakt/CbW7WXxEI4yHT1ZFrm5XrfJMRmlbn0pbPwigbUPFnqMYy1C
	qw4Wl
X-Gm-Gg: AYBFou2CKhTpz6MzOxxxUhG3ppfsgcx+HpSMvY09cXgxTCIs6rHlcO00UXw283suA6q
	5qSKYMkaHcvo4wPhpi1vkH3brosvKqppKasvD2oRFvXSrxO8O55oiIPN6Cbq37bPODT2jSAZi4O
	zJm7vFfTWgRfyyB8qTr2c42njSMadvxtbg6b1WJGtYMCZxsMhfWxWf3LZYfyPfmUdJ6NLw1wSUn
	tL0G319KFZFekUZvr1k0MtoZ1SKqRwwyFpo7TfEvldwIsivHSO1srovEkjmdgk1rCE0yLEgKbc/
	vleISKd9Vk3q3phTxkdFAcRs4Vkwts0Co3eMA9Mb3wGMVHhphwyzgeEIdiRELFd375p56PpeYZz
	VFUbS5WQfVs+iqk71XANQGsQ2BMQMok3LKdyphpD05N1I4WsT83p9Lt9evfwtDF5H4UG1KO3g+W
	pCO0U5DMedGktt7U/PfFaYg95daUvkOGKqCeu9wvTOBFE33KDX1sj4F1tYW6GcHW4=
X-Received: by 2002:a05:7022:f9c:b0:166:fc9a:11b3 with SMTP id a92af1059eb24-1825856b60cmr2980317c88.12.1792117840445;
        Thu, 15 Oct 2026 19:30:40 -0700 (PDT)
Received: from 244668f92ec4 ([20.38.40.137])
        by smtp.gmail.com with ESMTPSA id a92af1059eb24-18314ef8ed8sm1433764c88.3.2026.10.15.19.30.39
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 15 Oct 2026 19:30:39 -0700 (PDT)
Content-Type: text/plain; charset="utf-8"
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Subject: [STATUS] stable/linux-6.6.y -
 cecd39af8a1ab81373fd9fa765b2f7ab73becaad
From: KernelCI bot <bot@kernelci.org>
To: kernelci-results@groups.io
Cc: stable@vger.kernel.org
Reply-To: kernelci@lists.linux.dev
Date: Fri, 16 Oct 2026 02:30:39 -0000
Message-ID: <179211783906.391248.13089973609176471260@244668f92ec4>



Hello,

Status summary for stable/linux-6.6.y

Dashboard:
https://d.kernelci.org/c/stable/linux-6.6.y/cecd39af8a1ab81373fd9fa765b2f7ab73becaad/

giturl: https://git.kernel.org/pub/scm/linux/kernel/git/stable/linux.git
branch: linux-6.6.y
commit hash: cecd39af8a1ab81373fd9fa765b2f7ab73becaad
origin: maestro
test start time: 2026-10-15 13:13:48.777000+00:00

Builds:	   54 ✅    0 ❌    0 ⚠️
Boots: 	   80 ✅    0 ❌    0 ⚠️
Tests: 	 9129 ✅ 1238 ❌ 1361 ⚠️

### POSSIBLE REGRESSIONS

  No possible regressions observed.


### FIXED REGRESSIONS

  No fixed regressions observed.


### UNSTABLE TESTS
    
Hardware: qemu-arm64
  > Config: defconfig+netdev+nfs-root-boot+ltp
    - Architecture/compiler: arm64/gcc-15
      - ltp
      last run: https://d.kernelci.org/test/maestro:6ad0f149a3f195e1aa8b10a5
      history:  > ✅  > ✅  > ❌  > ✅  > ❌  
            


Sent every day if there were changes in the past 24 hours.
Legend: ✅ PASS   ❌ FAIL  ⚠️ INCONCLUSIVE

--
This is an experimental report format. Please send feedback in!
Talk to us at kernelci@lists.linux.dev

Made with love by the KernelCI team - https://kernelci.org
