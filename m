Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 087CF345EA4
	for <stable@vger.kernel.org>; Sat,  3 Oct 2026 22:33:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1791066808; cv=none; b=umKkb46JsfU9tZtZkLUO9lj0MV7ZXEHWdwbHni2Ax5GZ09o/tisu7pncB8cK5fwWhgPDQsrjwrGG0ofDlrgk87zYTEH8tJOPrd5MxP9VlPXdffF8zzZazsZP8qfjskkW6WRHkq8zGlmJHXNXyjYcEpVPPjlR4Jjkqf2UGF7zMYo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1791066808; c=relaxed/simple;
	bh=5xsa733mMyCInfdhpVpzppf2uqGOWsoRkXglvqDkE3s=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=Qc+urqJlwE3VLTD8kufFGCPaDOFnQGMG5g422+QjPMOqj251Uu9iHKo1XsMD1Nq24WAodwOmKou2IyUahPmjcTl0sq2XuUNRyMWpEmyTjy5CCllgUpABegDKDkIqjFOOajvgcBfFpLLGMM8hqojl3Ay1GimmFI4CpiG08zW2KbY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=eRSzh4CA; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="eRSzh4CA"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 245581F0089B;
	Sat,  3 Oct 2026 22:33:19 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1791066806;
	bh=Tu9JE29rHKbGgDxIIcZ2rQ7Q2gseS8QFk42t7OdBv+c=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References;
	b=eRSzh4CAAQGwY5CZ2c72tCZCl7xjWB6WGU+93xuNEGJLxRRpBRTnREe86lvM1lsjh
	 A1/+Ch6X6/+dD58slYSbpiCeMUWE8u8vPgEsviuiosu0lvLdbYffqGLwoaFfWUg1RZ
	 TIDEfGchGkIiJedIjkyOiPEXvPF1fmsF6rqz/9WI8fhn1Qal5sYR+v8RMOhT8CIYeo
	 d5QvZxL5PwObLmTYvDb8rwLsODM3YKOpM6n6xrDIHXT7liUQpqWZ6sF+WIm0lWf9QC
	 KGdp+ButjCvn/V3Z5wvSO+bBOVBewwT0pIMhW5wCBFzQf/hCarY5tFdPvDVk0nvX36
	 +RLbhbIxxQxAw==
From: Sasha Levin <sashal@kernel.org>
To: stable@vger.kernel.org
Cc: Sasha Levin <sashal@kernel.org>,
	Jiangshan Yi <yijiangshan@kylinos.cn>,
	Namjae Jeon <linkinjeon@kernel.org>,
	Paulo Alcantara <pc@manguebit.org>,
	Bjoern Doebel <doebel@amazon.de>
Subject: Re: [PATCH 6.12] smb: client: clear setuid/setgid bit on write with cifsacl/modefromsid/posix extensions
Date: Sat,  3 Oct 2026 18:32:44 -0400
Message-ID: <2026-10-03-1-daily-reply-0001-re-smb-kill-suid-cifsacl-6-12@kernel.org>
X-Mailer: git-send-email 2.53.0
In-Reply-To: <20261002145545.3927732-1-doebel@amazon.de>
References: <20261002145545.3927732-1-doebel@amazon.de>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

> commit b8e5dc4f95e5484159b343903f302eb6d783f2e6 upstream.

Queued for 6.12, thanks.

-- 
Thanks,
Sasha
