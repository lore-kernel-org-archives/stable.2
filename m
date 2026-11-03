Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=160.30.148.34
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1793732850;
	b=gEWsDlqBFHLl5QvDpfJK8NT3ZM/KeLOoXhrumdGm3Vlv8ZhY9wt5STjeaLwIAiv+bLdV
	 /Lwtye+w/U1KFBCU8lWcgpKR32s7OZHs2f4aawbOsttjq4M0nTI+h6vKgCzPdx2ktGTmA
	 ugobuukX70PNrNOSDoQpl3sQ07JMdlNmmDQJM6e/XSdcUB+0RxGFD5TVCQlWGQeyrB8Hk
	 HhoQedMDNW+4iC8/tB4rk94VSX5pB2kHjjPfJQg8MqyOMmANkj0U9485uiLVi2JwKNcQ8
	 5FtZuAE2NcfFJv2qOEuTyvxxEJuAMOjrJIMXe6g09+zNzGxT9ZRuG/XDgn43hpPYiyg==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1793732850;
	h=DMARC-Filter:Received:Received:Received:X-Zmail-TransId:X-Mailer:
	 Message-ID:In-Reply-To:References:Date:Mime-Version:From:To:Cc:
	 Subject:Content-Type:X-MAIL:X-TLS:X-ENVELOPE-SENDER:X-SOURCE-IP:
	 X-CLEAN:X-Fangmail-Anti-Spam-Filtered:X-Fangmail-MID-QID;
	bh=z7BFpxHBFAMv9NUJbg2Nh0kMD5DcNem/O4u4vl1QoWo=;
	b=ogc/wRdSPTPDzIgsA7X2RGt719PXzvQmLIrUHA1T0eZlTg5C/SV6gAran8Dt+LXAg3sp
	 CDqn7oile1mcfZQJ07d27vEhQcbb8p3q/+Uy/ByCE827G2zZn7ET5z3aN1EebTbDZMkKj
	 xEaHlouW0aNRxyTiUPbPjwSQNi+1UdpYttkdtXIh8qkvxNitVMgUlgZuCj+8xP/aP9ivF
	 JdMs8hO+F1/FRcqKOnW5lfeNa7cGXNSE7Tc79zJOQYy4KnSKDFNL+25HJlzPSB5RM4bJ3
	 /vWaiXUUm9p76nCpbWyVV3c1e5XA5HM8dywJv2pp79l3BPx68Kn226XAO/62mvvmS/w==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=zte.com.cn;
	spf=pass smtp.mailfrom=zte.com.cn;
	arc=none smtp.remote-ip=160.30.148.34
Received: from mxhk.zte.com.cn (mxhk.zte.com.cn [160.30.148.34])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DF224606A324;
	Tue,  3 Nov 2026 19:07:29 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org DF224606A324
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=zte.com.cn
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=zte.com.cn
Received: from mse-fl1.zte.com.cn (unknown [10.5.228.132])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange x25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by mxhk.zte.com.cn (FangMail) with ESMTPS id 4jJykS4TDmz5B0rY;
	Wed, 04 Nov 2026 03:07:28 +0800 (CST)
Received: from xaxapp01.zte.com.cn ([10.88.99.176])
	by mse-fl1.zte.com.cn with SMTP id 6A3J7Ldi084634;
	Wed, 4 Nov 2026 03:07:21 +0800 (+08)
	(envelope-from shao.mingyin@zte.com.cn)
Received: from mapi (xaxapp02[null])
	by mapi (Zmail) with MAPI id mid32;
	Wed, 4 Nov 2026 03:07:25 +0800 (CST)
X-Zmail-TransId: 2afa6aea30eddb9-da2f8
X-Mailer: Zmail v1.0
Message-ID: <20261104030725983jzZdkZpfTBDh22QD5TL5N@zte.com.cn>
In-Reply-To: <20261104030720567AV9nG8iiGp4C0YlWIDDs7@zte.com.cn>
References: 20261104030720567AV9nG8iiGp4C0YlWIDDs7@zte.com.cn
Date: Wed, 4 Nov 2026 03:07:25 +0800 (CST)
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
Subject: =?UTF-8?B?W1BBVENIIDEvMl0gbnZtZXQ6IHRha2Ugc3Vic3lzLT5sb2NrIHdoZW4gZm9yY2luZyByZWNvbm5lY3RzIGZvciB0Ymthcw==?=
Content-Type: text/plain;
	charset="UTF-8"
X-MAIL:mse-fl1.zte.com.cn 6A3J7Ldi084634
X-TLS: YES
X-ENVELOPE-SENDER: shao.mingyin@zte.com.cn
X-SOURCE-IP: 10.5.228.132 unknown Wed, 04 Nov 2026 03:07:28 +0800
X-CLEAN: YES
X-Fangmail-Anti-Spam-Filtered: true
X-Fangmail-MID-QID: 6AEA30F0.000/4jJykS4TDmz5B0rY

nvmet_subsys_attr_tbkas_store() walks subsys->ctrls to force a reconnect
while holding only nvmet_config_sem.  The list is protected by
subsys->lock: nvmet_alloc_ctrl() adds entries and nvmet_ctrl_free()
removes them under that lock, and the controller free path does not take
nvmet_config_sem.  Writing attr_tbkas concurrently with a controller
going away, for example on a keep-alive timeout or a fatal error, can
therefore dereference a controller that has already been removed and
freed.

Take subsys->lock around the list walk, as
nvmet_subsys_attr_qid_max_store() already does for the same loop.
delete_ctrl() only schedules the asynchronous teardown, so it does not
recurse into subsys->lock.

Fixes: e98e45e9465b ("nvmet: Add traffic based keep alive support to configfs")
Cc: stable@vger.kernel.org
Signed-off-by: Shao Mingyin <shao.mingyin@zte.com.cn>
---
Tested on 7.3.0-next-20261030 (QEMU/TCG guest, KASAN) with the loop
transport.

One process hammers the attr_tbkas store while another connects and
deletes loop controllers, so the walk over subsys->ctrls races with
nvmet_ctrl_free():

  unpatched                            patched
  general protection fault,            no report in 60 s,
  KASAN wild-memory-access 0xdead...   39591 iterations
  in nvmet_subsys_attr_tbkas_store

diff --git a/drivers/nvme/target/configfs.c b/drivers/nvme/target/configfs.c
index b3a5242d06f9..c17f2c8ab2df 100644
--- a/drivers/nvme/target/configfs.c
+++ b/drivers/nvme/target/configfs.c
@@ -1466,8 +1466,10 @@ static ssize_t nvmet_subsys_attr_tbkas_store(struct config_item *item,
 	subsys->tbkas = tbkas;
 
 	/* Force reconnect */
+	mutex_lock(&subsys->lock);
 	list_for_each_entry(ctrl, &subsys->ctrls, subsys_entry)
 		ctrl->ops->delete_ctrl(ctrl);
+	mutex_unlock(&subsys->lock);
 	up_write(&nvmet_config_sem);
 
 	return count;
