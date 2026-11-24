Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=100.103.45.18
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1795536891;
	b=cfmWrqPM/fOk5qMs+q8/1o+N+avu7B/BcXo/kESPPTD1vNlVauCTSV6KX8dYtQOguUek
	 asZ3mf5HgLw5JGC+4QGtcJhRCBS6nVzYT2gilF6OxRBYOZOmSZ3n6TIRCGGz+hVv5YoHC
	 uy8DNMFEWgnKZ7bYbHxA757piz5BkD+CvlydNWK7rDkRJM0PeXr7RBzAzUtCAH4xSnS6U
	 IdV4pT5TXkKaIvQOjJwtg68ycLBpClTFpqJZ+R8mMsuSrOwFWM4JYtDexTb4bNK39fexu
	 TwoMdqopLQnmrxocrKvdnklzr4iEZIaEj1E2JDh8Rj35+aMnfeBJGF1LvEZw90E30ug==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1795536891;
	h=Received:DKIM-Signature:Date:From:To:Cc:Subject:Message-ID:
	 References:MIME-Version:Content-Type:Content-Disposition:In-Reply-To;
	bh=O4Ixkabx7IqK/m8U6MgzMCo2KwFEclsBsP88qoNMIuo=;
	b=C+7GtteRjln77GOzryJp/7ZI7Ti37XnP946ONwJMz8HhpTqiTYwwLPorI8Oof6TQedL1
	 bMCukJFLcB7qQVoXek7OxIAIDekrtE7hvUlE52hiyXj/7X9jbE92lUZmULy18hJbP2PVs
	 PWRlypzksWb750IYeKkrZiFMcZ2lADEPvLrM7W3Im3JyqAJ9cWO0m0hFHq2Zx62BqrAQx
	 DlUQUIAo6wk0kjvBdYCKpFSlrxelldxS8iCAMeq99LeN5Oe+XjMtLpVLfsAP8GfL+reMC
	 /gZpzxDQrFVDTW9UUgOywLTOTk2VqbkRDSURTxYkJ55BJYGTnvaRr0Mq7VPYRcYy1iQ==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dkim=pass header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=iOAOTUXB;
	arc=none smtp.remote-ip=100.103.45.18
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8791F606A31E;
	Tue, 24 Nov 2026 16:14:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=iOAOTUXB
Received: by smtp.kernel.org (Postfix) with ESMTPSA id E6E8E1F000D4;
	Tue, 24 Nov 2026 16:14:48 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1795536890;
	bh=O4Ixkabx7IqK/m8U6MgzMCo2KwFEclsBsP88qoNMIuo=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To;
	b=iOAOTUXBkMLqaoHUiyq0eAl1C7Rk4jbRf3706VOMWBnrQRVV3N+CudIqT5d9B1nti
	 RiE8RRDTwGBJp7de7au5urDelQDTpg6p83/S5FS2PoPZYSgLqKV8EJEbyQ+Oj3jZLA
	 lowb+sY7637k5QsFL20nTe3ne3EzHx6AngWSt+xcY2Fr/7HNa5CCt0JT5eYODwJQJ+
	 743FfQPraxJFT7Rxwd5VbQf3Li3VefAJcG632euh71+3PX5+j9d6gIWbsibS9w0KBx
	 bt8uChj62O/tSHZKl30Ki5y8B6ZapjmeQKoD56nY0LZkRQ7N5aE3YdEHWvk5IjJMph
	 i5+EXw/Cb0cWA==
Date: Tue, 24 Nov 2026 17:14:46 +0100
From: Christian Brauner <brauner@kernel.org>
To: Dave Hansen <dave.hansen@intel.com>
Cc: Thomas Gleixner <tglx@kernel.org>, Borislav Petkov <bp@alien8.de>, 
	Dave Hansen <dave.hansen@linux.intel.com>, x86@kernel.org, linux-kernel@vger.kernel.org, 
	stable@vger.kernel.org
Subject: Re: [PATCH] x86/shstk: don't warn when the shadow stack is freed
 twice
Message-ID: <20261124-felswand-inhaftiert-klumpen-d4beb22ea8c9@brauner>
References: <20261124-work-x86-shstk_free-v1-1-fc456c538e70@kernel.org>
 <6af82bc7-f447-4eee-b7cb-31d0a746058b@intel.com>
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
In-Reply-To: <6af82bc7-f447-4eee-b7cb-31d0a746058b@intel.com>

On Tue, Nov 24, 2026 at 07:14:52AM -0800, Dave Hansen wrote:
> On 11/24/26 00:46, Christian Brauner wrote:
> > This also fell out of my exec massage. I was unsure whether it should go
> > to sec or on the list but it's just a WARN() that we need to drop. I
> > have a reproducer if that's needed.
> 
> I think it can just go to the lists like normal.
> 
> Thanks for the patch, btw!

No problem. Fyi, It's on the list already.
