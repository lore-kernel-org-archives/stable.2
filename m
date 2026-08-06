Received: from out28-49.mail.aliyun.com (out28-49.mail.aliyun.com [115.124.28.49])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 346043E7BCA;
	Thu,  6 Aug 2026 08:48:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=115.124.28.49
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1786006144; cv=none; b=KdlOtv6EfZGYeUBSkvTL3V4i43S9m/lzR5TwyfBGqsWjC+/njQ2cuoZ3UUMIaYtukCU7GI61gfSXMt5AJHk+Zk/IjLznZzwwuP6sb4OjFJsqan9YX3TKg5fvTF/Jcw4FbIsMjaE0tnPdf9XzG5HreI+QkPNsrkCkfTtWjXMvB48=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1786006144; c=relaxed/simple;
	bh=ZzYXGmTzv4QVV8SSCybvheGfYbxTATrKUA9tZOWdiVk=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=aVkZti3Sy8Lf7j0orNV/mkLv92nKQVTj/8WrZq7THHi7War5XlDTrJlsp08yF9HjMoKPZSxCWx0g4WxF/Q4QxrsvO/F/l2Ua6uDSx6zAgMMzXK2lHIeCqVv1K0JS7JuIshGQ4gsoSFF7+730XBNB8ZJk/2kO7SVMsah2kgvXDsI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=open-hieco.net; spf=pass smtp.mailfrom=open-hieco.net; arc=none smtp.client-ip=115.124.28.49
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=open-hieco.net
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=open-hieco.net
X-Alimail-AntiSpam:AC=CONTINUE;BC=0.07692014|-1;CH=green;DM=|CONTINUE|false|;DS=CONTINUE|ham_regular_dialog|0.000380969-2.64148e-05-0.999593;FP=12043138144921380551|11|2|10|0|-1|-1|-1;HT=maildocker-contentspam033032023038;MF=lixiaochun@open-hieco.net;NM=1;PH=DS;RN=7;RT=7;SR=0;TI=SMTPD_---.ifBIU-d_1786006110;
Received: from dev02(mailfrom:lixiaochun@open-hieco.net fp:SMTPD_---.ifBIU-d_1786006110 cluster:ay29)
          by smtp.aliyun-inc.com;
          Thu, 06 Aug 2026 16:48:50 +0800
From: Xiaochun Li <lixiaochun@open-hieco.net>
To: gregkh@linuxfoundation.org,
	jirislaby@kernel.org
Cc: john.ogness@linutronix.de,
	linux-kernel@vger.kernel.org,
	linux-serial@vger.kernel.org,
	Xiaochun Li <lixiaochun@open-hieco.net>,
	stable@vger.kernel.org
Subject: [PATCH v2] serial: core: Fix a NULL pointer dereference in uart_parse_earlycon()
Date: Thu,  6 Aug 2026 16:48:27 +0800
Message-ID: <20260806084827.16239-1-lixiaochun@open-hieco.net>
X-Mailer: git-send-email 2.52.0
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

console=uart and console=pl011 can reach the preferred console matching
path without an options field when a comma is absent from the command
line. In that case uart_parse_earlycon() receives a NULL pointer and
immediately passes it to strncmp(), which triggers a NULL pointer
dereference during console matching.

Address this by returning -EINVAL when the options pointer is missing,
ensuring incomplete console arguments are cleanly rejected while
preserving the behavior of all valid earlycon-style command lines.

Fixes: 73abaf87f01b ("serial: earlycon: Refactor parse_options into serial core")
Signed-off-by: Xiaochun Li <lixiaochun@open-hieco.net>
Cc: stable@vger.kernel.org
---
Changes in v2:
- Add Cc: stable@vger.kernel.org tag

 drivers/tty/serial/serial_core.c | 6 +++++-
 1 file changed, 5 insertions(+), 1 deletion(-)

diff --git a/drivers/tty/serial/serial_core.c b/drivers/tty/serial/serial_core.c
index a530ad372b43..02e770bf8bf6 100644
--- a/drivers/tty/serial/serial_core.c
+++ b/drivers/tty/serial/serial_core.c
@@ -2084,7 +2084,8 @@ EXPORT_SYMBOL_GPL(uart_console_write);
 
 /**
  * uart_parse_earlycon - Parse earlycon options
- * @p:	     ptr to 2nd field (ie., just beyond '<name>,')
+ * @p:	     ptr to 2nd field (ie., just beyond '<name>,'); %NULL if
+ *	     no console options were supplied
  * @iotype:  ptr for decoded iotype (out)
  * @addr:    ptr for decoded mapbase/iobase (out)
  * @options: ptr for <options> field; %NULL if not present (out)
@@ -2104,6 +2105,9 @@ EXPORT_SYMBOL_GPL(uart_console_write);
 int uart_parse_earlycon(char *p, enum uart_iotype *iotype,
 			resource_size_t *addr, char **options)
 {
+	if (!p)
+		return -EINVAL;
+
 	if (strncmp(p, "mmio,", 5) == 0) {
 		*iotype = UPIO_MEM;
 		p += 5;
-- 
2.52.0

