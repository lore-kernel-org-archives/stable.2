Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=100.103.45.18
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1794445960;
	b=hKH3OUSk4m3oOcKxt87zV59nnUIPqIVvTu1chzoQycEhtPhVlnsKvxhpC7n5Gxn+wMJM
	 MmDBUjKoxqw80OCXCUes7FwNZ+GTgUQIyi20oJZtvE5D51H3nXZp6uOdAW9brzT2bxslz
	 uo22WHThitM6OD1JVIKqsArFmfBmC1bE5nF2YogOyz9nX97fhuN/gP8HMZziJAm76F5xx
	 SB0GaKvyyczI2xnf7TtIW60wQl4mX7Xy7UTKHZLC1WbsRDWvwvroEyO6+qCXm/DlvDEWz
	 y76QHywuVGDQr34l41kXyzJ9neiy1DPfpUVGL5pViQZ65Ri8C7zk/s1PhOlBH2+Oeiw==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1794445960;
	h=Received:DKIM-Signature:Date:From:To:Cc:Subject:Message-Id:
	 In-Reply-To:References:X-Mailer:Mime-Version:Content-Type:
	 Content-Transfer-Encoding;
	bh=MiFbN8j2jyp+jkBuNs9uCIal0qPxMVDHV33aouRjMeU=;
	b=O/Fq0i0Q0SncrgfNro19OzaUpMjZDC/Wp+z3M5Xdjpv/B808sZCKn6lBKfu95YD+kkeP
	 9fzLQ4P8ps9Jv+ZDubB/KWxrKGYY/HJ7nzjeN7DYwrOuYpbKhfMFxmuMQ/DVZHKK7Ry0g
	 AFzwHn3Xw4r6PHFHmA3rDAV/cA874SJx3JMUxCTf9bg16DkQSBVKG3WPLiZarWqt6yOwP
	 KcqkB+w2Ipez/8I9JB9ibaxeXD0ilUxwZ33WPzN757z0OiSroTMdDu2r3cKbUUORBD81n
	 1YZJH5wT7MvEaYH5Oy/EaPDH42sY2J0DIJjn4ipoFaiDmExaj64eluBmwtrQQypQeSA==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dkim=pass header.d=linux-foundation.org header.i=@linux-foundation.org header.a=rsa-sha256 header.s=korg header.b=bZ9rboZd;
	arc=none smtp.remote-ip=100.103.45.18
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5274A606A324;
	Thu, 12 Nov 2026 01:12:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux-foundation.org header.i=@linux-foundation.org header.a=rsa-sha256 header.s=korg header.b=bZ9rboZd
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 009DB1F00A08;
	Thu, 12 Nov 2026 01:12:38 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=linux-foundation.org; s=korg; t=1794445960;
	bh=MiFbN8j2jyp+jkBuNs9uCIal0qPxMVDHV33aouRjMeU=;
	h=Date:From:To:Cc:Subject:In-Reply-To:References;
	b=bZ9rboZdTe4XEpMT/kSygMte2k5VLnK1HcPqsDH5y/ipbmUgN9OEek8Ab6d2Jom/n
	 uxGPCydRvHxLkoN2Ra6AVkRJSdc5z145ifo1RbszfAZ5mG+Qs51NwZvOWd9ifGxvQO
	 UjV2d02UkF+Fquaad2BvJ7iKpydTS2rdJox5IhXQ=
Date: Wed, 11 Nov 2026 17:12:38 -0800
From: Andrew Morton <akpm@linux-foundation.org>
To: "Theodore Ts'o" <tytso@mit.edu>
Cc: workflows@vger.kernel.org, ksummit@lists.linux.dev,
 linux-doc@vger.kernel.org, linux-kernel@vger.kernel.org, Jonathan Corbet
 <corbet@lwn.net>, Shuah Khan <skhan@linuxfoundation.org>, Randy Dunlap
 <rdunlap@infradead.org>, Mark Brown <broonie@kernel.org>, Laurent Pinchart
 <laurent.pinchart@ideasonboard.com>, Greg Kroah-Hartman
 <gregkh@linuxfoundation.org>, Leon Romanovsky <leon@kernel.org>, Konstantin
 Ryabitsev <konstantin@linuxfoundation.org>, Thorsten Leemhuis
 <linux@leemhuis.info>, "Michael S. Tsirkin" <mst@redhat.com>, Kees Cook
 <kees@kernel.org>, Geert Uytterhoeven <geert@linux-m68k.org>, Dan Carpenter
 <error27@gmail.com>, Miguel Ojeda <ojeda@kernel.org>, Alexei Starovoitov
 <alexei.starovoitov@gmail.com>, Julia Lawall <julia.lawall@inria.fr>, SJ
 Park <sj@kernel.org>, Bradley Morgan <brads@mainlining.org>, Sasha Levin
 <sashal@kernel.org>, stable@vger.kernel.org
Subject: Re: [PATCH v5 6/6] agents: add a skill to write KUnit tests
Message-Id: <20261111171238.7a974b89a2d9e793666b30df@linux-foundation.org>
In-Reply-To: <20261111225940.1573565-7-tytso@mit.edu>
References: <20261111225940.1573565-1-tytso@mit.edu>
	<20261111225940.1573565-7-tytso@mit.edu>
X-Mailer: Sylpheed 3.7.0 (GTK+ 2.24.33; x86_64-pc-linux-gnu)
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Post: <mailto:stable@vger.kernel.org>
List-Help: <mailto:stable+help@vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
List-Owner: <mailto:stable+owner@vger.kernel.org>
Precedence: list
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit

On Wed, 11 Nov 2026 17:59:38 -0500 "Theodore Ts'o" <tytso@mit.edu> wrote:

> Add a skill under agents/skills/writing-kunit-tests/ to guide coding
> assistants when designing, implementing, verifying, or reviewing KUnit
> unit tests. Point the skill at the KUnit and process documentation and
> cover unit testing principles (testing behaviors rather than
> implementation details, keeping tests focused and DAMP, choosing
> non-default and distinct test values, using narrow expectations, and
> maintaining test isolation), KUnit resource management and static stub
> idioms, and verification with kunit.py.
> 
> Update Documentation/process/coding-assistants.rst to list the new skill
> and note that skills only inspect and report unless their task is to
> write or modify code or tests.
> 
> ...
>
> +  KUNIT_DEFINE_ACTION_WRAPPER(my_resource_cleanup, my_resource_cleanup_wrapper,
> +                              struct my_resource *);

LLM says this should be

KUNIT_DEFINE_ACTION_WRAPPER(my_resource_cleanup_wrapper, my_resource_cleanup, struct my_resource *)

:)
