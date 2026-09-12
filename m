Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E7C2347277D
	for <stable@vger.kernel.org>; Sat, 12 Sep 2026 15:26:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1789226788; cv=none; b=ARW3MPeLyWryggrxCdRbeVHUTscEuS6tj3HxcnCXaarJgyFiFNlKOd+BfI2Wjeun/NLQ/MRJGEu+2QItekY3PFM1qXgL0UTrHNTyKc1O8DOYDidTc3EYezuVQRj6qfci7G7xWIRZ6lefKMOZrEmuuBURBsfHgDIa1bFKCErMUwA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1789226788; c=relaxed/simple;
	bh=B2O5Dkyhg4XcaRt84qy8IKN8rJGZ/XbT1KLDoaUB42E=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=SSJyJ4vv19LY43fLN/eWDUN3WZe4YnAfIJBcKD3LNo2xRSo+RhK+kCN2LOfGzUhdGJnLEp+7Wc+VrBvEgnmSUyli5ViFpos9ILts1AqU2SmjmkDXms8cDspR3PB5OE7k4KDYuGRq49ZXqGH2G+ZaZdIHKp4Ki4ixlXPA+BAfYQI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=SgHcsvaX; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="SgHcsvaX"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 14F4D1F000FF;
	Sat, 12 Sep 2026 15:26:26 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1789226786;
	bh=t2LlIEGLu+1ZxDlFdsIvj9z4kDq7Ojdl2L/xaLKmYNs=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References;
	b=SgHcsvaXhMEHW58GOCsHXWs9J39x2u0N2tU4wXnFR6q65gR9uYi09U1XRcDb0FXiD
	 v4eaX/usXd7QhPAKfQPhMgf+XcJqPJ+Lc5Txv4qowHdYXzTOPRdVLMPY0guTNsOqty
	 ZDgDO9ATUh6QFzRrQ3Qk0F0YnVny92gZgLNq7X5tQsDkHF5HHR5rrlC/RGramKNXoV
	 AjXihM058s0AGuRRFeWbLKiAPsLY7+nq/1qSU9hl7fzAzu2+VkKXIcZdcx9msLgeg2
	 VPuE7/eTrlRuWFVlXEeO2g+zc8LDfgzsUta6rs+s9lSS0UXqtJcRSm0hLEI8C4iken
	 Ib5P39GFoDC7Q==
From: Sasha Levin <sashal@kernel.org>
To: stable@vger.kernel.org
Cc: Sasha Levin <sashal@kernel.org>,
	Sven Eckelmann <sven@narfation.org>,
	Sashiko <sashiko-bot@kernel.org>
Subject: Re: [PATCH 5.10.y v2] batman-adv: dat: atomically update mac addresses
Date: Sat, 12 Sep 2026 11:26:14 -0400
Message-ID: <daily-reply-0004-re-batman-adv-dat-5-10-v2@kernel.org>
X-Mailer: git-send-email 2.53.0
In-Reply-To: <20260911124849.3741497-1-sven@narfation.org>
References: <20260911124849.3741497-1-sven@narfation.org>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

> atomic64_t can be used to store the 48 bit of a mac address. A reader will
> then either see the old mac address or the new one - never a mixture of
> both.
>
> Fixes: 2f1dfbe18507 ("batman-adv: Distributed ARP Table - implement local storage")
> [ Context, integrate support for dat_cache debugfs file ]
> Signed-off-by: Sven Eckelmann <sven@narfation.org>

Queued for 5.10, thanks. The dat_cache debugfs hunk in this v2 is what v1 was missing.

-- 
Thanks,
Sasha
