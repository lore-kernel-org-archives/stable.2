Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C5BBC32720C
	for <stable@vger.kernel.org>; Wed, 14 Oct 2026 01:27:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1791941258; cv=none; b=dgcx02jVupBdoy1oz1EaIet5YNuUrwMjpaXVKtRsl2ZdLvU44PyGmzMrZFU5dOda3rMuIoALGSKkpvzQ751HbLMYgEwj8/drePK7T4kJz+VgP2F/u/j51Nlr5WNbaT3IoEcC4+GG7jJFuEgOySI1ucomcFhmJe85Y6A26pmMO7M=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1791941258; c=relaxed/simple;
	bh=pXywT+n5RvdnARKY5GQVQor7N8EDfJAMK5S43zu01CU=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=mhY1LMI+tOBoPo01C62jKBwdA+Nm2H9LMSM/h50ego5WRNzLN41RUfD+Q0O5QNQ0/bowq9ytcuWjI3vCn4DWJwS1Cs5vrISgtANEBlZ5yURik1rmkWcdgl3iQGL4ayN/ZWWtxU0A0HECVBN6xVdGYAEBVOXQdiAl9WcLPv6hHdQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=lDssxrmQ; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="lDssxrmQ"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id E6D551F00893;
	Wed, 14 Oct 2026 01:27:36 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1791941257;
	bh=uEZdhpnvl8CIc1OqviEmDPbCmUEW9ERqrlfd86RR2d0=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References;
	b=lDssxrmQppaGFbkBwEWv5hbMR2PhshNL2aCdKD+sIdPapsukTdbOI+ObNkUmYgkDM
	 u3MvQGyLCBYJsBMitUJ0TWM/bkOJM0Y27RuxVXfLfYqJ+gCMnjGbuYm78Yo/fyYiXC
	 c5mo+7qgC3ebNSN6dsLbHouZTgJYbCtMyTokygHQerOptTiMKK1uPmxV3D0mL5dbTW
	 F2PSTnASCNWT+haVb5WYG4akUFkhOGfqimTkb7Rv5ZfsFT9gtt1j4jhxykFxSCPjrb
	 kq9QQIbOu6efwn5XLHZaZzBve4Jlig45D3rxEzhWznzvIniN3npu6JQrmjLIyYUSWi
	 i5VgyZeiCFVSg==
From: Sasha Levin <sashal@kernel.org>
To: stable@vger.kernel.org
Cc: Sasha Levin <sashal@kernel.org>,
	Dan Wheeler <daniel.wheeler@amd.com>,
	Roman Li <roman.li@amd.com>,
	Alex Deucher <alexander.deucher@amd.com>,
	Adrian Betschart <adrian.betschart@cinemaone.ch>
Subject: Re: [PATCH 6.18.y] drm/amd/display: Don't replace a sink mode that shares the native totals
Date: Tue, 13 Oct 2026 21:27:07 -0400
Message-ID: <2026-10-13-1-daily-reply-0017-amdgpu-sink-mode-native-totals-6-18@kernel.org>
X-Mailer: git-send-email 2.53.0
In-Reply-To: <20261012160420.8194-1-adrian.betschart@cinemaone.ch>
References: <20261012160420.8194-1-adrian.betschart@cinemaone.ch>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

> Inserted modes keep the native sync positions; a real mode with its
> own active width does not. Compare those too, so only inserted modes
> are patched.

Queued for 6.18, thanks.

-- 
Thanks,
Sasha
