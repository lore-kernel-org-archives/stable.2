Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=100.103.45.18
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1793384297;
	b=Ghvv7Skl5gE9RzPsOrt53mCkh426sNPQ75qP2Qrgzck+f5cO4DHoM2mRWmptvAM6EPnH
	 AR3gnZYlWLSYjbCZBoyS5lZfxMZR7hvITaA5+J9HeXgtQhseJQXJKfRPyikfHdVxcB8Qs
	 f56splUjo9UIaeUpLUPAN2j/6GSIZDbImCYlEEcJXqyBarYoDgnbPeWMDJKHHYsVXjIRf
	 ydO0thvUpClfGZCOjbh1AzqCyCWTSbbr7uDYt7JjY5YmD12MJn1VtN+MooTwKTlYms8o3
	 JTuB80zsI5EcuGmVr594G4usKsNJf0Tiki5JAgq/HinXxnJL7/8rX6RORuaKNVYtxOg==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1793384297;
	h=Received:DKIM-Signature:Date:From:To:Cc:Subject:Message-ID:
	 References:MIME-Version:Content-Type:Content-Disposition:In-Reply-To;
	bh=0oJND6e7p/41BF94Xli4Q3w1gwBLk8Sl1xYufIRgeVw=;
	b=w8k93rJTguN7gZ1zsI9iN4Sw20uS5kcSZq4GU52j4jomcoNQOWnvpY8Jz+1ECOTbrwwB
	 m77p6ulPYspongnI7VnllwDNJlwj3cwO8f5//pb6pGk03AOctAxHaGsIFPi17JAbFFr+h
	 h2etc3Db8TIy9Zt6okJm1gKNd6OVjoEitlftv4N80/+VegX4ZfdT3jt7M5HudXSZ2ls7p
	 dMRGKbFsrgZhPjD1vqO2dt3TF1FcFyj4A5bAL6dzku3Y4svfbAAest5p72c7QNSYu2hpt
	 uZmkMFSjlhmxJLaSXgJDTLOTkQyUAQCohYdC2MoX2ZYeFt2u6doUtK9H0Hb5I+yuquA==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dkim=pass header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=ZM7bRbW1;
	arc=none smtp.remote-ip=100.103.45.18
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with UTF8SMTPS id E4150606A31C;
	Fri, 30 Oct 2026 18:18:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=ZM7bRbW1
Received: by smtp.kernel.org (Postfix) with UTF8SMTPSA id DBF571F000C1;
	Fri, 30 Oct 2026 18:18:15 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1793384296;
	bh=0oJND6e7p/41BF94Xli4Q3w1gwBLk8Sl1xYufIRgeVw=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To;
	b=ZM7bRbW1rIAhx89d7oAG7MOv2oBHD2jsurHIdrLr7DkrPtO/S2JU/nK6I1aITh1YG
	 dAtqFtAD5tMivuMd+5kG6hkv9usgsOqHijCTpp+LX/2OsiF+F4iVjE/ztA9eScl/cs
	 AO5Emb1HOxQj1V/0XIBZopCIIW+U26yDjjtSbPeuj40nOPF0rlJ+Lg16HYDPD7eMhK
	 fMQkuXxH6CcstR5kklPxzp0N/d/MVRaIv52DaNwkXFDSNP+kqfVncFFXYGD+Pi7eYL
	 0JctbfttZ9ainuCvEZe8StrIyKmgB4wPXxfYN9ek09+RqPyEP3vVqIOq9Vxy/LEv/F
	 /6JvhEpTAO9CQ==
Date: Fri, 30 Oct 2026 20:18:12 +0200
From: Jarkko Sakkinen <jarkko@kernel.org>
To: Anvik Loitongbam <permissiontogallop@gmail.com>
Cc: keyrings@vger.kernel.org, David Howells <dhowells@redhat.com>,
	linux-security-module@vger.kernel.org, linux-kernel@vger.kernel.org,
	stable@vger.kernel.org
Subject: Re: [PATCH] KEYS: request_key: enforce keyring restrictions on
 constructed keys
Message-ID: <auTfZL8RjQqT8uiW@kernel.org>
References: <20261030173930.40948-1-permissiontogallop@gmail.com>
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
In-Reply-To: <20261030173930.40948-1-permissiontogallop@gmail.com>

On Fri, Oct 30, 2026 at 11:09:30PM +0530, Anvik Loitongbam wrote:
> construct_alloc_key() pre-links a newly allocated key into the destination
> keyring with __key_link(), bypassing __key_link_check_restriction(). If
> the request-key helper instantiates the key with ringid 0 (or any keyring
> other than the restricted destination), the key becomes positive while the
> provisional link in a restricted keyring remains, so the restriction never
> sees the payload, potentially resulting in a policy violation, where a
> user with write access can inject keys which are restricted on the restricted
> keyring.

What does "key becoming positive" mean here broken down?

Also I have really hard time on reading the second paragrah as it is,
let me count, over five lines long. I honestly cannot say that I
understood what I read. I tried it three times.

If you understand your fix, you should be able to nail it.

> 
> Restricted destinations lose the provisional-link deduplication while the
> key is being constructed. Callers that pass
> KEY_ALLOC_BYPASS_RESTRICTION keep the existing provisional-link behavior.

The second paragraph should be reformatted and there is no rationale
or descriptio for the code change.

Br, Jarkko
