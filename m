Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=183.62.165.209
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1794677282;
	b=08o1NoWBG8mPQxLf+e5YN7SMIz9FlLoy4L930PszjhvT2cEDqiPHUN8pRyaAU2tMnTv1
	 b+J1mb2vgeUc8Ld7VRnjvpjXhBN67sEAEGdhd/i9D0OUkJu84E6ZconbLm/rLr9yarRRr
	 L8LDunMxfAcDHiMukSXV9dOD4+QzrIOcqq8B3hkL7vssEurE2/zoOdEYZ8mjVrPExYftz
	 +nty4OUH9+gKxZ/4TURmPO52wO3H71hHzBQlyoVvxQYdmYh0wVkSVhv5nctSjE8GKdv/P
	 TjyO+vh/uhUT1ZLlrFrPgGrOTg9zWJXTtgVFGkHOQjAy6ueuYsAZDcLei6rNUHewdPw==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1794677282;
	h=DMARC-Filter:Received:DKIM-Signature:Received:Received:
	 X-Zmail-TransId:X-Mailer:Message-ID:In-Reply-To:References:Date:
	 Mime-Version:From:To:Cc:Subject:Content-Type:X-MAIL:X-TLS:
	 X-ENVELOPE-SENDER:X-SOURCE-IP:X-CLEAN:X-Fangmail-Anti-Spam-Filtered:
	 X-Fangmail-MID-QID;
	bh=AhEZAUWU3siQtDB4u7hy2EKIdXyvJUcxhnu0gQ87EUc=;
	b=OXQdu3gabnJgJvsXvg+zFAQ03beOJwR7go+3oyP+TakTmdmXhXQ+jzYh3eNPxXcQm73M
	 XjNuJskCHbzU0pTtvs8+G8DH7hBGqrKz8S4SL6r0A4eN4Ox2oYSM/EjvdjzjOPIK6c7iX
	 JWOiDPM8fkmL7WMSfxktbVY7pPcVEx662nix8qNEE3pAXhnW1hhKvIY8lqVSfjIzxpWIV
	 35pPfNtY9ZsbD5PyMSH8T02Ntfb5x+0mdEw8ZNuh6UOjF0bhRWteH+8KyrewFsUKkHOI5
	 41iyJ/QndpxmTEmcRG8USUCbFCcLyuLneCGt5Xk5g25boV+OIHxNMibO86ciVsnd4uA==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=zte.com.cn;
	spf=pass smtp.mailfrom=zte.com.cn;
	dkim=pass header.d=zte.com.cn header.i=@zte.com.cn header.a=rsa-sha256 header.s=z202610 header.b=aR33Yuuk;
	arc=none smtp.remote-ip=183.62.165.209
