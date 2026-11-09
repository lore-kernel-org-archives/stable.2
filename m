Authentication-Results: smtp.subspace.kernel.org; arc=pass header.oldest-pass=0 smtp.remote-ip=209.85.218.54
ARC-Seal: i=2; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=pass;
	t=1794195798;
	b=A9VPthig+vI3dhAikF3SDbj1GjkXMSylOzpbBI3Q6Sv3TlTmxnHDs7vFVIJNVN+HAp9C
	 j3gkdSucJ866k4FV8Iv3aZOCEFCWc/NggOc04Fgit/eTu++h7AV0YBXyPGAwC49wXkWMt
	 AUaarj9heSXifDLWQoSZRWoYhnuIywTBrWGH8l29XxY8r8XapkxICKKdCTIUc+nvX2cgz
	 FNMzqeSRjIdRLrh0EeV98/oGmDQOVz4OI3nJJ5I+K0kLujyCOHA5N98AJJibjVLXKrkRW
	 oP3w1TtPZydgGkjisI+oFPmbMY7f46hj3OWstM1ReZp9Y24DfJJ6mywbnSTihO4ZfRQ==
ARC-Message-Signature: i=2; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1794195798;
	h=DMARC-Filter:Received:DKIM-Signature:X-Google-DKIM-Signature:
	 X-Forwarded-Encrypted:X-Gm-Message-State:X-Gm-Gg:X-Received:
	 MIME-Version:References:In-Reply-To:From:Date:X-Gm-Features:
	 Message-ID:Subject:To:Cc:Content-Type:Content-Transfer-Encoding;
	bh=vyHAr9AVf2PmXWF+A0h9JBvHyYTghc2MPPZq5kjNEE8=;
	b=ICkzmWvbCozsH3Xk28zoYedno/xmP0gHA86t6pY1DDAPulnizArjyh9tkLDfTgweCDFx
	 gHVJ2ondvTB0LK7GSyIgaC3cHt5TLO/Purk/UifsP5BYjo5MXYu/58crLcBIoOaNuUlfg
	 QpGLpWFJziP8PfOd0JEDjbInHyn+bN2KvW6TUq5r/tfC4N2NEPswJD8IFhg5lwBSFmzsg
	 5jTHC9+Z7GBQHk3tw9o7dGItge+1StSGZ9cd1tzb8knQXMb2hb4uOJ26znZHkDY1+R04C
	 vEtPDwi/l9aN1QQWkQDkRSxUKabQPTzleD7XoWvnPgJeXBczSqRi3QMZxeucxy7OwGA==
ARC-Authentication-Results: i=2; smtp.subspace.kernel.org; 
	dmarc=pass header.from=gmail.com;
	spf=pass smtp.mailfrom=gmail.com;
	dkim=pass header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20260707 header.b=C59yJfQK;
	arc=pass header.oldest-pass=0 smtp.remote-ip=209.85.218.54
Received: from mail-ej1-f54.google.com (mail-ej1-f54.google.com [209.85.218.54])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D156D606A31C
	for <stable@vger.kernel.org>; Mon,  9 Nov 2026 03:43:17 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org D156D606A31C
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20260707 header.b=C59yJfQK
Received: by mail-ej1-f54.google.com with SMTP id a640c23a62f3a-c49c32650adso56583166b.0
        for <stable@vger.kernel.org>; Sun, 08 Nov 2026 19:43:17 -0800 (PST)
