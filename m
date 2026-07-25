Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4D04831E845;
	Sat, 25 Jul 2026 16:35:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1784997332; cv=none; b=BV07Kpt0tQQNqAET5GVOMQGSKljKTnO0yHXZLL8ooCWSAR5ZbT+KZIwwun0MUYMn9vqKb2HE3FnwXD2EJp336ZmLGrpXFxdOpAlgfe7jSgQ7TFpBaxlg+mwrpisJ2gO2jtp/G/eMRDGyxw1vWXZ3JzoiNu3wChuPKoLGTG9wzoM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1784997332; c=relaxed/simple;
	bh=exmQsfyQGG/+MJh2nyZwkSJHOIFE90WzEqGKB1dq3IY=;
	h=From:To:Cc:In-Reply-To:References:Subject:Message-Id:Date:
	 MIME-Version:Content-Type; b=lQ3VsPhjBgcigXSXq0xjShzsMK4J5QixEg3bweRYkjG8O+UiEJn8l/rYIGupDQv86R0nKjUl20dGcmaMfyks61dsUBTDTweXL0M5QFjwxyFt1nxijVbN7XKstio5VjmzbC1Ibk7hrZ7TfHtPiKz65NKEjdVuz0H+hNyJ+oq3CqQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
Received: by smtp.kernel.org (Postfix) with ESMTPSA id C124D1F000E9;
	Sat, 25 Jul 2026 16:35:30 +0000 (UTC)
Received: by venus (Postfix, from userid 1000)
	id 1FEFC181F17; Sat, 25 Jul 2026 18:35:29 +0200 (CEST)
From: Sebastian Reichel <sebastian.reichel@collabora.com>
To: Chris Morgan <macromorgan@hotmail.com>, Mark Brown <broonie@kernel.org>, 
 Sebastian Reichel <sre@kernel.org>, Liam Girdwood <lgirdwood@gmail.com>, 
 Lee Jones <lee@kernel.org>, Alexey Charkov <alchark@flipper.net>
Cc: linux-kernel@vger.kernel.org, linux-pm@vger.kernel.org, 
 stable@vger.kernel.org
In-Reply-To: <20260603-bq25792-v7-0-d487bed276d0@flipper.net>
References: <20260603-bq25792-v7-0-d487bed276d0@flipper.net>
Subject: Re: (subset) [PATCH v7 0/7] Add support for the TI BQ25792 battery
 charger
Message-Id: <178499732910.781280.8061315305197638408.b4-ty@collabora.com>
Date: Sat, 25 Jul 2026 18:35:29 +0200
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
X-Mailer: b4 0.14.3


On Wed, 03 Jun 2026 00:10:48 +0400, Alexey Charkov wrote:
> This adds support for the TI BQ25792 battery charger, which is similar in
> overall logic to the BQ25703A, but has a different register layout and
> slightly different lower-level programming logic.
> 
> 

Applied, thanks!

[7/7] power: supply: bq257xx: Add support for BQ25792
      commit: 13cf94703737b4b9a6826987b46020df0642b1e0

Best regards,
-- 
Sebastian Reichel <sebastian.reichel@collabora.com>

