Authentication-Results: smtp.subspace.kernel.org; arc=pass header.oldest-pass=0 smtp.remote-ip=209.85.219.48
ARC-Seal: i=2; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=pass;
	t=1793655151;
	b=wDXu9v16d4yZ31axgo3PRk0ISMvqEhj9ENo61NKasSVH28FpH0h3AzkYdembM4gCjXjY
	 5EFZz63EFZ9taMU8SljVzCykfDCy8pMxq4Bzblvbn/aqJ17bN1bzl0Mrkituz3jT1nX2x
	 FCb7uzavs7kYQOCpglYlW5XoEar14ASCEUBvXR9lbfz+4puKO4jatfEGRpxubaCRcgyMO
	 Lp7O/38JJNV0NbL1Tmwo9HuOzp7Vp7/7HbdfkW1YteDEvNRvFoSIDXnE3cTamuPai2a5K
	 Db2ZTden1YZk4Zt2ZMtR8Q9UQc6lvW+QVy9H/UvK9aL5EFLtEXHFOiHnR/mxakcwMTw==
ARC-Message-Signature: i=2; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1793655151;
	h=DMARC-Filter:Received:DKIM-Signature:X-Google-DKIM-Signature:
	 X-Forwarded-Encrypted:X-Gm-Message-State:X-Gm-Gg:X-Received:
	 MIME-Version:References:In-Reply-To:From:Date:X-Gm-Features:
	 Message-ID:Subject:To:Cc:Content-Type:Content-Transfer-Encoding;
	bh=Dy/3+y6cTy46fWlcbVMD558vn7aro/Q74xHtkgWN7Dg=;
	b=flPtOTjZxDNaIUIL/xxxhh6LB1eBMqCrrcBll8V6EHbrMvyiIG9PBAdfyFKhZD2xLcFe
	 Y/2u4SLSCgPJQAUs9gbTKDD+wcpPs/O/NYDSnIovWhBOx9lso4VkMlZnozDTxAZp88ImR
	 QPj/KwTk/Q86MlfsLuIHLZI/lfqVFpcg0ybN8WSlIXHN2qcck2enQGhSZpE5UWrabo07+
	 hCYxIwlbt5deRBqg0oU5xghJ0tq0gfFjRrlJbkeHRHtjSDNJwtQlXaAdR3XuwXt78Ylto
	 rDjRZ2VDdjCbfd2aP/XlXA8yVVKXjEWGTjqLmCpv5YmAR8SkIv4PEqnI3r9zzpES/6w==
ARC-Authentication-Results: i=2; smtp.subspace.kernel.org; 
	dmarc=pass header.from=gmail.com;
	spf=pass smtp.mailfrom=gmail.com;
	dkim=pass header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20260707 header.b=OJBl9LUk;
	arc=pass header.oldest-pass=0 smtp.remote-ip=209.85.219.48
Received: from mail-qv1-f48.google.com (mail-qv1-f48.google.com [209.85.219.48])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A0666606A327
	for <stable@vger.kernel.org>; Mon,  2 Nov 2026 21:32:30 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org A0666606A327
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20260707 header.b=OJBl9LUk
Received: by mail-qv1-f48.google.com with SMTP id 6a1803df08f44-91c905d7b6bso37332226d6.2
        for <stable@vger.kernel.org>; Mon, 02 Nov 2026 13:32:30 -0800 (PST)
