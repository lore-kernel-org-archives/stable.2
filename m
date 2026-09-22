Received: from mail-lf2-f13.google.com (mail-lf2-f13.google.com [74.125.229.205])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A303B52BE31
	for <stable@vger.kernel.org>; Tue, 22 Sep 2026 21:17:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=74.125.229.205
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1790111853; cv=pass; b=GyE2+jRQQVehUCCOIhbvZEo9IIAevOjv2rTL2NDPC/DCHtEcxZIsnwI2bRZK1Ddp+3z+ZUzFAccXZAgWxQDvHovewE6FKApfXFRys6MhU7tiBDlCR7w7LkgxV/mLRHgd7sOE/BH8buA86SWDKo32ttdWzFJC3t3lf/jw1CjUoZs=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1790111853; c=relaxed/simple;
	bh=n+Yzo7ihSKHs3bpGXiSBg3zFQX8q1yeHsiwSB74gv74=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=aIkIEeAOcBxy75Qi72no7/EpXe/E3L9FGo01/tvsPA1aVkU5/fw+76PreCVKVCUoYV+9a0bY3+okDw0JXMA7qgn88CWwY9YN0ClXHrlpZfXLigpzKbOvbWWKvH9rGt3Wk0F20xg42ydYCIIC/UFZ+AfO5o1KK4qLEASmxipWswI=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=lwKxjG6T; arc=pass smtp.client-ip=74.125.229.205
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="lwKxjG6T"
Received: by mail-lf2-f13.google.com with SMTP id 2adb3069b0e04-5b8d064e595so202047e87.2
        for <stable@vger.kernel.org>; Tue, 22 Sep 2026 14:17:04 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1790111821; cv=none;
        d=google.com; s=arc-20260327;
        b=fKrjDQ5BchBcoEV4882IkJGW2jRTpUCIHT/LQGCwYyAXMiHKj2Rj1j0xKBfgnrCSiF
         vIfLZdXyRKzTDbYAw+ttEKiAA7kxAN2bxhfYQSmyYj4ragILEkTEFdt4/dfvUPscrPvH
         pR5HQFgU0HvJJeG/HN5YNrKAJ0wQss1PjyN45FRN+dghLhoU8+FWyDz4NMJOs4lbretX
         Yv7P3V6JBK2+8CzHf7E1gxrgaMoQS0t5sX2pnlPIe8dmoAzM7IkcASSRtWfwWS22SVNZ
         XiHLYscZpDghe5H348Zsus3sy/IUS8qwGAqy8ygYdbK2LlBspXlTsGoHH6C2H4h6xAFx
         1eYg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20260327;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:dkim-signature;
        bh=tmx5dBbmMlKCVVFF4vkR3MxavF7GRtAH3Uv9OpL0m7E=;
        fh=o7MCfSBpH0hC3Hx+IcpSaJn+QQ6Qo8pSJlmsx6Jv65Q=;
        b=TFsTNRRjwDQN7vjcw/iTH9CNhnHtE3n15nqfX/DQJAz52bxlAz76M8hUO5fLUYD/vG
         OT1rIWY5d//9nTfDPY3unBFS4dLWsK5RRh3DP3figwCXUN6f8gsNmmoIx/vVl0tOo43I
         cPR329lfiwz549mo42rxSoY3dBObFBU9eJiq81d9+tSZfUMsNFmkZ77rP33Lhm2yRlDu
         s4P15uIP/2obaYslu58a0GTsgpPDsKlgjtyLFEpcTfBAij+13P6fkHcKlHBkVjOTyiyY
         lepnD585bT62LJRcmbJVj9rqmYzrRxUP5OpBxp07cN629VIXkhyqq9uB5irGQJ1rhn5r
         aXaA==;
        darn=vger.kernel.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1790111821; x=1790716621; darn=vger.kernel.org;
        h=content-transfer-encoding:content-type:cc:to:subject:message-id
         :date:from:in-reply-to:references:mime-version:from:to:cc:subject
         :date:message-id:reply-to:content-type;
        bh=tmx5dBbmMlKCVVFF4vkR3MxavF7GRtAH3Uv9OpL0m7E=;
        b=lwKxjG6TVc81TAoOC1s7xFV76laRhL4E4FfXn+R0cLK9dU2PDiVpgKVsnzFUgXhQyl
         KE37ecK+SDpeIyD5tJ0XyvduTyRxhHDmGP5IMyczEbbN/EN5WSyLj+oCIJb2inyL3LwC
         mFsOckbubVhwSRWkDdYC7407+cXaoYk+baSAjKPO9B2og1x5zDGsyp0VUCZ+xOsY1S2Y
         4BgcnZS7srPLss14CXe8vU44jZUc3PQQ7+c0JudKG0BNCwkUl7CCNv/WUKa8nWOYQ3VN
         HriDZhmOVND4630enYprHQCib8bomkE5ySJCGFh/SHbjlqhfHnNXdsYscls9p83JqSjO
         AC/Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1790111821; x=1790716621;
        h=content-transfer-encoding:content-type:cc:to:subject:message-id
         :date:from:in-reply-to:references:mime-version:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=tmx5dBbmMlKCVVFF4vkR3MxavF7GRtAH3Uv9OpL0m7E=;
        b=nhwa8xLwv0Tr23WNEbSXQu1Ja2Sg/ZIZpTEwCJb14R+r1AKXtXuG/NppQPrhGOOQZA
         tSS6AcrEwSa5kVN4VnN0y/7ILBoaOT9ytJG4lu50AwhcmSp1YpqYZfvfxnN8itRJx1t5
         MJ0ca5XT6czT0hBFaOSOaSTM8x7623PjSSw8Ql0vx0EG3s1ReakNKzwpXOAtbljS1HYF
         ytTUkqbvXo4RP37xbc3Uw/l2QsZBhL8/u2Hd8DlAefDpuY1eY9ipSJEbVpYtZQWeTVtY
         ZzazWALaXLF7tQBNkhJaPZccz+11l5SzEvHkE1f7MdLr8/hWj9/eBp2WzIYQSrKzIAQX
         lnMA==
