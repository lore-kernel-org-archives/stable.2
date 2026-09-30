Received: from mail-pj2-f41.google.com (mail-pj2-f41.google.com [74.125.227.169])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6E3FF31F991
	for <stable@vger.kernel.org>; Wed, 30 Sep 2026 12:59:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=74.125.227.169
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1790773152; cv=none; b=QKSeXZ5heplBaK72E/LaiddV2RH89eFEJ/pQhZjAbLAGY5j/wmkV6pOgIpFlgpCbIq39UAEuO678whNVS4Qd9jzCuOKVIZJPhjMrT1W8CknEysxk6LKOpmljBX/djNcpzo3MpVLCt4A1cfYyPUGJlZMshOBUfTOXOekBoHZftZ4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1790773152; c=relaxed/simple;
	bh=Mq0YPOcXIXmJM5XDX7yRYBMbSphahEFyS0D9AR8XhCQ=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=WCD+znEARG71ZN3EEVORsqpGKN1CmLE97CQ8MZQfZc+8MhtPpO2SOHbxyuC2Cydd2yeu0EcsDV9qlc4UAME9AjQ9NueuGvlYtWMXt4dMCBZzIT5dGHAVo/dFHwo638VqvokhtloQWmLqeYwAWqExj+fIRU5Q4eI4RfcgTMCRLRA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=pQ/rS2Bh; arc=none smtp.client-ip=74.125.227.169
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="pQ/rS2Bh"
Received: by mail-pj2-f41.google.com with SMTP id d9443c01a7336-2df9754484aso27862795ad.0
        for <stable@vger.kernel.org>; Wed, 30 Sep 2026 05:59:06 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1790773145; x=1791377945; darn=vger.kernel.org;
        h=content-transfer-encoding:content-type:mime-version:references
         :in-reply-to:message-id:date:subject:cc:to:from:from:to:cc:subject
         :date:message-id:reply-to:content-type;
        bh=ThjIdAe3tMXzbT84DjYHLGeB5MLacVxxaFyft5w9u4M=;
        b=pQ/rS2BhyTBa4XvWNR4QUjXVZeKTxg/CfzqIGdrOpbyn/gLrYC28Um+kRKQajCUhDQ
         nhi/coiKaamqF3NL4aPFb2dpNPd5z6FPMtPQInG6PApKXX1rLwJ4ABLPjXohKQSVDa/G
         0HhoXOQ6fFv/M34z3X0mAEl4IBPdz/xrrG3+v0DOzQCHm+PrE5TlTB50ZX0muUY3Pzss
         DKxk6w7h3mrsmG1MdjDkiqFyYdyYEbWJqCSOsDgbo9Xt6cxqh7Js5ltkAejzblJKCQjd
         T2AzyXh4iJJQzLELIoXzqPRY7yRgmXhd96Wf2b1u5UL74IeWXU6QFhAGXbzIXWtNSAK0
         t9gg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1790773145; x=1791377945;
        h=content-transfer-encoding:content-type:mime-version:references
         :in-reply-to:message-id:date:subject:cc:to:from:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=ThjIdAe3tMXzbT84DjYHLGeB5MLacVxxaFyft5w9u4M=;
        b=n2T//l2qHYmdoIXrrnlpbB7DFHRQ0tQDi+6g8srMds7tUmZ6ggmUkQH7bfW2jEmlzB
         SUcIo1ac4f6q50qwJyUVNEtSP9j/Dh+e8iRUA5NEAWKc7gLaYu+5xQGgDJw2xciekLhk
         cQOxwP2ifVIDuF9Uvmcr+bvvQUxWO0O9DvCEDZ5Q5OM6HpTv5wncAFnseb7BA7WDaRvR
         BjRUbJKGr/AoExuYeisQWd2KsQArGeinmzOpMUAwXaUndCjKP0ZDPvcBfkHqVxQLi2rW
         C0KfycSQEpeQ2+A5GrelROOTsVxlLY+NhqhAd1OSrQuAra639j+zRNJExgXlr24Yn0ti
         kQaQ==
X-Forwarded-Encrypted: i=1; AKwUvBybn80ZufC5sHbZq96gcfv17y56LYYJYRBMCWwPSacoPpHO5PPDo8ew1mVwKYUpKP9bijok3sY=@vger.kernel.org
X-Gm-Message-State: AFq9FYI1pMOi4MiK1tGmAdlgizD+mUCfAp8hFfdek/TyY/315i8m3lv2
	gogUo++0an8a7jVXmWiVOTZPN6taKR7PkOMvyc6QMQ3hzXxL56JnRl+I
