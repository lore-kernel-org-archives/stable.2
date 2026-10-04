Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 78BAB253B58;
	Sun,  4 Oct 2026 22:20:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1791152416; cv=none; b=r3aQbKINzMy1FlYjIlYPrd296ojH8ebRWVptPGekoDtCC81Nn+Y7xtGk6jWSdjfNUUmvcwSWbhb390BbJgYTIaNRGpQA9jrFxtbVkiQm00QEdpE9bGCMytK1SG8owHh+W/D03hWUZZwV+9gjpxPjlNsdwWVSCNZoeGw83kN3PRM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1791152416; c=relaxed/simple;
	bh=ucPXavhG6QjzMQdmVi4/DoZAcB6HobWTLPRwFQ1CN1k=;
	h=From:To:Cc:In-Reply-To:References:Subject:Message-Id:Date:
	 MIME-Version:Content-Type; b=oorZOM1xADXgzYClJ8d//NV7zN2GdowFvBX5mVDvyBpDUeOIy3RkXRjBMNSZdVSujewmfF+Bvp9QpwTccEQ2RUQdtMeXuvpnEJvIntlcyIxPA0unOgNYYPuONgkIMu40sAGNDf5K7Lp6iGvqyydmWvLo+tJZBp8pV41toIZtVbI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
Received: by smtp.kernel.org (Postfix) with ESMTPSA id B170C1F000FF;
	Sun,  4 Oct 2026 22:20:14 +0000 (UTC)
Received: by venus (Postfix, from userid 1000)
	id 16099180A51; Mon, 05 Oct 2026 00:20:13 +0200 (CEST)
From: Sebastian Reichel <sebastian.reichel@collabora.com>
To: Sebastian Reichel <sre@kernel.org>, Myeonghun Pak <mhun512@gmail.com>
Cc: linux-pm@vger.kernel.org, linux-kernel@vger.kernel.org, 
 stable@vger.kernel.org, Ijae Kim <ae878000@gmail.com>
In-Reply-To: <20261004041019.1123723-1-mhun512@gmail.com>
References: <20261004041019.1123723-1-mhun512@gmail.com>
Subject: Re: [PATCH] power: supply: sbs-battery: disable polling before
 supply teardown
Message-Id: <179115241307.240086.2136432066367076268.b4-ty@b4>
Date: Mon, 05 Oct 2026 00:20:13 +0200
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
X-Mailer: b4 0.16.0


On Sun, 04 Oct 2026 00:10:19 -0400, Myeonghun Pak wrote:
> The managed poll-work cancellation is registered before the power
> supply, so cleanup unregisters the supply before draining polling.
> A pending or running poller can then call power_supply_changed() on
> the released supply.
> 
> Commit 8d59cf3887fb ("power: supply: sbs-battery: Fix use-after-free in
> power_supply_changed()") moved the IRQ request after supply registration,
> but did not change the poll-work cancellation order.
> 
> [...]

Applied, thanks!

[1/1] power: supply: sbs-battery: disable polling before supply teardown
      commit: 5c1c602463d597c5189ddc5a73dece588ba2c57a

Best regards,
-- 
Sebastian Reichel <sebastian.reichel@collabora.com>

