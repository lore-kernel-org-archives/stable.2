Received: from mail-m155101.qiye.163.com (mail-m155101.qiye.163.com [101.71.155.101])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1C5AB31F9B1;
	Sat, 12 Sep 2026 16:12:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=101.71.155.101
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1789229544; cv=none; b=GxRNOKRPH2piLz2VSG/64rKbFNSiSwM8TdohFscT9jjiFETnCuoY6EnWXGFxfMD2WsoU270yUFSj88j4GDju7V6MKxybn8p/H/1+33M3k4KU5iMzdh+6iiDMbpGhYeA6PkrZns6tuATau8OhjwoXCq3xz4RdR4ZpcoOXpDYeSPM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1789229544; c=relaxed/simple;
	bh=gYyEEGxM144WobPG0PkEu1gZ4Dhzeyc0tdt0Aa5yEFk=;
	h=From:To:Cc:Subject:Date:Message-Id:MIME-Version; b=XrGcTml9H0wQqlRdX10NsGDsx2e99hTu5qiJ0TnhA8WNBUFurVixl5uJ4UBT98DnbOmZ2Gjqor+cZVflUCqU+oslY/8N4HDHu+D+UtKwooJAWoa8uBuouthJOJ+tSMy/yzIa3Y9TKU+K9TM4iieSATiRlvzzLxyqKBq/h39JSUI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=tju.edu.cn; spf=pass smtp.mailfrom=tju.edu.cn; dkim=pass (1024-bit key) header.d=tju.edu.cn header.i=@tju.edu.cn header.b=OR/kKeYc; arc=none smtp.client-ip=101.71.155.101
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=tju.edu.cn
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=tju.edu.cn
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=tju.edu.cn header.i=@tju.edu.cn header.b="OR/kKeYc"
Received: from tju.edu.cn (gy-adaptive-ssl-proxy-4-entmail-virt151.gy.ntes [183.242.150.9])
	by smtp.qiye.163.com (Hmail) with ESMTP id 4d867e247;
	Sun, 13 Sep 2026 00:12:06 +0800 (GMT+08:00)
From: Yibo Tan <lhfff@tju.edu.cn>
To: Andy Shevchenko <andy@kernel.org>,
	Geert Uytterhoeven <geert@linux-m68k.org>
Cc: =?UTF-8?q?Jean-Fran=C3=A7ois=20Lessard?= <jefflessard3@gmail.com>,
	Surendra Singh Chouhan <kr494167@gmail.com>,
	Chris Packham <chris.packham@alliedtelesis.co.nz>,
	linux-kernel@vger.kernel.org,
	stable@vger.kernel.org
Subject: [PATCH v1] auxdisplay: linedisp: prepare message before registration
Date: Sun, 13 Sep 2026 00:11:52 +0800
Message-Id: <20260912161152.1683002-1-lhfff@tju.edu.cn>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-HM-Tid: 0aa09663ed8603a1kunm4452ca3d21d6b8
X-HM-MType: 10
X-HM-Spam-Status: e1kfGhgUHx5ZQUpXWQgPGg8OCBgUHx5ZQUlOS1dZFg8aDwILHllBWSg2Ly
	tZV1koWUFITzdXWRgWCB1ZQUpXWS1ZQUlXWQ8JGhUIEh9ZQVkZTx9KVhgaSB8fQ0oZTB8aTlYeHw
	5VEwETFhoSFyQUDg9ZV1kYEgtZQVlKQ0hVSU9JVUpOS1VCWVdZFhoPEhUdFFlBWU9LSFVKS0hKTk
	xOVUpLS1VKQktLWQY+
DKIM-Signature: a=rsa-sha256;
	b=OR/kKeYcyxopjxIg1be77v2laqN4phWcvnrFPWOWPolEA60MokP657PKixI8Vfq0j6sIW2x+vVQLbEQg+A9oUkw94iqMta1skMxNbikcpJr35gzgdT8bcQj5BvsCKZuS76UEzwvpW80/ZdsTdINl9eTDk0lY95C/+SfT609I4+c=; c=relaxed/relaxed; s=default; d=tju.edu.cn; v=1;
	bh=b/HE8L6+deoaN+E+/Sb/hspBLwOnnLTTfe61QrIbmpc=;
	h=date:mime-version:subject:message-id:from;

Since the line-display attachment support was added, linedisp_register()
has displayed its initial message before calling device_add().  The
HT16K33, MAX6959 and GPIO segment drivers implement display updates with
delayed work, so that display operation can publish driver-owned work
before the final fallible registration step.

If device_add() fails, the registration error path releases the display
buffers and the caller's probe failure releases its managed private data.
The admitted worker can then access both freed objects.  In an HT16K33
KASAN reproducer, a real device_add() -EEXIST failure produced a
slab-use-after-free first in __pwq_activate_work() and then in
ht16k33_seg7_update().

The vulnerable kernel queued and executed the freed HT16K33 work in three
of three runs.  With this change, the same three runs reached the same
device_add() failure without queuing the update and produced no KASAN,
WARNING, Oops or panic.

