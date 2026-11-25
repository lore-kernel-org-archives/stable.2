Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=74.125.82.175
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1795618756;
	b=dhzutlWUFhcgBDph5NTftWz+mglKHXfjTPJ9tn65jgt5N3uEmrHl7vFBQZv2ACXHVUys
	 XCaP4yuqkbIF9zx9hCaVHAaonxlFHnCQqf6LUECIB7Wj+M/daio4w44qOphLmvkVjgZ2Z
	 PNNW7NMS5+1h45ly4cEXFzWARSSMMDwHPSo+vBtUm3BpspAd86h/gpcLtYSek9mOlQis6
	 FuxhDrU2Vvdq0yt1jKA9vtpeaIO/BS8EWf72RdhyNIL8fBukxqfim7izhcYQVGa9+SvXx
	 /C8NkrMHLIXMEqNQwnEKBSbmYunvKilS0Fn3fbzslFsgNFrs49ggdvQEhqJADu/Fe7w==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1795618756;
	h=DMARC-Filter:Received:DKIM-Signature:X-Google-DKIM-Signature:
	 X-Gm-Message-State:X-Gm-Gg:X-Received:Received:Content-Type:
	 MIME-Version:Content-Transfer-Encoding:Subject:From:To:Cc:Reply-To:
	 Date:Message-ID;
	bh=90577dlOQWfcPQfaT2gP/wBnxaxPlvqW8G2o69d3RZw=;
	b=ULm4WUKPiZurc6ncDKN/eGNgCo//PXmeXY8YcVnz1zld8MRS7oiBKF6lF/j3PMlvI/ih
	 T3X38o3J2twYCnEfGAydKKMTvPTNda9d4vwcFtpgPQIHrbtw62RdDr0jbf5eW7UqPQutp
	 10S3HI8VOWJr9oY1F7rsVKF71hhsT+ApIKlxpEoeOcamFr9N3Azp66nrruI2ws6ntk68d
	 CpfrLL+sKKbNPMDH1sygx269MR8DKcJT24eP6pyzmnK6tYJDxiyu41o238UR/OmuFOctf
	 MU2LOyuTkuWSpkFsJeCgoPBIekPAiRY1onmBHAlnA1SAvNqX762b2pIFfMpLYC6sI6Q==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=kernelci.org;
	spf=pass smtp.mailfrom=kernelci.org;
	dkim=pass header.d=kernelci.org header.i=@kernelci.org header.a=rsa-sha256 header.s=google header.b=LiLhWYa6;
	arc=none smtp.remote-ip=74.125.82.175
Received: from mail-dy1-f175.google.com (mail-dy1-f175.google.com [74.125.82.175])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B7B54606A32A
	for <stable@vger.kernel.org>; Wed, 25 Nov 2026 14:59:15 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org B7B54606A32A
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=kernelci.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=kernelci.org
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernelci.org header.i=@kernelci.org header.a=rsa-sha256 header.s=google header.b=LiLhWYa6
Received: by mail-dy1-f175.google.com with SMTP id 5a478bee46e88-38699cf08dfso6945084eec.1
        for <stable@vger.kernel.org>; Wed, 25 Nov 2026 06:59:15 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=kernelci.org; s=google; t=1795618755; x=1796223555; darn=vger.kernel.org;
        h=message-id:date:reply-to:cc:to:from:subject
         :content-transfer-encoding:mime-version:content-type:from:to:cc
         :subject:date:message-id:reply-to:content-type;
        bh=90577dlOQWfcPQfaT2gP/wBnxaxPlvqW8G2o69d3RZw=;
        b=LiLhWYa6hJZI6+x2R0a0kHb8qwQ7rBPYEpTEMgSRTCH9n0EjprLBn7D8jrBnzJen7Y
         q9TrrQxuOAvXvXJ41ddPzdeWKA10MgQnHw8b2ib4EY1ncLxzptrz2H8I/M6KYR729ePR
         Zlm/ABblE95yfvVdR0qD88TdtiOuKUiCzS8dCkgIGhS4OGwpt+BuGopRfnRY9XvIjeE1
         XfoMylsAz6RMsUTMyRFpXFNcDiZ+8AY7X77gMsmLMQyRCRMYhLNv1PxS6hjvNAsPNn/n
         /bn4OeoQLaxatZJYgJgwd1Ch+OKetIi9LNuGNpelhXt3aw9Oj6BvnbOIl5xBLvmNFIy3
         ZqGw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1795618755; x=1796223555;
        h=message-id:date:reply-to:cc:to:from:subject
         :content-transfer-encoding:mime-version:content-type:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=90577dlOQWfcPQfaT2gP/wBnxaxPlvqW8G2o69d3RZw=;
        b=aO6xz4hZ4qblvvT7RxVSYB/nsze1cvyLm34sqeG9lRSK8qWEn97PCpUa8zdeO+3cgH
         ylgyK//P5PYHd836uY6ncBmmN+OsgaYP14b530K+800CXm+K4ZfJZ26KwkI38a4UM+g9
         a5JIOYDSuXYHf4Lu8Lg+aP49jgbZrhDz5GfjNAruJMnQEDpr0FE5clhZ6UqhgZterEYI
         1nQ8fQHkiQkQQ5RDD76u9YgAqKG7PPl9Rzb60bpEeL5Por79zgLKAwruKA7g/SRN20ku
         LnQcW0m6Ld70hN/UGXi+NgLnNFgQ9J0XbgTbsk10VauqXDcugF9z2uHOK3W8Pm4jeR5A
         xhpA==
