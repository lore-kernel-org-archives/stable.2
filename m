Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=209.85.208.182
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1792831089;
	b=WARtnU3XZIWXOh7Kq3+/rZSlR2ZkObxDGWEXR18TFofSnCRGt+HHrtODwGqjNzwt84zC
	 /uIvNIu7GPzIa4CWUSQkDGLh0H0KWmaiDRVJWIILcIC0LvMoeY6OOvvCBqDwKwtWP1p+2
	 MclnVyKB1vt7HthJlLDANCFg5usitIBlKiwpNxh8uCpMrQwZG3Ap6rxEf/lPHaz29hDyn
	 7pRndufLuwhje+e4dXBXyTImcLL8wLd7n0IBAI1matHHZm74/XHO2mDoUS5zDbEPnN7yO
	 NeQ74aSL2xAR6q2wTli7WTAYIIIwJ/UNF0nSSjojFItTpTcEdgXqQaesgEHr7y5/JHw==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1792831089;
	h=DMARC-Filter:Received:DKIM-Signature:X-Google-DKIM-Signature:
	 X-Forwarded-Encrypted:X-Gm-Message-State:X-Gm-Gg:X-Received:Received:
	 From:To:Cc:Subject:Date:Message-ID:X-Mailer:In-Reply-To:References:
	 MIME-Version:Content-Transfer-Encoding;
	bh=gwbgZsLn0u2FeW1NnLX99L38TmXwF8CZ4LCOXWCfVz0=;
	b=Gwcqtfem6CCJIrP7EhtQEHajb73uLB8HikfvZ5DTmpV2rpD7JgIe9bK9OSZP7SxzaJyr
	 ZOjUjrnYGED1OjpQVHOyYsA/fXUW85gkurRUuM0VYSdoyzy7zfVXrepKrXeH+e4DSIUH3
	 oCmVvwsmK1MLXLOmxcGIjLUtygaHVSWVXIJMShYuXKJQtYq0fx95JXznywhUEVKO9LOud
	 2OJWOzRCRSb0/0Q4beRBeGWkCJldEVN4YXAgAo/d7CtdOdWN/ls8tXBzAAcGr+xAsX9BL
	 9+Ny2X2abt9VowPO0z2zBZUH4hVt5iA82ZGWJv9lX2YM48bsA1dWUg5b8/zCgf7Koyw==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=gmail.com;
	spf=pass smtp.mailfrom=gmail.com;
	dkim=pass header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20251104 header.b=iLMuBOBH;
	arc=none smtp.remote-ip=209.85.208.182
Received: from mail-lj1-f182.google.com (mail-lj1-f182.google.com [209.85.208.182])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 806D5606A31B
	for <stable@vger.kernel.org>; Sat, 24 Oct 2026 08:38:08 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 806D5606A31B
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20251104 header.b=iLMuBOBH
Received: by mail-lj1-f182.google.com with SMTP id 38308e7fff4ca-3ac65e845a8so14592851fa.1
        for <stable@vger.kernel.org>; Sat, 24 Oct 2026 01:38:08 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1792831087; x=1793435887; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=gwbgZsLn0u2FeW1NnLX99L38TmXwF8CZ4LCOXWCfVz0=;
        b=iLMuBOBHWJFg453Jpz9ZxWwyULw3uRF4CDdHiWyWb2IShq0ecwM2MoTwTOmQrSVLAh
         ix8QJ+GRjMastfznE9JRbjLTwfZL2f9mA5UJ+VFSKDMtTsQw3tC3jQImNR89ENmIflFZ
         fcV+s3MASpXaRTY8S2c1rBoDEfaI2xSd7LST1d90bZ1/rgyYdEaVIM0jSQrrydCEex2U
         rkXA6/4Gq6ycci2ac376WkMcdTqf/dxl8r18n81LJdx9Q+IaT/1RWnPtOCfBpa05sCDp
         8zwo7TUIaWddxDKU4RSFs8TQpz2DWS2QRceLZtD77O3vinGI5lV7DpmnT08kY560mrfZ
         CWbQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1792831087; x=1793435887;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to:content-type;
        bh=gwbgZsLn0u2FeW1NnLX99L38TmXwF8CZ4LCOXWCfVz0=;
        b=mrqgk5dj4hv4eKAX2UArN1j7cHU1SA6CojOiBPgBh457Hk5woAwEmvicglOcWrsLcH
         REqW+5rYnM1eAN9TRsih5Q8Up8XtdhOUJuKhBBRLfyqaoyzJDvYGoo0rj6E8G/DyYQ5d
         EtqACLIeJ7oqfGfiXel+TGCJk6wgdTsFokIuVuJFmxLgqYCU/4byA1uPP1W2JIuSYtNx
         FbimNuYX3+ny82eXOu0bLWw6Y8zBTLhQVtSEH6Ip6T6ywQywCguf0bUeLxWO9DkWyOuC
         Si6x+Cz8QAheD5ZixVBMVz0+YwtFfCJZvwzCa0t9VG0hkoTaTVqmd2cdZye10LgrgNyE
         w8zw==
X-Forwarded-Encrypted: i=1; AKwUvBwZLkEQNnjpU+jGyKK7urT+mgYS25uU6c1bT73gUchZ9SUvhz44TIRBFNq00viN4avzOl5j8Xs=@vger.kernel.org
X-Gm-Message-State: AFq9FYK8r9b8KmxcIFymCkEMLNRR52Lq/VxJJepZS+feooXaItRAb9GV
	3u+JaJji7hVmdEshkf7KeFE8euwXkY6GPNM039VrMsTRsoYIvkW6aVDh
