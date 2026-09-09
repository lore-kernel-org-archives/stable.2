Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 476594F30C6
	for <stable@vger.kernel.org>; Wed,  9 Sep 2026 12:11:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1788955904; cv=none; b=SCZQ2Fxi3iFrCtbYRGbd9yS0ppvScs0Nve2p0nsuZEdr1OzC2H6uF7hGx9vwxEHzD0VYS9avL3Z+6kgSiJcq4WG/rSmCtOLh+ouE2vBFrM4CXs/cE7dJcDn+ShYJLcF1IyOwuNj3suJuUk5PSjpPpNlP+xTu6M5ryu1ivDXz4N0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1788955904; c=relaxed/simple;
	bh=HytV/HmNCe2NId5R4GfzOIrLASormf8g8pjSGEKtMDU=;
	h=Subject:To:Cc:From:Date:Message-ID:MIME-Version:Content-Type; b=NXPVpJM5bmLe9zcNBc1SVGcoziRm5R2p+alnc29+arI8tG13cvxUJfOqMLUgOQpHnBC+JJ8WukSNHaMW4CLjqmAtvhxQnRZ1zmwx/YDDWHq7YlrS+Vt8H6ZPY2L6lN6JUamcUoRtlGvdwNsMDirmXVmn/TPy2JHvfiZXvEbCoxo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b=ZuGQEXiF; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b="ZuGQEXiF"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 962E11F00A3A;
	Wed,  9 Sep 2026 12:11:42 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linuxfoundation.org;
	s=korg; t=1788955903;
	bh=Cl+9TxqOxzwWIv+uF98pUZ1GfAoakLj+SUZi2J8VbgA=;
	h=Subject:To:Cc:From:Date;
	b=ZuGQEXiFfB61ho9d7F6vqI4/ZbtpYkd4Hkyya+Pu8Az2w7598uFtjdJZKl9tvjlo/
	 O1SGyV8h5XglK4eaOFI3XEvcMarC5jlhol8vDWATOO5CbdA0w9OC1IMdguXMeH7kUf
	 dBaqS1lDwVR0jD8h6YLNSEUEvukMLTcPHsjyjo5o=
Subject: FAILED: patch "[PATCH] drm/nouveau/uvmm: fix NULL deref unwinding an OP_MAP_SPARSE" failed to apply to 6.6-stable tree
To: whi4ed0g@gmail.com,dakr@kernel.org,danisjiang@gmail.com,lyude@redhat.com
Cc: <stable@vger.kernel.org>
From: <gregkh@linuxfoundation.org>
Date: Wed, 09 Sep 2026 14:08:59 +0200
Message-ID: <2026090959-unbalance-tubby-e048@gregkh>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=ANSI_X3.4-1968
Content-Transfer-Encoding: 8bit


The patch below does not apply to the 6.6-stable tree.
If someone wants it applied there, or to any other stable or longterm
tree, then please email the backport, including the original git commit
id to <stable@vger.kernel.org>.

To reproduce the conflict and resubmit, you may use the following commands:

git fetch https://git.kernel.org/pub/scm/linux/kernel/git/stable/linux.git/ linux-6.6.y
git checkout FETCH_HEAD
git cherry-pick -x 412a6ceb56d501ef2f8202e26ab4b5d4dfbca566
# <resolve conflicts, build, test, etc.>
git commit -s
git send-email --to '<stable@vger.kernel.org>' --in-reply-to '2026090959-unbalance-tubby-e048@gregkh' --subject-prefix 'PATCH 6.6.y' 'HEAD^..'

Possible dependencies:



thanks,

greg k-h

------------------ original commit in Linus's tree ------------------

From 412a6ceb56d501ef2f8202e26ab4b5d4dfbca566 Mon Sep 17 00:00:00 2001
From: Zhenhao Wan <whi4ed0g@gmail.com>
Date: Tue, 11 Aug 2026 16:46:28 +0800
Subject: [PATCH] drm/nouveau/uvmm: fix NULL deref unwinding an OP_MAP_SPARSE
 op

Each bind_job_op is zeroed by kzalloc_obj() in bind_job_op_from_uop(),
and the OP_MAP_SPARSE case in nouveau_uvmm_bind_job_submit() only creates
a region, so op->ops stays NULL for a successfully processed sparse map.

If a later op in the same job fails, the reverse unwind loop revisits that
op and calls drm_gpuva_ops_free(&uvmm->base, op->ops) unconditionally.
drm_gpuva_ops_free() dereferences its argument right away
(list_for_each_entry_safe on &ops->list), so a NULL op->ops oopses. The
path is reachable by any render-node fd holder, since NOUVEAU_VM_BIND is
DRM_RENDER_ALLOW.

Guard the free with IS_ERR_OR_NULL(), as nouveau_uvmm_bind_job_cleanup()
already does for the identical free.

Fixes: b88baab82871 ("drm/nouveau: implement new VM_BIND uAPI")
Reported-by: Yuhao Jiang <danisjiang@gmail.com>
Assisted-by: Claude:claude-opus-5
Cc: stable@vger.kernel.org
Signed-off-by: Zhenhao Wan <whi4ed0g@gmail.com>
Reviewed-by: Lyude Paul <lyude@redhat.com>
Link: https://patch.msgid.link/20260811-nouveau-uvmm-vmbind-fixes-v2-1-aaee4b395d04@gmail.com
Signed-off-by: Danilo Krummrich <dakr@kernel.org>

diff --git a/drivers/gpu/drm/nouveau/nouveau_uvmm.c b/drivers/gpu/drm/nouveau/nouveau_uvmm.c
index f5e4756b4de4..19e758a20c24 100644
--- a/drivers/gpu/drm/nouveau/nouveau_uvmm.c
+++ b/drivers/gpu/drm/nouveau/nouveau_uvmm.c
@@ -1489,7 +1489,8 @@ nouveau_uvmm_bind_job_submit(struct nouveau_job *job,
 			break;
 		}
 
-		drm_gpuva_ops_free(&uvmm->base, op->ops);
+		if (!IS_ERR_OR_NULL(op->ops))
+			drm_gpuva_ops_free(&uvmm->base, op->ops);
 		op->ops = NULL;
 		op->reg = NULL;
 	}

