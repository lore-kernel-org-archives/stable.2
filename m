Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=74.125.82.69
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1795645333;
	b=45HRJgct0mnU9lpModKK7vtitkHxsXP6VhB7KNwbvWJLQcv4ZnYpfIsvY4Q8VNaYNAYy
	 jflc9HC706d/PgRabnI7kesbyPTo2d4nbQQxMvpwTQNzH0wC3+4EnsVXdLwx3lbIHkP04
	 Tp5uMOTO96Qt2Kdq83mGRqlPU21qN5w4m6p+62B0B+y+YywnLTwfjWuE0D4r2dXTdwvyi
	 D4jOoroLK5g3b3bFfU4t0UzIit+FlpfeAlB8Ub2ZD85AtZRz8GvvI94yuXDW+65pmaBBo
	 z7Y8jB1IfDB2poL8PtCy0H4v6srn9SdQZ5Jgo2JE0LxdO1i1JoUpOYTxzE3klpxkqDQ==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1795645333;
	h=DMARC-Filter:Received:DKIM-Signature:X-Google-DKIM-Signature:
	 X-Forwarded-Encrypted:X-Gm-Message-State:X-Received:Date:In-Reply-To:
	 Mime-Version:References:X-Mailer:Message-ID:Subject:From:To:Cc:
	 Content-Type;
	bh=SKmb0CjpLP4ITLhIHnRihH0kGoAN8DUIdYytp7QeTFg=;
	b=O5Iu1wbvMNY/nroOpI2m8lyrRJjsQ9RGgFBHTiflps7B9E7dptDOros7nJsHAOQEqTUj
	 OkMQeCHLPTMTpQvW0LVHlG2VdIBm8oX5hmCFcK/FLSezXgwlqYuPCvDQ0LAWfIaakOVTs
	 vrrBuenI2KXpMbKJjhVp4nXMOqCCBaGCLr4JsFqjeH9tpGqBOPAob7f4J5DOLIwinXVti
	 qbsaKStjMXkVB/W/BT5FikgOYIAp6nhZU9sy1Z/xsSORIQu4kQtLx0zxJx6QM2s4i0Dfr
	 FuLqbOiqkig8udihfaL7xi9HHyxmTLlOrNOBQJWD+6e3bBRKxcsJhxon4kZGQ8CsyWg==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=google.com;
	spf=pass smtp.mailfrom=flex--elkin.bounces.google.com;
	dkim=pass header.d=google.com header.i=@google.com header.a=rsa-sha256 header.s=20260707 header.b="C7vmu//r";
	arc=none smtp.remote-ip=74.125.82.69
Received: from mail-dl1-f69.google.com (mail-dl1-f69.google.com [74.125.82.69])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2AF6D606A336
	for <stable@vger.kernel.org>; Wed, 25 Nov 2026 22:22:13 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 2AF6D606A336
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=flex--elkin.bounces.google.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.a=rsa-sha256 header.s=20260707 header.b=C7vmu//r
Received: by mail-dl1-f69.google.com with SMTP id a92af1059eb24-1b55f4f3bb8so3608403c88.0
        for <stable@vger.kernel.org>; Wed, 25 Nov 2026 14:22:13 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20260707; t=1795645332; x=1796250132; darn=vger.kernel.org;
        h=content-type:cc:to:from:subject:message-id:references:mime-version
         :in-reply-to:date:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=SKmb0CjpLP4ITLhIHnRihH0kGoAN8DUIdYytp7QeTFg=;
        b=C7vmu//rPE7qJxsInMDe3csjs+tO4/QDVHFDSIvT+y17NQiLq3mxOmMeX4DsnNWdMY
         bWqHcoTd7rsR18nOTJeMc/w5fSlUAcgZZznl0L6GZ0QoNzfxRZ1cfPRUuA3ApA6sR+RU
         d7A/D2mUlaZpWNJtO0CZtIilTiE4ODtGckcGiAJ+QQcKUXBoHcMCDI9eeG+XTzFXxwcb
         +AUSZRlNnCEltt2Vqoe8X7iMOHgPC4BKe2gucFk+itlmeNPP3wQ8dTXTVcisOQXi1yQF
         6bOqruEiFGguX062f7H0OnezvGrT4M9vYsUfBIjzmSnOa5ceuonw3by5TitiOH83I69y
         eNVw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1795645332; x=1796250132;
        h=content-type:cc:to:from:subject:message-id:references:mime-version
         :in-reply-to:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=SKmb0CjpLP4ITLhIHnRihH0kGoAN8DUIdYytp7QeTFg=;
        b=XQ73iD4DJf+2ne8pgj3tR6M5EW8+pnMY8wDiLs73NjB9nMSlr8WMXnW9gTinteSaLM
         fXsjTypcBngL7nmkStzMnDvSJp0ufCjDBqRBZ6fS/rltgFRVQdHZsY2NYj1gR+u8fqqM
         IbJeYO2bZCIlsRRbFNDzpsE4tZrJAKrHXo0+b4wsCEpyC2pNOsY3RSBj2uHyCj9ted2B
         S8sMScWNZNrpa2tfAuHEgMX9Xpc7ZutZO5nTyXAgIb0+nl/ZE+3FkQ9Sb3CawbR+9mDh
         SKBzBiFWO2pN89n3RibEoahAiDa9aRPjyqzREXnLuln2tiGRFQubKDEXCR/gvQ/UW6WW
         32MA==
