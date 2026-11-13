Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=100.103.45.18
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1794597016;
	b=jE+M4NzSxIryPYJ8bhkqNxX6TJ04uBgQ59Tdt+xvw+CI8g1/75I8/vwrMOi3XCTtVUZg
	 yFOTtszWjaHl3cJbhlarLr05fJjfTzBDs0OiMp9tIC/q9oyAvfLYTZ1xgOJyU3gl4h3Qb
	 g0T/gMI3XQVRMItJogvC2WdATwtD7XsTHPjNTFU2c6yV6AHWytpu13x1MfVEcLYygvKbK
	 CnEeDi+r0mt7VK7WteAr+mariDzotgK2vhx5DxfgYO7ckNvRtTOe7U9Tl8LHnNa91/Knb
	 t0DKqMuGI69gZUlPksfD8q/NbpgQzoC84YRRShZd4QrBH2n3TsigofzW0aqDDI5GRgA==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1794597016;
	h=Received:DKIM-Signature:From:To:Cc:Subject:Date:Message-ID:X-Mailer:
	 In-Reply-To:References:MIME-Version:Content-Transfer-Encoding;
	bh=zabQJqh6t7uxEuYlIQWDR7cku3smA7px6dIU8SpBgYA=;
	b=WU3XBKf1C/vzCSLN97wIVDImG7EiHJ8b62XPffjHb5yjLUaXP7+jPsMud60cT9wfedUH
	 mS8ANwf549gSrOLAlirf9AFhWKL15RmZRxNXZb4r4hJ4J3vGlBXLmgl2ImJKlzP+2AB35
	 N5OsmvO2wpbB/6ZajaizOmTyqZkpGaMMdhpreI43Z/C59P6p04H8AB+yAuzF5OAOkpLCq
	 3VA5lufJBUXgBAARbSm+24z5mveW5PY3GdsxB1RRnng7XXUxyXEQoiz3hYGo7gK48ghO5
	 bu8nec38DW65bv/cHg0a46urGrX+4EY2U4QA7P+BUE09kcmxUJEdPdx7y+n7bZv95iA==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dkim=pass header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=dwYLa8jG;
	arc=none smtp.remote-ip=100.103.45.18
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 38F9D60A261A
	for <stable@vger.kernel.org>; Fri, 13 Nov 2026 19:10:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=dwYLa8jG
Received: by smtp.kernel.org (Postfix) with ESMTPSA id ECA541F000CD;
	Fri, 13 Nov 2026 19:10:14 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1794597015;
	bh=zabQJqh6t7uxEuYlIQWDR7cku3smA7px6dIU8SpBgYA=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References;
	b=dwYLa8jGfbANwBDnffek3WSTjnOxSqseDsz0gJCmasHCMIgVTL/kaniXXnkVFiZwk
	 I+Tb++mjKgi0LH7Labd1QZpZBG5bEqMXb/hhRv7RollZgOmb6AjC6QJlKRo5m7zVgJ
	 ETjDC/haem1aRUCYjVfss232EiQEzpmvpohUV3n3k3IdBWKNqQG+2cfngBWCajQPHE
	 eR9MfVh66zuhPL5Y+C81zb7RKMvbvEwMWE/Dq1DpnI81n+g6D5na7oaBaMNs2c1aMN
	 /r5ZxB/y2n1ptwScnzw/xsTG6zLpXzM9rnF4rf2WC0X8xcV4pr9E5p4OZv0G7SImXX
	 rwIPtkNHOvrmA==
From: Sasha Levin <sashal@kernel.org>
To: stable@vger.kernel.org
Cc: Sasha Levin <sashal@kernel.org>,
	dipietro.salvatore@gmail.com,
	Andrew Morton <akpm@linux-foundation.org>,
	Vlastimil Babka <vbabka@kernel.org>,
	Johannes Weiner <hannes@cmpxchg.org>,
	linux-mm@kvack.org,
	Salvatore Dipietro <dipiets@amazon.it>
Subject: Re: [PATCH 6.6.y 0/3] mm/page_alloc: fix iomap buffered write regression from 5d8edfb900d5
Date: Fri, 13 Nov 2026 14:09:59 -0500
Message-ID: <draft-0009-redipietropagealloc6@kernel.org>
X-Mailer: git-send-email 2.53.0
In-Reply-To: <20261113110724.2920455-1-dipiets@amazon.it>
References: <20261113110724.2920455-1-dipiets@amazon.it>
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

On Fri, Nov 13, 2026, Salvatore Dipietro wrote:
> Patches 1-2 are its prerequisites from the same mainline merge (Cc:
> stable), only moved from mm/page_alloc.h to mm/internal.h. Patch 3 is
> adjusted for this tree, see its changelog.

Patches 1/3 (6ee3d87b9408 ("mm: page_alloc: do not give all non-blocking
requests reserve access")) and 2/3 (fe21f930d1e6 ("mm: page_alloc: remove
ALLOC_NON_BLOCK from ALLOC_RESERVES")) only carry Johannes' and Andrew's
Signed-off-by. Since you are the one sending them, they need your Signed-off-by
as well; only 3/3 has it.

Could you resend the series with your Signed-off-by added to patches 1/3 and
2/3?

-- 
Thanks,
Sasha
