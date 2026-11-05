Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=160.30.148.35
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1793887097;
	b=LjGgAHlUDlJjgwpLG0ycZGoUxtqFcP8zyh33ncfyhIJii0Tx59TMmQoDh4xd0g/ej6+L
	 ttsSnlEHnGRcbltEkdSTgjMqAtMOavRKtK00x7BonBPNP3rMJNNbz8f3oDBus+YXduw85
	 wcvzeBMheQC2Eu8Dsvb6UTU5imF5cdjL0RPnLPZhLjQv451Icu7D2MMcnsblAsYKxrHnm
	 jeEiIzDCqFvmwDrflSH9WOp9JESCPjGgJPrdnPjBU4+n1mjhIuHcHwEa4KFe2F6hy/bIw
	 Uc+fTmiFKmeaHkL7N92xN538p0CsLybClzuZLuD6RwVMzPWSoZcvycxUWJFTTrMfssg==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1793887097;
	h=DMARC-Filter:Received:Received:Received:X-Zmail-TransId:X-Mailer:
	 Message-ID:Date:Mime-Version:From:To:Cc:Subject:Content-Type:X-MAIL:
	 X-TLS:X-ENVELOPE-SENDER:X-SOURCE-IP:X-CLEAN:
	 X-Fangmail-Anti-Spam-Filtered:X-Fangmail-MID-QID;
	bh=roeOiANIDFUwCk1N8kNAgvb2U58m5KoSZCuD7m0gbng=;
	b=nkj+G0FjeeeudPhuZa+ujETbamHMs7TTR2Epk7bZMXQzl7uAQXspitk5W0wHh6yNqBIh
	 oZmQt1XiuvVLBgvzBP+rrbRj9ok2iQvYgs/EtFRwwihSqD5boWyhhG+msxDFlMX6zC5qc
	 Y7rxkqhRlxRye2HikVICovzY85EVyFPIMULtnVD/QDRzkQ74t3UQs4m8l+uJQyX0zkm3X
	 bXYHIHFzYnLwb9W8rXcraYRdz+o9qRyZ0AHE7T9bZ12DmMtw//FysLOoYihEqgv6ARIDA
	 ngBQMkZXpSX+1y8SLU4G8KKENmjP8JopGm58lZ71E4lxKo2CApbjjDzq7jA0gbUAqQA==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=zte.com.cn;
	spf=pass smtp.mailfrom=zte.com.cn;
	arc=none smtp.remote-ip=160.30.148.35
Received: from mxhk.zte.com.cn (mxhk.zte.com.cn [160.30.148.35])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C7A25606D819;
	Thu,  5 Nov 2026 13:58:16 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org C7A25606D819
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=zte.com.cn
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=zte.com.cn
Received: from mse-fl2.zte.com.cn (unknown [10.5.228.133])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange x25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by mxhk.zte.com.cn (FangMail) with ESMTPS id 4jL3ml3HNbz8Xrnt;
	Thu, 05 Nov 2026 21:58:15 +0800 (CST)
Received: from xaxapp02.zte.com.cn ([10.88.97.241])
	by mse-fl2.zte.com.cn with SMTP id 6A5Dw6So060372;
	Thu, 5 Nov 2026 21:58:06 +0800 (+08)
	(envelope-from shao.mingyin@zte.com.cn)
Received: from mapi (xaxapp04[null])
	by mapi (Zmail) with MAPI id mid32;
	Thu, 5 Nov 2026 21:58:07 +0800 (CST)
X-Zmail-TransId: 2afb6aec8b6fdec-d453e
X-Mailer: Zmail v1.0
Message-ID: <20261105215807526OqR0Bg86VChvwhCEz5xGr@zte.com.cn>
Date: Thu, 5 Nov 2026 21:58:07 +0800 (CST)
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
Subject: =?UTF-8?B?W1BBVENIXSBudm1lOiByZWplY3QgaW52YWxpZCByZWNvbm5lY3RfZGVsYXkgc3lzZnMgdmFsdWVz?=
Content-Type: text/plain;
	charset="UTF-8"
X-MAIL:mse-fl2.zte.com.cn 6A5Dw6So060372
X-TLS: YES
X-ENVELOPE-SENDER: shao.mingyin@zte.com.cn
X-SOURCE-IP: 10.5.228.133 unknown Thu, 05 Nov 2026 21:58:15 +0800
X-CLEAN: YES
X-Fangmail-Anti-Spam-Filtered: true
X-Fangmail-MID-QID: 6AEC8B77.000/4jL3ml3HNbz8Xrnt

From: Shao Mingyin <shao.mingyin@zte.com.cn>

nvme_ctrl_reconnect_delay_store() stores whatever kstrtou32() accepted
into opts->reconnect_delay without validating it.  The nvme-fabrics
option parser refuses reconnect_delay values that are zero or negative,
and the rest of the driver relies on that: nvme_ctrl_loss_tmo_store()
computes

	opts->max_reconnects = DIV_ROUND_UP(ctrl_loss_tmo,
					    opts->reconnect_delay);

Writing 0 to reconnect_delay and then a positive value to ctrl_loss_tmo
therefore divides by zero in the kernel.  In addition, a value larger
than INT_MAX is truncated to a negative int in the assignment and
silently bypasses the checks done by the fabrics parser.

Reject zero and values that do not fit into the signed int field.

Fixes: 764075fdcb2f ("nvme: expose reconnect_delay and ctrl_loss_tmo via sysfs")
Cc: stable@vger.kernel.org
Signed-off-by: Shao Mingyin <shao.mingyin@zte.com.cn>
---
Tested on 7.3.0-next-20261030 (QEMU/TCG guest) with the loop transport.

Writing 0 to reconnect_delay and then a positive value to ctrl_loss_tmo
divides by zero in nvme_ctrl_loss_tmo_store():

  unpatched                            patched
  reconnect_delay=0 accepted           write rejected (-EINVAL)
  divide error, kernel panic

diff --git a/drivers/nvme/host/sysfs.c b/drivers/nvme/host/sysfs.c
index 10018c6356b6..d7309a55aa8a 100644
--- a/drivers/nvme/host/sysfs.c
+++ b/drivers/nvme/host/sysfs.c
@@ -634,6 +634,14 @@ static ssize_t nvme_ctrl_reconnect_delay_store(struct device *dev,
 	if (err)
 		return err;
 
+	/*
+	 * reconnect_delay is used as a divisor by nvme_ctrl_loss_tmo_store()
+	 * and the reconnect logic expects a positive value, just like the
+	 * nvme-fabrics option parser does.
+	 */
+	if (!v || v > INT_MAX)
+		return -EINVAL;
+
 	ctrl->opts->reconnect_delay = v;
 	return count;
 }
