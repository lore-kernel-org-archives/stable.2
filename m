Authentication-Results: smtp.subspace.kernel.org; arc=pass header.oldest-pass=0 smtp.remote-ip=209.85.214.170
ARC-Seal: i=2; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=pass;
	t=1795426396;
	b=C3ADsfzZ0PN9ZXtnUweCawcOn6EqwHU7/HS0R1Hmgztx7sP3WjXYaTNLottwiURgWCN2
	 yZl/wN5jdMNOX1SWPCHcFanvtysE/XrE6VUDechCM3T6R3r0NLm/DUIKdUGClEK8iLBgv
	 gG0clhQitnbvZxR4M71XBfeKiggS63yxls2UcFryKcu0o8hF7/YJdA6BU6JY+2i/ukoEc
	 Mp/p8G1Tkx6adEqgNPURwqlDkfgQjyKg1Hl6bdFVc4umQrf91gysFyzAEytjCUz9qwlgU
	 bCvTyUhIEXSP4cyUP13V34F4YsXEmZGgQPg+Vaur+LuvfQduTSXGy6tIPL1uNegvEWA==
ARC-Message-Signature: i=2; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1795426396;
	h=DMARC-Filter:Received:DKIM-Signature:X-Google-DKIM-Signature:
	 X-Forwarded-Encrypted:X-Gm-Message-State:X-Gm-Gg:X-Received:
	 MIME-Version:References:In-Reply-To:From:Date:X-Gm-Features:
	 Message-ID:Subject:To:Cc:Content-Type:Content-Transfer-Encoding;
	bh=rEQwJ8ittw+kMTmn3OLooj/VNGKrQlM0GiJz9PEPOrE=;
	b=BUA+3e1FEG1IDPmeChadJv7WKd8cZRo3MxAwBloK80H9RBoTDmmaeRN7M1hnU04TGI6D
	 Uw0yAi1Nj8Yuln/Tb2ceXl+7XZrqqX25SolaWW9+HSkPRtZYRCZS/bxaB86R6Lqr6nDwN
	 VruWb8LThVWbgFjk4qMe+Wwv+9Fqtrin4U2oxF3zy765ZBxnziSp9TLdxWWySapQbTVKx
	 1jn84axCrATMeGRlMk/Ly2vDY94Rb+pgz6kAvVuLQbocXjA83D+7aO/Ef1fSNSuJChdw+
	 NcZM5fm8TPjd6yPVZOUcWWj6ONzVWci++ibljHVaXcDmyURdWVKtcuEcNYugmkmhOoA==
ARC-Authentication-Results: i=2; smtp.subspace.kernel.org; 
	dmarc=pass header.from=chromium.org;
	spf=pass smtp.mailfrom=chromium.org;
	dkim=pass header.d=chromium.org header.i=@chromium.org header.a=rsa-sha256 header.s=google header.b=LXj3nhiq;
	arc=pass header.oldest-pass=0 smtp.remote-ip=209.85.214.170
Received: from mail-pl1-f170.google.com (mail-pl1-f170.google.com [209.85.214.170])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 36845606A32D
	for <stable@vger.kernel.org>; Mon, 23 Nov 2026 09:33:15 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 36845606A32D
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=chromium.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=chromium.org
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=chromium.org header.i=@chromium.org header.a=rsa-sha256 header.s=google header.b=LXj3nhiq
Received: by mail-pl1-f170.google.com with SMTP id d9443c01a7336-2f02b9c1f6fso20199985ad.0
        for <stable@vger.kernel.org>; Mon, 23 Nov 2026 01:33:15 -0800 (PST)
