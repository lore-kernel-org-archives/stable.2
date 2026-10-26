Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=209.85.128.44
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1793022721;
	b=HR4x34rkgbB42NkBEkOhCJQi6rWJvHWhs6zynvNOpk5q79MkHeS2DaEdiHfpqh+2TOka
	 IcjMNzXvoY421GhzAy0F6TgwwbHBV5owiDQGWJXUZhSk9R2cbPuLDOdgDh4BUCtfVQYvL
	 nwgyNTsnj+lHrb9LReanWUevIiCSnjsYjQ/5iTwcSP5eFSKVVzyknzrH58Ewt3m6gnUG9
	 4f+VbcSQodCzfGMo2boNqy64wce7SVMCuKycwEy1vCuNbpIXsGSKqspM4EQguQfPc8+6k
	 fbDbRUrXHWMAA0RAcTh5fpkWYoKfmwLGct3mN89twY30uIYO2yCKAmWF9EhY6jKF5AQ==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1793022721;
	h=DMARC-Filter:Received:DKIM-Signature:X-Google-DKIM-Signature:
	 X-Forwarded-Encrypted:X-Gm-Message-State:X-Gm-Gg:X-Received:Received:
	 From:X-Google-Original-From:To:Cc:Subject:Date:Message-ID:In-Reply-To:
	 References:Content-Type:Content-Transfer-Encoding:MIME-Version;
	bh=yToqbndOEx+Hojl0phQ5607aWIXV5FC09eyMH7kbcws=;
	b=P8gLd2JKdOcWkjwBxV4CNOdaT+l0qbTMpS5a/g724cQcUqdpBqk8aRrAqz7O9cEsB4nP
	 xkz+gPDz99Mn1TJFHGHqibKJlrSyAzyW5X4/b0qhMUu5eUThsI0BbP64yxJPR7ixEz+3+
	 PrUteZBiW59dgVr5bp64ARHJwygoseaad5OJ0rBZ5EIMdS7LtcQhBnQ75lyFQthBtWRvC
	 he7hMfbEanOoNBaAazN0+F4nMoT30ulyIa+69tW3TwheeBlosXhOoigKkhH3W46VWroDT
	 ZZVj0Iurn5yVRpY+RSmrfnpOAqgWo3/JL60azj5owYt9V48So2+FNoV6OQ19ySF2zRA==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=gmail.com;
	spf=pass smtp.mailfrom=gmail.com;
	dkim=pass header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20251104 header.b=KHj81qdS;
	arc=none smtp.remote-ip=209.85.128.44
Received: from mail-wm1-f44.google.com (mail-wm1-f44.google.com [209.85.128.44])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8523B606A31D
	for <stable@vger.kernel.org>; Mon, 26 Oct 2026 13:52:01 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 8523B606A31D
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20251104 header.b=KHj81qdS
Received: by mail-wm1-f44.google.com with SMTP id 5b1f17b1804b1-4a60f9474c4so11104515e9.0
        for <stable@vger.kernel.org>; Mon, 26 Oct 2026 06:52:01 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1793022720; x=1793627520; darn=vger.kernel.org;
        h=mime-version:content-transfer-encoding:content-type:references
         :in-reply-to:message-id:date:subject:cc:to:from:from:to:cc:subject
         :date:message-id:reply-to:content-type;
        bh=yToqbndOEx+Hojl0phQ5607aWIXV5FC09eyMH7kbcws=;
        b=KHj81qdSIlSFOiHthO0dlwcj+NjDovUfLvD+44dcsjtzW9O2+W/Et/Ud/nJM8FaFpj
         l7KwuQx93TM46UEIXphcndJz6PGzO1QMz0ZWcBeLzCbXS+g5roTPwf7kgEC+3Q5oOB68
         3Dk3RZ9Zs1X75896jcm/nD5wSw5PNfukwenR9dtUSofQmM8SF+t7XgBCkkG9t1Pf6ilm
         sseShP3+l7j4e/bmgZrTqzcCs7V1ZWqHAw4CFOBFe2UX1cYVHGJj5P/TV3pcnffTEDfR
         QlYsZk4vvrK+5ATPuRa/uXIJPRXb2qdmvQPOpkXH4wCk1zYjAlaJOOiZYgQKCJn3+gSb
         oHww==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1793022720; x=1793627520;
        h=mime-version:content-transfer-encoding:content-type:references
         :in-reply-to:message-id:date:subject:cc:to:from:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=yToqbndOEx+Hojl0phQ5607aWIXV5FC09eyMH7kbcws=;
        b=NagtLzwCfDkRFGCOWg74N7osVgDFtqI+erYpfMSFNma0bH98eGi04QRk2qElo5kbd0
         ijLG/ajx0Rfcd5lrc9x5y5NoFFUFXdZ8kWg5k9y80di70VAARMwp9tMpFPX0RotHxwly
         G5n3ONFp3EdGLZmh+l4sYzAerfjNrCmYGZFb5OAH//ODYYW8eHKNgU9mlkWXzDdN3z0u
         wY81cWw21VFkeBTvPZfE+2hCcGpWMvPWo/7DBP+nm811kHByhCSChigoRXLi6P4aWIdS
         HuBPJwxrB1vL5Z1frJGWgOOx9XuFbtBJifFDpqMS/3QcJW31d9CiqrajQsANzCJfnNjb
         QS8w==
