Received: from mail-pj1-f53.google.com (mail-pj1-f53.google.com [209.85.216.53])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9E0C72C237C
	for <stable@vger.kernel.org>; Sat,  5 Sep 2026 00:36:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.216.53
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1788568565; cv=none; b=C4ZM1SxyamypnnQvUIXwtW8ks8B25pw5BRlPNKwCJVkr7RFmaaIzbij5Wjqw/aU5QUns15VgUYwENhZTqw5FBMxXG2Mlz2q3UBbkJptFNCcWETv1kYjyKyAbsEKKW8XNI8DNOq6Cg4edLPeBsRTvJh1eTN0IVoqjXuprgW632zE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1788568565; c=relaxed/simple;
	bh=4ocR7EIzawTfTG7p/inFgc30YXw4KjBNKt9fYUmExSk=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=nzDjQrE98HUree8AY2X0DSTatZEf9tVIAPyqdPGLKeMedLV1gOKqpj7G+GMycbpGIywXUv6Va4tt7uImv/ZJMOLN56ON6e5hz3A0uie+HZrQUDPbgUbHYm5e3eZWVx0ASlB95VzbxPNUtnp/679+irjLJoZYoiSr6HbnUwh/kXw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=svZS+au8; arc=none smtp.client-ip=209.85.216.53
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="svZS+au8"
Received: by mail-pj1-f53.google.com with SMTP id 98e67ed59e1d1-3964dfb5b9aso2019452a91.1
        for <stable@vger.kernel.org>; Fri, 04 Sep 2026 17:36:02 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1788568561; x=1789173361; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to:content-type;
        bh=LD3OLCMtVZNmVhZuxqAq1q8x8oye3KoraYKv1uY4dv4=;
        b=svZS+au8HnLlsqOl0KVxOqPanEvmr5rMmdq72mQzFkomkr7dV/SlMEdiWViNW3s5Ex
         KpkRhpBwnJqrOjVJ+i8GJKegqVgAyCwT7cdlhtHZBJz9fJC2zY00xsWb7vSCyuK5vsYP
         Sfsm/RhUvOUKqSt+tSgdQfDwKLXn4YYHGpAGoNmhXJ8zAK441v7Fw4z2QdE6rlbqWaFH
         pfKG8ylaIaIPa6536XQGstvuc0g15PK4u2hs2VI9AsDXRSQfmRTQPr5/JaZMdZI+b81o
         GvHumgbXV9JVmRFd0vmMG2V28i1EqQU7w93UoYXvqnMy9LJPDj3Pxy9DcLBG7yTyDBBB
         SKSQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1788568561; x=1789173361;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=LD3OLCMtVZNmVhZuxqAq1q8x8oye3KoraYKv1uY4dv4=;
        b=plTEZZcX/6Hh4OUiu9AzCF01OLwBBFesctDxesLVdJ47bmlHm8nkkxTBA4v2uC1LyM
         hXTrVsbEk2gp9abS2jkgLrhNnm78p1oRS2AqB3NrLdKs9rlqCASUDfOgW+CUD4CuyCtP
         Mk52HyIvZQZ00Z9kdZpXXJictdJduu0BOAXNzoL44H930ssVGA3oZtCfw9coJHPYr3dp
         J4nyRTbIcMTeGHwPYjMc0HqVPWGnGtEx7hDZO3ONA8h5V5ehDGBiJCkneAIwHLIszGhq
         2wJ+aEsh+3oxuWb6uTg9R3QEE2f9m5mugz/9Eg5c5s/DOaYBlnCyie4pVlmjNGc859mH
         +RJA==
X-Forwarded-Encrypted: i=1; AKwUvBw1+/Gvp9QfEsI0YrJUP2Pu3dEHuL6I1NtgNibbyvu2rW8f+2XfPmO2idyq0Lk3sgnGUpzks7s=@vger.kernel.org
X-Gm-Message-State: AFuF++kQ1IadH8kODcrifzTcoDH60R6Ehpcnar1cn+vmLPoEyInpRZnl
	oG1gupTHPwiylsEunRJRsfgzk+VabBA0oK6cWyA7LXzc60xXEEQDsnqA
