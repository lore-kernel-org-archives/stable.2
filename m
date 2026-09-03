Received: from mail-ua1-f52.google.com (mail-ua1-f52.google.com [209.85.222.52])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3CDFB32E729
	for <stable@vger.kernel.org>; Thu,  3 Sep 2026 23:21:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.222.52
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1788477692; cv=none; b=BwR34KooAsaqlMC1A2dDu6YcN5OAb+55VIPn6eKskobMYqTcGsEYEPSYwddLPlopTAsAZgogTIEX7jJkuEq3yL4OT/oJ+Jj7M+Uye+GxpaRgds2r60Pf/kz1VxDhhamKRL38IYIrlHnqe+V/EZmMNtOluY60ACkT75XVzzUj8pw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1788477692; c=relaxed/simple;
	bh=8+XLyZqnhfORQiEKXSgKcLx7LkZlVuLYNPOJl1UeOYw=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=gl99xi+/vigULaxnvUx3K6jIlsDqBH+iS4+UIcvjLXGV0drJXC+0Drq3OjL5QNSjqaEsN2ERdxwnHDm9tBCAG8QK9GWVPNYmvF44LIZDVOtAuNZihkZ4dl/qqDJHFcsZTh9/5LIciEqBSWmJ996S4GtSleTbez+yDLLjPQUzyTg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=Tz3NDmGm; arc=none smtp.client-ip=209.85.222.52
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="Tz3NDmGm"
Received: by mail-ua1-f52.google.com with SMTP id a1e0cc1a2514c-97fcda3952aso165933241.0
        for <stable@vger.kernel.org>; Thu, 03 Sep 2026 16:21:28 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1788477687; x=1789082487; darn=vger.kernel.org;
        h=content-transfer-encoding:content-type:mime-version:references
         :in-reply-to:message-id:date:subject:cc:to:from:from:to:cc:subject
         :date:message-id:reply-to:content-type;
        bh=ruQnDQuLtg+za+d/Pzwg+TIOwOfsfRnrKCBPRWwwDnI=;
        b=Tz3NDmGmQ/gTCsx0lZJR9n8+SuKfrNTj3kkoeX4MiZE0i6xpF178a73TOL57K4IRhZ
         h8JNeAEaJugVHgvjbfAluQocyitlzp1aSy1bYDpvIt9BkJfrebzie7HFVdyqGthnNUMJ
         aOfxNc7HSaOMn3HdDAtwEvwZlLfp68HwDl5wsua4U2a6JdMb51tv41gv+fOQDFPOMtSY
         q5Vg1k7VI1BrJ5cgV/yzwr8vy5/l/4GOZg61nqXLS419mQWDt7jLZW3ChzQ6eEGXRfBl
         LKt6/p20IBL1QZNhfseQ6IJlEoUJCHZDc8GANPagWqdd0c+7dtp7UHcFd4uGLNib5q+F
         YjFQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1788477687; x=1789082487;
        h=content-transfer-encoding:content-type:mime-version:references
         :in-reply-to:message-id:date:subject:cc:to:from:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=ruQnDQuLtg+za+d/Pzwg+TIOwOfsfRnrKCBPRWwwDnI=;
        b=OFCHizQoeiGa7mtaWhg6S7w9xvWXlx4rMQO9X/VpNeRm55y9OaCRGRlIHi5qnM2shV
         2gU4WGiLqBRvrJLbKhUTkqgsbhBLi4Yld2rcCJVcDCLw7E/yu+6VpQ8TphVgC7/U0Cjh
         M8R/GgKGVXFMMFZ/rSSGZaQSMZiN+JysDJPLg4WX1CkbwX8gWF/LphYE5vOz8RVJodXt
         WGekg/WbkYmycRQT2ovkp7H8hPeIFWP4L51Jlq2uiJhDZZnUzeWWOUFXA1w0KTAHHcpO
         402R95Vlok7LgUWY9XlpxrUgiLss3CsYMnzzFun/b5hATOgkiBdKgo8brBNq7OXoOnm+
         l8xw==
X-Forwarded-Encrypted: i=1; AKwUvBzbIobAjpZkByDfj6se9cjSTSszqXHHA3HMCN3587+IkLrND8LrsU7v7rAYexubiFf5CaAQNXY=@vger.kernel.org
X-Gm-Message-State: AFuF++nEm+FM1T5Z9Q/uIh06ng4NnYSxm89YQv66HlNbIW4c11ZH+eSx
	eWaE1+hNW03rjrPBXwG9lK8A24V2rQqk6oIOJcnnTH6ThO2kyBCBTGafJOcSkIk7
