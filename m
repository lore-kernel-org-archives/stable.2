Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=100.103.45.18
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1793631365;
	b=wuitgjECHN0nddOT1Ry53c6k73qP3KPI4xLPHedEWoWLJyQ20boKCXX0EzOyFyaUPe8x
	 q6qEHVU0njlaUpWmarb3NlFGUQfIxsSy6beBU8O9t6YbfO3u4eHgyQ2LyJ5AmcHxC7LbW
	 T141BlTydbcNN0uLiRjGHe5NtUgzdeWaAvcEMf05mejNleY7/Sjv4x33sLSr14851cpN+
	 B/6GuLGqbVPxhyvZJ2n+imm9YmeZOGWO6uVm0wtWjq0JmDDXSOEFzF6fU6r154i6EdeKW
	 q+IF57o+BokS4F9hAzpq3JdXncao+26tgeyPC+KSI3Um0UDxMl6qbhVmroHy46yYptw==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1793631365;
	h=Received:DKIM-Signature:From:To:Cc:Subject:In-Reply-To:References:
	 Date:Message-ID:MIME-Version:Content-Type;
	bh=vGzc07WtBuQo2pTRkYvYJz3J99bzTgQ8zwJKoBHi27E=;
	b=oJNl8ykI6PUJDv0A6R1HFGfu2QsislwmwSawhhKSvoGT2EC2bvtCAbAxYfUroR3+7/KH
	 dkayEMCFASSRbZ62oj+dQQl4ZfLcvvTRsFqEo2xghzopPs9Y8OsCfn86VYd7UmtlNaTBb
	 +jwcxI/RpJMu5rhfdWGQFM2gU8a2VJ9y3ClDuRi3iuVd6tUCcWY1AakzDHzj+wK23O9DW
	 TDOeB1PaqXPpeV73j8+K0yng+rc5s9yQTDg3kSKBCJEv73+/N+ZNmFy7snRR3WEH7DFV5
	 F0BQbMB3BWQKrY7XZQwjVP2Wm75d2v6C9LUV3fG/s6t94RIxtvl91V9f1XQccpWTewQ==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dkim=pass header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=DUu0fLDw;
	arc=none smtp.remote-ip=100.103.45.18
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9ABA0606F207;
	Mon,  2 Nov 2026 14:56:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=DUu0fLDw
Received: by smtp.kernel.org (Postfix) with ESMTPSA id B14E91F00A17;
	Mon,  2 Nov 2026 14:56:00 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1793631365;
	bh=vGzc07WtBuQo2pTRkYvYJz3J99bzTgQ8zwJKoBHi27E=;
	h=From:To:Cc:Subject:In-Reply-To:References:Date;
	b=DUu0fLDwnDY74I4X0y2HNF733wSuZPqqgVa5STCA0rPQJ8G9sdbFfXUaegj8r31kC
	 q5NrBXUW00U5KvK/ilQfGedwpKG/kSFcGPdN6DaD+Kjoy7wWHIgaqkiQ1+EeByluHY
	 6cW6+sUYJcuFhWVlSEhS4rV2BYIZ8GOR7X45bEpsUvsNFwL+1kpwcrbhR8vdvCFQ8b
	 aVERuvfrdMfadKkYpKLRLPdDzih+Fc0EE696/fPLvnwxxsI9y9zaJgNg+SxIhi5s5s
	 aEcWyN6xhc7mBWtP5qo5q5FkQkD3Iss6dDSikVytAeb5dYL5LExkkn2eOqXkWRS/pL
	 fiJMHdTxlP4mQ==
From: Andreas Hindborg <a.hindborg@kernel.org>
To: chenhan <chenhan0017.work@gmail.com>, rust-for-linux@vger.kernel.org
Cc: boqun@kernel.org, fujita.tomonori@gmail.com, frederic@kernel.org,
 lyude@redhat.com, tglx@kernel.org, anna-maria@linutronix.de,
 jstultz@google.com, sboyd@kernel.org, ojeda@kernel.org, gary@garyguo.net,
 bjorn3_gh@protonmail.com, lossin@kernel.org, aliceryhl@google.com,
 tmgross@umich.edu, dakr@kernel.org, daniel.almeida@collabora.com,
 tamird@kernel.org, acourbot@nvidia.com, work@onurozkan.dev,
 miguel.ojeda.sandonis@gmail.com, tomo@flapping.org,
 georgeandrout13@gmail.com, linux-kernel@vger.kernel.org,
 stable@vger.kernel.org
Subject: Re: [PATCH v5 1/3] rust: time: rename the rem_nanos() divisor
In-Reply-To: <20261031103206.24051-2-chenhan0017.work@gmail.com>
References: <20261031103206.24051-1-chenhan0017.work@gmail.com>
 <9vY-MKlqFfah0zyhFui44WvsNb-7yVuqoGQlipZs5Sz_UjHMj3m6BgtjgH2kmEaxOq-qZ9BDq_yUpiJujN2ODQ==@protonmail.internalid>
 <20261031103206.24051-2-chenhan0017.work@gmail.com>
Date: Mon, 02 Nov 2026 15:36:22 +0100
Message-ID: <87pkwnmhax.fsf@t14s.mail-host-address-is-not-set>
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

"chenhan" <chenhan0017.work@gmail.com> writes:

> The argument to rem_nanos() is the divisor, while self holds the
> dividend. Rename the argument and correct the documentation. Drop the
> architecture-specific implementation explanation from the public API
> documentation; the argument type already states the divisor's width.
>
> This does not change the function's type or behavior. It is a preparation
> for documenting and checking the invalid divisors in the next patch.
>
> Cc: stable@vger.kernel.org # prerequisite for the Delta division/remainder fix
> Reviewed-by: FUJITA Tomonori <fujita.tomonori@gmail.com>
> Assisted-by: LLM
> Signed-off-by: chenhan <chenhan0017.work@gmail.com>

Reviewed-by: Andreas Hindborg <a.hindborg@kernel.org>

Best regards,
Andreas Hindborg


