Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 33EAD3F12DE
	for <stable@vger.kernel.org>; Tue, 21 Jul 2026 00:56:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1784595415; cv=none; b=NkCrs2+jlpxEL7B3DavLdCXr1IPAeAS/ibiyDxfAVpZsnaLdX1tOIbeUOz4D7P4Ba//PDr0C9fL8bFatkrPFhBi61P4SP21nySnnLwQTjvloz5bu2jrMUxTTKHfoVeca1CMPgYVhjobjPGjcfFUsv7Yax/mVs/j4Beukk/owuXc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1784595415; c=relaxed/simple;
	bh=vAWX4VGhAGkqh/HMomEuHRKuXoJE+tJRR5lEyjKHj5k=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=beDE7c5nT4Gpf9jmj+j4SB5lJNDEgQk9DQpviLc51ja9eC5xUNHY4C2PuzxwZAj1hfH/rW2flkZUNa+6N9iLGUeUNgcBkFCcaAD8/O1WcjKX2bbJt7oFwb92byGrUvByW03O9paMsQd5uoJzaDPPAkAfg271lNl9dhC8X4Micb0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=kOMkzMW7; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="kOMkzMW7"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id A91EC1F00A3D;
	Tue, 21 Jul 2026 00:56:53 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1784595414;
	bh=9sMLZznqHPCXSSNHLGOOELeT8kUpy0BUszfgzYu6YMo=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References;
	b=kOMkzMW74kpN5r9T9ooqjRuo+nrqP4Pb1It9Ya/QiAMbquvYu3p4KevmviZEaR2SM
	 X0AV+l0sXJnzsMJl0VykqIypDunlCwi3y/7rENIMntpiq6OGOlnL2bZPrUT7tcON9L
	 6i4hh9cIXiA6eWumOGlffQDfyL1HSf+l0XZeEr0ime+fBU64KyDWNrR4IBhjlvNMnh
	 UgGKC34QweGtgJkCMvW6on0sI199zFy7MGlr77UqPF3Bw93ylwqCZ0IlouDaWm3YDB
	 1ej0I63w+EOFkq3AvbgDx5cZ9cPGyr4yI1BKRq/2VvLi8nNpMPjI08f4eHk5XgbN/w
	 m0Dn2EITwOg6w==
From: Sasha Levin <sashal@kernel.org>
To: stable@vger.kernel.org
Cc: Sasha Levin <sashal@kernel.org>,
	Sven Eckelmann <sven@narfation.org>
Subject: Re: [PATCH 6.1.y] batman-adv: clean untagged VLAN on netdev registration failure
Date: Mon, 20 Jul 2026 20:56:28 -0400
Message-ID: <20260720175500.0021-stable-reply@kernel.org>
X-Mailer: git-send-email 2.53.0
In-Reply-To: <20260720135201.770886-1-sven@narfation.org>
References: <20260720135201.770886-1-sven@narfation.org>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

> The register_netdevice() call will try to clean up the net_device using
> unregister_netdevice_queue() - which only uses the .priv_destructor to
> free private resources. In this situation, .dellink will not be called.

Queued for 6.1, thanks.

-- 
Thanks,
Sasha
