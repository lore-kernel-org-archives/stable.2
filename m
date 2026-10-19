Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=100.103.45.18
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1792427501;
	b=z9G/3jh6Q3YdrzYstrUn5ehfvz3AQKNrftOD5/e9gkaCJGt37ME678fMygzXJZCJCC3u
	 qvly840Zu2aFO3T4fgjuaJj5wRbC3ypFL7zV31H4SgTQzpmIaRU80K0Y06uH/55Kk0e1Z
	 xu5TH/WtBGM5j/5LJBUBjiqgC0TxTUk0cack7a6pW4Gyha3iDoRtrkUvHfwBLWxwPUq1J
	 IrN0TihucwBdKO55WgEGBwADOD60akibfTvuJ5ogEP7ZfRGxUztcILC+3ELA+oOMk1FZ5
	 GCQYhwlPoHqOtpmUV1mQSXTj50hUaSKo326ALKn0O0UD0kE80ouAKgHEj6uMKbXVvUg==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1792427501;
	h=Received:DKIM-Signature:Date:From:To:Cc:Subject:Message-ID:
	 References:MIME-Version:Content-Type:Content-Disposition:In-Reply-To;
	bh=9PTCGIfHqtYqMTLPhP30HbjjDJXCnmWLO/evJguW83U=;
	b=A2qnZKRqklot8EAuQoOy8+uFGN1kgwWhBSLtOb8NgdCNcI02oKrpE5hD0ULhH5p6ZVYb
	 q5gMCx6Iu3XVms0Rm+KLKGfPJdHrttMT+aipw0XLnlgWocKsZaLTUdVSuqI9BYGxLnIET
	 +EEAvSpoQNkl8DMVWuthTfrQC1WhYavFtAMBkLAdTPOjf/SZFigo9RBClaK5m0muHjqj6
	 xChsQl/zq3iEoGYxDKAACgpLeT7pngbjUPdU3i4sCvz3eWvQB8CrTKFbOhu5JzuHl/OC3
	 reqqW+1BIBcQW0hq+AKScG//Ynm/iwDbuw/9GS+MGxzleb0ELz5UnY72U1ijUJMIUnw==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dkim=pass header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=iFNVXkt3;
	arc=none smtp.remote-ip=100.103.45.18
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with UTF8SMTPS id 7C67D606A323;
	Mon, 19 Oct 2026 16:31:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=iFNVXkt3
Received: by smtp.kernel.org (Postfix) with UTF8SMTPSA id CE7C11F000C4;
	Mon, 19 Oct 2026 16:31:40 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1792427501;
	bh=9PTCGIfHqtYqMTLPhP30HbjjDJXCnmWLO/evJguW83U=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To;
	b=iFNVXkt3NzfxWDtSAaM/InhkOo/nCE1+EmpW6OvvN9GzTl8FdQWxhE502rkn/5XBn
	 2u8/ECJGBOb0mh+/HLr2EhKrcM8rIK75WK3kPucBYYngclDbGVgF2hZOifafcvOS7I
	 A1i/IUzgzl9GtuUSkpEVnsjtAyq/TyRcqC/mYvNRYU9Wrzj4TMBsSHDER9ReYuaaIO
	 11/Pbg1GhwGZzXniJndLUoOkPeH+XLbmXSIOvXonJrq59kar+hO1RFlqv0emStvhmD
	 3Df3+zo6gjMrX7/Ln+yhj6TAkUPTsAq8h8wtjDiyE9FItwTDftm8tmswA6SnGGFtLQ
	 fn1HDovdd7zlg==
Date: Mon, 19 Oct 2026 19:31:37 +0300
From: Jarkko Sakkinen <jarkko@kernel.org>
To: David Howells <dhowells@redhat.com>
Cc: keyrings@vger.kernel.org, Eric Biggers <ebiggers@kernel.org>,
	stable@vger.kernel.org, Paul Moore <paul@paul-moore.com>,
	James Morris <jmorris@namei.org>,
	"Serge E. Hallyn" <serge@hallyn.com>,
	open list <linux-kernel@vger.kernel.org>,
	"open list:SECURITY SUBSYSTEM" <linux-security-module@vger.kernel.org>
Subject: Re: [RFC PATCH 2/8] KEYS: Change the type of key->datalen to
 unsigned int
Message-ID: <atZF6T5roFnM4nTy@kernel.org>
References: <20261019142516.300040-3-jarkko@kernel.org>
 <20261019142516.300040-1-jarkko@kernel.org>
 <2609766.1792424012@warthog.procyon.org.uk>
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
In-Reply-To: <2609766.1792424012@warthog.procyon.org.uk>

On Mon, Oct 19, 2026 at 04:33:32PM +0100, David Howells wrote:
> I would merge this with patch 1.
> 
> Apart from that:
> 
> 	Reviewed-by: David Howells <dhowells@redhat.com>
> 
> on both 1 & 2.
> 
> David
> 

I can do that. I went a little over the top with sanity checking
the slop :-)

Br, Jarkko
