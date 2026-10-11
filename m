Received: from mail-ot1-f49.google.com (mail-ot1-f49.google.com [209.85.210.49])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0A0353BCD1E
	for <stable@vger.kernel.org>; Sun, 11 Oct 2026 06:36:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.210.49
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1791700581; cv=none; b=jiJOafu9o01tnf6Y0tu2o01wehtEg92upa3LCKW0Wvb93UGtfIftfukCR+nSUeueLfzpQ4qIaW0D4QeP00kDK+Na/CMXAS25OWzVrVGG3aQJtselcdKr7BSfrmfN0p0qQiSeiKRY0cPQ0kXiZ/Z8GjIMHcYdohNb9GUYtnyhmkI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1791700581; c=relaxed/simple;
	bh=prUNl9Z3gcOH8KCwu2iLC11/emUOJ7Zx5E9zrzmAYjo=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=tAYfx6t9Ax6bx/C9OzmhZJ2Lei4u/tmNLorcst3FtOVPsWgt5M6br9zCY24fK5C9AM8BpmA+XlhG7TZADx71O8woHaOzjO/hirARziL2WGm8Zq5uQXCrZn1yYHUsbH7m39P17LcpoY/fvyzI8p2V/uqnGAnkS84tunXIAdyrWUU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=Q5VjmON+; arc=none smtp.client-ip=209.85.210.49
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="Q5VjmON+"
Received: by mail-ot1-f49.google.com with SMTP id 46e09a7af769-825572e6701so607063a34.2
        for <stable@vger.kernel.org>; Sat, 10 Oct 2026 23:36:19 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1791700579; x=1792305379; darn=vger.kernel.org;
        h=content-transfer-encoding:content-type:mime-version:references
         :in-reply-to:message-id:date:subject:cc:to:from:from:to:cc:subject
         :date:message-id:reply-to:content-type;
        bh=eLizfgiIkYBIN6spMs2WJIgN1i9NSTMyDsWz9E36Flw=;
        b=Q5VjmON+C2lP/Xv3+4/f/FqigU0ONXlxgYtVDu5c2pwvwgqnt74yyyZRjBLQUw3Hhp
         zNCSQKF6HlcPkzks1h3PLqgvvRgz8IxI9/f0+lROGqL5/RAyGnaQngSMX/+Y5ERoobtQ
         RKuCtU0Lagmvq26N1MBtivkgZprExw4743Uu1uzqK2+PnBfqtu8mC/7zJHFhhT2o4xpT
         rDf5sFRw5fQUaaWSK92WIg4T+Si+VfLGe3V1pj/tnRlsuUmoYc2tQFGhzdd9NDsCyuob
         JqnpRfhSW69aJ4neEcdr+kISoEzFovsLIbekUd6SvfjKxqFcXthYAzVMfdDJKeAlvz31
         uaGw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1791700579; x=1792305379;
        h=content-transfer-encoding:content-type:mime-version:references
         :in-reply-to:message-id:date:subject:cc:to:from:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=eLizfgiIkYBIN6spMs2WJIgN1i9NSTMyDsWz9E36Flw=;
        b=2FnLBD3Bk+PjnUFK2WnZA2R65isJkm35j0yW3nspIOzcX9TatYaCUeWdoGD5t4cONg
         IKPrqzjRE6Md7eqXaOSJFKQLmLdUE3KjcfKJoZNdA+xYg1ZZfAcDJ0BEOt9H9ewrUVha
         larfiHjOb8b9PKxrYCjDbuHugOdFkxuSDpQa5t5g+OOc/FQ71XEAoYHPMRtWfm6jzFt9
         XSZXfikFeyoYFWjx9r99vLLLh39cx9yAOdT6qL7cwnu3cehr4TOABfctPCwPZPKZHUNp
         KLSvi1xTCi6fPGtWF9S/aMiDt41ZRYH/G34HtFtVds7MkvWlrcsCdSMhHCbgjz6fGAGf
         XTIw==
X-Forwarded-Encrypted: i=1; AKwUvBwY8eZhohONZw5BXrIAz9LNXAzjDi2vf3FEFs2l7WneU1/nJIVzhjbg5+Tpvw+e79dsmEGJDyY=@vger.kernel.org
X-Gm-Message-State: AFq9FYJIbJ0XooZ0P7d3KRXp1U7/yXCwVoWY7WNLwt01Eog0GZdLI6nx
	Pqe04jod+h+2ls+rGvAsJExQs6MKcBydI8FbCES42JwlRKWukONla8Jz
