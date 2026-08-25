Received: from mail-pj1-f48.google.com (mail-pj1-f48.google.com [209.85.216.48])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6FE9D353A81
	for <stable@vger.kernel.org>; Tue, 25 Aug 2026 03:49:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.216.48
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1787629746; cv=none; b=UXImnHrAYlihtTGVsu+cvx0vx2T91Aeh10jwaYrX51H/A0NVuNP46vMKaDP3ioh/a/O7w3OGMwfHNxKFbDRJOVj7A/QpGlbdYh8TYWSonNY9aI7WlnqqDkVAuw9eCLQkAbMPJMF6O5VJuaGc8TQS+1QgfE1FhDUdJ2Z3L7+/Y8c=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1787629746; c=relaxed/simple;
	bh=WXRtSPZwo+EGznNPp+Jayvn/HOYdALcAx63byJrDfX4=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=A+tNxxNTv51oR9tnvtWcXjWpOYVmh7U/h5Q4aH3IKT0HTrXyN0xtLVBn0fXmd01BaS7YdjPj0Kipposru3jTVEH+5fWrvjiWkd2W4VG5TiHUoz/SZxs5tXTu7tQLXw4cDd/s+wMwSciWWP8P7ldrgU3W3LlIh7KImbiLQuNA6KQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=EGzQdzi5; arc=none smtp.client-ip=209.85.216.48
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="EGzQdzi5"
Received: by mail-pj1-f48.google.com with SMTP id 98e67ed59e1d1-38de840f2f0so3392122a91.0
        for <stable@vger.kernel.org>; Mon, 24 Aug 2026 20:49:04 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1787629744; x=1788234544; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to:content-type;
        bh=AEJ7x4lrvTeoqoW+tLTqGuE/b/VMt/f1IowvImwnRh8=;
        b=EGzQdzi5lebR6UCad4WygqLJN8TqofD1UI1Q8Dmqjact5cr0mrZ790pCVIfGEyyqxg
         VpfdQbc20tBeCCg4fCrayLksOnxQfjQCymC0t97NScoeDyC0/eYLcjgvGP6ex26noeyj
         Vxxu1n9XYgWeXwJUbnkPnVQLlyREsUgYkYmmMmfMd/jSLN288eyy8ARenLku7hmpnxb2
         ayfSuYUNoOfdVPMb5F0ruMYtdeResGC2c/xwA6BXq1OkCNTkPh4lcM9z3m21f0deaKGe
         BN04Fz1eHDg+M/ivuYyPEHKtTyrg8tICw1Eu0FFjY83eeMXA946R2FU0dWUv6VcUCUct
         g3tQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1787629744; x=1788234544;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=AEJ7x4lrvTeoqoW+tLTqGuE/b/VMt/f1IowvImwnRh8=;
        b=FxMvYniiQ8W4f+yjZKy0Avgpd80t7ib7gradVoNTyQZ7f/BQGFHdHKr0lT8EGBPWV6
         z5vXtG5QDDogwb96LrvTN30R5hN7BazsCDXaNK0XS86fMkAEwTeD9oWwStuB/asXBTtZ
         VAUirWwdJ9REcTFk9PLAOoyGDexXOPACYQpGsZ7msofFn4GAXIdbLhoqu8+IrLjL8pUn
         iuRo7mb1x9PKmzkzsM8/+VPDY5mL0oXizdJ79LG/TaQZDRekWjqApgzgirUOpIqjuqlk
         i0J75iCfaUzvyQ2Z02tAoy0tL/rlBlEtkipgk35uAcXv4ZTIDHxuVHdL/IZgUmFUrnC4
         Jx0w==
X-Forwarded-Encrypted: i=1; AHgh+RrmbAhV384CS29/YF7pyrSq0YcpOoq9NMJfFuk9389uDfZOtXYWbjZ0m0Ghz1wgESlA08eVsK4=@vger.kernel.org
X-Gm-Message-State: AFuF++m9i1woQhdkmmKzO18talYrSVAIIETmJCzB3rqCfBHzxdEo0cO3
	DhUdm6g/D2DoWsqIEtryMdD6+hZYMS9fOz74JNpsNOpc8DswxTyU/QfmuAw0XOagIcY=
