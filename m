Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3CA85477E33;
	Tue, 28 Jul 2026 22:05:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1785276319; cv=none; b=Zr1x5UkMHVRrSPzI/2+43w4xlZ/PMOvQVNj9dhtKpL3zU6XiNoW4/PyoHHVORfJFQSfbIa4K8HHGM2vR993SzYcm+uIlZT61nBBeu90rhP7cenRd0M/++TDPetCro4qrdjqPNY8VeT0srEQGOrp8ma5DJG3DYTKewsS1xK2aBVE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1785276319; c=relaxed/simple;
	bh=eqZXMAiBfkIW//bOMn3yx+M8o8+96g2JXgyR7ofDjOY=;
	h=From:To:Cc:Subject:In-Reply-To:References:Date:Message-ID:
	 MIME-Version:Content-Type; b=mSGWsIkjjbmqlmJqRTpSoZB94ODwSvUBdwlBrpGDQPM0hfOCQnR3wu8QT+0f6uSRKxhzLQ/ImpoRJwhtYYEuRFf3XI6NRS4E88ID9EjMOZ7NrZ9bUlSBoibd5cGOb1kOclSlGz2sKccBjx/sHS17JZtQcEMadNdm8Nhr+Uhr5hc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=gEbFeNgd; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="gEbFeNgd"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 906D71F000E9;
	Tue, 28 Jul 2026 22:05:07 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1785276308;
	bh=y+jdwUBHemmnuLYABHolwLGwFjdaofb+r9iLfZhmU3c=;
	h=From:To:Cc:Subject:In-Reply-To:References:Date;
	b=gEbFeNgdIEphEVbh3V7pMP4bXqJJvK8L5f7wGzmaZeAp1gVsceWIGsLaLj1+o+y5n
	 H0x7RHGMvpsnD/rejxU2kKy5SMS7jrXWGbm4E7voaumI7liDuGBuIuHjPE5ECx+2Cp
	 C3S1oWa1KmHGkbPLQVsvHnTiAhoAzSdxRIf//ZNSY46N4BUvvWIh4fIAMaVxIp2Vx3
	 eXyM5ldS2QmFhT3NwSQwGqSbG7998S+KNQ4lAlwPFGwhMSR2RA/sqGahrWdhOOplAq
	 zFRmlGJk8dmUqeLFQyqZIwEgx6EkArv+awjzaB6dwPr6OYduNOoL9FvLnFqKzq4lhN
	 dP85+l9rJV7ig==
From: Thomas Gleixner <tglx@kernel.org>
To: Keno Fischer <keno@juliahub.com>, Ingo Molnar <mingo@redhat.com>, Peter
 Zijlstra <peterz@infradead.org>
Cc: Darren Hart <dvhart@infradead.org>, Davidlohr Bueso <dave@stgolabs.net>,
 =?utf-8?Q?Andr=C3=A9?= Almeida <andrealmeid@igalia.com>, Yang Tao
 <yang.tao172@zte.com.cn>,
 Yi Wang <wang.yi59@zte.com.cn>, Linux Kernel Mailing List
 <linux-kernel@vger.kernel.org>, stable@vger.kernel.org
Subject: Re: [PATCH] futex: Prevent robust futex exit race more
In-Reply-To: <CABV8kRwvex1VvQ0eGwUQmJL_vA7AP2h64VpHqtXvfOXMvvJQZA@mail.gmail.com>
References: <CABV8kRwvex1VvQ0eGwUQmJL_vA7AP2h64VpHqtXvfOXMvvJQZA@mail.gmail.com>
Date: Wed, 29 Jul 2026 00:05:04 +0200
Message-ID: <87ik5yhisv.ffs@fw13>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain

On Mon, Jul 20 2026 at 23:26, Keno Fischer wrote:

...

patching file kernel/futex/core.c
patch: **** malformed patch at line 69: struct task_struct *curr,

> --- a/kernel/futex/core.c
> +++ b/kernel/futex/core.c
> @@ -982,8 +982,11 @@ static int handle_futex_death(u32 __user *uaddr,
> struct task_struct *curr,

Here and ...

> @@ -992,42 +995,70 @@ static int handle_futex_death(u32 __user *uaddr,
> struct task_struct *curr,

.. here and some other instance.

Seems your mail client mangled the patch. See:

   Documentation/process/email-clients.rst

The only known way to send patches with the gmail web client is as
attachment, but that's a pain for reviewing, replying and applying.

But you can use git send-email with gmail smtp and that will do the
right thing.
 
Thanks,

        tglx
