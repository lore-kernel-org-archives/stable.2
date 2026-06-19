Received: from mail-qk1-f175.google.com (mail-qk1-f175.google.com [209.85.222.175])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4C9CC1EF36E
	for <stable@vger.kernel.org>; Fri, 19 Jun 2026 14:53:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.222.175
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1781880809; cv=none; b=Z8Y88DedoPD2puKHzACBqHsfAebtTUb0WoELd+x+aESUfVeeWMJ+CGT9zRSWZGSn6R8TChqwyIdzqNJv0Qv1+CEx/xxEC9w9n9s7o5mIF9WtHrF8/2Xxcej3aIS3LNscihsPyZcNPxTSqdAkRblQ/yVUg6USnefpRjvM31irvDQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1781880809; c=relaxed/simple;
	bh=IDlu9n3OLeJ5duMNxqd8I4MTVuzqBDGkDqPg20cC17o=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=pmYz28kx8tGcKNo7TUjdPkV0SeaxJxv0HUIuIlsqdfcSyI0b+mkgRVeeSj3atZ3AEJT9wcUCZ3O25+ppVcfjkxThgWec7Az5QTIMlkXaRdjfqGOkd6NOwG9E+vGzStH5+W55wzNzGV0N8sf6neoQrRmaAYiHq5omwTvdLkRI5Gw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=chromium.org; spf=pass smtp.mailfrom=chromium.org; dkim=pass (1024-bit key) header.d=chromium.org header.i=@chromium.org header.b=hUcq2Y3r; arc=none smtp.client-ip=209.85.222.175
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=chromium.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=chromium.org
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=chromium.org header.i=@chromium.org header.b="hUcq2Y3r"
Received: by mail-qk1-f175.google.com with SMTP id af79cd13be357-9159951f05aso243932885a.0
        for <stable@vger.kernel.org>; Fri, 19 Jun 2026 07:53:28 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google; t=1781880807; x=1782485607; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=XIGBVuVVm03R19snYPTC5iI7SwI4WcfAC4ZQNabDd18=;
        b=hUcq2Y3rPMsOGuflCDGlqJpyw54Fg2iC0h/0BpKj92M6/gyyQYqQ0hekTNXv7Y4UyE
         yOq0ojIhtl1m63J7PtLcijsIUogA6+uyagVvzyofDlesmdCo1qlUtzk9ZTlFRUmVDfaF
         iKMMym5wS7BSXXkAzLcpwvApaXvZRRuMN/9UQ=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1781880807; x=1782485607;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=XIGBVuVVm03R19snYPTC5iI7SwI4WcfAC4ZQNabDd18=;
        b=E4l8skmPY7FdH+j2TpORbKs9zUjcfIDRL2CHWWYNTNScyl7UKyuVwyRvC8E+JCFSJm
         uZYCO2S4WDir69dVFkz8dmTB6+M0vI1ol/s+aiXP1jYv1P4D+4inw/rrD7gmWui/IMp4
         7Caps+nQfFoUnFlMS7gneO7ew0/eQ+9WyWOoEoE86UIGi9rSKcYy/yxN/+rIMhA5r0S6
         9QWgFzUNONwoj2/86tJgaJdQ3XzghxwfZboAC1JbDuHlp4eQG5hAXXNA3PDf1TJv9JUJ
         UvmpJy2giMgv49h6S9LlyF9DSSkTm9wNhwwYJRSIcKhdUEXHGyb97yQ7yrtEqsm2H2FY
         4rrg==
X-Forwarded-Encrypted: i=1; AFNElJ+OndinIFO5Rqb2dZB8bIbSSUlZuBnTmNQWiFwfK3ssunNmXQVYa7VoqMcynCCjdBaAmL0mR+I=@vger.kernel.org
X-Gm-Message-State: AOJu0Yylj7408Rm8pxWLlY1WW+5io8B5cllQpbpSZ1QA5rRs5c6xiVzi
	wqfRM3d2pGCrAFbiAdldNZTtcBRkNahznkEXZjg42hjaoqH31Mpx5F3x5Lk3IzbGXNGnNDBDTTf
	vYQ/x6A==
