Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D2F7C3AE6E2
	for <stable@vger.kernel.org>; Wed,  3 Jun 2026 15:14:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1780499694; cv=none; b=CeqUeT90hc0MByqyiPzZpbPuU0xvdLcN5NZuwhQx0bTtPnH6r7t/rPj16QHv4VW0EIqEG6x6hrSydueUst2RU1MS4OgYB/lFcPVwSIHxcdMpMKBcE96m5+uhngl45H0J/e4wDFIvxLLRAUG3cyhBiSwx/NU/0TrNDUdmfBAl1+8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1780499694; c=relaxed/simple;
	bh=Ezkm9ZFBBVj0vhjm1nG9S2DHF83wuqcJfconYjhLc7g=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=dOFWX9oKD/tgAisWWOfYBuoWNqJeEjAPirR8hX2dTkOtLINnKqcBbr3CqSG/Eo9+o8brRh0VCYO1zzPfUgtNUD/LnFOlr/lKDy+s8RY5+rPDsrFiRtEaehu8CsZLZrJ3stvTIFTq7Ll2RZLZorvG+OmNwIFtSe21XAu8o4dOUcI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=eHoQlwpn; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="eHoQlwpn"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 418F21F00893;
	Wed,  3 Jun 2026 15:14:53 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1780499693;
	bh=WYJwWG4x16zLRsI59FJuAW/F/qyAzcv4cTVACN48lso=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References;
	b=eHoQlwpnzNueXgR+Kxf+5uG02ItyD3rrs05doO+iR7boGPlEbh8FUNC1AwWTgQUNu
	 6cEAfF4iPNbI1m1YGSZ0X+HhskSOs6+dp5KmPTteT0XqDe2ZQMpYeEkdHAj9dBLSnp
	 cPfBCh5tjf88yeimb6dpDYxJzKxpEPt8jTFcXsICodeG4grYE/fkoGlCL3A+KwmXIk
	 Flb6hd5cQ41456qQGxXZKw3ar6LuofQXInyJUxCFCKP15TGrV/kl9Jc5bZ9ksQT99d
	 BhqjbCt3PZdM0VPKW157JXvGLedTzHx4Zhku8ZGafJWnPHtMsPgEIcmUARjr56w8kF
	 bqW3rcTir6vgQ==
From: Sasha Levin <sashal@kernel.org>
To: stable@vger.kernel.org
Cc: Sasha Levin <sashal@kernel.org>,
	Sven Eckelmann <sven@narfation.org>,
	stable@kernel.org
Subject: Re: [PATCH 6.12.y] batman-adv: bla: avoid double decrement of bla.num_requests
Date: Wed,  3 Jun 2026 11:14:19 -0400
Message-ID: <20260603111500.item050@kernel.org>
X-Mailer: git-send-email 2.53.0
In-Reply-To: <20260529181042.415322-1-sven@narfation.org>
References: <20260529181042.415322-1-sven@narfation.org>
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
