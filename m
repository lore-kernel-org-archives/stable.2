Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=74.125.82.53
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1793716298;
	b=E+N4aGJoGfdc3pJiCSf9EzzAV7/Iqlh2ac7Bto/rOw99VxOt9bYWaaT6X+hUgImg8yyd
	 BaoOuFS7uAtHPuVdip0cZZba5nnTJhbKtrObDscQJBy/MxSwJNvHEMN951ya9Z8QqedSf
	 hYV3fkKhGdThzcyxN0v9qaDiS4BlX5UPyJyWafTK7vz795sOObh3SfGJgv8vi605Xpa9b
	 oF9USOVLXPAA3mlJ+5xjs4YXCiSPl5etdi+K6tlhh3hR8Dz2Cj8h0PT2rqtkqk83ti9Ot
	 Nb7OQ12h7uBPE7POnIUR7Q+nQImhq0W8emFfTvzhocNtej67EsNDsMk0TTDz9iWuz7w==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1793716298;
	h=DMARC-Filter:Received:DKIM-Signature:X-Google-DKIM-Signature:
	 X-Forwarded-Encrypted:X-Gm-Message-State:X-Gm-Gg:X-Received:Received:
	 From:To:Cc:In-Reply-To:References:Subject:Message-Id:Date:
	 MIME-Version:Content-Type:Content-Transfer-Encoding:X-Mailer;
	bh=uYybwPb89QwCww+5dp+JltAH+UFg4/2qC8d9/J9llBk=;
	b=bDMLR6ZJeI+kFjwRICCRYwCUf6vBRfucgG9SVwhGrS0sbp12ZM9mA31Skdh5wvEApG2J
	 UTsZmlw4DY93DC8TilQNSBVBoMqYHf9Gy4yIkgnjgeti7iW8xu5j/FibKGonKPsfblNtY
	 T0Ea3H563Pm4dGh6GKoxZhWSlxxhgCLUkRXu6aMw+rvy1SZeayFNoSXIrSwc59UJBTf3B
	 1/WZnmVd+3DaPsIdQmBHi0AImgwc5hDrnYMUGSXCkX+CxArPRuhWW8ajQnXwQOkthHGv2
	 FVSKzoD8XTkFeHIzJwRMQ0NQCk0QJ/oxDYA2pYXLpQ88xBwotVsI5OgjULw03KSPARQ==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=none header.from=kernel.dk;
	spf=pass smtp.mailfrom=kernel.dk;
	dkim=pass header.d=kernel-dk.20260707.gappssmtp.com header.i=@kernel-dk.20260707.gappssmtp.com header.a=rsa-sha256 header.s=20260707 header.b="i35I/h3W";
	arc=none smtp.remote-ip=74.125.82.53
Received: from mail-dl1-f53.google.com (mail-dl1-f53.google.com [74.125.82.53])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 63B9660A2612
	for <stable@vger.kernel.org>; Tue,  3 Nov 2026 14:31:37 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 63B9660A2612
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=kernel.dk
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=kernel.dk
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=kernel-dk.20260707.gappssmtp.com header.i=@kernel-dk.20260707.gappssmtp.com header.a=rsa-sha256 header.s=20260707 header.b=i35I/h3W
Received: by mail-dl1-f53.google.com with SMTP id a92af1059eb24-1a2761c69fbso7219084c88.0
        for <stable@vger.kernel.org>; Tue, 03 Nov 2026 06:31:37 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=kernel-dk.20260707.gappssmtp.com; s=20260707; t=1793716296; x=1794321096; darn=vger.kernel.org;
        h=content-transfer-encoding:content-type:mime-version:date:message-id
         :subject:references:in-reply-to:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=uYybwPb89QwCww+5dp+JltAH+UFg4/2qC8d9/J9llBk=;
        b=i35I/h3WiGP2irRIUqEFG4dVkgKZgcLvGR0H2bNMnIVIYlsOme4aozuauP0CWGqGQp
         cwkPoU3bRlYX44WqrNEIZKi0IlxOqkfckXBzGct7OQJTUOpgFPIycvec28JNH/OeenHk
         zcSa5FL0oePvH1Gi/X+5+HFc4OXMtMceb06I9L4mqXsD3jJ/kb9aUpk5BOagZEWX3OcM
         i6ysa6Lv6HC7BBA2EILnCSzNq+eTkOZ924CqqFhwlX7gpmaLxWdo+9DM2xh2VrZsx/M8
         V4B6T90//w6YhlFAcxGRzbRoWNgfvjFAUhc1VGhgpxCklaVKUlLR3uLlbXBv2IO440ou
         AEJg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1793716296; x=1794321096;
        h=content-transfer-encoding:content-type:mime-version:date:message-id
         :subject:references:in-reply-to:cc:to:from:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=uYybwPb89QwCww+5dp+JltAH+UFg4/2qC8d9/J9llBk=;
        b=yZbMXlZX09HyXl69dIj+ZsdimHChjtzNPo7yISZyc3ZaRJLhCj7kYttDvWqVk/tYjR
         Qwnwyfe8UxFx8c9R6n2T3PcN7Su47iKATK94ME7nFLIzyKzT+2Wv67UWKHOxKFrjR+gO
         h9lYV0TnVLxjxxpWJ4K1f3YzyNnvFwGJjP/FFtCMGTo2lRijeRaGvJjorNQDL+dgikEf
         NUyAaEUkFBwSXD5Kb+9Rq1QNXD7kVE/L3FSXpP//43q2IRBY+NyIVaF0oSID/6V3r53Z
         rDw6b6FpoGldh7M22XYSBwZvOr5jEZp95YBsEFxiD54mWmQxu/waYqM43ebEsHqfBajI
         YsBw==