ARC-Seal: i=1; a=rsa-sha256; t=1793655149; cv=none;
        d=google.com; s=arc-20260327;
        b=RUgxh7XJ5yAlG9CzH582U/oDhElh8s1GTztaAwFS/CwSrX9VXq44Nxvxy4vjaHF6DE
         hmUoL4dpAFWKJBZNbzKquJeE6R8qGnpJgWX4dUzdlYFyPiUtXePC57fTwU4PdrrRCJ3u
         hoPvDXX3pDAJ7gIiS4pwdvvLk7AQP1WC0HujSIOPeO2yWkgZC6d2mrxWoZAXDBIgVLYr
         Jz1ahDEB3vteMCtQpepNcWgJFd5eMuz47BXRCFnKTc94wJMmsGERKRI4//kYvfaOao9r
         Or1sLvHTjPkWF3bh2jWKMvCefPQBOudkhzgutqHgthCRU9Hm35uO3kjvUxxR0ry4y9VJ
         ZyAQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20260327;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:dkim-signature;
        bh=Dy/3+y6cTy46fWlcbVMD558vn7aro/Q74xHtkgWN7Dg=;
        fh=sKw3zjKeojfQFXZ7CV6t6ZPgI+8iEPCFlQqF5Qj7Ims=;
        b=h0AaGgJ/HRCnjA2WJnXA6OpnTcm8eeJPtAJxzg6XOqKG+EnCUQcYZN9wXKRFYvpxT3
         4JWEHq+WgSbP7zPRJn/Ys7fycdOM0/VTMgEIoqhxcYkOfDPqzvBYp3S/0ZxtQwzTvp5a
         0E0IegeIgcsCKUI4S+kYCJTU08ZsZXsaNbzzloUn8bOS+vZ1XfoPyZEajatDC5QRx4+W
         pWv1Cgimt+woSBpSuWq7C6F4bnX/T0xCVXlwSN5IXX/wikh7QODSsRgQjHkXpu606bbq
         vtbjngdwo3OQb+UQFqHk/1WTikW8zGlxAbqkjmT37ILWhOmQTEkeHkyHgX8LykSEEPl/
         O1Dw==;
        darn=vger.kernel.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20260707; t=1793655149; x=1794259949; darn=vger.kernel.org;
        h=content-transfer-encoding:content-type:cc:to:subject:message-id
         :date:from:in-reply-to:references:mime-version:from:to:cc:subject
         :date:message-id:reply-to:content-type;
        bh=Dy/3+y6cTy46fWlcbVMD558vn7aro/Q74xHtkgWN7Dg=;
        b=OJBl9LUki163v7WEot8KNBkz+ZyHxB3U3PZWOzUQnqU1C9gwNWqMqo4ep2zJTiF76E
         H27U0U2Y2xU1edkWPvCXKNlTdh7FHNvP6iPCbdbi4N485mFhvwTigF1MWvhKjB3dtraS
         rVPVpUnl8PFkyNlD5j8BF8pdDkAdWyttJ0cI7ax1saMKaIKfFduWLBkxscuo7Xjswgmk
         KWgTFFt3DNYb1YENzHWh81+7DLhh4cD15nS0R0RZswSSg1fEUniAiObyXCdPXUw4E70b
         LdyxMtqanpWwzAvoE/TOYetmETdsu/uLnQujF+lPJWE/HBU7sdTJaZxo3v+UlCUj6GfD
         Y9kw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1793655149; x=1794259949;
        h=content-transfer-encoding:content-type:cc:to:subject:message-id
         :date:from:in-reply-to:references:mime-version:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=Dy/3+y6cTy46fWlcbVMD558vn7aro/Q74xHtkgWN7Dg=;
        b=aMSBgV0e9Ilkv2MuBrHgUF5thKBL+72fC8IOEFRQoZwzpVfPlJB9D2uoB94bSQbhOO
         BM4ra0OLBFSCx2/Xpyg/iKhaoPnYMXN/lsx2Ji6rCnfC5im576m/7eqcWECGlAoET0Im
         1fWMmIkXLtX+Uv2YUGEyelHcUlfNAjjiNngWNVGB6ChWiuj63BEK8oCJi1D9XU8uo6fF
         HVeM4LEPFJr9cOeMOEoSnBadW5dMco2NW6K3mZJvLrU7mjhd414/IP8JBJFjMJdH0Mi0
         ec1bdFecMgT3ivEKX9LUOfNTH7eaBcNptW0os2zIuSk971WH6Z5q+0B5Nuj5cVOU2Bae
         G4ug==
X-Forwarded-Encrypted: i=1; AKwUvBwkYWCOhU39Ecth8UQk+rHSr71WiQyTNfwTGQjvM2tEXHRAIfQg7O/QKV4bvTOVlnsPoHutgwY=@vger.kernel.org
X-Gm-Message-State: APuU4Z8qr8j1pdsJKhWJGl4LR4tL7hz3En94ko0861gH6hGXH7r9W2cv
	aEkzUeHFiqwFtgLqWuvCtA7JWJhzhWjmfIC0oHSegzM+HtkL0YYd2BEoP1IW6Hpclfxg4X+p+J0
	B8flMreCb6xH7Ot1ErrQWGBPtgaiF+nU=
X-Gm-Gg: AYBFou3GjX2SO/iQ6JqiAVJtXq3OxwMe4/MXNvCMFNZQfUec3jwIC13OJwKblZ7UGng
	9XX9BzfWeTMnakUJ/Zow40dN7yZymO3ACrpGi8WPIi9/jHKE5n2PIwkMnrys/1oxpc+A+8IqCJO
	cK552WVP+aMVFNdMgqzWROs/d3cNvYBhYMHPBZuoohxY+AJ4SarCPTx0NHOT3lkplRu9iFOupIu
	JFNnLGDg9lR9dnpVvI+MG3YGDqgaF07OHX9qOjNsivxOMYnpiCkPHouTlE7V0B98tFuvhge1WaH
	oSXhcbqJnkNeEPbILy7q99IeO7MS13iWkOsII0BrRNMTiACC9V6dEMxFZi0ncKboIPlcZDLTeHP
	6D+LboQax3mgOTtLzgnfTDqa+amn7bJ0Al070dof/xEk90FPivft6Qi4Y7A==
