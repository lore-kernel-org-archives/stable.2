Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 76A6C4314B8;
	Thu, 16 Jul 2026 18:45:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1784227559; cv=none; b=B6ngwq2SD33gbi8lWtu6CKBNx5/zLjAUhvrfqb7lmXN3qhl8DScdwTiHm47fidBzGnYET4GlbjEpNEl5fJki2Icw0uDIOGPXfgdUuzmTu2jU89zhLR/MRBNsIv7YQLHB0D2cCc0tsoBYOfz9BZobIlsgTlCrRZCI+GDQWqohoLo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1784227559; c=relaxed/simple;
	bh=9jcnThpKqbhDe2vR4tcH2u1qIOXqXogFJxOSgKo7grk=;
	h=Mime-Version:Content-Type:Date:Message-Id:Cc:To:From:Subject:
	 References:In-Reply-To; b=L26RUSwmWu3Znw00tBEOJmVcb7abr+k+icZn3O9BhOJzICkMBtRLJnlJfOLgWfkSCPxrgrYtKEz5CaoSTDUn2OPed71oQGe8l+jpImgERpOwyQIWa0pjmIYvF/JYqivNVzh1P2hU+2N4HQx+2PJw5b20UysQnOdKGoZnYPXuk6Y=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=iqNXCG6W; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="iqNXCG6W"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 354741F000E9;
	Thu, 16 Jul 2026 18:45:54 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1784227558;
	bh=DuoNaGIN8f48jgsgNG0uOaD3zoy5Zi5FE8xyU8niMU0=;
	h=Date:Cc:To:From:Subject:References:In-Reply-To;
	b=iqNXCG6W4aVbGcQoI02uJfp1rQKwNlXn3FMqszesspi7ygp41Hmt8WDec6FRC1u/G
	 vdUZuAbiknFAo13+y/0T2d8lyPKyRvoYCXjDSZPxLlYYlBjBDVLGjQwPObJT5QOf3M
	 M2vujRg5bSnAWCb1mecF2EN2c9Fn+l60yEpeJFukWuYOaOknAyLv5EoBZq29FQdBN+
	 YyZop6852wVPs1uWHLqUH5fSN5ggebg9dicFNKTIkytw40mmeENWGLzKc5o24rXs5b
	 0NnnD/Nt2bAYMi603BgXJiq5xca8cLpjm0ixHcel+pFDFP9oHe1av3g6qocOv6Bohl
	 m8Waf9jqlXGVg==
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
Content-Transfer-Encoding: quoted-printable
Content-Type: text/plain; charset=UTF-8
Date: Thu, 16 Jul 2026 20:45:52 +0200
Message-Id: <DK07VQ14YCY4.13KSVBNXSSA5J@kernel.org>
Cc: "Alice Ryhl" <aliceryhl@google.com>, "Greg Kroah-Hartman"
 <gregkh@linuxfoundation.org>, "Rafael J. Wysocki" <rafael@kernel.org>,
 "Miguel Ojeda" <ojeda@kernel.org>, "Boqun Feng" <boqun@kernel.org>, "Gary
 Guo" <gary@garyguo.net>, =?utf-8?q?Bj=C3=B6rn_Roy_Baron?=
 <bjorn3_gh@protonmail.com>, "Benno Lossin" <lossin@kernel.org>, "Andreas
 Hindborg" <a.hindborg@kernel.org>, "Trevor Gross" <tmgross@umich.edu>,
 "Daniel Almeida" <daniel.almeida@collabora.com>, "Tamir Duberstein"
 <tamird@kernel.org>, "Alexandre Courbot" <acourbot@nvidia.com>,
 =?utf-8?q?Onur_=C3=96zkan?= <work@onurozkan.dev>,
 <driver-core@lists.linux.dev>, <rust-for-linux@vger.kernel.org>,
 <linux-kernel@vger.kernel.org>, <stable@vger.kernel.org>
To: "Miguel Ojeda" <miguel.ojeda.sandonis@gmail.com>
From: "Danilo Krummrich" <dakr@kernel.org>
Subject: Re: [PATCH] rust: device: avoid trailing ; in printing macros
References: <20260716-device-trail-semicolon-v1-1-f48e9dcfae15@google.com>
 <CANiq72n3BYGfB9VvLk4-bBQzGy9YhDxFvCrjkjJqBbcJa5YRYw@mail.gmail.com>
 <DK01JT88NEI6.1TTJR16A61780@kernel.org>
 <CANiq72=OKHJo0Shzb_h1OuzmTVLqn6qPJsA_AhJAWOfQATbYDQ@mail.gmail.com>
In-Reply-To: <CANiq72=OKHJo0Shzb_h1OuzmTVLqn6qPJsA_AhJAWOfQATbYDQ@mail.gmail.com>

On Thu Jul 16, 2026 at 4:28 PM CEST, Miguel Ojeda wrote:
> Thanks, no worries, I will take it -- this kind of fix makes more
> sense in `rust-fixes` since they are treewide, i.e. it could have
> triggered in more places at the same time since they changer the
> compiler, and I have other few in the branch accumulated for Rust
> 1.99.0.
>
> (An Acked-by is always nice of course!)

I don't understand the rationale about being treewide. This patch only touc=
hes
rust/kernel/device.rs.

(Even if there would have been other subsystems running into the same condi=
tion,
it would have produced independent patches, which could be - but don't have=
 to
be - sent in a treewide series.)

I'm obviously fine with the patch and I also don't mind if you take it if y=
ou
prefer to, thus:

	Acked-by: Danilo Krummrich <dakr@kernel.org>

But, if I may be honest, the way this is presented feels as if the driver-c=
ore
maintainers never had a say in the logistics in the first place, which does=
n't
feel right.

Also what makes this patch urgent in a way that waiting for an ACK to be gi=
ven
before applying wasn't an option?
