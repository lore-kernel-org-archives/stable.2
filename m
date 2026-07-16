Received: from mail-pj1-f41.google.com (mail-pj1-f41.google.com [209.85.216.41])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 639C542FCA4
	for <stable@vger.kernel.org>; Thu, 16 Jul 2026 14:28:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=209.85.216.41
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1784212139; cv=pass; b=YlZQrW/JTd+yqeDtz9SdtSnyb1lLoI1Oci0URcpLqSl3El2BuEPDDsaSbSGAWD4I53OpFnjeTqiLy2g/xDA0w1X/lNfy0zMs6dRVMQNfbzXDr/RaO/7IgWHONH/rZbdeQNDfTTadr9GncOxhet7Mc+o03GsxyRMhjnFtsW07Q30=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1784212139; c=relaxed/simple;
	bh=DfB9IWtbQ2i7/mFdpOyOosw8wiYRxIP7HFdFKYZuz6w=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=kxoPYOaBfglOv1RWC0uOK1MdHJT3JPPX3Iwt//LwcCkfRI5LZ5g4SgpQUOcFuzvQlBn0Yf2gDqStuYUhkhoiYaohR9NAgtMVZ1SHZiaHrKh9a8SrMRo4VWouXlA3ds2KIRgVYWihMmTOIaQ05BYbBQnrRzmcbElsPQHg8dRyG3I=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=CRCiUF2D; arc=pass smtp.client-ip=209.85.216.41
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="CRCiUF2D"
Received: by mail-pj1-f41.google.com with SMTP id 98e67ed59e1d1-381f03d7be0so925051a91.1
        for <stable@vger.kernel.org>; Thu, 16 Jul 2026 07:28:58 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1784212138; cv=none;
        d=google.com; s=arc-20260327;
        b=YABbgsww1LgBvPCF59eMKD6jv213UIPXjuAe/N8Ferk4/hfSem1tC4kcLD7f39AEa8
         TA4392xkx53fYQNakgsXNqAn4zuCzjHqKKmN1lwXgEOCW6R3ohGUG2ymH6fBFJpc0GHn
         Xqol1n6z3kUuO+sGAK08IC2d6LWx6uPn5TGxMY0cpmc4SCT4swM2okbsv/u2t2T7dFf4
         Mch9bhEpDE+H+avvzfagWOhM4y1roxkYV4VVifv60HQYdu5Mgr2sRthwio0S9xV0zhyZ
         v+E/XLdETflKK3U9cohQ3mUSqyZQf99S/EjlOqEV1NcLm+Wh32RxwEARXugt8whduvds
         pdyw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20260327;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:dkim-signature;
        bh=DfB9IWtbQ2i7/mFdpOyOosw8wiYRxIP7HFdFKYZuz6w=;
        fh=drB9AJed13kYT3MC+gyPLjOWPSArAotAIlbq3DoptFg=;
        b=FdTeRKE+jhs+Y+TuaArYmFoEB9kZ2dpazS9YvCOWSoqpJEoV1X2YHIcgXDPb5siqoz
         f+qLeasSpdkIdVFyXrRhXAfCEcTY2nUEPz5fPfluPXWNJAAO/PY4qbcU4Ngdp0Id3KNB
         fTeH2ft8sfb4qJ50d10mtIJl4QrqZXNuZFD3/Swv0MFoZf3whRpN6KFFZTbCZJG6tpQ/
         PrxNvFlx0GTPnpzXR9ETpBXLfsryUlRqqy9FYfZcTG/SaR5kcnqnoydZu67pB+MxhkMc
         Qkj81wiipB5egO7+dy8pSNOZlMpY2XfcuKj008JRd9ev6r+EDUm/LLpPmHrsKHTEu6Pj
         Tk6w==;
        darn=vger.kernel.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1784212138; x=1784816938; darn=vger.kernel.org;
        h=content-transfer-encoding:content-type:cc:to:subject:message-id
         :date:from:in-reply-to:references:mime-version:from:to:cc:subject
         :date:message-id:reply-to:content-type;
        bh=DfB9IWtbQ2i7/mFdpOyOosw8wiYRxIP7HFdFKYZuz6w=;
        b=CRCiUF2DM5/uS95hYCih0DkwKqxsEZDgMN1zQl17dJ9OIi926tmKUJwT3h1Lcp8F6M
         lqqyWl7P2OmGfj5YhPAnH4YgVQfEzUBCgqBZ3nH4KwXmMNiK2Phgd06g09OXzlFQqXSX
         bbzrYI/QcGKdtnEXQ1TuEfH2Pv8+LA9Y/ytc2nK/8KGsqOjIHqKwW/eD5p9S9wTKIKoz
         uAO/AbEKpu9t02D5jNIYbvl+5WAxsYMshDw0opw69zShO16GArc2FZ1QM0tXzEwgQ/Fs
         AREcSrJD77qFJ2Q1Cw8CQEgW2N485Wsj8FdEOzTwBMkr0vA7B4IBSFgBjcqoGOs16nLN
         ecHQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1784212138; x=1784816938;
        h=content-transfer-encoding:content-type:cc:to:subject:message-id
         :date:from:in-reply-to:references:mime-version:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=DfB9IWtbQ2i7/mFdpOyOosw8wiYRxIP7HFdFKYZuz6w=;
        b=SlJsrS40juoEooaC37S8R0jzBtGM5xDw/fyqrw6o6EbMpVTR2akGkDKhkpRtubCXFX
         0ZxIYG3XiEPpHLZtOWPMLp+esljuFfMKKqcN6FHBgZBucSb6djmcw9Hob8c0qjMllTyE
         hyiNyS7wLeEKOi87ZuODRUCwX+dnExG9e8exNRGJ30WAWCIa0PFIe5f1ZMKUzR7JjdBH
         nMUeoUuUsmWrwn8LduEFOLRF3ZDJPSZJQHUj5jSC0BoO/myH2AsIELAjpwpewo3zSU35
         OYAsA1U2hV7d/6kqytxKP0ubB65Y2nxiEv7Ah2MgA3HSGvdDldrf/9PbGoYh9Hmt6fV8
         xr+A==
