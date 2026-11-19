Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=100.103.45.18
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1795105750;
	b=43NUbfMFUNyVsu53ZaSjCooKJOeHQgQJLNwl4x1EzFZ8ztXg0zLZ8GWqivO/3Ex9JGet
	 R79pbgsPxjYeK9L5FtKo2sjealXmM5ZfSrHaZMYg7hn+FVk1n2Z2upax+OaLK3T1cfLdn
	 t8wIQV93qY0Mn64EktRYc5aNk3oBkJ0TFGWngTdNNgbT5fXTWRikQy+YMue6dClt94hIa
	 zhNUqLS0XIfFrEjeZHghreyQVcapI9FEnEcNX5OZtLex70Nnpb7BJ9c2bDgfockIxh5mI
	 flmqhPc6gPufPD5r2j9feLbYjipixiaUHtJnrsHm42GeYr80SBQyl7LLuWpQuK0n1DQ==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1795105750;
	h=Received:DKIM-Signature:Date:From:To:Cc:Subject:Message-ID:
	 References:MIME-Version:Content-Type:Content-Disposition:
	 Content-Transfer-Encoding:In-Reply-To;
	bh=42Xkf+DQSCY8fUGWy5Dgjmg4jz1IvOnKxBh9Nb2cSkw=;
	b=meCF8giZn3rC3lacXqSlplmqDN2fIckktpIMoW3A2ede0atrlHbwpMRQWjDUXbZXjR8Q
	 SpRZYd6bcLecevfBmKY90sFqvuMtc96am6mNaqkdv7gh9RQ5zejhGRdA9I/p1Sm6aEbzO
	 xWAU7SZvn5yNNhJJrlpzXZcSfPYMohmCowxv7MQIjx8CSgKmQNb4sq44GlgtWZjCvoHQ3
	 9akqjnoMDAhoCuYNrSk+5baZXlirIQxd+h/3X3sdLrDA580VpLJSqH1xyaxa60JXXX50B
	 zUfAKKLK6g8lZXY18bhgfquY6wrjUWkqXQa6ctCshcb45DPWeNICvB7CRrCuNmxWZUQ==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dkim=pass header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=RQbErtCI;
	arc=none smtp.remote-ip=100.103.45.18
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 080D6606A320;
	Thu, 19 Nov 2026 16:29:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=RQbErtCI
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 026131F000C5;
	Thu, 19 Nov 2026 16:29:08 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1795105749;
	bh=42Xkf+DQSCY8fUGWy5Dgjmg4jz1IvOnKxBh9Nb2cSkw=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To;
	b=RQbErtCIb26JdRuNcimbrV7z97THCLSkfa1S78CIAbuF0HYJheUFJI3wnyW2GZMHg
	 wIo+fdAxQSKOqMQCD/PW0b2x98x2ZNzqsW18zMqpYMVODOCPo7vqH185Y16Fu3pN0j
	 5MLSCJST6yLsd2DA6uPHtkWtn46OdK/ROXJLFFLrMBFXTGQXCNFQWSz2xt2WMO1LLn
	 0r6ZdaIyNQlSwZfSClT3FkbNJDynBBNb7vuA87BNwNslbpx1V3ftOv2GLcImsneTgr
	 lY+28ef6LGaECrijglUaLdKU2zDzzP0BMG+5mNeyVnKhcckzuLxywCquSG6MLGWgk3
	 b/b0MZKOLleVg==
Date: Thu, 19 Nov 2026 17:29:06 +0100
From: Frederic Weisbecker <frederic@kernel.org>
To: Haoli Zhang <26031212468@stu.xidian.edu.cn>
Cc: tglx@kernel.org, anna-maria@linutronix.de, linux-kernel@vger.kernel.org,
	richardcochran@gmail.com,
	syzbot+667788430769ef9ddf25@syzkaller.appspotmail.com,
	stable@vger.kernel.org, 25031212117@stu.xidian.edu.cn,
	byu@xidian.edu.cn
Subject: Re: [PATCH] posix-clock: initialize cdev state before publishing
Message-ID: <av8j0vUFpUg2aZyf@localhost.localdomain>
References: <20261116032853.825-1-26031212468@stu.xidian.edu.cn>
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Post: <mailto:stable@vger.kernel.org>
List-Help: <mailto:stable+help@vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
List-Owner: <mailto:stable+owner@vger.kernel.org>
Precedence: list
MIME-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <20261116032853.825-1-26031212468@stu.xidian.edu.cn>

Le Mon, Nov 16, 2026 at 11:28:53AM +0800, Haoli Zhang a écrit :
> cdev_device_add() may expose the cdev before it returns. Initialize
> clk->cdev.owner and clk->dev before calling it, so an open racing with
> registration takes the matching module and device references.
> 
> If cdev_device_add() fails after cdev_add() made the cdev available,
> open files may still exist. Mark the clock as a zombie under rwsem before
> returning the error, so subsequent read, poll, ioctl, and dynamic clock
> operations on those files fail while the caller tears down registration
> state. Keep clk->dev valid so the release path can drop any reference
> acquired by a successful open.

Is the device made available before device_add()?

Thanks.

-- 
Frederic Weisbecker
SUSE Labs
