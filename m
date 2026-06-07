Received: from mail-pf1-f179.google.com (mail-pf1-f179.google.com [209.85.210.179])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D1DA3370AD0
	for <stable@vger.kernel.org>; Sun,  7 Jun 2026 09:51:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.210.179
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1780825893; cv=none; b=XnWGk9AJG3k387vehFH4wmkP2xsZhf6k7jmE5zfh94EUzcSTH0eJusbDWxgrIBAEsatyJXaw8PIBPnuS43EA55HSGVC350JkSv8Y4uzBF2nbjwsshTfyInPKYtJZto9gMCsHMR60NGJjILYoyxpOOIgiBMvJIpgfJGz4giZC6HY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1780825893; c=relaxed/simple;
	bh=i1oCpfdFswALacqKWEmloOwuDuQecUWVE49heEfU014=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=dMiC6bE0JUv/JiAA9cyZT+G9PEyJ7JjpUmxEaU0GPoNM4G9MXl/fnsldY2IVyDRx69Env88OZJwhTxVVMGM1agHpcuBE1s60lN8Kush7A9BpFptSngwhb9OXh5GB8H83oRDwswYjPoTX9metHXRmnxEs/nmdRUUvgSmGTfWxOyI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=Znyv3Hmq; arc=none smtp.client-ip=209.85.210.179
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="Znyv3Hmq"
Received: by mail-pf1-f179.google.com with SMTP id d2e1a72fcca58-8423f52af13so2390782b3a.2
        for <stable@vger.kernel.org>; Sun, 07 Jun 2026 02:51:31 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1780825891; x=1781430691; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=ZZHHpy1q3ydpA2HSp+30PNQez/ja9FOTHakLXuwR4NM=;
        b=Znyv3HmqTjKyuCY+O3O6ouCk6TOtSkW8eiuXLoptskWS1NMZtNNC+m1kulYWGKz3pP
         DxzYGvqoCQ9jvFdNYpxK8+sGqWECqKGYgTcuT8a8ykh9Ssc3Cy6ZU9AMdIGD9rIO7+ZP
         WRCsOh366t3p6UDxhKVuTQnAknTAhVhmz9hV+CwqdjEoO2DWrCtrRuHpu2JnZLd9zYIH
         vVx1+TN7mASvd3zo43KVlQlGpActMTrbNYusgSXryePav56/eym0F80+CpqFAkWNJwzI
         tH3NP4qRFq39Kk31GXNxFZ3yYn35R886ybRURqRIruaEYbjdfv3lbxzEap6ialpbxYQs
         saAA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1780825891; x=1781430691;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=ZZHHpy1q3ydpA2HSp+30PNQez/ja9FOTHakLXuwR4NM=;
        b=MCln/3r8bng14TOl9AIHjs0dmK3jDd8gTRf04lMZrrsJB7C+M70g0DL758zBDO52rh
         2jf1+moXul8p4HcN9DFsC6L/QEOh1efQMl75N29+BG4JU4kBVwbWi3e+F2Hf+1Sz3ZoH
         Z57Qpmx6DnKQwgl7WhWRydUpnvgVJjk9qTGiRBnAqlLwE82O7Lqu5rOuutQ3A927qiMc
         QtP8yHAThhCoWSIyZcLl/zqcf4W+lU++X0gWNOFumF4oh7CydtWU/jhNAj+DanMkJCpg
         +YcZaZJoBOR2yzUi2IsfCUDeo2ONQwGD0XYxwqkYUT+hpEiEgKF0A/NxK0Jt9+j0Ht69
         TOeQ==
X-Forwarded-Encrypted: i=1; AFNElJ82heZVf8XJHHj7J4bh8zNOZwuu9PqtVnEcRx0C6mVha4AskcnMsVwGUUvw/psLb+pufxNoF9w=@vger.kernel.org
X-Gm-Message-State: AOJu0Yy1T5efkJI0WVzseYBZolx/xdvwyKEGH4QbMRfHq/vRcSPX4JCX
	SK9iHmC1Hr2PxO5ifwQcHhyKNg9gCtI2wciaT1KUM+QAXZAVNKKM57pA
