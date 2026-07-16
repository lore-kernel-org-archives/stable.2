Received: from mail11.truemail.it (mail11.truemail.it [217.194.8.81])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C3DE23CDBD3;
	Thu, 16 Jul 2026 09:00:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=217.194.8.81
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1784192413; cv=none; b=n/oVL0eBnl1yCrccuKKevLTVL7ysUos0ttrB+4BC6XFPOgMkwJJJvSCTwFvCQUdrYS0SuyuODcsVgWHeHpz9BFT6TjyQSlWIuu/dcKr6HRhguJab6lgYvdtVzE6j7dTPOKw3BPV4OHjB9EWOEXSHfexUqhqQyAzpSUHwOE8I1D4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1784192413; c=relaxed/simple;
	bh=fAISxBfCHu/Lz8kZZfFWQ1ZNu8lOMfcH8TVMQdRNR8Q=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=i2Yvuo7iWWOrUXyBw/uhw1Vlp7PYjhBeWP860o/FR/MQ6rpjvDIeA63A8qSeBMlbFK8/obzPuYWQRYMxh0PpZMjuw0cmg82Qxp84amQKkjXjnvImthBra8MQyfQZKVBXzdjp36LQDJi0tKogtjH9vesXkAYvbIystf82rqt4Vws=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=dolcini.it; spf=pass smtp.mailfrom=dolcini.it; dkim=pass (2048-bit key) header.d=dolcini.it header.i=@dolcini.it header.b=noNfZIRr; arc=none smtp.client-ip=217.194.8.81
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=dolcini.it
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=dolcini.it
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=dolcini.it header.i=@dolcini.it header.b="noNfZIRr"
Received: from francesco-nb (xcpe-178-82-120-96.dyn.res.sunrise.net [178.82.120.96])
	by mail11.truemail.it (Postfix) with ESMTPA id B7B3622911;
	Thu, 16 Jul 2026 11:00:02 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=dolcini.it;
	s=default; t=1784192403;
	bh=fAISxBfCHu/Lz8kZZfFWQ1ZNu8lOMfcH8TVMQdRNR8Q=; h=From:To:Subject;
	b=noNfZIRrl2EwUPWE+pRvyCJsUMmppBVJ6mn93bd5MiIqrovXApk6Jp1OJyxqPcONQ
	 PIanDY0+JlqiRRidr1i4pFfpHcUdrkZ/QrwOBM7qokFn6wpps7OAE+ppAlOZi6uizj
	 AM/V00dRl8Yh5kMmP7lQdETeirdkjgUQt5rJb+bkJsrIKA0yrtFlZohhIdgvNjgIOs
	 /eD0Nctx9kzmwQhFlg36ubqtg9+ha//n5126M8PGsT2j+Zqx+ncBRM55VeCu/vE63o
	 lsYGPWSFfLwOPmLN4f5+2PQwXE1XAigfXGJMLWvSO9u5+NgFiq/M3qTBBrbiDHI0V6
	 q7C46gT2SFf7A==
Date: Thu, 16 Jul 2026 10:59:59 +0200
From: Francesco Dolcini <francesco@dolcini.it>
To: George Valkov <gvalkov@gmail.com>
Cc: Francesco Dolcini <francesco@dolcini.it>, johannes.berg@intel.com,
	Dan Carpenter <error27@gmail.com>, briannorris@chromium.org,
	s.kerkmann@pengutronix.de, kees@kernel.org,
	linux-wireless@vger.kernel.org, linux-kernel@vger.kernel.org,
	stable@vger.kernel.org
Subject: Re: [PATCH] wifi: mwifiex: fix freeze for 60 seconds caused by
 request_firmware
Message-ID: <20260716085942.GA99146@francesco-nb>
References: <20260712221709.7099-1-gvalkov@gmail.com>
 <20260715145228.GG56330@francesco-nb>
 <CADOrJmYwYs08REP3eSwiTQegcKHFLwW0gpUexhomLDtO91ASMA@mail.gmail.com>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <CADOrJmYwYs08REP3eSwiTQegcKHFLwW0gpUexhomLDtO91ASMA@mail.gmail.com>

On Thu, Jul 16, 2026 at 11:26:54AM +0300, George Valkov wrote:
> Please backport to 6.18 and 6.12, which are used by OpenWrt.
> Initially I did not know that I could insert
> free text between the commit message and the patch.
> I apologise for that. I am still learning how to use git send-mail.

Please see Documentation/process/stable-kernel-rules.rst
It should explain everything you need on this regard.

Francesco

