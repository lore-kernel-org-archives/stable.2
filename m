Received: from mail-wr1-f42.google.com (mail-wr1-f42.google.com [209.85.221.42])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C70F738B7BA
	for <stable@vger.kernel.org>; Tue, 23 Jun 2026 18:42:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.221.42
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1782240151; cv=none; b=EhiJIlJe0wp47qGlyNwpMN/r+d0phtXzadtaG+5pmtvpWX0sW1oGrKGiR1Iff2U462srrmNaQ+bE6FFCsNTM3TCtegha/neFALyBYi0+tQpNj513F6ufGOsSO0rOVB9XxKc7xHyrL6i78aSRzINa2QVRVOwIpBb9LflZi1goro4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1782240151; c=relaxed/simple;
	bh=4ijPsrRHs5HDLixaI4BySfM7eV+ofaqEi239744DyB8=;
	h=Date:From:To:Cc:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=QChWZ6mBb9mrsGiLZg1TNlBMN0dxQEgl1WM01lrfMrJMlhiRoC2cVrRRp4+64XoO8NkInzAr9tt+k5lQmjfTuAiZpFrquQ9CtPoDIMtxW3HkB39DyHWqBl2dey4UWXS07nt9M6EQyGSA1t50+iRrRw2jFgTQi2rKpDrXWo5l5EI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=tOYvxA9S; arc=none smtp.client-ip=209.85.221.42
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="tOYvxA9S"
Received: by mail-wr1-f42.google.com with SMTP id ffacd0b85a97d-45eeea039ebso128639f8f.1
        for <stable@vger.kernel.org>; Tue, 23 Jun 2026 11:42:29 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1782240148; x=1782844948; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:subject:cc:to:from:date:from:to:cc:subject:date
         :message-id:reply-to;
        bh=CTMqG4t3z/eIp4oJgxGHgQBT2VYdrTvoVzYZ9QX3mIk=;
        b=tOYvxA9S/voMD5WeqqzAp8bb1o/plEncb4yY2bks1T+m+bjVsAWuvp6X5E0yqCygvn
         ObFShFFRz4Pu/FNYDresEH2shpVAgQldARHEuO9MKlA0PQoMZJq9yrE7uxDhRGtBfQDL
         iYkBeSXsAq0B7S55OftSl9TRGp6WRVLZcnFWepU0JT1MferY/AcB1A1FTwFqtN5dI597
         1xhZw1l2ZaIZoBYrfMOYrC+QKnSYIn/A0RVC+xWPiPvqShUOC40SWs0Y4+HcW6QuPs0h
         205qzcb0XKratm1Qr3GARVpq1aXuImIibtg2aiss7aU2wjup1l90M5mbYRoSxDblGNYJ
         ITRQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1782240148; x=1782844948;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:subject:cc:to:from:date:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=CTMqG4t3z/eIp4oJgxGHgQBT2VYdrTvoVzYZ9QX3mIk=;
        b=rv9rDZjU7u3mwSGfDcm4C8Rq0AzGzLTXfdgkSgJvWqrjajdxcUWnWBjEpmQ7zHO6MR
         2ALXHB/sdwC8uBA9U6ccz9wYaMeLOuiJiCCuWw/A8cKkM6gQQjEu5dYkTHAZj0h79Xvj
         jxpcymoQaqwZp7opd4fqxGdcBb4KV/mlbjcMlYnnOzn6RF529TVkp4sI1YIS9EhXo+PZ
         YNPNB0qy2KSIxhUhDYOywyTKWYUJNO7vzaQNCIwiaGF3b+7a+MjyZQW0xpyhUXxAjzRs
         AhhdIWI61/WikBgFJnjYp318QOSBW0wwDWkfRFdcyPB6zSfttRthH6f7Kyjq0n8uic9R
         cWjA==
X-Forwarded-Encrypted: i=1; AHgh+RqOK2oZLgT+Qv5D2c4YgBgJVJ56iVATNtW3r3eNp2fQKlVvl5CReO2aRhdlwrOc3+WGEze4sR4=@vger.kernel.org
X-Gm-Message-State: AOJu0YwlHV4V0dlVrnpLu9ZFquUU/HRkY42bho+9aLV17ddvcqxZIx1q
	PsdAOtQDnTfcWW5eWxj7P8+3K2QkAyp4qGr3Z1AR3H7W4MzKNOmEublZhdCWAAuK
