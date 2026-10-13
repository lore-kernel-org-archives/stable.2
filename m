Received: from mail-pj1-f43.google.com (mail-pj1-f43.google.com [209.85.216.43])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5C2A3392823
	for <stable@vger.kernel.org>; Tue, 13 Oct 2026 07:33:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.216.43
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1791876835; cv=none; b=I/CL2tG6BNSajaP+zs9BrEOt428jvf9yaJsu9e2YlyFtHhM0rrUbU4Csq71G9g9CRCqWYtoXoZGZmXDZvEBY60eEevytppDEY+wZjmeR4OwZFml1DJjRYwTObAMpdRfEZSa1juR27TZjW+vmVY3dIl9gNVKaVNnPkvtsDua55aU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1791876835; c=relaxed/simple;
	bh=zJpDVFp7OaMF23RUvdd5tO1VAXTrpQbzxS/lyg/1VrY=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=ip9Qa/5vwNApVLuDtainmS+Ycu3i7q/gYh4NHUFyD9EmJQbhu+vnrXM/YA4cc83y7OoZjMP5TPD0NoI/f9I2ttZDeSnIfof5r/daq7h/fFnc74IXGoCgIDdbAUonFYTNsFq2Zx2Aq2UNzilaMqhKcKijkya85/9adrl64bbOFXE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=isslab.korea.ac.kr; spf=none smtp.mailfrom=isslab.korea.ac.kr; dkim=pass (2048-bit key) header.d=isslab-korea-ac-kr.20251104.gappssmtp.com header.i=@isslab-korea-ac-kr.20251104.gappssmtp.com header.b=a3Ej321N; arc=none smtp.client-ip=209.85.216.43
Authentication-Results: smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=isslab.korea.ac.kr
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=isslab.korea.ac.kr
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=isslab-korea-ac-kr.20251104.gappssmtp.com header.i=@isslab-korea-ac-kr.20251104.gappssmtp.com header.b="a3Ej321N"
Received: by mail-pj1-f43.google.com with SMTP id 98e67ed59e1d1-3ab33730821so1455716a91.3
        for <stable@vger.kernel.org>; Tue, 13 Oct 2026 00:33:54 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=isslab-korea-ac-kr.20251104.gappssmtp.com; s=20251104; t=1791876830; x=1792481630; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=xQTqZ8qzN+s4bkiJNCgS9fx46evxSh0ez7cKQ2yLbe8=;
        b=a3Ej321NWZegkkNMRNbF8C/A+DfXSt00ETUtcV21ms2NPa/vDQTzh//lIE9xgdmqZo
         H9BtdQ68VwWRk+FME02/5LANSH57D4XmYj46hDnZjj72AJCbQSmSgpm+E1fAVpJ5Zrdi
         jr7Je06B+aDb+ME6tSOrBO5/ZyeDog2QyBlZ47fAsxOi2uYHHensWNdLt2GyeP2v26Hz
         qz8ylA04v1MaWNsrLNy0Uz4dwqugrAC18A99h8ZKkbQ1CvLPS9gugwFUUOawJx/Jv1pJ
         jqcIN34P2tfyv9Mhvk/qtmzvkWP57/8rMUHnibZrGWJcyiUiCMcLz1Va4drGOTFcqUgT
         u8mg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1791876830; x=1792481630;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to:content-type;
        bh=xQTqZ8qzN+s4bkiJNCgS9fx46evxSh0ez7cKQ2yLbe8=;
        b=2wX6zb0FsBEsgw+Sp1ApvHZd5RXf5jovQVzxUpH7jxGUN8xwAyIG6nuQ5XqbLXT/kT
         blmPSIcL4PTLsNghwLa06lizNC8T5BLGeqDGj3En3yjV2ZHKCVWtZhz4ROBGUyhDKtkV
         hlBMyPmkdiZU2LqLJ3g6fO1VGnRRzLMJjzWBOMZsdh7BIsk4Mh7P2a3uSYe53Qn9IAHk
         xnePwrmJ9wOUBHDMzsR3c3Tj0tavixPcOXkikKOR6T0rvVorRQk54KUDtc0LixyC2Ii4
         y8+ufSzdPLVYupkE/rlIBBzpji0eoDVWHqNDtwQbSX/yNAhQJLmQudQ2h1k/SwykR0gA
         FOqQ==
X-Forwarded-Encrypted: i=1; AKwUvBw1kdeVMaVrgMXR4EMD2MGE+NeXSD2mFCJ6h/kvz+OYfDmFLpUX2wfttNp0zTiiq9TqiAe5W7M=@vger.kernel.org
X-Gm-Message-State: AFq9FYI4Y1V/6Fga0SPP7I0fJd4ZP2SzfLJVNuatV7o/DJXA1XuQh6vK
	yHlDaIit958XPTVmfKeCTHNFQKzm/hs7kQSut8tNN7MsAcirEjD7/JSorr/SpkGrANA=
