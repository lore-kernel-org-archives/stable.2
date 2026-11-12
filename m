Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=100.103.45.18
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1794450738;
	b=GkZ/u+QiNpWtMYdH0UNh2/9dHqVpMRjgn3nV9AkrDDvLtn2c9Wj9fR+WEXPFyd3sRW+8
	 DeM3ckJBOoI2wztbmc3BhZcJo6+aNElZ0gs0e3FPp3Apt/A0Pan3euRLaT8mYBJOdmocn
	 CYSz10bmNPp8WKLNwLVSLGgHqw82VR8U/OpalbhAE2Sedrchdeu/RwzZ9MAWqo94l60PL
	 qkjNHCnMsZFIsS1uO0dkcAxvbS9t6QfoeL+5Sr98F3byOiKuo+Idm6rok2TTaMNZh2lJ7
	 Nx8iRsG7g0Z4kvbaS3Yn/k96hljx/HGjy3VKiUbtE0wSCaw9ZXG78s4Ssm4AA8jdtyQ==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1794450738;
	h=Received:DKIM-Signature:Date:From:To:Cc:Subject:Message-ID:
	 References:MIME-Version:Content-Type:Content-Disposition:In-Reply-To;
	bh=xA/HKNd/xvNY86VeER648zAE5tWSIqYGfPm1bcMLxyA=;
	b=DasHJyyM/4TlOXdCg//kbfFtNkpaAc3tN44xHpU+W2iRiEzjbdlSF9UvOKhNqHvdaIjx
	 +S6cFh1f6oMZCK3mlaTND+OT3o1q7u231IsKbEEU6e2FNCcRb7wAUJAIZUqsjwFkH1y3E
	 dkN9aph/I/Pgt0Mi40VbmWq2zAw1+F9erteULTSfUfy9ntyuphn+ydo+ecil9EMpCzNyr
	 tIIxW4gWQ6gucNU0D24vqG48W4d52O+XN7+smXAiUIROBZYrJ3atKQTgwB0FU0rqWwkfI
	 RCAPTiCtJxEu8MoukKxqkxTU+atXIkOvg2OlEOA7Htsw0a30/O20E53MWA/hf7jAdoA==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dkim=pass header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=oqC1WkDU;
	arc=none smtp.remote-ip=100.103.45.18
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CB560606A327;
	Thu, 12 Nov 2026 02:32:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=oqC1WkDU
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 33BEE1F00A07;
	Thu, 12 Nov 2026 02:32:18 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1794450738;
	bh=xA/HKNd/xvNY86VeER648zAE5tWSIqYGfPm1bcMLxyA=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To;
	b=oqC1WkDU3HfVJR9rBpnMeI+iTz8ZwhtaFjUh9OakfY9+5bjEWliGcsNMndrmszQyW
	 Zzy9hRIGiRogX0b86Ji3fj70cdzh/B+CCBYbYfbmPti7CwQmmSSUQikck5OBLoSnnJ
	 iAdlBzzboZldpshbSNjm23UoLUOsJzHvLQIigLGbXXAlWaKmdDs5hZt8r2bWz1XrOY
	 eZ5KRZ09t4DCVrNExlhRsoFtFEzd2zqdLCBiMcqD6c5VyM8omUOQ49AI69QCcFmZ7B
	 Fmj6k0DlEU54Wyuut9Xyz3PI4F1/MdJBr/Ula8FpDffEZKU0LG8+VhFU/j9jaUetch
	 j1CkgcDymmFTw==
Date: Wed, 11 Nov 2026 21:32:17 -0500
From: Sasha Levin <sashal@kernel.org>
To: Andrew Morton <akpm@linux-foundation.org>
Cc: Theodore Ts'o <tytso@mit.edu>, workflows@vger.kernel.org,
	ksummit@lists.linux.dev, Bradley Morgan <brads@mainlining.org>,
	Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
	linux-doc@vger.kernel.org, linux-kernel@vger.kernel.org,
	Jonathan Corbet <corbet@lwn.net>,
	Shuah Khan <skhan@linuxfoundation.org>,
	Randy Dunlap <rdunlap@infradead.org>,
	Mark Brown <broonie@kernel.org>,
	Laurent Pinchart <laurent.pinchart@ideasonboard.com>,
	Leon Romanovsky <leon@kernel.org>,
	Konstantin Ryabitsev <konstantin@linuxfoundation.org>,
	Thorsten Leemhuis <linux@leemhuis.info>,
	"Michael S. Tsirkin" <mst@redhat.com>, Kees Cook <kees@kernel.org>,
	Geert Uytterhoeven <geert@linux-m68k.org>,
	Dan Carpenter <error27@gmail.com>, Miguel Ojeda <ojeda@kernel.org>,
	Alexei Starovoitov <alexei.starovoitov@gmail.com>,
	Julia Lawall <julia.lawall@inria.fr>, SJ Park <sj@kernel.org>,
	stable@vger.kernel.org
Subject: Re: [PATCH v5 3/6] agents: add a skill to determine stable tags
Message-ID: <avUlMcKIeJgmCg5J@laps>
References: <20261111225940.1573565-1-tytso@mit.edu>
 <20261111225940.1573565-4-tytso@mit.edu>
 <20261111171055.527b4bf3da705367bc78a64c@linux-foundation.org>
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Post: <mailto:stable@vger.kernel.org>
List-Help: <mailto:stable+help@vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
List-Owner: <mailto:stable+owner@vger.kernel.org>
Precedence: list
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Disposition: inline
In-Reply-To: <20261111171055.527b4bf3da705367bc78a64c@linux-foundation.org>

On Wed, Nov 11, 2026 at 05:10:55PM -0800, Andrew Morton wrote:
>Marco had some thoughts on this just today:
>
>https://lore.kernel.org/CANpmjNMvM_TCs7Fao9+gM-NNpQyBKYumSuWOt_03ZX+tLwbjWw@mail.gmail.com

This makes a lot of sense.

>And Documentation/process/stable-kernel-rules.rst does ask for real
>things, not theoretical stuff.

We've actually dropped[1] the "theoretical" part.

The problem we were seeing is that bots were sending real fixes, with a solid
changelog, but not adding the stable@ tag.

Apparently our wording is pretty strong: unless you can prove that the issue is
real, it remains theoretical. You'd have to either show a real case where you
hit the bug, or to have reproduced the issue and can provide a way for us to
reproduce it.

Most bots can't actually do that for technical reasons, even if the bug is 100%
affecting our users, so they don't add the stable@ tag.

>Also, I would keenly like to see changelogs clearly explain *why* a
>backport is proposed.  As I have said 1000 times, "when fixing a bug
>please clearly describe the userspace-visible runtime effects of that
>bug".  Can we pleeeeeeeeeeze get this requirement clearly enshrined in
>this patcset somewhere where the LLMs will read it and comply?  It's
>really simple for the LLMs to cook up a paragraph for this, if so
>directed.

This is a great point, and would make our lives much easier too.

It sounds a lot like something that humans would benefit from hearing as well?
If so, I can send a patch tomorrow to add it to
Documentation/process/submitting-patches.rst and refer to it explicitly in the
agents file?


[1] https://lore.kernel.org/all/20261020142537.3533510-1-sashal@kernel.org/

-- 
Thanks,
Sasha
