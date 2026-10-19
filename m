Received: from mail-oi1-f176.google.com (mail-oi1-f176.google.com [209.85.167.176])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 01BE44AA3F4
	for <stable@vger.kernel.org>; Mon, 19 Oct 2026 11:04:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=209.85.167.176
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1792407852; cv=pass; b=P6tve4R6tTUo5pV1MpEHXCPVAug6/vMmTH/VKtEy+/Mvhjg4dNmH2E2mPRhqe83/UKtnWQ3EwdvV8OjieD6V1Qtm5bCbPdSzBra+lBwhV8ABxNq+j8xyonw8T8Ru0/XROGzhRhbjTs2v9hVGFFE3LDK5JqdikMuDhZ8DkFFYpCY=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1792407852; c=relaxed/simple;
	bh=bfHt9VJUjw2jpaKsvRmu5N8bb4qZt+FbJS5wdGnbVME=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=dGrATr82rgzrYDnxrUdc2Fp0Le2TaCgoWwySe/MPPkvGEEsf1d5Psd+jndWfTDESQu6m2lC66Sfg7w/1GWlMYUQSnCcQl+sPJxIEajbn69C2vhVx1L9uBgMIw/pgmETbxSNeKC/AJMdEIJKtScLE5p07XNBwB0o3hDvK4UwMJh8=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=hkE25WF3; arc=pass smtp.client-ip=209.85.167.176
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="hkE25WF3"
Received: by mail-oi1-f176.google.com with SMTP id 5614622812f47-4c9859ea2ceso1136859b6e.2
        for <stable@vger.kernel.org>; Mon, 19 Oct 2026 04:04:10 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1792407850; cv=none;
        d=google.com; s=arc-20260327;
        b=S1CwKqqKTGCqvYC3H7+rRhw/7Q1tKykAmJfzIkt8ofFP3W8WMoFl+PBJTZ4gMXWe7L
         wJaOXXxSkGKCA23UXIABhxilXhOLFM1IqgNrC9rTXEZAnfeSmk0Wgb+hVBIlCFUx8n8U
         hCfDEtxNqKFoO3AW/equ/Z42GTsYDvvaGxuBv1dwqsPPCMinm1fhVjiPgILsMS3B9wHK
         U6Kh1qTiwW7ha83X4k1c+tDhwR1yvpxhn44HQeXUDEFOc3rMEgf7nOsFXZ5PWHdzfg9l
         Z6JuaZuKwOSBPzXJe2QMwLYKQZAU/V6tPYnZn/pJCn8gyCcyHdfp7AejYer1S57M83uX
         p4zg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20260327;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:dkim-signature;
        bh=2RjmAJkJaRfKW8CM604T3xdOE/8FYHsXLHXgCKfQYGM=;
        fh=qMHO3qbfSxC5iQxLgTQ9JrZMJ2IFjY9n2DTZo/BFFyE=;
        b=DPG+SsnLhTeflej+w0UbWVP6BWBcl5wLHKmiT8CnYChNh00htiulAuVA/xlWICc8cl
         Qndgj5yNrF2u3HZdGv73dqrMlLIQ4Vnc+CejoCAFXahr1MhJ/bC3zkK0Y1tqv28QH3a5
         Sc+XeAc519t1i0UThmVSGCRIpfQwhPM6H6IkSRGQKpkXQpsYE+6b7PjW80AC9Abw5bFv
         sjwR7s5kq2sTredoFyEDvyD5d0GcMVRyZV0VE/3fxH3l7YbmRxMGRR840lqiegYVogxP
         +ZdDU38xLiJ54zhxXBSD/bALWR7/oz/KNwaj18G6yIkNeZYolcrVoWiqiLLRLz/UC033
         qN3w==;
        darn=vger.kernel.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1792407850; x=1793012650; darn=vger.kernel.org;
        h=content-transfer-encoding:content-type:cc:to:subject:message-id
         :date:from:in-reply-to:references:mime-version:from:to:cc:subject
         :date:message-id:reply-to:content-type;
        bh=2RjmAJkJaRfKW8CM604T3xdOE/8FYHsXLHXgCKfQYGM=;
        b=hkE25WF3TS5GmwX5rJIjm82r6l8ivurb5IXDVfJwUrMsU5PL2R2qw0QLzZY3D9tmIJ
         K3flmfB5VEVE1d/YIXwoibHUETJeJtOd43MmhTGeG+g8NKFgYrqRnttLtB722NsOu2m5
         dLbEM8JhoOUn3lpLAvd8PAl8Exn5J2ioRqnDfiM5UMmpoxgyuC1/xyjtDnk1suZbGUQx
         zfjYQZzMN2A3LhfSmySpIvtusTR8Ej4jkGZ5pdcKoWnND0YkcLrPFZ2lbQKxHfDFa8J1
         5zTNyMPiPKbY9f+DcepKc8q6UdSfAOBvj49wYV5DUKgP53niPT4gSGzGApQfsZImqIf4
         Y9TA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1792407850; x=1793012650;
        h=content-transfer-encoding:content-type:cc:to:subject:message-id
         :date:from:in-reply-to:references:mime-version:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=2RjmAJkJaRfKW8CM604T3xdOE/8FYHsXLHXgCKfQYGM=;
        b=GPByc+GHp491fUC24ReWB6mS2OzYQirrODl34DNAq2lwzf/4co/6aAEjbL63Bod/TR
         7NSfrYW+C9tJQo+29BCClBMiBjMd8IRx4pIip2BzQOftSjwxVZWfS/F0bkxgpul9D218
         TnV3CfQzTpOv6s7MiIq/5dXQVZ5eoIChXabWzs6fmbmniwODSf7+QBvWiPl00Mr3/CYV
         B4SbJR+iLvoOoxLSw3GvpKjSBi8pzXPVJopupcBl3KPlQXkRF5CzrlBHOCZ1Ve7jUTG1
         /cJDWaO7LgBdsXqDgrxaCVSGdM6eOvJqHgL5/9sQjHziz9yTlJeUwkQ1lNQNQftMK0yp
         txmA==
