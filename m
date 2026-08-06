Received: from sender-of-o57.zoho.eu (sender-of-o57.zoho.eu [136.143.169.57])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1CF9049482B;
	Thu,  6 Aug 2026 20:15:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=136.143.169.57
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1786047337; cv=pass; b=jG/3ecFMRJSbpZ+mXkR82XdTyvDkOINjEzZ5e7+3RcD9VqCaq4zaC6iIzxb0Pi/4DAHhBdWl9VdSbPlyS5TA5ZecArmH9rkwfNdLUpppX6r+wNl0Z6k6wXHOO/ffnJIt8GUsmKV8IKk15Okc+mzlIY0HBwRRJMWUz6uR33qCo0k=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1786047337; c=relaxed/simple;
	bh=MVfLlX3qBOW6qoKk3FH66N5N+j38qL8Lm+agOJDp9mo=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=oSuoc5iA7E4Zw/vk5Ln7qFUrBDSJbs02bEVBrd036X8gccrFKYBVjS7CHufEPyq/sz/0hgoAhI4tsoARHtRBPj2UhZH5YTmE2MA3dYZws5/2o9H8Bi94fPsUShuq4aoHfmwpKgrleDRrSSFFpbcX0aSj8PsIm6Dx1D3RY73B9qk=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=iusegentoo.com; spf=pass smtp.mailfrom=iusegentoo.com; dkim=pass (1024-bit key) header.d=iusegentoo.com header.i=ali@iusegentoo.com header.b=p+fIOCdo; arc=pass smtp.client-ip=136.143.169.57
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=iusegentoo.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=iusegentoo.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=iusegentoo.com header.i=ali@iusegentoo.com header.b="p+fIOCdo"
ARC-Seal: i=1; a=rsa-sha256; t=1786047310; cv=none; 
	d=zohomail.eu; s=zohoarc; 
	b=gZn0pF+H8ivks4cR7iFfzlUf7nZm/uheQ0XNQI/cItIRLF3KWI49mRjjVXfzXKg7pmrj+lVhN9+15ovMnvUzTvaX4TvrE4AyqGjNc6z63Ty7hEv0KYUGL5hxUvLvWQnwW5bDYGVMaJfNfpQg1aPqatI110DTNx0zzQjXm7t/Ha0=
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=zohomail.eu; s=zohoarc; 
	t=1786047310; h=Content-Transfer-Encoding:Cc:Cc:Date:Date:From:From:MIME-Version:Message-ID:Subject:Subject:To:To:Message-Id:Reply-To; 
	bh=EmIfLahE7z9+SYmHNT0tJ+OI261bLsPigY0gvofbqGA=; 
	b=WQzoktWjWIJZMoSGuG4BOVjcCx/EV41R0YF44UFmRbV7MtmwbsD1bhm9U1yfpb9IvmQ3yIHWtnNULq5/7zcJP+KfDlpDkPfscggEvHHv4ig+KdAIdiZovpKyPFHFTBMm7QPauCkM0+4RYKMgZ0jgzon8Ly5wY1wMXBZMtbLGzkY=
ARC-Authentication-Results: i=1; mx.zohomail.eu;
	dkim=pass  header.i=iusegentoo.com;
	spf=pass  smtp.mailfrom=ali@iusegentoo.com;
	dmarc=pass header.from=<ali@iusegentoo.com>
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; t=1786047310;
	s=zmail; d=iusegentoo.com; i=ali@iusegentoo.com;
	h=From:From:To:To:Cc:Cc:Subject:Subject:Date:Date:Message-ID:MIME-Version:Content-Transfer-Encoding:Message-Id:Reply-To;
	bh=EmIfLahE7z9+SYmHNT0tJ+OI261bLsPigY0gvofbqGA=;
	b=p+fIOCdowSJw4jHk/hWl4Xvsilldqi3jbgpvRwsnoWiF29sUze9r1CqC2sLyeC3T
	24VBGRRZEbosAFeOwmWsaJ/15CpxpO5RsBs9xJULyaRuXb0k8keRj9vhfA/YHwAIP9t
	FRmcbgc71kgb8BqMCuFb6zVBgOwaAHU7zlG9W92I=
Received: by mx.zoho.eu with SMTPS id 1786047307857787.9619546403114;
	Thu, 6 Aug 2026 22:15:07 +0200 (CEST)
