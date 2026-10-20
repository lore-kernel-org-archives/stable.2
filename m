Authentication-Results: smtp.subspace.kernel.org; arc=pass header.oldest-pass=0 smtp.remote-ip=209.85.128.43
ARC-Seal: i=2; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=pass;
	t=1792489247;
	b=b+F1/LTs2uW/ACLnCc/ShsakEWEVSoXmJGQQfaEc4ZBmN55jFK67klt5nY720w5wysXK
	 osVDWO8d6zzcZHGTaJuwXwu4nVogdNpkVAugsut/pNgsTASajzRhkp7E7Y/3NHsOCUf19
	 2hNvN5a90wjq72Nyc6OZ6Gfk9T8oJxnxhANjhcUDbf04ULh3PkQuZkq7lLb3HmJK4cA8P
	 cTvnC/Vz05GuHlomnrFS0iYlnDBBDG7+i51HOzqCe0J2NxqpuPh3ohlOIScweZlsLU4rb
	 2hZl14IjgmtWPhOl6B0cLbwfpXoCk4ckqLyOupz2450Yl/yZzaLzLWh2Kev4Uev2Tfg==
ARC-Message-Signature: i=2; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1792489247;
	h=DMARC-Filter:Received:DKIM-Signature:X-Google-DKIM-Signature:
	 X-Forwarded-Encrypted:X-Gm-Message-State:X-Gm-Gg:X-Received:
	 MIME-Version:References:In-Reply-To:From:Date:X-Gm-Features:
	 Message-ID:Subject:To:Cc:Content-Type:Content-Transfer-Encoding;
	bh=aGDzBe9wSfOot1JNH8CfshOMHkOZ/rP5xat4GkGedRw=;
	b=k5fUZw4fLTMbfj1gttEZDVMuHRYFyxRhuQAWhIlY+zGNBHTrRkDqj4MkSdEF+CGKCf1h
	 pAqc6t0096GO6zLri73ZT8kNUxmFGk9VxWOpOKTB/fG4cCXTLHUdkn5+6+lYMqbXcmbqQ
	 N1+EbamlT4OVROYnkBLt4vv4U3Sno+1yelRYMZI0m5pjJ+iF6pjC4Nl44HpVoO43oSfHW
	 xnDjk0+8ETYkvduC7VqgskNWjYcPJS6S8ZmtlBXkKKfF8PKxojbYn303J+ur26DGyLman
	 AM6lQ40nyxPqVpRoEmEAhTYyxAHSSQvte9bx5BViGYMzRA7lcXQSR/vSKUfmqdUPBGQ==
ARC-Authentication-Results: i=2; smtp.subspace.kernel.org; 
	dmarc=pass header.from=google.com;
	spf=pass smtp.mailfrom=google.com;
	dkim=pass header.d=google.com header.i=@google.com header.a=rsa-sha256 header.s=20251104 header.b="gG91j/Fh";
	arc=pass header.oldest-pass=0 smtp.remote-ip=209.85.128.43
