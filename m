Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D9EA947F3BF;
	Mon,  5 Oct 2026 13:51:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1791208282; cv=none; b=HjFKsXIg+GQ6ME4V0QGF3U9G/NrX1LhjfBpz3PtWuZphNazjsnY1nYm0PNRf4m6Vxi87j7QTkhb08nHU+jboCSp1cF42XcSjRPjTuH7JgFtxcMgqH8awv/yU1tL33D/wUY19Q9TOAg/SzJ2xZwwmK8GB9ljAcE+gUXdPKOYUy4Y=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1791208282; c=relaxed/simple;
	bh=OOKue6oM0KIqYGMaH6GPJwC6Gp4nk6xYQ8ODVVUPCcE=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=NjeohDumGBPgwUwh6goiLzWVgOm0VjB0uKfY17E/xVLH3BtaYvca8Wxx2N2lK4OSP78tNd6X97Fgz47Ieg4aH/v2xvGDHRl3X4XSzCN1knCoTTWZAXZLFTKk1uYaU5ulGmp57PfClOtgnnKEZljcZFmZYl3645xGKEGK7BaU+LI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=QUcG1AOK; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="QUcG1AOK"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 3286C1F00893;
	Mon,  5 Oct 2026 13:51:18 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1791208281;
	bh=0xqc1KlxnzN/YnqXwvAUO/yt7HYXIVLINd8gRyYucJ4=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References;
	b=QUcG1AOK3tr4a5ClBfSWJ+9bfFEbw0pS/KrSpkJBbKRQem/mhzHy94yHMNCzHxkRx
	 Wvro4lxdQvoIjinGKv9CH9Wg8qs4yzxBUvunz+/G+CEZBMX6sm6slGAbXFSlw+5xnU
	 ML3/oOjTn43E0M7YuET8xcvysqn/8W41Q+673wviMngZfG3LRSgkqw9mHxwtKMYKT1
	 jyY8RLDSbqlBlW33PSbMcH75AZCCWziI7lz9lT3H97wRiMGfsNu2vo7C3veMH8MdlJ
	 CQQ7vpDpk79i9KuuwB9YBFij/xuu4qAiRAaqA6MVyS/podaTlsOniTb+1eglszpA+W
	 xzSABfsWnU6xQ==
From: Sasha Levin <sashal@kernel.org>
To: stable@vger.kernel.org
Cc: Sasha Levin <sashal@kernel.org>,
	Jiangshan Yi <yijiangshan@kylinos.cn>,
	Sashiko <sashiko-bot@kernel.org>,
	Jarkko Sakkinen <jarkko@kernel.org>,
	Peter Huewe <peterhuewe@gmx.de>,
	Jason Gunthorpe <jgg@ziepe.ca>,
	Jonathan McDowell <noodles@meta.com>,
	Roberto Sassu <roberto.sassu@huawei.com>,
	Justinien Bouron <jbouron@amazon.com>,
	Krzysztof Kozlowski <krzysztof.kozlowski@oss.qualcomm.com>,
	Gunnar Kudrjavets <gunnarku@amazon.com>,
	Baoli Zhang <baoli.zhang@linux.intel.com>,
	James Bottomley <James.Bottomley@HansenPartnership.com>,
	linux-integrity@vger.kernel.org,
	linux-kernel@vger.kernel.org
Subject: Re: [PATCH 7.2.y] tpm: fix off-by-four bounds check in tpm2_get_random()
Date: Mon,  5 Oct 2026 09:50:25 -0400
Message-ID: <2026-10-05-1-daily-reply-0004-tpm-get-random-7.2@kernel.org>
X-Mailer: git-send-email 2.53.0
In-Reply-To: <20261005075447.98992-1-jarkko@kernel.org>
References: <20261005075447.98992-1-jarkko@kernel.org>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

> Fix this by checking the response length against 'offset', which
> already includes the skipped parameter size field.

Queued for 7.2, thanks.

-- 
Thanks,
Sasha
