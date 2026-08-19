Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B88533C1D5C;
	Wed, 19 Aug 2026 03:32:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1787110366; cv=none; b=Shfdd12XjjyKjNWhXr/sYEXDEiGm991lbriifSDXyEJWn8cGNMHhcmNJZybX0lPnEhWiOdlaq/zVPPVs7wQEjh/1/FU5w51+gWXE6iZyreQSKqzLVrC4zPsWHV/L6Rj98cjdQdZ4IwaA+ieA+EhKk4EtiAq4UeYL3Lng6FalKtA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1787110366; c=relaxed/simple;
	bh=Odps8ElBYqwwV9uBKtsF/zJtW/Jzc+G7vww6tUOFSeA=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=luMaZBkBLLOeKkp0Vi3kpGZkcby8m2Pxut7r7ybqGoQ1jhOeDn1o/u/5FYZtQGd585k+dRgyN2CxYmVCeiCLsRseq2dQrkKDAd75mXYL5y1BIu+uUSs4kZsglFtMbPtePTb0pxL1uiIsAblbXxdsEgtvtQBKf9lXFpOLpvJ7Jp4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=m2h5Ly82; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="m2h5Ly82"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 584841F00A3A;
	Wed, 19 Aug 2026 03:32:44 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1787110365;
	bh=KbTF/veYDO6H7x3tUS9zGsSfKwVoHYu1B7sV+MO8ejM=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References;
	b=m2h5Ly82ILKdJUlAft92okKyykQ3A6yhwVFm9GY/zSNkbhg3S/jnII7Im6d9PzGTT
	 0gozlmtqPBkjilQsFlhacP+8HcWXyq1emxAZZyUXFbU48MtDRivcnQRDsaL4SMsZX5
	 wlZE09PHmWY1aMO3XFmdsEnqCGbTVQfjZgV4WgJAnKdJJl6L3TkfDTozV+5+YGuWw0
	 K1XC+tRrfXhVtvO09QMyaxxGrcjJdmOEi2FoknnPGvp4HH52oKxgMSSfOLSWub7P3m
	 cHkytVkb5/YRGJ/zi5DaGwIZ4iTHjH4JLotAzznCRhGGKsW6ETgtYZE8lj9Wujn14s
	 PnYoMiq/9SF1g==
From: Sasha Levin <sashal@kernel.org>
To: stable@vger.kernel.org,
	Greg Kroah-Hartman <gregkh@linuxfoundation.org>
Cc: Sasha Levin <sashal@kernel.org>,
	Andrey Troshin <drtrosh@yandex-team.ru>,
	Tiffany Lin <tiffany.lin@mediatek.com>,
	Andrew-CT Chen <andrew-ct.chen@mediatek.com>,
	Mauro Carvalho Chehab <mchehab@kernel.org>,
	Matthias Brugger <matthias.bgg@gmail.com>,
	linux-media@vger.kernel.org,
	lvc-project@linuxtesting.org
Subject: Re: [PATCH 5.15 1/2] media: mtk-vcodec: potential null pointer deference in SCP
Date: Tue, 18 Aug 2026 23:32:26 -0400
Message-ID: <20260818220420.12@kernel.org>
X-Mailer: git-send-email 2.53.0
In-Reply-To: <20260818104324.2033-1-drtrosh@yandex-team.ru>
References: <20260818104324.2033-1-drtrosh@yandex-team.ru>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

On Tue, Aug 18, 2026 at 01:43:23PM +0300, Andrey Troshin wrote:
> [PATCH 5.15 1/2] media: mtk-vcodec: potential null pointer deference in SCP

Queued the series for 5.15, thanks.

-- 
Thanks,
Sasha
