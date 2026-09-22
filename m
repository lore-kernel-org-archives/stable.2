Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A9D0D37F8C1
	for <stable@vger.kernel.org>; Tue, 22 Sep 2026 02:23:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1790043833; cv=none; b=t599huRwHRpLPmtQtNEuzxmGAbJuVC02L18K2HgnjuRDz0dJY3u9naAbq6b3HsDuAD/CxHLk5yZI+fP4y/V6xZXSoMtZ5DXNXscNJ1DxlhKsc/SvtloIAPBBpfzUtFg1x26ybtebnm5iGlO1ASMNnejZxiRs4RieUCdv5Ys8uwI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1790043833; c=relaxed/simple;
	bh=gjV7Dwx5C+Rj0HTDT0ZI2AqqTmhdTHzp40dQ2Of35kc=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=DKv4FVF2PtErQmbOLddXyYsYPBOhyo/lH4XwwkswodxXdIqNUXBQgMfJBauAY7mRQ6ZuoUKiXSdcOHMZ/gMxtavFH7veu8th6DPHiBNqxvLRz85hBkkJtaQb5ymggsQm6duz1rTGNjeIng2wt60ZPkfhbqFZnUguRuPiyeL9zQk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=bDEwCCJk; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="bDEwCCJk"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 0C0291F00893;
	Tue, 22 Sep 2026 02:23:51 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1790043832;
	bh=xevCBX2cDU3dNET17gklLceYTTGMHaJ+Wvo5KyGdRXc=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References;
	b=bDEwCCJkd0T5UEb4CLDTpa+qGQfPIyGxN5opSNqnuORHnqbQjb7YrIbh9G9bdQn92
	 MsCfrtu/IBsY/v2w9/Rjr1rUVq2tLiB6SCOAt2I9VrCJvlvlIgvdV+ZDsKgsVH5W6z
	 rjVZuAZwPZlVisYjL5uCn651zu/jmFSiC4BKd+PbQ1FNLgRlWT8DUrKtyW1OO+XNKP
	 qcbbgKMWhnica4VC3wemz52gpGtoP2XMBSi6PKOGDDzFJxyi+pBXg9WR5NJIph3sMN
	 QVimHWe8sM8kT+bjpOgHx5hI1CBLgUxRCBC6JN+2No+Asw0DhmqjAHHGiKW4888Fzd
	 YvICSL2YJ2NgA==
From: Sasha Levin <sashal@kernel.org>
To: stable@vger.kernel.org
Cc: Sasha Levin <sashal@kernel.org>,
	Jakub Kicinski <kuba@kernel.org>,
	Kevin Hao <haokexin@gmail.com>
Subject: Re: [PATCH 6.6.y 0/2] Porting two fixes for the cpsw Ethernet driver to the v6.6.y stable kernel
Date: Mon, 21 Sep 2026 22:23:41 -0400
Message-ID: <2026-09-21-daily-reply-0004-re-cpsw-rx-mode-work-6-6@kernel.org>
X-Mailer: git-send-email 2.53.0
In-Reply-To: <20260920-v6-6-cpsw-v1-0-a4a4b3dd4eb2@gmail.com>
References: <20260920-v6-6-cpsw-v1-0-a4a4b3dd4eb2@gmail.com>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

> As requested by Sasha, both commits are now being ported together to the v6.12,
> v6.6, and v5.15 stable kernels. The only minor adjustment is replacing
> disable_work_sync() with cancel_work_sync(), as disable_work_sync() is not
> available in the v6.6 kernel.

Queued the series for 6.6, thanks. The cancel_work_sync() swap is the right
call for this tree.

You had already sent all three versions when I asked for them, sorry for the
duplicate request. I replied separately about 5.15.

-- 
Thanks,
Sasha
