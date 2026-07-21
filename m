Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9F0B03B8120;
	Tue, 21 Jul 2026 21:14:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1784668480; cv=none; b=lLNiRiLtCDJHHCdyUI8xWdrTDOljjgoV+E4MR6Mp9A+LdDDTDQbzPeg0ppSv+8nQdyCRlfHkG9/Wbk7Ik7X9iXxunbdzB3Joe0bqT/WvJ5wMnucQTX/IllE+b7Q6oO4wn5C6nY+4I+FjuxRvIVGyontTH67KnpWl05XC+VOWxgs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1784668480; c=relaxed/simple;
	bh=a/kCST0XBjhGuwicNsPJmQuzlrXl6wn+0mms2v7e6B8=;
	h=Date:From:To:Cc:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=GnnuuK8r4bz72BDARkX+ML56XqaIbDndoCCdJbk+/5TFdG/CmeCGOTjQTs28uHMTb7zYN58HLgdEIoYcq2Gf2B6aUzPd8mbPDZPFowyAVTvbK5MBvqr/t4dvDGCWBuV7PXWK/8vj1NBcSYbTJRzr0Hb6Om6I/ck5ZYWym8IvVEA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=bZbTYb2D; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="bZbTYb2D"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id C7AA91F00A3A;
	Tue, 21 Jul 2026 21:14:38 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1784668479;
	bh=CQBup7mRR3ZAq5vfWTv8cltjM6X23QREtbFZT/Vp/i8=;
	h=Date:From:To:Cc:Subject:In-Reply-To:References;
	b=bZbTYb2D8yRQdLYHDT7ZgQwDT/dJjadJCJaJt6PVpvyH8k9GtkjQKy2dNvqAeOiu+
	 oWlM1pZr4NCpZCpetjsoH6ieUuN1dqYZDD0kE45aF8Qv+vd2BeQakooW6b2UpbGuKd
	 CGVyVdAdv1R7XETkCTgYCl5P5XTt+HoHbjYjK3kU5fdNz67kAjUif/1YvhkdDOalRi
	 c3yv4/fUF4UBZXUDJoqEuPqv2RR2dbYzV7IV1zEMY7YwixFoY9GkaxFY8y5EctCumR
	 bx/08xEpUTXm7yVuT5IlC8w+pn9n1hkKhdS0tmHu5dhAHLtpcS1wgH/bmA7eZrZJTB
	 B/J2cDlKkuBOw==
Date: Tue, 21 Jul 2026 14:14:38 -0700
From: Jakub Kicinski <kuba@kernel.org>
To: memxor@gmail.com
Cc: Matt Fleming <matt@readmodwrite.com>, ast@kernel.org,
 daniel@iogearbox.net, andrew+netdev@lunn.ch, davem@davemloft.net,
 edumazet@google.com, pabeni@redhat.com, horms@kernel.org, hawk@kernel.org,
 john.fastabend@gmail.com, sdf@fomichev.me, lorenzo@kernel.org,
 toke@toke.dk, bpf@vger.kernel.org, netdev@vger.kernel.org,
 stable@vger.kernel.org, kernel-team@cloudflare.com, mfleming@cloudflare.com
Subject: Re: [PATCH bpf v2] veth: convert frag_list skbs before running XDP
Message-ID: <20260721141438.0b7a9594@kernel.org>
In-Reply-To: <178465260565.839953.7972365481675163007.git-patchwork-notify@kernel.org>
References: <20260720140545.461747-1-matt@readmodwrite.com>
	<178465260565.839953.7972365481675163007.git-patchwork-notify@kernel.org>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit

On Tue, 21 Jul 2026 16:50:05 +0000 patchwork-bot+netdevbpf@kernel.org
wrote:
> Hello:
> 
> This patch was applied to bpf/bpf.git (master)
> by Kumar Kartikeya Dwivedi <memxor@gmail.com>:

Kumar, this looks like a networking patch.
Also the kdoc is missing a returns statement.
