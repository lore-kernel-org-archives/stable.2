Received: from mail-ed1-f44.google.com (mail-ed1-f44.google.com [209.85.208.44])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 382CD34EF0F
	for <stable@vger.kernel.org>; Tue, 14 Jul 2026 13:14:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.208.44
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1784034844; cv=none; b=kmhpxHXy0w/fauUeQdVfUfpjn3CORK366/DF02fC3rhEAuYXg+z23/dW4gfAYn+o2z1YqmaCoFXlw/b4PrDvdLTwhtfh0454npHxnUKCL0NGhSM/WogG+2YC94puF28+suN5KuuhNC4EjTcdGwvvuuAx8LXjaxKNNdaLogyYFNo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1784034844; c=relaxed/simple;
	bh=MtotPDhuzhIIvZBQmRSCVo0ZcnrH0YTdHYKCpqdh+5Q=;
	h=Date:From:To:Cc:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=u3BLH5x2yiqwzpMjzL6yAXgGx/Jp3DzGLOYl66+dg92xx7HQDDYmoOZSxs2IaMUEEX/vdOpbQYkWEEFMHxrrxeG1/hEhOhTMzu5ez4TSmREFvXBkWiHXTiYQnvDi01ZvQu4G3bsM+b/23/QdjM0/Ncmt9ZfgPnu3Ri3Mr/JSMYE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=TURxFoUS; arc=none smtp.client-ip=209.85.208.44
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="TURxFoUS"
Received: by mail-ed1-f44.google.com with SMTP id 4fb4d7f45d1cf-69c7697d523so1286253a12.2
        for <stable@vger.kernel.org>; Tue, 14 Jul 2026 06:14:03 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1784034841; x=1784639641; darn=vger.kernel.org;
        h=content-transfer-encoding:content-type:mime-version:references
         :in-reply-to:message-id:subject:cc:to:from:date:from:to:cc:subject
         :date:message-id:reply-to:content-type;
        bh=ny5+3yiTMDoQJssQpPJVjH5n2qiBSxJZzbYo0RMA4qo=;
        b=TURxFoUSnQcZdZTMzki54XbbsritsNyE5wfUOwKJtz+XqjImvEPn0hzlYIn6Xb7FFH
         RDvzEA5MN8AXdrNoL8mc1aq2b+10fWDyOm9fHY7g1FREOMStaZC9WczDhx4+/7X5QRUY
         fHXD+yH7Y6flG1P9De8Xqm38X6etWOmf9/VipAJ5exzG9nFCbLC8BiIX18Twlq8osr0P
         +rPNI8cme+sVw+c8ApdPYEv3zdjgvf50+YY8+oqhfGmZnNB38lze+/y/t5dE+cdTFXEo
         DY4OQtpbNgh2BoEpPMyuhevxih+MxMIZk0DKEozf8tW++WEqYhzwNEVGTLxjrjB9IEyC
         siwQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1784034841; x=1784639641;
        h=content-transfer-encoding:content-type:mime-version:references
         :in-reply-to:message-id:subject:cc:to:from:date:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=ny5+3yiTMDoQJssQpPJVjH5n2qiBSxJZzbYo0RMA4qo=;
        b=Ibe0c4omWrO9sEst9kbJbERg7dxscncURGj6GAVgZmbeov5Bd2HhZem8OC6f94Tx5O
         homLCB5U5cQZwKEGWJU3M5V0mbiM/yG0injqqzZjEoe8txK3RvVn+lW1bqhqNDYKpTEo
         nGtU1siuyoVdLf39TYV+zyxBt4tEpGsytW4KtCNeCNQKSVdpFtBmY04PhKRIEPerYH9t
         BPJ34gOI8sWapDUzFPylunguXmFhlm+vyk+pxfwBmhedrGF178NOGJ15VxNQUrjQJTTU
         Xwq59z30LGBcPBurA1MWDNr2BtHidVe+QRDuOYAFOhQU+h71f3MnZwbVk9SIVvMgrZ2y
         Qevw==
X-Forwarded-Encrypted: i=1; AHgh+RpwWw60qXv3rFvnwsY2+4x5aq8UDn3FskDZQPmbTCCjjpiQK7ZHHRVHWJG4trOvglj5d2N0W7M=@vger.kernel.org
X-Gm-Message-State: AOJu0YwFiI96XXi4CyWeDxFCZukCioOxqIPpUruDBvQpx6pVsYV3AO2f
	DrSo6lvN/7CB9iTX713U4PCaU1Yoyx2s/nJRcAKWPzWiCPbA5Nwotx63