X-Received: by 2002:a05:6214:2403:b0:91c:a2b0:dd0d with SMTP id
 6a1803df08f44-91ca4ae1111mr177407566d6.17.1793655149330; Mon, 02 Nov 2026
 13:32:29 -0800 (PST)
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Post: <mailto:stable@vger.kernel.org>
List-Help: <mailto:stable+help@vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
List-Owner: <mailto:stable+owner@vger.kernel.org>
Precedence: list
MIME-Version: 1.0
References: <20260927041138.4112920-1-jinmo44.yang@gmail.com> <20261024033040.316652-1-jinmo44.yang@gmail.com>
In-Reply-To: <20261024033040.316652-1-jinmo44.yang@gmail.com>
From: Jason Gerecke <killertofu@gmail.com>
Date: Mon, 2 Nov 2026 13:32:17 -0800
X-Gm-Features: AclHuK_Ep6UP7A60iM8FcMVyZcPHYDAlQGKDcoV_PVYPLMetFNaYY3L4D27BGc0
Message-ID: <CANRwn3TaYNa-i-c-1AOdPb4HVS8otBhFUkFbMFPnwzeKKwHcBg@mail.gmail.com>
Subject: Re: [PATCH v4 0/6] HID: wacom: guard against NULL input devices on
 successful probe
To: Jinmo Yang <jinmo44.yang@gmail.com>
Cc: ping.cheng@wacom.com, jason.gerecke@wacom.com, jikos@kernel.org, 
	bentiss@kernel.org, dmitry.torokhov@gmail.com, linux-input@vger.kernel.org, 
	linux-kernel@vger.kernel.org, stable@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Fri, Oct 23, 2026 at 8:31=E2=80=AFPM Jinmo Yang <jinmo44.yang@gmail.com>=
 wrote:
>
> When wacom_setup_{pen,touch,pad}_input_capabilities() returns -ENODEV,
> the corresponding input pointer is set to NULL but probe still succeeds.
> Subsequent irq handlers dereference those pointers unconditionally,
> causing NULL-pointer dereferences reachable from a spoofed HID device.
>
> This series adds per-function NULL guards across all affected handlers.
>
> Changes in v4:
>   - wacom_intuos_pad() now returns 2 for the normal path, 1 for the
>     NULL-guard path; wacom_intuos_irq() applies "result - 1" uniformly,
>     suppressing the spurious input_sync() the old "return 1" would
>     trigger (Jason).
>   - Added pen_input NULL guard at the top of wacom_intuos_irq() to
>     protect its helpers wacom_intuos_inout() and
>     wacom_intuos_general() (Jason).
>   - Added pen_input NULL guard to wacom_bpt_pen() (Jason).
>
> Changes in v3:
>   - Fixed wacom_dtus_irq(): DTUSX is pen-only, so do not require
>     pad_input for it (sashiko-bot).
>   - Added patch 6: touch_input guards for wacom_intuos_pro2_bt_touch(),
>     wacom_24hdt_irq(), and wacom_bamboo_pad_touch_event().
>
> Changes in v2:
>   - Restructured per Jason's review: per-function checks for dtus_irq,
>     graphire_irq, and the Bamboo handlers.
>   - wacom_intuos_pad() returns non-zero when pad_input is NULL so the
>     report does not fall through to wacom_intuos_inout() (sashiko-bot).
>   - wacom_intuos_bt_irq() guards both pen_input and pad_input (Jason).
>   - Added dev_warn_once at every guard (Jason).
>   - Dropped the cp2112 patch (Benjamin prefers Dmitry's series).
>
> Jinmo Yang (6):
>   HID: wacom: check the input device in the shared report helpers
>   HID: wacom: check the input devices in the legacy irq handlers
>   HID: wacom: add NULL input guards to wacom_intuos_irq() and its
>     helpers
>   HID: wacom: add NULL input guards to wacom_intuos_bt_irq()
>   HID: wacom: add NULL input guards to Bamboo handlers
>   HID: wacom: add NULL touch_input guards to remaining touch handlers
>
>  drivers/hid/wacom_wac.c | 127 ++++++++++++++++++++++++++++++++++++++--
>  1 file changed, 122 insertions(+), 5 deletions(-)
>
> --
> 2.53.0
>
>

Apologies for the delay in reviewing and responding. I'm happy with
the series in its current state.

For the set:
Reviewed-by: Jason Gerecke <jason.gerecke@wacom.com>

Jason (she/they)
---
Now instead of four in the eights place /
you=E2=80=99ve got three, =E2=80=98Cause you added one  /
(That is to say, eight) to the two,     /
But you can=E2=80=99t take seven from three,    /
So you look at the sixty-fours....
