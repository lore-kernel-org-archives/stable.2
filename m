Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=100.103.45.18
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1793982966;
	b=QmWY/Ni+UNB+oo3j+sVZPZ2LrMSG3b9RmIZzX1wcYGjP5Sc4uYRDw/rRwoXn7m5QKCIt
	 vkpCVyqC7MdmUD1Ms+eLIpb7Qa7wA8FDFLbwZArd2nMPNYxYNx37joWierzIhaqVxnXP9
	 h0xxdYX3G26DDMEGJI+2/mD5vK/NCJp4Xwa+jyjQsX9OIe/VXReGMIhXcf4uaDn//lASH
	 dAY1CdMWULxF2UGd1krT0VeB86tZTH3TZvIVFl8XrSawt/O6FP1HA1Usp0GCibObvrQPo
	 1OoJ2a4OLSy8IxfZWxOTXNDiYTrEmAs13YMWbrDUFxxdAKZS1Ncc1T7sdSCdUCTpZ/w==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1793982966;
	h=Received:DKIM-Signature:From:To:Cc:Subject:Date:Message-ID:X-Mailer:
	 In-Reply-To:References:MIME-Version:Content-Transfer-Encoding;
	bh=3xK1Z4CoyPHS4NJnuMzDCtiijp/tPvzWRcyWep40mQc=;
	b=wdsafKhSSb6siq5ylqILt/A03jBzxdtnvSmtcrMfSvvuyydxeFGM17RvYWrQbSIvNyjt
	 B915k9kRz8B6w4uD33Bv5SzKXlEg91ux1VeoV6vhMIgOAC1KTZWJZQzjERGHMWg1wfyLO
	 sfRLpatCAP/AtAFpzcLywd/8MiYuKvefl9nD9niFD1EfikpMJ42MuaSxnPMqFz+r7aA4q
	 Y7wFui+uNCmQfElf/nYafJj2NORRstXlZb9GfN/arAqt/L/m9MnHE1pTYkST+O+kFKw0n
	 ujSBOGIFrFOUmNP/6abKOcgQf1gNiCyy8rrKkcAgwQlqTzc++srhF64w2pgxPVU6YSQ==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dkim=pass header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=WzXE8xqQ;
	arc=none smtp.remote-ip=100.103.45.18
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 63375606D825
	for <stable@vger.kernel.org>; Fri,  6 Nov 2026 16:36:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=WzXE8xqQ
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 68CAE1F0089F;
	Fri,  6 Nov 2026 16:36:05 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1793982966;
	bh=3xK1Z4CoyPHS4NJnuMzDCtiijp/tPvzWRcyWep40mQc=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References;
	b=WzXE8xqQhiTdS0E5EH88BDyuJhtBBkdeN0dmu/rK0wx84jsMTdsnv6l11qHO2/BJn
	 YvpHEsV+DFxYlLJK2MRigBhGVQD80KPo1JbmTFf+0DURX4UVvadkoG6Us10Z+BOM0I
	 5OTs6BQTHNY9R9dw9icFAw2ZSJ22ZF+XFcTIWJbESMRFwW90HCSbCu5rkUGah4cFkD
	 bk4N2yCLmvaf5y+Mk/eJw5eKgYM5hWW3ipDxVCwqsC3VblVpdxYR17nsjw/DniiW0y
	 wUQOoPLP1EIzzhW1vVWJKkH9uWRLD4GwbA5gbeJHw6GSTvAnRUHWjD5Z3uGjFvVOUz
	 Cr+Mz+b04cESg==
From: Sasha Levin <sashal@kernel.org>
To: gregkh@linuxfoundation.org,
	linkinjeon@kernel.org
Cc: Sasha Levin <sashal@kernel.org>,
	stable@vger.kernel.org,
	Stefan Metzmacher <metze@samba.org>
Subject: Re: FAILED: patch "[PATCH] smb: smbdirect: fix buffer length underflow in RDMA transfers" failed to apply to 6.1-stable tree
Date: Fri,  6 Nov 2026 11:35:44 -0500
Message-ID: <2026-11-06-1-daily-reply-0009-smbdirect-6.1@kernel.org>
X-Mailer: git-send-email 2.53.0
In-Reply-To: <5ff03aa9-eca4-41cc-9e1f-4ad8676bed6a@samba.org>
References: <5ff03aa9-eca4-41cc-9e1f-4ad8676bed6a@samba.org>
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

> smb: smbdirect: fix buffer length underflow in RDMA transfers

Queued your backport for 6.1, thanks.

-- 
Thanks,
Sasha
