Received: from mail11.truemail.it (mail11.truemail.it [217.194.8.81])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 79EDE3DA7E0;
	Mon, 15 Jun 2026 09:30:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=217.194.8.81
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1781515834; cv=none; b=F+5cadVnxhppeuOYL7Chv7HS1EP3PJIMSB/p6ZXokeww2EhgjAzxbrtHULdJaIOkCcvJLacqVz+uubXZG28PfsdgaYNThxypLtY9tz0zveS0xX4sil5xGFg22LFGGG+eJDBHIM65r3m+V3P/B4w9CzE2e2YbLsFRgWmIUq1HFj0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1781515834; c=relaxed/simple;
	bh=GEf1YDjpAHEtO/q/nECZh0WjUGBhL+tXiu7TmbhkuPk=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=HdubvuDpqyL6LNcG8bauS/8AhO6rSuBeP2gJbj79f86QWdMNfF3d4p3ysnLmDcF7qkIabkTuLYWqFZLP3C2b1Q0JQqfZQHb1/6cCQqEdsH9w1qpndnrLtFdx9sI0Ccpg9+p7tFC8s0W94+NrOzwCk+CjhZpHl10zfEldpHHSnTQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=dolcini.it; spf=pass smtp.mailfrom=dolcini.it; dkim=pass (2048-bit key) header.d=dolcini.it header.i=@dolcini.it header.b=a+1Z5x/d; arc=none smtp.client-ip=217.194.8.81
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=dolcini.it
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=dolcini.it
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=dolcini.it header.i=@dolcini.it header.b="a+1Z5x/d"
Received: from francesco-nb (248.201.173.83.static.wline.lns.sme.cust.swisscom.ch [83.173.201.248])
	by mail11.truemail.it (Postfix) with ESMTPA id 3B1291F91B;
	Mon, 15 Jun 2026 11:30:20 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=dolcini.it;
	s=default; t=1781515820;
	bh=pCp36q52TfHBlGuY3sWDp8g2g42BeaTmVWH1Cfy0fWw=; h=From:To:Subject;
	b=a+1Z5x/dzCYyPOKIUSgLeqRCcu8yYL0AngGL0uP0jzGDCwa9yjGLfRfEoDblH2mbS
	 WnSJ8g0W8k5ai9c5Do7QtI0cZKpz7aaoJAMX47VNwTNpVYw1geAKaGVN468av/ST8Q
	 QFm/GC1YqeXIwL0KWbLVEv+UvK4xmfgIrq3s3QcxPNan0MlvWGAgZZWYsypp2lNEP5
	 NmXPVh4nd0L74bTybnV++JaOYW+JPLwLcQUs7rh2POL1Lf2m2zRRzjb0qyAeCheUHi
	 NVkyxMsKanaY1y1lDzUxiqAt+pDYq/ipm7ITNh6WLhumdMunpKcG/bVw1Vx58ddH/2
	 zznuiHsOlAXsw==
Date: Mon, 15 Jun 2026 11:30:16 +0200
From: Francesco Dolcini <francesco@dolcini.it>
To: Jeff Chen <jeff.chen_1@nxp.com>
Cc: Rafael Beims <rafael@beims.me>, Brian Norris <briannorris@chromium.org>,
	Francesco Dolcini <francesco@dolcini.it>,
	Rafael Beims <rafael.beims@toradex.com>,
	linux-wireless@vger.kernel.org, linux-kernel@vger.kernel.org,
	stable@vger.kernel.org
Subject: Re: [PATCH wireless-next v1] wifi: mwifiex: fix permanently busy
 scans after multiple roam iterations
Message-ID: <20260615093016.GA6878@francesco-nb>
References: <20260612122547.1586872-2-rafael@beims.me>
 <ai+tqAb/kCkwbh7l@nxpwireless-Inspiron-14-Plus-7440>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <ai+tqAb/kCkwbh7l@nxpwireless-Inspiron-14-Plus-7440>

On Mon, Jun 15, 2026 at 03:45:44PM +0800, Jeff Chen wrote:
> On Fri, Jun 12, 2026 at 09:25:46 AM -0300, Rafael Beims wrote:
> > From: Rafael Beims <rafael.beims@toradex.com>
> > 
> > 
> > After testing on both IW412 and W8997, I could only trigger the bug on
> 
> I don't think there's an IW412 in NXP's lineup — did you mean IW416?

Yes, I can confirm it is IW416.

The commit message should be fixed.

Francesco

