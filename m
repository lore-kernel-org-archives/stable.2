Authentication-Results: smtp.subspace.kernel.org; arc=pass header.oldest-pass=0 smtp.remote-ip=74.125.82.179
ARC-Seal: i=2; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=pass;
	t=1794467232;
	b=1FvQLbGBU5xD6tHOSHG8ItKMZpfWO8hMDDnteTdcuBS4mCm5N2b/yjYRjTocnu1KiypX
	 OzUzWXeoj8/q0OU07UR6ukY3ghw4z3xdmxl0IhNIpXC1MPs5x0sQLMxEVL7n/0ARg6QBE
	 jZC3jufoxdQl8uMeSaPtI9iOKPkEoovpR6PteaSaMxxB9QcO8rm+UTDeaoAiklWh/BwPm
	 nemNqqpNlrwPeItxIm4/rLZjWjj0iCmbQznsHX+AwppPABTRsjjVdfHzfA2WK01HT2/DI
	 s9MTHWHKtjPWrf2lh+eVWuKABJzF9MjKPUcElQo1VWqC7EtcfoJ4W2mjOqVLhShcvOQ==
ARC-Message-Signature: i=2; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1794467232;
	h=DMARC-Filter:Received:DKIM-Signature:X-Google-DKIM-Signature:
	 X-Forwarded-Encrypted:X-Gm-Message-State:X-Gm-Gg:X-Received:
	 MIME-Version:References:In-Reply-To:From:Date:X-Gm-Features:
	 Message-ID:Subject:To:Cc:Content-Type:Content-Transfer-Encoding;
	bh=fKnVCHN7E/hSBh2v2WAaZgbrM1NIrcwDb5EE6y41Z7Q=;
	b=ugiGZmpDaYF2YphCQB15hAJSqeNg3COR03fzg/JGAggpD+DtwBvVTnjkAGV6WIwdjsKx
	 Kz9VgTKNpV1wtHWT/wqGsB9z+gzqq7L2HaW5Lnv0H27zJq8oeZ5PageUxUuFIbSQVG3Y+
	 sTOhS0CWDLp2BtUAN8NxU7WVQYH8WfhiuLbgyc+SN+aSRi/1PgLnpAvuyrbrHM1NuM3KR
	 lfZaP0jexuzXPAOOfqnS3Qpx3s6iXlf+cRbLuofeML/VXJjG6KBAAhb2G8jsBI7Y92kFk
	 sXPrT2QvJBJfIBhgP8/Wqy2qYxm/F6QVfgT6tfFRHaNyPfp2npojB1Obc9SwbckS3iA==
ARC-Authentication-Results: i=2; smtp.subspace.kernel.org; 
	dmarc=pass header.from=gmail.com;
	spf=pass smtp.mailfrom=gmail.com;
	dkim=pass header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20260707 header.b=xc44pbNc;
	arc=pass header.oldest-pass=0 smtp.remote-ip=74.125.82.179
Received: from mail-dy1-f179.google.com (mail-dy1-f179.google.com [74.125.82.179])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C8605606A332
	for <stable@vger.kernel.org>; Thu, 12 Nov 2026 07:07:11 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org C8605606A332
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20260707 header.b=xc44pbNc
Received: by mail-dy1-f179.google.com with SMTP id 5a478bee46e88-36e90071735so221837eec.0
        for <stable@vger.kernel.org>; Wed, 11 Nov 2026 23:07:11 -0800 (PST)
