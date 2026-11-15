Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=74.125.82.177
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1794757376;
	b=DZ4T6IgC7Nk/O8J+8eegqgdONuLMnUM1/ZP1RQoh39NG6andZsJEf3f2Y3xBJLRtLfeD
	 vz10Sf2cB4ZepEovYuGIHT90MbfPss8RC8MOJCn0r+klc0vZmnVWNql4Jhj/nDnLqkVbj
	 6NoMDccZPh9SpENZvvTbmpCuXakyy7NmHLR8vrEs3P7Dr6DpPbTopsknKy2Y2Jh2x3UtS
	 pzUpT4YchjmRF4wZRoYg9qH38TWSVRSPk8KlY0wLeYjtgKH0UNUkXgX+mCbw9/09NA36c
	 4THuJ07c+nxj+0/NL9GVRvpwz3pAiWV83n+/9r9NVfC+2MBzjA9gtI2dsPhz+2th6nA==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1794757376;
	h=DMARC-Filter:Received:DKIM-Signature:X-Google-DKIM-Signature:
	 X-Forwarded-Encrypted:X-Gm-Message-State:X-Gm-Gg:X-Received:Received:
	 From:To:Cc:In-Reply-To:References:Subject:Message-Id:Date:
	 MIME-Version:Content-Type:Content-Transfer-Encoding:X-Mailer;
	bh=DejR3krB2UUOuNcnZkNWRCdn92MbyftYbWjEZOleI5Y=;
	b=u6rl3KmQgZ+wKmz5Td398RdjmKjpUQ5djYmrbygTs41WHmPSg0ppMCPDNaKPD10qqnWm
	 eT7vPGsDJJdv6m+qgEChgSODH8TXAumfIv/1B7pDuiYNK/I1BMda8PY1mbYeIu6NLeDGH
	 ldj0BMIVU8LzazMG/za68oP5E/iQKFYThEPPRqP2XwupW+h3V+vpDWIqwX/81BJOscx0I
	 jXkJX62JLdgzF3sia2trjsRkUlYC/XNWeH/WPzPv3W5Cx2N8JGzaUAg6hARDQcS32oTDc
	 CSmj/jBczQ/b290wlLVXkGrKo032HjdiD63uU7yFpYkXyJInsIGEEB0jQ23RgWQ1cXw==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=none header.from=kernel.dk;
	spf=pass smtp.mailfrom=kernel.dk;
	dkim=pass header.d=kernel-dk.20260707.gappssmtp.com header.i=@kernel-dk.20260707.gappssmtp.com header.a=rsa-sha256 header.s=20260707 header.b=Bqsx4zwI;
	arc=none smtp.remote-ip=74.125.82.177
Received: from mail-dy1-f177.google.com (mail-dy1-f177.google.com [74.125.82.177])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C4249606A32F
	for <stable@vger.kernel.org>; Sun, 15 Nov 2026 15:42:55 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org C4249606A32F
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=kernel.dk
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=kernel.dk
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel-dk.20260707.gappssmtp.com header.i=@kernel-dk.20260707.gappssmtp.com header.a=rsa-sha256 header.s=20260707 header.b=Bqsx4zwI
Received: by mail-dy1-f177.google.com with SMTP id 5a478bee46e88-37f14feca60so267406eec.1
        for <stable@vger.kernel.org>; Sun, 15 Nov 2026 07:42:55 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=kernel-dk.20260707.gappssmtp.com; s=20260707; t=1794757375; x=1795362175; darn=vger.kernel.org;
        h=content-transfer-encoding:content-type:mime-version:date:message-id
         :subject:references:in-reply-to:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=DejR3krB2UUOuNcnZkNWRCdn92MbyftYbWjEZOleI5Y=;
        b=Bqsx4zwIkginSB1+zS+iluuGCfsoh1lrWajyafASq7xICgRjN0kfnmGca15hg2kFDO
         zGLbMdOzRdMez5mqA7M6NRrW/2rPqwFQRH59SPER0s+ejRC3ZatkxI1kQhoF+C2f9eLs
         hTf8xRi9NdWyUvE9Hsl0gNkRYU5b1VXB+zpTf2a9FpwTTIFXT8dO577Krmi6HQs5l0UY
         gdYwSFY6GxIxcxenzWpXUdgNsVAS+GG/SAOH+YwLn4cIH8oMz99cTANdyFo+7A3V/CmP
         bQWbxa+vZv5LF+BswRa7OdGybOcMw2STtXJ0u3oEhiIyM+U9ssnyfUhDjfFk7rrQl9iD
         Z+gA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1794757375; x=1795362175;
        h=content-transfer-encoding:content-type:mime-version:date:message-id
         :subject:references:in-reply-to:cc:to:from:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=DejR3krB2UUOuNcnZkNWRCdn92MbyftYbWjEZOleI5Y=;
        b=xyHoZm3+983pJveq0K+VPtNWzwnIescYg8rE73BxpKvB8v4dBc4JN92hRU5k3dALxl
         DjNL3x4icHhkxHXrbxuZUawKihn82W4/SWp6h1cplP92P3aGzM6lLEf2NLP+qt94/KpF
         9eBWq2AxlwKsolCqbTQEO/NLfDC5WuWN1sheX0nA0jBnJLD6EslZuny81tcq5ADQN/8k
         XHZPRBq062dSORNSK+5hVOq+Hy3VyuKsYsKXsQQG2d2RYvZkHMurosFU4tLYRP+KprnY
         RFvRFm+sWwWdSd4BfMLqqBb8fjdaKKvAqSQR/wpkixtlSh3U4/eL4IirOSQLcCqHYtvB
         iy2A==
