Received: from cvsmtppost32.nm.naver.com (cvsmtppost32.nm.naver.com [114.111.35.242])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0F4162737F9
	for <stable@vger.kernel.org>; Fri, 14 Aug 2026 04:42:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=114.111.35.242
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1786682531; cv=none; b=Tfwxx62/9xkZ7nqlyW1OprIn5ssYnKhxzqGIggbgqKwP4ZQXQyWw0NraKgHhjqYhM+ZFWjPcFjkAn5JMPmMJJpURndrMFkITO9EI5/qwZPevBrK35yvboSFCA40VhN6clMvyqlWbVpjqUIUk39WZPuRc44rnmgQUJ87fuHj5NGA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1786682531; c=relaxed/simple;
	bh=l4bN/IbQhfLzSXKo69xQ1REe6wkkUu4J0H6G67EMB4Y=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=bsia/OVEnVDzHDAzXaBZJ26luQC1eNotbg+mdkJTulrEAX3Moz7B/OQtJ9Ei6ScvC4s6fbhCd9UKOyZJG6I+t5PKumdxkUqpHSN/kRCKGoWsxBoFy6Y/h9AvwSdoP+2dRpdE0c8YtHMZ5L4C4v0Z+TcJViXrN8RjhYmmhngbQv0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=naver.com; spf=pass smtp.mailfrom=naver.com; dkim=pass (2048-bit key) header.d=naver.com header.i=@naver.com header.b=IxZAl6/n; arc=none smtp.client-ip=114.111.35.242
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=naver.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=naver.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=naver.com header.i=@naver.com header.b="IxZAl6/n"
Received: from cvsendbo021.nm ([10.112.18.58])
  by cvsmtppost32.nm.naver.com with ESMTP id QVpLggXAR6aRX7wZdkd3Cw
  for <stable@vger.kernel.org>;
  Fri, 14 Aug 2026 04:21:53 -0000
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=naver.com; s=s20171208;
	t=1786681313; bh=l4bN/IbQhfLzSXKo69xQ1REe6wkkUu4J0H6G67EMB4Y=;
	h=From:To:Subject:Date:Message-ID:From:Subject:Feedback-ID:
	 X-Works-Security;
	b=IxZAl6/nksBjeysJPg60fx7sSBcBXRXmuxyd2/LocpXu9wCHUi+9Tk9+gCeZYSVdi
	 1IDfFFUy1UQSu8+mjznrASzY8nzei2T9Nr4S4eFwYkr/VJmcMZ7O+McK9Z/zCCBanE
	 OOJgQdFlMpZ/x1qv0tUkFIONqxUXH9fOkM7S7HQ1D8WIF8c4bFNqrkUfTeZiTyaOnn
	 qCa+KBOPAkcaQrw2eBsV4uxGDP+lPieSNYyieS15A8e/tphq0UFwM0XwVrpynw6y7X
	 aY4zBJysGph43TJ+wmMwmm/gQEa1Czw/f2zhbyH85RDQ6+Dqay36lLlBvewl1/6MU1
	 LDvpswezWTE8g==
X-Session-ID: Os1z+Z6VT3iHp5zXEtqvPw
X-Works-Send-Opt: rlF8W4eXjHwYKBm9FAF9KBmwKo2mKqErKqb/jJIFjAJYKg==
X-Works-Smtp-Source: gdKdFoM/FqJZ+HmZKxv/+6E=
Received: from bl4ckhyun.localdomain ([211.41.193.194])
  by cvnsmtp010.nm.naver.com with ESMTP id Os1z+Z6VT3iHp5zXEtqvPw
  for <multiple recipients>
  (version=TLSv1.3 cipher=TLS_AES_256_GCM_SHA384);
  Fri, 14 Aug 2026 04:21:52 -0000
From: Hyeontae Lee <wonju345@naver.com>
To: wonju345@naver.com
Cc: stable@vger.kernel.org
Subject: [PATCH] usb: gadget: f_hid: don't free the IN request from ->disable
Date: Fri, 14 Aug 2026 13:21:49 +0900
Message-ID: <20260814042149.66475-1-wonju345@naver.com>
X-Mailer: git-send-email 2.43.0
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

hidg_disable() frees hidg->req while a f_hidg_write() caller may still be
holding it. The writer caches hidg->req into a stack local at the top of
its critical section, drops write_spinlock across copy_from_user(), and
uses that local from then on. The guard meant to prevent the free tests
hidg->req - the driver field - so it protects a different object from the
one being dereferenced.

write_pending cannot substitute for that check. It is a bare flag, not
bound to any particular request: f_hidg_req_complete() clears it for
whichever request completes on the IN endpoint, and hidg_set_alt() clears
it unconditionally. Worst of all hidg_disable() clears it against itself -
the usb_ep_disable() at the top of the function gives back an already
queued request, whose completion handler clears the flag, and the same
function then reads that flag and frees hidg->req.

