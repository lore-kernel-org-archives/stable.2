Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=100.103.45.18
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1794884953;
	b=aOG+DgCn0gIniDxsKWZ5MBktZdKuamGWQWqVXeTEwgUGVDtck2259giJ+SWKTzGC9Eyt
	 7ah7KNMQ1DR0xre1C4GwNksGl3fJyJFmbK0dLsCXsq4sbt9t5b4TLTTsoUxE5EEIDMmrK
	 Zo60t+HK3YtkKt4WrdY5hLs2Y0IynAp0eTo3ciPltXcSmY+VmXVMRsS9nOpaeHxG9HPPm
	 W8u/oonH7iqrgG4WWngMYsZgoHr1jvMlh2OV32WZ8aviwspVuFcT4QGlRDPf0k+LdTTmi
	 J1S6SqUXPwEI0wvdlcHTt6csG5zG2x8jqmoTdhquPwr71HlxyVjrb4ReOA27lbOYT7Q==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1794884953;
	h=Received:DKIM-Signature:From:To:Cc:Subject:Date:Message-ID:X-Mailer:
	 In-Reply-To:References:MIME-Version:Content-Transfer-Encoding;
	bh=bsKdpnnbNLZITb4IXi8YQJrmOxF/yvbqsGdvFsxy/Ks=;
	b=vci0opveAxD5i9rtXJEuCj1+81WrgPYRxFCNTE9/A6pdc2gj+dcMX2iFTgQCiETwRWuC
	 TX+QvpuFy21J6aH8qvwi45OopPmI9vbwHd1F098Hbho6LQT3yfOwkkAJJFO1d8bdTndd0
	 UdKxC1WX9Cltwpu9vRxxbLQJZ5Y3g9yuoUfErqvURY8CJoSWObxEaYIq/rEdherTtVJLg
	 3VBDcfR6w/DfdWk2yKtvMe/7Q4cBiqV0kx4uM8bajuZoamR70QKePaWx4BTESc0+wuakL
	 Bw1zK8FOXNEivzKkTVyOVVCQLGVkcUgwBdwGRGONiGUn/pITF08SeVOBxb3YV5+FhZQ==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dkim=pass header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=MevL1yT7;
	arc=none smtp.remote-ip=100.103.45.18
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DA4DC606A31C;
	Tue, 17 Nov 2026 03:09:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=MevL1yT7
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 2AEFA1F000C4;
	Tue, 17 Nov 2026 03:09:13 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1794884953;
	bh=bsKdpnnbNLZITb4IXi8YQJrmOxF/yvbqsGdvFsxy/Ks=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References;
	b=MevL1yT72wWCYGI4QPeV4DwsylX64DMvU6yG3IpfCnar6ZOm8i080Ib16BKsIaems
	 pF24awB8cOeXE/dCc/LJzuDF1rjhPAMuP1ZBe0PJUVnBUyhxKIv8+D8TJ7ug0t3RUt
	 tJH0+Rsn7Z/ftsUNmGv8j37QoVd1764IJa8sHFVlXVKrNdvgQjnxZmnm7Z8UuzMCOZ
	 g41WU7ZU13R3jPgLZYIY6viiSjF/Y4epbov2E8uISiT7Ko6VTiFaecHv/gEwQKUA/W
	 Kt+fMTAHCTxKyJYVRs1w94IaPqPfnYo6KghUvqT0GSlIb+gst0KpTiatyLgPYORg1g
	 5XmYEv+hid13Q==
From: SJ Park <sj@kernel.org>
To: SJ Park <sj@kernel.org>
Cc: stable@vger.kernel.org,
	Andrew Morton <akpm@linux-foundation.org>,
	damon@lists.linux.dev,
	linux-kernel@vger.kernel.org,
	linux-mm@kvack.org,
	Mark Polyakov <mark@thundercompute.com>
Subject: Re: [PATCH 6.12.y] mm/damon/reclaim: use parameter context correctly
Date: Mon, 16 Nov 2026 19:09:05 -0800
Message-ID: <20261117030906.117403-1-sj@kernel.org>
X-Mailer: git-send-email 2.47.3
In-Reply-To: <20261117025144.117100-1-sj@kernel.org>
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

On Mon, 16 Nov 2026 18:51:42 -0800 SJ Park <sj@kernel.org> wrote:

> From: SeongJae Park <sj@kernel.org>
> 
> damon_reclaim_apply_parameters() allocates a new DAMON context, stages
> user-specified DAMON parameters on it, and commits to running DAMON
> context at once, using damon_commit_ctx().  The code is mistakenly
> over-writing the monitoring attributes and the reclaim scheme on the
> running context.  It is not causing a real problem for monitoring
> attributes, but the scheme overwriting can remove scheme's internal status
> such as charged quota.  Fix the wrong use of the parameter context.
> 
> Link: https://lkml.kernel.org/r/20250706193207.39810-7-sj@kernel.org
> Fixes: 11ddcfc257a3 ("mm/damon/reclaim: use damon_commit_ctx()")
> Signed-off-by: SeongJae Park <sj@kernel.org>
> Signed-off-by: Andrew Morton <akpm@linux-foundation.org>
> (cherry picked from commit fed48693bdfeca666f7536ba88a05e9a4e5523b6)
> Signed-off-by: SJ Park <sj@kernel.org>
> ---
> Mark Polyakov found [1] this patch is missed in 6.12.y and causing an
> issue.

By the way, it was not picked for 6.12.y because I underestimated the bug and
therefore didn't Cc: stable@.  Sorry about that, Mark and stable@ maintainers.
Also appreciate again for the issue report, Mark!

> 
> [1] https://lore.kernel.org/CAA5JH2yO-gw1gn_172hv0YWFfQpkXz915a=uoVH+e49P_D8-+Q@mail.gmail.com


Thanks,
SJ

[...]
