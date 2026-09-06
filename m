Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5B7803D79E9
	for <stable@vger.kernel.org>; Sun,  6 Sep 2026 13:33:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1788701641; cv=none; b=BoyCz4HfXrDFrNXpkLfSV8xaduPqIGbh+aEYHzuzVjAWRdtJcSo45IBJIVe2WyLBxlm0oljPm+UXY94ZzRjfhj10lmhDktHmQOIBHRXPx2p2QbtOr92qqGo87p2kSPQ8E6rR9LfolE7lxTvsO+CLq1zau10A/WjnsgdJYk1mfUc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1788701641; c=relaxed/simple;
	bh=n0L+gq8T9x9zekXqRcWIXZWTtF7I7Han/DxWEblR5dE=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=DQQgUUhzB8xN6Vce93v46haF5mBODBHJwmm351r40+4UJb5D2HxcU9yIr+G0qidFcQGO8i0J4My2CfaSdIZOzL4FPS/1el84KYzsPr+MNio1r1JKn0t7scQJX2GDLiUrGNc9Y88IhnK/pxh+2ToqaFJV3oVi7mWlBDbp45WlIWY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=MhXhrjMT; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="MhXhrjMT"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 808D21F00ADE;
	Sun,  6 Sep 2026 13:33:56 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1788701637;
	bh=QzpPgIJe98CFFZz/WQIQb8VlnkFw3Y/eiNqzNQCHu7g=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References;
	b=MhXhrjMT+CM31NqJ72CQDI9Abf0r+7rzBxK9SCGaHScQrgh+G/VLtr60h7j7pPmaU
	 P0VtcWQAdQwGng8vNC5SZpv6Dy89QnlgyShK8veuuvi03dQPKf+wUluluc+V+Mz+R+
	 vOKu9YsQie3tl7X59sPzmCJD/BNpOVdu4u5oqx82bwNtDeNQzK395bMEAr6bVtPFOL
	 hEjLO6POzDlpP+BxYDcJwhbQ3jsiipP2ZwDS69wfwxlL76pTB1C+943hIazNz/Ao5L
	 uqK+zProgxxNws360vCklb+PqQnBMRsiBIFC50jcC1BdY16Gfg+YQbSSA/qgX9WPmY
	 gcs/CVIPjUEww==
From: Sasha Levin <sashal@kernel.org>
To: gregkh@linuxfoundation.org,
	ruanjinjie@huawei.com
Cc: Sasha Levin <sashal@kernel.org>,
	stable@vger.kernel.org,
	Thomas Gleixner <tglx@kernel.org>
Subject: Re: [PATCH 5.10.y] entry: Fix seccomp bypass after ptrace with TSYNC
Date: Sun,  6 Sep 2026 09:33:02 -0400
Message-ID: <2026-09-05-daily-reply-0032-seccomp-tsync-5-10@kernel.org>
X-Mailer: git-send-email 2.53.0
In-Reply-To: <87a4pxa84b.ffs@fw13>
References: <87a4pxa84b.ffs@fw13>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

> Sashiko review pointed out the following issue.
>
> If a thread is stopped in syscall_trace_enter() for ptrace, another
> thread can install a seccomp filter with SECCOMP_FILTER_FLAG_TSYNC
> (e.g., via seccomp_attach_filter()). This will successfully set
> SYSCALL_WORK_SECCOMP on the stopped thread, but syscall_trace_enter()

Queued for 5.10, thanks.

-- 
Thanks,
Sasha
