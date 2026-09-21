Received: from mail-pj2-f13.google.com (mail-pj2-f13.google.com [74.125.227.141])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8523A2D3A75
	for <stable@vger.kernel.org>; Mon, 21 Sep 2026 01:30:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=74.125.227.141
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1789954232; cv=none; b=Jp+R6TG297ql6xpRHoc5crV4TWMhBCwxFOAOcMK18k+fbqmgRM1Bb0UkIqqOXiyBIvvgBtSpWFGs3cs9BwlhMzBzciAaykfFi3+DwJ0ClhxFjG8QmIAEMkvg2pKDlgIt+JpLXAHsNh4UfAGGZVFvSo7bS0Oe8ew6xh4u9k+TBBU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1789954232; c=relaxed/simple;
	bh=t2kXYTfDoWYw6hLSMeM9i1WMUS5zpvinMMov6e67g9k=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=Um+/n7gTOjQ5S6oM2jlD2Wz6ep48e7HEXUpdj25iXN+yn+YoyDsi8651T2IFEEeIJj5o8b6GKy0qdfjggESIaftYA5ro4OKJ35a8cQrcogMNJUHFWdfkCizjQyA8EmzF/MIyYPruknvYLk3qbl6c4dapliA7Li7Kpvi1PvFfC+4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=GwmLPTOg; arc=none smtp.client-ip=74.125.227.141
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="GwmLPTOg"
Received: by mail-pj2-f13.google.com with SMTP id 98e67ed59e1d1-398cb5615deso2921920a91.3
        for <stable@vger.kernel.org>; Sun, 20 Sep 2026 18:30:31 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1789954231; x=1790559031; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=f+cTrga3fxRheLjWFEIpCVJBOqMuKdwt4xEbbBWyGpQ=;
        b=GwmLPTOgMCCaK3VxPfrrX1aedCgh6HG39XTL7CnTan6hxCRHg4SvV6WJu83ZeYtEyo
         eRFdM0ndjrXFALfoe5S/odZUQFUaHW+Q7ah3Lcoj8iK7KEcIRhZex2RTu3BVKm3038iL
         vzI7jmtxVUj1hP+/7YbPhW1LWxJAtkf9Kstlvsl2e2Pjy5U5eW/fSKZRcMjEuAQoAjyT
         2bsxUyP5O6Br5AdVMK3orrGYgSgK3nKaoIGjjU+tteP/GdIjpDb3gyDGdogg7m4m1JZ7
         NRKoA0NuxU3RCJdoW70z9qa14FMv4l2sFssnorDf2K020JeXaX1CpfQqVh+jXP/f+cOl
         iqgg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1789954231; x=1790559031;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to:content-type;
        bh=f+cTrga3fxRheLjWFEIpCVJBOqMuKdwt4xEbbBWyGpQ=;
        b=mzB4Jqm02Z0IzhIVNBVWZSLY9iWuasDtf19aEekgpla5Qy4gk/4O+00GuJy3wugze0
         BhqBMN4oiB5TMxRNbrN4Q+UbfD2E1Of5Nzst8YYpSo8xG4Wkcw+1UmwH1aOv0WzEsk9q
         VUotergkpr518Em7Cgwz3ejh4N2p08mvmoH4h0WwA2ZThNMJeFJaU9xvGt+BDBJ0wpF4
         ngNFj9pQIi3El9V22lMJ9NKYP1AxuTopKbTuO2/b8TSzturmOlQMj3d/i7UI1vLeGlT+
         qIe0CUBGM/hzZ0h+cB/Sid3etrb1fxoDrAM+xDV5T8h38MOOI87lbhZd4/ZfdmJfkfbF
         T9EQ==
X-Forwarded-Encrypted: i=1; AKwUvBy+P5uO1zDVRe8Weei/0JhdnPzWz1YtoJb0Z2/BsYg5nrvEDmxU9HLqvacd9G7iqBka9A+rba0=@vger.kernel.org
X-Gm-Message-State: AFuF++l76xLfUj1OWY/bsS4p/rRpUr4vfN0NiscvPx79mWrXPn4PKn4V
	sXa8wUtxdCpSnevvjBO6+gfuLhTtMBRt8uFFZoOHLCiU01JNtpAqdnoN
