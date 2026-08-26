Received: from mail-ot1-f43.google.com (mail-ot1-f43.google.com [209.85.210.43])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 803733F6C59
	for <stable@vger.kernel.org>; Wed, 26 Aug 2026 13:26:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=209.85.210.43
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1787750801; cv=pass; b=JVTv2jjPEAcNkvNA+3owlIP+2UCXIK1aTGKhdKSSB4YyYkBrnt/bkpLC0Ky3KY1y0LpTdHrxjg4SkFuxnXbVmuAILCtA7w5V25JM9oILNn8JYi1Oro2Q125YVVQKMmb/ugJtayhRJFUn9clYj6gHbWfUC2TXZUOeBWpPMSq6oyY=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1787750801; c=relaxed/simple;
	bh=PPyU/hz/a4Na+5pAT4hhG8x3kDuFcn+kPX+Se5g2BoI=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=qObvZliTcfrZ192Gea11ojML1pwNd6DXoBvoa5PyokvW+eTPOb3P7xBTCFXVo0Rmevn9K859gtRdZ//v3mEoEv5Y7r8PGKmcMCIt+hWYK/B7Uw466TccyExOhRW8b92RnshxXHp9VrsnwPe1sTvBUVjyjLizFbgY07RdWrTVsHs=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=f5VB0O21; arc=pass smtp.client-ip=209.85.210.43
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=google.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="f5VB0O21"
Received: by mail-ot1-f43.google.com with SMTP id 46e09a7af769-7ec3b429a3aso710132a34.1
        for <stable@vger.kernel.org>; Wed, 26 Aug 2026 06:26:38 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1787750797; cv=none;
        d=google.com; s=arc-20260327;
        b=bt8zMZF6rIVkDP/BabtZZYXOjkMZAGkUZ0UdlqNWHUEmCD1r/IYbMEeeVmtCs0xmaL
         l4vmfcfdt1X5a4mlI/rLI4nhaWLo/yo19rBut+o5Z32Sr49tG8lk5d1unBer8JrAGiTp
         AyK8XbaBQeFne2kWuuxwPU0VvrBXt1VhAmpdkkn8vAaRe3yr6z5J6ELPe7VVbvtz6VO/
         1uwEw572SKrwtNPpepdK/ui1VTEvAjEED/zJw+Fwg+vPAbGV+5WGJYVyiCxBVY8WxbLc
         jHZA1MYBfv138LONP5rkKKnIcqOyIXvpr23hHees+pVCfsMO4FcGyEg82sYfjkV0uyhn
         r6LA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20260327;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:dkim-signature;
        bh=dXJfDFxsjd6n3nxiKwY8tVm+DTv8K0aaUVAVp01ZKj4=;
        fh=5yMHCS4YRTxZiRC0N/G51aMfHTQWCNvMBhVmm5J3gsA=;
        b=KLBaiCuoA7il8ERNuAbjkCrMreFeM+OJo8Z+X4pbAErTqyQYTA9MF7pfdYvCZ+THh5
         ++gwrQMhLmdXJ8QIl9Xk7pQfTOzEXuE+7dzHTRrnsUz6ORYyRjZGjGkZvJDXFYALfsx1
         mFe21FHpwUJf9zQ/zqZ1lpzvaV6kOHCkywEdtiBxeKyU5wObISi/wZglF5rYzH1vR6HD
         owzhPlaoRgI9kRduwKZj7u0xIJqPfhoQdxA+3IjSUpDzhwCCHDSpgOt3caeVvf0pKAAP
         9FEbLxYsD0SUCQfIgQt0lFjONnJhpcPjArCANjPRO9tyJ2B2Rd2JxkBuzV1Lk6RcmHSZ
         cu0A==;
        darn=vger.kernel.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20251104; t=1787750797; x=1788355597; darn=vger.kernel.org;
        h=content-transfer-encoding:content-type:cc:to:subject:message-id
         :date:from:in-reply-to:references:mime-version:from:to:cc:subject
         :date:message-id:reply-to:content-type;
        bh=dXJfDFxsjd6n3nxiKwY8tVm+DTv8K0aaUVAVp01ZKj4=;
        b=f5VB0O21Nql8ySw+1SsT4k6WYugJHStg9aTUot/hSdc/dB15NxmjbX0+REenpjOe6I
         mA0woCQcfZQ1HJvH7WBkzd/0BPue3FPkK/6DvenVT9JjorUKsqfkP60UPXLOvZcQDqIs
         98cKeaa1MjjoIwimixGvaIrv6tpf4Sdxan6vXXSju8llSamOBz3gqSqHDD4m3hBTpq+X
         awMUMrtfFHqb8AKV9OlDBkZ1Txk7kzbvCayh+5w24FhY57DTLz7ec1h0docw6MDRlx3U
         PyA/CSieDTwB6wAQbYMXuzIFFcFahtvy+ZtNDMk1K8yt4MYhntskq3JGQ+fkEIoCDQQB
         Q7fw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1787750797; x=1788355597;
        h=content-transfer-encoding:content-type:cc:to:subject:message-id
         :date:from:in-reply-to:references:mime-version:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=dXJfDFxsjd6n3nxiKwY8tVm+DTv8K0aaUVAVp01ZKj4=;
        b=FAQPIbjDqI+/+jMy9WRyYI1WU3itTZfpbcfQ9vbUL/F01Cu29tZnojTcy5OAPKXrr5
         yV7QN6qLrkEix4DBmYh73Fn3oZgIDDpP5vagTzEoOJ8UPLGs1Qgj0bN/+zkrYtnggHpW
         uxKCLSqF8lC4Hobhs0s6AXtB73YYz/BaXMzsAvNvbGeebzfmM1/swI8aMEyMm0Ry6cO7
         4DsLtdmCS/HIK/ipoymqFphrUntp7+oqkAwmytOl8ezJmBCVobECmFGONpD4NatJkn0c
         i+xZvs99bbRcBv9zyVuJ1CD3q4f5X5/QMtBTA+WHM31YFWlisRW51Y2fUeYclB00jutf
         c+Mw==
