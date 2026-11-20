Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=100.103.45.18
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1795207185;
	b=qhsnUAjd1NOizykAyRqZseVXpPnJ0idnhjBnREJPvf9xH9DBzyj7InMXARxkt6lH3YJk
	 Z4x0Lm6zwD939ilxeuoFc0cQY5Ob9pLmRK783VtMcakiZIKzLTZa3EwNwliJGqMQJ2WTZ
	 XPZ2X8LOLSBmTdZqY4fvrEkxht0AtsEaiKSida6TVCX6wpC3PGwAz8RNa6RdGLs+2U61T
	 BAImaQlhOh0TbHutYRGu6qy9siWO3zYiVarA7iIkyzjNf5dVnL3MOkCHId0NogX++t8Ih
	 q8yt79yleNaKz6CO8bVVk/WJYfhMiIMMeBfEajEJVWD9EdRVvIw/9LSukVg3em1/GCA==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1795207185;
	h=Received:DKIM-Signature:From:To:Cc:Subject:Date:Message-ID:X-Mailer:
	 In-Reply-To:References:MIME-Version:Content-Transfer-Encoding;
	bh=jZVKvLmb550afXvpKge4vEIbjyeXxaRH3h2Jjw87qcE=;
	b=2h8hCCZTXp2g8M/V85Yo+ppCujRts9uveT9+oQQHwG1PC1pgbfN42a4sCsxKMMfA9KSl
	 lB3mg7rvmBeXccFIzwvo4JCKdmpKMPVwwPHKb6C594htTW58eqqcTwDqGNWfzmS1BtnYY
	 HgnbaG31MMo7oMz5NU6ON7KUePnLqWLjCBrP2HXLFDamUhvjnwOcb+MFV1NXZObHu0zG6
	 GY3wlvZufyMlwpY51JFhjO501qFlwHwzzYeXIGOxL3q58QCdkCbp1NDZ3u1oSPiez6Z3S
	 AfPaFOlAta5FDqI+f4Od37L1awEjmSgxdLVfhOErYu7NPqafh1aDjVkBQpKJNsT+ciA==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dkim=pass header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=jAnLlxR0;
	arc=none smtp.remote-ip=100.103.45.18
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 885A4606A6E7
	for <stable@vger.kernel.org>; Fri, 20 Nov 2026 20:39:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=jAnLlxR0
Received: by smtp.kernel.org (Postfix) with ESMTPSA id BEA761F000C6;
	Fri, 20 Nov 2026 20:39:44 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1795207185;
	bh=jZVKvLmb550afXvpKge4vEIbjyeXxaRH3h2Jjw87qcE=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References;
	b=jAnLlxR0qPzaYkoFBA+k+YG1lpnLy90rdz4+hBccpU1LN2o5EPNlweoPx7AqTE4K4
	 ffZStmMVxaZAhVMvzyG5XBlMIDdtcVdDCVFhHQayyOrDsXUJwhjwo4rjc3z/Ta7Anw
	 /6Da48nbmvsum6Af/EZo5Ers77+iWvm04Es8zFqLpvAYGitChRAQKX1PVm/JnjAknN
	 f0Ju9AiT7+RQSq4lAi1xFy9c2JzJcBOwicn1G0F5ybKRKqh8aFJR2AgskJiCpt75IJ
	 +s6bUXhaEPdEf63YG0ctuxyux5UCtf2cbgZIZ7IBk63JyaweTuxnrjVZlerTVmvN0s
	 5AHHD7Kk6SvFg==
From: Sasha Levin <sashal@kernel.org>
To: stable@vger.kernel.org
Cc: Sasha Levin <sashal@kernel.org>,
	kpsingh@kernel.org,
	Yingke Xiao <inkxiao12@gmail.com>
Subject: Re: [PATCH 6.12.y v2] bpf: Reject NULL data/sig in bpf_verify_pkcs7_signature
Date: Fri, 20 Nov 2026 15:39:03 -0500
Message-ID: <2026-11-20-1-daily-reply-0014@kernel.org>
X-Mailer: git-send-email 2.53.0
In-Reply-To: <CAMcAce_iciQJ31U-bmSpTbT61NxYPJNTq2mfcVNvAxMLXa6o2A@mail.gmail.com>
References: <CAMcAce_iciQJ31U-bmSpTbT61NxYPJNTq2mfcVNvAxMLXa6o2A@mail.gmail.com>
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Post: <mailto:stable@vger.kernel.org>
List-Help: <mailto:stable+help@vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
List-Owner: <mailto:stable+owner@vger.kernel.org>
Precedence: list
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

> [ Upstream commit 49b18315be4e590fae0fc39c87d46c87e9ec903c ]

This one doesn't apply: the patch is whitespace-damaged (tabs turned into
spaces, the hunk header wrapped), and git apply stops with "corrupt patch at
line 13".

A few other things to fix in a v3:

 - 49b18315be4e590fae0fc39c87d46c87e9ec903c is not a commit. The upstream
   commit is 49b18315be4eecfc36b75f4aecb4d40a87d68a20.
 - The Fixes: tag should be 865b0566d8f1 ("bpf: Add
   bpf_verify_pkcs7_signature() kfunc").
 - Please keep the upstream commit message and trailers, and add a
   "From: KP Singh <kpsingh@kernel.org>" line so authorship is kept.
 - The selftest hunk in kfunc_dynptr_param.c is missing; without it 6.12's
   own selftest fails.

Please send v3 with git send-email.

-- 
Thanks,
Sasha
