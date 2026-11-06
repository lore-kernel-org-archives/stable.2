Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=209.85.210.176
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1793987731;
	b=wKy27A7VgtP6NjcEZZXA36J54ILrQaGDKwvqi4EC6C/g8v1Qa3FlwYcj5tEQAjKx+OSl
	 YMei5IuHt027pRGk2O5R7DQA14mf5ls7J4A5KxCaw+caXgc4gxCGQpJ69ZCrzraMHdLqL
	 4CBdq6JFqODA8z6v1Omd2KcOxafpsn4zh+EODYD0cJVFvCn3RFI+l4soNbUH6b7YfXXxv
	 eBMEOCIKnqR2lXdyK4h0qnBdcWI6S8qU0GHdrAmGEt+R/Gd/Bgl8ktSnMFIFkFMIEMlny
	 OlVEqxLnHGJcRqZ8donNdFaLxoofGYdfaX566OJno5KcTChx+N1RejYT7DzSu23WZmA==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1793987731;
	h=DMARC-Filter:Received:DKIM-Signature:X-Google-DKIM-Signature:
	 X-Forwarded-Encrypted:X-Gm-Message-State:X-Gm-Gg:X-Received:Received:
	 Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To;
	bh=mr8GCRAOmajdICVG5OcvHing6H+KXq+hdcv7TT8Lw4E=;
	b=rDvS4+SQOYaVIbHeVKZ210fFXv/iPP/D2XlDFSNtkCvnA3rt7Dx8Cz4JB1C9tIwfQf6C
	 qKcTJj/YNkRUMdsApLZ/GBnmu2bQBvgfZEijlEJg/qxeQN2sp4UDWRDDoRzwFbo5QY/ZW
	 zErwne4G4Px55DLKbOdSINlCQE1Zo2YGsBC8FYMniJf+sQsiDIdWeipdEiP6pbSWcQU59
	 MMf/0LAx/7ZzMnGMC3Sk0bnCqkfrVGri4w5nXOexCna/j8cp9zfJVqegjx/nsrBUVoJ3g
	 58Nb43GV+5yl1Bw/ADc6U2UlgPO4jEs05Obf1YDoGcANtJWXRkaIZIk6/tVXlwenZpw==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=linaro.org;
	spf=pass smtp.mailfrom=linaro.org;
	dkim=pass header.d=linaro.org header.i=@linaro.org header.a=rsa-sha256 header.s=google header.b=dBhIDylT;
	arc=none smtp.remote-ip=209.85.210.176
Received: from mail-pf1-f176.google.com (mail-pf1-f176.google.com [209.85.210.176])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4DADB606A333
	for <stable@vger.kernel.org>; Fri,  6 Nov 2026 17:55:30 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 4DADB606A333
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linaro.org
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=linaro.org header.i=@linaro.org header.a=rsa-sha256 header.s=google header.b=dBhIDylT
Received: by mail-pf1-f176.google.com with SMTP id d2e1a72fcca58-8a0880a46e7so508614b3a.1
        for <stable@vger.kernel.org>; Fri, 06 Nov 2026 09:55:30 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1793987730; x=1794592530; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:content-type:mime-version
         :references:message-id:subject:cc:to:from:date:from:to:cc:subject
         :date:message-id:reply-to:content-type;
        bh=mr8GCRAOmajdICVG5OcvHing6H+KXq+hdcv7TT8Lw4E=;
        b=dBhIDylT/qvwXP8fIUl4kmmy4r+PqQddze5z3d6HGGftNMDhpZVdKxP4mdiE5hfeh6
         icFwF7vsZR+milGnnJUQkMNBlOP92rUCeeWYg1p/qjZoDVPIg/L2oGtKDzflrMSXy6tT
         hTF+fIHofeUqCDUZ69zp73yPVPJm4JNkwByGTu/6KkkJT3YOuC6pr/LKgOUq8Z3bZo/B
         kYpeuSSTVFdZQBgtR1AMFSP5TR2AavvKyvXbAJQJeumzh9iXBh7ke9ISQK3QTlnjjcZR
         Dhp1RC/8KEXfNHYyGc9gjqdg1QxqTSMomDu1ZM2lSP0P0Qj4cHGHWg9Rf8t/fzu2W3z8
         0/rA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1793987730; x=1794592530;
        h=in-reply-to:content-disposition:content-type:mime-version
         :references:message-id:subject:cc:to:from:date:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=mr8GCRAOmajdICVG5OcvHing6H+KXq+hdcv7TT8Lw4E=;
        b=V63UvGAwR4Qa3P99I1XdX3keI/TjjV8v5lSFp3Fq69xbjRmOAQjiAonBHgAiCm4m3l
         P6+cb43SI6+oUrvu4GGlN1s9dciLeY97uhKUatZsdrlvqF1AGHOYgktWHw1GAHwcJvXj
         BCHs2spL6qtlzUv6JZmj+azlo9Ha7e7HtHphcqrO6Ky1svF3qwiCAa8ZCKffek0nOmys
         VXXdYRYXcyIh2lhFeQJrgzBG1nQaYaDQMIy7LADjS7ywVZ3T0++jm5c3i9zEo33gbt8t
         hJIUWxyInO0wt2lH22UcQ0Lm8O92R5t6uuRmTkjLXQjh4k/6K+L8Yp+kl9mkcUul09/p
         DkFA==
