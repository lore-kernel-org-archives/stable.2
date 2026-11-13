Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=209.85.218.48
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1794563700;
	b=5oIUjACi2U5qjQZu3zLy+Ifhql0B5DkSVBv4ojY+UYKj1cD/PMyTACcUUIalfdod1is2
	 7h5BURaCU2FJSp6Ez2U2LyKzisaq1RUQjBrsCrCm+Mdo9hVJEVFI3tKKgy0Fnim/bpEKR
	 9wqpFZ9xeOqBZN+vmHwTK1HELpIS04Kejr6lYHz8IeOShALN8JJGQEV6igdWpXq77TvnO
	 mJ7qnXimRY6S+g4Uwj7B73a9Q80brFghs/29ZTNE4LoH6LSR39oxHAwN6dd+bjKqLYbA1
	 Zjh93PAbp633MuZ8h2x/F3pdUfjCrprq3h47e9RFeBF59OADIjOgWlsryryUkSFvLkA==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1794563700;
	h=DMARC-Filter:Received:DKIM-Signature:X-Google-DKIM-Signature:
	 X-Forwarded-Encrypted:X-Gm-Message-State:X-Gm-Gg:X-Received:Received:
	 Message-ID:Subject:From:To:Cc:Date:In-Reply-To:References:
	 Content-Type:Content-Transfer-Encoding:User-Agent:MIME-Version;
	bh=G8DmFU4pJwAPCJlqHBF8SKasEEThxtJNlC1sg/CSkLw=;
	b=CvTsPBMDbbWTCJafV5bRNNG+xgpSAnM5WWtpoSNRNMmOVQaYVH22JL5HBCUNf4aBsdQu
	 P4Odldm4kMrmN1fwKhi0O+Rd4IeuW29ckJ49+t0NZ9O7FO1MIP10ujmuJzNz9EwPjzuoX
	 gMTiDVqL8z1za54pRdEs2/Xas1ArZcksWAgvZQa+qMb3NSTtlTXd+P3WsMyZUb8GtQjqj
	 jf3HXVdy2vnNbTQLy4x9fi7k4GGjvJNeOrZYwXL4aE5bs4K4bfZ6mm4EnbyR0AEhJLTIt
	 ErOiuSdu+8i2irYXBMvKiuNqSF8Eu21pHu51xoeNvmmqutZrWBt2gu4fC2WPDdl0RZA==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=none header.from=amutable.com;
	spf=pass smtp.mailfrom=amutable.com;
	dkim=pass header.d=amutable-com.20260707.gappssmtp.com header.i=@amutable-com.20260707.gappssmtp.com header.a=rsa-sha256 header.s=20260707 header.b=sk58W6sW;
	arc=none smtp.remote-ip=209.85.218.48
Received: from mail-ej1-f48.google.com (mail-ej1-f48.google.com [209.85.218.48])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 39A3F60A2600
	for <stable@vger.kernel.org>; Fri, 13 Nov 2026 09:55:00 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 39A3F60A2600
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=amutable.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=amutable.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=amutable-com.20260707.gappssmtp.com header.i=@amutable-com.20260707.gappssmtp.com header.a=rsa-sha256 header.s=20260707 header.b=sk58W6sW
Received: by mail-ej1-f48.google.com with SMTP id a640c23a62f3a-c3f04e0e65fso169260466b.2
        for <stable@vger.kernel.org>; Fri, 13 Nov 2026 01:54:59 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=amutable-com.20260707.gappssmtp.com; s=20260707; t=1794563698; x=1795168498; darn=vger.kernel.org;
        h=mime-version:user-agent:content-transfer-encoding:content-type
         :references:in-reply-to:date:cc:to:from:subject:message-id:from:to
         :cc:subject:date:message-id:reply-to:content-type;
        bh=G8DmFU4pJwAPCJlqHBF8SKasEEThxtJNlC1sg/CSkLw=;
        b=sk58W6sWmN4ERo+6S+koVh/BM/TVuc998Smvb7+dAHAHasLoIxA1PyH7SpTb2sphTs
         qaL8BceJIK/C5zTluK59TXAg0t7i18MIhSXKzAc74GDtFkVBtJ5XexxofTn2ErTCpEyw
         wBL0ZIwSoD+QdFLNUYuAtp3uhttIIU+8CcgeY50Q9BuPcdVkRSxffNnvhBi5q+TOT3Z0
         N0fPVcnw8avDa7R0wdKzwUNoVC/3vPRCD1SmgKjZfrkNv7BBIugYP8aqCryl3mRTzhIm
         nyzLSOhSkS/Bye+QA00IM2MsjhnUA408QIyungJaHYxvuyXbuTeC6K0dJcKnUnQNsCLo
         BJGA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1794563698; x=1795168498;
        h=mime-version:user-agent:content-transfer-encoding:content-type
         :references:in-reply-to:date:cc:to:from:subject:message-id:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=G8DmFU4pJwAPCJlqHBF8SKasEEThxtJNlC1sg/CSkLw=;
        b=xFpHnQY3jmWBjWre1qyKnTcyGXzMuyoNEOQEYwty3FWvleMMqKdjJZ1MY5YabZ3GZY
         vWvlBuKifc58AlQ8clkvhTPXe7WLpaqaWa5f2/4BhX9ZX0FNSDBmkJjWoO0FPA+Vg12l
         DwGrWB+FRc1FsPVquDi7WmVrUtQHJmMvIT2zcy05TbpmpjJgiTpc7IUHyy9qf4J5QeLb
         luXwp630gj+xvCgmYBkszkbPtG5sglRcPrn6/fdxUT2dwRXJ5/gA51sLGgjRkVaMZRGD
         pharqluuM15CEd5UzkMYHvw12q06hl/Z6/7g3e3y44cPQ1O5ir+5UZ0seNuSZ+J/P/2u
         dsKA==
