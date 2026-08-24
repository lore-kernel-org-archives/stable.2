Received: from mail-pg1-f180.google.com (mail-pg1-f180.google.com [209.85.215.180])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E80063A1D01
	for <stable@vger.kernel.org>; Mon, 24 Aug 2026 08:26:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.215.180
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1787560015; cv=none; b=RLiiZBjb2O7xpxPdpZHrnPkp6K3DjJ0W4jNQNgLzvKDQ/1TQt6gJ8CkLcFf7ASlscDd5NFyDwGfngLH4uEc4R2qwGgCWlCLcpkGefZvheSyby9IW/KQuIIsRAQ/eZohP80z1o6lyiiQwc2jpDldb1K0PIeJfmhg1KSNFbModOLk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1787560015; c=relaxed/simple;
	bh=7K3qF4MHbnXOzGNTTxNufyBZaxyiQ5GnnlzSoo75z0Q=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=uvTh4UPbj5xFj62VN/vmevbZOSO3rPm4Ix9MpQJqAbhXPm4Io1vHXV6swPSZ4JZbXQOaYmjFxBTsAO7aEPru1VlOXCI7C6DJYGHt/AQ2pgUJxtSoCyyA1iD29sbP0866jKzOLUwv42m3iFs8oTSDdDvXRo2M+oLFOopLGm2zFBc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=DNr4iTTu; arc=none smtp.client-ip=209.85.215.180
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="DNr4iTTu"
Received: by mail-pg1-f180.google.com with SMTP id 41be03b00d2f7-cbe6295f05bso2820258a12.1
        for <stable@vger.kernel.org>; Mon, 24 Aug 2026 01:26:49 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1787560009; x=1788164809; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to:content-type;
        bh=CgyNog9WpL8OyqKZAIeKVr+B+H34q6AdaVPTiDSA/FQ=;
        b=DNr4iTTubhQ6dm0c/QIQ6DNZiFtuLzmaMz2JdufRvScAFmo0x+QbZT4JRzW+q0RDtD
         7eWPuPvSEOURouxihhrUcmW09fIR4evbyPxOfXwO/vgevTaPzzQN9iZ4TegUngX3I9iW
         3pWFeQojv/Qivww045K8yWFNtXKulBqsckg47H6kH/Q8CIi7GlK33GcYQPVxp6Hk+Yz7
         CYEmQQZ4aDX1KJuBcesE/MGLxdgavYTDSPLoJrEOaq1kpHGltMufXaGDWCnFZZYfHwiX
         D+qRhqDMi0tdo2jbmynGC8oZ8CCb4zPD7diJ2fs4a9dVyMrloKDZlCGXceJ47YbJC0Pm
         PWfg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1787560009; x=1788164809;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=CgyNog9WpL8OyqKZAIeKVr+B+H34q6AdaVPTiDSA/FQ=;
        b=JgoQMYYK74acn5OhpuMfZJwV4IXli0QRxpy3iGWXANqWI0fWt94rCaJvcaBWDVyKdb
         xzTeLcTU95K3h/bsbwpQ/aUMOqSlk+TdQRqoogOZW31091aYZ44W0HS6n7S0RgUD6xN6
         FlWvw4pBZ/W6nybBmYtSrNC3xU9fvBEA8IQpM++KJkWRd5qk8KkyCy6l85lWb0xr0b7j
         5QWYgdS/7MxsYdL8ZiQJbX9Sq9BLn0vg1CRoTg5ee2hZQ21B9Ow7JxT6jqJpkO/pbAak
         ig6/g2f4t7wHVoJEE2TljnvRivnHbMQNPYUm+BWkUIv/x3F75ryYq4ZAvlia4xYjwI5X
         2WcQ==
X-Forwarded-Encrypted: i=1; AHgh+RoX4M+1xpHkpd3EL2eUJ3IyCKZGPcrwWQQBJNtUxYcBtU2Ma0aqqp4u2exRsEHstYF6Ts7Gay8=@vger.kernel.org
X-Gm-Message-State: AFuF++kv3zGjVoYLcNGtAXUuq60cNPZM/6Fh58E2iNlF+pwJFgZ4+QN2
	1HIhaJM7IXScCM6GfRHNkSg1aN5QJG1Kt+ZwcpW1YoD/fUM4LGQqiqDW
