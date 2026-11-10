Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=100.103.45.18
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1794272734;
	b=Row6IO/mfkGxEweqh5pFjBEEEvy0oi5Xtw7hfXgS8eTFWUhqkf5HjsI1iEQinYYrjbK+
	 B3mBw9VfzXclkfdOBKU6mkc/pJNqSwpTPNubCyCiAaGnI5P7PDikWoumsf/l+gos0Kewr
	 3+xPNJdpnNbp6ApBizZ3P7fMXUmNkNHlQs/HbSyrz1hOGSsw7aH0OVN4RaUfqY/LgpoDR
	 OJ/ZNW5rZL2oPtn5hgR2xJto0/9ECi5L2a4pRQW1l9m77EnThEsg/a/l+VRxMA2paye9J
	 3k5mXUFaSjMxCbnusdfcs2YXBQynGZQBHBAwktfnaNosoQ0Q0SKDJnmJvJDn//8sYFg==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1794272734;
	h=Received:DKIM-Signature:From:To:Cc:Subject:Date:Message-ID:X-Mailer:
	 MIME-Version:Content-Type:Content-Transfer-Encoding;
	bh=y3xNZGzHQ3EfCA97EgJ/CwtiohO9gfpqJhq7Wtjr5fQ=;
	b=W/SYNZ+sWWU/mOgHzRPSLTAJ9qk57UgVUWAGRdzEETPXShRNWAhEsFHWd8Ee1nD5TWk/
	 QlXmqczsIMfoPr1aN3ZYZhfHdUEfyGSrmAkrSZwSzhUIfDhOvrsImTt0Sl8LKoqdQrV4H
	 tIYZhRgPN8mmFQ54l3GHMTfZ70jkZO+5R03eFRf0keKOoxLXLyLwuOUORq6oz9FuTuz40
	 0DCMpTcky3/xHOtaIXd5G8J5WLN02qhwVFqYi5nWzVBgD1bVLumEVbcnCwBJ2oRlvJhJj
	 tiRQYWMMarQDUnSDV0DYwfM2QAfG17FLQBHfaZ93k/rESrJt6nYaQ88X51cdYrTnvdg==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dkim=pass header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=hbq0TnUd;
	arc=none smtp.remote-ip=100.103.45.18
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 83FDD606A31C
	for <stable@vger.kernel.org>; Tue, 10 Nov 2026 01:05:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=hbq0TnUd
Received: by smtp.kernel.org (Postfix) with ESMTPSA id D54471F0089F;
	Tue, 10 Nov 2026 01:05:33 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1794272734;
	bh=y3xNZGzHQ3EfCA97EgJ/CwtiohO9gfpqJhq7Wtjr5fQ=;
	h=From:To:Cc:Subject:Date;
	b=hbq0TnUdws31dUSlOxQK+QsyrqDUU20TnqGdyFlor0wV6HEIeUfvv5AlBD7ZViAKt
	 G+SBeN5AZi0PPCao9yf9AAG937RYG/WwHuApCd8RaXnMoSrrHvitV0Ow/MgA0otEK/
	 fQF+uNtD8CRkmjesEgEF3RnNgOfqx8lPn3FXoxqNgeT+FjD0evKGBFJN+xZ5lrmiQv
	 MQ8wi3ipLYISW/tOdWh2659IeE3msk+xSRZw1mGOUxKuiRI3ZwPrU9FZQEgxgOxfWG
	 l2SKPtewBWguafiIk5X/5VL1CDZwuVAJTVu5IXpqJgUwo4oaGQsbfssqHfCTOIXqwr
	 vzJzBM2XxMkaw==
From: Sasha Levin <sashal@kernel.org>
To: jesse.zhang@amd.com,
	christian.koenig@amd.com,
	alexander.deucher@amd.com
Cc: stable@vger.kernel.org
Subject: FAILED: patch "[PATCH] drm/amdgpu: sign extend the addresses GEM_OP(GET_MAPPING_INFO) returns" failed to apply to 6.18-stable tree
Date: Mon,  9 Nov 2026 20:05:32 -0500
Message-ID: <20261109200532-failed-6.18-37cfaaa6b5e9@kernel.org>
X-Mailer: git-send-email 2.53.0
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Post: <mailto:stable@vger.kernel.org>
List-Help: <mailto:stable+help@vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
List-Owner: <mailto:stable+owner@vger.kernel.org>
Precedence: list
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
git cherry-pick -x 37cfaaa6b5e9448ef786342d470d0e0b8eb89fa6
# <resolve conflicts, build, test, etc.>
git commit -s
git send-email --to '<stable@vger.kernel.org>' --in-reply-to '20261109200532-failed-6.18-37cfaaa6b5e9@kernel.org' --subject-prefix 'PATCH 6.18.y' 'HEAD^..'