X-Forwarded-Encrypted: i=1; AL+hErHAfVwxaZtKYguqMKQJv4hWTNAr5u0U7UEEYPNmjzhI4tCwKJqnIlYu1OhWEBNHSWt6ayROC/A=@vger.kernel.org
X-Gm-Message-State: APuU4Z8wch4eA/rCikSG13MdOyWwbIY6N9Nt4n30+jJTcLwbAuSY0cx3
	c5Shiy71j3kKIXK13O2dmGxzhLKYZWkED4pibI9YkUUPjBQj3EhIFBVyCD6IZv6Lk2w=
X-Gm-Gg: AYBFou0oATVnPBLgu8ftUd7eOmYCCvKLLBbuZxLzVG5LqMj9ByZ45rPitF/RqJJleJG
	+1QjZxAYZxWNtb4f0e/WU8VsL7rWKebyaYAJkGOVCVBTBV38owlouFF2D1bMTkiewwK9hVNMFqz
	HGzt97NbreV88O3bN7HBvACsOyZMoJ/zv5Y2FXCs/kgc9NHVm7ofl1nCtO2+ElYwLZzK9dYki1A
	SXq8ZOKjyLtPa7iAtPATEIncAfeUWdYMvsSM04WRiadkg+UQAIRYsPuRdGniI2Sj1eANM6dUtik
	yffFhgYvjQK2UDtiwM0Ri+Lwmy+de69eML6FC1DzauEniyKiWssA7lWYdf0+hQQA2tWE9NEO4eT
	5Q6h+RefugRPmWEUR0qV7TbGvbA5DUTTDTm8TgW15IVdA0cm4u1D3SN+hFNi9BxtiJ8m4aVE2BQ
	SzmijJ5ngpHWzQlh5L0/MBiVhYZbajtHsfw5cPEPRhIw0FTLquZbN2jJetTQZfKR7m7I8LwL218
	uiDbYG9iuOoo0RQ/VDtHftX5SzH9SS8UWhIVgeOBUeQrJ07jFcFcPOBw58xwYhFxq8gzIgdfnF5
	ST9pUbc6CKrNJaTESDsZ+qKt09dO1jX8ShB7jASZrFsXHZuUW5IG0qVdb4WIYIyugql9l+C5TLw
	01k2Sd50UIgb1
X-Received: by 2002:a05:693c:69d0:b0:36a:15ee:c20e with SMTP id 5a478bee46e88-379675fd90bmr8136632eec.33.1794757374739;
        Sun, 15 Nov 2026 07:42:54 -0800 (PST)
Received: from [192.168.1.142] ([198.8.77.135])
        by smtp.gmail.com with ESMTPSA id 5a478bee46e88-379558231eesm25665134eec.12.2026.11.15.07.42.54
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 15 Nov 2026 07:42:54 -0800 (PST)
From: Jens Axboe <axboe@kernel.dk>
To: tom.leiming@gmail.com, linux-block@vger.kernel.org, 
 shao.mingyin@zte.com.cn
Cc: linux-kernel@vger.kernel.org, stable@vger.kernel.org
In-Reply-To: <20261115003352168cE_tyVxSyZV124AM31htL@zte.com.cn>
References: <20261115003352168cE_tyVxSyZV124AM31htL@zte.com.cn>
Subject: Re: [PATCH] ublk: dispatch the next fetch after a batch failure
Message-Id: <179475737404.32615.15503411123776192792.b4-ty@b4>
Date: Sun, 15 Nov 2026 08:42:54 -0700
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


On Sun, 15 Nov 2026 00:33:52 +0800, shao.mingyin@zte.com.cn wrote:
> When a batch fetch fails, for example because its provided-buffer group
> is empty, ublk_batch_dispatch() removes the failed fetch and returns.
> Pending I/O tags stay in evts_fifo even if another fetch with usable
> buffers is already queued. With no new I/O or fetch submission to select
> it, that fetch and the outstanding block requests cannot make progress.
> 
> Claim the next queued fetch under evts_lock before completing and freeing
> the failed one, then schedule its dispatch in the proper task context.
> Marking it active before dropping the lock also prevents cancellation
> from taking it before its task work is queued.
> 
> [...]

Applied, thanks!

[1/1] ublk: dispatch the next fetch after a batch failure
      commit: a6f37fb3f5747bb7cca5cd6630dfeea4435022a1

Best regards,
-- 
Jens Axboe



