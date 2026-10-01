Received: from mail-dl2-f43.google.com (mail-dl2-f43.google.com [74.125.229.171])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CB80649BD6D
	for <stable@vger.kernel.org>; Thu,  1 Oct 2026 23:58:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=74.125.229.171
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1790899107; cv=pass; b=ZPcKz58r8Dtz75X6eZaFU5N59qBuJAUUpH4YzzW6UXH75boAMg75Y2a7G8gAvmlUwtIIotfos7bHIsG/zvcc7UFKh2nfbz4WjiwgDNDcCO5616IC30ipiMc8l1nK5OunW97e9FkarfdLmNvMMMZoxao6InS4BdOdzMgYdyLj41U=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1790899107; c=relaxed/simple;
	bh=AU5qx0SsPYU3uJ8KwmQ0/fUfZYMcTpVxfADD1eUqY6g=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=S/+vWb8t7f66xgUsHid5T0iyc1HJkE7TdPzv/YHhc/HgKW9Z2cWp47bKidSVsSPalmE5ZagdK2J8bGlQYOoHvthY8JeUEaBenJ26CyohDBTDcJmtpPgAluUnaGQJHKkIB4P2ezZayJ7TpoW3sKJndTAv4UjdhYsDY0RhBkV+dRM=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=cdUMZqDM; arc=pass smtp.client-ip=74.125.229.171
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="cdUMZqDM"
Received: by mail-dl2-f43.google.com with SMTP id a92af1059eb24-144f7915355so6171823c88.3
        for <stable@vger.kernel.org>; Thu, 01 Oct 2026 16:58:25 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1790899105; cv=none;
        d=google.com; s=arc-20260327;
        b=gE0+TfMLxcPRAAtUFiyvohg8aoReAIoQJFlD53+1yPejY3rrBSkZSuUTSw262c8fAc
         xaj8ovqoOibaZAoQAJ5ozmQOlw0Kqc6L+pzlKDG6nr6CMhV8BePYhjyrxt+8jEQPk5LX
         XfTbXnfjm+98OzNN5pOJ+s+1Y4YJnoZvtPTulhJrN7PIg9iZ6mwtXMow+wzzI80MFKEd
         HOg9mNFlIlwsmxrzayEHLIwBYn7Ig2LbI0Y32ESR1unMthE7Hl+Gf6ZxtEKcYrRzpyf4
         8MJBtUrWSG8/kAHp9NUks+6WDlG6Dm26xEAb/mIkc1fHAgtO6uEO3T/I1gpuDiH2egVv
         kFzA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20260327;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:dkim-signature;
        bh=AU5qx0SsPYU3uJ8KwmQ0/fUfZYMcTpVxfADD1eUqY6g=;
        fh=7WGbgX6luQ2td1ksTbpHgUFiGy3qziI1EsEWrsV5WUM=;
        b=oTIODGzFfaR6OOPbVZPACCl1hCBhBHWRII5zTkkC3gYxoyH1Voh2ZZvZzIVN7E/hJK
         qnD3pnqbnvRy5ss1kU3U799+wZBSQIKW39XMzr544x5RqYSZK/edMUxD6cyR6BsbHXp4
         KRL1jq177uWNfaqHaacvQu4hOzM3N3BF4zaO5lLxlind1Yi5vJTDf5q13XrpeZ45t9my
         TeNyHpB1Yi6hZ+8uSRLJxWd4Oc14Rv8caclg2LcxNpHoyILzV7VkLaXsT+uHvqCyDxja
         py6214ujqrR3T80x1tJofZ3IdEzlbmB+m2oXExnz3uxzZf4RbpjSw2JfqS566luxIQHQ
         JVvg==;
        darn=vger.kernel.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1790899105; x=1791503905; darn=vger.kernel.org;
        h=content-transfer-encoding:content-type:cc:to:subject:message-id
         :date:from:in-reply-to:references:mime-version:from:to:cc:subject
         :date:message-id:reply-to:content-type;
        bh=AU5qx0SsPYU3uJ8KwmQ0/fUfZYMcTpVxfADD1eUqY6g=;
        b=cdUMZqDMwQu5oJ3RKznrcUG0HfrWQ77MDKzSIVN7yLrP34fGPPx4horPviI51zytzB
         66lHD4WLa4ozUFAae5NYIRGuYHnU65TiIF4EF/zUCR6oWSSekNHADJe9mmSQjJot5VLI
         guWGrHYBt4WkVBwJa8bby9y/SS9Ie22FOps7y/5i21g5FCv1KDMxrPJVK9ltgjTUuCJm
         4rlj16mZaMvL85NC9I0c1JpqQ+cJy6z/vcE7OU8jArNXM18uVEaRZ2S/BtCj6Sg5d9kk
         PNjQq2os2caVnEWh16vrHjaE6BqUgDhHIN208I99IEIn55s3TJyYxcFw1OYcaQTKpi3/
         3mpA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1790899105; x=1791503905;
        h=content-transfer-encoding:content-type:cc:to:subject:message-id
         :date:from:in-reply-to:references:mime-version:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=AU5qx0SsPYU3uJ8KwmQ0/fUfZYMcTpVxfADD1eUqY6g=;
        b=Dkwpr4oFKEI54Uy5RjODfSeqsF4SsZGddynhY8SAxf+8X5i2q1ZJdOCNkSuzOEvMKr
         uErPJCivMBD9QsjVSsAHqOV3lIP4or2zjP8bYHS9mzR3Qyf4IlKb4dm6NWXu9deoNC+u
         SoJTZT1VNm8ajKhFm0Tb6Gz/f46eDJ7rNaCiN3S72gUEdJ82bItL4iKyiOoX6gQjEWFZ
         fSeOynBbxVl//mSvrDWBT6P6fUrlCdrV6RiHxVdESLm9Kkb5wK98cZ+2G3F/bDSKXHIP
         FSwrHY2++iI18Z5gNx6+mYVBM8NE4XzbpxDv3F7C30ublUds5bZQ6ZotBxzk0BnaUEU0
         EhMQ==
