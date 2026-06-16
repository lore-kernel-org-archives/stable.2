Received: from mail-qt1-f176.google.com (mail-qt1-f176.google.com [209.85.160.176])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 23B273CE099
	for <stable@vger.kernel.org>; Tue, 16 Jun 2026 05:14:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=209.85.160.176
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1781586857; cv=pass; b=GuFqVE+ukk4RsjX98MY2RmwFDxNT/6VkMpA1wE1OCymxtYFJleb1Df8vmBLRWgWI46j5wc7d+lsteE1lkG5eeAbw5msoIct8XIiE/cSEB4tYLyRH7cmVbx8Up+D9U9JSIyySedtPo4vrIcr/ElFUjBBORcrqsv2O7wIK5lIC8Rc=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1781586857; c=relaxed/simple;
	bh=cdgthtRN3TaZug5RXpYRGPPhsYE+QJ6XysT3Mm820xc=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=UbbO908LEDNV3DzkKL4R7BEowoldLFG7wssux0Wa4h+2kZAieJg4iery3hRTo3mGelv45FuxYMTgehKP6ty2zBsQD/D5q7C6Epd5GyP6zrZfM8L+JgWtnId5wlA3HFXQSg/S5ng8O2N6STv7NN8V5mv0qj894uhfmb/ImuTiOsc=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=xwf.google.com; spf=pass smtp.mailfrom=google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=wEhFJAs0; arc=pass smtp.client-ip=209.85.160.176
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=xwf.google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=google.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="wEhFJAs0"
Received: by mail-qt1-f176.google.com with SMTP id d75a77b69052e-5177d1ff061so97451cf.1
        for <stable@vger.kernel.org>; Mon, 15 Jun 2026 22:14:15 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1781586855; cv=none;
        d=google.com; s=arc-20240605;
        b=TBx3UBV5pP/SeY22qc5gu9g8YPFK1r9O82vijKxXa/uufUhThhl74Yf19g55NTgqBY
         4e602vzGogc6+UQSXuzCOj3sRrx9dTJ/84cBRkiazvUS7wUldRDqsKjvqic7wZjnUTjO
         o56XyPABJ0++V3z7rmBQHAnDcs0PImmhnsulfmnZu4nYKKqk9hwAlCiPrnm/IcvUag3q
         VoHeE/AqB0b9xP4xoRVoda/K++1KBsssZWi/3/DwspIPIbP6a4UF/KTwDp66eo5qXwAp
         CdAdCGtjCp+u8wz7pe7mF49g3pEWbrx0c8w8JA+AXQnXOYuzpa4p6nAE0J5IbgokGgWm
         DoNQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20240605;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :reply-to:in-reply-to:references:mime-version:dkim-signature;
        bh=oZf9AADMW1nQW+AfyrB/2b+6l5AZvBA4C3NEgxXJMD8=;
        fh=sfSKpGTph5GLR1Cw+KVyxaLw5B88TnJZo0D7oUNwHh8=;
        b=VedvR5krHDloNQmxtSqdlBmHi7ewSpX80SpKg2Zr0u5V72LYmP8RS7pQ23uPVXzlZZ
         879/tz2HhhBf6XqG0B9m2k4nkDhB6fv+VRI2GhXosYlfM/lzufWefcbsMi6kNEdmuBm6
         GNXvDl7nu32gPPbL0XEHC3GOC5vQHrdb0pVMjXBL91BZmeSeDgNTXK1o67D8ilQxJr9L
         cqdCN8oKxFBm4ogWParLsPqUPr/m+I0tg3oykqtRjw4yO+n3TixWv4dvOz5lBWRnvnX7
         AfXxCzIu3BYXHolKGDmsE7OfmWq0vtta8u9OWLQ4y3wt5N5Pkq4e3hD8/MXfLh6Db/+V
         gDww==;
        darn=vger.kernel.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20251104; t=1781586855; x=1782191655; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :reply-to:in-reply-to:references:mime-version:from:to:cc:subject
         :date:message-id:reply-to;
        bh=oZf9AADMW1nQW+AfyrB/2b+6l5AZvBA4C3NEgxXJMD8=;
        b=wEhFJAs0av8w0frst2D7qsBUT8oBcLWm8aYlIkItG1hd8gwjWVkBVSgFXm8eEBSn3s
         YV45x1yVr1I5PTc3+Ianyb4QthYhFnI/YBFvU99FWYhwx/6HseDx+C8LuSGtV8/RfQPN
         y47w44+eYAXnA7HZn4H9M+yrgkK3HxqpQyqdlQoGcyihqe69nYJmy8a8gc+Q9pa5tdi6
         Y8U0i83xsIgj7MkIlOnNQI6eRcoJ5X5JgaPQvM+R0UJvl9YSPkpQO6ysA9ZrVyf8wYvu
         WZC2RB27l19oh+0P80NXnnZLONclItXLSrVd32a6XjmhzIdlQtE6jdJ7xn20pnKeynkF
         kFeQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1781586855; x=1782191655;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :reply-to:in-reply-to:references:mime-version:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=oZf9AADMW1nQW+AfyrB/2b+6l5AZvBA4C3NEgxXJMD8=;
        b=XdKkDvgT4o4+Iof8v7JlBQPnRkmqPgb1KXYGDePZ9HZXveqSvV7ggwLK0PVtX7ktDw
         jHyJllNNjnC3rf4gSP6u+xPbdUbxqDHsKc5/ZyCv1e8bq7OtF5uaELKfhnaYY25yTxnC
         ftiIhmyu/AKTXg58qCpDrE0X36ea8cCa+M4LagHXjZly59POEO41Qzufj2MGTdR5S33S
         ifvbT+4x5Uog6JjNQVw8gNiPYuy65p+1hkT9X3L02vzHtIdkVAkASLdgiF6G39C7+nVu
         9s13NYB+K4zuK+mD4kGa6VtuoaK71I9HVnenJRE4TKawIo7Zns8bA9t21Yu0KIAecLTa
         C+vw==
