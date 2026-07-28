Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id AA9563DD862
	for <stable@vger.kernel.org>; Tue, 28 Jul 2026 16:10:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1785255027; cv=none; b=FKOXax65/XAyAoE5JiYSJMclFKzlAetAh2FBuEp/ckvBg+S6vU9ITGL7mxzhkdgi81oc8jZ1N3P+N8/KMgtcjrfK1BRODftvqISxmA3d+RNatYDzougmB9BltNZp3bcS7lN1bsdZH9/6MKw0Vaj9oYOadNJzy0XgrdBCg0iOLr0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1785255027; c=relaxed/simple;
	bh=eJJabuO4hCXaYsOnivhzAs+mnqeo7yrDJqsdwNbaZCI=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=R28Es7QQSstMxjSthY5mBYkzZL0XDixV+62e0b5/O+o0fDadf5d+mbfBKehGNr6mwkBLz+WYCAB2ZbsmNJ3OqgbPf/tR4npbwOEzuJklnGtyiRc4s1VBS0THLhyuIC6jhcryUHMLKC5eBt0n47Mv86YXHco6khdBqz65vwtGV1Y=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=mF6jTYZh; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="mF6jTYZh"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 251EE1F00A3D;
	Tue, 28 Jul 2026 16:10:26 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1785255026;
	bh=76SYGvyU8cKPqPhhtdlBSisl1fmUTBFV7BQ0ld0S4mI=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References;
	b=mF6jTYZh14Qj/hauO9xYXfYc8q92fw2BPmWFFypOO5fWzmYZa9Tp6tM4V4XzWXpY+
	 3Tmh6iH4hEbkFgQRvdHusp8V/LQDVzoQJWR74y5rgu8L47LCkq+Xaha6Y8M1Y/7k/Z
	 FAHRkLCyK7Qgq9g1RyVidXGohRn7NY+RdHk16eu+FeegxuXuj6wtNhFeijb5abIbv5
	 ivqjQwsFialRl/dcwsNqoeNk0dtUK3+cTGwZx8zWocTwE9MdNTQCGV4oz1nUg58cXj
	 3v5/5H42bxQ/SxCJDP7lRf13nDBbRXfpAZ3lDwrBLmzo/+WcwrXPpFzBIZUXlAGEqh
	 AgzyclDM4r4og==
From: Sasha Levin <sashal@kernel.org>
To: stable@vger.kernel.org
Cc: Sasha Levin <sashal@kernel.org>,
	Shung-Hsi Yu <shung-hsi.yu@suse.com>
Subject: Re: [PATCH stable 7.1 6.18 0/2] selftests/bpf: Fix verifier_map_ptr failure after bpf_map excl field backport
Date: Tue, 28 Jul 2026 12:10:08 -0400
Message-ID: <20260728155654.stable-0014@kernel.org>
X-Mailer: git-send-email 2.53.0
In-Reply-To: <20260728072512.33620-1-shung-hsi.yu@suse.com>
References: <20260728072512.33620-1-shung-hsi.yu@suse.com>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

> The BPF selftest "verifier_map_ptr/bpf_map_ptr: read non-existent field
> rejected" currently fails on 7.1 and 6.18.

Queued the series for 6.18 and 7.1, thanks.

-- 
Thanks,
Sasha
