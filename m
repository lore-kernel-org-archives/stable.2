Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=185.171.202.116
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1795688371;
	b=yzURm7Bh6nCjS0jce9XC8rpsAmPyhu5ScMPVe8DhOrtRPFPw4p3/dYGEuChthWjE+rWY
	 +Mog9XQv0vQv3071IC52P4ws+kzu+m2hp1pYYRG8CR0sA3AlpexK/qPEBdFlbrpStCwyf
	 j/PaZt8LwL71RjLJjf9pyjoDlUtfRvomnk5q7DhJtxzlK9VtLtZHF/KlQ0Egp76p3m12y
	 DhRyE+AHt6d6SKYAPWlDxCVFPcOim72hDL1ZUA1xSVHtktNAxTmQgyYpan1Z6nV2rYUih
	 UAgoIr7w6u892X0OlMTo2zffSu8PljGFwjxC2VL2FBh9BjPp5TxydN5nsFSu2KJC7Kg==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1795688371;
	h=DMARC-Filter:Received:Received:Received:DKIM-Signature:MIME-Version:
	 Content-Type:Content-Transfer-Encoding:Subject:From:To:Cc:In-Reply-To:
	 References:Date:Message-Id:X-Mailer:X-Last-TLS-Session-Version;
	bh=SQGonsD2PK7GWC/netIzR2TM8App6Wl9rs87xlw6FJA=;
	b=oWjlfFCGblR1JvSLpKcIsj9MHPurs2+/81Ay9lUZ4eTqniUXFxc7eB5He10kmniVr02A
	 51kfJl/f1/FRLXFV4lFnfXXO0d5T1cUZ+URP3gwB3yjuUqrlhXbjV22xgCX/0r6L061Wq
	 ctR6I/NFg2fCUJw59UKwvLoepcMdaqzukFJVvW1rxit3g54LKR9iAARxArbCzkn1jrVPt
	 4jyJ6ZarGdZcQEbjrP+ZJis+uFyl48edFq4WU1aBBvCVnGVEPI02S/I68KjaxVcuajpLQ
	 QwDZ57VSz0ii0TZwn+7ywf4nA7BSfmDSUy6azMz8NCTHnbW0BfgoRK7Cdpg/oXR1Jkg==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=bootlin.com;
	spf=pass smtp.mailfrom=bootlin.com;
	dkim=pass header.d=bootlin.com header.i=@bootlin.com header.a=rsa-sha256 header.s=dkim header.b=jSP6Whf8;
	arc=none smtp.remote-ip=185.171.202.116
Received: from smtpout-04.galae.net (smtpout-04.galae.net [185.171.202.116])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E0245606A333
	for <stable@vger.kernel.org>; Thu, 26 Nov 2026 10:19:30 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org E0245606A333
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=bootlin.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=bootlin.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=bootlin.com header.i=@bootlin.com header.a=rsa-sha256 header.s=dkim header.b=jSP6Whf8
Received: from smtpout-01.galae.net (smtpout-01.galae.net [212.83.139.233])
	by smtpout-04.galae.net (Postfix) with ESMTPS id A0B40C2B9C6
	for <stable@vger.kernel.org>; Thu, 26 Nov 2026 10:19:31 +0000 (UTC)
Received: from mail.galae.net (mail.galae.net [212.83.136.155])
	by smtpout-01.galae.net (Postfix) with ESMTPS id 5E74460237;
	Thu, 26 Nov 2026 10:19:23 +0000 (UTC)
Received: from [127.0.0.1] (localhost [127.0.0.1]) by localhost (Mailerdaemon) with ESMTPSA id 1193411E68598;
	Thu, 26 Nov 2026 11:19:20 +0100 (CET)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=bootlin.com; s=dkim;
	t=1795688362; h=from:subject:date:message-id:to:cc:mime-version:content-type:
	 content-transfer-encoding:in-reply-to:references;
	bh=SQGonsD2PK7GWC/netIzR2TM8App6Wl9rs87xlw6FJA=;
	b=jSP6Whf85i8qwAwUPYtobw53QR/zvwF7ux1WIRVyNkmwbjC7lft1m8mbr3ZDXw37LKN2ex
	CcLFjBpRmKMgzesx6tQlAFflXr8iIW1t2TSMpdVov0chWqNdd9qAuuKrdmnA9vxHGKDx8a
	DQpMxmA+7iLu2OybHA25A2Jj0MsRwTJjk2Lpd22A/st1zirAJLlRtA99QdEeZzvzZhfck2
	OYDo/rf+uV/DUWkny+fBpPs3Kz8RkS5lt9k67MSMY2UWIZUxo2SUga9HSfhruJQeT8DyeF
	rQgMRHwzCfFBpKFeOOWfp3790ywOTl4V1EqmE+mjdpAoCsPcVWXinN9B8v4Y6g==
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
Subject: Re: [PATCH] i2c: cgbc: Fetch the status of a write transfer
From: "Thomas Richard (congatec GmbH)" <thomas.richard@bootlin.com>
To: Thomas Richard <thomas.richard@bootlin.com>, 
 Andi Shyti <andi.shyti@kernel.org>, Lee Jones <lee@kernel.org>
