Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=100.103.45.18
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1794050992;
	b=2tfulMHGz5uRVNcDBVG8HEYt6x8KW7lEt5ENBSWbpFkGoBGYErwIv6sPUd80wagruZRn
	 8LRuvDZn2FBjMNk3F2T2iH6O4AG8/DN1TDApeqUEIKQF1Sg2WvSHXOljKwxPQS37mO0tt
	 aNcWwbV9uS5qSC8yIm0PWOiJHOjvssemnX0mAGRIC0GjHwDLyw8De1/oSTHncSyI7NExn
	 ajYlH1VKGwXMo2jLrCAojHhsmF73Yx05lBEYMsDyxpoecshbjqN9rbDenQzs8qKroFte8
	 ZFTHrAvKZMHiYYFiN+0isJOVJZ0cCxTh0nwS3/C8CS3os5GzpReHw0r5ZoLSXaHUwBQ==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1794050992;
	h=Received:DKIM-Signature:From:To:Cc:Subject:Date:Message-ID:X-Mailer:
	 MIME-Version:Content-Type:Content-Transfer-Encoding;
	bh=a/42u5b2db6xrZpA8tvhkCCGG++rHs6ZypEQZcQ23GQ=;
	b=PAydi+gUQvoYSiVAQjp/mjsEBA4bHRcvUy9TEyiSkHdm2xlDVxU/H6Vi3bR2PzvIVVqV
	 /RXP35yCP2G6jOi2wwxaiy9SzbnDwSIEqEcKryqwi9yZY8dCUPML2lBqtBEGForsTckar
	 /jstUdR8WS/rl7l8dJmRxo9iM8w9EEQilxCPq/iB0Co85zhICxK9ry67oRWyx422PW9xK
	 kRxGJFgdxSWGIi6IkP0b5tvZsO+ibzbK8+BzNqEcsSt+C2OjZ7j71jS6P2bBzIiQ1+oc/
	 rkIGGQ1IUegllG4lKXESFruKT+SIVQeluDz5I/ZeovKWmdDNVcIjfKJrqPnhHNTvh/w==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dkim=pass header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=NVlGNtrt;
	arc=none smtp.remote-ip=100.103.45.18
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1ED9B606A326
	for <stable@vger.kernel.org>; Sat,  7 Nov 2026 11:29:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=NVlGNtrt
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 617781F0089F;
	Sat,  7 Nov 2026 11:29:51 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1794050992;
	bh=a/42u5b2db6xrZpA8tvhkCCGG++rHs6ZypEQZcQ23GQ=;
	h=From:To:Cc:Subject:Date;
	b=NVlGNtrtEgfVI1VhziUl0kDSGjyGFKbv5MDhyghd9hzrWVZdkqDLhGbqXSnlxH+Ug
	 DTH++LABbUYV7JUk7uArfb2VSrt3Xbc3iLJpGb1t2Y/11zPsyAw+bc3RPZMD2NwSg2
	 xoX2ozUNnEb2eovo912qheZvzEysxAoZfmYbqVa5aZfH/7ov2QClnYppHVC26jYUK9
	 AEn5JYroZOZKv5qoLh34FXGF1eqeDIZAs3AprV2+776FUiJwLASHZH9P7nmsvYH/aQ
	 TNSTRJbLbq8v1z66i6jdCAtitsPWQ8kBegvxN+wvM6UtjYlrVp7c88ei4STn2yL4Ty
	 NjD4FEhcuheKg==
From: Sasha Levin <sashal@kernel.org>
To: olivier.kaloudoff@gmail.com,
	xiaogang.chen@amd.com,
	felix.kuehling@amd.com,
	alexander.deucher@amd.com
Cc: stable@vger.kernel.org
Subject: FAILED: patch "[PATCH] drm/amdkfd: tear down KFD processes before early fini_sw on disconnect" failed to apply to 5.10-stable tree
Date: Sat,  7 Nov 2026 06:29:50 -0500
Message-ID: <20261107062950-failed-5.10-1233dd17f99c@kernel.org>
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

The patch below does not apply to the 5.10-stable tree.
If someone wants it applied there, or to any other stable or longterm
tree, then please email the backport, including the original git commit
id to <stable@vger.kernel.org>.

To reproduce the conflict and resubmit, you may use the following commands:

