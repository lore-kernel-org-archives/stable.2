Received: from mail-ot1-f46.google.com (mail-ot1-f46.google.com [209.85.210.46])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6B0C925A2C6
	for <stable@vger.kernel.org>; Wed, 26 Aug 2026 14:32:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=209.85.210.46
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1787754764; cv=pass; b=c1DC+XbwsTkRLfG6EexntCWh9q6OVNU+wgu97keZPhEtcqQNTKWjU90OlT8uxsvX8212iaRLNc4VtxFDdE8nihEr4baestmPY7UK93GJBXJzrIrknHFa8Z3XvhnZVz83CMlM+RkOseMFA63cXdg3wEbMGtdCn5FsIArt/7BJmsU=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1787754764; c=relaxed/simple;
	bh=uGuMG/KM6SBJAW6r5VuXsRS227UH4wUcYvkOdg0cQyQ=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=OMWV0bW1fWyDEHEGwqg/bV2V2TWepV6SWYT5mbJMQ36umxZ+9RPJZCvIokTX2QtF3/3fJBbpLOEA7XqbmxfPpYkVlXO0F6ilH0WGWgHlrJxYhLRRm6twWQkk/DEIPN+nIlKsmSdLIwerzGyknGD5GaovQWOi6MrtOGzqKtm8OL0=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=ClTpXhXM; arc=pass smtp.client-ip=209.85.210.46
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=google.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="ClTpXhXM"
Received: by mail-ot1-f46.google.com with SMTP id 46e09a7af769-7ec1e9d3359so776626a34.0
        for <stable@vger.kernel.org>; Wed, 26 Aug 2026 07:32:42 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1787754761; cv=none;
        d=google.com; s=arc-20260327;
        b=Orm5dUhCvaQnpSCi4u0t1M2pAi0ISS7HKO+iONIfKBkx5rMNmiImA8U1Y76NeVtiE9
         hmX7GxRivnh60gD5bqxSuUXtb3Z2sPNiVPYa5aqrRgDW/jES5YXCEYao9C/V4y6NBJ+2
         s2iBa+/HRDQWwFXLt2C1yjNi/wtuHxHrexL4bUBvih+U2qA7OHV0jXKq6WNzldgj6NUX
         Uctdakzmz/7zGA2+ViKLfbmAc5bZveSMQrH//GLHRkf7yweeQMqYJBnWZLpevEVyumvi
         Tx13fBZhOXK9i6Mlj+i3W0o6kcYvuCEGZqvOXuLmWARRR3z0/28r9sBrWRjloUEKMbzN
         Temg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20260327;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:dkim-signature;
        bh=x1g4ctzEFpC9hS1eVfp5ZBV87NdsbdBID9p8ekLhrAY=;
        fh=gwBYxKf1k6U/rU/Py/2HERwon962lb6wacfQC+4CIkY=;
        b=orqrPD8YrcpZWo6FRhc9t893WeGMHwGEZ/G+KnmCIdtr71KEXKuQqou6m0vRkc2TAW
         njqcT7M6uOnmP1Zqms+M41ov5sEI2KuYIQoyss9obqrvz4wMWBdNczbYhnhSbp+n8f5R
         +6B+MzMLD20IWpQbzoXaNcxhzj4eubd48PF899Uk6ra8bKCwMEAlu9gIMaC9X50Q+j72
         wVk/Fuzrj75zhRDh56mK2gw0+SBiNUk+n/uYKnG9cDLZS8hblEoGWLvulb4p8dh0XNZ1
         THNG3438kdH5B5efaICDa7YULlfbUE/qXuJ6+TY1YjpewuQnJXJEXdpx6lWZYwwMJpi8
         QLnQ==;
        darn=vger.kernel.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20251104; t=1787754761; x=1788359561; darn=vger.kernel.org;
        h=content-transfer-encoding:content-type:cc:to:subject:message-id
         :date:from:in-reply-to:references:mime-version:from:to:cc:subject
         :date:message-id:reply-to:content-type;
        bh=x1g4ctzEFpC9hS1eVfp5ZBV87NdsbdBID9p8ekLhrAY=;
        b=ClTpXhXM+uOrobfj90WP2yjdefO3X9gIPragRCzKJ+oH6FqsevrVBFi+MOMrJnT5xR
         ZGfvCqxA4/CSyQ578oeOsuVHUuj2uj+GZdCN2PnY0Ttm84UR16EbiWH4/rPyYZTvDKWh
         YStRL3BQ2poPflKdnZ9NDEaslV78sLIqZ5k+hp68RuIFRxvFOrGDPyo07YICfSkrXSwZ
         fIetlBBshd5qSn+e2owXUooXTpT6MBlyESB5PYbWr19NaYst/ItjsEUNrggbL9AqnjPw
         ZIL6biAo7riFR/h9yHd40N64JpcfDDtTWa47joW6SkHC/kyWCOHFPFRauovvQnuoQBxy
         shyg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1787754761; x=1788359561;
        h=content-transfer-encoding:content-type:cc:to:subject:message-id
         :date:from:in-reply-to:references:mime-version:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=x1g4ctzEFpC9hS1eVfp5ZBV87NdsbdBID9p8ekLhrAY=;
        b=pbYWqwTOMzmJcx+YUw/WEKhaICwTmTuDT9dM3uees4Q1C4jhlG3rUUs/pzOq7YSA4V
         VdEjHGr9nxra3pxL84v0ZlqetAMZ2EgaMYCzL6H6qypuS7vYIzakbVSgWZ0k/OuS0CeS
         0nccI/jCqmOz8t4J4YHbjfjeJRmLG5hqTfhOQ0kmuW3Rm4cP3mKNC5mUzKyy9FkmRAN3
         GmPH1eLljtCROyjtjqLzpQeoHeBrZarWsB3QVfzKQDE38A5P1LHGn3VCji6Ae6E1Dobm
         qi8PmX24KG2d7Wpkp87kDFcDVDCSivGTN5oVnQ4LH4BLIKGjqjNkCGPgVv9spwlvh2YO
         J/Vg==
