Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D0AB355D86C
	for <stable@vger.kernel.org>; Wed, 14 Oct 2026 16:53:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1791996814; cv=none; b=iy8q9ko/HmXu18mshKo6WxcjUEO6wGCu+VKrNjmm8O5Zw7I5b5gz794njBFzipEud39i5RCjipD38XVkA0sABpEeToUWkrAwjzC1Agf+3ePahQDWVF7989zqkEE+60Ej9tFfijFCCwjmLMc4d0XRB8RVhtg5yaOxng9fnntB3gE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1791996814; c=relaxed/simple;
	bh=EGyXa1COy7WqXAZZJPUEMIVP0E6kW9IR4fPGUBF3I+8=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=kLE6lL4k4FIBXZjo/6Wlt+BiRpT54UtFrL29xPGMiEYaNsJvXSkmlq/KJu/sIWn+pF7Fhg3uBLb4U9sSxZxgLYwSSx8PeoYY9ETbcka/C3fVAjOs5wkXQ7OSnfYRSbN//fOq/XDF/YGdf1zNz5fFbI469dkZSrued998+Jjfamw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=mVGskKKE; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="mVGskKKE"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 4F30F1F000C9;
	Wed, 14 Oct 2026 16:53:33 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1791996813;
	bh=UoH730kApYrT15Sc+VVaOn4NU3tNx89T8fn4YFIylPg=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References;
	b=mVGskKKEi7sgpBguo/KovAYHazX+6kPAyvM3nr7lSuK+RYsx/jRB4F9agrVl1BNon
	 Ts8281QsvsDtVBG2WRm9fLqYGNXUx+MH/siKy2vAxmvaHf8LYnjVDiy3wAxa+iM2T6
	 UODkze+MOp/sHODK5pT8muzKi/q2wCo637KM5skhc5Y4PmW47s551AQctqevyzaWWf
	 Z8wJ898XX/jz30Z2dNBaLZ5Ryb7qTSG3mAO9zHnebk+51kEL0NmVZxgGse42V/eDbX
	 p76B2g+7gx9TXLwRGsUaAEGMUi7kor8EzotCeuWo5E2t4siOy/URGZNPLZ+e5X+Vaa
	 DF2ZOsQRHZNdg==
From: Sasha Levin <sashal@kernel.org>
To: stable@vger.kernel.org
Cc: Sasha Levin <sashal@kernel.org>,
	ljs@kernel.org
Subject: Re: [PATCH 5.15.y] mm/mremap: fix locked_vm leak from MREMAP_DONTUNMAP self-merge
Date: Wed, 14 Oct 2026 12:53:16 -0400
Message-ID: <2026-10-14-1-daily-reply-0013-mremap-dontunmap-self-merge-5-15@kernel.org>
X-Mailer: git-send-email 2.53.0
In-Reply-To: <20261013170730.2523603-1-ljs@kernel.org>
References: <20261013170730.2523603-1-ljs@kernel.org>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

> Fix another of these - self-merge.

Queued for 5.15, thanks.

-- 
Thanks,
Sasha
