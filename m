Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8C3C43939B0
	for <stable@vger.kernel.org>; Sat, 20 Jun 2026 11:55:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1781956510; cv=none; b=ue9kUurv+3vaBFKRogRFOhVsE1eoA1vYE4eNChUNMSeYQfuHY0XbpFW3lsIfFxx3YUycK46/s9DPsGFWMmbZ18uP4zJG2f8cu7ufKK01XwGvGMBGKsJQSvTG5ihYe8rCQ+6jX6REhQeq1/HxjiQtf5yNnk19R575STT0G1trBVQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1781956510; c=relaxed/simple;
	bh=j8xo1A3zSxjAkLlHkt9wmE9YOfHvn974ukH65No/GGc=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=g8nK0+1p6ij4EfSWkRV54yWGWcysUDN+VIfUyizxt/h1GcOzb5ZOyP6lg02ye0Rc3lDnUNvHIP5KWMuaPQigIc/daVXqWshhZ18b2Er8kcIfinTuGB6AQwGGu6zH2YdKZjDygzK++v+OvD91QVerG93dCe99NiVBdH7eAvCHzX0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=UR4pEJv8; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="UR4pEJv8"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 0E1C01F000E9;
	Sat, 20 Jun 2026 11:55:08 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1781956509;
	bh=X/Ww/dnPHAPyC/egx86SWJHcHc45eMyutpKxhvcdmHc=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References;
	b=UR4pEJv8BsuVh24pTW9+jFJxLWqJrEVoKwrdbZK0aM96sXs+18+td2nAG9mU2Lswx
	 KKX6nBC2IO5p5uIfcJOsitAOEG3zulJKo83bci3MBAnKVvWh4mDaq6XYgCjKSeFYWc
	 +/aZuxgVqzIeK+iRQWRFTfFKsQzrQk3k5kfIVR2usAvhGpcBlwdS/2UdUCJqbQCFLH
	 oG4zSFA9HjbunIfgvyHX/WWbCUOplrH9ndewtwQ85QA+OhX/hRjuIfuAnD1nlhCgUi
	 Vs8lnnnKPF2pCqbry1HiQwsidS59oWkPmRSLXOi2Z4bzmNgiRwX3ei1JIGdNkU9e9j
	 FwBxKtguUjH7g==
From: Sasha Levin <sashal@kernel.org>
To: linux-stable <stable@vger.kernel.org>
Cc: Sasha Levin <sashal@kernel.org>,
	Marek Vasut <marex@nabladev.com>
Subject: Re: dbbec8c5a79f ("net: stmmac: fix stm32 (and potentially others) resume regression")
Date: Sat, 20 Jun 2026 07:54:56 -0400
Message-ID: <20260619.0008.reply@kernel.org>
X-Mailer: git-send-email 2.53.0
In-Reply-To: <6b4fb2b3-8af4-4963-aef3-ff55797b9954@nabladev.com>
References: <6b4fb2b3-8af4-4963-aef3-ff55797b9954@nabladev.com>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

> dbbec8c5a79f ("net: stmmac: fix stm32 (and potentially others) resume regression")

Queued for 6.18, thanks.

-- 
Thanks,
Sasha
