Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C3F9E10F1
	for <stable@vger.kernel.org>; Tue, 21 Jul 2026 00:56:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1784595399; cv=none; b=XkHtUx+tTSQ99Ialq5sUjUAtg7l/qVmQZSHPjEB4Dip7/Aj4kZmSDN8wYLpEmw1MICh0dqgQIeVIOje9KKCKJ9PCDm9Kr693l/Di6gmnBzNLZSGFJ+eaf4Tea2NkV4AnBP4nD6EnRW7FZcBtSsPEv4gLI+FrZTm4xqeoDinEOLk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1784595399; c=relaxed/simple;
	bh=cczH0LM7z6mHrpJI9RysewGrbBPG+gKKG8pYmhulfuQ=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=EKL89HZ/L3rlbQa4KTeggDVIuGq0gYM2HcJcvnMv9tVCrLTg8OJIYN+zA20Uq7DbnS3OfVINTiM0mPiOa3Z5ziIyKddoiAxEYjhzUBIx3UYx/ci61wGDFR+7ZYCVl3+uEklRzMsqZ/tx1McRZpGLwWryIY0QSeL+t4i71APZtgQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=T6eCD6Yh; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="T6eCD6Yh"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 01CAC1F00A3F;
	Tue, 21 Jul 2026 00:56:37 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1784595398;
	bh=1aGwhmTvOPNM52FMAfmTarx+cP5kpQCmbCBodYfqXSM=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References;
	b=T6eCD6YhzqNk7tY6WDGwLChzwwCO5KkzhPEa4eR0mfS8baC4piaYI1Ffzj5ZhZ1j6
	 J9JxhTisFSX8LsrA4cSalHVe01hwgMckwzQqw57O4pJV+Y5HMz2ZFRWvLXSiKdnboQ
	 zopTFJwWn5GIxaibC4VclkhyYVEQwetLeB7DcjljPlCEIQ2XAkfhvkuRRal+qpt+ID
	 gazXrs7ED/ltkqDCpUhMJ8Hn7Dsbz9cpIsjnLBnKX7I3PJ9T8QN8mEXsMWoyflLs7w
	 v78b+xkeif5gbIl7BHQvr5UmB8HvF6wGKre2Mcz7AlCHXUwy5R0rc9icVMzXHgvyFJ
	 75l84YC96Ky8g==
From: Sasha Levin <sashal@kernel.org>
To: stable@vger.kernel.org
Cc: Sasha Levin <sashal@kernel.org>,
	Shivam Kumar <kumar.shivam43666@gmail.com>,
	Christoph Hellwig <hch@lst.de>,
	Keith Busch <kbusch@kernel.org>
Subject: Re: [PATCH 5.15.y] nvmet-tcp: check INIT_FAILED before nvmet_req_uninit in digest error path
Date: Mon, 20 Jul 2026 20:56:10 -0400
Message-ID: <20260720175500.0003-stable-reply@kernel.org>
X-Mailer: git-send-email 2.53.0
In-Reply-To: <20260720134550.7632-1-kumar.shivam43666@gmail.com>
References: <20260720134550.7632-1-kumar.shivam43666@gmail.com>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

> Check cmd->flags & NVMET_TCP_F_INIT_FAILED before calling
> nvmet_req_uninit(), matching the existing pattern in
> nvmet_tcp_execute_request().

Queued for 5.15, thanks.

-- 
Thanks,
Sasha
