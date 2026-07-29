Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C59864314BD
	for <stable@vger.kernel.org>; Wed, 29 Jul 2026 12:48:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1785329314; cv=none; b=RS7eIt4fma3nF3y7IthkNQvJ2P9yYZsARK7wWzoZZa48B270IvwIHpuZ22l6BlenSqX1BPL8kA3OqEqtBxZr17xY5IGLcy2owMDson/vZrROlMkpZk+H4oOBWTT0+ClQ4clEjn2bjQlPEqKKl9JhMlY9anq/Jl2yevtG4/k1w/o=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1785329314; c=relaxed/simple;
	bh=ISk1Vb/qr4SA5S89UURdoJg8WRvy6RBPuAwIL7RoVzc=;
	h=Subject:To:Cc:From:Date:Message-ID:MIME-Version:Content-Type; b=tDo44yqOvtq6W0q8+n594EJo+0BcXZuoElV/Anjpz3ixLy1hQoJRiKO1tnSKG50pNu4Rx23t/ECyFFsccP6YtLxLDJz+GT4jx70oBPmnDMaBRbNioWB0Vx2JUq+kFZ0BIhXQHNKSvraCcawU/YDAP08LmCWagQcXfsjbjEdx/1s=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b=2Tlm5lPP; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b="2Tlm5lPP"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 1FA5B1F000E9;
	Wed, 29 Jul 2026 12:48:32 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linuxfoundation.org;
	s=korg; t=1785329313;
	bh=ncfv6tZ+5bUoih/HxyJ2mFY3oMFeCEiS0Arn4KrcFFM=;
	h=Subject:To:Cc:From:Date;
	b=2Tlm5lPPn7BmhB3YHVt7xQwGQKrfsTkLr0bO3SjGIJp83MP4kv3ljlZj4LG2dCMG5
	 J3BxL83AXReRJ5UWEAvhUXEWIRf0iNICCp+W3Lvh85xhewg67kZ+K5OcczVnUE3pi2
	 Sts//+pmho/FEF+amJPJYOU3w7pU/xAKGjJHv7Sw=
Subject: FAILED: patch "[PATCH] drm/amdgpu: Reserve space for IB contents in devcoredumps" failed to apply to 6.12-stable tree
To: timur.kristof@gmail.com,alexander.deucher@amd.com,christian.koenig@amd.com
Cc: <stable@vger.kernel.org>
From: <gregkh@linuxfoundation.org>
Date: Wed, 29 Jul 2026 14:48:10 +0200
Message-ID: <2026072910-coroner-sculptor-7d73@gregkh>
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
git cherry-pick -x b5eab15944b6b140f003af6e639a25f5c3a8ed0b
# <resolve conflicts, build, test, etc.>
git commit -s
git send-email --to '<stable@vger.kernel.org>' --in-reply-to '2026072910-coroner-sculptor-7d73@gregkh' --subject-prefix 'PATCH 6.12.y' 'HEAD^..'

Possible dependencies:



thanks,

greg k-h

------------------ original commit in Linus's tree ------------------

From b5eab15944b6b140f003af6e639a25f5c3a8ed0b Mon Sep 17 00:00:00 2001
From: =?UTF-8?q?Timur=20Krist=C3=B3f?= <timur.kristof@gmail.com>
Date: Sat, 11 Jul 2026 13:21:08 +0200
Subject: [PATCH] drm/amdgpu: Reserve space for IB contents in devcoredumps
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit

Currently the contents of IBs are abruptly cut off and don't
show the full contents. This patch makes sure to reserve
space for those contents too so they may be printed.

Signed-off-by: Timur Kristóf <timur.kristof@gmail.com>
Acked-by: Christian König <christian.koenig@amd.com>
Signed-off-by: Alex Deucher <alexander.deucher@amd.com>
(cherry picked from commit 4e2c0821509fed754e8c31d5053d152fbb3484a5)
Cc: stable@vger.kernel.org

diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_dev_coredump.c b/drivers/gpu/drm/amd/amdgpu/amdgpu_dev_coredump.c
index acab3d94a51a..6480a344006d 100644
--- a/drivers/gpu/drm/amd/amdgpu/amdgpu_dev_coredump.c
+++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_dev_coredump.c
@@ -234,6 +234,9 @@ amdgpu_devcoredump_print_ibs(struct drm_printer *p,
 			drm_printf(p, "\nIB #%d 0x%llx %d dw\n", i,
 				   coredump->ibs[i].gpu_addr,
 				   coredump->ibs[i].ib_size_dw);
+
+			for (int j = 0; j < coredump->ibs[i].ib_size_dw; j++)
+				drm_printf(p, "0xffffffff\n");
 		}
 		return;
 	}

