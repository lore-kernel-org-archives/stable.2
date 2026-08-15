Received: from mail.w14.tutanota.de (mail.w14.tutanota.de [185.205.69.214])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7FE703168EE
	for <stable@vger.kernel.org>; Sat, 15 Aug 2026 14:56:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=185.205.69.214
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1786805773; cv=none; b=VXQvwnlXMREZQoAXKIZKjR6lYF8h9FmSu+yI9wkgFqeldy67Des9Ev/kzz3RICKJO2Ra1MlllkF06I8rMdciijlCfL+stzsxyCB1jd9OI4YPa5AxIutd2atiVz68xVmSKPOfhAXUooYeDAEuop1OP8Sj/YI4JwO6iCYrBZycAb8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1786805773; c=relaxed/simple;
	bh=MCgyTApuWEpPfzipyyNLwQwH2m4XFsu9VAQ0gyHhjjo=;
	h=Date:From:To:Cc:Message-ID:In-Reply-To:References:Subject:
	 MIME-Version:Content-Type; b=phlKwZydfvmsgw67cS1eXJS7B1ZDKQvWWE4eiaKdnXYgjpbFXUwSFIUQgBkoRnH+XBimweaRQ/zPol72dyGUVFuAcUT8zAXsshgQMUQgGwKYFc7uTnGXJomQDoUFPfoV6xaFAmobuEYmzUcmcaLSx4ACbkVuMZ04+07Jrr8iJes=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=younes.io; spf=pass smtp.mailfrom=younes.io; dkim=pass (2048-bit key) header.d=younes.io header.i=@younes.io header.b=hkoV14qC; arc=none smtp.client-ip=185.205.69.214
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=younes.io
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=younes.io
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=younes.io header.i=@younes.io header.b="hkoV14qC"
Received: from tutadb.w10.tutanota.de (w10.api.tuta.com [IPv6:fd:ac::d:10])
	by mail.w14.tutanota.de (Postfix) with ESMTP id 875FC172857A9
	for <stable@vger.kernel.org>; Sat, 15 Aug 2026 16:56:05 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; t=1786805765;
	s=s1; d=younes.io;
	h=From:From:To:To:Subject:Subject:Content-Description:Content-ID:Content-Type:Content-Type:Content-Transfer-Encoding:Content-Transfer-Encoding:Cc:Cc:Date:Date:In-Reply-To:In-Reply-To:MIME-Version:MIME-Version:Message-ID:Message-ID:Reply-To:References:References:Sender;
	bh=MCgyTApuWEpPfzipyyNLwQwH2m4XFsu9VAQ0gyHhjjo=;
	b=hkoV14qCa+WaJvSDgHHl0niySWxtjFSiLKthr/fJM+T9wZHcfv4msx6tRavfffLw
	cJduKbwZ1QvpbjBrF6d+Fk7hM17WZlJlC0BHv/9AHdgM17xKyKb7n68KLjcFEVFHP2n
	1YCchXudOEhSFa8Zy3WYrkO4ctJzq7XZBIeWgmP8ReZroe1AFmFztWfG2d+mmYuYOyu
	58kXxBGtojlPjICGKORvyslBKxj4Z9ZzmfeK9yn3P9KmsSemy6yBvQ7rghzP5vFsE4B
	UCdIdzsF0Isxk/JWeTjdtYBFpoQTocm/maz7dmU1/AMD3jW83Nw778oiKYTXNusnLVu
	y5nT7AovkA==
Date: Sat, 15 Aug 2026 16:56:05 +0200 (CEST)
From: Younes Akhouayri <git@younes.io>
To: Miguel Ojeda <miguel.ojeda.sandonis@gmail.com>
Cc: Alexandre Courbot <acourbot@nvidia.com>,
	Yury Norov <yury.norov@gmail.com>, Miguel Ojeda <ojeda@kernel.org>,
	Boqun Feng <boqun@kernel.org>, Gary Guo <gary@garyguo.net>,
	=?UTF-8?Q?Bj=C3=B6rn_Roy_Baron?= <bjorn3_gh@protonmail.com>,
	Benno Lossin <lossin@kernel.org>,
	Andreas Hindborg <a.hindborg@kernel.org>,
	Alice Ryhl <aliceryhl@google.com>, Trevor Gross <tmgross@umich.edu>,
	Danilo Krummrich <dakr@kernel.org>,
	Daniel Almeida <daniel.almeida@collabora.com>,
	Tamir Duberstein <tamird@kernel.org>,
	=?UTF-8?Q?Onur_=C3=96zkan?= <work@onurozkan.dev>,
	Rust For Linux <rust-for-linux@vger.kernel.org>,
	Stable <stable@vger.kernel.org>, Younes Akhouayri <git@younes.io>
Message-ID: <P-4v-PO--F-9@younes.io>
In-Reply-To: <CANiq72kAkDeyqPKHHMT3gRNyC35R+934jNNQOKKytMpmwPwLCg@mail.gmail.com>
References: <20260815-fix-rust-bounded-from-bool-submit-v1-1-882227bf40ba@younes.io> <CANiq72kAkDeyqPKHHMT3gRNyC35R+934jNNQOKKytMpmwPwLCg@mail.gmail.com>
Subject: Re: [PATCH] rust: num: reject bool conversion to signed one-bit
 Bounded
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
Feedback-ID: 017a4576e383ca5e4eccfa1f2259bb19c2dec03584c01d38b9d90ddf5151b20911e3d9ef144c55bbe3dc4f7ace3695f8c3:TurnOnPrivacy!:tutamail

I tested this in a Linux Docker container with Rust 1.85.0 and two CPUs,
alternating 50 builds of `rust/kernel.o` for the parent and v1.

The difference was 1.16 ms (0.066%), similar to the identical-source
control at 0.96 ms. So I could not measure a clear slowdown from the
patch.

Thanks,
Younes