X-Gm-Gg: Acq92OFff9PnUhaCjqnNSUeozvNYZzb7YI3mHzSYe9wzCd0/0EELn8ylhF3x0Zbmz/4
	sVEM3gStRbR+c6RV5+OMdNC3gTk2np6lizPlWW+Uz49+Px7tmbjXKz+cSHv9Tz4WOTwiSt8w5q5
	RKSPhIwnsjJX4hvKiKDZdfRr4LHXpRTSVsuNzdBgp4Rn9fQJ+dJucHPBYFVSpMKt9oj4QPhxBwB
	4VwGDw+BR7MXmJ6rlp9pP0lHckGXk0ag07n6Ks+aEqMt5lYhPUgD4InrPhmw75SAPgm+Us74qE4
	B27MgBC9K1Zk2n0TMWe9tLvzRxXx7NGNzinxY9+h2WnKTnE9IDBz9grT80qo6oI0/jhaXRAtrCS
	o+B4AUlW4VivHlTQ3sR5Q1WSWTqZ3OSk+I5++yXTCluRgvj+cIk0ysaI2bG9yyNLknMwMVcjHU4
	lYflNvtQFD99+1UAA+Evszsd5wIZbuTW10qI+RsmXl4XQ9qT4zi47fUYXGP+fN1ZgtSr4sNmzeX
	a3+504qbtmq0WUMejNovdEvUzg=
X-Received: by 2002:a05:6a00:9286:b0:842:4023:42c9 with SMTP id d2e1a72fcca58-842b0fc08c5mr11266234b3a.41.1780825891034;
        Sun, 07 Jun 2026 02:51:31 -0700 (PDT)
Received: from nugod-NUC15CRHU5.tail9f095a.ts.net ([218.237.104.87])
        by smtp.gmail.com with ESMTPSA id d2e1a72fcca58-84282916b10sm14629670b3a.58.2026.06.07.02.51.29
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 07 Jun 2026 02:51:30 -0700 (PDT)
From: HyeongJun An <sammiee5311@gmail.com>
To: Johan Hovold <johan@kernel.org>,
	Greg Kroah-Hartman <gregkh@linuxfoundation.org>
Cc: linux-usb@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	stable@vger.kernel.org,
	HyeongJun An <sammiee5311@gmail.com>
Subject: [PATCH] USB: serial: kl5kusb105: fix bulk-out buffer overflow
Date: Sun,  7 Jun 2026 18:51:14 +0900
Message-ID: <20260607095114.9375-1-sammiee5311@gmail.com>
X-Mailer: git-send-email 2.43.0
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

klsi_105_prepare_write_buffer() is called by the generic write path
with the bulk-out buffer and its size (bulk_out_size, 64 bytes). It
stores a two-byte length header at the start of the buffer and copies
the payload from the write fifo starting at buf + KLSI_HDR_LEN, but
passes the full buffer size as the number of bytes to copy:

  count = kfifo_out_locked(&port->write_fifo, buf + KLSI_HDR_LEN,
                           size, &port->lock);

When the fifo holds at least size bytes, size bytes are copied starting
two bytes into the size-byte buffer, writing KLSI_HDR_LEN bytes past its
end. Copy at most size - KLSI_HDR_LEN bytes instead, leaving room for
the header as safe_serial already does.

Writing bulk_out_size or more bytes to the tty triggers a slab
out-of-bounds write, observed with KASAN by emulating the device with
dummy_hcd and raw-gadget:

  BUG: KASAN: slab-out-of-bounds in kfifo_copy_out+0x83/0xc0
  Write of size 64 at addr ffff888112c62202 by task python3
   kfifo_copy_out
   klsi_105_prepare_write_buffer [kl5kusb105]
   usb_serial_generic_write_start [usbserial]
  Allocated by task 139:
   usb_serial_probe [usbserial]
  The buggy address is located 2 bytes inside of allocated 64-byte region

The out-of-bounds write no longer occurs with this change applied.

Fixes: 60b3013cdaf3 ("USB: kl5usb105: reimplement using generic framework")
Cc: stable@vger.kernel.org
Signed-off-by: HyeongJun An <sammiee5311@gmail.com>
---
 drivers/usb/serial/kl5kusb105.c | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/drivers/usb/serial/kl5kusb105.c b/drivers/usb/serial/kl5kusb105.c
index ed8531a64768..e72a0b45a707 100644
--- a/drivers/usb/serial/kl5kusb105.c
+++ b/drivers/usb/serial/kl5kusb105.c
@@ -330,8 +330,8 @@ static int klsi_105_prepare_write_buffer(struct usb_serial_port *port,
 	unsigned char *buf = dest;
 	int count;
 
-	count = kfifo_out_locked(&port->write_fifo, buf + KLSI_HDR_LEN, size,
-								&port->lock);
+	count = kfifo_out_locked(&port->write_fifo, buf + KLSI_HDR_LEN,
+				 size - KLSI_HDR_LEN, &port->lock);
 	put_unaligned_le16(count, buf);
 
 	return count + KLSI_HDR_LEN;
-- 
2.43.0

