Received: from mail-pj2-f12.google.com (mail-pj2-f12.google.com [74.125.227.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6ECEE4195D0
	for <stable@vger.kernel.org>; Mon,  5 Oct 2026 12:36:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=74.125.227.140
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1791203770; cv=none; b=liibfw5FkH5IuOmUfVRmUQ/gEW9YFefCt57d+bDwVkBR0YrxIg3E9wg9Lo/4zROVDmkbmC2vrdrBZaE+iSnK5hiZTiQfYwqv4oKr0ZzHzyu4hCSSpj0JnFTjBJEm8vi+eo2nR9bIxpm1xklHBp9C+Gk6R/rj0qpAyHH6NvfWphI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1791203770; c=relaxed/simple;
	bh=QQ//D5UNEFrMdGNsE0x2XqrDjRfkmbQnZlSDOkPsLjM=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=nsISrUI+HdQlwx2rffwX0I/alKug/8gjTIi4ZgWEDZ2hJP3Wy3FnCeQV5P7PwSygWm/ClRWZhQe6lF7CesT6Xb2qDUNMzzhcgcaGxQWs8GX0GGIDwvIcAm9RAF7M8z17T58cQjEHhWyJ5PhGa6AJoaYKV2Cpy9dMsKDyYdTZOKM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=isslab.korea.ac.kr; spf=none smtp.mailfrom=isslab.korea.ac.kr; dkim=pass (2048-bit key) header.d=isslab-korea-ac-kr.20251104.gappssmtp.com header.i=@isslab-korea-ac-kr.20251104.gappssmtp.com header.b=LRrDNRz0; arc=none smtp.client-ip=74.125.227.140
Authentication-Results: smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=isslab.korea.ac.kr
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=isslab.korea.ac.kr
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=isslab-korea-ac-kr.20251104.gappssmtp.com header.i=@isslab-korea-ac-kr.20251104.gappssmtp.com header.b="LRrDNRz0"
Received: by mail-pj2-f12.google.com with SMTP id d9443c01a7336-2dd58e1e2c7so6146445ad.0
        for <stable@vger.kernel.org>; Mon, 05 Oct 2026 05:36:06 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=isslab-korea-ac-kr.20251104.gappssmtp.com; s=20251104; t=1791203765; x=1791808565; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to:content-type;
        bh=4jU8vbkoMdpm/iDka5HS8l6OLmahdMWqgTkrbnwvknU=;
        b=LRrDNRz0pHvIpLpLE2H9qGw9RxTzk6KPEJByVvSTdcI1tFZDoj7i+fjzwbHLVVRtD3
         gpxJcOa4kN5oAMIlIIjX1aH+s8EW5f2m+zEsQ0s0JRIef8mYDo7iUh3DyU5lxbT6Pz/2
         VaDBzU9Zm50NzDVD66drpFqOyuGdNHTdU+qlxAPuLgVheNowU5BjxlMs7iSq4mNQBw+F
         2P33Z9u4PwhNUfLS7hEM5vv8FstSBsKehuH2jAuPUTI1YONbm59kB2rWd+BWBf1PMNOi
         wOKSm2Afa2Xi9OR/yzXxBQekswq5Y2sTrn8y/56E2bCtDBDH/RxV01xpAnDMSqw/89me
         c4bw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1791203765; x=1791808565;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=4jU8vbkoMdpm/iDka5HS8l6OLmahdMWqgTkrbnwvknU=;
        b=a/VJWJMkmELzlIYueJcYml9Ue8fm8v+IjXoEErFywJxI1NTM3FZ9Os1Kf+2uCghppp
         9ZPTuJfi54QH4/y/ZFm3aCnpFU8nk01sG2U9q33ynjnAEpOH86uh4mTpkCf0pc9+MYSL
         gvvAttjBn78nO/njGLJryAzfEOEUWeQR7ZApcDqfhuc2qnlS5YfvYq8RgCEqd8Y9Ylmq
         xQlVCorjcbtsOwxWDQI1O95dPeYRzhbxqYJemtI57Sah8t10gFYSaxgk2MvA9WGxe0RY
         gKb6Y2hYDEZWIRLx4u5DNIT8BCdErOyT26oz6XVR2APfuuDxuBPIkUXXLSHPkDhqUdJi
         B/lw==
X-Gm-Message-State: AFq9FYKfl9DcaBTh8OA/967ShoCdqcJHb1h75pPxEVqDscIDrYdtgQWN
	gsPMkNqxBmyKiU2iw734WjTZ+QX9xjEH1v8y9Rk8klHTW4FUsff2M+AWWXu+AeXLrY8=
X-Gm-Gg: AYBFou1kOaFdzGmKalKJrIhi3tsE69SwmW7NCZkIm1neCHiq4nWFXqHLXvIsskC3iYX
	vzlNIcQiRQBOFsUQ+WbcznMqJ7oD7sKl/76HlJmG5tLFhNjTj0MqMopMfUNbY8nWI47FuxzCFj1
	c4YKQZvwhqKuH40N060c8D8fCYs1jZp/5IQA6gfeUNnBx9mOB0YW7eV4pgp9tyLkFwWK894Hij6
	99QmKP8LSmyT0kIVY+JskllP+hAqk9eoCmSCzG2KUcfWXzyF5HrzCA8t02Ie8dfaxbFCB7a+cu/
	E3qauLQuXoflGRy+L9AkfYRsxGjmr0hAUSzzDE/RC3IPjUP25XTyPVf9bdCw6Kc7JwYjyH0YYee
	WYAMVBPwh0sBccamYzswsByjCc6NOzFJhiif3U/4GV5WexBGR5kraHKTVTEhCYXfivHLHUsIxvI
	vEOaf6yhLoq49qjaF3D3smL/kN9yuWk3wq1sal/+Yf7Eji2Ry/evpbwI3NH43AZMZ/YoOpPy0gu
	uQzT9VjZD5RNiJzskvMug==
X-Received: by 2002:a17:903:186:b0:2dd:c053:c209 with SMTP id d9443c01a7336-2e49b6df076mr106567665ad.37.1791203765331;
        Mon, 05 Oct 2026 05:36:05 -0700 (PDT)
Received: from yhlee-960QFG.Davolink ([2406:5900:1044:110c:5364:bba9:2adf:d611])
        by smtp.gmail.com with ESMTPSA id d9443c01a7336-2e5a5caea48sm6542495ad.14.2026.10.05.05.36.01
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 05 Oct 2026 05:36:04 -0700 (PDT)
From: Yehyeong Lee <yhlee@isslab.korea.ac.kr>
To: Juergen Gross <jgross@suse.com>,
	Stefano Stabellini <sstabellini@kernel.org>,
	Oleksandr Tyshchenko <oleksandr_tyshchenko@epam.com>,
	"James E.J. Bottomley" <James.Bottomley@HansenPartnership.com>,
	"Martin K. Petersen" <martin.petersen@oracle.com>,
	Boris Ostrovsky <boris.ostrovsky@oracle.com>,
	xen-devel@lists.xenproject.org,
	linux-scsi@vger.kernel.org,
	linux-kernel@vger.kernel.org
Cc: stable@vger.kernel.org
Subject: [PATCH] xen/scsifront: check for a NULL shadow entry on a backend response
Date: Mon,  5 Oct 2026 21:35:54 +0900
Message-ID: <20261005123555.253995-1-yhlee@isslab.korea.ac.kr>
X-Mailer: git-send-email 2.43.0
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

scsifront_do_response() validates the rqid in a backend response against
VSCSIIF_MAX_REQS before using it to index info->shadow[], but then
dereferences the entry to test ->inflight without checking that the slot
is populated.  Shadow slots are NULL before a command is submitted (the
host private area is zeroed at allocation) and are reset to NULL in
_scsifront_put_rqid() once a request completes, so an in-range rqid that
does not correspond to an outstanding request makes the frontend
dereference a NULL pointer.

A malicious or buggy backend can thus crash the guest by returning a
response whose rqid is in range but not in flight -- for example a
spurious response before any command has been issued, or a duplicate of
one already completed.  The ring has only VSCSIIF_MAX_REQS (16) slots, so
before the first command every in-range rqid selects a NULL slot.

Reject a response whose shadow slot is not populated.

Fixes: 6d1c2f48f3fc ("xen/scsifront: harden driver against malicious backend")
Cc: stable@vger.kernel.org
Signed-off-by: Yehyeong Lee <yhlee@isslab.korea.ac.kr>
---
 drivers/scsi/xen-scsifront.c | 1 +
 1 file changed, 1 insertion(+)

diff --git a/drivers/scsi/xen-scsifront.c b/drivers/scsi/xen-scsifront.c
index 989bcaee42caf..aa44a233eac8d 100644
--- a/drivers/scsi/xen-scsifront.c
+++ b/drivers/scsi/xen-scsifront.c
@@ -367,6 +367,7 @@ static void scsifront_do_response(struct vscsifrnt_info *info,
 	struct vscsifrnt_shadow *shadow;
 
 	if (ring_rsp->rqid >= VSCSIIF_MAX_REQS ||
+	    !info->shadow[ring_rsp->rqid] ||
 	    !info->shadow[ring_rsp->rqid]->inflight) {
 		scsifront_set_error(info, "illegal rqid returned by backend!");
 		return;
-- 
2.43.0

