Authentication-Results: smtp.subspace.kernel.org; arc=pass header.oldest-pass=0 smtp.remote-ip=209.85.167.50
ARC-Seal: i=2; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=pass;
	t=1793429910;
	b=t1WFYODblHgxV5qxuCcOR+dfy9eHaxA4wKoer8aDM1b0+TYP5xdw4Q5NYeyMvXroJdR3
	 IAVcRR4Pvz47EKY3hockd3iw+zvnPOoOrXlqc0kkoli2ibndnBm/BXFT9Hv1H0OMPJhae
	 scNXmItRc3mULRUibFrKZSu4ryoDo0rwb/Wp5mvSorCtFUFDDFeY4yBRtjrT7La+qGTmk
	 r7C4ffYnL4Bjk4tEMKhPvl+GP9Y9G1IffXqGcr2p01kygXXbVF4AyLKGscj4eV8pxroRk
	 GKgP3Yjy/t9wgdCDcSaUKm4uYJVpWwFLq7v80hyJj2n3Go16e2wXecGy2/0asZ41C/w==
ARC-Message-Signature: i=2; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1793429910;
	h=DMARC-Filter:Received:DKIM-Signature:X-Google-DKIM-Signature:
	 X-Forwarded-Encrypted:X-Gm-Message-State:X-Gm-Gg:X-Received:
	 MIME-Version:References:In-Reply-To:From:Date:X-Gm-Features:
	 Message-ID:Subject:To:Cc:Content-Type:Content-Transfer-Encoding;
	bh=z+ERvyGFXJrTUdts7nrzpMlW3VnG47UNvQJMV6QYWbo=;
	b=Mx/Q24J1iUbnabRl+HPDdPZvxZtARqd6GgVuD75NBb1KMjLDg1l6kkH7JHkNgwHpw8HT
	 Ytp5XpXFCHGDHgkKbhCYCAVhFsOqLjId4fCEZlfhTWNi/CzKs0W+QyYOn6CxCsCUJg2Be
	 MeB4H+4MgF6qUYmxUdrdgBQP3OggJfyHUoM7zciXXI70Y+4Vrrt5eWHOuixnuvYKj4Zi0
	 DMqm3GV2wE4Snufi/WxDx83e3NQyfDbP1NnuKLRBa71Jt9REB9ayzMwulKKB/YLuMz2Ga
	 pCkyI3YbfQpDw4amk7oJHjnZe/ocHC4Fc/8C2m6if+iMTnr4dbWxZwoJsje6h6Vp6oQ==
ARC-Authentication-Results: i=2; smtp.subspace.kernel.org; 
	dmarc=pass header.from=gmail.com;
	spf=pass smtp.mailfrom=gmail.com;
	dkim=pass header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20260707 header.b=NM90WPI8;
	arc=pass header.oldest-pass=0 smtp.remote-ip=209.85.167.50