X-Forwarded-Encrypted: i=1; AKwUvBwqVoFr5gYusXxxJXVwE5MCpIXzPODe3KNltSPWy5OPTtQxK+AoDJhuFVefm+cFor0lE2VsMDQ=@vger.kernel.org
X-Gm-Message-State: APuU4Z/BvTHmlVG8KIyOObZsUbwMLwiwNG8vJCYzcgB6uTHLkOY5op57
	DGckw87xstVMjTj3uUgRgXTKS+7nr6scgnaQPMf6c6sAXtpNS+7YTUw84KY65DGyWNrmPOHPXcH
	D/Y14
X-Gm-Gg: AYBFou3GE9T80XakFc433skOoqzzxjnsHvSHCN7XhfwxvBUQg7Dif0EEXsL64SrNJHr
	aChg0p4Z10GwfexWjeQoZE3GVqZEUPDp6Vgit83HRMZ3q1ICSnGi1T3ED2iuuqdZpwWgHZ31CVK
	zZqt/ACm8Uw3epExPJRNkeRrdiJwzCg3XyXZJtBuS5kaehoz7j+TTNXjV2Ck51Oxm0dN9Ufjt/Y
	hWFiRpGRiFRpY4SVVe2MjH4S2a2P/k2gdZohIQocWRhfJz+SxiQ50wJaSPMn/mwUIbJThKaXWfl
	nfMBHaft2c+qQzOCUvjlho7bVZg6uYtnbtFDZuI8DQPSrwoqzJCTB5UwvrqAwwIDHtptHVzTx8G
	vWc4b0bC3pq0nMHkEPIES8Qh6BPODWxv6tgdp+hQP1k+zH/RsmymQgcx2jT8hUmb60CSGmTw366
	43yM0uQrfyBlrvRHN0oY+cTxTGp2fDj/Ytsi9HihnS2o/8DBCpeHnUAYa/AaiyFLylyF/ZWnHt4
	Wl0xQ3caQ1AvUCtckNge2vwt7fbH9jbdomVCuQ+sAhsOxIez9RgaGjdQiSEjbIyw6GfXh0WMgij
	3G3LmISLvWPHsvJMzjb5dDrMVmQKwe3F
X-Received: by 2002:a05:6a00:3a20:b0:8a0:652e:95eb with SMTP id d2e1a72fcca58-8b1e50a34dbmr4767646b3a.8.1793987729411;
        Fri, 06 Nov 2026 09:55:29 -0800 (PST)
Received: from p14s ([2604:3d09:148c:c800:b47c:40a0:a4eb:29ee])
        by smtp.gmail.com with ESMTPSA id d2e1a72fcca58-8b356c2c5a5sm847951b3a.7.2026.11.06.09.55.28
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 06 Nov 2026 09:55:28 -0800 (PST)
Date: Fri, 6 Nov 2026 11:55:26 -0600
From: Mathieu Poirier <mathieu.poirier@linaro.org>
To: Lianjie Wang <lian@is.s.u-tokyo.ac.jp>
Cc: Bjorn Andersson <andersson@kernel.org>,
	Ohad Ben-Cohen <ohad@wizery.com>, linux-remoteproc@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	Takahiro Shinagawa <shina@is.s.u-tokyo.ac.jp>,
	stable@vger.kernel.org
Subject: Re: [PATCH] rpmsg: virtio: Reject a message shorter than its header
Message-ID: <au4Ujm6W4Oq53WgO@p14s>
References: <20261102221504.175116-1-lian@is.s.u-tokyo.ac.jp>
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
In-Reply-To: <20261102221504.175116-1-lian@is.s.u-tokyo.ac.jp>

