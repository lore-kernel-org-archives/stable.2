Received: from mail-lr2-f10.google.com (mail-lr2-f10.google.com [74.125.230.74])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DE6E85304C9
	for <stable@vger.kernel.org>; Wed, 23 Sep 2026 14:57:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=74.125.230.74
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1790175432; cv=none; b=H8xToODZvvja6lAC5MHmSAUBAmWxU+ZrRJI58DZDVJ8f1HA1c7YzY6VYjpMipPOWUsIZlMd3aG/ckkU3+WcXxhRU8fSlRhz6qZS3tXePPRj9TB+BcWiTgOrPaeGbQR92IMWq3ET6bK5Ha5O4UBBLz2ra08Pwo4unFYTg46wrq5I=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1790175432; c=relaxed/simple;
	bh=OH8uQ9VNAZOQyUECZ3dFzXsuD/WJGTQjmmIL/oLjcgM=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=CSwBOE7lKRGwsaZGe9zJSOEQvy6X7klQKtfmfKarkufVP1qQjGtzWJ88vwpG77fGAfznTkTqmbaU5/ARyHizbxNl/MH/bretUvYswHh37RUn2F6qXPui7cBxjVwqJb/FFRwfzF7vUDFlC3x9TiBELzO4evc8LQzGm5OBWg9wpOk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=gzRnqFv6; arc=none smtp.client-ip=74.125.230.74
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="gzRnqFv6"
Received: by mail-lr2-f10.google.com with SMTP id 38308e7fff4ca-3a46d5c5bd7so6031801fa.1
        for <stable@vger.kernel.org>; Wed, 23 Sep 2026 07:57:10 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1790175398; x=1790780198; darn=vger.kernel.org;
        h=content-transfer-encoding:content-type:mime-version:references
         :in-reply-to:message-id:date:subject:cc:to:from:from:to:cc:subject
         :date:message-id:reply-to:content-type;
        bh=KLyY5MHaKq4xCUtb5Tr0mqR1G0KiRq9dtEBuRM3TfU0=;
        b=gzRnqFv6c+rxPvqLkGG47yxdiMfxAmQQHwmNwXVKXUNyRxCTuEBzM7lbDQEZdB3iIn
         LxCdox+tgkbcRI18L4XQ4AWNPdynQhywn63l419Y5yZbuZoRpfdp3bMQO5PkgNtHjosN
         qh4EwAVINOtHm5Nz5kUd02gBXAxwRwd+On/ELg6wmgl01Zee9nwNVUmKdQeRRL2vs4Eb
         dryEYQD4ql+sXd2Ha0EbyjG6QBk5DVyMml123z5+hYcNdbzVyJwRB0lhicnA1g0kbbFr
         9gB+L0IaPg53JBetwHVusHBJfUiBUSUXV2ArX7AAP+jm7KsjUtRyJggXXZMREJjP/wYN
         kc6g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1790175398; x=1790780198;
        h=content-transfer-encoding:content-type:mime-version:references
         :in-reply-to:message-id:date:subject:cc:to:from:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=KLyY5MHaKq4xCUtb5Tr0mqR1G0KiRq9dtEBuRM3TfU0=;
        b=m4WWXB0bGLclcdfqgi8VYfK923yWVeCKYS2apwDbzMKhh9bdiXVxT7HA+W1g7yYaHx
         zyK9JLpZLudD/yNtRoOt/61hJ5Tf6ydYFahiZwfuBlWh5V1Q1ldtMGGtqjPPHUPm31QO
         s7tZq4udYzDBgafz/P5vx6LiqRi2ERHBOHLeofG77VCmfENSkRCiTd88MMQOfNVY2GV+
         KHEVRknXGKWE2AFlK3oQPa1RfksVyJUP/Gykk2gwlDe80H+OlINs3GTOASadJH0cQtui
         T/SNUg515M2kSHda5QVTiwvRBTFrIDiFR3QsPr59nq7LJCWWwHCBxaS++beWWwKGv1sD
         cTow==
X-Gm-Message-State: AFuF++kdyZ0FbddWDX5+q9HKBLWtEg0xyipS5eAr25yerPS7NpOKcXIp
	+Etr2q5zALX8VST84kiW1/7edUm/f2vaTeQOMtloiz2WYqYYkCNbTT9zdyv2vaYZQik=
X-Gm-Gg: AYBFou2YIMoZ1fT2pcQiIeQuCKKUkBEUJ3Uo/7xbZ7wMGt7299ljZEULDFAxZHQElX0
	mwz9/8FQ/G+YfsJ/d7zppgkRs9OLg2LVzKyS9EAO8owx0R55Kd8G3pnebm0G6Ps7JyrN0adUNnP
	7/xRTfRuVrCAHrNgbnP+MGBpKG9POFmLi3YjyHceDKLzOvoElMSag5FPz+xz0+4DNzHqbpso1xF
	GpmiGQeaIBzSc82Ijwcv+sDP9sgpZZ6/VGaKTCWOTS2ijby+M7RvK91Y+t9zcw7rQalUw/nvFBP
	yxWkvUcYBNNcyCS+BRXR68og+8noDy0e70A/nScFQC1i59uHqfCRzKNp7PVdMkFDMUQINF4048Q
	yqNtgZ0WxyqEDrGQpw372AGshBe2U3f3vT9EfZDY1MAOWeQM+HTfD3prOgKwkQR12PjUmWcVNMr
	Z/6i07gj8iZSqropINVaEpLY05AFxfdJF6Hz/SOtam4MOCrQxGiv/CLDDuVb8SK1uviNbNMuS/5
	qucus/mRj1BG5+E
