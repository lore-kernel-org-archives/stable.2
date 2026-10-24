Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=100.103.45.18
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1792872693;
	b=RFcfYuC2s27hRiTt1HHTCJUeBcMdZeAI10soXswaIOR14X6Q9M93//K+4I0XB96D5zId
	 h0KWbDlXGdDeq+YydaqW+0+39xY9vJp61F5O2KI5oWS4wOCwsgCr0/jEE7o7CUHp2OED6
	 LtPuxBavUPSs7gLfbNpKwooWlsJLNYrnw6Vs0oo+h6qBhzl3k9XbEQSGSWL7Nue/eJ5/u
	 qWTfCcCU+mMVJLHb0P2MJE+2XAE0j+XNTt9axjMUcqEiyr1+c63bc3ZrII85vow3QEwHV
	 qRkm59tGs43uTMlQw08jnyTs5EOAvuwMxBKoLdbEEig0LS19QSjieUEt+2VGeij81NQ==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1792872693;
	h=Received:DKIM-Signature:From:To:Cc:Subject:Date:Message-ID:X-Mailer:
	 In-Reply-To:References:MIME-Version:Content-Transfer-Encoding;
	bh=vxFGTwlGQDDEqXJl1k086dE/QU091vyZ+i82JDaxiEs=;
	b=c1+uYzenPgjLJHgwVU0Td+5Px9fVJu/nRdSdyUt0EShzHKHKcDIWQ9Kk/XLiBFQfFIoR
	 +JuxKUkvuRkqXy9gFF5Zb/oUiwJQp7xiP5BnoVRA+EduPS6pDSGmUmVdHvuFtK+mjW9lb
	 QjcyPk1SN9b5R79fUBN/RUxI/UsLfBgJbRGqKpXSGHfXz2iSzlqsgmJ9g6inQyZzOGxAX
	 9RbMSgmo/jeMjXuM7GfaosvN1LCo/ECxavnj4jDj9sBAGI+M2/Gl+Fy4F5CseLKqKPqDn
	 lxYqYges5ms04isGsQDZKjxxpOySJqncV+caMBhhijpztgs757589qHOdmXjQZy89xg==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dkim=pass header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=DirlZVDP;
	arc=none smtp.remote-ip=100.103.45.18
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A3782606A324;
	Sat, 24 Oct 2026 20:11:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=DirlZVDP
Received: by smtp.kernel.org (Postfix) with ESMTPSA id A8AA51F031E0;
	Sat, 24 Oct 2026 20:11:32 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1792872693;
	bh=vxFGTwlGQDDEqXJl1k086dE/QU091vyZ+i82JDaxiEs=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References;
	b=DirlZVDP6VXe6rtLLy9pGxK7/CuX6QiB37oidMI30zbjCl29YQhcq6m3eF5VaoZ3Y
	 MFr/4q6ykEbdJNGCkbS42fhFd39ga+f1AZwOevCj+7/GM4ChUYeBK+zroNN7YgCWjr
	 Hgobk46KLqtni+KM4n8AD9hnDOB5mcp6N8SDRMEhwfdELoh1flEjHZDVf5bCr3N0nl
	 7CYKLTZ4d4PwwgDZ53wrAO4mOYMCkg1vmx/UNa9sFYbrhE+vd2paggYCSjHqCEA5vH
	 Vu6T15V5X4ebYH7FirYs16+mqMLOVbQOunUEb7K0tQN0sCZpdzH4Mvk50wzyzYd0GN
	 Nd0hPkZzswCfQ==
From: Sasha Levin <sashal@kernel.org>
To: stable@vger.kernel.org
Cc: Sasha Levin <sashal@kernel.org>,
	Ido Schimmel <idosch@nvidia.com>,
	Nikolay Aleksandrov <razor@blackwall.org>,
	bridge@lists.linux.dev,
	Steffen Pfendtner <steffen.pfendtner@kernelscan.io>
Subject: Re: [PATCH 5.15.y] bridge: mcast: Fix use-after-free during router port configuration
Date: Sat, 24 Oct 2026 16:11:06 -0400
Message-ID: <2026-10-24-1-daily-reply-0008-bridge-mcast-router-port-uaf-5-15@kernel.org>
X-Mailer: git-send-email 2.53.0
In-Reply-To: <20261024110929.47253-1-steffen.pfendtner@kernelscan.io>
References: <20261024110929.47253-1-steffen.pfendtner@kernelscan.io>
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Post: <mailto:stable@vger.kernel.org>
List-Help: <mailto:stable+help@vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
List-Owner: <mailto:stable+owner@vger.kernel.org>
Precedence: list
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

> The bridge maintains a global list of ports behind which a multicast
> router resides. The list is consulted during forwarding to ensure
> multicast packets are forwarded to these ports even if the ports are not
> member in the matching MDB entry.

Queued for 5.15, thanks.

-- 
Thanks,
Sasha
