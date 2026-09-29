Received: from mail-qk2-f39.google.com (mail-qk2-f39.google.com [74.125.230.231])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9A76A551997
	for <stable@vger.kernel.org>; Tue, 29 Sep 2026 18:43:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=74.125.230.231
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1790707429; cv=pass; b=RX8kTiAZB9zZEuesGbf6smxuj0SgPGh3qQsbOHjJkThF/AbEUDRTzfdEFbRqdtfSQHv6lIDhg/Ze4Ik52RRqG6rU/DAz5Tb6e/GMf9pZ/pY4kqzD7K44xMQyb7MV0meu3JKqLFS/4eKOGk+CTUkCYDbDMtUAgWHzX7B6R+EsKQQ=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1790707429; c=relaxed/simple;
	bh=kUVIdjgru6UCDpJhTGa7usyO5wvxDzwVO0NEapvsU6g=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=JbPqyi67PRbdseaEnUt4BguPu/V19yBWBBOzRTzTlNQnze3YzvSRksRUAsl87pTvJ7gznL9cQ3zkEhf5ecDasessQVPM/wnq4OUuSBGBGzKb1/8kzvVSOm4UI81rsoNfu/WF5lqy9d7l2GALD7dDDOpx2pA/OrHEQUSuu6jD7gM=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=juliahub.com; spf=pass smtp.mailfrom=juliahub.com; dkim=pass (2048-bit key) header.d=juliahub.com header.i=@juliahub.com header.b=OdUPUFE0; arc=pass smtp.client-ip=74.125.230.231
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=juliahub.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=juliahub.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=juliahub.com header.i=@juliahub.com header.b="OdUPUFE0"
Received: by mail-qk2-f39.google.com with SMTP id af79cd13be357-93c64c01c86so174351085a.1
        for <stable@vger.kernel.org>; Tue, 29 Sep 2026 11:43:48 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1790707427; cv=none;
        d=google.com; s=arc-20260327;
        b=Q/+kwN+mmZEbhYBOfPwvLvrANklAFPLif1Fas1IndMZb6jDZ7uCh/el3TC4f3D1drX
         0NL3U8SL3t5+zlisqWW086yot4Fg2Ip0RXbyZg2Oe2iaL8squL9J8CcKRnjkSrwRqMOV
         pNmi59qSQ0RHt/bDUuUoYLeKFJWDeTrwj+3CXFJwAI/6vBi8/dX8Ulq41igiImOX9Gfe
         qtGRtMPJdEl1MCTutWNi4rMBX4BUGqo/6RnSKJzbsqPkWAmrzohInp0aLAdxl4H6yA68
         Q5D0SYKJjUmS9YjUI0hp4RSF6k0lNzbvWrib7inus+s+XyU9dOGWZrZcMHDd1/0JZAU0
         bUhg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20260327;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:dkim-signature;
        bh=kUVIdjgru6UCDpJhTGa7usyO5wvxDzwVO0NEapvsU6g=;
        fh=+1afc72l8Ns8NZpX7hMC+L42yYIMifPYHepzzja/tNk=;
        b=Btrci2XDQwdeRsqXwsIEGiVXvHFwfd+9irTnnBfpAXRWGKRIYdJy4RpRemJZHQbUBa
         6f75ntlIGV31r/JvQskufVvhmeZ290ct1vKa+DaRdvQGLAW7iPuCGtTFwtJW3XJc+4ac
         qXP0ki8FvG+hhip+tftAA5xzp45uswxlkFDBF9A4jEG8D/eUNX3n49Dq+Zp2CE3LifXo
         k2N7viVF7aiPxbyMtHbQJhK/a0EP1zspX0Q2e+avBhTt9ub/MlX8KAZ1JtQHLlVyiY5U
         X5LnFTZr6+LFypxPyw4WbNttL0sQyN9p/t5kiV7SuO7zdm51BAyMKXgRljjJyAQ12Jvy
         Rhlg==;
        darn=vger.kernel.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=juliahub.com; s=google; t=1790707427; x=1791312227; darn=vger.kernel.org;
        h=content-transfer-encoding:content-type:cc:to:subject:message-id
         :date:from:in-reply-to:references:mime-version:from:to:cc:subject
         :date:message-id:reply-to:content-type;
        bh=kUVIdjgru6UCDpJhTGa7usyO5wvxDzwVO0NEapvsU6g=;
        b=OdUPUFE0H431saD30uHNe3HvLT3vYvkGnoMLspKiulsmvpbk9mnBHU223LcuPmM+kC
         SAsHDJuUnJujbLyRIN217utEl4lNr9iIfcxpK6xyDtMl+KP5Ap50ZwMnzuA9uv3ImSS2
         xds4fh70ks7/mGsqgoxDOOkwA4Z6gHz4K3Kper/CuBVpKcy4/7F2lYb9iP2iBjlow9hg
         K1LzYccoUkSmikaMPy/QiQ9NO9J2hAj4mvq5g3UsHKQG2W2TQFJhMOtaiJnH0H/5ckBr
         A1FMa+QFJ5Ap+2ioi+fUq1YOGKxeKkxDt13VtFi+OtSLXT2hV2sRYhbNZjO515MQFhju
         AsaQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1790707427; x=1791312227;
        h=content-transfer-encoding:content-type:cc:to:subject:message-id
         :date:from:in-reply-to:references:mime-version:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=kUVIdjgru6UCDpJhTGa7usyO5wvxDzwVO0NEapvsU6g=;
        b=sXhCmC63VQK3K4SGVL6UvEsJt6+W60pExj4tDx24IL73zwg4CMZxwNGbLFWb0elY0+
         bHYRGxJF2i6SYo/jXOKPrCeEvt8c1USeDhq4D7MJ/TwSK8kl1zAb/RJBujDLnDkGBOl5
         nOSJR9wTD7fo8ZxEq7nUw2UFrt/GRJ1Vypt7Tirx4RisZr6i1avAiBkyndFG+ILh0j/B
         GVk3YK+HgTOpsuh0i/KLG5V6LgYb0/5PBX3n/Ao7VGGDF/RzWL08wQwMi8NokTi6YUTM
         KX/YX2lQusSys91y4DSB65new+neTF134E9idgeEuQnMMb4u9hy88SODPdfl053DxVf7
         lnGA==