X-Forwarded-Encrypted: i=1; AHgh+Roav3rjNYmbtIoWs//EN0dvnawIqogfCKWyHkpHS47zM8yuGbZx2WefcFiaxiGdQYjcmNJXORo=@vger.kernel.org
X-Gm-Message-State: AFuF++nkM8hxFk94VyYl+SlWzDAuJ7xxKMgyHfWmJ2e9PLS4Dw2Fw5lH
	A3v8cq7vlVCs7ENhzNGw6+amvNzETerDpyc41u4q7B8bypi51O0ww1CuPkMZc4DagY9c3eXbHs6
	H1eTV77Wdb4Sdhg3CZI3iSo9lwWfNeP92TUUOBeGz
X-Gm-Gg: AR+sD13lby97O2kHAD3jPpyEtf/KeDhfk0CsR4bPLfkQfupEluLWw51ufp1awJmyDxQ
	0CNMk/WAHOy34Ndm99p0vJ7nAes92MrRQlX2MOdQ9sssr5pnIYqwDP3gr35LHvPkOpC7YPNX2cX
	Sz9DDZki4oC1ufNmTfxob6Xkeyy7QvlvSkzdjwjCJyKgQc/LS3xRxghM2863DHE/15ss6uICuh+
	NkkvcAEeZAsuGgObajApbw6s9ir6dCoRwLW5L067TRQROgWRmTHD8fIGZv9h94M3+Tvs8xcis0m
	z6dNoqdHHk3aHaI8wVn/HBVI8n2RDiDZ/fWO7VL33gnyhdnrPQBuPOjjwf4Gvmo/AFCY0db/CIL
	7rc+S9OpBMfqpN4rCSh7sD70CctMGXlyIe0W7rAqtopQm0ngxTqIdl8vzmt3q5RUBqaLr/6yjgC
	gaaBfzVYmbONC6MA==
