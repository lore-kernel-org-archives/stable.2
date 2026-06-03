Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id AB1D93D349F
	for <stable@vger.kernel.org>; Wed,  3 Jun 2026 15:14:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1780499679; cv=none; b=e/TllH+7uOSQgmuxyPt8l2Y5gAXJHQFUmpVS69qAG0s4KKdSHiCIQ0fDjPRricLaT4fE9bnnkddDyn1PP1REWdwF+YzknluunNB6gJZScz9yTm3gNxWc2QPgBhaXHlq5xDSPCIs1DtpVzchCu6tkoQhkR2+tKXLAy6e7akEfH7o=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1780499679; c=relaxed/simple;
	bh=Ezkm9ZFBBVj0vhjm1nG9S2DHF83wuqcJfconYjhLc7g=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=oOrZyf3HCB83f6+doIal+mv2bAHPbDcw6tnA0bMMVlxyEz3yD7t41aJtArgokZ+NUMgqtlTVAYxfn9EvECOyI/PMmzZv4DIdEBuhH1fJARjWPFOctvB0MiMggor6vYvevPrxfDerArQMGmj4e7p3oKhptQB5tE8jmGS2BEk8+gs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=i9yJ4q6G; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="i9yJ4q6G"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 93D1F1F00893;
	Wed,  3 Jun 2026 15:14:37 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1780499678;
	bh=WYJwWG4x16zLRsI59FJuAW/F/qyAzcv4cTVACN48lso=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References;
	b=i9yJ4q6GDaJ69Y7FRzygC/My2FM5xUK+nhRvfQ5AF9+Pf32kRS4Oy1QFYU2exwf7U
	 kaqBmoqAYhkIBU/yOZzoermjlsWuH6OFXPfdzKCa9UOFLMFcSJ1HCkTen4/QcGt6XQ
	 eMW8JhJISWdTykHiIYHSR1FbUyKSotVMTVGA9yd1L35gFJKG+UrB5xultD6aaH17xE
	 rcOZNoqlC/KdFUQD+G1+2R7Ng2pje1JIbFUiqSNQuxLTdTjIme/X0Y1T/Amd4CgISH
	 Kfg9E0LvTmddnIOEZCqX2BwfFBF8eENtrmzZgPr4rSr+pPAzL0M3FO4ub+jbq71ZLk
	 Kx2cZJF5vQCUw==
From: Sasha Levin <sashal@kernel.org>
To: stable@vger.kernel.org
Cc: Sasha Levin <sashal@kernel.org>,
	Sven Eckelmann <sven@narfation.org>,
	stable@kernel.org,
	Yuan Tan <yuantan098@gmail.com>,
	Yifan Wu <yifanwucs@gmail.com>,
	Juefei Pu <tomapufckgml@gmail.com>,
	Xin Liu <bird@lzu.edu.cn>
Subject: Re: [PATCH 6.12.y] batman-adv: v: stop OGMv2 on disabled interface
Date: Wed,  3 Jun 2026 11:14:03 -0400
Message-ID: <20260603111500.item009@kernel.org>
X-Mailer: git-send-email 2.53.0
In-Reply-To: <20260528192733.76065-1-sven@narfation.org>
References: <20260528192733.76065-1-sven@narfation.org>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Queued for 6.6.y, 6.12.y, 6.1.y, 5.15.y, and 5.10.y, thanks.

-- 
Thanks,
Sasha
