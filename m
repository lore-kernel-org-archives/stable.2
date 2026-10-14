Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7F9483093D8
	for <stable@vger.kernel.org>; Wed, 14 Oct 2026 01:27:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1791941261; cv=none; b=Pn3SL+GSCQcEwBUU8tBttiLCwa+y5BXX1kncM1K+X+ocCKbnLeo3VRTxApRY7GNmVUXQxKi7rKGeQqIZJ9CfC/yU8qV2VZpdgMrpKUXPA0SIDMV3eS+++8USubDlido+utpq2TyDumo9xPnd5fq61gSy8OXCFGs+B59b2Q4TUSI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1791941261; c=relaxed/simple;
	bh=YL7kyRBQV/Rf8NS+JrR7c73KEh/MsJorHDIi5nIFkaE=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=YcjzjDZUKHVhURYPDuswZ0oyS2nEO3XAmm45jANM5NQgqVDphFhxZ6GkJowxVMyCSQdAs7Er+zg+GAMW2nql+GGN3qHn/iqqGLvLcNCPUxVyert55VZgCxH7qzQcYlL6zz/K0aRkiw0bpVK6YIOr8E05lkl7Mxgbim9OB+wLUdg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=HI5xHYA4; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="HI5xHYA4"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id B7E581F000FF;
	Wed, 14 Oct 2026 01:27:39 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1791941260;
	bh=+hMTgh3esW8nr6WPkG8JruwzQi4MfjGiZGd9+MG8ZYk=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References;
	b=HI5xHYA4bkp9lExhrz1J+Q8mfTwp4s489YxJUX/HWf2RjO8DVaWoxwZmo3esJznPP
	 Dj8iPBlbn65cKk+wmF5l7inWJ8j+GuivlyIqDE4G83D5NxFNQj7YSsM3nzmO+gfGHp
	 vuS35xK4V91oC35W4oJfxrJSiYnhZiZHZG6C5i1sIQFyiT37cKU7uVtrlc3RDMwQz8
	 9JvzBAKwBvm07l09K/hiTpGBXlPmSNbO63bGRS2ofPc4ic8wcm2IBvd3y7Wqa8W1Uu
	 EeyeZ1iVZd2J9ULMoBbNVNNCtY59nSQ5odSm7NQRNokT52G3EeTbKB5mO9OOZjhNYs
	 G7t6dbb1ullHw==
From: Sasha Levin <sashal@kernel.org>
To: stable@vger.kernel.org
Cc: Sasha Levin <sashal@kernel.org>,
	Dan Wheeler <daniel.wheeler@amd.com>,
	Roman Li <roman.li@amd.com>,
	Alex Deucher <alexander.deucher@amd.com>,
	Adrian Betschart <adrian.betschart@cinemaone.ch>
Subject: Re: [PATCH 6.1.y] drm/amd/display: Don't replace a sink mode that shares the native totals
Date: Tue, 13 Oct 2026 21:27:10 -0400
Message-ID: <2026-10-13-1-daily-reply-0020-amdgpu-sink-mode-native-totals-6-1@kernel.org>
X-Mailer: git-send-email 2.53.0
In-Reply-To: <20261012160525.8456-1-adrian.betschart@cinemaone.ch>
References: <20261012160525.8456-1-adrian.betschart@cinemaone.ch>
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

Queued for 6.1, thanks.

-- 
Thanks,
Sasha
