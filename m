Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=100.103.45.18
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1793633629;
	b=O32boFqneRo57EWEGrw4zV2wJXtPLZdvoCMGnhsCTgs2c00MzFI6LTIwITI60F1b0GTc
	 AUZr5docuSq1yQ2liG/rhtwAgF9GXn9zlitvvutJmmlXTZpVeXuOCa9jtwATKEakpa+/3
	 7mtPJ7MI9p1Bs8Cb26CCRTPwUsd7M1HJlw9LvMxHm+wKCWz7FjNoGAUjEkLCPC5oRN3AE
	 H1Xz+Yl/YyKcGlAs5H5Yixz1A9RErr6Q5vKECeLGJaFjdpm7qVlZ1IXDPydJK1XuXtMsW
	 Due2XOvJvAu5q8SbQQP3qIY3oo6cwu//4RUoqRUVHx8OQxqIg44sQ/9o1JJAes4mYJA==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1793633629;
	h=Received:DKIM-Signature:From:To:Cc:Subject:Date:Message-ID:X-Mailer:
	 In-Reply-To:References:MIME-Version:Content-Transfer-Encoding;
	bh=o6ZJLk9d0zHqT0extmvqBIKjGWuG4RfryuZb4ZPaFeM=;
	b=kvjywPBLzBXVKZbB9FU5Sq6wFroMzC40gKuCi7PU9pMmRPqCAK5WbTNZGFp6MUInbUCG
	 hKYd9ySrZfl/+abS+QuQsjnNVVnuaMAbGKlroFal0J2aWGfPlN2yvnOWDugr8tzI81Zfo
	 TQF75Mo6gOYclMeSVkOiYdV0m03CEuaGInKe/4L1BVqSbP67B0Whi96FUmd4O9LPzcZbr
	 /PoE8QZUZUVCm/+f0ukcj6eWCusAMJwe4rNrhVY3eI8hXU89o0LbevuMeBn1eRIUi17yp
	 7AvAxA9vC44T+zokFxC9fO8XwHePfOk4oZusbP6aU1Iv54WpBlid8VvlS3l4l/k/I3g==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dkim=pass header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=nEAa3TOy;
	arc=none smtp.remote-ip=100.103.45.18
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5FE7B609FDAA
	for <stable@vger.kernel.org>; Mon,  2 Nov 2026 15:33:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=nEAa3TOy
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 380921F00A23;
	Mon,  2 Nov 2026 15:33:48 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1793633629;
	bh=o6ZJLk9d0zHqT0extmvqBIKjGWuG4RfryuZb4ZPaFeM=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References;
	b=nEAa3TOyd5co3M0Z1wr3USn6pkdVqlyNOQpcEL5DI31VmczoIfPDCDRYI/QB0biko
	 XWbzlovo/HwbplhG4bDWOZDMZLlZRmZLii9JGC1rjL4M/IL50vXpkoKcAA4C7D24Ow
	 41X9YYrTdymgCKr3PpC/nyYP2QKPZbxt5y1wUm05GP5sfBGZm79y0s5193IF5vv2sH
	 1gLGPZJLwXtls5es3xo+IPlcpFCrFfl3tFSI3GeZPF9w7lABpxkgcrL+fafYxLFALO
	 YSZLuECUvAmgEM7JFn5piQQPXnXPLZu/VUoeHMb1P4aowpedM7CkBkpNdfUN0xo9Ks
	 ho0aPBIv2bHig==
From: Sasha Levin <sashal@kernel.org>
To: stable@vger.kernel.org
Cc: Sasha Levin <sashal@kernel.org>,
	Qing Luo <luoqing@kylinos.cn>,
	Xin Long <lucien.xin@gmail.com>,
	Jakub Kicinski <kuba@kernel.org>,
	Harshvardhan Jha <harshvardhan.j.jha@oracle.com>,
	Harshit Mogalapalli <harshit.m.mogalapalli@oracle.com>
Subject: Re: [PATCH 6.1.y 1/2] sctp: auth: discard auth_chunk when skb_clone fails
Date: Mon,  2 Nov 2026 10:33:33 -0500
Message-ID: <2026-11-02-1-daily-reply-0007-sctp-auth-chunk-cxgb4-6-1@kernel.org>
X-Mailer: git-send-email 2.53.0
In-Reply-To: <20261102100300.1546414-1-harshit.m.mogalapalli@oracle.com>
References: <20261102100300.1546414-1-harshit.m.mogalapalli@oracle.com>
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

> Discard the AUTH chunk early via pdiscard when skb_clone() fails,
> so that the receive loop can continue processing remaining chunks
> in the inqueue instead of stalling the entire packet.

Queued the series for 6.1, thanks.

-- 
Thanks,
Sasha