X-Received: by 2002:a05:651c:551:b0:3a5:3b80:8f58 with SMTP id 38308e7fff4ca-3a63056a748mr6382501fa.6.1790175397496;
        Wed, 23 Sep 2026 07:56:37 -0700 (PDT)
Received: from localhost.localdomain ([78.40.184.2])
        by smtp.gmail.com with ESMTPSA id 38308e7fff4ca-3a62f53b4efsm7512171fa.39.2026.09.23.07.56.36
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 23 Sep 2026 07:56:36 -0700 (PDT)
From: Roman Demidov <roman.demidov.nn@gmail.com>
To: stable@vger.kernel.org,
	Greg Kroah-Hartman <gregkh@linuxfoundation.org>
Cc: Roman Demidov <roman.demidov.nn@gmail.com>,
	Alex Deucher <alexander.deucher@amd.com>,
	=?UTF-8?q?Christian=20K=C3=B6nig?= <christian.koenig@amd.com>,
	David Airlie <airlied@linux.ie>,
	Daniel Vetter <daniel@ffwll.ch>,
	Kees Cook <kees@kernel.org>,
	Andy Shevchenko <andy@kernel.org>,
	Sasha Levin <sashal@kernel.org>,
	Jani Nikula <jani.nikula@intel.com>,
	amd-gfx@lists.freedesktop.org,
	dri-devel@lists.freedesktop.org,
	linux-kernel@vger.kernel.org,
	lvc-project@linuxtesting.org,
	Jesse Zhang <jesse.zhang@amd.com>,
	Fang Wang <32840572@qq.com>
Subject: [PATCH 5.10 3/3] drm/amdgpu: Limit BO list entry count to prevent resource exhaustion
Date: Wed, 23 Sep 2026 17:56:20 +0300
Message-ID: <20260923145622.76242-3-roman.demidov.nn@gmail.com>
X-Mailer: git-send-email 2.53.0
In-Reply-To: <20260923145622.76242-1-roman.demidov.nn@gmail.com>
References: <20260923145622.76242-1-roman.demidov.nn@gmail.com>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit

From: "Jesse.Zhang" <Jesse.Zhang@amd.com>

commit 6270b1a5dab94665d7adce3dc78bc9066ed28bdd upstream.

Userspace can pass an arbitrary number of BO list entries via the
bo_number field. Although the previous multiplication overflow check
prevents out-of-bounds allocation, a large number of entries could still
cause excessive memory allocation (up to potentially gigabytes) and
unnecessarily long list processing times.

Introduce a hard limit of 128k entries per BO list, which is more than
sufficient for any realistic use case (e.g., a single list containing all
buffers in a large scene). This prevents memory exhaustion attacks and
ensures predictable performance.

Return -EINVAL if the requested entry count exceeds the limit

Reviewed-by: Christian König <christian.koenig@amd.com>
Suggested-by: Christian König <christian.koenig@amd.com>
Signed-off-by: Jesse Zhang <jesse.zhang@amd.com>
Signed-off-by: Alex Deucher <alexander.deucher@amd.com>
(cherry picked from commit 688b87d39e0aa8135105b40dc167d74b5ada5332)
Cc: stable@vger.kernel.org
Signed-off-by: Fang Wang <32840572@qq.com>
Signed-off-by: Sasha Levin <sashal@kernel.org>
Signed-off-by: Roman Demidov <roman.demidov.nn@gmail.com>
---
Backport fix for CVE-2026-23468

 drivers/gpu/drm/amd/amdgpu/amdgpu_bo_list.c | 4 ++++
 1 file changed, 4 insertions(+)

diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_bo_list.c b/drivers/gpu/drm/amd/amdgpu/amdgpu_bo_list.c
index 22d7b7c504db..ca0d82be5c9c 100644
--- a/drivers/gpu/drm/amd/amdgpu/amdgpu_bo_list.c
+++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_bo_list.c
@@ -35,6 +35,7 @@
 
 #define AMDGPU_BO_LIST_MAX_PRIORITY	32u
 #define AMDGPU_BO_LIST_NUM_BUCKETS	(AMDGPU_BO_LIST_MAX_PRIORITY + 1)
+#define AMDGPU_BO_LIST_MAX_ENTRIES	(128 * 1024)
 
 static void amdgpu_bo_list_free_rcu(struct rcu_head *rcu)
 {
@@ -230,6 +231,9 @@ int amdgpu_bo_create_list_entry_array(struct drm_amdgpu_bo_list_in *in,
 	const uint32_t bo_number = in->bo_number;
 	struct drm_amdgpu_bo_list_entry *info;
 
+	if (bo_number > AMDGPU_BO_LIST_MAX_ENTRIES)
+		return -EINVAL;
+
 	/* copy the handle array from userspace to a kernel buffer */
 	if (likely(info_size == bo_info_size)) {
 		info = vmemdup_array_user(uptr, bo_number, info_size);
-- 
2.53.0

