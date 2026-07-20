Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1578E444712
	for <stable@vger.kernel.org>; Mon, 20 Jul 2026 17:15:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1784567736; cv=none; b=ifEAlSArGHXGx2NpzNDKC1grrCBZSsso22KH3mfsYfsTV79Ur+BqXGUB6J386OssqungjnSflzkEcs7Q9Y51PjNbMYapnWnBsUTjOR0gQfmkUf6ZXjjWUNDAncbUxhT7j2qONTJB8hAjaiIUKDpb5w7lpqfP00alDK++1K64dtE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1784567736; c=relaxed/simple;
	bh=lwPYy9BFwZcmcm/D7UO/+vNtsBrYb74pDgnNDZVBr6I=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=LW6oPulJpCHlSqztwy3p6I4hJ8fROtXygUgiU10jV5p9Gss6MP2XWgQUDBCDLw+FVlFCMUQEAp85Co6CMFfhZ2dEUPNQeMsCP33FdgN6HyWzQ10RE3JCOtjI8y98Whtg3YNAciqjrL8W5Y9JHmkRqMF/mmYhbmPqvIvp8SJrOsg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=NCfUxm1u; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="NCfUxm1u"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 565771F01559;
	Mon, 20 Jul 2026 17:15:30 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1784567731;
	bh=SsTIIZv5oSQrZ5tMNk7Z3PcJZHiujw7FcblCaAPcXVI=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References;
	b=NCfUxm1ugrlL8Be+JFz/TBwj6vzGXRDjm7PXfNEJVYpfmMuDH6zwMlpAKFpgg99EO
	 K+SVAZyb6ELNhbCTwAVpahEwclc0vQGOT7ItWZpz1DrVplEQ9WASszF9bjkw9bNv9x
	 EGwJBFcAyZR5wiSAsEM8YTKCamIX7/CvGu2U5SL0mu0lhr1EZ3IMpLCJOt8uHcfPNe
	 ZVy516Cprla2mOoiL4FQjCBIu8dnuMswMdhQS/iTWeEqjVfsEgSk6bJfDUg4Yxt5cA
	 n5Xy4NoZhm++HDalFY5+0em/zTPPon6UzorDoXD89p/2qwlyrmN8JwImJbb0Rnxyow
	 e8Xpdi2ascVPg==
From: Sasha Levin <sashal@kernel.org>
To: stable@vger.kernel.org
Cc: Bryam Vargas <hexlabsecurity@proton.me>,
	Chaitanya Kulkarni <kch@nvidia.com>,
	Christoph Hellwig <hch@lst.de>,
	Keith Busch <kbusch@kernel.org>,
	Sasha Levin <sashal@kernel.org>
Subject: [PATCH 6.6.y 4/4] nvmet: fix pre-auth out-of-bounds heap read in Discovery Get Log Page
Date: Mon, 20 Jul 2026 13:15:25 -0400
Message-ID: <20260720171525.2695254-4-sashal@kernel.org>
X-Mailer: git-send-email 2.53.0
In-Reply-To: <20260720171525.2695254-1-sashal@kernel.org>
References: <2026071540-stiffly-shrill-b8b3@gregkh>
 <20260720171525.2695254-1-sashal@kernel.org>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

From: Bryam Vargas <hexlabsecurity@proton.me>

[ Upstream commit 53cd102a7a56079b11b897835bd9b94c14e6322c ]

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
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 drivers/nvme/target/discovery.c | 23 ++++++++++++++++++++++-
 1 file changed, 22 insertions(+), 1 deletion(-)

diff --git a/drivers/nvme/target/discovery.c b/drivers/nvme/target/discovery.c
index af3c6793aff032..c143e7a0d36221 100644
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
@@ -239,7 +240,27 @@ static void nvmet_execute_disc_get_log_page(struct nvmet_req *req)
 
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
-- 
2.53.0

