Received: from mail-lf2-f12.google.com (mail-lf2-f12.google.com [74.125.229.204])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B7D7824886A
	for <stable@vger.kernel.org>; Thu, 17 Sep 2026 15:03:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=74.125.229.204
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1789657406; cv=none; b=piS8aqov3tUxi+KoXx26CcOGr8GNgxuzW/44VIh75c0PokJ+W/DsMfLDXB9RA2w8gjgPiBjv+PaPE0BBQ6kKk+iUyHn8lTVeN3lUnNs0/5SI6QzkaZQ7u5+qkMZF2BYV6YIXrJ94qNHSc3cpgI0RSIcjAAfRxs+QeOPjPgcFSE4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1789657406; c=relaxed/simple;
	bh=v8TIQr+q1avK5K0cxXPV+I4INTDPrErrKq17EaY7bGI=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=QaCutPB0TIkX9ANtk9oA6lOElrT5VtmlDIr+rGjstfnIH6Uy2eJE+i/1gEZ5i4bW14eUM4AOk2kdqy+W0hBeq7ILIfnDaW9BXuMz1TXbTcvc+ioqZvSMzfPFWpft5nkNjGbxCDAeGOEs+fpAOMBS2T+vNTEZADP2dTOv0OziRh0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=FlwCsd7M; arc=none smtp.client-ip=74.125.229.204
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="FlwCsd7M"
Received: by mail-lf2-f12.google.com with SMTP id 2adb3069b0e04-5b5e4f1b846so1190903e87.0
        for <stable@vger.kernel.org>; Thu, 17 Sep 2026 08:03:21 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1789657397; x=1790262197; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:content-type:mime-version
         :references:message-id:subject:cc:to:from:date:from:to:cc:subject
         :date:message-id:reply-to:content-type;
        bh=AvQ95HVkZu+0oz5n/XboAcTGYSXdTRCXA3Bat1fmPR8=;
        b=FlwCsd7M5C0BEFxTJFsWbRmx655fiLCSqVkpyrjQWKsjEIYQJOGOXa0SVLQKsTWoAG
         PYlsO3IkMzfOXYm0GnxpUhzr7zXDlwRtp9Ngt1oK92rVzFGaz6EE5CsL3e7i7xq5xvam
         QVSSpyGm6otxbUB7e4V/bDTjQH9Mvk5i8mwOWr3fMyz7kmFiYGjRhVnwrkvolsvPCrDH
         anwWz2B/qpJWhKd+0gF7uUpqZPn2jUdPLvUI+Qz0Zst7VYOB4Dh1xZnBtE5peJiaOD1Q
         Wswq49FuzRKpGrncQoF4WK1xB0ggyC2aWyQjFa6TJ/bKsxOnWwwsnZQnJm7Q/I4+dsGX
         P0Pg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1789657397; x=1790262197;
        h=in-reply-to:content-disposition:content-type:mime-version
         :references:message-id:subject:cc:to:from:date:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=AvQ95HVkZu+0oz5n/XboAcTGYSXdTRCXA3Bat1fmPR8=;
        b=XQtBKqvu3oboHdSxX4bOvgPRAZs+YAUGZ0EQPbEoc5noYZAzmsRGGy1xZ1O3Ag58kD
         PhYCTBG4/moDVWIANEyGPL5tDr+bRDJEkONNBnAjn8KIYdFkIUl6CP1bLk06HdwQ6uup
         HmPUdFaBtxXkZJA+MDOfOnIRsa7AtxnDFgDS9ohur/q0b9gLrhKkgywCQZ7na7e+35xt
         yiL8SjkR1b9eILgtBXP0UzB8tIRkr3YL5vWP5QbIdz6MnuY5p3e2KJ0bEWxcg72rscU4
         b+nnHNpk9qDFkBkPKw6lwDaZDWIKyAW8MrotR6mqMuopnwqpJtxoNub2P5qUnfgcL9xY
         Asvw==
X-Forwarded-Encrypted: i=1; AKwUvBz1IDY9GPdriKS0dedJForMvfHgvnZvCtxb5w0EXQNkGTsihO64sJE89pbQefmJIScQDPLlKDc=@vger.kernel.org
X-Gm-Message-State: AFuF++mI7PsZGFZWAXJmnkqIE/77d4vP8+XonOLF407ZKBjMeGcGYzdd
	YBw1R++qJLYC+y2alLelwd9BRArQFLgglFGFp7H2B17TGKroMVn33Gjn
