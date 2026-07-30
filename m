Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id EFD4A376BE8
	for <stable@vger.kernel.org>; Thu, 30 Jul 2026 02:40:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1785379261; cv=none; b=fhap6udMN3y3u/cqs0tLhPLyJi69sOBHkqd033Ei3Xz3vQ1LToqcpOkpkLXpy2/0xXQ80zcQJkBhGuCkq2wE8qqE80mMy6tXL3DT5EvubNyQjBStjTTZqoJNJ63e/v8hg52QvAyQnLCjTLvzjQvEe4FWIqVMCexvnVX3zfLydDM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1785379261; c=relaxed/simple;
	bh=hgPHsu5Il4Pq7hycVk25MBjSoLP6yesmIkK6qybociw=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=TXjTcgeP3XsuMWl14pR78D4r72/cCmydDUtcAiS3XV9foWT8xd5ag2FbauoNFrwtN2bf3K/gxYl1tzFMj3Evr1bj6KmisxK7z3Ky3Q1ZvF3zR78lCILlZg+7zX7kA6wXtTuHtqpLuGWAwelK9Ip3YNYqtgWcw05QnhD2tr9P3n4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=fHefPxRJ; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="fHefPxRJ"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 28DEA1F00A3F;
	Thu, 30 Jul 2026 02:40:59 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1785379259;
	bh=nsLl2PWApHTnmaMMftyLSTtRYgaETkyNqD0ccOmJ28A=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References;
	b=fHefPxRJSwDmzYlywX3tBmermfBf4v6Z/fD8qX50LleZPnN4rSFm7D33GpfeznG1W
	 1luO5u2VoQiG+OMpS+ZqNHyeXbm5MqcYWZbgOxE73E0jJ1E0dPKvUtykhUblJnMnJe
	 arIY987hxRZHo19Vwu893pLVzquGuoWF1HvP21pIlbbY7UuMdd+A/EI2vagp6Jv5gJ
	 Z5A9ZVHxv4/J4l7UjVYsajn2SwatBwT2s0qW5Fu6noV5C2XXlzroWTY4dSfRg9bQbS
	 4wg9FIBbH8zPgNP6Gz2Jigti5yW+E/odLVGgt/DbyKzIyLmA9K3Cu4gfI/JskjJWw4
	 jS6Ur0kwKI09g==
From: Sasha Levin <sashal@kernel.org>
To: "stable@vger.kernel.org" <stable@vger.kernel.org>,
	Greg Kroah-Hartman <gregkh@linuxfoundation.org>
Cc: Sasha Levin <sashal@kernel.org>,
	"Deucher, Alexander" <Alexander.Deucher@amd.com>
Subject: Re: drm/amdgpu: fix check in amdgpu_hmm_invalidate_gfx
Date: Wed, 29 Jul 2026 22:40:25 -0400
Message-ID: <20260729223316.stable-0032@kernel.org>
X-Mailer: git-send-email 2.53.0
In-Reply-To: <BN9PR12MB5146BCCFFA60933C8B99D677F7CB2@BN9PR12MB5146.namprd12.prod.outlook.com>
References: <BN9PR12MB5146BCCFFA60933C8B99D677F7CB2@BN9PR12MB5146.namprd12.prod.outlook.com>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

> Please cherry-pick commit 52f650963d88 ("drm/amdgpu: fix check in amdgpu_hmm_invalidate_gfx") to stable trees.  The patch already has stable cc'ed and applies cleanly, but does not seem to have been applied yet.

It's already in the queue for 7.1 and 6.18.

-- 
Thanks,
Sasha
