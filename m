Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=74.125.82.173
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1794160486;
	b=LpB4PSSA7ZgXDEUS6w1cnSR1OjplDY0AyJCL7zrfuUf9gQqih31SzI+A9tc4ls1qaLNc
	 7ACSfiw8TRkcJRaG1kLScliun9Y/KO2cwS0sJ8zMD1dAIEhnTDopiCeEq6v/yNV9ktxQD
	 7dLusi3lk7KHq+/LbzWKQutETxQb0lBZqLGv+2woFglJgmwMckrgMNnYCJM1zmPK3DcYq
	 Dtn1fOHUUUovk0Pu1FjaUJn6sPp+Csio9i9lVg28UB9KZ1cu8nh41LJMjz2Ni6Es9reI/
	 VrBT6bL8p+1Qnlk5nGrjvc83fvUmQIH5Ln3/Gys6Q+MK2Qt7xS5UVSjZHDq7YDfw1Aw==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1794160486;
	h=DMARC-Filter:Received:DKIM-Signature:X-Google-DKIM-Signature:
	 X-Forwarded-Encrypted:X-Gm-Message-State:X-Gm-Gg:X-Received:Received:
	 From:To:Cc:Subject:Date:Message-ID:X-Mailer:MIME-Version:
	 Content-Transfer-Encoding;
	bh=XN+82m6XILmToReUZb14mcLlVGl4HvQRUT+BvYNhBMU=;
	b=x3lxII1y+mKMZfSKZgqQFfteVwYCKlPBMcUMY+IZqa3zJ6+v7qZOeU+fnY9WHZ0ZR4gA
	 qieoJQ3dqNVJdw9yicUkeXaSBcgez1bR+m7PF6rMRI36xtB6rSTyETa9m+1h2jMEqGXZR
	 zv2B1+dBbF9d2uZBoiTIKqYg2qBmulsT0bv8O38olwR+1Nre1GIwAYbB9lAT2mME0JxOd
	 hZpRBPU9ejHR0101CZpjpjEm9IhQfXQl1Y7Uko+ua6Wlz2vikjPTuU/8FtM5clU9MELoe
	 X7GtkCVvQcf4nBk5Z6MXKMyrLXj5dDrp2vs8lvksZfLB/slZihJUW2kejTs4FJMM6HQ==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=gmail.com;
	spf=pass smtp.mailfrom=gmail.com;
	dkim=pass header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20260707 header.b="w9rbpO/f";
	arc=none smtp.remote-ip=74.125.82.173
Received: from mail-dy1-f173.google.com (mail-dy1-f173.google.com [74.125.82.173])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 09117606A320
	for <stable@vger.kernel.org>; Sun,  8 Nov 2026 17:54:45 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 09117606A320
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20260707 header.b=w9rbpO/f
Received: by mail-dy1-f173.google.com with SMTP id 5a478bee46e88-372bdb942dbso308203eec.1
        for <stable@vger.kernel.org>; Sun, 08 Nov 2026 09:54:45 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20260707; t=1794160485; x=1794765285; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to:content-type;
        bh=XN+82m6XILmToReUZb14mcLlVGl4HvQRUT+BvYNhBMU=;
        b=w9rbpO/fro2/aQIsj9ctujKJ+4OaThbesS0tp253vPawbzRxfHE1lc/B1jxzwhvncg
         UlMFZ8snjPx2Y93HabO9prT68I6Tzx5bgPVaeECgfXSIsy4SFdZGfkoBZs4y10K5SwKM
         To0utznSCySu6J5IH7rBy3DlsKv3HcOoKViax9PCzBCfHhaszeAsD0HM7mBKgJmA2gJt
         a5ipiA8v8qzidRHlEfElIVT4pTS8TmeW1JcV+rf4gwoMgwiB727a9HX2uo5OReWHFynd
         6/Neosestl1XtTIqkd9oEXH3z9ed18WFiNMIiUFkMuXFnCs58DV/n/7bl/X4hIlqOPH+
         t1lQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1794160485; x=1794765285;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=XN+82m6XILmToReUZb14mcLlVGl4HvQRUT+BvYNhBMU=;
        b=y/YE0aS/FDGqmS35Q9BCgyrw/fF9Phmmx45S9wPD6Df1RImjO0MvbKZv5JDf9gOee2
         7bc4Jc3bWDzyMPQxQJAb7pBmsVvVyQuDzBcPJGn6h8qZomfganLJ3OVej9Q+U7+oeAJt
         BrMcmbrHhkgqAQgh9PxXzsII2pXps+eXWsgU/HzsrsiDmeXh2O4tIYEEdFFZmoObA+Fy
         9ZSS1kyLnOk/78JdePKIdvDoCJcePwsagpgh0102QYqYHotnbrhWRN1/hsBvtE0VP9Fg
         1/B9b2UBrOYo19gDZhsFdm/oprIJWc4poAlzQQHyys95B0+GvmVP/YVM4lAwAkA8XqmO
         2Skw==
X-Forwarded-Encrypted: i=1; AL+hErHfS9tao/7+5OY79KYZq4HM4jss6mPUK1Ud5xOSb6qMMt9Osf+0F9HlDaxgs7dlzha/lMyV2GE=@vger.kernel.org
X-Gm-Message-State: APuU4Z/kSHNnNe+QEOqcRJYqr8tD88fF0XiInqvdaDGDQXX5hlLEuWuV
	1AJN1tF4ihDMUDGOMKG6ZoLPL4UjVlXvmWNcLWhknIm58m9dXz2BY9jM
