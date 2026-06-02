Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5941D2E06E4;
	Tue,  2 Jun 2026 02:31:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1780367499; cv=none; b=AQGZ5mscLWZXuv4rbnjM1mUkUkfDMlLEXUkiMsU4Uc8+qwoLGFf5gXAqjutM69c7fW2uWThoBTpknv43H7T947gWhW6akTNqvKmJ/Bjbxeszcme00D72hshxB8BYaxzxecSD8oNsZmS71Y454bYptfldSQPRn90ojWd0N4Mayzw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1780367499; c=relaxed/simple;
	bh=0XOIUTvrbl3SAQ72SYDFAim8y+wxjlZ7GpEBan5/GGU=;
	h=Date:From:To:Cc:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=Dmflza4tevQlPMsxqHsZ7sNyHoHLARmqZlJJ3x1RW7CusRjesJxC2a9eqn2IqyHCT/KRn9/GlhFqU44zbYgaPQIebH0HbKh/pEqcMXF0H4FyRyIySmZ77xeTEKQwJ8lsyepa6bXEmMNX8/p50hw6QeIDmzrc4rbBfgTmEdk5Gz0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=m9oBE+Aq; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="m9oBE+Aq"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 9621F1F00893;
	Tue,  2 Jun 2026 02:31:37 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1780367498;
	bh=zlq722CCmo1RfiejtRU/V9QHu4tbLYEOJ0E0UPw8zaA=;
	h=Date:From:To:Cc:Subject:In-Reply-To:References;
	b=m9oBE+Aq5WUrCpPmAKsS8c0kXjtb14mPBPtbAu79OGdNCNLpk3NOeq/Vkwy4RsW92
	 gkDFmtSzqkpQuh0qBJMP3W+wMscGcmDJbgOAzNEezDK1b/rviip3qwaHgsnRFY6LRB
	 QDbLwGkqzwGSpGgfLuTpNjc+5SadRxswySXcQI/9A8A6W10Kqto850U9TBPhN2Wpr0
	 GPT/QPQTLu8MigV8ImdpzNap0bfnRJErenKLM5vex6kMxLnukCPJZO3zQrHE80XTWq
	 osqL4d+Yg9wuRcJSdvxP7eFoWX0ayxRSY9zJBESBblef2QIyGYpW5BGC0C6CMHECoR
	 CKFSYFqUkLLjA==
Date: Mon, 1 Jun 2026 19:31:36 -0700
From: Jakub Kicinski <kuba@kernel.org>
To: Zijing Yin <yzjaurora@gmail.com>
Cc: "David S. Miller" <davem@davemloft.net>, Eric Dumazet
 <edumazet@google.com>, Paolo Abeni <pabeni@redhat.com>, Simon Horman
 <horms@kernel.org>, Murali Karicheri <m-karicheri2@ti.com>, MD Danish Anwar
 <danishanwar@ti.com>, netdev@vger.kernel.org, linux-kernel@vger.kernel.org,
 stable@vger.kernel.org
Subject: Re: [PATCH net] net: hsr: remove VLAN filters from slave devices on
 port deletion
Message-ID: <20260601193136.06c65d95@kernel.org>
In-Reply-To: <20260527170805.3376866-1-yzjaurora@gmail.com>
References: <20260527170805.3376866-1-yzjaurora@gmail.com>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit

On Wed, 27 May 2026 10:08:04 -0700 Zijing Yin wrote:
> While fuzzing with a customized syzkaller, I hit a WARNING in netdevsim's
> nsim_destroy(): a netdevsim port is freed while it still has a VLAN RX
> filter installed (a bit left set in ns->vlan.ctag):

Another thing that the other drivers do on port del and HSR doesn't is
to remove the UC/MC MAC addresses propagated by ndo_set_rx_mode
Could you please check what else is missing and fix all of these with
one series?
-- 
pw-bot: cr
