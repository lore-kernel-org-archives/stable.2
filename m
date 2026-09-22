Received: from mail-pj2-f43.google.com (mail-pj2-f43.google.com [74.125.227.171])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DC98D4399C4
	for <stable@vger.kernel.org>; Tue, 22 Sep 2026 08:31:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=74.125.227.171
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1790065922; cv=none; b=TnB5f2YflOJqMrF54T4RZXgoi3wdO/1HW2LAfLQF3KNjl42aU6en/nbQKjkuMB15ItVvbqBWtLf5gzLd045TSKTVaZNM9Sr4aeC4M1KuJvnf+8PKPR4qzNGDIUesfgH3KwDHdtK8Qf+LiMVSYh7TS7kGkzg/NPgrG7JjXHgy/bM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1790065922; c=relaxed/simple;
	bh=+hb6WhVGSbxazqPNFCzPE7V0omcNMJ90KZH/aleX+Cg=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=vDn+sJK0Y2KcjgEIH0buVdBV1HFTT0RmCasr39L9U9YpQ4ZD+tssJNpNdqhLhAY3feXk8um1TnxW56XbM+p/FsAeE7r4l68KWT24NHdsHIMwLR7PKWhUIBm2VeO9HIhqPLw3nyxI25NAz0UqY1jEt95l00vRsZ23I71tuzFRnM8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=msA5QAbD; arc=none smtp.client-ip=74.125.227.171
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="msA5QAbD"
Received: by mail-pj2-f43.google.com with SMTP id d9443c01a7336-2db18fe459dso22884385ad.3
        for <stable@vger.kernel.org>; Tue, 22 Sep 2026 01:31:58 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1790065917; x=1790670717; darn=vger.kernel.org;
        h=content-transfer-encoding:content-type:mime-version:references
         :in-reply-to:message-id:date:subject:cc:to:from:from:to:cc:subject
         :date:message-id:reply-to:content-type;
        bh=a7VfkeZl7fPR5dTy6nweVWt5o/UsHxB20RTbQxUVJM8=;
        b=msA5QAbDTQiTHal9jp2jcWdZDd+NqRdbjjMox47NYi2L8nwDgRc8o9RLGvJou+DQs4
         HtRl/wORNBY86OoAQoeJBsVwWkhQj5hMrlIG9SyCRYMc4QA7hs7KpJ08FRRNlNS6IRtD
         f4NRYZIQafVir12mBbzVgjZ3/2cnuaei5ix70SF9UHfOSWHL7ROK9Ht4LRPF9K0n9x6S
         Oy9O7cLev+0QHHvti4cUkOO2/FW/lbpnICDruCe1rm2zzcUfvVJUm9Rj+i5cLI56oovh
         ERx8NefDAlcGFb1DvHLozW+V5kwOccWkGGeh919+Y6vzgXn7qRs4YTIr4QqVmOF8trPi
         1BXA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1790065917; x=1790670717;
        h=content-transfer-encoding:content-type:mime-version:references
         :in-reply-to:message-id:date:subject:cc:to:from:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=a7VfkeZl7fPR5dTy6nweVWt5o/UsHxB20RTbQxUVJM8=;
        b=wTYB2Q5ZyHTKIMqGq7/p0OeK75FMhwN+5rk+Ki+kgCxZZO8ILlYr1qM1g8Ebo2YyeE
         5EZG196BCsx5m5nmkQ5woe5SyoumcV5NhV7xHUkdJ6r47z9xRFBde436YKSpoILRJUvs
         uD/ettVHhmCUq31qLz4wEV2IWgPs3dGBE8aFtmVDODeFvqHeNcZQo0s+lQRrCiYMpMc6
         Zm9DnZzduCwBTbeN3Rbv0Ts71bH9qRq1BeHS6uWtf7wTS6niNZN2gBOrhIou7Wtzdrnp
         0l8oJ3mmrUzwaEzcKqy5cwAHlmqQW6cj0Zeu21BL0yBpEA3qwJ6zECfOb8opQe+rCvMr
         EPSA==
X-Forwarded-Encrypted: i=1; AKwUvBznnk27k4Xg+Qou8ouQeSTWR5SwEe3mBAzOrmpkM/GzkbD3Pj82+H0SGfKQapNDrxZCO17YI5I=@vger.kernel.org
X-Gm-Message-State: AFuF++nojwwzo6/8w5oLUoClwMZP2VCnpIJ/qXroJe4V7WCNS/2Aduoy
	3wUK8/ie165CRYHloHbWnui48q5H+dowjIsiQNMbayCRUVUCzrQg5Eoz
