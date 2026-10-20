Authentication-Results: smtp.subspace.kernel.org; arc=pass header.oldest-pass=0 smtp.remote-ip=209.85.208.42
ARC-Seal: i=2; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=pass;
	t=1792487099;
	b=L3GJNfHveK5YzZ/mLUVxvj+NlQNAQCVrxyUJ5f8fXMkryLQBDynlhSJwt8k7NAlRoLYM
	 u10dyNGbt4+dqIVZTy9v278R+YyigLEMu6RfH/MoaamB27K+YW14bpesjND7VO1kP5lT0
	 +VOFPU2nul/UH+3FEpjMmamTShSn5FRbhsSIoSjM5I+u43CwUCUwYRAQD0DRI1fgt/3xb
	 I26toOwL+dbOubWxHoiOksEtvYWuKruTJu8tN8YHQULw73zHqY5rzfDeOZchvQuk19ByE
	 iAzoUMooGhQIiNZUHY7Uu54BKA17IhBPN551JhXTI5JMezi9BzYV8zCiQiZbMYDhVlQ==
ARC-Message-Signature: i=2; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1792487099;
	h=DMARC-Filter:Received:DKIM-Signature:X-Google-DKIM-Signature:
	 X-Forwarded-Encrypted:X-Gm-Message-State:X-Gm-Gg:X-Received:
	 MIME-Version:References:In-Reply-To:From:Date:X-Gm-Features:
	 Message-ID:Subject:To:Cc:Content-Type:Content-Transfer-Encoding;
	bh=1EQskYS0D7RQlbdc42q06B8aUfDjbkE64g4Pl0A7js8=;
	b=es0IMmEf5rDsntEzGbX1kIvTUpIRsgN3usVy0+TXUwKYHY6/QmI3LYSsGqy6aKz22Uw4
	 +a4OrlO31DH3ByRIiH2SU3GV+oyIA37YGkHXPiMUin0atOjXwRNMD9wT3Pv0iehq/DZN7
	 akAWtQSMscCY/nneOCQyfqF5Ok3BdSE/sufQkk3DUqACBJ2X5Zgiagop2dK0wOSYLu/dz
	 n5IlmkyWQ+hQficxvIfEb8HQxUDoIx/TixkvmLxj17U/VlbVeg/tDODdhtnpMFumHP5Zb
	 bJaQNpxnwlzVMra4HaDieeDjeVKZIcujx3trguwGx238zhUAOmwtiFyPeiD95JaUY7w==
ARC-Authentication-Results: i=2; smtp.subspace.kernel.org; 
	dmarc=pass header.from=google.com;
	spf=pass smtp.mailfrom=google.com;
	dkim=pass header.d=google.com header.i=@google.com header.a=rsa-sha256 header.s=20251104 header.b=KS1AFbh+;
	arc=pass header.oldest-pass=0 smtp.remote-ip=209.85.208.42