X-Forwarded-Encrypted: i=1; AKwUvBzwiDCMoG3+KK80Xq3LPV1Koee/7DBlpKb28wN3eq+Dn0oUquDYm/Qy8Hfhck2PhR6VZWzjAHw=@vger.kernel.org
X-Gm-Message-State: AFuF++n1QpULJUGeBDcGBvBkoxJ5roOswS8W8gz10sTBcOnt5ZI9VBwj
	ZJ1Jt0KnULDmIsAblamlbvUUW3tk0OANXHvcsh1nMHPEa2Du8CacQ4L38w7VJ6/lEfd6qMa2nh4
	v+kmWzobbazfiazLPJqNHgWxGCC1h/8M=
X-Gm-Gg: AYBFou0H9MX/1OJeIlX1+NCsIvUUlMEkunghwSz70hgGN7m2wm0q1SBvtc/K7Hz3rIp
	AAsmufE6/+Ooa5RTMyvLR7Lj3mzxK9yswRJBu0Rf8OvaH93H6aJmNXhurRbP7LZFIvAxYRdF7Jc
	jGmEolEGulmcYFP9B41WT0VFj9XtfTmZIjNtQR7+mDpKp/BGfNSqR1mGzwi/EVojcLZb54r/aze
	4hYNFdFhOWD4rChL5vDVnYzjQzKd9mIyv1VtkBbG2HclKM+Hu/IeeLwDLhhYNrQlsqeH5oMOoLi
	E2XcSct2p19m9KDVI0MLI8ZQ/0ZRmyaz5Qo+FXfq8OepuH7wRcAWNgcyPn2s5pTuBcDugac592b
	Iaha+GL3dLlXqmg==
