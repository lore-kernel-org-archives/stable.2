Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A81D946D571;
	Fri, 28 Aug 2026 14:00:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1787925616; cv=none; b=FiDzInBHqkeq+jFO531fzCSMxXneHH/tnL1ynK4WErB2rrZ3LorPfdFEoOxmj1D47KI7Qz6Cg309yK/3GcwH4Kuyp8ObaJsrYo1XIRBioVVr0XOBocWg86qb0I5+vqM53/Wbwgw5Kamfxmierq3qQBY9SLxGEH3dJ+lSN6IlSQs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1787925616; c=relaxed/simple;
	bh=aO6lWOaDifNlLG0Wk+o1wIHg4+YCvtDfqH6I238sxco=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=N9MOLM5V+J38hZeom8U5R51x54HUaNj6iDrAJQ56WOVbbtRo1pmFgPkF4wnhejGZIHkv8v+86DJ7i2zsJngfH5Cs8mD56BxBKOD3cq4P43YuOlu9OgwXO21vLET9TSLSOVGcqkaFlmbbjFSu+yZoBfK40ChUTuHpTMcRegi37Lc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=Z/RG4bpA; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="Z/RG4bpA"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id A46E01F000E9;
	Fri, 28 Aug 2026 14:00:14 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1787925615;
	bh=q+X0/gX2IPjOBGehokkYYzLZBlrVv5LNhOlZ96uQcjM=;
	h=From:To:Cc:Subject:Date;
	b=Z/RG4bpACVMgvpnIJ3qWrK1pORM3N/fa3rjmapuZW1JBrHs2N7YL4BA068yerpCv9
	 5XEro/fxOqJb71Uit0AYvirRlGMEDlu/3JvAbv7TsICFMmCCoqfxy4xUv6X0QS/MD9
	 9BzVJxiRKd5zFrFgCes07GAb7chkMmO5A/Ho2t+cPfAF+wwL8yjAd/JVqoDvSm+XKX
	 tm735oetjpFjPdEijmbITxArm3KOD0TnlDU79FY91kl76rA+4ITzdmsOY3jdhC2Okv
	 VFVFd7Nud9h/NQOUqVgAN4dbT2Cs6MvU1vgRVmXhAmDhgVwqndUBICuasK7S5JAnVe
	 C+4uJv2srucSQ==
From: Andi Shyti <andi.shyti@kernel.org>
To: linux-media@vger.kernel.org
Cc: Farhad Alemi <farhad.alemi@berkeley.edu>,
	Mauro Carvalho Chehab <mchehab@kernel.org>,
	Hans Verkuil <hverkuil+cisco@kernel.org>,
	Johan Hovold <johan@kernel.org>,
	Andi Shyti <andi.shyti@kernel.org>,
	stable@vger.kernel.org
Subject: [PATCH] media: cx231xx: Fix cleanup path on failure
Date: Fri, 28 Aug 2026 15:59:50 +0200
Message-ID: <20260828135950.454799-1-andi.shyti@kernel.org>
X-Mailer: git-send-email 2.55.0
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

If cx231xx_init_v4l2() fails the probe currently jumps to
err_init, which only unregisters the V4L2 device. The analog
devices and I2C resources are left registered while the driver
state can be released.

A subsequent driver bind attempts to create the same I2C mux
channel links and triggers a warning when the existing
"channel-0" link is encountered. The remaining devices may also
access released driver state. This produces the following warning

    can't create symlink to channel 0
    WARNING: drivers/i2c/i2c-mux.c:403 at i2c_mux_add_adapter+0xcd8/0xeb0
    Call Trace:
     i2c_mux_add_adapter+0xcdc/0xeb0
     cx231xx_dev_init+0x2fb/0x1260
     cx231xx_usb_probe+0xc48/0x2140
     usb_probe_interface+0x657/0xc70
     ...

Jump to err_video_alt instead, which performs the full device
cleanup before unregistering the V4L2 device.

Reported-by: Farhad Alemi <farhad.alemi@berkeley.edu>
Fixes: 4d2a7d3509f5 ("[media] cx231xx: move analog init code to a separate function")
Closes: https://github.com/farhad-alemi/public_bug_reports/tree/main/185-warning-in-i2c-mux-add-adapter/
Signed-off-by: Andi Shyti <andi.shyti@kernel.org>
Cc: <stable@vger.kernel.org> # v3.17+
---
Hi Farhad,

thanks for your report. The failure happens in i2c-mux, but it is
indeed a cx231xx in V4L2 issue. With your report it wasn't
difficult to identify the problem, but to be sure I would
appreciate it if you coud test this patch.

Can you also share your reproducer.c?

Thanks,
Andi

 drivers/media/usb/cx231xx/cx231xx-cards.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/media/usb/cx231xx/cx231xx-cards.c b/drivers/media/usb/cx231xx/cx231xx-cards.c
index 69b24205bc56..b0941cd2a2d8 100644
--- a/drivers/media/usb/cx231xx/cx231xx-cards.c
+++ b/drivers/media/usb/cx231xx/cx231xx-cards.c
@@ -1826,7 +1826,7 @@ static int cx231xx_usb_probe(struct usb_interface *interface,
 
 	retval = cx231xx_init_v4l2(dev, udev, interface, isoc_pipe);
 	if (retval)
-		goto err_init;
+		goto err_video_alt;
 
 	if (dev->current_pcb_config.ts1_source != 0xff) {
 		/* compute alternate max packet sizes for TS1 */
-- 
2.55.0

