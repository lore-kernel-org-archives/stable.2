Received: from galois.linutronix.de (Galois.linutronix.de [193.142.43.55])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 65C5C3B83F0
	for <stable@vger.kernel.org>; Mon, 29 Jun 2026 14:41:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=193.142.43.55
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1782744101; cv=none; b=l9iAPix2NtHtEjogMtC0o5VdzOkGqiu1pVkOF8fEussGgY2afrT+ybMbsAkllnFQ/O2VETR6MNu3rgnQrs0A+IgDpIdLVQLxBIymShiLe/lCzGBZQOaH+3I8uuOhyVGDEJsfwjq56mBahUIRc5vw6zzIkA5Zn53nX8+oxbwrBIE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1782744101; c=relaxed/simple;
	bh=G3ecOnlCcL4XHdbt8TofXa72d59ab3mXOGkhB8Z5qsA=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=L4ZDP7cCMXwBDgGCARokqapVOOPjx6TElbQJmk94ChdV12l1bjzCbzby6CSUxngDG1iYwt9NDwKZi24k9zsRYBjt+SVFKB+utmQtuTQva/jFYirwlpfNXbgvPnutn2w+gCpIBvykqnDwS0D8O5FG9okQhv8tPlKzQ6M3yObhtAI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linutronix.de; spf=pass smtp.mailfrom=linutronix.de; dkim=pass (2048-bit key) header.d=linutronix.de header.i=@linutronix.de header.b=S0l8vau+; dkim=permerror (0-bit key) header.d=linutronix.de header.i=@linutronix.de header.b=LaYG/hC9; arc=none smtp.client-ip=193.142.43.55
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linutronix.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linutronix.de
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="S0l8vau+";
	dkim=permerror (0-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="LaYG/hC9"
From: Sebastian Andrzej Siewior <bigeasy@linutronix.de>
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020; t=1782744098;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=EWkYkdV3HEvlQ4FebCydtjkVMKddRipyq8YMkecXl64=;
	b=S0l8vau+4Ign9GWt/gRc+LvGaTTi4pTnQzvnxzMJIBQCogt4tl/yFcGtxGRcTQLXU7FJDW
	N9tmdTGiF1oMLS8eFA1KO2VnACipoPh9TlZFOolTCVRRrdTMhhgaTZ/t9RGLnO0OLIl2Xe
	8P0+I70+38POlHaWIgNxJzvKmUVOFJ6ksvJhTDFfld68AyRVF6izW4Dk7aMLixvxmT3cTM
	jJTI+RkM8ExVJX3ZWCzO+abM1tFXjDndpYzpjYeOeLcywkKI6LBLj0O9hUajcMbFEIV5XQ
	zK5TSHN+JnHD18jwuITAS4bjw2pvWynkI3WHBmSAGk71j1ZMstGQF3WylZXkfw==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020e; t=1782744098;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=EWkYkdV3HEvlQ4FebCydtjkVMKddRipyq8YMkecXl64=;
	b=LaYG/hC9Ycme9TJDrHaniyz987aRx3FSLxCEnLAouRxbu4pZbpx99G9iX+ZAy2bfZAkQoB
	Kl6yJGW64yC+tABA==
To: stable@vger.kernel.org
Cc: Jan Kiszka <jan.kiszka@siemens.com>,
	Jon Humphreys <j-humphreys@ti.com>,
	Russell King <rmk+kernel@armlinux.org.uk>,
	Sebastian Andrzej Siewior <bigeasy@linutronix.de>,
	Linus Walleij <linus.walleij@linaro.org>,
	Arnd Bergmann <arnd@arndb.de>
Subject: [PATCH v6.18 3/3] ARM: 9463/1: Allow to enable RT
Date: Mon, 29 Jun 2026 16:41:31 +0200
Message-ID: <20260629144131.788576-4-bigeasy@linutronix.de>
In-Reply-To: <20260629144131.788576-1-bigeasy@linutronix.de>
References: <20260629144131.788576-1-bigeasy@linutronix.de>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable

commit c6e61c06d6061750597e79c598acb5dead44c35b upstream.

All known issues have been adressed.
Allow to select RT.

Acked-by: Linus Walleij <linus.walleij@linaro.org>
Reviewed-by: Arnd Bergmann <arnd@arndb.de>
Signed-off-by: Sebastian Andrzej Siewior <bigeasy@linutronix.de>
Signed-off-by: Russell King (Oracle) <rmk+kernel@armlinux.org.uk>
Signed-off-by: Sebastian Andrzej Siewior <bigeasy@linutronix.de>
---
 arch/arm/Kconfig | 1 +
 1 file changed, 1 insertion(+)

diff --git a/arch/arm/Kconfig b/arch/arm/Kconfig
index b7f3ad66ff15f..bfb1734e50bec 100644
--- a/arch/arm/Kconfig
+++ b/arch/arm/Kconfig
@@ -41,6 +41,7 @@ config ARM
 	select ARCH_SUPPORTS_CFI
 	select ARCH_SUPPORTS_HUGETLBFS if ARM_LPAE
 	select ARCH_SUPPORTS_PER_VMA_LOCK
+	select ARCH_SUPPORTS_RT
 	select ARCH_USE_BUILTIN_BSWAP
 	select ARCH_USE_CMPXCHG_LOCKREF
 	select ARCH_USE_MEMTEST
--=20
2.53.0

