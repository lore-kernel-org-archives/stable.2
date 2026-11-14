Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=160.30.148.34
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1794677292;
	b=uPS7T0qx7/8/1ekgKioAP75Cq4akJF8mu1khfWvp/VMhpFJ7+zEsrpuwV2MunbEqETC4
	 ZJo05RQt6qpuhDMokxAfTPR5IAeIyoVVAS/lHEbfUMjg0GqGZrlk7SDqlaZqy/M6rpebW
	 qVtqRuXL5R1gocQ8y1hYZ//4h+Z9MU33W0nGAbwgoEx62mkBnjxooBFIDlZ663s4h4+ek
	 /ABxp4Om3CvH9Ljo6WKqQvYGsfdcMVyxQ/rbcOdHlBT5oYx3H1ZD5esAuoazkxDPH+XoW
	 EQTSVgpedEBXXRaT83X9+JvAhOmMKMvg3LQIcE7Ujs45c+6Yysi+RU7i0riLvxjiNqw==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1794677292;
	h=DMARC-Filter:Received:DKIM-Signature:Received:Received:
	 X-Zmail-TransId:X-Mailer:Message-ID:Date:Mime-Version:From:To:Cc:
	 Subject:Content-Type:X-MAIL:X-TLS:X-ENVELOPE-SENDER:X-SOURCE-IP:
	 X-CLEAN:X-Fangmail-Anti-Spam-Filtered:X-Fangmail-MID-QID;
	bh=WRNLrpU2e5LOoIR+wQJ0Ri4kspqhz6hENoSzU9nHoLQ=;
	b=EoeGCu6hPIdglYsWAKvV7TFSe8t16z0Ke47Po1U9J0uVWJyzPxyuk5cwFEweqM3/tYVo
	 w9WER8QohVq7q3JGQVCDUTn4SApZOrjQMvAk09XEYZ1KW10+6vVq3cHGSPkNeOwKEqhxB
	 zxF5JTE6apos5JmBYOlW3bmGWFlpmv4qjFOrUEkuKlFwFl4cVzvclxG7YWp5CHel1ORSy
	 M3B9c1ZT8HzN2GFjZCnSIXFhSz89XdUgp+lzCDr5lI92M2oe+bA3zbIHzDONht5KYKhHF
	 1mAWHhX7t6Zxan5LCoVFV2VrSUWrGn8aMM60vsyCVIO2chZBEFgmcwkOnnj5hZCJcNw==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=zte.com.cn;
	spf=pass smtp.mailfrom=zte.com.cn;
	dkim=pass header.d=zte.com.cn header.i=@zte.com.cn header.a=rsa-sha256 header.s=z202610 header.b="k/n87MZt";
	arc=none smtp.remote-ip=160.30.148.34
