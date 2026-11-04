Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=74.125.82.177
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1793833149;
	b=xvJOUOKUWwjbBfXpmjco5vXzPqd0MNNgbYWS8fpmMU7LApJSLC/swR1g111dKJTAPCLx
	 jwPl4tlw9vr/YaxG7KW2CzZb1eV1LxB+FimetBHZagiJjkztpwym4ew0p8wLQCKz37Q4g
	 C+BgK+DzEWqITVZYhaKKBzvbhfpwwIiFaSdY2O10Jp7T/xbcYZCV6Y7sbatGldgjIOtnR
	 AUwZmu8Pta5IV9ZVnRB4LQ22lWQoeJQ78FLdoI6QE6W2gI4FiY22IdyoS8SdB1BU4m5Ak
	 40Lo9Pxu+3Ehtzt/JzigYeUG3txa3kKfTWTgmmVMDg2y9I6GwglGXY0qkuBkX542b0A==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1793833149;
	h=DMARC-Filter:Received:DKIM-Signature:X-Google-DKIM-Signature:
	 X-Gm-Message-State:X-Gm-Gg:X-Received:Received:Content-Type:
	 MIME-Version:Content-Transfer-Encoding:Subject:From:To:Cc:Reply-To:
	 Date:Message-ID;
	bh=csA49c90+4OdJ6LKUviu6SpKjJwyl+naUs+pCGJJKDg=;
	b=w2vMpT4FnYxcdRH9lRuLk0Lta0XyM59oO7DGPJRZ/+qpdlK6fa+utjHane+y64sy3PC4
	 xdV+mctcES6gAhYZtkhZqLBP1HFZZKc4l19U2Lo+HCjdTp8aY0+55picz4itDRGyuUAn0
	 9EJpp7lk6i53oPfMPWT1htV2v8A3bnWpBAIk3rXjOh5ROipgxBw1wsj1RMYgCvxEYWkyc
	 CQqp/T9YScEPABVzdlptV9QcGAJ9HDJ4jSSWipybUaoBNayAGmDHf29t8k+J8gwJjVX0a
	 FH15/fnouSQ+OKSA8vQZ6sps94NxKqyPnduZoPm89VaZWJTRkd4s/nsniMOFy/wQfcA==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=kernelci.org;
	spf=pass smtp.mailfrom=kernelci.org;
	dkim=pass header.d=kernelci.org header.i=@kernelci.org header.a=rsa-sha256 header.s=google header.b="fTpCU/Gt";
	arc=none smtp.remote-ip=74.125.82.177
