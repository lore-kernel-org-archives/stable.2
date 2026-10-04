Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CA78C353A6D;
	Sun,  4 Oct 2026 22:06:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1791151615; cv=none; b=DBb5bq5uRxVfaJPYU6M7w9yyfZqXCvntw4V0j+TQ0hAFBZxozqz7g3ONeSPbzf9nxZrnB9/tCfJCcoTFULbO7fWPvhW5jn+SZknEojzdNb0RKaL+0iPUIXyGswpVkMi2hkUcPbmh4RrkGb8nD4Z3PxxXhGA4R504bH6ui4PsduM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1791151615; c=relaxed/simple;
	bh=0BlvP+UVoG4Ln1Pg/j68FYQ7OvnVNfsSV31y6kHStCA=;
	h=From:To:Cc:In-Reply-To:References:Subject:Message-Id:Date:
	 MIME-Version:Content-Type; b=pucXPGM0OCbKdYr1Y82oBx7SKhd9RS85lgpaqtcTmYx/xFMddM4rO/VIKwfOdFeqQbXR+REZOJzRq8AllM/hfPfzUZGb1F3TaqGCtXTJC4kbqxmmCiz7GymWUqWUjzEBuh0ADvaNpu57wVq6T5UF6Rx1aytq8LaqJTgnFe4Guwk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 4E5551F000FF;
	Sun,  4 Oct 2026 22:06:54 +0000 (UTC)
Received: by venus (Postfix, from userid 1000)
	id 5E6BA180A51; Mon, 05 Oct 2026 00:06:50 +0200 (CEST)
From: Sebastian Reichel <sebastian.reichel@collabora.com>
To: Samuel Kayode <samkay014@gmail.com>, Sebastian Reichel <sre@kernel.org>, 
 Myeonghun Pak <mhun512@gmail.com>
Cc: Frank Li <Frank.Li@nxp.com>, Lee Jones <lee@kernel.org>, 
 imx@lists.linux.dev, linux-pm@vger.kernel.org, linux-kernel@vger.kernel.org, 
 stable@vger.kernel.org, Ijae Kim <ae878000@gmail.com>
In-Reply-To: <20261004043728.1140015-1-mhun512@gmail.com>
References: <20261004043728.1140015-1-mhun512@gmail.com>
Subject: Re: [PATCH] power: supply: pf1550: drain IRQ work before
 unregistering supplies
Message-Id: <179115161036.234792.14449355885017215498.b4-ty@b4>
Date: Mon, 05 Oct 2026 00:06:50 +0200
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
X-Mailer: b4 0.16.0


On Sun, 04 Oct 2026 00:37:28 -0400, Myeonghun Pak wrote:
> The VBUS work calls power_supply_changed(), but its managed
> cancellation is registered before the supplies. Cleanup can therefore
> unregister a supply while IRQ-triggered work is still pending.
> 
> Commit 838767f50747 ("power: supply: pf1550: Fix use-after-free in
> power_supply_changed()") moved IRQ requests after supply registration,
> but left work cancellation before the supplies. That change protects
> the direct IRQ callbacks, while this fix drains the work they queue.
> 
> [...]

Applied, thanks!

[1/1] power: supply: pf1550: drain IRQ work before unregistering supplies
      commit: 4856b49317ccd4ce96a0e8970df7d13ce8975a02

Best regards,
-- 
Sebastian Reichel <sebastian.reichel@collabora.com>

