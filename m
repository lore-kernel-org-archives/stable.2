Received: from mail-lj1-f177.google.com (mail-lj1-f177.google.com [209.85.208.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5EEAB383C83
	for <stable@vger.kernel.org>; Mon, 24 Aug 2026 19:38:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=209.85.208.177
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1787600291; cv=pass; b=EygaubLs37Lo8R8LOYYoNIyY0w7dgdZ9QjLfjXv5GdoF1OL61o+eebm+RJSW/LJKIkcKG0lGoW4iNzCJXCkSHoaSYd3nZN7S4eHJpt6p83fA2aO/xQhhf1Ojy4PLVZCRvuGZYa0YFPZyNFWgNMy/LzfGb3RFJX8F7YuyjXRwP6E=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1787600291; c=relaxed/simple;
	bh=zHeHpucERJjVL5+r2NcJqPbPArlHtoL5ieMLJnSAk1Y=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=uKL2kFSth4nguRCq98KJ3fasx009alOC/W1mz6LWTKvsrbj4JRC1QM1QyOLmR/UdWUBdCFS6Kz3rFWr2EfvHAHmrvGRxFHU92PJip6SvQzlpXWBk0YVUh6yUiywzmqbUnSCEZ4Bqo17aBXvIfXyY9jjIjL6c9m6FEjcAAVaRYsk=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=mE4ASku9; arc=pass smtp.client-ip=209.85.208.177
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="mE4ASku9"
Received: by mail-lj1-f177.google.com with SMTP id 38308e7fff4ca-39da69c5ba3so37312611fa.1
        for <stable@vger.kernel.org>; Mon, 24 Aug 2026 12:38:09 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1787600287; cv=none;
        d=google.com; s=arc-20260327;
        b=J2w7rbRJkXHxlIjM6VsVwikA1k5rrNoJNK8XUxbaFoOuUU3WZG6ITeZJaXT+h3BgUL
         uqfwPQ7Rt0IUPZ0yDd/CfUVvLWhDXJJknMNl/5pjjzapEeVXGgKH8ojkcH85YR9kBgDN
         eN4E33IIopPGH/rmGG0cPcEObLJQd1w0933LhjEBi3pTKjDbW4CvHd7HCx88wx06CPan
         HHjzNecq616M8GBTNJCG81NTUQ8qmuDnxXgF44mWRJ1AwwjniE7HHm0U2OA0xafUPHo4
         bCWYnrVRAP0edelGUKeFDH0zOtwz6Shsq/qrBSe+1SO76Ru4GnlCGWH94EEQ+tYk5nr5
         1Wcg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20260327;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:dkim-signature;
        bh=zHeHpucERJjVL5+r2NcJqPbPArlHtoL5ieMLJnSAk1Y=;
        fh=Gq/AjmvivCztIpSzAwLD70QUIH20XQRebsDk7TQDJyw=;
        b=UPO39dG7raLWSobTVnubQ/9trfKqc4UizvrqPu+fJ3NLTt1ohWiPrb0KX2hXmXxuQJ
         9GNbZOAuC4VYhjq/Se/com3JeNDkY0oFOzXBQdXBONK4FuCOJdxKYNmxMLyYOPYw9/+2
         ZPUC5oAgMmqQAl9RjIOq4yOtvIZn3jJxbPyV9bHmcT0MiWe13X8Vuq4VG3Lm/HGRSo7i
         4iq9E8dKJhBCobu+262KYNBw3RnE/w0XlFTIoueJEHailEge7Vupcu2zWTgb08gpCMeg
         t2vft6nz6mNojWyhz6eVUq8b0N5DhDSlTdl6wOZmipFY9IQtQhO/LjazOhDNoPgJcV6N
         E9kQ==;
        darn=vger.kernel.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1787600287; x=1788205087; darn=vger.kernel.org;
        h=content-transfer-encoding:content-type:cc:to:subject:message-id
         :date:from:in-reply-to:references:mime-version:from:to:cc:subject
         :date:message-id:reply-to:content-type;
        bh=zHeHpucERJjVL5+r2NcJqPbPArlHtoL5ieMLJnSAk1Y=;
        b=mE4ASku9LVVm9yxGdgl2Fq7Ge1gAcKaZPYYbI73rle0bsQ3XkbDq5UkDTDP/4zLEPc
         Q3I8e8PVwT9Q+pJbLcm8Zm9zNIG6uVcr2fwFvLkmlPWJ2wW7iYJj2jPHjURmvWn7id+X
         0eR+GefmTE22O3Q0BqL2E0VY/mJVooi8dewTlu9Y39Sf3Rl4biAwVMeOOCGLyi/i+T+T
         NbhPXKRiyAsaYp8X8TG26kZmgnvT8w2BJEquIwYdbcFsr7w3QzTian7Gm/YKb2/1E/0m
         uM708AYnhzDct2ZZ7WtYEj/yD24sonir2vueTQNKTcdVH2cN38wI8BF6EuoK7kbOx/oE
         H1bw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1787600287; x=1788205087;
        h=content-transfer-encoding:content-type:cc:to:subject:message-id
         :date:from:in-reply-to:references:mime-version:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=zHeHpucERJjVL5+r2NcJqPbPArlHtoL5ieMLJnSAk1Y=;
        b=B6FVrqSblcBi/PxNNGVA68NJFYdqBg9/rYkIPgQgvt5rTGLqvao9GzEs+EEOcVKptj
         zRtxXIJXe5EqifS2sAjXyDZtlz3GeNJSF2YoJu0CFIJk96Dh7fDJaVQD6LKFYjd/CTpZ
         fdbgou8MmCo0d3h4SxRCyol/Yzg0Vy9JwEoX32l+jPGwGnR1JVb43jTTyHcqrzBNoKG1
         wBlaC9PuxhNldL/2rmydfR56w8FolVSaLv1jUB+hLmAD1OmiBx08OiErP0EURuXwjhr4
         5OJAN8REaD0jgo2g16hmfnB/XHIwE29IE35/fH1yT5nQcfmHUj+zl8oY/wnOtR51Qu6h
         3/eA==
X-Forwarded-Encrypted: i=1; AHgh+RpexGX8GkPvR7uaZUzfVJVFtpGi7xFVgtOlavCadzlkUGDY859eacudNDTub5PyL4dxq92nDGA=@vger.kernel.org
X-Gm-Message-State: AFuF++lDvhru5iSlR3HKUr/Y1hES8I+DZ4Gah1LhEuIX4n1ZTiR+yBrj
	LXofTr5XOsDJVHOfFJ5OtZqRioCQIL4rsxI2fZzXRIXg3gxlviH531WP8BoSIe2fzywDIjUF/C8
	xQnZ3jT8/MkVDonq6jpv6ePKyqiKtwtE=
X-Gm-Gg: AR+sD13De1tNB6WLGchC6+1TVaPJVAf7VbWgHZct6gdm6UyP9D68OTa+ImJQXWmhgfb
	8sfT+Hzv76/rtEKGEVSfiAptxWGYLRczkZslD/4Ebs1z6Lbizgtkh+eSYovVfYkUyp0/JOxJA+v
	Un7hQGXccvYxmL6VMFreq6O6aYs87x/AdK/khTa5iFawh5xb4gd1xJHVUzoFrOR67dnj8gWKSR0
	3ImW5Z6/BjTs8dlWGsHqSOmfrMZ+90q3XHMCMtDD2NC6PR/No/ZGFzqdJRfBztwYrxuAU6cIxIS
	nohbrowiPZanJQO6yvjxXk8RNL1bmy5ItpUe8fxy+IAxn6NbLs6zS6brQNhu2XwDWDlw16+0HWU
	i
X-Received: by 2002:a2e:a983:0:b0:38e:a12c:418c with SMTP id
 38308e7fff4ca-3a1ef5775bdmr1370571fa.11.1787600287017; Mon, 24 Aug 2026
 12:38:07 -0700 (PDT)
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <CAPyJwA_D9qw0T72f8zwM1yKjP+To=maVANbcdsWM7yRmbBxYvw@mail.gmail.com>
 <CAPyJwA9R=p8_uxyYODb00g_nUq26SRsWHBGgAAJnR0YMTRRo4A@mail.gmail.com>
 <CAPyJwA9P48LDcOr7u_iT1WPFBCHxh9w6cxFvyi5GS3syM6crbQ@mail.gmail.com>
 <07435e6b-ee30-4c85-8c8b-0ce3a4ead1d9@leemhuis.info> <aosGtkE_diwVJJtB@eggarch>
 <20260823174059.46fec036.michal.pecio@gmail.com> <aoser8dLytrwqBC2@eggarch>
In-Reply-To: <aoser8dLytrwqBC2@eggarch>
From: Mathieu Fluhr <mathieu.fluhr@gmail.com>
Date: Mon, 24 Aug 2026 21:37:55 +0200
X-Gm-Features: AcwNN1WiVe33vc8h6QVQzrHv4uzYMmh-8zMzWXxnjMlLCWrcww5TjCW4pcQuiCo
Message-ID: <CAPyJwA8m_Xd2oyV1i9k+-6f7A-j0FiC97yXL=Ci8ZAErs5W4vA@mail.gmail.com>
Subject: Re: [REGRESSION] 6.12.36+: usb: hub: post-resume delayed work
 triggers > uncorrected MCE / data fabric sync flood on Threadripper 7970X >
 (bisected to aec11e5f9c45)
To: Lovekesh Solanki <lovekeshsolanki00@gmail.com>
Cc: Michal Pecio <michal.pecio@gmail.com>, Thorsten Leemhuis <regressions@leemhuis.info>, 
	Mathias Nyman <mathias.nyman@linux.intel.com>, linux-usb@vger.kernel.org, 
	regressions@lists.linux.dev, stable@vger.kernel.org, 
	linux-kernel@vger.kernel.org, Mario Limonciello <mario.limonciello@amd.com>, 
	Forest <forestix@gaga.casa>, Slavik Dev <developer.slavik@gmail.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

> The issue is obviously a severe HW malfunction (you mentioned MCEs, the
> Ryzen CPUs simply totally locked up), triggered by poking certain xHCI
> controllers on the I/O die of these CPUs in some wrong way.

Yes. As mentioned, I first thought that the emulator itself triggered that =
by
doing something that the CPU did not like.To be honest, I barely play with =
old
Android versions anymore, but seeing that I could reproduce it even with
Android 13 or 14 made me suspicious.

I _guess_ Google implemented a workaround inside adb for version Android
15 since using this version, it remains stable for more than 2 hours.

But, in the end, the situation is that from a simple user account having ac=
cess
to some usb plugged in devices (I usually add my user account to the plugde=
v
group and use some known udev rules to access my Android tests devices),
you have a way to crash the complete system.

> Opinions seem to vary on whether CPU load must be present or absent.

On my side (and I am here only speaking about my TR. I don't know about
other Ryzen CPUs), I can't reproduce it under load, and one condition to
reproduce it is my CPU going in C2 state.
-> I did a 2:30 hour test using several youtube videos playing at the same
time on my desktop, also stressing the emulator with some 3D Mark runs
(as mentioned, I first suspected the nvidia driver to be faulty). As long a=
s my
computer was busy everything went fine. But then I let it stand still for a=
 few
minutes, and it just crashed.

If you need me to do some further tests or experiments, let me know. I will
be more than happy to play the guinea pig here.

On Sun, Aug 23, 2026 at 7:05=E2=80=AFPM Lovekesh Solanki
<lovekeshsolanki00@gmail.com> wrote:
>
> On Sun, Aug 23, 2026 at 05:40:59PM +0200, Michal Pecio wrote:
> > But I'm not sure what you mean by "1Hz stress loop" and why is slowing
> > down the suspend/resume cycles or moving suspend from close() call into
> > a work supposed to create problems?
> >
> > I would naively think that doing things *too fast* is more likely to
> > trigger races and break the HW. The whole issue smells like a HW bug,
> USB2 roothubs still do 30 ms cycles and are harmless, only stretched SS
> ones kill the box. So if speed were the issue the faster ones would be
> dying first and pre regression kernels ran fine.
>
> About 1Hz, adb scans the bus once a second,
> every open resumes the root hub and host controller out of D3 and close
> puts it back this existed before regression too but with 30 ms of
> close() and slept for rest of the second and now it keeps it
> in D0 well after close(), the suspend itself happening later from the
> delayed work, so this d3 - d0 - d3 trip of ~230ms repeats on
> each scan. That's the loop I meant.
>
> > Can it not become a problem for external hubs, under other workloads?
> Possibly yes, but nobody reported that so I'd rather scope where the
> harm is proven.
>
> > Also, what if we connect a downstream SS hub to the root hub? Will this
> > not cause the root hub to stay awake for 200ms again? Problem is back?
> The root hub itself skips the hold since the check is on its own parent,
> but it will be kept awake anyway while the downstream hub or devices are
> in use which is normal activity based PM.
> If heavy polling behind a real hub ever causes trouble that's probably a
> xhci/platform level fix anyways since real hubs can't really just drop
> the hold.
>
> Regards,
> Lovekesh
