Received: from mail-qt1-f172.google.com (mail-qt1-f172.google.com [209.85.160.172])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7FE90372EE9
	for <stable@vger.kernel.org>; Tue, 21 Jul 2026 16:50:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=209.85.160.172
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1784652644; cv=pass; b=C7b/mvoM2qwxaYD9Xruf2dvPGQmVbTQeT8ASeO5qlj9X8+K/N9YJ9K66Sy58ZYLI6WY/e+lkJTSmZ2bM3IwFg7lbsMnKqjIloh8MMHRJOlmYRBmoaL+JS8TSkOTNJk/U0GWE+vej/Jz3s54DWgXPCy9yKIpOFa9o2M0Bjzov4kw=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1784652644; c=relaxed/simple;
	bh=AuCLXbnmVAW35+LtLmPlUTBFP8D6hGpqNitAaKjOF4M=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=Fei+6gpcruC0jSOsafpYRZ6uX3snPtbCZeivhyAIP4965brEn96MwFDl6JMTN5eoQ/8Fpf4T0HS6nTsC5vIEy8SDGoXOU6hFTJZLXa/FsW6wSpavz2mzmvnZRNX92ZOv61EWbUirFyZ/lkI/uoHtXZBtUHHLy5PnOD3/2IEbgwE=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=juliahub.com; spf=pass smtp.mailfrom=juliahub.com; dkim=pass (2048-bit key) header.d=juliahub.com header.i=@juliahub.com header.b=Pyx50YSN; arc=pass smtp.client-ip=209.85.160.172
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=juliahub.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=juliahub.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=juliahub.com header.i=@juliahub.com header.b="Pyx50YSN"
Received: by mail-qt1-f172.google.com with SMTP id d75a77b69052e-51c0ecfaee7so105820211cf.0
        for <stable@vger.kernel.org>; Tue, 21 Jul 2026 09:50:43 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1784652642; cv=none;
        d=google.com; s=arc-20260327;
        b=QUkhTttwXGBDbc19PnCa53TgTQ0RQHqLubvcEYYmaDFd6YmTpevofKhiMSmju4fYaR
         dvfkoegJ89+qpn8OmM4Z0GcXCXyyLNzyHh5+HMPZsZFL1DgQJ5ynIvB/6yT6mZ/geSB+
         OG34LGJVR5h2QvnoGuj9B3iOf1Qg82QzJbDiWMmj05HS6/W237OU9ISsNRapmTpLMTAd
         qY1lJKVAbAaLLCbwuowcUY3a7vyw35EoYpgrui94LNwHaYh7k5HQcsV7cOUJZJJoE1Fu
         cm4e6Utq15xSfz/B2vYa8zyT3IaodUTMYAZl7R+r7oDzRlt7AewMYKLbGxEgVExC3xr7
         9l3w==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20260327;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:dkim-signature;
        bh=LkvcdAd37rxmSltJGB4ylyw9Oi+TRYhv8GI7j6I99KA=;
        fh=9hgRuRKpoxzdbUOnlGoltZscPeDMMoqwOQ7odM/uRK0=;
        b=M1z5S5raQsEi0aCEYgb3vDLaHrlPpqVnAHAzCaqC8ERxHIOuWmWi7jvj4vlfojiVph
         Mnjwpnt/j/7cKUypphVpYNTtNivWJUFFFfZ4atpD/1wKN7IipPZiFosKnYaDpehKNWR2
         jROXO94htc7MOBdB8sUdIFk9Jj3wG2WS4qUKrVMAO2DEtiaXI/a+HXYS6ycBd0oRotc9
         JIpalJ5FOWtpEydRx4xBZZlQ070kIQmg8z2DbwOYGqC6aNlBB3TgpDi5iXqB4sL5yShk
         7zwREAQsKp20/S5jGzy5rarF834gDSDLEAaJZ5n1jnbYXQhhQToH+UPCDvzwN9a5Hji1
         70hQ==;
        darn=vger.kernel.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=juliahub.com; s=google; t=1784652642; x=1785257442; darn=vger.kernel.org;
        h=content-type:cc:to:subject:message-id:date:from:in-reply-to
         :references:mime-version:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=LkvcdAd37rxmSltJGB4ylyw9Oi+TRYhv8GI7j6I99KA=;
        b=Pyx50YSN9sdkmcXmjvW+rJdWBWYcNQPz2a+5ngBAAiGB7UIY10YdiR8X0WHlC692wB
         tKmqpnKwqobdwckDV9Hvv38PWNTHWHorCB3F6yz3dhCuuyMfydYnSV+n6fcMIcy+rk/F
         KXviBxOIYKeORL4z5A7VU1VB0za6Ic7RECMp1KDdKqgLTo2fh9AYrBVRogoWWFbyD54q
         Y2Iqlz0LZS4cgwGjj2VtMzGUmrVpBNc7a5xTHOcpnDj4oEvpxBg6SeLbRsbrZsNiKmKH
         /P+f+sOUmdyujN6kFqnkmlGZedJIokcIjfsnfETOc9vudHKq9twwInPmlOo79sVopY0J
         7PWw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1784652642; x=1785257442;
        h=content-type:cc:to:subject:message-id:date:from:in-reply-to
         :references:mime-version:x-gm-gg:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to:content-type;
        bh=LkvcdAd37rxmSltJGB4ylyw9Oi+TRYhv8GI7j6I99KA=;
        b=J1lU0luk+le818E1UKz+0MU/FDGmtYNoUXc7IoaEL/cI1pBDNVA+MDhfB9iTyX0A1F
         DJtJO8ykw4apMGEIDxZREj8PrjG+1MH2akeUdsTDlbrib/97nZVgiVof1zGlbtI8r16r
         RRosG8K+Uxe1PiFAOOEBNmUw8Fq/zqAUjv0/PpmcCR32/ZBiCLl0lxx0ZCpHsz8MtltC
         vGo2LC+N5OQ+l+cv0/D8AbVqYa3lKoRUEUUVvgKu4nI38udoq4uxmKlOQ3FTaP4mO6Fq
         KprmOreuysf8G43BhPsvvPJ4OMa4fMZlj48CblK2dXbOtepsCNsW5iJvf264PiY9uK2I
         nZrg==
