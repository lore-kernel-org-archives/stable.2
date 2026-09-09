Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D3901453A28;
	Wed,  9 Sep 2026 20:49:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1788986990; cv=none; b=P6mV+LRSwx0n5FjOd+p1OxhfzfiMTTqZDNDbYOZIIYrsQVBOXqMWnyy3bui4WSAQppbOxjbFQJjW7ssZOv6SRA8FFaoOSWDhlgCRpu4m3gwOjiRaGQeMosUvNH4bYv12Y5JccOfxaKrycIjoUhhIpPvdFX5XtE8DKe0n/XWGjB8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1788986990; c=relaxed/simple;
	bh=SOSKQ6DMWsIzF51ySe3ch/gTAqxI796K8SC3BfvFJxk=;
	h=From:To:Cc:In-Reply-To:References:Subject:Message-Id:Date:
	 MIME-Version:Content-Type; b=SdyqRCBv/qNIp/hfYLSPPrsWJ/O4fFpramlgIKyWKaepP6vLJoCt9w6smgiQpH3Lx0POidU5ybLM23ux42b6xmjdhaEeGZ0VbxcHPJ6Qzq+X0e/cXDQewj/K39s/Mmb6UVPWIrM5NpdmGAE/XSsTLWi6WrMLdT/8FftCJjWwwYo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 770531F0089D;
	Wed,  9 Sep 2026 20:49:33 +0000 (UTC)
Received: by venus (Postfix, from userid 1000)
	id EEBD518337B; Wed, 09 Sep 2026 22:49:31 +0200 (CEST)
From: Sebastian Reichel <sebastian.reichel@collabora.com>
To: =?utf-8?q?Pali_Roh=C3=A1r?= <pali@kernel.org>, 
 Sebastian Reichel <sre@kernel.org>, Hans de Goede <hansg@kernel.org>, 
 Marek Vasut <marex@denx.de>, Shengzhuo Wei <me@cherr.cc>
Cc: linux-pm@vger.kernel.org, linux-kernel@vger.kernel.org, 
 stable@vger.kernel.org
In-Reply-To: <20260827-bq27xxx-suspend-cancel-sync-v1-1-77a67711cbc3@cherr.cc>
References: <20260827-bq27xxx-suspend-cancel-sync-v1-1-77a67711cbc3@cherr.cc>
Subject: Re: [PATCH] power: supply: bq27xxx: synchronize work cancellation
 on suspend
Message-Id: <178898697196.883277.12662329036916141963.b4-ty@b4>
Date: Wed, 09 Sep 2026 22:49:31 +0200
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
X-Mailer: b4 0.16.0


On Thu, 27 Aug 2026 05:22:29 +0800, Shengzhuo Wei wrote:
> The poll work requeues itself via mod_delayed_work() while the device
> is not removed. cancel_delayed_work() does not wait for a callback
> that is already running, so a poll racing with suspend can keep
> issuing I2C transfers after suspend returns and requeue itself into
> early resume.
> 
> Use cancel_delayed_work_sync() to quiesce polling before suspend
> completes, as the teardown path already does.
> 
> [...]

Applied, thanks!

[1/1] power: supply: bq27xxx: synchronize work cancellation on suspend
      commit: 5fa10f61bbe255011ca9368b8bd6352b7d724bd3

Best regards,
-- 
Sebastian Reichel <sebastian.reichel@collabora.com>

