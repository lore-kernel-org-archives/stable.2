Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=100.103.45.18
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1795555145;
	b=WvWlGWNeh9tJRJFQPRj6/H8xQMn7XRHo455LbBhjN6vjBbv/uLFyBUY3GxYf3iSBtgfK
	 raCmw7TmvTcz66E1w+DBbeIEk19SJUI7XpF5huM+6rCMB8M/21Vi5/1oUWLc5lDMONio8
	 AlRbsDfnmlZsSn5WJlLkL2zZtaw2tfzTaTJhxcDrWsKgHORPlHWPBm51jY2xEegFvQeNL
	 KLCqhwVZf4Z0EYWraYlVCUKip5A+I6zb1IuMpHc2ru6zS0HTeRirMka2E/XbmMqa3noiF
	 4K2eakG8GWu2JMHGgm0Fdou2D7AroQ9pyKODEthYvXixUJJ6mF7tqgFzeG33fT7tI/g==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1795555145;
	h=Received:DKIM-Signature:From:To:Cc:In-Reply-To:References:Subject:
	 Message-Id:Date:MIME-Version:Content-Type:Content-Transfer-Encoding:
	 X-Mailer;
	bh=Ep9YVBlZQt02FgWSHSNTDTXcDZCT5NwNSqZD0MMTqGw=;
	b=xTf+ka+2WVc+Bzs5iBqc5XPpMDnZyv4wp/Ay10DZPLE/yRzhp1GtFm5VyJ+CNtMce2kY
	 XVyZ9xYklIshpxS62LXJC2s6XszrUZSZ3LRsOlWDrNNvPk1mAL2MWaTEF65MZZdFlGbO2
	 wem6RTeZDsA1d6mBKFQr0otxIPSnM3cg9EurVf1IXAjCWIeqJZN1rmmK1wFplFfCoGQN0
	 wyzaWDfO8NLrOV9wK6dcn1KhC+sZLCAh7gY95zZ8YmyRLGTfmrUl4s02P2G6iH4AuJ5vG
	 fOt74mqWXjEpo4r3ar85qdtQ8WtPzUoMFNSvLwLOIlXMLRsge302r5367+6VmzO9yGA==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dkim=pass header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b="f/Nw8Qod";
	arc=none smtp.remote-ip=100.103.45.18
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D849F606A334;
	Tue, 24 Nov 2026 21:19:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=f/Nw8Qod
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 1E3541F000C6;
	Tue, 24 Nov 2026 21:19:03 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1795555145;
	bh=Ep9YVBlZQt02FgWSHSNTDTXcDZCT5NwNSqZD0MMTqGw=;
	h=From:To:Cc:In-Reply-To:References:Subject:Date;
	b=f/Nw8QodRE25s1X0Vy3GsVQ+DzJJpVuv2oDistmWx6jLx6UpUlwnF3C3iZLjB8rDt
	 snl34T/669/Ryd2qdM8ZQyYM5xg6o7VJ6rlS4wfb9/VLn4r4qU0cnHmPeQlwpGyXo0
	 W4MOnv6W1Dnw7JOO2IpvSYiyBJM6Ntd3Hckto+lyVQ3MX3EwwVgSfIDtlxXTOeN3qQ
	 3xySCy8BhNEyFJ00/ZLt+rMXg9vELr0mSnoT3evlCaF4QabXdA9oWdJc5UxJcHc+nF
	 abyWHj3xw3qYoDQtXa4oedmbzl9n87gW9mOfs0uVlRPWt6imcunxcCghW9IGD8CHg8
	 G5dT5oi/F/aIA==
From: Srinivas Kandagatla <srini@kernel.org>
To: Miquel Raynal <miquel.raynal@bootlin.com>, 
 Greg Kroah-Hartman <gregkh@linuxfoundation.org>, 
 James Hilliard <james.hilliard1@gmail.com>
Cc: linux-kernel@vger.kernel.org, stable@vger.kernel.org
In-Reply-To: <20261117-submit-nvmem-onie-tlv-bounds-v1-v1-1-2b114f1153cd@gmail.com>
References: <20261117-submit-nvmem-onie-tlv-bounds-v1-v1-1-2b114f1153cd@gmail.com>
Subject: Re: [PATCH] nvmem: layouts: onie-tlv: check both field header and
 value bounds
Message-Id: <179555514386.419336.6401619877478994530.b4-ty@kernel.org>
Date: Tue, 24 Nov 2026 21:19:03 +0000
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
X-Mailer: b4 0.14.3


On Tue, 17 Nov 2026 15:19:45 -0700, James Hilliard wrote:
> The table CRC does not validate individual field lengths. The field
> iterator can read a two-byte header when only one byte remains. Its
> value length check also counts the header as available space and can
> publish a cell extending beyond the table.
> 
> Check the remaining space before reading the header and exclude the
> header from the space available for the value. Stop at the first
> truncated field, keeping any complete cells already registered.
> 
> [...]

Applied, thanks!

[1/1] nvmem: layouts: onie-tlv: check both field header and value bounds
      commit: 1f2bc0f3b7bd5e459f6f751d912ecc85009b170a

Best regards,
-- 
Srinivas Kandagatla <srini@kernel.org>

