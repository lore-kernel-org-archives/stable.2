Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id AFAA5446BF8
	for <stable@vger.kernel.org>; Fri, 11 Sep 2026 11:21:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1789125691; cv=none; b=nRcy5iKCkaHYEk65EVzvgCmQSdwYtO252dX2KbSj45W2p1hff7etyr7KQa8RSN0u7YL96pFCe7SCDP0UZV9SzBUTePOPsw1UhgEn4FOEZ0V6LOwRNGmDENJ3FpiEktaJW2qL1MonnNS6c4YyvLLt3ukVPTBXBykQEtuVV6cdJCU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1789125691; c=relaxed/simple;
	bh=ja9p2+LmKY+fOjxB/v6lQMHrwJzSOXcDXUZD1u4PMB4=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=ESOMeM89+sCa3EfYS0NF0q51vNjvUYt+VKforS6kPVLk+xU46TSrtNswZ9m8D3CAzhwCIrIrc6FL5jtMw8xeqAPGdzhNL17juTGqhaw1MDFENKKidz40RPXWIYNFt49wBp9diE48WXjWz6BpwBCr3t6i7oMTB2BfsCbFnk7BBg0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=mKfIYhb0; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="mKfIYhb0"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id B6F0D1F00899;
	Fri, 11 Sep 2026 11:21:27 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1789125688;
	bh=4pe+LR7D9aXkKO93/gzkVICF9QA1eqK2Dqa7ejkk/S8=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References;
	b=mKfIYhb05XlOxrEiAbcxFKTLlqo3aZYp0P8h9hUpTaN06tExLZU7hkke71gyvBcd/
	 loQb6A1izRDhZpTzaPmuUXidLx/iU6Jhen4qTsV228Sj8k5f/8dSn2GkBHnFZgopIU
	 P+QS2IdBFQfzKnsyqis5zmMc6jZx1/BuSBLo0V6P9Gl2MtP7yugakDcjB1VAhtned7
	 SY73V3ApHx8RpoA7uCL6/Wwp+5SY7XIFYsjjJSJZCQ87rBIqbLw0wdHpzuyBKIVtvT
	 /w6QiZ99hkkAscckXB/KGy9vlJxlofMu9wWicRBzdhQbMRa15AwVgC1rZ4B/08s2WL
	 zIsisl1RySu9Q==
From: Sasha Levin <sashal@kernel.org>
To: stable@vger.kernel.org
Cc: Sasha Levin <sashal@kernel.org>,
	Neil Armstrong <neil.armstrong@linaro.org>,
	linux-amlogic@lists.infradead.org,
	Martin Blumenstingl <martin.blumenstingl@googlemail.com>,
	Christian Hewitt <christianshewitt@gmail.com>,
	Jerome Brunet <jbrunet@baylibre.com>
Subject: Re: [PATCH 6.12.y] clk: meson: align gxbb_32k_clk_sel number of parents with actual count
Date: Fri, 11 Sep 2026 07:20:49 -0400
Message-ID: <daily-reply-0030-re-clk-meson-gxbb-6-12@kernel.org>
X-Mailer: git-send-email 2.53.0
In-Reply-To: <20260910072139.313775-1-jbrunet@baylibre.com>
References: <20260910072139.313775-1-jbrunet@baylibre.com>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

> The following out-of-bounds read has been observed by Christian on a
> GXBB WeTek Hub:

Queued for 6.12, thanks.

-- 
Thanks,
Sasha
