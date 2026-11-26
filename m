Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=209.85.216.49
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1795671341;
	b=0AHV4eFzKap38YLLxsuJslBH9AWRU29wcKl7AVdBA6H9PF1j+GIzTwm0rhqp8YBYHLox
	 YMwMCTZ7B2ndx8+zzLWv6laxtErrCeRgiY2Qbnq94XbRyD1TRYq0NQZkgHg7NRRv2OINg
	 wlLcGbSKhHG4i5Bd3s5Y6REi4vVZutY0pmtQOfBjwh/L1BEcWm8mpbPezYUsP50VrxO/k
	 dT4zBlBQ/JPWTPTCgAwXLXHPjFN3Ul2UhCyDd2Iwet607ju+9WDILx8BFNpr4jFLjwB87
	 F2ZbXos1Yg+Z113k0MVUHs41v8R5SnmqtHxMd3FOiTbmaULDhVTI/s08WsF+yzIYiYw==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1795671341;
	h=DMARC-Filter:Received:DKIM-Signature:X-Google-DKIM-Signature:
	 X-Forwarded-Encrypted:X-Gm-Message-State:X-Gm-Gg:X-Received:Received:
	 From:To:Cc:Subject:Date:Message-ID:X-Mailer:In-Reply-To:References:
	 MIME-Version:Content-Type:Content-Transfer-Encoding;
	bh=t5d/xSmVguWHOOwwL11eA+wRkCdGaUqbRUc5A9MsbPw=;
	b=CiXjDfbrp+Miq37Y2g9/boZzRRxRdpWYcxxLu0Jptv1bc+1eD1eOyRV7Wm2CvOXE/lWN
	 Ork4Ch/p0jc1Jdu5IJ3rnDuZQINMVCOnwqmie//z5f15J9rhE3yOGfnzngSzFCI1UNCku
	 zY5A86cOLXsBfA0NAC9FCUujbx7bvJyGoTDAZkCBjTYrzaIu1V/eROisFxIzntApcaejs
	 ZV5L8XPSoZXk919/YpduL06lTIFT0xysnMYGXZjivqLTYUqHbAoTuEoHMYqyhmI9tCxHn
	 87qDPVpTsjSXVvU0YeCTsaqrL0IqtPvLAnWeEu2wd7aHsUF0C2dENjVJ9ismVaBgixw==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=gmail.com;
	spf=pass smtp.mailfrom=gmail.com;
	dkim=pass header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20260707 header.b=GVGnL+7U;
	arc=none smtp.remote-ip=209.85.216.49
Received: from mail-pj1-f49.google.com (mail-pj1-f49.google.com [209.85.216.49])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 10D0B606A31C
	for <stable@vger.kernel.org>; Thu, 26 Nov 2026 05:35:40 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 10D0B606A31C
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20260707 header.b=GVGnL+7U
Received: by mail-pj1-f49.google.com with SMTP id 98e67ed59e1d1-3b44bdcea8aso3738058a91.1
        for <stable@vger.kernel.org>; Wed, 25 Nov 2026 21:35:40 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20260707; t=1795671340; x=1796276140; darn=vger.kernel.org;
        h=content-transfer-encoding:content-type:mime-version:references
         :in-reply-to:message-id:date:subject:cc:to:from:from:to:cc:subject
         :date:message-id:reply-to:content-type;
        bh=t5d/xSmVguWHOOwwL11eA+wRkCdGaUqbRUc5A9MsbPw=;
        b=GVGnL+7UJT9jY2dL6VzbSLPqIBLb9sIj5YhMD/CLlDDA3i7geHCkqRYpuJLj09kXit
         B6f9nDRwQXa7YIOFgWO9q0BgH471cmq8gAY+EbjbXHEC9N8AtQ0MRNNdLEBA3uJqc2Bs
         fxdMq0UihvnkkQgKG9sjQ2j+i6SeMbHV9Tcv0YbPa3XyxRS9oPhnJcLkejiC3qMtKpdo
         thvOx6iBsraSSzjFtqMDh4iaLEpPjXYXyfNIxASts+8iJhpr1TbVQbqN+lBCkI0UjlHg
         98ulby1he/Mx45/k2l6rhztLYZopPx4vRcLixghfPp6cJU/WgilYSDPy3Yo62MY8zBUv
         FxPQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1795671340; x=1796276140;
        h=content-transfer-encoding:content-type:mime-version:references
         :in-reply-to:message-id:date:subject:cc:to:from:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=t5d/xSmVguWHOOwwL11eA+wRkCdGaUqbRUc5A9MsbPw=;
        b=UFi4nn4ZB4iNqLcUT7Zhbg4I6P0p4FSVs6XHly6cS/1WuhAPpHJ9H/DBXBO14kw/NC
         x5L5gM8/JzmlFxd8ZXHwrrBcUSuR16J6swMkH3hGk+bwExkefSUefiX2zqO0MiybcZGp
         TrYrfw5MCrFEIgPrn9yXVlOlHulGw0smDR9udoQfG/e7RsGvS4n3vJOHyOfXy1q6zWOg
         UKfvNXUzG85kFkkZbcHI8HDaojttmSv+xB/c52P6MoiuyYiC8MbOGmSlLP3iKzbjB4Ul
         VPnHrUOQe4JSOBk3d8sOtVJtBbMQOhsIJw+30c+aXRwbxbfbEf2cB67/uQKrpcM9WtEq
         mmHQ==
