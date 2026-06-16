Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 96D923D669A
	for <stable@vger.kernel.org>; Tue, 16 Jun 2026 17:48:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1781632104; cv=none; b=OTaeO9rimJHN8RxS22Qevrp6kgtfikKo5r9Tpk8uBc4gnEAe7BsgnSzPEndMbBhjcurKU3/DwjAi9qbJEPmMeOVd7rRkfQ7a4vwVnwWqAuIJjv+kCbOiqh7rfi3eLpW3K3QbBhjB7TSs5CTHSrkDeqHejOUunoFuvNnX+pHCQo4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1781632104; c=relaxed/simple;
	bh=03pf5/j3NaGgDKmpev630Mujf0qwm+ljLt88XRCabPg=;
	h=Date:From:To:Cc:Message-ID:In-Reply-To:References:Subject:
	 Mime-Version:Content-Type; b=QxSzNMhU/f0KVjRjTBX5Dpr5msaby7hIXStQNRbjNmT1CIbg40CSEFWDW/jDmsUuG3JxuGIltbyS1+4UtXsfvCYAt9Gy+84D3wWO2eSSB+8IIZV61MoHDsbzbxDWlhr43f/3RAwwtDcmw+P+Rb0QBZlSCHSw1x5MPlbnjZmQkXA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=m8JwMayz; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="m8JwMayz"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 1B8891F00A3A;
	Tue, 16 Jun 2026 17:48:23 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1781632103;
	bh=03pf5/j3NaGgDKmpev630Mujf0qwm+ljLt88XRCabPg=;
	h=Date:From:To:Cc:In-Reply-To:References:Subject;
	b=m8JwMayz7XbS6AU76PPInUfzXGpqSEoOrAZQKKOjS1CYAzO4mePH0twohOKuSg8IW
	 /xtIhZjUdI1BapUeTMFqAhgD+rZ03gUthTY47H7XXF5cYqucEFAGhYt/dAC0KU3KiK
	 oK4kNAdFfU52pdc2KPsQwtPLNutQ+s2xAyXN2LXKUxlVkFuue/01caCmVbPBkrmHNg
	 u+rrztweZuFPxVo/HSAH/hNPe1/qXIdXOx//f9JiGEyvoHCiLxQZ0jC1uBgmLSduS3
	 MlazOptH8Fu3tWU/h6hZlczWcOxTmccE9HPKwSVkco9txzOrWSCjaIqf1KqJ0D5Idb
	 tZafMN/sFgQqw==
Received: from phl-compute-05.internal (phl-compute-05.internal [10.202.2.45])
	by mailfauth.phl.internal (Postfix) with ESMTP id 63666F40069;
	Tue, 16 Jun 2026 13:48:22 -0400 (EDT)
Received: from phl-frontend-03 ([10.202.2.162])
  by phl-compute-05.internal (MEProxy); Tue, 16 Jun 2026 13:48:22 -0400
X-ME-Sender: <xms:Zowxav-WRym7mZvdypSw_zP1nfRRYZ2qCMN4Ml-QcZlu7o-549hrJQ>
    <xme:ZowxasIa2kt024t9ZG9CLxSoI4f6dtLFeB3d8NFMzoWE4TIH8arwmm3SQD208ckEm
    kz0HKQVjgqGC4pqxWZrOzXhY_AGhfgcA9MaABeVMcSrMKcbEQ1RlqA>
