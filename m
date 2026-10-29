Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=100.103.45.18
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1793299440;
	b=QrwIf2SmNapRI8trA0+aj9qI84vrzqis+LJbQ+2r6GT8OIAtHMfOuMqrSUNoiiDhVPkz
	 5S5ikGNfAkN9dhmARDvgCqT9deeacIIo9DiWUQduei2ZJlII54zbj+kxFCMoYG4kw0cVs
	 QLtWWS7kmY6rid4Jt/KjARxUFEgIidD0YpwzkHJTxTOaxMKHiUSDQyQ+NIsYsLjhL9TCe
	 mWktInZgsin37s35Iy+F3FEXXbrDS0p/SJvsonR/470WK4wxogv7CI4/EnLq4g0fJ3/Fa
	 EObKQzZ1dr3sr5OtGJl5AdqBtV8Nx69pa/XIFQg9o8CWMMZ7UzRbOWDINiAs+ygLCbw==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1793299440;
	h=Received:DKIM-Signature:From:To:Cc:Subject:Date:Message-ID:X-Mailer:
	 In-Reply-To:References:MIME-Version:Content-Transfer-Encoding;
	bh=rr/RfpHh+XPMZaOw5ua3YDgL3vzmzgp+Fp8cpDVXl2Q=;
	b=4wAQGkbQ+lBza1wJef4p08jv7/sxG6teTluxzsKgkv8fMa7Sf8pmVGUmo5NtCsllnIyz
	 y8uzm2aisOEMaolr1q/zAnybld9NoR+Y8ahlRfHrneiasuJFHknZeoXQtt7uoc9+UghKa
	 7iYVKwMUyE4/eN9pttB1VWJvrqegrHY+V/8N2/1qLa+C+O0dJ8U+x8BfjqZRtWQ3kfr24
	 4CJOuWfaU0A0sJqmt1JvIZAnsEYQ/VSkkGjd19cFgpbTLW5f5YbtrmxTRRwAxqOmRdkN7
	 r/+C7/e+OmENHZYhScwkJGifveVQ+cCL0ktfsG2jK62x/pHTCf2MS3HI/jZsvtlObHA==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dkim=pass header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=XTVJenTW;
	arc=none smtp.remote-ip=100.103.45.18
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6D64260A260D;
	Thu, 29 Oct 2026 18:44:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=XTVJenTW
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 447A51F0128B;
	Thu, 29 Oct 2026 18:43:59 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1793299440;
	bh=rr/RfpHh+XPMZaOw5ua3YDgL3vzmzgp+Fp8cpDVXl2Q=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References;
	b=XTVJenTWQMR3paaym4w3jF0MAuMeTd6eXbRpJzwnjWMKCbemjLgemVQmkNYiNAUJM
	 5yWkcpLl71APXDqcWQKjJD/BBStpMTO+JwVzl3FprwFbb3E86+aeITh0td25TDEP2Q
	 0xnSAKk2YSxae+9tNJvvV+8nklT5nd0W8IsvoPMUi+VsThvNUkbiDylC/iYFhdI8C9
	 f0orjy8Mx/PxQwSL4bhkjiJJalWjsQ/J6IqmfUg/dVbLiQ0VhqvmKg9hSuMIbgqNY0
	 x943Drkb7iOnuAFiWog7KB8zRR+tYaZEK0vjDgJ1Kfp42xcKWQxj3f1EOKQna6/WP6
	 DwQjuz5t0A9Cg==
From: Sasha Levin <sashal@kernel.org>
To: stable@vger.kernel.org
Cc: Sasha Levin <sashal@kernel.org>,
	Karl Mehltretter <kmehltretter@gmail.com>,
	Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
	Yi Yang <yiyang13@huawei.com>,
	Jiri Slaby <jirislaby@kernel.org>,
	Thierry Reding <thierry.reding@kernel.org>,
	Jonathan Hunter <jonathanh@nvidia.com>,
	linux-serial@vger.kernel.org,
	linux-tegra@vger.kernel.org
Subject: Re: [PATCH 5.10.y] serial: tegra: Add missing clk_disable_unprepare() in tegra_uart_hw_init()
Date: Thu, 29 Oct 2026 14:43:29 -0400
Message-ID: <2026-10-29-1-daily-reply-0022-serial-tegra-clk-5-10@kernel.org>
X-Mailer: git-send-email 2.53.0
In-Reply-To: <20261029061427.27973-1-kmehltretter@gmail.com>
References: <20261029061427.27973-1-kmehltretter@gmail.com>
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

> Add the missing clk_disable_unprepare() before return from
> tegra_uart_hw_init() in the error handling path.

Queued for 5.10, thanks.

-- 
Thanks,
Sasha
