Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.remote-ip=209.85.167.45
ARC-Seal: i=2; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=fail;
	t=1793341057;
	b=mCtZRBT7AnfW3/tJmRLao4ykElYkL52WxTGvjIQGXxwq9LTOKiMWhAVIg5dmb8AD4VMf
	 g6zZf0bzpTt+w8oqQvwD0x6QNqCRfORKxZP/7ZzxhcNrQ/F4SkSKLrH0XHMpCcnMecHCZ
	 6ndfMjIB6aP6+rIfnUl+HJuvSMQTwgfQGrUPg6Ggdp9VK0HmwYafFESZCohFIDgFF4F4k
	 hJl/MGN514NEIk3QGA+ZZgoFV0eJKt3Lkr6M6fIddY6hGpSTcZVKmVCicmy3yQVjlilP3
	 HWgJ1rkWC4oOJ6dPP8nM2qkoT1mubET3jhBbXlm9WO/iuBnxPsA99txDNbq/1ICgi9g==
ARC-Message-Signature: i=2; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1793341057;
	h=DMARC-Filter:Received:DKIM-Signature:X-Google-DKIM-Signature:
	 X-Forwarded-Encrypted:X-Gm-Message-State:X-Gm-Gg:X-Received:
	 MIME-Version:References:In-Reply-To:From:Date:X-Gm-Features:
	 Message-ID:Subject:To:Cc:Content-Type:Content-Transfer-Encoding;
	bh=pZjUBS3kieBFv9QWkcVR3UoiF5JGMnsqA3e9Kn0z4Y0=;
	b=W5LnptHaL44eCVL71emF98br30y/ahIZPWOBfVvwjC4GhZtCzJFRwNorDmQtTm7Rm7fe
	 eVAZAT3aTjs0eRah/P+InPfCpQPFg1wsYyQ/a/VxIQXoBwU4x+GuOSa7yKd2FT4Z5ifBY
	 hR0HcON/gHW5tuF/ZJSfGbHJfyiT7I1sZc5dZzFxpW7G0yDcWoNpzI68nk8la2S+vKpOq
	 EgcPQKtHF0tIeLzgMdg+yQoZqOVXSOxLiu+VBgOhCmHTfMHwMDtHWkofMubi6JK+P4CgF
	 xKK3UPULv+a/VGrT9nLHAUPjqIzn9S2ZWOtRyYVqWh8EB3mEJAwz3OICyZa3tjnQj4Q==
ARC-Authentication-Results: i=2; smtp.subspace.kernel.org; 
	dmarc=pass header.from=gmail.com;
	spf=pass smtp.mailfrom=gmail.com;
	dkim=pass header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20260707 header.b=TD46FCwJ;
	arc=fail smtp.remote-ip=209.85.167.45