X-Gm-Gg: AYBFou0+jz72ycbTze2K7fP22U7Ym3fD6PH1nziEGPJbya0AuVs+3HfMlHOwGeE8Dw9
	GrDPT75TBm+K8Ac/KvruiJQnPWi5c7d3GjNcpzYPUjZYthY3DwJ6iGB1GOTcSEeWrsbmF9qk7zF
	K3qGA9yqR/t56F3BOBZFRJVUZCgZTQxnR1pMFz+lc0jPlzCzYipMgn9Jyy+fOANDclA4vdeNGCm
	nCV37LxGIVbctF9AEYwBhEgrX/7quzY63bszZbCJMKP5W8eLbbSwyhKI52LfaX6uPNSFfmcmG7L
	5LrlxU13JKGmzq/AJP/Wq0Wsy8sFxK3t7if7oHv/zl/OdWPZxqg8wkgzpMTrc6zWJZSC2Krjcyu
	j+Fs5WEz/Ebyr3yvgLyBfYnG1v9nEiVI/njGK2YF3RkpRN5GjZRGXNz9bfioI5PGLlVaOKlmUdR
	pwJFYvHlgZYZxebB1yIk8aam8CYkUztdIxtoARwE83ghLzkyiZ2Uja4VpJWcyY9AB0Vtu4bIfyw
	XeIvzsrPJD2KMkum9/VZET1u13vo7WB8rSU1jYp4ZIeU33dMk3ym+1Wh6V1KEDY63dfvkeN5QFE
	D4ZdH7k4og==
X-Received: by 2002:a17:902:ce85:b0:2dd:ad74:6d1d with SMTP id d9443c01a7336-2df60adefe3mr5279055ad.26.1790065916879;
        Tue, 22 Sep 2026 01:31:56 -0700 (PDT)
Received: from phui-2.c.googlers.com.com (78.123.83.34.bc.googleusercontent.com. [34.83.123.78])
        by smtp.gmail.com with ESMTPSA id d9443c01a7336-2df5d0197d3sm5848175ad.13.2026.09.22.01.31.56
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 22 Sep 2026 01:31:56 -0700 (PDT)
From: Hui Peng <benquike@gmail.com>
To: Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
	Jiri Slaby <jirislaby@kernel.org>,
	John Ogness <john.ogness@linutronix.de>,
	=?UTF-8?q?Ilpo=20J=C3=A4rvinen?= <ilpo.jarvinen@linux.intel.com>
Cc: Hui Peng <benquike@gmail.com>,
	Andy Shevchenko <andriy.shevchenko@linux.intel.com>,
	linux-serial@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	stable@vger.kernel.org
Subject: [PATCH v3 3/3] serial: core: reject baud_base values that overflow port->uartclk in uart_set_info()
Date: Tue, 22 Sep 2026 08:30:51 +0000
Message-ID: <20260922083152.4055969-4-benquike@gmail.com>
X-Mailer: git-send-email 2.55.0.1082.g2b9226bbc0-goog
In-Reply-To: <20260922083152.4055969-1-benquike@gmail.com>
References: <20260922083152.4055969-1-benquike@gmail.com>
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

Reject new_info->baud_base > UINT_MAX / 16 alongside the uartclk == 0
check in uart_set_info().

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
Changes in v3:
- Add missing #include <linux/limits.h> for UINT_MAX and move the
  new_info->baud_base > UINT_MAX / 16 check to the uartclk == 0 check, as
  suggested by Ilpo Järvinen.

Changes in v2:
- Split out into patch 3/3 of the series, add Cc: stable@vger.kernel.org,
  and document the QEMU test method, as requested by Greg Kroah-Hartman.

 drivers/tty/serial/serial_core.c | 3 ++-
 1 file changed, 2 insertions(+), 1 deletion(-)

diff --git a/drivers/tty/serial/serial_core.c b/drivers/tty/serial/serial_core.c
index 3845fb582f45..362dd6648ba4 100644
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
@@ -933,7 +934,7 @@ static int uart_set_info(struct tty_struct *tty, struct tty_port *port,
 	if (!(uport->flags & UPF_FIXED_PORT)) {
 		unsigned int uartclk = new_info->baud_base * 16;
 		/* check needs to be done here before other settings made */
-		if (uartclk == 0)
+		if (uartclk == 0 || new_info->baud_base > UINT_MAX / 16)
 			return -EINVAL;
 	}
 	if (!capable(CAP_SYS_ADMIN)) {
-- 
2.49.0
