Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=209.85.221.44
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1794822686;
	b=B/ig48NkoSysUi+6dFQ1cqdbaTN5mvMYpGqk8NoiYi1Eto7GthrnwL3Swt0ot+LxTf9x
	 Y17bsPur18/qvIsROX8aWdZz3nTxGlh9KdzgzTA/rMNtpWjnRPK93PknEyhTGF3ygW8uO
	 MmzK0eHGPdaQzYD16z6JllO+MmTQEgBfUQG3lSAu1emzLNDWdZZxgKAlrSP60AIOdr8A3
	 ZvR8f22+zMYX41YgnDz//NF9xCgymyOZYN4F5dtW89rgKm1IPny8zj9fmpAd0f5NFKOn0
	 2mlAIDvqQcE2gVlVErrSh9XoXzH14kvGVrjBdr69kt/B1QrLPZ6X2lH23Nd2G/4Bmkw==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1794822686;
	h=DMARC-Filter:Received:DKIM-Signature:X-Google-DKIM-Signature:
	 X-Forwarded-Encrypted:X-Gm-Message-State:X-Gm-Gg:X-Received:Received:
	 Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To;
	bh=N+fImhJ1pc1ohPywlDOVCLfSXbIN+d12UyWza3WFBhk=;
	b=GHU2Ou9eVtcxQBZ8GXE6SbogQikIP2oRKJ6lvlhl/h2s3f1DKM19Roz/QSJkjySqKwvd
	 3UFqb5jC67t47S7QdIFLu7kFQav/oCWqT9L3cSwAvKGqDNXC4LGUktJQSwXiC+8YY431p
	 yHbjjuh9r9sSPFvYdb7PyJZH6G0xBKYKH3gqatHjho06vBZpWrrw7R2sycpE4/Ack8fqI
	 l/075EiaLEYtVUWKkl75/Wp9D6Z/ZrAHDWxiBgXP0gTiEmPxh1SxnCSqJwm5p18CMYB7I
	 6CfABhbucHol3zHx/5FxK7Pfbn/TuytVjKOpm/ckGj1OZMibnPcsdxMVpmxQQ/802fw==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=gmail.com;
	spf=pass smtp.mailfrom=gmail.com;
	dkim=pass header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20260707 header.b=EeFkAcdf;
	arc=none smtp.remote-ip=209.85.221.44
Received: from mail-wr1-f44.google.com (mail-wr1-f44.google.com [209.85.221.44])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5CE82606A323
	for <stable@vger.kernel.org>; Mon, 16 Nov 2026 09:51:25 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 5CE82606A323
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20260707 header.b=EeFkAcdf
Received: by mail-wr1-f44.google.com with SMTP id ffacd0b85a97d-4919a880834so1544903f8f.0
        for <stable@vger.kernel.org>; Mon, 16 Nov 2026 01:51:25 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20260707; t=1794822684; x=1795427484; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:content-type:mime-version
         :references:message-id:subject:cc:to:from:date:from:to:cc:subject
         :date:message-id:reply-to:content-type;
        bh=N+fImhJ1pc1ohPywlDOVCLfSXbIN+d12UyWza3WFBhk=;
        b=EeFkAcdfmpM/alg861PlAN3DrjF1bRj9ji0oDldUfaZv3j2CudELa/V0lrOC2gOkAG
         JGNkG9Blg/e5dnyx2OH4OuiMCYhFr9l99Ysf8YzZ/ks2aAc2KVLu4vH1KnHaNiDJd2E6
         uQ/myF+6CEQL7AlIAfTFXYZ/tDTPmqRORayOJm+JLmOFKYXRlMt7O52H2VceZUp/QiKA
         Xn3+0Z/DALpAQexSUr1ikDhJBCi0+kUKJIUwJ4e1WU/rwlPDlz4YYqJ0htdnv7ic21x0
         H+QfTC6+EUtcg7wTqdg6ULdakSYDXtVnUpK61Z30ZOur/uD9OitvzhOo06AZYJYQeLCL
         EVwA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1794822684; x=1795427484;
        h=in-reply-to:content-disposition:content-type:mime-version
         :references:message-id:subject:cc:to:from:date:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=N+fImhJ1pc1ohPywlDOVCLfSXbIN+d12UyWza3WFBhk=;
        b=tArpjXK4LRP7YDPE43N2+XBXnsqgnNDTrR5hPW+jWdwXVyEF/lWek6gfpZZ/nP5RnB
         2BS+Pfjn3QxcUxqq8zRtjanmJ5Q9/lMon31tGIUx6phv0F8zHZd67ygr8tgporiXgdls
         K9KSBCU6wKGVBjTJgA4bSG8rx/xNsvPxFDqDG4BJHNTqkCBBRHQ7RsRTBy4pIgS57iyj
         ZO3VKkyZRSILaMWyg4Vzv4oV7imnH8qH17KtGwyi4dfE1GJESGwjCXP8ugUwX6s3fSTO
         w9+P9ogFLK95goKQZMD/Qpii+ciE3nQyeYL/QarsUgRmTmqWkeDpkuVLZMH2PWtKlbfl
         P2Ig==
X-Forwarded-Encrypted: i=1; AL+hErE8vvClJw8ooMrZFGVxKpLMsUvYLgufbXMTCDrcbNhHqv7TUHXaLEpuTa5q2Qyx9bYUrLSErco=@vger.kernel.org
X-Gm-Message-State: APuU4Z/fnF7AJnYotsgrsZofVxMNwBbssZ0+Fd+8cWNUNk8wDS79Oi5b
	whsfaz/Bap3QDkLqYsth13bUJNobmEn9xdEz+fDQoWncWYlKBFssJm0K
