Received: from mail-wm1-f47.google.com (mail-wm1-f47.google.com [209.85.128.47])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E61B52DEA98
	for <stable@vger.kernel.org>; Wed, 10 Jun 2026 03:25:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=209.85.128.47
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1781061936; cv=pass; b=JRCME8kqdve+h9qXf6OKePDty9NienmfWtPwFY6BDfNUcAKdzWsN+vBYWNFFRHc5SbXFZsyWIeCl+iJrfRI5uICtjLRA/cHt7Ma7gjYgryMn23pj4D+iWM6sgZ1jNUuW3iwFc6eEnrrJHNlrJ/jOqugy3cir1wjlbZN2kUqMzFw=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1781061936; c=relaxed/simple;
	bh=bLTA2n16r0+5ngF72dQlvuuIu9xn7HaM9bU+TkfJqR8=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=MzDg/LcD4Ww+joxPi0lBTTjG4VSF7Yg4zUQ0LSvU3juv3OppsoCkUgIqAro4IYhLgi6oxbU2yD4Kw0tz9DG2p/EGSz6S14xt4P530iKhC99+FllaF1+MsH0IgkJyUDv0hXcWzNcw5JX34uW45mrWVkqHFwo83XVXD4xJ4OpGVZs=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=h/8VXO8x; arc=pass smtp.client-ip=209.85.128.47
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="h/8VXO8x"
Received: by mail-wm1-f47.google.com with SMTP id 5b1f17b1804b1-490ac357c55so67045425e9.1
        for <stable@vger.kernel.org>; Tue, 09 Jun 2026 20:25:34 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1781061933; cv=none;
        d=google.com; s=arc-20240605;
        b=T6Agl1nE5XJu5IB2wyw4M4eYop4OaeL47fuLkyJWlPj5f9TB9dSr5aveYWN5cHhRlt
         J2rJouIvbo+pCFtWLPuJ9STMcrS/fa48VouI9bAS65VXI46L9h+dcEe5npN9PeSize67
         aB6qtEDkng7h8zEJpRJhclTCDIk/AShASvcdiYvOM/xhj3QROxBZZi5+AqdmLOGy2i4v
         E2UljcPcZOEk7HxgEx7WaoOCTSWUyVJILg64XWSEteEuwjJ6gSzOXYB7VCl5LiXQTwVP
         OLx1/EevWaKZS92xhiFrS371jJqR8W6dC4zO0Ot2ZaE0LelXvTp9IyV/MrqL8vfKro5I
         p/Bg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20240605;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:dkim-signature;
        bh=zPt5I5nOTT9SNhJRE98M0BUywO9yu2msM1Dsa0Tt5oY=;
        fh=Umt9t3ly3n5OrAtv6xHSpgF+9BG/lUP+nSuddNtDBQQ=;
        b=SvN/I0S3o3z2wTzLI35VouLzKfc12+XdFtXyOzTN9lRbBrrLaQisnyc2MsThghF1OQ
         caVlUuKWY3yI8zANyyfIKqNZ51/qW/pXYaZM5gdMCaW3BbCyorQpopVrshLjcDBL1Xqj
         Wlr8OZaAH1rBl4S2KprSjp408W/RSwnrzq6SJEbGXWwMP/U4qWSLgg7V7fwoE1SLuh4C
         eVWZ+TUnnyvs3AY6CcCBdcgc2coFFaXFJ+2V+ctmEW7++0rROMuEyJDSe3vFR3vs6eow
         vsFn/6Sl95kfYSe0sEiuCYiW/p16vuEoGscUUGZdE22whuwJraeiXDzQQKqgQynD4ORh
         srGQ==;
        darn=vger.kernel.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1781061933; x=1781666733; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=zPt5I5nOTT9SNhJRE98M0BUywO9yu2msM1Dsa0Tt5oY=;
        b=h/8VXO8xPkWtp/8Uj7uEBEzd0flkYaM+5EsdXMZJMQVyFn9pkpuShbbz26vYKVZeO8
         mrxCf140NMB+b6k1X9KWOBZqSiAOHP6E0KO+NzVzMKbfB8oyVOlondDFR7JSYI1xpxqy
         sZIlk+HH+1U/2dICQsLrnkyuT8YU7YVl85stzNmsIFy3WmtzGcHpFN/sDCH4nBI43Gjr
         sF4CAS/mc0reQfTStC5JChgGg9/d+ocKREc6z0YpqcEq5QrnNLh5OcpSse+purzDiYS/
         x2V9OxGP10Q4jBgHC+hgZpSTFE/vijzGTF+sfDa2/q46s3kiqHY2joF+StYc/Jc83yOl
         DVFg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1781061933; x=1781666733;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=zPt5I5nOTT9SNhJRE98M0BUywO9yu2msM1Dsa0Tt5oY=;
        b=oVuT19czDmDFft+KeQU6CaRIGwWhnLZIXCz1OYt0tPMgE0GXr8krWlUOFZ1tv2W7WF
         0YhJPQ9rMxB2GMJ9Kh6ltfYnp0FUqYuK1ZTZpFcPAZTl8QotDmT/165HC7u+o2Gwspm4
         O9fzbAveIbStjtinWKLLuAP4slra8A67A4kdVXZWK45yYkT3ZTigPSLHOQ2/6iJ/aHrH
         63mgclIcVtyje2OgVY4dw6MxOIzu6LiBzQnWeX09bc9PpimzvzGw9kL5yRkV6MfOUEuN
         rrTkVxTRH3d8HUlz9DnZTY7u+3IcGgxXrbLIKO5BTkob5hQBytL7nLumkoanXNIhG0qV
         WORg==
