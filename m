Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5EC743D4116
	for <stable@vger.kernel.org>; Fri, 11 Sep 2026 11:21:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1789125673; cv=none; b=gNCR3UcW1UG2o+KaYBZfhwh1GR9I1/mWyWgY17/aMuG+tmasal/pp+kSesa9U4KYJ0Zjd/46tc1EiRk8hqgoGiS5yty60phpORMRH2MZh8j6q0Xq3K3gAdhFRBMzcnDRoANcCwCbreuK4FKKFTrU0Loi9wfzkMVrd1EdbJPeRbU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1789125673; c=relaxed/simple;
	bh=YwotSdPRQeXk7jGM7JralUJyi2Qlepej1A5Xxqj8WeI=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=TErg0kpjYkDm2CwbigQK3eMFGIOtTLXXuuUkAwV2pupVNmFvIz7DirCxs+hI4+hSUur2RCsISMuFtpXQna8oHIcYXTsm854CDrw4IL3+Jf8EB/B5/O0QK28H/tTTZ3fWcKGwVeg6zsn1xL8yRwuZpm5hmEAgL/CgkHyd0JwNECA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=FC5gQUpT; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="FC5gQUpT"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 970F31F000FF;
	Fri, 11 Sep 2026 11:21:07 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1789125668;
	bh=dNnH9RPa7Uex1gQCjkvy6DSbFNESGGJn+mbo5465bdk=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References;
	b=FC5gQUpTpirDxdwgU5PaRyxGwhkPuYvpLHuGKGmKtsJIOoxOuacvWUsV2Xv4wYGJ+
	 iO1jT7BPJkV2qNDwno6i8lnoPIIEsO62Juyvb4WIs+2VBIG5uoexykQ5RNESAV57Op
	 yO5VSUqwnrNv+etJ1wEpbGk3bN20HJAnVSvblQKmA8doIFBfQzV06C8IFzFY8Qj78g
	 cZDu3nBrgZjwvLIEGJuP6VotNi51tk8ZuQ++cQRjjPUZg4e27H/MGb5h55QvsdORES
	 gSYFKloNeBuVAaU2pgSiYr1KeGijxxLQpIobdyd/JoklRdvNeRNOHwCj+O/9BvgjDc
	 IZkcPsJ2iZk9g==
From: Sasha Levin <sashal@kernel.org>
To: stable@vger.kernel.org
Cc: Sasha Levin <sashal@kernel.org>,
	linkinjeon@kernel.org,
	Abdifatah Suruur <suruurism@gmail.com>
Subject: Re: [PATCH 6.12.y v2] ksmbd: fix use-after-free in oplock break notification
Date: Fri, 11 Sep 2026 07:20:24 -0400
Message-ID: <daily-reply-0001-re-ksmbd-oplock-uaf-6-12@kernel.org>
X-Mailer: git-send-email 2.53.0
In-Reply-To: <20260910072145.9042-1-suruurism@gmail.com>
References: <20260910072145.9042-1-suruurism@gmail.com>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

> smb2_oplock_break_noti() reads opinfo->conn without any lock and
> dereferences it after two allocations which may sleep.  When the
> durable handle owning the oplock is disconnected, session_fd_check()
> clears opinfo->conn and drops its conn reference under ci->m_lock.

oplock_break() can block up to 35 seconds in wait_for_break_ack(). This v2
takes down_read(&ci->m_lock) around the oplock_break() calls in
smb_grant_oplock() and smb_break_all_write_oplock() that previously took no
lock. But the wake path in opinfo_del() needs the same rwsem for write on the
same inode, so a queued writer there deadlocks against a break held open under
the new read lock.

The 6.18.y version of this fix takes no caller-side lock at all, so the lock
added here is not a required adaptation.

Could you resend without the down_read/up_read around those two call sites?

-- 
Thanks,
Sasha
