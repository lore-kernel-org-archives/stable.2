Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=62.72.0.81
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1795805335;
	b=eDkiPsk+6SbgWykxbX5gEKwx+0yuu+6E+XKtVm6cg4DP03BnUukr3a8kGXRlgehHwf7w
	 Pi1BdB2MfzeAYNvVsr+Bs4Sz0m2xL0LGyJ71MG2ZVqfxleYPIz0CRa+Vv+T25Ne8/76OJ
	 3w4J7qXAKMrG8LFOoX2glbPX4oxX2fxt9sUsePMS6bXkakEtOw4fMFDsjOx4lEqG79oM4
	 1k51OZZKbYvxPZcaBlVLFKehXCrtEQ9tlj+KqguyjbWVFL+80EgGh2czPfhEKnozayP0B
	 izDr9sMd0iwNhcCZ1MrW0NONDOhLJ9gnQx7pKGeejOeEdBjpHiF+swT2W54LZOLLXig==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1795805335;
	h=DMARC-Filter:DKIM-Signature:Received:Received:Date:From:To:cc:
	 Subject:In-Reply-To:Message-ID:References:MIME-Version:Content-Type;
	bh=dYyeeMUhFr8puOuOZGQZM4QfG/R8QVp2KZHEpG+NBoI=;
	b=hwyJAoATVm0WqAhldYxjKywEmsN2qYYIZwNcaXzoxoyUmAQUcPBcwepl5JqjxrlUgcdf
	 4W6gDhJ6ae9mvTMFRyQEW/k9CxyqQ9n/gXV2Bf2wvahRwdYobF0zbFWgPt3A96js8BpTK
	 tx7upq2ybciQx9DM7uehkgsagXrKHOychERNlmEqHU8RZTBsD82ck5/rZ2SjVNaVU6hMK
	 rxCiFzJ7REPgsiHg3rfdDoaGsifPktOGJMWsIjkJJv1+mKjKK9Z88cFEVxiidd3QOSbUI
	 3WrTyG1SoIwKXK23Gj6yPnm7mRf2tHelioYkafo5Zu3ON0mSZ9lMobSAMfDOOl8xB1Q==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=gentwo.org;
	spf=pass smtp.mailfrom=gentwo.org;
	dkim=pass header.d=gentwo.org header.i=@gentwo.org header.a=rsa-sha256 header.s=default header.b=WxD93Wcx;
	arc=none smtp.remote-ip=62.72.0.81
Received: from gentwo.org (gentwo.org [62.72.0.81])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 30B38606A31C;
	Fri, 27 Nov 2026 18:48:55 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 30B38606A31C
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=gentwo.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gentwo.org
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key, unprotected) header.d=gentwo.org header.i=@gentwo.org header.a=rsa-sha256 header.s=default header.b=WxD93Wcx
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=gentwo.org;
	s=default; t=1795805327;
	bh=/5CPMl9xM07tjnndPJsjgzhmzWrFR7GjPE4mqIGwTa4=;
	h=Date:From:To:cc:Subject:In-Reply-To:References:From;
	b=WxD93WcxquzKHgKa85ZtS6l7VrrAPt88ivgoPKsNYKsoNCvUnExUCzarrO1Y+RogA
	 8lVwQwwNz0AESZj6VxT7XpNlYX9MGBWbD5AhYcOa5X7IiXYSFLpZ2J9hZ0LH9BrcCS
	 XqvSCJ3OB+62QTyUyuQ1AZAvX0vizszPnothVkEo=
Received: by gentwo.org (Postfix, from userid 1007)
	id D347F401F9; Fri, 27 Nov 2026 10:48:47 -0800 (PST)
Received: from localhost (localhost [127.0.0.1])
	by gentwo.org (Postfix) with ESMTP id D0C20401F8;
	Fri, 27 Nov 2026 10:48:47 -0800 (PST)
Date: Fri, 27 Nov 2026 10:48:47 -0800 (PST)
From: Shubhang <sh@gentwo.org>
To: "Rafael J. Wysocki (Intel)" <rafael@kernel.org>
cc: Lukasz Luba <lukasz.luba@arm.com>, Len Brown <lenb@kernel.org>, 
    Pavel Machek <pavel@kernel.org>, Donald Hunter <donald.hunter@gmail.com>, 
    Changwoo Min <changwoo@igalia.com>, 
    Shubhang Kaushik <shubhangpk@gmail.com>, Christoph Lameter <cl@gentwo.org>, 
    "Rafael J. Wysocki" <rafael.j.wysocki@intel.com>, linux-pm@vger.kernel.org, 
    stable@vger.kernel.org
Subject: Re: [PATCH v2] PM: EM: Fix netlink performance-domain dump
 pagination
In-Reply-To: <CAJZ5v0jD4ddgeW=jBH1_zkOkF3poAoQGo5VAok+ZeVY73__krA@mail.gmail.com>
Message-ID: <c66af709-c6c2-f917-453f-98130b33685c@gentwo.org>
References: <20261125-pm-em-dump-v2-1-a28e132f8b0c@gentwo.org> <CAJZ5v0jD4ddgeW=jBH1_zkOkF3poAoQGo5VAok+ZeVY73__krA@mail.gmail.com>
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Post: <mailto:stable@vger.kernel.org>
List-Help: <mailto:stable+help@vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
List-Owner: <mailto:stable+owner@vger.kernel.org>
Precedence: list
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII; format=flowed

Hi Rafael,

On Fri, 27 Nov 2026, Rafael J. Wysocki (Intel) wrote:

>
> Sashiko has feedback on this:
>
> https://sashiko.dev/#/patchset/20261125-pm-em-dump-v2-1-a28e132f8b0c%40gentwo.org
>
> which looks valid to me.  Isn't it?
>
> Sashiko flagged this on the v1 too, AFAICS.
>

Yes, it is valid. I missed that returning skb->len after the final
successful traversal triggers an unnecessary additional callback.

I will send v3 returning ret after saving the cursor.

Thanks,
Shubhang Kaushik
