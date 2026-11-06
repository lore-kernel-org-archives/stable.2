Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=100.103.45.18
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1793995581;
	b=0HqLFv1Lc5rcwMLV8Ud1MebFWmgfvHyLhrNQDXrA+5xgMrEk3yNOwxIC70mBLxyJCav/
	 TQCaRNs0udIyfYcya2REVgpeFfGNHCwaJQ6JY7TGIlC/bUHeqJr0uCvdXAKiGd2VoD9Ai
	 /3hq3GuqlngkpWu5pmS/Pu2x+JkwEFj1RleCS2DQ0jHzHjFtq7goAVY4BkqWEcvgk0Ejm
	 VkeMtU62axODATr+55rDB0pJ+Icvszf9RW7QI0Jsj6xIO1NuKUmux0aU9WdphW6ZpQ2gG
	 B1+Kj+B1KTiwYHLbvzMLrUfQQqTkaUYyNTMeRcfIggaaAl6WyxiTkydvo9N/AsGMrDQ==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1793995581;
	h=Received:DKIM-Signature:From:To:Cc:Subject:Date:Message-ID:
	 In-Reply-To:References:Auto-Submitted:Content-Type:
	 Content-Transfer-Encoding:MIME-Version;
	bh=PJRu7W6/Or1we5Gv3BgoLEtby0D0Y0UGgfjBHfRc5+k=;
	b=4rjz2EaSWqMsUT+mDSXqs5bst4s0LWWwyspR6UIoesRnR53BTOn9+Kl7+WuurkHdTLHH
	 vwy/6GXHVv+8nvNk9Kyaegc+lx2ihZX6IrZGY61eNPr2omvWKWpL/4GFLYOp1IRJV5aTM
	 BU8dwR9swb9aTf38Ey4TAKIuBPJgtetQdCLPhHUNoHNUOhHOpfTU1jEvCF65x18YVAfVz
	 SrMVEvTY8kp+wNW5OKAAGKebNxJFGc7gtyzdSULMybpQKYvCci0G6IHA2F6hxuf8KoPB0
	 KW3VgvLtyC9LdYq9XKNwcwc8DhuNRpA0BYkz/QkveM3BN1wW5/Bwi6H0F8rBTyE8pBw==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dkim=pass header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=TDHt9sNW;
	arc=none smtp.remote-ip=100.103.45.18
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2A1AA606A326;
	Fri,  6 Nov 2026 20:06:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=TDHt9sNW
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 67B961F0089F;
	Fri,  6 Nov 2026 20:06:20 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1793995580;
	bh=PJRu7W6/Or1we5Gv3BgoLEtby0D0Y0UGgfjBHfRc5+k=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References;
	b=TDHt9sNW56hOoiwbQzNnuQqwPUTTgPjm3NZTIHGGtP5T9jMTAqfvZxyzbmFYvTMLX
	 NVPeRMIQtHqxvebUPvQfj+w51e+h80u1pu0ZqGCTl7guaj9otAKcWLzVJ4OreMGlJR
	 DOxtuuSTXt+pDZABo2vTkf0Q3MM++THfpiXJP/K3QORu71b/hctRmpwo8vPQEOrYo6
	 /Wrh7ECt+bxmpv1eYTrkEBXGbz2B+mJ5Hsdp3ZZHbuW0AaQh0vJI3wmIhGAjyzT7ep
	 hL5XnzWXzHowJbNVSGAuI/TatxoBVN+oa9NFpOTLzrpG7rnpbyr6ya3XLXL5xi3T3I
	 DhaiuKPn0Kq7g==
From: netdev-bot+sinfo@kernel.org
To: =?utf-8?q?J=C3=A9r=C3=A9my?= Jean <Jeremy.Jean@oss.cyber.gouv.fr>
Cc: Jamal Hadi Salim <jhs@mojatatu.com>, Jiri Pirko <jiri@resnulli.us>,
 netdev@vger.kernel.org, linux-kernel@vger.kernel.org, stable@vger.kernel.org
Subject: Re: [PATCH] net/sched: sch_qfq: revalidate aggregate after peek
Date: Fri, 06 Nov 2026 20:06:19 +0000
Message-ID: <179399557993.488859.3919888703294949668@kernel.org>
In-Reply-To: <20261106200236.716641-2-Jeremy.Jean@oss.cyber.gouv.fr>
References: <20261106200236.716641-2-Jeremy.Jean@oss.cyber.gouv.fr>
Auto-Submitted: auto-generated
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Post: <mailto:stable@vger.kernel.org>
List-Help: <mailto:stable+help@vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
List-Owner: <mailto:stable+owner@vger.kernel.org>
Precedence: list
MIME-Version: 1.0

Hi!

This is an automated message. This series looks like a fix, but its
commit messages seem to be missing some information:

 - How the issue was discovered, e.g. hit in production, hit during
   development, syzbot report, manual code inspection, LLM or static
   analysis tool scan.

Please do not repost the series just to address the above. Instead,
reply to this email with the missing information, so that reviewers
can take it into account. If the series needs another revision for
other reasons, please include the information in the commit messages
then.

The evaluation is done by an LLM so it may be wrong, if you think
that is the case please reply and explain.
