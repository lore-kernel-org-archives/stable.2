Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 76F783B961B;
	Sat, 17 Oct 2026 03:00:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1792206052; cv=none; b=eyfSE8KL2WW9YRJxw4lIsoQxgULSoTbBYIU3ouHeMGYe2UNF6f+ubUHoJoJ5RHpXfa3B+4YHAqINAZYkj56MsdHDCezPsfwP3s7Fjflh/6Gkar/PZs2Vr9W67DVSXGg4bW6izg6SK8Uc9LAEAMWFZKvMZ7kzTkXByDmVfERBc9s=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1792206052; c=relaxed/simple;
	bh=P4MYG5HgUIPQkX4oplVE7cKvW18doU+u521pzSgemqg=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=VRgXVis+iUIspM0a3lEvg6N1H7F27qXzd91hj2UR9gbbroo8LkA/r8uMjQYUlyd2hMxTUjDWFV4YrMJ72Jk1AbErxcrmVfe3zIy9f7sBh+x8zsJmYS4RhTBOOEsO6uwHdj0Y5FiFMhuzocbyrBPv1Ukza/F/W9Gp4EiOUz4NrCw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=NlA2n5fx; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="NlA2n5fx"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 8ACE51F000C7;
	Sat, 17 Oct 2026 03:00:45 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1792206046;
	bh=d1w1gkneqWGuArFWraDyPd1NUAgGJPZmhQDiFlysjeU=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References;
	b=NlA2n5fxsGEyenc3lkuEfjmsSUpaqRuXhc9Ek57hIcfkzHhyipTh2CWXDlAOiddxJ
	 MlNSXfX8TgfIrP0wXx1E4t0HzANjWEFEn7ycwvLUzcQqgbK2dtS8/++EA0L6sh7KSk
	 rfqcLjMdMiDR2VCCGHn+OuLYCjFxBZBA/+DhOOCOdhbDdbrmHj8EwYSfPVjCKJp/l6
	 8xsdHLWCtNdop27qrIljhuewb7XrHSUWV+AMLr4l3NjuY4l6ejqkMUNtGUqVN+t6If
	 leouUvbaGMhBlrmQYK0XTwBKHxdqPxCEVZzN5UBdBPDQn6gazqi3hN5a/l992Kv01L
	 jllZtxogsY7oQ==
From: Sasha Levin <sashal@kernel.org>
To: stable@vger.kernel.org
Cc: Sasha Levin <sashal@kernel.org>,
	stable-commits@vger.kernel.org,
	Jaegeuk Kim <jaegeuk@kernel.org>,
	Chao Yu <chao@kernel.org>,
	linux-f2fs-devel@lists.sourceforge.net,
	Eric Biggers <ebiggers@google.com>
Subject: Re: Patch "f2fs: move release of block devices to after kill_block_super()" has been added to the 6.6-stable tree
Date: Fri, 16 Oct 2026 23:00:22 -0400
Message-ID: <2026-10-16-1-daily-reply-0017-f2fs-bdev-release-drop-6-6@kernel.org>
X-Mailer: git-send-email 2.53.0
In-Reply-To: <20261016173526.GB122880@google.com>
References: <20261016173526.GB122880@google.com>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

> Not a clean cherry-pick, missing follow-on fix, and not Cc'ed to mailing
> list.  Nack.

Dropped, thanks.

-- 
Thanks,
Sasha
