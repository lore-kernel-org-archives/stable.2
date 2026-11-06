Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=100.103.45.18
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1793982973;
	b=iAMbyd7Gdmj3auWwjnD/e9S8Ul3e+HalGukGxKi4SMy4BSUPPcr+tQpUvmQxnoKZ51lo
	 VnKjVDXXrEvEZU89Tro4pF31dLiKDNlRI4pmtsOzVnfihazW+gTfo8GjKxb8gYCvoE5Nm
	 4Oj0Ll0SetOjuSkWH7WDyTY9vn8PAm4yBHmXwHE58xPvsIde3d7+gbE5q0bjuzR0pZ3eM
	 RdPZwAWM/AenE8kColsWmyjGTc04U3IZS2QmqYDNR2jd5e0rQ/ckk/dfK8pr/c5+om1kC
	 NbMEg6KBu/ipMKdVQaTYeeNVE9VL7TNTDmzRCP+amTBMP1njAf4GEACuK6VkfOUHfPA==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1793982973;
	h=Received:DKIM-Signature:From:To:Cc:Subject:Date:Message-ID:X-Mailer:
	 In-Reply-To:References:MIME-Version:Content-Transfer-Encoding;
	bh=0Ucu+wZ8GvlMied5VkmijzF0O4j9QKVD5tQ1is0T5W8=;
	b=jEAt7tIPm2xEfxUBcK71v5UMymYyix0ev4qA7dwfRUYkbcvmx9NrBVdi6u9qXjPP7C3Z
	 43Bvx9SSE5aGOtCblg0UHCaIi7iUnJgnVi9S8vdszlqlvfQ5LoUBpbMVoiZ+o91ZlNrhE
	 O5Nmdm+vF/ywsbry44CtIaBrZVOp74cv2zrLh3OEoBJM02g4dW0XfJo9b6q8mnI8FiKfS
	 wShwV+n8Fvt3r+CEU+8ohwrqyzLJkZpeICya1nWF9/Gw5NvNv4TXs/NH3X2JO5pybFR4h
	 172Mh9XR/rDr539mLS3BGk/1kXU5HOu61WbYt81jfyZ0Hqc87Xm3SorjTGosoGKQeJA==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dkim=pass header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b="Zl2A/+21";
	arc=none smtp.remote-ip=100.103.45.18
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6976D606A337;
	Fri,  6 Nov 2026 16:36:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=Zl2A/+21
Received: by smtp.kernel.org (Postfix) with ESMTPSA id F025C1F008A3;
	Fri,  6 Nov 2026 16:36:10 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1793982972;
	bh=0Ucu+wZ8GvlMied5VkmijzF0O4j9QKVD5tQ1is0T5W8=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References;
	b=Zl2A/+21xs0211gyvpTXAHoUpNGDM3/50z5nx/dIGJvxCMHfPDELZ7u1VdigiYbBz
	 0iKuO9Iw33sIN4Hhgey451KDMT/ZDHh1t9X/L5h4wuAJxOKEdhOxAJuEhWbGGe9e89
	 seaxpBiDDC+qBed11TlwNdnad2G201W0JNkPhQMJX+sQ/aoHX9+LSePoAQ76iceO57
	 UT81Nj31s0kpzthUvxwYLhhldG5W9/vRitHksZVmbgUssNPmwyZ6Kt71FWWH2VosaH
	 pjpV2XGXGs7m8yhBG7yGowsIFENXqrxW6koNsvZ1kQ7I6C5ejrQHG53WmtcQRnBRnI
	 n4ruWC3A9mSng==
From: Sasha Levin <sashal@kernel.org>
To: Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
	Alice Ryhl <aliceryhl@google.com>,
	Burak Emir <burak.emir@gmail.com>,
	Miguel Ojeda <ojeda@kernel.org>
Cc: Sasha Levin <sashal@kernel.org>,
	stable@vger.kernel.org,
	Yury Norov <yury.norov@gmail.com>,
	Boqun Feng <boqun@kernel.org>,
	Gary Guo <gary@garyguo.net>,
	=?UTF-8?q?Bj=C3=B6rn=20Roy=20Baron?= <bjorn3_gh@protonmail.com>,
	Benno Lossin <lossin@kernel.org>,
	Andreas Hindborg <a.hindborg@kernel.org>,
	Trevor Gross <tmgross@umich.edu>,
	Danilo Krummrich <dakr@kernel.org>,
	Daniel Almeida <daniel.almeida@collabora.com>,
	Tamir Duberstein <tamird@kernel.org>,
	Alexandre Courbot <acourbot@nvidia.com>,
	=?UTF-8?q?Onur=20=C3=96zkan?= <work@onurozkan.dev>,
	rust-for-linux@vger.kernel.org
Subject: Re: [PATCH 6.18.y] rust: bitmap: fix intra-doc link
Date: Fri,  6 Nov 2026 11:35:49 -0500
Message-ID: <2026-11-06-1-daily-reply-0014-rust-bitmap-intra-doc@kernel.org>
X-Mailer: git-send-email 2.53.0
In-Reply-To: <20261106063745.87864-1-ojeda@kernel.org>
References: <20261106063745.87864-1-ojeda@kernel.org>
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Post: <mailto:stable@vger.kernel.org>
List-Help: <mailto:stable+help@vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
List-Owner: <mailto:stable+owner@vger.kernel.org>
Precedence: list
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

> `BitmapVec::MAX_LEN` does not exist in 6.18.y, so `rustdoc` warns:

Queued for 6.18, thanks.

-- 
Thanks,
Sasha
