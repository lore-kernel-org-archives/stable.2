Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7834A363090
	for <stable@vger.kernel.org>; Wed, 22 Jul 2026 00:54:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1784681650; cv=none; b=gD1B7LMg0PtjHflVgUblH4F5gZe53aDbivjLfUcBKXq2f7EKoCXieuKaemy/rW93M46z5mSUch46KKVSuPLGnL4pUvZGTjsMa/ruh7dEQy2UjAzvVkrV5O/V+WjhD60+ORTNw9AUmFK9pETEY7Rygt7QMXAIx2z2pu0+HCfqhjg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1784681650; c=relaxed/simple;
	bh=JR/K0DXcf9m+LF2jczpvaa6cpzVvqFKUgvvHK9Imnb0=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=Yp5vmp40lV2amsq1OACAlbGU0KJaQq4Gtiq2r/Op9dl8jyztOlG2tPQ6lfZEpjuC8d73DosdwjT34IdgWuWwXSvQchkiTw6fBcO3ACh06OadxNB+Od8oFOmKNyWGh8tf9IcB53WcT1J4lm2IX3z+Eat7e1gDCYW7gmRwoXTbwB4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=fSEUjSXI; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="fSEUjSXI"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 2E8F01F00A3A;
	Wed, 22 Jul 2026 00:54:05 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1784681645;
	bh=4IKD4O7wzdAC+rh/2Q+Gmeiz35DSIBTzhmDI03GLfJ4=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References;
	b=fSEUjSXIFEWIQZStGQ6A0mqsvK4TGA6yD/NK6WUvsHFJAl9EWgQtoWBnj4DfG2RMT
	 2LafFu+7exo8/Lh0sWTyeDEPPEHJtgym/RaRyRnS9HOpQ0o6mYFzWODsNSuR2DZRU7
	 OcU9WDgTd9604SHHNNYW+ktR1XYs7zhv/SenD6bWk7C6tuKB7m9dhncKc3CoFhAHfk
	 QHrUOn3neuW1CYYLeNaJfuehBbaQN8g68KloziJXt6tsIEgbAVcu1S+BDAqrkBfkZx
	 emG2I5eXLRiRDsLXCN/07uJsXDAepevQDZkwbidJf3QwSuK7abI62hecRv0iAoBTmd
	 uQWDtE0ZGUBbg==
From: Sasha Levin <sashal@kernel.org>
To: stable@vger.kernel.org
Cc: Sasha Levin <sashal@kernel.org>,
	Guixiong Wei <weiguixiong@bytedance.com>,
	Srinivas Pandruvada <srinivas.pandruvada@linux.intel.com>,
	=?UTF-8?q?Ilpo=20J=C3=A4rvinen?= <ilpo.jarvinen@linux.intel.com>
Subject: Re: [PATCH 7.1.y] platform/x86/intel-uncore-freq: Fix current_freq_khz after CPU hotplug
Date: Tue, 21 Jul 2026 20:53:51 -0400
Message-ID: <20260721201114.0004-stable-reply@kernel.org>
X-Mailer: git-send-email 2.53.0
In-Reply-To: <20260721141743.28158-2-weiguixiong@bytedance.com>
References: <20260721141743.28158-2-weiguixiong@bytedance.com>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

> commit 6b63520ed14b17bbe9c2103debbd2152dde1fba3 upstream.
>
> When the last CPU of a legacy uncore die goes offline,
> uncore_freq_remove_die_entry() clears control_cpu. During CPU hotplug
> re-add, uncore_freq_add_entry() still populates sysfs attributes before
> assigning the new control CPU.

Queued for 7.1, thanks.

-- 
Thanks,
Sasha