X-Gm-Gg: AYBFou3iMjPWC5/zhyMd09SUaPMGpwblU3BnbOd8ZbVjUqJsh5JFzlT2TSZafVu59D2
	+9Rn0AWrkEI0MICwpb6QTnqCJtJofhFmWhpMeTCra2RGGy+D7ntRRqp/oE7PkXzGMHFonyk357E
	bM5xbH1It+GBYT0rgnkLkgBK/2VTyHc0BhaR98PztXPVfxVfJ+xGFq/oxfWZ/Md7PReX57HQbit
	ApN8Dn58kLW7bL0mOM+dC4eN9vbhxwzEONCSb80bKUoyA/z8c12I6hyAKGWmaZl3nobaEMIaUg2
	6GlF+ytd6qgKMOt3+2AebGLBcfmlBLfhgB4rg/7NMCkNzuQztIqcm1yB115dJh/jvEuhW3M+yN5
	/TxruRzdthTZYfMBR0JL3py6VOYCOVhbYlIJGHPZs2iU9IRn4agRRJ6KOXCei+em2NgSXQv+66O
	a1fTnr6YTulLD2sV1CNgcPUWwfySbQr0Hfn1gn1yBkkMG+x+ONSMezRbgvSZAW6d3hiPalhzSZL
	Fv4GVANbf+V7+rAZn1woGQRnSIf+xmdNkMKmo0mByG4nqO6K/KJblY7i4uXbgcMv5jaTCpnzxol
	Igl+4uGPiA==
X-Received: by 2002:a17:90b:37cb:b0:39e:6c69:9b9a with SMTP id 98e67ed59e1d1-39e6c69b2eamr9095109a91.63.1789954230752;
        Sun, 20 Sep 2026 18:30:30 -0700 (PDT)
Received: from phui-2.c.googlers.com.com (67.51.127.34.bc.googleusercontent.com. [34.127.51.67])
        by smtp.gmail.com with ESMTPSA id 98e67ed59e1d1-39e6c3145dasm11291460a91.4.2026.09.20.18.30.30
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 20 Sep 2026 18:30:30 -0700 (PDT)
From: Hui Peng <benquike@gmail.com>
To: Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
	Jiri Slaby <jirislaby@kernel.org>,
	John Ogness <john.ogness@linutronix.de>
Cc: Hui Peng <benquike@gmail.com>,
	=?UTF-8?q?Ilpo=20J=C3=A4rvinen?= <ilpo.jarvinen@linux.intel.com>,
	Andy Shevchenko <andriy.shevchenko@linux.intel.com>,
	linux-serial@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	stable@vger.kernel.org
Subject: [PATCH v2 3/3] serial: core: reject baud_base values that overflow port->uartclk in uart_set_info()
Date: Mon, 21 Sep 2026 01:30:27 +0000
Message-ID: <20260921013027.659965-3-benquike@gmail.com>
X-Mailer: git-send-email 2.55.0.1082.g2b9226bbc0-goog
In-Reply-To: <20260919222627.3797854-1-benquike@gmail.com>
References: <20260919222627.3797854-1-benquike@gmail.com>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
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

Reject new_info->baud_base > UINT_MAX / 16 with -EINVAL in
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
Changes in v2:
- Split out into patch 3/3 of the series, add Cc: stable@vger.kernel.org,
  and document the QEMU test method, as requested by Greg Kroah-Hartman.

 drivers/tty/serial/serial_core.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/tty/serial/serial_core.c b/drivers/tty/serial/serial_core.c
index 128fc056f5c9..4cd4fb0f7ee3 100644
--- a/drivers/tty/serial/serial_core.c
+++ b/drivers/tty/serial/serial_core.c
@@ -965,7 +965,7 @@ static int uart_set_info(struct tty_struct *tty, struct tty_port *port,
 	}
 
 	if ((new_info->irq >= irq_get_nr_irqs()) || (new_info->irq < 0) ||
-	    (new_info->baud_base < 9600))
+	    (new_info->baud_base < 9600) || (new_info->baud_base > UINT_MAX / 16))
 		return -EINVAL;
 
 	if (change_port || change_irq) {
-- 
2.49.0
