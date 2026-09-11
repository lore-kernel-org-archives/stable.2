Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D5D4F41228D
	for <stable@vger.kernel.org>; Fri, 11 Sep 2026 11:21:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1789125678; cv=none; b=THcHYd6re4l8eI/aDJYWnoTLT+3h/SNA9/JEJ1QoosZRG9mBMYodnlw4jhSbyOBzvQhRYEV9a5Tf3SDV07VLWa14c3XyEOJYAYQUQPwK8K0THqvRxAcXt4mFDmuXkcBZq/ThNmj1hP3ny2v54fObMib5b2CDhFCyO+T4DYKKUDQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1789125678; c=relaxed/simple;
	bh=QNbde7qlwTAizqGd1YwU+3m/i6pqJjAQO5/MLUnVYAI=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=UGUhj8GtEpghBXPPtLIbUS+4ykc4VRjzkAvqTyU1ey4l46AadOVY7EpKVZVRpeAuGbIYv0ujcAlZtcYj5EP0vsJXCtMobZpqhW0y6U0kQh6a147uLWkjK2OLlq+0LVe3/DxTEKm/tgy3+bELFF6qJM1m73ToVKzYgPWoKIux4m0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=Csc7ozRB; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="Csc7ozRB"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 548A41F00898;
	Fri, 11 Sep 2026 11:21:09 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1789125669;
	bh=u8k9go5Ed00RatU/FlqxAj0JYcj1dIKK1uAAFo32YAs=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References;
	b=Csc7ozRBTiikzt350RNgEHajOPSIqt4794w4QBBkykMgQD3BiUeh/XbZ9mVTDsZqS
	 qJKsib4wqacj3TcsEplXqxRYx5t0zwCnhMJbwQRZ+RCuXk3246CVXzCoScj806y3mL
	 ZZLAjzNsBwZ4HQzRiTfOIVWm0EYMgZxcioaG93UhiV6JqD3PXLcs8Ud+4fvemAsDFs
	 Qolh1dDnh27bzAK/kjH6wuanrqO4OsZi4QYgCoYcjYpl9XkiixYDAWIG/9rKaS3J2n
	 VCmeZ92yHNucpx1LtuMgWY2UYL5odqnukjv+K47FVwmb3eMyYSbN5jrWiEXrsMdQR/
	 Er1nBqC5DEV6g==
From: Sasha Levin <sashal@kernel.org>
To: stable@vger.kernel.org
Cc: Sasha Levin <sashal@kernel.org>,
	Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
	Artem Dinaburg <artem@trailofbits.com>
Subject: Re: Please consider these upstream CVE fixes for 6.1.y, 6.6.y, and 6.12.y
Date: Fri, 11 Sep 2026 07:20:26 -0400
Message-ID: <daily-reply-0007-re-cve-batch-6-1-6-6-6-12@kernel.org>
X-Mailer: git-send-email 2.53.0
In-Reply-To: <20260909180637.41361-1-artem@trailofbits.com>
References: <20260909180637.41361-1-artem@trailofbits.com>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

> The 28 commits below are still missing from one or more affected 6.x
> trees.  The Linux CNA affected ranges include every target listed
> here.

Queued for 6.12.y, 6.6.y, and 6.1.y, thanks. A few exceptions:

- 0c22d9511cbd ("ceph: fix BUG_ON in __ceph_build_xattrs_blob() due to stale
  blob size") is queued for 6.6.y but not 6.1.y: it applies cleanly there but
does not build, since 6.1.y predates the ceph doutc() logging refactor the
fix's 'cl' client pointer depends on.
- 3db440443539 ("md/raid10: wait barrier before returning discard request with
  REQ_NOWAIT") is not queued anywhere: its own follow-up needs a prerequisite
that itself needs further follow-ups still missing on 6.6.y, 6.1.y, and 5.15.y.
- efe24898485c ("drm/panthor: fix for dma-fence safe access rules") was not
  queued for 6.12.y: its own upstream tag reads 'Cc: stable@vger.kernel.org #
v6.17+', and the dma-fence infrastructure it depends on is not present before
6.17.

Everything else on the list is queued as requested.

-- 
Thanks,
Sasha
