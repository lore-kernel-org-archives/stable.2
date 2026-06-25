Received: from mail-wr1-f45.google.com (mail-wr1-f45.google.com [209.85.221.45])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D895B378839
	for <stable@vger.kernel.org>; Thu, 25 Jun 2026 09:11:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.221.45
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1782378682; cv=none; b=HyLfTyBWj/CdZfaiwgUKB0EGrdJMH/TDmtDYhqZtG6D1RoxC7yenF8s6YcUvofNgufP5KeEjos0uF5oHSSUS9SseuxugJnRleQu4UVAhgZL6nxYPhOFzEvXnT4rX07AY8CaPd2BwfZdo2RUC/MysQ21q11TUtZGImmVRZ2S9Qog=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1782378682; c=relaxed/simple;
	bh=7Vni6aoU/U+1ED5C8Gh3fxPndlG3z+xryt5KP9cLmiM=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=a5BvTAA+exMhNRYWiEv7obPlbdfviQDtA2rfEHBc4rF9tAMiWDweGdX3LPgwIJ27qvuNduLTIAmq/2U3kGg4YPc+2LTWO0aq/05e1Le8lp44xShet7JVHUkzVPZH5to3AvdaFLVHgltJLsZD7sHCuTnH7Fgv06N/UBV2Jx5UXwk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=Bq7A6eTR; arc=none smtp.client-ip=209.85.221.45
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="Bq7A6eTR"
Received: by mail-wr1-f45.google.com with SMTP id ffacd0b85a97d-46cbf263113so1455245f8f.1
        for <stable@vger.kernel.org>; Thu, 25 Jun 2026 02:11:20 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1782378679; x=1782983479; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=G69PCEOlnq92SdyMP8AGIKg5XJgYw5Jrc7HuDLGgvos=;
        b=Bq7A6eTRUrMs6DJCvsPR1BpweBfzA+pIixKc9P8gT7IOo+FzYzwLdFzRy7okuwDllh
         sPQU1bIAG58YlPkxGJEWum+aMh6LLuVkT2PWZwlzZCCo5zt92Uvb9ClIiBBSNibdIyQx
         HnXvlhY51yFHKa/Wl7O7ROrWVP1JUI8mqLeUQYxuZ2mOM3coJMqiohOgTQJxQdmOF3Ez
         DR4qL52ZUZ6iX6EYWlaO3U9d1bAbFil9ZCh23rJa+AJCMfX1+jpAdH8racdZfsC6yA40
         i63NiwfDIqpU/Zi6E2d8JLfISQQ4s0NIR56ILFztHS9z2xAnG+BGawaDvXFcdL9sQsvb
         p+yQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1782378679; x=1782983479;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-gg:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=G69PCEOlnq92SdyMP8AGIKg5XJgYw5Jrc7HuDLGgvos=;
        b=OKX+CX+uQmkCdA1Qwr5MYEqPgZ/D3AY1YoisfRFkpoZuEAnQr5W03P3sOLtNVdnIPV
         2jmihE6bAoFcNmykoIhRIm6wVQ7wYWwgd6Z6grf10GbOOEnN2NunXwYOOi6Z9K7C1Yxv
         66Zc8Lfi1bJHBHmYT4O7ySf7dbC9OS41lAjCDPKB6h/nu9Bu7CKkOnft3AAfHS1fMuOy
         Mp1aLhZRjDdwj/ijqliXyeOUALQ3GGWkGR+lwqZxhZ0UBnXBJ33gxW1FlDudh31KngY6
         cW+Qrz3CQm+VcPp6P86kwUhMkNopRvA+WAEuWrYel7NTXEs19FewwSVU4Utfy28OJ5HB
         85BQ==
X-Forwarded-Encrypted: i=1; AHgh+RojKFygtkJJTVcgjgxOp31OYNPLn2dpLQGeMfRAnDyafKd6W5uQOC6Mw7Uwjn4ua1Ls6yRfAe8=@vger.kernel.org
X-Gm-Message-State: AOJu0YwA8X3SCYMWmwFovPauNXr8gpo5uv3qkN8R+WNoNroqMbbs21iS
	uOwfnv1lLvJ78Uchcj2aBOMxrRXayWoJ+8tLsTSmSkMjt53fwh3dkzZ1
X-Gm-Gg: AfdE7cmf2EKsoUhpSjlJcbsBuFDak9CHda0IkYZEauCg+ybHf1RL0pJvqWw2t6zLAcy
	naPLTOZrzBbBZNyg/YsEtAoZXTlKEX7Gc+ERMWL/X7m/OWYteci+0kIcPV4SlzqNCd68LoQwXFj
	v7O6kf0E1aJcplw/SdFp4DcZ1d2hT9/0KoJ4tLNPj0Xo4cOnGhKUv7DgELyqL54XiA0aJVe5tdS
	IORQoVHOsjc6Y0X8SoB+4fgTuLm+MCkW0lNtRhJi2T8vDoxg/TD9rK2UufGi6aB1GB2PwUwMtB5
	ebyAbtDvgg19bOFIdvlpp1NTMrh9J1xQ5wqAGakMO4niEBfDwNxbeUk/CUF3SetzXWE80Yi0qb1
	yhEK6UDv5e219hk/fX5dX1ROsAIL4xLxnQpgeFu/gAM3LB2AmLjavXjTOMlKBnFij4Q==
