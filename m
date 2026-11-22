Authentication-Results: smtp.subspace.kernel.org; arc=pass header.oldest-pass=0 smtp.remote-ip=100.103.45.18
ARC-Seal: i=2; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=pass;
	t=1795338767;
	b=1Vpdc0Xq5yHte8HX0nKDFNrfSDfE/z4OW1dflU5HkQdO6qBemLhcYLvLazkGYgmjmVCs
	 40FT3qduFdTP3LqvpnDs/mpeXeE+PZMfNxT+CxRXtQo1t2XQ8na0gHQMkEBDKpIsDlqVc
	 MqQmSeELgPqfQltXM0tVt10KLrgUCfaaMPLPHtLUv8eeyMXImmnWkKPYrFh4wSDBBR1Pr
	 7JcorS8gTwrNmB1ieaR0tgUBypHcMs2Zwv/uAizLjVGZK+nJc7OxrRNlO6dr8RYbfaGwt
	 w9voH7hEvKuS9EVdJxXg6vrKK8bOBz3sNWmH2qyO39XWRHUDN7jfUPKC1/cDYOWsvPg==
ARC-Message-Signature: i=2; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1795338767;
	h=Received:DKIM-Signature:Received:From:Date:Subject:MIME-Version:
	 Content-Type:Message-Id:X-B4-Tracking:X-Change-ID:To:Cc:X-Mailer:
	 X-Developer-Signature:X-Developer-Key:X-Endpoint-Received:
	 X-Original-From:Reply-To:Content-Transfer-Encoding;
	bh=ST8IAOf43KM2cQ2CDniduzm0sEH3xm0Svex+zpATa/w=;
	b=eO8kp/BIEtynbLFRMq3h2eHZAo3iA9x3wgHZ0+umhGbSaUjqXUaRlBMxpCw9ym8+r9h7
	 Xh41pFg0sobNJlnmg4R3Gj3NUtpVcA/uKfX9vk2S246p+QQo+4yPWGm7g4cRbzp3BmoAJ
	 N66Oo14XlWbu4Efn26dp7/0qOPtkrMeh7w9kvcCAVn9Fd8AEYVui+a3TyGHm9w+Uv8ZAv
	 xMZ98EYmVNfTRUFUjgiIdGi0fxclGpzzmDGc9rIRw1PSukKwsPBtuy9/aUEZjRKoc+DOt
	 jOsKPXHdyovMNBylcQ5bgO0qq1Myh7+cR0KyIvuD0eny0uYKbFjUXvmXOGEsgenUrCw==
ARC-Authentication-Results: i=2; smtp.subspace.kernel.org; 
	dkim=pass header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=FoXi93Ta;
	arc=pass header.oldest-pass=0 smtp.remote-ip=100.103.45.18
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 279E7606A320;
	Sun, 22 Nov 2026 09:12:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=FoXi93Ta
Authentication-Results: smtp.kernel.org; arc=none smtp.remote-ip=100.80.115.77
ARC-Seal: i=1; d=kernel.org; s=arc20260519; a=rsa-sha256; cv=none;
	t=1795338766;
	b=fqmCG/pHHg0B/1Oo0bWUT2yJ0N/yOHiKUbGdhFtl41/gCiBk3fVFODWR//D8QewNjvku
	 N4PSbBsK1Ix81y1CA6WNxt+fEydRNT8nfV3f+CvRouYo9ViUwgoEmQthCZPbFm1b9Wt5l
	 4ktVo4VXVkN6VchpNmoIsSWRhhnPtNX5+m1F4fbDibjtl9do6T3cSJkWgthNL6dSosC2V
	 3/iKYxjIqeqCNHEtyMapFv11aF7Am4Nt1q4q02jYnHZdOemNhgC9lJQN+tKW0Of7t08of
	 P7PsukCCWtPx58quKZuNkmo1U8DezZycaAN/aDayr0LkcBP9zOOjejdHWLeciie6uvA==
