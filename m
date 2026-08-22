Received: from mail-m49197.qiye.163.com (mail-m49197.qiye.163.com [45.254.49.197])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id EB57537DE83;
	Sat, 22 Aug 2026 08:52:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=45.254.49.197
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1787388752; cv=none; b=clMVgZh9UjX9HzElLdMaMxK2EyuUryr84Fh4HLgnhllboUF2SuvCRU+pNgTZxU6+h7LMU+K2jAQFeRXkXVG2nHcntEyqEUzpEyo4sYDM1Cahg99j4WXy0b9OwDJrtRa+E5dyfz39YOuDff8eFDWJyOumEJfGMC3MD/epWr+pSSw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1787388752; c=relaxed/simple;
	bh=jehCVQX7W7pOxJtjjPQ5CPs1h+6DWCFZvI1j5qkHiGQ=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=SmYQoeGy6BcPUnzWt6UQHhfmLtU3A7XxRgTEUl3oP4tTBy00lvVhtQI+0d0Czb3s/s/sbpRcw5CBRZ2LNF2T+8ec/QWIqbd8rFmnF12Enx/+/SJzMjilo6cfXC1QaHLq53F1HsxFRgsYB7pyeUolaeCUdantiZU/pbI/1L96+ek=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=seu.edu.cn; spf=pass smtp.mailfrom=seu.edu.cn; dkim=pass (1024-bit key) header.d=seu.edu.cn header.i=@seu.edu.cn header.b=VmCkKTnt; arc=none smtp.client-ip=45.254.49.197
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=seu.edu.cn
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=seu.edu.cn
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=seu.edu.cn header.i=@seu.edu.cn header.b="VmCkKTnt"
Received: from LAPTOP-99KJFSET (unknown [36.153.54.101])
	by smtp.qiye.163.com (Hmail) with ESMTP id 4aeeb3cb9;
	Sat, 22 Aug 2026 16:52:15 +0800 (GMT+08:00)
From: Hongyan Xu <getshell@seu.edu.cn>
To: Stephan Gerhold <stephan@gerhold.net>
Cc: Hongyan Xu <getshell@seu.edu.cn>,
	Loic Poulain <loic.poulain@oss.qualcomm.com>,
	Sergey Ryazanov <ryazanov.s.a@gmail.com>,
	Johannes Berg <johannes@sipsolutions.net>,
	Andrew Lunn <andrew+netdev@lunn.ch>,
	"David S . Miller" <davem@davemloft.net>,
	Eric Dumazet <edumazet@google.com>,
	Jakub Kicinski <kuba@kernel.org>,
	Paolo Abeni <pabeni@redhat.com>,
	netdev@vger.kernel.org,
	linux-arm-msm@vger.kernel.org,
	stable@vger.kernel.org
Subject: Re: [PATCH net v4] net: wwan: qcom_bam_dmux: fix TX DMA channel use-after-free
Date: Sat, 22 Aug 2026 16:52:13 +0800
Message-ID: <20260822085214.1595-1-getshell@seu.edu.cn>
X-Mailer: git-send-email 2.50.1.windows.1
In-Reply-To: <20260815100454.695-1-getshell@seu.edu.cn>
References: <20260815100454.695-1-getshell@seu.edu.cn>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-HM-Tid: 0aa028abae6a03a1kunmb3ec789d1c31e1
X-HM-MType: 10
X-HM-Spam-Status: e1kfGhgUHx5ZQUpXWQgPGg8OCBgUHx5ZQUlOS1dZFg8aDwILHllBWSg2Ly
	tZV1koWUFITzdXWRgWCB1ZQUpXWS1ZQUlXWQ8JGhUIEh9ZQVlDHU1IVh4fH0xIGUhNQkNKT1YeHw
	5VEwETFhoSFyQUDg9ZV1kYEgtZQVlITVVKTkhVTk9VSktKWVdZFhoPEhUdFFlBWU9LSFVKS0hKTk
	xOVUpLS1VKQktLWQY+
DKIM-Signature: a=rsa-sha256;
	b=VmCkKTntE4jXBFD5wxwS89l389G2FU+iebGxsqB1l96UFY2+GoTEuSd1sn0vZfq9HMOU5XHvN7izvWwJQlrctSQ3dX31I4Z6jViuDHQ9Cp05xAy9F3DcpdM6Pd5R7+cBZ49dXgXsyWHsa0v4dqz17lNaYl8rbEZYZgIKHSQbHns=; c=relaxed/relaxed; s=default; d=seu.edu.cn; v=1;
	bh=Zlm3JlcmBBvnZG7UZC+WjDcj+ZqELHvcsTjBc0rjQ78=;
	h=date:mime-version:subject:message-id:from;

Hi Stephan,

Thanks for the detailed review. I addressed the comments in v4:

- Replace pc_vote, pc_vote_acked, and pc_down_pending with the four-state
  bam_dmux_pc_vote enum.
- Remove the redundant dmux->rx check in bam_dmux_handle_pc().
- Use guard(mutex)() in runtime PM paths and devm_mutex_init() in probe.
- Let runtime_suspend() handle cleanup when runtime_resume() cannot acquire
  the TX channel, instead of calling bam_dmux_power_off() there.
- Request both state IRQs with IRQF_NO_AUTOEN, enable them only after the
  initial probe state is committed, and disable both before final remove
  cleanup.

The v4 patch is attached.

Regards,
Hongyan
