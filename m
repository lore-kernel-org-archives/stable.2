Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id ECAA037E2E2
	for <stable@vger.kernel.org>; Thu, 30 Jul 2026 02:40:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1785379256; cv=none; b=b+/th0WOChuPzDhmZgTMyDv+FyBrRbtZB5MdxtvLd+/1G+AREMiepQXBn9LibvznkuMIlvqVCkKaCOfGbKC9h2oSvwI8BG1v20f8xEBdi3KMGPvILRH9b77MivFiWzY+Ya3HH8xKWg41pezbiQ5lfvjoeb2RtjYJCIzR/6Kt+6k=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1785379256; c=relaxed/simple;
	bh=w2/Q4cgcD1wFPnI2s3NQ5YHTvoMIj46ddIYWXn0QGj8=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=q/HdkE2KIojZEk/81EdMhKTrSV3UHPHDxwPiXFRxhPX/Rzx3XkqJyIWbJoqpYUimKDBC47l6Ct0R4YavoBPoWSlv4XJ1UILO5QRJ19leCuRqUncoJoOH6TEDMBLMo/Ve26h3sE0zrck+SKVmZfIIJEXwd1wDOCFBBWjjaQD1Qk8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=c28Kr/BD; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="c28Kr/BD"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id F33941F00A3D;
	Thu, 30 Jul 2026 02:40:53 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1785379254;
	bh=883rLjcu7Y9JCS649ck1GK8UHH/0yCVI7WJYG4CXXnI=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References;
	b=c28Kr/BDQwE0tngdO/blNs66p4yvabzR8506vglt9G9T0SLdBGB95VfMQCMfBtqol
	 ghbB+6jwLTEwhiTThuiEoflK214Dd4ES0JIQ3bWEh8KUuEeqMWsSOW57YC2b4XV/vl
	 /Ur4WbW5ugvbHA1iwGkTRG/q4bztazGaikQP0zNDaBwuhefZ3Nk+awJmB3UA6X4tO1
	 LalvWO+YYIYHnIGW3n3YKAJgkK+EGtTCUNRChd1ZNqqTocGGMd6ePFjlY7vy/a/5bn
	 f/MRmTlY06kUspXDunpmXWDDxOmfW5bF4CuRwyr5mnbbMU++3vs9gXJoTBEKwTp72Z
	 p6/5iNveP2O3g==
From: Sasha Levin <sashal@kernel.org>
To: gregkh@linuxfoundation.org,
	yi1tang.yang@gmail.com
Cc: Sasha Levin <sashal@kernel.org>,
	stable@vger.kernel.org,
	Jens Axboe <axboe@kernel.dk>
Subject: Re: FAILED: patch "[PATCH] io_uring/rw: fix missing ERESTARTSYS conversion in read paths" failed to apply to 6.1-stable tree
Date: Wed, 29 Jul 2026 22:40:20 -0400
Message-ID: <20260729223316.stable-0027@kernel.org>
X-Mailer: git-send-email 2.53.0
In-Reply-To: <d9ec68af-793d-41f4-9b9c-d68b1cd51200@kernel.dk>
References: <d9ec68af-793d-41f4-9b9c-d68b1cd51200@kernel.dk>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

> And here's the _actual_ 6.1-stable patch.

The 6.12 and 6.6 ones came through fine and are queued, thanks.

The 6.1 one didn't make it out though - both of your mails in this thread
arrived here with no attachment and an empty body apart from the quoted notice.
The only attachment in this thread is identical to the 6.12 patch, and its
pre-image doesn't match 6.1.

Could you resend the 6.1 version?

-- 
Thanks,
Sasha