ARC-Message-Signature: i=1; d=kernel.org; s=arc20260519; a=rsa-sha256;
	c=relaxed/relaxed; t=1795338766;
	h=DKIM-Signature:Received:From:Date:Subject:MIME-Version:Content-Type:
	 Message-Id:X-B4-Tracking:X-Change-ID:To:Cc:X-Mailer:
	 X-Developer-Signature:X-Developer-Key:X-Endpoint-Received:
	 X-Original-From:Reply-To:Content-Transfer-Encoding;
	bh=ST8IAOf43KM2cQ2CDniduzm0sEH3xm0Svex+zpATa/w=;
	b=IruL60u2fGFl6lleSj/CpR82/gO8OaTjirQ5vjFbDxoOuHrikKmlNWEMwAJY6q+QCaVU
	 AQaOLzoqIUh+NrYan4hTkae3wIqcIj3HEmIQFEons3bZ85pANh/2rPjAsj63wb1rRwnDM
	 r4ya/X6g83HXAmmrYVt0h2myLurtDi+Ey5XNAAmO0WGwLbz53ihvwMA544XS94sEVrjxA
	 SF5vpZv8HmitLiAAjxY4M/bxoYMDvSLTJ1YbzjBDtRBslcocVNJG7IztC3KyjEq6apas8
	 tjHUcRuOEkg6SPIzpo7eGMHsCCB7Qpm+ypcFl02O5t6huJzyFRQs6SIAPlJZ68lCSPg==
ARC-Authentication-Results: i=1; smtp.kernel.org; 
	arc=none smtp.remote-ip=100.80.115.77
Received: from lkml.kernel.org (nexus.subspace.kernel.org [100.80.115.77])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.kernel.org (Postfix) with ESMTPS id 186F61F000C6;
	Sun, 22 Nov 2026 09:12:46 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1795338766;
	bh=ST8IAOf43KM2cQ2CDniduzm0sEH3xm0Svex+zpATa/w=;
	h=From:Date:Subject:To:Cc:Reply-To;
	b=FoXi93Tavag8T6hgtiRwZN5ojZh0cdtjiBOLxL/QrgxR7AYMROlbCRBMiJ3VvbQs8
	 j3zlFldo3pufBOR8goqaSNkuPozDFSS3xlvOuLRGRHedOrslSssygZMebrdzB1/p2x
	 0/IAgLV6WhGn3K3aPxsu5uO2a4rNRJ5Umd13D7WFzW3nu5OZomegUPo+6f1faW3V3I
	 LAcX52k0h78TLi7/eMoQodDX1HajsTDCsa+/gK57cTCZn+Yy6ILUP+FXG/s4lNpsVT
	 rBLLLjYzUj5pRrmSHTaqnmWzkHtMFt0Pc71WAXLph3vT7dW49a4kG71tOalky9UmMC
	 mGYwF23l3xqag==
Received: from nexus.subspace.kernel.org (localhost [IPv6:::1])
	by lkml.kernel.org (Postfix) with ESMTP id 6F0074BFBD;
	Sun, 22 Nov 2026 09:12:45 +0000 (UTC)
From: Patrick Fischer via B4 Relay <devnull+admin.tsv-stahl-riesa.de@kernel.org>
Date: Sun, 22 Nov 2026 10:12:06 +0100
Subject: [PATCH v2] gpu: host1x: Cancel the fence when a syncpoint wait is
 interrupted
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Post: <mailto:stable@vger.kernel.org>
List-Help: <mailto:stable+help@vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
List-Owner: <mailto:stable+owner@vger.kernel.org>
Precedence: list
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Message-Id: <20261122-upstream-host1x-fence-cancel-v2-1-204760056348@tsv-stahl-riesa.de>
X-B4-Tracking: v=1; b=H4sIAAAAAAAC/42PSwqDMBRFtyIZ95V8TH+j7qM4iPpsUqxKXgwWc
 e9N7AY6uXDgci53ZYTeIbFbsTKP0ZEbhwTyULDGmuGJ4NrETHJ5EkIomCcKHs0b7EhBLNDh0CA
 0JmUPvFbyrJXQvD2xpJg8dm7Z9Y/qxzTXL2xCduaGdRRG/9n3o8i9P6eiAAGXa1dqpXkppbwHi
 kDB2B7yI3NskVXbtn0Bp349yuMAAAA=
