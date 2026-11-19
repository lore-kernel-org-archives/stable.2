Authentication-Results: smtp.subspace.kernel.org; arc=pass header.oldest-pass=0 smtp.remote-ip=209.85.128.173
ARC-Seal: i=2; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=pass;
	t=1795054011;
	b=QLCDkuUr35yVbopkAg9fskTcm+Qf2qH+A4027AyWTF/J5NsAaQQiu6I5FufAST07QW2f
	 EtcJCnJ7Xjwaxmxr1AW9XLdA1Za3wQAp8YjU5PLBr57e4YzbLQHvOUbH5Qj5UAyXtluG4
	 p8hXpAe+NSqc3ae6HBXjXhpzawSEBPAgoH/HaSlSy4W9L4SuP41+6rbE2lHIlHouMA1Xi
	 qta7udlQCcm2I+pl/EmuEoegp7/Y6Qa/35zELHBobDs/yCEjlt8+F6AhIw/Tx6iv8NkBw
	 PcgwudH75a/1rURxA/pa7nzDi/zBRYyegMUTCSILW3dtw65F4NVngaGU57gzAZzQhIQ==
ARC-Message-Signature: i=2; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1795054011;
	h=DMARC-Filter:Received:DKIM-Signature:X-Google-DKIM-Signature:
	 X-Forwarded-Encrypted:X-Gm-Message-State:X-Gm-Gg:X-Received:
	 MIME-Version:References:In-Reply-To:From:Date:X-Gm-Features:
	 Message-ID:Subject:To:Cc:Content-Type:Content-Transfer-Encoding;
	bh=NCO/dWkf50AZTb5CSt4Ge8e/B88cMhBm74UQ+F1PYOU=;
	b=myM0Js+ATKYW5fAKcam87BIWvdxCpg/auh2pSPK0xTG6Je/Lvjbf2DDbmvGsz43c4vPK
	 4iQo3Tc/X6lnxTlMiuCi4u0TbXAZpOF8TDb2QEspfv3sT6oCcwyBp71NKvAYl3M2ejVlS
	 6Jw1bjCSRjta6lqZKPTz9glgXd2pWVE8yxoccfXya3zeBKSBC25gv5EKFrFk/5L8dcyJl
	 kgkX0VOOhQTgsAT37o2u7UvDif8TeGzILanTRaJ5JruryMmbawrmDvMBOE8ZeYbHlNyYH
	 g467HZRkhNsE85MuZFLt8jPrJfCyDK7DaJqWUFllb99u0gmWemG6YVCzyEGzq+hCPiw==
ARC-Authentication-Results: i=2; smtp.subspace.kernel.org; 
	dmarc=pass header.from=gmail.com;
	spf=pass smtp.mailfrom=gmail.com;
	dkim=pass header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20260707 header.b=MUQcBVty;
	arc=pass header.oldest-pass=0 smtp.remote-ip=209.85.128.173
Received: from mail-yw1-f173.google.com (mail-yw1-f173.google.com [209.85.128.173])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 77877606A32F
	for <stable@vger.kernel.org>; Thu, 19 Nov 2026 02:06:51 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 77877606A32F
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20260707 header.b=MUQcBVty
Received: by mail-yw1-f173.google.com with SMTP id 00721157ae682-8b4c685c751so14418517b3.1
        for <stable@vger.kernel.org>; Wed, 18 Nov 2026 18:06:51 -0800 (PST)