X-Forwarded-Encrypted: i=1; AKwUvBzM6RGgymcc2N7oc9n5cJL34uNxiAvJ6qiguM3er8qP6fwKu0fui+zLoEUHDFPG0C/Qx2120eM=@vger.kernel.org
X-Gm-Message-State: AFq9FYL4DdUvcHF1lfd6F+WBCHecHSWnojtE/2g37Lr/Mg76050kBJK5
	Hj4zVZGc29bKYakOjCl65u/c554L7l0SxOC6Ceui9WYbQE3wlhymnAe7/zL4WGta0XYXfDeIXBM
	DYkOG9iyT44FFRjP0gxXbEa7A0rn62md/hYTasoY=
X-Gm-Gg: AYBFou0Foy53I0HiexLAwp5hEnhR8TlWnm1VW3EC8tD6ZMj74WMjUzJsVVuSAL1qIRu
	Z687ruxJSXU2ZMTh1Dl7Jl+D3YrlB8RhgKQ9pweQFfnVquMLz3Ou4F+2lNI4nWrPlrCBWAoCm0k
	ptVkYmx6U+2G7fq78DEdADtGNROxCMJRrVDUxZ7zkpMkyidocL6mUt7BzUC0j9Lbe5tqOn421vp
	YTLXsZj61WYJgx0eRLyQX37o7ACJ0jxmxs86ZAV6+Jgp/58yby/8TQ4VRrxsUBAYEDVTaNw29Gt
	wb2Pj3iyJyJCNak3UkqVi52Ls+vKVQiEauENsAFLop34y6HO2d7qbJ0Qcc7s/GDGjtxHHMvJoOM
	pRQlCg+fMET51YZYf7IF1qLg3EhFH5jve7qFGch2E
