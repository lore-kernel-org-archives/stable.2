Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A846738E8CA
	for <stable@vger.kernel.org>; Wed, 19 Aug 2026 03:32:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1787110367; cv=none; b=rg185enWsBhcoFBJ8qpwY5m4zAzpW5MM7DyDUpJBlGK8Tb7VwhfjLcmU0T7u/Q+NL7gY/omvYqwpz5nkJpLFeAkXDMuSmJEmAD50nKzgzIx1Bb74LKgsSOsv2nflloQxcjfJX24xNZSbqjRxY24VREFMfTK3rfr+qh6U82JwNjg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1787110367; c=relaxed/simple;
	bh=JKy/iZKMnNkGBDcRzdajTLDh4e9IY/TRKbc0cP3DSYI=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=lwM+WIRfscsGbs+BtUIZaAsQyGSYI3t8pdwtMPSmRd0O5debEFccyX0Y6BDdGybR762ySJFG/qx4RmYKRrwS9g2yZBY1eikQPRve+a8Ppu6OybuSnbV81wdTwUfGouLW60XhlROu7xOHwH9BlYXsRh1m6PqxYa6GfbqlCJ1VV2g=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=U3d4u9Ju; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="U3d4u9Ju"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 9C08F1F000E9;
	Wed, 19 Aug 2026 03:32:45 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1787110366;
	bh=8DCnDQjFIzdPQRo88/UAtSNImBdmfBzQYVQWj1LmZNs=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References;
	b=U3d4u9JuBSllkZKVsYx7FvmRcH+//YYJ6voZOtgPNjTBbN9q2TeMEzirXmh3QjnNa
	 YSZ1PoC2D/Ax/ALMwss9p+eEA7oNfFRaxyR7bkEhqWNaZmXUxBu2NsB00a8mFbzZTz
	 uSX9+kDhRLfK9Ok8/96FIuXld1kHLLHO3/YsI5z4olp8fIXpz6dzh0Vqq+M5qjclqo
	 NGC4dsB8/zXO5fBVVm2T4l9tBYm9+z1KW5E+rQKvZhQIjapE6mxs/XbTsRbgATjxjc
	 uoH1VEitu5nh2Yx1cFX0iUuwNgMSlQclVP97Yes+jzFehOJEqEwC/RZ0/J6TIeVk/m
	 pNCRDnG/oFgtw==
From: Sasha Levin <sashal@kernel.org>
To: stable@vger.kernel.org
Cc: Sasha Levin <sashal@kernel.org>,
	Philipp David <pd-lkml@3b.pm>,
	Aleksandr Loktionov <aleksandr.loktionov@intel.com>,
	Dima Ruinskiy <dima.ruinskiy@intel.com>,
	Tony Nguyen <anthony.l.nguyen@intel.com>,
	Jakub Kicinski <kuba@kernel.org>
Subject: Re: [PATCH 6.12.y] igc: fix netdev not re-attached after resume if interface is down
Date: Tue, 18 Aug 2026 23:32:27 -0400
Message-ID: <20260818220420.13@kernel.org>
X-Mailer: git-send-email 2.53.0
In-Reply-To: <20260818115405.25997-3-pd-lkml@3b.pm>
References: <20260818115405.25997-3-pd-lkml@3b.pm>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

On Tue, Aug 18, 2026 at 01:54:07PM +0200, Philipp David wrote:
> [PATCH 6.12.y] igc: fix netdev not re-attached after resume if interface is down

Queued for 6.12, thanks.

-- 
Thanks,
Sasha
