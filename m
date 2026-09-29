Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CDA823D9537
	for <stable@vger.kernel.org>; Tue, 29 Sep 2026 08:23:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1790670224; cv=none; b=mtPZlNVok1b3z9ZdZyB0gCJxrvb2CAGjKptQCkKLYxpKvF1P5jB2RAmZwAKV/siNzrEMl53nvrTneqekPVBgnqdN64sEZSieoK8fS8ReOikO4sVJr9CKD1gV4Y2jLEL8p9bkdNI1xgHsVaHTcyVqy9SGdAe6m18/b2cxuqRPCXI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1790670224; c=relaxed/simple;
	bh=eJKf0QhB+s2Q/lmHuoHP4MWwaMTlFPtdl49Bso99D70=;
	h=Subject:To:Cc:From:Date:Message-ID:MIME-Version:Content-Type; b=KqCfhnrnN4qaT81X+sLE9M6DN1VSYguZ5hL0VkPjDOBvz/9Ie8szjeUJjEo7I2EuXOPWzKBpGquQ+peh7nvoPacQb4Yaqm1cg5EU/nv+3Eu0gQXLEDxzKFkfCTPqChIp4DUV1XVdlA4NiM5/moAXQKTY1Py1Js8b8qFJdbJh/OI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b=Lehecb3n; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b="Lehecb3n"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 1A6241F008A1;
	Tue, 29 Sep 2026 08:23:41 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linuxfoundation.org;
	s=korg; t=1790670222;
	bh=VP7f59jtk1It1ID9s3vrhmb4ppDyesd36x2ue6RNec8=;
	h=Subject:To:Cc:From:Date;
	b=Lehecb3nEt8GEzS1BpD8DfKzzT/MRS18G9B+oVTEvHrWI48gYq4eyqZEQpw2Z7Mvo
	 Xd6CLEOT1q38xv11QCgZFJZ4sZE+hLhtBH+b4GqEISzblXCSpmX4TQC+zgmo3Cvakk
	 IN3ScRZY+eRqSd8BY0Skx/QE/sYcNz450+xfgJAo=
Subject: FAILED: patch "[PATCH] drm/amdgpu: Fix runtime PM leak in" failed to apply to 5.10-stable tree
To: vulab@iscas.ac.cn,alexander.deucher@amd.com
Cc: <stable@vger.kernel.org>
From: <gregkh@linuxfoundation.org>
Date: Tue, 29 Sep 2026 10:23:29 +0200
Message-ID: <2026092929-vividness-vanquish-6e88@gregkh>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=ANSI_X3.4-1968
Content-Transfer-Encoding: 8bit


The patch below does not apply to the 5.10-stable tree.
If someone wants it applied there, or to any other stable or longterm
tree, then please email the backport, including the original git commit
id to <stable@vger.kernel.org>.

To reproduce the conflict and resubmit, you may use the following commands:

git fetch https://git.kernel.org/pub/scm/linux/kernel/git/stable/linux.git/ linux-5.10.y
git checkout FETCH_HEAD
git cherry-pick -x 2b86ab1bd6673c525adda88819d7658ba9e784ec
# <resolve conflicts, build, test, etc.>
git commit -s
git send-email --to '<stable@vger.kernel.org>' --in-reply-to '2026092929-vividness-vanquish-6e88@gregkh' --subject-prefix 'PATCH 5.10.y' 'HEAD^..'

Possible dependencies:



thanks,

greg k-h

------------------ original commit in Linus's tree ------------------

From 2b86ab1bd6673c525adda88819d7658ba9e784ec Mon Sep 17 00:00:00 2001
From: Wentao Liang <vulab@iscas.ac.cn>
Date: Wed, 16 Sep 2026 09:58:05 +0000
Subject: [PATCH] drm/amdgpu: Fix runtime PM leak in
 amdgpu_debugfs_test_ib_show()

amdgpu_debugfs_test_ib_show() resumes the device with
pm_runtime_get_sync() before taking the reset domain semaphore with
down_write_killable().  If the write lock acquisition is interrupted,
the function returns without calling pm_runtime_put_autosuspend(),
leaking the runtime PM reference acquired for the device and keeping
the GPU awake.

Drop the runtime PM reference on the interrupted down_write_killable()
error path before returning.

Fixes: 6049db43d6dd ("drm/amdgpu: change reset lock from mutex to rw_semaphore")
Signed-off-by: Wentao Liang <vulab@iscas.ac.cn>
Signed-off-by: Alex Deucher <alexander.deucher@amd.com>
(cherry picked from commit ec30a576c2d4c0364549e6c04218f50704ef56c8)
Cc: stable@vger.kernel.org

diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_debugfs.c b/drivers/gpu/drm/amd/amdgpu/amdgpu_debugfs.c
index 132d054900b5..aca1a8045afa 100644
--- a/drivers/gpu/drm/amd/amdgpu/amdgpu_debugfs.c
+++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_debugfs.c
@@ -1780,8 +1780,10 @@ static int amdgpu_debugfs_test_ib_show(struct seq_file *m, void *unused)
 
 	/* Avoid accidently unparking the sched thread during GPU reset */
 	r = down_write_killable(&adev->reset_domain->sem);
-	if (r)
+	if (r) {
+		pm_runtime_put_autosuspend(dev->dev);
 		return r;
+	}
 
 	/* hold on the scheduler */
 	for (i = 0; i < AMDGPU_MAX_RINGS; i++) {

