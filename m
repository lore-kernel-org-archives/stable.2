Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=100.103.45.18
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1794961215;
	b=j07ziCnK2KtiI+gFc/WHfcLQr9WnrVgk/zRDdAKFQhaOUC4DEZn1jmhj2dqfAtebZCiy
	 hQnYVK1YxboAjHv5laFXFUV+ifdkNnUxvN+5aQZDt8n6uQdBjtjxNKtctxlZmqgkzLadU
	 IJo/iE1hxhFOVQyxNfpsTUnMGP6VJt/zGPm5sEZ1N2Ov2xbGP3xxHs4OLD0uo+mw4rbDB
	 BsXn0FVNXZNAFiwxP8qEaD06r3yAjvo+klWX/dmDsQwj4Or8qQIFZW8q9hbTjOc0Twe3y
	 B7jmr7g6Cc5mtUvKN+ai1+Lm+0jo6nYyCR3xh6n3e4ro61N8+LloiL+0HKaf3Jo9OPQ==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1794961215;
	h=Received:DKIM-Signature:From:To:Cc:Subject:Date:Message-ID:X-Mailer:
	 In-Reply-To:References:MIME-Version:Content-Transfer-Encoding;
	bh=CkbW//av23/68TB9XD/L1XMZDCm2MfcLf5r8qDRl6kM=;
	b=r63skA94qMK2J/KBt57P9unsgWTUlkOnkzZqZImucvrAcxNkv54UVwkG5rFysTSx7Xmt
	 DHBHVxU0Wi2sIBGsq40vWz0ojkb69fMIoGULHaBeDCHPcgKmsXlrcgkJlgIKaSPUyQuy0
	 X6NaDvDYYIp9k/hiygrN/BRXgln+u8m+Kg4JGhhklzS8beFYKzJEKopjuBJqKQ3TR/5JH
	 NNleN/EzdP+VXt9A42EbIQloaAANuHXqu45/vbjJu4t4YB4cJnfJ95MxjBJtZlIxuAz57
	 2LtVoIkNIlGkfqpjxcOrDzQ5Z9BG6WcPwN4y6QGE08ec68FwIKrIBj++PVMvOiDLIpg==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dkim=pass header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=fY01DNnU;
	arc=none smtp.remote-ip=100.103.45.18
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id EC1F4606A336;
	Wed, 18 Nov 2026 00:20:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=fY01DNnU
Received: by smtp.kernel.org (Postfix) with ESMTPSA id B36601F000CB;
	Wed, 18 Nov 2026 00:20:13 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1794961214;
	bh=CkbW//av23/68TB9XD/L1XMZDCm2MfcLf5r8qDRl6kM=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References;
	b=fY01DNnU8hBkz5ydqH3iQfejhCdohMg5Xf1wZwh8+Rab0Aqh8Fy1ouLssXlT//Ns1
	 XAtn1oXA/W24Mc9pQT4qnHjPTeS6Y6PcFxHJrXsxe0M7HbP/o39PzTmHIjubfacFw+
	 IjCYLHsaKbUnd8K4ovuXHYVXf1sWmD9YC4RHSTzVBrio8V9xEpIfgVndjkttULJdyi
	 NrWbhcrdMSQJ4X0a2DBOCH6IF7+A91wS4CkGhCO+QCHSKZop63Pvzuu2QWkcbxTOe+
	 k4Mn0EX7LJqxWgs2u0UGOWKXD46feESQt2e/6/vL2umsPyzl2auTgDbr0smRSmGYiy
	 4fEoZsYHYf5Jg==
From: Sasha Levin <sashal@kernel.org>
To: stable@vger.kernel.org,
	stable-commits@vger.kernel.org
Cc: Sasha Levin <sashal@kernel.org>,
	Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
	Jiri Slaby <jirislaby@kernel.org>,
	Andy Shevchenko <andriy.shevchenko@linux.intel.com>,
	=?UTF-8?q?Ilpo=20J=C3=A4rvinen?= <ilpo.jarvinen@linux.intel.com>,
	John Ogness <john.ogness@linutronix.de>
Subject: Re: Patch "serial: 8250: Switch to nbcon console, take 2" has been added to the 6.18-stable tree
Date: Tue, 17 Nov 2026 19:19:59 -0500
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

> Is this patch really needed for 6.18? The conversion to nbcon was
> initially reverted for 6.14.

Not needed. Dropped it from 6.18, along with the patches that were queued only
because of it. Thanks.

-- 
Thanks,
Sasha
