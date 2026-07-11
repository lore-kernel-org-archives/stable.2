Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7D80439EF25;
	Sat, 11 Jul 2026 10:21:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1783765264; cv=none; b=Sq6U2fl5o99oH27NxGk8g7nbbYNTci0s3N4lxAheTLMH6pvw02DmIqKfiWEBaU61bHGXMJ/mxlkwLD4w9Sz4BJsJfkRRLQ/gloYKMIXLOCU0v8uVL8NJkSWtrkFcU/HbSQ7FLQKSheWzAiMPJSp0JTYb7bbljsziOzyxg+7bLzI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1783765264; c=relaxed/simple;
	bh=dEHl9N2W+Y3yvK+K2EyyGXc4h70OKQlEhr0rRbekom0=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=PI10IuMfj/P9SBG3CAOo0uUT+dlgnDBfn7h0WhpMlck+U/Qg4LuUlJKcEVOUen4tg8kZdLHQqgLbJHStLmXBDBwQGquqzEDROofKRS5LGIElSZfwudoEStM/frxhgkVW65fhIoVL7oooxIOeXXBYU8bKyS1qeOYHLJb4J4PQGdE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=llwCZDfR; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="llwCZDfR"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 4457E1F00A3D;
	Sat, 11 Jul 2026 10:21:00 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1783765261;
	bh=Y5aJ+Qm0JJUYPvStiI2zNIiRrGLRCpzpQqL3fvDD7L4=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References;
	b=llwCZDfRI6L9DGkjO/QyBPXsnvmdDJGsDFjTZaXpX6jyKl86ER65OqWneo1Gq5Xno
	 lEKBIImLJWRUm/rh5toWqMGBpGkPNak38Of5ABK8L4kR8R76mjmMIVvZ7IuLhbkMw6
	 n5Amf1F3WKYQ8LG6wPIqHhqgx7YmmEQ0ky0od75QmGD/MWyrJD8tedkxyhyWfr1nZl
	 O0kOcppziScsm9UnpdqXtmCNhZ8CtUgERReRJUDdizgIEfj5JL5t9WRnDeTJhLU2jm
	 7V7CZzXeBNyiqPB9gyUYFijl+BHrO1/Iflwp5NTQ/kLIFfSz3glSkGvZi7cznOUSY9
	 q9M2YDcXUBa6A==
From: Sasha Levin <sashal@kernel.org>
To: stable@vger.kernel.org
Cc: Sasha Levin <sashal@kernel.org>,
	Thomas Bogendoerfer <tsbogend@alpha.franken.de>,
	Sebastian Andrzej Siewior <bigeasy@linutronix.de>,
	Thomas Gleixner <tglx@kernel.org>,
	Jiayuan Chen <jiayuan.chen@linux.dev>,
	linux-mips@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
	Jonas Jelonek <jelonek.jonas@gmail.com>
Subject: Re: [PATCH 6.6.y] MIPS: smp: report dying CPU to RCU in stop_this_cpu()
Date: Sat, 11 Jul 2026 06:20:56 -0400
Message-ID: <20260711061631.agent5-0002@kernel.org>
X-Mailer: git-send-email 2.53.0
In-Reply-To: <20260710223627.5860-1-jelonek.jonas@gmail.com>
References: <20260710223627.5860-1-jelonek.jonas@gmail.com>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

> commit 9f3f3bdc6d9dac1a5a8262ee7ad0f2ff1527a7e7 upstream.
>
> smp_send_stop() parks all secondary CPUs in stop_this_cpu(). The function
> marks the CPU offline for the scheduler via set_cpu_online(false) but
> never informs RCU, so RCU keeps expecting a quiescent state from CPUs
> that are now spinning forever with interrupts disabled.

Queued for 6.6, thanks.

-- 
Thanks,
Sasha