X-Gm-Gg: AfdE7cl/fdwPOzp+qsYfSJBWBy4WZ1XkrTjtD6rmeVqw2xOY1M3cxZfOW9Zz36T7DIg
	gY9aBXqccBW4jTAZLSO0iD6xHeBg00jLgthoVekFYfYheIQ6u7+5g0v6/+A9mAu2NsYzGCsHRpF
	KGKFC+uAMUiAtGW0TWzRsNDbNsOyTPHF8UGzXi6leC4Qd/yW4rRsm9C/ih1G8oHTK0x81Ven4eg
	CDUpE3ocoXEicemfoF1pjvIIrxYPBTA6Hfx/rwiq5/7hgt3xuR25KpKYvKTMC2RqiM8rTMUSrAe
	gagDVnCvVcJVlAYlDP7c61U27S9zrCOeYSGc2ZFKqlGOGuJw6Bw4xajm3GKgBmnzJlETnguEjsl
	Sw7gGLnvZLLMyL7CF/0Ozy4CbfPzNwxxoVJfGNKM5HRgd4B+fcc+1HjhbG1IRAEkp0D12KWxXnD
	9wp7LmAi5gsbY5Qpzk/wABo9r+61+O9Bho1fRa8DSomwjfIjlhpg==
X-Received: by 2002:a5d:634d:0:b0:460:3233:f994 with SMTP id ffacd0b85a97d-46c0b00b249mr33411f8f.43.1782240147866;
        Tue, 23 Jun 2026 11:42:27 -0700 (PDT)
Received: from pumpkin (82-69-66-36.dsl.in-addr.zen.co.uk. [82.69.66.36])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-466648c4fd2sm37006350f8f.14.2026.06.23.11.42.27
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 23 Jun 2026 11:42:27 -0700 (PDT)
Date: Tue, 23 Jun 2026 19:42:24 +0100
From: David Laight <david.laight.linux@gmail.com>
To: Paul Mbewe <paultyson.mbewe@ziehl-abegg.de>
Cc: <linux-serial@vger.kernel.org>, <linux-kernel@vger.kernel.org>,
 <gregkh@linuxfoundation.org>, <jirislaby@kernel.org>,
 <hvilleneuve@dimonoff.com>, <stable@vger.kernel.org>,
 <tobias.gannert@ziehl-abegg.de>, <joachim.knorr@ziehl-abegg.de>
Subject: Re: [PATCH 2/2] serial: sc16is7xx: set TX FIFO trigger level to
 half FIFO to prevent underruns
Message-ID: <20260623194224.308ba549@pumpkin>
In-Reply-To: <20260623171328.153735-1-paultyson.mbewe@ziehl-abegg.de>
References: <20260623160759.506f456e@pumpkin>
	<418f9ae5-8827-475c-b465-1271a784fbf1.bc56e27e-ecd8-43ae-bb87-75bfd472a28d.42cbe154-31f1-464c-8ca6-20ef01cab8dc@emailsignatures365.codetwo.com>
	<20260623171328.153735-1-paultyson.mbewe@ziehl-abegg.de>
X-Mailer: Claws Mail 4.1.1 (GTK 3.24.38; arm-unknown-linux-gnueabihf)
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: quoted-printable

On Tue, 23 Jun 2026 19:13:28 +0200
Paul Mbewe <paultyson.mbewe@ziehl-abegg.de> wrote:

