Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 052E344E649
	for <stable@vger.kernel.org>; Fri, 11 Sep 2026 11:21:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1789125683; cv=none; b=VIe0M6UZeA8un1eVvPcnGi3dSpXQ9medGuC4zZxHfBUiUHit4F9oIH6xpiQHsou6/fqymvE+9Xskc3BT4Kq7+Z25mfsonidKhAEj13TqsEjLrBfnTzknneWVolDzvb/d6gsskQEStEmnN8kkEKBwuOznefdliNh9CFQRoTmyn3E=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1789125683; c=relaxed/simple;
	bh=7fmswuls+DmarZMmv7ymQzIAmG5LwW5FkVwC+3DtqPY=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=lYtIPSVfHP90ChPpukkVjmzYpLXA8d6yRm9nUwHtCWxq8bcfYqWwp10ycLVRTmy48A3ZIQfl8rTw41geVLA4GpXWdMewU40G6SBZ9jaUWE3p3jwVavimqXJnrBzaj4jzawpJmGhv8DuahUG3O2xDxBL1zuZ4ypio9H0FYVjSmUo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=I5FaLTJV; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="I5FaLTJV"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 2E9D41F008A2;
	Fri, 11 Sep 2026 11:21:21 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1789125681;
	bh=E0DSUQtjjl6YqLBu4nExj3gFq8U/axN/AzTgDnT62vk=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References;
	b=I5FaLTJVzxqtSZFlOUENY/8eW1ohr4UwbP1zXlj7SCVBiP2Vf5hVxDrdorWCmS0Ob
	 H/vLCkwKEa+7JMLCGZliYnuKeWULo37wvCgkdYs1cWTej5Ahf5LhX7mqvfLSfpsiyc
	 2ygismS4EQgKYhk7lI7PkZa17wLZwEonDDd46ibzDIhjc0BaoejeeQ3wJmruCnTNN8
	 bstLCbrOa7Hs3vuq+pX04UeS2M/bAIzFV1owwXXxGwgfAUiSIixCizdQDLc9GsIm41
	 o/IsKKJf59uBzWacMToSv6du4VTye04dQE1vFobFe+TLB3XBnNeNmHqMGGVW6UWKCE
	 E1wvkdV6B1dZg==
From: Sasha Levin <sashal@kernel.org>
To: stable@vger.kernel.org
Cc: Sasha Levin <sashal@kernel.org>,
	Arnaldo Carvalho de Melo <acme@redhat.com>,
	doebel@amazon.de
Subject: Re: [PATCH 6.12.y] perf sched: Fix register_pid() overflow, strcpy, and BUG_ON
Date: Fri, 11 Sep 2026 07:20:41 -0400
Message-ID: <daily-reply-0022-re-perf-sched-register-pid-6-12@kernel.org>
X-Mailer: git-send-email 2.53.0
In-Reply-To: <20260909210503.199459-4-doebel@amazon.de>
References: <20260909210503.199459-4-doebel@amazon.de>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

> commit 5949d339f5ec98752d56dcd4e36f619a59d513a5 upstream.
>
> register_pid() has several issues when processing untrusted perf.data:
>
> 1. Integer overflow: (pid + 1) * sizeof(struct task_desc *) can wrap
>    to a small value on 32-bit systems when pid is large.

Queued for 6.12, thanks.

-- 
Thanks,
Sasha