Cc: mfd@lists.linux.dev, linux-i2c@vger.kernel.org, 
 linux-kernel@vger.kernel.org, stable@vger.kernel.org, 
 Markus Haberlander <markus.haberlander@rosenberger.com>
In-Reply-To: <20261123-cgbc-i2c-write-status-v1-1-5b0fa0322b57@rosenberger.com>
References: <20261123-cgbc-i2c-write-status-v1-1-5b0fa0322b57@rosenberger.com>
Date: Thu, 26 Nov 2026 11:19:00 +0100
Message-Id: <179568834099.302193.16315749597111506309.b4-review@b4>
X-Mailer: b4 0.16.0
X-Last-TLS-Session-Version: TLSv1.3

> A write transfer sends the I2C command to the board controller and
> returns without reading the controller's I2C status, while a read polls
> the status until the controller is no longer busy. The status of a write
> is therefore never fetched:
> 
> - the write reports success before the bus transfer has finished, and
>   an error such as a NAK is only reported by the next transfer;
> - the controller keeps the status of the last write pending. On a
>   conga-PA7 (BIOS PA70R026, board controller CGBCP032), a board reset
>   with a write status pending does not power the board up again: after
>   a reboot that follows a write on the general purpose bus, the board
>   stays off until it is power cycled.
> 
> Read the status after a write as well, as the read path does: poll until
> the controller is no longer busy, return the error it reports, and treat
> any state other than idle as an error.
> 
> Tested on a conga-PA7 with v6.18.64 and "i2c: cgbc: Propagate hardware
> errors when polling read status": without this patch, a write to an
> absent address returns success, the next read fails, and a reboot after
> a write does not come back. With it, the write itself fails, the next
> transfer succeeds, and 14 reboots, each right after an acknowledged or a
> NAKed write, all came back.
> 
> The patch and this changelog were drafted with the help of Claude
> Opus 5.5 and reviewed and tested by me.
> 
> Fixes: 6894f640b8f3 ("i2c: Congatec Board Controller i2c bus driver")
> Cc: stable@vger.kernel.org
> Signed-off-by: Markus Haberlander <markus.haberlander@rosenberger.com>
>
> diff --git a/drivers/i2c/busses/i2c-cgbc.c b/drivers/i2c/busses/i2c-cgbc.c
> index dfdb9ffc6447..2361591a1e31 100644
> --- a/drivers/i2c/busses/i2c-cgbc.c
> +++ b/drivers/i2c/busses/i2c-cgbc.c
> @@ -254,6 +254,22 @@ static int cgbc_i2c_xfer_msg(struct i2c_adapter *adap)
>  		ret = cgbc_command(cgbc, &cmd, cmd_len, NULL, 0, NULL);
>  		if (ret)
>  			goto err;
> +
> +		ret = read_poll_timeout(cgbc_i2c_get_status, status,
> +					status != CGBC_I2C_STAT_BUSY, 0,
> +					2 * algo_data->read_maxtime_us, false, adap);
> +		if (ret)
> +			goto err;
> +
> +		if (status < 0) {
> +			ret = status;
> +			goto err;
> +		}
> +
> +		if (status != CGBC_I2C_STAT_IDL) {
> +			ret = -EIO;
> +			goto err;
> +		}
>  	} else if (i2c->state == CGBC_I2C_STATE_READ) {
>  		xfer.write = 0;
>  		xfer.read = len;

I was able to reproduce the issue on conga-SA7 (and also the reboot crash).

$ i2ctransfer -y 11 w1@0x40 0x00	 <- non-existing device
$ i2ctransfer -y 11 w1@0x50 0x00 r1@0x50 <- read EEPROM
Error: Sending messages failed: Input/output error
$ i2ctransfer -y 11 w1@0x50 0x00 r1@0x50 <- read EEPROM
0x01

And with your patch:

$ i2ctransfer -y 11 w1@0x40 0x00	 <- non-existing device
Error: Sending messages failed: Input/output error
$ i2ctransfer -y 11 w1@0x50 0x00 r1@0x50 <- read EEPROM
0x01

Reviewed-by: Thomas Richard (congatec GmbH) <thomas.richard@bootlin.com>
Tested-by: Thomas Richard (congatec GmbH) <thomas.richard@bootlin.com>

Yes it conflicts (compile issue) with the series [1]. The possibilies are:
- I pick this patch in my series and send a v7.
- [1] is applied, an immutable branch is created, you rebase your patch on
  top of it, and patch is applied in I2C tree.
- [1] is applied, you rebase on top of mfd-next, and your patch is applied
  in MFD tree.

Andi, Lee, what do you prefer?

[1] https://lore.kernel.org/all/20261117-cgbc-i2c-storage-devices-support-v6-0-bb070ad3e9aa@bootlin.com/

-- 
Best Regards,
Thomas Richard