X-Gm-Gg: AYBFou3uo5d60nr+VVSwm0vgGWY40T6XaXEm7D3M9mnlnG4gJU3KIELw47DoeiBGUQy
	REd/dirX4vbKJ5wSOpAzv7KSsc2wV1QTRAUl6e3eHfjBi82Iw1pqF2nEngJcKHDNyNK1ERLh32L
	wmNtYFXQW6/Pb9hys+i+jFs5y36h8Xz5NlCIcz6nHEWYxJoWV3mg8SD4vPsNVKQpgLvwiqB/9QN
	M+NlWGQ4vxaQoV1eqDBwMGQBcb74dHzAdnl62q1IR4NHXMofXJAAtmtx0Iyv6B0geqOL43RMNoW
	k2AXWl4wXa7cE9kB3vs1qjMvh6lDyut/CW7GZ8vF1DlmKhpdF1JjO2KE1oTSQIlJmi3ykLgRjS8
	RCCSRMP1sr/zVkg/Jt1MaxQUe4CSe6cJvDl5AGU5IF0aeY1K96lcPLkZG7zC12tVw4uUO7H+Qt1
	O0wqo8+KXm7JZC8jo9K/nQyxSTuFT4RyKtmTuMjkU/ZhTL/3Q418mxMFS2P3QxjdWl8nMeaV3P4
	qCKoaR+mqp+rHlHqw==
X-Received: by 2002:ac2:51ca:0:b0:5b6:1a7c:aa1c with SMTP id 2adb3069b0e04-5b8b664e438mr2177419e87.52.1789657397222;
        Thu, 17 Sep 2026 08:03:17 -0700 (PDT)
Received: from rigel (194-223-74-160.tpgi.com.au. [194.223.74.160])
        by smtp.gmail.com with ESMTPSA id 2adb3069b0e04-5b8b57897dfsm1951402e87.3.2026.09.17.08.03.10
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 17 Sep 2026 08:03:16 -0700 (PDT)
Date: Thu, 17 Sep 2026 23:03:06 +0800
From: Kent Gibson <warthog618@gmail.com>
To: Bartosz Golaszewski <bartosz.golaszewski@oss.qualcomm.com>
Cc: Bartosz Golaszewski <brgl@kernel.org>,
	Linus Walleij <linusw@kernel.org>,
	Andy Shevchenko <andriy.shevchenko@linux.intel.com>,
	linux-gpio@vger.kernel.org, linux-kernel@vger.kernel.org,
	stable@vger.kernel.org, Sashiko <sashiko-bot@kernel.org>
Subject: Re: [PATCH] gpio: cdev: fix kernel stack leak to user-space in error
 path
Message-ID: <20260917150306.GA131235@rigel>
References: <20260917-gpio-cdev-stack-leak-fixes-v1-1-2bb52879e49c@oss.qualcomm.com>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20260917-gpio-cdev-stack-leak-fixes-v1-1-2bb52879e49c@oss.qualcomm.com>

On Thu, Sep 17, 2026 at 04:39:05PM +0200, Bartosz Golaszewski wrote:
> If we fail to acquire the GPIO chip guard in gpio_desc_to_lineinfo(), we
> return immediately before zeroing the info struct we'll end up passing
> to the user-space later in lineinfo_get_v1(). This may leak the kernel
> stack contents. Move the memset() before trying to acquire the SRCU read
> lock.
> 
> Fixes: d83cee3d2bb1 ("gpio: protect the pointer to gpio_chip in gpio_device with SRCU")
> Cc: stable@vger.kernel.org
> Reported-by: Sashiko <sashiko-bot@kernel.org>
> Closes: https://sashiko.dev/#/patchset/20260912123529.7951-1-tzungbi%40kernel.org?part=3
> Signed-off-by: Bartosz Golaszewski <bartosz.golaszewski@oss.qualcomm.com>

Reviewed-by: Kent Gibson <warthog618@gmail.com>

Cheers,
Kent.
