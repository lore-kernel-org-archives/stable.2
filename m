Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=100.103.45.18
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1794184493;
	b=tCjmntLboxaohXZpkxZfhEe1yMM7cjdszKS54Ort+R7iqFzAetjBK0jRvFzy1t9rzO6P
	 LijcEqfgYARAf+aLn3gg0kFVrQxfc4P2jXg8IRGyLSDYJH5FMaO+2GxWikto5W+jI7pJO
	 N5ohUOt9zLZsFxv1V3LmwIlrASIUNPgT7pGMVtaxIYOpMJgWaRTt2rvNka/NHzxS+PSbR
	 pMsupBHkvrnPAGODSBHlbj0i5d0VXLk3WGSVUER4VLwWWSuiFd+ic/D4np3p9PmTTyRwh
	 HiAij1No6ll/KDOP56CiMY7NbvofgV/ESu9LQZjbBlHXKnsw7dJcU9XoJjC0YGsfrug==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1794184493;
	h=Received:DKIM-Signature:From:To:Cc:Subject:Date:Message-ID:X-Mailer:
	 In-Reply-To:References:MIME-Version:Content-Transfer-Encoding;
	bh=fjN+k1QsHi2Msev8dUXF0/G92l1mgax72cZH0OJYxk8=;
	b=EuTOIsvNnfAcdDudaNOam0APY5Ba5NUXBtt29qdcDy+VvPms2COKm+j0NuYWkLNfkCJi
	 1PqvTp7yX5ZO607Zr+OtSZmfKn9/Wa6G7CYqgTC/JH2IHna0+sMmCtfhcy1YWJOPCUKa/
	 Kc8Q8fFYeT1bJAK/Iw9HYBZC00uiVCwp9Ki2L3vFN0Bw75RYE1o/eNJGVC+M/5nBjOaXC
	 Oa8Y12XHCXPNDrbyAgerMr2CjtpUGYegZyoVi1tIpj6FYY+Nb4jsz8WJT3zs/qK4PAFfF
	 jPCP4RYnnNfjKXoO8EHmJa6sbVTXt7kXwrDNuAqPMX4L2gE8l0St96CH4VCefS0U1kw==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dkim=pass header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b="cl5s5o/j";
	arc=none smtp.remote-ip=100.103.45.18
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 57EDA60A382E
	for <stable@vger.kernel.org>; Mon,  9 Nov 2026 00:34:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=cl5s5o/j
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 73B5C1F00929;
	Mon,  9 Nov 2026 00:34:52 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1794184493;
	bh=fjN+k1QsHi2Msev8dUXF0/G92l1mgax72cZH0OJYxk8=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References;
	b=cl5s5o/j0o5Ds8F0lOCCmK6uOhyqKNTN8D/w3P4fAEwGhsy5B+JvtIubev4QjTjyd
	 aahaAX1iegcyeS5FVUkYSWG5sIBJcCvh81tD5ciLQvfNyDPoUJOzWQGOmVz62nwaal
	 5XAhvOmy9aqwLsRPxHGPwKaVVI1g9o523AUFNG77PtHpn/LIurL/W97qmvALdwXFMZ
	 f8cgHu+p28AD4VgTztETBm7IYH+VVvDb+RSGu62LurmJ7D5hCPPn6vUABmv38MRwV5
	 iD7DQJM0YDqun/B/bUZi0qVq6HscEOWoXQaDJeVnBwBD+9HOq9nzizAWYwZ/EAin3c
	 PeqHMdQ2qpDzg==
From: Sasha Levin <sashal@kernel.org>
To: Rosen Penev <rosenp@gmail.com>
Cc: Sasha Levin <sashal@kernel.org>,
	miquel.raynal@bootlin.com,
	stable@vger.kernel.org
Subject: Re: FAILED: patch "[PATCH] mtd: rawnand: ndfc: use devm_platform_ioremap_resource()" failed to apply to 5.10-stable tree
Date: Sun,  8 Nov 2026 19:34:38 -0500
Message-ID: <2026-11-08-1-daily-reply-0010-ndfc-5-10@kernel.org>
X-Mailer: git-send-email 2.53.0
In-Reply-To: <CAKxU2N9mXdar0Pctgck2scdwSncajE2jbzuCsruL7FvwsPP4Sg@mail.gmail.com>
References: <CAKxU2N9mXdar0Pctgck2scdwSncajE2jbzuCsruL7FvwsPP4Sg@mail.gmail.com>
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

> Requires cceca8cb776b03e83985578f84bd730c30d57f70 as a prerequisite. I
> guess I messed up and didn't add a Fixes: tag to it.

Thanks. Queued for 6.18, 6.12, 6.6, 6.1 and 5.15, together with cceca8cb776b
("mtd: rawnand: ndfc: fix gcc uninitialized var") and 4f2692a5383e ("mtd:
rawnand: ndfc: use ioread32be/iowrite32be and allow COMPILE_TEST"), which
0d66f9895f28 ("mtd: rawnand: ndfc: use devm_platform_ioremap_resource()") needs
for context, and 97f9e509d839 ("mtd: rawnand: ndfc: add CONFIG_OF dependency")
on top of 4f2692a5383e.

5.10 is different: 4f2692a5383e conflicts in the Kconfig there, since 5.10 has
no `select MTD_NAND_ECC_SW_HAMMING`. A 5.10.y backport is welcome.

-- 
Thanks,
Sasha