X-Forwarded-Encrypted: i=1; AKwUvByNUAiV3itrBlMc5SLKTMKa0oti42Tjp7fd2KM+iPSdIqGLpV0kZEVbt6aKbwd8s41GDG/ScoA=@vger.kernel.org
X-Gm-Message-State: AFuF++kIKUXwJrdkuzMsT84WDbGAnbmnINKhPWyKgn6nlS0gYJtFi7Y4
	btIDSJi6SbuvCLM7/6+sU54qRSMxEqKH9QwUnshR5CSWouf/Jipf19cOqyR2CI7/1bKj7xh3s1D
	H0uOMcSUTN2ZwY1SljjUm//BitMQxIbwn2lgh9CGkiQ==
X-Gm-Gg: AYBFou3jU9dmFIxKxmgl6YJuQaYoeqiY+rNmpj2KOtBRoyISEFDwDNAsD3ZFfIeW+Mx
	iW4ejgbxiIsJE4CSc/N4jXDrx8JWkNkvrsw66ef0amUoD0oDpribCX2x1mIskSqpRH61qijKE5P
	rzckQeiSkBFQGA3FW8TFzhu71GaahbcRfMJ5FqLHFvoohTqUdStVAz4uvaLHN4ygtbzqLgc0MYQ
	uwkPIolx+XINpuqgmgasQAt/b5YKh3y15bWCKfKkSKK3q3zJygiBHjXEFEXnPjZiLlXSyIuhfwZ
	xY+jPl9tkh+NadY/5YqcRe/0gTS7bSQ3N0tKiRJ8kxDGMNEgRWSTRC9zeaWlGP9h9RyutqqBWGg
	MbJLAtf4RhLad3gkHT0QWFmwxOc+FYlp+ks6Oo2B0pRU1lIYYbKpRq9U=
X-Received: by 2002:a05:620a:361d:b0:93c:90f:b535 with SMTP id
 af79cd13be357-93c9f98ed93mr71424485a.4.1790707427346; Tue, 29 Sep 2026
 11:43:47 -0700 (PDT)
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <CABV8kRwvex1VvQ0eGwUQmJL_vA7AP2h64VpHqtXvfOXMvvJQZA@mail.gmail.com>
 <87bjc0led9.ffs@fw13> <CABV8kRwDhwa_OoQ9zx4sv3tDATZc0Yy-mYGObRXw59DO0cDfLw@mail.gmail.com>
 <87v7a7jeav.ffs@fw13> <CABV8kRz5c4opGVA3CPdALWxjUH_DkLf_tBLdefajsSevfHFYpQ@mail.gmail.com>
 <87zezdiiyg.ffs@fw13> <CABV8kRz1nLxUDAgCSKHB2oqME74M6PyxB-t+u1it=6eYo5cFAQ@mail.gmail.com>
 <87ldawinki.ffs@fw13> <CABV8kRw92-0sx6Mi=z5pzCA9gEE9nnBbTjwKHzEr35DpSk6keg@mail.gmail.com>
 <87o6fqhpcw.ffs@fw13> <87fr10faqi.ffs@fw13> <87cxw4f7jh.ffs@fw13>
 <CABV8kRws040xRZqsLdDJNaHs-3Ax063uQnqTR-1mMMmkaCq3ow@mail.gmail.com>
 <87a4r7fnl8.ffs@fw13> <877bmbf8kp.ffs@fw13>
In-Reply-To: <877bmbf8kp.ffs@fw13>
From: Keno Fischer <keno@juliahub.com>
Date: Tue, 29 Sep 2026 14:43:10 -0400
X-Gm-Features: AclHuK8X2NNf1YOtLa_rf0CsjHFHtehvfMchFZ2pGuoGH3kVhAPKrr8BC1QIO0U
Message-ID: <CABV8kRxDSbUwLTiNxauakM6HEOHqhaybFnHEkC6iFOVtWHfhVA@mail.gmail.com>
Subject: Re: [PATCH] futex: Make FUTEX_WAITERS state consistent for robust
 futex unlock
To: Thomas Gleixner <tglx@kernel.org>
Cc: Ingo Molnar <mingo@redhat.com>, Peter Zijlstra <peterz@infradead.org>, 
	Darren Hart <dvhart@infradead.org>, Davidlohr Bueso <dave@stgolabs.net>, 
	=?UTF-8?Q?Andr=C3=A9_Almeida?= <andrealmeid@igalia.com>, 
	Yang Tao <yang.tao172@zte.com.cn>, Yi Wang <wang.yi59@zte.com.cn>, 
	Linux Kernel Mailing List <linux-kernel@vger.kernel.org>, stable@vger.kernel.org, 
	Florian Weimer <fweimer@redhat.com>, Oleg Nesterov <oleg@redhat.com>, 
	Christian Brauner <brauner@kernel.org>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Fri, Jul 31, 2026 at 12:05=E2=80=AFPM Thomas Gleixner <tglx@kernel.org> =
wrote:
> I'll post the lot later.

Was there an updated version of this patch?
If we still want to do this, I think it would be good to
get it in sooner rather than later so userspace can adopt
the new ABI alongside the new robust unlock path.
My apologies if there is a v2 and I missed it.
