Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=100.103.45.18
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1795698893;
	b=1oyFpPs/eQOddynv2GieXnLK67IdeDv4L8n22GXh8necBnvkt/gBUwx7wxFDTDRIqWs+
	 ze+SCFp3gM4SvqjMoSAQ9NoUc37XMdU7mN39al2foSTZ9xH3kYjAUf0WhjK6IwF/WNZPH
	 Yu+20/PolZvTvHYWdqvWrrM8LlD4fV0MygFMDhxvAsSX232ADPeKTMwKxVZq9yr4ILPIl
	 tNln/kQYOLKVVX4jfc7U09ShxdBNKeO/Ps8tO5+BbxslCZ+nZKAAoQ6FcCK/jPgDtCNcr
	 YTLj1HOCgYDMm3Zl6YcShdzG0eRj5obQBLvm6W8nGJOT6czchWU6JxSV1zwgagrKsOw==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1795698893;
	h=Received:DKIM-Signature:Date:From:To:Cc:Subject:Message-ID:
	 References:MIME-Version:Content-Type:Content-Disposition:In-Reply-To;
	bh=2KA9MqjKO6Y0itKOF5tb4TxqbmmYNjVJ8YP1PqMh9IM=;
	b=1NUmAZyzAYeqYJ+t60MY7P6I5s7Gu5rtE4YVq/ahO67wNs2gMboVMkHnrsdsIxlGweAe
	 87PXXrm3fQ5GpRmOwEdkj6cxd40x5lQ6fSTxx2/eyaM9jJQ3jQiTUa47N2VyHsCwRluCm
	 MnpoJDJtvh2J1vvkTKlNQv64cfh+cmNIaDb4s3sdCU/to0zTA03hmLSc+btrF6kyac68V
	 lbjLICF8MUcBRc7qYSTBGi5DaVHOf6Sel7JUpmwtJVpeKttiLpT80vo+iXgWajyu94wpS
	 qigXcNsrZ6MPovo4paxkwlsMA+dgIUxWBh3T43fTX6BqNNk5OT+XerSfuLgs1LkaDCw==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dkim=pass header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=hChVRP+s;
	arc=none smtp.remote-ip=100.103.45.18
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2E82F606A329;
	Thu, 26 Nov 2026 13:14:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=hChVRP+s
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 9199D1F000D1;
	Thu, 26 Nov 2026 13:14:51 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1795698892;
	bh=2KA9MqjKO6Y0itKOF5tb4TxqbmmYNjVJ8YP1PqMh9IM=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To;
	b=hChVRP+sp4WkuxaxWWgjsCwNsMtIPgNRvVQM42gAlafrAWE/Ia+WnSTQr0t8pU4i7
	 SKBvNzbluU8Ywh8inYRFXh07aJK6OnMOaYI/IKeoiMmWlbs/hGLQ+v53knpkbYzozM
	 o4c1kz8VUU2afBVFkqSVfh5KjbiBK77siR4o9OWR8mukBaMOPGRsqXeSHwI0Db87Rk
	 68+qCdrvbpCFccGQkRY6vxHGGtL5qeGZ3tUw/HfEbKH26vjIwHkyIcfnLMwYFEKfYV
	 +kLkCGh/Bi2Z8mZIeDns6fu8tnRpVf17aMYhr7L2ETgQu0+Rouw37I0HaaOmartfxO
	 /m8sA7U35xfkw==
Date: Thu, 26 Nov 2026 14:14:48 +0100
From: Andi Shyti <andi.shyti@kernel.org>
To: "Thomas Richard (congatec GmbH)" <thomas.richard@bootlin.com>
Cc: Lee Jones <lee@kernel.org>, mfd@lists.linux.dev, 
	linux-i2c@vger.kernel.org, linux-kernel@vger.kernel.org, stable@vger.kernel.org, 
	Markus Haberlander <markus.haberlander@rosenberger.com>
Subject: Re: [PATCH] i2c: cgbc: Fetch the status of a write transfer
Message-ID: <awgwO98qx3zX4MaY@zenone.zhora.eu>
References: <20261123-cgbc-i2c-write-status-v1-1-5b0fa0322b57@rosenberger.com>
 <179568834099.302193.16315749597111506309.b4-review@b4>
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
In-Reply-To: <179568834099.302193.16315749597111506309.b4-review@b4>

Hi Thomas and Markus,

> > diff --git a/drivers/i2c/busses/i2c-cgbc.c b/drivers/i2c/busses/i2c-cgbc.c
> > index dfdb9ffc6447..2361591a1e31 100644
> > --- a/drivers/i2c/busses/i2c-cgbc.c
> > +++ b/drivers/i2c/busses/i2c-cgbc.c
> > @@ -254,6 +254,22 @@ static int cgbc_i2c_xfer_msg(struct i2c_adapter *adap)
> >  		ret = cgbc_command(cgbc, &cmd, cmd_len, NULL, 0, NULL);
> >  		if (ret)
> >  			goto err;
> > +
> > +		ret = read_poll_timeout(cgbc_i2c_get_status, status,
> > +					status != CGBC_I2C_STAT_BUSY, 0,
> > +					2 * algo_data->read_maxtime_us, false, adap);

would it make sense use USEC_PER_SEC here to preserve the
existing one-second timeout between write chunks?

> > +		if (ret)
> > +			goto err;
> > +
> > +		if (status < 0) {
> > +			ret = status;
> > +			goto err;
> > +		}
> > +
> > +		if (status != CGBC_I2C_STAT_IDL) {
> > +			ret = -EIO;
> > +			goto err;
> > +		}
> >  	} else if (i2c->state == CGBC_I2C_STATE_READ) {
> >  		xfer.write = 0;
> >  		xfer.read = len;
> 
> I was able to reproduce the issue on conga-SA7 (and also the reboot crash).
> 
> $ i2ctransfer -y 11 w1@0x40 0x00	 <- non-existing device
> $ i2ctransfer -y 11 w1@0x50 0x00 r1@0x50 <- read EEPROM
> Error: Sending messages failed: Input/output error
> $ i2ctransfer -y 11 w1@0x50 0x00 r1@0x50 <- read EEPROM
> 0x01
> 
> And with your patch:
> 
> $ i2ctransfer -y 11 w1@0x40 0x00	 <- non-existing device
> Error: Sending messages failed: Input/output error
> $ i2ctransfer -y 11 w1@0x50 0x00 r1@0x50 <- read EEPROM
> 0x01
> 
> Reviewed-by: Thomas Richard (congatec GmbH) <thomas.richard@bootlin.com>
> Tested-by: Thomas Richard (congatec GmbH) <thomas.richard@bootlin.com>
> 
> Yes it conflicts (compile issue) with the series [1]. The possibilies are:
> - I pick this patch in my series and send a v7.
> - [1] is applied, an immutable branch is created, you rebase your patch on
>   top of it, and patch is applied in I2C tree.
> - [1] is applied, you rebase on top of mfd-next, and your patch is applied
>   in MFD tree.
> 
> Andi, Lee, what do you prefer?

Let's wait your patches to get in first and then Markus can
rebase on top of them.

I will now prioritize your series.

Thanks,
Andi
