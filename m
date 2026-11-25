Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=100.103.45.18
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1795609417;
	b=SFBs7Qb7uDcfcJw34M4Bz3b3T+/bugNYVfT88D5K2tUy3kJycrFwbHOJvYzcY4IB5V+l
	 mGsIgPAMfN/xb4nrHDlP9TxTp6EMiassR8A1+yw35/UC4MpLddOp+1XUjhgT0EvrK5nHv
	 bGjZDQhpwllv3N8/xnzI7OvnCqUJ/DrVNCYj9F5uoDyTydUkY3eaWEed4dP6nG2QSG9Ba
	 +IuKeLohTqS9kUDEr17F+md7aNL4gZy5DFsk9aHsnTAkJCeXKFn9a6vovtukeilvMRRzF
	 UbDF+WkWFATrWdGlgWOioVKgvWzMEO25Bk9CClcjEXwkXcizKdxKavplPmdzk9KAP5Q==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1795609417;
	h=Received:DKIM-Signature:Subject:To:Cc:From:Date:Message-ID:
	 MIME-Version:Content-Type:Content-Transfer-Encoding;
	bh=PooGKXx7luGlvBAxDmMNH90fhM0kc1UE8TsEEXO9qtI=;
	b=sVUMOFJ1kuWbG6ixf3rPveZgJfelPtyhdYIcWXO2O0yE8o2/6PM02xbQpNGh1NbWAi40
	 2DMVNGR96EHV+t8LobUUkPUqpDXVs5HASOh0cxbiKLGA1P4Z0xHSZpv81NBZJx9aJk/32
	 rfFXKPYqKio2j6l0Rp0YPFBt9z2hvOVBErEcvDnc1yInR2Ab/GX8258btclByo26xUUcq
	 yHaP4f/EdoLzZAuooPfdbHtQiiGQoDxmq7LGZRZUrHtHW+B4mU66eiNXw87do6VqeBXdb
	 eC+v2pAIlsLoK01EkxF3DLsMQ+qGrmJyiHN5Alz1FUiLDZZALEPL+TXmoa5MHH3gtDA==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dkim=pass header.d=linuxfoundation.org header.i=@linuxfoundation.org header.a=rsa-sha256 header.s=korg header.b=K1qEG3gk;
	arc=none smtp.remote-ip=100.103.45.18
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0B81C606A33A
	for <stable@vger.kernel.org>; Wed, 25 Nov 2026 12:23:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.a=rsa-sha256 header.s=korg header.b=K1qEG3gk
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 466C81F000CF;
	Wed, 25 Nov 2026 12:23:36 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linuxfoundation.org;
	s=korg; t=1795609416;
	bh=PooGKXx7luGlvBAxDmMNH90fhM0kc1UE8TsEEXO9qtI=;
	h=Subject:To:Cc:From:Date;
	b=K1qEG3gkbSs38LiLMADc86CLEvhlzFMXRv5KVQFdoiHdubsxnHlxrqnceGQvI4P02
	 c7lBtXa9HZe7UFx9SAWyfmBKC059FUo2i9ciVPUY6tDlHJ1hHnVTG6A7kF2uG3j3tj
	 gC6gsLMRgmqawsZNqNcqbzUOL+Dx//gPMqR07eUI=
Subject: FAILED: patch "[PATCH] drm/amdgpu/mes: skip unmap queue notification during GPU" failed to apply to 7.3-stable tree
To: Prike.Liang@amd.com,alexander.deucher@amd.com,jinhuieric.huang@amd.com
Cc: <stable@vger.kernel.org>
From: <gregkh@linuxfoundation.org>
Date: Wed, 25 Nov 2026 13:15:54 +0100
Message-ID: <2026112554-easeful-grove-7e8f@gregkh>
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Post: <mailto:stable@vger.kernel.org>
List-Help: <mailto:stable+help@vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
List-Owner: <mailto:stable+owner@vger.kernel.org>
Precedence: list
MIME-Version: 1.0
Content-Type: text/plain; charset=ANSI_X3.4-1968
Content-Transfer-Encoding: 8bit


