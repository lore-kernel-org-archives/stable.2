Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6DB943242D4;
	Sun, 11 Oct 2026 16:48:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1791737322; cv=none; b=iX9SFfnWUFLILdDl7k01l6A9PhJ0FzK8mx+sTi2gYcCbN49B5R3OzylU+19u+7DH3LNMs4sWjgAD8mnAa/DIJMwz/f7a7sEOqFvZgXzGKb+oQjjJ90yTsdZycDxR4WIJ1lLV31FG9oJT+fMUh/zqrk9N2s/EJhN47KpKPu3RoIk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1791737322; c=relaxed/simple;
	bh=alh//LVdFtWmJOTTF7G48v6MxhzO7NPK/fRJTL7KjG8=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=HDUT1HpaKeQucvtuoWArn2DAHYCUeZAk9QSOyJEsQq/4/66DRe7iC/c7KapMKSHuxIkgWQraa86X2UrFybl7X7yn0PqAQn3FKnpbCIUEBngltrlpxTbWr5l02Vs724wLvO7ZO3Hy+F/SZhX5klZQim7xTcKxq2x8AVQzvhHqqIg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=DsnfuCWo; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="DsnfuCWo"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id B35691F0089D;
	Sun, 11 Oct 2026 16:48:40 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1791737321;
	bh=VoSBOMlqsCH2193UXFn0wR9csHsjlgwdcJrgyih8Fes=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References;
	b=DsnfuCWolck8zux1RVWDpqixmRFp8z6JAlKkCSV8aes/lWPxXL5d0Cri/EaLiFNyH
	 +txQvkUa25ziMyBgMrfapO9DP8b+6ak6Wipg7K1Wwu3FQbumG0DAhBXxvlcrfTeQ/p
	 Th4V/naAe7Ukg6yz4zxta++V5K8cakeV/3R9B8SezSWJoy+LxOjGIjAYkWKRaRBiNc
	 fJ5hyk8XweU+GoL9mlcVI6Ys2k/hsliHNkszLvzs5ksiGcG3+0Wihp1UaGQ8dNxJdf
	 nICW3vYOCwLWcacdNDDaflb4ohDONoBUX3fLmLimVDQ584ww1xuhVWSvKQ6TkraY3Z
	 kRC9uxLwMwVRg==
From: Sasha Levin <sashal@kernel.org>
To: stable@vger.kernel.org
Cc: Sasha Levin <sashal@kernel.org>,
	Daniel Golle <daniel@makrotopia.org>,
	netdev@vger.kernel.org,
	Aleksei Sviridkin <f@lex.la>
Subject: Re: [PATCH 6.18.y] net: dsa: mt7530: fix .get_stats64 sleeping in atomic context
Date: Sun, 11 Oct 2026 12:48:18 -0400
Message-ID: <2026-10-11-1-daily-reply-0011-mt7530-get-stats64-6-18@kernel.org>
X-Mailer: git-send-email 2.53.0
In-Reply-To: <20261009190808.1385789-1-f@lex.la>
References: <20261009190808.1385789-1-f@lex.la>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

> The .get_stats64 callback runs in atomic context, but on
> MDIO-connected switches every register read acquires the MDIO bus
> mutex, which can sleep:

Queued for 6.18, thanks.

-- 
Thanks,
Sasha
