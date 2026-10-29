Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=100.103.45.18
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1793299436;
	b=22m4NNaVbdQE+mPf7tPWYdHvQTxVSwGSPNpAUYCdm8NAA4yXncn2t4tB0lwBKqHhE6hb
	 CZqjP88nR6dOaEdREsUUqEtyLzlWbO+D2D2gkWF0Q0fKDudsvPsiAcc8qBamPTD7ApJ5/
	 ATcd0RtUEl968XtbbaVocLe+jEJJfM0yhGzDn7ILchk8cIQj9qm5ssiFesnivCgfZL6xw
	 YirGVVkD/MJwxguMwCXu5YZfkZEiOTbk+Uu5DpMPNfZQyOLnxrCahMDJrbsCEobUBfUG8
	 vjKrbOY5n40hAYFvlyt+XOd/jKGQu+YTnqPWaw7OwbG+/Xk9NoyePn9pW83XgALWwZQ==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1793299436;
	h=Received:DKIM-Signature:From:To:Cc:Subject:Date:Message-ID:X-Mailer:
	 In-Reply-To:References:MIME-Version:Content-Transfer-Encoding;
	bh=uQlGd1M4u76QyjOpAfww7sN8gyAXmT9XtIdN05iD/ho=;
	b=Qns93sP1oiBW9Ui8ExnVdKB+UN6Cf/jJ/sgI/ureV2/gfkPy/0U1+588BCkbsq6kAVW6
	 hLuhb3ITpVNrnurUQpkZcc/cLZOL469LbR7Teo/PCp1is3/fCfVLFhoJHoCv+CwygyC4f
	 OaK/d2uNFE9RWOa6X73qr/BXomPBiFuaBMikH4x/8b7hxK5810jHY4LV+6MNi+BcmAl9+
	 0XsUUOwoFaty3Earxqcnz9IcxAuRc6zAd/2NXs8Um030He3PfWwqYVf07rnqt/LjCTWTT
	 zkyNAbw2iZdkQjbLBv+Bvxl/LwkJF/HDZHJCHr3r34fbYGdMyefpivs5/3GYDyTIlmw==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dkim=pass header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b="cCcn7/8P";
	arc=none smtp.remote-ip=100.103.45.18
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A3BFB60A260F;
	Thu, 29 Oct 2026 18:43:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=cCcn7/8P
Received: by smtp.kernel.org (Postfix) with ESMTPSA id C9C181F01284;
	Thu, 29 Oct 2026 18:43:55 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1793299436;
	bh=uQlGd1M4u76QyjOpAfww7sN8gyAXmT9XtIdN05iD/ho=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References;
	b=cCcn7/8PU5KoGH2yfeWXGA4U1eL2MAVAEEL2cxRvceLmLsye7CF9218ZLQ26vg0fe
	 rxU9E0fx//jV7A1QkqVZtX2YYNrVX5Z60KgCjwrF2KVaOb7YwExxekUD8zRU5cZdPU
	 IsA0e/xml9/EuvntbIZKyfT/X0jdBLdhQOArGeBLX+5mqxdKYK6n3G+FrvKtTegwZu
	 mvGvmN3U58GpWFTTHdOp2usbAOMMQOnZyF11MIqCkzUIcdBwSlmP5tm5qi1+4mC7v6
	 1UICGHK0Tp+I7lqh6feAXIGpGhxpwHPc55oXN8danqhyAYjJMyAphLzRTqoNFDJ+nX
	 YPTqRvdYFjBgg==
From: Sasha Levin <sashal@kernel.org>
To: stable@vger.kernel.org
Cc: Sasha Levin <sashal@kernel.org>,
	Jonathan Cameron <jic23@kernel.org>,
	Srinivas Pandruvada <srinivas.pandruvada@linux.intel.com>,
	linux-iio@vger.kernel.org,
	Daniel Schaefer <dhs@frame.work>
Subject: Re: Request: backport cad928dad9a4 ("iio: hid-sensor: als: scale each channel individually")
Date: Thu, 29 Oct 2026 14:43:26 -0400
Message-ID: <2026-10-29-1-daily-reply-0019-iio-hid-sensor-als-scale@kernel.org>
X-Mailer: git-send-email 2.53.0
In-Reply-To: <CAAjcXz7fjcH283zHzJSZbKK74HOsOxEr9+W0ydoiYyLJ8y9qVg@mail.gmail.com>
References: <CAAjcXz7fjcH283zHzJSZbKK74HOsOxEr9+W0ydoiYyLJ8y9qVg@mail.gmail.com>
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Post: <mailto:stable@vger.kernel.org>
List-Help: <mailto:stable+help@vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
List-Owner: <mailto:stable+owner@vger.kernel.org>
Precedence: list
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

> Could you please cherry-pick commit cad928dad9a4c26aa56b4223dc2a29bca517fb5f
> ("iio: hid-sensor: als: scale each channel individually") to the
> stable trees >=6.9?
> Currently that's: 6.12.y, 6.18.y and 7.2.y

Queued for 7.2, 6.18 and 6.12, thanks.

-- 
Thanks,
Sasha
