Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CF70E36F917
	for <stable@vger.kernel.org>; Mon, 31 Aug 2026 16:42:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1788194567; cv=none; b=XsedEdh9xGeIdnAuM1RWqhHXfoYHfsvJCwROgY3XJ1Ly5FQIqb85Dw/A6zosQ3+QakyS7OjiosbayMgzSXTy5SHylD0QuasT7vKik3ImS1EjitZKY3Wzota2OFTRZ4Rtt1dcC6uJEDCntd/SXWdcgnLACgk8JnuY0Yn2YMoCEZs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1788194567; c=relaxed/simple;
	bh=Z/Hax0purXBnhY0/Sx6yym1mU9ul3AourHLxNt1sw7w=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=sdJJ68Tat9yGibklwC7gHpaaFPh9bsS0bkSKBs5DVU5VZj5jH2VQwZ2v8Kxe06CCWB5MghPYX/CNtwivJOg2nU3svod4wH1jbo8NnZZJtM9/Omz2nsfmH719MzO+shz4rPjIbjwhOcop7zTKWOUl8KU/RMdhG0IAfVZDQoqg5cM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=a+l5x0Yv; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="a+l5x0Yv"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 4113C1F000E9;
	Mon, 31 Aug 2026 16:42:45 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1788194565;
	bh=MVGcNLApYBcYaD3rfWkIkr/9qxzBC/GUODc/r5cUC2M=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References;
	b=a+l5x0YvKYhYT7fpdJ+xaWhcmGl7YNaGi2Jpe13w9Vo8OJXJNrfZgRkbLT/FKdyAI
	 VDJdBRvtVuW+enA0kVvCfJooieAsnBHH6DBiAfvYb1j19cTle9wvxnHembAgb8JmYb
	 SsGFm921mOzhXS5jM/LMwA4LNap3p64W6p6UYFwHXUwyzz8VoZvkPWs1RgnZdOqIds
	 PiV5q4iyO00wvKe8Jk3yuJh5ZJNotNXfL/JvvO8Gp+6lAx7RdS5V48o607YmAMv4JV
	 ZvX+MqBSDBLWKU3LM4NBqxwwO+Z8tSvBBSTuVJjOUlmzaNiucdgNgwe+9lcVon6nNy
	 WrLZTWyuNGK8w==
From: Sasha Levin <sashal@kernel.org>
To: stable@vger.kernel.org
Cc: Jiri Slaby <jslaby@suse.cz>,
	Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
	Sasha Levin <sashal@kernel.org>
Subject: [PATCH 5.10.y 1/5] tty: make tty_set_operations an inline
Date: Mon, 31 Aug 2026 12:42:39 -0400
Message-ID: <20260831164243.269282-1-sashal@kernel.org>
X-Mailer: git-send-email 2.53.0
In-Reply-To: <2026083142-everyday-fifteen-2ae3@gregkh>
References: <2026083142-everyday-fifteen-2ae3@gregkh>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

From: Jiri Slaby <jslaby@suse.cz>

[ Upstream commit cb9ea618ee60313d9278b2ba75f56da2531c8cac ]

Since commit f34d7a5b7010 (tty: The big operations rework) in 2008,
tty_set_operations() is a simple one-line assignment. There is no reason
for this to be an exported function, hence move it to a header and make
an inline from that.

Signed-off-by: Jiri Slaby <jslaby@suse.cz>
Link: https://lore.kernel.org/r/20210723074317.32690-7-jslaby@suse.cz
Signed-off-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
Stable-dep-of: a916fa66a43e ("xhci: dbgtty: Fix unregister on tty_register_driver() failure")
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 drivers/tty/tty_io.c       | 7 -------
 include/linux/tty_driver.h | 8 ++++++--
 2 files changed, 6 insertions(+), 9 deletions(-)

diff --git a/drivers/tty/tty_io.c b/drivers/tty/tty_io.c
index 984e3098e6317..e3ac7d084528f 100644
--- a/drivers/tty/tty_io.c
+++ b/drivers/tty/tty_io.c
@@ -3393,13 +3393,6 @@ void tty_driver_kref_put(struct tty_driver *driver)
 }
 EXPORT_SYMBOL(tty_driver_kref_put);
 
-void tty_set_operations(struct tty_driver *driver,
-			const struct tty_operations *op)
-{
-	driver->ops = op;
-};
-EXPORT_SYMBOL(tty_set_operations);
-
 void put_tty_driver(struct tty_driver *d)
 {
 	tty_driver_kref_put(d);
diff --git a/include/linux/tty_driver.h b/include/linux/tty_driver.h
index 2f719b471d524..05c1013aae94b 100644
--- a/include/linux/tty_driver.h
+++ b/include/linux/tty_driver.h
@@ -329,8 +329,6 @@ extern struct list_head tty_drivers;
 extern struct tty_driver *__tty_alloc_driver(unsigned int lines,
 		struct module *owner, unsigned long flags);
 extern void put_tty_driver(struct tty_driver *driver);
-extern void tty_set_operations(struct tty_driver *driver,
-			const struct tty_operations *op);
 extern struct tty_driver *tty_find_polling_driver(char *name, int *line);
 
 extern void tty_driver_kref_put(struct tty_driver *driver);
@@ -357,6 +355,12 @@ static inline struct tty_driver *tty_driver_kref_get(struct tty_driver *d)
 	return d;
 }
 
+static inline void tty_set_operations(struct tty_driver *driver,
+		const struct tty_operations *op)
+{
+	driver->ops = op;
+}
+
 /* tty driver magic number */
 #define TTY_DRIVER_MAGIC		0x5402
 
-- 
2.53.0

