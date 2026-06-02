Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1A3643947A4
	for <stable@vger.kernel.org>; Tue,  2 Jun 2026 18:21:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1780424509; cv=none; b=gWlldc/t+Vpz9exwG89EuhwO1bc7/KBQ/yR1hKHbbYOTDe30PyCgynLPkF9fkGTGrJlj2/OtsyIrCS9oyreEFmVbk3WcJvoH3bwJ52IqvRk1oU+eYHk8VMPWZrSciRUq2XH0nPwDTqoGlgdJfBjfipgjvgi84pC2CQAYeQoWcls=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1780424509; c=relaxed/simple;
	bh=GI6hjdP/5HmA4fKqJ5A165UD/zmfoUqQgcXUXppDea0=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=V2hTOgKBZ1qFYOIkBg26Bu9Fx59nZtpAd1wNT1Z9CfiQR3ckxrYzacOTl0meXdV3dol+AqRkZyhPg8xcBkdvyCGkZR/B1BBn+MfKud3o1TSeSlOQp6OiOpKmemW/MznOHw3lBpGxB6QFK8wmwx/a6l1hfGnjrAylLmBm3h78H0Q=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=lrs7P6Gc; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="lrs7P6Gc"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 5BDF61F0089B;
	Tue,  2 Jun 2026 18:21:44 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1780424505;
	bh=GI6hjdP/5HmA4fKqJ5A165UD/zmfoUqQgcXUXppDea0=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References;
	b=lrs7P6GcOS5yZo1uewm4Wa7DCimGEhqvMxpgPgF5ZmgoBcL1ONYs1KimyusopX9gD
	 qLlsajvYrZ6NrzuTjerQ0Q8X2IOD0lQ5TyK/L8wVGikatZW4h1gaZ8u+Pj5md66r16
	 kwnZk0xEOioavlx9cv7Snr+xG42VknuB+7j5hoCcxakWh5DBTBcFAv9JVhkT7KZnpJ
	 md4UCrq0Mmgo3uKlgpamcdqWjCFGozQQnazg8b8clwnoSH9NQafRHMC/VjlwMNq+wW
	 Tq9gFL7hnlGVrjwXVxQXDWN5IDYtsd8xJ1mj/VdI6m+iqokHF4l7wHnZCjttgk7RWg
	 ZcNwYzVdk4lMA==
From: Sasha Levin <sashal@kernel.org>
To: Mahmoud Nagy Adam <mngyadam@amazon.de>,
	stable@vger.kernel.org
Cc: Sasha Levin <sashal@kernel.org>,
	Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
	nagy@khwaternagy.com
Subject: Re: Backport "net/sched: cls_fw: fix NULL dereference of "old" filters before change()"
Date: Tue,  2 Jun 2026 14:21:23 -0400
Message-ID: <20260602180900.cls-fw-reply@kernel.org>
X-Mailer: git-send-email 2.53.0
In-Reply-To: <lrkyqmrxe16vj.fsf@dev-dsk-mngyadam-1c-cb3f7548.eu-west-1.amazon.com>
References: <lrkyqmrxe16vj.fsf@dev-dsk-mngyadam-1c-cb3f7548.eu-west-1.amazon.com>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

On Sun, Jun 01, 2026 at 07:57:04PM +0200, Mahmoud Nagy Adam wrote:
> Backport "net/sched: cls_fw: fix NULL dereference of "old" filters before change()"

Now queued from mainline (65782b2db732) to 6.18.y, 6.12.y, 6.6.y, 6.1.y,
5.15.y and 5.10.y.

Thanks,
Sasha
