Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3A376476077;
	Fri, 24 Jul 2026 23:35:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1784936111; cv=none; b=e5TWeC/V+awztdZmVxI6iUloOXtjLocJ1kcJ9NtDHWpaNZ6FysykzcHqkLGIJegppPzKbvL+q87aqcsQ//SDrMrWYDiu18XUaFFtSoCqdoPWVPVBt6OTJSFnRfWjc70damFvJyFRaGXWHq8IX6vDnkVVa28VV0iwY0aEHe9ZQqw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1784936111; c=relaxed/simple;
	bh=Qj2nTkSluL249X7nwqr4NACalwjiffYld6sBcMZvZHM=;
	h=From:To:Cc:In-Reply-To:References:Subject:Message-Id:Date:
	 MIME-Version:Content-Type; b=mEXlP0xLC+Tr/RXZT2SYE4i5hDU0jB7SIJLuycj/+skkN9wd6Ges7KdcZBbctBVHobCgWPYa/IxlZDMNirmpLtvjwWsjEL8mXA5+O/a2fwcHgGGundxygOkX01L3qebvZNBrNeilApNJwODy6EAzgATpT8Yi+9CZ15ZpFPwx9As=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
Received: by smtp.kernel.org (Postfix) with ESMTPSA id BDC2D1F00A3E;
	Fri, 24 Jul 2026 23:35:09 +0000 (UTC)
Received: by venus (Postfix, from userid 1000)
	id 32512181F17; Sat, 25 Jul 2026 01:35:08 +0200 (CEST)
From: Sebastian Reichel <sebastian.reichel@collabora.com>
To: Sebastian Reichel <sre@kernel.org>, Fan Wu <fanwu01@zju.edu.cn>
Cc: Krzysztof Kozlowski <krzk@kernel.org>, 
 Anda-Maria Nicolae <anda-maria.nicolae@intel.com>, linux-pm@vger.kernel.org, 
 linux-kernel@vger.kernel.org, stable@vger.kernel.org
In-Reply-To: <20260723145352.8865-1-fanwu01@zju.edu.cn>
References: <20260723145352.8865-1-fanwu01@zju.edu.cn>
Subject: Re: [PATCH] power: supply: rt9455: quiesce delayed work before
 teardown
Message-Id: <178493610818.699463.15904937629305163281.b4-ty@collabora.com>
Date: Sat, 25 Jul 2026 01:35:08 +0200
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
X-Mailer: b4 0.14.3


On Thu, 23 Jul 2026 14:53:52 +0000, Fan Wu wrote:
> The threaded IRQ handler can queue pwr_rdy_work,
> max_charging_time_work and batt_presence_work.  pwr_rdy_work and
> batt_presence_work can also queue max_charging_time_work, while
> batt_presence_work can requeue itself.
> 
> rt9455_remove() cancels max_charging_time_work before
> batt_presence_work.  The latter can therefore queue
> max_charging_time_work after it has already been cancelled:
> 
> [...]

Applied, thanks!

[1/1] power: supply: rt9455: quiesce delayed work before teardown
      commit: 3e7a1ebc32fad5a558254a478efd401c17a24381

Best regards,
-- 
Sebastian Reichel <sebastian.reichel@collabora.com>