X-Forwarded-Encrypted: i=1; AKwUvBzcWyw1yEee/XYauCIEFxcx6/Y1VAZP7pbmMTHr8+RMFahPWODRNSdNmeQ1CWNFRF41ssFd+Ks=@vger.kernel.org
X-Gm-Message-State: APuU4Z8VU3R43LyTvTPwQvLh4j4+RmK1+1DCtIlsoXMn2e5Q7UjFMMHb
	JeH+1rwxRCsJ9WdekPjj3ftLX3qFTdN0U9FA97YWCGoL35Rd1Rqw37wm10Fyzlvdi8CVl8x5bhn
	J/g6YpB0=
X-Gm-Gg: AYBFou3vdPvhFioQSl1SF8bUzjyNntmprPf90vl8Gjg/vXFJJqLJyQgykWF1CKozdAB
	5EbgVy0F7EAmrpUAaApxACpCGLik213oKxiZOp3lEHMujBoWoB1tbq1LxM2EVv4bhymRiYB5P2M
	eYLcel0GqndogJwYGKF5EifGUxuN6MHxGNpSrebmeo6E8SZ9YW46r/XVAQWH8ZDHbCUT+0gWPxK
	eKzeH74k6gnKnS/V1ia03HcDwQX1wY2cYDQcdC/z8qhzDyokktS7jD10KvpfQCCuReFtFu5KzDv
	/FOgiQQk10gWU86cFJf4ycIxrx0lEns+/MhOfrDSEvwCVf4gLnrqxMP2qxx2pf2r9QAj6qxC0jJ
	eiQlBpQzkBThGQcryp4l56Ezk4QlaA4PCBhHvcV+0lsCFmmb87O2ekAAPxmy/bWdbS87jf5K8rN
	+u4LTMeA89U4cgFqLxjoBZ+GTfGdTgbqCB/mtaHK0lmhKnjWisOQiHw6KxIZkbzd/aCyvGwEID0
	NcesV087AKCgiw+66SqIAuX+v78obWJhcK/eUjdOLZUslINZEFqFvODTrR2PoQYccIJxux6nRqc
	lxH1nvyVkEEwQRV7DBzi53nQU5+WPfDZSgpuBOfTkoXyMkOemB79iJsHq1GAzzz77t4e3MkVTMz
	77S1VP7Umbkto
X-Received: by 2002:a05:7022:223:b0:144:f089:b189 with SMTP id a92af1059eb24-1ac5c369250mr26670869c88.36.1793716296265;
        Tue, 03 Nov 2026 06:31:36 -0800 (PST)
Received: from [192.168.1.106] ([198.8.77.135])
        by smtp.gmail.com with ESMTPSA id a92af1059eb24-1b23b847348sm9534779c88.4.2026.11.03.06.31.35
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 03 Nov 2026 06:31:35 -0800 (PST)
From: Jens Axboe <axboe@kernel.dk>
To: Shakeel Butt <shakeel.butt@linux.dev>
Cc: Meta kernel team <kernel-team@meta.com>, io-uring@vger.kernel.org, 
 linux-kernel@vger.kernel.org, stable@vger.kernel.org
In-Reply-To: <20261101022146.309201-1-shakeel.butt@linux.dev>
References: <20261101022146.309201-1-shakeel.butt@linux.dev>
Subject: Re: [PATCH] io_uring/sqpoll: do the return-to-userspace work in
 the SQPOLL thread
Message-Id: <179371629544.3691261.3795019117614680928.b4-ty@b4>
Date: Tue, 03 Nov 2026 07:31:35 -0700
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Post: <mailto:stable@vger.kernel.org>
List-Help: <mailto:stable+help@vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
List-Owner: <mailto:stable+owner@vger.kernel.org>
Precedence: list
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
X-Mailer: b4 0.15.2


On Sat, 31 Oct 2026 19:21:46 -0700, Shakeel Butt wrote:
> The SQPOLL thread never returns to userspace. io_sq_tw() runs its
> task_work, but the rest of resume_user_mode_work(), like memory.high
> reclaim and block cgroup throttling, only runs when the thread exits.
> So memory.high reclaim only happens inside a charge, with sqd->lock and
> ctx->uring_lock held, and not at all if the charges can't block.
> 
> This used to work. The loop called io_run_task_work(), which does this
> work since commit b5d3ae202fbf ("io_uring: handle TIF_NOTIFY_RESUME
> when checking for task_work"). Commit af5d68f8892f ("io_uring/sqpoll:
> manage task_work privately") replaced that call with io_sq_tw().
> 
> [...]

Applied, thanks!

[1/1] io_uring/sqpoll: do the return-to-userspace work in the SQPOLL thread
      commit: f013b695506491c5202a412a6568313549c81f50

Best regards,
-- 
Jens Axboe