X-Gm-Gg: AR+sD104Zb+T6Er7/uwnA7Unzc02HNtGasV8kYFEZUIi7sKNPgmlzb90ZV/hWfo6G8g
	SsUY2/8yPI5EBRrcvQXeuUIJaVrkANUdNKRvpjesWJlzPsXFvJ0ZfJLYgqrNlxuMMfJXuPBhRHm
	MReOAmR4rrGPYltaDHeco53qGs+atWPKicRBq+ERvzEnvPIrv1elTHnwmIMGogoskH5eE9lgUri
	JplMF91MU6X8QzR+xRidkNbvMEway8zOlgou0eIFV3qcKbQ+cehEaCkDDX+MPotBoSSyguDrEo8
	gOLuBFjXYB7eLOpmSD0X3z+2Da2sdxlKseWC6qT3CKo3w8a0EutRJ+wltLVPuFVuyYf87xoB1se
	nwWq5l0AyOgZSxqz6zp7EUO0cIS/cTorJXRHfORzkMlprVgN/cN8o0v1Lr4xuila2AuG011OeqR
	CHP0ZTRB/OoauJ8Vt5+mJwav05WQ9VD8J3TAvq+gmCZ2GqTOtOliMe32DfVcrS7LCaklJTvWyb/
	7QZH4KaV1PpKy4+qyz541IVEwaTZK7QWz2Z7F3O07+7kkMft/erh0sn3VWwpzCQJ6d/9UF8gjkc
	WiPyV0x6VbaTWbp+RrOReRSA
X-Received: by 2002:a17:90b:53c7:b0:38e:5c6:4db9 with SMTP id 98e67ed59e1d1-396464a15f2mr7362298a91.11.1787629743650;
        Mon, 24 Aug 2026 20:49:03 -0700 (PDT)
Received: from LAPTOP-UUUVNN1I.localdomain (bb119-74-6-224.singnet.com.sg. [119.74.6.224])
        by smtp.gmail.com with ESMTPSA id 98e67ed59e1d1-39645b64c48sm1985671a91.8.2026.08.24.20.49.01
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 24 Aug 2026 20:49:03 -0700 (PDT)
From: Wei Jie Law <98lawweijie@gmail.com>
To: Jiri Kosina <jikos@kernel.org>,
	Benjamin Tissoires <bentiss@kernel.org>
Cc: Andrew Duggan <aduggan@synaptics.com>,
	linux-input@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	stable@vger.kernel.org
Subject: [PATCH] HID: rmi: fix use-after-free of struct rmi_data via reset_work
Date: Tue, 25 Aug 2026 11:48:54 +0800
Message-ID: <20260825034854.63555-1-98lawweijie@gmail.com>
X-Mailer: git-send-email 2.43.0
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

rmi_event() queues hdata->reset_work for any pointer/mouse usage as soon
as RMI_DEVICE is set, but rmi_remove() only cancels the work when
RMI_STARTED is set:

	if ((hdata->device_flags & RMI_DEVICE)
	    && test_bit(RMI_STARTED, &hdata->flags)) {
		clear_bit(RMI_STARTED, &hdata->flags);
		cancel_work_sync(&hdata->reset_work);
		rmi_unregister_transport_device(&hdata->xport);
	}

RMI_STARTED is set at the very end of rmi_input_configured(), so a device
that advertises the RMI report IDs - which is what makes rmi_probe() set
RMI_DEVICE - but then makes rmi_input_configured() fail leaves the work
schedulable and never cancelled.  Never answering the SET_REPORT that
rmi_set_mode() issues is enough, i.e. exactly the unreachable-device case
the guard was added for.  rmi_probe() still returns 0 there, because
hidraw claims the device, so the driver stays bound and rmi_event() keeps
running.

struct rmi_data is devm_kzalloc()'d on &hdev->dev, so hid_device_remove()
releases it as soon as ->remove() returns, with the work still queued or
still running.  The workqueue then reads and writes the freed object:
process_one_work() stores into work->data, list_del_init()s work->entry,
and loads work->func out of freed memory before calling it, while
rmi_reset_work() dereferences hdata->hdev, which the same unplug freed.

  BUG: KASAN: slab-use-after-free in process_one_work+0xd96/0x10b0
  Read of size 8 at addr ffff8881095c0540 by task kworker/0:4/3058
  [...]
  Allocated by task 450:
   devm_kmalloc+0x7c/0x220
   rmi_probe+0x36/0xcf0 [hid_rmi]
   hid_device_probe+0x286/0x430
  Freed by task 9278:
   kfree+0x125/0x420
   release_nodes+0xf0/0x260
   devres_release_group+0x23a/0x3a0
   hid_device_remove+0xf5/0x220

The read is of hdata->reset_work.func, 320 bytes into the freed 512-byte
region, which process_one_work() calls straight afterwards.  Without KASAN
the same reproducer oopses in rmi_reset_work() and leaves the kworker
"exited with irqs disabled".

Cancel the work unconditionally in rmi_remove(), and do not queue it
before rmi_input_configured() has succeeded or after rmi_remove() has
cleared RMI_STARTED.

