Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=185.246.84.56
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1792745050;
	b=touB6a5DBN3UeclgiUkaWBsWzvtbvaSN2mdk0hk2mhMUMsZeB/cT+Z1DbXRDpCB8t4cR
	 Is6k4BwCxix6RIYxjEEkLpJpVzl7yMKzZNnFFQkms6sq4DRaHyShG91IzXDgplEuayIfP
	 oLvMIYw0pF48OcRFmNWm4nL7udgIQwnL5A2upp185VjWJyFkPC9AwdqNcRlyYbKDMkehv
	 szAPv7FY8l1qbLFyqN/hKqB/sjUFrM2ty4UItHRshZ5nxqmGJtffUshwH//hMOdo0Lc/3
	 prwtDTrtR/NQbWRgq4ZKCG/q7mE2TDpEeHRpPJyWBYFmqlV6p+eu3tgixRgIUsc+MoQ==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1792745050;
	h=DMARC-Filter:Received:Received:Received:DKIM-Signature:MIME-Version:
	 Content-Type:Content-Transfer-Encoding:Subject:From:To:Cc:In-Reply-To:
	 References:Date:Message-Id:X-Mailer:X-Last-TLS-Session-Version;
	bh=Z+XZ/53UvCxImzQ+Xo+GZ40Pfdr9wSp/K3Gh847KDWc=;
	b=SdAedZyyJsESZEFanHR6dyAqY/L05npMMldrP9ayQtRUXSdaCWGHLhWclzDRGZIIS8hd
	 SwJISONF/Qb0hUpFo096ZIdBE8X6HkB6njHiwAxv0KpqgKU125+Br8URDTVEUjozkg4S9
	 cavP3ydDRMESuVMnVSp8rJdiMSbva46A+Mz53O0Qy+DOv1VDMGq8QN6c6mUsYf7oZtlli
	 UMqpdrKKgxr0xrMHU6Y31njPjFJfLmYCzvT/vO6RoUAZ9A1lU0rJj8kRXSLSe52oY55yx
	 9SuYrvp9Um2yhwMz1iA8D6PP3K9O11NSZthZxNPKPEujuVQ1QVohrnwF5o9bHCNJ/PQ==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=bootlin.com;
	spf=pass smtp.mailfrom=bootlin.com;
	dkim=pass header.d=bootlin.com header.i=@bootlin.com header.a=rsa-sha256 header.s=dkim header.b=XL4P28f7;
	arc=none smtp.remote-ip=185.246.84.56
Received: from smtpout-02.galae.net (smtpout-02.galae.net [185.246.84.56])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7945F606A31A;
	Fri, 23 Oct 2026 08:44:08 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 7945F606A31A
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=bootlin.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=bootlin.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=bootlin.com header.i=@bootlin.com header.a=rsa-sha256 header.s=dkim header.b=XL4P28f7
Received: from smtpout-01.galae.net (smtpout-01.galae.net [212.83.139.233])
	by smtpout-02.galae.net (Postfix) with ESMTPS id CA9461A12EC;
	Fri, 23 Oct 2026 08:44:06 +0000 (UTC)
Received: from mail.galae.net (mail.galae.net [212.83.136.155])
	by smtpout-01.galae.net (Postfix) with ESMTPS id 82BA060398;
	Fri, 23 Oct 2026 08:44:06 +0000 (UTC)
Received: from [127.0.0.1] (localhost [127.0.0.1]) by localhost (Mailerdaemon) with ESMTPSA id 6D37010328501;
	Fri, 23 Oct 2026 10:44:04 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=bootlin.com; s=dkim;
	t=1792745045; h=from:subject:date:message-id:to:cc:mime-version:content-type:
	 content-transfer-encoding:in-reply-to:references;
	bh=Z+XZ/53UvCxImzQ+Xo+GZ40Pfdr9wSp/K3Gh847KDWc=;
	b=XL4P28f7gy9ZFsrQTNe5CArpyMLBjN3CAN5OeiY0VLfyMdc0bvOv9TiZqNkTe6qxN7oEvp
	e6F7cIXnc6z8ARxg7DkuZHdOs1E58dkX2WdwNDyh80koOsaIjI9nTtHtbsAfuW7zbyIjnf
	hL8CaaOEbE235DpNzFryOBT+OabOWtDPmQi6EHMeRbjcT7HowMVio91ly5maFU7ACs2TPW
	+Jxi35PI/s5G2cXb8Ht/QYpe6kd7whiLXJP3vyMHaqmVW1WMVnl2xtFA81vntWTugFr/a/
	vFLVCCYDC4+UUeFTSnntURxK3l/rxOGF9Bpu/asOREKKldewqZVo0bF2Z+6KiQ==
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
Subject: Re: [PATCH 27/28] i2c: cgbc: Propagate hardware errors when
 polling read status
