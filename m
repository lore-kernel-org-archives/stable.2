Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1DDBF365A0F
	for <stable@vger.kernel.org>; Mon,  1 Jun 2026 13:17:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1780319850; cv=none; b=apWdMepo+MML/HC4fv1F/4wux5Hxbn3Csu65Q0XxAnKYNQAsM8U/v0Y72hHtwrunuA5TPUfhbBf/ysW3SY++2u1cO7Jgm7gb3yhbqj9Mko6Lr4wz6A/SBYNfhOzETKGmjp/7JlMsBzPgP/FY8L+HSfXWEfkurmKS5E43hoMCsO4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1780319850; c=relaxed/simple;
	bh=OJ9RuobannAvkyw1IT1tHyo6Y4y9Jh3FRX7Jxlr6XVg=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=CCjDTy/FGfPqAbP2jPMvijOQU6PM9KJvUEteDbJthkSvAqDBpqjo+Ojn3oa1nu3SazRnuvujBQraXR3MhGl9WB3o50KvXg4tl4HtKjVb4BmKg0nglt1hfjmgcydqRqBWm/2wj/f/RlpDglckwZYXtX9EcZC5fFlmrs9E8uCtGGQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=Hpq3u2Jl; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="Hpq3u2Jl"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 8847A1F0089A;
	Mon,  1 Jun 2026 13:17:28 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1780319849;
	bh=123A7HprqI8OIIqDrS2szhlS5d1WSCZ+LoNop6dItOw=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References;
	b=Hpq3u2JlulJ+t98uwY3rDTCQuW0aLoFWkyp/+b4QbGenlAqeXzUKj55UMgV81VE48
	 ewnuDMBI30jB5CvAbhGFY2iJoGCS1+vlr6JGpGqjE7w29Po3jXr68pSheFi/yibFID
	 WF9ArwgA+lmpnw2rPUiHxB58jE7OwxhsjncI4hgBLKca6whEHCCPp89fqz/KJneRZG
	 r612lVRXnRVrx8twUTrKm0ZWZUHDn5zsTRZ9/gYasJBDKjT6SD9olewdCjx5+qYnAd
	 lmkcWQJZbW/MNrD3Ng4Lo9yE3TNvdSjHeY6uwVdq8j5oRjg3mZ5LxXkcN1uNY58A8O
	 XvUv0I+yhpQSA==
From: Sasha Levin <sashal@kernel.org>
To: stable@vger.kernel.org
Cc: =?UTF-8?q?Ma=C3=ADra=20Canal?= <mcanal@igalia.com>,
	Iago Toral Quiroga <itoral@igalia.com>,
	Sasha Levin <sashal@kernel.org>
Subject: [PATCH 6.12.y 3/3] drm/v3d: Release indirect CSD GEM reference on CPU job free
Date: Mon,  1 Jun 2026 09:17:25 -0400
Message-ID: <20260601131725.780793-3-sashal@kernel.org>
X-Mailer: git-send-email 2.53.0
In-Reply-To: <20260601131725.780793-1-sashal@kernel.org>
References: <2026052815-arose-kabob-9b34@gregkh>
 <20260601131725.780793-1-sashal@kernel.org>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit

From: Maíra Canal <mcanal@igalia.com>

[ Upstream commit 6eb6e5acafa46854d4363e6c34981289995f3ace ]

v3d_get_cpu_indirect_csd_params() takes a reference to the indirect BO via
drm_gem_object_lookup() and stashes it in cpu_job->indirect_csd.indirect,
but nothing on the CPU job teardown path ever drops that reference.

Drop the extra reference in v3d_cpu_job_free(). The NULL check covers ioctl
errors before the lookup ran and CPU job types other than
V3D_CPU_JOB_TYPE_INDIRECT_CSD, which leave the field zero-initialised.

Cc: stable@vger.kernel.org
Fixes: 18b8413b25b7 ("drm/v3d: Create a CPU job extension for a indirect CSD job")
Assisted-by: Claude:claude-opus-4.7
Reviewed-by: Iago Toral Quiroga <itoral@igalia.com>
Link: https://patch.msgid.link/20260515-v3d-cpu-job-leaks-v1-2-7f147cbbf935@igalia.com
Signed-off-by: Maíra Canal <mcanal@igalia.com>
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 drivers/gpu/drm/v3d/v3d_submit.c | 3 +++
 1 file changed, 3 insertions(+)

diff --git a/drivers/gpu/drm/v3d/v3d_submit.c b/drivers/gpu/drm/v3d/v3d_submit.c
index 40c21aaade0d6..23472c7af41a9 100644
--- a/drivers/gpu/drm/v3d/v3d_submit.c
+++ b/drivers/gpu/drm/v3d/v3d_submit.c
@@ -130,6 +130,9 @@ v3d_cpu_job_free(struct kref *ref)
 	v3d_performance_query_info_free(&job->performance_query,
 					job->performance_query.count);
 
+	if (job->indirect_csd.indirect)
+		drm_gem_object_put(job->indirect_csd.indirect);
+
 	v3d_job_free(ref);
 }
 
-- 
2.53.0

