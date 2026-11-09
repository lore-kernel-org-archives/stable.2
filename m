Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=115.124.28.97
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1794193592;
	b=DRUoX2BISX+E3c5y9WGwzpmdFWqFKfNuzwktTRS161s4gszNR6WZUHOz5vZXx9wCcXVu
	 3rDmnq6XpORCFMqwvrKUUNGEzjn1SuCDNPePZQJomI4UFqU8muBHogWPPAQ4TtcB2qQs4
	 CXZnaGj6PIg5os0n6WvQRgazacUVkfBS4krIe5HXfuSHb3hVBZlMkxnazR00Gx6vhFmr8
	 bU1yeKziAEusV7d4viGqT/sVOGjOqlrb5HVC5gTQ7uZb01sQjg1lN0Rh4AQIU5VPmfB5Z
	 l/17szqSmSr2iQZkmuj2VazzUeACcnoxObyr+UJ0ap6YBXfoNVyDH0dPDOEq13P8AjQ==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1794193592;
	h=DMARC-Filter:DKIM-Signature:X-Alimail-AntiSpam:Received:From:To:Cc:
	 Subject:Date:Message-ID:X-Mailer:In-Reply-To:References:MIME-Version:
	 Content-Transfer-Encoding;
	bh=kZF80Iys/gOjxeFVwPFWc6WLyNpnR6vz38Zx5DRZCVA=;
	b=w4vowwT08ye3kEvKYcp+api/T4JN9ivWGkYojC+dXgKThT7IZ+nSkF4Mb5ad9wNV8EfE
	 czmyKQDzaNnGgVsA7dRWodAZcDzWP820YLZmDkMXJ4LmO2qQwzcgEA97UgujHM3ctRtun
	 4bz16YA7CweDl8jUJRxxzPF3rhH1Ls0lFNbGGzRsBCasOjHM+2Yen9AxZP03EWktPMBXv
	 XS/iRmqHj8Ru9rdK9smg7OWf0D7L/n/LkjaoeWHtTysza3yIUwDYtI0Do0Ip6GHJ6oScD
	 T7C0l0GCc61sbRYpBJziNirObAtAAluij+0t6He2sicZ+V4/B2KewaMcRZYWqOtlsig==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=none header.from=xiaopeng.com;
	spf=pass smtp.mailfrom=xiaopeng.com;
	dkim=pass header.d=xiaopeng.com header.i=@xiaopeng.com header.a=rsa-sha256 header.s=default header.b=B2dUuff+;
	arc=none smtp.remote-ip=115.124.28.97
Received: from out28-97.mail.aliyun.com (out28-97.mail.aliyun.com [115.124.28.97])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 36D40606A323
	for <stable@vger.kernel.org>; Mon,  9 Nov 2026 03:06:30 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 36D40606A323
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=xiaopeng.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=xiaopeng.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=xiaopeng.com header.i=@xiaopeng.com header.a=rsa-sha256 header.s=default header.b=B2dUuff+
DKIM-Signature:v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=xiaopeng.com; s=default;
	t=1794193582; h=From:To:Subject:Date:Message-ID:MIME-Version;
	bh=kZF80Iys/gOjxeFVwPFWc6WLyNpnR6vz38Zx5DRZCVA=;
	b=B2dUuff+ISC2YzxuAxJz/bt7uglYa0FrFZBHtpJDigSc9ffSyUqnbA5ScwhtnKsQgqGZ1ZxgtmPr6E8Y39rN9WDL7QyCEyvLgTKb+PzoEmOgvwzyqRvwwghSjlYRJwzruqAY9dENOHWF990OqfwsWHP+VgU8RtZrwAisRl43uaY=
