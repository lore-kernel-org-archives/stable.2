Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=100.103.45.18
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1795075435;
	b=DvvPbK2MtRJr2T49sjvmMkGnOFiSvSR8US53c9RtjjRO7q5OkcqoM+bKwwPbLTGWaHdK
	 bM7pXAhslh1DN0VExVkFMjjuyIuHwWsG6tv7WZ7cULkF4UyFaLu92ZkWzHJaY8peLzdD8
	 s82bdQvaeNKJ/gcNEmt8InulEVQjaqxKDrqXOTn+aLty4u5S2asP8c2vv8kmURApZ8Ddw
	 LY4LuvM8iPKtxGkIstWubGyvFkD8woY7QUlO+RE4y8RdJeUFARU2T9sG8QYdLBWOo9n7T
	 AjgPDlIKay6fZZ97rWodnAY8qVL1SZucVHnrQ3gWnOnrVwVZNiKrRWOWN99nV3E4pow==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1795075435;
	h=Received:DKIM-Signature:From:To:Cc:Subject:In-Reply-To:References:
	 Date:Message-ID:MIME-Version:Content-Type;
	bh=U5cak2zg2HyAXcWgEdbZBhzO0YcioJvNSOBG3QGgFO4=;
	b=DiGKIZV3bHLxoY8WRhgeTlHUtdXfU07JRyWaRQgFW0DJFgxbIEAGBUyXx8isduC4G65C
	 +yaqOm3v0/T6aeXjmJpMWtQeo5cxN9HlwXXC81gRAGFT1Q3VPCy/VQUN/2gWgHpzg5oNp
	 xsoUtXdWObbUOjZjm6Y8mGg4ixcrDJw5p41yjdkSa83wiAmX030P4Y6SHGVjVc+3S8FNI
	 VEHmZh6hPkZxclSw7quik2UJhV1JkCIpPK+rTAAVvysEhhS0oYJQkwWLC+c/HVJx8oESw
	 06jrUnNGMXLkFW1V7kuBQakh0jhbnrrt9x/Q6DgvOmbc827ita51ERRS6R0T8M5+ypg==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dkim=pass header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=hHArRXsC;
	arc=none smtp.remote-ip=100.103.45.18
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 833BB606A332;
	Thu, 19 Nov 2026 08:03:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=hHArRXsC
Received: by smtp.kernel.org (Postfix) with ESMTPSA id E1A691F000C4;
	Thu, 19 Nov 2026 08:03:51 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1795075435;
	bh=U5cak2zg2HyAXcWgEdbZBhzO0YcioJvNSOBG3QGgFO4=;
	h=From:To:Cc:Subject:In-Reply-To:References:Date;
	b=hHArRXsC7w1/F99Gnd3YhYJcKlLrnQU3RL5Z2ydJWn+w0trwFTXa8fF8JuCKrZqxB
	 M3ygHR8YZY/dV+V+oU99S9sT0K+HqJQXxul4fO7VAnS/iQt2r4DAfsg61zANVXByVb
	 l0fSUVcRUOK5qx4au0qZJITQcTdz1ToBe1GrpQFsc9AgXVoRg5Df5+VLFg46nySdFx
	 QLSAzsqF7WiMZCvT1O4rtvm4WJdi8nlVBaVH5+0velnafUwETK1DOXep5rl2i9femx
	 BNX7zYItbfgeY3yFRCeF4Zp60SHmT2bGZ8uGLULbmg9y/b2OqGnRdo7u0rRkptoS7V
	 YE+epm5qK+KNg==
From: Andreas Hindborg <a.hindborg@kernel.org>
To: peder.bergan@gmail.com, Miguel Ojeda <ojeda@kernel.org>
Cc: Boqun Feng <boqun@kernel.org>, Gary Guo <gary@garyguo.net>,
 =?utf-8?Q?Bj=C3=B6rn?= Roy
 Baron <bjorn3_gh@protonmail.com>, Benno Lossin <lossin@kernel.org>, Alice
 Ryhl <aliceryhl@google.com>, Trevor Gross <tmgross@umich.edu>, Danilo
 Krummrich <dakr@kernel.org>, Daniel Almeida <daniel.almeida@collabora.com>,
 Tamir Duberstein <tamird@kernel.org>, Alexandre Courbot
 <acourbot@nvidia.com>, Onur =?utf-8?Q?=C3=96zkan?= <work@onurozkan.dev>,
 rust-for-linux@vger.kernel.org, linux-kernel@vger.kernel.org,
 stable@vger.kernel.org, Georgios
 Androutsopoulos <georgeandrout13@gmail.com>
Subject: Re: [PATCH v2 1/2] rust: str: tie Formatter to its backing buffer
In-Reply-To: <20261117-formatter-lifetime-v2-1-e216d86ffb57@gmail.com>
References: <20261117-formatter-lifetime-v2-0-e216d86ffb57@gmail.com>
 <yz6hXhgdA-zYpjUYpSRORQDZ2pggs0Uu83_S-DdCm5iJ7lPqGJnf2eNwXNve7Jl8kspdCv6Wc2PHn7IG9ifmeQ==@protonmail.internalid>
 <20261117-formatter-lifetime-v2-1-e216d86ffb57@gmail.com>
Date: Thu, 19 Nov 2026 09:03:10 +0100
Message-ID: <87y0aptfi9.fsf@t14s.mail-host-address-is-not-set>
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Post: <mailto:stable@vger.kernel.org>
List-Help: <mailto:stable+help@vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
List-Owner: <mailto:stable+owner@vger.kernel.org>
Precedence: list
MIME-Version: 1.0
Content-Type: text/plain

"Peder Bergan via B4 Relay" <devnull+peder.bergan.gmail.com@kernel.org>
writes:

> From: Peder Bergan <peder.bergan@gmail.com>
>
> Formatter::new() returns a Formatter whose lifetime is independent of the
> borrow of its backing buffer. Safe code can therefore drop the buffer and
> then write through the formatter, causing a use-after-free.
>
> Tie the buffer borrow to the formatter's lifetime so that the borrow
> checker rejects such callers and prevents overlapping mutable access.
>
> Fixes: 87482d6d9104 ("rust: str: allow `str::Formatter` to format into `&mut [u8]`.")
> Cc: stable@vger.kernel.org
> Reported-by: Georgios Androutsopoulos <georgeandrout13@gmail.com>
> Closes: https://github.com/Rust-for-Linux/linux/issues/1261
> Signed-off-by: Peder Bergan <peder.bergan@gmail.com>

Reviewed-by: Andreas Hindborg <a.hindborg@kernel.org>

Best regards,
Andreas Hindborg



