Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=209.85.221.50
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1793234727;
	b=o7FVclzUiMtU+wst/pZ5vMXofLK820RCwIflFZiJiMIVyGVM4upwR8QgpBvDq7MyPflC
	 8r6DwF0QiOdwxPvNibDaBbyljHj8NwitH8pVEqrUxxUAQP9NDy+jXQ2hBbEUeD5GvZ6qV
	 3ELRUJqlq6+7o9D4ZlAozJZQauwAFzpfEXnbYuneyemsXVnd8GrwOn45zynpz9KvKuf4N
	 NHp7dq7E+7+tcECg8R6xs4DHmUf8+0YuP70ZDNwttQs3rGx6hgRdzURX4KnMyfjgCY8Dk
	 Ad3htz1vlf2wy3nazcJqVg7yovz7C9E/JQi5Oh4jg0jCdIhXzX4Wl/UZLmDC6ARrrSg==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1793234727;
	h=DMARC-Filter:Received:DKIM-Signature:X-Google-DKIM-Signature:
	 X-Gm-Message-State:X-Gm-Gg:X-Received:Received:From:To:Cc:Subject:
	 Date:Message-ID:X-Mailer:MIME-Version:Content-Transfer-Encoding;
	bh=aLZ385CP94FFQai82BttBy9mJrb7vTI1Apf4H0uBaCU=;
	b=ABzKX0lMjfwXkQCaloCSi9QLKWYVhPXUybiWDMULaxIGjk25R4IJcM4d9okk/bxBxsma
	 swhATTf+68ZOysOCe9qMnRHmxyBQzeyps/T4YbO+gVtHhYQQ4Gax3ABHjeG7vpF5yy2xk
	 Dvv28K7GunLaovMoKDWGljt/QeLwmPlMT1au2Caafy48J/IjWxrEhgQad9azBGu6q3W9Y
	 Fg9q+rVJYrMOjJC3rPxnk0j7GmYj9IJq7bMJR+BvwQ4ytqVJOnaxADfJuImto8mBpqLvn
	 WT2J7WSnQqhk1Z5BOduPbU2b4ELbHLECabZ8cEtGHCUgvgVDMuZyOERcq9WcVn6dZVw==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=gmail.com;
	spf=pass smtp.mailfrom=gmail.com;
	dkim=pass header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20260707 header.b=mgNqd85Z;
	arc=none smtp.remote-ip=209.85.221.50
Received: from mail-wr1-f50.google.com (mail-wr1-f50.google.com [209.85.221.50])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CB0FD606A31D
	for <stable@vger.kernel.org>; Thu, 29 Oct 2026 00:45:26 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org CB0FD606A31D
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20260707 header.b=mgNqd85Z
Received: by mail-wr1-f50.google.com with SMTP id ffacd0b85a97d-48e10a70540so1021290f8f.1
        for <stable@vger.kernel.org>; Wed, 28 Oct 2026 17:45:26 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20260707; t=1793234725; x=1793839525; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to:content-type;
        bh=aLZ385CP94FFQai82BttBy9mJrb7vTI1Apf4H0uBaCU=;
        b=mgNqd85ZCDxbX8xR2viMCiV0+wsZYcz0vEV22cg5AflmwDWe6pcAl1th54vWIMufoo
         nrTSVz6y0pkjy9LAe9HqKg4N3VUXn7V3wyN+9sBL4tKVmO1vovUabUrGgf50/AMYotPE
         zsWiBP/BWlKwE2v4kSvG7bcITp6H1Z0z6AewAFMb0H6mYyolKaKvevNm2Ubl911B7fSH
         bGK24U8u5BLTx9BqiPXzhcDCPpeJTwoeEi+OXCr8z6eMq7Mq7+MK/OFEO7XzvZBsDhZU
         dB+XvgtuEl7n9RzhdXytaHzPJoG0zJhD7aXNws+NNCICn/Ds3AF20Whd0g4DxJvcJ+wL
         erTA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1793234725; x=1793839525;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=aLZ385CP94FFQai82BttBy9mJrb7vTI1Apf4H0uBaCU=;
        b=ky23ioiZcws9T7jQTMc60Sjd3VHvYR14tipI0hC6gpxzJigaJbRtxHujmTjmpnxirm
         f+o0vKsQ6njMvfU0bhkQDbmNO+WqIZKUj3UBIHy39vH8D0abGHoymdL67E4LlJgJlCtW
         r6mZKC//FOJOjlU2FcVZ6qoZwj1Ip2TP46Zzo9AT7J5XrEC8JfmwPMZgkTrOBeHMLubP
         lpEzPU7V1KeE02wmfCBhL62TPpRNTN5h3sKGXr2iWQbh5w2+V5/LU+tVKeXzVyUzN2VH
         rN/aGFCTvECBjkMNefkmIS0egaFRdCxspnddrMKz7CfPKym8g4k6Jr8um/sWl3OYj8oW
         5p5w==
