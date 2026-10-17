Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 98B9F3BB116
	for <stable@vger.kernel.org>; Sat, 17 Oct 2026 03:00:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1792206039; cv=none; b=ZX76ph1jBdJ0nofAfO31N/KsiD8vkg7DAmyNh3cyjEpZIpoEj84u5Ex7U/x0Wq4/uFbsWRV9k12kXSKbRJEEcCPO4SOGHbJZjahoAHw8kpVHJ81NnkZUJTY0aB24zbDypYeVrCiMwy9YyK5eG9HFVpaXWoyuf7SM3RfeIe16G5o=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1792206039; c=relaxed/simple;
	bh=shBzYMw5/XcmINyEWiM4qXkPbgxCQy2lHzY6A6vCjrA=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=eB5YTG1fTlAQt6I34G1rBwdroVSajJ1Z21+sMYaA7zqW5Voy2BMNC11VSESgy0qrbfiQR8TBeifK+GH2LKoiZk7FqTuLVkENUZ/f5VZoQE64obEVxaItp0maIMeMKcEaHxlP4VKyqZZrMpfoDlKPKFgB4fmuT/JLTW/zweCqVwc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=KIjYxACd; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="KIjYxACd"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id A13661F000C4;
	Sat, 17 Oct 2026 03:00:34 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1792206035;
	bh=gRZKJNmuAWUIp8qiImd5y6Jd1ejj25DEVS+zR7FuFc8=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References;
	b=KIjYxACd+UxXwn/AQWqpkfAc4Oa4hDxU/i2MXlLf4c8n9Ienbg3KOTmqcXYi/FRbM
	 78ptnPnPEfiEU6OxMBYQqwMVQi9zVeGM1A1w+Cqj0N1p8E7+g2dNY6lzrMN+VE+7Gk
	 vfZD4Qrl5jUNtAEMzUPPhAewutM1PG3fjK6vhinyjI4gET60EkXG8PAg8fldkavSFo
	 18Xu/3PoGcHvosX7EYWBHD6JLv3RmDrKu7EKz4VR9wwRwLUvaTokrWurTZxGD2Qc9A
	 MdSeaWEnGlM1o/fXfaszI9nXGYLg9yAV8HIKZZ252SCSEU4lwxj8hKumONICtkun26
	 wqXxDKp81VQLg==
From: Sasha Levin <sashal@kernel.org>
To: gregkh@linuxfoundation.org,
	hengyul@cs.unc.edu
Cc: Sasha Levin <sashal@kernel.org>,
	stable@vger.kernel.org,
	Jens Axboe <axboe@kernel.dk>
Subject: Re: FAILED: patch "[PATCH] io_uring/kbuf: don't charge provided buffer rings to" failed to apply to 6.18-stable tree
Date: Fri, 16 Oct 2026 23:00:14 -0400
Message-ID: <2026-10-16-1-daily-reply-0009-io-uring-memlock-6-18@kernel.org>
X-Mailer: git-send-email 2.53.0
In-Reply-To: <c042f86a-750d-4e9e-bb7b-b5c86cbb6a7e@kernel.dk>
References: <c042f86a-750d-4e9e-bb7b-b5c86cbb6a7e@kernel.dk>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

> Here are the 2 accounting patches adopted for 6.18-stable.

Queued for 6.18, thanks.

-- 
Thanks,
Sasha
