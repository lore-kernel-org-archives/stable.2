Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 541D2411A02
	for <stable@vger.kernel.org>; Wed, 29 Jul 2026 16:22:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1785342179; cv=none; b=LTRxZPSZvaj4/xOMdibisBX7f5uzO9qf1n/s2UoRW2WtcnvN7vkyGeYfguvsGpbCIFF622IYyoiTf46hy9b+lkuLny+AcqI6b2cZRNuiHUY5uR608cQbf58jBf5yzv9uHKjvEdmW/7oR2E2bVD+9lJvB0ViqcaoWOTeKSbawq/o=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1785342179; c=relaxed/simple;
	bh=KzprYAtYDyBzLjUN8VhEZsi5+RVfufCs5sQvIzjIIA8=;
	h=Subject:To:Cc:From:Date:Message-ID:MIME-Version:Content-Type; b=d6aAwkl/5xk0RJtPw3fW4uvU80R5fjN7agb6SCeT5eseMp05sgrk9xgQ7Se8VdBpSHNCGBHIT0L6M8T2pZtgiyyv94+T6/WIGAMY3KEVjlHnNf5A21WFDDHMeQ5TXpk1om7bVFC228FiIJ5/yCF9ii+lNunWunbb9eE5Tt6r/eE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b=uggJvLqA; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b="uggJvLqA"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 798261F000E9;
	Wed, 29 Jul 2026 16:22:57 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linuxfoundation.org;
	s=korg; t=1785342178;
	bh=tlEgM1nxmUd63wc4Z56Pc6lZ5VSFr9AGHab8Ds6HNqE=;
	h=Subject:To:Cc:From:Date;
	b=uggJvLqApdMyIzab4ZfyjG7qebpvYY7zgrLlqYyfP+ttkAR2YxGhL03btWANQ5zC/
	 mBt93bq9XkyY4C7KJoUIrHkW4Oxc/AS22IQdTOgJAOrkiLV2T5/YXqEUewENHuztdl
	 RteRO8FZC2b68jnqCIZCbe341PBRs+dNVWBqylTs=
Subject: FAILED: patch "[PATCH] drm/amdgpu/mes12: set doorbell offset for suspending userq" failed to apply to 6.18-stable tree
To: Prike.Liang@amd.com,alexander.deucher@amd.com,christian.koenig@amd.com
Cc: <stable@vger.kernel.org>
From: <gregkh@linuxfoundation.org>
Date: Wed, 29 Jul 2026 18:22:36 +0200
Message-ID: <2026072936-cheer-pretense-c744@gregkh>
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
git cherry-pick -x 218c4929236d33413e5ecc6003c5185018f830fc
# <resolve conflicts, build, test, etc.>
git commit -s
git send-email --to '<stable@vger.kernel.org>' --in-reply-to '2026072936-cheer-pretense-c744@gregkh' --subject-prefix 'PATCH 6.18.y' 'HEAD^..'

Possible dependencies:



thanks,

greg k-h

------------------ original commit in Linus's tree ------------------

From 218c4929236d33413e5ecc6003c5185018f830fc Mon Sep 17 00:00:00 2001
From: Prike Liang <Prike.Liang@amd.com>
Date: Thu, 25 Jun 2026 10:42:27 +0800
Subject: [PATCH] drm/amdgpu/mes12: set doorbell offset for suspending userq
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit

Updating the union MESAPI__SUSPEND and union MESAPI__RESUME to
add the doorbell offset for suspending userq.

Signed-off-by: Prike Liang <Prike.Liang@amd.com>
Acked-by: Christian König <christian.koenig@amd.com>
Signed-off-by: Alex Deucher <alexander.deucher@amd.com>
(cherry picked from commit 5b58a2c120063544869d0284d3b355527f9f04f5)
Cc: stable@vger.kernel.org

diff --git a/drivers/gpu/drm/amd/amdgpu/mes_v12_0.c b/drivers/gpu/drm/amd/amdgpu/mes_v12_0.c
index 7453fb11289e..b6cbc25e1ab4 100644
--- a/drivers/gpu/drm/amd/amdgpu/mes_v12_0.c
+++ b/drivers/gpu/drm/amd/amdgpu/mes_v12_0.c
@@ -592,6 +592,7 @@ static int mes_v12_0_suspend_gang(struct amdgpu_mes *mes,
 	mes_suspend_gang_pkt.gang_context_addr = input->gang_context_addr;
 	mes_suspend_gang_pkt.suspend_fence_addr = input->suspend_fence_addr;
 	mes_suspend_gang_pkt.suspend_fence_value = input->suspend_fence_value;
+	mes_suspend_gang_pkt.doorbell_offset = input->doorbell_offset;
 
 	return mes_v12_0_submit_pkt_and_poll_completion(mes, AMDGPU_MES_SCHED_PIPE,
 			&mes_suspend_gang_pkt, sizeof(mes_suspend_gang_pkt),
@@ -611,6 +612,7 @@ static int mes_v12_0_resume_gang(struct amdgpu_mes *mes,
 
 	mes_resume_gang_pkt.resume_all_gangs = input->resume_all_gangs;
 	mes_resume_gang_pkt.gang_context_addr = input->gang_context_addr;
+	mes_resume_gang_pkt.doorbell_offset = input->doorbell_offset;
 
 	return mes_v12_0_submit_pkt_and_poll_completion(mes, AMDGPU_MES_SCHED_PIPE,
 			&mes_resume_gang_pkt, sizeof(mes_resume_gang_pkt),
diff --git a/drivers/gpu/drm/amd/amdgpu/mes_v12_1.c b/drivers/gpu/drm/amd/amdgpu/mes_v12_1.c
index 8a90ad5a51b8..e13535d94c51 100644
--- a/drivers/gpu/drm/amd/amdgpu/mes_v12_1.c
+++ b/drivers/gpu/drm/amd/amdgpu/mes_v12_1.c
@@ -484,6 +484,7 @@ static int mes_v12_1_suspend_gang(struct amdgpu_mes *mes,
 	mes_suspend_gang_pkt.gang_context_addr = input->gang_context_addr;
 	mes_suspend_gang_pkt.suspend_fence_addr = input->suspend_fence_addr;
 	mes_suspend_gang_pkt.suspend_fence_value = input->suspend_fence_value;
+	mes_suspend_gang_pkt.doorbell_offset = input->doorbell_offset;
 
 	/* Suspend gang is handled by master MES */
 	return mes_v12_1_submit_pkt_and_poll_completion(mes, input->xcc_id, AMDGPU_MES_SCHED_PIPE,
@@ -504,6 +505,7 @@ static int mes_v12_1_resume_gang(struct amdgpu_mes *mes,
 
 	mes_resume_gang_pkt.resume_all_gangs = input->resume_all_gangs;
 	mes_resume_gang_pkt.gang_context_addr = input->gang_context_addr;
+	mes_resume_gang_pkt.doorbell_offset = input->doorbell_offset;
 
 	/* Resume gang is handled by master MES */
 	return mes_v12_1_submit_pkt_and_poll_completion(mes, input->xcc_id, AMDGPU_MES_SCHED_PIPE,

