Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6BADF4AAC73
	for <stable@vger.kernel.org>; Wed, 16 Sep 2026 15:49:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1789573753; cv=none; b=a8QNC4BCnb3n8czgYCrrFHlmbt15sLgBFVggK2hgPETq84b5iQYBGkcJ+zskBkBNLzDGoJOSepi0NRDDRTV7QNSUUzn7CUrFHlW/8KPhrBKhKSAvvOLj8KcUn2nSsgeYsrLlCgjvR41qtc1ogCPIltgNjrM9GfEFq8s6Ps5M5ic=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1789573753; c=relaxed/simple;
	bh=IBqFvT7C66L1v0kdvTAUAQ/YkgwwymqUwJQFUF/027w=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=LvATWLYUI0CooZyFRt2dtCrsXEJ3TrJmz76ttmNvewbUiAIE0+gSnGjdV4emC5fHY65+yAAHNnHTwmXSqcQlVccQ5vwLGf9YCKmq8cWY21F3wQTYWKYp3oTXOYFKxD2wHgQrb/OLgJc3VkzxWqgWuJ0QydkO9QlRwusjjKF/OOs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=OBi5hkTp; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="OBi5hkTp"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 5B0241F00898;
	Wed, 16 Sep 2026 15:49:10 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1789573750;
	bh=BC6b7r7RV5/ey2Td63zvwVc2BTCi8bG6RR4ZdvGC7iE=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References;
	b=OBi5hkTpq6PBjfU0ZEx8ndhuxnqI0TcUs93aQAl1RbSLupuDnD5QDkcG5KGYH7Z7R
	 DVx73lTdNr6Bm3M6IyCAntDxZNUKri0UOMBeqe3VX1+vC2f8PBI93tbjyWFqpRo08L
	 g3QAXyhkwxHRbba+Pf0vkJWSM3IiQe3/d8qPxEZ8OLOvMQAc8Zlk0IGf8pMp4jpc2+
	 iZ0W0a2kc/NLTz/W2mTERb3P3AZchjFGWhpmrDRaalelCy0sZUgHR01Jz5cNjKBTe8
	 GEmX+IvnP/8M6zFyvoF+L83gMpd5uOzGRSS7ytZ+6wADeZyVrLYj4cwufnb8EGnseR
	 nS9vI9EmAsa4w==
From: Sasha Levin <sashal@kernel.org>
To: stable@vger.kernel.org
Cc: Tristan Madani <tristan@talencesecurity.com>,
	Takashi Iwai <tiwai@suse.de>,
	Sasha Levin <sashal@kernel.org>
Subject: [PATCH 5.10.y 2/2] ALSA: usbusx2y: fix in04_last array size mismatch with in04_buf
Date: Wed, 16 Sep 2026 11:49:08 -0400
Message-ID: <20260916154908.4167359-2-sashal@kernel.org>
X-Mailer: git-send-email 2.53.0
In-Reply-To: <20260916154908.4167359-1-sashal@kernel.org>
References: <2026091636-ultimatum-procurer-683f@gregkh>
 <20260916154908.4167359-1-sashal@kernel.org>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

From: Tristan Madani <tristan@talencesecurity.com>

[ Upstream commit 861111a14740e12c36d363e9830f8daa734279c9 ]

The in04_last array in struct usx2ydev is declared as char[24], but
in04_buf is allocated as sizeof(struct us428_ctls) which is 21 bytes.
In i_usx2y_in04_int(), when ctl_snapshot_last == -2 (initialization
path):

    memcpy(usx2y->in04_last, usx2y->in04_buf, sizeof(usx2y->in04_last));

This copies 24 bytes from a 21-byte slab allocation, reading 3 bytes
past the end of the source object.

Introduce a USX2Y_IN04_SIZE constant defined as sizeof(struct
us428_ctls) and use it consistently for the in04_last array, the
in04_buf allocation, the URB transfer length, and the comparison loop,
replacing the bare 24 and 21 literals throughout.

Fixes: 1da177e4c3f4 ("Linux-2.6.12-rc2")
Cc: stable@vger.kernel.org
Signed-off-by: Tristan Madani <tristan@talencesecurity.com>
Link: https://patch.msgid.link/20260904205826.4071119-1-tristmd@gmail.com
Signed-off-by: Takashi Iwai <tiwai@suse.de>
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 sound/usb/usx2y/usbusx2y.c | 6 +++---
 sound/usb/usx2y/usbusx2y.h | 4 +++-
 2 files changed, 6 insertions(+), 4 deletions(-)

diff --git a/sound/usb/usx2y/usbusx2y.c b/sound/usb/usx2y/usbusx2y.c
index 4d05f1997362d..26dacec9f0abe 100644
--- a/sound/usb/usx2y/usbusx2y.c
+++ b/sound/usb/usx2y/usbusx2y.c
@@ -198,7 +198,7 @@ static void i_usx2y_in04_int(struct urb *urb)
 			memcpy(usx2y->in04_last, usx2y->in04_buf, sizeof(usx2y->in04_last));
 			us428ctls->ctl_snapshot_last = -1;
 		} else {
-			for (i = 0; i < 21; i++) {
+			for (i = 0; i < USX2Y_IN04_SIZE; i++) {
 				if (usx2y->in04_last[i] != ((char *)usx2y->in04_buf)[i]) {
 					if (diff < 0)
 						diff = i;
@@ -300,7 +300,7 @@ int usx2y_in04_init(struct usx2ydev *usx2y)
 		goto error;
 	}
 
-	usx2y->in04_buf = kmalloc(21, GFP_KERNEL);
+	usx2y->in04_buf = kmalloc(USX2Y_IN04_SIZE, GFP_KERNEL);
 	if (!usx2y->in04_buf) {
 		err = -ENOMEM;
 		goto error;
@@ -308,7 +308,7 @@ int usx2y_in04_init(struct usx2ydev *usx2y)
 
 	init_waitqueue_head(&usx2y->in04_wait_queue);
 	usb_fill_int_urb(usx2y->in04_urb, usx2y->dev, usb_rcvintpipe(usx2y->dev, 0x4),
-			 usx2y->in04_buf, 21,
+			 usx2y->in04_buf, USX2Y_IN04_SIZE,
 			 i_usx2y_in04_int, usx2y,
 			 10);
 	if (usb_urb_ep_type_check(usx2y->in04_urb)) {
diff --git a/sound/usb/usx2y/usbusx2y.h b/sound/usb/usx2y/usbusx2y.h
index 06110143fea81..78492f72abb6c 100644
--- a/sound/usb/usx2y/usbusx2y.h
+++ b/sound/usb/usx2y/usbusx2y.h
@@ -5,6 +5,8 @@
 #include "../midi.h"
 #include "usbus428ctldefs.h"
 
+#define USX2Y_IN04_SIZE	sizeof(struct us428_ctls)
+
 #define NRURBS	        2
 
 /* Default value used for nr of packs per urb.
@@ -55,7 +57,7 @@ struct usx2ydev {
 	int			stride;
 	struct urb		*in04_urb;
 	void			*in04_buf;
-	char			in04_last[24];
+	char			in04_last[USX2Y_IN04_SIZE];
 	unsigned int		in04_int_calls;
 	struct snd_usx2y_urb_seq	*us04;
 	wait_queue_head_t	in04_wait_queue;
-- 
2.53.0

