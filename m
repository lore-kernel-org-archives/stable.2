Received: from mail-vs1-f53.google.com (mail-vs1-f53.google.com [209.85.217.53])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 68A9E19C556
	for <stable@vger.kernel.org>; Fri, 19 Jun 2026 14:20:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.217.53
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1781878842; cv=none; b=NUJXXvFfirhm55jcHZLfiw1ayqtWWM7qRcB73yY2k0mhaDGtzN4UjxvY+QXu22VPnJUaviyzh8lybsyri65NDZK0VD3Yu7F/1y5rD5vVQJgQLYsfOQhfGY5ikjKpl1g4ErQiJ93K9aIMHxnixabEFRBQhTts34CK3vub0dOE3FM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1781878842; c=relaxed/simple;
	bh=gJs7xtR7xm1gIzB99bRuyJh0Tdg/gw9Rplvwc1PxAUk=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=azRvh8V1LGiv4M46YDSBDwNOIY8TOvmvCzOvwekN7BCuDhHBQ3JWuWX56DWiRHu914U3YTAbwgN21yWevOOpeF3cLWzncxpZ+JbwOVs8/8nf9EqgrD49ISrmQpuPGwqSntWV/XRFMhUDRVbNrt9fOCteg+xtqF10fVSUmNNmR0E=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=chromium.org; spf=pass smtp.mailfrom=chromium.org; dkim=pass (1024-bit key) header.d=chromium.org header.i=@chromium.org header.b=aRWvAqtC; arc=none smtp.client-ip=209.85.217.53
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=chromium.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=chromium.org
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=chromium.org header.i=@chromium.org header.b="aRWvAqtC"
Received: by mail-vs1-f53.google.com with SMTP id ada2fe7eead31-6c28cd29891so1157869137.1
        for <stable@vger.kernel.org>; Fri, 19 Jun 2026 07:20:41 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google; t=1781878840; x=1782483640; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=fbcGH9ITMmOI3YSas2gsikCqBTKnvtgdWwDyBNbyusg=;
        b=aRWvAqtCr2x05huhxmKwNaJBrys3UqNzAciCQOoKz/if8WEjubM+KR5qMqyS1XRPBk
         m0CFSS9LIutiL0+cI4QvU+RiwzUQAMkGOxwS+4bLcyjT7tU3U6x/srJqTEEHZxV/SH9m
         9fZMqCLVY76jNTNFJQIoA4wIt7k8RechF7ZhQ=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1781878840; x=1782483640;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=fbcGH9ITMmOI3YSas2gsikCqBTKnvtgdWwDyBNbyusg=;
        b=JvwiIejKvQKALRyMm4XVMxqU/BLKZGX/3ZfNOzffAQfV7EnFmeBvfsDylZ6qVKSX1f
         SnhcVpQDHrF1+VE81TrjzvyUIlKe+AHvpXD74fRuGieBsUG3+brDNlkNlRqhRZTl9OTo
         VgH4p5gwqn5jFp5GkdQcLfXlnsmoc9D6ay2WMObAxWSwFXLtjMcdqtFzEvGHPY7kgslG
         gm0eeOsjVnkanMMxsceHTIfi2Crcgt3gmyZzPxRY+f0fXAVFVAx/h+9lWm6VT5NEtX9C
         x0UPEM4Ez9h68NXF0djRhp6rc+y8YirH+r9j0skMjYa+9MF03qsZZnK/Zo66dUR4DlYo
         2wkA==
X-Forwarded-Encrypted: i=1; AFNElJ8e4vyDrA07g1TJqtwrL9Hz41CSO0iZsCW4+pYkETxVb4gJZR0osIwqESaylKKmj7buN7yr1Ao=@vger.kernel.org
X-Gm-Message-State: AOJu0Yzfb/sXKF71LBbbyiDR/Ce7PZ31rqlu9fBMFhyxiKXLeCRxOFIQ
	8oZ5Q12xD5QTxx7uL19hQ+XurWAm0JyJQEGk5I7HimBKO963SEFDju7QCFXpP1Mpg2M+BwitfEM
	FP3kPIg==
