Received: from mail-pj1-f48.google.com (mail-pj1-f48.google.com [209.85.216.48])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4B0C8448393
	for <stable@vger.kernel.org>; Thu, 20 Aug 2026 15:59:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.216.48
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1787241548; cv=none; b=QmsRPrPyT0z8YT5jZrbKvvEMQBzS6jSs219kUFzwMbtWzYT/CNC0/nArT8QQvsLUne5Az2xM5oqXgB6QO2B/ArMhkzX12kXJX6XgM03kD2um5HtZGstZa16iNZECYp6USVpRxm84M7XrXM8FiA5VTVOEGKKyjBNH8pppTgWwQ1s=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1787241548; c=relaxed/simple;
	bh=fuC/BeCIMrtNL0H133v20x3EVLKpf5VsRfu38kDtbSw=;
	h=Content-Type:MIME-Version:Subject:From:To:Cc:Date:Message-ID; b=Ffe7Ui2jBcbfF0lfnJUIFU8aK634TdyIIc6g5oaefbVTYUhinV1q8DueLW/wiA46S3IEqZMh6cGWuXLOMXUm9dbnQr2Ui0O966R9wRdB5W6XC4ccCUb9n3q8dz6KNvqCRsy8j5nk+i5F3cxXENy/ukZeqZqIPEhQQhWkSFdeAIU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=kernelci.org; spf=pass smtp.mailfrom=kernelci.org; dkim=pass (2048-bit key) header.d=kernelci.org header.i=@kernelci.org header.b=eCMGTZqO; arc=none smtp.client-ip=209.85.216.48
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=kernelci.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=kernelci.org
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernelci.org header.i=@kernelci.org header.b="eCMGTZqO"
Received: by mail-pj1-f48.google.com with SMTP id 98e67ed59e1d1-38ea87caafeso1980381a91.3
        for <stable@vger.kernel.org>; Thu, 20 Aug 2026 08:59:06 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=kernelci.org; s=google; t=1787241545; x=1787846345; darn=vger.kernel.org;
        h=message-id:date:reply-to:cc:to:from:subject
         :content-transfer-encoding:mime-version:content-type:from:to:cc
         :subject:date:message-id:reply-to:content-type;
        bh=gkuFqYOzmY8e7XXKWPF0rhPCgH+DlZeF7LWca9ZD7sQ=;
        b=eCMGTZqO5Uzt4kngdzth8ERCEDnKCpTY3Q+2SJudFB2H4PCRt9hdTNC7A8S6MhCTaA
         1xOa6UdB4LzZoMHjFLM5OuhPVrKgOHDXsbYPxwoEP+fJk5P/ZzIdAx3RZsFWbjeVL8vB
         uSWdpE1WdW7TfWOHDoGAWuD8ghCwFv8Y5qRcHkDGUiZlhdGiurpgdZzl5dhpFo/onC4B
         ko3LAV1t2zC09aC7R/qOQ9MDr6LD26QFnIrrXanFRCeilrAspyu1FJ7C+nMiPivM9V86
         wpGp8QtBmYAFJld0kHwy1ck8T64QsUI6tCmu950fjUPil8CW1MXMx0D6Wla9hyQ7tITL
         0STg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1787241545; x=1787846345;
        h=message-id:date:reply-to:cc:to:from:subject
         :content-transfer-encoding:mime-version:content-type:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=gkuFqYOzmY8e7XXKWPF0rhPCgH+DlZeF7LWca9ZD7sQ=;
        b=pmqFtsttmV6Ae/jiUOpnqoVJouS5NpqW+M7kCOa5VKAdOSvApQ1srpJkP63aqSI5U4
         MXkHt+J2STwl0jqVtDqT0O0i1jqnxPQ5EjTRvylGt3i7VcPBPt9dDUy7KoaoyIeMsTJ1
         V4rKeP/T4nnhtpLQf5ui6R/QZrV/LYIRpx6WBMXQLK24qyYxCKntw0zeDFXhRni2lKKT
         7bndlDRJpDMOXFDHgEyEklkzc3m7ygfpuZ84Ur8KDn6c/8FXxTyoLldIgY+yNoI3Xv6E
         +gOYWX8hIi4dRma506TQfJ8pwkcg1vRsDFVj44B455oiDWckVRUh+Ec/xMPaT785E+Se
         zliw==
X-Gm-Message-State: AFuF++mci94g5/RgC+q4CQ4sdCZj+FCK4lWGUxzoudx9/lhNXld10NMA
	WFau6m68kZGM3xCwF02qCxPCC5D44BQtXxWgp35ThiEpWzZU24g2jtlDEoV9Y5h1ujEF1uGfsxq
	t3V6z
