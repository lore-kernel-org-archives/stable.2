Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=100.103.45.18
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1793299442;
	b=hO6L0Lf5h8wYOrkOi3jZnSV4/b5nlsAJrxmp4cD0iJYCICU7GfPoldEEJIhRUDGavsWE
	 iwzhNDjNowzoZj1fn7Ia8oZ32avUyhDcAZKfxsWH8GE2VJ60Y10yXrqQnsa0YyxiZfVZr
	 oFSAoz6bPEijgnbKp0CvQNlt3/WubbR8oCSUork6Eyn1qUhj2v208Tet7a1FuwZyUIEZU
	 zaRt8qVFFfyz6nZh6d2W+UzfTd6ehv4Ff4YmVR+1nqDNQjUN7Bb1ZlccpzcgJMmSoa76l
	 XDe3ZyrOwPtJJZbUCBYzjjTjmr/NCgwxAmfatVb3sqp8YLNJHCvUOvYDsY6HD2+5jcw==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1793299442;
	h=Received:DKIM-Signature:From:To:Cc:Subject:Date:Message-ID:X-Mailer:
	 In-Reply-To:References:MIME-Version:Content-Type:
	 Content-Transfer-Encoding;
	bh=Rk+E9um0ErRPfuRIhrr0Fhio2fNI58imIas9VE70hXs=;
	b=USj4pR+TR0SroSM+P77uJrGhoi1AkZis5X+P3rUxHcR+gLKUAbsbVV7Mm8G8Iq+yoQmB
	 D2YdUFy7r916MEqpNAt6kXCRikrJBUMJOzwksJJdq+YNG6gJekvqBDUeyV5vpDh2O0VN4
	 B2LfCDkAcki43ilYDJ6cvGDUq8nh7aZmq/31xw+PnrkWXbNivTBulsc/6Dwhtf73VBfEH
	 wbCoh7ZyevbXpMHRBo/YH1R6coYLYyHZFYQAe0Eq+jYa/4N3cWKx2rHmn6hv9QPrFyuaJ
	 aXJls7q8c2ehXpgrdgomWXBfhmFfbj04XOv3uQKqFUipHTsHziL6gM6P9aa/KQCOG0A==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dkim=pass header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=F1eL0zAr;
	arc=none smtp.remote-ip=100.103.45.18
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C7CAC60A2607;
	Thu, 29 Oct 2026 18:44:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=F1eL0zAr
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 8B7951F01282;
	Thu, 29 Oct 2026 18:44:00 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1793299441;
	bh=Rk+E9um0ErRPfuRIhrr0Fhio2fNI58imIas9VE70hXs=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References;
	b=F1eL0zAra4x3CdNu2PlHlA0ZOOYYGPW3yI2JluDrioc/TSb9zniD8gv9XxLfYoHt7
	 zmMp1orUK2WWKYv26qyau98wHVIkdV8+CupAgvmr8VsvTTu4AT8JU7jCJ6VWvR6Wqf
	 Se4oQ/RoRX4mzs5WNw6FrPAYd035+9Bw4aOL4KJEx7uX5GcBU62Jr/1ZgOGkfR4cXx
	 1EX/q8ymxI/KeWnMoFnKsmlHAS40Bftj/a4fOEaXTcmLcjZ8R8ajVTnNh4iiL4zpnW
	 fyofES0pNkzbrJNMgXB5/dC5aYMAJ2a9TsRnx89PKa2DQ4A1cEaQLZcfxDnaq1cenn
	 rbnQliOQkYV8g==
From: Sasha Levin <sashal@kernel.org>
To: stable@vger.kernel.org
Cc: Sasha Levin <sashal@kernel.org>,
	Nathan Chancellor <nathan@kernel.org>,
	Nicolas Schier <nsc@kernel.org>,
	Peter Griffin <peter.griffin@linaro.org>,
	Tudor Ambarus <tudor.ambarus@linaro.org>,
	Juan Yescas <jyescas@google.com>,
	linux-kbuild@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	kernel-team@android.com,
	=?UTF-8?q?Andr=C3=A9=20Draszik?= <andre.draszik@linaro.org>
Subject: Re: [PATCH 6.18.y] kbuild: link-vmlinux.sh: improve detection of third pass requirement
Date: Thu, 29 Oct 2026 14:43:30 -0400
Message-ID: <2026-10-29-1-daily-reply-0023-kbuild-kallsyms-third-pass-6-18@kernel.org>
X-Mailer: git-send-email 2.53.0
In-Reply-To: <20261029-linux-kallsyms-fix-6-18-v1-1-69c5dbee4c80@linaro.org>
References: <20261029-linux-kallsyms-fix-6-18-v1-1-69c5dbee4c80@linaro.org>
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Post: <mailto:stable@vger.kernel.org>
List-Help: <mailto:stable+help@vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
List-Owner: <mailto:stable+owner@vger.kernel.org>
Precedence: list
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit

> Upstream 14b8b4bf2d7b cherry-picks cleanly onto 7.2; please apply it to
> the stable 7.2 tree as well.

Queued for 6.18 and 7.2, thanks.

-- 
Thanks,
Sasha
