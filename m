Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 497C54DB57E;
	Thu, 23 Jul 2026 15:09:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1784819380; cv=none; b=j4Eihn2HQtTWpgWxl1rxIAlrqgTqIMRL1yUqTyBfhz8A1Lab3T8QWjBEkjVBZ1ulEfNJsmltjyHr0L12ba9xngnr6RItDW1byQXMme2t61CWmmvM9WCzrKtFtNYLkhbVCzzy5rVJAWmkoJ0o1LJpC0QKaxmePuAHCZcgpJAjnUk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1784819380; c=relaxed/simple;
	bh=CuyUjGsBGhUAqPYcNPD7mSABIcbmcO9cXvLSwry7W7Y=;
	h=From:To:Cc:In-Reply-To:References:Subject:Message-Id:Date:
	 MIME-Version:Content-Type; b=d7VRPYJBrKanIFtOW3DILdhhoHBBQ59dvktkaIb1vBEVsSofK/dM/mFKOotskwY0v7j2H+sAgX69v2eMPXxIQx7KNU9dXQlLOVZXIJ1XeIwD9+bzZQRHIP5070PX25Nub0OFDvZOKwwNf5D2x64VCh/M1HMbsy/EwyK7WbdaYVo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 45B381F000E9;
	Thu, 23 Jul 2026 15:09:27 +0000 (UTC)
Received: by venus (Postfix, from userid 1000)
	id D6078180CCC; Thu, 23 Jul 2026 17:09:24 +0200 (CEST)
From: Sebastian Reichel <sebastian.reichel@collabora.com>
To: sre@kernel.org, raoxu <raoxu@uniontech.com>
Cc: linux-pm@vger.kernel.org, linux-kernel@vger.kernel.org, 
 stable@vger.kernel.org
In-Reply-To: <0619C8BF15F43B7C+20260723065444.1796002-1-raoxu@uniontech.com>
References: <0619C8BF15F43B7C+20260723065444.1796002-1-raoxu@uniontech.com>
Subject: Re: [PATCH] power: supply: bq25890: fix the -10 C NTC lookup entry
Message-Id: <178481936485.618128.8107373687665239910.b4-ty@collabora.com>
Date: Thu, 23 Jul 2026 17:09:24 +0200
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
X-Mailer: b4 0.14.3


On Thu, 23 Jul 2026 14:54:44 +0800, raoxu wrote:
> The TSPCT lookup table is monotonically decreasing except for ADC code
> 121, where the sequence reads -9.0 C, -1.0 C, -12.0 C.  This makes the
> reported battery temperature jump upward by eight degrees for one code
> and then downward by eleven degrees for the next code.
> 
> The entry is a missing zero: use -10.0 C so the sequence remains
> monotonic between -9.0 C and -12.0 C.
> 
> [...]

Applied, thanks!

[1/1] power: supply: bq25890: fix the -10 C NTC lookup entry
      commit: 160a783aa65b74782bc17cb874af1a6d3f5fba3c

Best regards,
-- 
Sebastian Reichel <sebastian.reichel@collabora.com>