Received: from mail-ed1-f42.google.com (mail-ed1-f42.google.com [209.85.208.42])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 25423606A31C
	for <stable@vger.kernel.org>; Tue, 20 Oct 2026 09:04:59 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 25423606A31C
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=google.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=google.com header.i=@google.com header.a=rsa-sha256 header.s=20251104 header.b=KS1AFbh+
Received: by mail-ed1-f42.google.com with SMTP id 4fb4d7f45d1cf-6b1d8944cb0so4246816a12.3
        for <stable@vger.kernel.org>; Tue, 20 Oct 2026 02:04:58 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1792487097; cv=none;
        d=google.com; s=arc-20260327;
        b=V+wqotsrkTjaGoSPC4ujmMxMhe0ypzKnuTvVuSfhsx9U2OrGx+MI4xAyasiw+gCqbD
         omU7ebzlXisEZXBhAvYmUaLYYCvaXRjd7RErjL/6eiO9L8GHrrHTXbhx5k0uFK9ccRsS
         /x73mJmYT67TFOx31uTxnyYsHQMhxU5dybEmLIQu4HdWbOchViECe0FASJ3i/A6f4OEp
         KxBS+ZV2WazzKo101fzFphBS/T+gArqWvinYz6V/PWm5MJEhGpR3fcTQQwU7ICxhxDXW
         YGxn452dDtpf9tYPPOr3eKQGkEGrbQ8cS2RZLoI2+AUlXqR/BuE8wQSCVhTjw7sSdhCn
         XUsQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20260327;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:dkim-signature;
        bh=1EQskYS0D7RQlbdc42q06B8aUfDjbkE64g4Pl0A7js8=;
        fh=BV+uvhmJB42jISDAAB7bHSkZ5rWoD07FmtQYdMQezaM=;
        b=eoWWcs89eQ920bqu+qPLCYvL2sZW2rfZnGWYLQDsrxScyGJEJRSxpz/jGNt91pldUt
         tWRv+UkhtAeDSCfGxz3HliUPdU9BgJnRqYjhXuelIedngqluJchXCvYX65tBXdEmnPNz
         0TJEMKp6Kc546m0sXGADkOYQgTx6afPB/XvdbmvexqbmZWN9STQ+FeXwugaB8U615FVi
         efUJdY9bhx8HlWQpwioEWKAkfyMb5DYQ/8ZrOQC9l767LprrsrYRBvUfZHF6DPe2mNk7
         OcPVbr4mswQS9nn9xuhr94yk0t+tBjFecsQ68v1RwWIx1Kndt4EOxFjy5xQnrfRmUY72
         uldg==;
        darn=vger.kernel.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20251104; t=1792487097; x=1793091897; darn=vger.kernel.org;
        h=content-transfer-encoding:content-type:cc:to:subject:message-id
         :date:from:in-reply-to:references:mime-version:from:to:cc:subject
         :date:message-id:reply-to:content-type;
        bh=1EQskYS0D7RQlbdc42q06B8aUfDjbkE64g4Pl0A7js8=;
        b=KS1AFbh+RUlnRyYczf9BUEUIZP2JMbRVV77kkceNuVzuBNDF7PZsCn0FqeVeq4C7G0
         UMjgLX0PzOuiah80ZL7AQFlVaEBqlUZGCQ3MNGOE0g4kmL8Kppj6zmf/W41FCBqZxzbN
         uPl8HfSZvhjSXeBajx81DGSmebBgDPSsYAmG3kqa2f7QQLqHcdR8psbIjSUdojuo567y
         1gwpytO0Jo/sjRQ2yyKVRMdcLxuYyMWuttYovpbSGiVGMxjIp1E9a49P6fGRgYs7Q9iR
         Bpzgl/rJXkitTaOBMHqBso7HYX0Wnyr++rNZkupjnbsoKZ0VwsEwLJOPV4J54utgkXix
         IicA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1792487097; x=1793091897;
        h=content-transfer-encoding:content-type:cc:to:subject:message-id
         :date:from:in-reply-to:references:mime-version:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=1EQskYS0D7RQlbdc42q06B8aUfDjbkE64g4Pl0A7js8=;
        b=dJt9N1PKu9Wo65cGRf6jhDVICo02S2q5tx327j5MJlOlAt4uRVQ0DKVkHU3JUUGZhB
         REHSo5R5NhwXGWFvJqlDtCzRKvgrQ+SnZHXr/aYPU9ptcVPmdE6RQU+m4tjyshD0Eymc
         B5IrMiPElfc0CRGnMArscUOidc3eGcF27LGeJF5si3EnwBbG/i8peL7hI4cFbEE5xYTD
         t1QQjHnnR23fs/NKllAlHtQpfOcpLREdmCAtDAHMru1pnSV8hcR10KkmGreGeeFbThbr
         klBSeGwXMRYdaGS8LSpqY3wbqMMatzWxbk59uBU8hli55oets997u4EfJ0d8yGOVO2aU
         7HvA==
