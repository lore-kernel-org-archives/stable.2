Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id AC4CD4052B6;
	Mon, 10 Aug 2026 16:17:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1786378668; cv=none; b=DPleSHhn3HMeT8z31JXuZfsVjHdYUzhV/eLDh8TPfCbPxO7yKJQm0iumGceHMLHbFjZLAq77yGiedFJfKU/eJ6HjP3wJh6DhVTNjGlbJy5ezSlTaDIJ9JZRmgVy/7FFpOobX4UyEhyGveUKyHX3REdcippB35fcepZtZN6VDdKk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1786378668; c=relaxed/simple;
	bh=e7qU4DwQRhkwQZ7bRxaFZbYgsVTpDVtdRWvEtA7dFMA=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=FSgPN5o2edp+P2MtkrG28kHJ6/WrHRy6Y1DkNcqYh2gGvZO/c6JmgTRsE4tw7QhHOG8v+vRdAAHBbUGqfbFJu5BkkEn4jCEoZ30ho7ze7vV2js34nI5eBE8OnEL/6rn9w9nzAGSd5vjJuKfgWZH9RtdTGhnP95RcWF8MCKSiHl4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=N2yDUZHU; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="N2yDUZHU"
Received: by smtp.kernel.org (Postfix) with ESMTPS id 0D024C2BCFB;
	Mon, 10 Aug 2026 16:17:48 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1786378668;
	bh=e7qU4DwQRhkwQZ7bRxaFZbYgsVTpDVtdRWvEtA7dFMA=;
	h=From:Date:Subject:References:In-Reply-To:To:Cc:Reply-To:From;
	b=N2yDUZHUC+IiL1ijHjfMJnnBZdHY8+FrZXfujPqROiUzMIRwWzXXQaV0pg+4b71R+
	 iLgvFXIoU9QJrpVoLy39ERqqLbjpwDV7w9vRyR7wmaCmjOrVoTVv27X0IgqzqfGGuQ
	 tVztO48l8TE0ACnyKtMlo2J8zOolDMwREwqXaQSxmZ50QOF7DeB1yy8bE19qRyy0xN
	 9Z1wKjyXwfKZn3yXy5imLzmeRwaKSr5OysXS3NV7zG5u8OjY6gfbp6qp3TvNuV4k6E
	 qmzIFa4OWQj3tUwc6QcvIXj+oYjrCaXeFigq31AsfE/DHtTiceqomoqw0V4pn8EAWJ
	 kWCkQOvlzruJA==
Received: from aws-us-west-2-korg-lkml-1.web.codeaurora.org (localhost.localdomain [127.0.0.1])
	by smtp.lore.kernel.org (Postfix) with ESMTP id EDE7DC5B56A;
	Mon, 10 Aug 2026 16:17:47 +0000 (UTC)
From: Junrui Luo via B4 Relay <devnull+moonafterrain.outlook.com@kernel.org>
Date: Tue, 11 Aug 2026 00:13:14 +0800
Subject: [PATCH 5/5] drm/amdgpu: free userptr HMM ranges on the CS error
 path
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20260811-amdgpu-fixes-v1-5-4954a417b8ff@outlook.com>
References: <20260811-amdgpu-fixes-v1-0-4954a417b8ff@outlook.com>
In-Reply-To: <20260811-amdgpu-fixes-v1-0-4954a417b8ff@outlook.com>
To: Alex Deucher <alexander.deucher@amd.com>, 
 =?utf-8?q?Christian_K=C3=B6nig?= <christian.koenig@amd.com>, 
 David Airlie <airlied@gmail.com>, Simona Vetter <simona@ffwll.ch>, 
 Sumit Semwal <sumit.semwal@linaro.org>, Junwei Zhang <Jerry.Zhang@amd.com>, 
 =?utf-8?q?Nicolai_H=C3=A4hnle?= <nicolai.haehnle@amd.com>, 
 Prike Liang <Prike.Liang@amd.com>, Arvind Yadav <arvind.yadav@amd.com>, 
 Shashank Sharma <shashank.sharma@amd.com>, Leo Liu <leo.liu@amd.com>, 
 Felix Kuehling <Felix.Kuehling@amd.com>
