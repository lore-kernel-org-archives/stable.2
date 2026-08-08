Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 40DE03191D6;
	Sat,  8 Aug 2026 11:17:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1786187838; cv=none; b=u7t6ZEFM2vQ4p1pFfxxBc3RpVL66iNqZWkamMmpTY1+8e5xVasQT6D/pF9exf+I5boNUytnqeByW7EInbozPKqT8WhA5sxqNYbvz0nKZ4Z2BQK1/X1R0jf79CXLHN9IG3xMkyhVvR697kJKXTZv8jvcS/qMgm1k7pVFjUTPhzW0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1786187838; c=relaxed/simple;
	bh=qBJ2yKuCe+qydBAwBPNKgkU4vVCYc0ywAbFKq6nD8ZM=;
	h=From:Subject:Date:Message-Id:MIME-Version:Content-Type:To:Cc; b=jI598uO5bLkpm1uZimwAksI00XCPgKcUexRNzml2uk4osVKDd0P8QEA/lKQMVX8XzP5lScnYDjk1sNQfp+lTL8zAo2M7DwrA7njTVlM6ObFTSmUeBvj88JGlWftyGdwdlj/7hmLzrrBOCFrQtAwzdSYbmKdtarDYqybuE6CyN10=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=ZCHQ8FPS; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="ZCHQ8FPS"
Received: by smtp.kernel.org (Postfix) with ESMTPS id C87BBC2BCB8;
	Sat,  8 Aug 2026 11:17:17 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1786187837;
	bh=qBJ2yKuCe+qydBAwBPNKgkU4vVCYc0ywAbFKq6nD8ZM=;
	h=From:Subject:Date:To:Cc:Reply-To:From;
	b=ZCHQ8FPSUccVzKfrkcCh1a1gJaDqcz4XxcRFoGuxVU8xJoKRAgH7ItI7wYg4IRmfA
	 c5PFu6EVlvgP0U3AD0YnvGDbw30KvjOANcl8WVa4cFBNAjihn7QuwFp/9bp7fgrIi5
	 P5j1EyS+PTamHo0MFrfY7FmHoNDPjUT4zcvVg2iTUidkmoZhB8R1mlSuWn1KjL8ZVO
	 /wVVZPRDdSrTIEk7/K1YONMfBDdnxSiM8Q7nmOirOK2X2NDsxFHonYjEHTxMj67HZa
	 u8V/uwSF10ccjqm9/lTwwWkkA/0xHpNvivfq4Mh7ZQSztEyDmWjHXrdGg9crF628au
	 sg+2NSSl+uM5A==
Received: from aws-us-west-2-korg-lkml-1.web.codeaurora.org (localhost.localdomain [127.0.0.1])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 8B213C55174;
	Sat,  8 Aug 2026 11:17:17 +0000 (UTC)
From: Junrui Luo via B4 Relay <devnull+moonafterrain.outlook.com@kernel.org>
Subject: [PATCH 0/2] drm/nouveau: fix unbounded kernel allocations in the
 VM_BIND uAPI
Date: Sat, 08 Aug 2026 19:14:16 +0800
Message-Id: <20260808-nouveau-fixes-v1-0-c3ebdc17a89c@outlook.com>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
X-B4-Tracking: v=1; b=H4sIAIgPd2oC/x3LQQqAIBBA0avErBOmxJSuEi2kxpqNhqIE4t2Tl
 o/Pr5AoMiVYhwqRCicOvmMaBzhu6y8SfHbDjPOCBo3wIReyWTh+KQmNVqOTTkmjoD9PpD/0Zdt
 b+wB+fx5PXwAAAA==
X-Change-ID: 20260808-nouveau-fixes-70a70f3f5385
To: Lyude Paul <lyude@redhat.com>, Danilo Krummrich <dakr@kernel.org>, 
 Maarten Lankhorst <maarten.lankhorst@linux.intel.com>, 
 Maxime Ripard <mripard@kernel.org>, Thomas Zimmermann <tzimmermann@suse.de>, 
 David Airlie <airlied@gmail.com>, Simona Vetter <simona@ffwll.ch>, 
 Dave Airlie <airlied@redhat.com>
