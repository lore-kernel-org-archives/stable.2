Authentication-Results: smtp.subspace.kernel.org; arc=pass header.oldest-pass=0 smtp.remote-ip=74.125.231.192
ARC-Seal: i=2; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=pass;
	t=1793817524;
	b=tulfjOC33Uuk/BAR2mCFC1ZW5Nsn3JR+T8KiSYcz+VnM+f6ZOd5Xj3dBwjjK9U5okdlZ
	 cEkP27748/jk12JaTbUe20Hnyt+yvkPD4eCN/PRhrV7wuD9QyjlD2mrVlWQs2PfVhqEcp
	 vpOPEERYaQ97eTzbUmnQGRyi/mJebLFa5zPsJbgQW73H2xgH27uK80+sFdh+QfF1rOEvL
	 k3BY0Y052lC0G6JCob6iCz34FudEVDQ6nBR3lw54qR0iFifOVDmVanybaiPgwmZYR2Tr1
	 5HAdnn9LCPN6tgQxKx6P8J60HgM7S4IG1PCbir/qO2qf95WZF4LUeZaMTPppqrpgCgQ==
ARC-Message-Signature: i=2; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1793817524;
	h=DMARC-Filter:Received:DKIM-Signature:X-Google-DKIM-Signature:
	 X-Forwarded-Encrypted:X-Gm-Message-State:X-Gm-Gg:X-Received:
	 MIME-Version:References:In-Reply-To:From:Date:X-Gm-Features:
	 Message-ID:Subject:To:Cc:Content-Type;
	bh=xi2CTq0sctSpk2rBheKo6Pp4BrAIpJ2VTsphU+x+0aE=;
	b=lO7sKiI/BPnzmSjROvC1vKHqDQMGAztvW6p4Wh1PIkDQAik1phfSLDQ8dKaCpmz7Q5RR
	 u/rECK1GUODgs5XDyCFjjhHbsAOxBbvPt+TWBYEOyPLRZq1ltOIdML5jBOAvF7Bb42QpA
	 9FcjAgZdSLCqgz3pd4WObq0hNjRjMgNMM6iv6BAeJnLYYOHuWXAhfrcJPpYAMMYql+AuY
	 dGT+yXCQKooPR7tyZ/O9czeKQYjcXWBv51t9kGiyWEYpYaFwm+12BynID+E2AP0w5rWK3
	 VDveTybugdG2QqxqrduoISCLbA3uR/TtoEg37TYuAC/5QMhCV7m+07Vrh67/lyIkk4Q==
ARC-Authentication-Results: i=2; smtp.subspace.kernel.org; 
	dmarc=pass header.from=gmail.com;
	spf=pass smtp.mailfrom=gmail.com;
	dkim=pass header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20260707 header.b=Ml7tXF+s;
	arc=pass header.oldest-pass=0 smtp.remote-ip=74.125.231.192
Received: from mail-oi2-f0.google.com (mail-oi2-f0.google.com [74.125.231.192])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 25B94606D83F
	for <stable@vger.kernel.org>; Wed,  4 Nov 2026 18:38:44 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 25B94606D83F
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20260707 header.b=Ml7tXF+s
Received: by mail-oi2-f0.google.com with SMTP id 5614622812f47-533fe730856so454494b6e.1
        for <stable@vger.kernel.org>; Wed, 04 Nov 2026 10:38:43 -0800 (PST)