X-Forwarded-Encrypted: i=1; AKwUvBxSxXKTGwIjofY86IHSb+XZg4kpYmUfTx9ROMmYzMv6O/xvwbPhxBLvCPdIF6FXveCnyt5FZGk=@vger.kernel.org
X-Gm-Message-State: AFq9FYKd07eleWW6SzXhynpxueDYKzfYdyYOh+IY5B3nGDXTrzgLeB6O
	BYcBjHpm4G3gS9w4AKPVr8GwDwmm7RS9/TFn4u9fzHz702iBKZvuZjc=
X-Gm-Gg: AYBFou1Xdga4YQbd2gNU+aBbXqOi0HIM9Oqu0FWgMtIspV+rO/X/a/Dd3hk4/bDy5JK
	rBTnPmdbn92HFbPCfUJE1K9V4JzQ1cmwJyGhgh7UgxHIvxjme3mMCVTxDbQjF+kX3UTLhu0TW9g
	wZTlXZEeLrZKVL+B+YzzzpHgfEO9sNRgEYhHOpfETgGd0SkjVsTSu4YWuTfClLktZIfRf62Isx3
	q0giM6fu10aWZEgOxTS7O1mHpaERPTIZ6SVnW+hOev9xvH+rQLeXvQN7YcwZyMr6kIGt8+Z6lA+
	eTsE4OXnAl7H7mRZi0TD2C8milU+Fff+fS9HhKYPXhipfzVH0yyTEa53mOtBLkWMeZmtSePXzA4
	pK4MtPhqiO8NQNIlS/eB2fGmP+cTT1Yb2eywYBLd5CHyG2DbE3BggDahe8VPTKHSXdCNYXClSY+
	XKK7GNGp5K+Yk6ZAHdmpVGJ4gzL/OsDvyhkGx6tHamsmuDiYXqQomuhlSckNV69afhM3wJx34V7
	3Zx6lHgOL97GvOxsj9LOUzKUWuzj5egxdU=
X-Received: by 2002:a05:600c:a318:b0:4a3:5aee:2c25 with SMTP id 5b1f17b1804b1-4a35aee2cfdmr94233795e9.31.1793022719649;
        Mon, 26 Oct 2026 06:51:59 -0700 (PDT)
Received: from debian ([2001:41d0:303:db6b::])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-4a35a574088sm182895725e9.9.2026.10.26.06.51.57
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 26 Oct 2026 06:51:58 -0700 (PDT)
From: Tristan Madani <tristmd@gmail.com>
X-Google-Original-From: Tristan Madani <tristan@talencesecurity.com>
To: netdev-bot+sinfo@kernel.org
Cc: linux-can@vger.kernel.org, netdev@vger.kernel.org, mkl@pengutronix.de,
 socketcan@hartkopp.net, s.grosjean@peak-system.com, stable@vger.kernel.org
Subject: Re: [PATCH v2 net] can: peak_usb: fix use-after-free on PCAN-USB
 disconnect and init failure
Date: Mon, 26 Oct 2026 13:51:56 -0000
Message-ID: <179302271698.3957649.179210854484018832@talencesecurity.com>
In-Reply-To: <179296234587.3327.17827320411071304419@kernel.org>
References: <20261025210256.629830-1-tristan@talencesecurity.com>
 <179296234587.3327.17827320411071304419@kernel.org>
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Post: <mailto:stable@vger.kernel.org>
List-Help: <mailto:stable+help@vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
List-Owner: <mailto:stable+owner@vger.kernel.org>
Precedence: list
MIME-Version: 1.0

The issue was found by manual code inspection of USB CAN driver
disconnect and error handling paths, specifically looking for missing
timer/work cancellation before device structure teardown.

The bug has not been triggered in practice.  The race window is between
a bus error arming restart_timer in pcan_usb_restart_async() and a
concurrent USB disconnect calling peak_usb_disconnect() which frees the
candev.  The PCAN-USB adapter does not register a dev_free callback, so
the timer is never cancelled on the disconnect path.
