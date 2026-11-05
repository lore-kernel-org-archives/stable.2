Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=100.103.45.18
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1793903973;
	b=wTVW2FDOMKK36Gt7BfbIJw5ZjzhvIHGixS5vdt0BoKkjf/6T56FebCM8z3//KVA1q2PZ
	 oj0gAAy6N5dzNJJWMC+M5IANTvjryMQ3vhNMCEL6O/8hGsX5JsvZGr/zoTt5jzTRtIYMw
	 b0hBG2fp7HtbpV7qO5tnGQ/+1SXzOKEyacXfXvrl9X0UHHm3XL2AZWOSzlfmcYJuqQtOw
	 CIM2epPFvlb7JE6fPvk8eAz0KjegJSulVC1djJahtPEv8aIvnuHRqbX2et8qXxg5n8kTx
	 qdOt6ofEwucK7Zu6dnMKRkSekty+lnBl3MfLPdEuPhzA+H14r20LmFbdxwpJ47u6aeA==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1793903973;
	h=Received:DKIM-Signature:From:To:Cc:Subject:Date:Message-ID:X-Mailer:
	 In-Reply-To:References:MIME-Version:Content-Transfer-Encoding;
	bh=yZp0d94T9bPfx4eAPUckZTFJ9UR5AeCdX7IgpGQtpq4=;
	b=l9VSeUI2XbsMprV06/p06q3u1sIp34bThS6KinFm8AqcJDqEUrGqqvftL3beRCEDOluN
	 R4ldPrA59z7enmES66mhic2YYvmOtfMd/A6eIcBfKJPoP9Q40zDzN6Y4Pt+d1MxNPKIvj
	 WsuUYvSV7Bq5+Dn/G2S2A9VLq27RUd4LgThQ+TuPGKz7DsOUxh2/tU6e+6wAHr54dWYos
	 5p1+Gfn6gAU16SauM5F3KePz+wiJvXPmsg9X0/bkipHNQ/Ud8Lt+QP2yPZH31JNFK8aLZ
	 P3AQLm6x1I5oGUW68t+fIdmDydgZhMbBFVd2f4KE522fn/uD6BIE1rlgLFuv2bQM20w==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dkim=pass header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=HgJx9ICm;
	arc=none smtp.remote-ip=100.103.45.18
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 588A4606A334
	for <stable@vger.kernel.org>; Thu,  5 Nov 2026 18:39:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=HgJx9ICm
Received: by smtp.kernel.org (Postfix) with ESMTPSA id DE0241F00919;
	Thu,  5 Nov 2026 18:39:31 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1793903973;
	bh=yZp0d94T9bPfx4eAPUckZTFJ9UR5AeCdX7IgpGQtpq4=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References;
	b=HgJx9ICmappF/L2PYdIE+uSw6YhVEGNvmYYx6GuWvPPprAxt5X9tn2oE5WsLeNIrx
	 vBBkt7b16OSGlxFlO7k89i123kGYOnVAua2mdYGLuojPXbhqyaRhNOe2XTHQ5Fq9fK
	 jUkhQ7gX7tuAlTJ1piURzBFzJesC8Iy722W8HjoKmb81zT8wFAmOkdE41uM95u+xZ+
	 G4oyRHDSuv21yxy7zgOIKnUwuLgf2IJVB8/EuMpi/xMGbZL0L0U7hlzs21Xwi0QjAu
	 p89v5OF9BMeCNiRHiJI61Zc0u7kgLApGdHcEdbDGlCTTOdTEK8CQSnCkh1lDSFiy7q
	 jtmJ4udw9uSjg==
From: Sasha Levin <sashal@kernel.org>
To: stable@vger.kernel.org
Cc: Sasha Levin <sashal@kernel.org>,
	linux-mm@kvack.org,
	david@kernel.org,
	yangge <yangge1116@126.com>,
	Baolin Wang <baolin.wang@linux.alibaba.com>,
	Barry Song <21cnbao@gmail.com>,
	David Hildenbrand <david@redhat.com>,
	SeongJae Park <sj@kernel.org>,
	Andrew Morton <akpm@linux-foundation.org>,
	Mark Bundschuh <mkbund@amazon.com>
Subject: Re: [PATCH 5.10] mm: replace free hugepage folios after migration
Date: Thu,  5 Nov 2026 13:39:15 -0500
Message-ID: <2026-11-05-1-daily-reply-0010-mm-hugepage-folios@kernel.org>
X-Mailer: git-send-email 2.53.0
In-Reply-To: <20261105070150.3093908-1-mkbund@amazon.com>
References: None<20261105070150.3093908-1-mkbund@amazon.com>
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

> [ Upstream commit 04f13d241b8b146b23038bffd907cb8278391d07 ]

These carry only the is_migrate_isolate_page() hunk of 04f13d241b8b ("mm:
replace free hugepage folios after migration"), which has no Cc: stable or
Fixes: tag upstream.

I need an ack from an mm maintainer (David or Andrew) on the reduced backport
before queueing it for 5.10, 5.15, 6.1, 6.6 and 6.12.

-- 
Thanks,
Sasha
