Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=100.103.45.18
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1792463315;
	b=OeZYWVEu1KJU2mr+ywVeJd6XfbqyjottkWaGqToMkLuZ/CKazWCXHix4PMogyq8bWhit
	 yrKz2wtVJsIR8yXgEtRnfLZhUVL+/FfEb+Wf/uP+ma2fIsjGL7Z6tb2C8n8an8QxeywxS
	 IDaTrGSf7281N8Jo5EwspiLu57HAFrdyYdKMipKE7Ll6n1zkQfHv6FUBXB0VQzItptJCT
	 Kk27lf2rFx7qqY83GqiAHYzM+umx5hNbx5HLNkikqiKzEXgyrb5Uo64AdmQmfrGtc2hej
	 woaePij4bWPHXV/Vc8tHydVP6APXeufpY3VqHswgQIEKDOfBi6vc8wtPP//MsiPawIA==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1792463315;
	h=Received:DKIM-Signature:Date:From:To:Cc:Subject:Message-ID:
	 References:MIME-Version:Content-Type:Content-Disposition:In-Reply-To;
	bh=V5cihXyATqCidh8/6M75ZLppoiMd7lC0ljH3nH4uCLI=;
	b=ixY/XvZA1wVMvDkMJkDXGvawmUZ+EGI52Zd2JCVKi/sjo9p+FXbNT4oDEIXV3k8t4cxK
	 S5DlwvZCv0HbjPhMFAyy154bVGprNMsgw9Mrb9Y4FzElkpQsgD+ybJIDmsGUuni6/Rc77
	 bQxqqtIuLUFyk3s6tGDuzsfaCqNecsXY4qLO4axy7zLRcKali9HiuHdeJvxXPlFBzW3C8
	 LwfCjGFKEd3YayuQ5XfwFkyGn1x7BRSG8cWSyuAnHTFLMAT0nKBdlhuUgmR5dZfR5Y3u/
	 g1YH5kBYBnl08VYRtM+iodJI5bKllowEuzwH2EWwqTwWM2QuoIIj9s7dknEwMdO8mTQ==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dkim=pass header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=I6bXe+6b;
	arc=none smtp.remote-ip=100.103.45.18
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 53CDD606A319;
	Tue, 20 Oct 2026 02:28:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=I6bXe+6b
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 4ED5A1F000C4;
	Tue, 20 Oct 2026 02:28:34 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1792463314;
	bh=V5cihXyATqCidh8/6M75ZLppoiMd7lC0ljH3nH4uCLI=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To;
	b=I6bXe+6bpB000XibXf50OYL+rdA4e4XZ2djvv/ppK6x7M6BA6natdh6LyJNlgKp2a
	 kjtaLa2G723LyqKDLGa4Q1QGLsfv8G+gf3T6hpnuspoDzHXJh+PZ7JQHRnAZdxQ0Ia
	 Pfa3KR/qkDNOfiBuv7q6X0kJ9UNULHUfMGxsh4zVJ+PwY97R3LRwhC/ILFqNzKzLfw
	 JnlJRYzpq9A4s5jC+AWl5FnLTQP4vj5PbX6JaT6Lm/j1EraCqoSYs4OGhUmh1jVnAJ
	 W87sCqw7OekBx3EDhmdaVxuOommk29GuFwXUbkCJbUCr2XqlGpYmF63YF486ABRysv
	 bdQsfJh//Uy8Q==
Date: Mon, 19 Oct 2026 19:28:32 -0700
From: Eric Biggers <ebiggers@kernel.org>
To: Jarkko Sakkinen <jarkko@kernel.org>
Cc: David Howells <dhowells@redhat.com>, keyrings@vger.kernel.org,
	stable@vger.kernel.org, Paul Moore <paul@paul-moore.com>,
	James Morris <jmorris@namei.org>,
	"Serge E. Hallyn" <serge@hallyn.com>,
	open list <linux-kernel@vger.kernel.org>,
	"open list:SECURITY SUBSYSTEM" <linux-security-module@vger.kernel.org>
Subject: Re: [PATCH v3 2/3] KEYS: Reject @desclen values >= KEY_MAX_DESC_SIZE
 in key_alloc()
Message-ID: <20261020022832.GA3727@sol>
References: <20261020013903.1244157-1-jarkko@kernel.org>
 <20261020013903.1244157-3-jarkko@kernel.org>
 <atbIP003h_YHofQb@kernel.org>
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
In-Reply-To: <atbIP003h_YHofQb@kernel.org>

On Tue, Oct 20, 2026 at 04:47:43AM +0300, Jarkko Sakkinen wrote:
> On Tue, Oct 20, 2026 at 04:38:56AM +0300, Jarkko Sakkinen wrote:
> > @desclen in key_alloc() is saved to the 16-bit wide desc_len field in
> > struct keyring_index_key.
> > 
> > Reject @desclen values at or above KEY_MAX_DESC_SIZE with -EINVAL in order
> > to match the userspace limit. The constraints inherits from the one byte
> > required for the NULL character.
> > 
> > Cc: stable@vger.kernel.org
> > Assisted-by: LLM
> > Fixes: f771fde82051 ("keys: Simplify key description management")
> > Reviewed-by: David Howells <dhowells@redhat.com>
> > Signed-off-by: Jarkko Sakkinen <jarkko@kernel.org>
> 
> This is now the only one, which does not have keyutils script in the
> commit message so in that sense I think these fixes look pretty good.

Sure, this fix is still incomplete though, as I mentioned.

Turns out Sashiko found this too; see the comment on
https://sashiko.dev/#/patchset/20261020013903.1244157-1-jarkko%40kernel.org

- Eric
