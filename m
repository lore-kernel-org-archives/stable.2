Received: from mout-b-105.mailbox.org (mout-b-105.mailbox.org [195.10.208.50])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D9ECE1862;
	Thu, 27 Aug 2026 15:50:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=195.10.208.50
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1787845863; cv=none; b=jhT+UqwPdiSQLeO5fHYCl+VYUBPjvCnQG4LWBO/Xr1jDEBijIP10sR7JDdbFFVrG4bO/52WRxO47o9+yobymnHgn3mS6pwRFCOwAwyEn8/7OupHST2NDe5XXOGqosfb6PvjZJWk/8N/aeEumOT9U0He4IpmdCofigsNRyCiLuv4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1787845863; c=relaxed/simple;
	bh=hJFzBlJooUj9tMP3pBp8imx/OWxNH+mZjIyHiIkw7DI=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=rxd2yCRdSQE4U9h6uCdb4nkwk8/q5FTSAgravYFUB1gp+nZlwxpKrL56rJK/kSMhyO3SxXv4Al9ZB4oTnX6OMXca63Pze3sL/xL9/Pea+wpKlSzl2DLUJKDwjmCT39hFOZI2+WCVNXXusIe/2hR03ZPb39wprhoesi8vuWZPAz8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=mandelbit.com; spf=pass smtp.mailfrom=mandelbit.com; dkim=pass (2048-bit key) header.d=mandelbit.com header.i=@mandelbit.com header.b=q6LIjY6o; arc=none smtp.client-ip=195.10.208.50
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=mandelbit.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=mandelbit.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=mandelbit.com header.i=@mandelbit.com header.b="q6LIjY6o"
Received: from smtp2.mailbox.org (smtp2.mailbox.org [IPv6:2001:67c:2050:b231:465::2])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange x25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by mout-b-105.mailbox.org (Postfix) with ESMTPS id 4hW5Q715KNz9rvZ;
	Thu, 27 Aug 2026 17:43:11 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=mandelbit.com;
	s=MBO0001; t=1787845391;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding;
	bh=+WUyt0i+GSy2Gq4Mu2qBP0O11Puo1gl4vVXEYTcZH7E=;
	b=q6LIjY6ou2T1gmaRHTci14DgO7omruedHRTLJyx2DpsJe5EipztVpTzRbbDoqlZr9nmTVF
	3Y3nQWBhIGITdaifNHrvzv/INCP8rW11sPpT9Tg1Ob8xAOE5n9ehpVCNdKwzvJLt4Rixe9
	yrMBOhgSjUz/gPXmD58ISfgi70M4p7/fSZ4n5p7t9vlrOe2xZ4SKpjQpgYjDvXpAp456Uf
	GRvhNABCgPiazVHStvFjggVi+7ogCFmzWOQd/i3cR0t5ZsNYXI7rHhXG/rOhrdMPluNW64
	RnRvjbsTgPwlTsJ6WN89D4w7CcRhmGYXP0t95dP80/PO7gPRywG6vu8Ycsk1Sw==
Authentication-Results: outgoing_mbo_mout;
	dkim=none;
	spf=pass (outgoing_mbo_mout: domain of ralf@mandelbit.com designates 2001:67c:2050:b231:465::2 as permitted sender) smtp.mailfrom=ralf@mandelbit.com
From: Ralf Lici <ralf@mandelbit.com>
To: stable@vger.kernel.org
Cc: regressions@lists.linux.dev,
	Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
	Ran Wang <ran.wang_1@nxp.com>,
	Duoming Zhou <duoming@zju.edu.cn>,
	linux-usb@vger.kernel.org,
	linuxppc-dev@lists.ozlabs.org,
	Ben Hutchings <ben@decadent.org.uk>
Subject: [REGRESSION] 6.1.y/6.6.y: fsl-usb fails to build
Date: Thu, 27 Aug 2026 17:43:00 +0200
Message-ID: <20260827154302.706689-1-ralf@mandelbit.com>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Rspamd-Queue-Id: 4hW5Q715KNz9rvZ

Hi,

While working on some backport patches for an out-of-tree module and
looking for the exact versions containing the disable_delayed_work_sync
symbol, I stumbled upon occurrences of that function on longterm v6.1
and v6.6 in drivers/usb/phy/phy-fsl-usb.c despite not being declared or
defined anywhere. In fact, disable_delayed_work_sync was introduced by
upstream commit 86898fa6b8cd ("workqueue: Implement disable/enable for
(delayed) work items") and is only available since v6.10. Neither 6.1.y
nor 6.6.y defines it.

Consequently, kernels built with CONFIG_FSL_USB2_OTG fail with:

drivers/usb/phy/phy-fsl-usb.c:990:2: error: call to undeclared function 'disable_delayed_work_sync'; ISO C99 and later do not support implicit function declarations [-Wimplicit-function-declaration]
  990 |         disable_delayed_work_sync(&fsl_otg_dev->otg_event);
      |         ^
drivers/usb/phy/phy-fsl-usb.c:990:2: note: did you mean 'cancel_delayed_work_sync'?
include/linux/workqueue.h:470:13: note: 'cancel_delayed_work_sync' declared here
  470 | extern bool cancel_delayed_work_sync(struct delayed_work *dwork);
      |             ^

I reproduced the failure on PowerPC using corenet64_smp_defconfig with
CONFIG_FSL_USB2_OTG=m, building drivers/usb/phy/phy-fsl-usb.o with
Clang.

AFAICT, in 6.1.y, the regression was introduced in v6.1.160 by commit
4476c73bbbb0 ("usb: phy: fsl-usb: Fix use-after-free in delayed work
during device removal") and remains present in v6.1.185.

In 6.6.y, it was introduced in v6.6.120 by commit 319f7a85b3c4 ("usb:
phy: fsl-usb: Fix use-after-free in delayed work during device removal")
and remains present in v6.6.154.

Note that the same problem was pointed out by Ben Hutchings during the
5.10.y review:
https://lore.kernel.org/all/d147f0eb71f9cefbfb7605e95d98564d7f0ed346.camel@decadent.org.uk/

The corresponding patches were dropped from 5.10.y and 5.15.y, but
appear to have been retained in 6.1.y and 6.6.y.

Simply replacing disable_delayed_work_sync with cancel_delayed_work_sync
at its current location may not be sufficient: it looks like the delayed
work can also be scheduled from fsl_otg_set_host and from the IRQ
handler but I'm not familiar with this part of the kernel.

Cheers!

-- 
Ralf Lici
Mandelbit Srl