X-ME-Received: <xmr:Zowxatusxu-KGL93NBz5xUj-7M_XlPBAD2-VxnKMsxOQny6SLisNCISUkq-DtSQ9rTJfM4EFPqPo_3mqNBZHyVWQjSDQoGSRYV0>
X-ME-Proxy-Cause: dmFkZTGLmkz7uKr1nHdeJCfWh26WhHA9wRCkSRVB2EW4+YwAPQJy0tDPAsb9w6mSto6Jim
    TXmhtVARgz9dZ/kbZ+Jy2KdgKFNFpzrhDZL2s4xVNrdL1o9U7eg0H7TU4RXgeKZL7zkTSi
    12hL/sUfmr+CQdS/LxNmft5WEYWHX7RZKzbPZU76k0LIXxcKUa2E8Ydg+3zl7w6+8gwX5a
    FD4BcxHlEj8Ul+sPnmaIFwIOml6bwduMOi5D3Qp6hjmjaaA0YBZ3A5QD8GOSc/zpOV04OB
    NupRapVJwdbyqeig+p+3mE+TaSOTPzdhaRIGO4n23T3ik2jjdjkQYmCS2D2PZ+XK/DT8nP
    CnNKswe5fuJKDBXEhnuQICuPAezf1l00yhkHiurqK3KdvXmS8u+IZQ1jF7kjzygfo3BNo+
    hIHWpGSlAcPMP/TWBpAtb8bMTwJ+UvjqUOvngcZP7Me0JlG8P2ob2fLnttpgKirkHN235n
    4OA84mYLT4ZtuYUeCgC7w1FVnKyJACWws35BuvNoPCdNpqFY4/mHMbd+KJzJzDdSz4zS2d
    hAFCn8R+kCrRduBGqMEwq4ORLPMVIi0lAGXI0e2AmBwkDVwJYI63yLN+VA4x3GcPKSGucb
    txZaSlTIxYCn75wMI9nIrRS7105rTtpR1XwgzRTdrQK9VUyVMoWO0tcX0wCg
X-ME-Proxy: <xmx:ZowxajBClFL0e6_36FaVBfo7oOUNnswe1IpjkP4wThk4KzMQ9eibkQ>
    <xmx:ZowxalOHfXRcwccotzowQIQI94wc_MKL1JDotQDVXv3dowDj3M7gFg>
    <xmx:ZowxarAxAEwqsjnfnBBo67Y_8tb6kVrwRh7exAm45gC5G44ay6vXEg>
    <xmx:Zowxau4fF1OCFhnWlg5mNwzjZ-fJyKEMuc7RU5JTEfzwofWN3WL-Mg>
    <xmx:Zowxat7j8tMmKqs6WUzbfQw65KGXbeuSJEDiwFoWEZTtZTMXq7deQ3kC>
Feedback-ID: i67ae4b3e:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Tue,
 16 Jun 2026 13:48:21 -0400 (EDT)
Date: Tue, 16 Jun 2026 10:48:21 -0700
From: "Dan Williams (nvidia)" <djbw@kernel.org>
To: Dave Jiang <dave.jiang@intel.com>, 
 linux-cxl@vger.kernel.org
Cc: djbw@kernel.org, 
 dave@stgolabs.net, 
 jic23@kernel.org, 
 alison.schofield@intel.com, 
 vishal.l.verma@intel.com, 
 flavien@nus.edu.sg, 
 stable@vger.kernel.org
Message-ID: <6a318c65234a_199fc4100d4@djbw-dev.notmuch>
In-Reply-To: <20260616004007.4186004-3-dave.jiang@intel.com>
References: <20260616004007.4186004-1-dave.jiang@intel.com>
 <20260616004007.4186004-3-dave.jiang@intel.com>
Subject: Re: [PATCH 2/2] cxl/mce: Serialize the MCE handler against endpoint
 teardown
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
Content-Type: text/plain;
 charset=utf-8
Content-Transfer-Encoding: 7bit

Dave Jiang wrote:
> CXL endpoint has a shorter lifetime than CXL memdev state (mds) and
> the MCE notifier is part of the mds. The MCE handler needs to take
> a reference on the endpoint in order to keep it alive while operating
> on it. Take the cxlmd lock to verify the endpoint is still valid and
> take a reference on it before accessing it.

The only way to synchronize against the removal of cxlmd would be to
lock its parent device which is moving in the wrong direction.

This lifetime problem disappears with a region-relative mce
notification.