X-Forwarded-Encrypted: i=1; AHgh+RpDePCHy97o2iloTwJKJwc29BlFMhYZzrs1g7TCGQYG+6GKzxch57jCRI8e8swetsoHcltzATQ=@vger.kernel.org
X-Gm-Message-State: AFuF++klVxeLefvugHLKQBVqkyuTC15QfelLu992TI+BmfXMOUKCjPUW
	JMqVuwZyuhvG4FPOjmNOoXnu8hWxq9UK+9MSVwWKN8PyGXTo5gkpcj8JrdY8gmYgmLOcV7Hvpz3
	lNXb7cr+s4mWl7SgziU35rTwjztEG84P7qb6jI2c0
X-Gm-Gg: AR+sD112o9H2du56nXqKdB2Zv51TWLN5gQXk6GuHKctJ/PCf6+1Iypo/mV3FY/TMJA8
	Fgc2xt9OGkiUrN26eLpvs4EJFr3W3ey79tJuwDhvUC7GZnt4JpudNe3RtP9VIVLjJdELueJAXqV
	VrCqRHjWisCG2ZAsOaj9xtkfY6mP8Fdaj8w759O7bYgyOrq2nuQsVGi+YrzlLwvhlfbOU2FeC4l
	WHMq9AELV7a6rPdkStp7etC42RSO/xfnwaoy/K8HeBLq8HN/YAb8XO7YONYNGuVf+J5s17PgnRF
	gstZhkaDW40E1xqIXu2h6+bKpgMYu0WMfGTYnMgM2o+YTm1O3hEj9LEapxv4gi3Sv4UxoysYj/q
	nvvEl2/RS2hijjNW03XEbl4nAVdL7G2HRUjQGKaakgLmLgw++z1g9AeK6EgaPWy1ZGTC/utiZ7P
	Qtk7ct2cMP24j7
X-Received: by 2002:a05:6830:3708:b0:7e6:fa37:9797 with SMTP id
 46e09a7af769-7f4c4dfee34mr7818437a34.6.1787754760603; Wed, 26 Aug 2026
 07:32:40 -0700 (PDT)
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <6a88012e.dbb3a75c.13dd47.0007.GAE@google.com> <6a8d0f6c.dbb3a75c.7844.001d.GAE@google.com>
 <2026082540-tarantula-gigantic-b786@gregkh> <CANp29Y5YH=O35brw55HFo_hVmFDz5Y4Yw7buBc-rOjETU2DNjg@mail.gmail.com>
 <2026082507-ecosystem-giant-0b79@gregkh> <CANp29Y5hnOWaqGw8BbPu1TCr00TbvNRciYvs_VCd6Jtk=8kSPg@mail.gmail.com>
 <2026082602-compile-bogged-877d@gregkh>