X-Forwarded-Encrypted: i=1; AFNElJ8sU9ktOULkQNSY4RiNbwn6QeShyDfwcqYnpGYsb4SGVEzRXssOqhurWR0cRuwml1HrQSoRwDM=@vger.kernel.org
X-Gm-Message-State: AOJu0YzIpbzOVJYVgvkp+FNJYZyNWk3oGWF5V7uYGGkjo+oLZdMH+4/n
	fUJ6x0pHuzAyyJNGIemf8QkdoNIG1sutTWgCFIwrc40wEPLWVNKfjuSv/3RFEfOlkQUncNDHVtv
	7/5pEsflxLzle1dV6THG6LDQvMrbewcdxsV1x7h2+YkEZY6AMwy1Gt/LYL7A=
X-Gm-Gg: Acq92OFR+ou0riHu0Ehg0ADlkE8JbIdkagwVP1XB5vK0QC8CJXuTqPSGq4sxjb7WtSb
	j/3ZucdIgOXGeKcxr0ZYuVsSoFFaNPbWLuCrhXPgoODwaELbn6LgYtgYjzUlMeYmgdAcRjj9Wwb
	XcZvAITA5Mb8zy2dt/Jg8/IrkTGp1G/jyNDUhGuM+CdjoQE5QlX43x+WFJ7+NPaI/l5uuVhJx5p
	yE7iwiiAGCRG1LlSXCoHPDvyXRUcCudU3WmQGSdBey1MI3/lr+8+oC98Wlcs6ifapAhojHfm0+Q
	BNYG8sUdfw==
X-Received: by 2002:a05:622a:1811:b0:50f:be7b:923a with SMTP id
 d75a77b69052e-51993b50849mr4108131cf.9.1781586854474; Mon, 15 Jun 2026
 22:14:14 -0700 (PDT)
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20260526070635.839701-1-hhhuuu@google.com> <1f7a7bf2-4d21-4944-9da0-36082d052b25@rowland.harvard.edu>
 <CAJh=zjLLrY-NpV-ZcmH0V6q8CjNuKt7CmW-GEFQ8_y3zm9v1yw@mail.gmail.com> <d0042def-a513-479f-9742-12942346cd5a@rowland.harvard.edu>
In-Reply-To: <d0042def-a513-479f-9742-12942346cd5a@rowland.harvard.edu>
Reply-To: hhhuuu@xwf.google.com
From: "Jimmy Hu (xWF)" <hhhuuu@xwf.google.com>
Date: Tue, 16 Jun 2026 13:14:03 +0800
X-Gm-Features: AVVi8CdpgkJIscAxcD7JJW8uf9rRWz1lpVf-Jfo1TjIojlCbI_U2UHaPHFSuQOY
Message-ID: <CAJh=zjJqarEkrzajpdcUAZwOxisbdrwTPwX_jHWzuWZFSQ16SA@mail.gmail.com>
Subject: Re: [PATCH] usb: gadget: udc: Fix NULL pointer dereference in gadget_match_driver
To: Alan Stern <stern@rowland.harvard.edu>
Cc: Greg Kroah-Hartman <gregkh@linuxfoundation.org>, linux-usb@vger.kernel.org, 
	linux-kernel@vger.kernel.org, stable@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Tue, Jun 2, 2026 at 10:30=E2=80=AFPM Alan Stern <stern@rowland.harvard.e=