ARC-Seal: i=1; a=rsa-sha256; t=1795426394; cv=none;
        d=google.com; s=arc-20260327;
        b=s04JaUBDZE7nvsPzAnEdceOcFbjWkpUFahVTo4IWyoe0eW2slKbFBcpoQcUKROW48A
         CfJB1bzncPUBjvNxINe3wU648eR+s70ghHg3Y40ew7KPGiaE1svOmnSKxnsh4/dQdFDs
         edxTsHoRSxHtO9QsU5RuLNv9MOkxQqooHMDGzpYZmGRlgZ/qoG66oPbaqqKkexFI9sVi
         68jAF8W6ttqwKYa+gAxnUycVhafy7y2ENv5kDvvpfOwsgg1HtWa17i5fEw4Q9DGdKAL7
         jfBZvlYKuS4ayyH6/Qpf06RqVmH7W4o/IwvSBsDIWg+Koq/DdrY9VlJcYIJviDacUJHb
         kBwg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20260327;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:dkim-signature;
        bh=rEQwJ8ittw+kMTmn3OLooj/VNGKrQlM0GiJz9PEPOrE=;
        fh=WqHOfnFRxUY9IuIr9hnx6LPOqT9kqmjAL2uRF+s/D8U=;
        b=I+yNHFCaBHfEoRJDC92nB0ZuXwX7nrDxJGCFv/vOJ8SdmNpyH18RQpnguOk+qAGzZm
         +sMPhkgCpQDAaWfdfOZv+4JlQdLzlWJDJrPt9vdFKMBe6fwU0tzMpgrgk7qynTriatYy
         pwKO2fodP3vFxRoZG8TUHqB13kK9iCx2r+IrFpFfVqSBkZ+n//Fz7UOE3J6PN7wXqFyj
         l9IHnh0/B7TmgtsvWO85VEW0gqOPDNT0yfPZtgC9cXHkpkYMneg9PhcphpdmkRKjGpGB
         fCjHN3ytdLTDzkj3QeGEQNyIBjUym0i0lu8e7izHosjSPSyN87vPYOKsDudd8bY+CBm9
         3ULg==;
        darn=vger.kernel.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google; t=1795426394; x=1796031194; darn=vger.kernel.org;
        h=content-transfer-encoding:content-type:cc:to:subject:message-id
         :date:from:in-reply-to:references:mime-version:from:to:cc:subject
         :date:message-id:reply-to:content-type;
        bh=rEQwJ8ittw+kMTmn3OLooj/VNGKrQlM0GiJz9PEPOrE=;
        b=LXj3nhiqV2kbKq2JZYqo80CImn5UQl/GyJGDcm9FuPHx5dEG6XfT5QnS5ojom5OAPM
         IVr0OpPEPSVKwGcHptDgP2hgQT761eogItWV16wFBjkWc0VK/I51vre5G7/yf4bErS7L
         HXOhyjmxN4u6LTetunZ7WdZnVU6MVSaGXD6c8=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1795426394; x=1796031194;
        h=content-transfer-encoding:content-type:cc:to:subject:message-id
         :date:from:in-reply-to:references:mime-version:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=rEQwJ8ittw+kMTmn3OLooj/VNGKrQlM0GiJz9PEPOrE=;
        b=e9xjU4pDa51YVCruY4ItDC9cbNY75wNZbKQ9kFiw4LS4jokT5NGsr0Cf83rPlc/LLn
         aDkPRLJ+LgiceGA/0+gVEtjXTGI7CU+ddGhLFBKVJC6YHIzDipq0JdV/XGc23SxgdyDe
         XKx8xZ8RUHbGpofpNduYn5HZc0AEjo7EX+d3/bx7uWqvLapLg/7mRZ+Us6D3Wpr5A7Gs
         1w85WhY9l70bk9hZTJN1sfCiARQKp2pTUh1/QdWQsqeJkYzkM9WwKgK2nqnXfJHj2AvQ
         Aud6IdgvLNYDATHaqPn9WJkcAN3d0VRDRGt/tG3e8/MBuGckkQLRyg4MC2rsy1roU5Dh
         7ddQ==
X-Forwarded-Encrypted: i=1; AL+hErF1s7b+/CLI2byJAjXrybikZGYPw/NM3PmXqIb8JAVeux9siD6JOuIOqf7bQ4XL0P/xL2JduZo=@vger.kernel.org
X-Gm-Message-State: APuU4Z9r7oeisx6BW92rw2YVzs/ufxIx6g7U06Ck+TVdhb7q4f9Mx6EW
	MuuHbF1JdN0iyilIvWWUouHQ7y+/o5usRfA1B8Cfg1OM7AgBIs2z1Fp+x/fpLu807Ymevq8ev25
	D/5wtcamQsNJaY/aQPeBFLoyAst84ZvBQMGbhqaMy
X-Gm-Gg: AZFdTZd92kOORYxdRf4ExAyAOPIhazLEF9kUbJ3uyI/hxxAq/tA+9Y+gkAYugYbwxLj
	GJlfDMza3GnNsfoYmdIgeE4ipDbpW+PxwsBpkkArUX0CO1uVeEv7feOIix40lCVdMKPeJGUj7+v
	sVZ5rS6Sj3tMBzIaGHUu1KLgC+vbkVUck0ZiQa/oiE6/YN4xEovb7V1ZFgWPOOF55OglINZsZlH
	54mgOygjMkM+6ULCu3dFHbJl2KxOVag7rj2f6df71YZlR/TpeaWTplYCMUV0Gq/fEATLdRWlVLo
	sddJZu1JSq6oNWYbeYzaUjrpubkmkHT04VUjlw14owE7483S1pRvcyjWLDCjQHV8bbF908lTZqY
	5+MbNCDVhxrJQcP6c0RfI5vPFOdgm0FFsIC+Yh2VYD+TkVgVp4DDfzaQJbucvFb8mTuI=