X-Gm-Gg: AYBFou0OY3L9D2JFKZyuKhFaOBrkLHtVERGxUGkIXcpUxd1nDmoX92xu/ZTSPcN1r3E
	aFXQsib8tyTJdNMjktjBHdar+mrkwH8gu4vt5f0pLuJhLrXsiFGwP0oNSIYw1xfaGV7P2rK5YG7
	lNMFRgjP487JdHZIJI/rttLvMmMSDXN2AH+sFcr6VLdmZbnDSjYHqqESuxD8uBN4tcNT3O9SLkh
	C0cWMLQy6zjpc90lF0kvLdElCEFAEUx5Eaz2L6AkbDTi8o89uhOqRhvvm0zjjuTyGZumB3bGuZl
	eoeDWTLB8WEUi2r8XIlHQWhuY7YJNpVTttl1G5NLEP452tanzM2yhWXFY1nbMsdVokbbgE61xp0
	l/sNxCOjcbxUa+kCQip5LVxUqhnFxkE5t0+R8+9o83v0x1UpVlU+gt2zZ9QJpSFcy4wNpp0noZm
	hHYh+2aMjp4RDAUdG0RIqqmZPniLlg++OxBCK/DguVw+oZarYfDiBxus6KNdWfOfdwVPmWl5gqP
	V6Ing==
X-Received: by 2002:a17:90a:d44d:b0:3ab:1b19:78ed with SMTP id 98e67ed59e1d1-3ab3a60d92emr9613917a91.21.1791876829645;
        Tue, 13 Oct 2026 00:33:49 -0700 (PDT)
Received: from yhlee-960QFG.. ([125.131.91.97])
        by smtp.gmail.com with ESMTPSA id 98e67ed59e1d1-3ab36ed0daesm19973923a91.5.2026.10.13.00.33.47
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 13 Oct 2026 00:33:49 -0700 (PDT)
From: Yehyeong Lee <yhlee@isslab.korea.ac.kr>
To: gregkh@linuxfoundation.org,
	linux-usb@vger.kernel.org
Cc: Thinh Nguyen <Thinh.Nguyen@synopsys.com>,
	Sebastian Andrzej Siewior <bigeasy@linutronix.de>,
	target-devel@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	stable@vger.kernel.org
Subject: [PATCH v7 3/3] usb: gadget: f_tcm: clear the scatter list when reusing the BOT status request
Date: Tue, 13 Oct 2026 16:33:28 +0900
Message-ID: <20261013073328.2936318-4-yhlee@isslab.korea.ac.kr>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20261013073328.2936318-1-yhlee@isslab.korea.ac.kr>
References: <20261013073328.2936318-1-yhlee@isslab.korea.ac.kr>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

bot_send_bad_status() reuses fu->bot_req_in/bot_req_out to send the CSW or
drain the data phase, but a preceding sg command left req->sg and
req->num_sgs pointing at that command's t_data_sg - set in
bot_send_read_response() for a read, or usbg_prepare_w_request() for a
write. That command is freed before the status request runs, so an
sg-capable UDC walks a freed scatter list in dma_map_sg(): it reads freed
heap out to the host on an IN endpoint, or writes host data into a freed
page on an OUT endpoint.

Clear req->num_sgs and req->sg so the UDC uses the linear req->buf instead.

With KASAN, a read command followed by a rejected command that reuses
bot_req_in reports a slab-use-after-free in the UDC's scatterlist walk,
with the previous command's sgl_free() on the freeing stack; clearing the
scatter list removes it, while a normal sg read still queues its own
scatterlist.

Fixes: c52661d60f63 ("usb-gadget: Initial merge of target module for UASP + BOT")
Cc: stable@vger.kernel.org
Signed-off-by: Yehyeong Lee <yhlee@isslab.korea.ac.kr>
---
 drivers/usb/gadget/function/f_tcm.c | 3 +++
 1 file changed, 3 insertions(+)

diff --git a/drivers/usb/gadget/function/f_tcm.c b/drivers/usb/gadget/function/f_tcm.c
index a37a3ec8e7a4d..e727e8e1cfa0c 100644
--- a/drivers/usb/gadget/function/f_tcm.c
+++ b/drivers/usb/gadget/function/f_tcm.c
@@ -140,6 +140,9 @@ static void bot_send_bad_status(struct usbg_cmd *cmd)
 		req->complete = bot_err_compl;
 		req->context = cmd;
 		req->buf = fu->cmd[0].buf;
+		/* the status request is reused; drop the previous command's sg list */
+		req->num_sgs = 0;
+		req->sg = NULL;
 		usb_ep_queue(ep, req, GFP_ATOMIC);
 	} else {
 		bot_enqueue_sense_code(fu, cmd);
-- 
2.43.0

