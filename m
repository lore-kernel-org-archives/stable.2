Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DC02A2D949F
	for <stable@vger.kernel.org>; Wed, 14 Oct 2026 01:27:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1791941252; cv=none; b=pznM4dx791Bjr5j9iTAC7EZKUru2oQlplaoLXdZqJYqxW0afrBdP/GuEsMC1NRVHkWhKqQYgZ7GFLyzkM4oxQyW/rmM6gm50ALTb9b7B5I1aCDBFqrpr+3JjH0A11AoSI0WaKIbWGNso+SfWmU92obVRtSesVT0kbnz4mZp/1G0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1791941252; c=relaxed/simple;
	bh=vQ8InXrIWF32Ho/bBYgaRi38pGJuzqzq9RmtF5ZoNY8=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=e2sCq17zG60N4OguEku+lK9hjOXuZZKxVRRx0XF1xpGGFLMjI/zEZVMMxczHo2nFBN3+AS21l8mTzMzRVV9s0UplhazYxdm+yFOV0hptJgf4WeGBVGa32UbOqPDCrVY0dSc3j6V1lJ0VoDVGTKHsPoEhU6CpVbcCvtZOLGeUw5o=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=ZACdzrn7; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="ZACdzrn7"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 37C3A1F00893;
	Wed, 14 Oct 2026 01:27:31 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1791941251;
	bh=TVJgQVi9qSBEENU4mipicA+2LaunEuuhj+VjMtPE7FI=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References;
	b=ZACdzrn71r9+iR19V7/ZeSuDBs5MbdOdKcd4ThrtIirbxHps2VWq99DqItMyl+Ne6
	 0t1Meh65Sx/DctlQWhWAEjidQOwWz9WYKJ1v5Bk29MKNaiGzcn+9iXIsUiLdjsAxJZ
	 V+8NKGQlqitw8JQ2pilZywAe8ZmnvnU0FtEsxBal40tNRUYXk4YTFI8bbv4rGKwVzr
	 i1VcqnVF/k0geATdTlIIRvpSLfXJVv5IiCV57Xd9/M/Ed7yk1IWqI/WSxgj+kW29eM
	 K0TnnVeeVVCjwaGe/Jia8gRtyInN9KCyoE3gckY8shvbU8N/V3TxdjeYWSAPTtO3tK
	 HSD1gH5FQmb9w==
From: Sasha Levin <sashal@kernel.org>
To: stable@vger.kernel.org
Cc: Sasha Levin <sashal@kernel.org>,
	Marc Kleine-Budde <mkl@pengutronix.de>,
	Oliver Hartkopp <socketcan@hartkopp.net>,
	Joerg Willmann <joe@clnt.de>
Subject: Re: [PATCH 5.15.y] can: fix unique skb identifier regression under RPS
Date: Tue, 13 Oct 2026 21:27:02 -0400
Message-ID: <2026-10-13-1-daily-reply-0011-can-skb-uid-rps-5-15@kernel.org>
X-Mailer: git-send-email 2.53.0
In-Reply-To: <20261013074152.288306-1-socketcan@hartkopp.net>
References: <20261013074152.288306-1-socketcan@hartkopp.net>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

> Commit d4fb6514ff8e ("can: use skb hash instead of private variable in
> headroom") moved the per-skb unique identifier used for raw_rcv()
> duplicate detection into skb->hash.

Queued for 5.15, thanks.

-- 
Thanks,
Sasha
