Received: from galois.linutronix.de (Galois.linutronix.de [193.142.43.55])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 72A53332610;
	Wed, 12 Aug 2026 13:17:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=193.142.43.55
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1786540621; cv=none; b=qbcWtihy54EkJX+fnKKTYS3Y0+DzBPzWzQwDVsXt1CMtNABXqnRUMZ9xxMBLIvTSf0H6G9AUE/kZlppM2PI3lgJ1ccWDLf7SjV2j/GhGZcPZ4goe0uemMMbmKJWV0Bk0T/q78eYwSipTmFMI1TvLi5fN4fVxLGuie7VI0pb/d00=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1786540621; c=relaxed/simple;
	bh=d/k4SNSaIRxAs2eYl0qTG3qSPbJiZBT+hcYkIazZPp0=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=mvZdaIedwW7TkcojuwkcoPBcWF63zkP0B45wqwXo3D6SsiHuZn0ZaTKpnvlMApgPHe7KhZHf7vXbIL7VpMJpp39qH8lamaWeUl4wiQeoHvtXOT0OiUSxom5CQIiS4mbfSgQsBehwk1upFpy92Y5Uq3mgNU1r/uPorCuJyvShTYU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linutronix.de; spf=pass smtp.mailfrom=linutronix.de; dkim=pass (2048-bit key) header.d=linutronix.de header.i=@linutronix.de header.b=IO5AxRF3; dkim=permerror (0-bit key) header.d=linutronix.de header.i=@linutronix.de header.b=RqPDcgCj; arc=none smtp.client-ip=193.142.43.55
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linutronix.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linutronix.de
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="IO5AxRF3";
	dkim=permerror (0-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="RqPDcgCj"
Date: Wed, 12 Aug 2026 15:16:56 +0200
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020; t=1786540618;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=d/k4SNSaIRxAs2eYl0qTG3qSPbJiZBT+hcYkIazZPp0=;
	b=IO5AxRF33Ohxo0yZZCCF/y7mvMBr7gTdmqSl1WwILJ3uahKi+jgDRBG8bKHs+9WM+X4ydz
	h8Z0uxiJ2N93Q9kSXrSenLyF7Xit8GfbrxD6FCdATxuTR/u33vn+XqchRTjFEAB5jAJd8g
	qzi7Cf3N6wfCctSjASDa8256lmk+92B//y9wMBAAk5YpSIAGNzqsqlgI2VQ/HLfj7RoO6X
	6ixIDLknt6iaFz7MLLXlstbvkj73wyvYNuF6KVwzf+9JVJP3ikDEFdgaastKE7/6gOxeSA
	mYFsKqL4KmzroEmiVgMcP2W3wqhyjTdLzN1FCjYF2gwqNUDV8w6jrs9eyRL10w==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020e; t=1786540618;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=d/k4SNSaIRxAs2eYl0qTG3qSPbJiZBT+hcYkIazZPp0=;
	b=RqPDcgCjYlSZOMNWOKFA+GpC4EMCMWGZhwbzO5nLjt/wk99VQJ3mOQkH3RK6RmLL7MJmUs
	BeNh19JCOV/bhJBw==
From: Sebastian Andrzej Siewior <bigeasy@linutronix.de>
To: Linus Walleij <linusw@kernel.org>
Cc: Junjie Cao <junjie.cao@intel.com>,
	Bartosz Golaszewski <brgl@kernel.org>,
	Andy Shevchenko <andy@kernel.org>,
	Clark Williams <clrkwllms@kernel.org>,
	Steven Rostedt <rostedt@goodmis.org>, linux-gpio@vger.kernel.org,
	linux-kernel@vger.kernel.org, linux-rt-devel@lists.linux.dev,
	stable@vger.kernel.org
Subject: Re: [PATCH] gpio: pch: use raw_spinlock_t for the register lock
Message-ID: <20260812131656.Mq5SrLmw@linutronix.de>
References: <20260723014129.1129730-1-junjie.cao@intel.com>
 <CAD++jL=EJyWpqjwCdfosdanjS9GUAwMEJjHFrcvMyBV3iKHZZw@mail.gmail.com>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable
In-Reply-To: <CAD++jL=EJyWpqjwCdfosdanjS9GUAwMEJjHFrcvMyBV3iKHZZw@mail.gmail.com>

On 2026-07-25 11:50:05 [+0200], Linus Walleij wrote:
> Really? Why to stable? Is this a regression of something that used
> to work before? Using RT is fringe IMO.

There are stable trees where you can enable PREEMPT_RT without an out
of tree patch. I wouldn't call it a fringe. The driver might be rare
but=E2=80=A6

Sebastian
