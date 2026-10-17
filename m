Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 38942370ACE;
	Sat, 17 Oct 2026 21:56:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1792274196; cv=none; b=Q0tzKC1jaathEJ7JeKgWwXe9bag4VpB0EvCdxSMwzmYFCfbgfcxXwKMaMoYGS2HShRaThjlFOT1PF7o3clo7ugpXAZqHh1l2XJWg+OCvt+4tJzf7a7+uI+VJy88Zroc562LxY+TMs0DwRW5xCIWcM1D40VHQC5aT1H07A9q4G74=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1792274196; c=relaxed/simple;
	bh=0lUe5T1XZ01SOdlOpCK/Au+YgH0QhIr/tZVkgK+z3oc=;
	h=From:To:Cc:In-Reply-To:References:Subject:Message-Id:Date:
	 MIME-Version:Content-Type; b=WG26tlRgnr6B54SOAYK8nXCwAEVPROVd2ZNy2UVOwFpSxDst2bpAdY+0REV3a9SWouR2faMzGtQtpqji+HrS8AKOs+O1Ksej7MCXsLIvsf7hdZuqD1SwZquuDIeKuuRZ2Q4Q/Ma7/WbyD5bJIEjQCVRPsbQuugMnoFhCFNdDylU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
Received: by smtp.kernel.org (Postfix) with ESMTPSA id D2A0A1F000C4;
	Sat, 17 Oct 2026 21:56:34 +0000 (UTC)
Received: by venus (Postfix, from userid 1000)
	id 6D97C1824B5; Sat, 17 Oct 2026 23:56:33 +0200 (CEST)
From: Sebastian Reichel <sebastian.reichel@collabora.com>
To: Tzung-Bi Shih <tzungbi@kernel.org>, 
 =?utf-8?q?Thomas_Wei=C3=9Fschuh?= <linux@weissschuh.net>, 
 Sebastian Reichel <sre@kernel.org>, Benson Leung <bleung@chromium.org>, 
 Andrew Pam <andrew@fastmailteam.com>
Cc: Guenter Roeck <groeck@chromium.org>, 
 Matt DeVillier <matt.devillier@gmail.com>, chrome-platform@lists.linux.dev, 
 linux-pm@vger.kernel.org, linux-kernel@vger.kernel.org, 
 stable@vger.kernel.org
In-Reply-To: <20261005043418.243937-1-andrew@fastmailteam.com>
References: <20261005043418.243937-1-andrew@fastmailteam.com>
Subject: Re: [PATCH v2] power: supply: cros_charge-control: restore EC
 state on resume
Message-Id: <179227419343.76434.11850314972338032002.b4-ty@b4>
Date: Sat, 17 Oct 2026 23:56:33 +0200
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
X-Mailer: b4 0.16.0


On Mon, 05 Oct 2026 15:34:18 +1100, Andrew Pam wrote:
> The EC resets its charge control configuration when the AP powers off,
> so configured sustainer thresholds and charge behaviour are lost across
> hibernation.
> 
> Nothing notices the reset. Commit 4fc88ba435da ("power: supply:
> cros_charge-control: adopt EC charge state on probe"), in the
> power-supply tree, made the driver adopt the EC's charge state, but only
> at probe, and a resume is not a probe. Sysfs therefore keeps reporting
> the configured values while the EC charges the battery to full. On a
> Framework Laptop 16 (Ryzen AI 300, charge control command version 3)
> with charge_control_end_threshold set to 80, a hibernate and resume
> cycle leaves the attribute still reading 80 while the battery charges
> past it to 100%.
> 
> [...]

Applied, thanks!

[1/1] power: supply: cros_charge-control: restore EC state on resume
      commit: 1f2a40f954c848dff9d8bb6d81e404f9e47f0e81

Best regards,
-- 
Sebastian Reichel <sebastian.reichel@collabora.com>