So a USB host that issues SET_INTERFACE and then SET_CONFIGURATION 0,
while never polling the interrupt IN endpoint so an earlier request stays
queued, makes hidg_disable() free the request a /dev/hidgN writer holds.
Observed under KASAN: a use-after-free read and a use-after-free write of
the usb_request, a double free of it, a use-after-free write into the
freed report buffer, and a use-after-free read in the UDC's queue path.

  BUG: KASAN: slab-use-after-free in f_hidg_write+0x7b7/0x920
  Read of size 8 ... which belongs to the cache kmalloc-128 of size 128
  Allocated by task 0:
    alloc_ep_req <- hidg_set_alt <- composite_setup
  Freed by task 0:
    kfree <- hidg_disable <- reset_config <- composite_setup

  BUG: KASAN: double-free in f_hidg_write+0x267/0x920

Without KASAN this is not merely detectable corruption. struct
dummy_request has its queue list_head at offset 0, so freeing it while
still linked corrupts the endpoint's request list, and the UDC's
transfer engine faults walking it:

  BUG: kernel NULL pointer dereference, address: 0000000000000008
  #PF: supervisor write access in kernel mode
  RIP: 0010:dummy_timer+0x6b8/0xed0
   <IRQ> __hrtimer_run_queues <- hrtimer_run_softirq <- handle_softirqs
  Kernel panic - not syncing: Fatal exception in interrupt

about nine seconds into the attack, on a build with no debug options at
all. Because the fault is in interrupt context the kernel cannot
continue.

No other function driver frees a request from its ->disable callback:

  - f_printer's printer_reset_interface() disables both endpoints and
    clears the descriptors, and frees nothing; its request pools live
    until unbind.
  - fsg_disable() disables both endpoints and raises
    FSG_STATE_CONFIG_CHANGE, deferring teardown to the fsg worker thread,
    which runs in process context.
  - f_uvc allocates its ep0 control request at bind and frees it at
    unbind.

f_hid is the outlier. Do what the others do and keep the IN request
allocated for the lifetime of the binding: hidg_set_alt() installs one
only when there is none, hidg_disable() marks writes shut down instead of
freeing, and hidg_unbind() frees it as it already did. write_pending goes
back to meaning "one write at a time" and carries no lifetime
responsibility, so clearing it on behalf of some other request becomes
harmless.

Rejecting writes after disable used to rely on hidg->req being NULL. That
moves to a new write_disabled flag, maintained entirely under
write_spinlock in critical sections that already existed - hidg_disable()
and hidg_set_alt() both already take that lock, and f_hidg_write() already
holds it where the check is made. The three spinlocks in this file are
never nested today and this does not change that.

