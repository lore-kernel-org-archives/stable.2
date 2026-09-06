Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6674B2C15BB
	for <stable@vger.kernel.org>; Sun,  6 Sep 2026 13:33:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1788701627; cv=none; b=nixiM4bfEY9tDt4f7cVRaL4xpTGSt8jAPobhheco/DJZPdcOZ46C1OQ3QH/R5rlaXKNtITg1C5jM1zff+O/beE6of0+SiDYAoXGYCX3tUy/Y1b3XTJPqehuiCBrswi49KeVpnIuBrLjtX4TpqM8m51Vfr1DrtRTOwHovTsmrJMI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1788701627; c=relaxed/simple;
	bh=U90uT9ragr/1w+3jTdqEJb6v5bzcNXkieIz6yIUSyTQ=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=AUwDIQ3PMt8LZOlmk6WaUxPhDmSxY8ayd5mgFc+WHxQ6nJhttS8HJMbRAn8D5HVnQIvVldRhSNyl2OQIBH8pDZsq5cQVGgQJqM+urjsqUNQhGNgXPkcolGzzmhPIL7H9YpBH14rcIRzCwb5zEje/pIJbn8ffISgUdOirqND2vAY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=EHMNtY1Q; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="EHMNtY1Q"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 7248B1F00A3A;
	Sun,  6 Sep 2026 13:33:43 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1788701624;
	bh=xkB1qVAy/snp7la0WeChX6tAAvBu1MDreHil0QgEng0=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References;
	b=EHMNtY1QhoV/e/z0BBZL7hzh0ONRzQ55GOzDXVRRb+jhPSl/RyOZ7pOAnBM8ICwtg
	 VS1sVZ89y3hqGU/pIo9Bk+AoCZNha6Hun52fio0MNgFifqnw3SEpGzBoOIBI2R9EHV
	 duSSVtt1MdT45G8oPy2di+PGJbPsdqekJuzH11+0T7+Yehk3gB/hAa4COzndsJxqOm
	 D10gSBSlVErlbguxzI5utNSU4MrKrSyVoHxuF9ZPxP7pMYm7gLj9Ph7DP7fHXXTOZ7
	 CXywiayVgPZhIc6fqA7cQraj6vhp9PTgUtmuryc5TS8pcgGhNLv19fRrOIzLOTDjum
	 tq9+3bUKsZh1g==
From: Sasha Levin <sashal@kernel.org>
To: stable@vger.kernel.org
Cc: Sasha Levin <sashal@kernel.org>,
	=?UTF-8?q?G=C3=BCnther=20Noack?= <gnoack3000@gmail.com>,
	Christian Brauner <brauner@kernel.org>,
	=?UTF-8?q?Micka=C3=ABl=20Sala=C3=BCn?= <mic@digikod.net>,
	=?UTF-8?q?G=C3=BCnther=20Noack?= <gnoack@google.com>
Subject: Re: [PATCH 6.1.y] landlock: Require LANDLOCK_ACCESS_FS_MAKE_REG for whiteout creation
Date: Sun,  6 Sep 2026 09:32:50 -0400
Message-ID: <2026-09-05-daily-reply-0020-landlock-whiteout-6-1@kernel.org>
X-Mailer: git-send-email 2.53.0
In-Reply-To: <20260904185816.343078-2-gnoack3000@gmail.com>
References: <20260904185816.343078-2-gnoack3000@gmail.com>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

> Whiteout objects are used in the upper layer of an OverlayFS to
> indicate that the file with this name does not exist in the unified
> view, even if it is present in one of the lower layer file systems.
>
> For the userspace implementations of OverlayFS (fuse-overlayfs),
> whiteout objects can be created from userspace as well:

Queued for 6.1, thanks. Note: 6.1 is missing 49c9e09d9610 ("landlock: Fix
handling of disconnected directories"), one of the two prerequisites this
commit's own message names -- 6.12 and 6.6 already carry it. The whiteout
check itself is still correct and worth having, but if a disconnected/
bind-mounted directory is involved on 6.1 specifically the enforcement may
not be reliable yet. Could you send 49c9e09d9610 as a follow-up for 6.1.y?

-- 
Thanks,
Sasha
