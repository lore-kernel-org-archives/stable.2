Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A59E3359A89;
	Mon,  3 Aug 2026 23:01:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1785798117; cv=none; b=Zb+uFXhQZmqQCHGSSCQRd2TplLpxoMe3NSfLyxa/wTwyf3wBtlG0TYNn/g3qVvVmamW/UKiBbrSj7s8D4cRN8sN21qWJnNn5N6UEL39b0rGVR6F36YjJooayat4mHvHRId9i24Wsmt8CSmcFoxtSr+DSV/q/m6QHiGIFZQcJuUw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1785798117; c=relaxed/simple;
	bh=FG9UMc7a3U9l4xIjTp05UYBOxu2aNYddr7keYcplJEo=;
	h=From:To:Cc:In-Reply-To:References:Subject:Message-Id:Date:
	 MIME-Version:Content-Type; b=oZqMxMlqEhh6ZiF+92FFry6GCkA8ZyrH3La8AvjtRIjOkC7LHhS6fkTV0+KC2/1NTTD63/NtxKuPL+FB6oaR8c9+tqymPuV7cTVQfxqyaYVuUFP1VweFB24cYjEfyYXD72q66brWIBQtMhB1v97lgQpQaiUzBXVSENsF5Dc6qiI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 4A3F41F00A3D;
	Mon,  3 Aug 2026 23:01:56 +0000 (UTC)
Received: by venus (Postfix, from userid 1000)
	id B56E61806AC; Tue, 04 Aug 2026 01:01:54 +0200 (CEST)
From: Sebastian Reichel <sebastian.reichel@collabora.com>
To: linux-pm@vger.kernel.org, Fan Wu <fanwu01@zju.edu.cn>
Cc: sre@kernel.org, Milo.Kim@ti.com, anton.vorontsov@linaro.org, 
 linux-kernel@vger.kernel.org, stable@vger.kernel.org
In-Reply-To: <20260802035442.421697-1-fanwu01@zju.edu.cn>
References: <20260802035442.421697-1-fanwu01@zju.edu.cn>
Subject: Re: [PATCH] power: supply: lp8788-charger: fix use-after-free on
 remove
Message-Id: <178579811473.234019.3046500625347185563.b4-ty@b4>
Date: Tue, 04 Aug 2026 01:01:54 +0200
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
X-Mailer: b4 0.15.2


On Sun, 02 Aug 2026 03:54:42 +0000, Fan Wu wrote:
> lp8788_charger_remove() flushes charger_work before unregistering the
> IRQs. An IRQ thread can queue charger_work after flush_work() has
> returned. The work can then run after devres frees pchg and dereference
> it in lp8788_charger_event().
> 
> Unregister the IRQs first. free_irq() waits for any running threaded
> handler, so no handler can queue more work afterwards. Then use
> cancel_work_sync() to cancel pending work or wait for running work to
> finish.
> 
> [...]

Applied, thanks!

[1/1] power: supply: lp8788-charger: fix use-after-free on remove
      commit: 831c29a12d560f8a3225f43050b3fbb5dfd79c66

Best regards,
-- 
Sebastian Reichel <sebastian.reichel@collabora.com>

