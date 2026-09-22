Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B2B1D415F17;
	Tue, 22 Sep 2026 15:39:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1790091548; cv=none; b=RJzLieQogjRvD4ZlWuqVlYeRgjEm479LapjkJvQZ/1Hd3h5W2C9Lm6yliA6jrFxEZHNMog8hQELN7whAmo6OzLZujKlTYjYy58HYmT5Kjs0M+lyBfPFc4rgUouaIl+xrUsK7UPvhvBYFPwVlDYcdv1QzTsGK3sbZdjPTcVFgZBw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1790091548; c=relaxed/simple;
	bh=o/bwDSMh0cvsxxU/j0VJGK3Ioy5J2+xBMaKPThKgfI4=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=nlqItT/8xflqpKymbyQYTSMgxSm1rtlSvBbX816AQl3IZdG11cOAKcEAhCNxV0N797qPa3gpDM6NdeWF3D1Qd6KS7HpG8aF9OCswot1xh/QJ0yaoJyyexJ6BB9sELcYT77InMzE0PDyTBkOsWtyxatBtm1QTozG0QGtfhd4fd50=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=jmFRNDZb; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="jmFRNDZb"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 271321F0089A;
	Tue, 22 Sep 2026 15:39:06 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1790091547;
	bh=UVK7h2obwvfu695HCYqTPVZ30G9zhPQ7nPQGnTZUkLM=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References;
	b=jmFRNDZb1gNNc9j8Va1yA27pzFhQ0qiJ9TuC2DDRKf6u7qKK6xlBc6OPhN9ZwN4Ev
	 FLxgWFde+8I2YAE+3cTT0NP3v0En9XOWb+xsFK94HWi19yALJO3EIpMZf12f2xcEph
	 qI02tnFAFX86mXDwijKR0uN0mPt8pIeEtY2z/GtjopHwm+EgLLmu74yPZTwZetw/lf
	 dj1OhmcsVUkpPyfxzbWUZbanMcmRiH2MuokixR8nCfZpzTwhvPLDBkRdhKOcAg4o/Z
	 Ts5tBUYCY3+F+Vr7QbzZ0glupjlCY2WzHbpnjRQc8qfFrKy7yFSuftyuvrt1DQ3SCv
	 feGfzwemKJVyw==
From: Sasha Levin <sashal@kernel.org>
To: stable@vger.kernel.org
Cc: Sasha Levin <sashal@kernel.org>,
	Artem Dinaburg <artem@trailofbits.com>,
	Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
	Jens Axboe <axboe@kernel.dk>,
	linux-block@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	Chengming Zhou <zhouchengming@bytedance.com>,
	Ming Lei <ming.lei@redhat.com>,
	Yi Zhang <yi.zhang@redhat.com>,
	Hannes Reinecke <hare@suse.de>
Subject: Re: [PATCH 6.1.y 0/2] blk-mq: backport CVE-2023-54227 to 6.1.y
Date: Tue, 22 Sep 2026 11:38:56 -0400
Message-ID: <2026-09-22-daily-reply-0003-re-blk-mq-cve-2023-54227-6-1@kernel.org>
X-Mailer: git-send-email 2.53.0
In-Reply-To: <20260921200728.84114-1-artem@trailofbits.com>
References: <20260921200728.84114-1-artem@trailofbits.com>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

> The first patch frees excess tag
> sets after a queue-count reduction. Its immediate upstream follow-up moves
> that free past hctx resizing so the repair itself cannot race into a UAF;
> they need to travel together.
>
> Could you please queue the pair for 6.1.y?

Queued the pair for 6.1, thanks.

-- 
Thanks,
Sasha
