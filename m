Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0EF3F35F192
	for <stable@vger.kernel.org>; Wed, 22 Jul 2026 00:54:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1784681650; cv=none; b=uL+ku3ahSUMwNefAxCM10aEBiS5BIxeuc9/rRpDPlnejI2Rjn6jZOUPx+fcB7GC4l4u1iCDjnYfmgpVjErOiYACihdTarbHst0cnag+XLS/kwMAQ96iWfOnd4bj2Ikl35/OJcZA5rVu7TqoLwlcTGh7gNR3MWHEU3MIWs/Mp2hM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1784681650; c=relaxed/simple;
	bh=i58Z/xHoM82pfMhDMnr2FevkQoU/WEPGdHQErqy+7yk=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=hR9RgJwK83aqxn84ROrr96Ot8EEaP2PrIoEnyjMvAkJU+zMIBM8epwtW6oPfIZdJBb93JS37zusD2koPaB/rcXQq2P24nGRKsGgqdfgZgjpOhXgoKld6ZjGhAPGwID7brL6yOYkE+iS3G11G1YyatlBfOcvMRVZbdMKbFYLwUxY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=PtVwz5Qk; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="PtVwz5Qk"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 0B9EB1F000E9;
	Wed, 22 Jul 2026 00:54:05 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1784681646;
	bh=aq1qYOq17VACwlYujo5PDqEjOytVQeR+lvogPVfBMS4=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References;
	b=PtVwz5QkatCZKRYn31w3RgKbjWht3GOYpBWBGX0dHwQwzdicaFrRJy0VeHnO6ehbl
	 503e/KFu47Yj3h3i4B2rs1o1f66kHvdFDVa34gYWZ8nxUDSC+YoEEUbExO/B90gHv/
	 VNEgAimdEAQahOan4GTc/kVYDwLAIbtrMG2CyafC1YPZJUBpcKPokv0q5eQhY/gyd1
	 zvniIztd1oUKkhsZw/JKlOq7gmvBElKofdgbVKGmyR5X9ksVx0gZM29wBZRitcRsmH
	 cfy9bEzG03WCgK5uKnhQFGd8TkchDRI57gS1pSzvJ5l+YF950CxNN9LYc2J+MafgWF
	 gggPh7ossc08A==
From: Sasha Levin <sashal@kernel.org>
To: stable@vger.kernel.org
Cc: Sasha Levin <sashal@kernel.org>,
	Guixiong Wei <weiguixiong@bytedance.com>,
	Srinivas Pandruvada <srinivas.pandruvada@linux.intel.com>,
	=?UTF-8?q?Ilpo=20J=C3=A4rvinen?= <ilpo.jarvinen@linux.intel.com>
Subject: Re: [PATCH 6.18.y] platform/x86/intel-uncore-freq: Fix current_freq_khz after CPU hotplug
Date: Tue, 21 Jul 2026 20:53:52 -0400
Message-ID: <20260721201114.0005-stable-reply@kernel.org>
X-Mailer: git-send-email 2.53.0
In-Reply-To: <20260721150756.46921-2-weiguixiong@bytedance.com>
References: <20260721150756.46921-2-weiguixiong@bytedance.com>
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

Queued for 6.18, thanks.

-- 
Thanks,
Sasha
