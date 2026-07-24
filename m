Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0E7D9476687;
	Fri, 24 Jul 2026 23:35:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1784936111; cv=none; b=bCArWMyDWwl3vwaVBVg7bYAkw0zDS4kcvMlyCFfjKDxg+SiRv/Jm+600/B8PLrOON7ykXfM6gGABlXMmdIwiVbAxM+DHoyGpV4xQ42O+Mjjdw6aLHPW1KU++P28dmz/rv/mP146hxflxuJAWZWSI9juVcxttqBqQrhTcYFrhSTs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1784936111; c=relaxed/simple;
	bh=Relf9wOLoDvsQs+jCPbow1FCU1Rn/1Gqyd7QqC6w+K4=;
	h=From:To:Cc:In-Reply-To:References:Subject:Message-Id:Date:
	 MIME-Version:Content-Type; b=VgRh5S3xZNgLD8DN69/B5cHa9TJt2EPxP3tAPOR4c/zP6Jm0NxfP1EpQa+Ymx3MeYwsYnvgEZ7RG/GUqWz9THVG2O4BCWFuyPNVNFdAGokHL94mEBh1lnwTT6ipDZxGwFEir+eORZYixWgwMo7PVVvQ46Bf87cKBOivHzOsNLc4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
Received: by smtp.kernel.org (Postfix) with ESMTPSA id BA13A1F00A3A;
	Fri, 24 Jul 2026 23:35:09 +0000 (UTC)
Received: by venus (Postfix, from userid 1000)
	id 3D74F181F1B; Sat, 25 Jul 2026 01:35:08 +0200 (CEST)
From: Sebastian Reichel <sebastian.reichel@collabora.com>
To: Sebastian Reichel <sre@kernel.org>, Fan Wu <fanwu01@zju.edu.cn>
Cc: Krzysztof Kozlowski <krzk@kernel.org>, 
 Anda-Maria Nicolae <anda-maria.nicolae@intel.com>, linux-pm@vger.kernel.org, 
 linux-kernel@vger.kernel.org, stable@vger.kernel.org
In-Reply-To: <20260723225310.12663-1-fanwu01@zju.edu.cn>
References: <20260723145352.8865-1-fanwu01@zju.edu.cn>
 <20260723225310.12663-1-fanwu01@zju.edu.cn>
Subject: Re: [PATCH v2] power: supply: rt9455: quiesce delayed work before
 teardown
Message-Id: <178493610824.699463.10361691120520467758.b4-ty@collabora.com>
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


On Thu, 23 Jul 2026 22:53:10 +0000, Fan Wu wrote:
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