A report can still pass the RMI_STARTED test in rmi_event() just before
rmi_remove() clears the bit and queue the work after that cancel, so cancel
once more after hid_hw_stop() has stopped the report flow, and make
rmi_reset_work() bail out when RMI_STARTED is clear - by then the transport
device it would reset has been unregistered.

Fixes: 8725aa4fa7de ("HID: rmi: Check that the RMI_STARTED bit is set before unregistering the RMI transport device")
Cc: stable@vger.kernel.org
Signed-off-by: Wei Jie Law <98lawweijie@gmail.com>
---
This is independent of the pending "HID: rmi: fix OOB access with
undersized RMI reports" v3 [1] -- they touch different functions, and
either order applies cleanly.  They are worth taking together, though.

That patch makes a zero-length READ_DATA reply fail rmi_hid_read_block()
with -EIO instead of spinning in it, so rmi_scan_pdt(), and hence
rmi_input_configured(), now fail where they previously hung with the
device lock held.  That failure leaves RMI_DEVICE set and RMI_STARTED
clear -- the state this patch is about -- and, because the probe no
longer hangs, it also lets the unplug that triggers the use-after-free
complete.  The route described above, never answering the SET_REPORT
that rmi_set_mode() issues, reaches the same state on an unpatched tree,
so this is not a regression from that patch; it is a second way in, and
an argument for the two landing in the same release.

[1] https://lore.kernel.org/all/20260824122708.76168-1-98lawweijie@gmail.com/

 drivers/hid/hid-rmi.c | 40 ++++++++++++++++++++++++++++++++++------
 1 file changed, 34 insertions(+), 6 deletions(-)

diff --git a/drivers/hid/hid-rmi.c b/drivers/hid/hid-rmi.c
index d4af17fdba46..13a301404ff8 100644
--- a/drivers/hid/hid-rmi.c
+++ b/drivers/hid/hid-rmi.c
@@ -313,6 +313,14 @@ static void rmi_reset_work(struct work_struct *work)
 	struct rmi_data *hdata = container_of(work, struct rmi_data,
 						reset_work);
 
+	/*
+	 * A report that raced with rmi_remove() may have queued us after it
+	 * cleared RMI_STARTED, i.e. after the transport device we would reset
+	 * has been unregistered.
+	 */
+	if (!test_bit(RMI_STARTED, &hdata->flags))
+		return;
+
 	/* switch the device to RMI if we receive a generic mouse report */
 	rmi_reset_attn_mode(hdata->hdev);
 }
@@ -412,7 +420,13 @@ static int rmi_event(struct hid_device *hdev, struct hid_field *field,
 				return 1;
 		}
 
-		schedule_work(&data->reset_work);
+		/*
+		 * Only reset a device that finished rmi_input_configured();
+		 * before that, and after rmi_remove() has cleared the bit,
+		 * struct rmi_data may go away under the work.
+		 */
+		if (test_bit(RMI_STARTED, &data->flags))
+			schedule_work(&data->reset_work);
 		return 1;
 	}
 
@@ -739,15 +753,29 @@ static int rmi_probe(struct hid_device *hdev, const struct hid_device_id *id)
 static void rmi_remove(struct hid_device *hdev)
 {
 	struct rmi_data *hdata = hid_get_drvdata(hdev);
+	bool started = test_and_clear_bit(RMI_STARTED, &hdata->flags);
 
-	if ((hdata->device_flags & RMI_DEVICE)
-	    && test_bit(RMI_STARTED, &hdata->flags)) {
-		clear_bit(RMI_STARTED, &hdata->flags);
-		cancel_work_sync(&hdata->reset_work);
+	/*
+	 * reset_work lives inside the devm-allocated hdata, which is freed as
+	 * soon as this returns, so it has to be cancelled whether or not the
+	 * device ever reached the RMI_STARTED state.  Cancel it here, while
+	 * the transport device it resets is still registered.
+	 */
+	cancel_work_sync(&hdata->reset_work);
+
+	if ((hdata->device_flags & RMI_DEVICE) && started)
 		rmi_unregister_transport_device(&hdata->xport);
-	}
 
 	hid_hw_stop(hdev);
+
+	/*
+	 * A report that passed the RMI_STARTED test in rmi_event() just before
+	 * the clear above can queue the work again after that first cancel.
+	 * Such a work item does nothing, but it still has to be reaped before
+	 * hdata goes away.  hid_hw_stop() has stopped the report flow, so no
+	 * further queueing is possible by now.
+	 */
+	cancel_work_sync(&hdata->reset_work);
 }
 
 static const struct hid_device_id rmi_id[] = {
-- 
2.43.0

