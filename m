Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3086B48876C
	for <stable@vger.kernel.org>; Wed, 29 Jul 2026 12:56:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1785329816; cv=none; b=Bx/gviRmsUReq88n6snqDOvtJsPVJqW5oEDq0Ep6wLJ4BJuq8Y3zG8hrG3tLhnemfN9kJwy3n+mShpwJUSwnK3tqSajdXAX+e4f/6Bt5WDPdLI6nrJtTGyribyGdPlypRcl8HHuO5tcnNROzXhGR+kAazBW9eS6cZcq65NotRiA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1785329816; c=relaxed/simple;
	bh=NB4ADp/EjZA5R4kQP+wE5cD440ZNa+LH6H5PKz6HhOo=;
	h=Subject:To:Cc:From:Date:Message-ID:MIME-Version:Content-Type; b=T4/o0ro4S4hAzy4LH9je3z2ogh0KWy2Bn8bR03sEVyMTm+Tau4JP8IVNI0dDIt3gMQXlkcv6+nIT/jkcA919pjqDmqx0lkoXPB513jQ361UomqnWBIoeHmBqc7Qa8GnSI/ozC7+oh0A8fEu0x84vui183UVu5Sc5/EIRN/GC4kI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b=R1Jbrc2m; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b="R1Jbrc2m"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 16DAB1F000E9;
	Wed, 29 Jul 2026 12:56:46 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linuxfoundation.org;
	s=korg; t=1785329807;
	bh=F7CLsG4+OJ2QP5t7+fBzCKRkja0DuqPB4cZSWb6m3rM=;
	h=Subject:To:Cc:From:Date;
	b=R1Jbrc2mfUaWbETcbGPL0Ly+G4xjxiyXx/dw7bSgSbEgwD+rj3IGX8RIg6r5fUifE
	 CNRt8hff/eaOWMlYU2QjJwz+1NdparI/K6pJQYJKyJ44TpuYYz7FfYkELeJaAiYUFS
	 bQeKGGfI9J99BPpRkKXyD8drxSEzr6cv0NDLf+Dw=
Subject: FAILED: patch "[PATCH] drm/v3d: Reach the GMP through the hub registers on V3D 7.x" failed to apply to 6.12-stable tree
To: mcanal@igalia.com,itoral@igalia.com
Cc: <stable@vger.kernel.org>
From: <gregkh@linuxfoundation.org>
Date: Wed, 29 Jul 2026 14:55:19 +0200
Message-ID: <2026072919-speckled-hypocrite-b5e9@gregkh>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
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
git cherry-pick -x f7df2da0d1c375c1c4c70e1e0b569592de0d6b73
# <resolve conflicts, build, test, etc.>
git commit -s
git send-email --to '<stable@vger.kernel.org>' --in-reply-to '2026072919-speckled-hypocrite-b5e9@gregkh' --subject-prefix 'PATCH 6.12.y' 'HEAD^..'

Possible dependencies:



thanks,

greg k-h

------------------ original commit in Linus's tree ------------------

From f7df2da0d1c375c1c4c70e1e0b569592de0d6b73 Mon Sep 17 00:00:00 2001
From: =?UTF-8?q?Ma=C3=ADra=20Canal?= <mcanal@igalia.com>
Date: Sat, 18 Jul 2026 10:44:36 -0300
Subject: [PATCH] drm/v3d: Reach the GMP through the hub registers on V3D 7.x
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit

v3d_idle_axi() drains the GPU's memory interface for a safe powerdown by
using the V3D_GMP_CFG register. It reached both registers with the macros
V3D_CORE_READ and V3D_CORE_WRITE.

On V3D 7.x the GMP is no longer a per-core block; it lives in the hub
register region. Reaching it through the per-core register block addresses
the wrong region.

Select the hub accessors (V3D_{READ,WRITE}) for the GMP on V3D 7.x and
keep the per-core path for earlier generations.

Cc: stable@vger.kernel.org
Fixes: 0ad5bc1ce463 ("drm/v3d: fix up register addresses for V3D 7.x")
Link: https://patch.msgid.link/20260718-v3d-pm-axi-transactions-v1-1-4ecd7729ed70@igalia.com
Reviewed-by: Iago Toral Quiroga <itoral@igalia.com>
Signed-off-by: Maíra Canal <mcanal@igalia.com>

diff --git a/drivers/gpu/drm/v3d/v3d_gem.c b/drivers/gpu/drm/v3d/v3d_gem.c
index c43d9af41374..bb0eec870794 100644
--- a/drivers/gpu/drm/v3d/v3d_gem.c
+++ b/drivers/gpu/drm/v3d/v3d_gem.c
@@ -39,6 +39,18 @@ v3d_init_core(struct v3d_dev *v3d, int core)
 static void
 v3d_idle_axi(struct v3d_dev *v3d, int core)
 {
+	if (v3d->ver >= V3D_GEN_71) {
+		V3D_WRITE(V3D_GMP_CFG(v3d->ver), V3D_GMP_CFG_STOP_REQ);
+
+		if (wait_for((V3D_READ(V3D_GMP_STATUS(v3d->ver)) &
+			      (V3D_GMP_STATUS_RD_COUNT_MASK |
+			       V3D_GMP_STATUS_WR_COUNT_MASK |
+			       V3D_GMP_STATUS_CFG_BUSY)) == 0, 100)) {
+			drm_err(&v3d->drm, "Failed to wait for safe GMP shutdown\n");
+		}
+		return;
+	}
+
 	V3D_CORE_WRITE(core, V3D_GMP_CFG(v3d->ver), V3D_GMP_CFG_STOP_REQ);
 
 	if (wait_for((V3D_CORE_READ(core, V3D_GMP_STATUS(v3d->ver)) &

