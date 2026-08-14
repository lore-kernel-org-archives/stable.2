Received: from cvsmtppost08.nm.naver.com (cvsmtppost08.nm.naver.com [114.111.35.230])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D4891347532
	for <stable@vger.kernel.org>; Fri, 14 Aug 2026 08:56:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=114.111.35.230
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1786697795; cv=none; b=geEVGR28Cg2lMXUql/WEdlufJtDIbOZas6qviSi/wOTdv80YSXxkyITHPdl/AsCTeLyXL8ZyQDf+uVXxjGbn5lxL9pRUorMlgSJiiHPpLWBI9wNqNwg2RrWjnDSbEbYGAq68h2KTb+MdD9U4iWzEFOvmiecdgqXqYDKedd4CpwI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1786697795; c=relaxed/simple;
	bh=BCPyBqL54PWZKMN+4NXDapbcOzcTHBSwv8tnKZW/WLc=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=WXSQrgyY/B2Z5WAX3c9UqqvfwCjLmwXj/Zxhdc2xi0P77bJ0sDiB0Yh3paRdN0bG0WALMMLFAPa6SAIOk2AOmbsqC7hvOyU+exV19AqUdIFEPy2EGBS2rnQcYAAHhCY3KSHtBvL4dXOvmy7RzGPX8x3CvTw7PZ2f280lS5Kvn7E=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=naver.com; spf=pass smtp.mailfrom=naver.com; dkim=pass (2048-bit key) header.d=naver.com header.i=@naver.com header.b=M7nqo4oH; arc=none smtp.client-ip=114.111.35.230
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=naver.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=naver.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=naver.com header.i=@naver.com header.b="M7nqo4oH"
Received: from cvsendbo001.nm ([10.112.18.53])
  by cvsmtppost08.nm.naver.com with ESMTP id hvnoEJcZQCCfNuuGo2-8dg
  for <stable@vger.kernel.org>;
  Fri, 14 Aug 2026 08:46:22 -0000
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=naver.com; s=s20171208;
	t=1786697182; bh=BCPyBqL54PWZKMN+4NXDapbcOzcTHBSwv8tnKZW/WLc=;
	h=From:To:Subject:Date:Message-ID:From:Subject:Feedback-ID:
	 X-Works-Security;
	b=M7nqo4oHbU3c3U3YloFtL5UkjSRVJKOEm30zzYP1C/tV1J+AdqCqh6OQaXVnMAamn
	 Tvfmy9b1kiEYpRVHVSnsPx6PC5QafrDC/egEuoUrCBnkU4j+bJ8qe/gCUsQwn1NRuE
	 TvRa3aGVkg+T2s/10+MmPg2syEWEDrX91NkbQ42slo0YmnS81Q9sf13nE2hcXqFiBV
	 x33pliGMzQW5VvDm8NJEf+el1A8fl/A0NKZ3ItOsazH6VWhF6F7l8RSaUn4WLVsVCm
	 V1NQfwuVWAmRGdqvbx0N0spgLsyDH3P703dP5kJYmdd9pokBEudOyx6AsdVYgNFkV7
	 ASgZoSIMifcJg==
X-Session-ID: 1Fb99AraQdaqbpG9cujd7A
X-Works-Send-Opt: rPF8W4eXjHwYKBm9FAF9FBmwKo2mKqErKqb/jJIFjAJYKg==
X-Works-Smtp-Source: VdbrFoM/FqJZ+HmZaAbd+6E=
Received: from bl4ckhyun.localdomain ([211.41.193.194])
  by cvnsmtp004.nm.naver.com with ESMTP id 1Fb99AraQdaqbpG9cujd7A
  for <multiple recipients>
  (version=TLSv1.3 cipher=TLS_AES_256_GCM_SHA384);
  Fri, 14 Aug 2026 08:46:22 -0000
From: Hyeontae Lee <wonju345@naver.com>
To: Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
	Krzysztof Opasiak <k.opasiak@samsung.com>
Cc: linux-usb@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	stable@vger.kernel.org,
	Hyeontae Lee <wonju345@naver.com>
Subject: [PATCH] usb: gadget: f_hid: only clear write_pending from the owning request
Date: Fri, 14 Aug 2026 17:46:16 +0900
Message-ID: <20260814084616.259367-1-wonju345@naver.com>
X-Mailer: git-send-email 2.43.0
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

f_hidg_write() sets write_pending, caches hidg->req into a stack local,
and drops write_spinlock across copy_from_user(). hidg_disable() frees
hidg->req whenever write_pending is clear, so that flag is the only thing
keeping the writer's cached pointer alive.

f_hidg_req_complete() clears it for whichever request completes, not for
the one the writer owns. A write() that has queued a request leaves it
queued indefinitely if the host never issues an IN token. When the host
then disables the configuration, usb_ep_disable() gives that old request
back, its completion clears write_pending, and hidg_disable() goes on to
free hidg->req - which a different write() is holding at that moment.

