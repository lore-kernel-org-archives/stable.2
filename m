Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D9162239085
	for <stable@vger.kernel.org>; Tue,  8 Sep 2026 00:54:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1788828850; cv=none; b=D10W1nHdcG/+Z2E6VaCLSx3bkNx/D2h1ExeTOVZJzAq/1FXCDKzyxAkC+FLNtzvlQyqRnKpaGB48aXPjFCNJhurLKF7xqbHz43Oe8K9HB3nRa4OpR/jq8ci/d0HCAz2yZdarUf/erZ8dFaCFMLQxFfi8FePOkAadjR22lidoXUE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1788828850; c=relaxed/simple;
	bh=ShvcmfHAqoGQJwmMXuMNiR+rR1hCfsz3qYH3N7zpm1M=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=neLIc4SB5Xk+LmE+5PkFjMPXclLgPUI33uXLILC1JbH0EaUa3k2RB6ctcg+25cPTXS9bsPAOCzmH+/danoTWDQCNDyJl56QlatXC9+/ErgDpJQrvFQSzBSwdSi8Kd84RpqnFe7vLxj855Oo92RycXpzJy2ceQxkDrSgfTMd+ZMI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=a4cAktH6; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="a4cAktH6"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 308ED1F00A3E;
	Tue,  8 Sep 2026 00:54:08 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1788828848;
	bh=NdbfgWdGAt7bUVHeSXJmlYol+2wrPz6tu+zmAdcEJfY=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References;
	b=a4cAktH6az1v06MxFDqTAOCbiva1YOF7UdSYWpN5BA96N2HMhjrNL2TIHI+tDxupj
	 M5zi5kcHC/gKfbLZ0othcYamRj1cV9R+STxuEIL8cXoRXGcbRp9Ir8L65tCMcZM7D3
	 M/P+rL/HhyJHbjKsqpN9jhxTJPzLoROkxaW9BQ1S3hwEZgYiUDyg9WLXF/6f3L3Epu
	 Y/wfrEQS+i6f4eI4rIBloRp0h41f6AMis0ShP6tVIK/8edL4l5jA1G2rCtg1EnToaZ
	 35hk58Pph/4DAGk3Ye2cvreRvqzK0rCnOmY+vXuoVO6+OJgYLN4bsCXO6v415YitOx
	 B8t6bpoOGAlHA==
From: Sasha Levin <sashal@kernel.org>
To: stable@vger.kernel.org
Cc: Sasha Levin <sashal@kernel.org>,
	Koichiro Den <den@valinux.co.jp>,
	Dave Jiang <dave.jiang@intel.com>,
	Jakub Kicinski <kuba@kernel.org>
Subject: Re: [PATCH 5.10.y] net: ntb_netdev: Fix TX busy and drop handling
Date: Mon,  7 Sep 2026 20:53:44 -0400
Message-ID: <2026-09-07-daily-reply-0005-ntb-netdev-5-10@kernel.org>
X-Mailer: git-send-email 2.53.0
In-Reply-To: <20260907025712.468641-1-den@valinux.co.jp>
References: <20260907025712.468641-1-den@valinux.co.jp>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

> commit 8aaa47351db0f93a5c5297fbafdfa8bc75e8ae49 upstream.
>
> Currently, ntb_netdev returns NETDEV_TX_BUSY for every enqueue error. It
> also increments the drop and error counters while leaving the skb owned
> by the qdisc, and may return BUSY with the subqueue still awake.

Queued for 5.10, thanks.

-- 
Thanks,
Sasha
