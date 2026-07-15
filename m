Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 368E243FD22
	for <stable@vger.kernel.org>; Wed, 15 Jul 2026 10:24:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1784111067; cv=none; b=L7+CHVNS+FFyHF6X6JDkM3jGWloVV7u3myHBHK0Y4Xa+pym6423JKj/xZ84ZeJ8PUn7QGXgvDFIvGIsqkZSuSxduGCxKfqGhI1+MpaizCH5exK4l17GLsz1YSY1BADARZrDTK/+6trr45p/M3ZWH0zFl9VrqVkBq/YWn+Un3eIg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1784111067; c=relaxed/simple;
	bh=+zbpihkq+w7C7BlsHTYvCuF7d+DU2vcZYeI8RoJP/LI=;
	h=Subject:To:Cc:From:Date:Message-ID:MIME-Version:Content-Type; b=VEYWesDytAuqDiKR79JeW/R4vkbuFB4XvM1IXOJ6vLhVMadyLdAnYbof+7SVIxIhv5y6o3YhlMSPIUUXIWrAUgUyYaYx4Gj3Ud2SDf0qSdeWYz6/VnELn+lZcfc5gHiKAObPmQp6cVudpwuQGRTP81IUOqJP0LTdQlb++syG38s=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b=ds4gnpoI; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b="ds4gnpoI"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 9371F1F000E9;
	Wed, 15 Jul 2026 10:24:25 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linuxfoundation.org;
	s=korg; t=1784111066;
	bh=QQs0ifqpjHGNXNurFKOwbbEbH1kveye8ml+gG1lhkME=;
	h=Subject:To:Cc:From:Date;
	b=ds4gnpoIE+Zu9I27D6J2pZZW4K+dZ5/vxFboxKH5SrCW/Ge4MgHZBwTQfLkC6ts1y
	 j2arz91ws+nMKAXK68v3oPmfHI2Uv7Qr0m7lEoGaX6wAGHtaBG/tBZkrivnSbyGpXq
	 N/avqi/DjVPi9kpFGFr9AGCAocQIvJJHN6EE4AUg=
Subject: FAILED: patch "[PATCH] nvmet: fix pre-auth out-of-bounds heap read in Discovery Get" failed to apply to 5.15-stable tree
To: hexlabsecurity@proton.me,hch@lst.de,kbusch@kernel.org,kch@nvidia.com
Cc: <stable@vger.kernel.org>
From: <gregkh@linuxfoundation.org>
Date: Wed, 15 Jul 2026 12:20:41 +0200
Message-ID: <2026071541-variably-lion-7934@gregkh>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=ANSI_X3.4-1968
Content-Transfer-Encoding: 8bit


The patch below does not apply to the 5.15-stable tree.
If someone wants it applied there, or to any other stable or longterm
tree, then please email the backport, including the original git commit
id to <stable@vger.kernel.org>.

To reproduce the conflict and resubmit, you may use the following commands:

git fetch https://git.kernel.org/pub/scm/linux/kernel/git/stable/linux.git/ linux-5.15.y
git checkout FETCH_HEAD
git cherry-pick -x 53cd102a7a56079b11b897835bd9b94c14e6322c
# <resolve conflicts, build, test, etc.>
git commit -s
git send-email --to '<stable@vger.kernel.org>' --in-reply-to '2026071541-variably-lion-7934@gregkh' --subject-prefix 'PATCH 5.15.y' 'HEAD^..'

Possible dependencies:



thanks,

greg k-h

------------------ original commit in Linus's tree ------------------

From 53cd102a7a56079b11b897835bd9b94c14e6322c Mon Sep 17 00:00:00 2001
From: Bryam Vargas <hexlabsecurity@proton.me>
Date: Wed, 27 May 2026 15:00:00 -0500
Subject: [PATCH] nvmet: fix pre-auth out-of-bounds heap read in Discovery Get
 Log Page

nvmet_execute_disc_get_log_page() validates only the dword alignment
of the host-supplied Log Page Offset (lpo).  The 64-bit offset is then
added to a small kzalloc'd buffer that holds the discovery log page
and the result is passed straight to nvmet_copy_to_sgl(), which
memcpy()s data_len bytes out to the host with no source-side bound
check:

    u64 offset      = nvmet_get_log_page_offset(req->cmd);  /* 64-bit host */
    size_t data_len = nvmet_get_log_page_len(req->cmd);     /* 32-bit host */
    ...
    if (offset & 0x3) { ... }                               /* only check */
    ...
    alloc_len = sizeof(*hdr) + entry_size * discovery_log_entries(req);
    buffer = kzalloc(alloc_len, GFP_KERNEL);
    ...
    status = nvmet_copy_to_sgl(req, 0, buffer + offset, data_len);

