Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B6B973CC7CC;
	Wed, 30 Sep 2026 10:03:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1790762588; cv=none; b=jPXl+sdGaYoEcb+OtqJVTVl1wkV51NZIDSS+UDqDOMtdNAPpWx1l3KNoTNUS8CQB/2aCJMYNFVsGBi9jsObQoejuTW/56iWwIcE8amWqp8vn6IbR9IpF4EVCWvFoi2GHvKksZdXtnY2QQNEwXecPxOoPHZBpbx0FmKx/BEyiLAc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1790762588; c=relaxed/simple;
	bh=rWYELaz6Pm9VL3xlGQUsd4lOzrcgZxc2ONevk6bqnF4=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=tbrQhKtcZx12A1sUG2iiJRs2KC2FO/ueJZaA2K7NSk1VBc0prbpVKKY+o0OlHY/lTrXgfUk+Jgpjp2XaUan5qR0PpCbgRmYhwTqJ1/j0SM5bShDsYX7iiurAIEx8czQamkG2nGD7UOSg0gR4PJv6gA2APevNZropbfPf/tU3xAA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=fVDIrs1S; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="fVDIrs1S"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id BB1161F00893;
	Wed, 30 Sep 2026 10:03:04 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1790762586;
	bh=fzbzrLJVj9wrWMsyJpvdurle6PMjA/FX6l5Eo0UNBOk=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References;
	b=fVDIrs1SoJxsaen7Q4t9NI3p87ynuyavrfvSBXW/s7N8tmFr7HlvOz0elDOY+r6i0
	 IwH/+u92oq7B9gkE05fLbSNuhQS8Vv/ZljdlS6FEjrGyzXtcWkVk4PkjnXRsQj3nIh
	 9obzs2dYTjeXjkOMgqfRlZgXakWQPXLRADekrEcIe8w1dt3nbLFYwm+ViP98dnojZr
	 Cy0zvPjU29TTCLqpb5G5EjY2HxfPd7TsHtw98cwAxMh9Ys8puT6ALbf+0ybg47o8ZX
	 6MHKzsnC0bvjb3zjtOPEsy0E3VDFtY0fSoEfXquR2bU7f5ug5ftBTYy/b/eGTftRlm
	 mjsYcc3zNQVXQ==
From: SJ Park <sj@kernel.org>
To: SJ Park <sj@kernel.org>
Cc: stable@vger.kernel.org,
	damon@lists.linux.dev,
	Liew Rui Yan <aethernet65535@gmail.com>,
	Andrew Morton <akpm@linux-foundation.org>
Subject: Re: [PATCH 6.12.y] mm/damon/core: fix unconditionally skip last region
Date: Wed, 30 Sep 2026 03:03:01 -0700
Message-ID: <20260930100302.53089-1-sj@kernel.org>
X-Mailer: git-send-email 2.47.3
In-Reply-To: <20260930092829.45885-1-sj@kernel.org>
References: 
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Hello stable team,


Please ignore this patch, I made a mistake while backporting.  I will send v2.
Sashiko found the mistake.  Please refer to my reply [1] to Sashiko for more
details.

[1] https://lore.kernel.org/20260930100106.52943-1-sj@kernel.org


Thanks,
SJ

[...]