Received: from mxct.zte.com.cn (mxct.zte.com.cn [183.62.165.209])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C7DA1606A33A;
	Sat, 14 Nov 2026 17:28:01 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org C7DA1606A33A
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=zte.com.cn
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=zte.com.cn
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=zte.com.cn header.i=@zte.com.cn header.a=rsa-sha256 header.s=z202610 header.b=aR33Yuuk
Received: from mse-fl2.zte.com.cn (unknown [10.5.228.133])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange x25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by mxct.zte.com.cn (FangMail) with ESMTPS id 4jRh0Z6zPBz4xPRy;
	Sun, 15 Nov 2026 01:27:58 +0800 (CST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=zte.com.cn;
	s=z202610; t=1794677279;
	bh=fgbIpa7paOidWzQEQF1V9lKk++iJNa/wFvrwiomXOA4=;
	h=In-Reply-To:References:Date:From:To:Cc:Subject;
	b=aR33YuukUR+Z92c7RhR7tdOcJejHGXp027xMjyt/c6evgN9p8Sxi2f4oqPulto6hj
	 aUAfCU5iuM4pOISSBirnOycYdhz56UvFeoJhzI3rXnLZZPVe53j8s4+KVsbJWO0uA7
	 54LazfDOGobbZq81SfyPslsGUMFehTXw4eVKxlknzlFGgZMTxcTNCVWSFL2Npofw4Y
	 KStCfZc5n32rOL5G28Wtu0odBD6OGPVCij638Ale1b1nhZzxo9gHDO7NncO7AYYNG/
	 d6L5VVGor8it2ebuZZuZ1LJL2+8TbVbr71hLmKA5aK0EClF6iErzjNg7lUUCuADQFr
	 0e6pAiuXe8QsA==
Received: from xaxapp01.zte.com.cn ([10.88.99.176])
	by mse-fl2.zte.com.cn with SMTP id 6AEHRqqZ016765;
	Sun, 15 Nov 2026 01:27:52 +0800 (+08)
	(envelope-from shao.mingyin@zte.com.cn)
Received: from mapi (xaxapp04[null])
	by mapi (Zmail) with MAPI id mid32;
	Sun, 15 Nov 2026 01:27:54 +0800 (CST)
X-Zmail-TransId: 2afb6af89a1a198-56142
X-Mailer: Zmail v1.0
Message-ID: <20261115012754244CUh01sEOwZp4S8maAbDDM@zte.com.cn>
In-Reply-To: <202611150127512368BGQ07ZNIRAIwClkam-8u@zte.com.cn>
References: 202611150127512368BGQ07ZNIRAIwClkam-8u@zte.com.cn
Date: Sun, 15 Nov 2026 01:27:54 +0800 (CST)
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
Subject: =?UTF-8?B?W1BBVENIIDIvNV0gbnZtZTogbWFwIHBhc3N0aHJvdWdoIGRhdGEgd2hlbiB0aGUgbGVuZ3RoIGlzIG5vbnplcm8=?=
Content-Type: text/plain;
	charset="UTF-8"
X-MAIL:mse-fl2.zte.com.cn 6AEHRqqZ016765
X-TLS: YES
X-ENVELOPE-SENDER: shao.mingyin@zte.com.cn
X-SOURCE-IP: 10.5.228.133 unknown Sun, 15 Nov 2026 01:27:59 +0800
X-CLEAN: YES
X-Fangmail-Anti-Spam-Filtered: true
X-Fangmail-MID-QID: 6AF89A1E.000/4jRh0Z6zPBz4xPRy

From: Shao Mingyin <shao.mingyin@zte.com.cn>

nvme_submit_user_cmd() skips mapping when the user address is zero,
even if a nonzero data length was supplied.  Passthrough ioctls and
NVME_IOCTL_SUBMIT_IO can therefore submit a data-transfer command
without a mapped payload.  For example, the loop target returns a
Data SGL Length Invalid status instead of rejecting the user buffer.

Map whenever a length is given and let the mapping helper validate the
address.  This also permits address zero if the process has valid
memory mapped there, matching the io_uring passthrough behavior from
commit 99fde895ff56 ("nvme: map uring_cmd data even if address is 0").

Fixes: d29ec8241c10 ("nvme: submit internal commands through the block layer")
Cc: stable@vger.kernel.org
Signed-off-by: Shao Mingyin <shao.mingyin@zte.com.cn>
---
Tested on 7.3.0-next-20261030 (QEMU/TCG guest) with the loop transport
and a file-backed namespace.

NVME_IOCTL_IO_CMD with addr=0 and a nonzero data_len skips the mapping
on the unpatched kernel and submits the command with an empty data
pointer, so the target rejects it with "Data SGL Length Invalid" (status
0x600f).  With the patch the mapping helper rejects the null user
address with -EFAULT before the command is submitted:

  unpatched                            patched
  control read (valid addr) ret 0      control read (valid addr) ret 0
  read  addr=0 len=4096 ret 0x600f     read  addr=0 len=4096 -EFAULT
  write addr=0 len=4096 ret 0x600f     write addr=0 len=4096 -EFAULT

 drivers/nvme/host/ioctl.c |    2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/nvme/host/ioctl.c b/drivers/nvme/host/ioctl.c
index a87c9ca9d06c..22efc5412416 100644
--- a/drivers/nvme/host/ioctl.c
+++ b/drivers/nvme/host/ioctl.c
@@ -207,7 +207,7 @@ static int nvme_submit_user_cmd(struct request_queue *q,
 		return PTR_ERR(req);
 
 	req->timeout = timeout;
-	if (ubuffer && bufflen) {
+	if (bufflen) {
 		ret = nvme_map_user_request(req, ubuffer, bufflen, meta_buffer,
 				meta_len, NULL, flags);
 		if (ret)
-- 
2.43.0
