Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B32A63C10A0
	for <stable@vger.kernel.org>; Fri, 11 Sep 2026 11:21:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1789125681; cv=none; b=aquiVm1EmfOd6XvjYdszYpwvztHMaIID317thq+uPQ4OFtZMHekx9IMPM+3j/lNPQH4cgfQ8bRjRW9XWgyk4XPXAjaTCksKPVVZr+n4qiXErMIjINEzNkABXTlzFZUlwO0IgifespeogDG/1dECzMjy2qAHXEFJ4vOuAs3+JSis=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1789125681; c=relaxed/simple;
	bh=49jUDR9c1QsTzTvp3OG4sNmj+vAIJapXExOPksrTDKs=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=b3eCH19kEzan0gnLT/Eb+azSLj64thnFK1zYOiv0Eff2EH2yXhGpVNeO/vkRH+J2EKg1rYk0xI16gQm+OSqTq9zbKh6NrGtR5lcl1feenXMDhOR+VfyMsylOZacixJR+CIFm40nonoTOL48nIB2HloutSwr9eFIxnfZQhVcOW7E=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=U7yn7jV2; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="U7yn7jV2"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 387C01F008A0;
	Fri, 11 Sep 2026 11:21:13 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1789125673;
	bh=Cf/YxsCEWfo9A1BGoeVx1WvvmJexMRI1DmHnYCcktTo=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References;
	b=U7yn7jV2TjjwCjtNKO6NmmIKYUodJpWxalhmXzDJGOC4Bwyl3xPXGp4esrLrN9UHI
	 UKkyN3M2ow/3r+Zsh7tnpEaenIFdljb5fU3Kei5fgsva5geu+VVDmH8o5ve1kWFupW
	 fa6XZf+EqOwpyHoUx1h4VVs2eZa/Sx9wxizc8IWHCgTzpDf0egT8UH0jSXCTryhQHn
	 JlzH042U/cmm7x01+HPhTXqaq8PyN0lPJDs8twlfnXcaB6Qk3rpY/LTUaev0rKnWOm
	 pmGxbgHqgJX7u4K1vJoXbPnfQR1nt56vXrSlMk1Qf6En3j272ABPmvG8sy2wm9lsID
	 IOlpzk4NcU/Pg==
From: Sasha Levin <sashal@kernel.org>
To: stable@vger.kernel.org
Cc: Sasha Levin <sashal@kernel.org>,
	Sven Eckelmann <sven@narfation.org>,
	Sashiko <sashiko-bot@kernel.org>
Subject: Re: [PATCH 6.1.y] batman-adv: dat: atomically update mac addresses
Date: Fri, 11 Sep 2026 07:20:31 -0400
Message-ID: <daily-reply-0012-re-batman-adv-dat-6-1@kernel.org>
X-Mailer: git-send-email 2.53.0
In-Reply-To: <20260909190437.1073485-1-sven@narfation.org>
References: <20260909190437.1073485-1-sven@narfation.org>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

> commit e6de568d3eda3e3c01c868fabd7a9535d5ee4a73 upstream.
>
> When a MAC address is updated in batadv_dat_entry_add(), it is done
> using a simple copy function.  A parallel reader might only see parts
> of this update.

Queued for 6.1, thanks.

-- 
Thanks,
Sasha