X-Alimail-AntiSpam:AC=CONTINUE;BC=0.07463553|-1;CH=green;DM=|CONTINUE|false|;DS=CONTINUE|ham_system_inform|0.000766814-5.69194e-05-0.999176;FP=16997242591181295080|1|1|2|0|-1|-1|-1;HT=maildocker-contentspam033045099153;MF=zhugl3@xiaopeng.com;NM=1;PH=DS;RN=3;RT=3;SR=0;TI=SMTPD_---.jzg.W-9_1794193581;
Received: from DESKTOP-UL5U09E.xiaopeng.local(mailfrom:zhugl3@xiaopeng.com fp:SMTPD_---.jzg.W-9_1794193581 cluster:ay29)
          by smtp.aliyun-inc.com;
          Mon, 09 Nov 2026 11:06:21 +0800
From: Guanglei Zhu <zhugl3@xiaopeng.com>
To: stable@vger.kernel.org
Cc: liuwb@xiaopeng.com,
	Mark Brown <broonie@kernel.org>
Subject: [PATCH 5.15.y] spi: bcm-qspi: reject oversized dummy bytes in mspi exec_mem_op
Date: Mon,  9 Nov 2026 11:06:20 +0800
Message-ID: <20261109030620.419512-1-zhugl3@xiaopeng.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20261107060704-failed-5.15-9e44f0df3fff@kernel.org>
References: <20261107060704-failed-5.15-9e44f0df3fff@kernel.org>
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

From: Weibin Liu <liuwb@xiaopeng.com>

[ Upstream commit 9e44f0df3fff215d9033089e85980048c3ac132a ]

bcm_qspi_mspi_exec_mem_op() builds a local command buffer cmd[6]
holding one opcode byte, up to four address bytes and one spare
byte, and sets t[0].len = op->addr.nbytes + op->dummy.nbytes + 1.
bcm_qspi_exec_mem_op() only validates op->addr.nbytes <= 4 and never
bounds op->dummy.nbytes, which spi_mem_check_op() also leaves
unrestricted. With addr.nbytes = 4 and dummy.nbytes >= 2 the length
becomes 7 or more, so write_to_hw() reads past cmd[] on the kernel
stack and pushes the leaked bytes into the hardware TXRAM.

Reject operations whose dummy phase does not fit the remaining byte
of cmd[] by requiring op->dummy.nbytes <= 1, so such transfers fall
back to the generic SPI path instead of overrunning the buffer.

Reviewed-by: Guanglei Zhu <zhugl3@xiaopeng.com>
Fixes: 5f195ee7d830c ("spi: bcm-qspi: Implement the spi_mem interface")
Cc: stable@vger.kernel.org # 4.18+
Signed-off-by: Weibin Liu <liuwb@xiaopeng.com>
Link: https://patch.msgid.link/20261015-bcm-qspi-dummy-bytes-v1-1-c319da3c2497@xiaopeng.com
Signed-off-by: Mark Brown <broonie@kernel.org>
[ Adapted for 5.15.y: this tree returns -ENOTSUPP instead of -EOPNOTSUPP. ]
Signed-off-by: Guanglei Zhu <zhugl3@xiaopeng.com>
Signed-off-by: Weibin Liu <liuwb@xiaopeng.com>
---
 drivers/spi/spi-bcm-qspi.c | 3 ++-
 1 file changed, 2 insertions(+), 1 deletion(-)

diff --git a/drivers/spi/spi-bcm-qspi.c b/drivers/spi/spi-bcm-qspi.c
index bca7ac5..2c8f0d9 100644
--- a/drivers/spi/spi-bcm-qspi.c
+++ b/drivers/spi/spi-bcm-qspi.c
@@ -1025,8 +1025,9 @@ static int bcm_qspi_exec_mem_op(struct spi_mem *mem,
 	u32 addr = 0, len;
 	u_char *buf;
 
+	/* cmd[] holds 1 opcode + 4 address + 1 dummy byte at most */
 	if (!op->data.nbytes || !op->addr.nbytes || op->addr.nbytes > 4 ||
-	    op->data.dir != SPI_MEM_DATA_IN)
+	    op->dummy.nbytes > 1 || op->data.dir != SPI_MEM_DATA_IN)
 		return -ENOTSUPP;
 
 	buf = op->data.buf.in;
-- 
2.43.0

