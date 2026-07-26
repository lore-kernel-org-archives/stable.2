Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C7275376BD1
	for <stable@vger.kernel.org>; Sun, 26 Jul 2026 21:24:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1785101095; cv=none; b=bCrFb7W8NZBEP9PyGKnvRf9tNbcnaGg2jtTnYiK4nMP3IaiKYo+R+iGZpvDqztZ2Rvsz5esLyk12rUlF5GMUvNABLBcm6ELwS2mOp3AYDAzsMpTNBfRNkpXoHfjpePb5oIGCb4pCnbhnh1USHqzzAX0zb9TizQZ6wtP0M1GktE0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1785101095; c=relaxed/simple;
	bh=SVZo+dfyn2bV45yE3xK58y5+z+bUHmy1j37AwaFFo4s=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=dYV4FsEqb+4OHaUAfIN3aNT4g0etJKYW5WtCn5dQh/Cj9mRmKstT2sfXvsn4xhvHywKShrPfu1GpGI2cJSlOUjb4GTaEFwnHvM9XoiYGnGQQ9H+9TM666bEqoP1pee7wUMcwH+xgLjQoAdC/vvkuZVwVY3T0M3ABCJeM3SDaYNo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=Ak70mLEf; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="Ak70mLEf"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 005D41F000E9;
	Sun, 26 Jul 2026 21:24:53 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1785101094;
	bh=br7zvLxq5vWEBmlxPoitVMDo2lEe/Ek9VQlgonPG2/I=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References;
	b=Ak70mLEfKhr7NG73t47XQqRzPd50ltC35n6BhfwnoAyWnC0rwR6yKQGI7+RLo6ZLc
	 4zSu/wm58RT3/oxqhWyGu1H21+xv2Msq1w/7jgkFwZG6ZY/D4BbMDI8OJhKL1nZbqC
	 HcDubik4+ifAzI9R347//29671F97foodPcQ2nuZZpq4Sfjej60Ep8i9M17jvRGhtd
	 vrAMS6lhNZn2oMa5oBz/LCX5R+UlqmJV+nOB5i016d7sdSou2GxjVZho3r72EMRMHG
	 e/bn2fY91Noko0Gzbn+HCTMWrDkrk4sbrOmvevKr/saoyd0V3JQgr1NR66emRlO6jd
	 t7UtDXJ+Ung2w==
From: Sasha Levin <sashal@kernel.org>
To: kernelci-results@groups.io
Cc: Sasha Levin <sashal@kernel.org>,
	stable@vger.kernel.org,
	KernelCI bot <bot@kernelci.org>
Subject: Re: [STATUS] stable/linux-6.12.y - 0fdd40630ea1ca5eb0bb70113cdac90d5788511a
Date: Sun, 26 Jul 2026 17:24:46 -0400
Message-ID: <20260726195203.stable-0001@kernel.org>
X-Mailer: git-send-email 2.53.0
In-Reply-To: <178494662803.1348.11623299012805090598@92650adf53de>
References: <178494662803.1348.11623299012805090598@92650adf53de>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

> ### POSSIBLE REGRESSIONS
>
> Hardware: bcm2837-rpi-3-b-plus
>   > Config: defconfig+lab-setup+kselftest
>     - Architecture/compiler: arm64/gcc-14
>       - kselftest.proc
>       - kselftest.proc.proc_read

This one is a real oops rather than CI noise, and it affects 6.12.y,
6.6.y and 6.1.y.

proc_map_files_lookup() and proc_map_files_readdir() NULL-deref when the
target task has no mm.  The backport of 6650527444da ("proc: protect
ptrace_may_access() with exec_update_lock (part 1)") converted both
callers from get_task_mm() to mm_access() and only tests IS_ERR(), but
those trees are missing the v6.13 prerequisite cd3f8467afd4 ("mm:
refactor mm_access() to not return NULL"), so a NULL return falls
straight through into mmap_read_lock_killable().  5.15.y and 5.10.y are
not affected - their backports carry the compensating ERR_PTR(-ESRCH)
conversion instead.

Queued the missing prerequisite for 6.12, 6.6 and 6.1, thanks.

-- 
Thanks,
Sasha
