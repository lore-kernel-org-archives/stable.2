Received: from mail-pf1-f181.google.com (mail-pf1-f181.google.com [209.85.210.181])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E37533DBD51
	for <stable@vger.kernel.org>; Wed, 15 Jul 2026 08:54:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.210.181
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1784105685; cv=none; b=k6XeWhwGIqod0kbQGOz+fWmowPnqCavIczqgTcLorpeFTz1YFSjOrzxqL1snnzcKSFJZ/5t8vT7FZlBDqziJbhzc7hcjg/Jye8shcxhxUVfMNdo4HwJ2ewcv7yS9NeTn16NXKHM0R5DtJDohQZkA3PM/PP2kKsdACxBcQvdl5XM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1784105685; c=relaxed/simple;
	bh=hEYRQSd8L24KsvxuNroVxdJqty75+npmHbQjtSRCciI=;
	h=Message-ID:Subject:From:To:Cc:Date:In-Reply-To:References:
	 Content-Type:MIME-Version; b=u4ID6fIn7+r9/sHGS21yll6+FkL5iva6lX9CZjDMYEHxUhGcS0wsRAshqMIeebObFmlUl3igtZxr0mDobiQ/dYYRclmV6z8dAlmAfOtGhf7JUGkB2uIM31K02eAAz+715bDvYrFRAyjOd20qPFZMUac04ygou8ZYPy3W3gjpm9c=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=SgGL/LHN; arc=none smtp.client-ip=209.85.210.181
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="SgGL/LHN"
Received: by mail-pf1-f181.google.com with SMTP id d2e1a72fcca58-848882fdb18so1897322b3a.0
        for <stable@vger.kernel.org>; Wed, 15 Jul 2026 01:54:41 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1784105681; x=1784710481; darn=vger.kernel.org;
        h=mime-version:user-agent:content-transfer-encoding:content-type
         :references:in-reply-to:date:cc:to:from:subject:message-id:from:to
         :cc:subject:date:message-id:reply-to:content-type;
        bh=hEYRQSd8L24KsvxuNroVxdJqty75+npmHbQjtSRCciI=;
        b=SgGL/LHNYYqQEwqHHCqXbG/Cy4yxAKMTttPUbQ0IV8DJh/nIP5R1mezWVWAqDgX4pT
         0nWx5vquDD0SMfn42uwkx6a3uxgjDgykmX0F6apPO0eovwnuvHWGtEYhYLyH3Jte+Eqx
         2lb6ZFVPlzxU8ofmk4pshBM4gh+U8c0o51qnxtVH8Q5uAFpALSvgUC10LPDHumTuMNr5
         B+YmftYimRJnEcXL5GlcGckbRNXXbMxcMK8Koe5ZsaeeWD3By2jueb05whJlPMaJd968
         Hh9yitOS7JfsVZIFKbaKCs/V0qg33x1r8GslfTAuW3LUVOjJMW+Pec6Jj6FKxmHckKH5
         ILqw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1784105681; x=1784710481;
        h=mime-version:user-agent:content-transfer-encoding:content-type
         :references:in-reply-to:date:cc:to:from:subject:message-id:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=hEYRQSd8L24KsvxuNroVxdJqty75+npmHbQjtSRCciI=;
        b=jVrUUzhee8GgfvXgmCkv5R3KE5tGDzSQwpUBIUeAPPpaqnR7jC/YP7qOIBV2GlGwTC
         u/KZkddYyB7BfN9F82HLiSOHpAIDKb0OeRs915jF/rYMf+FgO/mXM+xt2+eOXDGq7iLa
         UV6s7mfGzdeKduHUCwqk0vyvpfzYJWLQUTVo6UAEilyc07Oy1p7efnav6qNnyLBf71In
         2GXazK/FH334dIpandVSBzL5lTYZFholxcAtMxQX33e10AuCFP//iugPCaZR3odFiRYh
         qFoZxbTz72bSEujUT9sbB0XXqRRDBMc/iDvDyNhTSoZAlmkZVx5QgrPs3i6Es2Di6Sgh
         rDgw==
X-Forwarded-Encrypted: i=1; AHgh+RqbQH0qmnSPJRhj8lw5QSwnYZXjvQVbGAT4IIhCUlstaFVaNXbFw9BFspqwZw10IPcqZyi3iH0=@vger.kernel.org
X-Gm-Message-State: AOJu0Ywa9rYrcrKAfV9AHOsywmt6v1VsuOnLNNDq3YknCvDCwn9F3AGa
	hQFEA0jTlQHJiiGwBRqFE29YzWadR63qoiIkDi5jpRuorvYTjdqV3+pp
