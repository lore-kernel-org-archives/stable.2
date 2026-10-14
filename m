Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B92F81A6803
	for <stable@vger.kernel.org>; Wed, 14 Oct 2026 01:27:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1791941253; cv=none; b=VO4X6aDjV3K5cL+ajJKAmmuPyJP9cETZz/+axxvJQFBAKwAGnQIIuq3Ckg+KEJqoYSCaQ5Jq72eoPxn/y6HZBVrrf/mKsvf7vQ9lB3DXpulTzsHNx3XUcEYpAJug9FSf50Y2/xWYSRhOPa3aBC+/qxzkLwHNa5/yOjYVqDSK+cg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1791941253; c=relaxed/simple;
	bh=vikMj6Kjx88XpcRYANQKLCOyulpcCVyBcH39gmuBQZY=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=jqDfkJ2jr4ckUJDxNtK+6uMfpI+4OcHt0+h82JVpcgXKyGHXL657yGY19W1ZqlMkhbHEnAXrUVJ5gCfOHjASPpcXQ4gaAuHMCDVGH1X23l1k5sZVbGFrzkEdpk10OZLnoZMxaeXCbkcNsaUSNRiVpEAmX3gTW3NGy+qvqsu2jKk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=oTEVM/tG; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="oTEVM/tG"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 110841F000FF;
	Wed, 14 Oct 2026 01:27:31 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1791941252;
	bh=CexoIta5bGcIeLZVXC6SwvIwov0Eprdhrwb0QfbeJCQ=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References;
	b=oTEVM/tGl6HQ2gAB1LxG65EaGTm3XxNh3scCNnqNc8NYiSBjz/03K94Ok1FmFDxiX
	 9neczVVsf+yE8ZqyV5Vuta0gz7S/V972p5oGC+u5KAa7GVZNQHptOJ/Ij7RUqQZKy9
	 gTIMg/xKtyE134iTigsXKELIUkeQr1D9UZlYS0Hmei1EhEGasOCdkeShZ9a4IF+2oi
	 12mH9yzROlVoAVTbrKJ9IIeLY2Ii8rMZK8LdJlhaKAuhwx+9L0NZUpUAiZ3mw+FY+l
	 NtDHUQWL6uco372Y2mjYYSdZmRpzJPa0ih4llkC5GhJGJbI7OnXT6xRHvxpb4DsLR5
	 vhbH1SEcUXIqw==
From: Sasha Levin <sashal@kernel.org>
To: stable@vger.kernel.org
Cc: Sasha Levin <sashal@kernel.org>,
	Marc Kleine-Budde <mkl@pengutronix.de>,
	Oliver Hartkopp <socketcan@hartkopp.net>,
	Joerg Willmann <joe@clnt.de>
Subject: Re: [PATCH 5.10.y] can: fix unique skb identifier regression under RPS
Date: Tue, 13 Oct 2026 21:27:03 -0400
Message-ID: <2026-10-13-1-daily-reply-0012-can-skb-uid-rps-5-10@kernel.org>
X-Mailer: git-send-email 2.53.0
In-Reply-To: <20261013074112.288283-1-socketcan@hartkopp.net>
References: <20261013074112.288283-1-socketcan@hartkopp.net>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

> Commit d4fb6514ff8e ("can: use skb hash instead of private variable in
> headroom") moved the per-skb unique identifier used for raw_rcv()
> duplicate detection into skb->hash.

Queued for 5.10, thanks.

-- 
Thanks,
Sasha
