Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=100.103.45.18
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1794406862;
	b=2k81AA/3LxXvDmGDhSOq9eRm+b6TVh0QDT8wXCLWaAWE3TAiNiwF6OzYF6qIt8eXoiy7
	 Ko0PfLXKXdlyaQ9EsnAlvx+EylvXu472H/vYMwGUZisvRxvLsvpfrNB+yA6Y4uOltIrpM
	 YspqJ2Z+26ywLR/O28Wgaf8i1Ykbb3N4cP286yofovCq6Re9Qre3+gXyKRdcs3VVV4Cbf
	 HMdgiQg2v9ruZgfXDh4EJf8Y+y/AaLF96Z7nz9XJ34IfWFId0Un37asXuxoypPRvwDMlS
	 ZPiyB+AW0nC1D0QEPHoWg7zQl1n1bHL3waxyBn0rUGTU0NbVkGTghoDWCW9iuzS9PnA==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1794406862;
	h=Received:DKIM-Signature:Date:From:To:Cc:Subject:Message-ID:
	 References:MIME-Version:Content-Type:Content-Disposition:
	 Content-Transfer-Encoding:In-Reply-To;
	bh=Zprllg4nPCi52f6KRO2S0bElXyAgA6mcaWozz8BopYo=;
	b=kiqgjlTbrll535ZHbrm1++MKqyMNQX8buAyI5P0DIPYGJv7ZSW5qh/tt19tzP/ePoDHT
	 fo6ii86/lkQs45i9DNlwcm0+7kxynkobFEMzHgRHsI0podGsgmYoeQrdYHPb8S5R/7hwx
	 6SiB4QNfJsvvtQINIobRNHGI0iMNBTgn1Bdfeutlk2q8vlSol7U42uDWpeAYFP+VYAEvP
	 G8c69ba73Nt0aMelTyO6I83EQ1wOK3NmcbQ7jZ/fo7h0LtwCHxicfO220UPGtD4Y5r0xm
	 fbiznsPsSdo5JHB3PX+s2BnE8Q+CpU4xdlnUoT9EChaLMrOQduKtbZwMtadpVfKPP+Q==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dkim=pass header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=NkvCD04A;
	arc=none smtp.remote-ip=100.103.45.18
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E5008606A324;
	Wed, 11 Nov 2026 14:21:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=NkvCD04A
Received: by smtp.kernel.org (Postfix) with ESMTPSA id E898C1F00A05;
	Wed, 11 Nov 2026 14:20:57 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1794406861;
	bh=Zprllg4nPCi52f6KRO2S0bElXyAgA6mcaWozz8BopYo=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To;
	b=NkvCD04Ak60M1qFrJy1HAiOPSeo0A1/tesB31G5t7NZZeRYSuy+1h8ayMEmUCmUQE
	 bZz5urs/EFu2GgEAJfPqxBH1Wyo1YtyMekjMKppI5U/8tYVO5p8xyMJeLqM3k9b23K
	 MWL8t7xCBO2w5qqOrSvcZsjVmCuQ4X0h/zfZIFgDkaKHkBAc3eBimllLjWI8twOJul
	 jYLeQk9LDtedigkWtEZWjFt6u1/jWj9rIB3wZUUUuSQyPJJnF47sSXa4xldo7kkvmO
	 +55/+e6LL/AbHAAjzFG9zpvKrBnBX4XETxXf/lGiboZbHy0w3ewTHU7/s+RHHy1m5x
	 ZHzTVkpl/Ewcw==
Date: Wed, 11 Nov 2026 15:20:55 +0100
From: Christian Brauner <brauner@kernel.org>
To: =?utf-8?Q?Micka=C3=ABl_Sala=C3=BCn?= <mic@digikod.net>
Cc: Josef Bacik <josef@toxicpanda.com>, Serge Hallyn <serge@hallyn.com>, 
	Paul Moore <paul@paul-moore.com>, James Morris <jmorris@namei.org>, 
	David Howells <dhowells@redhat.com>, Jarkko Sakkinen <jarkko@kernel.org>, 
	"Andrew G. Morgan" <morgan@kernel.org>, Serge Hallyn <sergeh@kernel.org>, 
	linux-security-module@vger.kernel.org, linux-kernel@vger.kernel.org, keyrings@vger.kernel.org, 
	linux-fsdevel@vger.kernel.org, Bradley Morgan <brads@mainlining.org>, stable@vger.kernel.org
Subject: Re: [PATCH] userns: Let LSMs deny the CAP_SETFCAP snapshot for
 mapping uid 0
Message-ID: <20261111-kommt-gischt-ohnedies-469998d2f219@brauner>
References: <20261110144205.2404088-1-mic@digikod.net>
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Post: <mailto:stable@vger.kernel.org>
List-Help: <mailto:stable+help@vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
List-Owner: <mailto:stable+owner@vger.kernel.org>
Precedence: list
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <20261110144205.2404088-1-mic@digikod.net>

On Tue, Nov 10, 2026 at 03:42:04PM +0100, Mickaël Salaün wrote:
> Commit db2e718a4798 ("capabilities: require CAP_SETFCAP to map uid 0")
> records in parent_could_setfcap whether the creator of a user namespace
> had CAP_SETFCAP, because a creator writing its own uid_map only has
> capabilities in the new namespace.  The snapshot uses cap_raised(), so a
> task whose LSM policy denies CAP_SETFCAP can still map uid 0 in a
> namespace it creates.
> 
> Use security_capable() against the parent namespace instead: the
> creator's credentials still belong to it at this point, so commoncap
> returns the same result, and only LSM denials are added.
> 
> Do not audit this check: creating a user namespace does not use
> CAP_SETFCAP, and most namespaces never map uid 0.  The uid_map write
> that later fails has no LSM audit record.
> 
> Checking CAP_SETFCAP when the map is written would not work: the
> writer's credentials then belong to the new namespace, where commoncap
> grants the creator all capabilities.
> 
> Cc: Christian Brauner <brauner@kernel.org>
> Cc: Josef Bacik <josef@toxicpanda.com>
> Cc: Paul Moore <paul@paul-moore.com>
> Cc: Serge Hallyn <serge@hallyn.com>
> Cc: stable@vger.kernel.org
> Fixes: db2e718a4798 ("capabilities: require CAP_SETFCAP to map uid 0")
> Signed-off-by: Mickaël Salaün <mic@digikod.net>
> ---

This seems fine but is another instance where what we really really
really want is for the LSM to be informed where exactly
security_capable() is called from. IOW, it would be nice if the LSM
would know that it is called from the user namespace creation path.

Can be a follow-up but would be nice.
