Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=100.103.45.18
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1794048953;
	b=fG7uJbPZQ3/Ymw15ePPAQuiytynBMtDxqkhQK+z5ChQ5P3ahqd7+esAAeEiH3HmZNyX7
	 UI+hyw0dYRnsqFZQv8WENnZsyf6l5TkppZYXhAkLrkeWWsFV95oKQ5+9/4QOh/XRUsYj8
	 GFI8apPRd6CLz9xVm12g9xubrxlUovzFKzjYA8HffeMw9PUJfCKHrMEMLfAS8c3VutPLy
	 jH/Gbj0JNSI5PjREtt7lOrEswjBG4T5u6glm9zbbSIVSqRScwRB5sPucP2q/PoBBKzpTt
	 rIh/gPP+8DgW3FjCAqMycLVKi23xp33tLILDdYBEPZtPTEpbr3h8u4HzSZrwkt8KEBA==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1794048953;
	h=Received:DKIM-Signature:From:To:Cc:Subject:Date:Message-ID:X-Mailer:
	 MIME-Version:Content-Type:Content-Transfer-Encoding;
	bh=qdcar74lW+qHwaA4MOMKY1StStxuIX1MYwsewFZlxHA=;
	b=04Y9W8vFKIOs6i05qDSTkf1R17f+fiqzfu6zQBSYfQYU+jKALbao3yJ+af3o0z9rvuLP
	 w6oRUhlA0eQP6NmEhY3zvptSk4Q6g5hXKTgAG96TpX8ldyF1uSTR91dXaUsC4vP2NBSZ6
	 ktCTpOygsI105LlGbcmfyodDjE53n1IwTQbhlNilsU9pKO5DtFyCYhOS6npZCIG6J+WRZ
	 weYJlH5KU7UXqkzey1afpqeNrUNFMrNvjYyuU2AZ+ZfC+/j7VnDnmGGARMiyAmRwmZJKd
	 ieE22OJT4Mw88XvCz7qQnq7i+uUfAjmNEisCj2I27Uqh3V7fIj4zI3/gpwR0qsx7asA==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dkim=pass header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=cdb+Virj;
	arc=none smtp.remote-ip=100.103.45.18
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6785A606A32D
	for <stable@vger.kernel.org>; Sat,  7 Nov 2026 10:55:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=cdb+Virj
Received: by smtp.kernel.org (Postfix) with ESMTPSA id AB9131F008A1;
	Sat,  7 Nov 2026 10:55:52 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1794048953;
	bh=qdcar74lW+qHwaA4MOMKY1StStxuIX1MYwsewFZlxHA=;
	h=From:To:Cc:Subject:Date;
	b=cdb+Virj7ioYndAXK9vPkVk1nb96rG1aOP/VuCbgfs+9rUI+jRkwOM3nY+wL/+Nhj
	 JXdY3MyE7wUbe+kS05pxYA/4TFH86v5L54xKU+XxOy4qRIW419a3LnaZcb65mY+fk0
	 QdjgmLBS0Iv2TFnoSUQ+bTH2imXr/tKF/IhRpcfmQlst1WVmXWjvb8BQbwpqGHWIH5
	 KPwObZ3xylCBoDQnVTM1HS3JMADRGmhsb9L6CmR4JbLceGvCxmHit66DNQTL+e18E5
	 6q7NiO8hR2o/OuGwA15HCv8ljwFiSYqpCqvPkSQvuIEJqjQqx1oED/tmo1aQUQpgF1
	 D6eNtppz2o79A==
From: Sasha Levin <sashal@kernel.org>
To: olivier.kaloudoff@gmail.com,
	xiaogang.chen@amd.com,
	felix.kuehling@amd.com,
	alexander.deucher@amd.com
Cc: stable@vger.kernel.org
Subject: FAILED: patch "[PATCH] drm/amdkfd: tear down KFD processes before early fini_sw on disconnect" failed to apply to 6.1-stable tree
Date: Sat,  7 Nov 2026 05:55:51 -0500
Message-ID: <20261107055551-failed-6.1-1233dd17f99c@kernel.org>
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

The patch below does not apply to the 6.1-stable tree.
If someone wants it applied there, or to any other stable or longterm
tree, then please email the backport, including the original git commit
id to <stable@vger.kernel.org>.

To reproduce the conflict and resubmit, you may use the following commands:

git fetch https://git.kernel.org/pub/scm/linux/kernel/git/stable/linux.git/ linux-6.1.y
git checkout FETCH_HEAD
git cherry-pick -x 1233dd17f99c75787a31035656ecfeff80522421
# <resolve conflicts, build, test, etc.>
git commit -s
git send-email --to '<stable@vger.kernel.org>' --in-reply-to '20261107055551-failed-6.1-1233dd17f99c@kernel.org' --subject-prefix 'PATCH 6.1.y' 'HEAD^..'

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