X-Forwarded-Encrypted: i=1; AL+hErGHiTYjFY0GsAS8ElmpQxWJKltwdFNbEzp+V5WdG1D12DgFQEd3EnuqhJHeS9vTyR314/5tbIU=@vger.kernel.org
X-Gm-Message-State: APuU4Z+M6+giaEiG1JVv+fcyPCIEosPl3DgBRwihMjJCtI+KyvRcJDWm
	OAKCccMzDToL7OYHkW557wDa5TOhvAiS/9izkyYlf4UK27koLlevfLCMGX3p8ODSKMQnRdyNn3M
	ESw==
X-Received: from dlgw19-n1.prod.google.com ([2002:a05:701a:cc93:10b0:1b5:7477:ff02])
 (user=elkin job=prod-delivery.src-stubby-dispatcher) by 2002:a05:701b:2701:b0:1b2:43cc:48
 with SMTP id a92af1059eb24-1b5568e8253mr16557418c88.33.1795645331978; Wed, 25
 Nov 2026 14:22:11 -0800 (PST)
Date: Wed, 25 Nov 2026 22:21:02 +0000
In-Reply-To: <20261125222102.1430675-1-elkin@google.com>
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Post: <mailto:stable@vger.kernel.org>
List-Help: <mailto:stable+help@vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
List-Owner: <mailto:stable+owner@vger.kernel.org>
Precedence: list
Mime-Version: 1.0
References: <20261125222102.1430675-1-elkin@google.com>
X-Mailer: git-send-email 2.56.1.839.g22a8290db9-goog
Message-ID: <20261125222102.1430675-3-elkin@google.com>
Subject: [PATCH 2/2] media: s2255: advance marker pointer and use unaligned
 reads in save_frame
From: Elkin Cruz <elkin@google.com>
To: Mauro Carvalho Chehab <mchehab@kernel.org>
Cc: linux-media@vger.kernel.org, linux-kernel@vger.kernel.org, 
	llvm@lists.linux.dev, irogers@google.com, Elkin Cruz <elkin@google.com>, 
	stable@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"

In save_frame(), pdword was initialized once from transfer_buffer before
the marker-search loop and never updated as jj incremented, repeatedly
inspecting offset 0 instead of scanning through the transfer buffer.

Derive pdata from pipe_info->transfer_buffer + jj on each iteration and
read the 32-bit little-endian marker and header fields via get_unaligned()
and get_unaligned_le32() since jj advances one byte at a time.

Fixes: 3fa0060526ea ("V4L/DVB: s2255drv: fixes for big endian arch")
Cc: stable@vger.kernel.org
Signed-off-by: Elkin Cruz <elkin@google.com>
---
 drivers/media/usb/s2255/s2255drv.c | 34 ++++++++++++++++--------------
 1 file changed, 18 insertions(+), 16 deletions(-)

diff --git a/drivers/media/usb/s2255/s2255drv.c b/drivers/media/usb/s2255/s2255drv.c
index 9ddc13c99a81..9b6979c811e2 100644
--- a/drivers/media/usb/s2255/s2255drv.c
+++ b/drivers/media/usb/s2255/s2255drv.c
@@ -31,6 +31,7 @@
 #include <linux/videodev2.h>
 #include <linux/mm.h>
 #include <linux/vmalloc.h>
