Received: from mail-ej2-f41.google.com (mail-ej2-f41.google.com [74.125.228.169])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 470734D0A12
	for <stable@vger.kernel.org>; Mon, 28 Sep 2026 21:35:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=74.125.228.169
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1790631308; cv=pass; b=I+UwS6hf4c4yq5OrA1qQBp3DB3QhM8Ig4RLcQZSR9y/3voqk/Agi9y7k4N409o9I9OFn3Bu2NEjhFGaSetykdizQY0d6Ld6m08UX5qN4ZnUHGRxeAIci/Ta7UZvwkNjvGd8aFGSUaS0tplPiLqV3sVHxW6ugSrRvkWB8Vm8GF+g=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1790631308; c=relaxed/simple;
	bh=vzJQ85GPqKFtTeBCXYuHKUzsnPT7TPrKjUdhJU56BoQ=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=SKZnEB0D8KK5td3O4HIHn37KVN+FK6ujtyXxEtljbNGsbIGAD6UMMkGjOumGJmznUTuZFmfBIafHzR2rM+xOjDdzPTuoKdO4GQf+c8ZXIbkcqwR2ufCpR18gaBz/kj/5FjH88YA6iqL3oShBFfCwoT4sod89xFM+DWImx8qq/qY=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=URNxiS6K; arc=pass smtp.client-ip=74.125.228.169
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="URNxiS6K"
Received: by mail-ej2-f41.google.com with SMTP id a640c23a62f3a-c2dd363f57aso192895366b.2
        for <stable@vger.kernel.org>; Mon, 28 Sep 2026 14:35:07 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1790631305; cv=none;
        d=google.com; s=arc-20260327;
        b=F1dvEgMKqjCad/ps5nm9pOzHSW54vmED7yuis+C2xznXcB++Zg2iAoVoxZ5o115+VK
         CVjbG0K5TRUQwc5iYiCdK6nIunY3aTCOVZIbYpOFfqNBO7rIfu81rZDWtFEMeqBTEUwK
         SFv+PymTLmmSoVlGyVgLzXoPCydn7pxR4zN8WsTBFoIz/3o+O2n1C1eD3vQf20PcOk6M
         zVpToVPcDY+TEaIprpWeiOFI5jX0JoWMZAv7ytwzjAeHqBTsJpnOJfOPus7C5CVSnF0z
         mgWGtxjwPvAynWeupxa5hDNn1zGZC83VDM91fefkpatvWc0vqGBpOc696sFhV79qPBpH
         ra1g==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20260327;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:dkim-signature;
        bh=hKH1VCmfZugQJTpZMRBvxmQ3C0yXJLdq33pyaJF/XR4=;
        fh=X874K7vpRRfdmJd8ktNtncwhihUXZzeg9IhVmfyLoPY=;
        b=ox6OLQRUSlEzRibZCKOfnKSRkZr6N1x8GdMgOcobaDrjv1VZRI3QIoraYgysiQ7d//
         5Gk6fYjMQGFshL1eWTV37HHlDynL8jdWsPy6xIfi481c12bOE7k995jXZftgQ0nANUpV
         cdOHoMVMvhld5GvRYNpQ/HKpej8mdWu4i6cxMM9mHAbJ72EX7WYaLe8SsJ8fuH44BHuy
         P5oxeT2EANCnw0LURJXDkHDJmKIQuGGxHBo97OHbhIeP5mKHIlNy7ne+24yeNVrT39Df
         8sd1l0jfRnu6hucD3wPiPpvz8rguXy0aTx2Rk1daySqWJibu3cT2vuPVFeYB26spXR0v
         jV9w==;
        darn=vger.kernel.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1790631305; x=1791236105; darn=vger.kernel.org;
        h=content-transfer-encoding:content-type:cc:to:subject:message-id
         :date:from:in-reply-to:references:mime-version:from:to:cc:subject
         :date:message-id:reply-to:content-type;
        bh=hKH1VCmfZugQJTpZMRBvxmQ3C0yXJLdq33pyaJF/XR4=;
        b=URNxiS6KrB0BjiY8vW5pi3471D4ar4brtKl+SuMRzOHRw3Z9+IVokYEsFRFWaSjOdS
         gQn3p18H/PPrpgwZ3p4EiD1lPNYZZE0ndHqy3LSU5xz9ACmXZQ1BE5wKeIWAiVeSmWui
         NpyUGGtZGi50fa350yGn6V398YN/rVJT+ObA1n+0EDt+Ss3P2DqNOs62BO2a44MeWMly
         b7T+7zzkeWbpGBPDbTDjjL/jrg9FlSHExQ3uskbx/m5Sv1wGqbek8Dy1+K/t6X8Cs2eG
         SO0vHi/OGWMy5nKmp9s3NCq9hZ66GmleX3bcLfi3TIqEmcEvhtMt3L2zUZiNPe6BAZ8j
         s3nw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1790631305; x=1791236105;
        h=content-transfer-encoding:content-type:cc:to:subject:message-id
         :date:from:in-reply-to:references:mime-version:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=hKH1VCmfZugQJTpZMRBvxmQ3C0yXJLdq33pyaJF/XR4=;
        b=cMqD865CYjBTTIiXhd5/tUWEORYWl1RsMBmYcnA2S+w9wx7Q2g+f1Xnn71l0653UYD
         15mKsqbOlxjQlBsBJNZIIk0u1Kr688rqN1YRRODRXgaxY49gwNkA4S2ybsEiarErnTrN
         SBhrgLJx1FpBSlUNZVb9tNdQ3QsKA66SISNHHbGR4F26i8/bDX++4sFheGOOqEQKiMQZ
         Vs8XffJ3GahMW0h0b5yj5+UO7GjozIEzLowwHrbALAEU+Iw+uf7gtqWnW+Hanqe03zeW
         7AkfjwxwQvvRfh7zh41yRwIl7HXEw3fYW77qUNZYMgy0oCkf+P5mbv9VpuMrhFoKrWQw
         rDuw==
