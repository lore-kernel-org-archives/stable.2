Received: from mail-pj2-f43.google.com (mail-pj2-f43.google.com [74.125.227.171])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A551442901E
	for <stable@vger.kernel.org>; Thu, 24 Sep 2026 06:55:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=74.125.227.171
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1790232919; cv=none; b=mly4vEkLVfbqgz079qNIFuop3PcruOnlWl206HyBh5vEDObyI3SGP79cZnYaiP9EYkrhN/3srOgvNPNAya4/HEucP83I4B2qOt8wbG1g3PwWB9nxjyD060WEdtHairoOkWZRtkZ3eS8TGLy7Ix8yYFPeaFMUauXJEFn9Yx/Nb80=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1790232919; c=relaxed/simple;
	bh=S1ifroC1rn1KTqaVlaVfiVWIPiuDCmVpTK19OnYuAgU=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=sYmySbWTOo698UPsOwKXbjX5uBSwx7Xua/kLn+DsORymyJp5mGmidVcf5F9km9zSvosPpJSaHKZJF9JmgSO6+427dOBp6tQXqeS6Jl7gPfnxcA0ULzmc5qObyhUSGKOOto2pZTqS7hMfEhmrmaNYVBTXWfebF/BQZE4pUwDvLrM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=aWUC+DTC; arc=none smtp.client-ip=74.125.227.171
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="aWUC+DTC"
Received: by mail-pj2-f43.google.com with SMTP id 98e67ed59e1d1-396ccdaea76so761611a91.0
        for <stable@vger.kernel.org>; Wed, 23 Sep 2026 23:55:14 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1790232913; x=1790837713; darn=vger.kernel.org;
        h=content-transfer-encoding:content-type:mime-version:references
         :in-reply-to:message-id:date:subject:cc:to:from:from:to:cc:subject
         :date:message-id:reply-to:content-type;
        bh=PIMJm+VCyEzSCDqSRZoYpvVJ5wMLjOdy3cRjV6Xlh64=;
        b=aWUC+DTCBNMvly2U1S3s0LXaor/YZTPC7zwq++FYl9N1YfvDd+edg2AbbFHA7cVccc
         w5Hq4nzO7pgDM/nEpkeoua0JBIhhJ4yXgDVOaE4I6nOF04Dqo78SxNa2eH1ovnKbKlsm
         JDOa+1YADyv+XlFUriHhX6rBqSwwCH0mtkgnkQ4NMY70R3oPVmWa3ivqXV/1zyBam3p0
         y6g6ZGb0pzTj/Xk23so8fl7rLmP1q+41veRhde9MenqxtwXTejJI/M1d1J+st3QCGLCv
         R1pCK+C6uiH/iEuv+wLF67U6zszukchwnKHaQsghlKFS/woNrzClZyoeASRqkbiwigXy
         GDvg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1790232913; x=1790837713;
        h=content-transfer-encoding:content-type:mime-version:references
         :in-reply-to:message-id:date:subject:cc:to:from:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=PIMJm+VCyEzSCDqSRZoYpvVJ5wMLjOdy3cRjV6Xlh64=;
        b=LJ/gotUvevBWfxfUaew+00KaIzhZgIH4a4NwNJSR3YgoGje9hdeYFlY2V+GtTJrog0
         a/KIthZOO0Aod1/9N1eTaJ5WPlsnOOXF0fVUPqvLymqj5vp2wZWDp2y1Tec7YJamwvN9
         i+zCP4+FVyonxSXT76BMV53T8z19WiCEJyzsCQSUw+yES7QqYAqlOXhEwYSg4ft3YHqQ
         +L7CcXMorhRcKpJzBhufHNoRhZu25f0RNsIa68GBtT776eidub3+VMIo03fxVi1/lU12
         SAc1PCSfHx6YcRF1DUnGSh6HCnnllQ/v7JNSUnLfmW/Y56da9oVKzoe8BdMFP6/uQVpR
         La8g==
X-Forwarded-Encrypted: i=1; AKwUvBwIAHCsKs2LB8J/PEQLR1+InCOt26HtS5RcOtsg1oPhtB5vfzTCtlr27QbtG/zQJNgBPsqdUNc=@vger.kernel.org
X-Gm-Message-State: AFuF++n1D3CtL135nFyec5DNbz7crHgxWO/aVhlGRsDqwmDeCm+gspG7
	hg0ZaIuoS/u9iapZpKo3XTrgF5gvL3IWHHAaTIH8exKOgNvIdpbffKMd
X-Gm-Gg: AYBFou3OW7b0BKwybDLgyu6gtTpMWhzwrGRF5WbGInbiotsQZM3yc4/Ye+CYjIsfVkn
	kA0WVQQtDdJw0yOP5w4l4TFjqrdhKDm0MeA9KbjY2XSbQTNpuF+/5f9btsrDGpocpUziPzJ3MRk
	bip9VPAG12Q6TVanUIPrp9Dz1+wyRpaX8nCFb4DEYamGWnAjFZ9B8kndTwa4695xV+F7XQbVDZe
	bdMKkvYWZTKwv/86TbNiASAiHxAqUdPExbLR3Zm8VLGVcst7gxWawceYl9TY2xMxRUfXNfxNhxN
	UrcU0eWdRi28E56Y9LetZqKlLqIMWY4pik4BK32E8gcb0TLZ4hZU6OmxjwiORcYTbtWwZRNg3eO
	zQ8s06na1TUqcXd8vi5zaVqS48HS/kCCJLOfZqimO92dtY4dU06rGQqQMXwpOBa9awX9vAHKbfy
	ulC8mDIFqgd7F9fDCg4V32rAX4xeyzEV9neF+oRfeWl9X7wqdncwhMf9yNGcwJFPzu9ynoxIy/B
	kO5v/rXOFy3CF6P0DSpLk8TwE1gMITioagsOv/L7qrsckKbdFzYjCQyKCH53i8v0Ay1Au/oCcFq
	ye7k/MW6Lw==