On Tue, Nov 03, 2026 at 07:15:04AM +0900, Lianjie Wang wrote:
> rpmsg_recv_single() rejects a message whose msg_len exceeds len -
> sizeof(struct rpmsg_hdr), where len is the used length the device
> reported. Since len is an unsigned int, a used length shorter than the
> header wraps the difference, and every msg_len passes. The endpoint
> callback receives up to 65535 bytes from a receive buffer of 512 bytes
> by default, and rpmsg_char copies them into an skb that userspace reads.
> The receive and transmit buffers share one DMA allocation, so the copy
> can run through the following buffers and, with small vrings, past the
> end of the allocation. With vrings of 16 buffers and a header claiming
> 65535 bytes, KASAN reports:
> 
>   BUG: KASAN: slab-out-of-bounds in rpmsg_ept_cb+0x4d/0xb0
>   Read of size 65535 at addr ffff888002484010 by task rpmsg_echo/140
>   Call Trace:
>    rpmsg_ept_cb+0x4d/0xb0
>    rpmsg_recv_done+0x29f/0x840
>    vring_interrupt+0x32a/0x540
>    vp_interrupt+0x146/0x180
> 
> Compare the sum of the header size and msg_len with len. The sum cannot
> overflow, since msg_len has 16 bits. Move the check ahead of the debug
> output, since dynamic_hex_dump() reads sizeof(*msg) + msg_len bytes
> when its dynamic debug site is enabled.

I don't understand why the check is moved ahead of the debug output and the
robot generated changelog isn't helpful at all.

I agree with this fix if we don't move the check ahead of the dev_dbg()
statement.  For this patch and any future ones you may send, write your own
changelog rather than simply dumping what the robot says.  

> 
> This patch is assisted by Claude Opus 5.5.
> 
> Fixes: 9648224e564a ("rpmsg: validate incoming message length before propagating")
> Cc: stable@vger.kernel.org
> Signed-off-by: Lianjie Wang <lian@is.s.u-tokyo.ac.jp>
> ---
>  drivers/rpmsg/virtio_rpmsg_bus.c | 20 ++++++++++----------
>  1 file changed, 10 insertions(+), 10 deletions(-)
> 
> diff --git a/drivers/rpmsg/virtio_rpmsg_bus.c b/drivers/rpmsg/virtio_rpmsg_bus.c
> index 23ff6c8b7a20b..a9125e81cb150 100644
> --- a/drivers/rpmsg/virtio_rpmsg_bus.c
> +++ b/drivers/rpmsg/virtio_rpmsg_bus.c
> @@ -661,6 +661,16 @@ static int rpmsg_recv_single(struct virtproc_info *vrp, struct device *dev,
>  	unsigned int msg_len = __rpmsg16_to_cpu(little_endian, msg->len);
>  	int err;
>  
> +	/*
> +	 * We currently use fixed-sized buffers, so trivially sanitize
> +	 * the reported payload length.
> +	 */
> +	if (len > vrp->rx_buf_size ||
> +	    sizeof(struct rpmsg_hdr) + msg_len > len) {
> +		dev_warn(dev, "inbound msg too big: (%d, %d)\n", len, msg_len);
> +		return -EINVAL;
> +	}
> +
>  	dev_dbg(dev, "From: 0x%x, To: 0x%x, Len: %d, Flags: %d, Reserved: %d\n",
>  		__rpmsg32_to_cpu(little_endian, msg->src),
>  		__rpmsg32_to_cpu(little_endian, msg->dst), msg_len,
> @@ -671,16 +681,6 @@ static int rpmsg_recv_single(struct virtproc_info *vrp, struct device *dev,
>  			 msg, sizeof(*msg) + msg_len, true);
>  #endif
>  
> -	/*
> -	 * We currently use fixed-sized buffers, so trivially sanitize
> -	 * the reported payload length.
> -	 */
> -	if (len > vrp->rx_buf_size ||
> -	    msg_len > (len - sizeof(struct rpmsg_hdr))) {
> -		dev_warn(dev, "inbound msg too big: (%d, %d)\n", len, msg_len);
> -		return -EINVAL;
> -	}
> -
>  	/* use the dst addr to fetch the callback of the appropriate user */
>  	mutex_lock(&vrp->endpoints_lock);
>  
> 
> base-commit: 6628e7d4c6b25c8d18f1345e3a20d21829aae7e4
> -- 
> 2.56.0
> 