The writer resumes, finds hidg->req NULL, and frees its cached pointer a
second time:

  BUG: KASAN: slab-use-after-free in f_hidg_write+0x7b7/0x920
  Read of size 8 at addr ffff888104fc9018 by task s4-3/163

  Allocated by task 0:
   alloc_ep_req+0x20/0x1b0
   hidg_set_alt+0x1ed/0xbd0
   composite_setup+0x1072/0x8690
   configfs_composite_setup+0xcd/0x110
   dummy_timer+0x1a68/0x31d0

  Freed by task 0:
   kfree+0x121/0x380
   hidg_disable+0x559/0x7a0
   reset_config+0x9d/0x200
   composite_setup+0x32d4/0x8690
   configfs_composite_setup+0xcd/0x110
   dummy_timer+0x1a68/0x31d0

  The buggy address belongs to the object at ffff888104fc9000
   which belongs to the cache kmalloc-128 of size 128

  BUG: KASAN: double-free in f_hidg_write+0x267/0x920

Record which request owns the flag and let only that request's completion
clear it. An older queued request being given back then leaves
write_pending set, hidg_disable() declines to free, and the writer frees
its own request on the existing path.

Fixes: 25cd9721c2b1 ("usb: gadget: f_hid: fix: Don't access hidg->req without spinlock held")
Cc: stable@vger.kernel.org
Signed-off-by: Hyeontae Lee <wonju345@naver.com>
---
Notes for reviewers:

The clearer was identified by instrumenting the three sites that clear the
flag: of 4944 frees at hidg_disable(), all 4944 followed a clear from
f_hidg_req_complete(), and 4440 freed a request a writer was holding.

749494b6bdbb introduced the stack local but left the uses on hidg->req, so
check and use still agreed; 25cd9721c2b1 moved the uses to the local and
left the guard on the field, which is why that one is tagged.

Every dereference of the freed pointer is inside f_hidg_write(), so this is
not remotely triggerable on its own - a local process must be writing to
/dev/hidgN at the time.

hidg_disable() now declines to free a request a writer owns; f_hid's request
lifetime under repeated SET_INTERFACE has pre-existing gaps this does not
address.

Tested on v7.2-rc7-12 (f5bbbfec59b4) under dummy_hcd, report_length=8: over
45 s of identical workload, double frees of the same address went from 52 to
0 and KASAN reports from 208 to 0.
---
 drivers/usb/gadget/function/f_hid.c | 17 ++++++++++++++++-
 1 file changed, 16 insertions(+), 1 deletion(-)

diff --git a/drivers/usb/gadget/function/f_hid.c b/drivers/usb/gadget/function/f_hid.c
index 3c6b43d06a6d1..d65169c9645b1 100644
--- a/drivers/usb/gadget/function/f_hid.c
+++ b/drivers/usb/gadget/function/f_hid.c
@@ -89,6 +89,7 @@ struct f_hidg {
 	/* send report */
 	spinlock_t			write_spinlock;
 	bool				write_pending;
+	struct usb_request		*write_req;
 	wait_queue_head_t		write_queue;
 	struct usb_request		*req;
 
@@ -443,7 +444,16 @@ static void f_hidg_req_complete(struct usb_ep *ep, struct usb_request *req)
 	}
 
 	spin_lock_irqsave(&hidg->write_spinlock, flags);
-	hidg->write_pending = 0;
+	/*
+	 * Only the completion of the request this writer owns may clear the
+	 * flag. usb_ep_disable() gives back whatever is still queued from an
+	 * earlier write(), and letting that clear write_pending lets
+	 * hidg_disable() go on to free a request a writer is still holding.
+	 */
+	if (req == hidg->write_req) {
+		hidg->write_req = NULL;
+		hidg->write_pending = 0;
+	}
 	spin_unlock_irqrestore(&hidg->write_spinlock, flags);
 	wake_up(&hidg->write_queue);
 }
@@ -480,6 +490,7 @@ static ssize_t f_hidg_write(struct file *file, const char __user *buffer,
 
 	hidg->write_pending = 1;
 	req = hidg->req;
+	hidg->write_req = req;
 	count  = min_t(unsigned, count, hidg->report_length);
 
 	spin_unlock_irqrestore(&hidg->write_spinlock, flags);
@@ -502,6 +513,8 @@ static ssize_t f_hidg_write(struct file *file, const char __user *buffer,
 
 	/* when our function has been disabled by host */
 	if (!hidg->req) {
+		if (hidg->write_req == req)
+			hidg->write_req = NULL;
 		free_ep_req(hidg->in_ep, req);
 		/*
 		 * TODO
@@ -534,6 +547,7 @@ static ssize_t f_hidg_write(struct file *file, const char __user *buffer,
 release_write_pending:
 	spin_lock_irqsave(&hidg->write_spinlock, flags);
 	hidg->write_pending = 0;
+	hidg->write_req = NULL;
 	spin_unlock_irqrestore(&hidg->write_spinlock, flags);
 
 	wake_up(&hidg->write_queue);
@@ -1102,6 +1116,7 @@ static int hidg_set_alt(struct usb_function *f, unsigned intf, unsigned alt)
 		spin_lock_irqsave(&hidg->write_spinlock, flags);
 		hidg->req = req_in;
 		hidg->write_pending = 0;
+		hidg->write_req = NULL;
 		spin_unlock_irqrestore(&hidg->write_spinlock, flags);
 
 		wake_up(&hidg->write_queue);
-- 
2.43.0

