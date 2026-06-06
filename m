Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B2450155757
	for <stable@vger.kernel.org>; Sat,  6 Jun 2026 13:31:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1780752685; cv=none; b=B1jPn+IUcw1sTnO8BhbARhwWffuaeGZ0/xy9Hurg1zno4iNbkOCcueAkVqHtYi1a5zXM5VvVynMuRF5yESSd4jyDCqOVGljYs646I5j/fMfyBky+8CEB4jSutdjnp88qwJ4Yhbl86yNpLtsGOjASVuFxK0bZw8BIIH8bTEYSTt4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1780752685; c=relaxed/simple;
	bh=wlNBa87WUqlbdM9AYsxiix44qp8Hm4lzeBz7V6jA1S4=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=o3J8d6ZMJdl1bxuEvm9XImeAcRuKnYnk2gKyl3RvSGFX9CMYBPNu8x8r7La90lOHl7fs08qGSNIvRRMCDx2a1/jLK28O9xZQb4pIngsuEGqOnak+mFQ9l26RttDcAr+04EfNXq9TuNhp7f6zdZc3UH8XB52VUFeZqg7B5MKHHTw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=icSoNCH0; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="icSoNCH0"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id B294A1F00893;
	Sat,  6 Jun 2026 13:31:23 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1780752684;
	bh=7uLeZX5YdXwGfWR+8W8pWzdZoh4HjBa0muly6bWfHUY=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References;
	b=icSoNCH0Hw2zAHHoU5stjg2rkRAdRwEIv7LiMf6d/Q+XHdfUKMBF4tUK2Ml9u8dN4
	 DJG8mqyyS4ZM6BF1v/FcRcswNfN/bdMMMscwnvkd5crWpXZ04DbFeHuKZwGlSVpciE
	 zyepgDXHsQQoQRkT8QEXqdiAAmbK0hjxNH/hfd0TrH2jYyOgVnF+t9JuDdXleQlXPo
	 gQREUPc46Iq1T7Sgl9hL653mlX04gBo8kpOB031abij1UZTVT/KnYdNk2p6BScqno7
	 ry4/NpenW25qH6TNKYQNbTGis3a893iRkbff4xYbCxTMa9nwu1ArU45ZW3eB6dm4tn
	 011N6ITkZQjgg==
From: Sasha Levin <sashal@kernel.org>
To: stable@vger.kernel.org
Cc: Sasha Levin <sashal@kernel.org>,
	"Maciej W. Rozycki" <macro@orcam.me.uk>,
	Greg Kroah-Hartman <gregkh@linuxfoundation.org>
Subject: Re: [PATCH 6.6.y] serial: dz: Fix bootconsole handover lockup
Date: Sat,  6 Jun 2026 09:31:11 -0400
Message-ID: <20260606-stable-reply-0001@kernel.org>
X-Mailer: git-send-email 2.53.0
In-Reply-To: <20260605030250.6181-1-macro@orcam.me.uk>
References: <20260605030250.6181-1-macro@orcam.me.uk>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Queued for 6.6, 6.1, 5.15 and 5.10, thanks.

-- 
Thanks,
Sasha
