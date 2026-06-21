Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7EFFE62809;
	Sun, 21 Jun 2026 13:47:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1782049674; cv=none; b=aqS29DMQlk0LO3JffLufmEzfvrbA00RPcOPETHuVpodr9Bsq+H918mQVnM3YTRLcGTUf4jqhWnmXYm6wA/Qjv9VzIZaEqTkD+QlgHtWk7pxACskc3SGxN+Ia/TJ1TmtRx/dUrbSSCo2X3sY4tzbKUT5eA2u6+eN2ztEG61dxGl0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1782049674; c=relaxed/simple;
	bh=4qRiunIixzSUm2c/epCCCUghgm1hs1SpOluiNikjXGs=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=cwo7tczFpk/GOumi5qOzH9SauNWA7CBWm4N5/6fHlRgcR2YwtMzMF4HhfjwQ0WRQ5P9ALlkiG6k5/Z3GNeLijzEeSp5+dqwOp+JOEefpTOIguBL6VBO2zApwf+xN9aX69CBJLMtBN5/0lTpmODDSQMMywqq5bLPo9J7VAlFDztU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=XDRAWRil; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="XDRAWRil"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 9C4A71F00A3D;
	Sun, 21 Jun 2026 13:47:51 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1782049673;
	bh=ow1LSmRuQ0I4nJ5kJTePCFnDvx4l3BvtVLs9xM0KEJA=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References;
	b=XDRAWRil2YMxxUZo1f1Honwpn9/53A5kb02/hR1mwZ/6ZKOruFAlBld42oTJcnt37
	 V3iIKz6/iA/AwR9kEnmjsTWaG6tbom/E++ETSZ58IOxKj/y4Ucnavp1ITl/r+Qw+PP
	 2FvSSr+y5FrBqxRB3CxAkO0Q0WRc/+2ZESEsPnzz0kOWHeETc6aiTyI8YD7Idw7gdM
	 xQG3BPiMr8t23O8oWiNDGl5dDuRew3dJk4UalKDxBLmmh6SfHOsUaK5WYPYCL4qLST
	 RstdHoLlBkJnnbOFgSs40NfJBh2Z8L0CecfBykG8X9mS9Y7j7AS+LU50t4dSd9GKxt
	 1v/ZaNV6C42eg==
From: Sasha Levin <sashal@kernel.org>
To: Alexander Viro <viro@zeniv.linux.org.uk>,
	Christian Brauner <brauner@kernel.org>,
	Jan Kara <jack@suse.cz>,
	Davidlohr Bueso <dave@stgolabs.net>,
	Andrew Morton <akpm@linux-foundation.org>,
	Soheil Hassas Yeganeh <soheil@google.com>,
	Eric Dumazet <edumazet@google.com>,
	Paolo Abeni <pabeni@redhat.com>
Cc: Sasha Levin <sashal@kernel.org>,
	linux-fsdevel@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	stable@vger.kernel.org,
	Quentin Schulz <quentin.schulz@cherry.de>,
	Linus Torvalds <torvalds@linux-foundation.org>,
	Jaeyoung Chung <jjy600901@snu.ac.kr>,
	Quentin Schulz <foss+kernel@0leil.net>
Subject: Re: [PATCH 6.12.y 0/7] eventpoll: backport a6dc643c69311677c574a0f17a3f4d66a5f3744b
Date: Sun, 21 Jun 2026 09:47:40 -0400
Message-ID: <20260621133722.0002.sashal@kernel.org>
X-Mailer: git-send-email 2.53.0
In-Reply-To: <20260619-6-12-cve-2026-46242-v1-0-e15a6de43c11@cherry.de>
References: <20260619-6-12-cve-2026-46242-v1-0-e15a6de43c11@cherry.de>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

> Backport a6dc643c6931 ("eventpoll: fix ep_remove struct eventpoll /
> struct file UAF") to 6.12.y. So the patch applies cleanly, [6 prerequisite
> commits] ...

Queued the full 7-patch series for 6.12, thanks.

-- 
Thanks,
Sasha
