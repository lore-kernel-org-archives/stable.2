Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9CAE53D3002
	for <stable@vger.kernel.org>; Wed, 16 Sep 2026 18:55:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1789584961; cv=none; b=DbNWMPfPFcoXu2ULLqwjZKffHmy+ykqN0VwQvn6/6WoAF6SVqqTUHvOHlezOVa35tMkpaqin65Rxjq2Bs/RtQVH7u9QVALRboh6xqxSpu8jQF/PZ7EDMYQ/hb7Vk8Ye6u/ULW9ZOYvgs8Nia25alvk7WxFxB4AMG0+Qcx+pqgMM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1789584961; c=relaxed/simple;
	bh=0A7JailQG/+PeSDsS0GjmqkIrg7nitoMwFIek97zWr4=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=bseMpGCjt/tFd81Rl5ha2Q9NiecPpfM1K5vODPeaCIwi6Gj+Avb07MvR096EhR/kjgrvfmGVoc8rS86MDDpsizMuMD0FuyYdeOJvU5YdFxxDmzfMvWGMA5aP2R7Iu0ZTeYayZ0JexXDXcZU4ODiOt+cIGgzAeBMSCsOskE9/peM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=cZT6nGRW; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="cZT6nGRW"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id C21241F00898;
	Wed, 16 Sep 2026 18:55:43 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1789584944;
	bh=0mJPyi2G/34IMkDRJPdAec8C7E2MNFJh7cYML1At2xs=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References;
	b=cZT6nGRWwRFqlLg1xCG+dXntDuRd1165fEepHnKjo2a1VV0Yn3yrcif0pqsZpX062
	 Iqm+0jb9Ez68lauMg3r2hIs72l/5v1WHm1eA3TTT90uGrO/KBW/q0qAHqgmbSv/XfC
	 0cMBFpd2ULUn8bibjzsX/hDaf6u22NB3u/JxgBmKr/cwIb78BPhHxYkysGYyStBw68
	 MFtqP1d1qix9vXo15PkzMTm4XDB8x+opKxpJVjPGa7oJ4SvAMjakLFqDuIm2rj1UdO
	 DqtPWMHVDi8Fa6d0VHrfKHeyMpkEJZtuVbSJHbFIhoBbWU09Ank+GR2DKtT6gYu08i
	 w0E4UdzI+JNVw==
From: Sasha Levin <sashal@kernel.org>
To: stable@vger.kernel.org
Cc: Andrzej Kacprowski <Andrzej.Kacprowski@intel.com>,
	Tomasz Rusinowicz <tomasz.rusinowicz@intel.com>,
	Jacek Lawrynowicz <jacek.lawrynowicz@linux.intel.com>,
	Sasha Levin <sashal@kernel.org>
Subject: [PATCH 6.6.y 2/5] accel/ivpu: Update VPU FW API headers
Date: Wed, 16 Sep 2026 14:55:38 -0400
Message-ID: <20260916185541.1885084-2-sashal@kernel.org>
X-Mailer: git-send-email 2.53.0
In-Reply-To: <20260916185541.1885084-1-sashal@kernel.org>
References: <2026091601-reply-pointy-7e61@gregkh>
 <20260916185541.1885084-1-sashal@kernel.org>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

From: Andrzej Kacprowski <Andrzej.Kacprowski@intel.com>

[ Upstream commit a4293cc75348409f998c991c48cbe5532c438114 ]

This commit bumps:
  - Boot API from 3.24.0 to 3.26.3
  - JSM API from 3.16.0 to 3.25.0

Signed-off-by: Andrzej Kacprowski <Andrzej.Kacprowski@intel.com>
Co-developed-by: Tomasz Rusinowicz <tomasz.rusinowicz@intel.com>
Signed-off-by: Tomasz Rusinowicz <tomasz.rusinowicz@intel.com>
Reviewed-by: Jacek Lawrynowicz <jacek.lawrynowicz@linux.intel.com>
Link: https://patchwork.freedesktop.org/patch/msgid/20240930195322.461209-2-jacek.lawrynowicz@linux.intel.com
Signed-off-by: Jacek Lawrynowicz <jacek.lawrynowicz@linux.intel.com>

Backport to 6.6: retain only the tracing-header read_wrap_count member
needed by the firmware log printing changes preceding 0724afc55c77.
Replace one reserved u32 so the tracing header size and subsequent field
offsets stay unchanged.

Drop the unrelated Boot/JSM version bumps, scheduling, native-fence and
power-management updates, together with the job queue conversion and
message-name changes. This tree has older API definitions and lacks
ivpu_jsm_msg_type_to_str(); importing those changes is unnecessary for
firmware log metadata validation. No functions are added.

The separate firmware logging refactors and BO accessor changes are still
required before the unmodified upstream target can apply to this tree.

[ sashal: Reduced backport -- upstream a4293cc753484 touches 4 file(s), this
  backport carries 1. Not backported here:
  drivers/accel/ivpu/ivpu_job.c
  drivers/accel/ivpu/ivpu_jsm_msg.c
  drivers/accel/ivpu/vpu_jsm_api.h
  This note is generated from the file lists only; see the resolution record
  for the reasoning. ]

Stable-dep-of: 0724afc55c77 ("accel/ivpu: Validate firmware log buffer metadata")
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 drivers/accel/ivpu/vpu_boot_api.h | 4 +++-
 1 file changed, 3 insertions(+), 1 deletion(-)

diff --git a/drivers/accel/ivpu/vpu_boot_api.h b/drivers/accel/ivpu/vpu_boot_api.h
index 88345070a9965..7d302693f4562 100644
--- a/drivers/accel/ivpu/vpu_boot_api.h
+++ b/drivers/accel/ivpu/vpu_boot_api.h
@@ -301,7 +301,9 @@ struct vpu_tracing_buffer_header {
 	u32 host_canary_start;
 	/* offset from start of buffer for trace entries */
 	u32 read_index;
-	u32 pad_to_cache_line_size_0[14];
+	/* keeps track of wrapping on the reader side */
+	u32 read_wrap_count;
+	u32 pad_to_cache_line_size_0[13];
 	/* End of first cache line */
 
 	/**
-- 
2.53.0