ARC-Seal: i=1; a=rsa-sha256; t=1794195796; cv=none;
        d=google.com; s=arc-20260327;
        b=r+I3MXUAFfqQv9dCA4QaJJrz1uR/h7bUSuBnypzjnB4OGgFNOgtiUGzpAUGcmgvGE/
         gH4ggTN12N2Oa9tAitxJbQz3R7gR9yezxUQbtmPnoUVwBLQVxo2v2sVsTO7X0uIPYQbu
         ND9jOpA+0jkijKAFJY6YuPBz9fbQtevyzBpJb9UWEtGPc84kjfK2+Qa1hsHEu0prgb4T
         SHaW6XZdlSQFG3yC34t1aFQRI8QRqwOSF5WyoIkfrTkAD0ORKuvhnxbobmtTYA11pW5W
         noQbFtmQ2rTZxTZAiia3m3BZjTdau+fulsaDta3rZsGyz9vilM7E2zipxFcsALvnTXSe
         OIqg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20260327;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:dkim-signature;
        bh=vyHAr9AVf2PmXWF+A0h9JBvHyYTghc2MPPZq5kjNEE8=;
        fh=e3qTLAdWzqhvc5IWN0gUY/chTCrTA3Chayp+rh2cvOM=;
        b=ZuUJWp2Cuv2YzjmrLT3FqAr941IQIMzFcx1suH60eHQRJicciYp4LPxf0G+Ka0C/GX
         HpkpqGJ+NR1CA0fzShF+UUPNTl/9cEgQb20px40PuPaykn6s2v7LZNwUNQtXp9ypsEhG
         s5b8D4WZGy6r2B9i+QdDI3LHyLbVhXpqwOdrRxOurENrcGRKxXLr35A+n/kRAZs4y1U0
         Wh8v4INSA7Hd9B+dXd0KhPTI115IWM2s+4xRovZvzczvvX47PGgJojj0nYiAa9La978Z
         hbkrD4MG5SlGQjvxF7cNJQtjIQ5U5oopTohl216ji4sG1n2DHfDhSMAn3jniK39BSfw1
         9Dow==;
        darn=vger.kernel.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20260707; t=1794195796; x=1794800596; darn=vger.kernel.org;
        h=content-transfer-encoding:content-type:cc:to:subject:message-id
         :date:from:in-reply-to:references:mime-version:from:to:cc:subject
         :date:message-id:reply-to:content-type;
        bh=vyHAr9AVf2PmXWF+A0h9JBvHyYTghc2MPPZq5kjNEE8=;
        b=C59yJfQKFhxWMqUveGQkxJLEm/QO4DZPDnwpLoAyIV+PQAybyaEHVTIh/99WZ+rW0R
         ZmaB427Ba+THghzbYoUU/3duT0CRfNf6IcacrkFRNuVGdXSW5oGVbf754QpsUvzPaF5R
         yRyW9HE8tmW4jRIXmYU3dqRkESpF8X26Z3c8X0xyE4oL+LMe2TcY5ig5FtYlMunozgY8
         qumMlAi1lY/6VtPfQaCYexvd00ORP+7bqQyFZelQL8p0F4F34RZvVz3IhhmcwnYvmQON
         tbASLmqEPhQfJgu+rX5vYD7IRaa4ILVxxBGKoyhHraeDYmeAzKBUD20S9aNXJX74RgN7
         FY0A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1794195796; x=1794800596;
        h=content-transfer-encoding:content-type:cc:to:subject:message-id
         :date:from:in-reply-to:references:mime-version:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=vyHAr9AVf2PmXWF+A0h9JBvHyYTghc2MPPZq5kjNEE8=;
        b=uZstiuYX2ii900XFmTMyICM2Ufc6vpkYcBOufKlMq6fXdDy5Ek9FQv9A7RhiUOuTeH
         uMAEGAas98VYo548M5lj802XQlh78fK0e3A169MZIKBblUJcDTvrMFl6LNAzk9JDmsCb
         Ch/QClJp7VfYYFXgI13gAdsUE0QJVVVmXHnZooYM8VxvvHiJy3i1fF9mRq9v6X70lfnp
         s5LEev0+6KjEEHm1otXTnoCfEQVpXsQSMEI1+9FP6zYl54fuzzV7DHxCNQGnDYvQgZYR
         H3qyI4iiBJW8zWbHanVaGbLjMYNzboxwJK4Kgyf8U+SvE8Cm4uVB0CDgHOtD7yNdJ7OQ
         aPkQ==
