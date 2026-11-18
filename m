Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=100.103.45.18
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1794961217;
	b=KhpDep7i+6wh9R8OSpWznpJcVfdx5Hen+Ns8ZksGVnQrdr4kyMFAEwtoq41jdEe2Mldt
	 /tOX33wX1Q0kWidII9EBRBrSMeW6vEZH4TTo+QYSNeeKooFW4eD6BOpqOKejHT0L6c9Yw
	 +4pf3OdiS9JQ0M/CK+47vzop51RBpRejPbeO/jCxDqX5bCvdVpXiS7js+G+4jgsLPRrFd
	 79iZf1hAEG9I7lMV/J8YQ1Jvm0LgYzmb+OdZkDJT3duFHP2UCdAijojDkBOQwKA/Y95i4
	 1XrVuzlvTQHEJ5sy/Sddq44RnZFjRUxIltjDYLVg7ZnAKXg3wuNzZIPbllnT4ieX7Pg==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1794961217;
	h=Received:DKIM-Signature:From:To:Cc:Subject:Date:Message-ID:X-Mailer:
	 In-Reply-To:References:MIME-Version:Content-Transfer-Encoding;
	bh=T/KeOQAMogHIx7JTaFazjZHCznLnaZpss/DsrDscrDA=;
	b=46u8tFFBGsgq1NyzBaK+NMN9k0Urw3ICZuMH7SPndakreEaxdOCXO/3BUQFei+KwWqPj
	 b5zb0SDAOOwVA4kUIlJeemW5tUTQ5NHx36lDswd3Y0a0AjmEFddhpsyNpZvi1aEf3PXkb
	 0O8qdTimNU3Re39u1BDLhmlenPrDHQw0pQysUk9OUp0E7Qc8lIKa5xWG38fTFcJrWmK6M
	 SuW4ySB8dhTZpsbxbrBPFPY297Cp7yu4Eaq6L35RfETWA+S596EX+gIY70aO29Ps5SSPX
	 UY0J0fK6dXnSQMUYGtpgojCq2mpS/9WSxMhhL0sqIu8s5QvTgxf7gMFsAra3f5TiD9w==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dkim=pass header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=T140318q;
	arc=none smtp.remote-ip=100.103.45.18
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7F6DE606A332;
	Wed, 18 Nov 2026 00:20:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=T140318q
Received: by smtp.kernel.org (Postfix) with ESMTPSA id EA9281F000CB;
	Wed, 18 Nov 2026 00:20:15 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1794961217;
	bh=T/KeOQAMogHIx7JTaFazjZHCznLnaZpss/DsrDscrDA=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References;
	b=T140318qKAlLLj1Xj9+4jRCUV8k4JEwzVYuDlkPCTTfThqvlcylHVqVdP6woJQSdg
	 yNEHyLyzOz84ea/M4kRe3zKeZBj51S1mizrt3enT+VSWgE1X/rj24evAIrnrRSHyyG
	 0VB96WTN/zNYOy2yp5zMls8qjB3+UNSIoYT3oQ8tY8jLZY/TOPyrLwbxyzmz5W78ew
	 3FrmZv9bnzO4H9YD6X/VbODSe5XKI1TYkmo42MTDctG4B3j2LiL3ZtXKXBFGl10eNh
	 atv5wtmeIea0cJ3wEJvCGQ+o49T4WFC3pnP3NSVajl4GoeMjI4obqlku29Hq5b8i3/
	 HqS1n6bpCf7ow==
From: Sasha Levin <sashal@kernel.org>
To: stable@vger.kernel.org,
	stable-commits@vger.kernel.org
Cc: Sasha Levin <sashal@kernel.org>,
	John Stultz <jstultz@google.com>,
	Thomas Gleixner <tglx@kernel.org>,
	Stephen Boyd <sboyd@kernel.org>,
	Miroslav Lichvar <mlichvar@redhat.com>,
	Anna-Maria Gleixner <anna-maria@linutronix.de>,
	Frederic Weisbecker <frederic@kernel.org>,
	Ingo Molnar <mingo@kernel.org>,
	Arnd Bergmann <arnd@arndb.de>
Subject: Re: Patch "timekeeping: add CONFIG_LEGACY_TIMER_TICK" has been added to the 5.10-stable tree
Date: Tue, 17 Nov 2026 19:20:01 -0500
Message-ID: <2026-11-17-1-daily-reply-0010@kernel.org>
X-Mailer: git-send-email 2.53.0
In-Reply-To: <101777e2-a6fe-4d1a-9a9e-7179ce89bd65@app.fastmail.com>
References: <101777e2-a6fe-4d1a-9a9e-7179ce89bd65@app.fastmail.com>
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

> I don't see how this is a dependency of 2927f7ca7844, it looks
> unrelated to me, and the patch only adds an unused function.

You are right, it is not a functional dependency of 2927f7ca7844 ("time:
Prevent time64_to_tm() day truncation on 32-bit"). The next patch queued for
5.10, de995239ab01 ("time: Improve performance of time64_to_tm()"), has the
LEGACY_TIMER_TICK Kconfig entry as context in its kernel/time/Kconfig hunk, so
I took it to keep the later patches unmodified. It only adds an unused function
on 5.10.

-- 
Thanks,
Sasha