From: Ali Ahmet Memis <ali@iusegentoo.com>
To: Matthew Brost <matthew.brost@intel.com>,
	"Thomas Hellstrom" <thomas.hellstrom@linux.intel.com>,
	Rodrigo Vivi <rodrigo.vivi@intel.com>,
	David Airlie <airlied@gmail.com>,
	Simona Vetter <simona@ffwll.ch>
Cc: intel-xe@lists.freedesktop.org,
	dri-devel@lists.freedesktop.org,
	linux-kernel@vger.kernel.org,
	stable@vger.kernel.org
Subject: [PATCH] drm/xe: kill the secondary bind queues on multi-GT teardown
Date: Thu,  6 Aug 2026 20:14:55 +0000
Message-ID: <20260806201455.340244-1-ali@iusegentoo.com>
X-Mailer: git-send-email 2.55.0
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-ZohoMailClient: External

xe_exec_queue_kill() walks the multi-GT list with its own cursor as the
list head:

	struct xe_exec_queue *eq = q, *next;

	list_for_each_entry_safe(eq, next, &eq->multi_gt_list,
				 multi_gt_link) {

The head expression is re-evaluated on every loop condition, and by then
eq is the cursor rather than q. multi_gt_list and multi_gt_link are two
names for the same member:

	union {
		struct list_head multi_gt_list;
		struct list_head multi_gt_link;
	};

so list_entry_is_head() compares &eq->multi_gt_link with
&eq->multi_gt_list, which is the same address, and the loop stops before
its first iteration. Modelling the layout and the list macros in a small
program shows it plainly:

	head = &eq->multi_gt_list : 0 secondary queue(s) visited
	head = &q->multi_gt_list  : 2 secondary queue(s) visited

For a VM bind queue on a multi-tile device, xe_exec_queue_create_ioctl()
creates one queue per tile and links the others behind the first, so the
loop is what is meant to stop them. Nothing else does: the two calls
after the loop only cover the primary. The secondaries are still freed,
because __xe_exec_queue_free() walks the same list with &q->multi_gt_list
and drops their references, so they go away without q->ops->kill() ever
running and without being removed from the VM with
xe_vm_remove_compute_exec_queue().

Use the primary as the head, the way the other two walks of this list in
the driver already do, in __xe_exec_queue_free() and in
xe_sync_entry_add_deps().

Single tile devices are unaffected, the list is empty there.

I have no multi-tile device, so this is from reading the code and the
program above rather than measured on hardware.

Fixes: dd08ebf6c352 ("drm/xe: Introduce a new DRM driver for Intel GPUs")
Cc: stable@vger.kernel.org
Signed-off-by: Ali Ahmet Memis <ali@iusegentoo.com>
---
The program the commit message refers to, in case it is useful. It uses
the same union layout and the list macros from include/linux/list.h:

  struct xe_exec_queue {
	int id;
	union {
		struct list_head multi_gt_list;
		struct list_head multi_gt_link;
	};
  };

  eq = &prim;
  list_for_each_entry_safe(eq, next, &eq->multi_gt_list, multi_gt_link)
	n++;			/* n == 0 */

  list_for_each_entry_safe(eq, next, &prim.multi_gt_list, multi_gt_link)
	n++;			/* n == 2 */

Compile tested only, I have no Xe device.
---
 drivers/gpu/drm/xe/xe_exec_queue.c | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/drivers/gpu/drm/xe/xe_exec_queue.c b/drivers/gpu/drm/xe/xe_exec_queue.c
index 1b5ca3ce578a..85a167857159 100644
--- a/drivers/gpu/drm/xe/xe_exec_queue.c
+++ b/drivers/gpu/drm/xe/xe_exec_queue.c
@@ -1571,9 +1571,9 @@ void xe_exec_queue_update_run_ticks(struct xe_exec_queue *q)
  */
 void xe_exec_queue_kill(struct xe_exec_queue *q)
 {
-	struct xe_exec_queue *eq = q, *next;
+	struct xe_exec_queue *eq, *next;
 
-	list_for_each_entry_safe(eq, next, &eq->multi_gt_list,
+	list_for_each_entry_safe(eq, next, &q->multi_gt_list,
 				 multi_gt_link) {
 		q->ops->kill(eq);
 		xe_vm_remove_compute_exec_queue(q->vm, eq);

base-commit: 0d839570765118029aa8bf4a95444c6a11aacf85
-- 
2.55.0

