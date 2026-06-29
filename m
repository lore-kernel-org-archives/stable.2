Received: from galois.linutronix.de (Galois.linutronix.de [193.142.43.55])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 62F6C3A2549
	for <stable@vger.kernel.org>; Mon, 29 Jun 2026 14:41:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=193.142.43.55
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1782744100; cv=none; b=n8zq9noqXVT0urWZkg16Ss6PpWPmqOOCRlaQcd/lu3tHfP4JpHaWQJ7yphlPly8uuPgkyy2oT4i+O9mc5bpSQtbNI8FSKWIQusntdCqeCzUmP6JDlVYQnVLyKxoir0ZKzvN8SAluMVDldS9w6qX9yLibzItdzyEgPgXrPbIEvOQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1782744100; c=relaxed/simple;
	bh=a+jH0hfgg9A1skt6sKLqlzAuNa/TNIR69rHvYoFXunY=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=HPs0iw6N3uLzHDzzR4FjpjwDH7eXm7qGIBwZ+qOh7kxTL+YA04i8nFRcrK8Nfr2CsVeHATOPHbuoSEUgcM6lsW06UC68NcRSo7Adjvnx6IxNm26lBtZfSCzwu7Xqo9dqAtP2eFFZgT42gCeYUELdjWvXKFrLf4gCKwPPBb4aWqQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linutronix.de; spf=pass smtp.mailfrom=linutronix.de; dkim=pass (2048-bit key) header.d=linutronix.de header.i=@linutronix.de header.b=AQbUdujE; dkim=permerror (0-bit key) header.d=linutronix.de header.i=@linutronix.de header.b=e9IbIHUm; arc=none smtp.client-ip=193.142.43.55
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linutronix.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linutronix.de
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="AQbUdujE";
	dkim=permerror (0-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="e9IbIHUm"
From: Sebastian Andrzej Siewior <bigeasy@linutronix.de>
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020; t=1782744097;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding;
	bh=rg7Ts0DBVabun5qwzoKxHmHbEQwrJgOSzqVBjFyzk18=;
	b=AQbUdujEi8LQTQ1Q1ajxNR8I2+nVhLPVv8thDHc2uTHauyybp1YOk6cWVMJxQO/u4dHT5j
	VgxF0K6PXmMECvr6SEooXQ0p29G2vmECvg6gRu+2G2FPXm+9oWGguyn4RqKURs+oL4ihnD
	faCONKxvQj/vhjYQxuhy5L3tIxGyuCX5kKs3m8EsL8w460RKsQD7MgYcD3+e0hOxWLQyTv
	ugSnGCYgz4wGDuKoTUnFPaE81t3l3duH02uLzLaNKvm/A9CkWVbAG57P5WpCnAxfXTmILH
	yomJEm4YCPlWRBoiL2nhFK0dVJ01pvQCfyujzUtImmapKH7PW+wxtXz48feFag==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020e; t=1782744097;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding;
	bh=rg7Ts0DBVabun5qwzoKxHmHbEQwrJgOSzqVBjFyzk18=;
	b=e9IbIHUmKaJpbr2ja6M2V09MBZO4JEws3zTfDp4+TR1IS8BVPRw9XmxSNxwXpxILdHrfJZ
	NLqVnnX4rsFzkHCQ==
To: stable@vger.kernel.org
Cc: Jan Kiszka <jan.kiszka@siemens.com>,
	Jon Humphreys <j-humphreys@ti.com>,
	Russell King <rmk+kernel@armlinux.org.uk>,
	Sebastian Andrzej Siewior <bigeasy@linutronix.de>
Subject: [PATCH v6.18 0/3] ARM: PREEMPT_RT backports
Date: Mon, 29 Jun 2026 16:41:28 +0200
Message-ID: <20260629144131.788576-1-bigeasy@linutronix.de>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable

Hi,

ARM missed the PREEMPT_RT window for v6.18. The following three patches
have been merged as of v7.1-rc1 and are the missing pieces.

I've been asked by people if it would be possible to include them in the
stable tree as it would make their life easier.

Russell King (Oracle) (1):
  ARM: ensure interrupts are enabled in __do_user_fault()

Sebastian Andrzej Siewior (1):
  ARM: 9463/1: Allow to enable RT

Thomas Gleixner (1):
  ARM: 9459/1: Disable jump-label on PREEMPT_RT

 arch/arm/Kconfig    | 3 ++-
 arch/arm/mm/fault.c | 6 +++++-
 2 files changed, 7 insertions(+), 2 deletions(-)

Sebastian
