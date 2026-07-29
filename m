Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id ECBF8448CFD
	for <stable@vger.kernel.org>; Wed, 29 Jul 2026 12:48:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1785329312; cv=none; b=mJQF2xrF/dCFkOT5Q8d81o664u/q7tJ5GgxzRDLP2W6tvlZU0RsWahLG0FvG9UUiGfMUVAt2PfOap4Iidu70uJD+KoquNPJMQsEL4rNksIe7mmyCyzidEUvXbVgi60mUv0QIouKUzj56UAvT9Jfn+stusn2xG5plmwN+r5xlRVw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1785329312; c=relaxed/simple;
	bh=6jOdmMH7goaBfgTrl1rvPeW38DaT9AEYqkQp3ZQdA0I=;
	h=Subject:To:Cc:From:Date:Message-ID:MIME-Version:Content-Type; b=AaLoiagDBQsQnT0ZXTx0aNn9G2edOcUoN3YxuD42Ie/ehJ8oVrMLGH/Q+lN/zyrs28pZntZ97UqIdy/bYVIl+V2JhCFiFGpukolLpJqQNznqVXjR9KQdo77oGn8AC/GFLd/QkU1ADYMZAkOes8C0cbfgJh4vpAC62drhMK6iMGA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b=hmdSAVi6; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b="hmdSAVi6"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 535351F000E9;
	Wed, 29 Jul 2026 12:48:30 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linuxfoundation.org;
	s=korg; t=1785329310;
	bh=2ur399qO24MU5rCipIvj3W8gc2Z58pBLnXVyIQOFFzQ=;
	h=Subject:To:Cc:From:Date;
	b=hmdSAVi6TftO0e/q9j9PdR7+GgSTcevb4Ez5EVNvsPjiCYL+lWpUGS0WBxG+HbfVO
	 esX/4E4Ye2U9qxlifunx2pXNisf/2hUSQZUj4ZWBmegiHoJr6+JSrKmQZFYBrSBDK9
	 RUo+jMIo0YX91YC42/HSI0ZHK76DdRRs6Mq9JB5s=
Subject: FAILED: patch "[PATCH] drm/amdgpu: Reserve space for IB contents in devcoredumps" failed to apply to 6.18-stable tree
To: timur.kristof@gmail.com,alexander.deucher@amd.com,christian.koenig@amd.com
Cc: <stable@vger.kernel.org>
From: <gregkh@linuxfoundation.org>
Date: Wed, 29 Jul 2026 14:48:10 +0200
Message-ID: <2026072910-riverside-untold-2db5@gregkh>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit


The patch below does not apply to the 6.18-stable tree.
If someone wants it applied there, or to any other stable or longterm
tree, then please email the backport, including the original git commit
id to <stable@vger.kernel.org>.

To reproduce the conflict and resubmit, you may use the following commands:

git fetch https://git.kernel.org/pub/scm/linux/kernel/git/stable/linux.git/ linux-6.18.y
git checkout FETCH_HEAD
git cherry-pick -x b5eab15944b6b140f003af6e639a25f5c3a8ed0b
# <resolve conflicts, build, test, etc.>
git commit -s
git send-email --to '<stable@vger.kernel.org>' --in-reply-to '2026072910-riverside-untold-2db5@gregkh' --subject-prefix 'PATCH 6.18.y' 'HEAD^..'

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

