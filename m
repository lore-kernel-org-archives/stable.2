Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 51DFB2836F;
	Sat, 25 Jul 2026 00:02:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1784937772; cv=none; b=s9lXviz20AoSxOn1RYgYzvZLswZiGfTJjBlS8jPXSIYj28VGHDYGamAMTLKjM5qqRauRJIs+Yt/nw4bPchuGHAmERDv2U6kM+sI1M3vJZwCPjHHVmuyfbLsBfPnGrGfHsLUCbG2gx0MhkjOEtW+2MEqTxDCxojhkXF0XzIQi6ks=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1784937772; c=relaxed/simple;
	bh=CD7flKDckmkrYltAjOzop3qDByyLfohVZzVwfCheI60=;
	h=From:To:Cc:In-Reply-To:References:Subject:Message-Id:Date:
	 MIME-Version:Content-Type; b=siX71YeUAMb2Xfoa/VfiNA1KYn+dSMZFyKNtvUlO/jVhE12vNkscfpMOo4qmF/8us7zzN+Q4IOFh3AHMo92bsLFgrZxo/g9hl4z7McjulUwZ7GvM5YevJm7xGz3ed7UsZHy1ZnhWDQDXvDXUf80IxcHTlisSOuiUrhvvXsODiEw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
Received: by smtp.kernel.org (Postfix) with ESMTPSA id CD8821F000E9;
	Sat, 25 Jul 2026 00:02:50 +0000 (UTC)
Received: by venus (Postfix, from userid 1000)
	id 3BFC9181F17; Sat, 25 Jul 2026 02:02:49 +0200 (CEST)
From: Sebastian Reichel <sebastian.reichel@collabora.com>
To: sre@kernel.org, marex@denx.de, hansg@kernel.org, 
 Ma Ke <make_ruc2021@163.com>
Cc: linux-pm@vger.kernel.org, linux-kernel@vger.kernel.org, 
 akpm@linux-foundation.org, stable@vger.kernel.org
In-Reply-To: <20260722044416.1623621-1-make_ruc2021@163.com>
References: <20260722044416.1623621-1-make_ruc2021@163.com>
Subject: Re: [PATCH v2] power: supply: bq25890: Fix power_supply reference
 leak
Message-Id: <178493776921.704550.12009062098342055633.b4-ty@collabora.com>
Date: Sat, 25 Jul 2026 02:02:49 +0200
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
X-Mailer: b4 0.14.3


On Wed, 22 Jul 2026 12:44:16 +0800, Ma Ke wrote:
> bq25890_fw_probe() acquires a reference to a secondary charger using
> power_supply_get_by_name(), but the reference is not released on later
> probe failures or on driver detach.
> 
> In particular, failures after bq25890_fw_probe() returns successfully,
> such as a failure in bq25890_hw_init(), also leak the reference.
> 
> [...]

Applied, thanks!

[1/1] power: supply: bq25890: Fix power_supply reference leak
      commit: 863c32a83e4235eb0cbf6106f2b124e645302156

Best regards,
-- 
Sebastian Reichel <sebastian.reichel@collabora.com>

