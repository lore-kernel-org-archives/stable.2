Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=209.85.215.178
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1794555414;
	b=FvvEac+BozBSsWRUSX2KuxbUCTnsobbzgVvB7KdvvwdAZbzs0v/rvLiGTbd835ik7Dfh
	 YHQxNkgmwFuzD/iAYxIz+Rbr4tTnUVrrO3YGGtA+M2+IODHjKWoP4+jPC2a4dgnMOQ7yC
	 xcVUf9wBnuI4lGpEo5C4f0pGh/tQV4OHk2eqfWmt35LXB5p10OPsxjoQJrvSnsVXjV23q
	 dJV9fjBitaoLtjoycLntkBg7yhE+4CgmbiKZmpUk1YtNk3qkIdWB+eHZUZn+rlMntGZfX
	 /gfj/+Mq7+eX+7TDTSEoduukAX9t78sOk/vSQti45C2SHroHsmUA76GzOt7fzSJSarQ==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1794555414;
	h=DMARC-Filter:Received:X-Google-DKIM-Signature:X-Forwarded-Encrypted:
	 X-Gm-Message-State:X-Gm-Gg:X-Received:Received:From:To:Cc:Subject:
	 Date:Message-Id:X-Mailer:In-Reply-To:References:MIME-Version:
	 Content-Transfer-Encoding;
	bh=mX97vKGfKG79Gv/YC4HRVZ42o6kQjjPD71aRf1vrpj4=;
	b=hJrTjBZnYaNFnijXn6B3Pt9JxbBq+P7Z36RAaZawvZpEW2De8KfzE8g80wqZc4JWRIgB
	 0IHZ90WB7LyAygKTqSznLNZlm3uDmw5bNPsXScmSe+DVf6NMQSTIx6QisXK9vaYOAyedn
	 wdYaiPIUKNGdRHCZAP4+nC/luhQuYFlgT7HAeQsClB4y1Y/tod5ekcFfzNfJjtXsQHg5P
	 FND9bAveENe0cwMNgxWNVaILTuzMjZaeJ95fk7opdhl3usqSr0J+CfYJYC+ASjS7teo67
	 9tT1o4uJjoerBeduZHCt0AIgurMN+uKURoPpgv1EKea/s4aMlbtixoB1bd+QA7BzUYw==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=none header.from=kylinos.cn;
	spf=pass smtp.mailfrom=gmail.com;
	arc=none smtp.remote-ip=209.85.215.178
Received: from mail-pg1-f178.google.com (mail-pg1-f178.google.com [209.85.215.178])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 34AB1606A331
	for <stable@vger.kernel.org>; Fri, 13 Nov 2026 07:36:54 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 34AB1606A331
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=kylinos.cn
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pg1-f178.google.com with SMTP id 41be03b00d2f7-cd60c5da24cso817963a12.0
        for <stable@vger.kernel.org>; Thu, 12 Nov 2026 23:36:54 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1794555413; x=1795160213;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to:content-type;
        bh=mX97vKGfKG79Gv/YC4HRVZ42o6kQjjPD71aRf1vrpj4=;
        b=1q3ABPB16TjBwfg9f8wVQQzqqAeuAr07GeS9OwmYvBQkIDmp/799FQ7JbsAQyykd4Q
         1WvmHACoGZUSqelTYc13qQCCOfDZupBrPlNxreL13sX+ZAK/HrMv78MFoxvWDwuyxFfT
         VQeKVP2B9PGOWWanLpX1aUKqnGQVTMe7+6tDQ732lSi8XljptDQMU9DU9rbHh7JLSCHZ
         NXi55nYgFq6B4QQnIaUly6lESWfYiuptOxM4WYY2jjwIE1VIbx5wcUQWuRHwbN5a7O3v
         j3NEbKLXS7tAGbTwfWWEHFxOrcOA2N/YEhiLWet+3tSxKUiWX80VGVHGL2kFc4y2Vq72
         MGXw==
