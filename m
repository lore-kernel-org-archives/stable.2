Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 900EE2E1EE0
	for <stable@vger.kernel.org>; Sun,  6 Sep 2026 13:33:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1788701643; cv=none; b=Kllq/Q/IHaPVqT2XyCgG0bvBBn1ftfdf4QS8/mEJ0mNMcEfFZ/JDbyn7h2FmSlnlD3EJBSl6fzAXw6rWqKafbOrlm1CCp1cn2LxkurwOo/gZ3Bk/2TKuL3qkw9BzvyreTePUmdsLTfpT29gwXnRElsF1EZUCf3yYZU7IycFmzgA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1788701643; c=relaxed/simple;
	bh=NM6Di+dprXzXp5/6CntjfkDp9qgGOhpC4nOOMtMS2cs=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=KwPnUKLkCPhz7IUHIjTobTXdGMpgNyWedNmWFKjXhXb+AAW1zSS/Lz9c5ry9XSVsaumqDxiCwJexSj+5bYA17sFiQjsGHUWNQ4b5zuGfY1J09/pHglDolKigg7fCmkhdYWkaFcRNeEgN0JeOzRFb+7QpMSZSlTxn1JUYkqBK5Us=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=WuCyB2Iv; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="WuCyB2Iv"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 63D501F00A3D;
	Sun,  6 Sep 2026 13:33:57 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1788701637;
	bh=9/jS06DWmXkVxCYZAzj1f4EfflZeErelB2/Snmf+DPs=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References;
	b=WuCyB2IvpccL62BDR9yZyZKQyhzGpkdUC4AI6QjuMn3qkJEP7DaaDbh8KKRxugrta
	 l3UZWfuzCE9P+1NEnHqnq/YUQdv6mR/IY434KJXFxp5iNoFOTSK4K5y1MVCDg3wnfQ
	 9vufMUCftyIGvR8FM+xGf2IRqOze4+BAqvUJR92nj2yPdUddYt4O5tzrIDb+vxtWJc
	 n+r3QTZXA8AG3kNvyz2xV9zOZ51SYEqUXYU5MpQ5eX4kkUN+kRa5ZHhxugN4n5SYd1
	 xdxvxADU8jo5ht+50eZBQ6tHOeZf6vYCKGInehT5Ru3J6SqRClNiW2pxNlNacgqibP
	 LJ9UHbKrtSxDQ==
From: Sasha Levin <sashal@kernel.org>
To: stable@vger.kernel.org
Cc: Sasha Levin <sashal@kernel.org>,
	Laxman Acharya Padhya <acharyalaxman8848@gmail.com>,
	Felix Fietkau <nbd@nbd.name>
Subject: Re: [PATCH 6.6.y] wifi: mt76: mt7996: validate default EEPROM firmware size
Date: Sun,  6 Sep 2026 09:33:03 -0400
Message-ID: <2026-09-05-daily-reply-0033-mt76-eeprom-size-6-6@kernel.org>
X-Mailer: git-send-email 2.53.0
In-Reply-To: <20260904052100.15696-1-acharyalaxman8848@gmail.com>
References: <20260904052100.15696-1-acharyalaxman8848@gmail.com>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

> The default EEPROM firmware is parsed and copied as a full EEPROM
> without checking its length. A truncated file can make the driver
> read beyond the firmware buffer during variant validation or the
> fallback copy.
>
> Reject files shorter than MT7996_EEPROM_SIZE before parsing or

Queued for 6.6, thanks.

-- 
Thanks,
Sasha
