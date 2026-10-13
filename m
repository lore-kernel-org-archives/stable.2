Received: from linux.microsoft.com (linux.microsoft.com [13.77.154.182])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 746B715665C;
	Tue, 13 Oct 2026 05:16:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=13.77.154.182
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1791868569; cv=none; b=k/VXEiJpokx2Z8E/Wc+KmDo2KeOTRuqZHtFarUxjY7mycU0D+8JJJZQa39HzDT0L9RYw4/M9nw/7g7U+bDGrTonycf8I2F/ZGVeCy5oWYn19h8V3ahAtBd7L3mps7Z2aQlzei19bBOGsoZiswJqYPy1sfW7mD4S03led/0HrvXs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1791868569; c=relaxed/simple;
	bh=zL1W/qViDs6/p6ihbWI+s/Hpz9aAWO5kIhNiVtRgxFM=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=X/gYOY4A0fPhUXUp+Oodohq1KjoEG+oz8NWMHJmi/Ir09fiF+L2jNoKT4pjmqgIxgfBBtZUNUMLclFGEwQDQCIEFgj9VNoJeZgIzckDRH4qO8dKnYyZ+BDPbBujDbTxtVh1YNWyWoV83IyV8SQUCdOGoHz9DQGrH+UMiLLz7Gys=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.microsoft.com; spf=pass smtp.mailfrom=linux.microsoft.com; dkim=pass (1024-bit key) header.d=linux.microsoft.com header.i=@linux.microsoft.com header.b=lx1d1nIh; arc=none smtp.client-ip=13.77.154.182
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.microsoft.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.microsoft.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux.microsoft.com header.i=@linux.microsoft.com header.b="lx1d1nIh"
Received: from mac.lan (unknown [4.194.122.162])
	by linux.microsoft.com (Postfix) with ESMTPSA id BEDBE20B7166;
	Mon, 12 Oct 2026 22:15:58 -0700 (PDT)
DKIM-Filter: OpenDKIM Filter v2.11.0 linux.microsoft.com BEDBE20B7166
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linux.microsoft.com;
	s=default; t=1791868564;
	bh=LIE+gH2MlvhH5aslepJ+OssT9+tebEO1hNcLMoTf5qs=;
	h=From:To:Cc:Subject:Date:From;
	b=lx1d1nIhicb8wAFe946F65ltziTWOVdXZC/x+pzogeX6ycRGbaEDK5GDQ/MeQcDp4
	 t69lLMTqqTuhQdL3QNLNMY7Bg2UrtNsYcsga/MfefPv6fN4YtezQb0xkbiKL/c3JtX
	 vThpHJYeyaGmWZ6U/sDJ6DgQ58GEhn/ws3N30lhI=
From: "Cen Zhang (Microsoft)" <cenzhang@linux.microsoft.com>
To: Dmitry Torokhov <dmitry.torokhov@gmail.com>
Cc: Kees Cook <kees@kernel.org>,
	Mikhail Gavrilov <mikhail.v.gavrilov@gmail.com>,
	Hillf Danton <hdanton@sina.com>,
	linux-input@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	stable@vger.kernel.org,
	AutonomousCodeSecurity@microsoft.com,
	Francis Perron <francis@akrites.dev>,
	tgopinath@linux.microsoft.com,
	Cen Zhang <cenzhang@linux.microsoft.com>
Subject: [PATCH] Input: uinput - fix use-after-free of FF requests in ioctl handlers
Date: Tue, 13 Oct 2026 01:15:53 -0400
Message-ID: <20261013051553.71887-1-cenzhang@linux.microsoft.com>
X-Mailer: git-send-email 2.55.0
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

