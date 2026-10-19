Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=100.103.45.18
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1792429712;
	b=NqjPdr/Vj2myEHwltCogY+nHjVXgkdYz+ATSE061JoupizOoLbaN745SX/wDYwb/rOfq
	 ICJ5np+JJXSFz8XGvPojUXXcS5vqI7y6ciBy/fDIenSKSfLM9MYHwKa+RJwDS+BDzF2wg
	 HVLw96M9UZa0KDlpSmE8ytx3OpvQZlKrHypdV28GZcKXxWQTTNjw/Ahkx/Nig2YzqRkCZ
	 tJCD4BjRtxnP8gsWN7zqTuWwJbxi1+wrxhK/xUE/RUI/BWUowyiQcVaNN63cF6da3t6/O
	 P9HAiZgTvoVWof7buhwK2bWb4vuoAhPxlFAP3eAFcLSMycjXGA3RsBRKe8I7XZ6pgUw==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1792429712;
	h=Received:DKIM-Signature:Date:From:To:Cc:Subject:Message-ID:
	 References:MIME-Version:Content-Type:Content-Disposition:In-Reply-To;
	bh=k4wnkBFrl6pjyADZhT342W27ueLhNCpKpq6XivIO9Xc=;
	b=HTtGODIYBNIn520rsQEdTES6s8Q9TDQ4q9l9q5D0qzI5c+dbgvkFZvQznhtKDCmJ9oGv
	 oSvbvvSQT6lBDVu44clFNHJwnqZ9BI7qA26JnBc807BoR8h5lTgfVKUbBAdwm1QTzISFo
	 El1RhLduSSA8AcRhFZ1tfGtJYyd+OIY+vSlBWCr30a1X53Ra/EgREnam4ig6+L8g5juCl
	 /8KlMmOkdINLwSSpzqYq1xgO1reCUIYFc8BUZYTUv3z6jzXWE3t2+hyU5LSC9P3tFGjTh
	 +fT7N7fV10C5VTrLQUoRrsqk5xhuV6M1DbfeqRyIM4THcGTLLSWFf4wCgtA5U5lMNSQ==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dkim=pass header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=h4QUfi0T;
	arc=none smtp.remote-ip=100.103.45.18
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with UTF8SMTPS id C2012606A31A;
	Mon, 19 Oct 2026 17:08:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=h4QUfi0T
Received: by smtp.kernel.org (Postfix) with UTF8SMTPSA id DEB5B1F000C4;
	Mon, 19 Oct 2026 17:08:30 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1792429711;
	bh=k4wnkBFrl6pjyADZhT342W27ueLhNCpKpq6XivIO9Xc=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To;
	b=h4QUfi0TENTekE8f27i8Ol0m2z7/x8KmnB02SRAxzO3mbnn664oHUkPC4Igtjt+Bg
	 MMoB8mHKJNvi2YFAoQN2J1EJWjCcP3HAl8y3qhgnmcNxwuz4O3zTppmq3rJe9ktY6H
	 0BHQvZFQJRjnO5vHbCFELBesPN/VgzXYcEFwj7gNzvyyhvWByuEQvNq+oL3F2xGGJ8
	 JQxZ+xOtoepV7j8WZGJ93o6kJGsxOW32FSe2EzFztWlKjROHF2uINtLgd+1AZyJ5dO
	 T6CYksGcmcVw6Oy8ALmB1Jb0wUbw2ObiYuSgi+rixS/5Za/mDm5p8vBmDC8kCHofFV
	 i0LRSgaayTCTg==
Date: Mon, 19 Oct 2026 20:08:27 +0300
From: Jarkko Sakkinen <jarkko@kernel.org>
To: David Howells <dhowells@redhat.com>
Cc: keyrings@vger.kernel.org, Eric Biggers <ebiggers@kernel.org>,
	stable@vger.kernel.org, Jann Horn <jannh@google.com>,
	Jonathan Corbet <corbet@lwn.net>,
	Shuah Khan <skhan@linuxfoundation.org>,
	Randy Dunlap <rdunlap@infradead.org>,
	Paul Moore <paul@paul-moore.com>, James Morris <jmorris@namei.org>,
	"Serge E. Hallyn" <serge@hallyn.com>,
	"open list:DOCUMENTATION" <linux-doc@vger.kernel.org>,
	open list <linux-kernel@vger.kernel.org>,
	"open list:SECURITY SUBSYSTEM" <linux-security-module@vger.kernel.org>
Subject: Re: [PATCH v2 2/2] KEYS: Reject keyring creation with overridden
 credentials
Message-ID: <atZOi-r1ayaLhgY_@kernel.org>
References: <20261019145624.309790-2-jarkko@kernel.org>
 <20261019145624.309790-1-jarkko@kernel.org>
 <2610820.1792425550@warthog.procyon.org.uk>
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
In-Reply-To: <2610820.1792425550@warthog.procyon.org.uk>

On Mon, Oct 19, 2026 at 04:59:10PM +0100, David Howells wrote:
> Would it make sense to just reject KEY_LOOKUP_CREATE at the top of the
> function if the creds are overridden?

Let me check..

Yep, I suppose you're right. I'll update the patch.

> 
> David
> 

Br, Jarkko
