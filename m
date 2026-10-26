Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=100.103.45.18
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1792982318;
	b=xYAdviwjFKQo+BO3gp+iQSdAJy6BFY/KoX5PR3Nj1RIKFzkk+6I68Oj99Z/vjoP4AnkJ
	 HhGhH6PfRXqKzn4DmfMpVC9/JHNNc/ipbvwV6iDg6d1w/e8tNyuzecuwLVxDc9H4bAYvs
	 1VSvMRyIjLluJN3gCR5C1cGV3ZnkBuW9IvhJI6Yyfc7VUONVv3Bu3htq2xCsMOc+fb64b
	 DNdJJ78FVPD6E3ShG4n53IYtSZVKRoENHJv8UoIG/VfWwVlCBlhgaoadMOcxY+3UcAEVO
	 yBRldVnSAuDZ5OWZZtkkiDOq5re04yHtZrzetRtdndkNKIfoonjwl8nsC96GT/b6lPw==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1792982318;
	h=Received:DKIM-Signature:Date:From:To:Cc:Subject:Message-ID:
	 In-Reply-To:References:X-Mailer:MIME-Version:Content-Type:
	 Content-Transfer-Encoding;
	bh=+WSxtcpzWDqfdS75bPeo5bTo+c8L8XTo3/3XTzhs2c8=;
	b=IuwiqVLAFNyFiA5Uf5n+ksD0goWMCfES6X+nDJ4q1HV5pIfsRaTVkX5ys6GEKoWFBK4+
	 f9cUHSR5hp5khVoLsxqTKqPWzct8FHXOMFHfoWz6UnJLDHBVBfOhig6jbb67k3QCQ1ypP
	 CvH596gse+5j/A0s1E9lLiOJeDywzrp+Wpn3fi76pUiqbaIu9RqTbu72N7LTtVMr2Jmpd
	 guyQk1pmkAIKvXPIVd2N9O/CpyofjPCi/TL+rrj/mOCa6CllZGiRwFA6jzt6MXYM8Uv2x
	 M4EZoWgj+qdXQg9NQfa497akW44ZtiIzs2QH+AL+rwR8qVlB/te7EvlmP2o7KoJ4ooA==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dkim=pass header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=ac9+pc4G;
	arc=none smtp.remote-ip=100.103.45.18
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7AB7F606A31B;
	Mon, 26 Oct 2026 02:38:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=ac9+pc4G
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 0D9A01F01825;
	Mon, 26 Oct 2026 02:38:35 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1792982318;
	bh=+WSxtcpzWDqfdS75bPeo5bTo+c8L8XTo3/3XTzhs2c8=;
	h=Date:From:To:Cc:Subject:In-Reply-To:References;
	b=ac9+pc4GgGD9qrk/zJZXuNNbzby2Q3zZb8H6vs9Lb4f+M71RBI1ni1rj9aAJupLdI
	 X25Bc9VYquBgJkqvt42DBVrAYoWjng3eVg9IdibMnCnnWalBOCKG5pZWbbAtru6Yuw
	 RIBbb9bjKYpOKuezVbN3PIY8eyxvPaszR7Ox3iCJQq0lbWSn7pf044dxOdU1JDEbcy
	 gkaykEf/fXI14WGJBuwCVhSoAb8dKs1VPk8LQfI/KG/XV568ovT41wyG9W1w5JqRHO
	 82kU4yujyk5pLRrjJd5Af6hqE0XQPkluhRa4mCAYQ0TsBpMmLMBs/vcbjg1uB7GhCb
	 jaUcXFYoEcPcw==
Date: Mon, 26 Oct 2026 02:38:31 +0000
From: Jonathan Cameron <jic23@kernel.org>
To: Jean-Baptiste Maneyrol via B4 Relay
 <devnull+jean-baptiste.maneyrol.tdk.com@kernel.org>
Cc: jean-baptiste.maneyrol@tdk.com, David Lechner <dlechner@baylibre.com>,
 Nuno =?UTF-8?B?U8Oh?= <nuno.sa@analog.com>, Andy Shevchenko
 <andy@kernel.org>, Jonathan Cameron <jonathan.cameron@oss.qualcomm.com>,
 linux-iio@vger.kernel.org, linux-kernel@vger.kernel.org,
 stable@vger.kernel.org
Subject: Re: [PATCH v2] iio: imu: inv_icm42600: fix parsing of all FIFO
 frames for odr change
Message-ID: <20261026023831.32e65b30@jic23-hlaptop>
In-Reply-To: <20261019-iio-imu-inv-icm42600-fix-odr-change-event-in-all-frames-v2-1-d72a69c327ff@tdk.com>
References: <20261019-iio-imu-inv-icm42600-fix-odr-change-event-in-all-frames-v2-1-d72a69c327ff@tdk.com>
X-Mailer: Claws Mail 4.4.0 (GTK 3.24.52; x86_64-pc-linux-gnu)
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

On Mon, 19 Oct 2026 15:37:33 +0200
Jean-Baptiste Maneyrol via B4 Relay <devnull+jean-baptiste.maneyrol.tdk.com@kernel.org> wrote:

> From: Jean-Baptiste Maneyrol <jean-baptiste.maneyrol@tdk.com>
> 
> For getting all odr change events, we need to parse all FIFO frames
> in each iio device. Fix this correctly by sending effectively all
> frames to all iio devices.
> 
> Previously only batches of frames containing a matching sensor event
> were sent to the corresponding iio device.
> 
> Fixes: f670d4d34773 ("iio: imu: inv_icm42600: fix odr change not caught in certain cases")
> Cc: stable@vger.kernel.org
> Signed-off-by: Jean-Baptiste Maneyrol <jean-baptiste.maneyrol@tdk.com>
Applied to the fixes-togreg branch of iio.git.

thanks,
Jonathan
