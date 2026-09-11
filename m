Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7840143C7C7
	for <stable@vger.kernel.org>; Fri, 11 Sep 2026 11:21:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1789125684; cv=none; b=MicUZmg0LUTKFL59/AwiGag4xpbgCrNuUxAglgoS9PYTOoIQB3OcXOfFqzGmLQOd2tqniR+hNgF7HuttEu0ORW/Qjma1puYdUcstQz80/8Zc16/+0cxkABCEQ738mFkDg+i4/cImdRtoQFCLZxiDDjjibanzs1IpTCWrlPLCtNA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1789125684; c=relaxed/simple;
	bh=U7wONz0QpSziY9G8hekum7uKxWReJQR4oDhSPW9KM50=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=cxr3RX9YFhM3tAVfwj9PsLNYoV/xPx7wQvUM3TNS86CXBjNJaasFPXQxHVBIm1Y/RPEV9Zdr8+54YrPSxOyt4Z/jA1iUOCYbZgTwxq9fd4J5E/0ZYI5Phjr3M5GyngAN2U5qxEkIWTiVv/il1q/ZTqqIyGNa/w9NZZnXuHP51RM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=Rb4qYUaN; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="Rb4qYUaN"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 3371C1F0089C;
	Fri, 11 Sep 2026 11:21:17 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1789125677;
	bh=vENPBPp8phs17gKUCjhq9N9YOyPheN9I7eeN3C0HwJg=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References;
	b=Rb4qYUaNyacKGslvJrX9zYWzqyKmxjhnQ0Cob0/7VEdLI0dOjJdZQxi6JrRwTLe8g
	 E8j/jAtCZJQEiagIl3PWhVP5xGKRa3QqG4tPsXi6R4xMc/vFhNb6/4Mp8sgVy/IWMv
	 bUx2cz/7MqrirUhT/P9XOSkkjbCB6AIQl5wGx4nxLZU38ymBKzvKG1xLpVRHD5YaoP
	 DIAXEGzEj2QtNxDBrRorBSZTSD8J2et6pd5tEjXXYVa2ubqkIXkl97UWmfJaDuVzpJ
	 NEcAqVIiZW6pK/S2/bdBStc8NRB4zt98ez8HkjteaXO1mvTQAl5Z/CQ+Sv0ilwb4Q7
	 XTiMa1Z985uAg==
From: Sasha Levin <sashal@kernel.org>
To: stable@vger.kernel.org
Cc: Sasha Levin <sashal@kernel.org>,
	Sven Eckelmann <sven@narfation.org>,
	Sashiko <sashiko-bot@kernel.org>
Subject: Re: [PATCH 6.12.y] batman-adv: bla: avoid CRC corruption due to parallel claim add
Date: Fri, 11 Sep 2026 07:20:36 -0400
Message-ID: <daily-reply-0017-re-batman-adv-bla-6-12@kernel.org>
X-Mailer: git-send-email 2.53.0
In-Reply-To: <20260909185235.976203-1-sven@narfation.org>
References: <20260909185235.976203-1-sven@narfation.org>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

> commit 08645ab95768b88e2ff85a89211994651710465b upstream.
>
> batadv_bla_add_claim() is used to add claims and modify the backbone
> of claims for CLAIM frames from remote backbones and local packets.

Queued for 6.12, thanks.

-- 
Thanks,
Sasha
