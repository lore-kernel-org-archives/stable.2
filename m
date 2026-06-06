Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 286D223183F
	for <stable@vger.kernel.org>; Sat,  6 Jun 2026 13:31:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1780752685; cv=none; b=pNAuuLkBTlsxdtMG5zD2oUxv95EZCQydv5QytA+bScLAlXZYFHYd8dpXaOtFLmPguY5amdytn8uSbi0k56AIoyDLuMIaSIccChwQVArtmXY4rSkY2CutcmK+rvS13YFXxdTYbK4Jyu4l585hnMBq281CODnM2NBTaVnRdCpoLoE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1780752685; c=relaxed/simple;
	bh=Hl9QoSe9XJTLFSgazDj1a8o5f+32uOFaFnhjfznZRGs=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=IQjcU5ARhUgT+FAnr0O6rpSSNYEvzPaGnleE+zxfE18veO+yAMRISfa4l/fnU8kjgVhO/OZiZRB110l/Z4PGPlvVgRDj3oCBF/HYIbfO6tAXwYk2E8P2zCZg9NmxEwhRaidQJ55q1wvAXHUovLS236ZtWR71esRy86xcINtEL5s=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=gXUvG9gS; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="gXUvG9gS"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 805351F00899;
	Sat,  6 Jun 2026 13:31:24 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1780752685;
	bh=J9BXVb3slJU1Eu9UJPNqqVJ94Fcdm0PgUFuFxcsE4Pg=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References;
	b=gXUvG9gSvMUgCcETEEJQde+jcP830quZtEEcbE4sKTgnQHe4maJsI2HZj245JCPP0
	 w6yzf+ZcxeheZt6j2sfOxOSBQdurcc3ZZuq7Ovd2T9eliv0tfPOcX2un+IoEyqyEEC
	 IXeza25vgx7nr8+v3yT6iOUDICfMktWHxRaKft9/cDp3zaJPYEhezIt1JA4jwhxHHa
	 VeZWx10nKUEznoYUX0EuTBxDKFvh6jyr6gsgnWvf2VkOHg4Rzhk9Nw1JVUL4aJTL61
	 7ERaCenB0Em4qEJt19DQSOq/AbKkyuLPi5MQ0+YxiAfD7sB16dhEEhpz/1TV1n34G0
	 XxpFps7CkgTKw==
From: Sasha Levin <sashal@kernel.org>
To: stable@vger.kernel.org
Cc: Sasha Levin <sashal@kernel.org>,
	"Maciej W. Rozycki" <macro@orcam.me.uk>,
	Greg Kroah-Hartman <gregkh@linuxfoundation.org>
Subject: Re: [PATCH 6.6.y] serial: dz: Convert to use a platform device
Date: Sat,  6 Jun 2026 09:31:12 -0400
Message-ID: <20260606-stable-reply-0002@kernel.org>
X-Mailer: git-send-email 2.53.0
In-Reply-To: <20260605030420.6321-1-macro@orcam.me.uk>
References: <20260605030420.6321-1-macro@orcam.me.uk>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Queued for 6.6, thanks.

-- 
Thanks,
Sasha