X-Received: by 2002:a17:90b:564d:b0:39e:6c66:cbdd with SMTP id 98e67ed59e1d1-3a098acb900mr899575a91.21.1790232912472;
        Wed, 23 Sep 2026 23:55:12 -0700 (PDT)
Received: from phui-2.c.googlers.com.com (67.51.127.34.bc.googleusercontent.com. [34.127.51.67])
        by smtp.gmail.com with ESMTPSA id 98e67ed59e1d1-3a096a61d9bsm3218143a91.0.2026.09.23.23.55.12
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 23 Sep 2026 23:55:12 -0700 (PDT)
From: Hui Peng <benquike@gmail.com>
To: gregkh@linuxfoundation.org
Cc: jirislaby@kernel.org,
	ilpo.jarvinen@linux.intel.com,
	linux-serial@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	stable@vger.kernel.org,
	Hui Peng <benquike@gmail.com>
Subject: [PATCH v4 3/3] serial: core: reject baud_base values that overflow port->uartclk in uart_set_info()
Date: Thu, 24 Sep 2026 06:54:42 +0000
Message-ID: <20260924065510.2587569-1-benquike@gmail.com>
X-Mailer: git-send-email 2.56.0.rc1.310.g51773c2048-goog
In-Reply-To: <2026092417-seducing-stank-af6d@gregkh>
References: <20260924060511.2364717-1-benquike@gmail.com> <2026092417-seducing-stank-af6d@gregkh>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit

In uart_set_info(), new_info->baud_base is multiplied by 16 and stored in
uport->uartclk (an unsigned int):

  uport->uartclk = new_info->baud_base * 16;

While uart_set_info() checks if (uartclk == 0) and
if (new_info->baud_base < 9600), when new_info->baud_base exceeds
UINT_MAX / 16 with low bits set (for example, 0x10000001), multiplying
by 16 wraps around in 32-bit unsigned arithmetic to a small non-zero value
(16), bypassing both uartclk == 0 and new_info->baud_base < 9600 and
setting uport->uartclk = 16 (baud_base = 1, well below the required
minimum of 9600 * 16).

Reject new_info->baud_base > UINT_MAX / 16 before multiplying by 16 in
uart_set_info().

Tested in QEMU against Linux 7.3.0-rc3 by calling ioctl(fd, TIOCSSERIAL,
&ss) with ss.baud_base = 0x10000001 on /dev/ttyS1: on the unfixed kernel
TIOCSSERIAL succeeds (ret = 0) and wraps uport->uartclk to 16
(TIOCGSERIAL reports baud_base = 1), whereas with the fix applied
TIOCSSERIAL returns -EINVAL and preserves the existing uport->uartclk.

Fixes: 1da177e4c3f4 ("Linux-2.6.12-rc2")
Fixes: 6eabce6608d6 ("serial: core: check uartclk for zero to avoid divide by zero")
Cc: stable@vger.kernel.org
Assisted-by: LLM
Signed-off-by: Hui Peng <benquike@gmail.com>
---
Changes in v4:
- Check new_info->baud_base > UINT_MAX / 16 before multiplying by 16,
  as suggested by Ilpo Järvinen.

Changes in v3:
- Add missing #include <linux/limits.h> for UINT_MAX and move the
  new_info->baud_base > UINT_MAX / 16 check to the uartclk == 0 check, as
  suggested by Ilpo Järvinen.

 drivers/tty/serial/serial_core.c | 8 +++++++-
 1 file changed, 7 insertions(+), 1 deletion(-)

diff --git a/drivers/tty/serial/serial_core.c b/drivers/tty/serial/serial_core.c
index 95774b0f1484..75bb1eaa27e7 100644
--- a/drivers/tty/serial/serial_core.c
+++ b/drivers/tty/serial/serial_core.c
@@ -16,6 +16,7 @@
 #include <linux/console.h>
 #include <linux/gpio/consumer.h>
 #include <linux/kernel.h>
+#include <linux/limits.h>
 #include <linux/of.h>
 #include <linux/pm_runtime.h>
 #include <linux/proc_fs.h>
@@ -931,8 +932,13 @@ static int uart_set_info(struct tty_struct *tty, struct tty_port *port,
 	old_custom_divisor = uport->custom_divisor;
 
 	if (!(uport->flags & UPF_FIXED_PORT)) {
-		unsigned int uartclk = new_info->baud_base * 16;
+		unsigned int uartclk;
+
 		/* check needs to be done here before other settings made */
+		if (new_info->baud_base > UINT_MAX / 16)
+			return -EINVAL;
+
+		uartclk = new_info->baud_base * 16;
 		if (uartclk == 0)
 			return -EINVAL;
 	}
-- 
2.55.0.1082.g2b9226bbc0-goog
