Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=100.103.45.18
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1795392110;
	b=hvZf7YMspu2963Z1wpOO1+vrTvB+ehTvOcKl+F/TUmfem4bOmiIeI8ywBwd/+l9BP1LH
	 L+p3VGSJzFwsNnFqP1HR2U+oQqOkPBq0RPFN58R8NaJ5EvqBMHsh/WpRZN7znqQA3IaDS
	 p3UgaejVpf6NLG22dTnFNsRq5jD6QLbXDfGpMoxvQiTd6gPU3u76JUEGIdgaMQ/Fr7p7c
	 1XuGLJFPuP581gCXTo/98/W4/z5KCCihLrSb5fQlrqkos+z+F/2pFWJUlTqG+yZkLrkGo
	 ei5ry11Sc4N/b6xrSlpnULZFYPDhtMCdUkNhAojcYFw+3R17BOhB8ib4lmZlH1s4pFw==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1795392110;
	h=Received:DKIM-Signature:From:To:Cc:Subject:Date:Message-ID:X-Mailer:
	 In-Reply-To:References:MIME-Version:Content-Transfer-Encoding;
	bh=/RWrU38gXUbEfMF9OTe2TxNpR3JhGadiWn2X6uNIggk=;
	b=Z1OHXafgzPdiKK987l1Cfpytc+bUqsCN3UR/82pTqmvndOsU4CRNsSIqlb08fKbcLwJd
	 4JgNoeG8RhyyB4dOFvYH6SGzHgaKK6HVzw15+tgG3J55U2ahLtD7rVpwdzcyFp36Pgr/W
	 e6eAhQ7KzFra1xRBoNFek7dPSpdzGXNCS+45nqb25B1Vu98H3PfCcQCVDDHhqWkOuWBOu
	 URPCDFFHrBPgxs6tD5PRe0WCehZBz0Gzmn/R0hCcdX3P1ky5gzzIPwKu261ySI5BpEv8I
	 XYFhGOY/ssjNkjGAdPrl9I2S1IzuRsrsqB53uDL13yW1RdSN5QMpWizettIs8AJjP9g==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dkim=pass header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=KIPHI3MT;
	arc=none smtp.remote-ip=100.103.45.18
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C8A55606A31A;
	Mon, 23 Nov 2026 00:01:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=KIPHI3MT
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 12D211F000D3;
	Mon, 23 Nov 2026 00:01:50 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1795392110;
	bh=/RWrU38gXUbEfMF9OTe2TxNpR3JhGadiWn2X6uNIggk=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References;
	b=KIPHI3MTKVVUFFy/Vr1VTGC9+hivxKCXKVDk/fyU/9wrQHUitb4QpscpXqhJ5L8tE
	 dvDiuV089DTx5o1X6eidWBL76n78U6toeFz3WJK0mGoDlXFkRgFHSdaMO/PiHOY/jz
	 Lw/UASQTTMTVP6jTFvvEL3aCiRSKnosuN1Crryu5p10Nb4Y/3nvIQ28zx3jISwmVIa
	 pBRDb3Cmois9pxwkf68RM/6q/XvaxQTzluuvEtb/5AzeRtwZmxTPCICeB/DBH+LSU7
	 RhcvdMdmoFA4sTUXYMTK8ph1v8/wg+MVxiiGryMgnkXYygS0Z44BSTZAtOrC0Vpde0
	 Tr51OESksZZEQ==
From: SJ Park <sj@kernel.org>
To: Yifan Feng <evanfengff@gmail.com>
Cc: SJ Park <sj@kernel.org>,
	Andrew Morton <akpm@linux-foundation.org>,
	damon@lists.linux.dev,
	linux-mm@kvack.org,
	linux-kernel@vger.kernel.org,
	stable@vger.kernel.org
Subject: Re: [PATCH] mm/damon/core: do not overwrite wmarks.activated in damos_commit()
Date: Sun, 22 Nov 2026 16:01:41 -0800
Message-ID: <20261123000143.86987-1-sj@kernel.org>
X-Mailer: git-send-email 2.47.3
In-Reply-To: <20261122002930.98401-1-evanfengff@gmail.com>
References: 
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

On Sat, 21 Nov 2026 16:29:30 -0800 Yifan Feng <evanfengff@gmail.com> wrote:

> damos_commit() copies the whole wmarks struct from the source scheme,
> including the private 'activated' field.  The source scheme is a new
> one, so the field is always true there.
> 
> As a result, a commit turns on a scheme that the watermarks turned off.
> If the metric is between mid and high at that time, the scheme keeps
> running, though it should stay off until the metric goes below mid.
> DAMON_RECLAIM and DAMON_LRU_SORT use the same path for commit_inputs.
> 
> Save 'activated' before the copy and restore it after.  Do not restore
> it for DAMOS_WMARK_NONE, because nothing sets it again in that case and
> the scheme would stay off.
> 
> Fixes: 9cb3d0b9dfce ("mm/damon/core: implement DAMON context commit function")
> Cc: <stable@vger.kernel.org> # 6.11.x
> Signed-off-by: Yifan Feng <evanfengff@gmail.com>

Reviewed-by: SJ Park <sj@kernel.org>

This patch is applied to damon/next [1] tree.  I will repost it soon (~1 week)
as an mm.git merge request.  So, no action from your side is needed for now.

[1] https://origin.kernel.org/doc/html/latest/mm/damon/maintainer-profile.html#scm-trees


Thanks,
SJ

[...]
