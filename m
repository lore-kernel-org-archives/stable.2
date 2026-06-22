Received: from galois.linutronix.de (Galois.linutronix.de [193.142.43.55])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 807B53A5448
	for <stable@vger.kernel.org>; Mon, 22 Jun 2026 10:26:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=193.142.43.55
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1782124017; cv=none; b=sBovRsO9QKruQbwMdPVkEU/74Saaok4YKz6zJtOiLOYMUA9yqSYj+mRe7hixcKDYuWAgh0IiF5UYU+Himf4Lvk+DIc1Dv4E4q25w7LqQmjQNrIoGCM3ZES4ShysdkdWcioq6r1vIET59nrIvWIORT+KW3kvhFaho1uLnPn4blwQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1782124017; c=relaxed/simple;
	bh=a1y0Csyx0ibHRx8cNFk5NU1gTATrGlpq0yADdjRsowg=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=D82+UABUlCgPihLU/TKVXEvi/9OZos8McVtK4NQ1DRk5CZtrXA+Qfi2Dai4sqEgnI6tdZ/IZfRRWn9TpJNay41vdI1vtUwpfMyqMWA3BeRwx/7P+KsgdbLnnVo3o1CQFPhEnWa3pLdkYyr3SxtmSzhdmlDzD2/hpEHcShU6nDBI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linutronix.de; spf=pass smtp.mailfrom=linutronix.de; dkim=pass (2048-bit key) header.d=linutronix.de header.i=@linutronix.de header.b=TBAwfk7z; dkim=permerror (0-bit key) header.d=linutronix.de header.i=@linutronix.de header.b=kQrPozAc; arc=none smtp.client-ip=193.142.43.55
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linutronix.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linutronix.de
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="TBAwfk7z";
	dkim=permerror (0-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="kQrPozAc"
From: Sebastian Andrzej Siewior <bigeasy@linutronix.de>
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020; t=1782124014;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=2X45r5/nbcYeSAfJf1pJIuSAN5ErvuGd3WnV2DwkAEQ=;
	b=TBAwfk7zKVLoiJZfRYUNuBvP343JaZmJcGhqAMLO9PGrMEO73PieFyPkIsdfwVGTx2ZbSY
	mNd8MQ+8CyNLZGEhMV4tPnXVXtDmdlFiJX8exX7HbpS6wgoSADnaKJ4jXKYfq7QjE5fDml
	8ZCQ/CqGCft2Mw8SWfkuryh1/o6kvnh810caggzi+yuEeOJS1AmgSsWOhta1znbH72apTY
	iayrqOHAW9EX0YTU/DcnLU22FpiDANeTXYGB1yVkdMeFceoawMZuiCpnKu/QmszPBo5iMM
	lgaGFDuAv15OBah6cnIAr2eyYKdySpR8bDL+4e0VQghurq3bDQxGsKdHYhEp1Q==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020e; t=1782124014;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=2X45r5/nbcYeSAfJf1pJIuSAN5ErvuGd3WnV2DwkAEQ=;
	b=kQrPozAc74N6peBtJjT0+SnOBx9t/gJXO8Djcx3QXKT16Mc20UIR57JFsyu72KSzZ15WRP
	1mD6Qi2O7v4qh4AA==
To: stable@vger.kernel.org
Cc: Bryan Brattlof <bb@ti.com>,
	Daniel Wagner <daniel.wagner@monom.org>,
	Jan Kiszka <jan.kiszka@siemens.com>,
	cip-dev@lists.cip-project.org,
	nobuhiro.iwamatsu.x90@mail.toshiba,
	pavel@nabladev.com,
	Russell King <rmk+kernel@armlinux.org.uk>,
	Xie Yuanbin <xieyuanbin1@huawei.com>,
	Sebastian Andrzej Siewior <bigeasy@linutronix.de>
Subject: [PATCH 2/4] ARM: allow __do_kernel_fault() to report execution of memory faults
Date: Mon, 22 Jun 2026 12:26:32 +0200
Message-ID: <20260622102634.780100-3-bigeasy@linutronix.de>
In-Reply-To: <20260622102634.780100-1-bigeasy@linutronix.de>
References: <20260622102634.780100-1-bigeasy@linutronix.de>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable

From: "Russell King (Oracle)" <rmk+kernel@armlinux.org.uk>

commit 40b466db1dffb41f0529035c59c5739636d0e5b8 upstream

Allow __do_kernel_fault() to detect the execution of memory, so we can
provide the same fault message as do_page_fault() would do. This is
required when we split the kernel address fault handling from the
main do_page_fault() code path.

Reviewed-by: Xie Yuanbin <xieyuanbin1@huawei.com>
Tested-by: Xie Yuanbin <xieyuanbin1@huawei.com>
Signed-off-by: Russell King (Oracle) <rmk+kernel@armlinux.org.uk>
Signed-off-by: Sebastian Andrzej Siewior <bigeasy@linutronix.de>
---
 arch/arm/mm/fault.c | 2 ++
 1 file changed, 2 insertions(+)

diff --git a/arch/arm/mm/fault.c b/arch/arm/mm/fault.c
index 879730a47c4a2..4c0ee81befb1e 100644
--- a/arch/arm/mm/fault.c
+++ b/arch/arm/mm/fault.c
@@ -176,6 +176,8 @@ __do_kernel_fault(struct mm_struct *mm, unsigned long a=
ddr, unsigned int fsr,
 	 */
 	if (addr < PAGE_SIZE) {
 		msg =3D "NULL pointer dereference";
+	} else if (is_permission_fault(fsr) && fsr & FSR_LNX_PF) {
+		msg =3D "execution of memory";
 	} else {
 		if (is_translation_fault(fsr) &&
 		    kfence_handle_page_fault(addr, is_write_fault(fsr), regs))
--=20
2.53.0

