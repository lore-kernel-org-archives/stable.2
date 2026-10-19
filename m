Received: from mail-qt1-f169.google.com (mail-qt1-f169.google.com [209.85.160.169])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 015C7552EAC
	for <stable@vger.kernel.org>; Mon, 19 Oct 2026 14:13:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.160.169
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1792419237; cv=none; b=TU9hkKjh+Fx75dYgjiHvscp1HeRDrec3tUj2w7/8I+Y06Z7CALythrNRIGQS01/K25BuUGLEHOKcelrG+j7K9AGEYiyvziFgcA1Lagc5U+8xX3YR70ZZ0lBPoPQ35sD+qB70+s5iSrifyqW//vWDs/PocwHgI3vXvQ4jt4POqgA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1792419237; c=relaxed/simple;
	bh=Xj1tXuPgTXzaT3nix7piE0Gi8Q7+az0H1KHgxrxkFZw=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=nSIwOLwrXMJoqF4fxbsDGn/ohegeGr/Y+tuhoR7wD5xtaMiemcJQnhoO9KjSNVJCqhIo+5Uu62doJEyem1Xocur/jlbG/77IDQFwQDRJFCDTJyOmeXkrdhjkUZthx0K4ZOzJmFqilwHnzG5oU9RXj5lA8vDU4dSUKigqhDccpLU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=rowland.harvard.edu; spf=fail smtp.mailfrom=g.harvard.edu; dkim=pass (2048-bit key) header.d=rowland.harvard.edu header.i=@rowland.harvard.edu header.b=YTFZ7HMD; arc=none smtp.client-ip=209.85.160.169
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=rowland.harvard.edu
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=g.harvard.edu
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=rowland.harvard.edu header.i=@rowland.harvard.edu header.b="YTFZ7HMD"
Received: by mail-qt1-f169.google.com with SMTP id d75a77b69052e-53669f7b518so10847531cf.2
        for <stable@vger.kernel.org>; Mon, 19 Oct 2026 07:13:55 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=rowland.harvard.edu; s=google; t=1792419235; x=1793024035; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:content-type:mime-version
         :references:message-id:subject:cc:to:from:date:from:to:cc:subject
         :date:message-id:reply-to:content-type;
        bh=5BlttwcoFjB9LyfPGuIFgEh48duPPMU/zmrf0OZAJ0E=;
        b=YTFZ7HMD0+7eZ0cb4C8DJvhGaaAIA6s1oS0hIaYf7kL2wQRV+jZYSV9KxZGeBF8JS4
         TXVFnK+81s75jp2tm77iwoWJMVq1KL3zlwcfDoqcGKhxtGkwDxujOSW4mgcSfaoEGZiQ
         yQmxvhJTVl9xc6i/eDFIxsUkRzJlChX/LeXyNHXv08kbEZMhvdu/JmMGpfxj6uDwVRZZ
         8P3SSpVfZ+KE9tzgT8BL6MIQkgfPdyVxStqzrp3TDDL5YzFc7JiyrNibTY5g30HsOeRk
         iif9nlaAjJLNu73mXLR2QYHJ5oHAh5fz+OhUR1yCr8zn7AtNSKEaCounzi30FMfcpfGi
         mIPA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1792419235; x=1793024035;
        h=in-reply-to:content-disposition:content-type:mime-version
         :references:message-id:subject:cc:to:from:date:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=5BlttwcoFjB9LyfPGuIFgEh48duPPMU/zmrf0OZAJ0E=;
        b=Fw++Dnd5VvwN1qjhy328jMqwFltRG/V7t6WtSaKKrSUJ1MsMYZFyy6SsiLcH8J173P
         XiP1P9Jz0jEeq0Kzzq3xUoFyzRRLeCWrNuagApmMjedU+5nRmcg728SoTwDRFezG8CSy
         vHvrToR1IV4y0ZtF/0JdACHg5R8PNfjYeaY2mO8GD7TiFjkoPmUF7UsFbleOFiXNUlSl
         zb0QOApYGf8n0azxuj+slBirpFZffaVQ1+O99/Aziy/DdWcd+wkA4Y87aM060feY2pED
         IKAnZ17c0p/4nDvFMJbSCex+VioOjYuaXCaVr2Xam/GrACOAfGRNO6yaueputKtYQj4G
         ReOg==
X-Forwarded-Encrypted: i=1; AKwUvByQ3BVBY7f45b77ecix9EXulG9tPHWaeaVCSA1v0p0f2YuSZbfC++w27Y6Q6vbi/13u9EOxhdk=@vger.kernel.org
X-Gm-Message-State: AFq9FYJ8FxavcA/8mkSnCDhHXKhKvuaHeKyVFtYj0JGAy/10QjwwByJe
	ONND5NPge06GGge0XN8KpHyt2/Ej3FtOPt9ZSrxEDiqsGdHHHrWCyeOlThmo6Jo+iQ==
