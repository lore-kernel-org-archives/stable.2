Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7F20F3264C7;
	Fri, 18 Sep 2026 00:52:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1789692777; cv=none; b=C2JysdYlwKM64N1uZeItiGYsz1/FMI6wjmXSAaOz3mVk+0ZNyFDTuwNzku7SQpcdZe+iuTrD1ScFMuxQgd4qjnglvdd9rsO0p6f5eJnBeWS+xx9FfvQT8P61z3OsyubxSfdGtJDjEvwsr69QNSBZWmOHa05XuqbSI0c9t4sSGDQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1789692777; c=relaxed/simple;
	bh=tM0NRSFnArKO9+Ic308atgNmYaMZ8A/kJTdbrsFvCGw=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=Ni7rWUNBSnDtzVrEdB6wZons7bILHyy038edpt5eWhOvr38AKzdukL9HyNKHuqQ0UhKX125WS/QrQuWX7vL60e5d52rLPZ9/4m0dQ8G5iGfw7zbHFbjbB+b8DDnfzqX2kdKFKmvt965g6/9eD8BSXX6NG6B8po0YW0XxLq/7llU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=oDFbKWpv; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="oDFbKWpv"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 41A0A1F000FF;
	Fri, 18 Sep 2026 00:52:55 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1789692776;
	bh=JFeSH0R8nm82pAar/9fdeugM12HGsO1Lzho6DZIdUD0=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References;
	b=oDFbKWpvuCA2Q9IA3988wy42olbAq6LE2JHBLCcERQQTTcowERTTIDFoWiuzyQ6tA
	 56YdlVo/iZuIchQPZI/MtgBibFTDD8k3l7nBAv2UOPSPNoPWGrciWMeAi1RyC2XiZg
	 XhZJuOtHbuUssXvfw8m3CPU+FBVrqlHEQrYTit4x5BKmkHILL7fVS25mCRu2OpBUjB
	 Q9DLey1xZmYDKbdP3Uk0julTPS1jVFdOHAKOACy2NJRciPlX5/C9nLDandcY4uhbbB
	 JIt0pMC/313r8h/gD27/XuLxakqox3mqOxWzuzhjP8DHfpxxaY8oAKVuBQ2YK2QFn9
	 sqXp2xhKuibSA==
From: Sasha Levin <sashal@kernel.org>
To: stable@vger.kernel.org,
	Jens Axboe <axboe@kernel.dk>
Cc: Sasha Levin <sashal@kernel.org>,
	Thomas Petazzoni <thomas.petazzoni@bootlin.com>,
	linux-kernel@vger.kernel.org,
	Joseph Ravichandran <jravi@mit.edu>,
	"Miguel Gazquez (Schneider Electric)" <miguel.gazquez@bootlin.com>
Subject: Re: [PATCH 5.10.y] io_uring: fix uninitialized field in rw io_kiocb
Date: Thu, 17 Sep 2026 20:52:34 -0400
Message-ID: <2026-09-17-daily-reply-0007-io-uring-kiocb-private@kernel.org>
X-Mailer: git-send-email 2.53.0
In-Reply-To: <20260916-cve-2022-29968-v1-1-b092d165f9cd@bootlin.com>
References: <20260916-cve-2022-29968-v1-1-b092d165f9cd@bootlin.com>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

> +		kiocb->private = NULL;

I am dropping this one: the assignment is dead code on 5.10.

The Fixes: target 3e08773c3841 ("block: switch polling to be bio based")
is v5.16, so iocb_bio_iopoll() does not exist on 5.10 and nothing reads
the uninitialized value. __iomap_dio_rw() writes iocb->private
unconditionally before its only -EIOCBQUEUED return, and io_do_iopoll()
skips ->iopoll whenever iopoll_completed is set. The same holds for
5.15, which is also pre-5.16.

-- 
Thanks,
Sasha
