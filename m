Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E54A0455626
	for <stable@vger.kernel.org>; Sat, 12 Sep 2026 15:26:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1789226786; cv=none; b=ssrd2PVYC0IN47WME0KGcIqMbNYSca2zMCUQXA06aM6fGhvLFhkBOUdTHGI2rR/ExzZti/6R5jciNMrySQ+vwAFLbu7DLymYb1i63enikWWMjqBz9XDBKd5Wljd/UIbp1/mfYQM3LpSa/AwuDj/i67bncpMHuwh9ougUbq0Eb4c=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1789226786; c=relaxed/simple;
	bh=tCCNBLRbZNJFATw5Agv8lCgq8/CbzqzqJ1hLeBJ3jJQ=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=qREXLKMZP5FK5tYzK5z/Y0kwxWZB4TCaEjYBBfuxH3q4jeEmiCvkcWsm/pF7sFIs17gY/I5y/HHo18anYGjicKNquCbkAvZCZYeAoLZ1cVDEOP6ighHOvZydooVvNwj4XhFulugUdFvzo87xTVXlxScLrin4UUn4TJjLiy5jINM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=FHeMBVps; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="FHeMBVps"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 4AE461F00898;
	Sat, 12 Sep 2026 15:26:25 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1789226785;
	bh=uls0FCs8FmfTdDSlcVVLlJJ9bnhVfTJLEIdHhZGggyA=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References;
	b=FHeMBVpsJRccyE68pB6ovhaCFoz2ecJvagBN4i30+mbjBQo6RCQjzKiXpvy67jkJv
	 +zzG1zN8aTiyLo0lRXq7YguYZ4A9lXXp+nEiOcC0w56twcWf322LVMV5dGMxzfj3jC
	 Dc0SL3wyj9dpS/WyWqG2VGDHuMUq8yZhgXP5z3tQ0sJuQ0q6ZayScw+/uV4kaePp9F
	 CQviMI5ygf9k1gHcMLGAP0arnL69swPhHKT6ecSzQxpW+XbVWD5rnVGVjstfnAeELT
	 KSHR08W1xMp+zDfJRlAZT2+vAyXHR+qijUDuD49dKUQXUGSgKFtnarRRivClcMKUBX
	 Zy0haWCOARtfA==
From: Sasha Levin <sashal@kernel.org>
To: stable@vger.kernel.org
Cc: Sasha Levin <sashal@kernel.org>,
	linkinjeon@kernel.org,
	Abdifatah Suruur <suruurism@gmail.com>
Subject: Re: [PATCH 6.6.y v3] ksmbd: fix use-after-free in oplock break notification
Date: Sat, 12 Sep 2026 11:26:13 -0400
Message-ID: <daily-reply-0003-re-ksmbd-oplock-uaf-6-6-v3@kernel.org>
X-Mailer: git-send-email 2.53.0
In-Reply-To: <20260911151048.27949-1-suruurism@gmail.com>
References: <20260911151048.27949-1-suruurism@gmail.com>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

> smb2_oplock_break_noti() reads opinfo->conn without any lock and
> dereferences it after two allocations which may sleep. [...] A break
> triggered by another connection that races with the teardown can then
> resurrect the freed connection [...] a use-after-free reachable by any
> authenticated client holding a durable batch oplock.

Queued for 6.6, thanks.

-- 
Thanks,
Sasha