ARC-Seal: i=1; a=rsa-sha256; t=1793817523; cv=none;
        d=google.com; s=arc-20260327;
        b=pK4uraMJim1DPXvaFxIUJKUYsjbF68XwkEpD28mSm782lqP/kdlaTvvAGiBxQTVwzb
         PwTzwOM/fLKuvGRbBRjo8kZzV3vSKx2YXmj67kD5+G4/8PFZuRAjmnYsQPy85T4L1hSB
         Ep+7sDdP0KLAklxaYpz+NHziBthIvzrLtUb3+h5sOG3qGX4QJ660/BA4u0qJfrYEFfQw
         e9IIwEW9db4anJFFKxbGOP9X3Ib+pAewwR3MFJjURnpCrfuN/fP0MacQEwYbAvUDL3iX
         6n9GISPoa/AVO6Lny0f/Ng3RovVSsFX3X/ZWyp4fSBBDQRwxqKLqQ6rumbSuLOyJJj/v
         e/xA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20260327;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:dkim-signature;
        bh=xi2CTq0sctSpk2rBheKo6Pp4BrAIpJ2VTsphU+x+0aE=;
        fh=GtzhohksprSf/qvdXm6NssWEuZWj1xXUfKIOcg3W50g=;
        b=chLDVEWGizFVkNb6QRpgC3l+vooDg5+Vc4Yqu0Z/kNCGQyKiwlZB6N1H+nu9mAHoO2
         pqY+rjPGI82RBuFp3m9Bfxxh/vyz2/vVFBGPKR+jkfhzKPFBezwggAFPRMd2NSHM40lU
         ZjmXJbZDZI3G3AaOqNQnncIXhxJSL40G9zA6b2dnnbmNthaUCN4Sy1jAKYF1vBO2Jwhb
         AuYl4HgqRPsgoc1VEmlh79JJtX7yyZ5IQbPKd7JP1PNb0yeN+QZLFp5f5k0msuDjEyG6
         IU2TipgLs13u8h4zd33qQ2Jwk80FyNnhGsW8ewIyCuzptDuv+DkzEDv2PM9FlM+Adz8u
         Ycbg==;
        darn=vger.kernel.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20260707; t=1793817523; x=1794422323; darn=vger.kernel.org;
        h=content-type:cc:to:subject:message-id:date:from:in-reply-to
         :references:mime-version:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=xi2CTq0sctSpk2rBheKo6Pp4BrAIpJ2VTsphU+x+0aE=;
        b=Ml7tXF+sVZvkpHkBr8/idNrFKfyY8PoYXpBJtAvho4ovbfG5zcGskW8/ivtnErEmZe
         NkBxWzblx8wNCyDPxt5bwvZNz0Ix0TeSzUiejal58hT/OCM0hTnBVHmyZjcRMYPmNmho
         zTL/Rv8Mh5U89IFQXczgPMALZMMUr6ldEXR2xtQqOAgydoaNpvagj3Qxr5s1pyPfYgNX
         DMrdh+xY5CDGQIkrgBb6bMsNunx3wZBuAobc7xPuzMDPob2V6QSE866W6c6l7PPx4YOM
         HCDDxzXAzWhgiwUXwpr6jeSVeyxGZohqp6bnZ7dLS/MHAq2jA92b6iDFM6DfoWjo0cOx
         MH9g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1793817523; x=1794422323;
        h=content-type:cc:to:subject:message-id:date:from:in-reply-to
         :references:mime-version:x-gm-gg:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to:content-type;
        bh=xi2CTq0sctSpk2rBheKo6Pp4BrAIpJ2VTsphU+x+0aE=;
        b=igPIic3wMtwwqLcqXF7M8rGKAFHC3JnZCyhln/MRIA4uDD65QqrkTvfODUkEMCRZa3
         JJvQF4vMVbKFuI11lpDsBoPZz95JPC23T12Q3zn2ZyJtgRv/VK77DxoVwdKkc3pz9i7m
         OYHjzwSlqvZCo6dcCOhAIgo/JhdKrp0coWsn4ReEAVUdQ4Af1K+9qQ8Y5wwc/FmoVUjV
         GXEGHcd9rQ6EipOOiR6b5fMd/ZiNNs9TQ1cFJZ1v+9qba/f6z89RdXzo0/DgKeajtGlZ
         pV8dmcAuLOhn1GN+rdGfm0yDC437e9GtctYD7yn/U2OsPqxH9ugEXE6P8z4PoByYaFPH
         Is0A==