X-Gm-Gg: AYBFou2DudeAxahxbGbQjjetfr3rEU6sfhdvovV1dmHvxtofcfwZ0BmNUlsUTDU7AOL
	72ZIGwI06uJbHnILe+5B+3xxZc6m43p01DoGhRZjMsVttZB0UGcNxJCbzPuY6oVDfmS7PbF6WNu
	P2j6EJ0758/IqdWKxefBWl/qmcwqEhdwd4DYGI1CaLAy+RfDjM8DXeJ7JyEOCEtwyOctA1UxuhJ
	AsCwB0/91Jnc7pSc61IqlWz5HnXQH8wZLZhVGwMECa5fjhDts+u7rBlKyeu+U50PrGKYWEyGMKE
	jbFU13bJWkHaoBeVWzNtndmTls82zF8OKXgWqWkBK63J/wmzn3Y7qeXs3MVe5npncT1R+4u/5px
	Ry0Qhd7KcMpMGWgmHQWKIvOKdycyaTW2NXnCFZc5ekSMWM46uOA141NVriyX/nTpTyKwep3BmNd
	5oeAfi/AfvGoDHsGD8wTi+QGPJHphJehl9QKnTJGbVb5vw6HZySr95Gf8vAyChJHSptll7fOJbv
	HZ6wSp2B/FoM/mJhKMAsxWVh94=
X-Received: by 2002:a05:622a:514e:b0:530:42d4:4c9a with SMTP id d75a77b69052e-5364605937emr109597891cf.44.1792419234421;
        Mon, 19 Oct 2026 07:13:54 -0700 (PDT)
Received: from rowland.harvard.edu ([140.247.181.15])
        by smtp.gmail.com with ESMTPSA id d75a77b69052e-5362a8e43cfsm99785331cf.5.2026.10.19.07.13.52
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 19 Oct 2026 07:13:52 -0700 (PDT)
Date: Mon, 19 Oct 2026 10:13:50 -0400
From: Alan Stern <stern@rowland.harvard.edu>
To: Andi Shyti <andi.shyti@kernel.org>
Cc: linux-media@vger.kernel.org, linux-usb@vger.kernel.org,
	syzkaller-bugs@googlegroups.com, stable@vger.kernel.org,
	Antti Palosaari <crope@iki.fi>,
	Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
	Mauro Carvalho Chehab <mchehab@kernel.org>
Subject: Re: [PATCH] media: dvb-usb-v2: ec168: Reject zero-length I2C reads
Message-ID: <1ab79363-7211-475d-8529-1d5c00586f8c@rowland.harvard.edu>
References: <20261019123542.4040472-1-andi.shyti@kernel.org>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20261019123542.4040472-1-andi.shyti@kernel.org>

On Mon, Oct 19, 2026 at 02:35:42PM +0200, Andi Shyti wrote:
> ec168_i2c_xfer() checks the length of the register-address
> message in a combined demodulator read, but does not validate the
> read message length. Userspace can supply a zero-length read
> through I2C_RDWR.
> 
> This reaches ec168_ctrl_msg(), which selects an IN control pipe
> for READ_DEMOD with wLength set to zero. The USB core treats
> control requests without a data stage as OUT(*), triggering the
> "BOGUS control dir" warning in usb_submit_urb().
> 
> Reject zero-length read messages with -EOPNOTSUPP before issuing
> the USB request, using the existing exit path to release the I2C
> mutex.
> 
> (*) is_out = ... || !setup->wLength;
> 
> Fixes: 2bf290be4f3e ("V4L/DVB (13364): ec168: add new driver for E3C EC168 DVB USB")
> Reported-by: syzbot+ed3ada41c4eb1c4ab78e@syzkaller.appspotmail.com
> Closes: https://syzkaller.appspot.com/bug?extid=ed3ada41c4eb1c4ab78e
> Signed-off-by: Andi Shyti <andi.shyti@kernel.org>
> Cc: <stable@vger.kernel.org> # v2.6.33+
> ---
>  drivers/media/usb/dvb-usb-v2/ec168.c | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)
> 
> diff --git a/drivers/media/usb/dvb-usb-v2/ec168.c b/drivers/media/usb/dvb-usb-v2/ec168.c
> index 973b32356b17..f6b98c7d3704 100644
> --- a/drivers/media/usb/dvb-usb-v2/ec168.c
> +++ b/drivers/media/usb/dvb-usb-v2/ec168.c
> @@ -115,7 +115,7 @@ static int ec168_i2c_xfer(struct i2c_adapter *adap, struct i2c_msg msg[],
>  	while (i < num) {
>  		if (num > i + 1 && (msg[i+1].flags & I2C_M_RD)) {
>  			if (msg[i].addr == ec168_ec100_config.demod_address) {
> -				if (msg[i].len < 1) {
> +				if (msg[i].len < 1 || msg[i+1].len < 1) {
>  					i = -EOPNOTSUPP;
>  					break;
>  				}

Isn't there an I2C quirks flag to indicate that 0-length reads aren't 
allowed?  Setting that flag would be more understandable than this test.

Alan Stern