X-Forwarded-Encrypted: i=1; AHgh+Rq8253OPhZe9ybM1q/HfRn6PFPibpA+oqy4Ul4Sr77jc3OiuiduY40qf1bBWELy51vWiiCPisc=@vger.kernel.org
X-Gm-Message-State: AOJu0YyWQPbpFbigptQL55bAztyDqKP36uV/ya0efsssyn4P+F3Z23UM
	xOajBKdH3/ZJGjL/PXGxSmE00DfQsNFgmjZyGK1+m+I0ul2xDQXFoR+F5ZWd42Q+nAhSBWDX77M
	YKLcUMZ5YXQKqwMQLy7qJps627yi51fIBmTn+giFekQ==
X-Gm-Gg: AfdE7ckrIKX2k8NHRNxIWgH+yLKBFFKOrEEeo0njXtXGueYMsGPO52MeQqIZsnA/Vwv
	GJW+dj/DPZehBUPWQZ68ksYhv2eAEnwVpBs6POI1kMLcoNbiH7p1mKd9PWtZ9Ig3kurya2qs6wb
	UrPORZddWgZlQNwxhTy3XfWYDuF+/o9H5IcqYTS6V3q5cM+OZNrFLqd7MpBbxC4gi5HK2pn27v4
	0a4G/hs7ToZq7NwAbuiOKUOGmKgX2gRrZ3DFZDT+a/YZzSPHur7Tn5GDViuhb/6H41PcW7hvi1a
	ghrP8NHrlJDPC7jWH1F7QUpNU7Zm