+#include <linux/unaligned.h>
 #include <linux/usb.h>
 #include <media/videobuf2-v4l2.h>
 #include <media/videobuf2-vmalloc.h>
@@ -1716,23 +1717,24 @@ static int save_frame(struct s2255_dev *dev, struct s2255_pipeinfo *pipe_info)
 	if (frm->state == S2255_READ_IDLE) {
 		u32 jj;
 		unsigned int cc;
-		__le32 *pdword; /*data from dsp is little endian */
-		int payload;
+		u32 payload;
 
 		if (pipe_info->cur_transfer_size < 20)
 			return -EINVAL;
 
 		/* search for marker codes */
-		pdata = pipe_info->transfer_buffer;
-		pdword = (__le32 *)pdata;
 		for (jj = 0; jj <= (pipe_info->cur_transfer_size - 20); jj++) {
-			switch (*pdword) {
+			__le32 marker, resp;
+
+			pdata = pipe_info->transfer_buffer + jj;
+			marker = get_unaligned((__le32 *)pdata);
+			switch (marker) {
 			case S2255_MARKER_FRAME:
 				dprintk(dev, 4, "marker @ offset: %u [%x %x]\n",
 					jj, pdata[0], pdata[1]);
 				offset = jj + PREFIX_SIZE;
 				bframe = 1;
-				cc = le32_to_cpu(pdword[1]);
+				cc = get_unaligned_le32(pdata + 4);
 				if (cc >= MAX_CHANNELS) {
 					dprintk(dev, 0,
 						"bad channel\n");
@@ -1741,7 +1743,7 @@ static int save_frame(struct s2255_dev *dev, struct s2255_pipeinfo *pipe_info)
 				/* reverse it */
 				dev->cc = G_chnmap[cc];
 				vc = &dev->vc[dev->cc];
-				payload = le32_to_cpu(pdword[3]);
+				payload = get_unaligned_le32(pdata + 12);
 				if (payload < PREFIX_SIZE ||
 				    payload > vc->req_image_size) {
 					vc->bad_payload++;
@@ -1749,7 +1751,7 @@ static int save_frame(struct s2255_dev *dev, struct s2255_pipeinfo *pipe_info)
 					return -EINVAL;
 				}
 				vc->pkt_size = payload;
-				vc->jpg_size = le32_to_cpu(pdword[4]);
+				vc->jpg_size = get_unaligned_le32(pdata + 16);
 				break;
 			case S2255_MARKER_RESPONSE:
 				if (pipe_info->cur_transfer_size - jj - 20 <
@@ -1757,14 +1759,15 @@ static int save_frame(struct s2255_dev *dev, struct s2255_pipeinfo *pipe_info)
 					jj = pipe_info->cur_transfer_size - 20;
 				else
 					jj += DEF_USB_BLOCK;
-				pdata = pipe_info->transfer_buffer + jj;
-				if (le32_to_cpu(pdword[1]) >= MAX_CHANNELS)
+				cc = get_unaligned_le32(pdata + 4);
+				if (cc >= MAX_CHANNELS)
 					break;
-				cc = G_chnmap[le32_to_cpu(pdword[1])];
+				cc = G_chnmap[cc];
 				if (cc >= MAX_CHANNELS)
 					break;
 				vc = &dev->vc[cc];
-				switch (pdword[2]) {
+				resp = get_unaligned((__le32 *)(pdata + 8));
+				switch (resp) {
 				case S2255_RESPONSE_SETMODE:
 					/* check if channel valid */
 					/* set mode ready */
@@ -1783,19 +1786,18 @@ static int save_frame(struct s2255_dev *dev, struct s2255_pipeinfo *pipe_info)
 					wake_up(&dev->fw_data->wait_fw);
 					break;
 				case S2255_RESPONSE_STATUS:
-					vc->vidstatus = le32_to_cpu(pdword[3]);
+					vc->vidstatus =
+						get_unaligned_le32(pdata + 12);
 					vc->vidstatus_ready = 1;
 					wake_up(&vc->wait_vidstatus);
 					dprintk(dev, 5, "vstat %x chan %d\n",
-						le32_to_cpu(pdword[3]), cc);
+						vc->vidstatus, cc);
 					break;
 				default:
 					pr_info("s2255 unknown resp\n");
 				}
-				pdata++;
 				break;
 			default:
-				pdata++;
 				break;
 			}
 			if (bframe)
-- 
2.56.1.839.g22a8290db9-goog