X-Received: by 2002:a05:6512:2529:b0:5b6:184c:7da5 with SMTP id
 2adb3069b0e04-5b8d89a7b61mr177150e87.46.1790111821108; Tue, 22 Sep 2026
 14:17:01 -0700 (PDT)
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20260916020301.24188-1-ping.cheng@wacom.com> <CAF8JNhKTVO7xro4qAoq4NG=4TWheb7rFU93AZEfeRJfJeqUfRw@mail.gmail.com>
 <20260922073134.GE2348773@google.com>
In-Reply-To: <20260922073134.GE2348773@google.com>
From: Ping Cheng <pinglinux@gmail.com>
Date: Tue, 22 Sep 2026 14:16:48 -0700
X-Gm-Features: AclHuK_nEtr4Ba21HKIDc3_0qWj4Pli70SkewhW_KJdIFN6mva9HRfdm5JV4FbE
Message-ID: <CAF8JNh++y2Zeik9iF=oZTfBsCOPn-J8BrL_gen3rNWrrPNT5NA@mail.gmail.com>
Subject: Re: [PATCH 1/2] Write shared touch initial status only once
To: Lee Jones <lee@kernel.org>
Cc: jikos@kernel.org, bentiss@kernel.org, linux-input@vger.kernel.org, 
	stable@vger.kernel.org, Ping Cheng <ping.cheng@wacom.com>, 
	Jason Gerecke <Jason.Gerecke@wacom.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Tue, Sep 22, 2026 at 12:31=E2=80=AFAM Lee Jones <lee@kernel.org> wrote:
>
> > Do you have any questions about my patches, especially this first one?
> > I added it to make the assignment consistent with your patch. Since
> > the is_soft_touch_switch can only be set by pad, we would only get to
> > this assignment once. It won't be assigned more than once with the
> > current firmware logic. If you don't see an issue with the patch, can
> > you give it an acked-by?
> >
> > The second patch adds the softkey touch switch back, which is
> > important. I hope my fix can be merged upstream along with your
> > patchset. Otherwise we break userland.
>
> Honestly, you know this driver much better than I do.
>
> The change looks sound to my uninformed eyes though.
>
> Bear in mind that the subject line does not match the style expected of
> the subsystem - or anywhere else for that matter.  =3D:-)

I was so eager to get the patches out...

> > On Tue, Sep 15, 2026 at 7:03=E2=80=AFPM Ping Cheng <pinglinux@gmail.com=
> wrote:
> > >
> > > From: Ping Cheng <ping.cheng@wacom.com>
> > >
> > > To match the same logic as with other shared data during registeratio=
n,
>
> Spell check.
>
> > > use WRITE_ONCE for is_touch_on too.
> > >
> > > Cc: stable@vger.kernel.org
>
> Fixes:
>
> With those fixed:
>
> Reviewed-by: Lee Jones <lee@kernel.org>

Thanks for the review. A second set of eyes are always helpful.

Cheers,
Ping

> > > Signed-off-by: Ping Cheng <ping.cheng@wacom.com>
> > > ---
> > >  drivers/hid/wacom_sys.c | 2 +-
> > >  1 file changed, 1 insertion(+), 1 deletion(-)
> > >
> > > diff --git a/drivers/hid/wacom_sys.c b/drivers/hid/wacom_sys.c
> > > index 8dc7aa1c0a26..33fa491fba92 100644
> > > --- a/drivers/hid/wacom_sys.c
> > > +++ b/drivers/hid/wacom_sys.c
> > > @@ -2386,7 +2386,7 @@ static void wacom_set_shared_values(struct waco=
m_wac *wacom_wac)
> > >                  * match historic default.
> > >                  */
> > >                 if (wacom_wac->is_soft_touch_switch)
> > > -                       wacom_wac->shared->is_touch_on =3D true;
> > > +                       WRITE_ONCE(wacom_wac->shared->is_touch_on, tr=
ue);
> > >         }
> > >
> > >         if (wacom_wac->features.device_type & WACOM_DEVICETYPE_TOUCH)=
 {
> > > --
> > > 2.55.0
> > >
>
> --
> Lee Jones
