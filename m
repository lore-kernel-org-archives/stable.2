Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3B4AD3EC6B9
	for <stable@vger.kernel.org>; Tue, 11 Aug 2026 18:56:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1786474576; cv=none; b=uE5S2fC8kc4zBjWhGst04ehQ3MLEoLTM93lSOExqTD0H+WO0vUlQNRFqJ58fUT2P4MwAp4zt0emXMXeGJQiSXh0VoGKSZ/ThT6AFkuVWV+sLXw/Yz0gsaahYrA+LdQlgZAde6jk+3pgUj0joMsPkgKwkCQe3f022xmMGMaLXThA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1786474576; c=relaxed/simple;
	bh=WbUC3HCVNRfA+PtbFFqA3nLtMJKqbHmxZHF3HYTmiT0=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=eEnWRNLdP+R5dYRucrRy6a3arRAQpiQho+AKkAu/z+wj0q5/i/6ToFYp0LJFpKRnbzg0gpscmVxMAweUFxjOyqtOAzoZHoAB+ZGe9hYwSxUTt6nT4uNWj8f/IIkz1n9dS8p5165CuNOoCUHY1PCfPl6WLOr2/+lFmBM2SBXouCg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=GFXGCwYW; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="GFXGCwYW"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 9F2141F00A3A;
	Tue, 11 Aug 2026 18:56:13 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1786474575;
	bh=O+pEZcuFstbdt3g4VB09vOqx1dKIiXDQNpytLYioGYU=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References;
	b=GFXGCwYWsOe5XLdXc0oBVDv4M+KphPjLP+uXjVMggimy1YHePTqjo9+jREWDBM3i1
	 VKibT1DbJ4JDGe/jpS1easnvYcxXm0D3aDIRuqtqc3xF5Zwq1fELIVDoEskGaP3EO8
	 YU/5obzuPP/m/pLxh0Sxqrlkw7F+CG+kAGsS/0lYVCig/ZrItod3jAbnHfVcDWDHIZ
	 j24ABjDy61tgDnEJOOtyavUoGyP1w4gmOiuifkABENjh9NRSCk+Gl+6QqMsz524nHe
	 Lz3wT+YAjU1B/oOa8ql3uvBVSvXr2md2qvUKRRElQ7nRtrPTbdXLo0yirySb5sHge8
	 J18+gxnUW78Ww==
From: Sasha Levin <sashal@kernel.org>
To: stable@vger.kernel.org
Cc: Sasha Levin <sashal@kernel.org>,
	Felix Fietkau <nbd@nbd.name>,
	Lorenzo Bianconi <lorenzo@kernel.org>,
	Ryder Lee <ryder.lee@mediatek.com>,
	Shayne Chen <shayne.chen@mediatek.com>,
	Sean Wang <sean.wang@mediatek.com>,
	Matthias Brugger <matthias.bgg@gmail.com>,
	AngeloGioacchino Del Regno <angelogioacchino.delregno@collabora.com>,
	Nicolas Cavallari <nicolas.cavallari@green-communications.fr>
Subject: Re: Patch "wifi: mt76: Disable napi when removing device" has been added to the 6.18-stable tree
Date: Tue, 11 Aug 2026 14:55:57 -0400
Message-ID: <20260811184500.stable-0014-sashal@kernel.org>
X-Mailer: git-send-email 2.53.0
In-Reply-To: <ed1f051c-b2d2-4e37-90fa-b9ad71d33688@green-communications.fr>
References: <ed1f051c-b2d2-4e37-90fa-b9ad71d33688@green-communications.fr>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

> The followup patch has been dropped and the former patch is being
> reverted, so you may stop waiting for it.

Good to know, thanks - I've dropped it from my list, so nothing is
waiting on the mt792x follow-up any more.

-- 
Thanks,
Sasha
