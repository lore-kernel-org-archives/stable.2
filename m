Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=100.103.45.18
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1794045751;
	b=bX0TT2QHKBiUVYRAXPZVMYNAdHar6kNrA3lu/qz5p1ujfGCX67oC03oPgkfbl4cAA448
	 a1Hm0EtrrBujlHuChS1SV2g4umZZM23qHcd03Ni6+Dq7u7Y0TBNLtcHa9eVJ0ylHdw2qR
	 aL2dMYFxULup/R8qCv6jtURCYhzOaaliNRe4sLwvFp29OYPXUh4G1UdMYIrgqnbIyUcli
	 pc8TN6i0t5lJA8GAGsLidyrcNEKvkxxV980gj7tfb7q/8UYaPdOVFId+5JY0iI8850hOh
	 O5GTEUAXznF1YHw94UxOc1unmSciGM5xMlcopEmm+EWjqDiIgfPFDi0Bcn1/BpQy3iw==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1794045751;
	h=Received:DKIM-Signature:From:To:Cc:Subject:Date:Message-ID:X-Mailer:
	 MIME-Version:Content-Type:Content-Transfer-Encoding;
	bh=uCsyGBgVc/4/r+plzA1l7SwnRfV0lxH45JBXeLxvWKo=;
	b=vEJW1OLvscERiJ15dFUZIHdfWiIHpXgCJNMNodT1Q+jgZwIY1sIofSKrkkZr8jZ1MBvp
	 NuTQX09kbRtsvxkFRYY1/050aMmJalECDrjXNODw2pVmfIIBt5CcS8zfY639SKQB3bSvZ
	 U3olrBrqtNDFnFEYbt7p6NuaX14xJvns4Pdv0ZAHJ+05ZFZ45K3hCvL9vslSc53nTUvPh
	 XDg3wjL3HboivaTQtQQFN/vNpKiqdV9kdPah4YFeHgkF/mmAQQ7KFSXVjZGXej/3vhPPy
	 qrXI7oY26Jq+dGsw9F99olo1sSxxsw6+aopvSCbIp0w8T2VNIWnrB/c2ZmUOZejvsQQ==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dkim=pass header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=G06kVdKQ;
	arc=none smtp.remote-ip=100.103.45.18
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 55205606A326
	for <stable@vger.kernel.org>; Sat,  7 Nov 2026 10:02:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=G06kVdKQ
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 76D141F008A1;
	Sat,  7 Nov 2026 10:02:30 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1794045750;
	bh=uCsyGBgVc/4/r+plzA1l7SwnRfV0lxH45JBXeLxvWKo=;
	h=From:To:Cc:Subject:Date;
	b=G06kVdKQ64boG93vEqNx/T5J7yS3oSnLB+L2eoPqMThFLLpPrBu8SkQ8qMVaD72CP
	 Jw6lVJsvNqchNMPBkEiHgnzj4rY3s39w0LIKSPgkhNRyrlQJJ0SKwNB+G248qibtyU
	 xM5pKCatIQ9QlD1uqZVNZSSEj7sL2wQIbS4k5vkCW4EX2bVMeXUK7S4mhsdGFT6RGd
	 OwZv07SyitAosCjQPgSeUzec2DeofvMBtci3sA2JO3EVWMlaXcIPGPHd24leme8uxx
	 2vddLrfhZo4SslhQJsMESpP9Znbvdo7IwY5qLKOSlCA9feF98la9G7Dy/fTIjT9RKD
	 VLQk4BdOVz7fQ==
From: Sasha Levin <sashal@kernel.org>
To: matthew.brost@intel.com,
	stuart.summers@intel.com
Cc: stable@vger.kernel.org
Subject: FAILED: patch "[PATCH] drm/xe: Order ring writes before ring tail updates" failed to apply to 7.3-stable tree
Date: Sat,  7 Nov 2026 05:02:29 -0500
Message-ID: <20261107050229-failed-7.3-136360290f31@kernel.org>
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

The patch below does not apply to the 7.3-stable tree.
If someone wants it applied there, or to any other stable or longterm
tree, then please email the backport, including the original git commit
id to <stable@vger.kernel.org>.

To reproduce the conflict and resubmit, you may use the following commands:

git fetch https://git.kernel.org/pub/scm/linux/kernel/git/stable/linux.git/ linux-7.3.y
git checkout FETCH_HEAD
git cherry-pick -x 136360290f314890428a3fbf31aaa8e4f1d43567
# <resolve conflicts, build, test, etc.>
git commit -s
git send-email --to '<stable@vger.kernel.org>' --in-reply-to '20261107050229-failed-7.3-136360290f31@kernel.org' --subject-prefix 'PATCH 7.3.y' 'HEAD^..'

Thanks,
Sasha

------------------ original commit in Linus's tree ------------------

From 136360290f314890428a3fbf31aaa8e4f1d43567 Mon Sep 17 00:00:00 2001
From: Matthew Brost <matthew.brost@intel.com>
Date: Fri, 7 Aug 2026 10:17:16 -0700
Subject: [PATCH] drm/xe: Order ring writes before ring tail updates

The ring buffer and the LRC context image are both mapped WC, so the ring
tail update can become visible to the device before the ring contents it
is meant to publish.

The GuC CT send does contain an xe_device_wmb(), so sending the H2G would
flush the ring contents. The problem is that it comes too late:
xe_lrc_set_ring_tail() publishes the tail before the H2G is sent, and the
device samples the tail from the context image independently of it, either
at context switch-in or while the context is already resident. A submitter
which is interrupted between updating the tail and sending its H2G
therefore leaves the device free to observe the new tail while the ring
contents behind it are not yet visible:

  1. Thread A emits a job into the ring, sets the tail to T_A and sends
     the H2G, which flushes A's ring contents. The GuC starts scheduling
     the context in, but it is not executing yet.
  2. Thread B emits a job into ring[T_A..T_B]. Those writes are not yet
     visible to the device.
  3. Thread B updates the ring tail to T_B. That write targets a
     different page and becomes visible first.
  4. Thread B is interrupted before it sends its H2G, so the flush which
     would have published ring[T_A..T_B] has not happened yet.
  5. The context is switched in and samples the ring tail from the
     context image, picking up T_B rather than T_A.
  6. The GPU executes A's job, advances HEAD to T_A, and continues on to
     ring[T_A..T_B], which still holds the previous wrap's contents, so
     the CS parses stale commands.

The result is command stream corruption, which typically manifests as a
hang or a spurious pagefault rather than anything that points back at the
submission path.

Kernel jobs are by far the most likely to hit this. Kernel queues such as
the migration queue are shared and can be driven by many threads
concurrently, producing back-to-back submissions on an LRC which is
already executing. User queues are typically tied to a single submitting
thread, so the same interleaving is much harder to produce.

Add an xe_device_wmb() at the end of xe_lrc_write_ring() so that it covers
every ring tail publication site, and so the invariant is local: once
xe_lrc_write_ring() returns, the ring contents are visible to the device.

Fixes: dd08ebf6c352 ("drm/xe: Introduce a new DRM driver for Intel GPUs")
Closes: https://gitlab.freedesktop.org/drm/xe/kernel/-/work_items/8651
Closes: https://gitlab.freedesktop.org/drm/xe/kernel/-/work_items/7810
Cc: stable@vger.kernel.org
Signed-off-by: Matthew Brost <matthew.brost@intel.com>
Assisted-by: GitHub_Copilot:claude-opus-5
Reviewed-by: Stuart Summers <stuart.summers@intel.com>
Link: https://patch.msgid.link/20260807171716.140475-1-matthew.brost@intel.com
---
 drivers/gpu/drm/xe/xe_lrc.c | 7 +++++++
 1 file changed, 7 insertions(+)

diff --git a/drivers/gpu/drm/xe/xe_lrc.c b/drivers/gpu/drm/xe/xe_lrc.c
index 3e7c995085d05..a0855648d1552 100644
--- a/drivers/gpu/drm/xe/xe_lrc.c
+++ b/drivers/gpu/drm/xe/xe_lrc.c
@@ -1849,6 +1849,13 @@ void xe_lrc_write_ring(struct xe_lrc *lrc, const void *data, size_t size)
 
 		__xe_lrc_write_ring(lrc, ring, &noop, sizeof(noop));
 	}
+
+	/*
+	 * The ring and the LRC context image are both WC, so the ring tail
+	 * update which publishes these writes can become visible to the device
+	 * first. Ensure the ring contents are visible before returning.
+	 */
+	xe_device_wmb(xe);
 }
 
 u64 xe_lrc_descriptor(struct xe_lrc *lrc)
-- 
2.53.0