X-Gm-Gg: AR+sD11IbUfXXmm1U8lOKHFaKUPNX14GL6G7ktU/iGeMYiDB4A/ZKd5CYWh27sYhQwH
	wgILRt99L6c/aUOPSIcuzXVMSeN7JLFA0YbGSAouGXhZXI+KLZJezsWueXawadTiVObUrxNm6OK
	mil08MLfASU3oc0rKutzK5SbinrWs+2YatR/55rK0Tdg/BgYhN5P+OvDL0pqxuw7lQwO3yvJCKT
	QUNqFe+MWbsc9Do0nWHruEWnkxHRLt31QMg1sEh1pLPTH5h02I6njATkDxmQQjW4z4YXTkOskTI
	y+R4VroHTVVFj9WAyB6iaYLyXyZyJG0ht+30n/ggNn2M6AAeXKzowFLmPXhAjBS6pfH3Enc+E4R
	Qv9zfni8+lbpG/fdZMAdrNgUpr3Q4cI6H8aW0gbPmjjG2aCuK/WNGpJa3dY/rtlaVH7Z/GQcFbN
	qb+jynhFqWyl1IOof3y+Un/PwyqFv8qOaX8jqqy6CEVw4oxVBSIr4Q
X-Received: by 2002:a17:90b:4c8d:b0:38e:ad9d:1151 with SMTP id 98e67ed59e1d1-39580a4c6aamr25354686a91.4.1787241545425;
        Thu, 20 Aug 2026 08:59:05 -0700 (PDT)
Received: from b455de3d9de8 ([20.38.40.137])
        by smtp.gmail.com with ESMTPSA id 5a478bee46e88-327bef3bb51sm19242743eec.6.2026.08.20.08.59.04
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 20 Aug 2026 08:59:04 -0700 (PDT)
Content-Type: text/plain; charset="utf-8"
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Subject: 
 =?utf-8?b?W1JFR1JFU1NJT05dIHN0YWJsZS1yYy9saW51eC02LjEueTogKGJ1aWxkKSDigJhz?=
 =?utf-8?b?dHJ1Y3QgYXRtZWxfbWNp4oCZIGhhcyBubyBtZW1iZXIgbmFtZWQg4oCYYmhfd29y?=
 =?utf-8?b?a+KAmSBpbiBkcml2ZXJzL21tYy9oby4uLg==?=
From: KernelCI bot <bot@kernelci.org>
To: kernelci-results@groups.io
Cc: stable@vger.kernel.org
Reply-To: kernelci@lists.linux.dev
Date: Thu, 20 Aug 2026 15:59:04 -0000
Message-ID: <178724154356.746.9503810646226485557@kernelci.org>

New build issue found on stable-rc/linux-6.1.y:

---
 ‘struct atmel_mci’ has no member named ‘bh_work’ in drivers/mmc/host/atmel-mci.o (drivers/mmc/host/atmel-mci.c) [logspec:kbuild,kbuild.compiler.error]
---

Log excerpt:
=====================================================
/tmp/kci/linux/drivers/mmc/host/atmel-mci.c:2631:31: error: ‘struct atmel_mci’ has no member named ‘bh_work’
 2631 |         cancel_work_sync(&host->bh_work);
      |                               ^~

=====================================================

When fixing this issue, please attribute this report according to the
patch submission rules:

Reported-by: kernelci.org bot <bot@kernelci.org>

For complete logs and details about the environment used, see the issue
on the KernelCI dashboard:

- dashboard: https://d.kernelci.org/i/maestro:e71bd58b6ee40a7cc9a9d2196cd640d7fc593702
- giturl: https://git.kernel.org/pub/scm/linux/kernel/git/stable/linux-stable-rc.git
- commit HEAD:  1869cbab73f5b53b4fc159de6cd5e4384d5bcaec

# Builds where the incident occurred:

## multi_v5_defconfig on (arm):
- compiler: gcc-14
- config: None
- dashboard: https://d.kernelci.org/build/maestro:6a871ef462f33761c0f1072a

## multi_v7_defconfig on (arm):
- compiler: gcc-14
- config: None
- dashboard: https://d.kernelci.org/build/maestro:6a871ef862f33761c0f1072f

#kernelci issue maestro:e71bd58b6ee40a7cc9a9d2196cd640d7fc593702

--
This is an experimental report format. Please send feedback in!
Talk to us at kernelci@lists.linux.dev

Made with love by the KernelCI team - https://kernelci.org
