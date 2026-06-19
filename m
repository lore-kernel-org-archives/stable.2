Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4F53432BF41
	for <stable@vger.kernel.org>; Fri, 19 Jun 2026 04:07:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1781842047; cv=none; b=UIb0lHKd/1/gn3sbebAcTI1y7qkGTnL0OPgBdMIpqvVMsTWl9qGD7tUUEWWmJKc1h+R0mMdRAEk6+8e9emOc0y7mpcxUAiKE2st/PLEsRn4mx6kISKcoro8orEW6HA8oXhjbgmIelXqrYIzechnMIBrqUXPxWILRulh9s27uTa4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1781842047; c=relaxed/simple;
	bh=SYrOiAi23vpHmBbCBuJchauJs0CaZacvuixu5G/T7Cg=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=dGB32T0w58huWTnEsUa1mK2wnDe1IjJ/hz6XME4JqzMIruY6ekowoXpjhZDpicOBC7IUfDRUVYarN7AQ9/KOQRoSSkE0tayz84DHJOgvlEhcsSYLSJ+nS3TpuvF3IuTdypqq/pHpuxN9ocvEpTiDkJVYVZbrJ8ykB95CJBO7F5Y=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=b1qbBNod; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="b1qbBNod"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 714341F00A3A;
	Fri, 19 Jun 2026 04:07:25 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1781842046;
	bh=SYrOiAi23vpHmBbCBuJchauJs0CaZacvuixu5G/T7Cg=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References;
	b=b1qbBNodfrbaz/ODiYdMFXclJ3fc++0s1ysh9iO4T0QBKIzeEvVq7+jU3WFp1nkOK
	 D5iFJv4yhEFnFlyFRmBOqaL0KjsYh5UD/PV+6UeVBBDBY/al6DHzXAPzSpdOOplfk5
	 FJaI9NomILmmGZ1ORZVKxjhV3Dm6PKqzRn697YBZlI80yroVhkfqxA1I/E9zp8KKkz
	 /aslkvUmyPNab+6BTShxcNlOsbsKdmEpJNVfxjSeB9f5UNpImFbfqChr4Te1UyMITF
	 tj+DLRbKvLcmjLPG9NC6M2O73e3dq0E01oq9dzKzsr+0WIXa0rrA/Of6PglWy2oCBw
	 uS1lcLIwJXRqw==
From: Sasha Levin <sashal@kernel.org>
To: stable@vger.kernel.org
Cc: Sasha Levin <sashal@kernel.org>,
	Shung-Hsi Yu <shung-hsi.yu@suse.com>,
	Ihor Solodrai <ihor.solodrai@pm.me>,
	Andrii Nakryiko <andrii@kernel.org>
Subject: Re: [PATCH stable 6.1 1/1] selftests/bpf: Check for timeout in perf_link test
Date: Fri, 19 Jun 2026 00:07:08 -0400
Message-ID: <20260618-reply-item039-perflink-61@kernel.org>
X-Mailer: git-send-email 2.53.0
In-Reply-To: <20260618074114.16091-1-shung-hsi.yu@suse.com>
References: <20260618074114.16091-1-shung-hsi.yu@suse.com>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

> [PATCH stable 6.1 1/1] selftests/bpf: Check for timeout in perf_link
> test

Thanks, but will this even build on 6.1? it depends on the get_time_ns()...

--
Thanks,
Sasha