X-Gm-Gg: AYBFou1o4D7K20hcg76oaqUKv+03cFXsjCWGk57svnLjvAExrHj5n73/BTZMNux/TOW
	DV1tgjTzjv/YsYqWXgYU5x1uKqkGAy0slQr5nikqAAGvPOV/6Bwx1vq1x67Wr0Eevk2Ee92kSct
	rasfVEkYth1yanOVe9hrUD4/cYtaW1LvOPmtZGM46KWqL1QychjLxiG08elqFBQHdwXBSuDiEw0
	O2/NT2U459eVAxC8lQoxBzJf/wUltQOoKIxchHwocixHIwgWh/dd4f4Hw6hxCAxYpVV3/8AwdoX
	efYRQ/SwR8fMGDO/cVC7OkwScTye1gKenT/taAxxfzEpCwa0MElpzTozh65U4rYSRvs8tqcWGOV
	cxXMJnnvIL1uLF+vqlbFoS9hUuO9/UE4Vch2DzFKqs7lEHAhJyfdeBB6s1C9sxvTyl004KgLTI4
	5URH617B1f4n7JrQPbrJ7pgmVRoDysICJABRQhvmoLH1WrpM5V0GpbbjN4wMKZRjzIp9l7p57Ck
	6dits/HG396Z6UXJ4U+MEhYTmn5kmYFz3uBsp85vqb2PHQHjtbFOzQRKhb45Hh6OW9Dr76ePzM0
	AP1a7Y15HA==
X-Received: by 2002:a17:903:4587:b0:2e2:bf79:3cbc with SMTP id d9443c01a7336-2e2e4a1f706mr10544205ad.14.1790773144737;
        Wed, 30 Sep 2026 05:59:04 -0700 (PDT)
Received: from phui-2.c.googlers.com.com (25.187.82.34.bc.googleusercontent.com. [34.82.187.25])
        by smtp.gmail.com with ESMTPSA id d9443c01a7336-2e2e5c1b3d7sm6751925ad.70.2026.09.30.05.59.04
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 30 Sep 2026 05:59:04 -0700 (PDT)
From: Hui Peng <benquike@gmail.com>
To: Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
	Jiri Slaby <jirislaby@kernel.org>,
	John Ogness <john.ogness@linutronix.de>,
	=?UTF-8?q?Ilpo=20J=C3=A4rvinen?= <ilpo.jarvinen@linux.intel.com>
Cc: Andy Shevchenko <andriy.shevchenko@linux.intel.com>,
	linux-serial@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	stable@vger.kernel.org,
	Hui Peng <benquike@gmail.com>
Subject: [PATCH v7 2/2] serial: core: reject baud_base values that overflow port->uartclk in uart_set_info()
Date: Wed, 30 Sep 2026 12:59:01 +0000
Message-ID: <20260930125901.778868-3-benquike@gmail.com>
X-Mailer: git-send-email 2.56.0.rc1.315.gc6ed9934b7-goog
In-Reply-To: <20260930125901.778868-1-benquike@gmail.com>
References: <20260930125901.778868-1-benquike@gmail.com>
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

Use check_mul_overflow(new_info->baud_base, 16, &uartclk) in
uart_set_info() to reject overflowing baud_base values with -EINVAL.

Tested in QEMU against Linux 7.3.0-rc3 by calling ioctl(fd, TIOCSSERIAL,
&ss) with ss.baud_base = 0x10000001 on /dev/ttyS1: on the unfixed kernel
TIOCSSERIAL succeeds (ret = 0) and wraps uport->uartclk to 16
(TIOCGSERIAL reports baud_base = 1), whereas with the fix applied
TIOCSSERIAL returns -EINVAL and preserves the existing uport->uartclk.

Fixes: 1da177e4c3f4 ("Linux-2.6.12-rc2")
Fixes: 6eabce6608d6 ("serial: core: check uartclk for zero to avoid divide by zero")
Cc: stable@vger.kernel.org
Reviewed-by: Ilpo Järvinen <ilpo.jarvinen@linux.intel.com>
Assisted-by: LLM
Signed-off-by: Hui Peng <benquike@gmail.com>
---
Changes in v7:
- Use check_mul_overflow() instead of raw UINT_MAX / 16 comparison as
  suggested by Jiri Slaby.

 drivers/tty/serial/serial_core.c | 9 ++++++---
 1 file changed, 6 insertions(+), 3 deletions(-)

diff --git a/drivers/tty/serial/serial_core.c b/drivers/tty/serial/serial_core.c
index 6ed0195e6912..9a8f4c2e1180 100644
--- a/drivers/tty/serial/serial_core.c
+++ b/drivers/tty/serial/serial_core.c
@@ -14,6 +14,7 @@
 #include <linux/tty_flip.h>
 #include <linux/serial_core.h>
 #include <linux/console.h>
+#include <linux/overflow.h>
 #include <linux/gpio/consumer.h>
 #include <linux/kernel.h>
 #include <linux/of.h>
@@ -931,9 +932,11 @@ static int uart_set_info(struct tty_struct *tty, struct tty_port *port,
 	old_custom_divisor = uport->custom_divisor;

 	if (!(uport->flags & UPF_FIXED_PORT)) {
-		unsigned int uartclk = new_info->baud_base * 16;

 		/* check needs to be done here before other settings made */
-		if (uartclk == 0)
+		unsigned int uartclk;
+
+		if (check_mul_overflow(new_info->baud_base, 16, &uartclk) ||
+		    uartclk == 0)
 			return -EINVAL;
 	}
-- 
2.47.3