In-Reply-To: <2026082602-compile-bogged-877d@gregkh>
From: Aleksandr Nogikh <nogikh@google.com>
Date: Wed, 26 Aug 2026 16:32:28 +0200
X-Gm-Features: AcwNN1U8xGoi4BJvKqmFyT1BTT2HHIMJbt0Q1AHIDird_ONv_FDVdlZesHwWpx0
Message-ID: <CANp29Y486UwGwRJpqzQ4aU2eN4Xu3A+zw_zDUJuFR5hKQ+Knrw@mail.gmail.com>
Subject: Re: [syzbot] [usb?] general protection fault in wcove_typec_probe
To: Greg KH <gregkh@linuxfoundation.org>
Cc: syzbot <syzbot+1a01783ea233350598b5@syzkaller.appspotmail.com>, 
	heikki.krogerus@linux.intel.com, jeffinphilip14@gmail.com, 
	linux-kernel@vger.kernel.org, linux-usb@vger.kernel.org, 
	mika.westerberg@linux.intel.com, stable@vger.kernel.org, 
	syzkaller-bugs@googlegroups.com, syzkaller <syzkaller@googlegroups.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Wed, Aug 26, 2026 at 4:11=E2=80=AFPM Greg KH <gregkh@linuxfoundation.org=
> wrote:
>
> On Wed, Aug 26, 2026 at 03:26:23PM +0200, Aleksandr Nogikh wrote:
> > On Tue, Aug 25, 2026 at 11:07=E2=80=AFAM Greg KH <gregkh@linuxfoundatio=
n.org> wrote:
> > >
> > > On Tue, Aug 25, 2026 at 11:04:54AM +0200, Aleksandr Nogikh wrote:
> > > > Hi Greg,
> > > >
> > > > On Tue, Aug 25, 2026 at 7:12=E2=80=AFAM Greg KH <gregkh@linuxfounda=
tion.org> wrote:
> > > > >
> > < .. >
> > > > >
> > > > > Please do not think that this is a valid path for syzbot to be
> > > > > fuzzing...
> > > > >
> > > >
> > > > Can you please elaborate on this?
> > > > Do you mean driver binding sysfs interface in general or something
> > > > more specific?
> > >
> > > That is the specific thing, don't have syzbot do random bind/unbind
> > > calls, having it attempt to bind any random driver to any random
> > > hardware device.  That's not how bind/unbind is supposed to work at a=
ll,
> > > it's for developers who "know what they are doing" and you get to kee=
p
> > > the broken system if you mess it up.
> > >
> > > Same for unbind.
> > >
> > > This is a root-only api for that reason.
> >
> > Thanks for clarifying!
> >
> > Some context from the syzkaller side:
> > Restricting the fuzzer is always tricky, especially when the
> > problematic operation is just opening a file and writing to it.
> >
> > We normally constrain openat to:
> > 1) An allowlist of safe absolute paths (so it won't open /dev/mem,
> > etc.), blocking any other path starting with '/'.
> > 2) Relative paths under CWD (so we can still fuzz normal file operation=
s).
> >
> > Here the problem is that one can mount sysfs under CWD, which leaves
> > syzkaller full access to everything inside it.
> >
> > Tightening the access to /bind, /unbind, /driver_override sounds
> > reasonable, but trying to catch all workarounds purely in userspace
> > (e.g., creating symlinks to these paths before opening them) will
> > easily turn into a whack-a-mole.
> >
> > Would you be open to adding some kernel config option or a boot
> > parameter to disable manual sysfs driver bind/unbind and
> > driver_override? We had a similar problem with writing to a block
> > device while a filesystem was being mounted, which was perfectly
> > solved by CONFIG_BLK_DEV_WRITE_MOUNTED.
>
> I've submitted a patch to taint the kernel if these files are written
> to, so that should "catch" syzbot and let you know to ignore these
> reports if it runs into them:
>         https://lore.kernel.org/r/20260826-bind_taint-v1-0-52b05f4a965c@l=
inuxfoundation.org
>
> Is that sufficient?

Hmm, if we set `panic_on_taint=3D` with TAINT_FORCED_BIND and ignore
such crashes, I think it could work, yes.

>
> If not, no, I really don't want to make a kernel config option just for
> this type of thing.
>
> thanks,
>
> greg k-h