X-Change-ID: 20261113-upstream-host1x-fence-cancel-0b32753150d6
To: Thierry Reding <thierry.reding@kernel.org>, 
 Mikko Perttunen <mperttunen@nvidia.com>, David Airlie <airlied@gmail.com>, 
 Simona Vetter <simona@ffwll.ch>, Jonathan Hunter <jonathanh@nvidia.com>
Cc: Svyatoslav Ryhel <clamor95@gmail.com>, dri-devel@lists.freedesktop.org, 
 linux-tegra@vger.kernel.org, linux-kernel@vger.kernel.org, 
 stable@vger.kernel.org, Patrick Fischer <admin@tsv-stahl-riesa.de>
X-Mailer: b4 0.15.2
X-Developer-Signature: v=1; a=ed25519-sha256; t=1795338764; l=5771;
 i=admin@tsv-stahl-riesa.de; s=20261020; h=from:subject:message-id;
 bh=/i8lgRDKGWyhoI9fKcpAxKGjBQNt1lXNXJJWwebXih4=;
 b=e7iObUyXdatftm1IDWTjXfcoIBLn3E6cwbef+W3mp6GEGaUUIqZi1aiGgSHW3Mbhz8dherRuA
 35+H4zg3AoYCQab/JfbQDNQpz1vSlatmqCaS4JeHTj2muwaG/UeODvu
X-Developer-Key: i=admin@tsv-stahl-riesa.de; a=ed25519;
 pk=D+v6EloYcEY9PIUHFyTM5sqcGIU/fIXzLUdkR8vjAtk=
X-Endpoint-Received: by B4 Relay for admin@tsv-stahl-riesa.de/20261020 with
 auth_id=1251
X-Original-From: Patrick Fischer <admin@tsv-stahl-riesa.de>
Reply-To: admin@tsv-stahl-riesa.de
Content-Transfer-Encoding: 7bit

From: Patrick Fischer <admin@tsv-stahl-riesa.de>

host1x_syncpt_wait() creates its fence without the internal 30 second
timeout and cancels it only when dma_fence_wait_timeout() returns 0.
If the wait is interrupted, dma_fence_wait_timeout() returns
-ERESTARTSYS and the fence is left on the syncpoint's fence list,
holding the reference that host1x_syncpt_fence_enable_signaling() took
for the interrupt path. It is freed only once the syncpoint reaches the
threshold, which may never happen.

Callers that retry on -ERESTARTSYS allocate a new fence each time.
tegra20_channel_capture_frame() retries in a loop without delay, and
while the syncpoint does not move, for example with a camera that
delivers no frames, every round leaks one fence until the system runs
out of memory. Svyatoslav Ryhel reported this as an out-of-memory crash
in the VI capture thread; the allocations in his report come from
host1x_fence_create(), called by host1x_syncpt_wait() from
tegra20_chan_capture_kthread_start(). The DRM syncpoint wait IOCTLs end
up in host1x_syncpt_wait() as well, so a process that is signalled while
waiting leaks a fence the same way.

Cancel the fence whenever the wait did not succeed. host1x_fence_cancel()
is safe if the interrupt path has signalled the fence in the meantime,
as do_fence_timeout() then returns early.

host1x_fence_cancel() can also run before signalling was enabled on the
fence. fence->list is only initialized in host1x_intr_add_fence_locked(),
so host1x_intr_remove_fence() would then see a zeroed list head, call
list_del_init() on it and report the fence as removed, after which
do_fence_timeout() drops an interrupt path reference that was never
taken. Initialize the list head in host1x_fence_create() instead.
host1x_syncpt_wait() does not hit this today, as
dma_fence_wait_timeout() enables signalling before it checks for a
pending signal, but the cancel path should not depend on that.

The leak was found with the help of an LLM assistant reading the host1x
and dma-fence code against the call chain in the report.

Fixes: d5179020f5ce ("gpu: host1x: External timeout/cancellation for fences")
Cc: stable@vger.kernel.org
Reported-by: Svyatoslav Ryhel <clamor95@gmail.com>
Signed-off-by: Patrick Fischer <admin@tsv-stahl-riesa.de>
---
Svyatoslav reported the out-of-memory crash, and he confirmed off-list
that v1 stops the leak on his LG P895 (Tegra30). v2 changes the code,
so that confirmation does not carry over to it.

