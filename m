Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=194.117.254.33
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1795604808;
	b=Ds0y88iVSBhct10nBqXsz12vE/Sbp1jZAX6mNArTDumRsb44vkbCxD4QmDJIk5L/3w1l
	 7mlQF1XSa0IIUDjk5BzGiXueyfkT2a0ehX/NY3FoxH5SV46Lm3v5p7HmI5N3r6DzRj4aB
	 zGtRzqb0J+ZenWEFg/BCpMlj+3nzlidYo3LIepbqXX/Xi3oLQyFkc8EU5A+phKdjlVsCM
	 xkR613BnD9tg66k1joVR7K+mgXkxZBt9+duhHntEowaObwUuQYd0I4LGiUIQF8CNJy+xZ
	 mAw8X6M9TNdXOELbmvMLdeeg+GDH1Zc4u6diYQM1nZurudLB82EQ8LBDprvODA7ubdA==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1795604808;
	h=DMARC-Filter:DKIM-Signature:Received:Received:X-UD-Smtp-Session:Date:
	 From:To:Cc:Subject:Message-ID:References:MIME-Version:Content-Type:
	 Content-Disposition:In-Reply-To;
	bh=CC1jwJWwdI454y7ESWHR3zHzYlpHKlOaH1jugkPLgTA=;
	b=IGiOxzS6G2giL9C/V8IthUF3fWh3O5XdF9UwUkZ0oqjL4l+8V1aTcDCvUzsMAubmYUch
	 ifjB7MsP6/uF/eE04vQlQveTK+3CWHCiviuhe/skWC4HrrhK6KqnMz55S6aNHcKRysr3Q
	 R50op2oUuK63bXh3A4VFb4z9McjLvTbj7S8d1NoJfP2nlvlsiyUf7gP3+2VW8oqqdYIZG
	 GUJBrBb/SqNMI/GIf+oc55xxAV4GeuHHdggVv0w0Idtsx0AwUnm8B7TqKrEK9+3zTXssK
	 KFlAQKgvFv4u1vRi62lgaXLt+cX3cD/92o8eYIgpC+FC3mXAX6Qa63DPlIghbZfZJjA==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=none header.from=sang-engineering.com;
	spf=pass smtp.mailfrom=sang-engineering.com;
	dkim=pass header.d=sang-engineering.com header.i=@sang-engineering.com header.a=rsa-sha256 header.s=k1 header.b=fMGKjbRh;
	arc=none smtp.remote-ip=194.117.254.33
Received: from mail.zeus03.de (zeus03.de [194.117.254.33])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B21B3606A321
	for <stable@vger.kernel.org>; Wed, 25 Nov 2026 11:06:47 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org B21B3606A321
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=sang-engineering.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=sang-engineering.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=sang-engineering.com header.i=@sang-engineering.com header.a=rsa-sha256 header.s=k1 header.b=fMGKjbRh
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	sang-engineering.com; h=date:from:to:cc:subject:message-id
	:references:mime-version:content-type:in-reply-to; s=k1; bh=CC1j
	wJWwdI454y7ESWHR3zHzYlpHKlOaH1jugkPLgTA=; b=fMGKjbRhsXU3w7WCzWvR
	jDMwCDbDltuKrAz49M+eHGT13cQ+BowtOyhdnUbwFfj+NQrLxOMxLY+6BpmxN6g+
	e+hQDQiz+ZpuLIRuqn6//bWLd1pg3J6Y0H6rx+Ke60vBNEPChA/jZq4wi6AuxdqJ
	8E9763PtVJFG92FhAa2JGFAiS6uUrlC8TR/riiDT1x+PyXycWY6i1o+VZ1GZ9j1+
	ijbXXBjPpojvTdN//jIAl3wJCFB6vLEXCvDUD22Zav154zel+alSFIH2p/iXItuz
	3kCnNSQtjAe1khan/2tDK9ZqUmKacAWqwHv6CU7zOUjwdtOB4i60/gcRrT6W2Cz6
	NA==
Received: (qmail 892782 invoked from network); 25 Nov 2026 12:06:45 +0100
Received: by mail.zeus03.de with ESMTPSA (TLS_AES_256_GCM_SHA384 encrypted, authenticated); 25 Nov 2026 12:06:45 +0100
X-UD-Smtp-Session: l3s3148p1@DSmP0hdhdJcujnvc
Date: Wed, 25 Nov 2026 12:06:44 +0100
From: Wolfram Sang <wsa+renesas@sang-engineering.com>
To: Yige Jiang <yigejiang86@gmail.com>
Cc: Madhavan Srinivasan <maddy@linux.ibm.com>,
	Michael Ellerman <mpe@ellerman.id.au>,
	Wolfram Sang <wsa@kernel.org>, linuxppc-dev@lists.ozlabs.org,
	linux-i2c@vger.kernel.org, linux-kernel@vger.kernel.org,
	stable@vger.kernel.org
Subject: Re: [PATCH] macintosh: therm_windtunnel: Fix i2c adapter reference
 leak in probe
Message-ID: <awbBRG6VMVKn0Dor@ninjato>
References: <rc-b1-20261110-vc-23-41d00428efcb@gmail.com>
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
In-Reply-To: <rc-b1-20261110-vc-23-41d00428efcb@gmail.com>

On Wed, Nov 25, 2026 at 05:03:43PM +0800, Yige Jiang wrote:
> therm_of_probe() walks the i2c adapters with i2c_get_adapter() and
> drops each reference with i2c_put_adapter() before taking the next one.
> Once do_attach() has started the control loop, however, it returns 0
> while still holding the reference to the current adapter. The pointer
> is not stored anywhere, so that reference is never dropped. This
> happens on every successful probe, including after an unbind/rebind of
> the platform device, and the extra device reference would make
> i2c_del_adapter() for that bus wait forever for the adapter device to
> be released.
> 
> The driver does not use the adapter after do_attach() returns; the
> sensor clients it talks to afterwards are children of the adapter and
> are unregistered by i2c_del_adapter(). Drop the reference right after
> do_attach(), before checking x.running.
> 
> Fixes: 3e7bed52719d ("macintosh: therm_windtunnel: drop using attach_adapter")
> Cc: stable@vger.kernel.org
> Signed-off-by: Yige Jiang <yigejiang86@gmail.com>

I require tests on HW for this one. Windtunnel support has always been
very fragile.

