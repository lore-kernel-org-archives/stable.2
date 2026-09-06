Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2B6213D5647
	for <stable@vger.kernel.org>; Sun,  6 Sep 2026 13:34:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1788701645; cv=none; b=sZRXFKMLHkdUa+HbOpjVBgtQyohKyiNeKuEBIjJEIOVDp6NRfIpf5yk69WCkM3MwcefMxJ1W0UvZFP1jxuKhE/GzlizzxY5rTSDYqJ5sAaehAuahu7CuAsc2H9Z5M25a82aK4EiiAJ4Zb6wXKkPsEid4qYdyNx5BMV3MfIQN5vQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1788701645; c=relaxed/simple;
	bh=pWNwoWD0eKGw9SqQ4mMBFrbUjHkLGel+nuxZ5drj9BY=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=N8hiHqFkalppLJzGMwVfC3Co1Xp7EOTmeYHpRAk2QACWmlIVnTIeDLeFoHf4icMhUd+Kx29P1Suqq4dAKb2YSwjQY+PS1q9D6lyY/BLi0/R9vyHtkoQNUOQLDkEbIbZ7FYlHYPc1/WM1C66iKq1hZrKD7Cp3uoKasjsR/FsmVmQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=db5Oj9qH; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="db5Oj9qH"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 2E4D01F00ACA;
	Sun,  6 Sep 2026 13:34:00 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1788701640;
	bh=b5lnD2MRc8+d5OGFOXFtoK5x5oBw15oJo8JoIQBq2jA=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References;
	b=db5Oj9qHgmzS4jEcH5aT8z/HbgaO6aHjt9mpYDdAaYNC0klD/TLE3f6KuP/sokZWg
	 KfYUBCnjFMUPPFXKgcGUECbsto/eTMVBlbym9ktcADadVyws3ikW4Yu0P9jrJ4xMSK
	 mlxue8K2mubvcO1j2oiJw0X7LGp8vOa0t3M8YhqGRbaR3bmyRFN1O+dexWqcRLlnXj
	 R01PDMorB4ERRrmILAQ6uPTlwf4B49npIjtx6Kx3NwTtN+5U7a338kyR4zYkGuU/4C
	 OTLviBAg74UHg1KEiNjtNymqKwLs21JXA5L6uZjRY6nMRk1nJR8p+gY+FsmuSByB5b
	 H2U2MoUguNgzA==
From: Sasha Levin <sashal@kernel.org>
To: stable@vger.kernel.org
Cc: Sasha Levin <sashal@kernel.org>,
	Youngjae Kwon <yjkwon0026@snu.ac.kr>,
	Jan Kara <jack@suse.cz>,
	Amir Goldstein <amir73il@gmail.com>
Subject: Re: [PATCH 6.18.y] fsnotify: Fix stale object mask after concurrent mark updates
Date: Sun,  6 Sep 2026 09:33:06 -0400
Message-ID: <2026-09-05-daily-reply-0036-fsnotify-stale-mask-6-18@kernel.org>
X-Mailer: git-send-email 2.53.0
In-Reply-To: <20260905024800.3944249-1-yjkwon0026@snu.ac.kr>
References: <20260905024800.3944249-1-yjkwon0026@snu.ac.kr>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

> When a mark gets a new event bit, fanotify and inotify may avoid
> recalculating the object mask if the cached aggregate already contains that
> bit. This is racy with a recalculation triggered by a concurrent update to
> another mark on the same connector.
>
> The concurrent scan can read the mark before the new bit is added, while

Queued for 6.18, thanks.

-- 
Thanks,
Sasha
