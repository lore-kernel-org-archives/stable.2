Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1B59936EA99
	for <stable@vger.kernel.org>; Thu, 30 Jul 2026 02:40:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1785379239; cv=none; b=TAeAfPyU55ozw9U06QZtTMADGUbD0KHzGN9tlHZJIiW93IGUSa09wSe6XLMPsPtIkym3M4HLlfdZ4MdjfMbmUKTxwhkBqmWnze5kQZMOX7j/DUKKTJ5gW0xPD3SObQtCqRWxtFXK5qn+p3SQ3qaiHsl6+xPDP4yQxpl1Qk8mCAM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1785379239; c=relaxed/simple;
	bh=LUW4zHaOFGMIaEQwj44bB1CLNG2pMQe0PDUb4DdDMdQ=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=acWUM95wKRD8oI6dSLDlf7lMA3yCj1YZWQq8g1uy7/QLuxE7ENe2CH6JlQmIHpgyieH87wP/3e9Fzf6pVkqXFSBbbbyg5G8D1dnwexKFQFXherzls6KowxqHf3w9FppLq3ePdiSKSuF903nT6LfijMb5ygA5qLbLxvtQolB6mTs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=HalDiNFl; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="HalDiNFl"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id C160B1F00A3A;
	Thu, 30 Jul 2026 02:40:36 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1785379237;
	bh=sSaF7koTwiUuq8IkIKybYS4c853a9PjYJBRNpYtvbKY=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References;
	b=HalDiNFlaFSrd0nLKeZawnDhFheaJtAWuBJ/J41C0GnOW661P8CIv65jNUlDPaGA5
	 k8oFVU6/J+0+d+s+LRla1exr0oqxCvK1WCEoJQiRdgraZ8CrQNkjQqECfTnXd7WETh
	 0zlcVrD5bCcteSmXwZT6Wl5htx8H0xDUEOEYwSGH9rbJRd9W0TbgcCabugoBqqt1Zm
	 xPyXmuHU8zvkzPjZmZAUBpjJDf1o3vfslVa8IZ5SGh/mz3dpcvT6Rm6AZJN//i4CTS
	 ykhID8JXMc5ZI5ghKcyExLAn1jBPP+bI+240oZvs30LbKRw1TkKt6aKA4xAg+8z96O
	 EP64j4oZ0lyCw==
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
Date: Wed, 29 Jul 2026 22:40:03 -0400
Message-ID: <20260729223316.stable-0007@kernel.org>
X-Mailer: git-send-email 2.53.0
In-Reply-To: <87c8fb9a-30c4-4800-8aa3-d22f3081f6f9@green-communications.fr>
References: <87c8fb9a-30c4-4800-8aa3-d22f3081f6f9@green-communications.fr>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

> This patch alone causes regressions on mt792x, please wait for this fix
> to reach mainline before applying both:
> 
> https://lore.kernel.org/linux-wireless/20260728002048.19351-1-mikhail.v.gavrilov@gmail.com/T/#u

Thanks for the heads up. I've dropped the backport of 13b7e6a96a00 ("wifi:
mt76: Disable napi when removing device") from the queue - it was only
queued for 7.1 and 6.18 and it is gone from both, so nothing shipped to
users.

I'll pick it up again together with the mt792x follow-up fix once that one
lands in mainline.

-- 
Thanks,
Sasha
