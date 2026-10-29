Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=209.85.128.43
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1793283042;
	b=NLGh6CcpeHYmGyF3GoydzvYwmakDYFHzXWLO3ymntkljh+WXUz8glGfvqnXQUj/Xbj4f
	 /qPubU/gVS+WMr9DBjxJXKRNh+51HYehbofAMj3dRbmFfg++7YBLxBLiozp3Lo77IXFw0
	 GO4/0t0awE2yjm670hCZtecQfJNEUvZRsM6w3E+A2yCEDYUBozyTO3y9Kk/RTF4m9Jvah
	 288/cbBeLD8ePN9du70UhEC5KnpcehFUK7b+7zICE5BlsmOcICeCkgNFvwwfAn5gfwTep
	 GIg55Jn4t7xDzQIUl6UsY56GIg7oidIayevFre/LeruZY6NGT+StQ3jqd2f5UJ5U3tQ==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1793283042;
	h=DMARC-Filter:Received:DKIM-Signature:X-Google-DKIM-Signature:
	 X-Forwarded-Encrypted:X-Gm-Message-State:X-Gm-Gg:X-Received:Received:
	 From:To:Cc:Subject:Date:Message-ID:X-Mailer:MIME-Version:
	 Content-Transfer-Encoding;
	bh=F0Pjn2BqzzaqvJe+lN0bPMDDItv7FxWwhFqAjmgdB4c=;
	b=v8ppHUUId6gB7FJyfN+oHcDmNgu5aXc+8HgrR6ikeTjF08HRKq/fs96ICfw5dNDosveJ
	 YGgFGb8TJZ/Hd/Af3u1jhNFpSK8K6mPb0u2NVx2XxwcKWLUFmeEedfaX9XB5LojjGJNfs
	 wT9yG1iqcyH/stH6bhtizdRPXNbYyMy+KG0eWK84hRUNTUKi0uNAT7HsW/OVo5Ls7hNob
	 B2B6+AIA9FEnV4zG2F7zpTf7nYzN++tWHpfqNQcH8wizE/bxIw1kZgikwAsfHkhHZbNJQ
	 kOPV8vBcCBEg0ozzpUDoWV09wVIqzbWIbcFm2qWzGGVg6lCmMlQMRlFVaB6Y2SzgY7A==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=gmail.com;
	spf=pass smtp.mailfrom=gmail.com;
	dkim=pass header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20260707 header.b=Y37EPxlC;
	arc=none smtp.remote-ip=209.85.128.43
Received: from mail-wm1-f43.google.com (mail-wm1-f43.google.com [209.85.128.43])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 80327606A31E
	for <stable@vger.kernel.org>; Thu, 29 Oct 2026 14:10:41 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 80327606A31E
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20260707 header.b=Y37EPxlC
Received: by mail-wm1-f43.google.com with SMTP id 5b1f17b1804b1-4a2d6d01ecbso15410465e9.0
        for <stable@vger.kernel.org>; Thu, 29 Oct 2026 07:10:41 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20260707; t=1793283040; x=1793887840; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to:content-type;
        bh=F0Pjn2BqzzaqvJe+lN0bPMDDItv7FxWwhFqAjmgdB4c=;
        b=Y37EPxlCyrUha6uIGc+dDcOlep9u0jlBuh9fefBtz5OC8Ej0GyRjlf1upZ6AEcsEm9
         SeVoZvh0dSuCshpsoIpwW0lhTQgm6BFz36rnAVwpIMqbndLmzK7Yf1nVDX3592ZuAhpb
         r2uj3+n2fbHUO5CsmG3Gg35f2XraLGLX0tWgp1aXpM1fW1+KYEhRRjmi6wPJxyPyEIan
         nXrT9f/UafSDB08BmzgqpQu/76HvX88HiJz/Qagxs8FSa0QDM+nI0GTkIQlAQsuu8H26
         GKc/t6x6fsJLMXIYwBJMASle5zJedGXsqlgXXoGo9ETPIwMdveKcO1kTbILfl4v+WfOu
         qHIQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1793283040; x=1793887840;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=F0Pjn2BqzzaqvJe+lN0bPMDDItv7FxWwhFqAjmgdB4c=;
        b=gbiyFS0S/SzuOguZ8VqwVtDsdvPQWUVAtLrYiE7sUgJ+WZAj6k6hWxJDrWkfJR6iVa
         2H/SRsT+JedBoyUiP5//vbfOUj2ohWmX1iRp3+GcgAJOGqGWWQ4cLo/wCc/sK9HQHuc2
         jq9dtaOpUnunzhCoh/+EoWa5/yIo2Sb5h1yTlr5fcLaiXxL3CXZNkUgvbM6jtHByg4k3
         Jge78C7LSMkB9vgfX9Az7y9D9CMOSMe4ma9yh74omkg8Zo+q1qp2O/sKy2BskzBW+poA
         qZjhvnbLBSnQJH7Toix9rACkcQKHMJJd4BAn0GmNk6r5eYE0KX0OCsIyiWc3gxIG7wdi
         JS2w==