ARC-Seal: i=1; a=rsa-sha256; t=1794467231; cv=none;
        d=google.com; s=arc-20260327;
        b=PI8g2k8BgmNY13ELkI38RQtLstkoW5321yyQHuaUSeh0zVBehD6nBFXY5r3MlZImkB
         n/dnv0HPKgWaWl8w3OQYQ7BDCdZWcg3wDSIgyIJyg80q9UFhXiIjbuvB2sSlUBULZdH6
         zSSaD6YM7vcGGvqLHIoLJ+kM++dG6c+kyec4fHdoCLyFKF6aW/sqaAq/Q8lWf0Ed5Ytp
         uweQfYsA8SOPlede92BTqoqfUtS2NZVExcLpe/Fko1zRQD7qesJr4hPiaukvM9oQTlOp
         aqhNB2JNkJvZvO2Zkn6anHm/BIt5ULmRavYDUu4Brq8b7qH23wf13i6QNSrpX6q6zgbY
         5peg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20260327;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:dkim-signature;
        bh=fKnVCHN7E/hSBh2v2WAaZgbrM1NIrcwDb5EE6y41Z7Q=;
        fh=Cxj025LwhZ2Ixlwb9BtQaE/bMSEJGZ0Rz/YCJCf/GD8=;
        b=j7wlj5L1c5wG+3wV6BtwHuBoVjTeEckKTllxPWZydtLOz4n0Ot074zvKviGkm3W8aI
         5Y2qgoHvRRkaPJuJhV1xoYr5HamI/UgRUTJOXUZneUAXsuaUOGvsmOYbnkxhhsYwbxdL
         NcPokKtN9AGcZrNL2jHEcyKuRid+4Its6avf2CmBnOtlwcD1tnBxbaVmiJRVr2ClDXbL
         ZBZMgFoXRsiGHZQ1zRzxLTQ8yZnnbGngrZuXouQLSURxk8Ut2VitH6Cxuvd5COpEPS0i
         oJZiOw4Io8BRTbyTsz/MR0b5LdbF1OT9VM0pzERCztvxctaWkzBDvKoP6V6Wqlm30k6Z
         rlCw==;
        darn=vger.kernel.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20260707; t=1794467231; x=1795072031; darn=vger.kernel.org;
        h=content-transfer-encoding:content-type:cc:to:subject:message-id
         :date:from:in-reply-to:references:mime-version:from:to:cc:subject
         :date:message-id:reply-to:content-type;
        bh=fKnVCHN7E/hSBh2v2WAaZgbrM1NIrcwDb5EE6y41Z7Q=;
        b=xc44pbNcxltUHGg4tunSUmN04e2U/jKsJUsnxPYcvA+qqm01NnKPXgtlnQekS7ByVq
         4AtP7iHvVolgk7MNR4QfFlGkEmt+3sBlL6oSmEktDhFPu/wHAnGbFh0jsqXMaougHBpI
         gHoW2ClvogVyVXvDiOeyl/DtSGsaERvHOwPNTFiQwuYZ3N87WzCUKI1ouIuw2rv1rSJu
         ocHwePSnJq+Q8ldOoYCTJCmzWnVlmSFv49wORYfLbrRHdk5QrrM3JmrTCLlA9wX6en6t
         KdeT0dTF/ux5bGGwY8xtfpaAQ0WlrEw0/9zk41gT10dn7W8jceJBbGr8FB+1KspVxMe7
         9xnQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1794467231; x=1795072031;
        h=content-transfer-encoding:content-type:cc:to:subject:message-id
         :date:from:in-reply-to:references:mime-version:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=fKnVCHN7E/hSBh2v2WAaZgbrM1NIrcwDb5EE6y41Z7Q=;
        b=H89CJkgOXYWq+Jh/SAx6yDHX+Q3vilyjED9Sxc0w/ph1icZ50jUftiL/XJvFKIJ/sz
         kCYzZbn3w5PF8rd7GA1zfpIx6AqVlKWSch/E/LqkX60cuM+vYk/hJCmZa+9NFi6XShFL
         G/Oq5sISTtBa7qVxlqjgLW8JO0SpzQlq31HDlDQCPI/dGMYM3dGodbi8n2Igy9EGs4xM
         7X6QjZrin2UMd5j1Nlwkj1xsDFjMwWar+XmUH4MIH1x3e3zFBxWFJURSXT5G9gk/XHbt
         XfbmjP4l+jpTPkaKTQeAYrtZP0suO3uk1QsiVVUDaarObeXrqIuUlO8ec1pWahDrxCVz
         8tCA==
X-Forwarded-Encrypted: i=1; AL+hErHfnxSO0C78DoU/bYiOQLCTeIGkXtGmByJhXyKTzCN1XqveAiKCg3oMPUzLhHw9YSkK/1OLryc=@vger.kernel.org
X-Gm-Message-State: APuU4Z+a5ct8KqbY0hedajxmXwk5X+LWlBLymtP4iE9Wqcu4+yWTsuam
	1iEdu6wWpXurlNhuIwvPGynnFWqW0yDsAowxtnonY3Xr/SIkxnICIhW0f3sWYXsNGRNIwof1hTf
	s5i7beW96c1nNEop6SupJDmtxbpmEHrM=
X-Gm-Gg: AYBFou1oGdVGeGMWXnKoaSfk76MTQCC9VaR2ZFOeAyHHT91krWrVASz4u43FULaN1Q3
	BuT3nEexN9o+gDhGoqlFPVnOFuCrg6cojo8cevvF11dIZl1HGrKpAKrx0EOPKylW28UucfqQhr4
	HD8ADaM9qzogyV0OYzIs7OhsplskcoSeYI9WeNCuEvEYnVdQaXsWQrUYxkasNcnpoLtMGc2UgNc
	oJqFUf0PgE/fWJHA60AqiV/AO+bZqJxaFEoKnlIyIEVsKdsdUZJExTacb2NaS8f3bpVJpIrsmFj
	NtmNg6vrrj7llAWkti4TPY4HKIqjXG9UK8ySGuq4daODSBviIGd5ttY7nMKdSOIUlMZADOXgdcC
	jKoa12i0CA2rapBhkwDZmsKjLazVI7eq5qPNvkP42Xl4qyKCjKpSmgzY4omK4ldJ7nafWqlCz31
	rIm8YKLMoTmiCBIynpe5F1A23kxuRgG4sB5aBCXBUACZoI3YYUTPxE73PnONaFOudOA9NJOKRng
	FnE4El0OLhhsb3lpLLRZLuMscxhCHfUKkQRPKTpEY310oL97Wv2ZB0pi3QQo+0og5LFQHsA5/bq
	BjA3bOMNLBtt5p3Q
