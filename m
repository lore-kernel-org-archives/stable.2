Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=111.22.67.139
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1794188024;
	b=BwuRdsVekHL3ZyGR2scFZwZgKdIWwibl6bq2MHGwHshiBJbM2pJtzHlWFZ6BUEy5+0jH
	 C0JfrIKPDoXcPKVjCpM5h8n7YvybLpzHPLhg0TxODbZYSY++ZrnFjaX4QUI3jUd7Fugu7
	 pBTzO2/rKKfoGybCvJgTHWYWx6eqPEfaZxsV4+k2RDaXUUpHz0DFq81ZnS5zAPPSn9T2s
	 F2cLF6cXKqLyBxO/S/Od3vxk+tnOMlVhBdG8uaQPxpPDqB0VW8bTzdRChONxgHe8shjsN
	 YrNCi45nyBh0HDhYlkJqLqztjQiFBxuo1yI7Rc3lBicDRKc9YZfSlZBRN8ZFtFeovMg==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1794188024;
	h=DMARC-Filter:DKIM-Signature:X-RM-TagInfo:X-RM-SPAM-FLAG:Received:
	 X-RM-TRANSID:X-RM-TagInfo:X-RM-SPAM-FLAG:Received:X-RM-TRANSID:From:
	 To:Cc:Subject:Date:Message-ID:X-Mailer:MIME-Version:
	 Content-Transfer-Encoding;
	bh=BhteyzlsA9AHFknqXbHWkQrum6QaM3/9EY4gqsJCK3Q=;
	b=vKOn3Da4bKU2spzuaEg3lTmSbcGzyzdtjZVAv1pyFFoc5izZBVhT8mBk0NXeEGsWAkxH
	 tRgXxGLDuPaByzZ7B8Bkqagpu9IlHX4Tq1G19yHMTSFtWWCmFg0UH4zBrqalTHRsmRyaU
	 dR799+I61LdU49dHj0Y5rok0tMGI5GMQegbPAkCLLw420TtvkmD+8RYfDMevPgxqk+bOZ
	 s5byn0RHjQlbBnM0djoan5wTL68uii6aFCnkQUZJAp1Xlcr6Yr/uyMutAdma5mBqCdsJH
	 8siAuIVo8YgWbAIAFP2NAV6hlXqpA8NY46KUnaqyYMNqXD1OXyc1HVXPaHRR4tI6hcA==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=cmss.chinamobile.com;
	spf=pass smtp.mailfrom=cmss.chinamobile.com;
	dkim=pass header.d=cmss.chinamobile.com header.i=@cmss.chinamobile.com header.a=rsa-sha256 header.s=default header.b=bV00zcj9;
	arc=none smtp.remote-ip=111.22.67.139
Received: from cmccmta6.chinamobile.com (cmccmta6.chinamobile.com [111.22.67.139])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 4B59F606A31C;
	Mon,  9 Nov 2026 01:33:41 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 4B59F606A31C
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=cmss.chinamobile.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=cmss.chinamobile.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=cmss.chinamobile.com header.i=@cmss.chinamobile.com header.a=rsa-sha256 header.s=default header.b=bV00zcj9
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=cmss.chinamobile.com; s=default; l=0;
	h=from:subject:message-id:to:cc:mime-version;
	bh=47DEQpj8HBSa+/TImW+5JCeuQeRkm5NMpJWZG3hSuFU=;
	b=bV00zcj9Xwgs8wUHgD3Z+TRPtAQ5SdZbSgMqwv033cyuLyhlhlM1h6iPu17tFlfwp+vx6EXzhExtf
	 8LI0yZs1ZqxDzsxbGElK1qHAVO0S2d9E3osfUlavu2yXqjgsMBXkuo/wtHXoMH/ao79Dc/ADeQ1yod
	 yh0p7E557XKIzToo=
X-RM-TagInfo: emlType=0                                       
X-RM-SPAM-FLAG:00000000
Received:from spf.mail.chinamobile.com (unknown[10.188.0.87])
	by rmmx-syy-dmz-app01-12001 (RichMail) with SMTP id 2ee16af122f4e3a-9a1ad;
	Mon, 09 Nov 2026 09:33:40 +0800 (CST)