Thanks,
Sasha

------------------ original commit in Linus's tree ------------------

From 37cfaaa6b5e9448ef786342d470d0e0b8eb89fa6 Mon Sep 17 00:00:00 2001
From: Jesse Zhang <Jesse.Zhang@amd.com>
Date: Tue, 20 Oct 2026 10:15:22 +0800
Subject: [PATCH] drm/amdgpu: sign extend the addresses
 GEM_OP(GET_MAPPING_INFO) returns
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit

GEM_VA takes the GPU virtual addresses above the VA hole sign extended,
like the rest of the UAPI, but GET_MAPPING_INFO reports them without the
upper bits, so they land in the hole. Mappings in the upper half of the
address space can't be recreated or removed with what it returns. On
navi31:

  MAP at 0xffff800100000000                 -> 0
  GET_MAPPING_INFO                          -> addr 0x800100000000
  UNMAP at 0x800100000000                   -> -EINVAL

Sign extend the addresses before handing them out.

Fixes: 4d82724f7f2b ("drm/amdgpu: Add mapping info option for GEM_OP ioctl")
Reviewed-by: Christian König <christian.koenig@amd.com>
Signed-off-by: Jesse Zhang <Jesse.Zhang@amd.com>
Signed-off-by: Alex Deucher <alexander.deucher@amd.com>
(cherry picked from commit 9d5524a339390da9145b19bfb40da45640332fb3)
Cc: stable@vger.kernel.org
---
 drivers/gpu/drm/amd/amdgpu/amdgpu_gem.c | 7 +++++--
 1 file changed, 5 insertions(+), 2 deletions(-)

diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_gem.c b/drivers/gpu/drm/amd/amdgpu/amdgpu_gem.c
index 3962b9f08dd67..3b8b089c258ed 100644
--- a/drivers/gpu/drm/amd/amdgpu/amdgpu_gem.c
+++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_gem.c
@@ -1064,6 +1064,7 @@ int amdgpu_gem_va_ioctl(struct drm_device *dev, void *data,
 int amdgpu_gem_op_ioctl(struct drm_device *dev, void *data,
 			struct drm_file *filp)
 {
+	struct amdgpu_device *adev = drm_to_adev(dev);
 	struct drm_amdgpu_gem_op *args = data;
 	struct drm_gem_object *gobj;
 	struct amdgpu_vm_bo_base *base;
@@ -1170,7 +1171,8 @@ int amdgpu_gem_op_ioctl(struct drm_device *dev, void *data,
 
 		amdgpu_vm_bo_va_for_each_valid_mapping(bo_va, mapping) {
 			if (num_mappings < args->num_entries) {
-				vm_entries[num_mappings].addr = mapping->start * AMDGPU_GPU_PAGE_SIZE;
+				vm_entries[num_mappings].addr =
+					amdgpu_gmc_sign_extend(mapping->start * AMDGPU_GPU_PAGE_SIZE);
 				vm_entries[num_mappings].size = (mapping->last - mapping->start + 1) * AMDGPU_GPU_PAGE_SIZE;
 				vm_entries[num_mappings].offset = mapping->offset;
 				vm_entries[num_mappings].flags = mapping->flags;
@@ -1180,7 +1182,8 @@ int amdgpu_gem_op_ioctl(struct drm_device *dev, void *data,
 
 		amdgpu_vm_bo_va_for_each_invalid_mapping(bo_va, mapping) {
 			if (num_mappings < args->num_entries) {
-				vm_entries[num_mappings].addr = mapping->start * AMDGPU_GPU_PAGE_SIZE;
+				vm_entries[num_mappings].addr =
+					amdgpu_gmc_sign_extend(mapping->start * AMDGPU_GPU_PAGE_SIZE);
 				vm_entries[num_mappings].size = (mapping->last - mapping->start + 1) * AMDGPU_GPU_PAGE_SIZE;
 				vm_entries[num_mappings].offset = mapping->offset;
 				vm_entries[num_mappings].flags = mapping->flags;
-- 
2.53.0




