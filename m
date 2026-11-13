Authentication-Results: smtp.subspace.kernel.org; arc=pass header.oldest-pass=0 smtp.remote-ip=100.103.45.18
ARC-Seal: i=2; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=pass;
	t=1794596480;
	b=WynuVJhSimuGilw8UOFcA3BmI1WEmdU512TXGhUDG6ZDJ9SA4OCWJ2jWYDWD7m59zxYh
	 gbqZGLRhk5ob5+nthZkOsqBjwuwFC+LBFjOkDuxsMOhjHYsMqhFqETC8zzYWZMEXlBoRI
	 9+2M1s2fNoA+BGrbmSk6SqeCUBaSSFTPsdIdtw7vzHd4wY2IEGbUcUPzhJVzA1I6KRFJw
	 lWyxEB4thYm4cyKDBGrJ5V6z6NIF+Rqmabvxphev+aAcZkxVUBUWWW7ir8dmiN+5nCdj6
	 jev4f6bWZYm57gghvIK8zLPf6i2ttt4N+WnAMXR0ejSRAFVFT+z1gt41u+AAc4V/t/A==
ARC-Message-Signature: i=2; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1794596480;
	h=Received:DKIM-Signature:Received:From:Date:Subject:MIME-Version:
	 Content-Type:Message-Id:X-B4-Tracking:X-Change-ID:To:Cc:X-Mailer:
	 X-Developer-Signature:X-Developer-Key:X-Endpoint-Received:
	 X-Original-From:Reply-To:Content-Transfer-Encoding;
	bh=nsSfnDpbQw7dfC3kYEhB0DRn0ChvOh3fdhFKa8KvdXc=;
	b=LDAgI+8ESpYuMIHj71dQd+MZXnWBg/l6hXIwrcs7b6MS6b0jTxSVDCwhDtrLpazLcExi
	 27wIpEhy3RpXlt8gGg/sB8llc1qKmcRXk9xxAuvX2t5e3gAajhjTH0RQbqCkk33U4ETou
	 CWzLwZDHom6wNTahHMh+Z9DocWeV+qqzugKky09OSETssXKb1aKXW1ofdnsVNN9y1d4T5
	 VY+M8VPUnbsxE1GglGkdVNvZyrgiX3FCkw8wERI8MYOkVEbN1YJCy8GY3RV2lJYEW6Rzq
	 3WlVfbnsRXHgHNEFiEH/P3Cru+biKq2vATvOGo8eJs/wA9QIZsFMyati5R+WipRdPVQ==
ARC-Authentication-Results: i=2; smtp.subspace.kernel.org; 
	dkim=pass header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=FLv71mKf;
	arc=pass header.oldest-pass=0 smtp.remote-ip=100.103.45.18
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E80BF606A336;
	Fri, 13 Nov 2026 19:01:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=FLv71mKf
Authentication-Results: smtp.kernel.org; arc=none smtp.remote-ip=100.80.115.77
ARC-Seal: i=1; d=kernel.org; s=arc20260519; a=rsa-sha256; cv=none;
	t=1794596479;
	b=ozaSJ9Vmhn3mCAixPPQ6swV+IlCK06I9reBl6F3S5hnqChcBturSoxMGtytrkKgrIpUJ
	 Yw4cj/BNPYKA/k2RA27Whnh/wlAiIc/Zt1p4M/RB/breNsmJl9l+Gk/d2+QTbMTB+hG2+
	 zltJlIz7pUTy9HMObSs+fQTAo9/gmI8Z8pU1F0g322dXSi6K2DXrBviAhJgwwky15VLY3
	 jqaKvgJlWO0TsL7y3kgPyyRV46xGdyFEjTcoXF53LmkNpsiYpOL4qAREXn8UDbnmC/8V3
	 WJexdhmx2KAckUtTrHDQPJTQRnRBbJpROazXsV3jjTaShv79WZkFQ/LhbppjSt49vvw==
ARC-Message-Signature: i=1; d=kernel.org; s=arc20260519; a=rsa-sha256;
	c=relaxed/relaxed; t=1794596479;
	h=DKIM-Signature:Received:From:Date:Subject:MIME-Version:Content-Type:
	 Message-Id:X-B4-Tracking:X-Change-ID:To:Cc:X-Mailer:
	 X-Developer-Signature:X-Developer-Key:X-Endpoint-Received:
	 X-Original-From:Reply-To:Content-Transfer-Encoding;
	bh=nsSfnDpbQw7dfC3kYEhB0DRn0ChvOh3fdhFKa8KvdXc=;
	b=FRa38nK9iSTcgUTZbq+tYmkuk09WxlBSsy7gBHLekH6L8EBU/fmyABG7VFAjfnVkjMv+
	 YC3DXk/G7n+U67kG7PRlQPp0lWCy7Mm0uJiyoqXnnmQ8q42r3q4DPJhIZ/wPrWY66qYzU
	 Ly0QwQdWJoKru4CKpOvyAW588t2C6PsoKPhUAwCB9PoJ1b4RMNjb9tpOesDZ55JKFVYhm
	 VrW9olw40u0MUQOIbUJmw9hCQJiaALF0LTKHsZyUcUKP2HT0TSa+y/CXMwydl7yQODvDI
	 P7p5xXIARhlrO3557L71EfMsHalmgeGqj0W91iVbBInNHPeuWFllle6AQGrKYTpA1xw==