git fetch https://git.kernel.org/pub/scm/linux/kernel/git/stable/linux.git/ linux-5.10.y
git checkout FETCH_HEAD
git cherry-pick -x 1233dd17f99c75787a31035656ecfeff80522421
# <resolve conflicts, build, test, etc.>
git commit -s
git send-email --to '<stable@vger.kernel.org>' --in-reply-to '20261107062950-failed-5.10-1233dd17f99c@kernel.org' --subject-prefix 'PATCH 5.10.y' 'HEAD^..'

Thanks,
Sasha

------------------ original commit in Linus's tree ------------------

From 1233dd17f99c75787a31035656ecfeff80522421 Mon Sep 17 00:00:00 2001
From: Olivier Kaloudoff <olivier.kaloudoff@gmail.com>
Date: Tue, 13 Oct 2026 20:53:11 +0200
Subject: [PATCH] drm/amdkfd: tear down KFD processes before early fini_sw on
 disconnect

On surprise removal, amdgpu_device_fini_hw() calls
amdgpu_amdkfd_device_fini_sw() when pci_dev_is_disconnected() is true.
fini_sw frees kfd.dev, but KFD processes may still be alive and hold
references to it: kfd_process_destroy() dereferences kfd.dev via
kfd_processes_remove(), and svm_range_list_fini() /
kfd_process_free_outstanding_kfd_bos() touch per-device SVM state.

The kfd_processes_count wait only happens later in
kgd2kfd_teardown_processes(), called from the top-half remove path
well after fini_sw. In the observed failure the killed KFD process
(SIGBUS on unplug) stuck in D state on its exit path, so
kfd_processes_count never drained and the PCIe removal thread wedged
permanently in cond_resched(), producing soft-lockup and hung-task
splats.

Tear KFD processes down before freeing kfd.dev on the disconnect
path, and guard kgd2kfd_teardown_processes() against kfd.dev already
being gone when it runs a second time.

Cc: Xiaogang Chen <xiaogang.chen@amd.com>
Signed-off-by: Olivier Kaloudoff <olivier.kaloudoff@gmail.com>
Signed-off-by: Felix Kuehling <felix.kuehling@amd.com>
Reviewed-by: Felix Kuehling <felix.kuehling@amd.com>
Signed-off-by: Alex Deucher <alexander.deucher@amd.com>
(cherry picked from commit 836f44ba87ed7b1d83e2b7bfc788f8c6437b03a7)
Cc: stable@vger.kernel.org
---
 drivers/gpu/drm/amd/amdgpu/amdgpu_device.c | 5 ++++-
 drivers/gpu/drm/amd/amdkfd/kfd_device.c    | 9 ++++++++-
 2 files changed, 12 insertions(+), 2 deletions(-)

diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_device.c b/drivers/gpu/drm/amd/amdgpu/amdgpu_device.c
index f147c0c459da5..c65bc575a57a8 100644
--- a/drivers/gpu/drm/amd/amdgpu/amdgpu_device.c
+++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_device.c
@@ -4331,8 +4331,11 @@ void amdgpu_device_fini_hw(struct amdgpu_device *adev)
 	 * before ip_fini_early to prevent kfd locking refcount issues by calling
 	 * amdgpu_amdkfd_suspend()
 	 */
-	if (pci_dev_is_disconnected(adev->pdev))
+	if (pci_dev_is_disconnected(adev->pdev)) {
+		/* Drain KFD processes while kfd.dev is still valid */
+		amdgpu_amdkfd_teardown_processes(adev);
 		amdgpu_amdkfd_device_fini_sw(adev);
+	}
 
 	amdgpu_coredump_fini(adev);
 	amdgpu_device_ip_fini_early(adev);
diff --git a/drivers/gpu/drm/amd/amdkfd/kfd_device.c b/drivers/gpu/drm/amd/amdkfd/kfd_device.c
index bb4c6695f3cf9..0f96c9e3fa4d9 100644
--- a/drivers/gpu/drm/amd/amdkfd/kfd_device.c
+++ b/drivers/gpu/drm/amd/amdkfd/kfd_device.c
@@ -1814,7 +1814,14 @@ void kgd2kfd_teardown_processes(struct amdgpu_device *adev)
 
 	mutex_unlock(&kfd_processes_mutex);
 
-	/* wait all kfd processes use adev terminate */
+	/* kfd.dev may already be freed on surprise removal */
+	if (!adev->kfd.dev)
+		return;
+
+	/*
+	 * Wait for all KFD processes using adev to terminate. Must be
+	 * unbounded: device state is freed once they are gone.
+	 */
 	while (!!atomic_read(&adev->kfd.dev->kfd_processes_count))
 		cond_resched();
 }
-- 
2.53.0




