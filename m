Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 45F82388E5B;
	Sat, 25 Jul 2026 16:15:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1784996122; cv=none; b=NdyLHUccwX+SULm/1MKZ+l5g6c5hwR5jD40WDx6Lb6gvhKzloXRoRB4QruRBmA4zmfSPYnrQT12QMHyHYeoVJ3UvLUE0rYYGs8SfZYXdOgeRZ7UOd1DEy8IMun1IBOYWlHkeccTZeRgFezC2bOLLKz0SD8RlF2Y0KBepjvpo/Ao=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1784996122; c=relaxed/simple;
	bh=9EO/mVg/U1v9peEdseao4EiW3MgxiPx6N2Z9oSllmJE=;
	h=From:To:Cc:In-Reply-To:References:Subject:Message-Id:Date:
	 MIME-Version:Content-Type; b=nwrOxTnuEVlzEPyQyReCvP90qQshF4G1OOzvpdCsNPH8PrcFBw2GiwcgrzfzF0uEg0mtBtcb+C6tuHtd37SWqOIThWwi3/sxL0YGO2CR6oAYGIQGOVuegxcxZHrzXjC474MDXozhQjqcPdqRTtTrQUOoAKDAjiTGQdPEm6KrurI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 3C35D1F000E9;
	Sat, 25 Jul 2026 16:15:11 +0000 (UTC)
Received: by venus (Postfix, from userid 1000)
	id 82FD0181F17; Sat, 25 Jul 2026 18:15:09 +0200 (CEST)
From: Sebastian Reichel <sebastian.reichel@collabora.com>
To: Sebastian Reichel <sre@kernel.org>, Maoyi Xie <maoyixie.tju@gmail.com>
Cc: linux-pm@vger.kernel.org, linux-kernel@vger.kernel.org, 
 stable@vger.kernel.org, "H . Nikolaus Schaller" <hns@goldelico.com>, 
 Anton Vorontsov <cbouatmailru@gmail.com>
In-Reply-To: <20260725072540.3092504-1-maoyixie.tju@gmail.com>
References: <20260725072540.3092504-1-maoyixie.tju@gmail.com>
Subject: Re: [PATCH] power: supply: twl4030_charger: cancel workers via
 devm
Message-Id: <178499610950.774435.8676334469368857883.b4-ty@collabora.com>
Date: Sat, 25 Jul 2026 18:15:09 +0200
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
X-Mailer: b4 0.14.3


On Sat, 25 Jul 2026 15:25:40 +0800, Maoyi Xie wrote:
> bci is devm-allocated. Two workers (bci->work and bci->current_worker)
> dereference it. twl4030_bci_remove() disables charging and masks
> interrupts. It cancels neither worker. A worker pending at remove() can
> run after devm frees bci.
> 
> The USB transceiver comes from devm_usb_get_phy_by_node(). devm
> unregisters its notifier only after remove() returns. A cancel_work_sync()
> in remove() can then race a notifier reschedule. devm_work_autocancel()
> and devm_delayed_work_autocancel() avoid that. They cancel the workers
> during devm release, before bci is freed.
> 
> [...]

Applied, thanks!

[1/1] power: supply: twl4030_charger: cancel workers via devm
      commit: 6eba34732524067da2aad5ddfdfbc641ded10e9e

Best regards,
-- 
Sebastian Reichel <sebastian.reichel@collabora.com>

