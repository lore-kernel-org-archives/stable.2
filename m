Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=185.246.84.56
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1792603132;
	b=0pahgNLfZNtzWyDnCEnQYPH3bV086MWAAtqdC1E8huNMSBikK9hE1hHu0RvrSGN+COGU
	 h2WKwjrrbnpxN952sxTvcLtR/IY4Ml0peb5QMK7wfh00cYWKnforyWcIZZU7EJP3ri6aF
	 4bVeerAUButeaZng3WC2Lr0zF/u31OoymcdTRHM3Do8o8T6OL0JHrO37LCF1dbeIUIvIX
	 5kM5/kJwZV5CVW9G4U/LaSl7KghZe+7z2mpJrlar1KsXmDewKy3eyukqB8cH2m4je2Lo4
	 /BM33qQ8pldzVK/8nkQ/OLTidnZ1yIXFyqSM18GcKD27ZHSDYWi5fo8+V+B6+RFtzLQ==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1792603132;
	h=DMARC-Filter:Received:Received:Received:DKIM-Signature:MIME-Version:
	 Content-Type:Content-Transfer-Encoding:Subject:From:To:Cc:In-Reply-To:
	 References:Date:Message-Id:X-Mailer:X-Last-TLS-Session-Version;
	bh=D5rcxsFZdOnBsChcn2OwDSeYiCmUrlk0I9zL6NmVr2E=;
	b=3RfrWz+KvcpcZPc0mmDYS2/27v/DenRVDHB0ezz+xU+R5WHOcg4Y82g2rvB9hqWEkRmF
	 M0JIMgAeZy8AUH/6OAjGjlxTH5I2YTHQtJ1Lez5Y627N77o3DesZTqQymVCZX2RgMez/0
	 AyZLW2yQl+FUZB6YwuYpdsLRnLSd+m1Y2QovBZTF0A/iMLbz/R+j9eYrDZp2pTEcZOYGw
	 MA30bw+PS++msgpFeTJt6cCe4b1tO1KOe0NL5YwqC4iLmCCG9sTnNWGOweQ11f05h9HFR
	 IsNsyYo5IXB8S3uPqHTta/84HX77C87TfadON8YzWWTZgwwdmlf0TWfYBweevQKvhmg==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=bootlin.com;
	spf=pass smtp.mailfrom=bootlin.com;
	dkim=pass header.d=bootlin.com header.i=@bootlin.com header.a=rsa-sha256 header.s=dkim header.b=ZEyYEg5A;
	arc=none smtp.remote-ip=185.246.84.56
Received: from smtpout-02.galae.net (smtpout-02.galae.net [185.246.84.56])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E1514606A31B;
	Wed, 21 Oct 2026 17:18:49 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org E1514606A31B
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=bootlin.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=bootlin.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=bootlin.com header.i=@bootlin.com header.a=rsa-sha256 header.s=dkim header.b=ZEyYEg5A
Received: from smtpout-01.galae.net (smtpout-01.galae.net [212.83.139.233])
	by smtpout-02.galae.net (Postfix) with ESMTPS id 3BF9B1A12B1;
	Wed, 21 Oct 2026 17:18:48 +0000 (UTC)
Received: from mail.galae.net (mail.galae.net [212.83.136.155])
	by smtpout-01.galae.net (Postfix) with ESMTPS id EB3FA606E3;
	Wed, 21 Oct 2026 17:18:47 +0000 (UTC)