X-Gm-Gg: AYBFou31R6wTicUTvsP0ALNa/eX8MeWDU088wP6sVTOKbI6D0azD8FHUkXtZzZcSAbQ
	IweB8DckN+azfW8/mblHlBBQUhxGSvKg8NLXFpS8zbYf0ER3weZvVkARc+EOda0H7RuoTBO7qD5
	ZVgFo2Mdo08X46rtg2kJqn+6f9POv/aLudT4pjTw/BeWhYj5v84v7AGYTHAUi+wh9XtmpBqdcfJ
	ZOOaJ9qtHsHKppfwO3xc3Cjqko3FcgAxo3zW/qE50tz61LbmV3t9SSOleO5ZnOBw9JVxRxMUv1P
	B8vgiL69GjNcWPkWfWCZQZXBzi5Q9ENMRQX/LVD8qoG4BMAa0SFeAtzVPd/h9XdLwPTw6uIzeXD
	eAWjjcLRinfz5wjat5/Or9C16yQiSRDxnkXET17bEJreE1CP+KJpNg0xIbSlX69kL8DohLfWJd/
	qrQbBIrf0D25J3P4tuTrG2AnI2hBU9lgkBYEC/aCP4RdYfH6Y2wDdF2w==
X-Received: by 2002:a05:6102:2b9c:b0:785:1a50:3f56 with SMTP id ada2fe7eead31-78a4aa53ca4mr520733137.12.1788477687005;
        Thu, 03 Sep 2026 16:21:27 -0700 (PDT)
Received: from unix.. ([181.229.23.179])
        by smtp.gmail.com with ESMTPSA id a1e0cc1a2514c-9808ebb37fdsm529794241.1.2026.09.03.16.21.23
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 03 Sep 2026 16:21:26 -0700 (PDT)
From: =?UTF-8?q?Iv=C3=A1n=20Ezequiel=20Rodriguez?= <ivanrwcm25@gmail.com>
To: Heikki Krogerus <heikki.krogerus@linux.intel.com>,
	Greg Kroah-Hartman <gregkh@linuxfoundation.org>
Cc: =?UTF-8?q?Iv=C3=A1n=20Ezequiel=20Rodriguez?= <ivanrwcm25@gmail.com>,
	Fan Wu <fanwu01@zju.edu.cn>,
	Wei Huang <huangwei@kylinos.cn>,
	linux-usb@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	stable@vger.kernel.org
Subject: [PATCH v2] usb: typec: ucsi: acpi: fix use-after-free on driver removal
Date: Thu,  3 Sep 2026 20:21:21 -0300
Message-ID: <20260903232121.271776-1-ivanrwcm25@gmail.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20260903030356.58597-1-ivanrwcm25@gmail.com>
References: <20260903030356.58597-1-ivanrwcm25@gmail.com>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit

ucsi_acpi_remove() destroys the UCSI instance before removing the ACPI
notify handler:

	ucsi_unregister(ua->ucsi);
	ucsi_destroy(ua->ucsi);

	acpi_remove_notify_handler(...);

ucsi_acpi_notify() dereferences ua->ucsi, so a notify arriving after
ucsi_destroy() uses freed memory:

  CPU0					CPU1
  ----					----
  ucsi_acpi_remove()
    ucsi_unregister()
    ucsi_destroy()
      kfree(ucsi)
					ucsi_acpi_notify()
					  ua->ucsi->ops->read_cci()   <-- UAF

Simply removing the handler before ucsi_unregister() is not correct
either. ucsi_unregister() drains work that needs the notify path to make
progress: ucsi_handle_connector_change() issues GET_CONNECTOR_STATUS and
ucsi_unregister_port() drains and destroys con->wq, and those commands
block in wait_for_completion_timeout() on ucsi->complete for up to
UCSI_TIMEOUT_MS. That completion is signalled only from
ucsi_notify_common(), i.e. from the notify handler. Tearing the handler
down first would leave cancel_work_sync() and destroy_workqueue()
waiting the full timeout for a completion that can no longer arrive.

