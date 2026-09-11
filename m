Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7CDDD457E45
	for <stable@vger.kernel.org>; Fri, 11 Sep 2026 11:21:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1789125695; cv=none; b=G3ZH4JWdrN49mBmO8Q0tZjwMltMAcPLKVZDZ61P6rlJkLWCsHWwKEYPjceH87Hpgg+RPrXNr55QBXF+J5kBea6pbngCHc0Ybsnv9BYB/+nRM2xjCR99sH3LPj9LC+/lEK4Q1hGsj5OqDuTlOf5IXBabc0P8xUlmrfQ/ARK2Fo18=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1789125695; c=relaxed/simple;
	bh=GNZpmQTB9Du2DhopH/QOw9Xmi2zvrD3bolpIYgq5RSE=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=vC9jpbbKGiWsw7pVXL4zTyeh63rPtLWI/Wz2GY6mIOlTdXGQJ4kwvP3mpAjtJ9p9GFldxW5RvXJMn+4YtjHScSOjQqJ/qpM1VDBsbQ1HoFENH7n2LdszyoxO77HrNm++GutzP8xAtOpRZtXrMgInaoVsyq1tBxnq7BENA/9NKaE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=Ml80mA8N; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="Ml80mA8N"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id D2D021F0089D;
	Fri, 11 Sep 2026 11:21:30 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1789125691;
	bh=UuS/LZ1eE74D8SNYjwyHlLA2QH/XqSEZT/6QJcsLE34=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References;
	b=Ml80mA8NDu/bK/RLGKBH40B0M0mAIHn82bK48YbgazUldpDsDscqyW5/0b2hTaUNb
	 Uf5QaeKmYRIZCC3hWHDqWd8qYGfkQV9ANhqaL0L89yILFE80qdiWALrUNEysWjhIeh
	 cJEsyLYIDAqmCjn2DD18rUGJZjUmUHZbPoUnYPMeA35VMmGVLH1kuBRTGVC6RjXvJ6
	 4DBmT5e48UlEPqnLFqZy5wJPmE2GKLkcgm636CiipQvP74R/boT9sOrvJWQKbj6vC3
	 /mVz2rAD9Z4YUEK4CrIsldouMCVexGGmPsVCKTe5Xb4Tqzr3EikgWryt+IVTYdezNZ
	 0t/zz9d0gSIsA==
From: Sasha Levin <sashal@kernel.org>
To: stable@vger.kernel.org
Cc: Sasha Levin <sashal@kernel.org>,
	Neil Armstrong <neil.armstrong@linaro.org>,
	linux-amlogic@lists.infradead.org,
	Martin Blumenstingl <martin.blumenstingl@googlemail.com>,
	Christian Hewitt <christianshewitt@gmail.com>,
	Jerome Brunet <jbrunet@baylibre.com>
Subject: Re: [PATCH 5.15.y] clk: meson: align gxbb_32k_clk_sel number of parents with actual count
Date: Fri, 11 Sep 2026 07:20:52 -0400
Message-ID: <daily-reply-0033-re-clk-meson-gxbb-5-15@kernel.org>
X-Mailer: git-send-email 2.53.0
In-Reply-To: <20260910072950.341030-1-jbrunet@baylibre.com>
References: <20260910072950.341030-1-jbrunet@baylibre.com>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

> The following out-of-bounds read has been observed by Christian on a
> GXBB WeTek Hub:

Queued for 5.15, thanks.

-- 
Thanks,
Sasha
