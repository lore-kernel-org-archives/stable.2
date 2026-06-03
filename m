Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3DD143B6350
	for <stable@vger.kernel.org>; Wed,  3 Jun 2026 15:14:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1780499685; cv=none; b=QWA+TCHGEXCBW8/niZIqKEd/6M2Bxu5YEutiXpxJ6mKPgWDxhJYEXUYga9mYcozKd82+mQQuQt4t2VgU5X5OUNJAj5gTeeO7JvQk6+qwQnsOPsUvADVsx0f5DcYNUwqxJ+9PeLT+ahdMMW+NfyWr+xAs0x548PpxmGcez+VVNLU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1780499685; c=relaxed/simple;
	bh=eRNUCBBJINHiVqFx+I4Z9oHzVx/7+/cS+HEGOQ73m9s=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=buLe+H1RR/41tC5V5h4P39Ho6YQz7MUs0Pp+YyzPYgYz91pOGgu4j6xBROJ4UNSGTjtZRTy/aqqA9xxdkcu6bELoeNChNnTJX4jHtvwFKuRawCwxF+PIj725il7Ytej2y07terSTqQutq3OLYoUwiLaz495E/LlD5akqnoqWvo4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=By+I2/JD; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="By+I2/JD"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id B2E511F00893;
	Wed,  3 Jun 2026 15:14:43 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1780499684;
	bh=KsM0D1AgDtQF6FePttJck8X/Qmlo3RFVGi1J4IlKj2Y=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References;
	b=By+I2/JDXHGKgdPXTaH/0V2iaQzPxuNLnw/3b2nQsUzkcvxsgaeJFLGKEKTOlqfnF
	 3fK57q0oRmwuXO3XyHOVKusDIZ4HmRi80sskWGzyvULRRGgzFtHXn2ZvGPrvO9oFTH
	 WQ2hnVe5ecXGgbQ++2mPfyTNkfOu2u1mQ7jQ14e041amAaKBHrziIvUSRcyn12XzZs
	 aIiumTosI39thA85BAjAhkAdRroWgacK9DNRrGn1b7d+g/bH7aNfKbuaVGaO9KaKZM
	 xuDViEUEBG7WYypiRhpugHa0LGz15txCwPARIQouZlnZZjAvf/bmYe/ylAHFdB/6IW
	 TPV2RSD6FDheg==
From: Sasha Levin <sashal@kernel.org>
To: stable@vger.kernel.org
Cc: Sasha Levin <sashal@kernel.org>,
	Peter Oberparleiter <oberpar@linux.ibm.com>
Subject: Re: [PATCH 6.12.y] s390/cio: Restore GFP_DMA for CHSC allocation
Date: Wed,  3 Jun 2026 11:14:09 -0400
Message-ID: <20260603111500.item029@kernel.org>
X-Mailer: git-send-email 2.53.0
In-Reply-To: <20260602154855.365104-1-oberpar@linux.ibm.com>
References: <20260602154855.365104-1-oberpar@linux.ibm.com>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Queued for 6.18.y and 6.12.y, thanks.

-- 
Thanks,
Sasha
