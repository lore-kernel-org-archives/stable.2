Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 176FA3CF678
	for <stable@vger.kernel.org>; Fri, 11 Sep 2026 11:21:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1789125683; cv=none; b=hNMzmk5VAMDAk0LRf90v4J7H6S/mLJvJOOcqylxs2PZA9R/x17jyxAxLksZxAcx+VKvu1rJiW/07nlalvncxQg2TuWPpekgdxhdwBQ96o2jR77WhTWHEIGujbwqWcoj3CVnaruiPd4U+l4QKAJPxU8NoIhQi6E7ftnKMvfWZOeQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1789125683; c=relaxed/simple;
	bh=rtQFt20y9utCSal7oQS6dDCe1aMQoWOBBCaewIv0dyM=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=aWCkjH3+ImKn4QSAgk36hCDlwd9PcMqaaZNkCziMUKmhXI//4YpylY+dQwKxFJi61mEiphR0H7RWdD3n/ZpRGeeGlF4O/tZg1EE0mv9Aa0GQDOWkWysgEHZ04FxEVbxPXP5CTU9O9g81RAZ5yhHz96+yD91MKHm2qGMg5PcTq7g=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=HDHSzfeV; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="HDHSzfeV"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 5BBEE1F000FF;
	Fri, 11 Sep 2026 11:21:16 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1789125676;
	bh=Hehhb8PWcQOHp7g+5Rg2i+Y/AETB/h9L5E8hB6C9Vnk=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References;
	b=HDHSzfeVrtAPuoX8k/oFaVHjPJJUmv/FVBCFBD7H+5cnc1U+FFx2sKHqoKvVxtT/P
	 PSl83+iAa02w9ecllejkQoYsIg+M38HgWcRFWhfF3Nhre2JsPTuz0gNjfOnOcx1Cdx
	 o0LwMllZeKjZpsdJFBvUOcjDErnlMHGFAL0wONv9I9KDWqUTUrD6hmTj7B2oQAXPFU
	 zDd3GZZD9ebgKp0SO7Q+WvifF6pF+CqIN+gf/M/6RHHb8i4ZNbTML4K96Emw+62taS
	 fb4w5wqo/V1LMh3P6ouMgCxPut1YCbg5Qfnt+WupJ83bPMvikmdYc9GJMl2dkZsegf
	 /mXMv6Usaq1tQ==
From: Sasha Levin <sashal@kernel.org>
To: stable@vger.kernel.org
Cc: Sasha Levin <sashal@kernel.org>,
	Sven Eckelmann <sven@narfation.org>,
	Sashiko <sashiko-bot@kernel.org>
Subject: Re: [PATCH 6.18.y] batman-adv: bla: avoid CRC corruption due to parallel claim add
Date: Fri, 11 Sep 2026 07:20:35 -0400
Message-ID: <daily-reply-0016-re-batman-adv-bla-6-18@kernel.org>
X-Mailer: git-send-email 2.53.0
In-Reply-To: <20260909184617.945109-1-sven@narfation.org>
References: <20260909184617.945109-1-sven@narfation.org>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

> commit 08645ab95768b88e2ff85a89211994651710465b upstream.
>
> batadv_bla_add_claim() is used to add claims and modify the backbone
> of claims for CLAIM frames from remote backbones and local packets.

Queued for 6.18, thanks.

-- 
Thanks,
Sasha