X-Received: by 2002:a17:903:1c9:b0:2e2:d3ef:125 with SMTP id
 d9443c01a7336-2f03efa3ce4mr74174785ad.5.1795426394589; Mon, 23 Nov 2026
 01:33:14 -0800 (PST)
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Post: <mailto:stable@vger.kernel.org>
List-Help: <mailto:stable+help@vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
List-Owner: <mailto:stable+owner@vger.kernel.org>
Precedence: list
MIME-Version: 1.0
References: <20261018023438.3902617-1-mhun512@gmail.com> <CAMMMRMcBT1TgmOYyYO8dJsLsdzqBiyUU4=S7XzE2zhYh_hpP_A@mail.gmail.com>
In-Reply-To: <CAMMMRMcBT1TgmOYyYO8dJsLsdzqBiyUU4=S7XzE2zhYh_hpP_A@mail.gmail.com>
From: Andrei Kuchynski <akuchynski@chromium.org>
Date: Mon, 23 Nov 2026 10:33:03 +0100
X-Gm-Features: Aa3M54pgTzsRiadjShSiXZDHYLQMr5Bhj_1HMO-qoyOLiBI_ZI7BFiyHNfSFFtg
Message-ID: <CAMMMRMeA76TfQnCJN66K6+VtNGE5YG1cNi-TcVhrEJpdT9EdnA@mail.gmail.com>
Subject: Re: [PATCH v3] platform/chrome: cros_ec_typec: Stop altmode work
 during partner removal
To: Myeonghun Pak <mhun512@gmail.com>
Cc: Benson Leung <bleung@chromium.org>, 
	Abhishek Pandit-Subedi <abhishekpandit@chromium.org>, Jameson Thies <jthies@google.com>, 
	Tzung-Bi Shih <tzungbi@kernel.org>, Guenter Roeck <groeck@chromium.org>, 
	chrome-platform@lists.linux.dev, linux-kernel@vger.kernel.org, 
	stable@vger.kernel.org, Ijae Kim <ae878000@gmail.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Tue, Oct 20, 2026 at 10:21=E2=80=AFAM Andrei Kuchynski
<akuchynski@chromium.org> wrote:
>
> On Sun, Oct 18, 2026 at 4:34=E2=80=AFAM Myeonghun Pak <mhun512@gmail.com>=
 wrote:
> >
> > DisplayPort and Thunderbolt port altmodes queue work to deliver VDM
> > responses to partner drivers. Partner altmode unregistration does not
> > drain this work, so it can run while the partner driver is being remove=
d
> > and access released driver data.
> >
> > Look up the corresponding port altmode with typec_altmode_get_partner()
> > and disable its work before unregistering the partner altmode. Keep the
> > work disabled while the partner driver is removed, then clear pending
> > response and DP status state before re-enabling it for a new connection=
.
> > Use the same cleanup when list-node allocation fails after registering
> > an altmode.
> >
> > This issue was identified as part of our ongoing research while
> > reviewing kernel code.
> >
> > Fixes: dbb3fc0ffa95 ("platform/chrome: cros_ec_typec: Displayport suppo=
rt")
> > Cc: stable@vger.kernel.org
> > Assisted-by: LLM
> > Co-developed-by: Ijae Kim <ae878000@gmail.com>
> > Signed-off-by: Ijae Kim <ae878000@gmail.com>
> > Signed-off-by: Myeonghun Pak <mhun512@gmail.com>
>
> Tested-by: Andrei Kuchynski <akuchynski@chromium.org>
> ---
> > +void cros_typec_enable_altmode(const struct typec_altmode *alt, bool e=
nable)
> > +{
> > +       struct cros_typec_altmode_data *adata =3D dev_get_drvdata(&alt-=
>dev);
> > +       struct cros_typec_dp_data *dp_data;
> > +
> > +       /* An altmode without its optional implementation has no work. =
*/
> > +       if (!adata)
> > +               return;
> > +
> > +       if (!enable) {
> > +               disable_work_sync(&adata->work);
> > +               return;
> > +       }
> > +
> > +       mutex_lock(&adata->lock);
>
> That won't be necessary, as there is no activity at the moment.

Hi Myeonghun,

Could you please send V4 without `mutex_lock`?

Thanks,
Andrei
