Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=100.103.45.18
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1792531093;
	b=FAjyYZFBtyJo6x6tBN2QZas2eLIX/UhifZYXMKq4r+mAGH6TVJjpyiSEnXI8REZz+DSs
	 j6L0FpZo9UZF1U/uGC20QAp+j6DS0PQJ4pmUMhihVR45O/yj6R84Jc2nBTibslPzB5ePt
	 dryOTzlJ5GCsXbfNS+aHLqUIbOu0wdQZXFifu1lJOcmfYrxeHqX9k0UNkKKg3fE0AELfk
	 ADmPTmhpl5KT6bcFgei5NJFu46AO6Bz/mRFW/mJD6VEy1OmuQhx4XYLyIyEm0D5+VsIcW
	 yYDzF+wwJyy8G5dOEzsrAwLn6zRvseKZscsVeaWG9ohzXdMyhTkoIcLHn/aUnxF/HgQ==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1792531093;
	h=Received:DKIM-Signature:Date:From:To:Cc:Subject:Message-ID:
	 References:MIME-Version:Content-Type:Content-Disposition:In-Reply-To;
	bh=5hULH4ZYM3z8m89zFG1L2yglAfij0m6F6HFugGAhj2k=;
	b=WPiAqNQJxe/m7n+CRpMhvLZ+EFTihALM7W6niqQX9yS+QjEFALijH1a2GsiHXmCFf9xr
	 AnV/Tl48ae4KGoxjEblLEv+f/n4fakOhlnjeNMLOzUmLWWP1r0g1cN75GPjSNC7WFvyzF
	 X/nzPvHN3H7+K5IwSUypnpW5O84IKplfK+Pex356PKrC+g2C29Dj+4tAdMvt4eA3ntj54
	 6xqRUPITBY6s7DV0KrjA5SoWxjuVc9AAwb6KudpUa+ikPRFFofshL8KvKqTrpVVy/ZIAL
	 X0cZ0/a551Si7TQomTtCrooJbPdmyJFz8n+VxUpydfv9Q2OB9WSAkYjPQ9sz/W1GyKQ==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dkim=pass header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=l3EHb6GX;
	arc=none smtp.remote-ip=100.103.45.18
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with UTF8SMTPS id 1131A606A319;
	Tue, 20 Oct 2026 21:18:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=l3EHb6GX
Received: by smtp.kernel.org (Postfix) with UTF8SMTPSA id 4AF4F1F000C9;
	Tue, 20 Oct 2026 21:18:12 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1792531092;
	bh=5hULH4ZYM3z8m89zFG1L2yglAfij0m6F6HFugGAhj2k=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To;
	b=l3EHb6GXPworRXK/QJWPCIDNpfqIZJBnrYp7omtWXt6ta1vXHKnJgOib1PSbgaOSh
	 DVfRNMLJNwr7NVTDnQkz2E/itNwAudYSKFxNqufsNweeMiNxKM25dxDyFTEJbfKMJq
	 JHkS6H6Gju4w0N+gJ+glNWJxhf3DxFTC+2MYtzEAJXMMfYsB3kyCaEyDcx0Tl18niF
	 92CkNsYXQgatnAb4kRDwBYQwonduAELT9A9uBjN/r01DKWFf+C9TUyLlw2limpWGlb
	 ZqXl1SbdJ5EOun37qa/D0+/g558fR8K2cV3AS//+Z/3tzB3a3Ft37YjSP5KHQbq8jJ
	 HeAjL/Bi+h9sA==
Date: Wed, 21 Oct 2026 00:18:09 +0300
From: Jarkko Sakkinen <jarkko@kernel.org>
To: David Howells <dhowells@redhat.com>
Cc: keyrings@vger.kernel.org, Eric Biggers <ebiggers@kernel.org>,
	stable@vger.kernel.org, Paul Moore <paul@paul-moore.com>,
	James Morris <jmorris@namei.org>,
	"Serge E. Hallyn" <serge@hallyn.com>,
	open list <linux-kernel@vger.kernel.org>,
	"open list:SECURITY SUBSYSTEM" <linux-security-module@vger.kernel.org>
Subject: Re: [PATCH v4 2/3] KEYS: Reject descriptions larger than
 KEY_MAX_DESC_SIZE
Message-ID: <atfakaH2Gwm2FtXF@kernel.org>
References: <20261020174325.2229448-1-jarkko@kernel.org>
 <20261020174325.2229448-3-jarkko@kernel.org>
 <atfaI1d3heLgX5jE@kernel.org>
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
In-Reply-To: <atfaI1d3heLgX5jE@kernel.org>

On Wed, Oct 21, 2026 at 12:16:23AM +0300, Jarkko Sakkinen wrote:
> On Tue, Oct 20, 2026 at 08:43:20PM +0300, Jarkko Sakkinen wrote:
> 
> There is only case in key_alloc() where index_key.desc_len is not set:
> 
> 	desclen = strlen(desc);
> 	if (desclen >= KEY_MAX_DESC_SIZE)
> 		goto error;
> 
> 
> Other sites match to:
> 
> 	static int keyring_index_key_set_desc(void *desc, int desclen)
 	static inline int keyring_index_key_set_desc(struct keyring_index_key *index_key, void *desc, int desclen)
> 	{
> 		desclen = strlen(index_key.description);
> 		if (desclen >= KEY_MAX_DESC_SIZE) {
> 			return -EINVAL;
> 		}
> 		index_key->desc_len = desclen;

		return 0;
> 	}	


Br, Jarkko