X-Forwarded-Encrypted: i=1; AKwUvBzm/XHA0v8qk01GygoudReCIHZiG3+CAqUBuRImrsCSMhhvceaTp5GfHlSkBpLg6gl/kpL5jQ4=@vger.kernel.org
X-Gm-Message-State: AFuF++ltvazjGDRDWT5jXrdR9sI90qqz3Aua+DzkWnmphvrlrTrXTbLV
	6UncM1+xqVwj4uhEkuiiwnyI0WxQGdC8O95r8O4+dB489/FSYitBAa3ZyWvJbhlNFojqrkkERQG
	xCe1hdYSXGxB4KuXJ6PzlFWrqKftirZo=
X-Gm-Gg: AYBFou1E6z6PFN/Amzo8CqQP8xUowP+LvS+NQEnRt1lI9SAfVyu60629eYcAc6hd7Wf
	8g64h298CFbwbQ/zpAS6aX3/k6tc8U7sqjzgUGOzeGejegpRHaM1tDuH1VUjT4G0B5KvfQO05PM
	aOUJlQKGM8eiKNKTYRXkSI8bKtna1v846qwKgk9tVVGWJsFkOvOAEmz4CXUHBhq/Y49wMzcmDu/
	6eoViUprQ7aq7kjDsBbnd5fJo9PbHbcv3D9fj8xKPT9SxkbdAPRArbGNMWzCFkN88yvLPLr/n3a
	abFyuiZ4sX2AZu5eWICP7BZy62jXpKGvy8qGliWPJKtqKAGXY3o8N0a0X5ulg0TthY/wxxJL1CI
	Bloat/V0k18h55xhge3ZVW1P33lLaj5ZqFAhpBzIme91gkKoJHqiYqcd3k/5Fqge9VquERsO31n
	LMOCbMAigKBorDnoDpyrioYLLds4hcyqTMolAWULvF
X-Received: by 2002:a17:907:d789:b0:c29:5172:6151 with SMTP id
 a640c23a62f3a-c2ac263bc06mr1090827066b.45.1790631305354; Mon, 28 Sep 2026
 14:35:05 -0700 (PDT)
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20260928200318.63383-1-meatuni001@gmail.com> <20260928200318.63383-4-meatuni001@gmail.com>
In-Reply-To: <20260928200318.63383-4-meatuni001@gmail.com>
From: Andy Shevchenko <andy.shevchenko@gmail.com>
Date: Tue, 29 Sep 2026 00:34:29 +0300
X-Gm-Features: AclHuK_zWLiFRrc6U7vmxR1ZoTbaYKmfPM7Lz80sz5CYaEVPc8AD2uZZsDfOheM
Message-ID: <CAHp75VcrAo_XACcfcycaGyiEsDniBBzCGMyGLip32KQz82q33Q@mail.gmail.com>
Subject: Re: [PATCH v2 3/3] platform/x86: hp-bioscfg: return -ERANGE from validate_password_input()
To: Muhammad Bilal <meatuni001@gmail.com>
Cc: Jorge Lopez <jorge.lopez2@hp.com>, Hans de Goede <hdegoede@redhat.com>, 
	=?UTF-8?Q?Ilpo_J=C3=A4rvinen?= <ilpo.jarvinen@linux.intel.com>, 
	platform-driver-x86@vger.kernel.org, linux-kernel@vger.kernel.org, 
	stable@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Mon, Sep 28, 2026 at 11:03=E2=80=AFPM Muhammad Bilal <meatuni001@gmail.c=
om> wrote:
>
> validate_password_input() returns INVALID_BIOS_AUTH (0x0E, positive)
> on rejection. store_password_instance() skips the store on nonzero
> ret, but its final "return ret < 0 ? ret : count" treats the positive
> value as success, so userspace sees count instead of an error.
>
> Return -ERANGE, matching the sibling validators for string,
> enumeration, and integer attribute types.
>
> Tested on HP EliteBook 840 G2 (Fedora 44, Linux 7.2.7): writing 999
> bytes to current_password returned 999 with no error before this fix.

...

>         if (length > MAX_PASSWD_SIZE)
> -               return INVALID_BIOS_AUTH;
> +               return -ERANGE;

Nope, ERANGE is for integer values. Here is definitely about the size
of the input string. We have E2BIG for such cases.

>         if (password_data->min_password_length > length ||
>             password_data->max_password_length < length)
> -               return INVALID_BIOS_AUTH;
> -       return SUCCESS;
> +               return -ERANGE;

Ditto.

> +       return 0;
>  }

--=20
With Best Regards,
Andy Shevchenko