X-Gm-Gg: AfdE7cn2jJaX1oTEc5iQ3A0BWu24DagGdwRk7y1NIESmkZMEyft658xzfIrfBlF8Em5
	oukiFLBixByfSfVzgf/ph3HNmPr99pcJvgtd/JbyPVacfMKiQ5DfWwduKrlV8rG3EVwSdXUwvNY
	cam5GSKPBAs9XMltKs0lhqHD7X6PZum0oOBfXHr1W5m+j+vbR8oH+fsDo1X0zK8FKiuiZSJkLbr
	ZjXH0FMwE2aw3qXt/yXksOA8cX1nAVv6lNMoDwNvWesyGSUP1g9rDAzKLf/lMjXJQWNds15L35F
	DywdgzXE7isnj9zLZDAzOnDFASvU4Mqvon7hu4899MNPTp5ZJHMeHoATpXbIwsN6ijrVqEnGluj
	nowomF+hphF/yxAGjJPaYiT9WBYKdL+8dB5udLDHotCiLFUcC9bFbv9wDikkk3oRMGVVnYna3mb
	guo1q6Z1jVDbmc7LTFU5xwTxv0sZ8Bzsi08wG4gzjyR9C0sGV06eE=
X-Received: by 2002:a05:6102:5121:b0:631:d586:893e with SMTP id ada2fe7eead31-72a1d205a0fmr2217420137.5.1781878840293;
        Fri, 19 Jun 2026 07:20:40 -0700 (PDT)
Received: from mail-qt1-f182.google.com (mail-qt1-f182.google.com. [209.85.160.182])
        by smtp.gmail.com with ESMTPSA id af79cd13be357-920a0e4ad99sm253798885a.5.2026.06.19.07.20.38
        for <stable@vger.kernel.org>
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Fri, 19 Jun 2026 07:20:39 -0700 (PDT)
Received: by mail-qt1-f182.google.com with SMTP id d75a77b69052e-519ed52bcc6so186221cf.0
        for <stable@vger.kernel.org>; Fri, 19 Jun 2026 07:20:38 -0700 (PDT)
X-Forwarded-Encrypted: i=1; AFNElJ/YzjB/rtxhE7mXjYjHOCXq9J9pr98HKVGlA9ijf1ZibLDurKrbhopu1uy0hfSNn1xCPKzZ8KU=@vger.kernel.org
X-Received: by 2002:ac8:7d8e:0:b0:516:4f62:85ec with SMTP id
 d75a77b69052e-519e8d1f14dmr7406931cf.17.1781878838041; Fri, 19 Jun 2026
 07:20:38 -0700 (PDT)
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20260609121329.1262170-1-senozhatsky@chromium.org>
 <CAGp9LzpBUReZtrTEKgUr-+yvB+3tcs5hw7ziC4WaMRFNa2AYpg@mail.gmail.com> <87tsqyirsn.wl-tiwai@suse.de>
In-Reply-To: <87tsqyirsn.wl-tiwai@suse.de>
From: Tomasz Figa <tfiga@chromium.org>
Date: Fri, 19 Jun 2026 23:20:20 +0900
X-Gmail-Original-Message-ID: <CAAFQd5BtO7vL_A2i84CoF1Dk7Bmp_DZQJgoNAB-HyGA89=XDUQ@mail.gmail.com>
X-Gm-Features: AVVi8Cfvj7Tldb-rRHpdw6zA1vefldpMM6jJzOD0R18t-VmMpCoygqlJxAYuFRA
Message-ID: <CAAFQd5BtO7vL_A2i84CoF1Dk7Bmp_DZQJgoNAB-HyGA89=XDUQ@mail.gmail.com>
Subject: Re: [PATCH] Bluetooth: btmtksdio: fix infinite loop in btmtksdio_txrx_work()
To: Takashi Iwai <tiwai@suse.de>
Cc: Sean Wang <sean.wang@kernel.org>, Sergey Senozhatsky <senozhatsky@chromium.org>, 
	Marcel Holtmann <marcel@holtmann.org>, Luiz Augusto von Dentz <luiz.dentz@gmail.com>, 
	Mark-yw Chen <mark-yw.chen@mediatek.com>, Sean Wang <sean.wang@mediatek.com>, 
	linux-bluetooth@vger.kernel.org, linux-kernel@vger.kernel.org, 
	linux-arm-kernel@lists.infradead.org, linux-mediatek@lists.infradead.org, 
	stable@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