X-Gm-Message-State: AFq9FYIw8NfQj9VOkBfK9OT34+IsfImVzfbuMUVnebITUfbovzWooKTx
	XKBzlkna8aNc1YPFQYcXioHlgBpJJ2FTxSLachzJ8eb+OMrfjGH/H5hQTvlQezcd
X-Gm-Gg: AYBFou16RIoEeLjRKE8NehfN778YpWLxJLof67MchRp847T8bmQWFsBRdgQp6Z3W3hB
	g+EviGv4cTppLAle9AJCsZ88wCccWoewJ4oDdl1o09JMXffnZomsv/byQKgd7iC2Je+caX8W4sE
	a/z4cENKZtKUtq1yye3QhKjAEpKKa1JiM0/lXjYdGqBS7zSVvTV4O0n6bjVGERp3PWLsbv01uI4
	rv/MBvlMkV51C+DHD1nYb0Jx7pQCjDmOnLeT7LQC0DPufjHCuzFZTlKjO0n+6r2kpLtt+Oa91JQ
	MzURdpqnmqB3GmKwVlpiAAUkeRhZtzA/gvGxG8MWwoGp26tvJ3PAp2zOL/lLM9JED4ah2ov3Dvm
	74v7YX/aCJKXC0RzHJpgZrm//KfV7HHAtdOYBwgqHm7qHTsXMV0yXHpxl5IRCZgqTyQsqYZWzKA
	BMyAzdigpmFLqwo6xGBn8ZEGlmruJ8Q578ZAMfJm86zanW6xQ4hIfxhvMG+msTvjrkYEQQJq4Dw
	EFF0gcPdk3FBlnNdCOTz3PX3RL78/pzChyDpKOsaFpZ6eRlrGJhfc9SY2LHcui8f+87RmULRNTz
	9tWnV9VRpKrNT4QLqto/ZVOy2roQmUUQ/5h9OajnG8wLz8tgoBZvZzLML+rR48RGZAZbsFR61i4
	b/SeTuJS+nPpmeiNw/IIFNO3mMGZGfXBUlBVKxFEzdR50prlGKaqkg9HhLRgyz4WKtY2JDGvwmL
	UY8On/3TTmrSsPuHhGezoXGP6zxC3U4I4fuRmOlR9pfxdHPFk=
X-Received: by 2002:a05:6000:24c4:b0:48e:203e:84f0 with SMTP id ffacd0b85a97d-48e5d5c8442mr9351081f8f.24.1793234724998;
        Wed, 28 Oct 2026 17:45:24 -0700 (PDT)
Received: from localhost.localdomain (dynamic-2a00-1028-8388-a84e-301f-0e2e-7b95-b045.ipv6.o2.cz. [2a00:1028:8388:a84e:301f:e2e:7b95:b045])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-48e3ecd8ddasm33960070f8f.48.2026.10.28.17.45.22
        (version=TLS1_3 cipher=TLS_CHACHA20_POLY1305_SHA256 bits=256/256);
        Wed, 28 Oct 2026 17:45:23 -0700 (PDT)
From: Josef Schlehofer <pepe.schlehofer@gmail.com>
To: stable@vger.kernel.org
Cc: Ridham Khurana <khurana.ridham222@gmail.com>,
	=?UTF-8?q?Marek=20Beh=C3=BAn?= <kabel@kernel.org>,
	Krzysztof Kozlowski <krzk@kernel.org>
Subject: Request: 59797443846b ("platform: cznic: turris-omnia-mcu: Add missing MODULE_DEVICE_TABLE()")
Date: Thu, 29 Oct 2026 01:45:21 +0100
Message-ID: <20261029004521.48885-1-pepe.schlehofer@gmail.com>
X-Mailer: git-send-email 2.54.0
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

Hi,

please apply this mainline commit to 6.12.y, 6.18.y and 7.2.y:

  59797443846b ("platform: cznic: turris-omnia-mcu: Add missing MODULE_DEVICE_TABLE()")

It fixes 992f1a3d4e88 ("platform: cznic: Add preliminary support for
Turris Omnia MCU"), which came in v6.11.

Without the module alias, udev does not load the MCU driver. On a
Turris Omnia with 6.18.59, modprobe -R finds no module for
'of:Nsystem-controllerT(null)Ccznic,turris-omnia-mcu'. Distributions
then have to load the module by hand, for example in the initramfs.

The commit applies cleanly to all three trees.

Thanks,
Josef
