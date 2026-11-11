Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=62.72.0.81
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1794378566;
	b=QST6s3RR+UPQ6JdyTxmgAv6EJ9taDj6sY1giv1fdfs6np9AukHaI9OZWE7IO6BjwNMZv
	 HZCYkPyLqK+/cYC7sU2BNaSQa2Pu/hkEKuiosgO+KxM7N9tw7L6f+ziOwGDpPI3Ba5PRL
	 i1fc8MbhcwVUWeJpSDloUrO1AEVjacHl0/b54y2F25220zFPj5TUpuznwkJ5Nzjt07pDG
	 Rbpj9PK6m29CO0p60gacKYFAp7jl9cNWlf9upGPMg3k3l7DnqgDS5XybppxV+Teg7zzGX
	 4zNgsbutSQTXriH3R6XpVF04C+SCB0Mkq2x9V42k5eUhCM7O3iJ5zeEY/k2IVyittjw==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1794378566;
	h=DMARC-Filter:DKIM-Signature:Received:Received:Date:From:To:cc:
	 Subject:In-Reply-To:Message-ID:References:MIME-Version:Content-Type;
	bh=niTYEQ4qS3QR96qaI+UfobUPO6GzEy4z1ekWEaekeXc=;
	b=E5hz54gDnLlWOkp8ZnaSUTbZnJvCncILwUa+ixtIdetbATtqVd4M720DiXd8jsOS3iDe
	 jNy3aWrg+IvqQWlJSjq+ah74HN8aCNsi07XUpYNAhhATpxqV95NcYuIvrnGza1uufKFxg
	 L8gXNhBqlVt+rMLXKPXZpCJMPbXTv6VXQXV1xlWgmwxK5T7ALRujy0B4P7YM2+96uuPBN
	 BWM4lIDlJUqtLsH5U5O3ru9bZDIZCHKN86k8SCv/7pAKWXYnc96s4JiMI+7LV9s9qThKd
	 iKefF2/MOfBiOSKIeJVePl+YeIYYsn4/gqJjVGg72cWBYDKUES7Dy1Q5E3duvFz+Jhg==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=gentwo.org;
	spf=pass smtp.mailfrom=gentwo.org;
	dkim=pass header.d=gentwo.org header.i=@gentwo.org header.a=rsa-sha256 header.s=default header.b=Y4pnG4uk;
	arc=none smtp.remote-ip=62.72.0.81
Received: from gentwo.org (gentwo.org [62.72.0.81])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3AFE4606A320;
	Wed, 11 Nov 2026 06:29:26 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 3AFE4606A320
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=gentwo.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gentwo.org
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key, unprotected) header.d=gentwo.org header.i=@gentwo.org header.a=rsa-sha256 header.s=default header.b=Y4pnG4uk
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=gentwo.org;
	s=default; t=1794378559;
	bh=oOwENHjOONiOu9bxnAwGe/ibhroYR8nPbhZYokBmEjs=;
	h=Date:From:To:cc:Subject:In-Reply-To:References:From;
	b=Y4pnG4ukeSNFInaOm4FhDYE9+R4quPFDa83wAxgqYEVPaqSuMBFe0spj1zBFlT8bn
	 z7JT2R1SJpHMkTBpOgcoJAgQA/dTe+RtwwnPhtPVAIlkfsf+IKZaXLtx9RSaesqmB7
	 nBFf20fY4JslsdJ19/eUisYeEDkoOgKYl5y1BROE=
Received: by gentwo.org (Postfix, from userid 1007)
	id 2150C406DD; Tue, 10 Nov 2026 22:29:19 -0800 (PST)
Received: from localhost (localhost [127.0.0.1])
	by gentwo.org (Postfix) with ESMTP id 1DBCE4006C;
	Tue, 10 Nov 2026 22:29:19 -0800 (PST)
Date: Tue, 10 Nov 2026 22:29:19 -0800 (PST)
From: Shubhang <sh@gentwo.org>
To: Catalin Marinas <catalin.marinas@arm.com>
cc: Thomas Gleixner <tglx@kernel.org>, Ingo Molnar <mingo@redhat.com>, 
    Peter Zijlstra <peterz@infradead.org>, Darren Hart <dvhart@infradead.org>, 
    Davidlohr Bueso <dave@stgolabs.net>, 
    =?ISO-8859-15?Q?Andr=E9_Almeida?= <andrealmeid@igalia.com>, 
    Shuah Khan <shuah@kernel.org>, Kees Cook <kees@kernel.org>, 
    Shubhang Kaushik <shubhang@os.amperecomputing.com>, 
    "Christoph Lameter (Ampere)" <cl@gentwo.org>, 
    Andrey Konovalov <andreyknvl@gmail.com>, Will Deacon <will@kernel.org>, 
    linux-kernel@vger.kernel.org, linux-kselftest@vger.kernel.org, 
    stable@vger.kernel.org
Subject: Re: [PATCH v2] futex: Canonicalize arm64 tagged user addresses
In-Reply-To: <auxgNACRQVqTuqd3@arm.com>
Message-ID: <f658dc68-7a30-5aec-133d-7a83e2cf3c96@gentwo.org>
References: <20261030-futex-tagged-uaddr-v2-prep-v2-1-131eb7414bda@gentwo.org> <auxgNACRQVqTuqd3@arm.com>
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Post: <mailto:stable@vger.kernel.org>
List-Help: <mailto:stable+help@vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
List-Owner: <mailto:stable+owner@vger.kernel.org>
Precedence: list
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII; format=flowed

Hi Catalin,

Thanks for the review.

On Thu, 5 Nov 2026, Catalin Marinas wrote:
>
> Since this is a cc stable, I'd separate the actual fix from the
> kselftest with the latter not cc'ed to stable.
>
> Thanks.
>
> -- 
> Catalin
>

I posted v3 with the stable-targeted fix and selftest split as requested: 
https://lore.kernel.org/r/20261109-futex-tagged-uaddr-v2-prep-v3-0-3f5f2ef83138@gentwo.org

Regards,
Shubhang Kaushik
