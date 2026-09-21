Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 21E32BA45;
	Mon, 21 Sep 2026 00:13:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1789949586; cv=none; b=MSajB4mXGktv8krkYNfwhu2+vyNR2Yn+tUgt3JXZUGG2RoS57qCkAdw4K1kzUiPsjg75tAqoja7+sDTZUikIyaQ8GcX/ed5RQ1/V+m9K8VR0PPX/Y9Clgb+lRaCsMAFzXqhef57TDqHWBICOHRnxm1VF8G9is6UUL9e0H9Kj+h0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1789949586; c=relaxed/simple;
	bh=70U/mKZZCoK204siZkA8JxgieTMUxnMu7/kNXmbiIks=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=nQUyHFtPgEBiaWjjGqmz+hpeXxKpgFWUxn98WiSee71vZMoSZMbbskPlhWGoYETafPSmbak+tVPdvt1r9JgURUpaq/lmQh4WnCVL3QvM/9E2oNTpabTE27eIab3dP+arR7rLh3CmhaZyFnEDRevGd7/LJbZxN09DM8tILmZ7Eb4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=Zekdbm6U; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="Zekdbm6U"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 95B1D1F000FF;
	Mon, 21 Sep 2026 00:13:03 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1789949584;
	bh=YN1oN1wZnzFbnwYA5jad0HdKingtmleOV9lWTzSMxqg=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References;
	b=Zekdbm6U3Pm3+GnP3esDQeN+UW1vPdodY8flZQCdjCMOD6RKoyViRsXYWRYtuaxYV
	 IKbXsOqZajn9xoNw5w8vnRU1Wp7x2Y6KntYt/Rm+iwx8xuvzxAg91z3WM0d5SD1cDc
	 8Cizn6stzh2uDLOSX+PdpMrpodBFoZ0q7MWUAS7NPVZNYn8dBS33ASguZetCFhsLUA
	 6Q95/JkGZ3Tr2sLoGqW4PHZvG16UEDkeYHpBMK24Gav9oqWHxt2vD0Gj6EVy1dv3LS
	 hIvKjOq/A1B7azl+aJ50i1/I3TKFgXujLcHOLItmiaRONm7EZIdLKpBVhL/BYTGkfB
	 Y10uPNd2B6rEQ==
From: Sasha Levin <sashal@kernel.org>
To: David Lomas <david.s.lomas@gmail.com>,
	gregkh@linuxfoundation.org
Cc: Sasha Levin <sashal@kernel.org>,
	stable@vger.kernel.org,
	rafael.j.wysocki@intel.com,
	matthew.leach@collabora.com,
	superm1@kernel.org,
	linux-pm@vger.kernel.org,
	regressions@lists.linux.dev
Subject: Re: [PATCH 6.18 0167/1250] PM: hibernate: call preallocate_image() after freeze prepare
Date: Sun, 20 Sep 2026 20:13:01 -0400
Message-ID: <20260920200637.10dc42c1bb6a@kernel.org>
X-Mailer: git-send-email 2.53.0
In-Reply-To: <CALjEBWQo0-Sdimo+aRNKUQvgDGw=jBFCcfwCXaqVdtoPrHLAQA@mail.gmail.com>
References: <CALjEBWQo0-Sdimo+aRNKUQvgDGw=jBFCcfwCXaqVdtoPrHLAQA@mail.gmail.com>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit

On Sat, Sep 19, 2026 at 02:47:25PM +0100, David Lomas wrote:
> Upstream commit 783c8109844503bd1c35dab41b6d5fd074a9f131 deadlocks
> hibernation entry on my machine (7.2.4, Dell XPS 13 9360, 8 GB, zswap
> on) whenever the system has been in use for some hours: the hibernate
> call never returns and the laptop sits warm with no image written,

Thank you for the report!

> Captured with SysRq (w) after ~8 minutes hung. The hibernating task is
> in the direct-reclaim throttle waiting for kswapd, which was frozen 27
> ms earlier by freeze_kernel_threads(), which this commit moved ahead
> of hibernate_preallocate_memory():

I've dropped the patch from the 6.18 queue. 783c8109 has not appeared in
a released 6.18.y yet (v6.18.52 is the latest), so dropping it from the
queue is enough to keep 6.18.y clear of this.

-- 
Thanks,
Sasha
