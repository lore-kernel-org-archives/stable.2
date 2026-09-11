Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 77C4842CAE0;
	Fri, 11 Sep 2026 13:50:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1789134613; cv=none; b=tZRt0cQNXYXvJkVIyydemPu/PNV62AiXpbIjD+KM4hUtaH99KwRJy6q1LLAW7Avh5X+SglUXgM9CtzQEyjiRIBxPi6NrQQT0giENJHs6Dx97Wx4FZ32msUSHMVlKvz7DeLeGuRSnx41RU0daNj6I/dTNQAD+sjMnt0NbM5p/sSA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1789134613; c=relaxed/simple;
	bh=7Pzy7LvWFGWYqG6GDWL/XEhVYrgoAF/P3PtZzPJ66+M=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=G42C+BFVg2A9gruMsOqkU8bGS/lvJ6IjA+mR22UE7MmldTQWksbNXj3SoeYutTgpEcWWogCO0AwKY+q09IcImZJPlnFfoFT1GiApHMtZ0u2ApR/BPOYK12EbFxcJmtTuLfAOE5De8OSfis2Our/faUX8fqXL10R/kKtdj0Lg1mE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=Iny5Vh+f; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="Iny5Vh+f"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 3218D1F000FF;
	Fri, 11 Sep 2026 13:50:10 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1789134610;
	bh=jf4tEdG7wS1eKtvO5jxzxOIw28OrD85vJr2G5HeEULU=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References;
	b=Iny5Vh+fJlmKagwMCxsj3E+d/FrCqsLmJZYcYftr3qBJFz/XSeLm7iHRX5mg9qJS1
	 knizZHah/injx3xRLoNYDVPRB69Bczg+or7ItfcnRUqIskgDYPxg7s9FXMv/7E6Faw
	 DqnmkgCtG1VJWmclQRaxa8aXOXAmJoiySbzcpeP1Rn9b0nA4PnAD0t4xvjiePE0Nue
	 BqP7HpgJLBkjs7j1hMIf59UFCHtLEPH8NdHBkuXrcVorVEAnF6yCqzy9Ed2W7IcPV+
	 3xMNDyU3bSEr+z/4LkyjJqbDG+UdXhh84Adw4PY0xJv+qsEmnEv6S41Se0IcaNxJM3
	 meEPLqpef1TuQ==
From: SJ Park <sj@kernel.org>
To: Sasha Levin <sashal@kernel.org>
Cc: SJ Park <sj@kernel.org>,
	stable@vger.kernel.org,
	damon@lists.linux.dev,
	Andrew Morton <akpm@linux-foundation.org>
Subject: Re: [PATCH 6.18.y] mm/damon/core: avoid infinite kdamond_merge_regions() internal loop
Date: Fri, 11 Sep 2026 06:50:02 -0700
Message-ID: <20260911135003.96395-1-sj@kernel.org>
X-Mailer: git-send-email 2.47.3
In-Reply-To: <daily-reply-0037-re-damon-merge-regions-6-18@kernel.org>
References: 
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

On Fri, 11 Sep 2026 07:20:56 -0400 Sasha Levin <sashal@kernel.org> wrote:

> > Sashiko found a few issues in DAMON that could cause infinite loop,
> > NULL dereference and monitoring results degradation.
> 
> Holding this on all five branches for now. 6.18.y is newer than 6.12.y, 6.6.y,
> 6.1.y, and 5.15.y, and it needs a fix here first, but the patch you sent for
> 6.18.y does not apply: 6.18.y has since grown a count_age parameter
> through the same lines this patch touches.
> 
> Could you send an updated 6.18.y version rebased against the current count_age
> code?

Sure!  I just sent [1] it.

[1] https://lore.kernel.org/20260911134904.96369-1-sj@kernel.org

> Once that lands, the other four branches are ready to go.

Cool, let me know if there is anything that I can help!


Thanks,
SJ

[...]
