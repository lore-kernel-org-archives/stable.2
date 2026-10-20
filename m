Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=100.103.45.18
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1792459338;
	b=hRmCKyMAB+0ueumSeM2TfeMbB9vhQ2OYmXUZXxJ6GvaJB1cWYUlV/oV2kI51I3LoST2D
	 voWYaYFJkoLnEESazJlmNlNbIbcHfVyPxHKPvtQaKKP05nVfWirFbdSvI68MmTt91RcqD
	 QPWz3zxC5Yq93lTU01/7dMMBmCZe+Vmjj8sMdhEMb3FXxHAr2p2fKRd2OOgpKzV/F7AG1
	 pIe09RtWTGAvrK7KeGCXGdF8hRlS1Ekgpnayd+mI4CyuZr3sg/xDHmV+o2kRP8ZdpWRmP
	 PNRvLEijRByTWtBYQ6s20dGKYWpDPe3Zp8fj73PiO8hPJXUnl4Udma+cJO7SYZL3DTw==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1792459338;
	h=Received:DKIM-Signature:Date:From:To:Cc:Subject:Message-ID:
	 In-Reply-To:References:MIME-Version:Content-Type:
	 Content-Transfer-Encoding;
	bh=8/YceKJZmT1U4bJ9tUqkAL9T6oiqubdBaipQf+wYmUk=;
	b=BNFH5kO83C2FelZDmPEwjfbzrElPgcgd2qEXf3Ctv9M21EjngLn5pn687u70/3NPzV+t
	 pB+GZt4azCp+q1aC/7jdFJQI6joSuanUM6L/Ui40f0UPe6OTiX/pOKxTcyAOVKmHKuxg2
	 GPNV0NUN+eyZ0h5Cgg2rouQNv/1azdNfFD5vthNxJCb0dyGwe85NmEkRGknn9sg1I0pxp
	 /XNs326eGl28UAykhABQi/hppRAi6+bvuHSzIWRILQ4ksGoicwOoTro4bM6KTxE78pVcA
	 FioJfUPAwNnivizqngE+N3Jcseh4qug94YoUe+0o8cfmdJu295Bcm+A70BD+sM4xmsA==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dkim=pass header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=Yw8SkhYg;
	arc=none smtp.remote-ip=100.103.45.18
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5322A606A319;
	Tue, 20 Oct 2026 01:22:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=Yw8SkhYg
Received: by smtp.kernel.org (Postfix) with ESMTPSA id A16551F000C4;
	Tue, 20 Oct 2026 01:22:17 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1792459338;
	bh=8/YceKJZmT1U4bJ9tUqkAL9T6oiqubdBaipQf+wYmUk=;
	h=Date:From:To:Cc:Subject:In-Reply-To:References;
	b=Yw8SkhYg21/9hLQYjlTg0d0dw5naaNPd2jsEGKqHvXAbM3kmrN0bIkma5ZRscPx+B
	 TgKLP/+b9GRixlfxnvOhLmsdrIHLhu5u1Y2iMEqjelzhawuadtnPaG1AJr/0zCb1k4
	 7DysJNB0n/6lQhU9LUp0bOyV1iy9+xJvYPoRqRDeTMn6Ru405ZoD80Znb8025ViDgo
	 E/Ari207Oi2+bkVtAt6Ip9bWb/0Xg3PpCbMcS75pWr0GD45vlZ3RmRLkubhyJozLZY
	 FfUC2CXl4YiEx4pch/t+cWRbBTNVqwZ+ZNsdyFzeHLKF0c6XWvxj6eYavhuArNWWUi
	 fyP4OB8sLwJQg==
Date: Mon, 19 Oct 2026 18:22:17 -0700
From: Jakub Kicinski <kuba@kernel.org>
To: netdev-bot+sashiko@kernel.org
Cc: franck.baur.67@gmail.com, cooldavid@cooldavid.org,
 andrew+netdev@lunn.ch, davem@davemloft.net, edumazet@kernel.org,
 pabeni@redhat.com, netdev@vger.kernel.org, linux-kernel@vger.kernel.org,
 stable@vger.kernel.org
Subject: Re: [PATCH net] net: jme: keep RX MAC clock enabled for WoL
Message-ID: <20261019182217.18e26e57@kernel.org>
In-Reply-To: <179181078924.434549.16666867636447785126@kernel.org>
References: <20261011-jme-wol-submit-v1-1-9cc033e259e4@gmail.com>
	<179181078924.434549.16666867636447785126@kernel.org>
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Post: <mailto:stable@vger.kernel.org>
List-Help: <mailto:stable+help@vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
List-Owner: <mailto:stable+owner@vger.kernel.org>
Precedence: list
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit

On Mon, 12 Oct 2026 13:13:09 +0000 netdev-bot+sashiko@kernel.org wrote:
> - [Medium] The patch turns the RX MAC clock on before arming WoL, but
>   resume never turns it back off.

sounds legit
