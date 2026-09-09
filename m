Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9B8DC559CB3;
	Wed,  9 Sep 2026 20:49:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1788986994; cv=none; b=jU++mOTvmHjWmPIjAeB1OpHwhapJzUnUYb8Cplhn/3V3x07uJGPF2+q7T/3EJeMRuNrOqgZNidFlIKDsi6sx+t2cD0ZDWd1K+RkKhRmE0Z9JQscIIDrYDuhIO/ic9BTTTQrrQoSH6w3SUDHWUEuxCoCb4R1LTKHyvL3z4E0ID94=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1788986994; c=relaxed/simple;
	bh=+/c27T920kBCdmxGv5fLETrRsiIAYcQsxC/xLBTVVI0=;
	h=From:To:Cc:In-Reply-To:References:Subject:Message-Id:Date:
	 MIME-Version:Content-Type; b=QDGa4jFl6OME2H5nuITz/A0P8E/qFVkdhIyIenb3jf85sfas7SS1p/8Hk/q3fcCXrVMjK2VrSmlN26u/8fc/svB+rTTxQMYDq2KzzG6TGu/4OkfrdeIbjxsiwjY071mqNPnpROVQT4BKCKYnyK/3KkzouzzPO0FlwHRGySUHdAc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 2B1CC1F008A1;
	Wed,  9 Sep 2026 20:49:35 +0000 (UTC)
Received: by venus (Postfix, from userid 1000)
	id 15319183380; Wed, 09 Sep 2026 22:49:32 +0200 (CEST)
From: Sebastian Reichel <sebastian.reichel@collabora.com>
To: linux-pm@vger.kernel.org, Fan Wu <fanwu01@zju.edu.cn>
Cc: sre@kernel.org, pali@kernel.org, songl@zju.edu.cn, 
 linux-kernel@vger.kernel.org, stable@vger.kernel.org
In-Reply-To: <20260903081312.225535-1-fanwu01@zju.edu.cn>
References: <20260903081312.225535-1-fanwu01@zju.edu.cn>
Subject: Re: [PATCH] power: supply: bq27xxx: Ensure poll work is cancelled
 on remove
Message-Id: <178898697207.883277.5505684330129247481.b4-ty@b4>
Date: Wed, 09 Sep 2026 22:49:32 +0200
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
X-Mailer: b4 0.16.0


On Thu, 03 Sep 2026 08:13:12 +0000, Fan Wu wrote:
> The di->work poll work is queued from the poll callback itself and from
> bq27xxx_external_power_changed(). The cancel_delayed_work_sync() in
> bq27xxx_battery_teardown() runs while the power_supply is still
> registered, so external_power_changed() can re-arm the work after the
> cancel, and it runs after the driver data has been freed.
> 
> Register a devm_delayed_work_autocancel() before
> devm_power_supply_register(), so on unwind the power_supply is
> unregistered first, after which no new external_power_changed()
> callback can be dispatched, and the poll work is cancelled only then.
> Drop the now-redundant cancel from bq27xxx_battery_teardown().
> 
> [...]

Applied, thanks!

[1/1] power: supply: bq27xxx: Ensure poll work is cancelled on remove
      commit: b90fd101324ca12494a65bd8d2e749883551962d

Best regards,
-- 
Sebastian Reichel <sebastian.reichel@collabora.com>