X-Gm-Gg: AYBFou3dL9jmFwFx5Kep5omsp18NU7PD5IDeaai5XDlPy82nAvUDc+pIsusH4nBiI0E
	P70JmNEL2rRZP3h4iEzu+pI10U/83EOBu4cvXguE9fNDZSYFtYPHtRzBWe2jfS3fMANcA9Cnv+L
	QG3YTj7+iGMVRatnfVugPVohtyKZozDwhcIFZexZrvzONlnXu08EzJvBh6JAnRxhCsgSltQVkut
	SLNRaq13N8WCT0t0DJaJCjuYNldSFygWDaxcBWVn4U2ZbeQP0oZ8EiFH6C+TxCqMcK7+tExr9Be
	QBDLF7vpnl68E2sdntzPHBfjUMJ7DoW5X0j9VxTK0au9I2VyKdiYfKWs6I1N0+WusnffZuh5EJs
	PwG8yxvQpxhDEbocKk6defzUfm7kXk0Od9OVLaD3DcCgThkCbfk5VgqVoSxzwN8fjG3EHOn771M
	PIEij+fPL0LL2RNgUxy4NIUYXmaqoOFURDiBmladrZ4ykGrRdtmwgPJQs7yVjJNPW7hqzY0bMmJ
	fMVB5yLW9ukqeFQVUUsPKFOQuxDypX363YbGASsLliMboC5H64zYXIEzUKGGneFVjpldHDkFJuo
	VbspIQokCEWDZSYS83/tcm7V1xM=
X-Received: by 2002:a05:6830:3815:b0:830:43b8:72db with SMTP id 46e09a7af769-83096fad2f8mr4487779a34.24.1791700579004;
        Sat, 10 Oct 2026 23:36:19 -0700 (PDT)
Received: from fedora-laptop.tail348456.ts.net ([172.245.82.59])
        by smtp.gmail.com with ESMTPSA id 46e09a7af769-8303a515aa9sm6593164a34.25.2026.10.10.23.36.15
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sat, 10 Oct 2026 23:36:18 -0700 (PDT)
From: Ming Lei <tom.leiming@gmail.com>
To: linux-block@vger.kernel.org
Cc: Ming Lei <tom.leiming@gmail.com>,
	Jens Axboe <axboe@kernel.dk>,
	Caleb Sander Mateos <csander@purestorage.com>,
	Josef Bacik <josef@toxicpanda.com>,
	Li RongQing <lirongqing@baidu.com>,
	stable@vger.kernel.org
Subject: [PATCH v3 04/12] ublk: reset the FETCH round in release also without a disk
Date: Sun, 11 Oct 2026 01:35:47 -0500
Message-ID: <20261011063555.1142277-5-tom.leiming@gmail.com>
X-Mailer: git-send-email 2.55.0
In-Reply-To: <20261011063555.1142277-1-tom.leiming@gmail.com>
References: <20261011063555.1142277-1-tom.leiming@gmail.com>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit

The release of /dev/ublkcN resets the queues only when the device has a
disk. Without one it skips ublk_reset_ch_dev():

  server fetches, never starts;         old server exits
  or STOP_DEV removed the disk           release: no disk → skip reset
                                         ios stay ACTIVE / CANCELED,
                                         nr_io_ready stays full
  new server opens /dev/ublkcN           FETCH: -EBUSY (still ready), or
                                         -EINVAL after a partial round
                                         → the device can only be deleted

All uring_cmds are done when the release work runs, with or without a
disk, so the reset is safe either way. Do it in both cases. Then a new
server can fetch and start the device again, as the STOP_DEV entry in
Documentation/block/ublk.rst says ("ublk device is ready for the new
process").

Fixes: 82a8a30c581b ("ublk: improve detection and handling of ublk server exit")
Cc: stable@vger.kernel.org
Tested-by: Josef Bacik <josef@toxicpanda.com>
Signed-off-by: Ming Lei <tom.leiming@gmail.com>
---
 drivers/block/ublk_drv.c | 10 +++++-----
 1 file changed, 5 insertions(+), 5 deletions(-)

diff --git a/drivers/block/ublk_drv.c b/drivers/block/ublk_drv.c
index e57c0626b84f..35202789cf98 100644
--- a/drivers/block/ublk_drv.c
+++ b/drivers/block/ublk_drv.c
@@ -2551,12 +2551,13 @@ static void ublk_ch_release_work_fn(struct work_struct *work)
 	}
 
 	/*
-	 * disk isn't attached yet, either device isn't live, or it has
-	 * been removed already, so we needn't to do anything
+	 * No disk: the device isn't live, or it has been removed already.
+	 * There are no requests to abort, but the round still has to be
+	 * reset, so that a new server can fetch and start the device.
 	 */
 	disk = ublk_get_disk(ub);
 	if (!disk)
-		goto out;
+		goto reset;
 
 	/*
 	 * All uring_cmd are done now, so abort any request outstanding to
@@ -2617,10 +2618,9 @@ static void ublk_ch_release_work_fn(struct work_struct *work)
 unlock:
 	mutex_unlock(&ub->mutex);
 	ublk_put_disk(disk);
-
+reset:
 	/* all uring_cmd has been done now, reset device & ubq */
 	ublk_reset_ch_dev(ub);
-out:
 	clear_bit(UB_STATE_OPEN, &ub->state);
 
 	/* put the reference grabbed in ublk_ch_release() */
-- 
2.55.0