[Resending without HTML... Damn Gmail]

On Fri, Jun 19, 2026 at 10:27=E2=80=AFPM Takashi Iwai <tiwai@suse.de> wrote=
:
>
> On Wed, 10 Jun 2026 08:52:31 +0200,
> Sean Wang wrote:
> >
> > Hi,
> >
> > On Tue, Jun 9, 2026 at 7:19=E2=80=AFAM Sergey Senozhatsky
> > <senozhatsky@chromium.org> wrote:
> > >
> > > Every once in a while we see a hung btmtksdio_flush() task:
> > >
> > >  INFO: task kworker/u17:0:189 blocked for more than 122 seconds.
> > >  __cancel_work_timer+0x3f4/0x460
> > >  cancel_work_sync+0x1c/0x2c
> > >  btmtksdio_flush+0x2c/0x40
> > >  hci_dev_open_sync+0x10c4/0x2190
> > >  [..]
> > >
> > > It all boils down to incorrect time_is_before_jiffies() usage in
> > > btmtksdio_txrx_work().  The btmtksdio_txrx_work() loop is expected
> > > to be terminated if running for longer than 5*HZ.  However the
> > > timeout check is twisted:  time_is_before_jiffies(old_jiffies + 5*HZ)
> > > evaluates to true when old_jiffies + 5*HZ is in the past i.e. when a
> > > timeout has occurred.  Using OR with time_is_before_jiffies(txrx_time=
out)
> > > means that:
> > > - before the 5-second timeout: the condition is `int_status || false`=
,
> > >   so it loops as long as there are pending interrupts.
> > > - after the 5-second timeout: the condition becomes `int_status || tr=
ue`,
> > >   which is always true.
> > >
> > > When the loop becomes infinite btmtksdio_txrx_work() loop never
> > > terminates and never releases the SDIO host.
> > >
> > > Fix loop termination condition to actually enforce a 5*HZ timeout.
> > >
> > > Fixes: 26270bc189ea4 ("Bluetooth: btmtksdio: move interrupt service t=
o work")
> > > Cc: stable@vger.kernel.org
> > > Signed-off-by: Sergey Senozhatsky <senozhatsky@chromium.org>
> > > ---
> > >  drivers/bluetooth/btmtksdio.c | 2 +-
> > >  1 file changed, 1 insertion(+), 1 deletion(-)
> > >
> > > diff --git a/drivers/bluetooth/btmtksdio.c b/drivers/bluetooth/btmtks=
dio.c
> > > index 5b0fab7b89b5..c6f80c419e90 100644
> > > --- a/drivers/bluetooth/btmtksdio.c
> > > +++ b/drivers/bluetooth/btmtksdio.c
> > > @@ -620,7 +620,7 @@ static void btmtksdio_txrx_work(struct work_struc=
t *work)
> > >                         if (btmtksdio_rx_packet(bdev, rx_size) < 0)
> > >                                 bdev->hdev->stat.err_rx++;
> > >                 }
> > > -       } while (int_status || time_is_before_jiffies(txrx_timeout));
> > > +       } while (int_status && time_is_after_jiffies(txrx_timeout));
> >
> > yes, loop continues only while there is interrupt work and the timeout
> > deadline is still in the future
>
> I stumbled on this while backporting to distro kernels, and I wonder
> whether this change is correct.
>
> IIUC, this essentially makes the loop exiting right after the first
> cycle; the patch changed from time_is_before_jiffies() to *_after_*(),
> not only the logical OR to AND, and *_after_*() returns false, so the
> whole condition becomes false, too.

The intention is for the loop to keep running as long as there is
still an interrupt left to handle (int_status !=3D 0) and the timeout
has not elapsed (jiffies < txrx_timeout).

Note that time_is_after_jiffies(x) returns true if x > jiffies (or jiffies =
< x):

/**
 * time_is_after_jiffies - return true if a is after jiffies
 * @a: time (unsigned long) to compare to jiffies
 *
 * Return: %true is time a is after jiffies, otherwise %false.
 */
#define time_is_after_jiffies(a) time_before(jiffies, a)

Or am I missing something?

Best,
Tomasz
