Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=100.103.45.18
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1793633630;
	b=XlFaPEiMl1VHSL7YsVr2IT9aN5etiwVUyUp3vJiEyhyCtBSc56/E05kxiTTjCiDCm0e7
	 pedDKTYohTv4Iqqtm0+9z108g++MvCw9Hft51f6XX/SeU/aSeLa6pFqFsFUzT4Zcmjnkw
	 JoLtapvzpkeTxwmXkfBtqYcRh4WlgodJ2m+VURYWrodtJtMUVyZALCsS3Uo2dMHsSwxbU
	 zz1/a7lTtzEPqji5xAHoZ50E2H2MSKpno89cATkV6nmAIVyZRG1MJYda+9F/3QEux0uAc
	 DSLkrG9e43HxLOrzDr0972slGZB9oUejwuLIxXh6iMocm84sctQym90QXGtCisaCXEA==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1793633630;
	h=Received:DKIM-Signature:From:To:Cc:Subject:Date:Message-ID:X-Mailer:
	 In-Reply-To:References:MIME-Version:Content-Transfer-Encoding;
	bh=9w/T1qxUcNkfnQM6qNThQKEStGTRJOfXaFqRr1vX6yI=;
	b=RGYU6QE+hFYeGTL+vIa3dCMQXB5/5JuyBW0qQkBh8toTgYTwpTOck75yq2goK3xU0LHi
	 x299xM86VHaAxipQsUpPFGsCtvJn8MV2QhM8xzB/0YdO7txk31wz5O5Jc6wVvEcJ6AquQ
	 bDNsA2bzVv7FZzFeCToN7u2l6U5WxjzlGbPbr+RGUzID3e6G1dyFUZQDGDVKIKa3ML8rc
	 CGUMLv+e3Ujd/HAtElb8+CrPoq4PgvsKKDT7RdKWO+DG60mXnrExzjm3bpM5cGOKRnq0m
	 AhDDKostXDOo14085hJKUODsgioAL1H//hvOWB6qsAQnCqlqS3wtG3LsrhBOTkwKZaw==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dkim=pass header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=ZJwdfafO;
	arc=none smtp.remote-ip=100.103.45.18
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D25CD608A36F
	for <stable@vger.kernel.org>; Mon,  2 Nov 2026 15:33:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=ZJwdfafO
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 457C41F00A1E;
	Mon,  2 Nov 2026 15:33:49 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1793633629;
	bh=9w/T1qxUcNkfnQM6qNThQKEStGTRJOfXaFqRr1vX6yI=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References;
	b=ZJwdfafOviK31nGuK13jWtucwhWZvbOh5Y/zd/IN7fPb0uWG9zyhqHOQugBAaPsKj
	 vCHb+Dq66ptTIP8Ae8KRwJBhmVBdMXpVxVaeLijYgZ2dUEY6oJ49wR0abPcoPwEBYl
	 ZlRpNSaUuQQhU+Cgl8v0g/TPcEdzAVMEdHiPvZsSAb2Mm04MIIiM1Z8arbHZc2BdcV
	 Yv0cRQiYu+4+yOT+BXIdc9ox560elqAYAG2bmp5rpFAW3f0ATP2dlLND+xd91HkRe7
	 t7Qkydyy7hAY/1o4pWqIQh/ZTl10xhsrCLUU+VeEsfnvATlsQxyMf2rT0ttivgfFPr
	 L6vZX37RmLlbA==
From: Sasha Levin <sashal@kernel.org>
To: stable@vger.kernel.org
Cc: Sasha Levin <sashal@kernel.org>,
	Harshit Mogalapalli <harshit.m.mogalapalli@oracle.com>
Subject: Re: [PATCH 5.15.y 00/11] Few CVE backports to 5.15.y
Date: Mon,  2 Nov 2026 10:33:34 -0500
Message-ID: <2026-11-02-1-daily-reply-0008-few-cve-backports-5-15@kernel.org>
X-Mailer: git-send-email 2.53.0
In-Reply-To: <20261102101239.1557688-1-harshit.m.mogalapalli@oracle.com>
References: <20261102101239.1557688-1-harshit.m.mogalapalli@oracle.com>
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

> We have backported some upstream fixes to stable kernel 5.15.y.

Queued patches 1 to 10 for 5.15, thanks.

-- 
Thanks,
Sasha
