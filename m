Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=100.103.45.18
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1793468858;
	b=2qhKqr3AlCwit2zjnNpo/39ryYfBY0eXDqowrKR02hJP568DtiFIPO6Iv/k8UA39PuXs
	 vUis0KqimQBhneZUnVDyRjI2p2SMbL199qBqIjMhvT0fb+Xr5Ijx4jIMkAAeHAB8R4N+V
	 QebSGeuqClM/MMdgQoQ67B5wB0R/TyrDx87qSKrmdb+a9cuknwF9x9sJ6VMQCeNBsQIH2
	 IvJkPvoa0dC+bUBy+sXnrfVv0G90b8S7gBWBB9KuYKWDXhAjV5Z2aePgULMxCmooUSCQJ
	 nL+4jC+26RYjtBYSJCKkmcq05B6pakaPSUf+I8EFjZp0lQ+NzDlklg2pNFTZTGYTcCQ==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1793468858;
	h=Received:DKIM-Signature:From:To:Cc:Subject:Date:Message-ID:X-Mailer:
	 In-Reply-To:References:MIME-Version:Content-Transfer-Encoding;
	bh=1h5N+uXBUkAc2XasWbf+L9wwWxu8fi1nQyRF01jT8d8=;
	b=SD8bw2jn6w30eJBbV2RVL/26kUoJR7IKVusQOVGv1JeO85I9A4ReciCCrczK9RqvrbUx
	 37DWP3cjEA8JTvDEfVtv96A+pTPBILk7cu0BsSd5HHo44cttGQvL7ZplZOX9NgQPmcdMQ
	 /oux/WoMueJ/r8F1Nk+bnl280D+HJ1GRDeW7K8we162aRWkYI6BGlHUQBcnBqXLoiTDSS
	 4bhE4q24hJo1D6HVE2sUWsF97sgJFMTH5LASEymD8iJcNcKiSivFxpkz+PIxuXzCm2kCu
	 87I9GCCQogBYp2prs+F7wE2bFMCJm4d2vjv/PoGYStwZJdoVul5brSK3RKP0wVtLsiQ==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dkim=pass header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=lbuTd6xN;
	arc=none smtp.remote-ip=100.103.45.18
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8EF55606A31C;
	Sat, 31 Oct 2026 17:47:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=lbuTd6xN
Received: by smtp.kernel.org (Postfix) with ESMTPSA id D12FC1F000C1;
	Sat, 31 Oct 2026 17:47:37 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1793468858;
	bh=1h5N+uXBUkAc2XasWbf+L9wwWxu8fi1nQyRF01jT8d8=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References;
	b=lbuTd6xNnxzdilE1w0rc0CBCjKyKLmuTFN0ZkPJp8l0CHMEMCSa0pedHFdUP6VI5V
	 4w7flaCig/G2AcBK3nVYftBnflhgxu/FJXeI8MZ/cSp7jpuuU00xtTQPpgCYh5ElLA
	 Z3m1Xp0xWuVyP3dGnyhH+KLqvAv+dqucYOrVv6fwjoJNRK+nGmd1lRJkIBgyUYYraJ
	 EC2NyWGK/s6iE261vlWHrsSqQSEroUYKuD9DQIBqiN4wpCFkRP2L/ROm2C32Kmzb/5
	 /XKZycPwA3ssUx+64jaA8lO72VWn2Rx9jrII7xA8QqgiQf820IlPUcN52gUviFg345
	 W8lpSSTJOZAcg==
From: SJ Park <sj@kernel.org>
To: Aveline Noir <jm5905938@gmail.com>
Cc: SJ Park <sj@kernel.org>,
	Andrew Morton <akpm@linux-foundation.org>,
	damon@lists.linux.dev,
	linux-kernel@vger.kernel.org,
	linux-kselftest@vger.kernel.org,
	linux-mm@kvack.org,
	sashiko-bot@kernel.org,
	sashiko-reviews@lists.linux.dev,
	Shuah Khan <shuah@kernel.org>,
	stable@vger.kernel.org
Subject: Re: [RFC PATCH] selftests/damon/sysfs_memcg_path_leak: define ksft_skip
Date: Sat, 31 Oct 2026 10:47:25 -0700
Message-ID: <20261031174726.85433-1-sj@kernel.org>
X-Mailer: git-send-email 2.47.3
In-Reply-To: <179346448183.4.15545164251841296990@gmail.com>
References: 
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

On Sun, 01 Nov 2026 03:34:41 +1100 Aveline Noir <jm5905938@gmail.com> wrote:

> Hi SJ,
> 
> On Sat, 31 Oct 2026 08:38:58 -0700 SJ Park wrote:
> 
> > Thank you for reviewing, Aveline.
> 
> Oh, looks like I forgot that. Thanks for the reminder.

No worries!

> 
> That also gives me an idea: maybe I could build a modular tool to help
> write emails. Building on b4 might be a good starting point.

Sounds like a good plan!

> 
> Tested the non-root skip path on x86-64 Linux with Bash 5.3.20:
> the exit status changed from 0 to 4.
> 
> Reviewed-by: Aveline Noir <jm5905938@gmail.com>
> Tested-by: Aveline Noir <jm5905938@gmail.com>

Thank you for reviewing and testing!


Thanks,
SJ

[...]
