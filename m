Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=100.103.45.18
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1793804614;
	b=xdHBQmO87MDIDGNXV0UlEJ/piYNofO05NpzCy7LXkQ78+7WOtDlZYTgqAFEpZ0zPnfvh
	 B8nxiErDoC2H9X7bKSJ4eQ8PNZ8zobSSYgdDvb1G6ba/jLVCn6WwZ4f23nFQxfttXBERY
	 fy5JLbZ8aMqG6fVZX269uNGefXsbBtC9KQl3S5KXynP6GsSEKj82R4cf3a2D5UJ4EO48d
	 H/xMIYs/c8XNetuzuhvTl7uxpNVrWrTi9XODyEZ4UfIr0O9LQpZXPe9yZUM7tHzBdLIo0
	 CK0IVVMGjCxp87PeBalaJreeEjQf1MvA+MXK+JYrJZREzlj7Snk/0eCyQ4xESfzxKFA==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1793804614;
	h=Received:DKIM-Signature:From:To:Cc:Subject:Date:Message-ID:X-Mailer:
	 In-Reply-To:References:MIME-Version:Content-Transfer-Encoding;
	bh=fINob83SejFZPfBNExTbtDkvtQ/HdhakZJ/VtelXf0s=;
	b=fWrbN4RWcHNmb5va8vZQsOjPkP7yxiSVu+HQMJaT2QEjqyZCxNcuQso4qcmhPz0RXf+B
	 FlZtxCT/0LFYs5ggaNKDRACm9jJmqQfjZOpElq4oThDw9jicqlsA14JJ3oiERjK11iDTv
	 OsQC96Hc5d3a92YNDCzlc/7yVidQb11TX/VO9Yj8rU6YCCH0O1OMyDBeTlzY6fle+3m30
	 4+TcYwFWLCt6tfMOhWeE9C9TPY0tIXxNe5rVd+D93xjL9EvCj2Y72da9e2unBp5+Sb5uw
	 IT3f+WcPE6KsZCx0MB2rkNYAr8f+4mVZskRrSQ4Mamt46XhF4iKFk1XPMbylXKM3GZA==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dkim=pass header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=X8Uu8OFr;
	arc=none smtp.remote-ip=100.103.45.18
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 682B0606A33A
	for <stable@vger.kernel.org>; Wed,  4 Nov 2026 15:03:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=X8Uu8OFr
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 52A3D1F00919;
	Wed,  4 Nov 2026 15:03:33 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1793804614;
	bh=fINob83SejFZPfBNExTbtDkvtQ/HdhakZJ/VtelXf0s=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References;
	b=X8Uu8OFrl0HfAowBaCV1oSWH1MosiNeCZYC7biKOdaHmS+kAysnlroOZrHhlt0cze
	 c4epjdD4lU2+fxJvmAVXczT/eL277krtZw8KSCfQrbnN+AQ1SwKgmngEIRABn10D3T
	 ZO4uo/eI6XlhQ1ASSuR1iIRBv9IxHJCthBdJuiV/W+/vJAGbvcwZDhSvHuWNdKaGV1
	 qOqXDW8DktsZN5hJycahh+Z6q8xgZByD2/sIih4gX0d6uz0fnNEy52mxUQdMuaKXvn
	 mZfe5h3Nr0v5h3KyUvsWpxfiHWNqLxsOEMG4fkoxFySsyhbSPoMoYaofM+PBRowrAP
	 3IpDBK2rUrLzw==
From: Sasha Levin <sashal@kernel.org>
To: stable@vger.kernel.org
Cc: Sasha Levin <sashal@kernel.org>,
	Sam Dlinn <sledge@meta.com>,
	edumazet@kernel.org,
	pablo@netfilter.org,
	Florian Westphal <fw@strlen.de>
Subject: Re: [6.18.y request] netfilter: restrict payload mangling
Date: Wed,  4 Nov 2026 10:03:15 -0500
Message-ID: <2026-11-04-1-daily-reply-0006-re-netfilter-payload-mangling@kernel.org>
X-Mailer: git-send-email 2.53.0
In-Reply-To: <auscVa1zQMqoTxhq@strlen.de>
References: <auscVa1zQMqoTxhq@strlen.de>
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

On 2026-11-04, Florian Westphal <fw@strlen.de> wrote:
> Could you please pick up following commits for 6.18.x kernel?

Queued all nine for 6.18, thanks. 7.3 was still missing the checksum offset
patch from the series, so I queued that one there as well.

-- 
Thanks,
Sasha
