Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2AA19361965;
	Sat,  1 Aug 2026 16:26:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1785601607; cv=none; b=iebvGHqcYz39xqF1pwvSaXCMmRqIEzgJ/SoD5HhDp4HXIUDKBe2ls3Fy6HhiUO88E1H3Ub9+ms5rnmwNigCsPzZ1vAas4a3hVwtpJorlSruxgJTx5fiTaPw1UL5oYtbVab9ZXD3FFy9y+sOhcuqNOBoIB4rOfbcskVMY8y35Y1w=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1785601607; c=relaxed/simple;
	bh=MWB1zmAQt1bMKEipnGaQvMqoXfOADAeEWig+Z3qIaNs=;
	h=From:To:Cc:In-Reply-To:References:Subject:Message-Id:Date:
	 MIME-Version:Content-Type; b=UPCkopnVqLlm1VbH8apLl3wu11AM+owqsbDJ+lrcZT7eDGpxC2G3w0oIlgH8hHMV+YpEYyH/uHN8eE1o2PNWjg/N51Z/gmdaRrPhJrD1aMpPYNNsiGYUmqBBp+Zs3LF/sy7diYIxfKbsLL9d7FSfkY2rsdPHV9pjHs68+STvF2E=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
Received: by smtp.kernel.org (Postfix) with ESMTPSA id B090A1F00AC4;
	Sat,  1 Aug 2026 16:26:45 +0000 (UTC)
Received: by venus (Postfix, from userid 1000)
	id 3302B180537; Sat, 01 Aug 2026 18:26:44 +0200 (CEST)
From: Sebastian Reichel <sebastian.reichel@collabora.com>
To: linux-pm@vger.kernel.org, Fan Wu <fanwu01@zju.edu.cn>
Cc: sre@kernel.org, laurentiu.palcu@intel.com, krzk@kernel.org, 
 linux-kernel@vger.kernel.org, stable@vger.kernel.org
In-Reply-To: <20260801051958.354528-1-fanwu01@zju.edu.cn>
References: <20260801051958.354528-1-fanwu01@zju.edu.cn>
Subject: Re: [PATCH v2] power: supply: bq24257: fix use-after-free on
 remove
Message-Id: <178560160420.8893.15196865802852999836.b4-ty@b4>
Date: Sat, 01 Aug 2026 18:26:44 +0200
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
X-Mailer: b4 0.15.2


On Sat, 01 Aug 2026 05:19:58 +0000, Fan Wu wrote:
> The STAT-pin interrupt is devm-managed, so it stays armed until the devm
> cleanup that runs after remove() returns. remove() cancels
> bq->iilimit_setup_work while the threaded handler can still fire; that
> handler reschedules the work and dereferences bq, so the work runs
> against freed memory once devm frees bq.
> 
> Make the delayed work device-managed with devm_delayed_work_autocancel(),
> registered before the interrupt request. The devm cleanup then releases
> the interrupt first, so the handler can no longer reschedule the work,
> and cancels the work before bq is freed. The explicit
> cancel_delayed_work_sync() in remove() is no longer needed and is dropped.
> 
> [...]

Applied, thanks!

[1/1] power: supply: bq24257: fix use-after-free on remove
      commit: 9d34c9d660c3d0931d2cc749c46c47cf31f96e48

Best regards,
-- 
Sebastian Reichel <sebastian.reichel@collabora.com>

