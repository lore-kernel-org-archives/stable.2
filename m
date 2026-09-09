Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0FF6F43802D;
	Wed,  9 Sep 2026 20:26:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1788985613; cv=none; b=oYdwdiISthZP51g3GdQ887IiIuswKSRTJ8oHH9iqi+3Ib8EIsgi8lRkHv5Rua3cJjjn7zIpQYkb/bzy7Ux8Zj4LBGAvqGEZiIJOpTFDVPMVGLFUvffkTMINZ0VIWY3tzW5gI0OPwQu0SBpA0EszesZuHrvIh8vPSiwhhq24ATIQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1788985613; c=relaxed/simple;
	bh=W7GJcSaKJ53MFHny0HUEhXil89++ZDmH/szU9rYO1w4=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=iGqUcsiNX1FqP/oxyZr7YX6RVR/s1iurCVqdXVymy+1o3f5FPCW2Cgl2tRG1RNEA/gxKmTUGdd/k2BK30AwDHG9PpX4cW84w1lvVg3B1Xg372k60iWmANNWeIczSlQ9Ha09Ui8Nv86lDeS9ypbXcTY8jCGmWNB8EgiuiZvEM//E=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=MZI9oYEU; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="MZI9oYEU"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 7C95C1F0089F;
	Wed,  9 Sep 2026 20:26:44 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1788985605;
	bh=eJJdWAo/oRPQRJj2tf+8JwdrbAiF0nuPNt8Fb2iYYHc=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References;
	b=MZI9oYEUAiTIxm4QTJ8AEPrwFFGKorze9w0sBcRSipf43/SB7PmMhTgwX+NuCxDlf
	 XTmlBd1mVfP1RQS8FQgP5Ag2aalxNT3CaCZh9AoXt7Ubdfd22sprinCAB8fN20JViW
	 ntonEuRw1drQIa8OemVF46wWXhCJa11iRwVgGT6WUSm8OiMRm7/FlN+QZjV8nDTJg1
	 nmdGezRhpcc/IF7OHV6JVLBSc0vJMlGB2B4ITdLO2JMa2zCfmZEVa4h3l4oQfyaloy
	 NWIjFR/UJCagncKwrVyIbYiUuZsnPZvvYBh+Au4cEK9xet7KHGJFgjg5T+vg76u8qd
	 RzsQKtJ/46Kug==
From: Sasha Levin <sashal@kernel.org>
To: stable@vger.kernel.org
Cc: Sasha Levin <sashal@kernel.org>,
	damon@lists.linux.dev,
	SJ Park <sj@kernel.org>,
	Andrew Morton <akpm@linux-foundation.org>
Subject: Re: [PATCH 6.6.y] mm/damon/vaddr: drop last same folio access check optimization
Date: Wed,  9 Sep 2026 16:26:08 -0400
Message-ID: <2026-09-09-daily-reply-0010-damon-vaddr-drop-optim-6-6@kernel.org>
X-Mailer: git-send-email 2.53.0
In-Reply-To: <20260909055857.266952-1-sj@kernel.org>
References: <20260909055857.266952-1-sj@kernel.org>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

> The optimization can race when multiple kdamonds are running.  Meanwhile,
> the impact of the optimization is quite doubtful.  Just remove it.

Queued for 6.6, thanks.

-- 
Thanks,
Sasha
