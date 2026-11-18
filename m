Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=100.103.45.18
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1794961387;
	b=m+iPUGFFQ+euj7gaHRod8Qu7AJTBMXjuBtebsIx4z2C1mM05XQa+pjoSzyy8iZeQDVzq
	 7Y75v+yBrYibSHVZ386WKTXJ3s5bo0cSBg3yS2ZI4gzAYUcQ+jwbyEvyFhIsplrznZYAo
	 cZpnE9I2bWcuCeWC6zU0hfYyVWGxpJ9BPJJyBxY3G29MLXzMQoyuEj5xkBD/BWMgfpBCW
	 EL9alA9Y7Dwk0UJlP+USxGrOYvn/gleuJIzHNEzBs6lbeMl5zkLq/mlKi+1Dcz0s+ifN/
	 YklGvdijWfgPELdK9O5GY/WQfMpLBN6LNkw7TmpLXpz7EKiOmlMdZ7zeTY856nQ5HZA==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1794961387;
	h=Received:DKIM-Signature:From:To:Cc:Subject:Date:Message-ID:X-Mailer:
	 In-Reply-To:References:MIME-Version:Content-Transfer-Encoding;
	bh=CkbW//av23/68TB9XD/L1XMZDCm2MfcLf5r8qDRl6kM=;
	b=WIYhJXX8+6N+R1DTSmxH6aHScnelmjmnvnOm+W6+3qngrfputfR61aZtDEELXWyjZQ8l
	 nwXkgeoA1KP4N9nt6uATOIdw6W6GvQ71db+5yXVAD1zykook4PTAeIUr378OlA+EKNbnx
	 1qedh1lOnoSfqVyzkWbv3w6Aq3zNv80GAfROUcv8VdysYlR1ngPoWp6BO7jxZC/hqf++W
	 qAOAxmQfAO2BIKfm3TtHDayLxaepsjybT8rVG+zN4Qrs4+RSF/yy2nDMk/2tZN1AfF3x8
	 fivHQucSzDAj85Y1YccWihhQSaN0N7Tp+Dqz+WDEoMYO4cuiD6zTEIYGOb8nxxuLr3g==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dkim=pass header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=lntXEWIt;
	arc=none smtp.remote-ip=100.103.45.18
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 909DC606A333;
	Wed, 18 Nov 2026 00:23:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=lntXEWIt
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 1212F1F000C8;
	Wed, 18 Nov 2026 00:23:05 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1794961386;
	bh=CkbW//av23/68TB9XD/L1XMZDCm2MfcLf5r8qDRl6kM=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References;
	b=lntXEWItVj2f9LV2xs7cFhKm2+KiTDIMz7l94KyFrPCFEr76VYDhrrKJouhWhT5tJ
	 mOZyPUXh935qTaIE4McSH+MC3O9TN7asBfmCmYItvaECB9x+ZuxPPpU5ESsJCUPiJg
	 zzULxPDEnRDdHRY/f3dUVOHVKVp2dzsIjwIZSgpBjBuzY/6EZt3+Z8747GJ9ci1LKU
	 JdMCbnc56gJ2QUurjhx3x/c/zdUyIM5R9wrSGqrDF7eS2MHYLKlmwlie6DrH+nypxJ
	 HJ0G9BoQlHxyCrxDOvxKE79Awev3ja8/mDz9FSwLi9ULX3HjxT1ntybR01oGfifL5X
	 7j4ejXbjYvjVA==
From: Sasha Levin <sashal@kernel.org>
To: stable@vger.kernel.org,
	stable-commits@vger.kernel.org
Cc: Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
	Jiri Slaby <jirislaby@kernel.org>,
	Andy Shevchenko <andriy.shevchenko@linux.intel.com>,
	=?UTF-8?q?Ilpo=20J=C3=A4rvinen?= <ilpo.jarvinen@linux.intel.com>,
	John Ogness <john.ogness@linutronix.de>
Subject: Re: Patch "serial: 8250: Switch to nbcon console, take 2" has been added to the 6.18-stable tree
Date: Tue, 17 Nov 2026 19:23:04 -0500
Message-ID: <2026-11-17-1-daily-reply-0008@kernel.org>
X-Mailer: git-send-email 2.53.0
In-Reply-To: <87a4n79zqb.fsf@jogness.linutronix.de>
References: <87a4n79zqb.fsf@jogness.linutronix.de>
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
Message-ID: <20261118002304.tT8KKyByPztclr_66TQq4eQCIaOhQdUCDCMQc0J-e4Q@z>

> Is this patch really needed for 6.18? The conversion to nbcon was
> initially reverted for 6.14.

Not needed. Dropped it from 6.18, along with the patches that were queued only
because of it. Thanks.

-- 
Thanks,
Sasha