X-Gm-Message-State: APuU4Z8Rye4+fOzWcflmsZ3CBrVK5OF4OdfbtE42Y+iTQUTVtL9K0Lt+
	tyJXfv3lx+AqWw2TX20QKTzXmkPrgGJ4gf7Af7ZisxbXCn9dmEnRuq7/HFh3Px7/ikYdoycO5ST
	iFEpl
X-Gm-Gg: AZFdTZdok+ZIuKoc/W79f78DfA4QwwX5TwNRAM5dQ0LHnIV4AyeoUI6b9+iiehTkvFr
	n9wmcjyrIp2rUMCgFqhYlhqya46Lb0ukeWlevGqRIDtDhyLqRLqDIL3Yx6eSzhdHLpEj+QGoa91
	FYEFrx3obRxvF7gTPeoHV0BYht3MMp6YCWw7yq7tcfw95xJuHvG3qAamACPZ/LbtSDYqF9pAemf
	ppOj2YTAXDxsRNgzAZdrVIfj0cvWJEJPsermmeMOsyqh70kga8XBgbhfGFoWyskW+ol2aAw9vuT
	wQDOKakjdhcEBKI4WzkqrBhb4XLkcVNn7CwUG4tZtHrCCxQ5b/yEq5RZoLyomhqjr3gRjtnYVkT
	cyyylVlJLoBvbM1kX44ZrB+tWivjvjqe6DYo7M+Vpc6ittbVYkGOvnwmCGJ/9S8WtaApoVOeKRb
	wj15UxJLJly4i0TUekAGJJbMBrSfqdNSRs9gcSxJE4WOPtktrdB5GkHKX5+cMb24mPlp5wj1afO
	qAa76jjRavyzqWJuYUA8LftqdJjHT89Hl6mR9ZvIIQhzcbKwoknQ7EsbnfC/ZJrgm7w3YUmnV3b
	ZJFRlnKzGDXGimqgGeV1yA==
X-Received: by 2002:a05:693c:37c8:b0:386:a0d1:1b41 with SMTP id 5a478bee46e88-386a0d136aemr19397464eec.34.1795618754672;
        Wed, 25 Nov 2026 06:59:14 -0800 (PST)
Received: from 52d83ede7c60 ([20.38.40.137])
        by smtp.gmail.com with ESMTPSA id 5a478bee46e88-385672ce402sm51855155eec.16.2026.11.25.06.59.13
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 25 Nov 2026 06:59:13 -0800 (PST)
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
Content-Transfer-Encoding: 7bit
Subject: [REGRESSION] stable-rc/linux-6.1.y: (build)call to undeclared
 function
 'init_flush_fput'; ISO C99 and later do...
From: KernelCI bot <bot@kernelci.org>
To: kernelci-results@groups.io
Cc: stable@vger.kernel.org
Reply-To: kernelci@lists.linux.dev
Date: Wed, 25 Nov 2026 14:59:13 -0000
Message-ID: <179561875314.101431.5502710796652185837@kernelci.org>

Cc from: regression/stable-rc.yaml

New build issue found on stable-rc/linux-6.1.y:

---
call to undeclared function 'init_flush_fput'; ISO C99 and later do not support implicit function declarations [-Wimplicit-function-declaration] in init/do_mounts_rd.o (init/do_mounts_rd.c) [logspec:kbuild,kbuild.compiler.error]
---

Log excerpt:
=====================================================
/tmp/kci/linux/init/do_mounts_rd.c:277:2: error: call to undeclared function 'init_flush_fput'; ISO C99 and later do not support implicit function declarations [-Wimplicit-function-declaration]
  277 |         init_flush_fput();
      |         ^
1 error generated.

=====================================================

When fixing this issue, please attribute this report according to the
patch submission rules:

Reported-by: kernelci.org bot <bot@kernelci.org>

For complete logs and details about the environment used, see the issue
on the KernelCI dashboard:

- dashboard: https://d.kernelci.org/i/maestro:47d0bc919c8962ef48ed36f82cbd63f7d7029c6f
- giturl: https://git.kernel.org/pub/scm/linux/kernel/git/stable/linux-stable-rc.git
- commit HEAD:  1c9c007d0246db7a5d04105e86069fe5ba06e01a

# Builds where the incident occurred:

## multi_v7_defconfig on (arm):
- compiler: clang-21
- config: None
- dashboard: https://d.kernelci.org/build/maestro:6b06efc3286e1965ecb36329

#kernelci issue maestro:47d0bc919c8962ef48ed36f82cbd63f7d7029c6f

--
This is an experimental report format. Please send feedback in!
Talk to us at kernelci@lists.linux.dev

Made with love by the KernelCI team - https://kernelci.org