X-Forwarded-Encrypted: i=1; AL+hErET+zG92bSGYq9ruIk1Q11RYCEred/WmVcDUOahtI2vhzlQYC/JcyVmo1jMb94WezgWwbTo9xo=@vger.kernel.org
X-Gm-Message-State: APuU4Z/CRPGsKKIrloZ0mQQGbmZqa9EsnkUvuRTRdG9cXn88sR6weYjj
	hH2qf5FDEhxSjXtQLj35CvC/+tZ1pN6bqqhj6lt/mWvAQuL3ytN796WvPPWB2w==
X-Gm-Gg: AYBFou3Fq6ULkbcvorqQu81NhIlSS/J6Db1FK7ho+lbpoB1BYMilg9AbokKqDA5ms4C
	j3fXzIJCEkO8Pcfnld+Y10Zqavx/kehS5t1kRHhe0UT0pXKYKfDHaUgO46757eGO+xVR/HgnOds
	koPwqrDxYPNYNDrtyLdxu3Z1jOIrVGQr8uoZhtW++D7HrxdH7syop4WV8eNfioPtbfLLbkoIYk/
	5UZCakA9SDdraw9XhRbX2DKcop7kyjTJ6jE/6oQ2dK43fST6Nim8GS1FTd2ONz/8YJrJ30x9NMc
	IXxId4OTZjlgPuFTx+Nf0qDWPnGNmehCbgSLFB0simff+Al4tZhH2hmkXs+p2Q1zQoisDML8yxB
	4ZxDJKLalEt953tuzhY5jTUl9wyJ9xpAfHJgmXkvxGrnvIEI/NrusENYVMsohVTfxWIH7dCITLd
	/0IiMXKghCadzoaEfocHDBjds2mXyxovidh/bm/aM5UyutNgMI3OiQQbKXH8VFNcc35Hq5BdLhx
	ulJyplwmPN1Hsk2Oh+2uEKHKHQm28x+k5HGZ9L+nf+A2KMJvgi+KxhDx1k6MXv7Ys4xKqDi1Z+q
	sgwT/gMT9ytr5rhdfjirbjJ+G5YlVQJL8aqQ8ohLTRgt7A==
X-Received: by 2002:a17:90b:57c3:b0:3ab:9c73:130 with SMTP id 98e67ed59e1d1-3b1b0a108e5mr1426110a91.33.1794555413550;
        Thu, 12 Nov 2026 23:36:53 -0800 (PST)
Received: from localhost.localdomain ([116.128.244.169])
        by smtp.gmail.com with ESMTPSA id 98e67ed59e1d1-3b1aeb179fasm3205009a91.4.2026.11.12.23.36.49
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 12 Nov 2026 23:36:53 -0800 (PST)
From: Hongyu Xie <xiehongyu1@kylinos.cn>
To: Alan Stern <stern@rowland.harvard.edu>,
	linux-usb@vger.kernel.org
Cc: linux-kernel@vger.kernel.org,
	Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
	usb-storage@lists.one-eyed-alien.net,
	syzbot+30552b4cbe99d6d91306@syzkaller.appspotmail.com,
	Liu Qi <liuqi@longcheer.com>,
	stable@vger.kernel.org,
	Hongyu Xie <xiehongyu1@kylinos.cn>
Subject: [PATCH v5 1/2] usb-storage: add usb_stor_bulk_transfer_buf_timeout()
Date: Fri, 13 Nov 2026 15:36:37 +0800
Message-Id: <20261113073638.1225998-2-xiehongyu1@kylinos.cn>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20261113073638.1225998-1-xiehongyu1@kylinos.cn>
References: <b07b5f5b-4722-4f1c-84b9-205ba9b8943f@rowland.harvard.edu>
 <20261113073638.1225998-1-xiehongyu1@kylinos.cn>
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

usb_stor_bulk_transfer_buf() waits for URB completion without a timeout.
That is correct for transfers belonging to a SCSI command, whose timeout
and abort handling terminate the wait, but not for transfers issued
outside a SCSI command.

Add a variant which takes a timeout, in jiffies; zero means no limit.
usb_stor_bulk_transfer_buf() becomes a wrapper with a zero timeout, so
existing callers are unchanged.

