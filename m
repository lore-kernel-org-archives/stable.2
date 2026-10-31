Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=100.103.45.18
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1793484824;
	b=4tJZnX/6J0dNn0TbATopHeVi4LvmQDny8aI46lEb4oJp2biOWb2TJhpyg/DGMZr5T1R5
	 z3UbtMJSo2utVRSMKtVLFLY7BXlqUZuIJ5/1g670mJlxPLn4r7qYKBX8+wXArXdAkXG3M
	 1vEjjfRt/YqhgyU43NHZ0F6O40Yrh4CNs9Fd6Qs6zZ+XW+i1Mf6DfHllYtkgEjAp4wlXp
	 HmkHSwHQjHjhIZQbBEsKRHl1h6/7fiRZDXvywPtTBlxHcpNK9M5e1pjLQYywHsVWCqTg9
	 UD6/cNIR1xjXmhpidwmtrkTdyRvzccgfhOCbkaglQvQcsXIWMTvvl8O3jCHtJsxweOQ==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1793484824;
	h=Received:DKIM-Signature:From:To:Cc:Subject:Date:Message-ID:
	 In-Reply-To:References:Auto-Submitted:Content-Type:
	 Content-Transfer-Encoding:MIME-Version;
	bh=URC7r36kokGjXCV5G6Ei8oKV54JoMbconYpCKkPt2AY=;
	b=W/VRNZ+XRXyQDBduAiRKhvmXhL67YccMHwiaZ2YK3USaAmmNrymQMN+RjA26MNVVCDuT
	 uc6h/AdnMm17u29iMN5wwQbAw/28kwBe/Ux6BKCO+7mCMc3soLzy6vhq9CnBt04D8C+dp
	 AwtsJBGFlpAzuBdvflScPsWiGiBO6aXjRKp+iVZgTbHO6A1JrH8rdObJ0DGY95EC4CDlZ
	 RsnNRYxJYd4XAWvzgbWQPvN+XJdLndMQmzNbyGAZQfd1fCoyaKcgUz0tTVPcMLcqhV+aw
	 /1HKluIAEkib1vuyiKLLF3hZgD11OH+CpbTa9dtpQyVlUiKA0jpeaGCuzS79qzBUBvQ==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dkim=pass header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=DABniCJy;
	arc=none smtp.remote-ip=100.103.45.18
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 028B9606A31A;
	Sat, 31 Oct 2026 22:13:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=DABniCJy
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 8723C1F000C1;
	Sat, 31 Oct 2026 22:13:43 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1793484823;
	bh=URC7r36kokGjXCV5G6Ei8oKV54JoMbconYpCKkPt2AY=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References;
	b=DABniCJynMbdmsWGQDy+T2EBfQiI1ngC/BABok18Q80s0NyKnCXWDIuRHizxnakL0
	 7V1iEboeCcUbemCvnkYFt8Wl4bsh1xdcaQzEQOVREiJWKAp1tVe7HcPMp8yM28eWvY
	 LuGmgyBfMGWMOb1kk25c6E8MH39N4+VY2jfXysOq1J3zoP/J1NvsxwgO7/EBsOVWlH
	 fUJepHH9ngGHi/yc8CR+h1Kx0MNSGYv+nqOQCHajfxKM/DF/nRrV25CIs5ghr2/euG
	 AFBVJRBYPZ9BJJAlWxqYHXwA4x05xd/NDkb//1opN0HBsu5H20cmpV2SdCnznloUx5
	 MQj0hD1tYD2Vg==
From: netdev-bot+sinfo@kernel.org
To: =?utf-8?q?J=C3=A9r=C3=A9my?= Jean <Jeremy.Jean@oss.cyber.gouv.fr>
Cc: Subash Abhinov Kasiviswanathan <subash.a.kasiviswanathan@oss.qualcomm.com>,
 Sean Tranchetti <sean.tranchetti@oss.qualcomm.com>, netdev@vger.kernel.org,
 linux-kernel@vger.kernel.org, stable@vger.kernel.org
Subject: Re: [PATCH net] net: qualcomm: rmnet: bound TX aggregates on
 byte-limit update
Date: Sat, 31 Oct 2026 22:13:43 +0000
Message-ID: <179348482309.3286.17799482231932078029@kernel.org>
In-Reply-To: <20261031221052.1642262-2-Jeremy.Jean@oss.cyber.gouv.fr>
References: <20261031221052.1642262-1-Jeremy.Jean@oss.cyber.gouv.fr>
 <20261031221052.1642262-2-Jeremy.Jean@oss.cyber.gouv.fr>
Auto-Submitted: auto-generated
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Post: <mailto:stable@vger.kernel.org>
List-Help: <mailto:stable+help@vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
List-Owner: <mailto:stable+owner@vger.kernel.org>
Precedence: list
MIME-Version: 1.0

Hi!

This is an automated message. This series looks like a fix, but its
commit messages seem to be missing some information:

 - How the issue was discovered, e.g. hit in production, hit during
   development, syzbot report, manual code inspection, LLM or static
   analysis tool scan.

 - Whether the issue was actually triggered, or is only theoretical
   (e.g. found by code inspection). If it was triggered please include
   the symptoms, like the stack trace or error messages.

 - What hardware the change was tested on. For driver fixes please
   mention the device (and if relevant firmware version) used for
   testing, or say that the change was not tested on real hardware.

Please do not repost the series just to address the above. Instead,
reply to this email with the missing information, so that reviewers
can take it into account. If the series needs another revision for
other reasons, please include the information in the commit messages
then.

The evaluation is done by an LLM so it may be wrong, if you think
that is the case please reply and explain.