Separate message preparation from the hardware update.  Prepare the
initial message before registering the device or attribute groups, and
only invoke the non-failing update after registration succeeds.  Apply the
same ordering to linedisp_attach(), which has the same static pattern but
currently has no in-tree caller.

Fixes: 3ba5c78fe7c5 ("auxdisplay: linedisp: support attribute attachment to auxdisplay devices")
Cc: stable@vger.kernel.org
Assisted-by: Codex:GPT-5
Signed-off-by: Yibo Tan <lhfff@tju.edu.cn>
---
 drivers/auxdisplay/line-display.c | 63 +++++++++++++++++++++----------
 1 file changed, 43 insertions(+), 20 deletions(-)

diff --git a/drivers/auxdisplay/line-display.c b/drivers/auxdisplay/line-display.c
index 915eb5cd96b2..d5854a9ac9b0 100644
--- a/drivers/auxdisplay/line-display.c
+++ b/drivers/auxdisplay/line-display.c
@@ -149,20 +149,8 @@ static void linedisp_scroll(struct timer_list *t)
 	mod_timer(&linedisp->timer, jiffies + linedisp->scroll_rate);
 }
 
-/**
- * linedisp_display() - set the message to be displayed
- * @linedisp: pointer to the private data structure
- * @msg: the message to display
- * @count: length of msg, or -1
- *
- * Display a new message @msg on the display. @msg can be longer than the
- * number of characters the display can display, in which case it will begin
- * scrolling across the display.
- *
- * Return: 0 on success, -ENOMEM on memory allocation failure
- */
-static int linedisp_display(struct linedisp *linedisp, const char *msg,
-			    ssize_t count)
+static int linedisp_set_message(struct linedisp *linedisp, const char *msg,
+				ssize_t count)
 {
 	char *new_msg;
 
@@ -181,8 +169,6 @@ static int linedisp_display(struct linedisp *linedisp, const char *msg,
 		kfree(linedisp->message);
 		linedisp->message = NULL;
 		linedisp->message_len = 0;
-		memset(linedisp->buf, ' ', linedisp->num_chars);
-		linedisp->ops->update(linedisp);
 		return 0;
 	}
 
@@ -195,6 +181,16 @@ static int linedisp_display(struct linedisp *linedisp, const char *msg,
 	linedisp->message = new_msg;
 	linedisp->message_len = count;
 	linedisp->scroll_pos = 0;
+	return 0;
+}
+
+static void linedisp_update(struct linedisp *linedisp)
+{
+	if (!linedisp->message_len) {
+		memset(linedisp->buf, ' ', linedisp->num_chars);
+		linedisp->ops->update(linedisp);
+		return;
+	}
 
 	if (should_scroll(linedisp)) {
 		/* display scrolling message */
@@ -206,7 +202,30 @@ static int linedisp_display(struct linedisp *linedisp, const char *msg,
 		       umin(linedisp->num_chars, linedisp->message_len));
 		linedisp->ops->update(linedisp);
 	}
+}
 
+/**
+ * linedisp_display() - set the message to be displayed
+ * @linedisp: pointer to the private data structure
+ * @msg: the message to display
+ * @count: length of msg, or -1
+ *
+ * Display a new message @msg on the display. @msg can be longer than the
+ * number of characters the display can display, in which case it will begin
+ * scrolling across the display.
+ *
+ * Return: 0 on success, -ENOMEM on memory allocation failure
+ */
+static int linedisp_display(struct linedisp *linedisp, const char *msg,
+			    ssize_t count)
+{
+	int err;
+
+	err = linedisp_set_message(linedisp, msg, count);
+	if (err)
+		return err;
+
+	linedisp_update(linedisp);
 	return 0;
 }
 
@@ -461,8 +480,7 @@ int linedisp_attach(struct linedisp *linedisp, struct device *dev,
 	if (err)
 		goto out_del_timer;
 
-	/* display a default message */
-	err = linedisp_display(linedisp, LINEDISP_INIT_TEXT, -1);
+	err = linedisp_set_message(linedisp, LINEDISP_INIT_TEXT, -1);
 	if (err)
 		goto out_del_attach;
 
@@ -471,6 +489,9 @@ int linedisp_attach(struct linedisp *linedisp, struct device *dev,
 	if (err)
 		goto out_del_attach;
 
+	/* display the prepared default message */
+	linedisp_update(linedisp);
+
 	return 0;
 
 out_del_attach:
@@ -557,8 +578,7 @@ int linedisp_register(struct linedisp *linedisp, struct device *parent,
 	if (err)
 		goto out_del_timer;
 
-	/* display a default message */
-	err = linedisp_display(linedisp, LINEDISP_INIT_TEXT, -1);
+	err = linedisp_set_message(linedisp, LINEDISP_INIT_TEXT, -1);
 	if (err)
 		goto out_del_attach;
 
@@ -566,6 +586,9 @@ int linedisp_register(struct linedisp *linedisp, struct device *parent,
 	if (err)
 		goto out_del_attach;
 
+	/* display the prepared default message */
+	linedisp_update(linedisp);
+
 	return 0;
 
 out_del_attach:
-- 
2.39.5

