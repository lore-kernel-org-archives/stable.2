Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5B2C823C368
	for <stable@vger.kernel.org>; Sun, 12 Jul 2026 20:27:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1783888065; cv=none; b=EMAMV25mhRS9wnwGUr+Dl86CFW+5uG88mexRFIjghXjCVMH7N8emuWQT5dX0bHbfDXC2fAl+lKQBV6BqRlRS4AifaK2VYt3fWbuYCm6FsdeLfJl6UEAACqYZQPrs1q2McRHbTdLyngYNGiylizKtKVUrAf8m2qk7HZutWLzRWec=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1783888065; c=relaxed/simple;
	bh=NgPLl++qXayWCKQzn75iSgOdaL/HC8uFVrxKCnRmzOs=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=JUKrtsri42+gKA0LjKlcDqevaoIhOSLIKHAFEWGkfYn1W0QobAxSzsMf0O7r7zu6JKeKfWe2uFRHXPGRRFMjCibsw3OjT6f+euRDn3nrNsqOBESgnPIDg9x98EX4x3MQM2S7UOYtDulIWT5ComD6CbKNA6AjHPfTJ+/x6K2AtjU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=MhqXA0zD; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="MhqXA0zD"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 2F8911F000E9;
	Sun, 12 Jul 2026 20:27:43 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1783888064;
	bh=+G5f1Wg9nkcsNTfRENhfcYAGj0RpndjPmZqY7zGq1F8=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References;
	b=MhqXA0zDXJalBbIPSdc6vl/WcnR6RWpdh/7Wr2Ck8fpDcu0RLhIYnkjk7/F/nFc6j
	 NxH7TGsBNUTQC0RE63Gob7UYNTQtUqjLWOY5R9f3pt2Z0mGfzzP5J7gP/pGQCauReG
	 /0iDq8RVGt7DaWGlISk6fQVuqr3GEvCy3/tmk2mXILDK9jA4c3ttL8FQ8uMB96EDSJ
	 WEBRFfyteG4PTwj1ncc4s2D7ehQ3OkAAA7Qbn3pXNG6eZXoqVyQVHtvTsqPUJVHDqP
	 RBfwPMV0X1l/Y8SiyCQR56D23iLuVUPK2XRqSx/LJ8RE+6elTXCwovX+bfNFqsRZ5D
	 CqCyDypXgBhjg==
From: Sasha Levin <sashal@kernel.org>
To: "stable@vger.kernel.org" <stable@vger.kernel.org>
Cc: Sasha Levin <sashal@kernel.org>,
	Bitterblue Smith <rtl8821cerfe2@gmail.com>
Subject: Re: Please apply 63ccdfac8677 ("wifi: rtw89: correct drop logic for malformed AMPDU frames") to 7.1
Date: Sun, 12 Jul 2026 16:27:37 -0400
Message-ID: <20260712105304.agent5-0001@kernel.org>
X-Mailer: git-send-email 2.53.0
In-Reply-To: <083f380c-23e3-4a46-9885-085013371aee@gmail.com>
References: <083f380c-23e3-4a46-9885-085013371aee@gmail.com>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

> rtw89 has a regression in 7.1: GTK rekeying can make the network
> traffic stop. 63ccdfac8677 fixes that.

Queued for 7.1, thanks.

-- 
Thanks,
Sasha
