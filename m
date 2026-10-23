Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=100.103.45.18
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1792725236;
	b=KwYhFIUUlfvTljNJFXphvO55DqTRtzqaboxxif5ViaM3H/HlWPB6ssgt9tEHIBWea/aD
	 JN31WOGoNhMxeCV1LnmxAAv8gY8aYwAy+D9u37KRaN0+EwoVcgVIHapO+QS/T4UY6Z08a
	 DmmC+8vmH3qouWLlCBEFtB8pKhNXj4iGqesvFd31wGhg0aCi89UPc7lVusZ7AlgR4fKnw
	 oEghRTzdSsEeR9syhypVspxO5qx51n2ZbNcnTGLLPnGYy9XhOhsnJmXxAFfL5sEDxQiy0
	 StgBc1pPTYmaQgkGdQIIDtWxaAshPkhBVqymlrX7dVzVA+Fmb/1LuXhPINb4FalNOGg==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1792725236;
	h=Received:DKIM-Signature:Date:From:To:Cc:Subject:Message-ID:
	 In-Reply-To:References:X-Mailer:MIME-Version:Content-Type:
	 Content-Transfer-Encoding;
	bh=vfZGoyGj+flppEH91JjbeJRT3nOonufO4fLgvx1VIJk=;
	b=UCzSGoTfethIsRRLkGCB1TP6fN2SMFrDCmXNwOJ0cMzC8woopK25tygDgvY3kGlE/6QN
	 lPTAO1ddOcQDxNy4X5LTKec0wxJ5ZIZyFcDL1fU9fDqRAQmpWJFPqI7PJvrjXUhW2/RRj
	 ogVTAbRBOdbxzJAULVtaesbKYqHnb8REF/C/97Q5O2SeFFQGJ8d+OoG8m9t6w/amDXG8F
	 whYqlAWeMAi14M8rBy1jjJyDlBjNdbVENHy05yMElQH4NhCdHiJtf89fKART/e7nwvyfp
	 UYn7jW0jK0JRPJ/fCOdv8abz6yClXyxgkbJNWfKh+coLuZ7DYUqz/cysUD4+Yl+Qnew==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dkim=pass header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=J6yVuvZH;
	arc=none smtp.remote-ip=100.103.45.18
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 16723606A319;
	Fri, 23 Oct 2026 03:13:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=J6yVuvZH
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 203FE1F01825;
	Fri, 23 Oct 2026 03:13:53 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1792725235;
	bh=vfZGoyGj+flppEH91JjbeJRT3nOonufO4fLgvx1VIJk=;
	h=Date:From:To:Cc:Subject:In-Reply-To:References;
	b=J6yVuvZHnPt47ffzAcGrnp/M3/SWHoy93BW4CqT/BPHNgBgnllV4wOSQnkymH1DAI
	 8iMxGrzykjUpjMXu69hfbng7xnq4krESuW086BfmIwZ4rOblDOu7Pn64rf8rBwuoWZ
	 /jMjXnS9XVs/SXR1/Z0PjTu+WjP+9ksYSiRnb54dFhgem0uWDCZKDm7vwMJDA8Z/K+
	 Cj/Fy1MjDWEuGgincSC3HtD8yfNoFDaz6cTdviiq09LBvmTfuJL4dhI/3JJvhX0kSw
	 vCHYomcbVwxO2TPoMBN3kceMZkpDeX4ceQGlidWoCJlqE1fgupgvDENZEhQx+g04kU
	 nxJ8gw7wKeNug==
Date: Fri, 23 Oct 2026 04:13:48 +0100
From: Jonathan Cameron <jic23@kernel.org>
To: Jan Remes <ciakval@gmail.com>
Cc: David Lechner <dlechner@baylibre.com>, Nuno =?UTF-8?B?U8Oh?=
 <nuno.sa@analog.com>, Andy Shevchenko <andy@kernel.org>, Joe Sandom
 <joe.g.sandom@gmail.com>, linux-iio@vger.kernel.org,
 linux-kernel@vger.kernel.org, Jan Remes <jan.remes@mycroftmind.com>,
 stable@vger.kernel.org, Martin Triska <martin.triska@mycroftmind.com>, Andy
 Shevchenko <andriy.shevchenko@intel.com>
Subject: Re: [PATCH v4 1/4] iio: light: tsl2591: don't divide by zero
Message-ID: <20261023041348.4717b717@jic23-hlaptop>
In-Reply-To: <20261022-first-patch-v4-1-90b2fc6e8e28@mycroftmind.com>
References: <20261022-first-patch-v4-0-90b2fc6e8e28@mycroftmind.com>
	<20261022-first-patch-v4-1-90b2fc6e8e28@mycroftmind.com>
X-Mailer: Claws Mail 4.4.0 (GTK 3.24.52; x86_64-pc-linux-gnu)
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Post: <mailto:stable@vger.kernel.org>
List-Help: <mailto:stable+help@vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
List-Owner: <mailto:stable+owner@vger.kernel.org>
Precedence: list
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit

On Thu, 22 Oct 2026 20:56:40 +0200
Jan Remes <ciakval@gmail.com> wrote:

> From: Jan Remes <jan.remes@mycroftmind.com>
> 
> The TSL2591 has two raw light channels - CH0 and CH1. The algorithm for
> calculating illumination from the raw channels requires division by CH0
> (which can be zero) and by "counts per lux" (CPL) value which is also zero
> for (gain = LOW, integration time <= 400 ms).
> 
> Furthermore, the algorithm assumes CH0 > CH1, which can be violated in
> almost complete darkness.
> 
> As a result, reading from 'in_illuminance_input' results in
> division-by-zero whenever CH0 is 0 (complete darkness) or whenever the
> parameters result in CPL being zero. This results in kernel oops on
> x86_64 and in reading the value as 0 on arm64.
> 
> Fix that by:
> - reporting CH0 <= CH1 as zero (catches also CH0 = 0)
> - updating the lux algorithm to only do the division at the end
> 
> Fixes: 2335f0d7c790 ("iio: light: Added AMS tsl2591 driver implementation")
> Cc: stable@vger.kernel.org
> Reported-by: Martin Triska <martin.triska@mycroftmind.com>
> Reviewed-by: Andy Shevchenko <andriy.shevchenko@intel.com>
> Signed-off-by: Jan Remes <jan.remes@mycroftmind.com>
Applied to the fixes-togreg branch of iio.git

Thanks,

Jonathan
