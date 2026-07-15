Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1A73D219E8
	for <stable@vger.kernel.org>; Wed, 15 Jul 2026 00:12:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1784074378; cv=none; b=Q16EklJsRQ73Ez4LsGlbQb1mghMAbLl+Sp2OUdEh9J2JaO3S/yifpfqgmKgfI/M7Lw41qqpFJoCXoMh7dDG2ISHFw1Wnz2jFB2YRMd4qizHDRxNIbHIiQWJLtSCTy/1fXWg+5jGvghwjympy2UDQxdA9xT/G9GEJLMyCD4mqSrU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1784074378; c=relaxed/simple;
	bh=TGktpBSs8EIvZwPQ9dPiZr5yHB1FOr/kUlmDOhRJZMM=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=jiq9/z/D6ldKA6ufkBaq65ZMMlAShfPFB/J8agciM2p4cM4n0LL0QpT1MVEivoa2tWRCaI0lIm66eY/ZGJERWWYLgPQGi9MsmTEnFe3ufIAroc5Z06iQOzTrNZ6LAwe58x1xXwNInwgngH8tCbaftWlbBtwGQjBUrEzOWjeJm7U=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=ekP8SkHJ; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="ekP8SkHJ"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 49EFA1F00A3D;
	Wed, 15 Jul 2026 00:12:56 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1784074377;
	bh=kcRiSYOEa0LcsyOkFpR1HjAqMOlMaDwPSe8RyvG7hao=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References;
	b=ekP8SkHJb/iwK6GdxvmAS1tLzFcmT3AkDcn2WB6/NzovfQqoVdSqW7UYtUBKpTnU+
	 3iENKjkTSmJ76jLT/tnfuW+iJv7rgC09CRseKUwlWIVp2LHjinXF4M99d9HZEitVYA
	 XgFShDXzEHOMOvj8tsAyRxZ1mOjdDA4JyB4jKepNDBWzmW3IuO/G/z8VnHcmo5+UkT
	 LdAK1ek3RaM8ut3WdMfB17cmzcCId6Q/eZPFzhX6XCn/d5zqGIUefDkkOFLL7C6p3Z
	 rykPmqfNi2ZtOyxk/7wC5dvqkAFpa/qqUwulgJ6B8qIiTJ3ACS6JB3DH0f7nMl7ish
	 aMvvjD8lboh2g==
From: Sasha Levin <sashal@kernel.org>
To: stable@vger.kernel.org
Cc: Sasha Levin <sashal@kernel.org>,
	Anisse Astier <an.astier@criteo.com>,
	Ard Biesheuvel <ardb@kernel.org>,
	Mario Limonciello <mario.limonciello@amd.com>,
	"Mario Limonciello (AMD)" <superm1@kernel.org>
Subject: Re: [PATCH 6.1.y] efivarfs: expose used and total size
Date: Tue, 14 Jul 2026 20:12:41 -0400
Message-ID: <20260714200600.stable0012@kernel.org>
X-Mailer: git-send-email 2.53.0
In-Reply-To: <20260714043329.3510162-1-superm1@kernel.org>
References: <20260714043329.3510162-1-superm1@kernel.org>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

> Background for this backport is that fwupd needs to be able to do CA
> updates on Debian oldstable (bookworm) which tracks 6.1.7.  The CA update
> process checks for free storage, and needs this function to do it.

Queued for 6.1. I also pulled in the follow-up fix 79b83606abc7 ("efivarfs: fix
statfs() on efivarfs") on top, so the broken statfs() error path this commit
shipped with doesn't land in 6.1.y, thanks.

-- 
Thanks,
Sasha