Moving the removal between ucsi_unregister() and ucsi_destroy() is not
sufficient on its own: at that point the connector array has already
been freed, so a late notify reaching ucsi_connector_change() would
queue work on a freed connector.

Teardown therefore needs two properties at the same time: no new
connector changes once connectors start going away, but the notify path
still available for command and acknowledge completions until that work
has been drained. Whether the PPM actually produces those completions is
a firmware matter; what changes here is that the path able to deliver
them is no longer torn down first.

Introduce a quiescing state, local to the ACPI backend, that provides
both. ucsi_acpi_remove() sets ua->quiescing under ua->notify_lock before
calling ucsi_unregister(); ucsi_acpi_notify() takes the same lock and,
when quiescing, reduces the CCI to the bits that ucsi_notify_common()
consumes for completions. ucsi_notify_common() looks at exactly
UCSI_CCI_BUSY, the connector number, UCSI_CCI_ACK_COMPLETE and
UCSI_CCI_COMMAND_COMPLETE; keeping the first and the last two preserves
the completion and bogus-data behaviour unchanged, while clearing the
connector number makes ucsi_connector_change() unreachable. The CCI that
the command path inspects is unaffected, because
ucsi_sync_control_common() re-reads it from the interface after the
completion.

The resulting order is:

  mutex_lock(&ua->notify_lock);
  ua->quiescing = true;			-- no new connector work
  mutex_unlock(&ua->notify_lock);

  ucsi_unregister();			-- drains work, notify path still
					   available for completions

  acpi_remove_notify_handler();		-- unlinks, then flushes
					   kacpi_notify_wq

  ucsi_destroy();			-- no notify can be in flight

which gives the following happens-before chain:

- A notify that acquires notify_lock before ucsi_acpi_remove() runs to
  completion while remove() waits on the lock, so any schedule_work() it
  performs happens before ucsi_unregister() starts cancelling.
- A notify that acquires notify_lock after remove() released it observes
  quiescing == true, so it cannot reach ucsi_connector_change() and
  cannot touch ucsi->connector.
- acpi_remove_notify_handler() unlinks the handler and then calls
  acpi_os_wait_events_complete(), which flushes kacpi_notify_wq, so a
  notify already dispatched on another CPU has returned before
  ucsi_destroy() frees the instance.

notify_lock is never held across ucsi_unregister() or
acpi_remove_notify_handler(); holding it there would deadlock against
the notify work those calls wait for. It is only ever taken as a leaf:
ucsi_notify_common() and ucsi_connector_change() take no locks, so it
cannot invert against ucsi->ppm_lock or con->lock, which the drained
work holds while waiting for the completion. The handler runs from
kacpi_notify_wq via acpi_os_execute(OSL_NOTIFY_HANDLER, ...), i.e. in
process context, so sleeping on the mutex is allowed.

The probe error path already removes the handler before ucsi_destroy()
and is left unchanged.

Fixes: f56de278e8ec ("usb: typec: ucsi: acpi: Move to the new API")
Cc: stable@vger.kernel.org
Reported-by: Fan Wu <fanwu01@zju.edu.cn>
Link: https://lore.kernel.org/all/20260718021142.3146566-1-fanwu01@zju.edu.cn/
Signed-off-by: Iván Ezequiel Rodriguez <ivanrwcm25@gmail.com>
---