Received: from mail-dy1-f177.google.com (mail-dy1-f177.google.com [74.125.82.177])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9AC0F606A329
	for <stable@vger.kernel.org>; Wed,  4 Nov 2026 22:59:08 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 9AC0F606A329
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=kernelci.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=kernelci.org
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=kernelci.org header.i=@kernelci.org header.a=rsa-sha256 header.s=google header.b=fTpCU/Gt
Received: by mail-dy1-f177.google.com with SMTP id 5a478bee46e88-35b2c599f43so631277eec.0
        for <stable@vger.kernel.org>; Wed, 04 Nov 2026 14:59:08 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=kernelci.org; s=google; t=1793833147; x=1794437947; darn=vger.kernel.org;
        h=message-id:date:reply-to:cc:to:from:subject
         :content-transfer-encoding:mime-version:content-type:from:to:cc
         :subject:date:message-id:reply-to:content-type;
        bh=csA49c90+4OdJ6LKUviu6SpKjJwyl+naUs+pCGJJKDg=;
        b=fTpCU/GtN0sxmMKnYdEZOy3Pv+8MYFpSOzQqDv+y79+Gj2SWiIlUnVQm/dE/ag7Ibj
         zK5WOFEcDf9ls1XYFQ4Mt2rninibBIcP9HgeJ2cbcJnm+xJTPY01YRmPzgYQGRVOWdtz
         9v3Qt7KW/ueQcLda4yLrbTAk1jGR5Fs+MopPzITM7jbrSxaBii5/4NmDUDAqwExnCDA/
         PVOA3NNxcv6FYXshuCIrboLUfjbv6gJmhZOyLtzPnaUk4mtE3ezU7lsvTTUXgUuLLWDr
         7zum0uZtrapNVySBVzoPWE+yZH1wJQvIgfdlDYz4mki9CbtNy5pQ9s9QnY2qQ0EHrfJV
         KjTw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1793833147; x=1794437947;
        h=message-id:date:reply-to:cc:to:from:subject
         :content-transfer-encoding:mime-version:content-type:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=csA49c90+4OdJ6LKUviu6SpKjJwyl+naUs+pCGJJKDg=;
        b=gIg1I471aZYG6F1LnwsyQjdMXnUL6Pn6CWfRFzQnYSUuj3ahX3DpakDr9nlKs84py/
         BEy72FcuSNOsiqNyHZdbqvi0J292pr84fKapgnE+DCB7xXwxJZnzdIg6/eEpocaNKhZ9
         /QBeWtYk3GtkLn4M9i0bfaU+v7X5fqH256cX+NFPSNBweP38dncdafTV9f7vmVzNiLWg
         srs86hxTvtCKpkx3yOZ4a0O9xOVQB5qEUaIgpiR0kFgPoeTPV5GuCzv6WR7gf8kx2RSv
         NojzOwLceOyiyxP31ezWm657kBiJqc73lcPWPG+gNVzFwcCcpA98CzLzcn7q8ChqpNUz
         SnuA==
X-Gm-Message-State: APuU4Z98e37hJMKqrebzAjoM0ALjlvNRc0jfqag3bSZAu073yir2i8x7
	4Eo+5UIYDxp/RI4Si4uwaYOESXf/RjvtTlxofvvoLjiOtA9XFK/BZbdkT5CWG+6nxgk2Z5w3/iu
	Cpfm7
X-Gm-Gg: AYBFou1yknPR5g5hw1FOi03wcM0qU34yuF6+6iD8Zy3lcDpgLHUXRZ6Mfgmg1oD7VoY
	JYxrMrm1LG388vYIXkgf/8Ok2T+IOoA9a93vv9J7v2LgUPZAfmvm2pM9qh6Jj4IhKZCYJprwoe6
	AdL8c/lrO9Poik+HuUOBiGhn0QrX+cn8HPRZwuTFcnL08TCXW4xx5ysBJxInbiK1UwiX4Gdbvvq
	bmqT7U2//b4B5Qnda78dSKlizAzo3nSuhAcch91Fo+/KmrWHUK2OiIB8PwRSh1tAnw8pzBxLghW
	HKU703OpvHtQ555ij8Da5rpFV/oBOcyz9rQ7qGE7vYJXgjbintZioLLJLPepetRJZv4LiHvbWY7
	a6LFCADRRx4TfiEZDaYrul+/mkh7tyg6JqSObyqHMoQEwXAZgyjaDmGdo3sRyUcp455Ht6uBvbS
	BC82q7mGNGEPc8mBxcf/f08pSaSEBCx4VklkKzpcwaJrAPHHt1DjRmsh2vDcQ+bUCAxTdLIRNhg
	NHLu2mJJP6SWnVVhVzrAxLl8Pu9zitFHPRZfHfuDU/EONfAOrIyJbETD0V4FuQ5RANqoC93cwd4
	0CKlDxZYB5woaKT3e1raWQ==
X-Received: by 2002:a05:7300:c019:20b0:369:d6ed:f2b5 with SMTP id 5a478bee46e88-36a4246992amr29186754eec.39.1793833147212;
        Wed, 04 Nov 2026 14:59:07 -0800 (PST)
Received: from 34406640b1f4 ([20.38.40.137])
        by smtp.gmail.com with ESMTPSA id 5a478bee46e88-36ca38d3754sm13965854eec.14.2026.11.04.14.59.06
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 04 Nov 2026 14:59:06 -0800 (PST)
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
Subject: [REGRESSION] stable-rc/linux-6.1.y: (build)macro "DEFINE_SEMAPHORE"
 passed 2
 arguments, but takes just 1 in ar...
