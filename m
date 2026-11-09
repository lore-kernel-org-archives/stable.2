Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=100.103.45.18
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1794239614;
	b=mie3sxciN8B+POTUlYmqpfSHUIU+Q2jv3AGUOGVk5iu8/3gQ+2PwWjL4epx1xA0/FoWi
	 MFY2px0GSTvhZxnzhA4AOZ3z98c8LoaWSVQGgKb1/NOStVYNrQeuPHu3b03odC1jKVhba
	 S2G8KSv91z3cnsY6jdXk2xJ2N6F49u2AVWXDGHD2vH3+/IOU5XrKBgJXD+BxglcRgYJyw
	 imZHOt1WShOdJ3n4CsWJNIv4K4OL+YOPvLLpQ3xv6WDFO+xVZUREGNc6tkfCqPOmU8kSO
	 5gkW52cOUaAR7poYcSjk40jCOa2Xuz91XgtPw4bcBkRu9AvtEMjsVV/ts0kqLkfaxZg==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1794239614;
	h=Received:DKIM-Signature:From:To:Cc:Subject:Date:Message-ID:X-Mailer:
	 In-Reply-To:References:MIME-Version:Content-Transfer-Encoding;
	bh=tS5jTZcSdLisdgmA6N4tQ7G61M5UpS3u2x8yUvkXb7E=;
	b=lTwAUVrsr+v9RdkcGMmIN0LrIOn6xKKak4STaq4xr/vYhgimJ/seqIk0I1DDEG3A4isO
	 7hninG6hDZZCSK7EYy3AcllE9hhhnR0wq9pCKYNy6rBylqwEcMXnv6Gcy17G8FLmf+J0U
	 YmZ6O+uPlvNvfKtvQ5n7PXUVofX4HgHSK0i90hGxnKkUXV31hZWLYh07KOiHHPGZFVKiC
	 0vOQ64EoL5DJ3kvEE8vKFPkJDC2oKBLLj3vMzPPwteVWsk9VjqaGeOaXfh8a7bhRcejCO
	 izjCA0zmOZJOhu1nXmPhsc2RHc/6I4TWDvRM0nkWToQ1RcqM9DHOlxa9m+l1xCKNCgg==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dkim=pass header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=BcteWjv7;
	arc=none smtp.remote-ip=100.103.45.18
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B3FCE606EE8D
	for <stable@vger.kernel.org>; Mon,  9 Nov 2026 15:53:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=BcteWjv7
Received: by smtp.kernel.org (Postfix) with ESMTPSA id D967D1F008AB;
	Mon,  9 Nov 2026 15:53:32 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1794239613;
	bh=tS5jTZcSdLisdgmA6N4tQ7G61M5UpS3u2x8yUvkXb7E=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References;
	b=BcteWjv7uDheChKVaG0C11sBKoShOfy/ufHlA5KFwpTUw85lqKfWHrS76gDwRJBrj
	 JSXsjYxQ52J1X3QpNE79bSe9WmENGb3riuBwioaLc0dYAtrzJ8HMpfpX3hxLkt1pR6
	 +0q4Ch8K14k6OEQtQnc8jaAFofMpl4gGoDpaxSHOBSBsadJa+uKx2y2wgiBe/weUw/
	 iyAEvt+ATHuZYkQb/Ud5A2xftexXMGZtggXmocltrNcYp60FDvTtU48QRMtjo48X9V
	 bX4SiCRSYtqdqjwEcvPLzoD0h/m6EkjivJio06b9ApU9DLV59AWd0bVM2g97DZsTHz
	 6BkgNW5LqCNzw==
From: Sasha Levin <sashal@kernel.org>
To: stable@vger.kernel.org
Cc: Sasha Levin <sashal@kernel.org>,
	Marek Vasut <marek.vasut+renesas@mailbox.org>,
	Manivannan Sadhasivam <manivannan.sadhasivam@oss.qualcomm.com>,
	Bjorn Helgaas <bhelgaas@google.com>
Subject: Re: [PATCH 6.18.y] PCI: rcar-gen4: Limit Max_Read_Request_Size to 256 Bytes
Date: Mon,  9 Nov 2026 10:52:49 -0500
Message-ID: <2026-11-09-1-daily-reply-0007-rcar-gen4-6.18@kernel.org>
X-Mailer: git-send-email 2.53.0
In-Reply-To: <20261108195708.2478016-1-marek.vasut+renesas@mailbox.org>
References: <20261108195708.2478016-1-marek.vasut+renesas@mailbox.org>
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Post: <mailto:stable@vger.kernel.org>
List-Help: <mailto:stable+help@vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
List-Owner: <mailto:stable+owner@vger.kernel.org>
Precedence: list
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

> PCI: rcar-gen4: Limit Max_Read_Request_Size to 256 Bytes

Queued for 6.18, thanks.

-- 
Thanks,
Sasha