ARC-Seal: i=1; a=rsa-sha256; t=1795054010; cv=none;
        d=google.com; s=arc-20260327;
        b=JL2NxC2YZSJ8D4nc6XEN84oZQbLQNmFwOyyCJ/7TKtx55MiwjQKFvYhcRPRqjHdFrc
         yFOUiCrPossVBWL1SzlrA0FcCoRG/MRUf5b85awk9bkk+a5zRukqcP3bpN3jK/OaZ0JY
         LPhganwz/DZ7TLABDpwEyImSOhER3zpXpZ9ZxIcfLFo1HTquLhoA1+aoBNDryFo8PHmL
         +57s9XRDgkaHG541JYIaeq02Ssm9kFP7HLkLfyQ5dEl76WjA62NdktsPAqVcDs6hN08C
         AcBCDdaQi4AIOylfY/xYjlRbosVKgEkGgSCEZlVipfZvauVgAkkXFw3Wie9TN/2x/x4P
         OQ1w==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20260327;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:dkim-signature;
        bh=NCO/dWkf50AZTb5CSt4Ge8e/B88cMhBm74UQ+F1PYOU=;
        fh=EgycTg2vkHF5Fk4cQ+or4/aS2ZFy7K+MWNdqVdnTwGY=;
        b=kub5KX+yo9Nc3uI/yzhD03Sff5Y6+fwQSfHVJdFAsf3eFE7Fgzse2w9TGuLLXYuKOU
         7l+ni/gmFjiuS7g7T1k1KvNQvQCa1X4k/v57ILNP2w/BTGX/lA8bmolTAUd0wbw0ufvU
         L+7NQxNBGLZTwXvVNybFqhWLs1Jr2CNJ1CK5CyAQbdVHnGcGKI5/YpnGylqYq5hep/lC
         TFYywUOEbb6qVTdsNIucojjGYdqt343B0CHCrFJ4orgkFqoHrCS+LkMBQz2/P3xoQwF3
         W15i+OqTLA4CLErBqAczOGqGVtPr9rP23/k1KT8mwqWWvyAMelgBmpQ6QGqG9o4PhvJx
         kVng==;
        darn=vger.kernel.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20260707; t=1795054010; x=1795658810; darn=vger.kernel.org;
        h=content-transfer-encoding:content-type:cc:to:subject:message-id
         :date:from:in-reply-to:references:mime-version:from:to:cc:subject
         :date:message-id:reply-to:content-type;
        bh=NCO/dWkf50AZTb5CSt4Ge8e/B88cMhBm74UQ+F1PYOU=;
        b=MUQcBVtyUzJRoojUTrNjL9onWir2Px+mfjnx9u5ppxEgtV3YoVXn2MzDdacL8r9Jff
         gqPF/5wAbOw/Y9EW7iRyd/xtMQFgTzjZGeR7ifufm0KHL6WQJFiIEfa4XiS/bUqciqv2
         mVci2TRWXo9JiyXyM4bgGC8FxtoJzIO9pYrk847STndlMI/6jzVh4whOq4NtJGgmX8Pp
         JrIU+OPASOJ6UmNioXJ82x5XY7vfGhrdXXJK9lbMMeEHUGL/urUB/zoDq0wYlxmsPJy2
         iC99SGdpcwrI7F/G2RalchDIbKl4Nz7QKMJNw79WFNyyXSw/z1IpwWLNI17yeKfWdvlZ
         urJg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1795054010; x=1795658810;
        h=content-transfer-encoding:content-type:cc:to:subject:message-id
         :date:from:in-reply-to:references:mime-version:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=NCO/dWkf50AZTb5CSt4Ge8e/B88cMhBm74UQ+F1PYOU=;
        b=wgIkLJUXpAgGTl9Wx4LQT99qruK/k5Rn5xrAOuVMZY3vd0A9hOg1mqIOxihSO9yCVQ
         ZZX24kBFM/jO5t62TgxxhBse4QvX0mtLS5HlC8ojdCH/g+EQArg39fhiIg5F5znTs2Se
         zOQyR5naa+9i6I2azhbn2wvkKhI3g9WSLoavXol1JhmEHes01MzPs42MMFq3IcBJnYgq
         dck0ZFg5JHIn7eFLz5BqVdqXI09U0MP6zZ6KCpLSAPEtH3GQ4Wur6WTZ9TeB5LgknHCH
         MTCqSWsefZMDYNhfrHHjgPMgcQIRl7gRCNeqJr/vj5Is0uNN9Xscv4e55rrNpdpGUHt7
         23mg==
X-Forwarded-Encrypted: i=1; AL+hErFJt9ebqBCtvD5aroIGLD5x4NY4XxIljDQ/RNK9Wgcp6z+EEBcoEQz3RTe4gePIaJ3uxvo+uQo=@vger.kernel.org
X-Gm-Message-State: APuU4Z/RRMJu71zVzwpVY1OCNFoPsZGyZRFryzd9DusOHtuXV2+vP+sI
	m59YzrlTWrOlTkHd8Z8fc/RHhcMEGEG8g9VLs6BlUIskimRBwBbQOvUw50YaGd1PL4NAuTCj000
	fzKYDY3c69u40S8kPn9c3EED6njCOTpQ=