X-Received: by 2002:a05:693c:20cd:20b0:375:f846:5b3f with SMTP id
 5a478bee46e88-3767fe8f34bmr7678043eec.0.1794467230848; Wed, 11 Nov 2026
 23:07:10 -0800 (PST)
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Post: <mailto:stable@vger.kernel.org>
List-Help: <mailto:stable+help@vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
List-Owner: <mailto:stable+owner@vger.kernel.org>
Precedence: list
MIME-Version: 1.0
References: <20261111225940.1573565-1-tytso@mit.edu> <20261111225940.1573565-4-tytso@mit.edu>
In-Reply-To: <20261111225940.1573565-4-tytso@mit.edu>
From: Miguel Ojeda <miguel.ojeda.sandonis@gmail.com>
Date: Thu, 12 Nov 2026 08:06:56 +0100
X-Gm-Features: AclHuK-0Vjsbk82ppS8gYU_c-KZHXRP49X84VVchA17Y0XwPYJKcU9nKf-NQksU
Message-ID: <CANiq72mNefHqXnfy_mh_kyRT0SfM8rLj1kRnc-Y-qmdaDq0nvw@mail.gmail.com>
Subject: Re: [PATCH v5 3/6] agents: add a skill to determine stable tags
To: "Theodore Ts'o" <tytso@mit.edu>
Cc: workflows@vger.kernel.org, ksummit@lists.linux.dev, 
	Sasha Levin <sashal@kernel.org>, Bradley Morgan <brads@mainlining.org>, 
	Greg Kroah-Hartman <gregkh@linuxfoundation.org>, linux-doc@vger.kernel.org, 
	linux-kernel@vger.kernel.org, Jonathan Corbet <corbet@lwn.net>, 
	Shuah Khan <skhan@linuxfoundation.org>, Randy Dunlap <rdunlap@infradead.org>, 
	Mark Brown <broonie@kernel.org>, Laurent Pinchart <laurent.pinchart@ideasonboard.com>, 
	Leon Romanovsky <leon@kernel.org>, Konstantin Ryabitsev <konstantin@linuxfoundation.org>, 
	Thorsten Leemhuis <linux@leemhuis.info>, "Michael S. Tsirkin" <mst@redhat.com>, Kees Cook <kees@kernel.org>, 
	Geert Uytterhoeven <geert@linux-m68k.org>, Dan Carpenter <error27@gmail.com>, 
	Miguel Ojeda <ojeda@kernel.org>, Alexei Starovoitov <alexei.starovoitov@gmail.com>, 
	Julia Lawall <julia.lawall@inria.fr>, SJ Park <sj@kernel.org>, stable@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Thu, Nov 12, 2026 at 12:00=E2=80=AFAM Theodore Ts'o <tytso@mit.edu> wrot=
e:
>
> +Read Documentation/process/stable-kernel-rules.rst. It says which change=
s go

If the LLM is going to read the file, then I wonder if we should just
clarify this (i.e. the list given below) in that document directly (as
a guide, i.e. still acknowledging that the stable team decides in the
end).

> +Judge a change by what it does, not by how its description labels it: a
> +"cleanup" that releases a resource on an error path fixes a leak. In pra=
ctice,
> +the stable trees take:

We are adding Rust soundness issues to `stable-kernel-rules.rst` [1],
so if we are going to have this detailed list here, could we please
add a bullet point somewhere in this list like:

  - Fixes for Rust soundness issues.

?

Thanks!

[1] https://lore.kernel.org/all/20261020163358.176088-1-ojeda@kernel.org/

> +  the code it changes. Otherwise, if the Fixes tags are unresolved, so i=
s the
> +  stable decision.

When I was reading this, I wondered if "unresolved" had a particular
meaning here. I assume it is referring to the output of the call to
`find-fixes` and how that affects the output of this one. Perhaps
something like:

    Otherwise, if the find-fixes skill cannot determine the Fixes tags,
    the stable decision cannot be made either.

is clearer, i.e. being a bit more explicit and using the same words as
the last paragraph?

I hope that helps!

Cheers,
Miguel