X-Forwarded-Encrypted: i=1; AKwUvBzZNAIP6Ki7rOThtoEl7SxQgfjXu6Nfb6SYSfJ7YTLX20A+C2m1W5NcKOyx3GwiYnxgPxh8mxU=@vger.kernel.org
X-Gm-Message-State: APuU4Z8c9MIVo/ydQguflFGhXcDAfg3IaOMWAUSsT2T4UBUIDa56JmDK
	mW6vhBnzgu4mduxnprIuYKBWOoTFnF+3ZxcRXftoWpxUew+U62lLfFDaOSoFDvTWwUEjr33bGY3
	HLjzRXgKXQMb5wneilTSY0R2vsn3fXms=
X-Gm-Gg: AYBFou2v77mHMCDjk5iN156yrANxTvDiHikguUOBzydRxxGlGdFLLA+o2BwNg3eAlvY
	oUyaOHRPiVv+affOV20Q0QixDh1DCu8mrQ+kQywIWHoK3HlV/FHkXUu/44UTFfGQXQ5ttPMHdk0
	hpChLpOqa6csmtpXBynlXRev+o1gJxAgP8r3XRHwOyfG6HB2+0kiOwB5TK5AyKZqMcXlrzZNxgX
	83c0PIN6K0AeYGuDGb1SYaDzO6FcAa1jTEp3DBuwkimdLn+to5w0AG2QyB0zOzzIBwBlGjqVDJe
	P+srFHpTTXs7zxYmGhFic6Fj3c4fk/aWUWgkdd3lYBC6GLuLEftmzgG1+Eho6gZetaC4KPnTV/t
	LhxFReaprwDnS1EElJDcNHEk/revIm2fm/CEPQyv4ohYfLm11PAua75dJqbpwNzFrLzeyoNG9gz
	zK+eJZGo/2vVjdADfdIDO/SsvNPlYlzWNHhZS5IcHD7Ju0CNvtXwhY
X-Received: by 2002:a05:6808:1209:b0:4d5:295c:a82f with SMTP id
 5614622812f47-5640df1c57dmr11547296b6e.60.1793817523087; Wed, 04 Nov 2026
 10:38:43 -0800 (PST)
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Post: <mailto:stable@vger.kernel.org>
List-Help: <mailto:stable+help@vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
List-Owner: <mailto:stable+owner@vger.kernel.org>
Precedence: list
MIME-Version: 1.0
References: <20261029013616.97194-1-dennylin0707@gmail.com> <jnqgrofg5eh4rvmpqr3wrhyimlux2cwtguj2o5d3tjzdaqq6nc@xsxxjpzmpomu>
In-Reply-To: <jnqgrofg5eh4rvmpqr3wrhyimlux2cwtguj2o5d3tjzdaqq6nc@xsxxjpzmpomu>
From: Hungyu Lin <dennylin0707@gmail.com>
Date: Wed, 4 Nov 2026 10:38:32 -0800
X-Gm-Features: AclHuK-r_3WJ0ntTj1FvPXP3r8tt_m6iclxJZOkDMnSvHN7BvKNtxEkMKUL6peE
Message-ID: <CAGEkeHeBgeDM5_+ncjKspqEOw0CnVBsb5GJYdbQ+rUJ-W3ht8g@mail.gmail.com>
Subject: Re: [PATCH] ext2: preserve IOMAP_F_DIRTY for extending direct writes
To: Jan Kara <jack@suse.cz>
Cc: jack@suse.com, ritesh.list@gmail.com, linux-ext4@vger.kernel.org, 
	linux-kernel@vger.kernel.org, stable@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"

On Wed, Nov 4, 2026 at 4:44 AM Jan Kara <jack@suse.cz> wrote:
> Thanks for the fix. I've just move the setting of the IOMAP_F_DIRTY bit
> instead of moving the initialization. Functionally this is equivalent and
> the iomap modification is better localized that way (the resulting patch is
> attached).

Thanks for the adjustment! That looks good to me.

Hungyu
