Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=100.103.45.18
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1795555245;
	b=SAkV6RHoNrbFa1+7qqdtonLxJHeucFhqwhjnsSMwJO9GVgrmYszHiRGMlbLN5ESQ3Rk+
	 TiYkUUq383P2yctz8aufkw997EdubCxGSvWwdIPOV0d8V2U6bzK/TiB4L9kUrcfZ6syvG
	 +Zl2Be+7nkKL7kZB8viATqeCmgSIFQ92Zu4+N2FiQTgwG9nCj+8JMwFOReGytuxxCRP59
	 LhEljm8j6s1FHDU67ZugcvAHzk0W9AvCw2pqHTvRw6Hn+sRt9ayvoVagMVwzaRywv770e
	 ZhLw9M9FnWz4PlcOKEXxD1g1I8+k8tPtazoDysvO8h5SDeiQ3h1GyOAHuLh6dush9fA==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1795555245;
	h=Received:DKIM-Signature:From:To:Cc:In-Reply-To:References:Subject:
	 Message-Id:Date:MIME-Version:Content-Type:Content-Transfer-Encoding:
	 X-Mailer;
	bh=5TOKTFFCMEFyAZIkA+YJjPzgn8USwgBN9WGMKfiRu+g=;
	b=xI1J13j2vJ9Ps+D8w3N6kLhtCfjjJTihv7UlzhhRPfmxXMB45H34HpdPt7gDEJeaFtWq
	 gZegXSSCMPYWJJ4+2rjJBTX1BEcD5AVm0fdk07fZ4A2A6Y8mslwRI1HYuAm6y6MZNReiY
	 qvmGJEDGQP07TLW+bSDYu8Ami5yk7WCgAlBVwqOUYkYgiQoQb4BVdoJ/OquJOynHzTkYo
	 XP0fZgQ8UaSIngMiVZ0nDY9bYAiqNynnKgVhcvJrJwRTDoQQWzoXEsAZyE4Nyn1k6kzAY
	 mmtWZxupk9bVA7MKpByFD9I9+6z352ZralVxm3p6VDrf79LXiJe5kXYZSg38PzOGrvg==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dkim=pass header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=jpv8rCyA;
	arc=none smtp.remote-ip=100.103.45.18
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C0B0F606A321;
	Tue, 24 Nov 2026 21:20:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=jpv8rCyA
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 6EC791F000C4;
	Tue, 24 Nov 2026 21:20:44 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1795555245;
	bh=5TOKTFFCMEFyAZIkA+YJjPzgn8USwgBN9WGMKfiRu+g=;
	h=From:To:Cc:In-Reply-To:References:Subject:Date;
	b=jpv8rCyA6LYR8eNgYMbaOpwHmWuzhE0a+L1eFG08sFsw4tbSNqiKtRDxe0E8cvIBN
	 WSgIF4mZCLyiAL/ex7PyGkNtacyGMj/gF74VU3vaHEepdMCwCAR8RXBM1WZ71NQzeW
	 M/zyjzvG6M7iUYelE+iZ88rl19fKopPYoSF/7PoRphBGEAc/Sc8vvIvoxjF6LLkk7n
	 vdI9TUEhVjt+0id8u1wOgID2rJc2VvwnQh2Cps2CeXRn0QCEyXfTltrVUKUstrF1yx
	 27HIZBssWCZlCZI4mP0J4zHgLKajypumX9U6TxdkUIql/9aFCL7C54wTu+qtiV37Ny
	 p1fWGC+x9oYEQ==
From: Srinivas Kandagatla <srini@kernel.org>
To: Greg Kroah-Hartman <gregkh@linuxfoundation.org>, 
 Markus Schneider-Pargmann <msp@baylibre.com>, 
 James Hilliard <james.hilliard1@gmail.com>
Cc: linux-kernel@vger.kernel.org, stable@vger.kernel.org
In-Reply-To: <20261117-submit-nvmem-dt-cell-name-v1-v1-1-491cee782e6e@gmail.com>
References: <20261117-submit-nvmem-dt-cell-name-v1-v1-1-491cee782e6e@gmail.com>
Subject: Re: [PATCH] nvmem: core: validate DT cell bits before allocating
 the name
Message-Id: <179555524419.419683.13845924822424310192.b4-ty@kernel.org>
Date: Tue, 24 Nov 2026 21:20:44 +0000
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Post: <mailto:stable@vger.kernel.org>
List-Help: <mailto:stable+help@vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
List-Owner: <mailto:stable+owner@vger.kernel.org>
Precedence: list
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
X-Mailer: b4 0.14.3


On Tue, 17 Nov 2026 15:14:46 -0700, James Hilliard wrote:
> An invalid bits property makes nvmem_add_cells_from_dt() return before
> it frees the cell name. Allocate the name after validating the property,
> and fail before invoking the provider fixup if allocation fails.
> 
> 

Applied, thanks!

[1/1] nvmem: core: validate DT cell bits before allocating the name
      commit: 98de33870444c60adcd05d8301d86f7ad37af1f0

Best regards,
-- 
Srinivas Kandagatla <srini@kernel.org>

