Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=100.103.45.18
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1795005606;
	b=tleSRDds9fuKrPDz3+/hTixnJlGeK/WPfL8RXggze2DlnSB/rbsBMQUnZc97FKUskpqH
	 FsK1yQNO+89f/DleLBluSQ70USIkDIHtwh2GD4pXDh9uf4XFuG5aDUXvm3WeVHrO8PQuU
	 7KEwQCyIsbHvdXTJy9oXe3bLMGshDispD7YU5UHQ/0yX4pgM0PtlJ/RhExF7CQVylP7j7
	 Q6L0Fmdb9RBuc5/p/oQ4ndSFZeBeGjwhJZYH1uUL77BaC9NTKhW2UIfW5IWGinB4zGKiR
	 vZ90Z88lXsi+ad/ArzhecHMM7Xt0fWq8ahCg7TwWqxprVI26hx2zQL+8uuLn0F4aDtA==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1795005606;
	h=Received:DKIM-Signature:From:To:Cc:Subject:Date:Message-ID:X-Mailer:
	 In-Reply-To:References:MIME-Version:Content-Type:
	 Content-Transfer-Encoding;
	bh=q77K6mTBp/Yq7Q7Il+okXaZvOp3BjyFzkJbKUioWPIM=;
	b=xO780i2b/Lv7eKjmxQ6VeFa19XhDnbiJOAJt4ELm0xQrjp2LnrE0Jk9i1RB8xnJxG6MH
	 fNqBfOxZPGXm42vt55PZPWPyGrXYs9bbDAMJlbrRLzrgbzgOqOUgMuBU1s5k6UBECcq4n
	 hD6zSyf6/wpRp4MVdhKx1FTcbFwu/MusWAUEDpSabhy4+M5U7LU/lV1ZiohPqupVDbKZh
	 ETaTbmFWWtsQisp7OWzFzUAR9JlyKyYb6kPJ3FCQ4/JtKrMZv+0uOtwyhfSUSfREBz6YD
	 tWh/jkp4pMUyA/u8alfCo2ICfg7uGhlD6fQjFD01fQCa1W6vHvQ3lxbcZOe1n6CnX/Q==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dkim=pass header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=DhvHB0uG;
	arc=none smtp.remote-ip=100.103.45.18
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4CFF0606A31C;
	Wed, 18 Nov 2026 12:40:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=DhvHB0uG
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 2605E1F000C9;
	Wed, 18 Nov 2026 12:40:05 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1795005605;
	bh=q77K6mTBp/Yq7Q7Il+okXaZvOp3BjyFzkJbKUioWPIM=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References;
	b=DhvHB0uGdsRIzbrkxYmMH0647yCwifcfecY18/T0iF40ggVskeD3ucMsBX1l1aC7e
	 V71sT6GyMa+B/Jq3Tr6niIYO/O/FjzH90HHcgZoYTZhY0rFjHL4EAFA9ATXHD2mSC9
	 UCe1VAHWI2C+1I+YkmrzL6bCpZ0HSHs2GnnJBObl7VubFtIah6Ouv5HRdTeJeiVk0M
	 yr9PyjhfJC45e2xp0UKr8cGwXq28rWYqjpodd4FMCSKWomdqrKfwGfm1URDE8PgV5a
	 fSqR/+LBpscGi09ZdecpovixQulu4d2WToi7dEjJhkJwu9fyjEIGJITh9SuBwi32ql
	 5Wg9Biz12B8yw==
From: Sasha Levin <sashal@kernel.org>
To: Andre Przywara <andre.przywara@arm.com>,
	stable@vger.kernel.org,
	stable-commits@vger.kernel.org
Cc: Sasha Levin <sashal@kernel.org>,
	Rob Herring <robh@kernel.org>,
	Krzysztof Kozlowski <krzk+dt@kernel.org>,
	Conor Dooley <conor+dt@kernel.org>
Subject: Re: Patch "dt-bindings: vendor-prefixes: Add vendor prefix for Teclast" has been added to the 6.6-stable tree
Date: Wed, 18 Nov 2026 07:39:58 -0500
Message-ID: <20261118124002.3727477-2-sashal@kernel.org>
X-Mailer: git-send-email 2.53.0
In-Reply-To: <c1cb0981-b152-4c5f-a296-bdf3417bf665@arm.com>
References: <20261117175632.2198155-1-sashal@kernel.org> <c1cb0981-b152-4c5f-a296-bdf3417bf665@arm.com>
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Post: <mailto:stable@vger.kernel.org>
List-Help: <mailto:stable+help@vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
List-Owner: <mailto:stable+owner@vger.kernel.org>
Precedence: list
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit

On Wed, Nov 18, 2026 at 10:48:59AM +0100, Andre Przywara wrote:
> So unless there is a specific reason I am missing, please drop this
> backport.

Dropped from the 7.3, 6.18, 6.12, 6.6 and 6.1 queues, along with the
vendor-prefix patches that were only queued as its dependencies.

-- 
Thanks,
Sasha
