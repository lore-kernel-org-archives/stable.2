Received: from mail-pl1-f182.google.com (mail-pl1-f182.google.com [209.85.214.182])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 145D234B19F
	for <stable@vger.kernel.org>; Wed,  2 Sep 2026 01:37:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.182
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1788313057; cv=none; b=dZXtt8VZCSO7LATi6MBj5+TC4eoLXTmUT6NAY116CgNjHhh8r2mqPSC4/HJ1GG0Q2Av8JBFQ12gNsu90SUgWP8xuBeVpYYp+xCdK+I/NuNAEitBRUjQl1j3eH8wrmSurLYoYHIXbJwvLUlw0WkfvKSWlC7cYUuYzBnGon+9VLAU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1788313057; c=relaxed/simple;
	bh=NrAH008nQYMiy5+kqVbBiuaIHPaYC7zm9BY+XKP16EM=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=mqCXHs8RMK1kl6F557pBzJPwunCel6cMk9TbCLP3fGdZoHzQmU/0+R/OinOe3havgDWwdwpby5x5C038Y9NETkp0OFa6/UGKfT8+7fhGWT9yjXeB6WjlsRtu/W4olwuN2XsbO+96LnCXq6ehzHQwHKTQV7cWldItKM2bxbAHgs8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=i9dpNus4; arc=none smtp.client-ip=209.85.214.182
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="i9dpNus4"
Received: by mail-pl1-f182.google.com with SMTP id d9443c01a7336-2d944747d41so5399735ad.0
        for <stable@vger.kernel.org>; Tue, 01 Sep 2026 18:37:24 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1788313041; x=1788917841; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=yt47hjuFRmrWXIWHqaihRpAk0PWrFFvNkF4NbOnBXCA=;
        b=i9dpNus4Llg4iROHZj7bs5U1AOxapz/sEMP4Dq3TJ+hQ7vC5qyO/TY1JN2y1DXX2N3
         2CIkryAJaEUE3CL4nW39ufE9putZqN/YbruPUiUY2zC/kXozNgXyn0awNSo357YgC4T5
         Psu7CV77gNnYaKKBOH2hPv0u315dRj22OhzPrvzO6tFFqIurZvvKMvuHVr8kUOBMppM6
         GNVTFnKyloPxtZiRG0ZIb4rHnb2wghNPdI1dHBR1TJvJ7Z8YX7BlQ97KRZsDB1VQsfpc
         zLm0LvbVqq5c0G3NrZ4EIhnG94QHw6tsVgNXMpyiLItFw9/L/U/AEPP0TwwX6Y7rdNwe
         nKgw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1788313041; x=1788917841;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to:content-type;
        bh=yt47hjuFRmrWXIWHqaihRpAk0PWrFFvNkF4NbOnBXCA=;
        b=F7wn1Z2WNC1kY9Sw/P3jV7vGg4hHnC+qh+0ox7NBoDS2V9k9QTD3hvKSeJDLLApo/B
         ECrUJnMlazPh8B29YRDthlhSFyPP4m8SAzVTUzQxtqLSwBIE4DYrIaCenszo4dKh8cUm
         iedi93IOYfYezzNOClK8xqHIhovXh3uN4DLzUWfSvgv1a5LTeQIJ1XdgZZtIkNHTrucd
         sbPaf5P6zZwOtOMCSuthr/RGgL1xXTbwrkiuUsJt9o5VzvhnohxCOwnrOZWVNKW01xJI
         WFV784bguyLibAmC0QawBM+i1KrQJfo2rrGGcHFSiW7m0ogC2yYTDs6wKKGT/lZuDK1P
         10vw==
X-Gm-Message-State: AFuF++kwg6Pk2PLLyHuncZaPJrMFLXDtjFGYiRqKxhwi2NLL5ZoE7me0
	5/dpaVYyu0kUnaxdYakUv11q/pLNWNcuM+bE07RFsjodgYVllssqRn+IMgZGS5U=
