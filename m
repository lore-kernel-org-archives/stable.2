Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=209.85.160.41
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1795018071;
	b=XsUWPmy1DQfOoPscl3mdfU9yI8WvL71o/gNNbWbhlBgTOMpJnqz4X2VdpA15q6HTr7qZ
	 KpqLOermpXPmy/40ALfFU0WKS6T83+tnY9cAu0t5HWwRWtn605hds0ew7JPzuWLrU/d65
	 wXsENBiRBJg3hOefrodENFYN//L5B9TcaFXicRELx2mTWvo71ra/nO3yQq5FORZBAG2w7
	 +CAPm33Hm0kD3laIqgmViXf217zVqdIaK47DkaTVhE4+WUQXKsNqiQNJq7rIPOHi09E41
	 C9YrfH6S5sFqitlXyWW/R6TEMOG82gIucEL8N8oWv8C2r1PQRTID9qzXYCz5n/mxzug==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1795018071;
	h=DMARC-Filter:Received:DKIM-Signature:X-Google-DKIM-Signature:
	 X-Forwarded-Encrypted:X-Gm-Message-State:X-Gm-Gg:X-Received:Received:
	 From:To:Cc:In-Reply-To:References:Subject:Message-Id:Date:
	 MIME-Version:Content-Type:Content-Transfer-Encoding:X-Mailer;
	bh=mrYL5WsZOMFb7NvjakVneJtwznSPE0xr2KZxBOzVkZo=;
	b=ebqzY3D5Xh5gYKV1770jKrL4aqMtYq0aXek7Lgqr+gZbifusAVai7+JiJG3xj3HmAhX0
	 u30o8hX+h+sflNX5PBwMA2j3UTOgimjF+XJ6HkpubZGqF78ki5b+xSYinynVV02Y+2c7l
	 8HhqGhW0n4A5lwsooLuWc+OmSF+itUjlBrQGBYYIRT/0ENSzxR5QHe54Yht33Slqt+ZUA
	 ggjjV7L2Ye7NFWT9vW3j1/zw6gHYkbRG9zxrInSpVzc0XRClg2xCUOSoNOdTRV48zF4Bz
	 H/j9SGuTzpekyeMhdawGiUBC1g+IuX8NfTFpK5Ovi0R+3CvVuT1/G5QksvJHtMyp4sw==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=none header.from=kernel.dk;
	spf=pass smtp.mailfrom=kernel.dk;
	dkim=pass header.d=kernel-dk.20260707.gappssmtp.com header.i=@kernel-dk.20260707.gappssmtp.com header.a=rsa-sha256 header.s=20260707 header.b=YVWFu3ON;
	arc=none smtp.remote-ip=209.85.160.41
Received: from mail-oa1-f41.google.com (mail-oa1-f41.google.com [209.85.160.41])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id EE98660A5BC7
	for <stable@vger.kernel.org>; Wed, 18 Nov 2026 16:07:50 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org EE98660A5BC7
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=kernel.dk
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=kernel.dk
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel-dk.20260707.gappssmtp.com header.i=@kernel-dk.20260707.gappssmtp.com header.a=rsa-sha256 header.s=20260707 header.b=YVWFu3ON
Received: by mail-oa1-f41.google.com with SMTP id 586e51a60fabf-451a49abd8aso1040640fac.3
        for <stable@vger.kernel.org>; Wed, 18 Nov 2026 08:07:50 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=kernel-dk.20260707.gappssmtp.com; s=20260707; t=1795018070; x=1795622870; darn=vger.kernel.org;
        h=content-transfer-encoding:content-type:mime-version:date:message-id
         :subject:references:in-reply-to:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=mrYL5WsZOMFb7NvjakVneJtwznSPE0xr2KZxBOzVkZo=;
        b=YVWFu3ONxADGZ1TCzNmmfe+iJS+iAMFchsUFgHqzrvGIenRCDA4yP0OeY5oGrttNMO
         slJiHcrBn4vK/OV4Wj1DXmiXQTMopiStBWArmcGzgF7YPGXGotfzkocwp3jfK/TMFmLv
         5Srg0A+SCJ+yXZRjjB7WCNe92jb0tltS5owxk0CfeBFdxEYmicaKS/5NvO1E8+CkTvBP
         tM1SjaPJ0iIQvMPxRcW3zVTg2o7DTQyMrnEDmLqFRbXTUvZVqw8ax1qdp55nbqGe6O1n
         OuZE5ZhthBEmxFctu10N1GS7oELzDXglU8hg+s2DO4/MNTnU2gWgaty6KW9J83D5xh6e
         iXjQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1795018070; x=1795622870;
        h=content-transfer-encoding:content-type:mime-version:date:message-id
         :subject:references:in-reply-to:cc:to:from:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=mrYL5WsZOMFb7NvjakVneJtwznSPE0xr2KZxBOzVkZo=;
        b=BeQ3VvVPolLzXJrSClSGTlCQC7v5D8PkoiyriOchnFJVvpV1Ge/wkk6c0kX8yKZ+4O
         AqPZ6HRo3+hFpemulXDJM2GFJ4oDnW5yT9Wobu/7SFNp/I4aeDQMuoDtV1FfzoroiB58
         TKslngViM7JKnjN1iQgiNBA6JBOoHPfoOXa7kkd4dJn5PqwdTUbS44bf5XVx0mE3q5VN
         fui9ZjBIpxQ07F+kiw8UDPyBfU4Mx/yGknJFl08R2Air1QlDzVUnK4k4vog0rrKQreOv
         +tyzofSimccsdNE0gGlQbipBp3ProrDBYMh/Q5/L42mTvYf0WwQV1fYDA7rYNpuEXMzn
         eyOw==
