Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=100.103.45.18
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1795705095;
	b=Bt1eeHRPmJmxUXjcHUZwP+jR2Rvf/qtZzZP8MlDlNz/cg26p9jnE9oSGtHfoOtWxgn4S
	 Pga2Cymqgn86lnnrO+CjQClgSFfTBbsppvJdggIvnw4gPLz00E5bIzNXPOZZ2tPkGcGZs
	 iE+nNbsm7SlHJOhk1m3dtXq09qEG7lFWhOcOXQrf1iKKih489RxZnpEomJrfI4oFErCpe
	 1TGRYeAaT8Yvw+5We8AHkU/BwfPLr8gQ1rjPs+4O1nJf6KCm7osma7enV9QnPYlg7UaXB
	 IbxF/iRBAezkc2DZFhoA9IEScGX1OD2zoIu3e9T5wcgM2XImEB7Nao5MzTSJxz+hPYg==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1795705095;
	h=Received:DKIM-Signature:Date:From:To:Cc:Subject:Message-ID:
	 References:MIME-Version:Content-Type:Content-Disposition:In-Reply-To;
	bh=X91XRJns01zzAP7u3wGVGoHNNV7Q7cA+0pT6Sq5Sc3o=;
	b=QjCGmdbYGgCFK4fNrfMKF4P9opYW/cuUEp7jZU9lvAQ7h/zPlURr0JoXm+PonFd/unLX
	 LUg4c0VDb7gd5lk/lSFdot9R+Jn+bEh/WI0Z3NtWcJTc43759Y7plWCsIPUBxJ+qlif9x
	 uPOgDkDE2UUDx4S3mBstz7LcymwgO/QKzUoNP9skTcBLaO2YqlLodWiL/YDjkIhTPwIqy
	 uAbF93RLUanGfoYrbcfImI0aJBW3ovJiRxdPusX3ww6S0hyZg8cOerus8icksuS8JLUOG
	 I7Hnae0H1e4AF5HW0MY7t38BBpVGBxQVr4iRAMYFZ4aMqjQBeJ1gAHpc7w/QqKA8s4g==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dkim=pass header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=VLKHpz8u;
	arc=none smtp.remote-ip=100.103.45.18
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with UTF8SMTPS id 5A426606A31E;
	Thu, 26 Nov 2026 14:58:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=VLKHpz8u
Received: by smtp.kernel.org (Postfix) with UTF8SMTPSA id BF7041F000D1;
	Thu, 26 Nov 2026 14:58:13 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1795705095;
	bh=X91XRJns01zzAP7u3wGVGoHNNV7Q7cA+0pT6Sq5Sc3o=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To;
	b=VLKHpz8uhxQaP7WWnd4H48X48aeyaVf5PX2ry3tKuARfqZaj5xHVUb0iWIU4/gn0d
	 6PQQPr9/u8Jz3hAhT+pBlEt3DkLkOvLXUYZPudwjGTBTTNsw+tqs6KUs3RBOX2Ffem
	 AL6cQb2XURKnwKOwjHrk1uY7o/9entiT/qOTWnzcb2IuG6tbZmc/6Y9+4SBqq6Gbrh
	 ycGBWOHFK7tbV3jyrB0hhHDW/G3E8z00lJfgLoYv3DUxaByFSD4UL8weDQaMEBGYps
	 a2oQzd2rPZ7WNGLwLvdxYyzH4VWv7kMoq+BCIX5+HOyV1qjmCWt1Qa+Yhp2T+3DGk7
	 zmwHSW6hT5E+A==
Date: Thu, 26 Nov 2026 15:58:10 +0100
From: Bartosz Golaszewski <brgl@kernel.org>
To: Daniel Svendsen <das@emlogic.no>
Cc: Srinivas Kandagatla <srini@kernel.org>, 
	Bibby Hsieh <bibby.hsieh@mediatek.com>, linux-kernel@vger.kernel.org, stable@vger.kernel.org
Subject: Re: [PATCH] eeprom: at24: wait for write cycle before releasing
 runtime PM
Message-ID: <i5btdjlga6tqxjjyeb2kkvhupuojdnbyotkyl3x2k7naocp2o7@fqrz6ynav5ig>
References: <20261126-at24-write-cycle-v1-1-ec9c38617130@emlogic.no>
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Post: <mailto:stable@vger.kernel.org>
List-Help: <mailto:stable+help@vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
List-Owner: <mailto:stable+owner@vger.kernel.org>
Precedence: list
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20261126-at24-write-cycle-v1-1-ec9c38617130@emlogic.no>

On Thu, Nov 26, 2026 at 01:15:35AM +0100, Daniel Svendsen wrote:
> at24_regmap_write() returns as soon as the chip has ACKed the
> transfer, but the EEPROM only programs the data afterwards, during its
> internal write cycle (typically up to 5 ms). For all but the last
> chunk, the following write is NACKed and retried until that cycle has
> finished. After the last chunk nothing waits, and at24_write() drops
> its runtime PM reference right away. When vcc is controlled through
> runtime PM and has no other users, at24_suspend() disables the
> regulator in the middle of the write cycle and the last chunk is lost,
> while the write is reported as successful.
> 
> This was seen on a board where the EEPROM supply is a switchable
> regulator used only by at24: 32-byte writes with a 16-byte page size
> programmed just the first 16 bytes.
> 
> Wait for the write cycle to finish before releasing runtime PM by
> doing a one-byte read of the last written address. at24_regmap_read()
> retries while the chip NACKs, up to write_timeout.
> 
> Fixes: cd5676db0574 ("misc: eeprom: at24: support pm_runtime control")
> Cc: stable@vger.kernel.org
> Signed-off-by: Daniel Svendsen <das@emlogic.no>
> ---

Reviewed-by: Bartosz Golaszewski <bartosz.golaszewski@oss.qualcomm.com>
