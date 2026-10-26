Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=100.103.45.18
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1793026408;
	b=ptiHQPkrjtDEmNlpQoutjsq7TkHIWVOeJZl1+7E1q/TBQjrcKjxaec4INJIx0v5geh4S
	 u8Koo9L/wnlWb6RoRNpNCzDyj3eUhtBq7xUB0v1o8EIUQ/2SKoCOjZG/hgaaIdUG8MERJ
	 lVq/QsR079uUMAxnBktQZWBeq1kDz6NyLPYtFiPhY2UwubaFme/XNRsw+aBeB3p8PMw8R
	 90CQbsqfin/yy1foeb3EMJZSDBzdOHelHfqxfivJfl40ZYS0W/znF4f8yuRsKzMK1zjA/
	 tInqIWmW96YogoqtWx4sOWBJ51hneiiaTIfirAWNxd8drAfClOMf2H9+BwsdpeuRm1g==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1793026408;
	h=Received:DKIM-Signature:Date:From:To:Cc:Subject:Message-ID:
	 References:MIME-Version:Content-Type:Content-Disposition:In-Reply-To;
	bh=C0X3A9X5FibURRyeVwfCqcuTEpYjJX2HQwwqPTfSt8c=;
	b=LYM2ToKQutk3j006BOj/poIe8Ow1OHCgsR2Fh7B4zpOowt1s2/C+5oKMYel+iP11ox5l
	 BDvnK+NdBz/biJp+MuEMLWkyLK/7FUGY2CagnsiZRDiNRyApwxpSVAZZRQwlrgpSbpoen
	 5JmKcmuGaYNIw+k/z3f6OkonVa6+LG6rUzFbP38Uj3TKtjJ8zlVkGtQmwNnUjGZg194ij
	 YtrP4Z174xIQkCVY96we/C+nZvvtOE/jNNPSnLKrFABaAXMwa36JhgEA4qlg9AuL64x1e
	 pSf1dqN/eN/1d8EjTdjdJlShnTpUqe6a7KdItSXl5dVd+JZQN/1K4hixv/MLQpsqW5Q==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dkim=pass header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=QFRp0Bfs;
	arc=none smtp.remote-ip=100.103.45.18
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 566CB606A31A;
	Mon, 26 Oct 2026 14:53:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=QFRp0Bfs
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 099531F01825;
	Mon, 26 Oct 2026 14:53:26 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1793026408;
	bh=C0X3A9X5FibURRyeVwfCqcuTEpYjJX2HQwwqPTfSt8c=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To;
	b=QFRp0BfsdpmLotnFgCep9bJLOWIUA6u9XGSUNeFO7wEMzlpCk74aMIdj5DlKX9dCe
	 LW9x9yvInNpRPkvWZc2VBEDRlrI36sMNQVYlPW42LkW3lB7L0+5CtBjmOfaRc3Rjb6
	 QJcKFnLTG9BnxRXzpF04tGS31PR5bl5/OOmgBmW+M9wsoWRhTVtQooB9BbTEmYtoVa
	 n47cXqOaolw7SEZLk5k2xg7A8eDEuU8HPmfAaa6Yr44cVadl696ZI3IElNO6AFeCD+
	 UMJ0kw88f5GGkY9LgPmGrNNW9XuHaKw/HA3En2O7scvnH8Csucte4h5U7wjnmTNM0r
	 INM/Jn8YEIwaQ==
Date: Mon, 26 Oct 2026 14:53:24 +0000
From: Lee Jones <lee@kernel.org>
To: "Thomas Richard (congatec GmbH)" <thomas.richard@bootlin.com>
Cc: Andi Shyti <andi.shyti@kernel.org>, linux-i2c@vger.kernel.org,
	linux-kernel@vger.kernel.org, stable@vger.kernel.org
Subject: Re: [PATCH 27/28] i2c: cgbc: Propagate hardware errors when polling
 read status
Message-ID: <20261026145324.GA2195460@google.com>
References: <20261021121245.3111563-1-lee@kernel.org>
 <20261021121245.3111563-27-lee@kernel.org>
 <179274502734.1225981.17255285643417793434.b4-review@b4>
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
In-Reply-To: <179274502734.1225981.17255285643417793434.b4-review@b4>

On Fri, 23 Oct 2026, Thomas Richard (congatec GmbH) wrote:

