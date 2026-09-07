Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A26D94FDE4F;
	Mon,  7 Sep 2026 17:28:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1788802122; cv=none; b=K0g1E6xVklBC73ULdE76mt3fgRcPtAeNBPFxnR74IMfkkPmOFKPqKDRqKhw84ouUVup2A5AyuYCrrCADRimO61ZkHPGdu6Emz4wQIAgzmZw/diG/qSmdUag1pvzsykIDVY1tOKqm8Yw56uSXIINMbQXjQsVXTgHWhyYKoek8eec=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1788802122; c=relaxed/simple;
	bh=vXwLNfHPzU8bfsofq4g8bmwUYL5F0bhrd10fUU0cZT0=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=lZxu06PrLc1kc1FI/Ql1zDLixlaGuTXiRCQUC8qN++YELTz0P1FHcck/ATapeHunnbDfaS7/tg4lvwwjZKHvREgQPHm0s/vpxx1Ugx70AmxyKhbBeXu9Lm/i9v1KTywarG7PCN+heYiESkHwWuZ+4F7dRnH0FQ/J5PjKIjLs5X0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=PYW1rCbZ; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="PYW1rCbZ"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 045F01F00A3A;
	Mon,  7 Sep 2026 17:28:40 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1788802121;
	bh=5b/sg7nRQD9/2QrfkHXPbfXaDTnpNCHth002k6PlL6w=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References;
	b=PYW1rCbZTZK99N+NNFGs7g/OHBV3T9qv/759RQ4v6LlXSkJ2M2a128/B1bdIaxXiN
	 5gvQxG2k5CpBoaJC9t/yFqaiCKSsnDMm5ncqUSG7xSz9uBwyPVrJYpAd8PZBW1DwdS
	 7MQG73viD3iqAfSx5H3LSBirkbRRQFY8UQ3PPQUU2wi6wOAX2Yh6wcaqUIV4CYBRJJ
	 f+I1jPepRGT9vQfbvrexSaraqe5iImI36nqXHWZvskLwPhdRZmzQ++s3b3NoncP5Ff
	 73LRe7TTCFuEfILDGmnK/iqP69dlFoKRAN9lqsvyeD9M8l7qnmhJf0jIoUMrjMXz3Q
	 rnEiPxrVlZXUQ==
From: SJ Park <sj@kernel.org>
To: SJ Park <sj@kernel.org>
Cc: Andrew Morton <akpm@linux-foundation.org>,
	stable@vger.kernel.org,
	Enze Li <lienze@kylinos.cn>,
	damon@lists.linux.dev,
	linux-kernel@vger.kernel.org,
	linux-mm@kvack.org
Subject: Re: [PATCH] mm/damon/core: reset invalid quota->charge_target_from
Date: Mon,  7 Sep 2026 10:28:32 -0700
Message-ID: <20260907172833.102388-1-sj@kernel.org>
X-Mailer: git-send-email 2.47.3
In-Reply-To: <20260907165529.98874-1-sj@kernel.org>
References: 
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

On Mon,  7 Sep 2026 09:55:27 -0700 SJ Park <sj@kernel.org> wrote:

> DAMOS can suddenly stop working if a target process that quota just
> fully charged in it is terminated.  Fix by catching and processing the
> corner case.

Sashiko found this fix is not complete.  I will post a new version.


Thanks,
SJ

[...]