X-Forwarded-Encrypted: i=1; AHgh+RoCu1YDWTYw+QNXZs3jCBjbb6BvjWVkSeB3tZE8RcpawRPXb4j+ssGg7bgWoRFY74VDsgDKUxs=@vger.kernel.org
X-Gm-Message-State: AOJu0YzdDq4uMt+0N364RkyQ3n4Isw3N/86rztkzlj0yKv3NvrnMPWzO
	WrE/emDEnDVIghINUVzMHryzaHySY0lpLK7+dzoW/fTZ9Cymvqa0Js3A1v65LI4nJGm+kcVGPlt
	tDWvIY4xvWJZxofuBqazKlZqPjU7bIzY=
X-Gm-Gg: AfdE7cnVauZLAw6Ew0ez0lwrR615G+/51Pf3vyIdZC6idwnjMRbTFEgBCnJLEnlCBmm
	HpVzd7iha5HxGQ8Kh9feXexkmJvHHHoqI16VvvNxWodeptwV9zeUxF6wj/BQaGnL08bweQAKhMC
	mxtDJdz4dNRPGZJiZeliV6pRnh9vTn72fWranOAzydlgWFqIyZAWnwzdUUlyqVNOaYzqW6soVZ+
	PbwvBuVsOsh2ol8BTTB9wq9Zk4eCBlNu0sGlfBTCFlycaTx74Keg1svZW68/pa6NgAVcdvbfhrM
	y4/nR6SXmO60gzHxERt1/OzMsQNDZ+Y+NPkHcjiY62TPo85EA0IhAqqDmDMaphvpxeE7OtAzrL7
	yvQ==
X-Received: by 2002:a17:90b:48cf:b0:381:2788:a437 with SMTP id
 98e67ed59e1d1-38dc7a978edmr14844482a91.1.1784212137665; Thu, 16 Jul 2026
 07:28:57 -0700 (PDT)
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20260716-device-trail-semicolon-v1-1-f48e9dcfae15@google.com>
 <CANiq72n3BYGfB9VvLk4-bBQzGy9YhDxFvCrjkjJqBbcJa5YRYw@mail.gmail.com> <DK01JT88NEI6.1TTJR16A61780@kernel.org>
In-Reply-To: <DK01JT88NEI6.1TTJR16A61780@kernel.org>
From: Miguel Ojeda <miguel.ojeda.sandonis@gmail.com>
Date: Thu, 16 Jul 2026 16:28:41 +0200
X-Gm-Features: AUfX_mxEo7Na8S_Zfjwk-IJFfG8hfJYcWvQK3HRVF7C8IC1nwjWKc-JhNNi9_Vw
Message-ID: <CANiq72=OKHJo0Shzb_h1OuzmTVLqn6qPJsA_AhJAWOfQATbYDQ@mail.gmail.com>
Subject: Re: [PATCH] rust: device: avoid trailing ; in printing macros
To: Danilo Krummrich <dakr@kernel.org>
Cc: Alice Ryhl <aliceryhl@google.com>, Greg Kroah-Hartman <gregkh@linuxfoundation.org>, 
	"Rafael J. Wysocki" <rafael@kernel.org>, Miguel Ojeda <ojeda@kernel.org>, Boqun Feng <boqun@kernel.org>, 
	Gary Guo <gary@garyguo.net>, =?UTF-8?Q?Bj=C3=B6rn_Roy_Baron?= <bjorn3_gh@protonmail.com>, 
	Benno Lossin <lossin@kernel.org>, Andreas Hindborg <a.hindborg@kernel.org>, 
	Trevor Gross <tmgross@umich.edu>, Daniel Almeida <daniel.almeida@collabora.com>, 
	Tamir Duberstein <tamird@kernel.org>, Alexandre Courbot <acourbot@nvidia.com>, 
	=?UTF-8?Q?Onur_=C3=96zkan?= <work@onurozkan.dev>, driver-core@lists.linux.dev, 
	rust-for-linux@vger.kernel.org, linux-kernel@vger.kernel.org, 
	stable@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Thu, Jul 16, 2026 at 3:48=E2=80=AFPM Danilo Krummrich <dakr@kernel.org> =
wrote:
>
> I can also take it through driver-core-fixes, I have another minor fix to=
 send
> anyway.

Thanks, no worries, I will take it -- this kind of fix makes more
sense in `rust-fixes` since they are treewide, i.e. it could have
triggered in more places at the same time since they changer the
compiler, and I have other few in the branch accumulated for Rust
1.99.0.

(An Acked-by is always nice of course!)

Cheers,
Miguel