X-Forwarded-Encrypted: i=1; AFNElJ/swjxr1r697elkqupNrN7RyFokTV/pP4s2AeoKxdmHxQwQEpMeFHo4Adyy7ore0JgFdv+kqaA=@vger.kernel.org
X-Gm-Message-State: AOJu0Yz4YNZQcyzZ0hCESpCYJLEt2oSOmMo2rAbStoBEBMMdMg/bWdgB
	WyzT+lJmqmS5vSQ6Vi5iRYQqKF3Y1rUobjVFyv6921sqUNYvHg4d/x5dzxZWQSFchnQN9DdDNH9
	Xs3XO/aS9jcMzu8tvWC2d+UWsIeXT6BY=
X-Gm-Gg: Acq92OFOjUiSuYJC9crSDZRzSjRusTTgAyCN0vNaKSkj5at59at8oQlOTAnjh+Bi/UM
	viESyTCBTf+Rgm0g8GRbOFt4/S2gTQOS9rSFLSoANInGBC4lmGadWgSgyAHL+Paw/eoLaSM5FQH
	usM23xcm3g5SzxRs5q0x2aMkagX+Gm57c5yELzS+1wcvEgebiH9V8Df8MgkoNHM9awgHhBbMNbC
	gKyQ0a7xLVovHC8XXdXyHYjFWdv7NcDCCxzdSlJbUdo8tISCK1iNKggWfOpfA7Dt5hAmrTp/dAM
	v6ocn8NCcvo7qu9mPBp6CS4Yg3QRD1JrGtG060+5YTjTCJhdxoGmEkSAunmp2353AM113klMGNw
	EIautTOJu
X-Received: by 2002:a05:600c:c493:b0:490:ae52:499c with SMTP id
 5b1f17b1804b1-490c25f1ab6mr393052765e9.21.1781061933272; Tue, 09 Jun 2026
 20:25:33 -0700 (PDT)
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20260610003717.1720575.7a414fc8c0ea.fuse-notify-prune-count-wrap@trailofbits.com>
In-Reply-To: <20260610003717.1720575.7a414fc8c0ea.fuse-notify-prune-count-wrap@trailofbits.com>
From: Joanne Koong <joannelkoong@gmail.com>
Date: Tue, 9 Jun 2026 20:25:21 -0700
X-Gm-Features: AVVi8CfRPeeOu2dsd9aqrIIj60y--USHNaIrr5n67yP-THOc9yTjY2P-ZtwBuE4
Message-ID: <CAJnrk1bkXSmUp88KAMZvK3rnvN7ijAXMVev+dHCpodpo2GAxig@mail.gmail.com>
Subject: Re: [PATCH v2] fuse: avoid 32-bit prune notification count wrap
To: Samuel Moelius <sam.moelius@trailofbits.com>
Cc: Miklos Szeredi <miklos@szeredi.hu>, stable@vger.kernel.org, 
	"open list:FUSE: FILESYSTEM IN USERSPACE" <linux-fsdevel@vger.kernel.org>, open list <linux-kernel@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Tue, Jun 9, 2026 at 5:38=E2=80=AFPM Samuel Moelius
<sam.moelius@trailofbits.com> wrote:
>
> FUSE_NOTIFY_PRUNE validates the nodeid payload length with:
>
>     size - sizeof(outarg) !=3D outarg.count * sizeof(u64)
>
> On 32-bit kernels, size_t is also 32 bits, so the daemon-controlled
> count multiplication can wrap.  A prune notification with count
> 0x20000000 and no nodeid payload passes the check, enters the copy
> loop, and asks the device copy path to read nodeids that are not
> present in the userspace write buffer.  In QEMU this reaches the
> fuse_copy_fill() BUG_ON(!err) path.
>
> Validate the payload length with array_size() instead.  That accepts
> exactly the same valid messages, but avoids wrapping arithmetic before
> the copy loop consumes the count.
>
> Assisted-by: Codex:gpt-5.5-cyber-preview
> Fixes: 3f29d59e92a9 ("fuse: add prune notification")
> Cc: stable@vger.kernel.org
> Signed-off-by: Samuel Moelius <sam.moelius@trailofbits.com>
> ---
> Changes in v2:
>   - Use array_size macro
>
>  fs/fuse/dev.c | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)
>
> diff --git a/fs/fuse/dev.c b/fs/fuse/dev.c
> index c105aaf9ff5d..0c6d1855003e 100644
> --- a/fs/fuse/dev.c
> +++ b/fs/fuse/dev.c
> @@ -2081,7 +2081,7 @@ static int fuse_notify_prune(struct fuse_conn *fc, =
unsigned int size,
>         if (err)
>                 return err;
>
> -       if (size - sizeof(outarg) !=3D outarg.count * sizeof(u64))
> +       if (size - sizeof(outarg) !=3D array_size(outarg.count, sizeof(u6=
4)))
>                 return -EINVAL;
>
>         for (; outarg.count; outarg.count -=3D num) {
> --
> 2.43.0
>

LGTM. A heads-up: in Miklos's current fuse tree [1], the notify logic
was moved over to a new fs/fuse/notify.c file, so I think you'll
probably need to rebase this onto for-next and resubmit against
notify.c. But this current patch looks great for backporting to
stable.

Reviewed-by: Joanne Koong <joannelkoong@gmail.com>

Thanks,
Joanne

[1] https://git.kernel.org/pub/scm/linux/kernel/git/mszeredi/fuse.git/log/?=
h=3Dfor-next