X-Forwarded-Encrypted: i=1; AL+hErH1FFK37HvIH1ypeAZLH/8dkR7jc87Hhw3cqZ2uv2Tl8vhMuljmkmAE5pZ8S3dmV/Ye2JBgFok=@vger.kernel.org
X-Gm-Message-State: APuU4Z+atudMHO/v0vG98jftn5a/0myiROYNQpIoPOoQwZMf8ApdQb5X
	7VcxPXBwjEr0kW7Fdpin2LmDuPMV1lC3JU2RZ5wlC7D00AuVoWV60Z/OSBUPYQ/Ac82h
X-Gm-Gg: AYBFou2xJHGpM5PXhXD83cH5BPKl1GTeokHoXbQd6Xm9r0JlHyhomgP1EbGLgLqzz7m
	jUW42WwvmLTMIYYT7ZPv47AU88hIgccO3fn21uL/BtcAubl+gHvqqAYeMAntMlWum/OWTO+MAoG
	LRTclJ4drIz5pnpoz+w0tswezV9ZoUile5ohntvQoSvFxDuEKARLFjYWlQSqNh9xdq62Uy9rkWN
	X2C0AJD5Pvub40fYhLwy4lbTUibIdNYQLHMUlxUJdG+B6lfHp/aSIqy4D1o+9ihcrjerQQpRz9W
	A8qs2K8prycM/ud8Qujgwknan0xS4ZXTMDS2Owd7yUWbD2bwddlN4E6B7xnDyqCs6QNSW0R1O5j
	wgy20uuRRwL52ZDAJyD0ulpdlIXihEBvcSW6zrnbxzzEQXSTNjvSMHncGx4TNQ3SWqAwFBziPRb
	Uu0rUAWleX15UK1gwzpEh8dV3Xe4LFocm08t2eBglpNkfID16R4nkAV4+DOGquFhKA9ehZka9L5
	2xqr9l3LC1EjVNrLm6jbjy3ebaUEdTyoR8I06FzdFyeaiJeS5XV9CABljX551mT8DV0Zh7GodeO
	qKAD/WVV6UvaXu2pu8bgoH2DjCNBWK0mljkW4Xl2x2MsX8XlFs04kOQMQDT7mYw=
X-Received: by 2002:a17:907:ea93:b0:c41:4c20:5a80 with SMTP id a640c23a62f3a-c50963bdb9bmr198299566b.44.1794563698514;
        Fri, 13 Nov 2026 01:54:58 -0800 (PST)
Received: from [10.0.0.233] (tmo-086-54.customers.d1-online.com. [80.187.86.54])
        by smtp.gmail.com with ESMTPSA id a640c23a62f3a-c50957c6c1fsm75151566b.0.2026.11.13.01.54.57
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 13 Nov 2026 01:54:58 -0800 (PST)
Message-ID: <b42c9f4d29a9cbea66929c95cc8f736f12703c72.camel@amutable.com>
Subject: Re: [PATCH RFC 01/41] loop: refuse backing files that aren't open
 for reading
