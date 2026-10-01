Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 61F6A519912
	for <stable@vger.kernel.org>; Thu,  1 Oct 2026 13:52:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1790862760; cv=none; b=pGgrQBOkvMWn2mjBTHg7sdT9yTJuUiH3b8Mbr3DBUen7hC2S9+xgMv7ikCGAMGdWv1fOam5Nj3VvfsegQcyehC2TKUKSxCPu/mA8NEe5ndnWPTAUNAPA+GVRt6vxlxzKv3SG4+3V43QfdES3/AgF9Ox47PJ2Jg5ebBFvx46HFK0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1790862760; c=relaxed/simple;
	bh=8uq4eR66lI3NQjDrv/sOGzFgiTpGRGqTHnfNH82Zvt0=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=IAxeHE+Z7rcB6kWTzhbZd/Ncr353hxJRr8uq1uwIst8K+ebO/m1i7Rfm38He2gv/CUmqa/SU+hrvI3WlgV+F7oRmIE5hlrTg1Wa2Xku6LJJ9EuovkrVuLPQe8RVuH8Aj4oQLytN3fZgrbThuBHWdHRaWD0Hbj4XNFGhH5xGA0lc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=Z+azuk1X; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="Z+azuk1X"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 716331F00899;
	Thu,  1 Oct 2026 13:52:33 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1790862754;
	bh=ToO6RzP1hGUHg9CoFo9Em+OvuaShKjbfQSpSMsY/Xm0=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References;
	b=Z+azuk1XA5C3IMCsreGnnoxrsx+tXRNwGM5lIdMvJR9S8LxEHOZH2UxQcNvIPaL1Y
	 j3xfbb8k7NiMw9xmmIpc0aj3VGeMm5TCf2rHdc5Ey/1eH/VZu4y45XYLLXf7qnqh6H
	 YhRln0SGsSo1kKJS5yMqBMzI69esIwg6bivc+LMh2W5NhC691rCw+/zXoKZcaqGM7P
	 vFUW3r6HAANf+oIOphz5Hlkbon+NdXV1jLSlZ5/yLMCOGNj2DwkVF1UsOghbg3SAZJ
	 UGkNs7hcUFZ0z+83EHr0AcWMOgNMPdZj233t2OigR0ZXW0bygwgFNm9SYDeQcrH0ol
	 bLg8SjrGxRZgQ==
From: Sasha Levin <sashal@kernel.org>
To: stable@vger.kernel.org
Cc: Sasha Levin <sashal@kernel.org>,
	Ilya Titov <ilya.titov@wirenboard.com>,
	Linus Walleij <linusw@kernel.org>
Subject: Re: [PATCH 6.1.y] pinctrl: sunxi: keep a shadow copy of the data register output latches
Date: Thu,  1 Oct 2026 09:52:11 -0400
Message-ID: <2026-09-30-1-daily-reply-0007-sunxi-shadow-latch-6-1@kernel.org>
X-Mailer: git-send-email 2.53.0
In-Reply-To: <20260929143657.18855-1-ilya.titov@wirenboard.com>
References: <2026092930-ethics-jawless-929e@gregkh> <20260929143657.18855-1-ilya.titov@wirenboard.com>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

> Backport of a13f7f5d14af to 6.1.y.  The only conflict is in
> sunxi_pinctrl_init_with_variant(): upstream had already converted the "apb"
> clock to devm_clk_get_enabled() by the time this commit moved the request
> ahead of devm_pinctrl_register(), while 6.1.y still does devm_clk_get() +
> clk_prepare_enable() and unwinds through a clk_error label.

Queued for 6.1, thanks.

-- 
Thanks,
Sasha