Notes:
    Hi Heikki, Greg,
    
    v2 is a rewrite rather than an incremental fixup. v1 moved
    acpi_remove_notify_handler() ahead of the teardown, and that ordering is
    wrong for the reason Fan Wu had already documented in [1]: the work that
    ucsi_unregister() drains can be waiting for a completion that only the
    notify path delivers. This version keeps the handler installed across
    ucsi_unregister() and adds an ACPI-local quiescing state instead.
    
    Wei Huang asked on v1 whether acpi_remove_notify_handler() waits for a
    callback that already entered on another CPU. It does: for
    ACPI_DEVICE_NOTIFY it calls acpi_os_wait_events_complete() after
    unlinking the handler (drivers/acpi/acpica/evxface.c), that flushes
    kacpi_notify_wq (drivers/acpi/osl.c), and device-notify dispatch runs on
    that same workqueue through acpi_os_execute(OSL_NOTIFY_HANDLER, ...).
    So the raw call is already the barrier, and acpi_dev_remove_notify_handler()
    would only add a second flush. Chasing that question is what surfaced the
    harder half of the problem, which is what this version is about.
    
    On [1]: that patch kept the handler installed across ucsi_unregister()
    for exactly the right reason, and this version preserves that property.
    What it did not cover is the window you described in that thread, where a
    notify arriving after ucsi_unregister() has freed the connectors still
    reaches ucsi_connector_change(). You also asked to keep the solution
    inside ucsi_acpi.c rather than redesigning the core, which is what this
    does.
    
    Changes since v1:
    - Do not remove the notify handler before ucsi_unregister().
    - Add the quiescing state, so connector changes stop while the notify
      path stays available for completions.
    - Drop the ucsi.c changes from v1 (ntfy = 0, connector = NULL, cap = 0).
      I could not show they were needed for the other backends, and they do
      not belong in the same patch as the ACPI lifetime fix.
    - Correct the Fixes: tag. v1 pointed at 8243edf44152, which added the
      driver; the current ordering came from f56de278e8ec.
    - Credit Fan Wu, who reported the underlying use-after-free first.
    - Use mutex_init() rather than devm_mutex_init(), which only appeared in
      4cd47222e435 (2024) and would be a needlessly modern dependency for a
      fix tagged for stable from a 2019 commit.
    
    Testing
    
    I have no machine that exercises the UCSI ACPI path, so this was tested
    with a software PPM backend that drives the real UCSI core
    (ucsi_create/ucsi_register/ucsi_unregister/ucsi_destroy/
    ucsi_notify_common) and reproduces the ACPI notify protocol, including
    the deferral to a percpu workqueue. All three candidate teardown
    orderings were run against it: the one from v1, the one from [1] and the
    one in this patch. v7.3-rc2, KASAN + lockdep + PROVE_LOCKING +
    DEBUG_MUTEXES, QEMU, oops=panic.
    
    Each case below parks a connector work in wait_for_completion_timeout()
    before teardown starts, and asserts that precondition rather than
    assuming it.
    
      teardown ordering                     result
      ------------------------------------  ----------------------------
      quiesce, unregister, unlink (this)    148 ms, clean, with a late
                                            connector notify fired after
                                            ucsi_unregister() returned
      unlink, unregister (v1)               10595 ms stall
      unregister, unlink (as in [1]), a     KASAN slab-use-after-free in
      connector notify landing in the       queue_work_on(), then a GP
      window                                fault in the kworker that
                                            picked up the freed work
      nothing in flight (this)              146 ms, clean
    
    Repeated with the teardown starting while ucsi_init_work() is still
    running, so that cancel_delayed_work_sync(&ucsi->work) has to drain an
    init command parked on the completion: this patch takes 2299 ms and
    completes cleanly, of which 1500 ms is the injected command delay, while
    the v1 ordering stalls for 10089 ms and the init gives up with
    -ETIMEDOUT.
    
    Two deterministic checks of the properties the patch claims:
    
    - CCI mask. A single CCI carrying both connector 1 and COMMAND_COMPLETE
      (0x80000002) is delivered while quiescing: the completion is signalled
      and EVENT_PENDING stays clear, i.e. ucsi_connector_change() is not
      reached. The same CCI with quiescing off sets EVENT_PENDING, so the
      check is sensitive to the path it claims to block.
    
    - notify_lock as a barrier. A notify that has entered the handler is
      held inside it for 1200 ms; the store of quiescing in the teardown
      path blocks for 1215 ms behind it. This is what makes "a notify that
      started before teardown finishes its schedule_work() before
      ucsi_unregister() begins cancelling" an ordering guarantee rather
      than a likelihood.
    
    Soak: 1000 teardown cycles with four threads hammering the notify path
    concurrently with the quiesce sequence, repeated at 1, 2, 4 and 8 vCPUs,
    so 4000 teardowns in total. No stall, no KASAN report and no lockdep
    splat in any configuration. A separate KCSAN build ran 200 of those
    cycles at 4 vCPUs with no data race reported in any UCSI path.
    
    What this does not cover: no real ACPI hardware, so the ACPICA drain
    described above is established by reading evxface.c and osl.c rather
    than by execution; and the LG gram quirk path is untouched and
    unexercised.
    
    The harness is not part of this patch. I can post it separately if it
    is useful.
    
    [1] https://lore.kernel.org/all/20260718021142.3146566-1-fanwu01@zju.edu.cn/

 drivers/usb/typec/ucsi/ucsi_acpi.c | 53 ++++++++++++++++++++++++++++--
 1 file changed, 51 insertions(+), 2 deletions(-)

