Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id AF62A41D208
	for <stable@vger.kernel.org>; Thu, 24 Sep 2026 17:13:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1790270022; cv=none; b=bmElm9jIuf5wok4iKBK17zt7UJdc0pJnH8NPlVEsleYM4Z9+ZgvzJiuNeTKWm8sYLBxEeW7ql+iQSgrrmvFbQj0dzXhNCGVzzpv0nwKJtAVck6SIUFyMu8/UrxsDzIhHugBSWKIDz5qul52TelWmWzGCQV6gQITvxGABBJJIVI8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1790270022; c=relaxed/simple;
	bh=lr+l3z3Ogr8k4Ukl/5H9q7UT430DY/BIphjNZCNfmL4=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=orzXI9RCkthCSYkF+Rdxk8Q5jCj4yOSRYtBXO1BEjZF0Q9SWPzMzeWpCLZkROIAJtfhsY68iAV0VNG2vLYgK8FtKy0isrEPDBXJwuUcl0zQJY/2WoAbG3yq1GJwwKTBVWXkYFqyolvq51jd88Ktwhqn+GWo5VpvsKc7TRKLH7sE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=VkIk2mRQ; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="VkIk2mRQ"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id BCF401F00893;
	Thu, 24 Sep 2026 17:13:40 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1790270021;
	bh=RNNUYDI66+hNxEQQ2K9n2KZa2YO+qAAmWioCsovRxfM=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References;
	b=VkIk2mRQZOIgX0U+BkOBDInGhL5CH3rMZT9/wh52orrYruWDmBlUibMZU4wlkrE8u
	 fekOevCzB2KHPA0gWYlgAW2LzDD1JAMluNB/ciVBSTNr34r4lnkh5XUGqijKSGOwW/
	 7nXHmMN46VOdxucku9e/lOhJCz9O2+GuqDDDcgArTk3pNPgs0LxTF/kEejt2jkSmQw
	 tkOHkdUsU4lV+l5czenE8fULVm/RHBjK66Uo9Aq4BpumbwHdlvNhfwTCAVwqWhQyLP
	 IiDc+HA3sXqyMUhPnMx1tABhxHFkAGW11ndRf2h76UWAbUGCf11fC+E3bvqDOi7bPs
	 tgq1R/TrXTSVw==
From: Sasha Levin <sashal@kernel.org>
To: stable@vger.kernel.org
Cc: Sasha Levin <sashal@kernel.org>,
	=?UTF-8?q?Micka=C3=ABl=20Sala=C3=BCn?= <mic@digikod.net>,
	=?UTF-8?q?G=C3=BCnther=20Noack?= <gnoack3000@gmail.com>,
	Christian Brauner <brauner@kernel.org>,
	=?UTF-8?q?G=C3=BCnther=20Noack?= <gnoack@google.com>,
	Song Liu <song@kernel.org>,
	Tingmao Wang <m@maowtm.org>
Subject: Re: [PATCH 6.1.y v2] selftests/landlock: Add tests for whiteout object creation
Date: Thu, 24 Sep 2026 13:13:27 -0400
Message-ID: <2026-09-24-daily-reply-0008-re-landlock-whiteout-v2-6-1@kernel.org>
X-Mailer: git-send-email 2.53.0
In-Reply-To: <a657d4a9cd9f0445a700de9472a9f69d901e3f3d.1790169454.git.mic@digikod.net>
References: <2026-09-18-daily-reply-0004-re-landlock-whiteout-6-1@kernel.org> <a657d4a9cd9f0445a700de9472a9f69d901e3f3d.1790169454.git.mic@digikod.net>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

> Changes since v1:
> https://patch.msgid.link/1b6b0763e8d42e60d4d86489dab9972e554b94bc.1789655724.git.mic@digikod.net
> - Define RENAME_WHITEOUT when libc headers do not provide it.

Replaced v1 with v2 for 6.1, thanks.

-- 
Thanks,
Sasha
