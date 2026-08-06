Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7A7513242DF;
	Thu,  6 Aug 2026 04:45:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1785991537; cv=none; b=Fjx5x7P98VMvCpxQKgrxYQrvRl/bBVZ/0/Fcr8w8Mjm1j3yJBhxVfjwl+x+ebgpb7y3+FfSNvmY971fBFXZ2jg7DKZB6ft/PQL5c034sBprw4jj7SUXahxLqdfoo1brdNba3lQC2rlU994D/d7wjoC9NoPZ6nM15Wk3OWsL4qPo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1785991537; c=relaxed/simple;
	bh=3NczoWZQrqLw7zUXyd1SxxJ2hwLtnnTgf389lCOh1EM=;
	h=From:Subject:Date:Message-Id:MIME-Version:Content-Type:To:Cc; b=acuXR/+an1jLYlNU8hiz7OimNIz7tKQFwvbyxP9MxQ6cTQUTBUes3JwbGpf/2LL/Dgd25AVeJeRjFgdIYT9NPcLmmuLFy0clYesykJaYA0tvG0O5KB5q4CR0NhygitxGXhozHi31j6zFFgue9UYUds+1tDnCR/EJ3AW1/UuC3Ug=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=LL5jM+5n; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="LL5jM+5n"
Received: by smtp.kernel.org (Postfix) with ESMTPS id 23AB1C2BCC7;
	Thu,  6 Aug 2026 04:45:37 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1785991537;
	bh=3NczoWZQrqLw7zUXyd1SxxJ2hwLtnnTgf389lCOh1EM=;
	h=From:Subject:Date:To:Cc:Reply-To:From;
	b=LL5jM+5njsttFCBEmFiVVMMjJIizeeW4zuZHHg6f19ICI1B9CHkXfDVGrD8GABEqD
	 FxbCdRHLwRLAkMU1zZql+NDfFw2okc20Ah0jReYB7RcKZjmptq1ZGoa1pKHZ2B4n4F
	 Vx5j27TJ/S80aa0U+yZQ8/hmaWkkObexj4ti/41H7TRnwsv6xNzko7gbO6vjZdK4+M
	 bZgtTGu6sh4gEjI/UiVonhEDiU5MolawgoxGlnR0RakXgLulGAFYkBABdAup53rgv7
	 Ant7sbMiE/O4FWN9Ld/vXb5RmggGYtoeUvEoVn8gklIaTdlIgsU6ILZu3yVh7FeFr6
	 0Q+fhFXc+q+3A==
Received: from aws-us-west-2-korg-lkml-1.web.codeaurora.org (localhost.localdomain [127.0.0.1])
	by smtp.lore.kernel.org (Postfix) with ESMTP id EFC27C55ABF;
	Thu,  6 Aug 2026 04:45:36 +0000 (UTC)
From: Junrui Luo via B4 Relay <devnull+moonafterrain.outlook.com@kernel.org>
Subject: [PATCH 0/3] drm/amdgpu: three independent fixes in the CS and VM
 paths
Date: Thu, 06 Aug 2026 12:45:23 +0800
Message-Id: <20260806-amdgpu-fixes-v1-0-ce247012d4da@outlook.com>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
X-B4-Tracking: v=1; b=H4sIAGMRdGoC/6tWKk4tykwtVrJSqFYqSi3LLM7MzwNyDHUUlJIzE
 vPSU3UzU4B8JSMDIzMDCwMz3cTclPSCUt20zIrUYl3z5FRjS1MDkyRLixQloJaColSwBFBHdGx
 tLQAKb3g2XgAAAA==
X-Change-ID: 20260806-amdgpu-fixes-7ce39504b98d
To: Alex Deucher <alexander.deucher@amd.com>, 
 =?utf-8?q?Christian_K=C3=B6nig?= <christian.koenig@amd.com>, 
 David Airlie <airlied@gmail.com>, Simona Vetter <simona@ffwll.ch>, 
 Jammy Zhou <Jammy.Zhou@amd.com>, Madhav Chauhan <madhav.chauhan@amd.com>, 
 Felix Kuehling <Felix.Kuehling@amd.com>
Cc: amd-gfx@lists.freedesktop.org, dri-devel@lists.freedesktop.org, 
 linux-kernel@vger.kernel.org, Junrui Luo <moonafterrain@outlook.com>, 
 Yuhao Jiang <danisjiang@gmail.com>, stable@vger.kernel.org
X-Mailer: b4 0.14.3
X-Developer-Signature: v=1; a=openpgp-sha256; l=1525;
 i=moonafterrain@outlook.com; h=from:subject:message-id;
 bh=3NczoWZQrqLw7zUXyd1SxxJ2hwLtnnTgf389lCOh1EM=;
 b=owJ4nJvAy8zAJVb4wiKgu++DA+NptSSGrBLBvNWTW3Y78fTEuQfv8c+rUDLLW9JS9XD7vccJR
 gtupd5oYe4oZWEQ42KQFVNkOV5w6ZuF7xbdLT5bkmHmsDKBDGHg4hSAiTCnMDLMbT5YejfL+Zv8
 +nWVG4/UeH3gEn62SFJ+6tGLmXIblhVtYmT4pWtubK/6lOspy8k1JVxHC37N3Jx2Wf/4B8EKXtX
 1f4UZABziSXk=
X-Developer-Key: i=moonafterrain@outlook.com; a=openpgp;
 fpr=C770D2F6384DB42DB44CB46371E838508B8EF040
X-Endpoint-Received: by B4 Relay for moonafterrain@outlook.com/default with
 auth_id=909
X-Original-From: Junrui Luo <moonafterrain@outlook.com>
Reply-To: moonafterrain@outlook.com

Three independent fixes; no dependency between them, they can be applied
or dropped individually.

Patch 1 rejects submissions carrying more than one AMDGPU_CHUNK_ID_FENCE
chunk.  p->uf_bo is a single-slot field, so every FENCE chunk but the last
leaks a BO reference that outlives handle close and process exit.

Patch 2 clamps the rounded-up entry count in amdgpu_vm_update_range().
Where AMDGPU_GPU_PAGES_IN_CPU_PAGE is greater than 1, a mapping whose GPU
page count is not a multiple of it can round num_entries up past what the
cursor holds and trip BUG_ON(size > cur->remaining) in amdgpu_res_next().
4K-page hosts are unaffected.

Patch 3 adds the mapping offset when computing the CPU-side pointer to an
IB in amdgpu_cs_patch_ibs().  The page tables are programmed from
mapping->offset, so for a mapping created with a non-zero offset_in_bo the
kernel inspects different bytes than the GPU executes.

Signed-off-by: Junrui Luo <moonafterrain@outlook.com>
---
Junrui Luo (3):
      drm/amdgpu: disallow multiple FENCE chunks in one submit
      drm/amdgpu: fix VM update overrun on non-4K page kernels
      drm/amdgpu: add the BO-va mapping offset when kmapping an IB

 drivers/gpu/drm/amd/amdgpu/amdgpu_cs.c | 6 +++++-
 drivers/gpu/drm/amd/amdgpu/amdgpu_vm.c | 5 +++--
 2 files changed, 8 insertions(+), 3 deletions(-)
---
base-commit: 075b74841bd0065a3bda3440873c747938e69b68
change-id: 20260806-amdgpu-fixes-7ce39504b98d

Best regards,
-- 
Junrui Luo <moonafterrain@outlook.com>


