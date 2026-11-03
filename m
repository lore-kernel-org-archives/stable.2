Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=160.30.148.35
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1793703236;
	b=KbMS43HD0Eh8vOK7EWe8asCftQka9vL97gcLBp0q0EszZnsfx5fMDs2vZviyH99LJpOn
	 CQ1CNK9P+Hen0PDGlXTFiANXBGMSse6dx0hzhsfRAMtVzqQXh8mA67exTDHYanQIAzOzW
	 FKSJq1R3FIIMKqOP1+ztQEdqlHKKw2fe+HlecwxD+G7cQZWIo5obHIk8FcR+MdUGuQG9B
	 qvy4frwP9dUyn0MAYtpoK9Nf9eOaJpbm3vjCDhu1xmByl2SZuWQB3gNCAsnrY/Ktk9ti7
	 xM7fzthKv2+UA+dt2EPTnAPrwaI2aTxF16kjY4dfO5S4NIMV+MqjTtNhhLJbuLAe6Wg==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1793703236;
	h=DMARC-Filter:Received:Received:Received:X-Zmail-TransId:X-Mailer:
	 Message-ID:Date:Mime-Version:From:To:Cc:Subject:Content-Type:X-MAIL:
	 X-TLS:X-ENVELOPE-SENDER:X-SOURCE-IP:X-CLEAN:
	 X-Fangmail-Anti-Spam-Filtered:X-Fangmail-MID-QID;
	bh=i+DHw1eJBnfBYMpsbId+fwdj/ffdvRjE8kTCYAnvm70=;
	b=UWr9l3SS9hMI21iAxIic6q5rfYJbpxm0RnOvl6XhD8DpaTMr9Bag/5gJoS8kENz61Pg+
	 BsiSK4o3hCcAldreiDrF5Z7z4xOdhAvDwdr46jhaMaFp5/JAfGIFwnO90A/nWbY8RiJTP
	 wz636o3iK9Nk5prCdeamyGavN8TyfTEmhCTQ7hcI0HeYPdGSbRNrxfWMqFI3YUbcevZNU
	 dXcU4cczLahPUfvKQzItDJVFXPZ/DSRXWkV9nnkkaavW6Q7GYgCmW4s7ilpk3xRb1FO5s
	 rCdfdMg/eKM7RGz8TVtB0ewlZU+DoYZEghTIor7ZMIJTNy8aJPJT+x1MOcekTP5umlQ==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=zte.com.cn;
	spf=pass smtp.mailfrom=zte.com.cn;
	arc=none smtp.remote-ip=160.30.148.35
Received: from mxhk.zte.com.cn (mxhk.zte.com.cn [160.30.148.35])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BAAF0606D829;
	Tue,  3 Nov 2026 10:53:55 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org BAAF0606D829
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=zte.com.cn
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=zte.com.cn
Received: from mse-fl2.zte.com.cn (unknown [10.5.228.133])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange x25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by mxhk.zte.com.cn (FangMail) with ESMTPS id 4jJlmy14Xkz8Xrrc;
	Tue, 03 Nov 2026 18:53:54 +0800 (CST)
Received: from xaxapp05.zte.com.cn ([10.99.98.109])
	by mse-fl2.zte.com.cn with SMTP id 6A3ArbDm051787;
	Tue, 3 Nov 2026 18:53:37 +0800 (+08)
	(envelope-from shao.mingyin@zte.com.cn)
Received: from mapi (xaxapp01[null])
	by mapi (Zmail) with MAPI id mid32;
	Tue, 3 Nov 2026 18:53:40 +0800 (CST)
X-Zmail-TransId: 2af96ae9bd34b2d-af295
X-Mailer: Zmail v1.0
Message-ID: <20261103185340382nGk9q5f5TbPSdgcbDLAUy@zte.com.cn>
Date: Tue, 3 Nov 2026 18:53:40 +0800 (CST)
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
To: <agk@redhat.com>, <snitzer@kernel.org>, <mpatocka@redhat.com>,
        <bmarzins@redhat.com>, <dm-devel@lists.linux.dev>
Cc: <linux-kernel@vger.kernel.org>, <stable@vger.kernel.org>
Subject: =?UTF-8?B?W1BBVENIXSBkbSBtcGF0aDogZml4IGJ1ZmZlciBvdmVyZmxvdyBpbiBwYXJzZV9od19oYW5kbGVyKCk=?=
Content-Type: text/plain;
	charset="UTF-8"
X-MAIL:mse-fl2.zte.com.cn 6A3ArbDm051787
X-TLS: YES
X-ENVELOPE-SENDER: shao.mingyin@zte.com.cn
X-SOURCE-IP: 10.5.228.133 unknown Tue, 03 Nov 2026 18:53:54 +0800
X-CLEAN: YES
X-Fangmail-Anti-Spam-Filtered: true
X-Fangmail-MID-QID: 6AE9BD42.000/4jJlmy14Xkz8Xrrc

parse_hw_handler() builds the hw_handler parameter string in a buffer
sized with

	len = 4;

plus one byte per argument.  Those four bytes were meant for the decimal
form of the parameter count, three digits plus the terminating NUL.
dm_read_arg_group() accepts up to 1024 arguments and the count written is
'hw_argc - 1', so a count of 1000 or more needs four digits plus the NUL
and sprintf() writes one byte past the allocation.

Size the buffer from the actual string length instead.

Fixes: 2bfd2e1337f0 ("[SCSI] scsi_dh: Use scsi_dh_set_params() in multipath.")
Cc: stable@vger.kernel.org
Signed-off-by: Shao Mingyin <shao.mingyin@zte.com.cn>
---
diff --git a/drivers/md/dm-mpath.c b/drivers/md/dm-mpath.c
index ae9318f5f21b..2f871a23a8cb 100644
--- a/drivers/md/dm-mpath.c
+++ b/drivers/md/dm-mpath.c
@@ -1085,8 +1085,9 @@ static int parse_hw_handler(struct dm_arg_set *as, struct multipath *m)
 
 	if (hw_argc > 1) {
 		char *p;
-		int i, j, len = 4;
+		int i, j, len;
 
+		len = snprintf(NULL, 0, "%d", hw_argc - 1) + 1;
 		for (i = 0; i <= hw_argc - 2; i++)
 			len += strlen(as->argv[i]) + 1;
 		p = m->hw_handler_params = kzalloc(len, GFP_KERNEL);
