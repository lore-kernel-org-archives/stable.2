Received: from mail-m155101.qiye.163.com (mail-m155101.qiye.163.com [101.71.155.101])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0804D25228D;
	Fri,  9 Oct 2026 01:29:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=101.71.155.101
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1791509363; cv=none; b=VD0SiuKmXIhrjSfHUSgFVa8xqxD8VP/d3W6hsLJ3FIAXedo61ytFmwCczuKOTjepWaBb28ccQU2lsP0um3JH/ub8xFPjjRbEHsstH1C5WL2GdHPCKj/kOGBgbgj5tsUUmOxdEuV7vtIGy/D3riE2NI3jfT1AqphOUD7gP+8O/ps=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1791509363; c=relaxed/simple;
	bh=sEHnVK+cGI77dBADCJ0be5zStEW7wq7MOe8uU18EpjA=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=q4CRsyTjFwfGCvGqeQHreGbNCqQXFT3HxTGblJCDkyDJ93a5+Akh0B6WmZNvw+HTA51eKYAWCYVnlJUfSE+luFPP2+rJX+zIbe8sPCBdeCxyrT8Fz2o8fqy2vpxHQe/RoIKPRi2T7so2JJ2rtWyDlIxqUrc+Ix8+YrQlkkF4eHU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=seu.edu.cn; spf=pass smtp.mailfrom=seu.edu.cn; dkim=pass (1024-bit key) header.d=seu.edu.cn header.i=@seu.edu.cn header.b=PIvbZRxs; arc=none smtp.client-ip=101.71.155.101
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=seu.edu.cn
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=seu.edu.cn
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=seu.edu.cn header.i=@seu.edu.cn header.b="PIvbZRxs"
Received: from PC-202605011814.localdomain (unknown [58.241.16.34])
	by smtp.qiye.163.com (Hmail) with ESMTP id 505d38da4;
	Fri, 9 Oct 2026 09:29:07 +0800 (GMT+08:00)
From: Runyu Xiao <runyu.xiao@seu.edu.cn>
To: Simon Horman <horms@kernel.org>
Cc: netdev-bot+sinfo@kernel.org,
	Sukhdeep Singh <sukhdeeps@marvell.com>,
	Andrew Lunn <andrew+netdev@lunn.ch>,
	"David S . Miller" <davem@davemloft.net>,
	Eric Dumazet <edumazet@google.com>,
	Jakub Kicinski <kuba@kernel.org>,
	Paolo Abeni <pabeni@redhat.com>,
	Richard Cochran <richardcochran@gmail.com>,
	netdev@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	stable@vger.kernel.org,
	Jianhao Xu <jianhao.xu@seu.edu.cn>
Subject: Re: [PATCH] net: atlantic: only free the PTP IRQ after a successful request
Date: Fri,  9 Oct 2026 09:28:59 +0800
Message-Id: <20261009012900.1098973-1-runyu.xiao@seu.edu.cn>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20261006165557.GO83879@horms.kernel.org>
References: <20260930074023.2943213-1-runyu.xiao@seu.edu.cn> <179075425701.31693.17457011245131119734@kernel.org> <20261006165557.GO83879@horms.kernel.org>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-HM-Tid: 0aa11e473a7c03a1kunm611c7a0b42a27a
X-HM-MType: 10
X-HM-Spam-Status: e1kfGhgUHx5ZQUpXWQgPGg8OCBgUHx5ZQUlOS1dZFg8aDwILHllBWSg2Ly
	tZV1koWUFITzdXWRgWCB1ZQUpXWS1ZQUlXWQ8JGhUIEh9ZQVkaHktMVkxDHUwaHR1OHUlMHVYeHw
	5VEwETFhoSFyQUDg9ZV1kYEgtZQVlOQ1VJT0pVSk1VSE9ZV1kWGg8SFR0UWUFZT0tIVUpLSUhOQ0
	NVSktLVUtZBg++
DKIM-Signature: a=rsa-sha256;
	b=PIvbZRxsKHbGjKHSx4hyng7e9bSBxSJFujO/Rx8bkX10sxnitH7hkpFwyoOdHX05H1XqkP44bPe1/hYD0QfSBeHmNtSY43qQGmpFFEY5x8Bg1XMNl26YLSZ8kolvXelwjYOd3jgOcTK/azLOEAhqu3qCFhsbc7WTU8EMB1J18YU=; c=relaxed/relaxed; s=default; d=seu.edu.cn; v=1;
	bh=sEHnVK+cGI77dBADCJ0be5zStEW7wq7MOe8uU18EpjA=;
	h=date:mime-version:subject:message-id:from;

Hi Simon,

> Whether the issue was actually triggered, or is only theoretical
> (e.g. found by code inspection). If it was triggered please include
> the symptoms, like the stack trace or error messages.
>
> What hardware the change was tested on. For driver fixes please
> mention the device (and if relevant firmware version) used for
> testing, or say that the change was not tested on real hardware.

The issue was identified by code inspection and was not reproduced at
runtime. In legacy INTx mode, aq_ptp_irq_alloc() skips request_irq() and
returns -EINVAL. The aq_ndev_open() error path then calls aq_nic_stop(),
which invokes aq_ptp_irq_free(); before this change, that path could call
free_irq() without a matching request_irq(). The expected IRQ-core warning
is "Trying to free already-free IRQ", but I did not capture a runtime
warning or stack trace.

I did not test this on real Aquantia Atlantic hardware or firmware.

Thanks,
Runyu