X-Gm-Gg: AYBFou1i8nkhDVFZj5HYdLUfX6iLQVy3bEU9rFwTX//zpk67QZrmAuHNcGllMgQLUjV
	2JSN45vwbxH9au6fu0m8hJjOlVaWLvInhdMLQr+DSzNWQ6f2DqtqbDWDcQ9btf9+cfyx0IXG7Uc
	cCh3TaVaxlstVUUmfDK2tB8LmtCEcU2ya1EmGC9A2RLd+xLl8vhZKBevzy6d0BoNZPoyhQJgzGo
	Lq/6ShlfKRAmOQarKF6LcO49i6O8vwBqMgXh0zSJm4cADj1ybIRySXWSPjGeH3t6BrJWyVYaUxp
	82w3NRRUlb85scHwKSukBV6ccyV5xFIKezudr1wNaxK/yuy7js/PID44lFFNSAp44T8utvRuTwG
	moWI6MU5RhSt9wntjNEn5qrnBcGBNKhNak1lLVgC7mhAnSFAcp+jFE08fu2PejJoZkIVCBA8VGE
	d1u9xO7lof7Bj3ugEBfm3EMpQZhdFx6e9X7ADARVM9ZeYcSpweCTSHprMAuN3o
X-Received: by 2002:a17:90b:50cc:b0:396:65dd:4093 with SMTP id 98e67ed59e1d1-39b26202ebamr14823913a91.14.1788568561231;
        Fri, 04 Sep 2026 17:36:01 -0700 (PDT)
Received: from tradnomic.. ([2601:646:8300:7570:4132:9566:38a4:e435])
        by smtp.gmail.com with ESMTPSA id 98e67ed59e1d1-39b2612ba2bsm6549744a91.14.2026.09.04.17.36.00
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 04 Sep 2026 17:36:00 -0700 (PDT)
From: Rafael Alejandro Diaz Cruz <rafad900@gmail.com>
To: gregkh@linuxfoundation.org
Cc: linux-usb@vger.kernel.org,
	stable@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	Rafael Alejandro Diaz Cruz <rafad900@gmail.com>,
	syzbot+4a5c87a01894ca37f25c@syzkaller.appspotmail.com,
	Alan Stern <stern@rowland.harvard.edu>
Subject: [PATCH usb-next v2] USB: gadget: Fix UAF in gadgetfs_fill_super()
Date: Fri,  4 Sep 2026 17:35:58 -0700
Message-ID: <20260905003558.1686039-1-rafad900@gmail.com>
X-Mailer: git-send-email 2.43.0
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

When gadgetfs_fill_super() fails, it's error path calls
put_dev() which drops refcount inside the_device to 0
and frees the objet. But the_device pointer is not
cleared, leading to point at freed memory.

VFS will then call gadgetfs_kill_sb() after mount
failure leading to put_dev() to be called on the
already freed pointer.

Fix by setting the_device = NULL during error path
before calling put_dev() inside gadgetfs_fill_super()
so that gadgetfs_kill_sb() skips put_dev().

Fixes: 1da177e4c3f4 ("Linux-2.6.12-rc2")
Reported-by: syzbot+4a5c87a01894ca37f25c@syzkaller.appspotmail.com
Link: https://syzkaller.appspot.com/bug?extid=4a5c87a01894ca37f25c
Signed-off-by: Rafael Alejandro Diaz Cruz <rafad900@gmail.com>
Reviewed-by: Alan Stern <stern@rowland.harvard.edu>
---

Changes from v1:
    
    Removed unecessary reference to syzkaller in the description.

    Added Reviewed-by: tag.


 drivers/usb/gadget/legacy/inode.c | 1 +
 1 file changed, 1 insertion(+)

diff --git a/drivers/usb/gadget/legacy/inode.c b/drivers/usb/gadget/legacy/inode.c
index d87a8ab51510..3e2bce7543d4 100644
--- a/drivers/usb/gadget/legacy/inode.c
+++ b/drivers/usb/gadget/legacy/inode.c
@@ -2059,6 +2059,7 @@ gadgetfs_fill_super (struct super_block *sb, struct fs_context *fc)
 	rc = gadgetfs_create_file(sb, CHIP, dev, &ep0_operations);
 	if (rc) {
 		put_dev(dev);
+		the_device = NULL;
 		goto Enomem;
 	}
 
-- 
2.43.0

