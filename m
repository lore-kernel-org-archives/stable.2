Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=217.140.110.172
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1794585826;
	b=qkzqiCYo+byTjeBDJaakZpnah+zAVVW9cDpL8OOrvmYP5aix/+5G/w3nIDt5Y9RH6kZ8
	 ic2PhOQHJC0BzwXNrnU8aIv9XTbUGnjbLzb4c4/hKkLM31VngnPU1laUaQlZtE/Gp6PLY
	 8eJmfEDKym9xPV0kDc8jg1xwrWAMuen6hMx8LHoW5uEOMQACz5mFytv/NL2hDXF3kTEih
	 +O7EUDGXdflSmXg+NtV8cXrkE38Pg/CtV6Pua/Cnr+6rbh1JqUZ6FrR/P2Z6G4Bk0r+be
	 DMAmTyUpgFrJ9HM5r1KoZt2/Q1Y3j73MtjnuBcynyoFv2hrchKXAFyUeRRwPBD17Pbw==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1794585826;
	h=DMARC-Filter:Received:Received:DKIM-Signature:Date:From:To:Cc:
	 Subject:Message-ID:References:MIME-Version:Content-Type:
	 Content-Disposition:In-Reply-To;
	bh=oIe8tsNYDsRzQFg3J2rpKh8+KY+zb5Wykm4LdjiH/U8=;
	b=L037sfTHNzRThOizT7GnIqPJ/Jgl4lT6IywfGMepcQT6+bzOZi4+AqRSQb7HBXWq7LQH
	 hZGnzQQAR3VcZcZ27IRwCQjzwUE805531pOn9wtuNtp3TDTt6ObbcWRwIqpE+KG0k/se7
	 HwWJBh5i6msnuIpLhlr8QOftHAILtX8jV2I7cFcBs2qUGnnyknVLjQTu8fXlGXf/D2Swf
	 aTMeDsLjrWzibsJIFnTTwNPqnyl5IJM/cvJ7UighBX/E3SfrRy7i9wD4zqWx0lkuzFD2w
	 4wkrlq8vsIW9/8TNHeDcAkUPytO9Y7t4JHvoit4wgqfCgZwWNsp5nvQpyUU0FOsIm3w==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=arm.com;
	spf=pass smtp.mailfrom=arm.com;
	dkim=pass header.d=arm.com header.i=@arm.com header.a=rsa-sha256 header.s=foss header.b=rHAkUWbn;
	arc=none smtp.remote-ip=217.140.110.172
Received: from foss.arm.com (foss.arm.com [217.140.110.172])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 898F2606BAA6;
	Fri, 13 Nov 2026 16:03:46 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 898F2606BAA6
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=arm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=arm.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=arm.com header.i=@arm.com header.a=rsa-sha256 header.s=foss header.b=rHAkUWbn
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
	by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id DB8991516;
	Fri, 13 Nov 2026 08:03:42 -0800 (PST)
Received: from pluto (usa-sjc-mx-foss1.foss.arm.com [172.31.20.19])
	by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPSA id 9667A3F673;
	Fri, 13 Nov 2026 08:03:44 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple; d=arm.com; s=foss;
	t=1794585825; bh=oIe8tsNYDsRzQFg3J2rpKh8+KY+zb5Wykm4LdjiH/U8=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=rHAkUWbnsG87EaSsWRJnZUOiwdJFcWBWAMR/bFBo7N1n8fxIbeFiGIn4wQWmOGNzK
	 bHV9z02MXIuwXuOXvZOGvlTKDTw51Mzcardv1ryWXIAwbST7id1sjLaVJTfsfS2LLX
	 q1ACZXW9TtK8/xORwMhIWasFJlJxW2eTJqbOeGmQ=
Date: Fri, 13 Nov 2026 16:03:37 +0000
From: Cristian Marussi <cristian.marussi@arm.com>
To: Guangshuo Li <liguangshuo@mail.sdu.edu.cn>
Cc: Sudeep Holla <sudeep.holla@kernel.org>,
	Cristian Marussi <cristian.marussi@arm.com>,
	"Rafael J. Wysocki" <rafael@kernel.org>, arm-scmi@vger.kernel.org,
	linux-arm-kernel@lists.infradead.org, linux-pm@vger.kernel.org,
	linux-kernel@vger.kernel.org, stable@vger.kernel.org
Subject: Re: [PATCH] powercap: arm_scmi: Fix potential stale zones after a
 skipped leaf
Message-ID: <avc02U7K7mXG0PDZ@pluto>
References: <20261113-4e14e563a1-powercap-scmi@mail.sdu.edu.cn>
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Post: <mailto:stable@vger.kernel.org>
List-Help: <mailto:stable+help@vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
List-Owner: <mailto:stable+owner@vger.kernel.org>
Precedence: list
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20261113-4e14e563a1-powercap-scmi@mail.sdu.edu.cn>

On Fri, Nov 13, 2026 at 10:09:35PM +0800, Guangshuo Li wrote:
> scmi_zones_register() skips leaf zones that cannot be registered, but
> returns the last leaf error when that leaf ends the traversal. Probe
> then fails without unregistering the successfully registered zones,
> whose private data is device-managed.

LGTM.
Reviewed-by: Cristian Marussi <cristian.marussi@arm.com>

Thanks,
Cristian