X-Gm-Gg: AR+sD12jfQ9Dw1T7sf+spDYl4NPh5tzWvhx4+JWLzk+QlzFaq71bPF1yOVnY7MQ97da
	t1SKNAUAHSgfjQvRvgJOiNN3GdfcRLej++qKXOVji8EjVMZRkATnvEz0cFk+d6MtzlngHrC8bEp
	TzQajBPSIYegCVX4cW6nrkFj5XHSEIlyis2nSuQwdC0kIRkSKozqCnvxY0YvSGQKcCTFNzRRQxA
	EYP59C1S3WG+pgEkMTxBVL3W2ZmNRPNEEd9Ou4jq6FIdDc0KIGwQ6eyKQuFwqQIpljHeueZG5Lx
	tq/f6Dgk/s3JR7Gt9ANOJIjdS41lRFq1BwXteETCZCIOZGY+HsHEJBKkvWqJbCZMuzYcLxQTOzs
	HwS9kDjbWU1gtOVDi3kX0bLHmoDpfUo7pag5IG/yNN2N9VEcr0j+CTvAM9QM0T5dpsEFVKm/36n
	Q6o8zyvrIf/WQBexO1P1K4zSFM8DGJfVJWssfmacPVXX7DOQuC0TFuDDg4rBTom7ruKjwBuD5ay
	Bcw1ZH0hzeuEuG7GI55qQsMfA5DzhUR/5tYSb2zyIQifDHZlGOzNCEf6IvA9oGZLnUdpujyEzAJ
	qh7LSlHjFXhYVABCF6YNjAwd4eZ8gvvld4avWmT6zUaWe7vkE6ZiXm/Y2ax/2BTItHMIzTJ2GU2
	1IYii5Pmq2Zr0u30FvEVhi6oVqj8QlcrIAG0I8GC76/5dl14=
X-Received: by 2002:a17:90b:4ac8:b0:380:ce69:2669 with SMTP id 98e67ed59e1d1-395a0510f96mr35860154a91.9.1787560009190;
        Mon, 24 Aug 2026 01:26:49 -0700 (PDT)
Received: from localhost.localdomain ([101.251.7.10])
        by smtp.gmail.com with ESMTPSA id 5a478bee46e88-327f90c0dd3sm25994595eec.7.2026.08.24.01.26.44
        (version=TLS1_3 cipher=TLS_CHACHA20_POLY1305_SHA256 bits=256/256);
        Mon, 24 Aug 2026 01:26:48 -0700 (PDT)
From: Laxman Acharya Padhya <acharyalaxman8848@gmail.com>
To: Sven Peter <sven@kernel.org>,
	Janne Grunau <j@jannau.net>
Cc: Neal Gompa <neal@gompa.dev>,
	Arnd Bergmann <arnd@arndb.de>,
	asahi@lists.linux.dev,
	linux-arm-kernel@lists.infradead.org,
	linux-kernel@vger.kernel.org,
	stable@vger.kernel.org
Subject: [PATCH v2 0/4] soc: apple: rtkit: harden syslog shared-buffer handling
Date: Mon, 24 Aug 2026 14:11:36 +0545
Message-ID: <cover.1787559303.git.acharyalaxman8848@gmail.com>
X-Mailer: git-send-email 2.51.2
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Split the syslog hardening into focused changes as requested. The first
patch fixes the SYSLOG_INIT reinitialization leak. The second prevents
zero-sized messages and out-of-bounds shared-memory copies. The third
corrects the entry-count boundary, and the fourth rate limits validation
warnings controlled by the coprocessor.

The index-boundary change has not been tested on Apple hardware running
Linux. Asahi m1n1 describes the initialization field as COUNT, consistent
with the kernel's syslog_n_entries name, but patch 3 is kept independent so
it can be reverted without removing the shared-memory bounds protection.

Testing:
  - arm64 GCC build of drivers/soc/apple/rtkit.o with W=1 in Docker
  - scripts/checkpatch.pl --strict on each patch

Changes since v1:
  - inline the one-use shared-memory bounds check
  - use == 0 for the crashlog copy and < 0 for syslog copies
  - split the SYSLOG_INIT leak fix into patch 1
  - split the idx == n_entries change into patch 3
  - make the zero-size guard independent of the leak fix
  - rate limit existing malformed-syslog warnings in patch 4
  - rebase onto upstream commit 0a0d1d55dad5

Laxman Acharya Padhya (4):
  soc: apple: rtkit: free syslog buffer before reinitializing
  soc: apple: rtkit: bound syslog copies to the shared buffer
  soc: apple: rtkit: reject syslog indices outside the entry count
  soc: apple: rtkit: rate limit malformed syslog warnings

 drivers/soc/apple/rtkit.c | 75 +++++++++++++++++++++++++--------------
 1 file changed, 49 insertions(+), 26 deletions(-)


base-commit: 0a0d1d55dad570724bf8c7ea83409639cfb4be9b
-- 
2.51.2
