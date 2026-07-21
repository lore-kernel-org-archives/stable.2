Received: from m16.mail.163.com (m16.mail.163.com [117.135.210.2])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BA518368D65
	for <stable@vger.kernel.org>; Tue, 21 Jul 2026 01:48:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=117.135.210.2
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1784598518; cv=none; b=jmaTEvoCdiQJkLYqe82Wx2GD9WclfcOxXs2XQ7SpX6WNVSI5LET68np67iYoT7H+oZsKzscgwPNmTC6n3Es6GO7GLa1ioLTjB1ZFKchlUHs8xN9EExK36OpBQIXeb1a3Quh8U9CIMlRhsBixB2XtWbSdw1+LOmFajoYSHycG2BI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1784598518; c=relaxed/simple;
	bh=DN6XtckzFpYwHpFOKOpH27zxiPop2CQpN6/zit9lm58=;
	h=From:To:Cc:Subject:Date:Message-Id:MIME-Version; b=KkgKqtcciQPD3er/tdznTrP++W0IXEMECgU1ack6WBUmXG5Jd00IEPODAMofJ9Xg2NLXsphShu92se5Evh0XJl7OC/T9wLXTecbykXTtMfJwA573GPmoKpH5iwz5aVHmHIq42i7X1fsqaNykYauRVWv3QJX/k0FgmRh0i4zefwA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=163.com; spf=pass smtp.mailfrom=163.com; dkim=pass (1024-bit key) header.d=163.com header.i=@163.com header.b=Ta6N/Xby; arc=none smtp.client-ip=117.135.210.2
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=163.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=163.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=163.com header.i=@163.com header.b="Ta6N/Xby"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=163.com;
	s=s110527; h=From:To:Subject:Date:Message-Id:MIME-Version; bh=fQ
	7BS31i6xTxUsdYPDfpim+SvNAWMyB/3/cI+XOsd0Q=; b=Ta6N/XbycdR27guANI
	XTrBp64toPAF3qROizSdUrVuGEJ2x+OJ78Ow8Qd57SCLO2bUO8JW0rNuekp1EgeX
	3qJwysb7UwDHeOWiwpS+Choc5aYjVGxgOv1HRckLXn2Mk1rISWZ1xIfVQxmaBg55
	TwcHpsmVoTr9xMZQ9tGXJzkJg=
Received: from lwj.localdomain (unknown [])
	by gzga-smtp-mtada-g0-3 (Coremail) with SMTP id _____wA3Phjsz15q2VPxKg--.20038S2;
	Tue, 21 Jul 2026 09:48:29 +0800 (CST)
From: Xuan Tang <x14786623579@163.com>
To: x14786623579@163.com
Cc: stable@vger.kernel.org
Subject: [PATCH] [PATCH] drm/gma500: Handle zero-length GMBUS writes
Date: Tue, 21 Jul 2026 09:48:22 +0800
Message-Id: <20260721014822.843861-1-x14786623579@163.com>
X-Mailer: git-send-email 2.34.1
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-CM-TRANSID:_____wA3Phjsz15q2VPxKg--.20038S2
X-Coremail-Antispam: 1Uf129KBjvJXoW7ZF1fJF47ZF1fur47Jw43ZFb_yoW8Jw1xpF
	sIgF4UKrZxJF42y34a9a12yFWrC3W3Xa43GFZ7Kwn8u3ZxXFy5JFZ8Wa4YgrWrG3savryS
	qrn5KFyrZF17JF7anT9S1TB71UUUUU7qnTZGkaVYY2UrUUUUjbIjqfuFe4nvWSU5nxnvy2
	9KBjDUYxBIdaVFxhVjvjDU0xZFpf9x0zECzuNUUUUU=
X-CM-SenderInfo: j0rulmywwsjkixz6il2tof0z/xtbCzg1hUWpez+368AAA3v

gmbus_xfer() uses a do-while loop to preload the first bytes of a
write message into GMBUS3. The loop accesses the message buffer
before checking whether any bytes remain.

For a zero-length write, the loop therefore dereferences the buffer
once. Decrementing the unsigned length from zero also wraps it to
65535, which may lead to further out-of-bounds accesses.

Check the remaining length before accessing the buffer. This keeps
the existing GMBUS transaction flow unchanged and preserves the
behavior of all non-zero-length writes.

Fixes:
Cc: stable@vger.kernel.org
Signed-off-by: Xuan Tang <x14786623579@163.com>
---
 drivers/gpu/drm/gma500/intel_gmbus.c | 7 ++++---
 1 file changed, 4 insertions(+), 3 deletions(-)

diff --git a/drivers/gpu/drm/gma500/intel_gmbus.c b/drivers/gpu/drm/gma500/intel_gmbus.c
index 5933ae04a6aa..bf060a62b3b7 100644
--- a/drivers/gpu/drm/gma500/intel_gmbus.c
+++ b/drivers/gpu/drm/gma500/intel_gmbus.c
@@ -294,9 +294,10 @@ gmbus_xfer(struct i2c_adapter *adapter,
 			u32 val, loop;
 
 			val = loop = 0;
-			do {
-				val |= *buf++ << (8 * loop);
-			} while (--len && ++loop < 4);
+			while (len & loop < 4) {
+				val |= *buf++ << (8 * loop++);
+				len -= 1;
+			}
 
 			GMBUS_REG_WRITE(GMBUS3 + reg_offset, val);
 			GMBUS_REG_WRITE(GMBUS1 + reg_offset,
-- 
2.34.1