X-Gm-Gg: AfdE7cnJaqfzGlErwnRdH+0/Ny5thVykLlAcwcd/hCgHiva/tQN0KJURTfhKvu7Q9AJ
	Oy4mMT46gxwokeqHZ5E6hWx/fZuHsJC9YtdNTD9gqDHgRcUcFzLWT1bNxCPkWxmnB8XzQ0W6vu8
	IKykjeyfXsUsJC5vddswVpxpR/YFfTqKqjn5Npz42j4KWr/OuJXkI62BqWeOOcLO5DGcw+2i4gc
	3tiOeyGhv80DRDsSrsufvmedWJ4ckPcGiA6x/lzSE0surqtvFsAJuBoy7n5OCVOM6E9oe6y7LNs
	8GGaBFuu3R2J1d00gsf1paPmXzECy6k1wYX3yx8hMduIQJVS9/OL6llwggxXHiKGJHZPP6rHm0g
	IjsWTAjZCqeibGVBThy2WvuvEVv4Hr56xoqyVgaHXWJZ1lhTyknpHTf80XHn7vzdKIdTH2nfgjN
	9gp5ZGVLmCGLQTHu1nfCvL7k5HGagarqoeiicH8UIr2mtBuFqkTl0=
X-Received: by 2002:a05:620a:1a23:b0:915:f360:e97b with SMTP id af79cd13be357-920d1218025mr412192785a.6.1781880807022;
        Fri, 19 Jun 2026 07:53:27 -0700 (PDT)
Received: from mail-qt1-f174.google.com (mail-qt1-f174.google.com. [209.85.160.174])
        by smtp.gmail.com with ESMTPSA id af79cd13be357-920a4348cfdsm258287885a.31.2026.06.19.07.53.26
        for <stable@vger.kernel.org>
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Fri, 19 Jun 2026 07:53:26 -0700 (PDT)
Received: by mail-qt1-f174.google.com with SMTP id d75a77b69052e-51765531803so303441cf.0
        for <stable@vger.kernel.org>; Fri, 19 Jun 2026 07:53:26 -0700 (PDT)
X-Forwarded-Encrypted: i=1; AFNElJ9CSJZImhhayre7qkVOfIhud6VCI2k+8vVpM5nTGAteZcptutbwN3RO292BTiJY8BCTY0QhaKs=@vger.kernel.org
X-Received: by 2002:ac8:5e0d:0:b0:50f:b69a:f4a8 with SMTP id
 d75a77b69052e-519e890ed52mr6854591cf.7.1781880805032; Fri, 19 Jun 2026
 07:53:25 -0700 (PDT)
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20260609121329.1262170-1-senozhatsky@chromium.org>
 <CAGp9LzpBUReZtrTEKgUr-+yvB+3tcs5hw7ziC4WaMRFNa2AYpg@mail.gmail.com>
 <87tsqyirsn.wl-tiwai@suse.de> <CAAFQd5DyDQo9vBH80YYQBW7Bgf64F1m9q44-jhf1cc75XYpftA@mail.gmail.com>
 <87jyruiomq.wl-tiwai@suse.de>
In-Reply-To: <87jyruiomq.wl-tiwai@suse.de>
From: Tomasz Figa <tfiga@chromium.org>
Date: Fri, 19 Jun 2026 23:53:07 +0900
X-Gmail-Original-Message-ID: <CAAFQd5DDH3LynVPUxS3Wj7xQoUMcOWfxk8cRhXaHyEY-dj5fDA@mail.gmail.com>
X-Gm-Features: AVVi8CcjnxCeHWkLS06U6AojxhWztkixD9Fe53sN6dMUH6hUtZPXwg6RxFcRCjE
Message-ID: <CAAFQd5DDH3LynVPUxS3Wj7xQoUMcOWfxk8cRhXaHyEY-dj5fDA@mail.gmail.com>
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