X-Received: by 2002:a05:6000:41fc:b0:46d:47bb:d711 with SMTP id ffacd0b85a97d-46dc0e050d9mr2295206f8f.23.1782378679096;
        Thu, 25 Jun 2026 02:11:19 -0700 (PDT)
Received: from eichest-laptop ([2a02:168:af72::cb4])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-46e3d6ba143sm209356f8f.33.2026.06.25.02.11.18
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 25 Jun 2026 02:11:18 -0700 (PDT)
Date: Thu, 25 Jun 2026 11:11:16 +0200
From: Stefan Eichenberger <eichest@gmail.com>
To: Vincent Jardin <vjardin@free.fr>
Cc: Oleksij Rempel <o.rempel@pengutronix.de>,
	Pengutronix Kernel Team <kernel@pengutronix.de>,
	Andi Shyti <andi.shyti@kernel.org>, Frank Li <Frank.Li@nxp.com>,
	Sascha Hauer <s.hauer@pengutronix.de>,
	Fabio Estevam <festevam@gmail.com>, Wolfram Sang <wsa@kernel.org>,
	Kaushal Butala <kaushalkernelmailinglist@gmail.com>,
	Shawn Guo <shawn.guo@freescale.com>,
	Stefan Eichenberger <stefan.eichenberger@toradex.com>,
	linux-i2c@vger.kernel.org, imx@lists.linux.dev,
	linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org,
	stable@vger.kernel.org
Subject: Re: [PATCH v2 2/2] i2c: imx: fix locked bus on SMBus block-read of 0
 (IRQ)
Message-ID: <ajzwtNbCKXdxQAUA@eichest-laptop>
References: <20260525-for-upstream-i2c-lx2160-fix-v1-v2-0-26a3cc8cd055@free.fr>
 <20260525-for-upstream-i2c-lx2160-fix-v1-v2-2-26a3cc8cd055@free.fr>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20260525-for-upstream-i2c-lx2160-fix-v1-v2-2-26a3cc8cd055@free.fr>

On Mon, May 25, 2026 at 06:43:16PM +0200, Vincent Jardin wrote:
> SMBus 3.1 6.5.7 allows a Block Read byte count of 0, but the
> interrupt-driven block-read state machine rejects it as -EPROTO. Worse,
> it returns without a NACK+STOP: the next receive cycle has already
> started, so the target keeps holding SDA and the bus stays stuck until a
> power cycle of this i2c controller.
> 
> Accept count=0: NACK the in-flight dummy byte (TXAK) and set msg->len to
> 2 so i2c_imx_isr_read_continue() emits STOP via its normal last-byte
> path. The dummy byte is discarded; block-read callers only consume
> buf[0..count-1].
> 
> Reading I2DR has likewise already armed the next byte on the
> count > I2C_SMBUS_BLOCK_MAX error path, so NACK it (TXAK) before aborting
> with -EPROTO; otherwise the failing transfer's STOP cannot complete and
> the bus stays held.
> 
> The atomic path regressed earlier (v3.16) and is fixed separately; this
> patch covers only the v6.13 state-machine rework.
> 
> Fixes: 5f5c2d4579ca ("i2c: imx: prevent rescheduling in non dma mode")
> Cc: <stable@vger.kernel.org> # v6.13+
> Signed-off-by: Vincent Jardin <vjardin@free.fr>
> ---
>  drivers/i2c/busses/i2c-imx.c | 17 +++++++++++++++++
>  1 file changed, 17 insertions(+)
> 
> diff --git a/drivers/i2c/busses/i2c-imx.c b/drivers/i2c/busses/i2c-imx.c
> index 14107e1ad413..8db8d2e10f5c 100644
> --- a/drivers/i2c/busses/i2c-imx.c
> +++ b/drivers/i2c/busses/i2c-imx.c
> @@ -1061,11 +1061,28 @@ static inline enum imx_i2c_state i2c_imx_isr_read_continue(struct imx_i2c_struct
>  static inline void i2c_imx_isr_read_block_data_len(struct imx_i2c_struct *i2c_imx)
>  {
>  	u8 len = imx_i2c_read_reg(i2c_imx, IMX_I2C_I2DR);
> +	unsigned int temp;
>  
>  	if (len == 0 || len > I2C_SMBUS_BLOCK_MAX) {
> +		/*
> +		 * SMBus 3.1 6.5.7: support count byte of 0.
> +		 * I2C_SMBUS_BLOCK_MAX case should not hold the SDA either.
> +		 * So NACK it (TXAK) to not hold the bus.
> +		 */
> +		temp = imx_i2c_read_reg(i2c_imx, IMX_I2C_I2CR);
> +		temp |= I2CR_TXAK;
> +		imx_i2c_write_reg(temp, i2c_imx, IMX_I2C_I2CR);
> +
> +		if (len == 0) {
> +			i2c_imx->msg->buf[i2c_imx->msg_buf_idx++] = 0;
> +			i2c_imx->msg->len = 2;
> +			return;
> +		}
> +
>  		i2c_imx->isr_result = -EPROTO;
>  		i2c_imx->state = IMX_I2C_STATE_FAILED;
>  		wake_up(&i2c_imx->queue);
> +		return;
>  	}
>  	i2c_imx->msg->len += len;
>  	i2c_imx->msg->buf[i2c_imx->msg_buf_idx++] = len;
> 
> -- 
> 2.43.0
> 

Reviewed-by: Stefan Eichenberger <eichest@gmail.com>
