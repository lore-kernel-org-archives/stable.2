Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=100.103.45.18
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1793299418;
	b=QU7Eg9ZSEdFhMdzv+zpEoPZb07VL6OUgDfEpcU8XHYyeH34TB8gu2I//cyMWzk0h4pCY
	 ielU32+qCKS9S0vLv07sTxEGQFZ2GVhAcnsF/+clFqbgW5LEKB72KHdbx+N5/qBBSaqyN
	 hRb7uoDg3LXfBbcUlPXUogb2JPmpek3tLnH70l1Gm7htZlA1n61p8YFx2y7uVvqf6eF38
	 WQlBEB4WiMYdKbMB5FHfrMF5+ILiexMO79PUPXLIZ0W9MzQaHokSjf5pvedBhaNtwq8j0
	 cw2/4GGP3QZeNfPiodRc8oBxzdsHMa1B3RgdP+1y6DMLwiImTHlGGGPZb6ydhcYNTYw==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1793299418;
	h=Received:DKIM-Signature:From:To:Cc:Subject:Date:Message-ID:X-Mailer:
	 In-Reply-To:References:MIME-Version:Content-Transfer-Encoding;
	bh=DMc9BN7cfB/ctr90j5iazUBHVgwBgpWajdm3rU7xVro=;
	b=RVIeBFJ9iVsMDNw1IwwNN2BcZzpcL8jY6bMT7EiVUkQu9uPtdYWF4R9Ld7DP2T/UKQI8
	 MOKT59D/FNhBUs6uA4Zymsev9e3GCxcFcLw8ipEiEpDxNgk+hgPEIJQKUHqkt9rSxn1lO
	 Qt9cIcE9OdlesAkYRhVILVADWDtrh9lCcrlTSIQfg+jPifA4ud9XlV/U13Lpj2oBD2Gc3
	 02dKklBZZ8Km8RfM6R3qCtdkb25R3OgtdTkcjDf2tfLAF5SvpIx2mcaP0k53apol6p0Qa
	 hUy/gHXhNONHKHdUKHgapxd2UWKvDfsJzGPZ1nualJaWrq2gP2tDUioYtKqi2hY3ifg==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dkim=pass header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=nMJPgGq4;
	arc=none smtp.remote-ip=100.103.45.18
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7975E606A322
	for <stable@vger.kernel.org>; Thu, 29 Oct 2026 18:43:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=nMJPgGq4
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 2E4AC1F01824;
	Thu, 29 Oct 2026 18:43:37 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1793299418;
	bh=DMc9BN7cfB/ctr90j5iazUBHVgwBgpWajdm3rU7xVro=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References;
	b=nMJPgGq4YOm9Vt8ta5hy8Upe+FjAgJ2rhZ+jy2Y9inp2yFDUUcsnzZAnxTiaM5DV+
	 7Js/HPJu0bI2M6EGCT4v6R5X/aqxRlB/pn4FYUMbFcN8OOfxsMSMP756nCT63+zAcN
	 9Wxet4cnHORmv+O2zSqdUqRTCSd5i5190DibLBQwST6jBvyHFa00KgcKL0/zy/UEEN
	 sCLjI4wU6KS9BefMttiT7di9mKcy3ZzUCvif8qh721MG3sijncN0NSbUD/m4G79T5i
	 XTU9Mb68BvclhDY81tl7+W2SlcDLnYdMjKXTc9a34J8TaESSq6EAt6kG8BlxEx57pY
	 Fd0BZrmKDSARg==
From: Sasha Levin <sashal@kernel.org>
To: lee@kernel.org
Cc: Sasha Levin <sashal@kernel.org>,
	stable@vger.kernel.org,
	gregkh@linuxfoundation.org,
	Hyunwoo Kim <imv4bel@gmail.com>,
	Thomas Gleixner <tglx@kernel.org>,
	Kijo Park <red993688@gmail.com>,
	Oleg Nesterov <oleg@redhat.com>,
	Frederic Weisbecker <frederic@kernel.org>
Subject: Re: [STABLE v5.15] exec: Cleanup POSIX timers right after de_thread()
Date: Thu, 29 Oct 2026 14:43:11 -0400
Message-ID: <2026-10-29-1-daily-reply-0004-exec-posix-timers-5-15@kernel.org>
X-Mailer: git-send-email 2.53.0
In-Reply-To: <20261028122114.3429846-1-lee@kernel.org>
References: <20261028122114.3429846-1-lee@kernel.org>
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

> commit acb03d3881818581052924a9bbbe92b8741ed448 upstream.

Queued for 5.15, thanks.

-- 
Thanks,
Sasha