X-Gm-Gg: AYBFou36lpbWl+CrJgUN7vbRVRcHpy2FakEOAt4Z5FzGP4lCifXg6VGiG8Mfj+Np58K
	uHggP5y0+kRpcbvlMErqW8/2DDBPQVnW3CfKR0qGZ9kWNxupYyXyt8ukaKtTW3JMJc5YILXVVEj
	Jdmz7DqZwFURLYiAmnAdEAwOGZuEXfdxe0kEGb7V3l2RLAfDb/Jv5dWpg2pFRtjdb0NB1m3IGhg
	CyoRK9NhXu+B6/9VeTjpisBuhdvDJzVmaKOAX8WBlsMMRYj069XaWLhD9vpvmSvwaSr8XPc3Dsc
	aepmy6p9mbsFBFhityLmVthDBOvfXAzbWLThOmwRlhEh7XWN1WI/w6lcm845DeNgVR7+d9eMFT9
	dkDWBicM8SqrgHOOkVSrIVrvVf3zBFC/VQQ99IwAQtZHOALmlr2Y7vfPCKCNBG5lYtu2dKnTMhm
	1LyLC+NQxYkrb0XN4ZMwoz4suy97zhyybPfEHJCsyjB1lLNbvaNmTDYcM9ZJcean32MdtapCGH4
	J1Dm0pi/OHsaww8
X-Received: by 2002:a17:902:ccd2:b0:2d8:d4ce:7e3a with SMTP id d9443c01a7336-2daec6e9924mr19235035ad.15.1788313039467;
        Tue, 01 Sep 2026 18:37:19 -0700 (PDT)
Received: from localhost.localdomain ([66.219.198.74])
        by smtp.gmail.com with ESMTPSA id 5a478bee46e88-32f079c0530sm1601475eec.3.2026.09.01.18.37.18
        (version=TLS1_3 cipher=TLS_CHACHA20_POLY1305_SHA256 bits=256/256);
        Tue, 01 Sep 2026 18:37:19 -0700 (PDT)
From: Rochan Avlur <rochan.avlur@gmail.com>
To: stable@vger.kernel.org
Cc: Rochan Avlur <rochan.avlur@gmail.com>,
	syzbot+d6540a3fa1626e11360d@syzkaller.appspotmail.com,
	Miklos Szeredi <mszeredi@redhat.com>
Subject: [PATCH 7.1.y] fuse: wait for FR_FINISHED on abort_on_kill to prevent use-after-free
Date: Tue,  1 Sep 2026 19:36:56 -0600
Message-ID: <20260902013656.17291-1-rochan.avlur@gmail.com>
X-Mailer: git-send-email 2.50.1
In-Reply-To: <2026083100-flyable-tidings-a936@gregkh>
References: <2026083100-flyable-tidings-a936@gregkh>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

The abort_on_kill path in request_wait_answer() calls fuse_abort_conn()
and returns without waiting for FR_FINISHED.  If fuse_dev_do_write() is
concurrently processing the same request (FR_LOCKED set), the caller
frees req->args while it is still being accessed, causing a
use-after-free.

Fix this by jumping to the existing wait_event(FR_FINISHED) instead of
returning early.  The wait will not hang because fuse_abort_conn()
ensures all requests are ended.

Reported-by: syzbot+d6540a3fa1626e11360d@syzkaller.appspotmail.com
Fixes: 204aa22a686b ("fuse: abort on fatal signal during sync init")
Cc: stable@vger.kernel.org
Assisted-by: Claude:claude-opus-4-6
Signed-off-by: Rochan Avlur <rochan.avlur@gmail.com>
Signed-off-by: Miklos Szeredi <mszeredi@redhat.com>
(cherry picked from commit 64b0b5cacbd2fea88001464cb712c9dfc795b26e)
---
 fs/fuse/dev.c | 3 ++-
 1 file changed, 2 insertions(+), 1 deletion(-)

diff --git a/fs/fuse/dev.c b/fs/fuse/dev.c
index 5aea3f4d3030..878b60e15eaf 100644
--- a/fs/fuse/dev.c
+++ b/fs/fuse/dev.c
@@ -580,7 +580,7 @@ static void request_wait_answer(struct fuse_req *req)
 
 		if (req->args->abort_on_kill) {
 			fuse_abort_conn(fc);
-			return;
+			goto wait_for_finish;
 		}
 
 		if (test_bit(FR_URING, &req->flags))
@@ -591,6 +591,7 @@ static void request_wait_answer(struct fuse_req *req)
 			return;
 	}
 
+wait_for_finish:
 	/*
 	 * Either request is already in userspace, or it was forced.
 	 * Wait it out.
-- 
2.45.2