Received: from mail-lf1-f45.google.com (mail-lf1-f45.google.com [209.85.167.45])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E3CBA606A31C
	for <stable@vger.kernel.org>; Fri, 30 Oct 2026 06:17:36 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org E3CBA606A31C
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20260707 header.b=TD46FCwJ
Received: by mail-lf1-f45.google.com with SMTP id 2adb3069b0e04-5bfbc25a76aso1226826e87.0
        for <stable@vger.kernel.org>; Thu, 29 Oct 2026 23:17:36 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1793341055; cv=none;
        d=google.com; s=arc-20260327;
        b=C6E85lp+9i9tBBIsML4wX54ILvFc/Vbgmjnp21Rb4515QMAEpzkMbX5BU0/LOQQ1Ol
         RJBuF1drHve8Tu3zB/KiWD1cOaiuXegsy0I+ZWakw+zTe0QgPsedXd9sufsRxw9waPNa
         W5ZO88JjEhOZOPczQiSNDgT1xwFSVzDFJLXqmosi8GAPo0RRjsObpH9TwrotFVkxdQlJ
         GdeDkdzZMImDSh6/92JfOdbEE8A8n2SKHJPvi3xT8mAO5BbArFBH7eQxn9J+/fw2S4qQ
         urmotcRKSxOxiY18MoUfKGgmDOvU69at32UFacMqhmyNEDpfQB6B6+dHHr3CKktmn8gO
         RNqw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20260327;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:dkim-signature;
        bh=pZjUBS3kieBFv9QWkcVR3UoiF5JGMnsqA3e9Kn0z4Y0=;
        fh=wE3TdXttWtWqtEj1FFesOa6O/ThE1mFFz03FHCQo/rk=;
        b=Cq6/a01Y16Rd619Dz1S7TqjU8MmRc657CTSC4I1bAJ3aut3jy6XCJ57Pk0ZhmEv3in
         Vlyyl72xJwIQIiMSJAi5WqrtqKcJaCUktKOdRYjj3B4vZlf9m2/M2oZh/+gG26BsiW4O
         jQfCBF7LdpFW1wO1FUxcYuay8FOTn581XG45EkCRlRTe++LpLoW55NJzPAw8n+IEwn6u
         MfvUDG86eKEAgKWsB0/sqQPSxuY2UqmT9HWMg2UbYP/GiS+1FaK8sSX1ZhVTXsa9OFi4
         iD1ubSS9YbqEHx64NPt17b4nXPDII3Em2QjFhoN68pVLjUixakdpt52Zc21pBDmH23RP
         Q8hg==;
        darn=vger.kernel.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20260707; t=1793341055; x=1793945855; darn=vger.kernel.org;
        h=content-transfer-encoding:content-type:cc:to:subject:message-id
         :date:from:in-reply-to:references:mime-version:from:to:cc:subject
         :date:message-id:reply-to:content-type;
        bh=pZjUBS3kieBFv9QWkcVR3UoiF5JGMnsqA3e9Kn0z4Y0=;
        b=TD46FCwJ48PWQ++JTVjnTHURAxiVSCJVUehHuE5xZF26M7cKoXVZKRehFwYeITOdwz
         XW3ej+L9V4GZoykkibdU1/GXTkUX/HJ3T41e8rknb+HfFoTFrrFyPVWpMMx7xpl0zHkm
         bfiCInfyo8fKdXvKVetbn+SnYHHa+xLqivo4P90kOYmCWEqHQG6Ku4WDuCyUnQoyDiu4
         2Wm9Sj6u3m2gAnkNe7b4K9CVl6vnj4brEkrqg2Krrz9AuoaWsfQTRmM8e4S8XOtzNEvZ
         Z00krKv59jNC4kZIhX6kpdUIaIFsGcjMpkGjQZHmEnYsBbarWcqJkwSNY6wLPI+gf0E3
         DeHg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1793341055; x=1793945855;
        h=content-transfer-encoding:content-type:cc:to:subject:message-id
         :date:from:in-reply-to:references:mime-version:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=pZjUBS3kieBFv9QWkcVR3UoiF5JGMnsqA3e9Kn0z4Y0=;
        b=NR8A3tGpt5D7xOLPH5J4hZmgAg4s+EEwoLmtwkdaPcf2y2Rzemtj8s71LTVXIxa4i9
         ORpThfYlGbpKRhnuKwKTcYgVirRxGJ+YuYCm9buIzqd9JdylJTT+N8ioyFPK3XbcXMzS
         dCWn2LoZCNbnwwjpIro7MdcalUx+Fg6GJIx1SWyUd620xZ7PzMkvHD9M3vqXdK0nht5V
         fc9+hmvGY+ti0Qm77zW4znZuCyAeHAXUjlDRSfbF8ckxUSNUG6qTT6qkp4WoKBYov6US
         K+X/ODFFsnxtz1v7lWFcS3w0VYDohYpEJ/VK3x96uB/LI30wkStqU3oL7bPELmn32HtB
         vyIQ==
X-Forwarded-Encrypted: i=1; AKwUvBylfm7l8lcRSVU5/2J3N9zh5t4dDlAuNaeSprbx8jZlksc7JO/nthU303/JAdL9uB59v2HQ1pw=@vger.kernel.org
X-Gm-Message-State: AFq9FYIH2zKM2RF8ZHsntNWn0r3VLFFU6cn8ETPH8rODNL8kae0WvWed
	QGncpjYzyZa6Jo/YJBjbaULlxkoTcXw3HVOGAW3cLZtxL/tKgYz7BCZTIXAdOZGiha3XOhro3eL
	B6vZ82PVFJMpsNXAqg5WBCQiXj28mFZE=
X-Gm-Gg: AYBFou2E5zHKyshVlsOI/xRCDfiOqRy8AFpmC86rfTqFB+BonfzF5uR+PBkzzfgMWMJ
	8IHxb1yy2QUg69d5gA1nI5VmDcbtJSULLB4DWF96TQpp60/IvXZJe6TUOSnXdGiPlPLsDMUl2Jw
	ZHlKURwnu26TfBrcKXR8SQM0D2ui4+47wUjn8Qtad+vmHpJjkR5g8Y0dS5u3ny/ZIpdhpLaAl34
	jGktZFD8cW/VwrZrdfT//QF+euHa//gP/oflXCNUO5jVaKFsMnEPmVqP9uVN2O4Oav4uDjR6HuZ
	BL3D/ca9EVBJqplG05DIKs6WJ3zHqGVvTOPWy2waT5N/Qq/yDy3Kh+IToLWDZDAascgcBDd7XDY
	OzdhI+VPsuG/J9QzDQ48D9+Hy0rDFF+RMshNARVm8B+8IVScD8tIktUnBsN8tpHFmxJZ6j3lqIy
	Zu3hO2XLLPHpE0uIeW56nWjdagY5IWfC17AR3V/heK70bcUn9HT3g=
