Received: from mx.itxnorge.no (itx-kvm-14.itxnorge.no [91.189.121.228])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B55AC3AA1B6;
	Sat,  3 Oct 2026 19:23:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=91.189.121.228
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1791055394; cv=none; b=o8Gs06WO211m2Lqa5iEPCUy7wLpf9H95v7Fu66ICUgLqGKl5c9dVR21kq0cyHk3/acU8ZlRu6LipT5MC+/NJaRoU6uTqfDag9ObNhNwofjdLeGAhDc3b0Jd3K2JSwKd5kYlX4r7KdMiVbGlsSvul3OlnKrJ8GcigboiR4OHscxg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1791055394; c=relaxed/simple;
	bh=QvNYrjXm8YOGE3v08dTl/NDt5m2cmJAD22A7lsmxpMA=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=YRfkeik5Z1H8BUPFpcAtTPcduAKKnEtClGYIWgkD+1cqygLQ+7gFV/jCPxQS83CB/ajU+FtytrAgQ+ElLYvPVAFm6S/rY9YwkbEiPMfjla6iVmZC/TMcV93TkmIO4DmoHWqGgJ5xoaC6c474CuYNEXzEVIa80/x1deaGsyPPnlc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=itx.no; spf=pass smtp.mailfrom=itx.no; dkim=pass (1024-bit key) header.d=itx.no header.i=@itx.no header.b=YPBjK0EM; arc=none smtp.client-ip=91.189.121.228
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=itx.no
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=itx.no
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=itx.no header.i=@itx.no header.b="YPBjK0EM"
From: Stian Halseth <stian@itx.no>
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=itx.no; s=mx.itx.no;
	t=1791055390;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=QvNYrjXm8YOGE3v08dTl/NDt5m2cmJAD22A7lsmxpMA=;
	b=YPBjK0EMw4IV3hzXSp2aicshvr0udsDdPQklS0tBm9yxAzrDkUpgCO9cUw2LLtxj5zQ9bG
	NJauUMo8RDQKG59ACIhzW42sx9fVEpz3IKWaQ9VANEATRsAjRTUpj4Otkl75d5PqjQ6rw0
	uY6OaAxgekBd/zOxDbF5Hnga08pLw0o=
To: Imre Kaloz <kaloz@kernel.org>,
	Andreas Larsson <andreas@gaisler.com>
Cc: sparclinux@vger.kernel.org,
	"David S. Miller" <davem@davemloft.net>,
	Thomas Gleixner <tglx@linutronix.de>,
	linux-pci@vger.kernel.org,
	stable@vger.kernel.org
Subject: Re: [PATCH] sparc/pci_msi: Clear the MSI descriptor irq on teardown
Date: Sat,  3 Oct 2026 21:22:56 +0200
Message-ID: <20261003192256.3605029-1-stian@itx.no>
In-Reply-To: <20260927105515.8701-1-kaloz@kernel.org>
References: <20260927105515.8701-1-kaloz@kernel.org>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

On Sun, Sep 27, 2026 at 12:55:15PM +0200, Imre Kaloz wrote:
> Since commit 2f2940d16823 ("genirq/msi: Remove filter from
> msi_free_descs_free_range()") the MSI core expects msi_desc::irq to be
> cleared by the architecture teardown before the descriptor is freed.
> sparc64_teardown_msi_irq() never clears it, so disabling MSI or MSI-X
> warns in msi_domain_free_descs() and leaks the descriptor.
>
> Clear it once the MSI has been torn down.

Tested on a SPARC T7-1 (M7) with 7.3-rc5 and ixgbe. Without the patch
the first MSI-X teardown warns at kernel/irq/msi.c:214. With it, 30
teardowns through ethtool -L and 3 unbind/bind cycles give no warning,
and the device keeps the expected number of MSI-X vectors.

Tested-by: Stian Halseth <stian@itx.no>