X-Received: by 2002:a05:622a:6082:b0:517:6550:2a0 with SMTP id
 d75a77b69052e-5213c200918mr175136981cf.19.1784652642327; Tue, 21 Jul 2026
 09:50:42 -0700 (PDT)
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <CABV8kRwvex1VvQ0eGwUQmJL_vA7AP2h64VpHqtXvfOXMvvJQZA@mail.gmail.com>
 <87bjc0led9.ffs@fw13>
In-Reply-To: <87bjc0led9.ffs@fw13>
From: Keno Fischer <keno@juliahub.com>
Date: Tue, 21 Jul 2026 12:50:05 -0400
X-Gm-Features: AUfX_mzR9bzwa54Kyd80XICsMHO7_PrXkvmwZMXh0uYpAchm8vdp_HzCYo6y45w
Message-ID: <CABV8kRwDhwa_OoQ9zx4sv3tDATZc0Yy-mYGObRXw59DO0cDfLw@mail.gmail.com>
Subject: Re: [PATCH] futex: Prevent robust futex exit race more
To: Thomas Gleixner <tglx@kernel.org>
Cc: Ingo Molnar <mingo@redhat.com>, 
	"Peter Zijlstra <peterz@infradead.org> Darren Hart" <dvhart@infradead.org>, Davidlohr Bueso <dave@stgolabs.net>, 
	=?UTF-8?Q?Andr=C3=A9_Almeida?= <andrealmeid@igalia.com>, 
	Yang Tao <yang.tao172@zte.com.cn>, Yi Wang <wang.yi59@zte.com.cn>, 
	Linux Kernel Mailing List <linux-kernel@vger.kernel.org>, stable@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"

On Tue, 21 Jul 2026 14:24:34 +0200, Thomas Gleixner <tglx@kernel.org> wrote:
> On Mon, Jul 20 2026 at 23:26, Keno Fischer wrote:
>> Fix this by augmenting the robust list exit processing to also
>> perform the extra wakeup if the futex word is owned by another
>> thread but FUTEX_WAITERS is *NOT* set.
>
> While your change "fixes" this particular problem, it leaves the related
> UAF problem unsolved.
>
> The more complete solution is:
>
>    https://lore.kernel.org/all/20260602084648.462672743@kernel.org/
>
> which is upstream now. Specifically the combined unlock/wake part
>
>    https://lore.kernel.org/all/20260602090535.670514505@kernel.org/
>
> ensures that your scenario can't happen and provides at the same time
> one part of the solution for the UAF exit race.

Yes, I'm aware of that patch series.
However, this is not quite the same race.
As the updated comment indicates, the combined unlock/wake prevents one
of the three race scenarios that causes problems.
However, if a *woken up* task dies before it can re-acquire the futex,
the kernel must still pass the baton down the line to the next task.
The existing code handled this case for the scenario where there was no
interfering third task (the second scenario in the original comment).
However, the possibility that a third task could perform an uncontested
acquire in the meantime was not accounted for.

>> This issues was discovered as part of a larger attempt to resolve the
>> long-standing issue that robust futexes are not safely usable across
>> pid namespaces.
>
> What's the actual problem with that?

I was planning to write it up with that patch series, but here's
the abbreviated version: Embedded databases (e.g. LMBD) use
shared-memory robust mutexes (glibc pthread_mutex in the LMDB case)
to coordinate access to the database file among users. However, if
those users are in different pid namespaces, the mutex silently fails
to provide mutual exclusion, causing corruption and hangs (bad for a
database). We (the Julia programming language project) found this
out when we added an LMDB-backed cache to our compiler. As it
turns out, a significant fraction of our users like to bind mount the
directory in question into their containers (because sharing the
caches makes things faster and they're using the containers for
consistency of environment not as a security boundary) or share
it among multiple different containers (AI sandboxes are a common
example). For now we're detecting this scenario and disabling the
cache, but it doesn't seem like a patently unreasonable use case
to me. Yes, perhaps it's a bit odd to have shared-memory communication
over what is supposed to be a an isolation boundary, but it is what users do
In actual practice.
