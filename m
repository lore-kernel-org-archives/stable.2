Received: from mail-m49197.qiye.163.com (mail-m49197.qiye.163.com [45.254.49.197])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D2DCF3783AF;
	Fri, 24 Jul 2026 05:28:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=45.254.49.197
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1784870934; cv=none; b=e4AImxJd2jSAaZw6H4Q70b+mfeaTTP01swSTHYpL1RayZyZkO6018pwY1Tmvc61TeGj2WnQP2DvyrSSzW5vql8tcxnRFd0tlxEQf0/gnxS/2mQeXqnaP5ahe8JN73g4pQs+PS/nfYqIj1bF1t12p00cskeirCS366SZGXf7Fy5I=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1784870934; c=relaxed/simple;
	bh=8O+mme2012dg9H1JvTX2lXWHFcoSArNE2pDsocvPocE=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=Fs9pbxlYypXDsMYFxvgNOQhHofpueft3qe07ax5mTerj7q4cqUyPXtWGyOie6dc1mqk+AqdLKXyw5m6CsEJmDXUn8tjlQdpD7qFHCDAW9lEPGlqEFswQxweSLZwkn+oKElpMltWkzF/PceBqvIeVIFEnx9e/VlBgzh1ixsSSOP0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=seu.edu.cn; spf=pass smtp.mailfrom=seu.edu.cn; dkim=pass (1024-bit key) header.d=seu.edu.cn header.i=@seu.edu.cn header.b=f7O5B+SY; arc=none smtp.client-ip=45.254.49.197
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=seu.edu.cn
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=seu.edu.cn
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=seu.edu.cn header.i=@seu.edu.cn header.b="f7O5B+SY"
Received: from LAPTOP-99KJFSET (unknown [58.241.16.34])
	by smtp.qiye.163.com (Hmail) with ESMTP id 47691a1b2;
	Fri, 24 Jul 2026 13:28:44 +0800 (GMT+08:00)
From: Hongyan Xu <getshell@seu.edu.cn>
To: gregkh@linuxfoundation.org,
	sashal@kernel.org,
	arnd@arndb.de
Cc: linusw@kernel.org,
	brgl@kernel.org,
	stable@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	linux-gpio@vger.kernel.org,
	jianhao.xu@seu.edu.cn,
	getshell@seu.edu.cn
Subject: [RFC PATCH 6.6.y 0/4] misc: ti-st: close transport removal races
Date: Fri, 24 Jul 2026 13:28:38 +0800
Message-ID: <20260724052842.1052-1-getshell@seu.edu.cn>
X-Mailer: git-send-email 2.50.1.windows.1
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-HM-Tid: 0a9f9298ed9b03a1kunm7e8f9dea24454
X-HM-MType: 10
X-HM-Spam-Status: e1kfGhgUHx5ZQUpXWQgPGg8OCBgUHx5ZQUlOS1dZFg8aDwILHllBWSg2Ly
	tZV1koWUFITzdXWRgWCB1ZQUpXWS1ZQUlXWQ8JGhUIEh9ZQVlCGk1OVkJIQkxPSkgaTU5CHlYeHw
	5VEwETFhoSFyQUDg9ZV1kYEgtZQVlOQ1VJT0pVSk1VSE9ZV1kWGg8SFR0UWUFZT0tIVUpLSUhOQ0
	NVSktLVUtZBg++
DKIM-Signature: a=rsa-sha256;
	b=f7O5B+SYUIc9n3sL0Chq4Vm+mT1Y0gsy5ogElmYN3SeWvrY8HkSk6l0S2ZMQbP34oaDScHlUahaWCz0TUZ2v6xXCucjpNeQPUqS85zMRZzJK9hdlfTc5TT1PiViHoYVNdP1HeZqL2UvuPeuQlFO53z89QeClWc81FyoIuaFOrIo=; s=default; c=relaxed/relaxed; d=seu.edu.cn; v=1;
	bh=hrwS7FgHLT1mN3bobYbs6uCZsVFY8jzLQo6DL7YVfbc=;
	h=date:mime-version:subject:message-id:from;

The TI shared transport is published before probe completes and remains
published while remove tears its core down.  The exported protocol entry
points can retain the raw core pointer across that teardown.  An attached
N_TI_WL line discipline and its write-wakeup work provide another path to
the same freed core.

This series publishes only fully initialized transports, accounts users of
the published pointer, withdraws and drains that pointer on remove, and
synchronously closes an attached TTY before freeing the core.

This is an RFC for the 6.6 stable tree because the driver is still present
there but was removed from mainline by commit 78fe66360ed6 ("misc: ti-st:
st_kim: remove the driver").  There is consequently no current mainline
code location through which these fixes can first be merged.

The patches are based on linux-6.6.y commit da47cbc25466.

Hongyan Xu (4):
  misc: ti-st: publish the transport only after probe succeeds
  misc: ti-st: account published transport users
  misc: ti-st: drain published users before transport removal
  misc: ti-st: synchronize TTY teardown with transport removal

 drivers/misc/ti-st/st_core.c | 59 +++++++++++++++++++++++---------
 drivers/misc/ti-st/st_kim.c  | 65 ++++++++++++++++++++++--------------
 include/linux/ti_wilink_st.h |  8 +++++
 3 files changed, 91 insertions(+), 41 deletions(-)

-- 
2.50.1.windows.1
