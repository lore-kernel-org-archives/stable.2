Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=209.85.210.170
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1792572793;
	b=CTHL6/ZVHJTT8I0r+5gDCucmtoRf5DEZbdEDYbbyS+EW9dOmJhAvv7zdIJt3Q+y+wwCR
	 nkBh441vvo84Qr+MTixKItINgJG+x2bS0NZ9FTKFclz6/8fsB0dV/yg4s+iIT4+vNxqAr
	 Jr22NYasLJAJ2Yt+efbNz+2eGaATPg8duHk60N6mKkpaLKrJj9TsB1uBP/HiQFrr62Si/
	 CIuMB33OuhhkIgrYwbmGT3HL4ti6C+8+k9NfYFvhIfcxp43mT6bnmwySoKm5IfS2ymmXM
	 44tWApf5pPRf7BW5gfneKa6JPQctR2SngBV6ZdjdQZDaVTEN7kCpAgM98dyE0x/v/uQ==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1792572793;
	h=DMARC-Filter:Received:DKIM-Signature:X-Google-DKIM-Signature:
	 X-Forwarded-Encrypted:X-Gm-Message-State:X-Gm-Gg:X-Received:Received:
	 From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type:Content-Transfer-Encoding;
	bh=azsroOQy0D9NBLxIw8305L+Q5mbMoQP0E8Zku8I6kL8=;
	b=dUbMRwvtN2LEuprFp3viedn8eUv9+p9sCUlQinEax26iCt6kgtEov8aEFZvC1XAI/yuV
	 YSoG3DFFw+6aFDDblPuwmaqwEdFJGwk/5dTS2j00xqRjlrFab/k7u7I/pX2DiqJwNNvX3
	 rF8CfjRIwEfWbedSNPFmMU6OjBM5UHRMOF+PuqIF4f+arT/yQZhLvbXpCb/fG/45sH6rv
	 OuM6jnaR2mpiZJJrpOZaIxmnpk/FuqE3eKRIt8OoacceNDwhD1kD2CU8EqULja/uTOHzN
	 p16erWVUM9cZyI7uK4LUqRFpZISi/leRGdMz2EmHF6LzkzyvzdswX5S/ek/BFo7NZxA==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=gmail.com;
	spf=pass smtp.mailfrom=gmail.com;
	dkim=pass header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20251104 header.b=n4HxuxQC;
	arc=none smtp.remote-ip=209.85.210.170
Received: from mail-pf1-f170.google.com (mail-pf1-f170.google.com [209.85.210.170])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 04205606A31F
	for <stable@vger.kernel.org>; Wed, 21 Oct 2026 08:53:12 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 04205606A31F
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20251104 header.b=n4HxuxQC
Received: by mail-pf1-f170.google.com with SMTP id d2e1a72fcca58-8a06c60065fso340896b3a.1
        for <stable@vger.kernel.org>; Wed, 21 Oct 2026 01:53:12 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1792572792; x=1793177592; darn=vger.kernel.org;
        h=content-transfer-encoding:content-type:mime-version:references
         :in-reply-to:message-id:date:subject:cc:to:from:from:to:cc:subject
         :date:message-id:reply-to:content-type;
        bh=azsroOQy0D9NBLxIw8305L+Q5mbMoQP0E8Zku8I6kL8=;
        b=n4HxuxQCqnew/uzBCFBXl9JM/FUybwmzHZedUalx6HnPy+gFSnup1v1oIqINM9mG8d
         59xRtEIvffxG6LLWjFm8AUXTAmrL4WUHJF3SN+E/cQ5eQH6RUWLqkQvLGTSsx8u5P+2i
         S2rtHo16giWUSAKVEdIghcH7CB4oNU/mzZkNwqrjm0kGw0fbfBsnEh80sxE8ZaLlNufS
         +upD6IyYCtJRrvSuHt0tvukfn0Jm33m3QQj0cUvSifqRlAGyyiV33PJjHKeIitHk4rF3
         bO/w37mjmImsru0WB1Pgsus/ktsL+0vo1QW8KyeVsUozxup5sumLfhP928ov82sVx5vF
         7yWA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1792572792; x=1793177592;
        h=content-transfer-encoding:content-type:mime-version:references
         :in-reply-to:message-id:date:subject:cc:to:from:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=azsroOQy0D9NBLxIw8305L+Q5mbMoQP0E8Zku8I6kL8=;
        b=qxQVTW3fzAnK46AP9HbAi0JJ/5NvNwOy08C5H6pXW7ETaStsWbvXfdhoxuepBUFq/j
         7uPEkOtb9qPYmFm/xS4Hn7HCVdQRyECOqp7W9hsL91tzpIg7/T2+lZjYc9zVGNLxVylP
         STRDi7qvb3cN886U5CDYyg4uKUxPtKtLf7Z11Z5k2YgZDNYJSVPfSB4NkHzkvGFQeTqL
         DqYz9LfKMcBdf5oAzC5eacBZLwEHOebPS/+OEHYVrqwFHqjwxZluAfkdOgLityej+EoP
         VMNTCSzz2rKu/ewzgFKUMQLKPI44nHZW7KqMLKoT76YCpYMWz89ePDAD7dpYyOB1uHJz
         TG3g==