X-RM-TRANSID:2ee16af122f4e3a-9a1ad
X-RM-TagInfo: emlType=0                                       
X-RM-SPAM-FLAG:00000000
Received:from Z04181456177947 (unknown[10.55.1.71])
	by rmsmtp-syy-appsvr09-12009 (RichMail) with SMTP id 2ee96af122f063a-7bfd3;
	Mon, 09 Nov 2026 09:33:39 +0800 (CST)
X-RM-TRANSID:2ee96af122f063a-7bfd3
From: Zhao Feng <zhaofeng2@cmss.chinamobile.com>
To: greybus-dev@lists.linaro.org
Cc: johan@kernel.org,
	elder@kernel.org,
	gregkh@linuxfoundation.org,
	elder@ieee.org,
	linux-kernel@vger.kernel.org,
	syzbot+693652ded53d3eb9cb91@syzkaller.appspotmail.com,
	Zhao Feng <zhaofeng2@cmss.chinamobile.com>,
	stable@vger.kernel.org
Subject: [PATCH] greybus: reject messages with claimed size smaller than header
Date: Mon,  9 Nov 2026 09:33:36 +0800
Message-ID: <20261109013336.1122-1-zhaofeng2@cmss.chinamobile.com>
X-Mailer: git-send-email 2.55.0.windows.5
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

gb_connection_recv() performs two sanity checks on received
messages: the receive buffer must hold at least a full message
header, and it must hold at least the message size claimed in the
header.  Neither check verifies that the claimed message size
covers the header itself.

A message claiming a size smaller than sizeof(struct
gb_operation_msg_hdr) (e.g. 7) passes both checks when 8 or more
bytes were received, and the claimed size is then used as the
message size:

- gb_operation_create_incoming() computes
  request_size = msg_size - sizeof(header), which underflows to
  SIZE_MAX.  The request handler then reads payload from a message
  whose payload size is SIZE_MAX; syzbot reported this as a KASAN
  global-buffer-overflow read in gb_svc_request_handler().
- gb_connection_recv_response() similarly computes
  payload_size = size - sizeof(*header) for accepted short
  responses, which underflows the same way.

Reject such messages up front in gb_connection_recv().  A claimed
size equal to the header size is valid (header only, no payload),
so the comparison must be strict.

Reported-by: syzbot+693652ded53d3eb9cb91@syzkaller.appspotmail.com
Closes: https://syzbot.org/bug?extid=693652ded53d3eb9cb91
Cc: stable@vger.kernel.org
Signed-off-by: Zhao Feng <zhaofeng2@cmss.chinamobile.com>
---
No Fixes tag: the missing validation dates back to the original
greybus import; the introducing commit could not be verified with
the trees available to me.

Not runtime-tested (no greybus hardware).  The affected function is
identical in current upstream master, so the patch applies there
as-is.

This also answers the question raised on the syzbot thread about
whether the underflow is reachable: it is, because the existing
checks compare the *received* size against the claimed size, never
the claimed size against the header size.

 drivers/greybus/operation.c | 6 ++++++
 1 file changed, 6 insertions(+)

diff --git a/drivers/greybus/operation.c b/drivers/greybus/operation.c
index 8459e9bc07..83b16c78f7 100644
--- a/drivers/greybus/operation.c
+++ b/drivers/greybus/operation.c
@@ -1046,6 +1046,12 @@ void gb_connection_recv(struct gb_connection *connection,
 	/* Use memcpy as data may be unaligned */
 	memcpy(&header, data, sizeof(header));
 	msg_size = le16_to_cpu(header.size);
+	if (msg_size < sizeof(header)) {
+		dev_err_ratelimited(dev,
+				    "%s: malformed message received (%zu < %zu)\n",
+				    connection->name, msg_size, sizeof(header));
+		return;
+	}
 	if (size < msg_size) {
 		dev_err_ratelimited(dev,
 				    "%s: incomplete message 0x%04x of type 0x%02x received (%zu < %zu)\n",
-- 
2.39.2



