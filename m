Received: from mail-lr2-f12.google.com (mail-lr2-f12.google.com [74.125.230.76])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DC1164BB27E
	for <stable@vger.kernel.org>; Mon, 21 Sep 2026 17:55:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=74.125.230.76
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1790013317; cv=pass; b=D8cUZdIx2Y9I4j3YI710bU+Gfx7vMRpdJY0l25espUs6MEnYo/ck/Z8Yejl4HLIV9pRNX6U2z0jT1o4U5fMK754bUEeoR6Xar6Ytzcfh1aVxxuZc+XcZntC1o+Cbwy70DZb7YeE8SV/YyCFEvM4+nvAGzzFTOBkbKGx+4XcSdjI=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1790013317; c=relaxed/simple;
	bh=sDKcd2FnnaAXCfLgzj8Tgw4fSqF8/9G0zE8D9gcitow=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=kbF1ahmUXGoxYo+slsTNMSbr3mMTwC1AMfhfSIEqPu0449t+OWc/A0n4djlm6wOvxIxTKUer2hPOxXDo9SMUd5fXateanDgDv1FlkJaEnfPMcrjuPF6w0cNd4umsYey0RXV3OEz7HzzmKlZb3qX/zW95h8B4WthOF7XyotCfU+Y=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=gXdVqDzL; arc=pass smtp.client-ip=74.125.230.76
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="gXdVqDzL"
Received: by mail-lr2-f12.google.com with SMTP id 38308e7fff4ca-3a2ff148dfdso21568441fa.1
        for <stable@vger.kernel.org>; Mon, 21 Sep 2026 10:55:14 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1790013313; cv=none;
        d=google.com; s=arc-20260327;
        b=n+gY/z52W+TV3bsCZNu+iATCZehPe5JZSYT1u0ZYXcVma+E+LKQtn9roS+JZVjNeOz
         9gxP+mFNBIW22Epi9ZPIfXIsHEaEyh07+xgsgeioePco8ywinKNO23ciq3eusceDuRQY
         +O1FprPX+bRG+FUH+hR+NH/+3QLW+Q6YJnO+Sx3BLzLk9RBBCmJVjkJiNer2JoI/bSZt
         0U+j1L9KNT8+LM7IdrI5cK4GXLZASaVT2SlMmYbNmYKSMXc+A0BTQNSlIJz358RiQ7JY
         uNO2U1aHFqfWrYw9zIA3v6dRVR8dst35TH60vpANxGk5kViKRKlJ4iL/3sZmbYL8G2Ft
         ohmw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20260327;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:dkim-signature;
        bh=Rjabd0V8j0ZscLDVjxMT64ulH3IQfQTqiOQYhc80Tds=;
        fh=Om70pKKg5d86+0zyx1Hmg/HCNed6n3M9Vk2hziW5jSU=;
        b=Bwid9v1EpiuBVm7FE7xQVNgLkQJafsbehtdQKc4P6pxavyTvPc946vX9Qog2uYMnR1
         icW+a/0SBbr+9C5rF2o272RZXksqpupJosMOkLITk9SVTaLqrpiJqULe9CGtWHaj4aMq
         fRvyYNxz8UP3DlwoC82nK3/zj99TnUTtHdWxTD5ZcHj3HzBdJoqCPMplGP3ZQ++/FCal
         AGb+5U52U4fRSvbuAFandLihwQ92gFVk9skQM4nakJyCnp/BE3Y4/wbyt6QAKDyAdT+f
         BvgXO4uZZ38MwJWCW+8IxkbekfNcqvpyYBIrjK99xk/jXi5kDPPd8UJGkd3l4KKAk3b7
         YaAQ==;
        darn=vger.kernel.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1790013313; x=1790618113; darn=vger.kernel.org;
        h=content-transfer-encoding:content-type:cc:to:subject:message-id
         :date:from:in-reply-to:references:mime-version:from:to:cc:subject
         :date:message-id:reply-to:content-type;
        bh=Rjabd0V8j0ZscLDVjxMT64ulH3IQfQTqiOQYhc80Tds=;
        b=gXdVqDzLQhDmrUvDEHUFjOxhcxrcG7hHZ1GQtVok3T2jTX5fhXH6ZvrmliWDBrN7aC
         EeB18IVqNgV8L8u1aINvUdSJEvpUbeElJ4y4Sq1EKVtvSNB3DRP7D1UN3UregOQ3MGu3
         NdUzdStnAGMvLdkKKGHLCsdUtQXn8JTdjLHVp2dFzokwMxkGieLrMeTtlt1hrTGSlgWz
         7f7z9LWzcezUj+BArUd9Mlq3oaIcS92ofbmIyI29PwyM56GYtHqK1krS/a6qhsDSZoBK
         JGaK+sb57Hi9GZNNWBZhppZkMoStadqCx7OyuQ61Ubp0HzonQmuokFwyLRs90zNnJBP7
         GuiA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1790013313; x=1790618113;
        h=content-transfer-encoding:content-type:cc:to:subject:message-id
         :date:from:in-reply-to:references:mime-version:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=Rjabd0V8j0ZscLDVjxMT64ulH3IQfQTqiOQYhc80Tds=;
        b=MtVdEdzFCigEXb0jEWpSaEFk+vyTe++gDlYpJv6sRMADEzXUC9HqqsBOWuOWpUe7g5
         1mUmbdixv3G7LBAemdgRBYfqvw4NvGkVllCdXO8uBvhWYEOmw5wkAMsqLkpfxwAOqnqY
         n3RCfReCTbVkkmIMvJCqePR0mD86mNNbl0Zkm7YzcQWU7+K8qPE50gTI6LBsS3y+DQVL
         JL7PYCOFKPWd1E7wmXObnq9R5MLjYz0oOvxsj1l+jhl9u/UkqjeDg9/LLVh3jD99lpNW
         kExmcyQ2LL/xK2upxvskwMELSYfjcLA/v0FlEsQCcbacW1iIkfqUC4a3kLlrU8XKngwm
         gZbQ==
