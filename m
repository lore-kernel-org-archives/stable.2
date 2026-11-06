Authentication-Results: smtp.subspace.kernel.org; arc=pass header.oldest-pass=0 smtp.remote-ip=209.85.208.47
ARC-Seal: i=2; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=pass;
	t=1794003685;
	b=3Yugk6QaYPLF3N/51LOTk+E9A77XU0i711Fb9CXx0qHNatjFKiLxyJfVIWO8QwtGvn3T
	 ZXYp9I0jArxDF49qwXPArX4m9Q1ai0k5bXH+o1vu+zkyWJ1BMh+R9Z/zT7fVpSeP8rKAR
	 nZDh8iED2r1h4lzuNPYzW4TptL555atvHP1GC9DK6MwoUT4puJea/VyrNTn2vG1Rx8dUW
	 ilJ86/vvqRlusRvWi/a6/vyMx5c/EmMjsQO0ovVBuf4g/pwphlGBCRdeOyFy+T7dtskni
	 ot2vYfqzRSQw7H6+ItgzU8lW5QTZOCXsXWC4Gjh6Cd1DZnkhvWxJ0ld+Ky+cGrF4GTg==
ARC-Message-Signature: i=2; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1794003685;
	h=DMARC-Filter:Received:DKIM-Signature:X-Google-DKIM-Signature:
	 X-Forwarded-Encrypted:X-Gm-Message-State:X-Gm-Gg:X-Received:
	 MIME-Version:References:In-Reply-To:From:Date:X-Gm-Features:
	 Message-ID:Subject:To:Cc:Content-Type:Content-Transfer-Encoding;
	bh=YWKjnbX+5m+r05pX0tFM8zKeOZxWPGlpWFmRfyjOSKc=;
	b=bVEa3GEZ6B3MRgPynFC4c63Cd2S3kPGtyvHiyeYhFtDMKg/ZsPS+ImKAR9psDja9jr1u
	 sTfgJfWGnmXjJ0DfhGRBoAasii5W/Z9vgVCiOgCQ60P1cVM3Fn1Pj1tZKA7ZdjkLJNjNp
	 9YZ8a85/fKOIM0SxZUqWdYp+PtDFRJvW2o/LRfWjopRESB6bQmvyKs1grtJXqFN5v8kS9
	 VoF7FS68p4efqp97E/Itm1z3GtiD8O87ALydsQ+zCCIsjquwSFYTizJSjb1GQMYnlu/HM
	 FiznmqhYRIzCCI1kZnO9FzcuKaYrfUX2HXNUyf/MFEyL/qdHgmbx57DyXgqHxgIOXwA==
ARC-Authentication-Results: i=2; smtp.subspace.kernel.org; 
	dmarc=pass header.from=gmail.com;
	spf=pass smtp.mailfrom=gmail.com;
	dkim=pass header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20260707 header.b=zTpEqiNq;
	arc=pass header.oldest-pass=0 smtp.remote-ip=209.85.208.47
Received: from mail-ed1-f47.google.com (mail-ed1-f47.google.com [209.85.208.47])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0BF5F606A326
	for <stable@vger.kernel.org>; Fri,  6 Nov 2026 22:21:24 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 0BF5F606A326
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20260707 header.b=zTpEqiNq
Received: by mail-ed1-f47.google.com with SMTP id 4fb4d7f45d1cf-6ae305e3bd9so1728052a12.0
        for <stable@vger.kernel.org>; Fri, 06 Nov 2026 14:21:24 -0800 (PST)
