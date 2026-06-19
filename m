Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8508D3264DA;
	Fri, 19 Jun 2026 04:07:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1781842033; cv=none; b=iJdvqE+ty28FiO3oAd8T8y95xYD2wpxUe7HMFOrCEkd3Knffx2w7P72oWnt5yuAComDRvV9mihl8p0rG2o41bquPnxUfuZQISql3zWn8STejTOwqZxs8GXk1fMuiJq4AtCXUhiwkwkOv4OHYD1yqYezqKJbmz2G9IyT9qnkk9t0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1781842033; c=relaxed/simple;
	bh=BNPsSlcWM5VwVn650MixKKW+g0DRFmT2V9H+eER7ZkY=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=SNQdN6CBRuB0BED1i+QjgfUZWP/kIsJIYqMMvfRFgcB+T/4b6QxTjM0bEveXgO8N4t4o5hFS7X3kRy6nUMXz9Q1Ygi4r9PJyNPI0H4lVC2w6+tTz31Vucs2BtRIFbhRxFjcdheLwQeTEp9+yfAc/qm4VVN0JEWAhHwcPBaczUqQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=i6YaYO2S; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="i6YaYO2S"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 2FE8D1F000E9;
	Fri, 19 Jun 2026 04:07:11 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1781842032;
	bh=STZMxVNasNP111QrobD1YWuR6RIGnTRQqos5R6ylo3Q=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References;
	b=i6YaYO2S3katfP2zO18DYNdfejLoB8qDWcm7qPcev4uAu38JiAmyScbuE7xCgX+R0
	 L6P/A/I7BKcaIkqH3s+IYamgba6Is7YEN/c4WFRoZL/3LxlzLg9KVJix1jClxha+52
	 t+WCREldmYVZaGcxiVdvIq/6zsLBIev7YUFurDRjZXmWMlD4VRjjwjd0gxstofkdqd
	 QIJy2Wvf0JcSTyyZMjaNEGMGpyRronMz6OzoJ7iEZpa8MR4vIWTwm1RCjIXxMFF1n2
	 xywuIYdMbnnBIfVcVATuzKhQJzdPpMQWUkC3PEIOlO/niuCdthT2F6nWXGDrF8d31O
	 pFmMYnyoc72QQ==
From: Sasha Levin <sashal@kernel.org>
To: Sasha Levin <sashal@kernel.org>,
	stable@vger.kernel.org
Cc: Felix Fietkau <nbd@nbd.name>,
	Lorenzo Bianconi <lorenzo@kernel.org>,
	Ryder Lee <ryder.lee@mediatek.com>,
	Shayne Chen <shayne.chen@mediatek.com>,
	Sean Wang <sean.wang@mediatek.com>,
	linux-wireless@vger.kernel.org,
	Ajrat Makhmutov <rauty@altlinux.org>
Subject: Re: [stable request] mt7921e: backport two mt76 fixes to 6.12.y
Date: Fri, 19 Jun 2026 00:06:56 -0400
Message-ID: <20260618-reply-item001-mt7921e@kernel.org>
X-Mailer: git-send-email 2.53.0
In-Reply-To: <66552f9d-f5cc-4070-bde5-6417a41eed96@altlinux.org>
References: <66552f9d-f5cc-4070-bde5-6417a41eed96@altlinux.org>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

> Please backport the following mt76/mt7921 fixes to 6.12.y:
>   - avoid undesired changes of the preset regulatory domain
>   - fix a potential scan no APs
>   - fix potential deadlock in mt7921_roc_abort_sync

All three are now queued for 6.12, thanks. The roc_abort_sync fix was
adapted to keep del_timer_sync(), since the timer rename is absent in
6.12.

--
Thanks,
Sasha
