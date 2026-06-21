Received: from mail-pf1-f182.google.com (mail-pf1-f182.google.com [209.85.210.182])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BEEA240D588
	for <stable@vger.kernel.org>; Sun, 21 Jun 2026 04:34:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.210.182
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1782016497; cv=none; b=mgsqyJRUIm74OCY3od7o4xYCEJwBcMJyTXLz8/BbZMWnND8UjnTEo5wYHiI08xuupra8GqWPO5dnaQL2SvQ0WCogduBbYVjU5mLw770i5Md2i9TXDV3BNwIWXc7G0gc/AmzmCn3nAXtbcXRs6P414/QxWcSRzHuL7hvn7aRapws=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1782016497; c=relaxed/simple;
	bh=nJkwZ2j117c0Z3zPl5Dhlg/EXAbSwaozedbg+/sxW+M=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=D/mb1y9A2XCKfrsl/GMxoD5QjQlUN46SGsn/rzraoct4qvdcF+ofBxsaus54+yVXUm4DQtUrXnZTm0r4S82HgYXF/G9CEwmT5BumIv3ING1iPrmEBoibe2LqnT2n6A+CNFi4mAD9denScd+bw88GCEyyaBwwRZ3rKahedUpzn48=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=OgwvxGbo; arc=none smtp.client-ip=209.85.210.182
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="OgwvxGbo"
Received: by mail-pf1-f182.google.com with SMTP id d2e1a72fcca58-84537777d45so2567828b3a.3
        for <stable@vger.kernel.org>; Sat, 20 Jun 2026 21:34:56 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1782016496; x=1782621296; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=EZhvgXv/PGau/vVplEkRNj2uGEyJ8j257hahknRP+sc=;
        b=OgwvxGbocdOHyDkrOOyTeDCm9ykgdviAswa9nlkAFQ4RHgd4BM3vp+AYg6uacJRBQw
         SQDT/iyTobImI3mNRwTBPkWYL1JRFXrvOzkIakdmgohZpBnu7y/smexSzlzU58LhKTFK
         VkNzOozc4/QG13RxEUY8UGQRQ9NhjSLrp0Zk5i0BU79uybBTqfw4pETcC+/Uv02XaSrT
         eo9x5V+H1Rm4Qp8ZiXfQiZ0eFuBsVChlQQTg0kqrCdcHgtNSjezdqOF4oOEOGh/vsGog
         bwozvBj6kUJGp5aRlQfTYfqYA9zPpsNlsw/86MPXFF1HWlbOW0oMggqarERGpTqeJVHA
         cyDw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1782016496; x=1782621296;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=EZhvgXv/PGau/vVplEkRNj2uGEyJ8j257hahknRP+sc=;
        b=nlYNyfB1+i+wX9Jt/wzAZohpp4qiuZugN+1GdeE3fB2V1dP5ggsyzd3ioGKueuh9z0
         GHZuFUWiUzF6WYBDz6QR2P4OPnVB/3NJwnNov0hlz09feiE1dJ/u1Z3dNfuXqv2u+sxX
         28759sideuIrEfONbJd2hN5azScRezkuoX+kQTlBdHSiHrLN5f8aLoEq0jLu5p0Zm3x3
         32BVy1WUD+tMI6S/XVw/jqov5hXuVzHw5ezZq6AhMG97+XgWnHpgpeZ3HZID3nMUJVrD
         Xru5odx5xUmOuw8xEICuCSfhqPCzbmnA/Dunj89lAYGwqDNa2rgf4Io1RkcD5JwEVDn1
         I4gA==
X-Forwarded-Encrypted: i=1; AFNElJ9qkNmtsfkLGFs00fdsQnShcDUg0R4DPlzwtQ7Ey1nnI7LrFba0PpPfyCve1DXDumpjyw7/F2o=@vger.kernel.org
X-Gm-Message-State: AOJu0Yz8ISNjN2vZ7HiyiBygCwns3qlTmivqyuhrSqM21txk1cni08wh
	wRUqS7tbcRNwrjjUAn/IEKyye+Hw49vb9ltBh81Y8vE7NQjQXd5LrArq
