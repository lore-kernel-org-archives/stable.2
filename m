Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BF645476CED;
	Fri, 24 Jul 2026 23:35:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1784936112; cv=none; b=MAHzEiEPncPHwug2+pJuqDFkqZgmSSBLdxd8goMSGFhRQhIuy6AaNneZDH5rtpFfwdw0rGW+EbwINHAMKlQqs+MwOLYTfwmlN7khYhoLMGcrW5vc3gWQg4Rmi9b6cDg5o2CiBzsrld6OS/yjGQjF1v6dj0zUlZtSomAe2XeZd6o=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1784936112; c=relaxed/simple;
	bh=uDrn2R2mkAuGs1LhWSbHAGfwfIRWbEWZ8mDMLmG0lSE=;
	h=From:To:Cc:In-Reply-To:References:Subject:Message-Id:Date:
	 MIME-Version:Content-Type; b=T/J4cZA5Rc+93+m9JxwK3wk3gSsgmhdlsmn3OsSAXvNkZTZ45aahOZ9LBjYqOBdPYPGbIc1ntOyLWuZmsP78oo8n/ENzvxt860aPuwzvpa5hqRR9mrFIOw35kOLn7tfJwZa34FAV+IYBZRJSz5GFCK7InQZiRIjqbUCM8VCebfk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 770B21F000E9;
	Fri, 24 Jul 2026 23:35:11 +0000 (UTC)
Received: by venus (Postfix, from userid 1000)
	id 982B7181F1D; Sat, 25 Jul 2026 01:35:08 +0200 (CEST)
From: Sebastian Reichel <sebastian.reichel@collabora.com>
To: samkay014@gmail.com, raoxu <raoxu@uniontech.com>
Cc: sre@kernel.org, imx@lists.linux.dev, linux-pm@vger.kernel.org, 
 linux-kernel@vger.kernel.org, stable@vger.kernel.org
In-Reply-To: <097F0559A936ACCB+20260724095437.368905-1-raoxu@uniontech.com>
References: <097F0559A936ACCB+20260724095437.368905-1-raoxu@uniontech.com>
Subject: Re: [PATCH v2] power: supply: pf1550: enable charging when battery
 profile exists
Message-Id: <178493610861.699463.14451805512367862305.b4-ty@collabora.com>
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


On Fri, 24 Jul 2026 17:54:37 +0800, raoxu wrote:
> PF1550 starts in charger mode 1, where charging is disabled. The driver
> comment says that mode 2 should be selected for applications using a
> battery, but the condition is inverted: PF1550_CHG_BAT_ON is written only
> when power_supply_get_battery_info() fails.
> 
> Consequently, a board with a valid monitored-battery profile is left in
> the default charger-off mode, while a board without battery information
> enables charging with fallback settings.
> 
> [...]

Applied, thanks!

[1/1] power: supply: pf1550: enable charging when battery profile exists
      commit: af4ee48a09cfb7a2440cc4822e9fda43a76cfbe5

Best regards,
-- 
Sebastian Reichel <sebastian.reichel@collabora.com>