> > In cgbc_i2c_xfer_msg(), read_poll_timeout() uses the same ret variable
> > to store the polled return value of cgbc_i2c_get_status() and the
> > timeout result of the macro itself.  When cgbc_i2c_get_status() returns
> > a negative error code (such as -EIO on an I2C NACK), the loop condition
> > ret != CGBC_I2C_STAT_BUSY evaluates to true and read_poll_timeout()
> > overwrites ret with 0.  The driver then issues CGBC_I2C_CMD_DATA, which
> > completes with CGBC_STATUS_CMD_READY without populating msg->buf,
> > leaving uninitialised heap memory in the caller's read buffer.
> > 
> > Store the polled status in a separate variable, verify that it equals
> > CGBC_I2C_STAT_DAT, and check that CGBC_I2C_CMD_DATA returns the expected
> > number of bytes.
> > 
> > Fixes: 6894f640b8f3 ("i2c: Congatec Board Controller i2c bus driver")
> > Closes: https://sashiko.dev/#/bug/linux-66cbf4b1-a219-4012-969d-236417bf419a
> > Cc: stable@vger.kernel.org
> > Signed-off-by: Lee Jones <lee@kernel.org>
> >
> > diff --git a/drivers/i2c/busses/i2c-cgbc.c b/drivers/i2c/busses/i2c-cgbc.c
> > index 682ba639d887..3226838cca46 100644
> > --- a/drivers/i2c/busses/i2c-cgbc.c
> > +++ b/drivers/i2c/busses/i2c-cgbc.c
> > @@ -198,9 +198,9 @@ static int cgbc_i2c_xfer_msg(struct i2c_adapter *adap)
> >  	struct cgbc_device_data *cgbc = i2c->cgbc;
> >  	struct i2c_msg *msg = i2c->msg;
> >  	u8 cmd[CGBC_I2C_CMD_SIZE];
> > -	int ret, max_len, len, i;
> > +	int ret, status, max_len, len, i;
> >  	unsigned int cmd_len;
> > -	u8 cmd_data;
> > +	u8 cmd_data, data_len;
> >  
> >  	struct cgbc_i2c_transfer xfer = {
> >  		.bus_id = i2c->bus_id,
> > @@ -259,17 +259,32 @@ static int cgbc_i2c_xfer_msg(struct i2c_adapter *adap)
> >  		if (ret)
> >  			goto err;
> >  
> > -		ret = read_poll_timeout(cgbc_i2c_get_status, ret,
> > -					ret != CGBC_I2C_STAT_BUSY, 0,
> > +		ret = read_poll_timeout(cgbc_i2c_get_status, status,
> > +					status != CGBC_I2C_STAT_BUSY, 0,
> >  					2 * i2c->read_maxtime_us, false, adap);
> > -		if (ret < 0)
> > +		if (ret)
> > +			goto err;
> > +
> > +		if (status < 0) {
> > +			ret = status;
> >  			goto err;
> > +		}
> > +
> > +		if (status != CGBC_I2C_STAT_DAT) {
> > +			ret = -EIO;
> > +			goto err;
> > +		}
> 
> We could save a goto and make code more readable IMO
> 
> if (ret)
> 	goto err;
> 
> if (status != CGBC_I2C_STAT_DAT) {
> 	ret = (status < 0) ? status : -EIO;

Ternary operators certainly do not make the code _more_ readable.

Concise, yes.  Readable, no.  The current code is preferable.

> }
> 
> >  
> >  		cmd_data = CGBC_I2C_CMD_DATA | i2c->bus_id;
> >  		ret = cgbc_command(cgbc, &cmd_data, sizeof(cmd_data),
> > -				   msg->buf + i2c->pos, len, NULL);
> > +				   msg->buf + i2c->pos, len, &data_len);
> >  		if (ret)
> >  			goto err;
> > +
> > +		if (data_len != len) {
> > +			ret = -EIO;
> > +			goto err;
> > +		}
> >  	}
> >  
> >  	if (len == (msg->len - i2c->pos)) {
> 
> Otherwise looks good to me.
> 
> Reviewed-by: Thomas Richard (congatec GmbH) <thomas.richard@bootlin.com>
> Tested-by: Thomas Richard (congatec GmbH) <thomas.richard@bootlin.com>

Thanks for these.  Much appreciated.

-- 
Lee Jones
