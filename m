Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 00B0F37FF43
	for <stable@vger.kernel.org>; Wed,  7 Oct 2026 21:04:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1791407041; cv=none; b=dELeiid59dVPxPQHXJ+fsI89IhTrZY1uyEXZW35qOCfTX7NT2oslqclZ/HkXs9kfBj1HyEtH2KDDi9Nurrupj8o5UgBkvZsJbWEVlMDBoGLMTu+D+ltpdgseuJFWKdYPQrvJ4DL9oLuD4S8ypEaC5WEJTZzmpvS3LgooYmrUsck=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1791407041; c=relaxed/simple;
	bh=af3Lj6iiT3X18e7fBH+a8DhGGU6ipjGmZe+xmvvsOV8=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=YTyp33jMUh9UgWdifbxkxVVy3sNHN15iBFyjE5ASaVU3+4+q+5niJcIK7SZIc064CD+IFlzDoxLM7qhz/FhilUHa2OrWIGYqfwBEJ6ik5eoodzjw+RlNsLky5Obux+Hg1b6vqnsmnqnl5URVHomJe6FBuwXBAWePACpAYeNC47U=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=BkKIy8jb; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="BkKIy8jb"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id E4BBC1F00893;
	Wed,  7 Oct 2026 21:03:59 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1791407040;
	bh=KitVfamkFEoDcIlw7YDKVaqi6/DZKTfH9b8X3cm6CFM=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References;
	b=BkKIy8jbfF+ni//jFt2TNIUePm0Kiib2umu0R7E4N2xJC7jUPO1PJkhekfaamyd14
	 yYupr/MKTgtqsCnk19/GSkxPcmF0Aiic2DdCY2tw7+trq0JAGKgTnJS304c5Jtv6w9
	 lRrkcexAd7QTGue9qjiAkKa7a7SjB+VOC1RjCOi0jpa3un3xKXjkN+OUWfWRsQL2Q6
	 8kBmbzMV62P47F1KkgOp2ebq3xm5xcx3XV2fWKhWculvJq5iGln6ZbLj1jynT8ZnTu
	 R6FQiSEc3qN24DulesaOzRxLFf0GWjhTTrNdVcFU0YhwItJ5YJ8pUFvnBFcMKIvj1R
	 Z8RfyxSGKWl3g==
From: Sasha Levin <sashal@kernel.org>
To: stable@vger.kernel.org
Cc: Sasha Levin <sashal@kernel.org>,
	Beata Michalska <beata.michalska@arm.com>
Subject: Re: [PATCH 6.6.y 1/2] arm64: errata: Factor out broken AMU const counter cap
Date: Wed,  7 Oct 2026 17:03:26 -0400
Message-ID: <2026-10-07-1-daily-reply-0009-arm64-a725-erratum-6-6@kernel.org>
X-Mailer: git-send-email 2.53.0
In-Reply-To: <20261006134820.2627481-1-beata.michalska@arm.com>
References: <20261006134820.2627481-1-beata.michalska@arm.com>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

> Move the workaround from the erratum 2457168-specific cpucap to a generic
> broken AMU constant-counter one.

Queued the series for 6.6, thanks.

-- 
Thanks,
Sasha