X-Gm-Gg: AfdE7ck71nSxQgM31jh9uXdKu6hRTMlMk1HiibU4xNRgVqt26tG1P3G5d6ZE6LmtKj5
	4i5yVeaHtUHDsPOZHP8ep9ZbUmh4dPVh+CQbNADM8p3mnIgv7mIoV57YxKB9eb95qMBSA6jf781
	4GqdIwjynY2bV+sUx2SKf3Dd5b1a95qrWJUzjbSXlw2+QWf5W7m6q/70E8sJPIJAXeNIyqWiJdr
	QoyznPjnp5aOvW/W3udK9ATeFrGnMA1zuXOIsB45k40dRPnuAl3woq41s3cviCQpEt1do8M75es
	EupFT/VzynxJos1ct2nY98S09+MLs9SSgWkjnITaGoOLHK8OC84KzW+ObMygkRxLZcRL7TBvd84
	IYSDiaX84pGT1EoFKrgGKv+TTpILG97JA1s7l7HHi28ybI9izf5XW1n8lBEHLMehr65eAQfeMxG
	9bsyh1b5DR5o4zzt8zOvQ4dHgOf7aYcQ2YanyOA+oq4qQ/x89ciw==
X-Received: by 2002:a05:6402:1e8c:b0:683:e394:cc0c with SMTP id 4fb4d7f45d1cf-69c5ef84424mr6428415a12.4.1784034841275;
        Tue, 14 Jul 2026 06:14:01 -0700 (PDT)
Received: from pumpkin (82-69-66-36.dsl.in-addr.zen.co.uk. [82.69.66.36])
        by smtp.gmail.com with ESMTPSA id 4fb4d7f45d1cf-69cd2952836sm1533316a12.27.2026.07.14.06.14.00
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 14 Jul 2026 06:14:00 -0700 (PDT)
Date: Tue, 14 Jul 2026 14:13:59 +0100
From: David Laight <david.laight.linux@gmail.com>
To: Baineng Shou <shoubaineng@gmail.com>
Cc: Sumit Semwal <sumit.semwal@linaro.org>, Christian =?UTF-8?B?S8O2bmln?=
 <christian.koenig@amd.com>, "T . J . Mercier" <tjmercier@google.com>,
 Benjamin Gaignard <benjamin.gaignard@collabora.com>, Brian Starkey
 <Brian.Starkey@arm.com>, John Stultz <jstultz@google.com>, Sandeep Patil
 <sspatil@android.com>, "Andrew F . Davis" <afd@ti.com>, Srinivas Kandagatla
 <srini@kernel.org>, stable@vger.kernel.org,
 dri-devel@lists.freedesktop.org, linux-media@vger.kernel.org,
 linaro-mm-sig@lists.linaro.org, linux-kernel@vger.kernel.org,
 linux-arm-msm@vger.kernel.org
Subject: Re: [PATCH v3 1/2] dma-buf: dma-heap: don't publish fd before
 copy_to_user() succeeds
Message-ID: <20260714141359.7758575d@pumpkin>
In-Reply-To: <20260714114654.3885457-2-shoubaineng@gmail.com>
References: <CABdmKX21NHc2=9Sk2F-BFpu6is0vTg-QXLE+wiFNEPdsWWjvog@mail.gmail.com>
	<20260714114654.3885457-1-shoubaineng@gmail.com>
	<20260714114654.3885457-2-shoubaineng@gmail.com>
X-Mailer: Claws Mail 4.1.1 (GTK 3.24.38; arm-unknown-linux-gnueabihf)
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: quoted-printable

On Tue, 14 Jul 2026 19:46:53 +0800
Baineng Shou <shoubaineng@gmail.com> wrote:

> DMA_HEAP_IOCTL_ALLOC allocates a dma-buf and installs an fd into the
> caller's fd table via dma_buf_fd() -> fd_install() before
> dma_heap_ioctl() copies the result back to userspace.  If the trailing
> copy_to_user() fails, userspace never learns the fd number, but the
> fd (and the underlying dma-buf reference) are already visible to
> other threads in the same process and are leaked for the lifetime of
> the process.
>=20
> The obvious "close it on the failure path" fix is unsafe: once
> fd_install() has run, another thread can already dup() the fd, send
> it via SCM_RIGHTS, or close() it and let its number be reused, so a
> subsequent close_fd() from the ioctl path can operate on an unrelated
> file.  This was pointed out by Christian K=C3=B6nig on v1 [1].
...

My 2c:

The other option is just to leave it as a 'problem for user space'.
No reasonable program is going to handle the EFAULT return by doing
anything other than exiting.
Even getting an EFAULT is really an indication that the application
is already in a real mess - most likely with a badly corrupted heap.

Anything else leaves error recovery code in the kernel that is pretty
much never executed and open to a variety of bugs.
While the recovery here is probably ok, there are some sockopt calls
where it is all more complicated.

	David
