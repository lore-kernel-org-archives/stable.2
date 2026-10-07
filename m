Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3CFA3414DDB;
	Wed,  7 Oct 2026 21:04:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1791407052; cv=none; b=GNjK4qLHqqD/lsIypkav+RWxJ/oVzTheerATBROjRhFs0csUCMrE9svKYgE82+kjVArL8oOqayL5X2mqJxIdO0VXbg3uuR+rTFAW2yCrUqoL0G2supBliQ/F2Fh7FMfhHvNoTxeV3W2YbaOgi9UA2sYgCdBkcoJpZA3d/Y/syj0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1791407052; c=relaxed/simple;
	bh=YVGn4j8Xj117VtsDybfD/Nbr1XFft4L4TUF6oG5yD1o=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=DI9EpWRJBydwQqBmewM526DAJFwCVG9OMtD9RR2ZqGKvJgaM1Q2UqLhpV+rw2hIyG5pzdEah/O08zshFoT0enBgbWa1f0MuOhR0WLU1+Pj2d6Ug3hOkc3PqkE5duvK975K9ocYNHipsoEmQ8xPlLDxXxMenInjcQNpu0MQV8UBY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=PT56f07V; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="PT56f07V"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 293E91F000FF;
	Wed,  7 Oct 2026 21:04:07 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1791407050;
	bh=ZSdoGWZoc06XGY+z5CFBLOvt0h/anWLAC7ap5m/ePXk=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References;
	b=PT56f07VdtIpEjBHVGoqYnAOY4VHH4Uv9uE0KcQ6PAWyaLd+WcUqxazLHsBDy7heg
	 mbW/mipIMKKHGmoDyYyPoSpKd9a+F4V+9JLRSkA15wVjI1/uozredD3XvW4DAMloXE
	 TvtBPbjt2tmfFFjou1x2d7+dmW0nDcz3OBTsvpXjDm8U8dN3mNvVz1cKAmHzzsITU0
	 8a64uuD+80hMHxuxTHxP4eyh6AaJpRWy7Ix1Gozcqv6eHlgWBArs2wS3bO2sD+XcUy
	 PqtUneeZwIl9QStOZTT0f2bdwr1q7YB8EtGt+lt+mXzek3QnMtZrUdnLdZBpeSi2xL
	 DzU9uEoPNqUSQ==
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
Subject: Re: [PATCH 5.15.y] iio: buffer: serialize buffer teardown with mode claims
Date: Wed,  7 Oct 2026 17:03:31 -0400
Message-ID: <2026-10-07-1-daily-reply-0014-iio-buffer-teardown-mlock-5-15@kernel.org>
X-Mailer: git-send-email 2.53.0
In-Reply-To: <20261006102525.172949-1-kimjinseob88@gmail.com>
References: <20261006102525.172949-1-kimjinseob88@gmail.com>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

> Take mlock in iio_disable_all_buffers() so that unregister honors the
> mode-claim lifetime guarantee.

Queued for 5.15, thanks.

-- 
Thanks,
Sasha
