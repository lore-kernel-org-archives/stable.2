Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6E5E133938F;
	Thu, 17 Sep 2026 00:30:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1789605032; cv=none; b=M0x5AqadZmO6EPwo6uiJwsB4t9io3xl2KGdzMASKykay6C7wh9E4QkeCETLT6h98xBamqSbkEJW7enbtAIk8qV/oXqZYwpkb5/5n/ZVwxz2F2wgXcf/wOct5Yf4yCOaZTIyQ7liZe3ZI+1OBD859VyzwNzuzIRUxQTx3M0kvN8E=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1789605032; c=relaxed/simple;
	bh=oYG6oqEXKM71Vx0FVvcKaEqIluq5mPiCvi4P/KQuz+w=;
	h=Date:From:To:Cc:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=iG0KJvvoEDCheQ1BspoWmu/fWtgXYp6cygPkKCqirUQ1HReylTeTHS3bb5Dw2cz2oYtykYKzEurZRsL55RuhtmCu8VM65AVT26iexb/ygGwWc7xryA5NaBOwr6jT6/wHpyrAofzUIz2AWX3W2qO4z09wT+8kxB33O7NboQaAvBQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=EH437860; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="EH437860"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id CDF431F00893;
	Thu, 17 Sep 2026 00:30:25 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1789605028;
	bh=LRJuW1G1kuLW50MJCNk8YbtTnx1at2EzijAw2lQ1fbw=;
	h=Date:From:To:Cc:Subject:In-Reply-To:References;
	b=EH437860PIasELZAGQxhqcIp7joxh8a0bGdFFDBIueoSNjiDSrL29+9CSoK6rLFY8
	 vz2MIBaB6eyrUgBPeeEdunEMW4+h4Tuxf/RhkBUGEMFnhtnrzpS9cbGTgrYpxIe5PR
	 mPw+hCIP9JD2Z313i23UGet2cjiVxGq5o3zFXS71Ps5XlTts0HFPDVbmGvhJnnYiWP
	 KVUioOH5jf4bFzdgcO8+3KhI1GR6cUgXBPvnc/SdI3xQo4HetlSewIJDKRbclKfuit
	 tIfK3d+IeU09pK9aGWpDEWznvI38gQDgW1qkZtOBj+72Au07YJCmueJP1ycqloVL6Y
	 lWy+F5Lg7aHHg==
Date: Thu, 17 Sep 2026 01:30:23 +0100
From: Jonathan Cameron <jic23@kernel.org>
To: Wentao Liang <vulab@iscas.ac.cn>
Cc: andy@kernel.org, dlechner@baylibre.com, linux-iio@vger.kernel.org,
 linux-kernel@vger.kernel.org, nuno.sa@analog.com,
 tomasz.duszynski@octakon.com, stable@vger.kernel.org
Subject: Re: [PATCH] iio: chemical: scd30: Fix trigger reference leak in
 scd30_setup_trigger()
Message-ID: <20260917013023.5fd8d0fb@jic23-hlaptop>
In-Reply-To: <20260916162817.2083674-1-vulab@iscas.ac.cn>
References: <20260916162817.2083674-1-vulab@iscas.ac.cn>
X-Mailer: Claws Mail 4.4.0 (GTK 3.24.52; x86_64-pc-linux-gnu)
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit

On Wed, 16 Sep 2026 16:28:17 +0000
Wentao Liang <vulab@iscas.ac.cn> wrote:

> The reference taken with iio_trigger_get() is only dropped by
> iio_dev_release() when INDIO_BUFFER_TRIGGERED is set. Failure of
> devm_request_threaded_irq() in scd30_setup_trigger(), or of triggered
> buffer setup in scd30_probe(), returns before that mode is set and
> leaks the reference acquired for indio_dev->trig. Take the reference
> after the IRQ request succeeds and set up the trigger after the
> buffer so that only failures with the mode already set follow the
> iio_trigger_get().
> 
> Fixes: 64b3d8b1b0f5 ("iio: chemical: scd30: add core driver")
> Cc: stable@vger.kernel.org
> Signed-off-by: Wentao Liang <vulab@iscas.ac.cn>
Same again. See bma220. Not this solution.

Jonathan