X-Gm-Gg: AZFdTZd0iYQ3nTxuUbEo9RR3T5WE+7o7Fa4Z1n0IkSWJewE7N0WtNU/rx0OycROSWCN
	oYeqJcbhovUgGmrfGNxR0KscieAF6f1spY58EYQMwGZh7v1thPylG+1dyF3E9IfXFxJs2hmHxx+
	U08fT+Xfv9zOZw885VHxReh/C8S9u6VQY3JT4LoGOC5IpzwnVnreB+XmCD0R2RbPTw1Dam31lIu
	76AftzzwyNprDNcO+4wK/8yXgQqbANFO/BcgtgYQ0F1/FGQbDWFVXMYsJ5g827YyKizUCTalLHa
	AMPM0sTkOaCNb2c/gwl1UuvZAVktkYcpLx3ABj296SMAiuMP/jafTXHnEwc3d8xxihN15s1ELN9
	c5sz88SAnarHXd2+NkokxrzDahmQR9Y1R5W3Pf7v6Qn90vf2n6qwCwr2fNTAc9SY06N1Hf1FGZ8
	Qte3cFZeOownxs88EYe8WBz38p3AjtaADrk1qRAa3QU9kTxq8GjYBMxTznlRm4IjGnwG9JvFww8
	HWBhk9I8G5IpGnkl3NeXDocnd3UdmjbEv8Nk/wzbUbll+cvAW6sXzLW0CmqtxxQvUuOcL26LJn4
	Q+5fH1I=
X-Received: by 2002:a05:6000:2584:b0:49d:a36c:2d66 with SMTP id ffacd0b85a97d-49da38ab522mr16399232f8f.27.1794822683448;
        Mon, 16 Nov 2026 01:51:23 -0800 (PST)
Received: from eichest-laptop ([2a02:168:af72::cb4])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-49c5f1c1968sm21517792f8f.10.2026.11.16.01.51.22
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 16 Nov 2026 01:51:22 -0800 (PST)
Date: Mon, 16 Nov 2026 10:51:21 +0100
From: Stefan Eichenberger <eichest@gmail.com>
To: Mehmet Fide <mehmet.fide@gmail.com>
Cc: Andi Shyti <andi.shyti@kernel.org>,
	Oleksij Rempel <o.rempel@pengutronix.de>,
	Pengutronix Kernel Team <kernel@pengutronix.de>,
	Frank Li <Frank.Li@nxp.com>, Sascha Hauer <s.hauer@pengutronix.de>,
	Fabio Estevam <festevam@gmail.com>,
	Stefan Eichenberger <stefan.eichenberger@toradex.com>,
	linux-i2c@vger.kernel.org, imx@lists.linux.dev,
	linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org,
	stable@vger.kernel.org
Subject: Re: [PATCH] i2c: imx: test the block read flag of the message that
 is read
Message-ID: <avrSGehp4JX4aQ5L@eichest-laptop>
References: <20261113110501.1142036-1-mehmet.fide@gmail.com>
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
In-Reply-To: <20261113110501.1142036-1-mehmet.fide@gmail.com>

Hi Mehmet,

On Fri, Nov 13, 2026 at 12:05:01PM +0100, Mehmet Fide wrote:
> From: Mehmet Fide <mehmet.fide@screeningeagle.com>
> 
> i2c_imx_xfer_common() decides between the DMA and the interrupt driven
> read with I2C_M_RECV_LEN of the first message of the transfer instead of
> the message at hand. A block read of DMA_THRESHOLD bytes or more that
> follows another message is therefore done with DMA, which reads the
> initial length and does not look at the count byte.
> 
> Fixes: b460b15b3cc2 ("i2c: imx: separate atomic, dma and non-dma use case")
> Cc: stable@vger.kernel.org
> Signed-off-by: Mehmet Fide <mehmet.fide@screeningeagle.com>
> ---
> Reported by the Sashiko review of another i2c-imx patch:
> https://sashiko.dev/#/bug/linux-f62df5ed-ad96-43f2-872a-ae2c0100b73f
> 
> Tested on a Colibri VF50 (i2c0 with DMA) with a v6.12.117 kernel that
> carries the i2c-imx changes of v6.13 and later as backports; on this
> base compile tested only. An I2C_RDWR transfer of a one byte write
> followed by a read with I2C_M_RECV_LEN and an initial length of 16:
> without the patch 16 bytes are read and the count byte is taken as data,
> with it the count byte is evaluated (here -EPROTO, the device answers
> with 0x25).
> 
> The line is from v6.13, the patch applies to 6.18.y and 7.3.y.
> 
>  drivers/i2c/busses/i2c-imx.c | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)
> 
> diff --git a/drivers/i2c/busses/i2c-imx.c b/drivers/i2c/busses/i2c-imx.c
> index ccf08cd63151..9abe0a26c877 100644
> --- a/drivers/i2c/busses/i2c-imx.c
> +++ b/drivers/i2c/busses/i2c-imx.c
> @@ -1713,7 +1713,7 @@ static int i2c_imx_xfer_common(struct i2c_adapter *adapter,
>  			msgs[i].flags & I2C_M_DMA_SAFE &&
>  			!(msgs[i].flags & I2C_M_NOSTART);
>  		if (msgs[i].flags & I2C_M_RD) {
> -			int block_data = msgs->flags & I2C_M_RECV_LEN;
> +			int block_data = msgs[i].flags & I2C_M_RECV_LEN;
>  
>  			if (atomic)
>  				result = i2c_imx_atomic_read(i2c_imx, &msgs[i], is_lastmsg);
> 
> base-commit: 25e7ab89f4774b0f842cee0e8a20c11f755924d5
> -- 
> 2.56.0

Thanks a lot for the fix, it makes sense to me.

Reviewed-by: Stefan Eichenberger <eichest@gmail.com>