The Discovery controller is unauthenticated -- nvmet_host_allowed()
returns true unconditionally for the discovery subsystem -- so the call
is reachable pre-authentication by any TCP/RDMA/FC peer that can reach
the nvmet target.  With a discovery log page of ~1 KiB, an attacker
requesting up to 4 KiB starting at offset == alloc_len reads the next
slab page out and gets its content returned over the fabric (an
empirical run on a default nvmet-tcp loopback target leaked 81
canonical kernel pointers in one Get Log Page response).  Pointing the
offset at unmapped kernel memory faults the in-kernel memcpy and
crashes (or panics, on panic_on_oops=1) the target host instead.

The attacker-controlled source-side offset pattern
"nvmet_copy_to_sgl(req, 0, buffer + ATTACKER_OFFSET, ...)" is unique
to nvmet_execute_disc_get_log_page in the entire nvmet codebase: every
other Get Log Page handler in admin-cmd.c either ignores lpo (and
silently starts every response at offset 0) or tracks a local
destination offset with a fixed source pointer.

Validate the host-supplied offset against the log page size, cap the
copy length to what is actually available, and zero-fill any remainder
of the host transfer buffer.  The zero-fill matches the existing
short-response pattern in nvmet_execute_get_log_changed_ns()
(admin-cmd.c) and prevents leaking transport SGL contents when the
host asks for more bytes than the log page contains.

Fixes: a07b4970f464 ("nvmet: add a generic NVMe target")
Cc: stable@vger.kernel.org
Reviewed-by: Chaitanya Kulkarni <kch@nvidia.com>
Reviewed-by: Christoph Hellwig <hch@lst.de>
Signed-off-by: Bryam Vargas <hexlabsecurity@proton.me>
Signed-off-by: Keith Busch <kbusch@kernel.org>

diff --git a/drivers/nvme/target/discovery.c b/drivers/nvme/target/discovery.c
index e9b35549e254..114869d16a1f 100644
--- a/drivers/nvme/target/discovery.c
+++ b/drivers/nvme/target/discovery.c
@@ -166,6 +166,7 @@ static void nvmet_execute_disc_get_log_page(struct nvmet_req *req)
 	u64 offset = nvmet_get_log_page_offset(req->cmd);
 	size_t data_len = nvmet_get_log_page_len(req->cmd);
 	size_t alloc_len;
+	size_t copy_len;
 	struct nvmet_subsys_link *p;
 	struct nvmet_port *r;
 	u32 numrec = 0;
@@ -242,7 +243,27 @@ static void nvmet_execute_disc_get_log_page(struct nvmet_req *req)
 
 	up_read(&nvmet_config_sem);
 
-	status = nvmet_copy_to_sgl(req, 0, buffer + offset, data_len);
+	/*
+	 * Validate the host-supplied log page offset before copying out.
+	 * Without this check, the host controls a 64-bit byte offset into
+	 * a small kzalloc'd buffer: a value past the log page lets the
+	 * subsequent memcpy read adjacent kernel heap, and a value aimed
+	 * at unmapped kernel memory faults the in-kernel copy and crashes
+	 * the target host. The Discovery controller is unauthenticated,
+	 * so the bug is reachable from any reachable fabric peer.
+	 */
+	if (offset > alloc_len) {
+		req->error_loc =
+			offsetof(struct nvme_get_log_page_command, lpo);
+		status = NVME_SC_INVALID_FIELD | NVME_STATUS_DNR;
+		goto out_free_buffer;
+	}
+
+	copy_len = min_t(size_t, data_len, alloc_len - offset);
+	status = nvmet_copy_to_sgl(req, 0, buffer + offset, copy_len);
+	if (!status && copy_len < data_len)
+		status = nvmet_zero_sgl(req, copy_len, data_len - copy_len);
+out_free_buffer:
 	kfree(buffer);
 out:
 	nvmet_req_complete(req, status);

