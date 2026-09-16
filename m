Received: from smtpout-04.galae.net (smtpout-04.galae.net [185.171.202.116])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 04BEC37DE8B
	for <stable@vger.kernel.org>; Wed, 16 Sep 2026 14:59:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=185.171.202.116
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1789570744; cv=none; b=BzJ3eQ5T60+A4I3HNZN8G5D1i0qCAwKrT2UmFgPlnXWV/p3PD88nEHsCGiRIMO6NCoPhzuEr0lcpOEQzMJ1ifTbI2QE1ZMosZXyyAiODwk4Q9WHeSRbMCFqM2aKQqhbvolpVr0Ap8dd70Vhd+XIHH/MyaD2JJLRqnPE+TIIxXbw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1789570744; c=relaxed/simple;
	bh=hYAGqwpIs+x7LYly7KLF0A20MY3D38YyH5+WMGqiexU=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:To:Cc; b=Ind/sF0zo0h9eZAXSy+n559sQS3/DhuKiKQey5dlOGNQNocfRqFRxR6zjgkOUNK+DJOmnNi9ux/U//IngRgiofZEITYh7cCK+XWVZdGL9X6MPVxn/TABbn2b6kgKF74ymJQPh2CjQ53HEAhaIc68KBJf3NzHZJsV1m2i+yyXDAQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=bootlin.com; spf=pass smtp.mailfrom=bootlin.com; dkim=pass (2048-bit key) header.d=bootlin.com header.i=@bootlin.com header.b=scCdjC5J; arc=none smtp.client-ip=185.171.202.116
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=bootlin.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=bootlin.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=bootlin.com header.i=@bootlin.com header.b="scCdjC5J"
Received: from smtpout-01.galae.net (smtpout-01.galae.net [212.83.139.233])
	by smtpout-04.galae.net (Postfix) with ESMTPS id EA5F1C5CD65;
	Wed, 16 Sep 2026 14:59:42 +0000 (UTC)
Received: from mail.galae.net (mail.galae.net [212.83.136.155])
	by smtpout-01.galae.net (Postfix) with ESMTPS id EDF8E60337;
	Wed, 16 Sep 2026 14:58:58 +0000 (UTC)
Received: from [127.0.0.1] (localhost [127.0.0.1]) by localhost (Mailerdaemon) with ESMTPSA id 0725111C7B053;
	Wed, 16 Sep 2026 16:58:52 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=bootlin.com; s=dkim;
	t=1789570734; h=from:subject:date:message-id:to:cc:mime-version:content-type:
	 content-transfer-encoding; bh=d4xGQDZX4U8QpAwEXPvm3mMeXxrXd6x7U1+CxNxw4e8=;
	b=scCdjC5JbIx0uNzDPxuv64ierKBGjVF2gP420++asd1RFAbmLLQZDstZzW473T+aedgqVD
	kdz/jWEWxGtVXKTzA8mZmsO7VjSTn9c+hUUnMYUmQqFj/bJcedL4Vfjx4qkX5YcrTHzky2
	Qli1MshnwP0Mvrzioga2/6XYYWVBjVBoT0xekSWY+L26zSPbXgkQknco+8WTwhBMJlzBTf
	QA+swc+8cyydQbNosKZj6vwdPHavZWHPe29xKRj9ScPnHKhnrUQRuvBuEO1zl3k7SgIR/y
	ChHnYbskLhVWCtKti6GoM1cYLWqKKBsOWMia2pyx11geSty97Bxy9TGB1oqAVQ==
From: "Miguel Gazquez (Schneider Electric)" <miguel.gazquez@bootlin.com>
Date: Wed, 16 Sep 2026 16:47:16 +0200
Subject: [PATCH 5.10.y] io_uring: fix uninitialized field in rw io_kiocb
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20260916-cve-2022-29968-v1-1-b092d165f9cd@bootlin.com>
X-B4-Tracking: v=1; b=H4sIAAAAAAAC/yXMwQ6CMBCE4Vchc3ZJ20ixvgrxUJZF1wOaFoiG8
 O5WPX6TzL8hS1LJOFcbkqya9TEV2EMFvsXpKqRDMZxx3gTriVehAkcuBH8iE5iPsW9bP0aU0zP
 JqK9fsENTW1O/cfnveenvwvO3hn3/AI9OSG16AAAA
X-Change-ID: 20260916-cve-2022-29968-09cc4ab776fa
To: stable@vger.kernel.org, Jens Axboe <axboe@kernel.dk>
Cc: Thomas Petazzoni <thomas.petazzoni@bootlin.com>, 
 linux-kernel@vger.kernel.org, Joseph Ravichandran <jravi@mit.edu>, 
 Sasha Levin <sashal@kernel.org>, 
 "Miguel Gazquez (Schneider Electric)" <miguel.gazquez@bootlin.com>
X-Mailer: b4 0.15.2
X-Developer-Signature: v=1; a=ed25519-sha256; t=1789570732; l=1215;
 i=miguel.gazquez@bootlin.com; s=20250708; h=from:subject:message-id;
 bh=84RmxuZXpL6G97dB8g/4T3Q7NZ/u8ZiPAqxX8xnx0VA=;
 b=rEuEOwAI9eU7j5jyWtDIj1CRQC56n6ujtpRiiUR68Idb+EuH6mPXEYiwezGguwn0ghWD5KQmh
 bdNnPOhmB+QC6y+mMUbDC/7W17/BK1nr1FKPrEj3/KKc/SSttCJPwOS
X-Developer-Key: i=miguel.gazquez@bootlin.com; a=ed25519;
 pk=k/2KI9jkmayaF0ghZ8QYUH9Wm/kFHDhl8QoZ0RHbr4w=
X-Last-TLS-Session-Version: TLSv1.3

From: Joseph Ravichandran <jravi@mit.edu>

[ Upstream commit 32452a3eb8b64e01e2be717f518c0be046975b9d ]

io_rw_init_file does not initialize kiocb->private, so when iocb_bio_iopoll
reads kiocb->private it can contain uninitialized data.

Fixes: 3e08773c3841 ("block: switch polling to be bio based")
Signed-off-by: Joseph Ravichandran <jravi@mit.edu>
Signed-off-by: Jens Axboe <axboe@kernel.dk>
Signed-off-by: Sasha Levin <sashal@kernel.org>
Signed-off-by: Miguel Gazquez (Schneider Electric) <miguel.gazquez@bootlin.com>
---
 io_uring/io_uring.c | 1 +
 1 file changed, 1 insertion(+)

diff --git a/io_uring/io_uring.c b/io_uring/io_uring.c
index 01eff1694d8c..c1716140348b 100644
--- a/io_uring/io_uring.c
+++ b/io_uring/io_uring.c
@@ -2985,6 +2985,7 @@ static int io_prep_rw(struct io_kiocb *req, const struct io_uring_sqe *sqe,
 		    !kiocb->ki_filp->f_op->iopoll)
 			return -EOPNOTSUPP;
 
+		kiocb->private = NULL;
 		kiocb->ki_flags |= IOCB_HIPRI;
 		kiocb->ki_complete = io_complete_rw_iopoll;
 		req->iopoll_completed = 0;

---
base-commit: 1797d8bf8d0c2e74defad605d14e3553d43a3caf
change-id: 20260916-cve-2022-29968-09cc4ab776fa

Best regards,
--  
Miguel Gazquez (Schneider Electric) <miguel.gazquez@bootlin.com>

