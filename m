Received: from mail11.truemail.it (mail11.truemail.it [217.194.8.81])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 19F8729D288;
	Sun, 27 Sep 2026 14:37:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=217.194.8.81
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1790519875; cv=none; b=S4eLWs2sTzHhdqlZEmemG519URKPGGnb8fB/v/YUtNkh8loUBRsm++J/ioTCy1hsdchWmH0CjQ3/NY2DzgsCxsn5NX6FEHhxg0yC5ExYt3osn51/dTjaB8Nv5Lmw1ohIh3wPiVOK+fayDt+rA8Z6dmHLXSB/uz2nv9NB0ZCocJA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1790519875; c=relaxed/simple;
	bh=3kifUECnap8xTf1tSndDLZV6Gyt+fjzlJGi/q5QHSKU=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=QXaJoda3GLp0qf0EGhz6JPQaT4uPIlflBb13GZZdDVSTtYEjsDPsgEmKh3gUygxsjN6ln8mjFXNIkm0CtwCa9KJSzkKD+sSmphna3Rfkko+6XprreDGoC9H3ITw1yg91GF9QEPZOPR1PYLHlVD8riN6KN4OhcGVYSOGsfJ0XE3A=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=dolcini.it; spf=pass smtp.mailfrom=dolcini.it; dkim=pass (2048-bit key) header.d=dolcini.it header.i=@dolcini.it header.b=u/uk/hhm; arc=none smtp.client-ip=217.194.8.81
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=dolcini.it
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=dolcini.it
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=dolcini.it header.i=@dolcini.it header.b="u/uk/hhm"
Received: from francesco-nb (xcpe-178-82-167-143.dyn.res.sunrise.net [178.82.167.143])
	by mail11.truemail.it (Postfix) with ESMTPA id E72031F92B;
	Sun, 27 Sep 2026 16:37:48 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=dolcini.it;
	s=default; t=1790519869;
	bh=KMEiirLcdmzxclUk+A6aDUXj3pkkrLYqYUw4QNelmRk=; h=From:To:Subject;
	b=u/uk/hhmF+fA0GAC7eJcJOUjLS9OdjdqR9K5vWNptv+A8mob4mPk3jVq67IqZoW/c
	 hjGGWdd4SzE8vM24umDs8BAeXE/3BW1Q5tl6isgfp5TuF55VC1iTMWrbhCe9ntFa3l
	 tUI8OOgi6Mnb4MNEsGdl13MRMfb2fKMvOCHjqaNbgAdoqJZRsA8gzxAwVDjKFp/yGu
	 w7XRiaeEC9BZFmixnljEdsUVxvZP+EQ1ja++xWB3HTcGY9uq16a1u9vPEvwmWsQGs8
	 XvhAezA3wX6tGwh8Rv0wpWB0FJAqs7DDXlBHg3cS99RS5XFFq6JI0apF7qqHyoxTVy
	 mPqpmHEw9P0lA==
Date: Sun, 27 Sep 2026 16:37:45 +0200
From: Francesco Dolcini <francesco@dolcini.it>
To: Jiale Yao <yaojiale02@163.com>
Cc: Wei Fang <wei.fang@nxp.com>, Frank Li <frank.li@nxp.com>,
	Shenwei Wang <shenwei.wang@nxp.com>,
	Andrew Lunn <andrew+netdev@lunn.ch>,
	"David S. Miller" <davem@davemloft.net>,
	Eric Dumazet <edumazet@google.com>,
	Jakub Kicinski <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>,
	Fabio Estevam <fabio.estevam@freescale.com>, imx@lists.linux.dev,
	netdev@vger.kernel.org, linux-kernel@vger.kernel.org,
	stable@vger.kernel.org
Subject: Re: [PATCH 2/7] net: fec: manage the netdev lifetime with devres
Message-ID: <20260927143745.GA54546@francesco-nb>
References: <20260927111005.1035089-1-yaojiale02@163.com>
 <20260927111005.1035089-3-yaojiale02@163.com>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20260927111005.1035089-3-yaojiale02@163.com>

On Sun, Sep 27, 2026 at 07:09:59PM +0800, Jiale Yao wrote:
> fec_drv_remove() frees the netdev before devres releases the managed
> IRQs whose handlers use it as their data pointer. A late interrupt can
> therefore access the freed netdev.
> 
> Allocate the netdev with devres so that the later IRQ registrations are
> released first during teardown.
> 
> Fixes: 0d9b2ab1c376 ("fec: Use devm_request_irq()")
> 
remove the empty line, tags should be all together without any empty
line in-between. same applies to the other commits.
> Cc: stable@vger.kernel.org
> Signed-off-by: Jiale Yao <yaojiale02@163.com>

Francesco

