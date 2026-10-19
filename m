Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=100.103.45.18
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1792427878;
	b=vqywS7r2Jhm6fljRRDZH5g32XUwEkl1jIk3iPK/dBPhMLhPNNaAqXzsk1MBeqTcTn9N6
	 7OiXMymTgP1pIVampHEtRIWSLUG9zip+n7z3GUSeV68VkXP6sdAmoluxI/YbczYYCnkFt
	 2VrPLNHwZHFpc3IH8NB4zducLQYVeo3oGT3MSpdqGmiFDZhR2QIiIxw/UXhgq9i2+w2d8
	 azEM4zNXP3i+Pqz7DuCwB7MUNxz3euLmzK2oLqH6/03Oe/hRZuZ0hjscUuNkNfpKqfq5E
	 TvDy6XBJ5QJ7IFxFN0/aiEq96hwKVdSclUJm4fPaAEUEEcHoRe2W9SWfJ7ZblS13s1w==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1792427878;
	h=Received:DKIM-Signature:Date:From:To:Cc:Subject:Message-ID:
	 References:MIME-Version:Content-Type:Content-Disposition:In-Reply-To;
	bh=H+3Jzbs0/J+IBCVHh3CjTGM4uhBYtoVtzxePGU+3JPg=;
	b=d9MaPtlgMZeTZYzAxUDOEjcz/FHRy0oEp9CRj8pIkaEkNTBOH/y5UnQzTgUoY1bKHLPU
	 U1XncaiwoetDzqjOKpL+KIt21/zIpRcQXVZO54Z4d+6IHQe/XPWnaLx3mMJ9kmDaikYIu
	 jYo1Y4ga0vUS4+RHMxDqvlArM36rVxtpHZMaw/UfWhqdxEySv625FAGgwl7Y+sr10/6IC
	 /EwuSeXyv83+1KnK0jVOgT7g2UGe+0kzI7bzTQ4HCpDYaHaHNNVUNgAfUT1IYDEkeEI5I
	 vqsAfELHAkWvgcu+t8emjV/RvR/VO/4S4p5mplEZ2kbclxjfRCjAMV2MpqKq790H23w==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dkim=pass header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b="j/rtf65e";
	arc=none smtp.remote-ip=100.103.45.18
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with UTF8SMTPS id 6FCBF606A321;
	Mon, 19 Oct 2026 16:37:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=j/rtf65e
Received: by smtp.kernel.org (Postfix) with UTF8SMTPSA id 72DF51F000C6;
	Mon, 19 Oct 2026 16:37:57 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1792427878;
	bh=H+3Jzbs0/J+IBCVHh3CjTGM4uhBYtoVtzxePGU+3JPg=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To;
	b=j/rtf65ezRr+4pYztgbYk+EtmKOKHf5CwJN8oJwIXD0EDlBNXM9QlNr+rteeSWmKc
	 xEZ8/o+vGEihtnaa8aeBIvsT3+uBKrEqWHQhUoXC6faQUZo9Cl8CJkEVl9oGWsOVaI
	 e7CHuut92MjopEQP39eOzB2wquVcuGl0RIQo7lwhArJnfXJfa9OUBISwaEluf5szfI
	 +SpnlUsU+02lzcHU9sfQMm89+rC78YaQ6viEMGTc/6Z7oBnpjmi5J8RZhLRpzO9geO
	 KC6vsJpM5+OqUusPHXTMo/ZhzQqvfOnBrNPfTWgiCocsGh54y8DYRUGzy2KyeQY3h+
	 LXXeGuPVaO4wg==
Date: Mon, 19 Oct 2026 19:37:54 +0300
From: Jarkko Sakkinen <jarkko@kernel.org>
To: David Howells <dhowells@redhat.com>
Cc: keyrings@vger.kernel.org, Eric Biggers <ebiggers@kernel.org>,
	stable@vger.kernel.org, Paul Moore <paul@paul-moore.com>,
	James Morris <jmorris@namei.org>,
	"Serge E. Hallyn" <serge@hallyn.com>,
	"open list:SECURITY SUBSYSTEM" <linux-security-module@vger.kernel.org>,
	open list <linux-kernel@vger.kernel.org>
Subject: Re: [RFC PATCH 8/8] KEYS: Verify the key identity in __keyctl_unlink
Message-ID: <atZHYltB-Fndn17J@kernel.org>
References: <20261019142516.300040-9-jarkko@kernel.org>
 <20261019142516.300040-1-jarkko@kernel.org>
 <2610587.1792425313@warthog.procyon.org.uk>
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
In-Reply-To: <2610587.1792425313@warthog.procyon.org.uk>

On Mon, Oct 19, 2026 at 04:55:13PM +0100, David Howells wrote:
> This will show it:
> 
> 	keyctl newring ring_a @s
> 	keyctl newring ring_b @s
> 	A=`keyctl add user A ss %:ring_a`
> 	B=`keyctl add user A qq %:ring_b`
> 	keyctl newring R @s
> 	keyctl show
> 	keyctl link $A %:R
> 	keyctl show
> 	keyctl link $B %:R
> 	keyctl show
> 	keyctl unlink $A %:R
> 	keyctl show  # R is now incorrectly empty
> 
> Reviewed-by: David Howells <dhowells@redhat.com>

I'll actually add this to my own test harness, thanks.

I'm a slightly worried of this patch given that you can
technically interpret it as a uapi change. I guess here it
is acceptable, and if a tree falls down, we'll respond
to that.

Br, Jarkko