X-Gm-Gg: AYBFou1Jvoe+gSUr7KCY3Yz7eLmThykKKKKF3GVmpziBKm9A8BbTqyhamrbRS3Ktn3L
	tcqVZhgm45m4xvwbq6tB2vE7xjvHs7k7cLNBoVjKEmPAIjcjXsQ7SM/Bd2ivjikXYMtaEQ0IHdW
	BKJ9H9s3GuN/RTS1pET0bX3XHrrAq+0OzpMfAolbRVL/mnmlOvPJe6DKSR9SRBLbQhQ7959Z3ui
	zRfbdCPN5Ej3IhlwDvrI2KSrLrRk82AMOFQhtL3dtcyLXzI5/N0DuNa5GTbD0BmC1R2XgUaQj78
	bt2LMj/8TWt2s0wxJ8s48vTTpZYYI1F9GDW3x6jcFo8lPNqmnC6Y3N0XVhHsC9uwQebNiOHSJOI
	AYUfzbUcinmvjdcyKh9HhZ6L8PiB8+w4Kop1kz4NSy/kj2a6gDMbAvGFEdoDSQ0XdxzX5/SzQxR
	UFNJYtGLKChTd6h7rJuCs4MAQ2VkYFSR4KIipHj1OUxfcM3EzC5z7TyG+Q8x33qwviKJKsaGHof
	HW0OVrMNLtCXQNmZNyhA9747yIk1Su57WZ1sx9Qyx8t576K5oXfq1FeRHIZHojPGPav9EFQ/RtB
	1r9ykJNmqgGhFVb3btbb6z7peyTJR7uk2cWlyVU6UnlIeQ09gaviU9r6aaEQ
X-Received: by 2002:a2e:bc27:0:b0:3ac:4f4c:8da2 with SMTP id 38308e7fff4ca-3ac6fd3234amr3217541fa.17.1792831085835;
        Sat, 24 Oct 2026 01:38:05 -0700 (PDT)
Received: from x870steellegend.lan (95-25-165-240.broadband.corbina.ru. [95.25.165.240])
        by smtp.gmail.com with ESMTPSA id 38308e7fff4ca-3ac70a2d324sm3122591fa.33.2026.10.24.01.38.04
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sat, 24 Oct 2026 01:38:05 -0700 (PDT)
From: Igor Putko <igorpetindev@gmail.com>
To: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
Cc: Alan Stern <stern@rowland.harvard.edu>,
	Tejun Heo <tj@kernel.org>,
	Oliver Neukum <oneukum@suse.com>,
	linux-usb@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	stable@vger.kernel.org,
	syzbot+a5b220cacb0618384d5a@syzkaller.appspotmail.com,
	Igor Putko <igorpetindev@gmail.com>
Subject: [PATCH v2] usb: core: hcd: flush giveback work on stop
Date: Sat, 24 Oct 2026 11:36:47 +0300
Message-ID: <20261024083647.2599-1-igorpetindev@gmail.com>
X-Mailer: git-send-email 2.47.3
In-Reply-To: <20261023174015.54793-1-igorpetindev@gmail.com>
References: <20261023174015.54793-1-igorpetindev@gmail.com>
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

When an HCD is stopped/removed (either during module unload, driver
unbind, or an error path in probe), pending URBs are unlinked and
completed. However, for root hubs or HCDs with giveback done in BH
context, the work function usb_giveback_urb_bh() may still be executing
on another CPU after __usb_hcd_giveback_urb() drops the URB use_count
and wakes up waiters in usb_kill_urb().

Since the caller may immediately free the struct usb_hcd via usb_put_hcd()
after usb_stop_hcd() or usb_remove_hcd(), the running worker accesses
the embedded giveback_urb_bh structure in its epilogue (e.g. clearing
completing_ep or clearing the running flag) after the memory has been
freed, triggering a slab-use-after-free write detected by KASAN.

Ensure all giveback work has fully completed in usb_stop_hcd() by calling
flush_work() on both high and low priority BHs before deallocating.

Fixes: 8fea0c8fda30 ("usb: core: hcd: Convert from tasklet to BH workqueue")
Cc: stable@vger.kernel.org
Reported-by: syzbot+a5b220cacb0618384d5a@syzkaller.appspotmail.com
Closes: https://syzkaller.appspotmail.com/bug?extid=a5b220cacb0618384d5a
Suggested-by: Alan Stern <stern@rowland.harvard.edu>
Signed-off-by: Igor Putko <igorpetindev@gmail.com>
---
v1 -> v2:
- Use flush_work() instead of cancel_work_sync() to ensure no pending
  work items are dropped, as suggested by Alan Stern.
---
 drivers/usb/core/hcd.c | 3 +++
 1 file changed, 3 insertions(+)

diff --git a/drivers/usb/core/hcd.c b/drivers/usb/core/hcd.c
index 8e8a5f59b319..e6854d67ed8c 100644
--- a/drivers/usb/core/hcd.c
+++ b/drivers/usb/core/hcd.c
@@ -2787,6 +2787,9 @@ static void usb_stop_hcd(struct usb_hcd *hcd)
 	/* In case the HCD restarted the timer, stop it again. */
 	clear_bit(HCD_FLAG_POLL_RH, &hcd->flags);
 	timer_delete_sync(&hcd->rh_timer);
+
+	flush_work(&hcd->high_prio_bh.bh);
+	flush_work(&hcd->low_prio_bh.bh);
 }
 
 /**
-- 
2.47.3