> Hi David,
>=20
> On the test system, the relevant threads already run with RT priority:
>=20
> =C2=A0 irq/134-spi2.0=C2=A0=C2=A0=C2=A0=C2=A0 SCHED_FIFO priority 50
> =C2=A0 sc16is7xx=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 SC=
HED_FIFO priority 50
>=20
> So this is not caused by the IRQ thread running as a normal SCHED_OTHER
> task. That does not remove all latency sources, of course; on this
> single-core SPI system the threaded IRQ can still be affected by other
> RT/kernel activity, IRQ/preemption-disabled sections, SPI transfer time,
> or lock contention.
>=20
> I agree, changing the TX trigger from 8 to 32 free spaces reduces the
> per-interrupt time-to-empty margin. With an 8-space trigger the FIFO
> still contains 56 bytes when THRI asserts, while with a 32-space trigger
> it contains 32 bytes. So the v1 commit message is misleading when it
> describes this as increasing the refill window.
>=20
> The observed effect is instead that the 8-space trigger causes many
> small TX refill events. Each event has roughly the same cost, as you
> said. If the handler runs in time, it can catch up by seeing more than
> 8 free spaces and writing more data. The failure happens when one event
> is delayed long enough for the FIFO to drain.
>=20
> Using a 32-space trigger reduces the number of refill events and the
> associated IRQ/SPI load. It also reduces the chance that one delayed
> event lets the FIFO drain completely. On the tested setup this reduced
> irq/134-spi2.0 CPU usage from about 15-17% to about 5%, sys CPU from
> about 51-61% to about 19-28%, and load average from about 2.0-2.2 to
> about 0.65-1.3. With that change, the observed TX gaps disappeared.

Even with those figures (and the cpu % differences seem reasonable)
I still don't see why it stops the underruns.

An interesting exercise would be to call to ftrace_stop() when the
tx fifo is unexpectedly nearly empty.
Then enable all the ftrace scheduler and interrupt events (they don't
normally slow things down that much) and run the test with ftrace enabled.
When the trace gets stopped (you can just 'cat tracing_on' to find out
when it has been stopped) just 'less trace' to see what happened.
I think that will show that the isr thread is scheduled but doesn't
run for a while because something else is 'hogging' the cpu.

I've used this set of events - seemed to be useful.
    Clear old events
echo >set_event

    System call entry and exit:
echo 'syscalls:*' >>set_event

    IRQ entry and exit:
echo irq:irq_handler_entry irq:irq_handler_exit >>set_event
echo irq:softirq_entry irq:softirq_exit >>set_event

    Scheduler process switch events:
echo sched:sched_switch >>set_event
echo sched:sched_wakeup sched:sched_wakeup_new >>set_event
echo sched:sched_migrate_task >>set_event

	David
 =20
>=20
> So I agree the commit message should be reworked to describe this as
> reducing TX refill events and IRQ/SPI load, not as increasing the
> per-interrupt latency margin.
>=20
> If changing the default trigger globally is considered too broad, I can
> also look at making the TX trigger configurable or limiting the change to
> SPI-backed devices.
>=20
> Thanks
> Paul
>=20
> _______________________________________=C2=A0
>=20
> ZIEHL-ABEGG=C2=A0
>=20
> Executive Board: Joachim Ley (Chairman), Marco Altherr, Wolfgang Mayer
> Supervisory Board: Dennis Ziehl (Chairman)=C2=A0
>=20
> Court of Registry: District Court Stuttgart HRB 746188
> Company Seat: K=C3=BCnzelsau, Germany=C2=A0
>=20
> Der Inhalt dieser E-Mail und/oder jegliche Anh=C3=A4nge k=C3=B6nnen vertr=
auliche Mitteilungen enthalten und sind ausschlie=C3=9Flich f=C3=BCr den be=
zeichneten Adressaten bestimmt.
> Wenn Sie nicht der vorgesehene Adressat dieser E-Mail oder dessen Vertret=
er sein sollten, so beachten Sie bitte, dass jede Form der Kenntnisnahme, V=
er=C3=B6ffentlichung,
> Vervielf=C3=A4ltigung oder Weitergabe des Inhalts dieser E-Mail einschlie=
=C3=9Flich Anh=C3=A4ngen unzul=C3=A4ssig ist.
> Wir bitten Sie, sich in diesem Fall mit dem Absender der E-Mail in Verbin=
dung zu setzen.=C2=A0
>=20
> The content of this e-mail and/or attachments may contain confidential in=
formation and is intended solely for the named recipient.
> If you are not the intended recipient of this e-mail or on its distributi=
on list, please note that any type of disclosure, publication,
> copying or distribution of the content of this e-mail including attachmen=
ts is strictly forbidden.
> In this case, we would kindly ask you to notify the sender of the e-mail.