The patch below does not apply to the 7.3-stable tree.
If someone wants it applied there, or to any other stable or longterm
tree, then please email the backport, including the original git commit
id to <stable@vger.kernel.org>.

To reproduce the conflict and resubmit, you may use the following commands:

git fetch https://git.kernel.org/pub/scm/linux/kernel/git/stable/linux.git/ linux-7.3.y
git checkout FETCH_HEAD
git cherry-pick -x dcae66f5b9fe539e897aacca8e28bfe802478095
# <resolve conflicts, build, test, etc.>
git commit -s
git send-email --to '<stable@vger.kernel.org>' --in-reply-to '2026112554-easeful-grove-7e8f@gregkh' --subject-prefix 'PATCH 7.3.y' 'HEAD^..'

Possible dependencies:



thanks,

greg k-h

------------------ original commit in Linus's tree ------------------

From dcae66f5b9fe539e897aacca8e28bfe802478095 Mon Sep 17 00:00:00 2001
From: Prike Liang <Prike.Liang@amd.com>
Date: Tue, 13 Oct 2026 12:54:13 +0800
Subject: [PATCH] drm/amdgpu/mes: skip unmap queue notification during GPU
 reset

amdgpu_mes_userq_notify_unmap_work_handler() submits a MES misc op
without holding reset_domain->sem, so it can ring the MES doorbell while
the GPU is being reset:

  WARNING: amdgpu_device.c:928 at amdgpu_device_skip_hw_access+0x73/0x90 [amdgpu]
  Workqueue: events amdgpu_mes_userq_notify_unmap_work_handler [amdgpu]
  Call Trace:
   amdgpu_mm_wdoorbell64+0x20/0x70 [amdgpu]
   mes_v11_0_ring_set_wptr+0x71/0x80 [amdgpu]
   amdgpu_ring_commit+0x5b/0xa0 [amdgpu]
   mes_v11_0_submit_pkt_and_poll_completion.constprop.0+0x207/0x520 [amdgpu]
   mes_v11_0_misc_op+0x8b/0x240 [amdgpu]
   amdgpu_mes_notify_unmap_queue+0xa3/0x110 [amdgpu]
   amdgpu_mes_userq_notify_unmap_work_handler+0x24/0x70 [amdgpu]

Only send the notification when reset_domain->sem can be trylocked. The
work re-arms itself while the HW queues are oversubscribed, so the
notification is retried once the reset has finished.

Fixes: c0431e1aecdb ("drm/amdgpu/userq: create the same workaround of oversubscription timer")
Signed-off-by: Prike Liang <Prike.Liang@amd.com>
Cc: Eric Huang <jinhuieric.huang@amd.com>
Reviewed-by: Eric Huang <jinhuieric.huang@amd.com>
Signed-off-by: Alex Deucher <alexander.deucher@amd.com>
(cherry picked from commit 6c7eee33c1487ed68a41d9d0a5bd932ad32b15d1)
Cc: stable@vger.kernel.org

diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_mes.c b/drivers/gpu/drm/amd/amdgpu/amdgpu_mes.c
index 8d813c68450b..384510c343cd 100644
--- a/drivers/gpu/drm/amd/amdgpu/amdgpu_mes.c
+++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_mes.c
@@ -1191,7 +1191,11 @@ static void amdgpu_mes_userq_notify_unmap_work_handler(struct work_struct *work)
 					       userq_notify_unmap_work.work);
 	struct amdgpu_device *adev = mes->adev;
 
-	amdgpu_mes_notify_unmap_queue(adev);
+	/* MES is unusable during GPU recovery; the re-arm below retries later */
+	if (down_read_trylock(&adev->reset_domain->sem)) {
+		amdgpu_mes_notify_unmap_queue(adev);
+		up_read(&adev->reset_domain->sem);
+	}
 
 	/* Re-arm if still oversubscribed */
 	if (atomic_read(&mes->userq_hw_queue_count) >