X-Gm-Message-State: AFuF++mu5+9xKzC4J+l3rEtJ6EdWPQ8hlClgrXhD8bbm6SNPSYeru4kN
	DZ84SMMLJGJA6Br2OnKq+E8ijstjyW+lRwprpKqfouomKU7CZux5SQIbKGSq2tWoolVlZKzyCqG
	pmtRMAngURkfWnmAkYmzeNMn9ua9Ni7g=
X-Gm-Gg: AYBFou152ijrjiPVX3/hdbO9fuVhxEopcNHc0OfenSihnlVE7v78/vtUtMmdLhICK/G
	lKnIngjWDhcpOIvoUjn2x6/OKIJqyfZC593x6K5u4giibTZoqBe8XpISmR5DTKLYfwXAIZyiwDr
	FUGlajIvpmW3hZbGAMCwbk2+CxPaEcD4anTdn0Wx6b3FxDFrvoF92J49y50tMvF+Fuo+hjoy7k4
	AjzE4lAlmtwLtlg2nt2LVwm+iCQa8y4w3Lj9S2OQWTql0xvZjMa6vsNH6jSrKh/FuGwqVX+gSs8
	S6qd0JNPETgU7rnwkUKN73no5OOI/OatYnS6dK0AXrfjVmru1fcrUs0VRG69JWe6axamqdaa2Zm
	/M48EdzZw961+uA==
X-Received: by 2002:a2e:a596:0:b0:3a5:ba1e:8b05 with SMTP id
 38308e7fff4ca-3a5fbeb587cmr24355231fa.1.1790013312546; Mon, 21 Sep 2026
 10:55:12 -0700 (PDT)
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20260916020301.24188-1-ping.cheng@wacom.com>
In-Reply-To: <20260916020301.24188-1-ping.cheng@wacom.com>
From: Ping Cheng <pinglinux@gmail.com>
Date: Mon, 21 Sep 2026 10:54:58 -0700
X-Gm-Features: AcwNN1WsqrMyphsW-EW6Ps9_PEVpIsbZuIuSPnPJCCSeEIrGt3RcSjG4E58g2RE
Message-ID: <CAF8JNhKTVO7xro4qAoq4NG=4TWheb7rFU93AZEfeRJfJeqUfRw@mail.gmail.com>
Subject: Re: [PATCH 1/2] Write shared touch initial status only once
To: lee@kernel.org, jikos@kernel.org, bentiss@kernel.org, 
	linux-input@vger.kernel.org
Cc: stable@vger.kernel.org, Ping Cheng <ping.cheng@wacom.com>, 
	Jason Gerecke <Jason.Gerecke@wacom.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

Hi Lee,

Do you have any questions about my patches, especially this first one?
I added it to make the assignment consistent with your patch. Since
the is_soft_touch_switch can only be set by pad, we would only get to
this assignment once. It won't be assigned more than once with the
current firmware logic. If you don't see an issue with the patch, can
you give it an acked-by?

The second patch adds the softkey touch switch back, which is
important. I hope my fix can be merged upstream along with your
patchset. Otherwise we break userland.

Thank you,
Ping

On Tue, Sep 15, 2026 at 7:03=E2=80=AFPM Ping Cheng <pinglinux@gmail.com> wr=
ote:
>
> From: Ping Cheng <ping.cheng@wacom.com>
>
> To match the same logic as with other shared data during registeration,
> use WRITE_ONCE for is_touch_on too.
>
> Cc: stable@vger.kernel.org
> Signed-off-by: Ping Cheng <ping.cheng@wacom.com>
> ---
>  drivers/hid/wacom_sys.c | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)
>
> diff --git a/drivers/hid/wacom_sys.c b/drivers/hid/wacom_sys.c
> index 8dc7aa1c0a26..33fa491fba92 100644
> --- a/drivers/hid/wacom_sys.c
> +++ b/drivers/hid/wacom_sys.c
> @@ -2386,7 +2386,7 @@ static void wacom_set_shared_values(struct wacom_wa=
c *wacom_wac)
>                  * match historic default.
>                  */
>                 if (wacom_wac->is_soft_touch_switch)
> -                       wacom_wac->shared->is_touch_on =3D true;
> +                       WRITE_ONCE(wacom_wac->shared->is_touch_on, true);
>         }
>
>         if (wacom_wac->features.device_type & WACOM_DEVICETYPE_TOUCH) {
> --
> 2.55.0
>
