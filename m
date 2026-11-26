Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=100.103.45.18
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1795677778;
	b=NIoVXQhegEp/3NZUjiYq8IjeueYSkTAzjkkOvL3NJaqBuTEFDBUXxdhYyTVLFTaFKywo
	 /ojUUAbXUhmM8l3KSaLQhgXRS+BD1ECEnI5/TRaoY6OxtwdtC373v78gm53ZtPHJ9rm1s
	 VMn1NXjxv1XKxlj5jqF+yJQJuEMLq38nJdMkLXG9BgF/kvGG+nUxAxUcTU+koJ/PCBAbz
	 t/goLMYDy998NPX4nWJ+j0mj6QFUY0UEJNaaIpIy8xiVrjUxnXuMm0eDblLXtbMZP7KPJ
	 IWjexAoV31qjlMV3nR0wBJm7OaZBRYyK8Koc4QdJ4+RJezwVVvbwO3Tl5BFVAQoXM+w==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1795677778;
	h=Received:DKIM-Signature:Date:From:To:Cc:Subject:Message-ID:
	 References:MIME-Version:Content-Type:Content-Disposition:
	 Content-Transfer-Encoding:In-Reply-To;
	bh=c+YGKNy0undebmGtU4Trh2jXQSe0INHXZI3iEWNv0KU=;
	b=uy2w8/zWYtqUgNuBduJdrmZHSd2W7FvSICwdTDpROIeEUPLq0syWJNOEJR2ZnRjSUG32
	 lJgMbedMUqibQAiiOIPasjUfYJSLBp4k9Saq57mdu5x43llJXJAHQ9aWYDTbJVYILtIhv
	 ToXUH+G7oDSpiYtwm6AjOqvUeQGrfK1rbYC4HNkzT0Q8NJbStID78Mqj1Wjz06B1thbIK
	 XxdtTm8PVtTAd8aRLVryzvMH5FXURXIR1PgiFfAbwlGghFlqW2ci0K2IOSP9acxOjGufp
	 evkD+p8hP2mxS/qKZzhme0UegXu3RfC9ihnQ9P7ihQE/dDeWHNhhLCGkdjAjKupAvcg==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dkim=pass header.d=linuxfoundation.org header.i=@linuxfoundation.org header.a=rsa-sha256 header.s=korg header.b="nezz/RYL";
	arc=none smtp.remote-ip=100.103.45.18
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 24149606A31E;
	Thu, 26 Nov 2026 07:22:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.a=rsa-sha256 header.s=korg header.b=nezz/RYL
Received: by smtp.kernel.org (Postfix) with ESMTPSA id DE7FE1F000EC;
	Thu, 26 Nov 2026 07:22:56 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linuxfoundation.org;
	s=korg; t=1795677777;
	bh=c+YGKNy0undebmGtU4Trh2jXQSe0INHXZI3iEWNv0KU=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To;
	b=nezz/RYL58XFm29k5p/1GK6zWqhmxpdR4fuZYSYNSwciDNviQmVwhDzN6TyW1w9DS
	 EMW9HdSPl2dd253D9RP1Aeanfx2Xl2/54t6bz0Pmjix9PZKZdCYHqAoroKB+Tr3KJk
	 Eqi8TTPlaZQpW4XO1J25R7V/Wb7+551V3BoyFirU=
Date: Thu, 26 Nov 2026 08:22:54 +0100
From: Greg KH <gregkh@linuxfoundation.org>
To: =?utf-8?B?5qKT5bed5ZKy5aSq?= <inkxiao12@gmail.com>
Cc: stable@vger.kernel.org, bpf@vger.kernel.org, sashal@kernel.org
Subject: Re: [PATCH 6.12.y] Backport request: 49b18315be4e ("bpf: Add NULL
 check for dynptr in bpf_verify_pkcs7_signature")
Message-ID: <2026112636-landfill-praying-49a2@gregkh>
References: <CAMcAce_aAr0ADgpTdhOv04wkRVaYU6iOCRm7czUeBnPHY1Y5Kw@mail.gmail.com>
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Post: <mailto:stable@vger.kernel.org>
List-Help: <mailto:stable+help@vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
List-Owner: <mailto:stable+owner@vger.kernel.org>
Precedence: list
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <CAMcAce_aAr0ADgpTdhOv04wkRVaYU6iOCRm7czUeBnPHY1Y5Kw@mail.gmail.com>

On Thu, Nov 19, 2026 at 12:52:51AM -0500, 梓川咲太 wrote:
> Hi Stable Maintainers,
> 
> Please consider backporting upstream commit:
> 
>   49b18315be4e590fae0fc39c87d46c87e9ec903c ("bpf: Add NULL check for dynptr
> in bpf_verify_pkcs7_signature")
> 
> to linux-6.12.y.

Not a valid git id
