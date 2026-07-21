Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 08D322343BE;
	Tue, 21 Jul 2026 00:56:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1784595398; cv=none; b=K8EVcodWvcObErrW/emQnM49yj5fhSDF5fPE8FWdS95iXeHLnNIHX1A8WvgbW3OFxgISvsK0N2DMfDVSB5Uek3EszbIic1MUPUYXEy1YyA6RrFhW5H+6X574C3aWuApTuDE+dmaI6G3lE+bZ7AU7WtGOTZfUrbzCq9Ej2bNEjCw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1784595398; c=relaxed/simple;
	bh=ffQeFcQQrwnueNJRQXpoci1eK0DtcMqI2C3NQtfCmJg=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=BONxkMHBlvZo1VzIK7aoyGyESZlT7b+hN6nm9QFOTs5mScpn19ma9CO2K/ICOE5zUVjtU6O1YQ27Ai15+cxdc3DmgDHRXAhO3X01Yxo6rzFdyd0wFcVwq9SQA3WdtYJdacUxPswLJnimX8lqfyg8zUj1T6JWj70jLYCkfBGqP1w=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=dZs8GWoQ; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="dZs8GWoQ"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id EB6F61F00A3A;
	Tue, 21 Jul 2026 00:56:36 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1784595397;
	bh=rxLkcj4io5mat7iJ4TQ4Cf+pU0vkC9pH/Z7lbtKmZW8=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References;
	b=dZs8GWoQlf9vtEVY9us8flp6pJcCYJnrB02p6Kp/zJ7g2OP0GUAVWE9uQ8m6pV7LS
	 RORNQw7+1et3BoW2yI7KeD7HpkbOAQh1Feh33fThSad8nZmdkoSwM0rCNyIBi8GAxq
	 0eNiquuMCW5k3b7q3tZqirWfgUeGNRpbtlB/Y+XzZST6DUcnBcQLolPfBNlNSYFH2S
	 UynVFYCMy9Uu6nB1uWhUi7bIqcYRQi8HfqgGjcCT5VxwXIdW/Vs9l2EVmyCgeOennE
	 nhlxib1k1LJmGxR/zMEObaLjLwUiHmTUhYmK4lmmdUeexoS9nRPJ4im3ObtNC3bame
	 jKnsfmLu9p5Wg==
From: Sasha Levin <sashal@kernel.org>
To: SJ Park <sj@kernel.org>
Cc: Sasha Levin <sashal@kernel.org>,
	damon@lists.linux.dev,
	linux-mm@kvack.org,
	Liew Rui Yan <aethernet65535@gmail.com>,
	stable@vger.kernel.org,
	Yikai Zhao <yikai@z1k.dev>
Subject: Re: [PATCH] mm/damon/reclaim: fix typo in damon_reclaim_timer_fn()
Date: Mon, 20 Jul 2026 20:56:09 -0400
Message-ID: <20260720175500.0002-stable-reply@kernel.org>
X-Mailer: git-send-email 2.53.0
In-Reply-To: <20260720094708.243937-1-aethernet65535@gmail.com>
References: <20260720094708.243937-1-aethernet65535@gmail.com>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

> Commit 2f54908fae211 ("mm/damon/reclaim: detect and use fresh enabled
> and kdamond_pid values") introduced a typo in damon_reclaim_timer_fn()
> where '!=' was used instead of '==' (unlike damon_lru_sort_timer_fn()).

Queued for 6.1, thanks.

-- 
Thanks,
Sasha