On Fri, Jun 19, 2026 at 11:36=E2=80=AFPM Takashi Iwai <tiwai@suse.de> wrote=
:
>
> On Fri, 19 Jun 2026 16:17:31 +0200,
> Tomasz Figa wrote:
> >
> >
> > On Fri, Jun 19, 2026 at 10:27=E2=80=AFPM Takashi Iwai <tiwai@suse.de> w=
rote:
> > >
> > > On Wed, 10 Jun 2026 08:52:31 +0200,
> > > Sean Wang wrote:
> > > >
> > > > Hi,
> > > >
> > > > On Tue, Jun 9, 2026 at 7:19=E2=80=AFAM Sergey Senozhatsky
> > > > <senozhatsky@chromium.org> wrote:
> > > > >
> > > > > Every once in a while we see a hung btmtksdio_flush() task:
> > > > >
> > > > >  INFO: task kworker/u17:0:189 blocked for more than 122 seconds.
> > > > >  __cancel_work_timer+0x3f4/0x460
> > > > >  cancel_work_sync+0x1c/0x2c
> > > > >  btmtksdio_flush+0x2c/0x40
> > > > >  hci_dev_open_sync+0x10c4/0x2190
> > > > >  [..]
> > > > >
> > > > > It all boils down to incorrect time_is_before_jiffies() usage in
> > > > > btmtksdio_txrx_work().  The btmtksdio_txrx_work() loop is expecte=
d
> > > > > to be terminated if running for longer than 5*HZ.  However the
> > > > > timeout check is twisted:  time_is_before_jiffies(old_jiffies + 5=
*HZ)
> > > > > evaluates to true when old_jiffies + 5*HZ is in the past i.e. whe=
n a
> > > > > timeout has occurred.  Using OR with time_is_before_jiffies
> > (txrx_timeout)
> > > > > means that:
> > > > > - before the 5-second timeout: the condition is `int_status || fa=
lse`,
> > > > >   so it loops as long as there are pending interrupts.
> > > > > - after the 5-second timeout: the condition becomes `int_status |=
| true
> > `,
> > > > >   which is always true.
> > > > >
> > > > > When the loop becomes infinite btmtksdio_txrx_work() loop never
> > > > > terminates and never releases the SDIO host.
> > > > >
> > > > > Fix loop termination condition to actually enforce a 5*HZ timeout=
.
> > > > >
> > > > > Fixes: 26270bc189ea4 ("Bluetooth: btmtksdio: move interrupt servi=
ce to
> > work")
> > > > > Cc: stable@vger.kernel.org
> > > > > Signed-off-by: Sergey Senozhatsky <senozhatsky@chromium.org>
> > > > > ---
> > > > >  drivers/bluetooth/btmtksdio.c | 2 +-
> > > > >  1 file changed, 1 insertion(+), 1 deletion(-)
> > > > >
> > > > > diff --git a/drivers/bluetooth/btmtksdio.c b/drivers/bluetooth/
> > btmtksdio.c
> > > > > index 5b0fab7b89b5..c6f80c419e90 100644
> > > > > --- a/drivers/bluetooth/btmtksdio.c
> > > > > +++ b/drivers/bluetooth/btmtksdio.c
> > > > > @@ -620,7 +620,7 @@ static void btmtksdio_txrx_work(struct work_s=
truct
> > *work)
> > > > >                         if (btmtksdio_rx_packet(bdev, rx_size) < =
0)
> > > > >                                 bdev->hdev->stat.err_rx++;
> > > > >                 }
> > > > > -       } while (int_status || time_is_before_jiffies(txrx_timeou=
t));
> > > > > +       } while (int_status && time_is_after_jiffies(txrx_timeout=
));
> > > >
> > > > yes, loop continues only while there is interrupt work and the time=
out
> > > > deadline is still in the future
> > >
> > > I stumbled on this while backporting to distro kernels, and I wonder
> > > whether this change is correct.
> > >
> > > IIUC, this essentially makes the loop exiting right after the first
> > > cycle; the patch changed from time_is_before_jiffies() to *_after_*()=
,
> > > not only the logical OR to AND, and *_after_*() returns false, so the
> > > whole condition becomes false, too.
> >
> > The intention is for the loop to keep running as long as there is still=
 an
> > interrupt left to handle (int_status !=3D 0) and the timeout has not el=
apsed
> > (jiffies < txrx_timeout).
> >
> > Note that time_is_after_jiffies(x) returns true if x > jiffies (or jiff=
ies <
> > x):
> >
> >     /**
> >      * time_is_after_jiffies - return true if a is after jiffies
> >      * @a: time (unsigned long) to compare to jiffies
> >      *
> >      * Return: %true is time a is after jiffies, otherwise %false.
> >      */
> >     #define time_is_after_jiffies(a) time_before(jiffies, a)
> >
> > Or am I missing something?
>
> Doh, scratch my comment.  It's enough confusing about time_after() vs
> time_is_after_jiffies().  Too hot here to review something today :-<
>
> Sorry for the noise!

Haha, no worries, it got me too! (In our internal discussion with
Sergey) I had to look up the definition and think about it for quite a
while to ensure it was really what we needed. ;)

Best,
Tomasz