Received: from mail-lf1-f50.google.com (mail-lf1-f50.google.com [209.85.167.50])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4F4E5606A31C
	for <stable@vger.kernel.org>; Sat, 31 Oct 2026 06:58:30 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 4F4E5606A31C
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20260707 header.b=NM90WPI8
Received: by mail-lf1-f50.google.com with SMTP id 2adb3069b0e04-5ba36cc21cdso2283364e87.1
        for <stable@vger.kernel.org>; Fri, 30 Oct 2026 23:58:30 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1793429908; cv=none;
        d=google.com; s=arc-20260327;
        b=s2TD7CnPDYTWor2R5NRwpdEuz4LQa8OaROV2V8Mf4HY11FtOFWnWjx/5UL42ra21bK
         8H+8FNYDypEpT4XVomWDvrVQ10E9dXJAaEP+lwcyDwSawaptG7K91sim42E+XuSdTIaw
         0w3yOMu7Vj6opfuTGdDz6E8vGhpZUTTMJj9tN9UeDZlQrPD/e+gxU9naYU/L6Zjg4Eqk
         7ou6UARdAgM6CxsCrzmoHSENrzc55/FpI6WxLXv2EKhLhrXoAChgR9E8Z4uMvkKhTxu8
         jvcI+rz0uDtBIeR4x46SjYzpEgIm2d67bq24uQu39VIIZB1cGnBqRxZ2xt1itHT8JG36
         pW3A==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20260327;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:dkim-signature;
        bh=z+ERvyGFXJrTUdts7nrzpMlW3VnG47UNvQJMV6QYWbo=;
        fh=QCA7RY42jZeyKdntvI3sndnHuOd71yiXt0KbbmokUtY=;
        b=chagsxLhbVA4nxOCiLdSEAeO7svHvaJUglMhTZi3vKyHf6GcssprifwTPYtTao/BMS
         pAXqSdim1Dov5NBydmdZ5PlvAdLVTmOfjfuOxZPJIH8XzakVWFbqyJWt3O0EXPaJSQHT
         1HwgJbQdDAUO56Y34TsjVZ5naEu3ORNn4zRnJa2qLWP3/1w0+MsDl3vCgOPufLX/CEI+
         FHQs6TI7LsmxP+Ut7tWYHmVTGw4XilKGlqibEwFfNGVK1PXl4AuDoGmXnUu3bj0DPrDX
         kdYGdQC1UQSjJtkJNB9v7EPf+e8jmXsTcspa9HXOFseXAKNzLBCiCA67nAcTYCWwsYyy
         6MMg==;
        darn=vger.kernel.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20260707; t=1793429908; x=1794034708; darn=vger.kernel.org;
        h=content-transfer-encoding:content-type:cc:to:subject:message-id
         :date:from:in-reply-to:references:mime-version:from:to:cc:subject
         :date:message-id:reply-to:content-type;
        bh=z+ERvyGFXJrTUdts7nrzpMlW3VnG47UNvQJMV6QYWbo=;
        b=NM90WPI8YAaCMCqbEkAT0Q+XVe2Ic6hF7MD9jz36BcAKlkd3tqG3RYwvZgK5w1kkOl
         ouAY4xgR8RAHJNda13HvjQzH1H4If9gNGS1KjZdqZIsS16QJa1nV+A6ZdxXiZ1gCTKhx
         MKjqhRePsj1yNeYOzokLrRpcSrO7DUHGM+BEWqWWN1kTpbmZVpEsx7wjt6/6j5jnGEtJ
         DLUT7WqHY4j5XC9UW3V4Y1ZjhwZInup+AMU0MqaIIpAa+3IZ6GGngfvA/i87YEpZnGB4
         wyJOLS3n9Zuy9QTpfw5y0YE5GWzhqt2c1O6m/alSiglj4V5v9U0Jl6uGX4SZLCtlmdKg
         xaDQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1793429908; x=1794034708;
        h=content-transfer-encoding:content-type:cc:to:subject:message-id
         :date:from:in-reply-to:references:mime-version:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=z+ERvyGFXJrTUdts7nrzpMlW3VnG47UNvQJMV6QYWbo=;
        b=CkdmJbACV98rD/3DWKRTm2oECRqaRoX5kdDlTVv6IFFg1DokmKv/T/0cE5M6NJHESo
         dtb9Xmxgb7EQC2N6rRiHkBYiTLeNeFDOaVoTG9XfAHWrGw+1DYV6GOB4fu7V1E7QM52h
         o2jfdRfvwbDcWXLEy1Iu6joYk2WnW/GoepYiQmdDg/2H7O3H7qlsxOsktHJ/z5qfDyVw
         zv7HMBhK2EfpQag2g/SKIuxi94MD3sSRFUioeDerkxpErkSRpaER9za7rJy1wDTXlSSQ
         SkCpQccTGHKbquSzy9PrfSBSQKGTRI2sLIhSz4tM+xcjykdk9M9GJly7i0r4/J7WD8VM
         P5Fg==
