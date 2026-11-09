Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=100.103.45.18
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1794239617;
	b=0WJtBJEjEHCUoshguyKkDUQqEh4D3Wedf5vBOgaokgL/Obq0pJuThfiHMKkSoo+Wg68f
	 6BhIjx8C+xaBeNFdqJEm24WHsL7KV3aqt2Z8zyO2TAt1PtVIERGxkMv/FOOzzb5OdHjdX
	 kKSGxdj2NGgqXSvC7IHFCdTukYyl2zMs+JgEQ0rtjQujhQQv5HFnZuWmPAY+TvnnW6LKO
	 MA8DUbx6A0RruN6evtoMHdP1lqIRi/ht05GOO5LSMff00q/DFvuPMBe3gi8BcwkVqR/RH
	 1kttaJzIPOINOBP+zqdZdg+1LOhH8rSdmsV+MoA9bRqf6OpRnXrYdI3CLzm5mxsdKQA==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1794239617;
	h=Received:DKIM-Signature:From:To:Cc:Subject:Date:Message-ID:X-Mailer:
	 In-Reply-To:References:MIME-Version:Content-Transfer-Encoding;
	bh=5109ubmeIwQrAfQ92C+eurcg8qo9u2yKEB8DC6Ju3sk=;
	b=pJGTrf5eQNfvtpAIz/V1oMRdBJOx9HhUfIs9jrnf1pDAokfUP69Y8zDmJX6tFTO/obyw
	 MNAaZWAkmCeVDIYBFmYNmge+qY0wFYOiVDbpGBs3pKBqzykoV6/Z8Iafg8yiyT3MOLzpZ
	 4gcmMt1ueW75Kf9Wd8pxmFj0eVq/0xwJojuOhQB9UTzXU9rvX/Dq0R0V/6SQc3oxN+F2/
	 +K3XiyXg9QGwQl2v/nSq04WDjQ3V+BAy9iqvyCXnkEMD2it531uF1vSNd71xsElitN/Fn
	 QnuFx6+kalp2jqlbGyhZiNpZEkHAEY77hPfHRfiA0WtWNsgjJBoeHmPu655dfOeXjFQ==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dkim=pass header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=nItQyesN;
	arc=none smtp.remote-ip=100.103.45.18
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 46130606EE93
	for <stable@vger.kernel.org>; Mon,  9 Nov 2026 15:53:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=nItQyesN
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 58FA81F0089F;
	Mon,  9 Nov 2026 15:53:36 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1794239617;
	bh=5109ubmeIwQrAfQ92C+eurcg8qo9u2yKEB8DC6Ju3sk=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References;
	b=nItQyesN+ttNBy3ECKgqbJUwXC0pOVF+rvijz33pKZdLy3/QSy0kw+OL29uyu0XqI
	 5RrsZDtYCm/P53dBFzjUPp2dQ2Gfch1fpNpySYvPB+PC2gWSeLt++DnO6K1jsAsy/P
	 d4RNuDUn0vF81FXOQ6pSLVyxAbdaAOhAK2TJS7gYnMqkor9xZxOtFo/DbbleEcGAtd
	 mowKu3waak5QLa9SbSSbMYhQ6jVqutq4Jp12ZoeBx68PFeNJ5HnsjAaSw2NCkY3nKo
	 ztrXQ4jr6ac1y0Sl0ZReMmRtRfMTv/CXFumt7GCFsD3oCw2qUZcoNsrqCaC+d+IcFz
	 kn9o0EMCAcuPg==
From: Sasha Levin <sashal@kernel.org>
To: stable@vger.kernel.org
Cc: Sasha Levin <sashal@kernel.org>,
	Yi Cong <yicong@kylinos.cn>,
	Felix Fietkau <nbd@nbd.name>,
	Yi Cong <cong.yi@linux.dev>
Subject: Re: [PATCH 6.18.y] wifi: mt76: mt792x: fix negative errno truncation in offload capability
Date: Mon,  9 Nov 2026 10:52:52 -0500
Message-ID: <2026-11-09-1-daily-reply-0010-mt76-6.18@kernel.org>
X-Mailer: git-send-email 2.53.0
In-Reply-To: <20261109023454.52603-1-cong.yi@linux.dev>
References: <20261109023454.52603-1-cong.yi@linux.dev>
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

> wifi: mt76: mt792x: fix negative errno truncation in offload capability

Queued for 6.18, thanks.

-- 
Thanks,
Sasha