diff --git a/drivers/usb/typec/ucsi/ucsi_acpi.c b/drivers/usb/typec/ucsi/ucsi_acpi.c
index 18286d3e9cc5..61bba7625d17 100644
--- a/drivers/usb/typec/ucsi/ucsi_acpi.c
+++ b/drivers/usb/typec/ucsi/ucsi_acpi.c
@@ -24,6 +24,15 @@ struct ucsi_acpi {
 	bool check_bogus_event;
 	guid_t guid;
 	u64 cmd;
+	/*
+	 * notify_lock serialises ucsi_acpi_notify() against the start of
+	 * teardown, so that @quiescing is observed by every notify that has
+	 * not yet run. It must not be held across ucsi_unregister(), whose
+	 * drained work may depend on the notify path, nor across
+	 * acpi_remove_notify_handler(), which flushes notify work.
+	 */
+	struct mutex notify_lock;
+	bool quiescing;
 };
 
 static int ucsi_acpi_dsm(struct ucsi_acpi *ua, int func)
@@ -179,11 +188,31 @@ static void ucsi_acpi_notify(acpi_handle handle, u32 event, void *data)
 	u32 cci;
 	int ret;
 
+	mutex_lock(&ua->notify_lock);
+
 	ret = ua->ucsi->ops->read_cci(ua->ucsi, &cci);
 	if (ret)
-		return;
+		goto out_unlock;
+
+	/*
+	 * Once teardown has started the connectors are being unregistered and
+	 * freed, so a connector change must not be reported any more. Command
+	 * and acknowledge completions must still be able to reach the core:
+	 * ucsi_unregister() drains connector and partner work that can be
+	 * blocked in wait_for_completion_timeout() on ucsi->complete, and that
+	 * completion is only signalled from here. Keep exactly the bits that
+	 * ucsi_notify_common() needs for that, which drops the connector
+	 * number and with it the path to ucsi_connector_change(). The busy
+	 * indicator is kept so that bogus CCI data is still ignored.
+	 */
+	if (ua->quiescing)
+		cci &= UCSI_CCI_BUSY | UCSI_CCI_ACK_COMPLETE |
+		       UCSI_CCI_COMMAND_COMPLETE;
 
 	ucsi_notify_common(ua->ucsi, cci);
+
+out_unlock:
+	mutex_unlock(&ua->notify_lock);
 }
 
 static int ucsi_acpi_probe(struct platform_device *pdev)
@@ -219,6 +248,8 @@ static int ucsi_acpi_probe(struct platform_device *pdev)
 
 	ua->dev = &pdev->dev;
 
+	mutex_init(&ua->notify_lock);
+
 	id = dmi_first_match(ucsi_acpi_quirks);
 	if (id)
 		ops = id->driver_data;
@@ -256,11 +287,29 @@ static void ucsi_acpi_remove(struct platform_device *pdev)
 {
 	struct ucsi_acpi *ua = platform_get_drvdata(pdev);
 
+	/*
+	 * Stop reporting connector changes, but keep the notify handler
+	 * installed so that the work ucsi_unregister() drains can still be
+	 * reached by the command completions it may be waiting for. Any notify
+	 * that already passed this point runs to completion first, so no
+	 * connector work can be queued once ucsi_unregister() starts.
+	 */
+	mutex_lock(&ua->notify_lock);
+	ua->quiescing = true;
+	mutex_unlock(&ua->notify_lock);
+
 	ucsi_unregister(ua->ucsi);
-	ucsi_destroy(ua->ucsi);
 
+	/*
+	 * Now that no work is left to serve, drop the handler. This unlinks it
+	 * and then calls acpi_os_wait_events_complete(), which flushes
+	 * kacpi_notify_wq, so a notify running on another CPU has returned
+	 * before ucsi_destroy() frees the instance that it dereferences.
+	 */
 	acpi_remove_notify_handler(ACPI_HANDLE(&pdev->dev), ACPI_DEVICE_NOTIFY,
 				   ucsi_acpi_notify);
+
+	ucsi_destroy(ua->ucsi);
 }
 
 static int ucsi_acpi_suspend(struct device *dev)
-- 
2.43.0

