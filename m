Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6757F43E4A6
	for <stable@vger.kernel.org>; Fri,  5 Jun 2026 19:37:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1780688268; cv=none; b=oNwsqOgHy4t4vuk7R8l+kIIZ1DrnhW4bI13YrjjIrw3+TOtb/1Z1q/Hyur+3o/j3t8J710/g56U7+RGTUXyNq3eVQc4+daDDNGiMNe/c5NBOED0BQRPQ56cOB46oYu0pXejPXw2+yh+EQBnZkraL4mlC/452Npa664u5PgBSumA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1780688268; c=relaxed/simple;
	bh=exoEOWSgNDkiqV04c8dQtEg6APFoDReBp6cxdFAHYGQ=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=gOineya2GdyREA6Zzf0kqjOcYaeNzQY7C3CzbYrYOaDD00ydbNOcFd8W4ldnxDL+rByrb37NaI36d1RKrBUN9YDN8f9PT7PWAHpIr/GuhzEfcaeQds7SFJZl6S/1Xh5B6gbpd30QAXKfzACMyFeg7yjU/tih3f2idcj2wihOGWA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=U6gZMHlb; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="U6gZMHlb"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id B59AD1F00898;
	Fri,  5 Jun 2026 19:37:46 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1780688267;
	bh=cDDMplL0vlNihLQFTdnsZN54PrCoHwjgL18pnIOyWsE=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References;
	b=U6gZMHlbwL/OEswGak+T/jAKabxjU2FpJq0V7Stw5zLKMRbWt07s9xwuIs7gs0o95
	 tD/etRNkmT+ZCFexHPedPpsrTwuP9pMBHuKTtblFfkdP11C3iRWAru9oKOA0+PH2qU
	 jk5GQRk+0oYxNo0gM/EVWjok/cCKRadV6r8FOnQqWG016k3Ajf7aeztsxQJduxXUd2
	 zXrah1asz3JA9mrDme7GNdWwSZ5u0gGYSquIVVBcnG//myptpHMqyd5LabfDmzyxxp
	 acbjtHBNF90972q+86ueBihqqU04PtJPs7nkkiXaEOY+upXmXU13mkqRWDjBKR1NBe
	 hraXtnbbjMLNQ==
From: Sasha Levin <sashal@kernel.org>
To: stable@vger.kernel.org
Cc: Sasha Levin <sashal@kernel.org>,
	weichengc@nvidia.com
Subject: Re: [PATCH 6.12.y] xhci: tegra: Fix ghost USB device on dual-role port unplug
Date: Fri,  5 Jun 2026 15:37:20 -0400
Message-ID: <20260605-stable-reply-0013@kernel.org>
X-Mailer: git-send-email 2.53.0
In-Reply-To: <20260604121909.150108-1-weichengc@nvidia.com>
References: <2026060432-overnight-groin-0e8e@gregkh> <20260604121909.150108-1-weichengc@nvidia.com>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

> [PATCH 6.12.y] xhci: tegra: Fix ghost USB device on dual-role port unplug

Queued for 6.12.y, thanks.

-- 
Thanks,
Sasha