Cc: dri-devel@lists.freedesktop.org, nouveau@lists.freedesktop.org, 
 linux-kernel@vger.kernel.org, Junrui Luo <moonafterrain@outlook.com>, 
 Yuhao Jiang <danisjiang@gmail.com>, stable@vger.kernel.org
X-Mailer: b4 0.14.3
X-Developer-Signature: v=1; a=openpgp-sha256; l=1742;
 i=moonafterrain@outlook.com; h=from:subject:message-id;
 bh=qBJ2yKuCe+qydBAwBPNKgkU4vVCYc0ywAbFKq6nD8ZM=;
 b=owJ4nJvAy8zAJVb4wiKgu++DA+NptSSGrHIBi08MP5l7s2M5cmvP935cMcdbe8FB18a7p2qY4
 pM25joLhneUsjCIcTHIiimyHC+49M3Cd4vuFp8tyTBzWJlAhjBwcQrARMqaGf4Z2ulnzsx4d9bo
 58z72/0/zZwTbj9T+eCtRXNZ9KbJy5g9ZWSYuTR56f3IApbIlssn3+0oj+IVqd5T+CNHMNXYdfX
 hfnFGAOcWSP0=
X-Developer-Key: i=moonafterrain@outlook.com; a=openpgp;
 fpr=C770D2F6384DB42DB44CB46371E838508B8EF040
X-Endpoint-Received: by B4 Relay for moonafterrain@outlook.com/default with
 auth_id=909
X-Original-From: Junrui Luo <moonafterrain@outlook.com>
Reply-To: moonafterrain@outlook.com

Two independent fixes to the uAPI added by b88baab82871 ("drm/nouveau:
implement new VM_BIND uAPI").

Patch 1 bounds the sync and operation counts in EXEC and VM_BIND.
nouveau_exec_ucopy() and nouveau_uvmm_vm_bind_ucopy() hand user-supplied
u32 counts straight to u_memcpya(), which only rejects multiplication
overflow -- something a u32 count times a small element size never
reaches on 64-bit.  A wait_count of 0xffffffff thus becomes a 64 GB
vmemdup_user() request: above INT_MAX that trips the WARN_ON_ONCE() in
__kvmalloc_node_noprof(), and below it the kernel attempts a vmalloc of
up to 2 GB that GFP_USER leaves uncharged to the caller's memcg.

Patch 2 rejects a second VM_INIT.  nouveau_uvmm_ioctl_vm_init() never
checks whether the client already has a GPU VA space before overwriting
cli->uvmm.ptr, so a second call orphans the first nouveau_uvmm with no
remaining reference to it.  The orphan, its drm_gpuvm, that gpuvm's
reservation object and its region maple tree are never freed, the buffer
objects mapped in it stay pinned, and its nvif vmm keeps the GPU page
directories allocated until the file is closed.

Signed-off-by: Junrui Luo <moonafterrain@outlook.com>
---
Junrui Luo (2):
      drm/nouveau: bound sync and op counts in EXEC and VM_BIND
      drm/nouveau/uvmm: reject a second VM_INIT

 drivers/gpu/drm/nouveau/nouveau_exec.c | 12 ++++++++++++
 drivers/gpu/drm/nouveau/nouveau_uvmm.c | 24 ++++++++++++++++++++++++
 include/uapi/drm/nouveau_drm.h         | 18 ++++++++++++++++++
 3 files changed, 54 insertions(+)
---
base-commit: 075b74841bd0065a3bda3440873c747938e69b68
change-id: 20260808-nouveau-fixes-70a70f3f5385

Best regards,
-- 
Junrui Luo <moonafterrain@outlook.com>


