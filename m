Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 90852305688
	for <stable@vger.kernel.org>; Wed, 14 Oct 2026 01:27:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1791941260; cv=none; b=g0ZJ9I8TX7/hq2hR4DuYhQD2IHDm5zadXistE2LZMY40yyZmNBAHUV/gSZkP9YN4hdncxTHc5uXQ7U69HltStkQC9J4DsriFa+4DtmY1AJ3G8/JQIZ6xGMtZ21qE0PPOe9SP2ZrJ7EOpKa+iYO0ji4IX+1m/JAMgT4IXwhD7djA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1791941260; c=relaxed/simple;
	bh=1BTzguurCKrQmdIYqMEw3a6JDLyZTumZP9rAokf3vE4=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=FUR6/VI6BnfagxHFKl/L99kNl+HL9C9uyeb5Kg9Pp/eFj6AHR+Y25Et1lB9HGvLJn+1topqLwV8/0miDoFN7E8qML3rT2/kTzlU9BgMpWIzAMK/ChW8CSaKsPZL1eykiaPaQ/hiik9xttehOS5nA5EOQka2wgZGwwTW5vjFvVrE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=GhooQYJs; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="GhooQYJs"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id C91B11F00893;
	Wed, 14 Oct 2026 01:27:38 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1791941259;
	bh=3hmbnqxk8DmevEWFh9rrgdspkgK6wipT+wPZ36UIUag=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References;
	b=GhooQYJs1OKX5n8KWbO8yO+6VomYIgqHjqNjiOonvvyIBScQw+LPtA0v1BzohHiaP
	 2UhCZak/8WfdGiWEl+LOza52pLqhwQ9L3ljjZ+DmoPAj2GsicCaOOEXriKz+le+AT4
	 bQ8tmcC2eYOILuQtkQRO4HW51Ujf3N21HRtX/CHwgsnHZyx5WsAmj5P0tFLl/PFADM
	 gNPUIfEFoncWC7xFQ3QH6OUJrF0NbnHsCFnfqJKztgnRAmlPMV8XYCD99mjYY87CeH
	 H15AoX7+oPETk2c7oQeJgwTMhZwR44wYTQJK7KN4an/W9wwxEFgo67mOsTJ01DWbUk
	 RB7n8yvOGN/tA==
From: Sasha Levin <sashal@kernel.org>
To: stable@vger.kernel.org
Cc: Sasha Levin <sashal@kernel.org>,
	Dan Wheeler <daniel.wheeler@amd.com>,
	Roman Li <roman.li@amd.com>,
	Alex Deucher <alexander.deucher@amd.com>,
	Adrian Betschart <adrian.betschart@cinemaone.ch>
Subject: Re: [PATCH 6.6.y] drm/amd/display: Don't replace a sink mode that shares the native totals
Date: Tue, 13 Oct 2026 21:27:09 -0400
Message-ID: <2026-10-13-1-daily-reply-0019-amdgpu-sink-mode-native-totals-6-6@kernel.org>
X-Mailer: git-send-email 2.53.0
In-Reply-To: <20261012160523.8432-1-adrian.betschart@cinemaone.ch>
References: <20261012160523.8432-1-adrian.betschart@cinemaone.ch>
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

Queued for 6.6, thanks.

-- 
Thanks,
Sasha
