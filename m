Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5E38C37C92C
	for <stable@vger.kernel.org>; Thu, 30 Jul 2026 02:40:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1785379243; cv=none; b=VZVNun125fR1M9hRhsVDYYgiuVkdjJYwmVs2BbYDkpdmcO8sH7F0OabT3ihnJhtzeFvp0jIWHgNXPpmIHRjXHJ8vTDvPURxl3ikxUcReqKm5YWbjzJouiF4BqC74aXf6gBxYJTcmU2XQKzsQuyci4t/u/3mpg7/IMcnz2SzzSto=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1785379243; c=relaxed/simple;
	bh=QcpFnMhjq241J3zbUEUXcDtRg0vqs2OQR0u3I55nYOU=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=fRwMSUxvr768QuX4mqFCP4dPveRn6O3DT8e8ghfQNM+4v2aePDiVCgiCIKQ6WwgUclfR6bDxTqX96WoPsASUSGtwMymaEbO6T2zffaPPpSMWEQaCcGNBOo/W0nAsNLKxaATH8mUiEQ+PNWX3hDC7TFUmmEyW46qzTK4Y4KTaWq8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=JXfdGu5E; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="JXfdGu5E"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id BD6CC1F000E9;
	Thu, 30 Jul 2026 02:40:41 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1785379242;
	bh=x6zUgt4Mr2l1/4tEyjB8ODUrbTwinanYpo/e9Pv+G5E=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References;
	b=JXfdGu5E3wEOEwQxo4qVRgAYjsi0vx04k2or/egwLvmMyE0mzImqpS0Ub6vEh3QIb
	 1ccvzJmDLaXuhK9xW2zHLX2YCcnZIrzGuQFgrByUygleJJX3eKTTXM86Cslbj/qBJR
	 ddEVVCEIZf89o5VWVg2vIsc3Wh2DUInjRLeP1dGxpvXmPhx4P9XXRJg6ozZxR8NEAV
	 Qqj25CVHm5okqoABXDvAfUqxlPza3BtAMUX/EjRWmOc5xe9JniTErphl5W8RFcXD/o
	 kcDXVHYMn9DJi68d7NSHgBpYLu+Amgi17a9E2V4QCKHwObrSUgbemb+L8h7qBk0lHn
	 X/uLDQNmVRVUg==
From: Sasha Levin <sashal@kernel.org>
To: stable@vger.kernel.org
Cc: Sasha Levin <sashal@kernel.org>,
	nbd@nbd.name,
	Devin Wittmayer <lucid_duck@justthetip.ca>
Subject: Re: [PATCH 5.15.y] wifi: mt76: mt7615: drop TXRX_NOTIFY on non-mmio buses
Date: Wed, 29 Jul 2026 22:40:07 -0400
Message-ID: <20260729223316.stable-0011@kernel.org>
X-Mailer: git-send-email 2.53.0
In-Reply-To: <20260729150056.49369-1-lucid_duck@justthetip.ca>
References: <20260729150056.49369-1-lucid_duck@justthetip.ca>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

> [PATCH 5.15.y] wifi: mt76: mt7615: drop TXRX_NOTIFY on non-mmio buses

Queued for 5.15 and 5.10, thanks.

-- 
Thanks,
Sasha
