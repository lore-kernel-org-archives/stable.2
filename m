Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=100.103.45.18
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1794272908;
	b=OGsKIa4Qo4AxVQn1kSe/Z7A30RrcIkv219YmV+LhmOiHNy+uUmQRoK0W3u/9dvSoseqj
	 vhRTJeEUWDqXYN0xASNnEFGIhebVptz5GjMVb4VW3pzr1j1z7UsqrwOkYV+FVhsz22kMx
	 tem/xERTF9aqP31PR5N8bYG6hYJHPMv1ip7gOBok0MRE+EI+YM4V4Dox1Vf95fMwA3YXu
	 uRjYJB9P4RnS77/l0OZhYtK4oAe30VZ28DxTFOYqJonBXEUSpr+2Pk40RXenpxUzwZNuF
	 U1Cc36+ZoFn0bIZTGbliETX5BfnNY2SbQJltpZolKGl+3WHqJ6AzGVxQVIgikvCCiVw==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1794272908;
	h=Received:DKIM-Signature:From:To:Cc:Subject:Date:Message-ID:X-Mailer:
	 MIME-Version:Content-Type:Content-Transfer-Encoding;
	bh=Q32DzIPBgv2l/ezYrkMSTegKK5t8SWygjMoIi0tn3i0=;
	b=bffERl/+546jIwfxRF4lM2t95hffD0uuaQxLPjl4DmS3+F07dnU1fHt+MmSPNRA4Onmm
	 geDPux7R9OP8xZwfmKUS2m6yWHESja0GGTiD+F6z3a1N2ozl3GOGQoxh673At4mX4EmgF
	 95Xr74I+GXfjxPhySyug+JUijGLiJGlWjr3PkWJfXxJ5u25i5O0OnwajmSoBs8RtS/D66
	 r+5F5nfbM6HBpvZU7WuHkjqzWMOG6m4Nhnm40Zslz8o/UjlEC/Wet7ISIsXZWmX3jCtUu
	 /0nk2P9lPCUa74stOF1V1viGqTfcfyoApmEovb21YrLTd97CyDDUiOkbcS2aUNajp+A==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dkim=pass header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=YeuVOCnw;
	arc=none smtp.remote-ip=100.103.45.18
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 24F50606A31C
	for <stable@vger.kernel.org>; Tue, 10 Nov 2026 01:08:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=YeuVOCnw
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 728481F0089F;
	Tue, 10 Nov 2026 01:08:27 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1794272908;
	bh=Q32DzIPBgv2l/ezYrkMSTegKK5t8SWygjMoIi0tn3i0=;
	h=From:To:Cc:Subject:Date;
	b=YeuVOCnwLZoEHiASqdsnuvt7YxoybFGHhTDXfGyzXh94XgtFFxYjxZ1880pZfW0Xm
	 v+bRUX3duc75y1AuWp1ecKroQCdrHHas0MntiFZfB6pdGU/qvc3QiIx4/5RQy3VBvT
	 D08856bguH2AwLBKDdiSr8MmxkEG07J6OFoGykBJNDVMq+nhmtpm8qqZUsgTUyRhzo
	 o8vQdzLp6wYvmu3CbnY6HMUBcubDzbg03Rg5UTd6+62HSf1pY4gxVUyrFUHNzYLSeG
	 51iqigyMEp0Tla23Wt8mi3JMaVuefn7kqMvVEXEr5tHzy8M9mHVkyGRIM7OIN2p3uw
	 AVM133nBJYW/Q==
From: Sasha Levin <sashal@kernel.org>
To: shubham@octane.security,
	michael.christie@oracle.com,
	mst@redhat.com
Cc: stable@vger.kernel.org
Subject: FAILED: patch "[PATCH] vhost-scsi: zero misaligned I/O bounce pages" failed to apply to 6.12-stable tree
Date: Mon,  9 Nov 2026 20:08:26 -0500
Message-ID: <20261109200826-failed-6.12-01c3a5fa6d64@kernel.org>
X-Mailer: git-send-email 2.53.0
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Post: <mailto:stable@vger.kernel.org>
List-Help: <mailto:stable+help@vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
List-Owner: <mailto:stable+owner@vger.kernel.org>
Precedence: list
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit

The patch below does not apply to the 6.12-stable tree.
If someone wants it applied there, or to any other stable or longterm
tree, then please email the backport, including the original git commit
id to <stable@vger.kernel.org>.

To reproduce the conflict and resubmit, you may use the following commands:

git fetch https://git.kernel.org/pub/scm/linux/kernel/git/stable/linux.git/ linux-6.12.y
git checkout FETCH_HEAD
git cherry-pick -x 01c3a5fa6d641c93c7cef4fb25c5f12938316e18
# <resolve conflicts, build, test, etc.>
git commit -s
git send-email --to '<stable@vger.kernel.org>' --in-reply-to '20261109200826-failed-6.12-01c3a5fa6d64@kernel.org' --subject-prefix 'PATCH 6.12.y' 'HEAD^..'

Thanks,
Sasha

------------------ original commit in Linus's tree ------------------

From 01c3a5fa6d641c93c7cef4fb25c5f12938316e18 Mon Sep 17 00:00:00 2001
From: Shubham Antil <shubham@octane.security>
Date: Tue, 20 Oct 2026 16:25:03 +0530
Subject: [PATCH] vhost-scsi: zero misaligned I/O bounce pages

The misaligned I/O fallback copies the full bounce scatterlist to the
request buffer during completion.  If a data-in command transfers less
than requested, part of a newly allocated bounce page can remain unwritten.

Allocate bounce pages with __GFP_ZERO so all bytes copied during completion
have a defined value.  This path is already the slow fallback for
misaligned I/O, so the added initialization cost is acceptable.

Found during an LLM-assisted source audit and validated with a QEMU/KVM
vhost-scsi target using misaligned data-in commands.

Fixes: 5ced58bfa132 ("vhost-scsi: Fix alignment handling with windows")
Cc: stable@vger.kernel.org
Assisted-by: LLM (OpenAI Codex, gpt-5.6-sol)
Signed-off-by: Shubham Antil <shubham@octane.security>
Reviewed-by: Mike Christie <michael.christie@oracle.com>
Signed-off-by: Michael S. Tsirkin <mst@redhat.com>
Message-ID: <20261020105503.75904-1-shubham@octane.security>
---
 drivers/vhost/scsi.c | 7 ++++++-
 1 file changed, 6 insertions(+), 1 deletion(-)

diff --git a/drivers/vhost/scsi.c b/drivers/vhost/scsi.c
index 1a0b75cc4cefe..8b166bf5ae773 100644
--- a/drivers/vhost/scsi.c
+++ b/drivers/vhost/scsi.c
@@ -944,7 +944,12 @@ vhost_scsi_copy_iov_to_sgl(struct vhost_scsi_cmd *cmd, struct iov_iter *iter,
 	}
 
 	for_each_sgtable_sg(sg_table, sg, i) {
-		page = alloc_page(GFP_KERNEL);
+		/*
+		 * Completion copies the full bounce buffer, including bytes the
+		 * target did not write. This is already the slow fallback for
+		 * misaligned I/O, so zeroing is acceptable here.
+		 */
+		page = alloc_page(GFP_KERNEL | __GFP_ZERO);
 		if (!page) {
 			ret = -ENOMEM;
 			goto err;
-- 
2.53.0