Received: from [127.0.0.1] (localhost [127.0.0.1]) by localhost (Mailerdaemon) with ESMTPSA id 5A90710328D6E;
	Wed, 21 Oct 2026 19:18:42 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=bootlin.com; s=dkim;
	t=1792603123; h=from:subject:date:message-id:to:cc:mime-version:content-type:
	 content-transfer-encoding:in-reply-to:references;
	bh=D5rcxsFZdOnBsChcn2OwDSeYiCmUrlk0I9zL6NmVr2E=;
	b=ZEyYEg5AAcLne7uj/7uFyelWMlWfSvogrfZvUZynWS6BjP1w4XI1xtk7fskSKVjdBO6Bta
	trFxXdN3IKVfXZaXBWJfYbTA4JAt1N24Q7iJcb5a9hHN27xXBul9wyKmBzNmLcQXm2QkUo
	yeuvVRut28K5AuKMIgH100WCmY06rMN+4VhCYBNnXmsAq/fpXNzwjz/0fpaYMHaQGrtAhM
	9fH523fCP/SgaoCkt9C529yLZ8y38bKLdgHAW3CxaAd6ZsRzr5mXLR9jorcbE8CvQOCLa4
	TaVcSGxiLcXG5mAnIAmIrzTKGVx7Xs17miVOlp0+FQOcV2S/xdwVVq5RbN74BA==
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
Subject: Re: [PATCH 09/28] mfd: cgbc: Zero-initialise version buffer in
 cgbc_get_version()
From: "Thomas Richard (congatec GmbH)" <thomas.richard@bootlin.com>
To: "Thomas Richard (congatec GmbH)" <thomas.richard@bootlin.com>
Cc: Lee Jones <lee@kernel.org>, mfd@lists.linux.dev, 
 linux-kernel@vger.kernel.org, stable@vger.kernel.org
In-Reply-To: <179260069841.1125687.16461366525950099809.b4-review@b4>
References: <20261021121245.3111563-1-lee@kernel.org>
 <20261021121245.3111563-9-lee@kernel.org>
 <179260069841.1125687.16461366525950099809.b4-review@b4>
Date: Wed, 21 Oct 2026 19:18:29 +0200
Message-Id: <179260310903.1125687.4328531935004472672.b4-reply@b4>
X-Mailer: b4 0.16.0
X-Last-TLS-Session-Version: TLSv1.3

On 2026-10-21 18:38:18+02:00, Thomas Richard (congatec GmbH) wrote:
> > If the Board Controller returns a short response to the firmware
> > revision query in cgbc_get_version(), cgbc_command() can succeed
> > without populating all bytes of the stack-allocated data buffer.
> > Those uninitialised stack bytes are then copied into cgbc->version
> > and exposed to userspace via the cgbc_version sysfs attribute.
> > 
> > Zero-initialise the data buffer on the stack to prevent leaking
> > uninitialised kernel stack memory.
> > 
> > Fixes: 6f1067cfbee7 ("mfd: Add Congatec Board Controller driver")
> > Closes: https://sashiko.dev/#/bug/linux-8c473713-527e-4619-8404-689f28c7654d
> > Cc: stable@vger.kernel.org
> > Signed-off-by: Lee Jones <lee@kernel.org>
> >
> > diff --git a/drivers/mfd/cgbc-core.c b/drivers/mfd/cgbc-core.c
> > index edfac2b60718..7513ba42eb96 100644
> > --- a/drivers/mfd/cgbc-core.c
> > +++ b/drivers/mfd/cgbc-core.c
> > @@ -461,7 +461,7 @@ ATTRIBUTE_GROUPS(cgbc);
> >  static int cgbc_get_version(struct cgbc_device_data *cgbc)
> >  {
> >  	u8 cmd = CGBC_CMD_GET_FW_REV;
> > -	u8 data[4];
> > +	u8 data[4] = {};
> >  	int ret;
> >  
> >  	ret = cgbc_command(cgbc, &cmd, 1, &data, sizeof(data), NULL);
> 
> Yes Sashiko complained multiple times even if I already explained it cannot
> happen if cgbc_command succeeds. Anyway I agree that things can be improved
> but I would prefer in a generic way:
> - add macros for cmd resp size (eg CGBC_CMD_GET_FW_REV_RESP_SIZE) in all cgbc
>   drivers
> - cgbc_command() should return an error if data buffer size doesn't match
>   the number of bytes returned by the hardware, it is not the case today [1].

I mean return an error if data buffer size is smaller than the number of
bytes returned by the hardware. Also cgbc_command() should initialize data
buffer first (in case of it does not populate all bytes after), so no need
to it from the callers. I also noticed we use cmd and data pointers, but we
did not check if they are NULL.

I'll send a series to address all of these issues. So you can drop this
patch.

Best Regards,
Thomas