X-Gm-Gg: AZFdTZdti/Ewt7VpQsb8J2M1zeXwUkdt4hkoEuqCHzFiGreIDTfNOc3RXsMJQ0LeSPQ
	a/0szwtp5t4NIjq4k9j/7CB2/Jz+XroX81fIRo0DxAynM0j8xImJUNerQ0RV+pNRdUAXNAoCEHb
	qzE98dQTilXZRbUZPm0VtqB/P5wFU7km38m+mvoaYlq4b9fLyj3YTAEaSJ97YCXOUQ+QF+CViof
	oTH0rnLGalrFT3hQJmTKUB8JMoI/W3dv9MVR27PqMVWQgDY2nsvj9MAza2cHBKS0zOoRhcpwml2
	kiLxmB623vB2WJxKrlLSvqTxujZRyyThCBdqOQH84bEMrWV5TMFMkEVs+Q84xRURB9QIY0mmcA4
	cdbIc4WcR19I0PzJpynR0t7JZhBi3lIPBwrd5dAiv0HbQhkWvJKWPrDotboY=
X-Received: by 2002:a05:690c:799:b0:8b4:ef8d:88a9 with SMTP id
 00721157ae682-8b4febd6644mr15765197b3.12.1795054010454; Wed, 18 Nov 2026
 18:06:50 -0800 (PST)
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Post: <mailto:stable@vger.kernel.org>
List-Help: <mailto:stable+help@vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
List-Owner: <mailto:stable+owner@vger.kernel.org>
Precedence: list
MIME-Version: 1.0
References: <20261101073700.1261966-1-gye976@gmail.com> <179490829262.50223.600134266125251477.b4-ty@b4>
In-Reply-To: <179490829262.50223.600134266125251477.b4-ty@b4>
From: Gyeyoung Baek <gye976@gmail.com>
Date: Thu, 19 Nov 2026 11:06:39 +0900
X-Gm-Features: AclHuK95wjyOSL3USWJSLiddXMHlAMqUxucxyJ8PocUeHdqhrsCSx-8gPf2yb_w
Message-ID: <CAKbEzntg_+A6rERcgBmYNwDEz0_Ta6F_N8YGQP1uH1ETNgYiUg@mail.gmail.com>
Subject: Re: [PATCH v2] accel/rocket: Fix drm_mm UAF on close vs in-flight job
To: Tomeu Vizoso <tomeu@tomeuvizoso.net>
Cc: Oded Gabbay <ogabbay@kernel.org>, 
	"dri-devel@lists.freedesktop.org" <dri-devel@lists.freedesktop.org>, LKML <linux-kernel@vger.kernel.org>, 
	stable@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

Thanks!
(Re-adding the lists)

On Tue, Nov 17, 2026 at 10:05=E2=80=AFPM Tomeu Vizoso <tomeu@tomeuvizoso.ne=
t> wrote:
>
>
> On Sun, 01 Nov 2026 16:37:00 +0900, Gyeyoung Baek wrote:
> > The drm_mm and its mutex live in rocket_file_priv, which
> > rocket_postclose() frees on fd close.  But a BO held by an
> > in-flight job is only freed after close, from the drm_sched
> > free_job worker, and its destructor then accesses the already
> > freed drm_mm and mutex.
> >
> >   BUG: KASAN: slab-use-after-free in __mutex_trylock_common+0x90/0x1e8
> >   Workqueue: <NPU>.npu drm_sched_free_job_work [gpu_sched]
> >   Call trace:
> >     __mutex_lock
> >     rocket_gem_bo_free
> >     rocket_job_cleanup
> >     rocket_job_free
> >     drm_sched_free_job_work [gpu_sched]
> >
> > [...]
>
> Applied, thanks!
>
> [1/1] accel/rocket: Fix drm_mm UAF on close vs in-flight job
>       commit: c3fe8795ecd844d0bf76102217bec01cce01b715
>
> Best regards,
> --
> Tomeu Vizoso <tomeu@tomeuvizoso.net>



--
Thanks,
Gyeyoung