X-Forwarded-Encrypted: i=1; AKwUvBzGuMLeN5UrJFgnAgvA/4KP8N24oRQ5AnxI6DPZS87/0SPYYeLN/nvJ9LHEVS3KZqDvz/KWmnk=@vger.kernel.org
X-Gm-Message-State: AFq9FYL82/Ktf4pMz2piCi76wYhaOJ53AR32yH6UyQAJEAblf0fWthBt
	PjWRko5JV+BaFawjxNy+4okNXe/+HGkgZiVV+pKLHHDQ4eF1Jw61B5I=
X-Gm-Gg: AYBFou3ZAEzz2G3ZxNPin7NmreuiHSXgL37eW79QwIUX6IV+zBhvGiVMa0mziOYkY/w
	1DMV73Pc1CldvBO+rFyU2VSxJPfILhi+QIvjwBqPDkZjxKb3xJCQd/Zp/YOS8VbKoDtjEBGCAcB
	xUi+JiGpUYuZ4StAmhjdyb5KK26AUAVCBvS5xiRcpTE1hkAVDU4mVXwVBu3Zl9B+ctNDWil7HLU
	Cy5x4iFr2YWeRYubhdAVWFu+oiqH9x0hGriwikhhen/lj78ljAar2CnC9yirQpUiFs9wKuDL0FC
	aXuw5BU4/r+cHCKOk0lH9gur40n4hPn30Aa+J0tlXzP0oRcDxaEkxbZw3QPcX+L2FNpjijovLQV
	DD+hcrVUO9dJz2ZtBWFZapjn013VIzCeKa/NiB0aWwi5jms+M0QpjR/cXnflP3Vaxy7CicBx1kX
	BCQxOOsrCx4oenVjDjOdbp+B931hkfV1ug2tNOG2U+3knKRd++y2qN4Oba5ht2doJSutXw0okQA
	2iQpGdoOT7Eb8t1YQ+unFm+QlPvOD8P84GtFwtwK5ZSlJYjaAJTwqEUIV21ZELGr06FtHieHw==
X-Received: by 2002:a05:600c:b8a:b0:4a2:b89:b02 with SMTP id 5b1f17b1804b1-4a96667c848mr120870685e9.10.1793283039641;
        Thu, 29 Oct 2026 07:10:39 -0700 (PDT)
Received: from debian.. ([2001:41d0:303:db6b::])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-48e3ebc3932sm35906848f8f.18.2026.10.29.07.10.37
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 29 Oct 2026 07:10:37 -0700 (PDT)
From: Tristan Madani <tristmd@gmail.com>
To: Even Xu <even.xu@intel.com>,
	Xinpeng Sun <xinpeng.sun@intel.com>,
	Jiri Kosina <jikos@kernel.org>,
	Benjamin Tissoires <bentiss@kernel.org>
Cc: Srinivas Pandruvada <srinivas.pandruvada@linux.intel.com>,
	Mark Pearson <mpearson-lenovo@squebb.ca>,
	linux-input@vger.kernel.org,
	stable@vger.kernel.org,
	Tristan Madani <tristan@talencesecurity.com>
Subject: [PATCH v3 0/2] HID: intel-thc-hid: validate ACPI buffer lengths
Date: Thu, 29 Oct 2026 14:10:34 +0000
Message-ID: <20261029141037.2655603-1-tristmd@gmail.com>
X-Mailer: git-send-email 2.47.3
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

From: Tristan Madani <tristan@talencesecurity.com>

The QuickSPI and QuickI2C ACPI helper functions copy firmware-returned
buffers without verifying their length.  This series adds buf_size
parameters and overflow checks.

Changes in v3:
- Split into two separate patches (QuickSPI and QuickI2C), per Even Xu
- Add kernel-doc @buf_size parameter descriptions

Changes in v2:
- Use overflow-only check (>) instead of exact-match (!=)
- Zero-initialize caller stack structures
- Add missing type validation and kfree in DSD helper

Tristan Madani (2):
  HID: intel-thc-hid: quickspi: validate ACPI buffer length before
    memcpy
  HID: intel-thc-hid: quicki2c: validate ACPI buffer length before
    memcpy

 .../intel-quicki2c/pci-quicki2c.c             | 42 ++++++++++++++-----
 .../intel-quickspi/pci-quickspi.c             | 37 +++++++++-------
 2 files changed, 54 insertions(+), 25 deletions(-)

-- 
2.47.3