From: KernelCI bot <bot@kernelci.org>
To: kernelci-results@groups.io
Cc: stable@vger.kernel.org
Reply-To: kernelci@lists.linux.dev
Date: Wed, 04 Nov 2026 22:59:06 -0000
Message-ID: <179383314600.333747.3921734538803484420@kernelci.org>

New build issue found on stable-rc/linux-6.1.y:

---
macro "DEFINE_SEMAPHORE" passed 2 arguments, but takes just 1 in arch/s390/crypto/aes_s390.o (arch/s390/crypto/aes_s390.c) [logspec:kbuild,kbuild.compiler.error]
---

Log excerpt:
=====================================================
/tmp/kci/linux/arch/s390/crypto/aes_s390.c:38:38: error: macro "DEFINE_SEMAPHORE" passed 2 arguments, but takes just 1
   38 | static DEFINE_SEMAPHORE(ctrblk_sem, 1);
      |                                      ^
In file included from /tmp/kci/linux/include/linux/fs.h:25,
                 from /tmp/kci/linux/include/linux/highmem.h:5,
                 from /tmp/kci/linux/include/crypto/scatterwalk.h:16,
                 from /tmp/kci/linux/arch/s390/crypto/aes_s390.c:26:
/tmp/kci/linux/include/linux/semaphore.h:28:9: note: macro "DEFINE_SEMAPHORE" defined here
   28 | #define DEFINE_SEMAPHORE(name)  \
      |         ^~~~~~~~~~~~~~~~
/tmp/kci/linux/arch/s390/crypto/aes_s390.c:38:8: error: type defaults to ‘int’ in declaration of ‘DEFINE_SEMAPHORE’ [-Wimplicit-int]
   38 | static DEFINE_SEMAPHORE(ctrblk_sem, 1);
      |        ^~~~~~~~~~~~~~~~
/tmp/kci/linux/arch/s390/crypto/aes_s390.c: In function ‘ctr_aes_crypt’:
/tmp/kci/linux/arch/s390/crypto/aes_s390.c:608:27: error: ‘ctrblk_sem’ undeclared (first use in this function); did you mean ‘ctrblk’?
  608 |         if (down_trylock(&ctrblk_sem) == 0) {
      |                           ^~~~~~~~~~
      |                           ctrblk
/tmp/kci/linux/arch/s390/crypto/aes_s390.c:608:27: note: each undeclared identifier is reported only once for each function it appears in
/tmp/kci/linux/arch/s390/crypto/aes_s390.c: At top level:
/tmp/kci/linux/arch/s390/crypto/aes_s390.c:38:8: warning: ‘DEFINE_SEMAPHORE’ defined but not used [-Wunused-variable]
   38 | static DEFINE_SEMAPHORE(ctrblk_sem, 1);
      |        ^~~~~~~~~~~~~~~~

=====================================================

When fixing this issue, please attribute this report according to the
patch submission rules:

Reported-by: kernelci.org bot <bot@kernelci.org>

For complete logs and details about the environment used, see the issue
on the KernelCI dashboard:

- dashboard: https://d.kernelci.org/i/maestro:198d0349888f342a660c236e8ecabdd12aee4e26
- giturl: https://git.kernel.org/pub/scm/linux/kernel/git/stable/linux-stable-rc.git
- commit HEAD:  5444176e86225bbe9484411fcdeb5812a7588dab

# Builds where the incident occurred:

## defconfig on (s390):
- compiler: gcc-14
- config: None
- dashboard: https://d.kernelci.org/build/maestro:6aebb0b95b429d354eef198e

#kernelci issue maestro:198d0349888f342a660c236e8ecabdd12aee4e26

--
This is an experimental report format. Please send feedback in!
Talk to us at kernelci@lists.linux.dev

Made with love by the KernelCI team - https://kernelci.org