From: "Thomas Richard (congatec GmbH)" <thomas.richard@bootlin.com>
To: Lee Jones <lee@kernel.org>
Cc: Thomas Richard <thomas.richard@bootlin.com>, 
 Andi Shyti <andi.shyti@kernel.org>, linux-i2c@vger.kernel.org, 
 linux-kernel@vger.kernel.org, stable@vger.kernel.org
In-Reply-To: <20261021121245.3111563-27-lee@kernel.org>
References: <20261021121245.3111563-1-lee@kernel.org>
 <20261021121245.3111563-27-lee@kernel.org>
Date: Fri, 23 Oct 2026 10:43:47 +0200
Message-Id: <179274502734.1225981.17255285643417793434.b4-review@b4>
X-Mailer: b4 0.16.0
X-Last-TLS-Session-Version: TLSv1.3

> In cgbc_i2c_xfer_msg(), read_poll_timeout() uses the same ret variable
> to store the polled return value of cgbc_i2c_get_status() and the
> timeout result of the macro itself.  When cgbc_i2c_get_status() returns
> a negative error code (such as -EIO on an I2C NACK), the loop condition
> ret != CGBC_I2C_STAT_BUSY evaluates to true and read_poll_timeout()
> overwrites ret with 0.  The driver then issues CGBC_I2C_CMD_DATA, which
> completes with CGBC_STATUS_CMD_READY without populating msg->buf,
> leaving uninitialised heap memory in the caller's read buffer.
> 
> Store the polled status in a separate variable, verify that it equals
> CGBC_I2C_STAT_DAT, and check that CGBC_I2C_CMD_DATA returns the expected
> number of bytes.
> 
> Fixes: 6894f640b8f3 ("i2c: Congatec Board Controller i2c bus driver")
> Closes: https://sashiko.dev/#/bug/linux-66cbf4b1-a219-4012-969d-236417bf419a
> Cc: stable@vger.kernel.org
> Signed-off-by: Lee Jones <lee@kernel.org>
>
> diff --git a/drivers/i2c/busses/i2c-cgbc.c b/drivers/i2c/busses/i2c-cgbc.c
> index 682ba639d887..3226838cca46 100644
> --- a/drivers/i2c/busses/i2c-cgbc.c
> +++ b/drivers/i2c/busses/i2c-cgbc.c
> @@ -198,9 +198,9 @@ static int cgbc_i2c_xfer_msg(struct i2c_adapter *adap)
>  	struct cgbc_device_data *cgbc = i2c->cgbc;
>  	struct i2c_msg *msg = i2c->msg;
>  	u8 cmd[CGBC_I2C_CMD_SIZE];
> -	int ret, max_len, len, i;
> +	int ret, status, max_len, len, i;
>  	unsigned int cmd_len;
> -	u8 cmd_data;
> +	u8 cmd_data, data_len;
>  
>  	struct cgbc_i2c_transfer xfer = {
>  		.bus_id = i2c->bus_id,
> @@ -259,17 +259,32 @@ static int cgbc_i2c_xfer_msg(struct i2c_adapter *adap)
>  		if (ret)
>  			goto err;
>  
> -		ret = read_poll_timeout(cgbc_i2c_get_status, ret,
> -					ret != CGBC_I2C_STAT_BUSY, 0,
> +		ret = read_poll_timeout(cgbc_i2c_get_status, status,
> +					status != CGBC_I2C_STAT_BUSY, 0,
>  					2 * i2c->read_maxtime_us, false, adap);
> -		if (ret < 0)
> +		if (ret)
> +			goto err;
> +
> +		if (status < 0) {
> +			ret = status;
>  			goto err;
> +		}
> +
> +		if (status != CGBC_I2C_STAT_DAT) {
> +			ret = -EIO;
> +			goto err;
> +		}

We could save a goto and make code more readable IMO

if (ret)
	goto err;

if (status != CGBC_I2C_STAT_DAT) {
	ret = (status < 0) ? status : -EIO;
	goto err;
}

>  
>  		cmd_data = CGBC_I2C_CMD_DATA | i2c->bus_id;
>  		ret = cgbc_command(cgbc, &cmd_data, sizeof(cmd_data),
> -				   msg->buf + i2c->pos, len, NULL);
> +				   msg->buf + i2c->pos, len, &data_len);
>  		if (ret)
>  			goto err;
> +
> +		if (data_len != len) {
> +			ret = -EIO;
> +			goto err;
> +		}
>  	}
>  
>  	if (len == (msg->len - i2c->pos)) {

Otherwise looks good to me.

Reviewed-by: Thomas Richard (congatec GmbH) <thomas.richard@bootlin.com>
Tested-by: Thomas Richard (congatec GmbH) <thomas.richard@bootlin.com>

Best Regards,
Thomas

-- 
Thomas Richard (congatec GmbH) <thomas.richard@bootlin.com>
