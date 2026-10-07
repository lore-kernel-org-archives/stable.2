Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C4C86374A08;
	Wed,  7 Oct 2026 21:04:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1791407048; cv=none; b=pUCra9gtSe0pSXqUCArORWaXuu4bOGYsshC5WRRExDHff3OKvbwGJOeCWmfKJQryiOCZmji9XRM4DSXUTk7mvhhG65dPjOmBEEmCBHfyMCCumT7EMAvRpmCiyTioIldkJf75I62qRPnPtzsQd2to2a3WjuWppOD/nGfqP/cIRmY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1791407048; c=relaxed/simple;
	bh=wPcqIFVlb8DiqYUKavwIid/bzf/zGfRl4Ofbh5FRw4A=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=QiMkl5Pq3dj9s0OvX02Qfv2kDjbUZGAneNqlQsRFaYhHgT0HBrM5ST1Qisn0t8R77bn/YWd4jjs7v7ekGK9pCYjKI/JW8mtaqWwFTOQDFxwEAoPIdL66yOygUjyqAS3pP3Juehin6Q7LDyfynNqrQeOZTwUGLnCWedyg2qK/UPM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=FIwMfPl7; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="FIwMfPl7"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 96D561F00893;
	Wed,  7 Oct 2026 21:04:05 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1791407047;
	bh=0qYNfAqBEZ9MhKd8sfZSY9+S9pEt+V1iXJ8iIXfm9Tw=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References;
	b=FIwMfPl7rW3aNXLpAySo+Vwz27IrRGLpBqTScwKYlnndxN/qZtm2GVEw7uiYvf2T8
	 eqcKeEhAo5uWvL3brAs7FMeZ252d8R5by9i+XipoxeySXPGDVt+dIb9e2WKzPh3gKL
	 mRZQCYMLdeFpbb7w1E4u8lKlalAQU/3IJVRybgcsfGlLrVZz6rr249b3OvoQGbjNq5
	 HboaBJojRHbdaR3vXHX4eQksFchESrLdvJNtvgtIeEB/ryoUrDjKeJZ/gvSoncoiUV
	 e8DLMB+9kqpQTDwmsPKTfnxYWgNoXXVLLu/u16r9u3y3EmOr3N22/jkmq2iTaloCmA
	 5fS5nEfifTqnw==
From: Sasha Levin <sashal@kernel.org>
To: stable@vger.kernel.org
Cc: Sasha Levin <sashal@kernel.org>,
	gregkh@linuxfoundation.org,
	jic23@kernel.org,
	lars@metafoo.de,
	linux-iio@vger.kernel.org,
	joshua.crofts1@gmail.com,
	nuno.sa@analog.com,
	Jinseob Kim <kimjinseob88@gmail.com>
Subject: Re: [PATCH 6.1.y] iio: buffer: serialize buffer teardown with mode claims
Date: Wed,  7 Oct 2026 17:03:30 -0400
Message-ID: <2026-10-07-1-daily-reply-0013-iio-buffer-teardown-mlock-6-1@kernel.org>
X-Mailer: git-send-email 2.53.0
In-Reply-To: <20261006102351.172907-1-kimjinseob88@gmail.com>
References: <20261006102351.172907-1-kimjinseob88@gmail.com>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

> Take mlock in iio_disable_all_buffers() so that unregister honors the
> mode-claim lifetime guarantee.

Queued for 6.1, thanks.

-- 
Thanks,
Sasha
