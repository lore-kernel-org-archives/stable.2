Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2E4FC1A9FBC;
	Sun, 31 May 2026 17:04:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1780247096; cv=none; b=mixGAzQIx1RcC/QKM6IBCZVdts9RYm/5SU10pj2+sPXMu0bn1U1IQwnK4CmQJ4sP6FgF+4fj05Bypcs4uU9ut0zatV4ZlKglSCgyMyZV3aWA/7e7fV+tObNcVAs/xviR3yttq5zQH9FGYzrROhPD7BUvvHcegG93puIrmBQIlIU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1780247096; c=relaxed/simple;
	bh=jngPp+w7Ksu7gsTnfGygZDL4tF+S1G+/zkSdXoYzJ1c=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=JQZ1SgN3JtbSLo6t97C8dHjuyj3bZGjMhB82imReLJSDAnmyyXb3dHN18C4O8rbZvQjTAVVabQ1FYANOA9LYnz0bkF8ELwmp3R2A9MCCoJUW80O4giVTd+3J/sGPqWNNKWpJefSlJ0dD0KMUJwI4qLMYMvznAjUbWlmyx2w5Tao=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=dwJ4pCvr; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="dwJ4pCvr"
Received: by smtp.kernel.org (Postfix) with UTF8SMTPSA id 2BF101F00893;
	Sun, 31 May 2026 17:04:53 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1780247094;
	bh=vmVcttHD8U/PDaD7LLGhIcJvfJteRmIRh1ozj2XkBLY=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To;
	b=dwJ4pCvrtNRcPsZbpOLZT80KHltJ4bE1PaxdZ6TF/j/vRwWX6pTmn0gBfCZFdVnR1
	 m2tRqEL+XEHUl/E3EtFJiAqVo1tKfM0RjaqDc8PrEp9HeVPZUea6XQ6SuKNG9rCFl5
	 6az83l2/n7mIawRdwJs7uVzgfH9Uznd+G7QLn0/UxQ9xTb10TMvnZUxijVM75wzZG+
	 I64RNhtEvcjYPCpzydqgrY8umqHclesW1JwK1PbfRH0xDBtrPhBnYtB8nJDxAWURWA
	 PWdEo9bRC19cnyGXLzgDi/nRGu8SZjv7cOJUrCtFUlOZSMlEKpoGGiuwA21SjQ4Soo
	 qmEQ1WHz2Iqpw==
Date: Sun, 31 May 2026 20:04:50 +0300
From: Jarkko Sakkinen <jarkko@kernel.org>
To: Alessandro G <ale.grpp@gmail.com>
Cc: keyringsy@vger.kernel.org, stable@vger.kernel.org,
	David Howells <dhowells@redhat.com>,
	Paul Moore <paul@paul-moore.com>, James Morris <jmorris@namei.org>,
	"Serge E. Hallyn" <serge@hallyn.com>,
	Denis Kenzior <denkenz@gmail.com>,
	Marcel Holtmann <marcel@holtmann.org>, keyrings@vger.kernel.org,
	linux-security-module@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH] KEYS: fix overflow in keyctl_pkey_params_get_2()
Message-ID: <ahxqMocnAcWY7Hn9@kernel.org>
References: <20260531024914.3712130-1-jarkko@kernel.org>
 <ahuqIqUninpjqfpF@kernel.org>
 <CAJXJp6jMLQvYi6rpt31hO0O5WwLipSihT9PxFJu1bvtfUS2CBw@mail.gmail.com>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <CAJXJp6jMLQvYi6rpt31hO0O5WwLipSihT9PxFJu1bvtfUS2CBw@mail.gmail.com>

On Sun, May 31, 2026 at 09:23:11AM +0200, Alessandro G wrote:
> Hi Jarkko,
> 
> The surname is “Groppo” instead of “Grupp”, don’t worry and thanks for asking!
> 
> Thanks also for the fix!
> 
> BR,
> Alessandro

Thank you! This was a super good bug report.

Since I cannot do it without permission, can I add your tested-by to the
patch?

BR, Jarkko

> 
> Il giorno dom 31 mag 2026 alle 05:25 Jarkko Sakkinen <jarkko@kernel.org> ha
> scritto:
> 
>     On Sun, May 31, 2026 at 05:49:13AM +0300, Jarkko Sakkinen wrote:
>     > The length for the internal output buffer is calculated incorrectly,
>     which
>     > can result overflow when a too small buffer is provided.
>     >
>     > Fix the bug by allocating internal output with the size of the maximum
>     > length of the cryptographic primitive instead of caller provided size.
>     >
>     > Cc: stable@vger.kernel.org # v4.20+
>     > Fixes: 00d60fd3b932 ("KEYS: Provide keyctls to drive the new key type ops
>     for asymmetric keys [ver #2]")
>     > Reported-by: Alessandro Grupp <ale.grpp@gmail.com>
>     > Signed-off-by: Jarkko Sakkinen <jarkko@kernel.org>
> 
>     Should be available in -next within a day or along the lines so please
>     be quick with tags/feedback. I'll forward a PR as soon as all is good.
> 
>     BR, Jarkko
> 