X-Received: by 2002:a05:6512:3d93:b0:5bf:ac46:c5d6 with SMTP id
 2adb3069b0e04-5bfd956d81cmr334864e87.12.1793341054873; Thu, 29 Oct 2026
 23:17:34 -0700 (PDT)
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Post: <mailto:stable@vger.kernel.org>
List-Help: <mailto:stable+help@vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
List-Owner: <mailto:stable+owner@vger.kernel.org>
Precedence: list
MIME-Version: 1.0
References: <20261029054200.97234-1-gyutae.opensource@navercorp.com> <9024faed-854d-411d-96c1-7cefd4d68dc6@redhat.com>
In-Reply-To: <9024faed-854d-411d-96c1-7cefd4d68dc6@redhat.com>
From: Jason Xing <kerneljasonxing@gmail.com>
Date: Fri, 30 Oct 2026 14:16:57 +0800
X-Gm-Features: AclHuK9fBg3EIjSbcv_z0WzBp7bKE-7jz6yFtnks3DmKKxBRExDPJTaJqejvlF0
Message-ID: <CAL+tcoAmq0WfSzo01xbAQ=g8OtE+GpJ5+RGs1G1SdNPdHx_eZg@mail.gmail.com>
Subject: Re: Backport request: Revert "softirq: Let ksoftirqd do its job" (d15121be7485)
To: Paolo Abeni <pabeni@redhat.com>
Cc: Gyutae Bae <gyutae.opensource@navercorp.com>, stable@vger.kernel.org, 
	Thomas Gleixner <tglx@kernel.org>, Eric Dumazet <edumazet@kernel.org>, Jakub Kicinski <kuba@kernel.org>, 
	Sebastian Andrzej Siewior <bigeasy@linutronix.de>, Peter Zijlstra <peterz@infradead.org>, 
	"Paul E. McKenney" <paulmck@kernel.org>, netdev@vger.kernel.org, linux-kernel@vger.kernel.org, 
	Minsu Jeon <minsu.jeon@navercorp.com>, Jonghyeon Kim <jong-hyeon.kim@navercorp.com>, 
	Siwan Kim <siwan.kim@navercorp.com>, Gyutae Bae <gyutae.bae@navercorp.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

Hi Paolo,

On Thu, Oct 29, 2026 at 4:33=E2=80=AFPM Paolo Abeni <pabeni@redhat.com> wro=
te:
>
> On 10/29/26 06:42, Gyutae Bae wrote:
> > Please backport the following upstream commit to 6.1.y and 5.15.y:
> >
> >    d15121be7485655129101f3960ae6add40204463
> >    Revert "softirq: Let ksoftirqd do its job"
> >
> > On a production 5.15 PREEMPT_NONE node, long-running overlayfs
> > getdents64() calls prevented ksoftirqd from running.  RPS IPIs
> > continued to arrive, but NET_RX processing on that CPU stalled for
> > up to about 3 seconds.  Over 15 days, the node logged about 1,000
> > bonding ARP monitor failovers, with no link-state changes recorded
> > during that period.  The failovers stopped after the workload was
> > removed.
> >
> > On a 5.15.27 PREEMPT_NONE test node, we used a livepatch to make
> > ksoftirqd_running() always return false.  This removes the same
> > softirq deferral checks as the revert on this build.  Under the same
> > load, we measured three 10-minute windows: before patching, with the
> > livepatch active, and after removing it.  The number of HTTP requests
> > taking more than 200 ms was 17, 0 and 11, respectively.  TCPTimeouts
> > increased by 25, 1 and 21.
> >
> > We verified with patch --dry-run that the revert applies cleanly
> > to v6.1.190 and v5.15.223.  Both already contain the related RCU
> > fix 1dd1eff161bd.  6.6.y and later already contain the revert.
> >
> > The original commit was intended to prevent user-task starvation
> > under a softirq flood.  The revert's changelog points to threaded
> > NAPI as an alternative, but it is disabled by default.
> >
> > The revert was merged in v6.5 without a Cc: stable tag.
> > Syzbot has also reported bisections to this revert [1].
> > Paolo, Thomas, Eric: I would appreciate your thoughts on whether
> > this revert is suitable for 6.1.y and 5.15.y.
> >
> > [1] https://lore.kernel.org/all/000000000000a249880603717c15@google.com=
/
> IMHO such change should not land to stable lightly. It's a behavioural
> change with subtle side effects. The threaded napi feature is disabled

Technically speaking, yes, it's actually not a bug but an optimization.

> by default for the same reason. Also the revert has some soft functional
> dependencies in napi threaded cleanup and improvements landed into v6.4,
> i.e. 6bb218b5a6e3f3c5e2e76faf8fc976f3f6f72496, likely more.

Maybe I have a slightly different thought on this: since I really
received/noticed there are not a few reports showing the 'issue' in
the older kernels. It's not easy for some people or company to upgrade
the stable kernel. I'm wondering if it's still possible to land it
with more careful consideration in the patch if Gyutae volunteers to
do so? Please feel free to reject the proposal :)

Thanks,
Jason