X-Forwarded-Encrypted: i=1; AKwUvBxJj8FJEWX/rcnQKOopfPQu4kWIT78/ihPbiWzBBuvj08/IfNGe/pcbOJVFe6H8z9f8vABKpTs=@vger.kernel.org
X-Gm-Message-State: AFuF++mHkpLGXf5UmG7NTsc+rVxjQH2YuQ4nJJsmjJl9CSYifWTwNXWY
	3QaB5zbQlWa5XRs5lR7PjVaPgVWCX67zlKq4gD5FFLK0bB+LdMWNVHaeeY0LsvF1K41gh5KuBtv
	PkZcThuZrlBdNeO37r4dBtd7Ap9TXjNY=
X-Gm-Gg: AYBFou3dO9v3nqmn6DkQXyluydOBWNeUBe4wEvrCaQr0LlDEkINyWMC/xLK5Ak8iIYM
	Mi0VuxHwwR8FmtwOT6rFKGtYz0TmEqrh0zM4vx0ZbhZYlifI6ZDaRMn8e8jkDpTYIijnnmPp4nD
	W3iy+5xnlHiDuh43qtWYwjU8RAvaC5rlxBxA6h21SIZees58BfDF+fQsuTFAuyqyvSL4sz8G534
	4ZnttTtqt9F/2HUJp9tIAFb3aRC/Usc2zxs+b9nTMDYut4bdeRTPPv38VX6tXfPo5kO41B9vMVF
	CvGzawcDLx19Jg6VLyOcikKqPxwhMWXGZ7ZzHHc90SaMKkb2cIFkpbLlH05AMxUR0uvljXnmKn2
	p96g19ZVI4azOo7eWJ288uXk4WQ==
X-Received: by 2002:a05:7022:150a:b0:143:5722:55be with SMTP id
 a92af1059eb24-14f5c2ef10emr1139903c88.30.1790899104864; Thu, 01 Oct 2026
 16:58:24 -0700 (PDT)
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20260930-tb-dprx-fix-v1-1-da92659e491a@gmail.com> <20261001034839.GA176164@black.igk.intel.com>
In-Reply-To: <20261001034839.GA176164@black.igk.intel.com>
From: David Medina <b2amedina@gmail.com>
Date: Thu, 1 Oct 2026 19:57:56 -0400
X-Gm-Features: AclHuK98N9acfHTGaWAbQzc_UJu8LzhR1AJw-KZvb2e5NZcBn3V2zswzwxEWLcw
Message-ID: <CAGTy6n-voghUysgDmvU5bU+zuBPyr_svGXU9m-zm+vKXHYf55A@mail.gmail.com>
Subject: Re: [PATCH] thunderbolt: Fix domain reference leak on DPRX work cancel
To: Mika Westerberg <mika.westerberg@linux.intel.com>
Cc: Andreas Noever <andreas.noever@gmail.com>, Mika Westerberg <westeri@kernel.org>, 
	Yehezkel Bernat <YehezkelShB@gmail.com>, linux-usb@vger.kernel.org, 
	linux-kernel@vger.kernel.org, stable@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

Hi Mika,

Had issues with your mail servers kicking back my message - so
resending just in case.

------

Thanks =E2=80=94 I tested your fixes branch and can confirm it already
resolves the shutdown/reboot hang.

Please disregard my patch.

Thanks,
David


On Wed, Sep 30, 2026 at 11:48=E2=80=AFPM Mika Westerberg
<mika.westerberg@linux.intel.com> wrote:
>
> Hi,
>
> On Wed, Sep 30, 2026 at 10:16:35PM -0400, David Medina via B4 Relay wrote=
:
> > From: David Medina <b2amedina@gmail.com>
> >
> > tb_dp_dprx_start() takes an additional reference to the domain with
> > tb_domain_get() and passes it as callback_data to tb_tunnel_alloc_dp().
> > That reference is only released by the callback, tb_dp_tunnel_active(),
> > which tb_dp_dprx_work() invokes once the DPRX capabilities read complet=
es
> > or times out.
> >
> > If the tunnel is deactivated before the DPRX work runs to completion,
> > tb_dp_dprx_stop() cancels the still pending work. The callback is then
> > never called and the domain reference held in callback_data leaks. The
> > domain's reference count never reaches zero, so tb_domain_release() nev=
er
> > runs and a subsequent shutdown/reboot hangs waiting for the domain to b=
e
> > released.
> >
> > Release the callback_data domain reference in tb_dp_dprx_stop() when th=
e
> > DPRX work is canceled, mirroring the release done by the callback.
> >
> > Fixes: d6d458d42e1e ("thunderbolt: Handle DisplayPort tunnel activation=
 asynchronously")
> > Cc: stable@vger.kernel.org
> > Signed-off-by: David Medina <b2amedina@gmail.com>
>
> This should be fixed already by the patches in my fixes branch, can you
> try?
>
> https://git.kernel.org/pub/scm/linux/kernel/git/westeri/thunderbolt.git/l=
og/?h=3Dfixes



--=20
David Medina
14901 SW 87th Ave
Palmetto Bay, FL 33176
786-280-0880