From: Alexander Mikhalitsyn <alex@amutable.com>
To: Christian Brauner <brauner@kernel.org>, linux-fsdevel@vger.kernel.org
Cc: Jann Horn <jannh@google.com>, Chris Mason <mason@kernel.org>, Josef
 Bacik	 <josef@toxicpanda.com>, Christoph Hellwig <hch@lst.de>, 
	linux-block@vger.kernel.org, linux-kernel@vger.kernel.org, 
	linux-nvme@lists.infradead.org, Alexander Viro <viro@zeniv.linux.org.uk>,
 Jan Kara <jack@suse.cz>, linux-scsi@vger.kernel.org,
 target-devel@vger.kernel.org, 	driver-core@lists.linux.dev,
 linux-mm@kvack.org, bpf@vger.kernel.org, 
	linux-security-module@vger.kernel.org, selinux@vger.kernel.org, 
	apparmor@lists.ubuntu.com, linux-nfs@vger.kernel.org,
 netdev@vger.kernel.org, 	fuse-devel@lists.linux.dev,
 linux-efi@vger.kernel.org, 	xen-devel@lists.xenproject.org,
 ocfs2-devel@lists.linux.dev, 	linux-s390@vger.kernel.org,
 linuxppc-dev@lists.ozlabs.org, 	linux-usb@vger.kernel.org, Amir Goldstein
 <amir73il@gmail.com>, 	linux-erofs@lists.ozlabs.org,
 linux-kselftest@vger.kernel.org, 	stable@vger.kernel.org
Date: Fri, 13 Nov 2026 10:54:56 +0100
In-Reply-To: <20261110-work-loop-pseudo-v1-1-4c998976c6c7@kernel.org>
References: <20261110-work-loop-pseudo-v1-0-4c998976c6c7@kernel.org>
	 <20261110-work-loop-pseudo-v1-1-4c998976c6c7@kernel.org>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
User-Agent: Evolution 3.56.2-0+deb13u1 
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Post: <mailto:stable@vger.kernel.org>
List-Help: <mailto:stable+help@vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
List-Owner: <mailto:stable+owner@vger.kernel.org>
Precedence: list
MIME-Version: 1.0

On Tue, 2026-11-10 at 10:14 +0100, Christian Brauner wrote:
> loop_configure() takes any file as long as it implements -
> >read_iter().
> Loop itself never checked whether the file was actually opened for
> reading. Buffered I/O went through vfs_iter_read() which refuses
> files
> without FMODE_READ. Direct I/O has called ->read_iter() of the
> backing
> file directly ever since loop grew support for it.
>=20
> Since commit f2fed441c69b ("loop: stop using vfs_iter_{read,write}
> for
> buffered I/O") buffered I/O calls ->read_iter() directly as well.
> That
> commit was about O_DIRECT handling and the FMODE_READ check went away
> as a side effect.
>=20
> So whoever can set up a loop device can read a file it was only
> allowed
> to open for writing. Open the file O_WRONLY, configure a loop device
> with it and read the contents through the loop device.
>=20
> Refuse backing files that aren't open for reading. Loop always reads
> from its backing file so a write-only backing file never made sense
> in
> the first place.
>=20
> Fixes: bc07c10a3603 ("block: loop: support DIO & AIO")
> Fixes: f2fed441c69b ("loop: stop using vfs_iter_{read,write} for
> buffered I/O")
> Cc: stable@vger.kernel.org
> Signed-off-by: Christian Brauner (Amutable) <brauner@kernel.org>

Reviewed-by: Alexander Mikhalitsyn <alex@amutable.com>

> ---
> =C2=A0drivers/block/loop.c | 3 +++
> =C2=A01 file changed, 3 insertions(+)
>=20
> diff --git a/drivers/block/loop.c b/drivers/block/loop.c
> index a3325ceab484..c96e35c3ef42 100644
> --- a/drivers/block/loop.c
> +++ b/drivers/block/loop.c
> @@ -528,6 +528,9 @@ static void loop_assign_backing_file(struct
> loop_device *lo, struct file *file)
> =C2=A0
> =C2=A0static int loop_check_backing_file(struct file *file)
> =C2=A0{
> +	if (!(file->f_mode & FMODE_READ))
> +		return -EBADF;
> +
> =C2=A0	if (!file->f_op->read_iter)
> =C2=A0		return -EINVAL;
> =C2=A0