X-Forwarded-Encrypted: i=1; AKwUvBxMAHzcElA9KtDIeJ/xT/quxQh8IpEYHEFyqnraUTnaf2AULYg9ZU3nD9EMxR7/y4IGOgboV94=@vger.kernel.org
X-Gm-Message-State: AFq9FYIyC/0Qo9prdi2o83SmDg70MQZqgnv6tyX+4j7YHPEUjUGBiFsY
	6MhV/MDS7bM7GtVrMRQlqNiipDosWGfCIylEi15ltutNcQicaIH0QPvafL6gu5q5e53ldhRd8cZ
	mPD4MWhUIKa+cZFcUhWUZySRcDwGmXi4=
X-Gm-Gg: AYBFou37x6tm3bRjRDIhxD0ZFR22LaAXwuzjl/55rexArMwMijCmzmEPTktY7U6I4HT
	AZjqsj2VKdTdq2wb2O5TLnAoY8Qa3wY6t7Zble6XSryCgC8yscxOWYgMmbSlASirqF5d8+TNNqH
	Z3Qo6kO4uzm+4RZHFzDU4PSMMxeaVvjahq+dsNiO7PqVHc7NXn7cyQg0Q8mDOgB6NTfXE476En6
	WgaM8tkMBVdQjikPa6l6uwucndmDl2iIwHKMH7fFgYNAyPNDtxV+kYbv1fm9ekFJ2brGkERMcoB
	lswzXrMH8CZTw1pbKdhtb/+V3nuOzLdzOLgoE01uAMfFmfac2w2IH/FKstH8Ft+QcjpqxLOq+Bt
	Ig5de+u2WfdtSA9L0LiZ7H6TvqIEY7Zk0QWruo2V5xzOMqK1SyiVYjx3VmVoatLUToCkf2Qvt7r
	QNCpNGLXp5YnnjWF+H/ZvwCyihLTlBNcW3QFM1nlb1WeFJguMke7yLlA0WoMjMeNCnOEXWKmyLy
	MZD8Ffnjqc=
X-Received: by 2002:a05:6512:1087:b0:5be:4792:82ac with SMTP id
 2adb3069b0e04-5bfd956f142mr1539518e87.41.1793429908173; Fri, 30 Oct 2026
 23:58:28 -0700 (PDT)
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Post: <mailto:stable@vger.kernel.org>
List-Help: <mailto:stable+help@vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
List-Owner: <mailto:stable+owner@vger.kernel.org>
Precedence: list
MIME-Version: 1.0
References: <20261029054200.97234-1-gyutae.opensource@navercorp.com>
 <9024faed-854d-411d-96c1-7cefd4d68dc6@redhat.com> <CAL+tcoAmq0WfSzo01xbAQ=g8OtE+GpJ5+RGs1G1SdNPdHx_eZg@mail.gmail.com>
 <2026103018-gothic-sheath-5c34@gregkh>
In-Reply-To: <2026103018-gothic-sheath-5c34@gregkh>
From: Jason Xing <kerneljasonxing@gmail.com>
Date: Sat, 31 Oct 2026 14:57:50 +0800
X-Gm-Features: AclHuK_yKmoKPeylNNTwvOCcmLXjE5Vpfta5mEI4e24EAoe6XTOkLL75-ZO1HLk
Message-ID: <CAL+tcoASLs8jfPgs+OSbjy=aEJjor_wK2qPWnOvBAD1vuroT-g@mail.gmail.com>
Subject: Re: Backport request: Revert "softirq: Let ksoftirqd do its job" (d15121be7485)
To: Greg KH <gregkh@linuxfoundation.org>
Cc: Paolo Abeni <pabeni@redhat.com>, Gyutae Bae <gyutae.opensource@navercorp.com>, 
	stable@vger.kernel.org, Thomas Gleixner <tglx@kernel.org>, 
	Eric Dumazet <edumazet@kernel.org>, Jakub Kicinski <kuba@kernel.org>, 
	Sebastian Andrzej Siewior <bigeasy@linutronix.de>, Peter Zijlstra <peterz@infradead.org>, 
	"Paul E. McKenney" <paulmck@kernel.org>, netdev@vger.kernel.org, linux-kernel@vger.kernel.org, 
	Minsu Jeon <minsu.jeon@navercorp.com>, Jonghyeon Kim <jong-hyeon.kim@navercorp.com>, 
	Siwan Kim <siwan.kim@navercorp.com>, Gyutae Bae <gyutae.bae@navercorp.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Fri, Oct 30, 2026 at 10:15=E2=80=AFPM Greg KH <gregkh@linuxfoundation.or=
