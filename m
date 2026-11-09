Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=100.103.45.18
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1794239648;
	b=OLuJaNV6HOnUN4qZqgOrL7wGyTQSP2IHbG4MC8+9TEyAoxPhocpSvFPIMSWjBYFksN2x
	 0mhvtvyT1y9RFDM6cBbFp1/dGC7td+tTizVqNYHGwmGmGRLxFeQ6+xqPkY6gwBf7VoOHR
	 eNcRoh14sAz7sYuV9UbZKB0XA/ufopWs8WdpAynj7HhQ5Ob1fIzJ9ig3arjhSl0tuOgCC
	 3P3/MCaxN4/e3/kAnSN6dACyV7JFXBUv9DeUpXbDc4N/L4yHs1QiCbIt/5NWeU6nJ4UB4
	 ZUWh/IdImzmEpHUFwVvh5gewWkR9drcb18/YqZWiG4p/nId3v4x3xkFaDQvtka1WVZQ==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1794239648;
	h=Received:DKIM-Signature:From:To:Cc:Subject:Date:Message-ID:X-Mailer:
	 In-Reply-To:References:MIME-Version:Content-Transfer-Encoding;
	bh=Hdf6vMuDaVloj7wof0JwV7vAQHSJ53SjXTWFkPKKVTg=;
	b=tMQ5//ic49Ts7JVKkbrTcOsImDqcL75kSDeByjkDKI6FSb0hQ7TZTce0wIOwmO1K/Kuk
	 BZOeGkfdKSYewCHq1eASq6thVmrQY9HDbDeVPZVXgcXQytc8uPYMkfUOg+tBwF8fzv3Hz
	 98uHYh+6XuuJYNHdELUCMvPIL/fPBGN70CiWLwTLtTrhdn8gbGNl9pKk14aNEt1YvSub+
	 aoo+k41yn62zzhbsB0QfMjECvpQA3A5k69RTV8ob0mytxDROtsKF9gEs6rBHzK1dXSExT
	 Uf+n179tc6kIZMkEDU0fCAzzb2nwKmFjOjkJKgsx336RL01XO0erLOTNWcFQz7J7lFg==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dkim=pass header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=OaylF9Js;
	arc=none smtp.remote-ip=100.103.45.18
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 71E79606EE9D
	for <stable@vger.kernel.org>; Mon,  9 Nov 2026 15:54:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=OaylF9Js
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 758CA1F008A1;
	Mon,  9 Nov 2026 15:54:07 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1794239648;
	bh=Hdf6vMuDaVloj7wof0JwV7vAQHSJ53SjXTWFkPKKVTg=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References;
	b=OaylF9JsHU+DjDXU/kYbYBeOno+KJdadJGyaU4B4DipgnesossM6VwJwKreOunK50
	 PS2CQZDqO8hudh/MOJaeDOtollqACXCT36DvdcQf5l30gjcwb9uu7C2UcxvG5NvO0Z
	 0KFcuPzSxwvCGlSPgofWL/8xCDWQMUkvonbL3/M7ZTn8seB8hwT3gv1bW1JuosYtxJ
	 eRrPDe8UdMpLc4jZZ9uSV1OTaQazbEe/l9ZbOCqJE3awguTPER9XOWjMnKeq6hZw6f
	 YZeup5L+VLfANeDlY5ByMatv00l+ACGnMwlau2c54Dz58DG4uUo6ubZATIaVHzu03H
	 +jHN2ZxKMo9Lg==
From: Sasha Levin <sashal@kernel.org>
To: stable@vger.kernel.org
Cc: Sasha Levin <sashal@kernel.org>,
	liuwb@xiaopeng.com,
	Mark Brown <broonie@kernel.org>,
	Guanglei Zhu <zhugl3@xiaopeng.com>
Subject: Re: [PATCH 5.15.y] spi: amd: fix len==0 underflow and FIFO overflow
Date: Mon,  9 Nov 2026 10:53:23 -0500
Message-ID: <2026-11-09-1-daily-reply-0041-spi-amd-5.15-5.10@kernel.org>
X-Mailer: git-send-email 2.53.0
In-Reply-To: <20261109030623.419563-1-zhugl3@xiaopeng.com>
References: <20261109030623.419563-1-zhugl3@xiaopeng.com>
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

> spi: amd: fix len==0 underflow and FIFO overflow

Both the 5.15 and 5.10 backports delete "message->status = 0;" in
amd_spi_fifo_xfer() with nothing replacing it. This driver uses
transfer_one_message and the core leaves msg->status at -EINPROGRESS, so every
successful message would complete with an error. Please keep status = 0 on the
success path.

The per-transfer FIFO bound also does not cover tx_len + rx_len, since rx is
read at FIFO_BASE + tx_len + i.

Could you send a v2 for both trees?

-- 
Thanks,
Sasha
