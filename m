Received: from mail-pl1-f180.google.com (mail-pl1-f180.google.com [209.85.214.180])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id EEF5F582B95
	for <stable@vger.kernel.org>; Fri, 16 Oct 2026 17:35:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.180
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1792172134; cv=none; b=BfjHxdyV5Ce97kvB8QIWqxNl5IJb/LM6bbjspPxs2tVUEfmNqaoy+/AOJNm8u1bsW2ZuIbWv4k5MRRXTavP5TYrLV/82YjopWzMbQHvSMmbvu09d6FqyF65ePAwNljCxLQgkyyXEBu1wtAJKn/tmPyZdrBBFJseTjNjoz6H7AI4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1792172134; c=relaxed/simple;
	bh=az/gOF/w5yeRnvJt7UcidmaKTmnG+RAjYemUPKaOJnQ=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=ExOueFJuqzcSVPrjNTp93P1n9so0QA26mDt6sSVWeLoQWKqjWuB0uvGiFa835QZ3E2uLF47tpaC5F3rJ2b0VSUbJMkOm2IuPt+ki/FENzc/n+7YgX3Gk3pnB3wVmJamDWKRqfh75wkC4phx+NzreQwAgFHh+TzYvbOYVinsGQPY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=H9wxoEOp; arc=none smtp.client-ip=209.85.214.180
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=google.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="H9wxoEOp"
Received: by mail-pl1-f180.google.com with SMTP id d9443c01a7336-2e8da6ef7ddso396535ad.3
        for <stable@vger.kernel.org>; Fri, 16 Oct 2026 10:35:32 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20251104; t=1792172132; x=1792776932; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:content-type:mime-version
         :references:message-id:subject:cc:to:from:date:from:to:cc:subject
         :date:message-id:reply-to:content-type;
        bh=cohS5KPUJ2GkeIniZLg5yBu1tNFxae8UdmbhqHbdHdc=;
        b=H9wxoEOpQFS1iMuzwe7jXFREKLwRGoYbee+vKAcmMdVCr6XFL4qTzLlG76tB+oJfPl
         dC3qONlWpgZxcxg9dFznIiP4vLPlwYBmbkLPCZt2OBiMbZWu9FbIGIGe8IJdSJEkv/al
         HKmCzX1shr+GWMb7zfU4pqyRFM9YZv4Uoa7r7UMV7hWgnnhkRNXxGBvrRq0UFJs7Tzpw
         Uz6YtfPrBOPWO1gnCdvXEYESgSvW+dngegFftF6FMRfeQwQLAStuGHKV1qhFWjRIbLqP
         uY+1P3oY3MN84B0DgT5bvqgRy20sf86ZHxDUT9pJh9D4aDFfBdEgtCRKL1AFzu6GW30A
         jLEQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1792172132; x=1792776932;
        h=in-reply-to:content-disposition:content-type:mime-version
         :references:message-id:subject:cc:to:from:date:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=cohS5KPUJ2GkeIniZLg5yBu1tNFxae8UdmbhqHbdHdc=;
        b=C4961dfm/d1/qmU/nK+yzCGK0yNcrHKESX+nsxgo1+dIdORHCigc6NxhULjpfW/EFf
         BITUAWaRTZOsyoBOcyYAasAyll50goKrTTREIwidgsM+d81LbWTJohDfnsZD43uiv74s
         kL2y6u4nnWi3pPA+Fsregd2Lv9/NcJ0w4oo7HFhphNDAKvC5eqtIsK01XMZV9STViEmX
         w6vt3EdjxKLkTnXJIAhwJcF1VBeaLjJ0UvB1yEq6rbkxxa5egCv4VmD1/vio1HcYEPT1
         W7ypgO3C+NNcgxCUx0r8izgI0dHhma2S/F8QTIvEyK+KUTlLLTdZNnO1my0IUzW2Fq6y
         /MWg==
X-Gm-Message-State: AFq9FYKljCTFrYJBtcj+m3aPfK3ThaNWw9d5KooDkgLb3oyDZzlJzK39
	mdJ4udwj3+917H90x9HFiQTgZ8XUI7AfqATpYRFoKPlliDQZOOFqD81x9yFNFjK5YKF4sflr9Jo
	C4aq4/g==
X-Gm-Gg: AYBFou0GymeHRTN8/zVszI4mFQAIgvqxwMHCXqAPeCBF0vAR5fLvj10nOVs6d5xi2yD
	9Smg99jdEBSs6200uKDijA7BdTCuodcIgeednAAwCjoWOBNM1AQyYLKnkndBfNlvgDKQ8eYPcp5
	e3/IY/2W37mN0FU0RXrWAHNQoktzI0ez5/54kYLvRPO4NaG+bN6FQHh6Q3Fl5GS07y28GfbDroC
	KmNdKMCuMEyXfOno4yxjKIhTd0D5pcriFFebKr3TAmkKd0wBZ7uqhEWcBM6fJOflmyMs4bPDKzn
	RtgQ1DsaYw9hypr2UCRIlCn/rlSotHv/j/5gTNcEN0EvShE2PDCkTkxWObCs9D4QRU8st9v5LWw
	5scpP1VzfipShQcSeUoF8qFLrPTWkKBtr3JJecNl569avnVIoKRWHhzOZnfJkXfMuZIafC5tLqq
	n3NIso8cRdMw0shgUlheJYSH7N0oiVXA/Ngec8Sel1T/+D2sWG+gCBarMLF9ofE3ZCoG6k4T607
	lt+Gd1cKJ3wJd0JTSu1Y73nimt+dnN1/bb0pkdd
X-Received: by 2002:a17:902:db09:b0:2e6:943:39de with SMTP id d9443c01a7336-2e9a6d26461mr5962425ad.30.1792172131142;
        Fri, 16 Oct 2026 10:35:31 -0700 (PDT)
Received: from google.com (248.182.125.34.bc.googleusercontent.com. [34.125.182.248])
        by smtp.gmail.com with ESMTPSA id d9443c01a7336-2e97e8997edsm14024145ad.63.2026.10.16.10.35.29
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 16 Oct 2026 10:35:30 -0700 (PDT)
Date: Fri, 16 Oct 2026 17:35:26 +0000
From: Eric Biggers <ebiggers@google.com>
To: stable@vger.kernel.org
Cc: stable-commits@vger.kernel.org, Jaegeuk Kim <jaegeuk@kernel.org>,
	Chao Yu <chao@kernel.org>, linux-f2fs-devel@lists.sourceforge.net
Subject: Re: Patch "f2fs: move release of block devices to after
 kill_block_super()" has been added to the 6.6-stable tree
Message-ID: <20261016173526.GB122880@google.com>
References: <20261016172401.4002976-1-sashal@kernel.org>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20261016172401.4002976-1-sashal@kernel.org>

[+Cc linux-f2fs-devel@lists.sourceforge.net]

On Fri, Oct 16, 2026 at 01:24:01PM -0400, Sasha Levin wrote:
> This is a note to let you know that I've just added the patch titled
> 
>     f2fs: move release of block devices to after kill_block_super()
> 
> to the 6.6-stable tree which can be found at:
>     http://www.kernel.org/git/?p=linux/kernel/git/stable/stable-queue.git;a=summary
> 
> The filename of the patch is:
>      f2fs-move-release-of-block-devices-to-after-kill_blo.patch
> and it can be found in the queue-6.6 subdirectory.
> 
> If you, or anyone else, feels it should not be added to the stable tree,
> please let <stable@vger.kernel.org> know about it.

Not a clean cherry-pick, missing follow-on fix, and not Cc'ed to mailing
list.  Nack.

- Eric