g> wrote:
>
> On Fri, Oct 30, 2026 at 02:16:57PM +0800, Jason Xing wrote:
> > Hi Paolo,
> >
> > On Thu, Oct 29, 2026 at 4:33=E2=80=AFPM Paolo Abeni <pabeni@redhat.com>=
 wrote:
> > >
> > > On 10/29/26 06:42, Gyutae Bae wrote:
> > > > Please backport the following upstream commit to 6.1.y and 5.15.y:
> > > >
> > > >    d15121be7485655129101f3960ae6add40204463
> > > >    Revert "softirq: Let ksoftirqd do its job"
> > > >
> > > > On a production 5.15 PREEMPT_NONE node, long-running overlayfs
> > > > getdents64() calls prevented ksoftirqd from running.  RPS IPIs
> > > > continued to arrive, but NET_RX processing on that CPU stalled for
> > > > up to about 3 seconds.  Over 15 days, the node logged about 1,000
> > > > bonding ARP monitor failovers, with no link-state changes recorded
> > > > during that period.  The failovers stopped after the workload was
> > > > removed.
> > > >
> > > > On a 5.15.27 PREEMPT_NONE test node, we used a livepatch to make
> > > > ksoftirqd_running() always return false.  This removes the same
> > > > softirq deferral checks as the revert on this build.  Under the sam=
e
> > > > load, we measured three 10-minute windows: before patching, with th=
e
> > > > livepatch active, and after removing it.  The number of HTTP reques=
ts
> > > > taking more than 200 ms was 17, 0 and 11, respectively.  TCPTimeout=
s
> > > > increased by 25, 1 and 21.
> > > >
> > > > We verified with patch --dry-run that the revert applies cleanly
> > > > to v6.1.190 and v5.15.223.  Both already contain the related RCU
> > > > fix 1dd1eff161bd.  6.6.y and later already contain the revert.
> > > >
> > > > The original commit was intended to prevent user-task starvation
> > > > under a softirq flood.  The revert's changelog points to threaded
> > > > NAPI as an alternative, but it is disabled by default.
> > > >
> > > > The revert was merged in v6.5 without a Cc: stable tag.
> > > > Syzbot has also reported bisections to this revert [1].
> > > > Paolo, Thomas, Eric: I would appreciate your thoughts on whether
> > > > this revert is suitable for 6.1.y and 5.15.y.
> > > >
> > > > [1] https://lore.kernel.org/all/000000000000a249880603717c15@google=
.com/
> > > IMHO such change should not land to stable lightly. It's a behavioura=
l
> > > change with subtle side effects. The threaded napi feature is disable=
d
> >
> > Technically speaking, yes, it's actually not a bug but an optimization.
> >
> > > by default for the same reason. Also the revert has some soft functio=
nal
> > > dependencies in napi threaded cleanup and improvements landed into v6=
.4,
> > > i.e. 6bb218b5a6e3f3c5e2e76faf8fc976f3f6f72496, likely more.
> >
> > Maybe I have a slightly different thought on this: since I really
> > received/noticed there are not a few reports showing the 'issue' in
> > the older kernels. It's not easy for some people or company to upgrade
> > the stable kernel. I'm wondering if it's still possible to land it
> > with more careful consideration in the patch if Gyutae volunteers to
> > do so? Please feel free to reject the proposal :)
>
> Given that 5.15.y is about to go end-of-life in a month, that's a
> non-starter.
>
> For 6.1.y, you better be planning how to move off of that _now_ given
> that you only have 1 more year before that is gone.  Anyone hitting this
> issue should be moving now as that gives you an incentive to do so :)

Right, it makes sense to some extent.

Thanks,
Jason
