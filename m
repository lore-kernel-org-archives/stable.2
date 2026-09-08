Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1907334216C
	for <stable@vger.kernel.org>; Tue,  8 Sep 2026 09:42:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1788860561; cv=none; b=SET0H+l24Bog4wBX2DEqb2yb5K0mbaSpRNec6WWF0sb6yGiIEjBGqRP0FUcdGxO7A6BA1iBsJ2IsNenduInX3NxRJ1IZXk3DilKGIo5cIUAzH/isDpqN0CmdHWsOq71qVtFdQFyueX3qoh6oangYZj+hT1ZyAA0b8JFWqvuXMBg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1788860561; c=relaxed/simple;
	bh=ECKmHDFTCaWZUO3ZEsJrVyI/tYLtMTumWVWPVhpHgk8=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=p8ueVZlDjUxvsrRhNGfmCcsGu7enPfHVP62dlxpvasPlBwGo4DDT4kc7ZGiWakITnyygpsaneM0P/IaoNL3MfYYypZUjlPFK8XbzV1FnVcPToiCQjAP+Fg1MqXtMbPTUDCTPL1GGmHJLERbsZwRqMZ5GVdBmCSKgKs5UEOB1e8s=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=lo5DnKym; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="lo5DnKym"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id C32951F00A3D
	for <stable@vger.kernel.org>; Tue,  8 Sep 2026 09:42:39 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1788860559;
	bh=gGeu9eNrhSalqK3WcJ+GEtqcT6zYbbo4PWNmHxnBjsM=;
	h=References:In-Reply-To:From:Date:Subject:To:Cc;
	b=lo5DnKymRknyNdkFvFsCi9sKz7+JGIfci5aTtfKrggQRuxDUIAR/Y7NxaPuFos8yV
	 QZ9c8v7U6QYubDABShaFDCrgNdUqyzBuhnBHOOiutc6BkoWGKhvHty2yTHpSuEDaPw
	 0dZAMWZER0uNo0eN4VlKP3jH3kyfsDw91pllNvQzCqxefC+rKUosLbGfPDZmg5Oevo
	 Fek5NDRkyLZ8madmMMsuzZ9IcMIYNfYdcL8Twi6ezwYs5MgXx08/cjt3hU9i8sxUnx
	 ECaIqaT8RZzd2ae9yBDrlhA29esQcTlRXu6HsFXxA74g9KmxtjbVb3GiP2xjFhVDno
	 CjlWgbOENb8Xg==
Received: by mail-ej1-f54.google.com with SMTP id a640c23a62f3a-c262204cc80so441065866b.3
        for <stable@vger.kernel.org>; Tue, 08 Sep 2026 02:42:39 -0700 (PDT)
X-Forwarded-Encrypted: i=1; AKwUvBzTm8Jc5j1EV5EiHvNjnxpJPXMBSGB/QcLBSVMm7fw1L9HBXYp5k8MyLJ1w2CzJTMq9Pm3im7I=@vger.kernel.org
X-Gm-Message-State: AFuF++klypoUQdPsflFnvnLk4/LmG3LIR9HqQ/N00BF/Yrvp4ytAzA8z
	p8xSr/wKBewNgayy+6gLq/b9cBL3Sl1wT3ljisYKdoN+XtGI7cJhHX27PsC/8zTYRPIqv5XrFB2
	FjH0kKZpW1DbTW9lDep6t6OSRJhwTuGk=
X-Received: by 2002:a17:906:6a06:b0:c27:420b:7c91 with SMTP id
 a640c23a62f3a-c27420ba148mr546895366b.45.1788860558416; Tue, 08 Sep 2026
 02:42:38 -0700 (PDT)
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20260907035726.37123-1-zenghongling@kylinos.cn>
In-Reply-To: <20260907035726.37123-1-zenghongling@kylinos.cn>
From: Namjae Jeon <linkinjeon@kernel.org>
Date: Tue, 8 Sep 2026 18:42:25 +0900
X-Gmail-Original-Message-ID: <CAKYAXd-GOecc9SF-HUemarO+tG6COWONoqL+_r5CJJLg+7jOng@mail.gmail.com>
X-Gm-Features: AcwNN1XiYkiKCzRplIbTTRph9qTTCQz9v-eFlxSGSTq6f7-uceSPdYx5Tv4sWqM
Message-ID: <CAKYAXd-GOecc9SF-HUemarO+tG6COWONoqL+_r5CJJLg+7jOng@mail.gmail.com>
Subject: Re: [PATCH] ntfs: use fatal_signal_pending() for fallocate
 interruption checks
To: Hongling Zeng <zenghongling@kylinos.cn>
Cc: hyc.lee@gmail.com, ntfs@lists.linux.dev, linux-kernel@vger.kernel.org, 
	zhongling0719@126.com, stable@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Mon, Sep 7, 2026 at 12:57=E2=80=AFPM Hongling Zeng <zenghongling@kylinos=
.cn> wrote:
>
> The fallocate implementation uses signal checks to let a long allocation
> loop abort early.  However, signal_pending() also returns true for
> TIF_NOTIFY_SIGNAL, which io_uring uses to deliver task_work completions
> to the submitting task.
>
> generic/616 is an io_uring fsx soak test that issues fsx-style
> read/write requests through io_uring and calls fallocate() directly in
> between.  A pending io_uring task_work notification can therefore make
> signal_pending() true inside ntfs_attr_fallocate() even though no real
> signal was delivered.
>
> That caused the previous signal-interruption patch to return -EINTR for
> an io_uring notification, which fsx treats as a fatal failure.  Switch
> both checks to fatal_signal_pending() so only fatal signals interrupt
> the allocation loop.  A real fatal signal still returns -EINTR, and any
> other error still takes precedence.
>
> Fixes: 4dc8f4ee2d46 ("ntfs: handle signal interruption in fallocate")
> Cc: stable@vger.kernel.org
> Signed-off-by: Hongling Zeng <zenghongling@kylinos.cn>
Applied it to #ntfs-next.
Thanks!