ARC-Authentication-Results: i=1; smtp.kernel.org; 
	arc=none smtp.remote-ip=100.80.115.77
Received: from lkml.kernel.org (nexus.subspace.kernel.org [100.80.115.77])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.kernel.org (Postfix) with ESMTPS id F02A41F000C4;
	Fri, 13 Nov 2026 19:01:18 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1794596479;
	bh=nsSfnDpbQw7dfC3kYEhB0DRn0ChvOh3fdhFKa8KvdXc=;
	h=From:Date:Subject:To:Cc:Reply-To;
	b=FLv71mKfDNEjRTdjCX9qWkZtYvZFobGa/9DY27RUnsEGLt+B39QM7GjNZsPogSvQG
	 tOoPWwUPxWYwW31zgoat/74gGiktOmB5kgOnLazrcjZJcIjuLGVn323M5mBkghQtEN
	 fCFJIOZzB9TZJfTqdWFpXgrtpXaIa8jVEPisoyPeuedMdKjYX4VnJgWgtzFp3VQ3Lh
	 MxFDbNwoUtdZVprNUOGfR4gn9/x43Ago/Dq9DUOq6G6vkso6ep+kzkMxMPypnfP4wv
	 0PY2hNkOaNY2ol3a0TgR09ivCCcOrBsi/EJZYmAgMwFET63Zf+dIbYfypCNeh7qHIa
	 q0c9aWTl5TtYA==
Received: from nexus.subspace.kernel.org (localhost [IPv6:::1])
	by lkml.kernel.org (Postfix) with ESMTP id 814DE49A75;
	Fri, 13 Nov 2026 19:01:18 +0000 (UTC)
From: Patrick Fischer via B4 Relay <devnull+admin.tsv-stahl-riesa.de@kernel.org>
Date: Fri, 13 Nov 2026 20:01:08 +0100
Subject: [PATCH] gpu: host1x: Cancel the fence when a syncpoint wait is
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
Message-Id: <20261113-upstream-host1x-fence-cancel-v1-1-89f453504222@tsv-stahl-riesa.de>
X-B4-Tracking: v=1; b=H4sIAAAAAAAC/yXMQQqDMBBA0avIrDuQSVChV5EuYhx1So2SiUUQ7
 9603Xx4m3+CchJWuFcnJH6LyhoL6FZBmH2cGGUoBmtsQ0QO901zYr/gvGqmA0eOgTH40hea3tm
 2dlSboYGy2BKPcvz23eNv3fsnh/x9wnV9AEi9W5aAAAAA
X-Change-ID: 20261113-upstream-host1x-fence-cancel-0b32753150d6
To: Thierry Reding <thierry.reding@kernel.org>, 
 Mikko Perttunen <mperttunen@nvidia.com>, David Airlie <airlied@gmail.com>, 
 Simona Vetter <simona@ffwll.ch>, Jonathan Hunter <jonathanh@nvidia.com>
Cc: Svyatoslav Ryhel <clamor95@gmail.com>, dri-devel@lists.freedesktop.org, 
 linux-tegra@vger.kernel.org, linux-kernel@vger.kernel.org, 
 stable@vger.kernel.org, Patrick Fischer <admin@tsv-stahl-riesa.de>
X-Mailer: b4 0.15.2
X-Developer-Signature: v=1; a=ed25519-sha256; t=1794596477; l=3463;
 i=admin@tsv-stahl-riesa.de; s=20261020; h=from:subject:message-id;
 bh=ma0XREdmMy4ffQO85e1k8ga8QFqtOsd1gUnED0Gj8hE=;
 b=AImcND9Q3ZBs1nzv3pd5kyP7ZjsNI4ynf7JGlkn7e2QDU+r4vkwsg/ERQOsPjn3m9xClaHAtL
 mdSJsZhynNYD/ylWY3E4gANZDqR6pT+R4sgotTBPNapj1yu34n/itpn
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

The leak was found with the help of an LLM assistant reading the host1x
and dma-fence code against the call chain in the report.

Fixes: d5179020f5ce ("gpu: host1x: External timeout/cancellation for fences")
Cc: stable@vger.kernel.org
Reported-by: Svyatoslav Ryhel <clamor95@gmail.com>
Signed-off-by: Patrick Fischer <admin@tsv-stahl-riesa.de>
---
Svyatoslav reported the out-of-memory crash, and he confirmed off-list
that this patch stops the leak on his LG P895 (Tegra30). I left out a
Tested-by so that he can give it here.

I could not test this myself: the Tegra Note 7 I work on has no
working camera path in mainline yet. Build-tested for arm and arm64.
The DRM IOCTL case in the changelog comes from reading the code; I have
not tried it.

The retry loop in tegra20_channel_capture_frame() still spins without
delay as long as the wait keeps returning -ERESTARTSYS. With this patch
that costs CPU time instead of memory; how the VI driver should handle
an interrupted wait is a separate question.

Tool use (see Documentation/process/generated-content.rst): an LLM
assistant (Claude, in a chat) found the leak by reading
host1x_syncpt_wait() and the fence code against the call chain in the
OOM report. Claude Code then checked the finding against the code and
wrote the change, the changelog and this note from my notes and
instructions. I reviewed the change.
---
 drivers/gpu/host1x/syncpt.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

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