X-Forwarded-Encrypted: i=1; AL+hErHLbGJvI+uv2kDpf/ltEAb1LhJXUlxZMUaaLdZNPMLYPlWyEooWokZ3zwLR5tMNComm9RD7kmI=@vger.kernel.org
X-Gm-Message-State: APuU4Z9lRCpacGkoccJAB8Up/W4Km8h/NzHG1vpz+yAGRnc5s+M1/1h7
	mYDQjrEaggiQtVtROMjmA5398lugFMWadXBUmT0ZNj8S1M8wTtoH713l
X-Gm-Gg: AZFdTZc5FTmwj1efK890pml+skQkt/uRiTw8UwirW9e0SkyQvdi7zLVCpLTr2yeqSDO
	WUu6JAqFczuunol6zXemWxzOXS3Q3Iw61Mxh1QAa1CzVrmjzYVGBXvuq4+d0oegbDRbvQYX5UwM
	Q0ygSV0HMLCQRjwJ67ZM7V3yUmfTkREiauBg6eKmJqztAhU+mvwafLGNpnVqGgd3HIMF4PBBYyc
	wkRCDBdn7vLx7fhfrhVLmvzNudnjkq0rYdSeRrZoEDQ84hs9BT8ZlzoMjYy3NYbqTuwKvkpAnTb
	MVCCqe+XYfj1GXI9DvXMgRvlG+PfshoaHeDS4KcI0k/fnL7O6M6dhfUrbASv2R0Ub3ebDoNj1Uh
	N8NGyzMtQGxMH1VBUple25g+z8zis+C5CGcIFNqyhVgvcw7DiEX+PCIKHoaH6EYe7wRUpumC1cQ
	ltSzRYcB9EzLQPMWcU/ZZSbIfSIHhBTCcAldL1EZb05qNqc4Wm4Tjkhh1SduvfcEfe798HjikYf
	LsEnfg3iBVDOu6Fabr5OMdQnr3DwwPon2vt5teU6eTaydFdEv7BezQsI5mIsik0zRaZycjsb5+m
	CGwIXay58+etIhYp3REO4Q+VHDRT+wCnAG5lQb2e0NtrvTxQRTEVUrr/7Fn3/+SmOYu6n3DpIwk
	mBJ+02q0SLNx9cz4mtiT0SRQ8yanfZXZEDXAUl3ujX8O15sK7Gaue4fDgabiVTDqcNprmLD1clJ
	vPk+qtBbL20CLzzXQLsfIEurY=
X-Received: by 2002:a17:90a:e54a:b0:3b0:9310:b255 with SMTP id 98e67ed59e1d1-3b41c961506mr8969271a91.36.1795671340410;
        Wed, 25 Nov 2026 21:35:40 -0800 (PST)
Received: from kapoor ([149.40.62.11])
        by smtp.gmail.com with ESMTPSA id 98e67ed59e1d1-3b405d639fdsm34005822a91.10.2026.11.25.21.35.34
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 25 Nov 2026 21:35:39 -0800 (PST)
From: Arnav Kapoor <kapoorarnav43@gmail.com>
To: Zhiqi Zhang <zhiqizhangg@gmail.com>
Cc: Tomasz Duszynski <tduszyns@gmail.com>,
	Jonathan Cameron <jic23@kernel.org>,
	David Lechner <dlechner@baylibre.com>,
	=?UTF-8?q?Nuno=20S=C3=A1?= <nuno.sa@analog.com>,
	Andy Shevchenko <andy@kernel.org>,
	linux-iio@vger.kernel.org,
	stable@vger.kernel.org
Subject: Re: [PATCH v2] iio: chemical: pms7003: Reject frames with invalid length
Date: Thu, 26 Nov 2026 11:05:26 +0530
Message-ID: <20261126053526.623714-1-kapoorarnav43@gmail.com>
X-Mailer: git-send-email 2.53.0
In-Reply-To: <20261126052717.69095-1-zhiqizhangg@gmail.com>
References: <20261126052717.69095-1-zhiqizhangg@gmail.com>
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

On Thu, Nov 26, 2026 at 01:27:17PM +0800, Zhiqi Zhang wrote:
> Reject data lengths shorter than the checksum before storing the expected
> frame length. Keep other lengths up to the frame buffer size accepted so
> short command replies and compatible Plantower measurement frames can
> still complete.

Thanks for the quick respin. With num >= PMS7003_CHECKSUM_LENGTH the
checksum offset in pms7003_frame_is_okay() can no longer go negative,
and the 4-byte command replies and the 20-byte PMS3003 frames still
complete. Applies to iio testing, builds without warnings (W=1) and is
checkpatch --strict clean.

Reviewed-by: Arnav Kapoor <kapoorarnav43@gmail.com>