Allocation stays in hidg_set_alt(). It cannot move to bind: alloc_ep_req()
aligns the buffer against ep->desc, which is only assigned by
usb_ep_enable(), which is why commit 749494b6bdbb ("usb: gadget: f_hid:
fix: Move IN request allocation to set_alt()") moved it out of bind in the
first place.

The cost is that one usb_request and its buffer, together roughly 136 to
192 bytes, stay allocated while the function is bound but disabled. Reuse
across a disable/re-enable cycle is safe because report_length cannot
change while bound - the configfs store returns -EBUSY once opts->refcnt
has been taken in hidg_alloc() - so the cached request is always correctly
sized.

This also fixes a memory leak reported by Kyungtae Kim in May 2020 and
never fixed: hidg_set_alt() overwrote hidg->req with a freshly allocated
request on every SET_INTERFACE, losing the previous pointer. Installing
only when there is none removes that overwrite.

Fixes: 25cd9721c2b1 ("usb: gadget: f_hid: fix: Don't access hidg->req without spinlock held")
Cc: stable@vger.kernel.org
Signed-off-by: Hyeontae Lee <wonju345@naver.com>
---
Notes for reviewers (below the --- so it does not enter the commit message):

Fixes: tag. Two commits are candidates and the divergence is traceable to
exactly one. 749494b6bdbb introduced the stack local, but every use in
f_hidg_write() still went through hidg->req, so the check and the uses agreed.
25cd9721c2b1, a week later, converted copy_from_user(), free_ep_req() and
usb_ep_queue() to the local and left the guard testing the field. Its own
message - "hidg->req should be accessed only with write_spinlock held as it is
set to NULL when we get disabled by host" - shows the reasoning: it correctly
fixed the unsynchronised access by caching, without noticing that caching makes
a field-based guard meaningless for the cached pointer. Both landed in v4.11
(rc1 and rc4), so stable targeting is the same either way.

Composition of the trigger. The host supplies the free; a local process writing
to /dev/hidgN supplies the use and the second free. A cable-only attacker cannot
reach it: every dereference of the freed pointer is inside f_hidg_write(), and
hidg_disable() leaves nothing dangling on the host-facing side. The writer is a
victim doing its ordinary job - writing HID reports to /dev/hidgN is what f_hid
exists for.

Deployment. Devices exposing a HID gadget with a resident daemon feeding it
reports, i.e. KVM-over-IP and remote-console appliances, where the attacker is
the managed server the appliance is plugged into and the victim is the
out-of-band management device. AOSP configures no HID function, so Android as
shipped is not affected.

Reproduction rate. With an ordinary writer - one resident 8-byte buffer, plain
write(), no window manipulation - the race lands unaided: 12 KASAN reports in
903 s over 30320 enabling epochs. Artificially widening the copy_from_user
window raises that to 227 reports in 60 s over 25429 epochs, i.e. widening
accelerates it about 22.6x rather than manufacturing it.

On exploitability, stated conservatively. The double free does reach the real
allocator on a kernel with no sanitizer, and the window between the two frees
was measured at about 16 ms, which is large. But no controlled primitive is
claimed: whether a foreign object can be landed in the freed chunk was not
established, because the test guest has no competing allocators in the
kmalloc-128 class. Note also that KASAN inflates the hit rate by roughly two
orders of magnitude (0.58% of enabling epochs with it, 0.003-0.015% without),
so the race is harder to win on a production kernel than the figures above
suggest.

Tested on v7.2-rc7-12 (f5bbbfec59b4) under dummy_hcd, report_length=8, with
patched and unpatched builds using a byte-identical .config; the panic above
came from a separate build with no KASAN and no freelist hardening. A
self-contained reproducer that runs both configurations and diffs them is
available on request.
---
 drivers/usb/gadget/function/f_hid.c | 39 +++++++++++++++++--------------------
 1 file changed, 20 insertions(+), 19 deletions(-)

diff --git a/drivers/usb/gadget/function/f_hid.c b/drivers/usb/gadget/function/f_hid.c
index 3c6b43d06a6d1..38789bc77fa15 100644
--- a/drivers/usb/gadget/function/f_hid.c
+++ b/drivers/usb/gadget/function/f_hid.c
@@ -89,6 +89,7 @@ struct f_hidg {
 	/* send report */
 	spinlock_t			write_spinlock;
 	bool				write_pending;
+	bool				write_disabled;
 	wait_queue_head_t		write_queue;
 	struct usb_request		*req;

@@ -458,13 +459,12 @@ static ssize_t f_hidg_write(struct file *file, const char __user *buffer,

 	spin_lock_irqsave(&hidg->write_spinlock, flags);

-	if (!hidg->req) {
+	if (hidg->write_disabled) {
 		spin_unlock_irqrestore(&hidg->write_spinlock, flags);
 		return -ESHUTDOWN;
 	}

 #define WRITE_COND (!hidg->write_pending)
-try_again:
 	/* write queue */
 	while (!WRITE_COND) {
 		spin_unlock_irqrestore(&hidg->write_spinlock, flags);
@@ -500,16 +500,6 @@ static ssize_t f_hidg_write(struct file *file, const char __user *buffer,

 	spin_lock_irqsave(&hidg->write_spinlock, flags);

-	/* when our function has been disabled by host */
-	if (!hidg->req) {
-		free_ep_req(hidg->in_ep, req);
-		/*
-		 * TODO
-		 * Should we fail with error here?
-		 */
-		goto try_again;
-	}
-
 	req->status   = 0;
 	req->zero     = 1;
 	req->length   = count;
@@ -1009,13 +999,14 @@ static void hidg_disable(struct usb_function *f)
 	spin_unlock_irqrestore(&hidg->read_spinlock, flags);
 	wake_up(&hidg->read_queue);

+	/*
+	 * Do not free hidg->req here. A f_hidg_write() caller may be holding it,
+	 * and write_pending cannot tell us: it is cleared on behalf of whichever
+	 * request completes, including by the usb_ep_disable() above. The request
+	 * stays allocated until unbind, exactly as the other function drivers do.
+	 */
 	spin_lock_irqsave(&hidg->write_spinlock, flags);
-	if (!hidg->write_pending) {
-		free_ep_req(hidg->in_ep, hidg->req);
-		hidg->write_pending = 1;
-	}
-
-	hidg->req = NULL;
+	hidg->write_disabled = true;
 	spin_unlock_irqrestore(&hidg->write_spinlock, flags);
 }

@@ -1100,10 +1091,19 @@ static int hidg_set_alt(struct usb_function *f, unsigned intf, unsigned alt)

 	if (hidg->in_ep != NULL) {
 		spin_lock_irqsave(&hidg->write_spinlock, flags);
-		hidg->req = req_in;
+		/* Keep the request we already have; only install a new one. */
+		if (!hidg->req) {
+			hidg->req = req_in;
+			req_in = NULL;
+		}
 		hidg->write_pending = 0;
+		hidg->write_disabled = false;
 		spin_unlock_irqrestore(&hidg->write_spinlock, flags);

+		/* We were already holding one, so this allocation is surplus. */
+		if (req_in)
+			free_ep_req(hidg->in_ep, req_in);
+
 		wake_up(&hidg->write_queue);
 	}
 	return 0;
@@ -1264,6 +1264,7 @@ static int hidg_bind(struct usb_configuration *c, struct usb_function *f)
 		goto fail;

 	hidg->write_pending = 1;
+	hidg->write_disabled = true;
 	hidg->req = NULL;

 	INIT_WORK(&hidg->work, get_report_workqueue_handler);
--
2.43.0

