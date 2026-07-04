Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B47862309AA
	for <stable@vger.kernel.org>; Sat,  4 Jul 2026 02:05:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1783130760; cv=none; b=jhiEDQQAGoP4QJSX8AapixpSuvV4ceuOKcMNB/nOUwk73BR6XIiBQ5T3jiTHaIWk1F3U89rJzUoWWVJg4hd9TEEDtaL7tz8T8/JOXTYRvXJP//fDtUZmSSsUfnmzzeq5/Vx1Dp8Gr98eWDlvHiH4Wejk9RdRFVPjLNhG+L8aTxA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1783130760; c=relaxed/simple;
	bh=enyRv9A7LL0PMG1Sfwa7uOR0aU+AG+Mfrp90NOrgw9Q=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=Edh1vCKmXrYIWb9dXF1Aqr7mylsZj1uIuaL6Lgfg2j124B9mhATmxILygb4yniHAH3ht5Ij/NAeCediIbY/FXw8KzkbuxsutYTUFZKyYaza6xZ8B9SgOPCIfsqT0TQAS5+W/5Ftkbf813jC0qBOCbXTKROCYitpMflgGwapekw0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=Oy+qIkcc; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="Oy+qIkcc"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id D99C41F00A3F;
	Sat,  4 Jul 2026 02:05:58 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1783130759;
	bh=vkHbBWy6dxnIxY6uMlmcq/AMafxCSQVmxRhFn5qQ9+o=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References;
	b=Oy+qIkcc7/yapVDZw3SFIY110+xc6uN57TQw4BiUOk2vAkANA0CZzIQ6Zd3qKSEYb
	 0Ja8W9QvGoRTzcNUjTOe69XBsvYqMlIpV/kQ64l6c5SWkRWLk/8VqDWGzRcal//gNq
	 zShWtbwHoh0Li59kGHzoC5TuYfyT0jXTFMVB9xjV3+G0DAwJAFBTds+J/MNKcmWK7+
	 fc4yICXYCoEhacJjitzZewc5TRs149sxxXxv0nen4xmPn02EKBybqI+hXhUZu7lbiH
	 Dwqps+kcqgnyicZAc0ksLsBl5De93v47GoJPlXh8GMuLNBFDUQ4quTaFdmjO+N5kQc
	 XsFNXnkaiHm8w==
From: Sasha Levin <sashal@kernel.org>
To: stable@vger.kernel.org
Cc: Sasha Levin <sashal@kernel.org>,
	Shung-Hsi Yu <shung-hsi.yu@suse.com>,
	Daniel Borkmann <daniel@iogearbox.net>,
	Puranjay Mohan <puranjay@kernel.org>,
	Alexei Starovoitov <ast@kernel.org>
Subject: Re: [PATCH stable 6.6 6.1 1/1] bpf, arm64: Reject out-of-range B.cond targets
Date: Fri,  3 Jul 2026 22:05:19 -0400
Message-ID: <2026070315-stable-reply-0025@kernel.org>
X-Mailer: git-send-email 2.53.0
In-Reply-To: <20260703061126.125313-1-shung-hsi.yu@suse.com>
References: <20260703061126.125313-1-shung-hsi.yu@suse.com>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

On Thu, Jul 03, 2026 at 02:11:25PM +0800, Shung-Hsi Yu wrote:
> From: Daniel Borkmann <daniel@iogearbox.net>
>
> commit 48d83d94930eb4db4c93d2de44838b9455cff626 upstream.

Queued for 6.6.y and 6.1.y, thanks!

-- 
Thanks,
Sasha
