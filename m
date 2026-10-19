Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=100.103.45.18
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1792427553;
	b=5lInLH0n74JZz0NDGV9SPHvRJQnuy5AxfBP61OzcHaH+mqh+/WH3361aIlQ86VLA2gcP
	 je2FEUxjjoBtcijwUtiMqZ7E17+ytO0aRVPpvSKScL39guGEgbs5WZtzewdIoAVk37+kC
	 jpLCOCRh7ri2kF5KBuVrGY6g3yheuP39XjpIxH3pKWu5VyiwSS/mY3DxMbpjArpgyHAjO
	 9GHB+hnZnuNd9HzUhF0AYtmZXUGdmujRivRt3KCODleBP4ywKSeh5g9SHNUAhVzs0ebgu
	 A/ItnT2R1mylGx8A3mfO52+bmQsi2qd1/eMRXoxX0DvfVmb4WMENrdsiG4QoGKGx8yg==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1792427553;
	h=Received:DKIM-Signature:Date:From:To:Cc:Subject:Message-ID:
	 References:MIME-Version:Content-Type:Content-Disposition:In-Reply-To;
	bh=+VR/o2o/DhJfnVdRZHSwegdY3Q5vwh/kgdmzV0BQzrI=;
	b=nl4K8A+Uh2xx9Ja6NgWgkaUkCNbphdgXUKAaIq7gwrfclLfb0yIcR1nUkVccD8P6VSJY
	 fu5dep4o0rk2RvzO8svoSLk39ZvdBD0HLji4QWgaMHM/pdgbi8SpxUdskJmzZSIaUujVM
	 zG7NiiuRptwivZ80JOOFxfnNBpEoTqu8AYDighDyWvmyHT44oFCioNvz8RxxIkN/OJdme
	 uVKq5LiNG+LVw0Vv20qws9IawJG/uSHKCe25nom91AMhNfouPhbzbhgOlV65uWBT+Ng6B
	 qSzT6W7sCgC7KeX7S8kpCsqvssBeZ7sfzUkrexAjvKN2xO0UWwDM6bNeMWvQHwrKQRQ==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dkim=pass header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=n5FS2pB7;
	arc=none smtp.remote-ip=100.103.45.18
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with UTF8SMTPS id 5C1F4606A31F;
	Mon, 19 Oct 2026 16:32:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=n5FS2pB7
Received: by smtp.kernel.org (Postfix) with UTF8SMTPSA id 4D8D11F000CC;
	Mon, 19 Oct 2026 16:32:32 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1792427552;
	bh=+VR/o2o/DhJfnVdRZHSwegdY3Q5vwh/kgdmzV0BQzrI=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To;
	b=n5FS2pB7BNbwmdCUMaZ7qcy9gEJS+4y6GcWxbkZ6ShABdtlLxKtiQKg6d6tzP8auY
	 Q0kUUPTL+BAERQjOTKdMLBOHy5uHVy0plbsYycgMlWWydecQ+vbHRWed4F26etXmiU
	 xReVnS+t3N8ZxDcL71AqQ2OLDdpOana2bHBps3cT3v73Qb/VD0WjT1kVoHkRaLqn0d
	 XO3xFUJ3znwpNOBmTtKGWC/zLEeX+i4yprDUPNYnCsH7l3yjuqLxmXrKwLPGukpj9G
	 7QQF8xA93U7Q+TuRoN56kPLLzENu6D/y4SaChUFJ8zQ8ckY9bosFzn7Ws2RlM4fHSS
	 UGtsJ8977koPA==
Date: Mon, 19 Oct 2026 19:32:29 +0300
From: Jarkko Sakkinen <jarkko@kernel.org>
To: David Howells <dhowells@redhat.com>
Cc: keyrings@vger.kernel.org, Eric Biggers <ebiggers@kernel.org>,
	stable@vger.kernel.org, Paul Moore <paul@paul-moore.com>,
	James Morris <jmorris@namei.org>,
	"Serge E. Hallyn" <serge@hallyn.com>,
	"open list:SECURITY SUBSYSTEM" <linux-security-module@vger.kernel.org>,
	open list <linux-kernel@vger.kernel.org>
Subject: Re: [RFC PATCH 3/8] KEYS: Reject @desclen values over U16_MAX in
 key_alloc()
Message-ID: <atZGHd_ricOqIPnw@kernel.org>
References: <20261019142516.300040-4-jarkko@kernel.org>
 <20261019142516.300040-1-jarkko@kernel.org>
 <2609869.1792424119@warthog.procyon.org.uk>
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
In-Reply-To: <2609869.1792424119@warthog.procyon.org.uk>

On Mon, Oct 19, 2026 at 04:35:19PM +0100, David Howells wrote:
> Jarkko Sakkinen <jarkko@kernel.org> wrote:
> 
> > Reject @desclen values over U16_MAX with -EINVAL in order to prevent
> > integer overflow.
> 
> KEY_MAX_DESC_SIZE.
> 
> David

Good catch, thanks.

Br, Jarkko