Received: from mail-wm1-f43.google.com (mail-wm1-f43.google.com [209.85.128.43])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7CDDA606A325
	for <stable@vger.kernel.org>; Tue, 20 Oct 2026 09:40:47 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 7CDDA606A325
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=google.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=google.com header.i=@google.com header.a=rsa-sha256 header.s=20251104 header.b=gG91j/Fh
Received: by mail-wm1-f43.google.com with SMTP id 5b1f17b1804b1-4a1fa22006cso467515e9.1
        for <stable@vger.kernel.org>; Tue, 20 Oct 2026 02:40:47 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1792489246; cv=none;
        d=google.com; s=arc-20260327;
        b=i7Bwiff/2k8kUOsxpX6vT/bJGVWoRHj1sjnnUv+SEFUiXbGZdqOaoNoMKieZE+6L26
         yPU5XOn1QZxiuOySkpWLuKWmt9J3/k/cMBcTWqRBLTc02AVBPJ9OuRbJ8MbE2U2bx4fC
         9ba1H0V1EztYcSsp3EBHeXC/5E6btoY7OK90rJRJYv1lw1EAIg0n9shbvUzC/hK/csQe
         4xksxelpmGqdqYDRuYUwCgXcd8EbX2cDfI9f7zVymoVcQEzy54VCjv2ueIoMJ0alUBCt
         tYp7R5AtCbkdGuAfFp0dl5wn5nBpKxRMTGlKH6e1v2y6/9YgbCZZK92tkz2njlMzphuP
         fcLA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20260327;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:dkim-signature;
        bh=aGDzBe9wSfOot1JNH8CfshOMHkOZ/rP5xat4GkGedRw=;
        fh=Hb8i+CiCSquoMUnb1khu7TxElRQtcISmeBKECu9Nduc=;
        b=PwwN1AqZ3xfJxbbWPGZknYzA7WlQKTLnvF7kND4Hfk4bB5/hVbmnXYuXMmfMISq+Fn
         sQ5i5XOk9KYCC/7RKcfnlYTywYFLn/A3bjfvt7vCYcC1kcGDjjfvkPeMC8TT7idI7ctM
         5vXceiJ3UZKE99dsI4BlLw2YqpIk5uay+WldBPai6LvYqOtlBVodjgcfE0DjbLMM3/St
         askUm9tckSaR8n+meXEgotLaa9he6M05sIHpVF2iAGoJssDs/Q29ecR7dbML8dTMJ6QA
         as2P3RORMQDf4v+zopYyWgNxSlzajqXzNE3N3UTJlPWjAks530vuUtTvdOWUkKtH/kRu
         /82g==;
        darn=vger.kernel.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20251104; t=1792489246; x=1793094046; darn=vger.kernel.org;
        h=content-transfer-encoding:content-type:cc:to:subject:message-id
         :date:from:in-reply-to:references:mime-version:from:to:cc:subject
         :date:message-id:reply-to:content-type;
        bh=aGDzBe9wSfOot1JNH8CfshOMHkOZ/rP5xat4GkGedRw=;
        b=gG91j/FhXglb0AljTZi+SztoO7prTJ1Kped+u9wquVXS6rrw5nR3KY7eDXhjJjYMaV
         /bHGrTDsBkUfp6sUWh+QQOo7IqFsjLmT4OcY7hY1dJUSwIGu636c4vLCw2UjMm10259O
         GEdX+Gga4FYJVKtlPHWUOj2Kw5haJsOaO5Ij7ptYnGbyGPJyDb5rKS1JfkskopCSB97i
         oJtcDuI4HW1sqQ1Qogvgy36ry3XPb581DX6c5LQNHFs/TQ3dYfpTrogXj8cVm9h31AED
         I5W381ue/hLcEEJ0Tg9/ta9Ht+a03o4bkzyIMum2NCJPiz700y+CzDvl96W6wBMc4y8b
         mu/g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1792489246; x=1793094046;
        h=content-transfer-encoding:content-type:cc:to:subject:message-id
         :date:from:in-reply-to:references:mime-version:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=aGDzBe9wSfOot1JNH8CfshOMHkOZ/rP5xat4GkGedRw=;
        b=xlALsYXGRyC4LPqemAmIHvkAteoiGqBU8QNuIZX7A3XERRPoK+tN2eoFE5Ejwp5DZB
         4TbAg/TABuxKMOVYM7o+T3eK6F9mX0YHigTSaTcb/zB9LloO04O3smhysD26UStDw8IL
         LrkmRG0vqgJO6rG7wOkVVeBGyBYPs84EXpmekXzMbS5GHEaq0LbUmaTh/1AkmAoFL9/q
         JtgoEU5yac0LHSYLDTY36eNiQVO1AQJ8HidC4pHk4bFfBE4wWBEfrY4DfrOXbZs6gtso
         xyPffrkKfL5M8iAt1Y23LbrSDWILBebkwG5/mIc+5o1N0TuAUuyK4P86w1OjkQKVXGHf
         B1og==
X-Forwarded-Encrypted: i=1; AKwUvBzWJ3nA2cV7GN1LYOXcPWMx+0m8BqRMVCT4mtt1OGrxqznbuOBsQIk+5fSWDovXVCMK18UNHTw=@vger.kernel.org
X-Gm-Message-State: AFq9FYLV7T4oSefKOOqXuXy0+4zXLXWEfH9+zKjXt6VHvbsnA03NK4ji
	RAby6VcYyo414IsdLtCtqQtX0hbogXYe1vYbSU5Omu6zVkBkh/5L9KyNbDGsHp+nX3M38z+7Z0q
	Vqm2Uo6OXus2gPTb3g2MzylAa4W9VjxJMJpheNQ8W
X-Gm-Gg: AYBFou01zpEjoGSkZ/pKZwlsHldVpenUDsg1AXYfbuBtNuUsIwrsYjq+oFKUASbIBlH
	ItEOEX9gYdYZUOfoUkmqEMuDENoIH3KO2zLm9umywX+z2XjBw6cAX/JLLeESA11/CyCtTkfK6QP
	k6sRnyHhgwgQeVLDBfurNb4pRekl9IyzcnUtZpPRF6PhpR1uNRBVUHKpyADe/AG/zhvZW70GtOt
	0TyWuqTsu7YhlLEDGtWVfvBBQRK1j8A07sD7W9A7zsKMjvmPmX+bnYNR/CI+MH5hyywxPPPCHVN
	mkq7MuA3Hzcp4o5L5uXfTZl8bmw0CvyyKgHatxShlhNgVvnAwdAn09jcCmHaM+F9if+z7wjHLH3
	V4NsvExpDutp9Ou1qG3oU