Signed-off-by: Hongyu Xie <xiehongyu1@kylinos.cn>
---
 drivers/usb/storage/transport.c | 31 ++++++++++++++++++++++++-------
 drivers/usb/storage/transport.h |  5 +++++
 2 files changed, 29 insertions(+), 7 deletions(-)

diff --git a/drivers/usb/storage/transport.c b/drivers/usb/storage/transport.c
index 8de3015bce050..424293658918a 100644
--- a/drivers/usb/storage/transport.c
+++ b/drivers/usb/storage/transport.c
@@ -378,12 +378,17 @@ static int usb_stor_intr_transfer(struct us_data *us, void *buf,
 }
 
 /*
- * Transfer one buffer via bulk pipe, without timeouts, but allowing early
- * termination.  Return codes are USB_STOR_XFER_xxx.  If the bulk pipe
- * stalls during the transfer, the halt is automatically cleared.
+ * Transfer one buffer via bulk pipe, allowing early termination.  Return
+ * codes are USB_STOR_XFER_xxx.  If the bulk pipe stalls during the
+ * transfer, the halt is automatically cleared.
+ *
+ * A nonzero @timeout bounds the wait for URB completion, in jiffies.  It
+ * must only be used for transfers which are not part of a SCSI command:
+ * those rely on the command's timeout and abort handling.
  */
-int usb_stor_bulk_transfer_buf(struct us_data *us, unsigned int pipe,
-	void *buf, unsigned int length, unsigned int *act_len)
+int usb_stor_bulk_transfer_buf_timeout(struct us_data *us, unsigned int pipe,
+				       void *buf, unsigned int length,
+				       unsigned int *act_len, int timeout)
 {
 	int result;
 
@@ -392,14 +397,26 @@ int usb_stor_bulk_transfer_buf(struct us_data *us, unsigned int pipe,
 	/* fill and submit the URB */
 	usb_fill_bulk_urb(us->current_urb, us->pusb_dev, pipe, buf, length,
 		      usb_stor_blocking_completion, NULL);
-	result = usb_stor_msg_common(us, 0);
+	result = usb_stor_msg_common(us, timeout);
 
 	/* store the actual length of the data transferred */
 	if (act_len)
 		*act_len = us->current_urb->actual_length;
-	return interpret_urb_result(us, pipe, length, result, 
+	return interpret_urb_result(us, pipe, length, result,
 			us->current_urb->actual_length);
 }
+EXPORT_SYMBOL_GPL(usb_stor_bulk_transfer_buf_timeout);
+
+/*
+ * Same as usb_stor_bulk_transfer_buf_timeout() with an unbounded wait.
+ */
+int usb_stor_bulk_transfer_buf(struct us_data *us, unsigned int pipe,
+			       void *buf, unsigned int length,
+			       unsigned int *act_len)
+{
+	return usb_stor_bulk_transfer_buf_timeout(us, pipe, buf, length,
+			act_len, 0);
+}
 EXPORT_SYMBOL_GPL(usb_stor_bulk_transfer_buf);
 
 /*
diff --git a/drivers/usb/storage/transport.h b/drivers/usb/storage/transport.h
index 74ffd0d7e7b6c..361dbd77f15e3 100644
--- a/drivers/usb/storage/transport.h
+++ b/drivers/usb/storage/transport.h
@@ -77,6 +77,11 @@ extern int usb_stor_clear_halt(struct us_data *us, unsigned int pipe);
 extern int usb_stor_ctrl_transfer(struct us_data *us, unsigned int pipe,
 		u8 request, u8 requesttype, u16 value, u16 index,
 		void *data, u16 size);
+extern int usb_stor_bulk_transfer_buf_timeout(struct us_data *us,
+					      unsigned int pipe, void *buf,
+					      unsigned int length,
+					      unsigned int *act_len,
+					      int timeout);
 extern int usb_stor_bulk_transfer_buf(struct us_data *us, unsigned int pipe,
 		void *buf, unsigned int length, unsigned int *act_len);
 extern int usb_stor_bulk_transfer_sg(struct us_data *us, unsigned int pipe,
-- 
2.25.1

