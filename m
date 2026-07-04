Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6081237268A;
	Sat,  4 Jul 2026 02:05:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1783130745; cv=none; b=sEJu6/SCJG5o5wN28auRPPozAS1dIl2Wytdzo6hWnqQkpSmzMC2zszPWNLl/iJTjbU9FAGUPWAKBo+mnBQ749oD8Fb6aM1MTRwJkNTIMYiiuVVb9S2h1lGLW9AKK+JLPfm584BD/BQMvKGyX6Rrm3HjAeB3uUqAuLPTvGl1QUbE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1783130745; c=relaxed/simple;
	bh=Gh7zPtnoU6n2C2fISk3f0t2N8UYzRiVrBf/AWbw9cFs=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=YzAnJgCJjnnjlj0a6BNjDOxv1vHhWCkdjJHFh2XtyETLXW2X8g9FBhzZeP9eHg5oVxiccbaftorAl4wta3MgsTkPf+8v+KE59oUTgQdKlUXt2NbdWqQBbmRwhv+rnSSulFzmHnLirH+trBqQE1rchS83VjxSfPaPkdI8Dnn9ns0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=UniFhK3a; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="UniFhK3a"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 3FF9B1F000E9;
	Sat,  4 Jul 2026 02:05:43 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1783130744;
	bh=FuKFRC2UMqfTB32HTYGSrvKzMcxyhi40to9kRReBfSw=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References;
	b=UniFhK3azUSfHEIXglQprci6Ifz3s4z7OleDAidUoWHhd7c+FFUtkTWLgpsBEQ6g3
	 PHrQI7fu5j+4q41WsD9qizzjGSXLcqLQgqdSrUt4GNn29QvtB84CZ+Utx62OmYZY1w
	 Tdj0r7TKnXZOBkkz6p4UZobeblF6/LUnXlZTPrE3xUmIs6Glqk3j0OhXRYmQ38cRL3
	 yeKOTcRq6cKLcTiTOcgIWyDIf4/kYKC6JBSkRz0bR3aO2p92Cd5S/eigerZ02chJVx
	 o0ijzLYuAq4D+Ailg82Ln+lAwPiKYEF6czejUbI3I+mQBZAZ81YzAamLHQkAD9T6m2
	 8mTybduwHYb5A==
From: Sasha Levin <sashal@kernel.org>
To: Chris Lu <chris.lu@mediatek.com>,
	Sean Wang <sean.wang@mediatek.com>
Cc: Sasha Levin <sashal@kernel.org>,
	Linux kernel regressions list <regressions@lists.linux.dev>,
	linux-mediatek <linux-mediatek@lists.infradead.org>,
	linux-kernel <linux-kernel@vger.kernel.org>,
	linux-bluetooth <linux-bluetooth@vger.kernel.org>,
	stable@vger.kernel.org,
	Thorsten Leemhuis <regressions@leemhuis.info>
Subject: Re: btmtk: regression in 6.6.142: NULL pointer dereference in btmtk_usb_hci_wmt_sync during resume from S4
Date: Fri,  3 Jul 2026 22:05:10 -0400
Message-ID: <2026070315-stable-reply-0016@kernel.org>
X-Mailer: git-send-email 2.53.0
In-Reply-To: <7ea1c4a0-d38f-413b-993b-7846b2b7debd@leemhuis.info>
References: <7ea1c4a0-d38f-413b-993b-7846b2b7debd@leemhuis.info>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

On Thu, Jul 03, 2026 at 08:34:04AM +0200, Thorsten Leemhuis wrote:
> Hi Chris & Sean! I noticed a report about a regression with btmtk that
> happens in 6.6.y series. This strictly speaking is the domain of the
> stable team, but maybe you want to take a look nevertheless:
>
> https://bugzilla.kernel.org/show_bug.cgi?id=221696

Thanks for the report!

I've queued the missing part of the upstream chain for 6.6.y: 5c5e8c52e3caf
plus its follow-up fixes 67dba2c28fe0af ("Bluetooth: btmtk: Fix failed to send
func ctrl for MediaTek devices."), 099799fa9b76c5 ("Bluetooth: btmtk: Fix
wait_on_bit_timeout interruption during shutdown"), and f0c83a23fcbb42
("Bluetooth: btmtk: Fix btmtk.c undefined reference build error").

-- 
Thanks,
Sasha
