Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=100.103.45.18
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1794344391;
	b=5W3WqDr2X5GzKwMjNtdsq8kJKHIj//NS3gLsCxYGgbswzkDrNHaVZVdqpGRNLyVXK7Dj
	 URdYIBBZUXs5mGBuZ7/EUGUO1vdtAvN7NiNR+aqEwgue29o52UXblySSn3VvD5jNvkdqc
	 EInv49AEv4TFsN+jYOX5ceLlCoDs0sssZ0WZWXs56iuifs6+dbZAy16PDSvd4Mqii351B
	 2kyV7HID9L93dFclJm5D4lw4rK5ZrCokrUf7YnkhXd5sjSqk0bcIBIxlnfC8KD/9/G1l3
	 iBsxncfYeTnM54k1jyQR5XUthjFbT3PbkmRDQ8f3UzPPRVhjL/cPTQGGxo0AlNNAgPg==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1794344391;
	h=Received:DKIM-Signature:From:To:Cc:Subject:Date:Message-ID:X-Mailer:
	 In-Reply-To:References:MIME-Version:Content-Transfer-Encoding;
	bh=+3Ga3FAhjojqa8Wl4m7Luz1WyWDfSPfuD35trdzR5cM=;
	b=EBJUxWTF2n5lKCqiZdG/lMCpJz+BDknmCk/e5yQ/8wG9wJ40v+TzZIJghOHOWnAb5l7s
	 JhmKLD7LEHFAY9d8Sx45/BI4lZGhv7LZrn/hzk2Y1wETUu0xZkl1iXU5pPaG1YQhp6O+y
	 vf9HE8mRoTFvNZTHHHBfPBSmCYbVwJJyPbFDZ+GczFr6zkyy+tJwupS5/2OB5vvlMPEtI
	 uc9guroCvqtzFK721OMy6IXHFVSckoAQnidNFKUiA09bvpPKhvUTvyZ7zl39X/4HD75pr
	 rGtnkoWeySgYpyV/TV7DMzDLW0pU8hkiMrJ02U5kAkCC+9XcGmNrV+I9jF8xX/1Yg/A==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dkim=pass header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=ZwFjaSkw;
	arc=none smtp.remote-ip=100.103.45.18
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 812FC606A339
	for <stable@vger.kernel.org>; Tue, 10 Nov 2026 20:59:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=ZwFjaSkw
Received: by smtp.kernel.org (Postfix) with ESMTPSA id BE3801F0089F;
	Tue, 10 Nov 2026 20:59:50 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1794344391;
	bh=+3Ga3FAhjojqa8Wl4m7Luz1WyWDfSPfuD35trdzR5cM=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References;
	b=ZwFjaSkwUxyeS3SBB8B9DZ1eg/J0Ld2QogVbLUtif+mH/EG5GAjTR3nR8GdwuYmYC
	 lnYSiR4hbOpZtKykxuawKs0iDPhlw727lzMtjZg+HPH8u5cTgyW2uA1wuVzIQWvbyt
	 D5+3qAmsYe8NdQ8d24W9g/KbeHPCOY+mfZjxyID0Mcl8socHt0fhMH4EzWRCVOj/m1
	 lACSMbMnflGnlf1E2xn5DDmz547ghucbKintm0TDBsvN7TggMsoKebhR9YsXXkIvkz
	 Ux6ekrvmrsntkJzL07VzZu+5qerV4E4tSjpVrvvz83mv0/E5KmsKEL6eUlvR89xTXR
	 lxpoOCR0tOs7g==
From: Sasha Levin <sashal@kernel.org>
To: stable@vger.kernel.org
Cc: Sasha Levin <sashal@kernel.org>,
	Sven Eckelmann <sven@narfation.org>
Subject: Re: [PATCH 6.18.y] batman-adv: tt: ignore ROAM flag of received ADD changes
Date: Tue, 10 Nov 2026 15:59:14 -0500
Message-ID: <2026-11-10-1-daily-reply-0018-batman-roam-ignore-add@kernel.org>
X-Mailer: git-send-email 2.53.0
In-Reply-To: <20261110185154.76707-1-sven@narfation.org>
References: <20261110185154.76707-1-sven@narfation.org>
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

> batman-adv: tt: ignore ROAM flag of received ADD changes

Queued for 6.18, thanks.

-- 
Thanks,
Sasha