ARC-Seal: i=1; a=rsa-sha256; t=1794003683; cv=none;
        d=google.com; s=arc-20260327;
        b=bjBkwPysGpfhZ1Xbn01TPVVTSy2JC0/b/iiZgbW7Zu49eLIfH4RboF7UcCJhQy7mVD
         V4r6NL0/sChv5i/j8t+c8HXLSLx9j78Fp8urrJ2hNLlmktvr5zx30tLGXT7iPtOM9hBi
         vv7DK3+TyLPhXo3Th857jHt25NLSOsdVBuQwirveEdj0tykbZiJxGKMEdiFUXpmgAvNt
         itxHqbvr+4tpIkNYx1a9046JFICJyelf1Cp3JXKZo2YgeUVjT/8QDifVXfuBUNB/qfC1
         nc3enzS9/6H0VU/+82Cfp3pSqZNDONRDNG6ISsX8TEuIQ6D10losR5u7HO9GFMpOZc3x
         PvtA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20260327;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:dkim-signature;
        bh=YWKjnbX+5m+r05pX0tFM8zKeOZxWPGlpWFmRfyjOSKc=;
        fh=LNjy4jxSHissVRhUnJloxgWDLQbF+i3ijsDPvm711VE=;
        b=XN/dhb6XwCN55hQqneY7gYf4sZVL9Itr7GCMTO1JF7mWEuqNEXIZh3YK0Mki11ZUVi
         bMTtBjqHvOIFRsGCbmhhsJ7Rzn9iGNeBHXmkUOvvn56gikLtR1yNcPAvvTJ+SzNidtww
         PehI108e2R1cu+kyuThwTYMZM9XrO12rWb6M+Avmbj+X2rNYdov47t25EWrFRqVRpcb6
         qN/pQl6l5qbWL7TZjsx3ZCwjCfpvU8hG2O219Mq01aHVNVYCznyEE561x36RQmOpwren
         J+YmCEXevUX84GqmfJg1/yzzehxJkES5i/gJi5ppZEmfv7okFzj/Swb0KTOpiDCcextY
         LkCw==;
        darn=vger.kernel.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20260707; t=1794003683; x=1794608483; darn=vger.kernel.org;
        h=content-transfer-encoding:content-type:cc:to:subject:message-id
         :date:from:in-reply-to:references:mime-version:from:to:cc:subject
         :date:message-id:reply-to:content-type;
        bh=YWKjnbX+5m+r05pX0tFM8zKeOZxWPGlpWFmRfyjOSKc=;
        b=zTpEqiNq7KaHT117vQdFYIUsTleGwL/lJzpbgt89QHiR11x/IAEFaONLeZkDpDNFfK
         S/VUTRa633O9AvnnjbMtUGaYF2MH8WjXMcfG/33f4U90t5IkYWZDKYJ0/DVLjhYiRyTp
         WnPcTB4w/lF20lDbVyO8S0lfsmhijFhvCsYYz8nyI+zrH8Qz1rTkLX3r959eVy116KZJ
         YKtjNBp4nI5bloVTQwqaZedn0NUsMgOt5SaOm6EsWfGBG/SH/Y73exLZBxvdHhD1qXF6
         +h1NSILbSbaBh/30f+Ozh3X5ABgnmO7yhYBmXtLH9kMMSXXbopcOzW7vL5JxTf2gJaGD
         Ez9w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1794003683; x=1794608483;
        h=content-transfer-encoding:content-type:cc:to:subject:message-id
         :date:from:in-reply-to:references:mime-version:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=YWKjnbX+5m+r05pX0tFM8zKeOZxWPGlpWFmRfyjOSKc=;
        b=WR2HbyiAhyJSUi/gEDmncZz2McgvNDzpMhKzgroEUwupZUhjRSyy9x6OnMNZ1GySeI
         o5MIHYrz5pmzBjVedKL4LWT22UolHJeeovJG49N5uk59I4RYpq0BXwLkbJqhxHows0s4
         rPxi6C4Mqrr8GupWvS3TTcYQN6UDef524UEanHAalGlMItdnRikEHUWnUwzGliF4YnPf
         ZP2tnj9vtox0ghxnwhNieqH4zdNfo5kVMvxcWKMiBEq1ORKhvZe8EqcgSDat+oIxGF4B
         vIoP4B66KudUolU3ZBkTWJHNbhB9fyNcLROK0hT9Ky2ToJqCLFv3BZPJ4z6pB0AR2uE/
         pF7Q==
X-Forwarded-Encrypted: i=1; AL+hErEOi1VD07zmXUFdooiG500wfgPrAKBFvF+WL6SKpeITrnOoJLealWA4uAxCofmEiFtxXwPGK00=@vger.kernel.org
X-Gm-Message-State: APuU4Z8NjQWMLviJr1T9Gl8P+Cc5RFe6VNVOl5pVpNEPTpAMnFDG/nmM
	buP7kw+5htnKeS8Rdc5UHFjj3riOx0Ei1jOKzXUs1LE5TbHJq/jFHe3nplHEr1D9BBLAPHy3Nb7
	tpWRhw/yQiIToQQuhxmqLdkZFLOiLZEAJa5MA
X-Gm-Gg: AYBFou3YT/WwVIlqqWdmVHpPzyAPLdRBfLP+XMATtMleSZGHAASjfFjVNo4D8CeaE/M
	d3mxsHFYCrgdVXDVx9TCJgGz1+0hjFybnzS21zWXna72PUIpd2a0EXj4b4xWYHm7rOMF1g2oI8z
	ZjJtaS14Xhuil9ZsbQz8huPAaXHFADFCS/LC/sxuWDRi8uEKkEMi2buJ9B6znzFkS4/c23YpTdW
	PH8jg6a83UmWi+izs6jhVmKkaY/lGYK9XfHL9z66Z/nSLVkvbh/IsrWFBW2QNpDofiUVrJis6J2
	uAPeOSvvI8kRjSgUKKFtbTimOlXk5dp2qYrKKQMIM5bTj/0jTN6EJJGgl+t2VGrqRMwUh6LJ7ai
	gLECZWwWbsZ7+KBOILVCJ/byFyaf7d0lNeVOxou79gaXGCbuzBqOTDFyPjrJ+PQHLuJatAbkje/
	swUkBVhqYVCrdsH1ET+26Vbn9prCVrZEkdaMPbxJhQ/MHOV8WvVGAEmVl8kaWL4JqukebEB0V+i
	gCWDUIiQb+WLHoHHLaosiDsdkhArnvcj98nfp8+t6pVaERBjQ==
