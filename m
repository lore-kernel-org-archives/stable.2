Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=100.103.45.18
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1795207187;
	b=aIGCxS5+7PRvAwAGRVJgABfNhgmksPeQBvLANCYk3IuWaKb7IpeCSFAYlH7BBQ19TtV3
	 FRe3yuKxxCQEC94QWLncqOQ/NRLVtTTxK7jEl8kXfSmEIwiuANiERv8GDJZgSAQz49HiG
	 nQTwp7MciXSo55HlRBqihozHb8OihczL/j3bGcUACi8fMCIZv+9ddZa40BxHqLhZIU6Vk
	 1MHZDZkx+j7EHvZrCBQC1S2Oflz4gO7QNPZ7uGXr9marMweKrN9Sq0vjLXJxU8fvqK2k9
	 n9cYhY1akpsnE4Yal+PjGUQ1ytd5Icw4I6Wl96b3uVoaeODXat0wGcvI5GJNdc6Ujig==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1795207187;
	h=Received:DKIM-Signature:From:To:Cc:Subject:Date:Message-ID:X-Mailer:
	 In-Reply-To:References:MIME-Version:Content-Transfer-Encoding;
	bh=h3zs5hgs44WM0UBZAL57hHU1qVZrIOi2lXkg7M8Oprg=;
	b=jixg7yYvWt382cq6bOGmoTIyxizTUmTLmImqCkiVLvxK0ONDGNBglJzezVPNN4A5VXiK
	 MO7Uu1wX9cnhRLqFCLY5t9nX3jO8RoL044SHyHnlkRkMlWkiR2DsgmHv8qrDPXaBH//xf
	 gEgO3pOREBPQNCLU0yvbSf5Zxl7daVNcuC1Wy5GdReNDOMdKXJa+PGp431zzmdJ+MzQN4
	 clUqWyf4CeI7DcDaJBqJr9MIM2uncbD0ZgIoYolDZ4hY6Hq1lPl5C7o2OU92hWHejTptV
	 eLgipPS7cVEp/CK5f0Mxk7DH8qNPauKNEc6xclHGseTK8a9Ypk/jVn44UmuyiSHZcBw==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dkim=pass header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=etuctfcS;
	arc=none smtp.remote-ip=100.103.45.18
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 58933606A33D;
	Fri, 20 Nov 2026 20:39:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=etuctfcS
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 2E0361F000CF;
	Fri, 20 Nov 2026 20:39:46 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1795207186;
	bh=h3zs5hgs44WM0UBZAL57hHU1qVZrIOi2lXkg7M8Oprg=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References;
	b=etuctfcSocmPen/gWdHcxqU+yP9MpOo6hHvKdj0ILIVp6NYdwK51drvRDgDzXspuT
	 rpcSbHTo/jFujvaD1u5cOkjfAuZBJNX4G2Dg07m/h1dKNWFG7cqzqiyqG+gUGxnvrj
	 D6RHswWn3IH6XVmPIv8MdAD3G5K796SiSm5+s/3nK+gmLTzYwChIiqXFYqkiY8jfR5
	 izwmGWUMLTZssIjJRrOLd9E445F9SRlfqKL0B8Tg0hOYQsCN4cPt4YaXBhZJr9jP4E
	 tZ8crhmge4MlqxZRVIsoebAd89fia7buS3BhPDalkiOIr4eMw9cQIU/A8pr/xm28Ld
	 P1FKQRD68VO5g==
From: Sasha Levin <sashal@kernel.org>
To: stable@vger.kernel.org
Cc: Sasha Levin <sashal@kernel.org>,
	bpf@vger.kernel.org,
	memxor@gmail.com,
	Yingke Xiao <inkxiao12@gmail.com>
Subject: Re: [PATCH 6.12.y] bpf: Add tracepoints with null-able arguments (CVE-2024-56702)
Date: Fri, 20 Nov 2026 15:39:04 -0500
Message-ID: <2026-11-20-1-daily-reply-0015@kernel.org>
X-Mailer: git-send-email 2.53.0
In-Reply-To: <CAMcAce-4MeO8rpx2rvDu77r-OpbFd9k0geOs8wZBoaMbYVkpDw@mail.gmail.com>
References: <CAMcAce-4MeO8rpx2rvDu77r-OpbFd9k0geOs8wZBoaMbYVkpDw@mail.gmail.com>
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

> [ Upstream commit c83e2d970bae ("bpf: Add tracepoints with null-able
> arguments") ]

I can't take this one:

 - The patch is whitespace-damaged and does not apply.
 - It adds 5 of the entries c83e2d970bae ("bpf: Add tracepoints with
   null-able arguments") adds, with no reason given for leaving the rest out.
 - It lacks the "From: Jiri Olsa" line and the upstream sign-offs, and
   carries a Signed-off-by from Kumar that is not on the upstream commit.
 - CVE-2024-56702 is cb4158ce8ec8 ("bpf: Mark raw_tp arguments with
   PTR_MAYBE_NULL"), not this commit.

Please send a backport of the full upstream commit with git send-email.

-- 
Thanks,
Sasha
