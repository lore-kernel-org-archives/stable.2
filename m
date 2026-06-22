Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 08A473A383C
	for <stable@vger.kernel.org>; Mon, 22 Jun 2026 09:54:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1782122078; cv=none; b=p9jCqudtz0u8UzNwQK1mFBaC8mg3v1CmQMyTVLIlXoI1Pp6kZU8bCGKVjtwHtwZ97gbdj9nqZJj2GVzWpSm6/9PUzRqZcs17v7Mt+RktMKsGTDgH0P2F3XxH5aXTfMbc8ZyZs3EO1sKnVk94LvpLRyluSG7ywE/JE5kKriOC4zo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1782122078; c=relaxed/simple;
	bh=BJyGh0z3P30vO2qgFu4RutoNTFYPMu59XThdlfPpiyg=;
	h=Date:Message-ID:From:To:Cc:Subject; b=W5EBc/EbWipXak58ProGSvK9J6QGxmeivvgVP5rKhI2qv8mqYteoeeip1d7icN1FVqScxXm0G6DjZXaoKRcGUEbGUsN4ZYc7Hu0LcfVoX4JrfxnykNlu4whWUvmxLGH5OBzBukrifRwl1JFUeznyg9fJmglnIekGfdwg4eh20NQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=HXaDP3XC; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="HXaDP3XC"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id B481B1F000E9;
	Mon, 22 Jun 2026 09:54:35 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1782122076;
	bh=xhmApsWlju3W9kGDHLVahbpDlPbsjxixGor1UQqvCqs=;
	h=Date:From:To:Cc:Subject;
	b=HXaDP3XCQ8RmUhyJ4FXtqIxrrznp871bUhV+69DHZox6FxFynN1w+0zZPxC4SZD28
	 9iJkJIhDU4n/j+NDtyNmmfULh/0Q6Vxr+sO5DnLnM9YlHvBbTkAiqPFWtkqWoh4h2p
	 w00UR5yWyjQe7yZHMt936e2DVZIF/vMnbvaaAo+KJbDsdEGtNnaeKfgBTYJw3SWy9U
	 RLmCt9yChkodw4Z/BZ1pJp1jk80kM0FFx2I9DnmrXb62iQI5hBimTGv5DCxK0Km/TT
	 fAWSXqrUWUZ8xOzJe3bCetFCbOMBnOnYGNtVo6NznmuFTdz6kyOpZFgiRzyOsBQJVb
	 gfu5fzvyBNikA==
Date: Mon, 22 Jun 2026 11:54:33 +0200
Message-ID: <20260622093040.582177124@kernel.org>
User-Agent: quilt/0.69
From: Thomas Gleixner <tglx@kernel.org>
To: stable@vger.kernel.org
Cc: Waiman Long <longman@redhat.com>,
 Sebastian Andrzej Siewior <bigeasy@linutronix.de>
Subject: [patch v6.18.y 0/4] debugobjects: Various backports
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>

This series contains the necessary backports to apply the recent important
debugobject fixes to the linux-6.18.y series.

Thanks,

	tglx