X-Forwarded-Encrypted: i=1; AKwUvBwoLinjS6SYIKDE9UzVjckjr2VwTUOJ3HY7u0bYD4eivfKVheczepvuxviTndlAoWPe1zoPR/M=@vger.kernel.org
X-Gm-Message-State: AFq9FYJuXoA/2DS1f25EIOyyJ2cOaYVVAkFE8bRqRcXuZCtOWlURnh67
	dG3fRL4vOc9euasfLAbS3jj8H8fYPBMx6hRi9+g82u5UzJkmDc98CBEq
X-Gm-Gg: AYBFou1fb8NWXEcY1SEO9Rbl1WnqBbI7Ku2l9TgC4HVLtOwGfLE4xcM0FOvXl0JzFbU
	XJ6PwSSS0CfDEweu+JVmko/WNNKrriNFgGdydYChp/xV2ZY4N2psId5YALEwJbsDj+Z50gMp/g8
	ECgFpqimc/cwO22V2R1+Vks7k/ooHEk92yc5acO7ezlbQYpsnTQ/Mixn4B7vvywnbYVc1/Htlrd
	kMO7BNODx3eWbO13Z5rlLx1F4UdhIrMGqqT3567WMCqgajFURqXurEkr6ogmfCUfuD8GMuXmxU+
	NDb15YjWXg1CyNEFJy3QcgpK7t1fOmpu5cqqR1TLfw10Ke0XlTw0/ktTGAieMjvnZaRAsSE7hDB
	o0NO3k/DuVPOBsMzdKF2gJ/W/28ZMDgVPZ1+uAyR4Tb37igFtWheifcEicG35ltN9dJ7hDIqf9/
	XUUmVtKxoPojxi5MfwNubxJsHB/suOmV1uaWuvsAYaptpNgkUqzuw0aryP0Ypvf8Mdk4PdukJmP
	DtQWz1G4+cNcSJxHZuUihEUENtLv2T3LY4L2AtM8l6pxbN/SD+Yim95F6BWiTjD/LQNGysmtp11
	rP4jOoZQ3VVMoRXXVfz8M5jSGmxC2AV0KFROlA==
X-Received: by 2002:a05:6a00:810:b0:8a0:2b8f:ba7b with SMTP id d2e1a72fcca58-8a089b82570mr1155273b3a.0.1792572792205;
        Wed, 21 Oct 2026 01:53:12 -0700 (PDT)
Received: from 675-reply.eml (awork131052.netvigator.com. [219.76.131.52])
        by smtp.gmail.com with ESMTPSA id d2e1a72fcca58-8a0895d8e70sm611023b3a.35.2026.10.21.01.53.06
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 21 Oct 2026 01:53:11 -0700 (PDT)
From: Yuqi Xu <xuyuqiabc@gmail.com>
To: Jarkko Sakkinen <jarkko@kernel.org>
Cc: Yuqi Xu <xuyuqiabc@gmail.com>, linux-integrity@vger.kernel.org, Peter Huewe <peterhuewe@gmx.de>, Jason Gunthorpe <jgg@ziepe.ca>, Jerry Snitselaar <jsnitsel@redhat.com>, James Bottomley <James.Bottomley@hansenpartnership.com>, stable@vger.kernel.org, Vega <vega@nebusec.ai>, Ren Wei <weir@nebusec.ai>, xuyq21@lenovo.com
Subject: Re: [PATCH v2 1/1] tpm: reject duplicate PCR banks in tpm2_get_pcr_allocation
Date: Wed, 21 Oct 2026 16:49:34 +0800
Message-ID: <179257257405.72348.17698648428918034727@gmail.com>
In-Reply-To: <ateJA_WanjASrIUM@kernel.org>
References: <cover.1790568982.git.xuyuqiabc@gmail.com> <9d27c4513a3c6fc32f9574ba192cd3bfcb2bac98.1790568982.git.xuyuqiabc@gmail.com> <arwssp0czGg9XKv7@kernel.org> <arw9CHc4mIOm5C6Q@kernel.org> <20260930033300.30295-1-xuyuqiabc@gmail.com> <ar8hhrjQQw_yfghj@iki.fi> <ateJA_WanjASrIUM@kernel.org>
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

Hi Jarkko,

On Tue, Oct 20, 2026 at 06:30:11PM +0300, Jarkko Sakkinen wrote:
> OK, so now that I was writing summary of TPM pull request changes, I
> came into conclusion that this is not a bug fix, unless you can show
> from TCG specifications that this is possible spec allowed behaviour.

I cannot. Part 1 identifies a PCR bank by its hash algorithm, so one
hash is one bank. In the TCG reference implementation, TPM2_PCR_Allocate
keeps only the last selection when the same hash appears more than once,
and TPM2_GetCapability(TPM_CAP_PCRS) returns that allocation. A
conformant TPM will not report a duplicate.

> So I can keep the commit but would remove fixes and bug related tags
> from this. It is essentially hardening and safety measure but not a
> bug fix.

Please do. Drop Fixes:, Cc: stable, Reported-by:, and Closes:. The code
change can stay as hardening.

> Do you have something to say that I might have missed?

Only that the commit is not on the current master after the rebase. I
can send a v3 without those tags if that is easier than reapplying it
yourself.

Thanks,
Yuqi