I have not run v2 on hardware. The Tegra Note 7 I work on only
captures with Svyatoslav's out-of-tree VI/CSI patches, and I have not
tried to trigger an interrupted wait there. Build-tested for arm and
arm64. The DRM IOCTL case in the changelog comes from reading the code;
I have not tried it. The same goes for cancelling a fence before
signalling was enabled, which no caller does today.

The retry loop in tegra20_channel_capture_frame() still spins without
delay as long as the wait keeps returning -ERESTARTSYS. With this patch
that costs CPU time instead of memory; how the VI driver should handle
an interrupted wait is a separate question.

Tool use (see Documentation/process/generated-content.rst): an LLM
assistant (Claude, in a chat) found the leak by reading
host1x_syncpt_wait() and the fence code against the call chain in the
OOM report. Claude Code then checked the finding against the code and
wrote the change, the changelog and this note from my notes and
instructions. For v2, the chat checked Mikko's point against the code,
and Claude Code applied the change and extended the changelog. I
reviewed the change.
---
Changes in v2:
- Initialize fence->list in host1x_fence_create() instead of
  host1x_intr_add_fence_locked(), so that cancelling a fence before
  signalling was enabled is safe (Mikko Perttunen)
- Link to v1: https://patch.msgid.link/20261113-upstream-host1x-fence-cancel-v1-1-89f453504222@tsv-stahl-riesa.de
---
 drivers/gpu/host1x/fence.c  | 1 +
 drivers/gpu/host1x/intr.c   | 2 --
 drivers/gpu/host1x/syncpt.c | 2 +-
 3 files changed, 2 insertions(+), 3 deletions(-)

diff --git a/drivers/gpu/host1x/fence.c b/drivers/gpu/host1x/fence.c
index 1acf579c562b..f77a391b9195 100644
--- a/drivers/gpu/host1x/fence.c
+++ b/drivers/gpu/host1x/fence.c
@@ -134,6 +134,7 @@ struct dma_fence *host1x_fence_create(struct host1x_syncpt *sp, u32 threshold,
 	fence->sp = sp;
 	fence->threshold = threshold;
 	fence->timeout = timeout;
+	INIT_LIST_HEAD(&fence->list);
 
 	dma_fence_init(&fence->base, &host1x_syncpt_fence_ops, &sp->fences.lock,
 		       dma_fence_context_alloc(1), 0);
diff --git a/drivers/gpu/host1x/intr.c b/drivers/gpu/host1x/intr.c
index 30f3dff4487b..380f679b4d7f 100644
--- a/drivers/gpu/host1x/intr.c
+++ b/drivers/gpu/host1x/intr.c
@@ -47,8 +47,6 @@ void host1x_intr_add_fence_locked(struct host1x *host, struct host1x_syncpt_fenc
 {
 	struct host1x_fence_list *fence_list = &fence->sp->fences;
 
-	INIT_LIST_HEAD(&fence->list);
-
 	host1x_intr_add_fence_to_list(fence_list, fence);
 	host1x_intr_update_hw_state(host, fence->sp);
 }
diff --git a/drivers/gpu/host1x/syncpt.c b/drivers/gpu/host1x/syncpt.c
index fe74ff6fc6f2..f9c871f218f3 100644
--- a/drivers/gpu/host1x/syncpt.c
+++ b/drivers/gpu/host1x/syncpt.c
@@ -247,7 +247,7 @@ int host1x_syncpt_wait(struct host1x_syncpt *sp, u32 thresh, long timeout,
 		return PTR_ERR(fence);
 
 	wait_err = dma_fence_wait_timeout(fence, true, timeout);
-	if (wait_err == 0)
+	if (wait_err <= 0)
 		host1x_fence_cancel(fence);
 	dma_fence_put(fence);
 

---
base-commit: 9d66f26fefacebfeed15de31c1123451a17ff119
change-id: 20261113-upstream-host1x-fence-cancel-0b32753150d6

Best regards,
--  
Patrick Fischer <admin@tsv-stahl-riesa.de>


