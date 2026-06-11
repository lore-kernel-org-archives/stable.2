Received: from mail11.truemail.it (mail11.truemail.it [217.194.8.81])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 00C6D2EF64F;
	Thu, 11 Jun 2026 08:53:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=217.194.8.81
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1781168037; cv=none; b=oKJvqOzl1i0AI+d4PmWg0+M5z8VUi8H1DJNkpjLK4xv+hAJEqWCodo/siMThww3i67c2Euhg8Zr+IUQXgUSeqhjogo4EJGIAXps4YudF1GYNo7giLjc63+s681cZ4H2o3HkKNTy3cVq8nyUE8tWg5vO5QsL2yNuJo20+OhcbuzI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1781168037; c=relaxed/simple;
	bh=tfTwCjfLpFULPT9+zPuv67P5JPu6VZn0x12UyuJx9Qs=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=CPZHrlNlqe/QrfDz7VDsDbe50f5I6nVr8cwN8jxwJLfI3sjayx0523QXn5BTLmQ4hVkyB60EC9GCCyVY5dOq3/5qKp3ZwCgA6lUhHZrcKMfxyMG5PIPaxhGoqR++LpivRWUSy3//h6FxiI8UGN0IQgs7MuiIFtbvpaLmgmatWGo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=dolcini.it; spf=pass smtp.mailfrom=dolcini.it; dkim=pass (2048-bit key) header.d=dolcini.it header.i=@dolcini.it header.b=Fx1YMl6k; arc=none smtp.client-ip=217.194.8.81
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=dolcini.it
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=dolcini.it
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=dolcini.it header.i=@dolcini.it header.b="Fx1YMl6k"
Received: from francesco-nb (93-49-2-63.ip317.fastwebnet.it [93.49.2.63])
	by mail11.truemail.it (Postfix) with ESMTPA id C324A206E9;
	Thu, 11 Jun 2026 10:53:44 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=dolcini.it;
	s=default; t=1781168025;
	bh=AP4k7vCpcWzwbhiQECe8xTnolNKqf91FVaQ4lTLkXlY=; h=From:To:Subject;
	b=Fx1YMl6kKbhJyCJ9Fi4A74unJnCFnnNIFgu8KAJ5y+IXnveaQQavA4yoaphen8NNN
	 3ED9oQ6kPAPzEZDeGcxsjUAfyqaR2VCmtRe4NbniG4OByw1QGK2F/zmvhb+PHJdU/F
	 2+cVpZSluPBGqiCk/4t7PRpd8c8G0pUnKtWTG8NN9npn2fbehQPVvoXVovufq+UeNY
	 f6cTG4kUy3HCPYz0kmQ1IJckKELBjR5SpmiRWeB7uTaaTfX9qWZ+L1E8hjz9aKvsh2
	 TgKBPhRLO4a5XLT6UugJqSxCZv2uJ7JDkDQxxsYEI4lgO4y6vt3VefXLmSd3+eCjP3
	 0jlXFvnSLjZPA==
Date: Thu, 11 Jun 2026 10:53:43 +0200
From: Francesco Dolcini <francesco@dolcini.it>
To: Rafael Beims <rafael@beims.me>
Cc: Brian Norris <briannorris@chromium.org>,
	Francesco Dolcini <francesco@dolcini.it>,
	Rafael Beims <rafael.beims@toradex.com>,
	linux-wireless@vger.kernel.org, linux-kernel@vger.kernel.org,
	Jeff Chen <jeff.chen_1@nxp.com>, stable@vger.kernel.org
Subject: Re: [PATCH] wifi: mwifiex: fix roaming to different channel in
 host_mlme mode
Message-ID: <20260611085343.GB6993@francesco-nb>
References: <20260610150021.1018611-1-rafael@beims.me>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20260610150021.1018611-1-rafael@beims.me>

On Wed, Jun 10, 2026 at 12:00:18PM -0300, Rafael Beims wrote:
> From: Rafael Beims <rafael.beims@toradex.com>
> 
> When host MLME is enabled, mwifiex_cfg80211_authenticate() transmits the
> authentication frame on a remain-on-channel (ROC) reservation so that the
> frame is sent on the target BSS's channel. The ROC is only configured
> when priv->auth_flag is zero.

...

> 
> Fixes: 36995892c271 ("wifi: mwifiex: add host mlme for client mode")
> Cc: stable@vger.kernel.org
> Assisted-by: Claude:claude-opus-4-7
> Signed-off-by: Rafael Beims <rafael.beims@toradex.com>

Reviewed-by: Francesco Dolcini <francesco.dolcini@toradex.com>