Cc: amd-gfx@lists.freedesktop.org, dri-devel@lists.freedesktop.org, 
 linux-kernel@vger.kernel.org, linux-media@vger.kernel.org, 
 linaro-mm-sig@lists.linaro.org, Junrui Luo <moonafterrain@outlook.com>, 
 Yuhao Jiang <danisjiang@gmail.com>, stable@vger.kernel.org
X-Mailer: b4 0.14.3
X-Developer-Signature: v=1; a=openpgp-sha256; l=2404;
 i=moonafterrain@outlook.com; h=from:subject:message-id;
 bh=L6QMfmjG08GEYgq6Lvgjn+rT+rJCq+Q7xLdhBvY9+GU=;
 b=owJ4nJvAy8zAJVb4wiKgu++DA+NptSSGrMqfy6RfzJuy89+X84usVeOvsxZ2dRd+fvO2Y3GL7
 G0m597euRkdpSwMYlwMsmKKLMcLLn2z8N2iu8VnSzLMHFYmkCEMXJwCMJHHnxkZvjsd3j4/vThq
 p2rz6jjX/GVveLbFf9zL6NGSKFRhWnulg5Fh2dX9fdNlpNndDOxbPjf+kJn0MMVvVnP40Zi8st8
 xCrz8AHwXTaI=
X-Developer-Key: i=moonafterrain@outlook.com; a=openpgp;
 fpr=C770D2F6384DB42DB44CB46371E838508B8EF040
X-Endpoint-Received: by B4 Relay for moonafterrain@outlook.com/default with
 auth_id=909
X-Original-From: Junrui Luo <moonafterrain@outlook.com>
Reply-To: moonafterrain@outlook.com

From: Junrui Luo <moonafterrain@outlook.com>

amdgpu_cs_parser_bos() allocates a struct amdgpu_hmm_range for every
userptr entry of the BO list and returns with them live. They are only
released in two places: the out_free_user_pages label in
amdgpu_cs_parser_bos() itself, and the invalidation check loop in
amdgpu_cs_submit().

Every error edge between those two points leaks. A failure in
amdgpu_cs_patch_jobs(), amdgpu_cs_vm_handling() or amdgpu_cs_sync_rings(),
or an early return from amdgpu_cs_submit() before its release loop, jumps
to error_fini and falls into amdgpu_cs_parser_fini(), which never walks
the BO list for userptr ranges. An IB address with no VM mapping is enough
to get there: amdgpu_cs_patch_ibs() returns the -EINVAL that
amdgpu_cs_find_mapping() hands back, so the leak is repeatable at will
from an unprivileged render node fd. Each leaked entry costs a struct
amdgpu_hmm_range plus its hmm_pfns array, a kvmalloc_array() of one entry
per page of the userptr mapping, allocated with plain GFP_KERNEL and so
not charged to the caller's memory cgroup.

Release the ranges in amdgpu_cs_parser_fini(), which every path out of
amdgpu_cs_ioctl() passes through. amdgpu_hmm_range_free() ignores a NULL
range, so the success path, where amdgpu_cs_submit() has already freed and
cleared them, is unaffected.

Fixes: fec8fdb54e8f ("drm/amdgpu: fix userptr HMM range handling v2")
Reported-by: Yuhao Jiang <danisjiang@gmail.com>
Assisted-by: Claude:claude-opus-5
Cc: stable@vger.kernel.org
Signed-off-by: Junrui Luo <moonafterrain@outlook.com>
---
 drivers/gpu/drm/amd/amdgpu/amdgpu_cs.c | 10 ++++++++++
 1 file changed, 10 insertions(+)

diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_cs.c b/drivers/gpu/drm/amd/amdgpu/amdgpu_cs.c
index 617f53f135f3..17c4fec21402 100644
--- a/drivers/gpu/drm/amd/amdgpu/amdgpu_cs.c
+++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_cs.c
@@ -1416,6 +1416,16 @@ static void amdgpu_cs_parser_fini(struct amdgpu_cs_parser *parser)
 				amdgpu_vm_bo_invalidate(bo, false);
 			}
 		}
+
+		/*
+		 * Release the ranges still live on the error paths;
+		 * amdgpu_cs_submit() already freed and cleared them when it
+		 * got far enough to check them for invalidation.
+		 */
+		amdgpu_bo_list_for_each_userptr_entry(e, parser->bo_list) {
+			amdgpu_hmm_range_free(e->range);
+			e->range = NULL;
+		}
 		amdgpu_bo_list_put(parser->bo_list);
 	}
 

-- 
2.51.2