Received: from mxhk.zte.com.cn (mxhk.zte.com.cn [160.30.148.34])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2D09C60A2607;
	Sat, 14 Nov 2026 17:28:12 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 2D09C60A2607
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=zte.com.cn
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=zte.com.cn
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=zte.com.cn header.i=@zte.com.cn header.a=rsa-sha256 header.s=z202610 header.b=k/n87MZt
Received: from mse-fl1.zte.com.cn (unknown [10.5.228.132])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange x25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by mxhk.zte.com.cn (FangMail) with ESMTPS id 4jRh0p5yv1z4yjS4;
	Sun, 15 Nov 2026 01:28:10 +0800 (CST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=zte.com.cn;
	s=z202610; t=1794677290;
	bh=cM3ClT4u+zl82PZyFZeUSO2AVbc/sz+uQne/Xdz4UdI=;
	h=Date:From:To:Cc:Subject;
	b=k/n87MZt5OItqLhj4Yd7FQmFmZRQ0fAiQh6fUUUs1W734LeypknJ4Za8sc59sHqec
	 JBNgZoiswXO3lkYHbGPCNxhW1cpI77x5vbMhPth+TQpz5GKtPJcZjNnn5tOQxzKQ35
	 3BQ1ITlXnII0/P0ArY7/Qhhic7TznBQ9q6Do9sxRcrhfc49jZlcdGfSKuiXoaE+QF2
	 AlsCE7it8LS5J1K92Gs6w3W58AACl+TmCipvIec4awhRzXau6t/KQ6ifZ4H0Bp6XMv
	 yH3KIeoQF0oohMZJ3CXD/FXlx2dC+83iel5iIJwQ1TOM+Fs32N28FeqLbilgfQqrnZ
	 0wz1hahpWRcHA==
Received: from xaxapp04.zte.com.cn ([10.99.98.157])
	by mse-fl1.zte.com.cn with SMTP id 6AEHS2ma012439;
	Sun, 15 Nov 2026 01:28:02 +0800 (+08)
	(envelope-from shao.mingyin@zte.com.cn)
Received: from mapi (xaxapp01[null])
	by mapi (Zmail) with MAPI id mid32;
	Sun, 15 Nov 2026 01:28:06 +0800 (CST)
X-Zmail-TransId: 2af96af89a26171-58119
X-Mailer: Zmail v1.0
Message-ID: <20261115012806699yIujDZo6TywlxuhhSIktO@zte.com.cn>
Date: Sun, 15 Nov 2026 01:28:06 +0800 (CST)
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Post: <mailto:stable@vger.kernel.org>
List-Help: <mailto:stable+help@vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
List-Owner: <mailto:stable+owner@vger.kernel.org>
Precedence: list
Mime-Version: 1.0
From: <shao.mingyin@zte.com.cn>
To: <kbusch@kernel.org>, <axboe@kernel.dk>, <hch@lst.de>, <sagi@grimberg.me>,
        <linux-nvme@lists.infradead.org>
Cc: <linux-kernel@vger.kernel.org>, <stable@vger.kernel.org>
Subject: =?UTF-8?B?W1BBVENIXSBudm1ldDogZml4IHRoZSBDU1RTIHN0YXRlIGl0ZXJhdGlvbiBpbiBkZWJ1Z2Zz?=
Content-Type: text/plain;
	charset="UTF-8"
X-MAIL:mse-fl1.zte.com.cn 6AEHS2ma012439
X-TLS: YES
X-ENVELOPE-SENDER: shao.mingyin@zte.com.cn
X-SOURCE-IP: 10.5.228.132 unknown Sun, 15 Nov 2026 01:28:10 +0800
X-CLEAN: YES
X-Fangmail-Anti-Spam-Filtered: true
X-Fangmail-MID-QID: 6AF89A2A.000/4jRh0p5yv1z4yjS4

From: Shao Mingyin <shao.mingyin@zte.com.cn>

nvmet_ctrl_state_show() uses the size of a sparse name array as a
bit count.  Its last index is NVME_CSTS_PP (BIT(5)), so the loop has
33 iterations and evaluates BIT(32).  This exceeds the width of an
unsigned long on 32-bit systems.  With GCC on x86 this can make a
normal ready status print "ready|ready".

Iterate over the 32 bits of csts instead.  Check the name array bounds
before indexing it and print unknown bits as unsigned values.  The
out-of-bounds lookup requires a reserved status bit; the current target
code does not set those bits.

Fixes: 107a23185d99 ("objtool, nvmet: Fix out-of-bounds stack access in nvmet_ctrl_state_show()")
Cc: stable@vger.kernel.org
Signed-off-by: Shao Mingyin <shao.mingyin@zte.com.cn>
---
Tested on 7.3.0-next-20261030 (QEMU/TCG guest, KASAN) with the loop
transport.  No in-tree path sets a reserved csts bit, so the guest
injects one through a test-only debugfs attribute added for this test
(not part of the patch).

ORing BIT(31) and then BIT(6) into ctrl->csts and reading the controller
state attribute:

  unpatched                            patched
  BUG: unable to handle page fault     csts_bit31='ready|2147483648'
  RIP: nvmet_ctrl_state_show+0x90      csts_bit6='ready|64|2147483648'
  Kernel panic - not syncing

 drivers/nvme/target/debugfs.c |    9 +++++----
 1 file changed, 5 insertions(+), 4 deletions(-)

diff --git a/drivers/nvme/target/debugfs.c b/drivers/nvme/target/debugfs.c
index e85fe1d4c9f8..905a08c63669 100644
--- a/drivers/nvme/target/debugfs.c
+++ b/drivers/nvme/target/debugfs.c
@@ -78,18 +78,19 @@ static int nvmet_ctrl_state_show(struct seq_file *m, void *p)
 	bool sep = false;
 	int i;
 
-	for (i = 0; i < ARRAY_SIZE(csts_state_names); i++) {
-		int state = BIT(i);
+	for (i = 0; i < BITS_PER_TYPE(u32); i++) {
+		u32 state = BIT(i);
 
 		if (!(ctrl->csts & state))
 			continue;
 		if (sep)
 			seq_puts(m, "|");
 		sep = true;
-		if (csts_state_names[state])
+		if (state < ARRAY_SIZE(csts_state_names) &&
+		    csts_state_names[state])
 			seq_puts(m, csts_state_names[state]);
 		else
-			seq_printf(m, "%d", state);
+			seq_printf(m, "%u", state);
 	}
 	if (sep)
 		seq_printf(m, "\n");
-- 
2.43.0