X-Gm-Gg: AfdE7clYa4BiBefOvrayJfisUPIKe9ElUgMaIDFGvQekAqXzgFELw3Dinpzp+umZ1s9
	wr9mHaW3Goyp/3VPnqpgIDGdsjZyoW5R79ZNMnx1W6GlbeGZf71L1H8T9cIEnc/dTcWo6TlgSd3
	8cj8DNO6cgVQOofMXHOndIWypbcR2JT8F9fFzU2x9Ta28gTE9u6KIRRrl4ageEctiPDI+Awc1z+
	xHS0vvglAO+vmSYo/YoVDB3GDYdL8t6OO3fF0ip2Q5rUqyAnppoSa+aihzGHiwIOcHClwnxZMYV
	8uVWE+ic9sd7TOuqAAdP3BAiytMh2vIfEtPDt3iy+tC8p5290PzXuJdlK4iVOe1CiNj5STxPFZz
	DvZWCu+xnBPv8LTueA0Faai2WzZI4wLDjscPi+WmNGh582vgPYJ9gOZLtd/rJH2/1WveyXd/C7S
	N9MjNNTwGb/gB8UlM4ytMoHopu/Txl06pa0EBSs/OV
X-Received: by 2002:a05:6a00:368d:b0:848:56ff:6ced with SMTP id d2e1a72fcca58-84a6723d613mr1883067b3a.8.1784105680638;
        Wed, 15 Jul 2026 01:54:40 -0700 (PDT)
Received: from [192.168.0.13] ([38.34.87.7])
        by smtp.gmail.com with ESMTPSA id d2e1a72fcca58-84a4f6bebcesm2787462b3a.32.2026.07.15.01.54.39
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 15 Jul 2026 01:54:40 -0700 (PDT)
Message-ID: <488c235db713648bb2f5c90e4389c96a97ebcdde.camel@gmail.com>
Subject: Re: [PATCH bpf v5 2/2] selftests/bpf: Cover negative buffer pointer
 offsets
From: Eduard Zingerman <eddyz87@gmail.com>
To: sun jian <sun.jian.kdev@gmail.com>, Shung-Hsi Yu <shung-hsi.yu@suse.com>
Cc: bpf@vger.kernel.org, Alexei Starovoitov <ast@kernel.org>, Andrii
 Nakryiko	 <andrii@kernel.org>, Daniel Borkmann <daniel@iogearbox.net>, Emil
 Tsalapatis	 <emil@etsalapatis.com>, Jiri Olsa <jolsa@kernel.org>, John
 Fastabend	 <john.fastabend@gmail.com>, Kumar Kartikeya Dwivedi
 <memxor@gmail.com>,  Martin KaFai Lau <martin.lau@linux.dev>, Shuah Khan
 <shuah@kernel.org>, Song Liu <song@kernel.org>, Yonghong Song	
 <yonghong.song@linux.dev>, Matt Mullins <mmullins@mmlx.us>, 
	linux-kernel@vger.kernel.org, linux-kselftest@vger.kernel.org, 
	stable@vger.kernel.org
Date: Wed, 15 Jul 2026 01:54:37 -0700
In-Reply-To: <CABFUUZFsJsF-C5Z2gb3FkZ7WD=vBavnGdZ7veScP_+dwZLsaMg@mail.gmail.com>
References: <20260714093846.18159-1-sun.jian.kdev@gmail.com>
	 <20260714093846.18159-3-sun.jian.kdev@gmail.com> <alcGgfNM94zgydlK@u94a>
	 <alcKV2MXI_5dsaez@u94a>
	 <CABFUUZFsJsF-C5Z2gb3FkZ7WD=vBavnGdZ7veScP_+dwZLsaMg@mail.gmail.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
User-Agent: Evolution 3.56.2-10 
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0

On Wed, 2026-07-15 at 13:26 +0800, sun jian wrote:

[...]

> > Anyway, still recommend adding a regression test that test access to on=
e
> > byte before the start of writable context.
> >=20
>=20
> The new tracepoint_writable_reject_negative_const_offset verifier case
> already covers an access before the start of the writable context:
>=20
> =C2=A0=C2=A0=C2=A0 r6 =3D *(u64 *)(r1 + 0);
> =C2=A0=C2=A0=C2=A0 r6 +=3D -8;
> =C2=A0=C2=A0=C2=A0 r0 =3D *(u64 *)(r6 + 0);
>=20
> Its effective access range is [-8, 0), so it is rejected at load time.
> This is the direct regression test for the negative-start case.

The existing test seem to be sufficient, why would it matter is at
offset -8 or -1 given that the read is appropriately sized?

The added test in tools/testing/selftests/bpf/progs/verifier_raw_tp_writabl=
e.c
is redundant given the changes in raw_tp_writable_reject_bad_access.c
but I was going to apply anyway.