X-Forwarded-Encrypted: i=1; AL+hErHEAY7xI9e4PPV3U+j0j0yq80f4JhthxmqiMZEcBU64HIGAzy6d1G6x1WpQ0E3vWBCHbU/H17s=@vger.kernel.org
X-Gm-Message-State: APuU4Z9d12aTOw+KMor5yPZYfKekqob4DHxfX/5sS6/mNJGbhCQOSD1w
	BzevQettLgQppAWnRxcXTW2E3iVOw2H/rtil6zi5x9lIGjXx9jeW3P8gmGMwIc6xe2ShX2DUFNJ
	X79EHCTLyKte6ItUd/FMLUrjOxxCCgME=
X-Gm-Gg: AYBFou22mWqlKkzXUyEFZrvS0NbdeJTjFW0wJCWFRcobhQF8PLlaT8VHdGEY7eU+1hY
	wTJy7YPxnu8dIZu6UjbGCOGsvkvftpM8UiLmSeyqWGkg7u8abDZlTvOloDAOiTyFq5T6X9lvRUv
	fOEs9jxcTIaQIKEWH3omHja8PYetentt5HL/w3V/9+1fBy696zjSTVtSA9kGc6apbL402BUY/i4
	geZLy5q3h4hGWK5Bbx4YZpP/F4GT63w+l0STcmByCDFlHffVXQ2vf532uN8rhEPpLAN7ryf2g8N
	V6Uw+sCQ9eCtyeOoG59WmpHO2QyCBa1bayQQkYem0qM4wCjosmkwaytor/PcApE0Ktmyy2Zr3eC
	3LmZPRBl208AoTW89gSpmvwQYFODE+VqlGFc+wkTVsd5QtkUjdm7Fyk0MsxG3NsUZAUiKa/I4RV
	kHCkJpsJHU8VmQ1gUCfyKqPD2FwWzdRMpxxxZqQTgXNVvKmZ+x2wiXa1W5rc+wLFejwkb1DA95h
	idaBnwBTPVcdQXw/7ES38E1JOPlYHqSLp+wtyB6kzRT4EhR3Q==
X-Received: by 2002:a17:906:99c4:b0:c40:80eb:c541 with SMTP id
 a640c23a62f3a-c4d6d162393mr190807966b.2.1794195796109; Sun, 08 Nov 2026
 19:43:16 -0800 (PST)
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Post: <mailto:stable@vger.kernel.org>
List-Help: <mailto:stable+help@vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
List-Owner: <mailto:stable+owner@vger.kernel.org>
Precedence: list
MIME-Version: 1.0
References: <CAKxU2N8QChO59Z=ncdNfvq-hNZp5Q2UsGFcovqn52G5mQso6hg@mail.gmail.com>
 <2026-11-08-1-daily-reply-0012-ath9k-5-10@kernel.org>
In-Reply-To: <2026-11-08-1-daily-reply-0012-ath9k-5-10@kernel.org>
From: Rosen Penev <rosenp@gmail.com>
Date: Sun, 8 Nov 2026 19:43:05 -0800
X-Gm-Features: AclHuK9ZTQmObayR7aJ10YsL9uusCBBTBYd5CathrhHPWeXJIkNmtFArXSBypww
Message-ID: <CAKxU2N_Y8t2FRax6n-CGMqk4dXUFZ8q=inUzJ1tHXbcUC-ZP_A@mail.gmail.com>
Subject: Re: FAILED: patch "[PATCH] wifi: ath9k: delete channel-context timers
 on deinit" failed to apply to 5.10-stable tree
To: Sasha Levin <sashal@kernel.org>
Cc: gregkh@linuxfoundation.org, jeff.johnson@oss.qualcomm.com, toke@toke.dk, 
	stable@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Sun, Nov 8, 2026 at 4:34=E2=80=AFPM Sasha Levin <sashal@kernel.org> wrot=
e:
>
> > git cherry-pick -x 81394dfb9a7905472957628b560ae894eae3a30f
> >
> > works locally. No idea what the issue is here.
>
> The cherry-pick applies, but 5.10 has no timer_shutdown_sync() (added in =
6.2),
> so 81394dfb9a79 ("wifi: ath9k: delete channel-context timers on deinit")
> doesn't build there. A 5.10.y patch using del_timer_sync() is welcome.
I assume this gets sent directly to linux-stable.
>
> --
> Thanks,
> Sasha