X-Received: by 2002:a05:6820:1a08:b0:6b1:3427:698b with SMTP id
 006d021491bc7-6b1a0496fa5mr6594994eaf.18.1787750795474; Wed, 26 Aug 2026
 06:26:35 -0700 (PDT)
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <6a88012e.dbb3a75c.13dd47.0007.GAE@google.com> <6a8d0f6c.dbb3a75c.7844.001d.GAE@google.com>
 <2026082540-tarantula-gigantic-b786@gregkh> <CANp29Y5YH=O35brw55HFo_hVmFDz5Y4Yw7buBc-rOjETU2DNjg@mail.gmail.com>
 <2026082507-ecosystem-giant-0b79@gregkh>
In-Reply-To: <2026082507-ecosystem-giant-0b79@gregkh>
From: Aleksandr Nogikh <nogikh@google.com>
Date: Wed, 26 Aug 2026 15:26:23 +0200
X-Gm-Features: AcwNN1Ukp9gqLT_Z82SDZ7L72P37HiiIWWLnUCjIe39LlRn1vZJuzZxoH2pucek
Message-ID: <CANp29Y5hnOWaqGw8BbPu1TCr00TbvNRciYvs_VCd6Jtk=8kSPg@mail.gmail.com>
Subject: Re: [syzbot] [usb?] general protection fault in wcove_typec_probe
To: Greg KH <gregkh@linuxfoundation.org>
Cc: syzbot <syzbot+1a01783ea233350598b5@syzkaller.appspotmail.com>, 
	heikki.krogerus@linux.intel.com, jeffinphilip14@gmail.com, 
	linux-kernel@vger.kernel.org, linux-usb@vger.kernel.org, 
	mika.westerberg@linux.intel.com, stable@vger.kernel.org, 
	syzkaller-bugs@googlegroups.com, syzkaller <syzkaller@googlegroups.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Tue, Aug 25, 2026 at 11:07=E2=80=AFAM Greg KH <gregkh@linuxfoundation.or=
g> wrote:
>
> On Tue, Aug 25, 2026 at 11:04:54AM +0200, Aleksandr Nogikh wrote:
> > Hi Greg,
> >
> > On Tue, Aug 25, 2026 at 7:12=E2=80=AFAM Greg KH <gregkh@linuxfoundation=
.org> wrote:
> > >
< .. >
> > >
> > > Please do not think that this is a valid path for syzbot to be
> > > fuzzing...
> > >
> >
> > Can you please elaborate on this?
> > Do you mean driver binding sysfs interface in general or something
> > more specific?
>
> That is the specific thing, don't have syzbot do random bind/unbind
> calls, having it attempt to bind any random driver to any random
> hardware device.  That's not how bind/unbind is supposed to work at all,
> it's for developers who "know what they are doing" and you get to keep
> the broken system if you mess it up.
>
> Same for unbind.
>
> This is a root-only api for that reason.

Thanks for clarifying!

Some context from the syzkaller side:
Restricting the fuzzer is always tricky, especially when the
problematic operation is just opening a file and writing to it.

We normally constrain openat to:
1) An allowlist of safe absolute paths (so it won't open /dev/mem,
etc.), blocking any other path starting with '/'.
2) Relative paths under CWD (so we can still fuzz normal file operations).

Here the problem is that one can mount sysfs under CWD, which leaves
syzkaller full access to everything inside it.

Tightening the access to /bind, /unbind, /driver_override sounds
reasonable, but trying to catch all workarounds purely in userspace
(e.g., creating symlinks to these paths before opening them) will
easily turn into a whack-a-mole.

Would you be open to adding some kernel config option or a boot
parameter to disable manual sysfs driver bind/unbind and
driver_override? We had a similar problem with writing to a block
device while a filesystem was being mounted, which was perfectly
solved by CONFIG_BLK_DEV_WRITE_MOUNTED.

Best regards,
Aleksandr

>
> thanks,
>
> greg k-h