uinput_request_find() reads udev->requests[id] without holding
requests_lock, and the UI_BEGIN_FF_* / UI_END_FF_* ioctl handlers then
keep using the pointer it returned: the BEGIN handlers copy data out of
the request (including *req->u.upload.effect, which points into the
evdev caller's stack), the END handlers set req->retval and call
complete(&req->done).

The problem is that the request is a local variable of the task
sleeping in uinput_request_submit(). Once that task wakes up it clears
the slot and returns, and the request is gone. It can wake up at any
time as far as the ioctl handler is concerned: another UI_END_FF_* may
have completed it already, uinput_flush_requests() may have completed
it because the device is being destroyed, or the 30 second timeout may
have expired. If that happens after the lookup, the handler ends up
reading from and writing to a stack frame that no longer exists, and
complete() then tries to take a spinlock that contains whatever the
stack was reused for.

An easy-to-hit case: two processes sharing a uinput fd and both issuing
UI_END_FF_UPLOAD for the same request id crash a KASAN kernel within
seconds.

  Oops: general protection fault, probably for non-canonical address
    0xdffffc0000000001: 0000 [#1] SMP KASAN NOPTI
  KASAN: null-ptr-deref in range [0x0000000000000008-0x000000000000000f]
  RIP: 0010:complete+0x95/0x260
  Call Trace:
   uinput_ioctl_handler.isra.0+0x4b7/0x1a40
   __x64_sys_ioctl+0x184/0x1d0

Fix by holding requests_lock from the lookup until we are done with
the request, similar to what uinput_flush_requests() already does.
uinput_request_release_slot() takes that lock too, so the submitter
can not release the slot (and return) while a handler is still using
the request. Once the slot is released, a lookup can no longer return
the expired request.

To keep copy_to_user()/copy_from_user() out of the locked region, the
part of each handler that touches the request is moved into a small
helper that runs under the lock.

Fixes: 6b4877c7bdc6 ("Input: uinput - avoid crash when sending FF request to device going away")
Fixes: 8e009118a45a ("Input: uinput - allow FF requests to time out")
Cc: stable@vger.kernel.org
Cc: Francis Perron <francis@akrites.dev>
Reported-by: Hillf Danton <hdanton@sina.com>
Closes: https://lore.kernel.org/all/20240521113619.2092-1-hdanton@sina.com/
Reported-by: AutonomousCodeSecurity@microsoft.com
Assisted-by: LLM
Signed-off-by: Cen Zhang (Microsoft) <cenzhang@linux.microsoft.com>
---
 drivers/input/misc/uinput.c | 110 ++++++++++++++++++++++++------------
 1 file changed, 73 insertions(+), 37 deletions(-)

diff --git a/drivers/input/misc/uinput.c b/drivers/input/misc/uinput.c
index d32fa4b508fc..1a294f4e941b 100644
--- a/drivers/input/misc/uinput.c
+++ b/drivers/input/misc/uinput.c
@@ -119,16 +119,80 @@ static bool uinput_request_alloc_id(struct uinput_device *udev,
 	return reserved;
 }
 
+/*
+ * Find an input request, by ID. Returns NULL if the ID isn't valid.
+ * Requests live on their submitter's stack, so the caller must hold
+ * requests_lock while using the result.
+ */
 static struct uinput_request *uinput_request_find(struct uinput_device *udev,
 						  unsigned int id)
 {
-	/* Find an input request, by ID. Returns NULL if the ID isn't valid. */
+	lockdep_assert_held(&udev->requests_lock);
+
 	if (id >= UINPUT_NUM_REQUESTS)
 		return NULL;
 
 	return udev->requests[id];
 }
 
+static int uinput_ff_upload_begin(struct uinput_device *udev,
+				  struct uinput_ff_upload *ff_up)
+{
+	struct uinput_request *req;
+
+	guard(spinlock)(&udev->requests_lock);
+
+	req = uinput_request_find(udev, ff_up->request_id);
+	if (!req || req->code != UI_FF_UPLOAD || !req->u.upload.effect)
+		return -EINVAL;
+
+	ff_up->retval = 0;
+	ff_up->effect = *req->u.upload.effect;
+	if (req->u.upload.old)
+		ff_up->old = *req->u.upload.old;
+	else
+		memset(&ff_up->old, 0, sizeof(ff_up->old));
+
+	return 0;
+}
+
+static int uinput_ff_erase_begin(struct uinput_device *udev,
+				 struct uinput_ff_erase *ff_erase)
+{
+	struct uinput_request *req;
+
+	guard(spinlock)(&udev->requests_lock);
+
+	req = uinput_request_find(udev, ff_erase->request_id);
+	if (!req || req->code != UI_FF_ERASE)
+		return -EINVAL;
+
+	ff_erase->retval = 0;
+	ff_erase->effect_id = req->u.effect_id;
+
+	return 0;
+}
+
+static int uinput_ff_request_end(struct uinput_device *udev,
+				 unsigned int id, unsigned int code, int retval)
+{
+	struct uinput_request *req;
+
+	guard(spinlock)(&udev->requests_lock);
+
+	req = uinput_request_find(udev, id);
+	if (!req || req->code != code)
+		return -EINVAL;
+
+	if (code == UI_FF_UPLOAD && !req->u.upload.effect)
+		return -EINVAL;
+
+	req->retval = retval;
+	complete(&req->done);
+
+	return 0;
+}
+
 static int uinput_request_reserve_slot(struct uinput_device *udev,
 				       struct uinput_request *request)
 {
@@ -913,7 +977,6 @@ static long uinput_ioctl_handler(struct file *file, unsigned int cmd,
 	struct uinput_device	*udev = file->private_data;
 	struct uinput_ff_upload ff_up;
 	struct uinput_ff_erase  ff_erase;
-	struct uinput_request   *req;
 	char			*phys;
 	const char		*name;
 	unsigned int		size;
@@ -1011,19 +1074,9 @@ static long uinput_ioctl_handler(struct file *file, unsigned int cmd,
 		if (retval)
 			goto out;
 
-		req = uinput_request_find(udev, ff_up.request_id);
-		if (!req || req->code != UI_FF_UPLOAD ||
-		    !req->u.upload.effect) {
-			retval = -EINVAL;
+		retval = uinput_ff_upload_begin(udev, &ff_up);
+		if (retval)
 			goto out;
-		}
-
-		ff_up.retval = 0;
-		ff_up.effect = *req->u.upload.effect;
-		if (req->u.upload.old)
-			ff_up.old = *req->u.upload.old;
-		else
-			memset(&ff_up.old, 0, sizeof(struct ff_effect));
 
 		retval = uinput_ff_upload_to_user(p, &ff_up);
 		goto out;
@@ -1034,14 +1087,10 @@ static long uinput_ioctl_handler(struct file *file, unsigned int cmd,
 			goto out;
 		}
 
-		req = uinput_request_find(udev, ff_erase.request_id);
-		if (!req || req->code != UI_FF_ERASE) {
-			retval = -EINVAL;
+		retval = uinput_ff_erase_begin(udev, &ff_erase);
+		if (retval)
 			goto out;
-		}
 
-		ff_erase.retval = 0;
-		ff_erase.effect_id = req->u.effect_id;
 		if (copy_to_user(p, &ff_erase, sizeof(ff_erase))) {
 			retval = -EFAULT;
 			goto out;
@@ -1054,15 +1103,8 @@ static long uinput_ioctl_handler(struct file *file, unsigned int cmd,
 		if (retval)
 			goto out;
 
-		req = uinput_request_find(udev, ff_up.request_id);
-		if (!req || req->code != UI_FF_UPLOAD ||
-		    !req->u.upload.effect) {
-			retval = -EINVAL;
-			goto out;
-		}
-
-		req->retval = ff_up.retval;
-		complete(&req->done);
+		retval = uinput_ff_request_end(udev, ff_up.request_id,
+					       UI_FF_UPLOAD, ff_up.retval);
 		goto out;
 
 	case UI_END_FF_ERASE:
@@ -1071,14 +1113,8 @@ static long uinput_ioctl_handler(struct file *file, unsigned int cmd,
 			goto out;
 		}
 
-		req = uinput_request_find(udev, ff_erase.request_id);
-		if (!req || req->code != UI_FF_ERASE) {
-			retval = -EINVAL;
-			goto out;
-		}
-
-		req->retval = ff_erase.retval;
-		complete(&req->done);
+		retval = uinput_ff_request_end(udev, ff_erase.request_id,
+					       UI_FF_ERASE, ff_erase.retval);
 		goto out;
 	}
 
-- 
2.55.0

