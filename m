Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=100.103.45.18
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1792427603;
	b=zF0qY7NOzArwZu4yYONOQl0mGc2cpMw/aEUqiMi6aXqbd6N0BWSIJPnzdjaeWVwQQLI+
	 Ofwpgipl3lhqZE3eYretpcaaEdzCkXIJrakLh6V5GUPv6A/nYry8tPGnfHXN1NbpxhYom
	 +F9CFZQRVp03laJTySuvjdKk7OVe36aS4xkv8sPn+4RX4gZJ0Vv1CUObiCBP4uiFqZ6ic
	 +MHQw8G9pts27fH+QWpy9vHWwewDaqgSYfFAv5mX69biYXKditP7w83c5mBl+5W3NRJtJ
	 3rcdlm78W3cz454j8I2dRmzZN3OQhPxlNmc6eg/iKl4zsGjBlzRBg21G/vu+5aEjL7A==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1792427603;
	h=Received:DKIM-Signature:Date:From:To:Cc:Subject:Message-ID:
	 References:MIME-Version:Content-Type:Content-Disposition:In-Reply-To;
	bh=/py+BIubP/OmBOm2FAgo3Fsz172lgOMKPKz0tgMlcJw=;
	b=MihWi6KXES6dG3I99b9GkXza18NTpUoEBzekXAJaYBKd8wJ7WVdqC/d3rpzAxn+7vR00
	 akZwX2lrfzlTXfqqT2MwQ8kYbSPfGvweC9EA1UmIVXWCAsFAjhwWV1JjbHnqZg1lh/lzb
	 3hO0/TwHqZogsBVKvBKIuOy1/VcPugs5BPxQnVRe891biEqLGkQxh8ho7nRdoMnDG/nzB
	 DPcXCjkIDFN/zJbI49hXjc736N9cGyxiP+9Dgp7rwHQAIVMTDlKa1SPOZ6SuwheyGg0JY
	 /CmuGHocPSzi/Fhntx5OmzNvEAsda829cvcqVZL0W92yvPi4E05+8pDjJyPIOxJPqNQ==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dkim=pass header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=HF4eKmos;
	arc=none smtp.remote-ip=100.103.45.18
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with UTF8SMTPS id 558ED606A319;
	Mon, 19 Oct 2026 16:33:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=HF4eKmos
Received: by smtp.kernel.org (Postfix) with UTF8SMTPSA id 648491F000C4;
	Mon, 19 Oct 2026 16:33:22 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1792427602;
	bh=/py+BIubP/OmBOm2FAgo3Fsz172lgOMKPKz0tgMlcJw=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To;
	b=HF4eKmosr4WxhxqpodI8RNtR1PpzPW111lcneNbgB49G42/Q0uKng8XamDYKCgeBB
	 cwVmEq1XWRkRYf+XInPo476PgMpkVurY1ZpvxoGgF+rBeplOfh6SbMo7cWk9mBCbvs
	 9eRzSHM1N5nkxS0cyy+yzT9zK8tQJJJydmpBYv3AjSfESghd4SS3yO3CToafWJ/fqM
	 j4b4p6TogCNkJZQCPgCxcOeFyZ7jdRQfu6znOsR8DPqF0b9Z+64OUjnC0JHRh3atHP
	 pr7MGLh7NsBIujimtwWQn/x3BUavk49KKc3XY5ojW9BQYBZhqcBV2Hv88OwOWCJaSF
	 sRjcjHAuxA6cg==
Date: Mon, 19 Oct 2026 19:33:19 +0300
From: Jarkko Sakkinen <jarkko@kernel.org>
To: David Howells <dhowells@redhat.com>
Cc: keyrings@vger.kernel.org, Eric Biggers <ebiggers@kernel.org>,
	stable@vger.kernel.org, Paul Moore <paul@paul-moore.com>,
	James Morris <jmorris@namei.org>,
	"Serge E. Hallyn" <serge@hallyn.com>, Andrew Morton <akpm@osdl.org>,
	"open list:SECURITY SUBSYSTEM" <linux-security-module@vger.kernel.org>,
	open list <linux-kernel@vger.kernel.org>
Subject: Re: [RFC PATCH 5/8] KEYS: Prevent overflow of quota in key_alloc()
Message-ID: <atZGT8y8xMCHl-aL@kernel.org>
References: <20261019142516.300040-6-jarkko@kernel.org>
 <20261019142516.300040-1-jarkko@kernel.org>
 <2610080.1792424447@warthog.procyon.org.uk>
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
In-Reply-To: <2610080.1792424447@warthog.procyon.org.uk>

On Mon, Oct 19, 2026 at 04:40:47PM +0100, David Howells wrote:
> Jarkko Sakkinen <jarkko@kernel.org> wrote:
> 
> > -	if (desclen > U16_MAX)
> 
> This should also be KEY_MAX_DESC_SIZE.
> 
> > +	if (desclen > U16_MAX || type->def_datalen > INT_MAX - desclen - 1)
> 
> That looks awkward, but I can see why you did it.
> 
> Reviewed-by: David Howells <dhowells@redhat.com>
> 

Do you mind if I do search-replace and apply these with
KEY_MAX_DESC_SIZE fixup?

Br, Jarkko
