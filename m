Received: from smtpbgjp3.qq.com (smtpbgjp3.qq.com [54.92.39.34])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D7F9C372062;
	Mon, 10 Aug 2026 09:20:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=54.92.39.34
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1786353663; cv=none; b=gSFai2iOmDorPjcG//qv6wqvuRGT5Jjgq9UIDMLmL43M509o/zm7TZ0aZdbS9Ei8Zr99NQcvpO8E4pb1cgaJwL1PBn6FY1W1D77yV8FHLyDA2Y5ueuCin9Mjfsnz2L0B6AvrSFXgNc0FZ66PXqge+QeMKg2m3bpLSDcqpxuVAQk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1786353663; c=relaxed/simple;
	bh=QdkTzbtCkDJxlS7CTj1PwUNqIInKL45U5ZUtV1lh49I=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=RbVoM1gOgMjBdRhCypgJm8I1RJAL7Bmw/DIwxpZUOfWPNPYWnxdGWYLSGbvDWQ617zZfFTGAnxFUfgNhc0NxaM5ekPKwnuBb+BW9lFM2zPVXV6MdGai9u+cdcLqbTuxLT7I3nIYSGSaTKNiaFyZLhddtgM/sOZ8HekFVKPYKWso=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=uniontech.com; spf=pass smtp.mailfrom=uniontech.com; dkim=pass (1024-bit key) header.d=uniontech.com header.i=@uniontech.com header.b=a3s61FHe; arc=none smtp.client-ip=54.92.39.34
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=uniontech.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=uniontech.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=uniontech.com header.i=@uniontech.com header.b="a3s61FHe"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=uniontech.com;
	s=onoh2408; t=1786353645;
	bh=8tLGbIp0Ta1vTWMv6dNkzKIVnot+g5opsJmhP+J5sCI=;
	h=From:To:Subject:Date:Message-ID:MIME-Version;
	b=a3s61FHeQ5uuErXvlvVP7dfdc7lQZu0R3FfcTbfQPrLF/9/m2nw/oTv4HP7lrJY86
	 ljLIt9h782JmijvnxHLkpPkNaKTIx1AmcL4+Kw0OJey/C4Rtie+Ru5DagP3iJaYKDM
	 ZN/6nTxkm4N+tYLxdB/4+gBS4rwM4Nm5C5jBn7mo=
X-QQ-mid: esmtpsz10t1786353627t9a19c8f8
X-QQ-Originating-IP: xbGbFhxW2SyckUwBsp53UOPcQ0aUNYZcEgMpZMTtYmg=
Received: from PEN202512010004 ( [113.57.152.160])
	by bizesmtp.qq.com (ESMTP) with 
	id ; Mon, 10 Aug 2026 17:20:25 +0800 (CST)
X-QQ-SSF: 0000000000000000000000000000000
X-QQ-GoodBg: 1
X-BIZMAIL-ID: 2117933671536180727
EX-QQ-RecipientCnt: 7
From: raoxu <raoxu@uniontech.com>
To: laurent.pinchart@ideasonboard.com
Cc: hansg@kernel.org,
	mchehab@kernel.org,
	linux-media@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	raoxu@uniontech.com,
	stable@vger.kernel.org
