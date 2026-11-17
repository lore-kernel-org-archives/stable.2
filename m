Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=100.103.45.18
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1794954594;
	b=zlbb+r2/ceSZ3c0I41LK1m6HgzkuX8p/KHCTjjP0CRHZupeXAad9Wq14W9TzMMzgowJ4
	 sql9lLSzBnzMQrKefOOurZHahKSHU5uKbe5cegiKiUa/rNu7+WkSxnSoo1avA82zLNaR+
	 i32Bv9v4QZ6uZGvYG2Ini0NxMy/MRijwGstvqsK+VMzrkNoCfd7xSGR453zCy6kk7CSkk
	 10jekGmIqTcAEjTdMSvolIEarwgEiwGdrYCB1H31qWef2nWJnYdMApsoXov01W9Tenzdi
	 oVtcgxOVSzcTFHlEgNzfIk3FB5e9LzVCedhOSWuSUfGymcS9gT6OeFyRswTmiUwTF9A==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1794954594;
	h=Received:DKIM-Signature:Subject:From:To:Cc:Date:Message-ID:
	 In-Reply-To:References:X-sashiko-severity:Content-Type:
	 Content-Transfer-Encoding:MIME-Version;
	bh=D//WxIqwyY8ji52F0H+lPRoMbtoFsCNAj+cgnUwhths=;
	b=sYXwb/MH4+R0xjqp1L6FsXs8f1sJ1ajqyPEG3NP13Zj9sApJJRIGeZkJatLLUroGah5D
	 MZ6tqWAjkfM9lKloctYu/tEZffhOaxmom/6GFDfiavK3Cqu3/GHCic6UKPYW4JsHJkD1c
	 19WFzQqz6dkl1GkwcZcoIKpeCJURgbC6kb2pzLwB7BLQOntg2nVNrO1xr5pykSiqZWUFM
	 +rvfjadHSJi983l4xGlBoDm4tbEaHxmkCuF4p/zL+6VqQTBZ4nntx0Ys9xDQKlsxMDrJy
	 oIjevK2b+LoP9zaMtn+kutgEg/e+cORMm1OPGr5GTpq+iff/Xd0KiTL+m8g1qoFunBw==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dkim=pass header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b="P6QGNu7/";
	arc=none smtp.remote-ip=100.103.45.18
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id ED2A2606A32C;
	Tue, 17 Nov 2026 22:29:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=P6QGNu7/
Received: by smtp.kernel.org (Postfix) with ESMTPSA id DC4721F000D0;
	Tue, 17 Nov 2026 22:29:52 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1794954593;
	bh=D//WxIqwyY8ji52F0H+lPRoMbtoFsCNAj+cgnUwhths=;
	h=Subject:From:To:Cc:Date:In-Reply-To:References;
	b=P6QGNu7/ufiuExft0twdnpgwyP+JwuOqqoyLe9LMfKNDNvIdh68PBqw6h+T1/htHm
	 M8GKTgcbKXgJf8uOn97ObzFSCBM50k00wX0WpNy9LqHmDepcL3uYQc+aY4Fsy1UaJ3
	 qY/aQZnCbg/yAJw/ySzYYPHqQD9IMXIt4ahFGqDfgwZmFNgOo13i6Nrd5sz7ojPZNG
	 KoDgfAMg+kFhk20eX5+RA52S47uyerbOT8q6z1QgC7EZcQwhyOOW685c28L99e9zEh
	 Wp8MkwyrAF3IKfjGw/ggfbF3UoJ9oKx1JmVb0nekvXAjxbKnCfKqRbX8YvTSrNvVny
	 NlukQ6T+yJ4Ag==
Subject: Re: [PATCH net 7/7] mptcp: fix dummy mapping of overlapping segments
From: netdev-bot+sashiko@kernel.org
To: matttbe@kernel.org
Cc: martineau@kernel.org, geliang@kernel.org, davem@davemloft.net,
 edumazet@kernel.org, kuba@kernel.org, pabeni@redhat.com, horms@kernel.org,
 fw@strlen.de, dmytro@shytyi.net, netdev@vger.kernel.org,
 mptcp@lists.linux.dev, linux-kernel@vger.kernel.org, stable@vger.kernel.org,
 mason@kernel.org
Date: Tue, 17 Nov 2026 22:29:52 +0000
Message-ID: <179495459243.3136.9349092580555178374@kernel.org>
In-Reply-To: <20261116-net-mptcp-misc-fixes-7-4-rc4-v1-7-bf7656de653e@kernel.org>
References: <20261116-net-mptcp-misc-fixes-7-4-rc4-v1-7-bf7656de653e@kernel.org>
X-sashiko-severity: Low
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Post: <mailto:stable@vger.kernel.org>
List-Help: <mailto:stable+help@vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
List-Owner: <mailto:stable+owner@vger.kernel.org>
Precedence: list
MIME-Version: 1.0

Thank you for your contribution! Sashiko AI review found more severe
issue(s) in other patches of this series. This mail is only an FYI, in case
you want to address the nit picks below when you respin.

Low priority / nit picks for your consideration:

- [Low] The commit's author and the author's sign-off use different email
  addresses.

--

mptcp: fix dummy mapping of overlapping segments

After a fallback to TCP, subflow_check_data_avail() builds a dummy
mapping. This commit computes map_subflow_seq from the first byte of the
skb at the head of the receive queue instead of from copied_seq, so that
map_subflow_seq and map_seq describe the same byte. Without this, new
bytes in a segment that partly overlaps data already received get a DSN
that is too low, and they are skipped as old data.

Link: https://lore.kernel.org/4c48d016490d43b6892c622cbae858b48f176cff.1794304840.git.tanggeliang@kylinos.cn [1]

> Author: Geliang Tang <geliang@kernel.org>

[ ... ]

> Signed-off-by: Geliang Tang <tanggeliang@kylinos.cn>

[Severity: Low]
This isn't a bug, but the author address and the address in the author's
sign-off are different. The author is geliang@kernel.org, and the only
sign-off from Geliang uses tanggeliang@kylinos.cn. No sign-off uses the
author address.

scripts/checkpatch.pl reports this as a FROM_SIGN_OFF_MISMATCH warning
("From:/Signed-off-by: email address mismatch"). The names match exactly
but the addresses do not, and checkpatch does not look at .mailmap.

.mailmap already maps the two addresses to the same person:

    Geliang Tang <geliang@kernel.org> <tanggeliang@kylinos.cn>

So this only affects the consistency of the tags. The DCO itself is not
in question.

Since this carries Cc: stable, could the author be set to the kylinos.cn
address, or the sign-off use geliang@kernel.org (changed or added), before
the patch is applied?

-- 
Sashiko AI review · https://netdev-ai.bots.linux.dev/sashiko/#/patchset/20261116-net-mptcp-misc-fixes-7-4-rc4-v1-0-bf7656de653e%40kernel.org