X-Forwarded-Encrypted: i=1; AKwUvBxdpBVhL/fGbGk1fvG4bh30iRnZaMQn9+E9qYjsD26wInuo/RIAL2OLcu/MBdHsjy9zz0J67dE=@vger.kernel.org
X-Gm-Message-State: AFq9FYK0MX9Yz6Js+tg/rhRJxDJhzUtW78OA7rJbikWu/s+YfJ7aVXBS
	P3cxeR/3UNvo5HcsPXuVvDFemlhKW8O3BVsmtaQs4hfRVM+ipNK60Y0o87aZceNCVIXkDr799UV
	3uytaKinZgdK95il0xUkgiVqJUt5yFKsTC4RKMasv
X-Gm-Gg: AYBFou24s3MSLLraM5HdjFfMyzA5il4qghTqfUjdNbNLV11Ys2Ogtk4W741lJRZO0Vp
	GRaIImBrdZbRRE1SMHj7uxmBjAoQvHB/mOOIk/pAw36gHUE6bsKZV+mhjrVDl/QiHvoR5OLZ0X+
	qwlIG5+uBSA56adjapOhivz4pyezZ9yhIhbQ5YgzzIppRLYlDbjHta3kS/1SekVax7R7qJxEhkQ
	cDE9NBizPwJeoQXIygLSrvD1DwYeqmzW1LvpjBkAhZ1vm4dh0mIkBO+syRvPV55duWlJ4QHXAcz
	1KSH5aS0lM3u1SVTs29JMOqi/c5J5pM8YRcL8OPIs2wA6bLFCJlfX8ljHq0i5yA+btabkK8HUQ5
	LyEqWdbWHBtANZaGWg+MvRTEfuazWDR5H2mOhA9KghkB/phNEojtnus1PFkNaauYRPszMepw5+k
	QK/HLA1Z8U2tIJ
X-Received: by 2002:a05:6402:27d3:b0:6aa:ff76:3076 with SMTP id
 4fb4d7f45d1cf-6b3a8191bddmr6786581a12.32.1792487096676; Tue, 20 Oct 2026
 02:04:56 -0700 (PDT)
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Post: <mailto:stable@vger.kernel.org>
List-Help: <mailto:stable+help@vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
List-Owner: <mailto:stable+owner@vger.kernel.org>
Precedence: list
MIME-Version: 1.0
References: <20261020-fwctl-cfi-encoding-v1-1-ebb30d1500df@google.com> <20261020115534.1134f2b3@inno-dell>
In-Reply-To: <20261020115534.1134f2b3@inno-dell>
From: Alice Ryhl <aliceryhl@google.com>
Date: Tue, 20 Oct 2026 11:04:43 +0200
X-Gm-Features: AclHuK8s5pDVPA952Sda847MnmKxiPykXZ_GhxHRu1vfO-Km8lE5fIjR6TFHhMM
Message-ID: <CAH5fLgj6oCjVheVLYu+X=ptFA-+x4cznX1+bgWT3ayndiA6eiw@mail.gmail.com>
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

On Tue, Oct 20, 2026 at 10:56=E2=80=AFAM Zhi Wang <zhiw@nvidia.com> wrote:
>
> On Tue, 20 Oct 2026 08:28:37 +0000
> Alice Ryhl <aliceryhl@google.com> wrote:
>
> > Currently, VTable::fw_rpc_callback() takes scope as a u32, whereas C
> > calls fwctl_ops::fw_rpc with enum fwctl_rpc_scope. With kCFI enabled,
> > enum types are encoded distinctly from integers, causing every fw_rpc
> > indirect call into a Rust fwctl driver to trip a CFI failure. Thus,
> > generate fwctl_rpc_scope as a newtype with a cfi_encoding attribute
> > and use it in fw_rpc_callback().
> >
>
> Thanks for the fix. Looks good to me.
>
> Reviewed-by: Zhi Wang <zhiw@nvidia.com>
>
> BTW: I saw this =E2=80=9Clru_status=E2=80=9D needs the same treatment, gu=
ess bindgen
> will someday automatically handle this?

I believe lru_status is already handled.

Alice
