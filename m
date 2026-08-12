Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id F3B12480DCF;
	Wed, 12 Aug 2026 22:23:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1786573434; cv=none; b=JR4Lo5tYrp3jkL8nCuAMxzGmQrB+FSKwz/Awp7ffxnYS31xW4L7u8nPxbBPEM6jxhrDD8gYPObYmFrn2UA2al5hme3015xtRK9o+ybSVgc8T3MBFvgrS2iT85DyEkHmf4juWh7yVV02zKsowpt3XHpJGbw36WUVqcpitaubU1MY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1786573434; c=relaxed/simple;
	bh=4rBy0aGKrGXkT7jiVw96Zsubk87BhS+usgc+nKum1dE=;
	h=From:To:Cc:In-Reply-To:References:Subject:Message-Id:Date:
	 MIME-Version:Content-Type; b=D4FM0Pbf+3fHAMLn0EZuusPP5O8VUXC1NuTHXzVtDcgRxAccQCa6T3Aagdvy/G2dh0gDuA9sFCrMcVf/Vu58TxmuRJwz3xbEqtLKqNzri+FWy8tq8Mcfxyo7Y3+Dhk+vxdymc64/F2cEeOC1bhHq0DJUV1Pdpde1EbFh7Ww/QAc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 9FBD01F00A3E;
	Wed, 12 Aug 2026 22:23:52 +0000 (UTC)
Received: by venus (Postfix, from userid 1000)
	id 91D5C1830B4; Thu, 13 Aug 2026 00:23:50 +0200 (CEST)
From: Sebastian Reichel <sebastian.reichel@collabora.com>
To: sre@kernel.org, Fan Wu <fanwu01@zju.edu.cn>
Cc: linux-pm@vger.kernel.org, linux-kernel@vger.kernel.org, 
 stable@vger.kernel.org
In-Reply-To: <20260807033520.8551-1-fanwu01@zju.edu.cn>
References: <20260807033520.8551-1-fanwu01@zju.edu.cn>
Subject: Re: [PATCH] power: supply: lp8727: fix use-after-free in
 lp8727_release_irq()
Message-Id: <178657343058.347615.7085557597766857502.b4-ty@b4>
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


On Fri, 07 Aug 2026 03:35:20 +0000, Fan Wu wrote:
> lp8727_isr_func(), the threaded IRQ handler, is the only caller that arms
> pchg->work via schedule_delayed_work().  lp8727_release_irq() currently
> cancels the work before freeing the IRQ, so an IRQ delivered in between
> can re-arm the work through the threaded handler.  After .remove returns
> the devm layer frees pchg while lp8727_delayed_func() may still run and
> dereference it.
> 
> [...]

Applied, thanks!

[1/1] power: supply: lp8727: fix use-after-free in lp8727_release_irq()
      commit: ceb6ac43b0f591722401922ceb958ce2616935e0

Best regards,
-- 
Sebastian Reichel <sebastian.reichel@collabora.com>

