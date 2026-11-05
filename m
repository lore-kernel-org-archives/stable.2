Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=100.103.45.18
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1793860883;
	b=OBhFbSywxgfOIjQWMKt+Alac4ExSCX9n05L9hS2g+nWTpLf6bXRxQ0TFp++ICB3MBOCZ
	 vCweBeZxBNjAePnnyfaC/kKe9m/P8A+IzUPC7zCJms7ITeUwf7YgB92/tznsQViQlXKdN
	 GvgPw0yW4x3xfBs/yjs7k96PdkNElLAC5voQKG/5oGRkPZQC+8yTtBpl41c56c5NG77Lw
	 r4TmToVEdUa07PHYjqBxqYXLWY8tcA5PT7DgViIuD6LRrQuO1lfII4QrUtaCF8uf4HFQE
	 YkWLn3ar3HWIhkEQSj+tOTP0EwW604wCSKL+0rxA6JniX/fKCNSWWJxjrNYc7NHGrKQ==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1793860883;
	h=Received:DKIM-Signature:Date:From:To:Cc:Subject:Message-ID:
	 Mail-Followup-To:References:MIME-Version:Content-Type:
	 Content-Disposition:In-Reply-To;
	bh=2nfix4GUrP2vkL1phSGVFDwRAmYhxJ4QRB6j0d73dtE=;
	b=fNZ0LX/my8vMRDMDhbi03cw2Xvl8ZSUFoWIOeZHsCxzL0mVplx8AdRucbvNHj54Ep4sR
	 JpKksLTELX4aBCh03Cqo8HezHLlLHkQhpzx4jJym6PNhNdyiKbWioF39NDzG0ga4GxR2j
	 N8tUCPEYpA3RAJHdm5JqZyf4ajb15+0CuOFapD9fa+c0FvccDpWNIfp/4QPJ54TqPFAub
	 5irWsLQuyUIzkSh/hGiOBMvP+Ejywlq5ClCiFXU0TrxjhctX0KIoEbZtsA6BrX3b85AB5
	 +ufn6CDuDv940rtoWzWtdfbeQrwH/+wnThedFp1XDmda7h0f4xZwdP6fcWQo35zKcJA==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dkim=pass header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=EFjZbcJk;
	arc=none smtp.remote-ip=100.103.45.18
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id AE9F2606A326;
	Thu,  5 Nov 2026 06:41:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=EFjZbcJk
Received: by smtp.kernel.org (Postfix) with ESMTPSA id CF6211F000C1;
	Thu,  5 Nov 2026 06:41:21 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1793860882;
	bh=2nfix4GUrP2vkL1phSGVFDwRAmYhxJ4QRB6j0d73dtE=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To;
	b=EFjZbcJk//o65965ieIPR5psh1kCnFNG8KPt9rTkgHoucLPz5HQ0c/v6FLrbwwKyL
	 qnwfU17aQ0niAKB8dRVumFJlPqluxRxG3Yt9/MfSOXfkw+t/1IH6KUEquGPq3VsYk1
	 IkRHjdFxo4a21C+edKQVYI+x0N/POQLZmXahJv3QaxxhZL2C71LNa3HC/mJQpupgBk
	 GeoCZjzGpseCqUTL8C58Pbywim4TZR1MrxfCFWkalMImkegcaZL/2VEm2AeE9TgfWa
	 U4P/8I7uDyTE0VLgCyQ9SUA3JO8MnTlTcbIhug17QaiDrDw8xGdB/6R5c12/2ll9iY
	 iPgsoLF+JuMqg==
Date: Thu, 5 Nov 2026 07:36:55 +0100
From: Nicolas Schier <nsc@kernel.org>
To: Nathan Chancellor <nathan@kernel.org>
Cc: linux-kbuild@vger.kernel.org, linux-kernel@vger.kernel.org,
	stable@vger.kernel.org
Subject: Re: [PATCH v3] kbuild: Makefile.lib: fix offsets generation with
 debug info
Message-ID: <auwkB55JcRO24RUd@derry.ads.avm.de>
Mail-Followup-To: Nicolas Schier <nsc@kernel.org>,
	Nathan Chancellor <nathan@kernel.org>, linux-kbuild@vger.kernel.org,
	linux-kernel@vger.kernel.org, stable@vger.kernel.org
References: <20260928105330.25427-1-d.kandybka@gmail.com>
 <20261015210149.78470-1-d.kandybka@gmail.com>
 <20261026074733.11777-1-d.kandybka@gmail.com>
 <179385408066.826739.6575864914757012196.b4-review@b4>
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Post: <mailto:stable@vger.kernel.org>
List-Help: <mailto:stable+help@vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
List-Owner: <mailto:stable+owner@vger.kernel.org>
Precedence: list
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <179385408066.826739.6575864914757012196.b4-review@b4>

On Wed, Nov 04, 2026 at 09:48:00PM -0700, Nathan Chancellor wrote:
> > When debug information is enabled (e.g. -ggdb3), the assembler
> > output file (e.g. kernel/sched/rq-offsets.s) contains additional
> > directives such as .ascii with offset info and debug metadata.
> > 
> > For example:
> > 
> >    .ascii "->RQ_nr_pinned $3048 offsetof(struct rq, nr_pinned)"  #
> >    ...
> >    .ascii "->func); __data = (it_func_ptr)->data; ((void(*)(void *, pro"
> > 
> > The current sed-offsets macro uses [^ ]* to match constant names,
> > which is too permissive and can match unexpected characters when
> > debug directives are present. Additionally, the fallback command
> > 's:->::; p;' strips '->' from any unmatched line and prints it,
> > which causes debug metadata to leak into the generated header
> > file (include/generated/rq-offsets.h), breaking the build.
> > 
> > Replace [^ ]* with [[:alnum:]_]* to match only valid C identifiers,
> > and remove the fallback 's:->::' command so that only successfully
> > transformed lines are emitted into the generated header.
> > 
> > v2:
> > - Add BLANK() macro for better readability of generated headers
> > (suggested by Nathan Chancellor).
> > v3:
> > - Check for ->BLANK() at the beginning of a line
> > (suggested by Nathan Chancellor).
> 
> For the future, please include this changelog underneath the '---' below
> your signoff so that it is not included when we apply the patch.
> Nicolas, would you mind snipping that during application?

Sure, thanks for the reminder!

-- 
Nicolas