X-Gm-Gg: AYBFou120lmtfmGGvQX4CW9s7hVDX94scY7GZDkaw43axaAicQg2XC2sRuuc8M5E1qN
	K0noIYgVWPESClVrK6Dv8TAWupNBIGCYY4njyzZ/YGCDNVHJnudf2mtIK1IIO8w2i0I7Nq7hkI4
	pk+E5Ay1/izGnM7wRx0ro25rzKTp7vKmjUxqe55ieSCx51hMFLxKfobquJvDRA8Lf4o4cj5hJ+g
	ARR/LJB3I+eO4yHglzI8oCRwlER3zwKcidOYU4YdsaSzN6dhQDioAwFoKmHYWNHnK3WhMxArXDw
	5mtCYtHKKjIZiRfqD4Ei3QKJStEIrTRy0FTJb69GRnUm2xpB09lvzvsqgU/oO/ire9oij+hZP8j
	2on0tpFJab4Iw1jOGQ3ae+pJ5SpPtoCnsbyg7KUCoKoBdo289lPelqlZ9cLEZV+j6vEKZ/ccpos
	VcUSMWs8TG/heoyKLGIY2amFkaDyHMlBAJABXFWZU4oBaF1AbIO3Kk4IQ4DaIK8byp7MljLWxeV
	dnbwTXtGyPHLghod0+WfIQWSFHrg4a/a8U1JhUDjK980QXv+k8KA/9uFkcxLCEJLhipSn+xXAmo
	MQ8diU4MUjQy/aX3RNk3D1fEO/JPXziMQcTY6rE5scgpEuXT
X-Received: by 2002:a05:701b:260d:b0:196:7742:3928 with SMTP id a92af1059eb24-1b39fdaf0c3mr2557319c88.0.1794160484955;
        Sun, 08 Nov 2026 09:54:44 -0800 (PST)
Received: from hj.. ([163.239.22.29])
        by smtp.gmail.com with ESMTPSA id a92af1059eb24-1b3771ea85bsm7386310c88.18.2026.11.08.09.54.42
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 08 Nov 2026 09:54:44 -0800 (PST)
From: hyunjungg <hj351016@gmail.com>
To: Mahesh J Salgaonkar <mahesh@linux.ibm.com>,
	Andrew Donnellan <andrew+kernel@donnellan.id.au>
Cc: Frederic Barrat <fbarrat@linux.ibm.com>,
	Arnd Bergmann <arnd@arndb.de>,
	Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
	linuxppc-dev@lists.ozlabs.org,
	linux-kernel@vger.kernel.org,
	stable@vger.kernel.org,
	Hyunjung Ko <hj351016@gmail.com>
Subject: [PATCH] ocxl: cancel xsl fault work before freeing the SPA to avoid use-after-free
Date: Mon,  9 Nov 2026 02:54:35 +0900
Message-ID: <20261108175435.725507-1-hj351016@gmail.com>
X-Mailer: git-send-email 2.43.0
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Post: <mailto:stable@vger.kernel.org>
List-Help: <mailto:stable+help@vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
List-Owner: <mailto:stable+owner@vger.kernel.org>
Precedence: list
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

From: Hyunjung Ko <hj351016@gmail.com>

The XSL translation-fault interrupt handler schedules
spa->xsl_fault.fault_work (xsl_fault_handler_bh), which dereferences the
fault and the SPA (via container_of) and acks the interrupt. free_link()
calls release_xsl_irq() -- which frees the XSL interrupt so no new
fault_work can be scheduled -- and then free_spa(), which frees the SPA.
Neither cancels a fault_work that was already queued by the last
interrupt. As it runs on the system workqueue with no timing bound, it
can execute after the SPA has been freed, dereferencing freed memory --
a use-after-free.

Cancel the fault work in free_spa() before the SPA is freed. By that
point release_xsl_irq() has freed the interrupt, so the work cannot be
re-queued and cancel_work_sync() is sufficient. The interrupt top half
takes a reference on the faulting mm that the bottom half is expected to
release, so if cancel_work_sync() cancels a not-yet-run work, drop that
reference here to avoid leaking it.

Fixes: 5ef3166e8a32 ("ocxl: Driver code for 'generic' opencapi devices")
Cc: stable@vger.kernel.org
Signed-off-by: Hyunjung Ko <hj351016@gmail.com>
---
 drivers/misc/ocxl/link.c | 9 +++++++++
 1 file changed, 9 insertions(+)

diff --git a/drivers/misc/ocxl/link.c b/drivers/misc/ocxl/link.c
index 7749dcd..1c2a89e 100644
--- a/drivers/misc/ocxl/link.c
+++ b/drivers/misc/ocxl/link.c
@@ -376,6 +376,15 @@ static void free_spa(struct ocxl_link *link)
 		link->dev);
 
 	if (spa && spa->spa_mem) {
+		/*
+		 * A pending xsl fault bottom half holds a reference on the
+		 * faulting mm (taken in the top half, released by the bottom
+		 * half). If we cancel it before it runs, drop that reference
+		 * here so it is not leaked. release_xsl_irq() has already
+		 * freed the xsl interrupt, so no new work can be scheduled.
+		 */
+		if (cancel_work_sync(&spa->xsl_fault.fault_work))
+			mmput(spa->xsl_fault.pe_data.mm);
 		free_pages((unsigned long) spa->spa_mem, spa->spa_order);
 		kfree(spa);
 		link->spa = NULL;
-- 
2.43.0