X-Received: by 2002:a05:600c:c090:b0:4a1:702f:c736 with SMTP id
 5b1f17b1804b1-4a1d75af24bmr181205285e9.3.1792489245370; Tue, 20 Oct 2026
 02:40:45 -0700 (PDT)
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Post: <mailto:stable@vger.kernel.org>
List-Help: <mailto:stable+help@vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
List-Owner: <mailto:stable+owner@vger.kernel.org>
Precedence: list
MIME-Version: 1.0
References: <20261020-fwctl-cfi-encoding-v1-1-ebb30d1500df@google.com>
 <20261020115534.1134f2b3@inno-dell> <CAH5fLgj6oCjVheVLYu+X=ptFA-+x4cznX1+bgWT3ayndiA6eiw@mail.gmail.com>
 <20261020120852.6d2ff11b@inno-dell>
In-Reply-To: <20261020120852.6d2ff11b@inno-dell>
From: Alice Ryhl <aliceryhl@google.com>
Date: Tue, 20 Oct 2026 11:40:33 +0200
X-Gm-Features: AclHuK9BrUjMuF23vOzcGkpwaIs37hezkcv9StlIIIkbNAypoyvDRfKJpnSfuq4
Message-ID: <CAH5fLggw3afkFQW-5NM9MqCqCtTPu-Na0GZYsx94MV1=P8YJ0Q@mail.gmail.com>
Subject: Re: [PATCH] rust: fwctl: declare cfi_encoding for fwctl_rpc_scope
To: Zhi Wang <zhiw@nvidia.com>
Cc: Miguel Ojeda <ojeda@kernel.org>, Boqun Feng <boqun@kernel.org>, Gary Guo <gary@garyguo.net>, 
	=?UTF-8?Q?Bj=C3=B6rn_Roy_Baron?= <bjorn3_gh@protonmail.com>, 
	Benno Lossin <lossin@kernel.org>, Andreas Hindborg <a.hindborg@kernel.org>, 
	Trevor Gross <tmgross@umich.edu>, Danilo Krummrich <dakr@kernel.org>, 
	Daniel Almeida <daniel.almeida@collabora.com>, Tamir Duberstein <tamird@kernel.org>, 
	Alexandre Courbot <acourbot@nvidia.com>, =?UTF-8?Q?Onur_=C3=96zkan?= <work@onurozkan.dev>, 
	Dave Jiang <dave.jiang@intel.com>, Jason Gunthorpe <jgg@ziepe.ca>, Saeed Mahameed <saeedm@nvidia.com>, 
	Jonathan Cameron <jic23@kernel.org>, rust-for-linux@vger.kernel.org, 
	linux-kernel@vger.kernel.org, Sami Tolvanen <samitolvanen@google.com>, 
	stable@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Tue, Oct 20, 2026 at 11:09=E2=80=AFAM Zhi Wang <zhiw@nvidia.com> wrote:
>
> On Tue, 20 Oct 2026 11:04:43 +0200
> Alice Ryhl <aliceryhl@google.com> wrote:
>
> > On Tue, Oct 20, 2026 at 10:56=E2=80=AFAM Zhi Wang <zhiw@nvidia.com> wro=
te:
> > >
> > > On Tue, 20 Oct 2026 08:28:37 +0000
> > > Alice Ryhl <aliceryhl@google.com> wrote:
> > >
> > > > Currently, VTable::fw_rpc_callback() takes scope as a u32,
> > > > whereas C calls fwctl_ops::fw_rpc with enum fwctl_rpc_scope. With
> > > > kCFI enabled, enum types are encoded distinctly from integers,
> > > > causing every fw_rpc indirect call into a Rust fwctl driver to
> > > > trip a CFI failure. Thus, generate fwctl_rpc_scope as a newtype
> > > > with a cfi_encoding attribute and use it in fw_rpc_callback().
> > > >
> > >
> > > Thanks for the fix. Looks good to me.
> > >
> > > Reviewed-by: Zhi Wang <zhiw@nvidia.com>
> > >
> > > BTW: I saw this =E2=80=9Clru_status=E2=80=9D needs the same treatment=
, guess bindgen
> > > will someday automatically handle this?
> >
> > I believe lru_status is already handled.
> >
>
> Yes, lru_status is already handled.
>
> I meant that both lru_status and fwctl_rpc_scope need explicit entries
> in rust/bindgen_parameters. I was wondering whether there are plans for
> bindgen to generate the newtype and matching CFI encoding automatically
> for enums used in function-pointer signatures, so future additions
> wouldn't need the same manual setup.

That would be nice, but I'm not aware of anyone working on it.

Alice
