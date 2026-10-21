Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=100.103.45.18
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1792541309;
	b=owlvBO087+GnG3f4Jb96reGOc9XoXN6DvsIZKjD9efZyNg0LE4m3sXT7vOIqDwYvaiBV
	 yQdhoCDZM9ajCgy2bWdKnNvCAcaQWeauTmCT0dzB6nyVv5/Rx7HSkOVv39lCbaEP0RkmG
	 wFoSMufDrpECYYXDNhCaDB9GEqLUGrfjnlFejdEqC3X1LgyXvDeAhZGETy1fBDbzH56FI
	 LILdgTvoOr30RLPjTV3w382tgjYLxFB7sxSzqAH2UDstxKVpVl7i57R6MfY6tifShCG2z
	 7l9J7UJH3P2kBZjxNvr+RD49pT8dl0owVV81q1mnMiQqp5cqYStDVOBxfj6tL6J+J9w==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1792541309;
	h=Received:DKIM-Signature:From:To:Cc:Subject:Date:Message-ID:X-Mailer:
	 In-Reply-To:References:MIME-Version:Content-Transfer-Encoding;
	bh=jJXPzkd8XW3cpVL1uiArgr6YP7UgpuG3A0mQModnNqI=;
	b=yKqv/GT/pE9fy1JStJX/Px5TtTR+642XfIYjSyyYlXXQr5uguRfrx5m2GlgAz+e+C2TU
	 /xH+c80zCgZQ2wc/mvlTlqwGAxRJvqZ6Iw6xYWlJ8NxTBjD16AKtRhVjuC3TlwptJIOri
	 9WuhsaR3R4//L7qAIeacKaZhnF/zYYzrDEWdUZuZ4tMnnKUxsYafttzjIGcAS/Sfu4rS/
	 IhPEKHRBoG0Bp33pAYxzBbYUl8jJifxGd2oowZppY3KfHwudNpRqF7KnCHYuXhNWsTJ1L
	 2vOvbXCzjhRSUa3Eo6AfO/JYITjPXfV2B7C07sXlE3lRTLRctqTJG0sN95SdmHYHn9A==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dkim=pass header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=gSGseXH2;
	arc=none smtp.remote-ip=100.103.45.18
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 29F4C606A31A;
	Wed, 21 Oct 2026 00:08:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=gSGseXH2
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 80C011F000C9;
	Wed, 21 Oct 2026 00:08:28 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1792541308;
	bh=jJXPzkd8XW3cpVL1uiArgr6YP7UgpuG3A0mQModnNqI=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References;
	b=gSGseXH2aPrlREkQA8yRXNzTOWZ8roFwh6IXr7h8Q8n5+6DIAVMNg2LRmGiWxcuTQ
	 tGEZfSyq4chtKjCxNdeL9YGhF1S1P35Xt8qIAzXSlbygl6MXTqMeSb6A9BP4zTNFSI
	 l/9SrCSUTYvMpkuk4wlRulU/DunO2o2dFaE3/TfMHyPHWy8IVsWvNvyQVtpkLuW0YQ
	 Hvep5qxnUvcK0tTIxaRwC8eABmyOL91RGmk8xztCVa5JAkIX9tX6f6cWJG/3JAxX4T
	 uhYSccvo6tuXdZbOL6zfS5Q18UqwcANOnNjCl+p22ixZxqZcg8E8QvokgKwOrvZJNK
	 +znIKCqjd+Ajw==
From: SJ Park <sj@kernel.org>
To: Aveline Noir <jm5905938@gmail.com>
Cc: SJ Park <sj@kernel.org>,
	Andrew Morton <akpm@linux-foundation.org>,
	stable@vger.kernel.org,
	damon@lists.linux.dev,
	linux-kernel@vger.kernel.org,
	linux-mm@kvack.org
Subject: Re: [PATCH] mm/damon/core: remove unreachable damos charge_{target,addr}_from
Date: Tue, 20 Oct 2026 17:08:20 -0700
Message-ID: <20261021000821.93515-1-sj@kernel.org>
X-Mailer: git-send-email 2.47.3
In-Reply-To: <179251032453.2.9019098760697634552.damon-quota@gmail.com>
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

On Wed, 21 Oct 2026 00:07:00 +0800 Aveline Noir <jm5905938@gmail.com> wrote:

> Hi SJ,
> 
> > Catch the corner cases in damos_adjust_quota() and reset the pointers.
> 
> 
> The patch looks good to me. I tested DAMON_RECLAIM stop/start after
> filling the quota on x86-64 KVM and everything goes well :)
> 
> Reviewed-by: Aveline Noir <jm5905938@gmail.com>
> Tested-by: Aveline Noir <jm5905938@gmail.com>

Appreciate reviews and tests to this and other patches, Aveline!


Thanks,
SJ

[...]
