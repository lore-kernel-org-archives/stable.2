Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DE63532B125
	for <stable@vger.kernel.org>; Sat, 12 Sep 2026 16:24:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1789230265; cv=none; b=RXRSGt3akicA+r0gzZNxZ2+fSXQTsnUcHzwgDYsI/fsZaem+ud9oY2WUAj9C3Jc+NqBYnTw3hYvsuCAOCcpc5C/aP2dV5QteHozE/Z+ze2bDGB9KBusMGc4Chhg5vrbedPV1yiYvBiHStakuhWDUIhWOQUUgs4xtyYMzqX73lnE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1789230265; c=relaxed/simple;
	bh=dUz7G9QPwqBK7BIA/82IajsbH7y4foO5ofrjUtJcdYk=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=Xqu/mzgK9ugP8wgmW/52Zv7/dPxc9kZ+MBaSnn6poPJAj8FlBiD+y+iLn7xI1yGIAw3qYcPr1qTrq4Ts23Vq4ywSOgKpZUabswHKIMLgXhBshno2fFZkKPYxujW/+6QL+CihAIORgZPVfuH65EUymynWVYVsLKR1bE+sVSUzCTk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=OA3+Ww/x; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="OA3+Ww/x"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 252561F0089A;
	Sat, 12 Sep 2026 16:24:23 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1789230263;
	bh=JP006T3tzDtbaNwGoxOWfh1IoIbXR287z3rdyD/MYp8=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References;
	b=OA3+Ww/xgJHqJc8V7nFPqhYosT9yj7kdAdwZvsKExqAsNiTFOu+DvvQb325+aXQKd
	 7mXdGwQDSwMVzydmiueFS0P12Zxo3Pnc1ky2jzRnQzfW8dzfJXB53H9cuZS5ATfaZG
	 HHxmXbUomDHy3nZRc7w6VOfgqfKWnvwzyhfNPrJ6qw93SgJb6ednRdf+3yPS0nbuhZ
	 uh8Fo2O3ZnSjlff3q+uX3v5YF+b6jzutplTAzCrYlKOM2uwEtWAIFC+xCiKdcqNdhf
	 jRGTQ3NeqFWGJer7eiTvHq1rN6OhQQSgRYlV6LFJQ0U2OOYQrTorm3DCyDUKo9fThW
	 /BK4+VCvcglSQ==
From: Sasha Levin <sashal@kernel.org>
To: stable@vger.kernel.org
Cc: Zhenhao Wan <whi4ed0g@gmail.com>,
	Yuhao Jiang <danisjiang@gmail.com>,
	Lyude Paul <lyude@redhat.com>,
	Danilo Krummrich <dakr@kernel.org>,
	Sasha Levin <sashal@kernel.org>
Subject: [PATCH 6.6.y 3/3] drm/nouveau/uvmm: fix NULL deref unwinding an OP_MAP_SPARSE op
Date: Sat, 12 Sep 2026 12:24:19 -0400
Message-ID: <20260912162419.3655187-3-sashal@kernel.org>
X-Mailer: git-send-email 2.53.0
In-Reply-To: <20260912162419.3655187-1-sashal@kernel.org>
References: <2026090959-unbalance-tubby-e048@gregkh>
 <20260912162419.3655187-1-sashal@kernel.org>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

From: Zhenhao Wan <whi4ed0g@gmail.com>

[ Upstream commit 412a6ceb56d501ef2f8202e26ab4b5d4dfbca566 ]

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
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 drivers/gpu/drm/nouveau/nouveau_uvmm.c | 3 ++-
 1 file changed, 2 insertions(+), 1 deletion(-)

diff --git a/drivers/gpu/drm/nouveau/nouveau_uvmm.c b/drivers/gpu/drm/nouveau/nouveau_uvmm.c
index 899af72e99ca3..299a52d3820a3 100644
--- a/drivers/gpu/drm/nouveau/nouveau_uvmm.c
+++ b/drivers/gpu/drm/nouveau/nouveau_uvmm.c
@@ -1406,7 +1406,8 @@ nouveau_uvmm_bind_job_submit(struct nouveau_job *job)
 			break;
 		}
 
-		drm_gpuva_ops_free(&uvmm->base, op->ops);
+		if (!IS_ERR_OR_NULL(op->ops))
+			drm_gpuva_ops_free(&uvmm->base, op->ops);
 		op->ops = NULL;
 		op->reg = NULL;
 	}
-- 
2.53.0

