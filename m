Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 90CA23D170E
	for <stable@vger.kernel.org>; Sun,  6 Sep 2026 13:33:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1788701641; cv=none; b=P+mTGz8b9Oi48ud1tQAcMQRt/XAB/Rnuq158Sc055uTCAtQMGiNCkm7dcQQBiNfN/1CXWVjd9eykE6/FyHBLwV9ultxxjNhtLnsABDJtrgel/MBdUm9qoJuTIy2fumi1lHkNt7OidEKGpYc8XOSJdsA35VnZiKpXSmqYAWn23so=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1788701641; c=relaxed/simple;
	bh=aPVPahaSLa8QiTBmz5WhzD8sNo5ZJXY9W9r3Yv7/nSw=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=Cds+JLa10lXrgR/XkJfC2PVi++KwDwFTY+7U7ofqYfoFxGvc/ZhOsP+y4BGdLrK1M8OCVj8gfOsuSAwVhizdpFJOD787IY9aRCZKD1gIhq0/pTRmDIjwu9L0N98MelKvKzmTS+wiKqD9e6CJvw0k2jXqCzbB3TL8Ckqyla6ue10=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=mOqu4Igz; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="mOqu4Igz"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id A322F1F00A3A;
	Sun,  6 Sep 2026 13:33:55 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1788701636;
	bh=hTjV/brA1hm+AdmtkntGPpNDUgEaGrlD5+0cQ+sCOs8=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References;
	b=mOqu4Igz3YOgNQpE1Thy8DqGLGVihEzRqbKyzjD4l6ukACSMp8I40UdL16L46MbM+
	 adx+w48LAesjTPJuVa6DViSXdtKiAyLhMZoDw1+74zw5JL5NrWlVAJh3QqTANPG0Wf
	 PFklEkDDM30wW/6nauLyENL6Urdz2222HdXvPlekU3RG+tPC2WxDBAQAMCwlJPLOm1
	 N15VudtAScOeArAJRLaiEdrimbHjfFwiEqJE3hzlNnXhqGUSmdbMJeMW+weiC7jFHO
	 iS3bHzJjQUmgBgo33YkN9u7++JEjtyxo79AzVtbLN7jmUAlHoM0IqhQko1YiYVxMfg
	 HDkFyuKS2B73Q==
From: Sasha Levin <sashal@kernel.org>
To: gregkh@linuxfoundation.org,
	ruanjinjie@huawei.com
Cc: Sasha Levin <sashal@kernel.org>,
	stable@vger.kernel.org,
	Thomas Gleixner <tglx@kernel.org>
Subject: Re: [PATCH 5.15.y] entry: Fix seccomp bypass after ptrace with TSYNC
Date: Sun,  6 Sep 2026 09:33:01 -0400
Message-ID: <2026-09-05-daily-reply-0031-seccomp-tsync-5-15@kernel.org>
X-Mailer: git-send-email 2.53.0
In-Reply-To: <87cxuta85a.ffs@fw13>
References: <87cxuta85a.ffs@fw13>
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

Queued for 5.15, thanks.

-- 
Thanks,
Sasha