X-Received: by 2002:a05:6402:1946:b0:6b4:2960:d38e with SMTP id
 4fb4d7f45d1cf-6b59783609bmr2741590a12.26.1794003683164; Fri, 06 Nov 2026
 14:21:23 -0800 (PST)
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Post: <mailto:stable@vger.kernel.org>
List-Help: <mailto:stable+help@vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
List-Owner: <mailto:stable+owner@vger.kernel.org>
Precedence: list
MIME-Version: 1.0
References: <2026110443-depth-overbuilt-7852@gregkh>
In-Reply-To: <2026110443-depth-overbuilt-7852@gregkh>
From: Rosen Penev <rosenp@gmail.com>
Date: Fri, 6 Nov 2026 14:21:11 -0800
X-Gm-Features: AclHuK-qvPtjJJoK4siDPji18LIlgTD-OxEzb0Cs6ul_7mbhUv18g8pJcaYztJs
Message-ID: <CAKxU2N8QChO59Z=ncdNfvq-hNZp5Q2UsGFcovqn52G5mQso6hg@mail.gmail.com>
Subject: Re: FAILED: patch "[PATCH] wifi: ath9k: delete channel-context timers
 on deinit" failed to apply to 5.10-stable tree
To: gregkh@linuxfoundation.org
Cc: jeff.johnson@oss.qualcomm.com, toke@toke.dk, stable@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Wed, Nov 4, 2026 at 6:25=E2=80=AFAM <gregkh@linuxfoundation.org> wrote:
>
>
> The patch below does not apply to the 5.10-stable tree.
> If someone wants it applied there, or to any other stable or longterm
> tree, then please email the backport, including the original git commit
> id to <stable@vger.kernel.org>.
>
> To reproduce the conflict and resubmit, you may use the following command=
s:
>
> git fetch https://git.kernel.org/pub/scm/linux/kernel/git/stable/linux.gi=
t/ linux-5.10.y
> git checkout FETCH_HEAD
> git cherry-pick -x 81394dfb9a7905472957628b560ae894eae3a30f
git cherry-pick -x 81394dfb9a7905472957628b560ae894eae3a30f

works locally. No idea what the issue is here.
> # <resolve conflicts, build, test, etc.>
> git commit -s
> git send-email --to '<stable@vger.kernel.org>' --in-reply-to '2026110443-=
depth-overbuilt-7852@gregkh' --subject-prefix 'PATCH 5.10.y' 'HEAD^..'
>
> Possible dependencies:
>
>
>
> thanks,
>
> greg k-h
>
> ------------------ original commit in Linus's tree ------------------
>
> From 81394dfb9a7905472957628b560ae894eae3a30f Mon Sep 17 00:00:00 2001
> From: Rosen Penev <rosenp@gmail.com>
> Date: Fri, 11 Sep 2026 14:31:44 -0700
> Subject: [PATCH] wifi: ath9k: delete channel-context timers on deinit
> MIME-Version: 1.0
> Content-Type: text/plain; charset=3DUTF-8
> Content-Transfer-Encoding: 8bit
>
> ath9k_deinit_channel_context() cancels chanctx_work but does not delete
> the offchannel and sched timers set up by ath9k_init_channel_context().
> If either timer fires after deinit (e.g. during driver unload or
> suspend), it accesses sc->sc_ah which may already be freed by
> ath9k_hw_deinit(), causing a use-after-free.
>
> Delete both timers with timer_shutdown_sync() before cancelling the work
> item.
>
> Assisted-by: LLM
> Signed-off-by: Rosen Penev <rosenp@gmail.com>
> Acked-by: Toke H=C3=B8iland-J=C3=B8rgensen <toke@toke.dk>
> Cc: stable@vger.kernel.org # v6.2+
> Fixes: 705d0bf83dbe ("ath9k: Add a routine for initializing channel conte=
xts")
> Link: https://patch.msgid.link/20260911213144.130192-1-rosenp@gmail.com
> Signed-off-by: Jeff Johnson <jeff.johnson@oss.qualcomm.com>
>
> diff --git a/drivers/net/wireless/ath/ath9k/channel.c b/drivers/net/wirel=
ess/ath/ath9k/channel.c
> index 8b27d8cc086a..cfb1c90eb4b6 100644
> --- a/drivers/net/wireless/ath/ath9k/channel.c
> +++ b/drivers/net/wireless/ath/ath9k/channel.c
> @@ -1363,6 +1363,8 @@ void ath9k_init_channel_context(struct ath_softc *s=
c)
>
>  void ath9k_deinit_channel_context(struct ath_softc *sc)
>  {
> +       timer_shutdown_sync(&sc->sched.timer);
> +       timer_shutdown_sync(&sc->offchannel.timer);
>         cancel_work_sync(&sc->chanctx_work);
>  }
>
>
