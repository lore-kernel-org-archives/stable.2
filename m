Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 792092AE8D
	for <stable@vger.kernel.org>; Thu, 18 Jun 2026 19:08:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1781809708; cv=none; b=VYpieBu2VaKFw9CQ4K9i7GXlbC7xxWRkhtQw/KLjyL/Vdc63lzXVpnwpMxFxQ8lG8/7MA6M37gx6Vvn9XHxgMeshClJLIipZILW2/JoJtfP7fD73qBhV+zfUExh6TDZwsCDXBMoT7+xNc+9WTZ/p/Fx3cCSFRnfzxaHut8poQHg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1781809708; c=relaxed/simple;
	bh=qfjGJ5CvoayPVlQvB+11cWCAnki221oDocN9fqHIl9s=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=BdHKAZy4AVdqUgncEU9+fSPk6PRR7VHmoRABoM4XA956/0QNHBcy941T24KD0TNDj2dUuG4I5FEtR/hpfdC6gP2uFwnOldsbXhsSJPlfcFLOGARsvmn8IlLeJwn60ikFagsEnZ8UckRICl3KH8bj4Lz8yi4K3+NSQQsayO08R9Y=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=Yke/Pl0y; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="Yke/Pl0y"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 9B8231F00A3D;
	Thu, 18 Jun 2026 19:08:26 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1781809707;
	bh=x4VmBUM9Mnb4BMl6IzRGsPB2z7C2TlEYbuFFJ28s4Gs=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References;
	b=Yke/Pl0yDHw6BLnyXKkl8a0sImfWb/qOgjunMpofw25dlnlkSgU2ZHl6JoWYyhXOZ
	 7KvSHPXc/UBq1g77T6pNXDVc0sL5z1yGn75MOBCYBFhw10HGpCmoirJJjgms2c10v4
	 AkwIYe8SFWXxgZqq1fYUZGMmmzU7Ddi0ZgjUywWy/etOYb4c/tDhKObcppuRKAoZqU
	 UG1b4JMN+fsYghaGvPW0UY32mGx3Dc1DFJmZB0ACuahcvcz6giw4fsSWNyCmrH2Hft
	 Ijgao1pcKnS8mpZo8ha8vTHmiNizvkqpC35kdPj2GJK/5kyvpHfmCUlaZI1iIl3FBG
	 njzmEENa2riGQ==
From: Sasha Levin <sashal@kernel.org>
To: stable@vger.kernel.org
Cc: =?UTF-8?q?Ma=C3=ADra=20Canal?= <mcanal@igalia.com>,
	Jose Maria Casanova Crespo <jmcasanova@igalia.com>,
	Iago Toral Quiroga <itoral@igalia.com>,
	Sasha Levin <sashal@kernel.org>
Subject: [PATCH 5.10.y 2/2] drm/v3d: Skip CSD when it has zeroed workgroups
Date: Thu, 18 Jun 2026 15:08:24 -0400
Message-ID: <20260618190824.985358-2-sashal@kernel.org>
X-Mailer: git-send-email 2.53.0
In-Reply-To: <20260618190824.985358-1-sashal@kernel.org>
References: <2026061530-phoniness-operative-8a96@gregkh>
 <20260618190824.985358-1-sashal@kernel.org>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit

From: Maíra Canal <mcanal@igalia.com>

[ Upstream commit 7f93fad5ea0affc9e1505dd0f7596c0fdb496213 ]

A compute shader dispatch encodes its workgroup counts in the CFG0..CFG2
registers. Kicking off a dispatch with a zero count in any of the three
dimensions is invalid. First, the hardware will process 0 as 65536,
while the user-space driver exposes a maximum of 65535. Over that, a
submission with a zeroed workgroup dimension should be a no-op.

These zeroed counts can reach the dispatch path through an indirect CSD
job, whose workgroup counts are only known once the indirect buffer is
read and may legitimately be zero, but such scenario should only result in
a no-op.

Overwrite the indirect CSD job workgroup counts with the indirect BO
ones, even if they are zeroed, and don't submit the job to the hardware
when any of the workgroup counts is zero, so the job completes immediately
instead of running the shader.

Cc: stable@vger.kernel.org
Fixes: d223f98f0209 ("drm/v3d: Add support for compute shader dispatch.")
Suggested-by: Jose Maria Casanova Crespo <jmcasanova@igalia.com>
Reviewed-by: Iago Toral Quiroga <itoral@igalia.com>
Link: https://patch.msgid.link/20260602-v3d-fix-indirect-csd-v4-2-654309e32bc0@igalia.com
Signed-off-by: Maíra Canal <mcanal@igalia.com>
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 drivers/gpu/drm/v3d/v3d_sched.c | 10 ++++++++++
 1 file changed, 10 insertions(+)

diff --git a/drivers/gpu/drm/v3d/v3d_sched.c b/drivers/gpu/drm/v3d/v3d_sched.c
index 06371ea19e3c0d..fe5bdfd19f13a6 100644
--- a/drivers/gpu/drm/v3d/v3d_sched.c
+++ b/drivers/gpu/drm/v3d/v3d_sched.c
@@ -243,6 +243,16 @@ v3d_csd_job_run(struct drm_sched_job *sched_job)
 		return NULL;
 	}
 
+	/* The HW interprets a workgroup size of 0 as 65536; however, the
+	 * user-space driver exposes a maximum of 65535. Therefore, a 0 in
+	 * any dimension means that we have no workgroups and the compute
+	 * shader should not be dispatched.
+	 */
+	if (!V3D_GET_FIELD(job->args.cfg[0], V3D_CSD_QUEUED_CFG0_NUM_WGS_X) ||
+	    !V3D_GET_FIELD(job->args.cfg[1], V3D_CSD_QUEUED_CFG1_NUM_WGS_Y) ||
+	    !V3D_GET_FIELD(job->args.cfg[2], V3D_CSD_QUEUED_CFG2_NUM_WGS_Z))
+		return NULL;
+
 	v3d->queue[V3D_CSD].active_job = &job->base;
 
 	v3d_invalidate_caches(v3d);
-- 
2.53.0

