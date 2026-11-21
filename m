Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=100.103.45.18
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1795274882;
	b=xLJYs9cB9S6Ty4xQNn6kxE5/ytPr1u0/ktsq/OiLR2+Wnf9bUBAC098JlpLKhdTyD1gu
	 b8ljTNMDQlRKC4DpyjyjGzOU9dwV8dWMTDNdfvkNJnuEp1nUrnvPARzhT5R9ZqmiEwZ+C
	 uwYwC3bGzoIebi1mJ3Jk50HKTzb1tsWdUCs9phgmGqdskbJf32LyQywNzyjXbfJ2dBmnx
	 mr033ZfjF+3EQye2S4r8EuL0nldgdEC3y/zCXxNuAfc85CeBfg24elThVwKpjkdwAHxBy
	 0Q/Z0c0+tzxOx8jLD08cdEulD2o5e5Ue2r1OZ4WPEVkVaajt/zAdTlNLymBCW8CHq7w==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1795274882;
	h=Received:DKIM-Signature:From:To:Cc:Subject:Date:Message-ID:X-Mailer:
	 In-Reply-To:References:MIME-Version:Content-Transfer-Encoding;
	bh=RK2e9+WRGJMVcQkIV4bZRjpl2JYmJQKz1RqlgXUJqR8=;
	b=bPUfscy6S3bW4eX17YJbZBth6nzsKomLC/HMKr41FaxZ4aTTeArUdr+E+dBvWFr5Jj+b
	 TM3Sw+6tkzV0KRZxaDXFvZGNk02Tg/uqm9jU8Tx5oxGmWtiCzzQDTlCNBDNHQMe00uJ6o
	 eOAFw31e3KRvIptLYS9ixdUIKcpfyXT2scCCHFJh7OBDd+SglnYQQ88qwfxrI+RJEDcYV
	 rE3ktfS58XbeEoaMJzKekw/DjIDerolpKYf2JBuU63Eap+zrCm+km67xyRV4T+3kAmnmG
	 HIKqhk4N5LkCYlPWRDFH1VMezeKHcsd8PKZ7fu+AwkNty0/jzT2OsZJJ5sDiBh6wz2w==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dkim=pass header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=mUZN4xsG;
	arc=none smtp.remote-ip=100.103.45.18
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7EF80606A320
	for <stable@vger.kernel.org>; Sat, 21 Nov 2026 15:28:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=mUZN4xsG
Received: by smtp.kernel.org (Postfix) with ESMTPSA id B99491F000C0;
	Sat, 21 Nov 2026 15:28:01 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1795274882;
	bh=RK2e9+WRGJMVcQkIV4bZRjpl2JYmJQKz1RqlgXUJqR8=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References;
	b=mUZN4xsGrgjHqzYpBupcPJZMecRLOLsdLnZ/EpCgkUKb6fOQZB/ERD0XNsuxJD+Qd
	 yGB+7kap7BzqIYopwmiQxqvKuZc7DbP1VgjPgt+pwpjTv5NuTMSnMcKYieoeaF4lQt
	 YOWsMUH3aAEo+SeRAM0aXuQDJMsCyuqbTWcA24ZATyxIAjW4kpk4B1U9NPgC3Dt/Yz
	 WoNtngc4erwu9Mj4bspxAMlEh6AIZtnosyEG3rmTp3TCvv4pLOjQ8nRqo8M0ZUyyQr
	 bmTH7qelj+isbRGKKQRfBZ4Hplc8BYWJX731kqXcmIQLOmuQU7mU7u9fqxozoNraEc
	 DXKxnWBsTOruQ==
From: Sasha Levin <sashal@kernel.org>
To: stable@vger.kernel.org
Cc: Sasha Levin <sashal@kernel.org>,
	Feng Ning <feng@innora.ai>
Subject: Re: [PATCH 6.18.y] staging: media: atomisp: use array3_size() for overflow-safe allocation
Date: Sat, 21 Nov 2026 10:27:42 -0500
Message-ID: <2026-11-21-1-daily-reply-0014@kernel.org>
X-Mailer: git-send-email 2.53.0
In-Reply-To: <e4e67ea4f7d14636a8bab81909764adc@innora.ai>
References: <e4e67ea4f7d14636a8bab81909764adc@innora.ai>
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

> The atomisp driver computes DVS, morphing table, shading table and
> statistics buffer sizes using unchecked arithmetic.  When the table
> dimensions are large, the product can silently wrap, causing kvmalloc()
> to allocate an undersized buffer.

The code is fine on all six trees, but please keep the upstream changelog of
d178c7ca8fef ("staging: media: atomisp: use array3_size() for overflow-safe
allocation") unchanged. Upstream says "When dimensions are attacker-controlled
or simply large".

> Backport note: these three files do not include <linux/overflow.h> in
> this tree yet, so the include is added here.  No other changes were
> made.

Huh? did you bother to double check your LLM?

Could you resend all six (6.18, 6.12, 6.6, 6.1, 5.15 and 5.10) with those
two changes?

-- 
Thanks,
Sasha