X-Received: by 2002:a05:6808:3509:b0:53a:6769:c35b with SMTP id
 5614622812f47-53ccaf1f442mr5332468b6e.12.1792407849778; Mon, 19 Oct 2026
 04:04:09 -0700 (PDT)
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20261018-vlv-dsi-owned-gpios-v1-1-3ca18bcda670@gmail.com> <atXp2NSPKZUPj8sq@ashevche-desk.local>
In-Reply-To: <atXp2NSPKZUPj8sq@ashevche-desk.local>
From: Michael Anderson <mwwa919@gmail.com>
Date: Mon, 19 Oct 2026 07:03:57 -0400
X-Gm-Features: AclHuK8biEMfZ_1GVer949iI38PfSha8JvD86j9Plx2_choI2YB3QRBY5aZp0yo
Message-ID: <CAL-Wm=O-Gr3CuvCn8iSQceQMhu=LGFz0SPhmWeFL=RiVnoprdw@mail.gmail.com>
Subject: Re: [PATCH] drm/i915/dsi: Use owned panel/backlight GPIOs in VLV MIPI sequences
To: Andy Shevchenko <andriy.shevchenko@linux.intel.com>
Cc: Jani Nikula <jani.nikula@linux.intel.com>, Rodrigo Vivi <rodrigo.vivi@intel.com>, 
	intel-gfx@lists.freedesktop.org, 
	Joonas Lahtinen <joonas.lahtinen@linux.intel.com>, Tvrtko Ursulin <tursulin@ursulin.net>, 
	David Airlie <airlied@gmail.com>, Simona Vetter <simona@ffwll.ch>, Hans de Goede <hansg@kernel.org>, 
	intel-xe@lists.freedesktop.org, dri-devel@lists.freedesktop.org, 
	linux-kernel@vger.kernel.org, stable@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

Thanks for looking at this. I'd like to make sure I understand before
doing a v2.

Here both users of pin 10 are i915 itself: intel_dsi_vbt_gpio_init()
takes it as the "backlight" enable GPIO (soc_panel_gpio_table,
PPS_BLC_SOC), and the VBT MIPI sequences on this tablet then toggle the
same pin as the panel reset (low in ASSERT_RESET, high-low-high in
DEASSERT_RESET). Do you mean describing pin 10 with a software-node
"reset-gpios" reference and having both paths go through
reset_control_*(), or something else?

One concern: the VBT drives explicit pulses on the pin, and shared reset
controls are refcounted, so a pulse from one path wouldn't reach the line
while the other holds it deasserted. Would an exclusive reset obtained
once by i915 and used by both paths work instead, or am I missing how
reset-gpio handles this?

Thanks,
Mike


On Mon, Oct 19, 2026 at 5:58=E2=80=AFAM Andy Shevchenko
<andriy.shevchenko@linux.intel.com> wrote:
>
> On Sun, Oct 18, 2026 at 04:12:40PM -0400, Mike Anderson via B4 Relay wrot=
e:
>
> > On VLV with PPS_BLC_SOC, intel_dsi_vbt_gpio_init() requests the
> > backlight and panel enable GPIOs (INT33FC:01 pins 10 and 11) for i915
> > itself. Since commit 8241b55f1ded ("drm/i915/dsi: Replace poking of VLV
> > GPIOs behind the driver's back") the GPIO elements of the VBT MIPI
> > sequences also request their pin through gpiolib, so when a sequence
> > toggles one of these two pins the request fails and the toggle is
> > dropped:
> >
> >   i915 0000:00:02.0: [drm] *ERROR* GPIO index 10 request failed (-EBUSY=
)
> >
> > Before that commit the pad registers were written directly, so the
> > sequences could still drive the pins i915 owned.
> >
> > The Toshiba Encore 2 WT8-B (Bay Trail, DSI panel) uses pin 10 as the
> > panel reset line: MIPI_SEQ_ASSERT_RESET drives it low and
> > MIPI_SEQ_DEASSERT_RESET pulses it high-low-high. With every toggle
> > failing, the panel is never reset after i915 sends MIPI_SEQ_DISPLAY_OFF
> > during takeover and stays black, even though the backlight PWM and both
> > enable GPIOs read back as on. The tablet only has a usable display
> > with nomodeset.
> >
> > When a VLV MIPI sequence targets pin 10 or 11 and i915 holds the
> > corresponding descriptor, set it through that descriptor instead of
> > requesting the pin a second time.
>
> Ah, nice, this should be solved via using reset-gpio, which is exactly fi=
xed
> for the reset shared lines case.
>
> --
> With Best Regards,
> Andy Shevchenko
>
>


--=20
Michael Anderson
