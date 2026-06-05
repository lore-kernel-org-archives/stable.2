Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8C6321FCF41
	for <stable@vger.kernel.org>; Fri,  5 Jun 2026 19:37:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1780688268; cv=none; b=q+ml/0xn6Hi5toQC87btHZGEjqmXBltXAH2qNexkw26u+62ZND/nf1eobJle9uznrzMWYVHetiq4OCH2Jb0MlG4zcvuzrOerPnaV6BXOKKWXzQThGF1bEv1jSZAxqjgBUSl9DTQT8MJ3LzlTW1BetV/VtKv5LoLmRmb426AMuKU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1780688268; c=relaxed/simple;
	bh=3igKwLfksXGAj+lQELoQaASwLQ/TY+xkP2KGCKfwbQY=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=aoxrPPmq/72n8azdi8/KwjmeR+nCA7/J0f00vRYJbGYNanEE0AAXDVuYusscVOSaQ1tFmelmtuq14iYCoiwCB3TF8KdQwkdBcYSfIOugHD3hDAfZexODaba5NmEAaTlEfeBs6znn0cnV3aLXs7GIv+YqTci0IoNjnmOKUQFS6jk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=hzTool08; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="hzTool08"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 0C7591F00893;
	Fri,  5 Jun 2026 19:37:45 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1780688266;
	bh=afZKjanoX8EYmb0ci780HNObxiLdx7NQK1pldeQGPTQ=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References;
	b=hzTool08aLguejKsLU/sezotZlI4lowJF481i2pusOZVDkc2wYRiMw9b6094vq0sS
	 iZtF3ZYqmwtNaz3HCjTem9NzIzLpjOSHyR8y+uYjJIbBz0n0sk8iSXgnXmlwIpPYrW
	 /lFHTToFSuUH1qm1H1vMf/jyZwAnlVVaQqBHjmCrVsl84GR4dpQ2tW3U212h/29bAp
	 QRqDK1mGSp/3Zm8js3CpttRtGQtroBxbhflZl1ciHECkbj+rdqaGSqKDaFt8OJddBy
	 pm6agr0//s8aYazyAkt/Ly+PEe1gnO5Bx18/ZqM1A3RkDZF/6jllV+lTZOpDhsIxHq
	 PLqrHBR8zW8LQ==
From: Sasha Levin <sashal@kernel.org>
To: stable@vger.kernel.org
Cc: Sasha Levin <sashal@kernel.org>,
	weichengc@nvidia.com
Subject: Re: [PATCH 6.18.y] xhci: tegra: Fix ghost USB device on dual-role port unplug
Date: Fri,  5 Jun 2026 15:37:19 -0400
Message-ID: <20260605-stable-reply-0012@kernel.org>
X-Mailer: git-send-email 2.53.0
In-Reply-To: <20260604121907.150042-1-weichengc@nvidia.com>
References: <2026060431-headgear-oversweet-6e6d@gregkh> <20260604121907.150042-1-weichengc@nvidia.com>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

> [PATCH 6.18.y] xhci: tegra: Fix ghost USB device on dual-role port unplug

Queued for 6.18.y, thanks.

-- 
Thanks,
Sasha