X-Forwarded-Encrypted: i=1; AL+hErEWFi9wykM1sezeGA3TO9jlIbYW3IQb3CFnFu+RYEyY3Bqr3V64XXBtDY4noiBaVQX1cqnthSQ=@vger.kernel.org
X-Gm-Message-State: APuU4Z/ZbTyHyUKtXSmyUknisfj3YASR3OH7VmtMmhPbfm/xhPC2t8vZ
	DLwO0OdhRTHyPeBqjcawTMzidvPPb+T9SdyydRhXWi8PuZyyDdRt8HVoxFFNjKyK2BE=
X-Gm-Gg: AYBFou2dR3yOjHuFKhYNAPRKFmIeooOEL/HsIhtqqWhiboz1CdAb0RySWRCGsHADjcH
	Dg38uvoQXVvqYPAQYiO1Pnq81+gEu5mXQzeNw1qahKyNF7eoXgjjfmajt+agHWI78rNb7aFRfac
	hF5euseEkF00oDJqOHapn+5K0tSvclz0v85EEnWBWIVZYmFbdki7V8tA3rbLurOGj7A9p1pVg4n
	oDoI1mZ990/99aVCCoQz7omMBkdJ5XEl9G9fugML/DUrUUvEzYuNpqk/05zx066Lascc2lUHgeA
	zF2TMRwFztyBPR9pLUrANeq3sbn7kbIxdMfE6ddu5eNDtYjqlwyQeZrQozWvAb1CJx/1cRZlXVr
	cjqkiSXxIjc9qraXuvc3SX9or1NEwT6Dr/8+KrOeTWjq/u/EQRJrA4G3I5GMMSRFsWy7qcapITV
	+d5rTt3cx1vq5T+oreRU4uJ5JdUl3WJKU6a19SZMB+y0C0nMnKa0NMU5KFKqJbmywRuKMMz5LDu
	7kU+IB/giR25mf9t9+wJbTD4XEaKKVeLhvMg1GeCvz8ujRGNsBIbzqDRXQAn5fu7jiEdrAvzPE+
	sl6Un0vnc5Ad4/J/hyMCp1yC/YuzD0T4uQ0RjLQhAhPyVEVkc9OTDuzu+2gFZKdLlod/l6AEFWu
	N59y6sa6+kI/hZDph4WFrIX8pO958x8rOCkRKfTR4EygmlQEnSCk=
X-Received: by 2002:a05:6871:2ee3:b0:4a7:4324:1807 with SMTP id 586e51a60fabf-4b75da54ef7mr2618439fac.12.1795018069724;
        Wed, 18 Nov 2026 08:07:49 -0800 (PST)
Received: from [192.168.11.112] ([96.43.243.130])
        by smtp.gmail.com with ESMTPSA id 586e51a60fabf-4b743721fe9sm2624231fac.6.2026.11.18.08.07.48
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 18 Nov 2026 08:07:48 -0800 (PST)
From: Jens Axboe <axboe@kernel.dk>
To: io-uring@vger.kernel.org, Mikhail Malyshev <mike.malyshev@gmail.com>
Cc: Pavel Begunkov <asml.silence@gmail.com>, 
 Felix Moessbauer <felix.moessbauer@siemens.com>, 
 Josef Bacik <josef@toxicpanda.com>, linux-kernel@vger.kernel.org, 
 stable@vger.kernel.org
In-Reply-To: <20261111162705.1150983-1-mike.malyshev@gmail.com>
References: <20261111162705.1150983-1-mike.malyshev@gmail.com>
Subject: Re: [PATCH] io_uring/io-wq: apply the current cpuset to new
 workers
Message-Id: <179501806843.17649.11773219766773468762.b4-ty@b4>
Date: Wed, 18 Nov 2026 09:07:48 -0700
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Post: <mailto:stable@vger.kernel.org>
List-Help: <mailto:stable+help@vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
List-Owner: <mailto:stable+owner@vger.kernel.org>
Precedence: list
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
X-Mailer: b4 0.15.2


On Wed, 11 Nov 2026 16:27:05 +0000, Mikhail Malyshev wrote:
> Since commit 84eacf177faa ("io_uring/io-wq: inherit cpuset of cgroup in
> io worker"), io_wq_create() copies the cpuset of the creating task into
> wq->cpu_mask, and io_init_new_worker() gives each new worker that copy.
> A cpuset change, or a move of the task to another cgroup, updates the
> workers that exist but not the copy, so workers started later run on
> the CPUs the cgroup had when the io-wq was created, which may since
> have been given to other tasks. Workers come and go for the life of the
> io-wq, and a worker that cpuset moved is also retired at its next idle
> timeout and replaced on the old CPUs.
> 
> [...]

Applied, thanks!

[1/1] io_uring/io-wq: apply the current cpuset to new workers
      commit: 0659e44ce739ecd856164c75a5325b7959a2921d

Best regards,
-- 
Jens Axboe



