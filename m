Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C22883612FE
	for <stable@vger.kernel.org>; Fri, 18 Sep 2026 19:45:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1789760756; cv=none; b=HniHhiD/xUP9aEO4mPBga4eC985gemGWyYp2BFPtIjby1ksMaGZXREhzLlFapC8GDGp9nYQC9LGIAqM9EO4pWuWsV+HFDpxij7OEVLqr2690kUiwjuGjj+FmIBcWPyq10lejAQkxdbkZrsnwMhWF6eSR3mRZ+M6ElIA66uuWTng=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1789760756; c=relaxed/simple;
	bh=I3vX9VfW2PtfvnKw6yy1hRFH+TVnJsqRA1s1PfjTxU0=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=U4iFMZZgpHiqCjQ2eoIJDXH1w9CfOUPp5bI3lTeWC1AzN67sbUgJ5F3ul1knv3rA7+yEKmILdCHm2F7Dh4mrMDQxmEE6xoge08kKmmXquf5PAjTO1vJ4T6Nds3J+Ldhr8Buku3nzE7spw5Z63SDkR5RnKJqar+u/8d6JBmn4zm4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=TATV855D; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="TATV855D"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 062DB1F000FF;
	Fri, 18 Sep 2026 19:45:50 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1789760751;
	bh=534ahwBgKLJGwAuK/Nz/BsgrJp39rdQTv45jr+TNDnM=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References;
	b=TATV855DyUj5aGj/NGGWZP9GpXOPkUXF0pltIwuQ3P9MMoi+puh+bF7hTsmNY2fCf
	 3n8GJtwn0jGdHdvpzM3/ZVwfuVL1A3ORxDLUtGGdpRhSvTiHoG2cT6XBL644cAD89Y
	 fLwiFEfk9ydqrasuwWh1GYQ56RI257mRhORvAeqj+ceqJiVBIh/nYoelLm/OZza3XP
	 66AY5F62bnaNg/rq38dHsxOZg+/6TausYxI2SUUiF7ckFzDpYOSO1zIrxMiAo1mKJv
	 OWVMsmpTTAIsknqjcqH4M/jBTyIAiqO4ooqhlOnQz5VCFC3mxb17nRStUT27ac+ktj
	 QZQ7CztD+cXpw==
From: Sasha Levin <sashal@kernel.org>
To: stable@vger.kernel.org
Cc: Sasha Levin <sashal@kernel.org>,
	=?UTF-8?q?Micka=C3=ABl=20Sala=C3=BCn?= <mic@digikod.net>,
	=?UTF-8?q?G=C3=BCnther=20Noack?= <gnoack3000@gmail.com>,
	Christian Brauner <brauner@kernel.org>,
	=?UTF-8?q?G=C3=BCnther=20Noack?= <gnoack@google.com>,
	Song Liu <song@kernel.org>,
	Tingmao Wang <m@maowtm.org>
Subject: Re: [PATCH 6.1.y 4/4] selftests/landlock: Add tests for whiteout object creation
Date: Fri, 18 Sep 2026 15:45:31 -0400
Message-ID: <2026-09-18-daily-reply-0004-re-landlock-whiteout-6-1@kernel.org>
X-Mailer: git-send-email 2.53.0
In-Reply-To: <1b6b0763e8d42e60d4d86489dab9972e554b94bc.1789655724.git.mic@digikod.net>
References: <1b6b0763e8d42e60d4d86489dab9972e554b94bc.1789655724.git.mic@digikod.net>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

> [mic: Backport: adapt the tests to the older filesystem fixture and
> ruleset helper]

Queued for 6.1, thanks.

-- 
Thanks,
Sasha
