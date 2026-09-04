Received: from mail-wr1-f43.google.com (mail-wr1-f43.google.com [209.85.221.43])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7747C3E9C2F
	for <stable@vger.kernel.org>; Fri,  4 Sep 2026 20:58:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.221.43
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1788555514; cv=none; b=jIQNNdXheDRM8ZPKYHHOJ277mAw8Mt815q3LzOFUBWVjHxTQ053+ipkAcO13bfs/HEP4KTH1jSiEFxEstNy8dzpW0ZvRmQgSkdsLGZO5PrUmvuydtywKHOXjJVE/eVWFfvo0YkIbGkMBwpGsb4RCuCyhQ+IWKuXGPV6JPJYrDpE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1788555514; c=relaxed/simple;
	bh=28uhGPjiJ2KFbOvQJhv6vfgzO9MJUM/PdqW0N3evoOk=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=QnDZpdc1q/Do/vXKwh8YsgItdbjJWAhyEZrnDNCv7IoRcoMlHFFXGAMz5Jz8V/N5aWGytzvp2Rn/NEYKC0EwPfNvNkyweS/e/1XRG3RropYntpz5rDf0g3EysBkS/kU8eCrgCI92r5bUmUz+1ORq7A1l/TZEk4x/2Q3zgz5TDOU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=PH8V1WhP; arc=none smtp.client-ip=209.85.221.43
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="PH8V1WhP"
Received: by mail-wr1-f43.google.com with SMTP id ffacd0b85a97d-484374f54d0so937072f8f.3
        for <stable@vger.kernel.org>; Fri, 04 Sep 2026 13:58:31 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1788555509; x=1789160309; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to:content-type;
        bh=6FQ7QnZPMANOssRW33us2G5YSu4ovcViTbmXD59gXys=;
        b=PH8V1WhP4MY8/RkgToK5DzOTP94PWrxluTheX7jM4xFd/4tlkSj5iBlHTTNrGiY+oi
         73OnMu2r3Pxdn4gOg0zeC9stTthceOp7FusjPU5ghzSvwFDRUokBlMj/P6kxu6LgbzVR
         TfMT9ymXggb1RfNnxLKlLyH3Se7LcfRnnpKVtNg0bZq84ptI5vtBxerIEoU4+SwWObGu
         nBD+NgXOFTts79Z2yAi57saCm1oNH0ycr9JOq2GEFbiaGvfToCk0DjYlYIIWcjn4joIF
         rquE4JEEd0QMhfEo9T1fryjnHJWbysushTntxOcVWjyONbeQLGCzLnyneF4YyLwRrun3
         jKWw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1788555509; x=1789160309;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=6FQ7QnZPMANOssRW33us2G5YSu4ovcViTbmXD59gXys=;
        b=d3R8yTm3FHeZc3F1KP9aFeCEBA3gv011XQD8iNMBXjaozr6bb59gVyq6m4S8wYBkDF
         7hC3Ct02JG6R+l0G0WY1irHkbWBVYhTzVtuKMxyIg3RJIR55Rl/Lo+nFgYB7+ULdZ8/m
         CrKpKqBB40xYElmmLm3f9LncIes4rXy/lOJ+L4OPwbRzTbPs4U31rYA+nbOBZMVbmsgO
         zHpXuZbeGJbHURjDj94h1OXiOBPdWdiPbXJnnmvxmJ/Gqq+odphoNR3dqTsQtTvVLAyR
         DRRwUfRjjkBPo4lo7czUTGYA1UGreSrwz9FWp/+Zx8/yveWBAvi5f2L5LIh6zVmT9ZmU
         L/Ig==
X-Forwarded-Encrypted: i=1; AKwUvBxPHpOPOjtAbfRAANz4vJ5EUhH2VSy9HeeElYxaa43m4miMthRSkh3PtqxMMl5wqLw6XA0ym7A=@vger.kernel.org
X-Gm-Message-State: AFuF++ny05XMMLmYkh6YMYHZ09Q//9JnHqQiD7UJ9ArBUFqO+zeCLdpe
	D11kPfvq6au+5lv8/Mrhl3f+2/W3HQDh7uX41TmUr8OLI5WsRWLpXFE=
