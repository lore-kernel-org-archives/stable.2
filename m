Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 18E343AD52B
	for <stable@vger.kernel.org>; Wed,  3 Jun 2026 15:14:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1780499693; cv=none; b=gUBfTEwDBTSHSPwV9BhVM2Td3WkylOOoCAj7e0lMhG778vxPYXOw5lLBj1Hn8fmAW0HLpYwSNRn9UESvymXTR3tG/qZsOuyM2ogseKtIMoj2mEMyB63fMe7L2CdUlNPIouJTuD7il9cuB6l6rmAWKwbR6J//w0j2qHdzhkKAUZ4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1780499693; c=relaxed/simple;
	bh=Ezkm9ZFBBVj0vhjm1nG9S2DHF83wuqcJfconYjhLc7g=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=O2lLaRyk9PIlOZEGSLF/UQvnmi1TNRNUdUIPpdej9pNflXSK/5PPstEp2Eb+3g682bCl6EINgZzOOSVQw+a1lGeOCUx2Qdas6iY96y+hYhZbkRHJT+z0iNuaS/KPoeW37oWLlGLEE6JhEQQ77GAgJeOsROnon9GLBlOdj24oPDw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=JcTMp1Wh; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="JcTMp1Wh"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 75FC11F00898;
	Wed,  3 Jun 2026 15:14:52 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1780499693;
	bh=WYJwWG4x16zLRsI59FJuAW/F/qyAzcv4cTVACN48lso=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References;
	b=JcTMp1WhwHiTg9PRxyajlmGPCk4ZjoSwtJ2wcTS6y3elTj8vBM9bq9zqxYm47ZTJb
	 9H+IGG9XvaNmZzs8UpE2pWm7j6ECXmtFFIKdoWrvMCAohq0vo6ZOMQuFLMAYBMeMIH
	 68nU85TMTVQG48lG8espo0T7blwJMHfnzgcjbH6zD4qZh3xNihjZm3Bl5s9uuYxrcI
	 a2gzh2EL/JinMFv7mYwvhGs2d5vQAaqZMb62AGW9bZjAw12HY+8JP+rL/2nXDoJdOP
	 EqeW/WUtxIthK0hJTvvcriTLZpkFRW2CohzkbuUJoDnMf5wxCfFLbuQKK4dGc8SUdo
	 RjnSIapaKQZMg==
From: Sasha Levin <sashal@kernel.org>
To: stable@vger.kernel.org
Cc: Sasha Levin <sashal@kernel.org>,
	Sven Eckelmann <sven@narfation.org>,
	stable@kernel.org
Subject: Re: [PATCH 6.12.y] batman-adv: iv: recover OGM scheduling after forward packet error
Date: Wed,  3 Jun 2026 11:14:18 -0400
Message-ID: <20260603111500.item049@kernel.org>
X-Mailer: git-send-email 2.53.0
In-Reply-To: <20260529181000.415087-1-sven@narfation.org>
References: <20260529181000.415087-1-sven@narfation.org>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Queued for 6.6.y, 6.12.y, 6.1.y, 5.15.y, and 5.10.y, thanks.

-- 
Thanks,
Sasha
