Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id AA70A3A5445
	for <stable@vger.kernel.org>; Sat,  1 Aug 2026 01:40:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1785548421; cv=none; b=cHbPJ6FbLVkniNh2+/KCkxkcOEPhNz6uyxE+FqXJkZ7hIwA+wzyK5WFRTfK2SRsgTRrXgXPpBTkJFdYe6ukjpz0EfEnVYzeMwZHI6q8JyupOVojjeQB1Ubx6ft6ENmlphKVyIDmZaMfRv2Hd1KiDiAQYaL5618sXnzvk1Lpmago=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1785548421; c=relaxed/simple;
	bh=rl1sgT3P2tIgnXmO383+6PQJxxQ9KBnLSe3Zh3L6Ods=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=qibqhLmuBlT+2dkyPKCi16bYNIHwD7sbZnkffcZCN1Idp9pDzA0a5CHn8dK8L8Dw0jgJXZ1pPOdbfqt9s3l0RmpJg6WAnviW5dpGUJSjVtFrYIWddfB7f/2Aye8h7Xgn+Ftvu2Wahwyoc0HcNVw+X29N/0vJbZvOH+/FuYBePlU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=OixQKtrh; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="OixQKtrh"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id BB01C1F00AC4;
	Sat,  1 Aug 2026 01:40:17 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1785548418;
	bh=X/yBXIfxRAWheakY877Fnp5Y83xRDVvWOxTN/1Xdvms=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References;
	b=OixQKtrh7LJWUCztelv329vhcT7VQaZjO/YbB81zVowE4Pss2xg5xQ8cE5sV9eZ3p
	 SeP9ikE9iOJewjUO9oUdnteGZ4hjUZA9ip90D7pnPV1eXUeq6wEWF99DyoJ2TCPLdH
	 lE6eQz0eAGsKfZsI2ron2d7BcYqvQoDG5UTzptAjUCj9W7W+CoQSQGRR3qAdMcEWki
	 1wV40NcdeNUtbDDSHXOyzYQizJnysOA5ljfMGDnOKc26gDUrju+bTKCI6WR+PVnZS2
	 K851hc+F4Oh7gfAHooxOfdqbvhRXf0D+WXnxjt0pnqr4Fae3v67ISayj6Z9d+NUykH
	 vYrA5eicBEqXw==
From: Sasha Levin <sashal@kernel.org>
To: stable@vger.kernel.org
Cc: Sasha Levin <sashal@kernel.org>,
	Isaac Scott <isaac.scott@ideasonboard.com>,
	Ricardo Ribalda <ribalda@chromium.org>,
	Laurent Pinchart <laurent.pinchart@ideasonboard.com>,
	Mauro Carvalho Chehab <mchehab+huawei@kernel.org>
Subject: Re: [PATCH 5.10.y 1/2] media: uvcvideo: Implement dual stream quirk to fix loss of usb packets
Date: Fri, 31 Jul 2026 21:40:08 -0400
Message-ID: <20260731211006.stable-0007@kernel.org>
X-Mailer: git-send-email 2.53.0
In-Reply-To: <20260731104320.690415-1-ribalda@chromium.org>
References: <2026072042-handgun-nature-b630@gregkh> <20260731104320.690415-1-ribalda@chromium.org>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

On Fri, Jul 31, 2026 at 10:43:19AM +0000, Ricardo Ribalda wrote:
> [Added JPEG_MARKER_SOI definition, jpeg header does not exist yet]

Queued the series for 5.10, thanks.

-- 
Thanks,
Sasha