du> wrote:
>
> On Tue, Jun 02, 2026 at 01:34:07PM +0800, Jimmy Hu (xWF) wrote:
> > On Wed, May 27, 2026 at 2:00=E2=80=AFAM Alan Stern <stern@rowland.harva=
rd.edu> wrote:
> > >
> > > On Tue, May 26, 2026 at 03:06:35PM +0800, Jimmy Hu wrote:
> > > > A NULL pointer dereference occurs in gadget_match_driver() because =
a
> > > > race condition exists between the DRD mode-switch work and the
> > > > configfs UDC write path:
> > > >
> > > > 1. The DRD mode-switch work invokes __dwc3_set_mode(), which calls
> > > >    dwc3_gadget_exit() and subsequently frees the UDC device name vi=
a
> > > >    device_unregister(&udc->dev).
> > > > 2. The configfs UDC write path invokes gadget_dev_desc_UDC_store(),
> > > >    which calls usb_gadget_register_driver() and subsequently
> > > >    compares the UDC device name via gadget_match_driver().
> > > >
> > > > If gadget_match_driver() runs concurrently during UDC unregistratio=
n, it
> > > > may access the freed UDC device name. Once the freed memory is zero=
ed,
> > > > dev_name(&udc->dev) returns NULL, causing a panic in strcmp().
> > >
> > > I don't see how this can happen.  gadget_match_driver() runs during
> > > probing of a gadget, which takes place only while the gadget is
> > > registered in the device core.  But usb_del_gadget() calls
> > > device_del(&gadget->dev) before it calls device_unregister(&udc->dev)=
.
> > > This means that at any time when gadget_match_driver() can run, the U=
DC
> > > device name must still be allocated.
> > >
> > > You should run more tests.  Add debugging printk() calls just before =
and
> > > just after the device_del(&gadget->dev) and device_unregister(&udc->d=
ev)
> > > lines, and inside gadget_match_driver(), so the tests will show
> > > unambiguously when these things happen with respect to each other.
> > >
> > > > Fix this by checking dev_name(&udc->dev) before calling strcmp().
> > >
> > > Adding a check like this will not fix a race; it will only make the r=
ace
> > > less likely to occur.  It won't prevent the name from being deallocat=
ed
> > > between the check and the strcmp() call.
> > >
> > > Alan Stern
> >
> > Hi Alan,
> >
> > Thank you for the review. You are absolutely right about the TOCTOU ris=
k;
> > the simple NULL check does not prevent the name from being deallocated
> > after the check but before the strcmp() call.
> >
> > I will submit a v2 patch that uses get_device(&udc->dev) and put_device=
()
> > to increment the UDC reference count during the matching phase. This wi=
ll
> > guarantee that the UDC device name remains allocated and valid througho=
ut
> > the entire duration of strcmp(), eliminating the race condition structu=
rally.
> >
> > Does this approach sound reasonable to you?
>
> No, because you haven't addressed the issue I raised at the start of my
> email, namely, how can this problem actually occur?  And you didn't run
> additional tests with the extra debugging information that I asked for.
>
> Alan Stern

Hi Alan,

I have captured the KASAN log with the extra debugging information
you requested, which shows how this race condition occurs.

The log shows that after gadget_match_driver() enters execution on
one core, a parallel core can invoke usb_del_gadget() and complete
both device_del(&gadget->dev) and device_unregister(&udc->dev)
before strcmp() executes.

Here is the exact timeline from the dmesg output:

1. At 268.595241, task 1374 (configfs path) enters
gadget_match_driver() (on CPU6):
[  268.595241][ T1374] [CPU6
android.hardwar]:[JJ][core.c/gadget_match_driver/1568] Enter

2. At 268.595250 (only 9 us later), DRD work invokes usb_del_gadget() (on C=
PU3):
[  268.595250][  T102] [CPU3
kworker/3:1]:[JJ][core.c/usb_del_gadget/1529] Before
device_del(&gadget->dev);
[  268.598129][  T102] [CPU3
kworker/3:1]:[JJ][core.c/usb_del_gadget/1531] After
device_del(&gadget->dev);
[  268.598159][  T102] [CPU3
kworker/3:1]:[JJ][core.c/usb_del_gadget/1534] Before
device_unregister(&udc->dev);
[  268.599405][  T102] [CPU3
kworker/3:1]:[JJ][core.c/usb_del_gadget/1536] After
device_unregister(&udc->dev);

3. At 268.599427, task 1374 starts comparison, where it triggers a
KASAN invalid-access. (Due to kernel preemption, the task was migrated
to CPU7):
[  268.599434][ T1374] BUG: KASAN: invalid-access in
gadget_match_driver+0x150/0x1cc
[  268.599448][ T1374] Read of size 8 at addr 66ffff801a49b880 by task
android.hardwar/1374
[  268.599454][ T1374] Pointer tag: [66], memory tag: [fe]
[  268.599456][ T1374]
[  268.599460][ T1374] CPU: 7 PID: 1374 Comm: android.hardwar Tainted:
G S      W  O       6.1.124-android14-11-ga633402dff84-dirty #1

To resolve this object lifetime issue, I see two potential approaches:

1. Protect the UDC device lifecycle during the comparison phase using
   get_device(&udc->dev) and put_device() (as a lightweight fix).
2. Serialize the configfs match path and the unregister path using
   a subsystem mutex.

I would highly appreciate your thoughts on which direction you prefer.
Does this data address the scenario you raised?

Thanks,
Jimmy