Subject: [PATCH] media: uvcvideo: fix output terminal type check for ID namespace
Date: Mon, 10 Aug 2026 17:16:24 +0800
Message-ID: <ABE1FC11603F6BBE+20260810091624.2159038-1-raoxu@uniontech.com>
X-Mailer: git-send-email 2.50.1
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-QQ-SENDSIZE: 520
Feedback-ID: esmtpsz:uniontech.com:qybglogicsvrgz:qybglogicsvrgz6b-0
X-QQ-XMAILINFO: McJfg7Aee/FZ1Lz1Kz0sHqAM9YNqZGzKAEgRnCdHW5rPEcCxbBvGPZna
	eQzLC9Lm9mzcxjzyfUdDPlHc2OLKqqVZvClZ9NdO/xPkHtQ+vpMepp5CA9OBBTTKKsfPdno
	Fy5qI8PhsqDfv20cCwiL6kSJQuf8JEiYd/LmsTasbTatGQ/efG7KV5hwT9dZ/Ai3SjBX3KZ
	56ril+0AHCRkW1TZOl11RgD5IVipra6kJ0cKpvVrUZ5TPl9Er3UKDGh+eAj1kBJlWP6/hlj
	bIT5mBPFKHSOOpjZ1t5D62XBSS2NUldtYmE5H0Axy/mw11cxfFrpETQknW7qMIJ040BkoVC
	9S79UaZTz4Efs77AyfXsXDFNUfs0KSAkExBIWXZ3iojzIJ06eYQUuOaJ4ZuIWkD0wVRuhJ4
	O6PQ6guJ1S3H6bqZ6Wz3nsODtjXkIVawOjgwNsdAO1jvLHDR5c4EDggKp+r3ju7uQTdsn6o
	KPaLuFSjcC45/WZ9TJqDwqFSyytvvrLyeNVtoeir+7KeeSSsPU5cB5Y8fxStrVHGgopShrs
	WMmnBf+kiUhCWCEJPGnAgJPI/HFkucBDVm1bZ5A4VSrSmI4Gd3MVlh4gOgzIErFRkJBr9OQ
	tnAKr8yOePudasqbCkRyb7LPMhwWT/qZDgdd7EpkanqtM5h0xyRKwd2+FchmBsKMVkK5ffe
	w7TJaigUCp6xpMQty51e4grFQ6RIfLpUtKPVs6vRAPikZLo6mm/Nvwk9uvTXgB/hWt0R+lm
	cweUsr8+4m0/yaHT/iNzNDF73i0jrwWpT6CNWKpTFV86mDi+zZMnhrduFvE+06y/kw8hVvX
	75d+c1+0HeRFJuD61aepfayLKBGAA4YWV8TaGqoA0EpJ0yqrw415+C5IxP/NoQIGJIvmmm6
	6ES9FMgqxNH4qCHgN0SN1I6dViLpCBL/BLWow9oKMCJdTBdlmxtrp3GKqv9TX/cOORHpi+Y
	4v4U8LHxf4yDqVNTyDh2vJ0NajOaCGSQvwjnRluZl7z4Lw8Foeahg2/Fbdw/8vUEoF/ox6z
	BhkcZn3/JlNjYOgylpXpQ1FWRyanozXXk1T+v5WH8hHT4GntN0hyd9Gmn4isk=
X-QQ-XMRINFO: NS+P29fieYNwqS3WCnRCOn9D1NpZuCnCRA==
X-QQ-RECHKSPAM: 0

From: Xu Rao <raoxu@uniontech.com>

Commit 3d9f32e02c2e ("media: uvcvideo: Create an ID namespace for
streaming output terminals") added a separate internal ID namespace for
streaming output terminals.  The namespace is only valid for those
terminals because their descriptor IDs are used by streaming interface
bTerminalLink fields, and uvc_stream_for_terminal() intentionally masks
the internal namespace bit when matching that link.

The parser currently decides whether to use the namespace with
`type & UVC_TT_STREAMING`.  Terminal types are values, not bitmasks.
Since UVC_TT_STREAMING is 0x0101, standard non-streaming output terminal
types such as UVC_OTT_VENDOR_SPECIFIC, UVC_OTT_DISPLAY and
UVC_OTT_MEDIA_TRANSPORT_OUTPUT also make the test true through their
0x0100 bits.

Those terminals can then receive an internal ID that differs from their
descriptor ID even though normal UVC descriptor references still use the
8-bit descriptor ID.  This can make later entity lookups fail or hide an
entity ID collision that should be handled as a regular UVC descriptor
collision.

Use an equality check so that only UVC_TT_STREAMING output terminals
enter the separate namespace.  The issue was easy to miss because real
streaming output terminals make both the bitwise and equality tests true,
so the devices targeted by the original change keep working.

Fixes: 3d9f32e02c2e ("media: uvcvideo: Create an ID namespace for streaming output terminals")
Cc: stable@vger.kernel.org
Signed-off-by: Xu Rao <raoxu@uniontech.com>
---
 drivers/media/usb/uvc/uvc_driver.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/media/usb/uvc/uvc_driver.c b/drivers/media/usb/uvc/uvc_driver.c
index e289cc71ba98..acfc5797a1c2 100644
--- a/drivers/media/usb/uvc/uvc_driver.c
+++ b/drivers/media/usb/uvc/uvc_driver.c
@@ -1130,7 +1130,7 @@ static int uvc_parse_standard_control(struct uvc_device *dev,
 		 * so limit usage of this separate namespace to streaming output
 		 * terminals.
 		 */
-		if (type & UVC_TT_STREAMING)
+		if (type == UVC_TT_STREAMING)
 			id |= UVC_TERM_OUTPUT;

 		term = uvc_alloc_new_entity(dev, type | UVC_TERM_OUTPUT,
--
2.50.1