X-Gm-Gg: AfdE7ckqRWbGic3b4XZ8ms98eQQE2c3nszE6Le13AuGxRR68meq08ostVAeCI+b5zUF
	BKqx5QLNmtLrZctaN5+znMYalRyNo0e0jxcFl9GCtw68QH772eKZhhSs7XXipBT7pgopFjF4dYJ
	3VGJNgEFOeE9zF2JT8JyYW3GeC2emRB6g31k2fLlcPFAywaBK78DJWD11pvqetySiEEjzfzl7Aa
	3VC6zmeJn+I+p2/3GK1m3oAtZR7uvZYFalkM8sagRsb6SrmxPNzXidH+YQMpjjxroA+6lDMkfMN
	4l/MMgRFoPvk0r5JabpmlSbkGiNhwdBQNLLOXOAgfIRbYPrncKi1yNLdk0e0h+2avZBweCxmqom
	7jssvLtTurtmnUAcQVa3CaLSGealoPCfVeqA+TfLos6LB48Mv0Q6pUs0mfiC+5GjOpSNBXfBhbv
	z/MzyudGXBuGpcA/XduevRrsLjB99wl6nM2+Ub4qlyW+3QZHt2maWh
X-Received: by 2002:a05:6a00:2e23:b0:845:3c47:9159 with SMTP id d2e1a72fcca58-845508e2719mr10476394b3a.45.1782016495956;
        Sat, 20 Jun 2026 21:34:55 -0700 (PDT)
Received: from localhost.localdomain ([49.207.234.96])
        by smtp.gmail.com with ESMTPSA id d2e1a72fcca58-84564d6813bsm3695572b3a.8.2026.06.20.21.34.51
        (version=TLS1_3 cipher=TLS_CHACHA20_POLY1305_SHA256 bits=256/256);
        Sat, 20 Jun 2026 21:34:55 -0700 (PDT)
From: Biren Pandya <birenpandya@gmail.com>
To: Hans Verkuil <hverkuil@kernel.org>,
	Mauro Carvalho Chehab <mchehab@kernel.org>,
	Kees Cook <kees@kernel.org>,
	linux-media@vger.kernel.org,
	linux-kernel@vger.kernel.org
Cc: hdanton@sina.com,
	syzbot+051024d603432b4ab395@syzkaller.appspotmail.com,
	syzkaller-bugs@googlegroups.com,
	Biren Pandya <birenpandya@gmail.com>,
	stable@vger.kernel.org
Subject: [PATCH v2] media: cec: disable delayed work before freeing an interrupted transmit
Date: Sun, 21 Jun 2026 10:04:37 +0530
Message-ID: <20260621043439.52943-2-birenpandya@gmail.com>
X-Mailer: git-send-email 2.50.1
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

cec_transmit_msg_fh() drops adap->lock to wait for a blocking transmit in
wait_for_completion_killable(). If that wait is interrupted by a signal,
cancel_delayed_work_sync() can run before the CEC kthread arms the reply
timeout via schedule_delayed_work(&data->work) in cec_transmit_done_ts().
The work is then armed after the cancel, and the data is freed with its
delayed_work still pending:

  ODEBUG: free active (active state 0) object: ... hint: cec_wait_timeout

Use disable_delayed_work_sync(): it cancels the work and disables it, so
the later schedule_delayed_work() becomes a no-op and the work cannot be
re-armed. The data is freed right after, so it need not be re-enabled.

Fixes: 490d84f6d73c ("media: cec: forgot to cancel delayed work")
Reported-by: syzbot+051024d603432b4ab395@syzkaller.appspotmail.com
Closes: https://syzkaller.appspot.com/bug?extid=051024d603432b4ab395
Suggested-by: Hillf Danton <hdanton@sina.com>
Cc: stable@vger.kernel.org
Signed-off-by: Biren Pandya <birenpandya@gmail.com>
---
v2: Use disable_delayed_work_sync() instead of reordering the cancel, and
    name the re-arm path. Suggested by Hillf Danton.
 drivers/media/cec/core/cec-adap.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/media/cec/core/cec-adap.c b/drivers/media/cec/core/cec-adap.c
index 8f7244ac1d43..acb0b5483bbf 100644
--- a/drivers/media/cec/core/cec-adap.c
+++ b/drivers/media/cec/core/cec-adap.c
@@ -965,7 +965,7 @@ int cec_transmit_msg_fh(struct cec_adapter *adap, struct cec_msg *msg,
 	 */
 	mutex_unlock(&adap->lock);
 	err = wait_for_completion_killable(&data->c);
-	cancel_delayed_work_sync(&data->work);
+	disable_delayed_work_sync(&data->work);
 	mutex_lock(&adap->lock);
 
 	if (err)
-- 
2.50.1