X-Gm-Gg: AYBFou0t6gMCZr5s4TZvqOxDmWFqcVZWBgvv8Znhr71AzlrYm+l/bGAOqfBPwIolLOl
	u/xkjoDIMg3PW5Jb3bwYF7Lrck75Xdb3gbrBcmAxOlB8+5SE/oW3Uvd6pvv/xmI+87nEU3KNtZh
	OBma4xlCU07PbhUIOWBaSBrvbSY2r9pDTHWftWZA9j4LwxZOIPHpMjcgn/I78sNtwzfgktcp63N
	8ilfyW4W1w/c9E9L/Eu3jtc/jxfK0Tkt/Hb7Zr6zytJTi4kkwp0cMLFjTub+9y04cSFZ0I8O44b
	r+dvKBImvZ9+7RcmgB4tAXPGd5ALuSMfGgE+TuIECy+I5hV2FsaJ5AvVo53BogGCaFKaPgfp7sp
	PA13m9xSAmgL1+WDNlw+uS3TBJxUUu/UrOU49nv6wxCUEkOmikqAxKaYm90XbELKqxZEkmMt5fb
	qGjMR7xZYlAj9AVV3o7f6EN7PK7XBJeWzzK6k97rFfbw==
X-Received: by 2002:a05:6000:26c4:b0:485:847c:4c64 with SMTP id ffacd0b85a97d-4858729b6f7mr16087150f8f.28.1788555508729;
        Fri, 04 Sep 2026 13:58:28 -0700 (PDT)
Received: from debian.. ([2001:41d0:303:db6b::])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-4858d312ca0sm5789563f8f.4.2026.09.04.13.58.27
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 04 Sep 2026 13:58:27 -0700 (PDT)
From: Tristan Madani <tristmd@gmail.com>
To: Jaroslav Kysela <perex@perex.cz>,
	Takashi Iwai <tiwai@suse.com>
Cc: linux-sound@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	stable@vger.kernel.org,
	Tristan Madani <tristan@talencesecurity.com>
Subject: [PATCH v2 1/2] ALSA: usbusx2y: fix in04_last array size mismatch with in04_buf
Date: Fri,  4 Sep 2026 20:58:25 +0000
Message-ID: <20260904205826.4071119-1-tristmd@gmail.com>
X-Mailer: git-send-email 2.47.3
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

From: Tristan Madani <tristan@talencesecurity.com>

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
---
v2: Introduce USX2Y_IN04_SIZE constant and replace all magic number
    occurrences, per Takashi Iwai review [Takashi Iwai]
 sound/usb/usx2y/usbusx2y.c | 6 +++---
 sound/usb/usx2y/usbusx2y.h | 4 +++-
 2 files changed, 6 insertions(+), 4 deletions(-)

diff --git a/sound/usb/usx2y/usbusx2y.c b/sound/usb/usx2y/usbusx2y.c
index 4190227c5a2a5..200b708aacd6d 100644
--- a/sound/usb/usx2y/usbusx2y.c
+++ b/sound/usb/usx2y/usbusx2y.c
@@ -196,7 +196,7 @@ static void i_usx2y_in04_int(struct urb *urb)
 			memcpy(usx2y->in04_last, usx2y->in04_buf, sizeof(usx2y->in04_last));
 			us428ctls->ctl_snapshot_last = -1;
 		} else {
-			for (i = 0; i < 21; i++) {
+			for (i = 0; i < USX2Y_IN04_SIZE; i++) {
 				if (usx2y->in04_last[i] != ((char *)usx2y->in04_buf)[i]) {
 					if (diff < 0)
 						diff = i;
@@ -305,7 +305,7 @@ int usx2y_in04_init(struct usx2ydev *usx2y)
 		goto error;
 	}
 
-	usx2y->in04_buf = kmalloc(21, GFP_KERNEL);
+	usx2y->in04_buf = kmalloc(USX2Y_IN04_SIZE, GFP_KERNEL);
 	if (!usx2y->in04_buf) {
 		err = -ENOMEM;
 		goto error;
@@ -313,7 +313,7 @@ int usx2y_in04_init(struct usx2ydev *usx2y)
 
 	init_waitqueue_head(&usx2y->in04_wait_queue);
 	usb_fill_int_urb(usx2y->in04_urb, usx2y->dev, usb_rcvintpipe(usx2y->dev, 0x4),
-			 usx2y->in04_buf, 21,
+			 usx2y->in04_buf, USX2Y_IN04_SIZE,
 			 i_usx2y_in04_int, usx2y,
 			 10);
 	if (usb_urb_ep_type_check(usx2y->in04_urb)) {
diff --git a/sound/usb/usx2y/usbusx2y.h b/sound/usb/usx2y/usbusx2y.h
index 6a76d04bf1c7d..7b6deed17d4b1 100644
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
2.47.3

