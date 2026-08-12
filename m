Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id F38EE43F0BD;
	Wed, 12 Aug 2026 22:23:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1786573434; cv=none; b=Z2gqR0hBiSgKAo8KFzTSNEs6aVljyg2OYD6xTAHR+XGcTUdeeBvotWeaWqaVnevDrzkj/0NMwWXaW3hiMSKVbJS2AFoQOJORVHNIUVZLxc8dfF5HUcHSx5SUrldN+Aonp1kDGKE2UH+EBZPYMtOiF8pzTi7xWXiVffKdlv4PkUQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1786573434; c=relaxed/simple;
	bh=c3kKe3HlUCLraM/NwW8wcnA351tRY4SIRYfyVWLBseU=;
	h=From:To:Cc:In-Reply-To:References:Subject:Message-Id:Date:
	 MIME-Version:Content-Type; b=HRUQ3M3fw3GA+dvs71A0PZGRp706onFonINHeH2etSMJHwB/+B2CL/jn8skfCRHmwbVtPbxuUjkB3IdQgCVGXcRHWTbffHqsY/XtZfuF1TWMDZ04XuoyxGdJq7GecTnVwOV9mT7qgLJAr6aEngWwN0Ygtrosd3KVpkUrprd9SqM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 9C2761F00A3D;
	Wed, 12 Aug 2026 22:23:52 +0000 (UTC)
Received: by venus (Postfix, from userid 1000)
	id 8A98C1830B3; Thu, 13 Aug 2026 00:23:50 +0200 (CEST)
From: Sebastian Reichel <sebastian.reichel@collabora.com>
To: linux-pm@vger.kernel.org, Fan Wu <fanwu01@zju.edu.cn>
Cc: sre@kernel.org, r-rivera-matos@ti.com, linux-kernel@vger.kernel.org, 
 stable@vger.kernel.org
In-Reply-To: <20260804145511.103470-1-fanwu01@zju.edu.cn>
References: <20260804145511.103470-1-fanwu01@zju.edu.cn>
Subject: Re: [PATCH] power: supply: bq256xx: drain usb_work before freeing
 the charger
Message-Id: <178657343055.347615.13631525717125029923.b4-ty@b4>
Date: Thu, 13 Aug 2026 00:23:50 +0200
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
X-Mailer: b4 0.15.2


On Tue, 04 Aug 2026 14:55:11 +0000, Fan Wu wrote:
> The USB-PHY notifier queues usb_work, whose handler calls
> power_supply_changed(bq->charger). The reset devm action only unregisters
> the notifier and was registered before the power supplies, so devm frees
> bq->charger on unwind before the action runs; a usb_work still queued can
> then dereference it.
> 
> Register the reset action after the power supplies, so it unregisters
> the notifiers and drains usb_work before the supplies are released.
> Initialize usb_work and obtain the PHY references before registering
> the notifiers, so the worker cannot run before the supplies exist.
> 
> [...]

Applied, thanks!

[1/1] power: supply: bq256xx: drain usb_work before freeing the charger
      commit: 2dd6cd823777bea6d9a880a12a92a73ec76aee0b

Best regards,
-- 
Sebastian Reichel <sebastian.reichel@collabora.com>

