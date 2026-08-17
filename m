Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5B690442364;
	Mon, 17 Aug 2026 18:12:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1786990340; cv=none; b=SThf3VVDvXSI2hznIxfY16/pZ2X7w0IrtdXK5msgUjJUELE4QXD3bMEEhiv5t8ac5Np3U1hrWvFFpE/C1ATIPjzuof8LlaVezhe1xRmvyB+8Lhp9+PY9tHqwhmCsoefO828KbTY09EV5zn9KF5aj/AsLPQuXGaHkAWyKbFmOt6M=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1786990340; c=relaxed/simple;
	bh=jw3E4GvzjLsrAQxKeX1+l5jtVDZfGjR3B+gVNNIXclk=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=aj7PNyMAJlGgYKOn/1d13epmrdRW5D4fc9wZvXXnYT1oWqkQMqaNNwhSgXblXNzmyZJcVfPK2qoeR9BzvWb7jk2ARNmJatpMKE07lP6GB6Z/Z6cHeOdGJ+8Zldib112rrXszud5AOQoLTsEfFnXPXiZcyJECQ3q9t5qcEIFJr/k=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=a+sT4F+G; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="a+sT4F+G"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 641301F000E9;
	Mon, 17 Aug 2026 18:12:15 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1786990339;
	bh=J7lbDjvO1YdRXrmvFso2O876QXWoj5AWCIxP88NH1X8=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To;
	b=a+sT4F+GJYaSNjb50jcFC4YqIT+JQNphWc1wtIWhPDDL8+aScAYNcUWLXRaFl6P49
	 NtdTTYMHKNNxcvj/AalOEcas0E6ILPKaZygqZYxOFIp2T0qOt8etzOJ2XHonWeXj3L
	 PyAtVXUudtQ7kiSL8+Yk/NYh4jjsg9dVAQoKE+rHTLzMiI2Z0SqOXOh0H0vV4xGa/d
	 QQZdLMvixixZTvzWpenYeIe0amY5cegNEk0WqaFPyvFJIfUl9datlTPtK2zqbVb7IB
	 5btLO2c9yHBE03Id1lNmKsILdfKnrTHmj/2b29ltVn5/eRYQAeZvpndTxMJg9vpqvh
	 mM5UvcDZkb4Mw==
Date: Mon, 17 Aug 2026 11:12:12 -0700
From: Nathan Chancellor <nathan@kernel.org>
To: Miguel Ojeda <ojeda@kernel.org>
Cc: Nicolas Schier <nsc@kernel.org>, Boqun Feng <boqun@kernel.org>,
	Gary Guo <gary@garyguo.net>, Matthew Maurer <mmaurer@google.com>,
	Alice Ryhl <aliceryhl@google.com>,
	Josh Poimboeuf <jpoimboe@kernel.org>,
	Peter Zijlstra <peterz@infradead.org>, linux-kbuild@vger.kernel.org,
	=?iso-8859-1?Q?Bj=F6rn?= Roy Baron <bjorn3_gh@protonmail.com>,
	Benno Lossin <lossin@kernel.org>,
	Andreas Hindborg <a.hindborg@kernel.org>,
	Trevor Gross <tmgross@umich.edu>,
	Danilo Krummrich <dakr@kernel.org>,
	Daniel Almeida <daniel.almeida@collabora.com>,
	Tamir Duberstein <tamird@kernel.org>,
	Alexandre Courbot <acourbot@nvidia.com>,
	Onur =?iso-8859-1?Q?=D6zkan?= <work@onurozkan.dev>,
	rust-for-linux@vger.kernel.org, stable@vger.kernel.org
Subject: Re: [PATCH 2/2] kbuild: rust: keep Rust objects out of Clang LTO
 with inline helpers
Message-ID: <20260817181212.GA1249844@ax162>
References: <20260816133233.197500-1-ojeda@kernel.org>
 <20260816133233.197500-2-ojeda@kernel.org>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20260816133233.197500-2-ojeda@kernel.org>

On Sun, Aug 16, 2026 at 03:32:33PM +0200, Miguel Ojeda wrote:
> Another possible alternative that Gary suggested is to turn the flags on
> globally for C, whether only when inline helpers are enabled or in all
> cases, but it may be intended that in C we expect not to generate the
> `unreachable`s.

I am not sure we can use '-mllvm -trap-unreachable' for C code, as that
would mess with manually inserted calls to __builtin_unreachable(). It
has come up before:

  https://lore.kernel.org/CAHk-=wgPCbZv0JgqoNWMOO+p=N772YW16xYk_pmb1GU7aeuPFA@mail.gmail.com/

It is possible the '-no-trap-after-noreturn' avoids that particular
issue but I still think the "compiler inserted" vs. "user inserted"
distinction that Linus comments on is likely still potentially relevant.

-- 
Cheers,
Nathan
