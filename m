Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=100.103.45.18
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1794452291;
	b=qx+G91YOk+KE89GW8ewCSiVOT2z0gVF3V9aM4iuxxRG52CS081nWgYapCimlKeSL9lME
	 HSCl4RDqxiEuPPuH/gULEr6J77e7a/hZejOg//UBTWEDXEz2k+sReeml05OblCITFc0zC
	 jOMYJZiYnVlu309Rsw6XSPSgHolk2i/5oJ1Imj4A76ze+Hpwd/t30j0HLbsb5GJrt9gUd
	 ODor0gfHxm3Hd2u0M7Mpi4aX5Q1sxUyXEYILhrfOfsiPR7qjxO4PsfPgrcW01omiIDHfn
	 uHCbYbOn6VUYG5MaIN4sSPFhNM2duvWmbtHKo3H4yYOLuDBWiPunnn304sbdzjImsRA==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1794452291;
	h=Received:DKIM-Signature:From:To:Cc:Subject:Date:Message-ID:X-Mailer:
	 In-Reply-To:References:MIME-Version:Content-Type:
	 Content-Transfer-Encoding;
	bh=3wwknJ1E5ztHiETDYKjWfcwp4caCIPZZ1NP+ZAX6Adw=;
	b=yHWVUhwxJw8MKVvKmiR6LasFtj6RW6T7vzDZT2ZjbCUsK1DwVDWexHhwqfv88er4ih5Z
	 tVVhspyUxwUKjgULD+4gSynH+oe+dmzA8npUnvRSkiHwXAvg0OBArSO1LR/8aPQpQ1uG5
	 RqwqQrIxkDnM1RcVPURPiK5Fbnox0QAmf6qcJh33Fzmrl2x7FlB127VQ4TYHex61EgS1b
	 V1dpKpOOkK5Z0aXRRKuL3K2u8uGEpllVCjRuR0FVKm2LR/x2fu1AdAq/MlkSjtONaObMC
	 OSfBHQdnAB1JwL8pVXddDFeY1JcdES1HNa9Wi9WbLprrSQSDV6+3UU/WtOW4JkIC3og==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dkim=pass header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=Y4W3JUGk;
	arc=none smtp.remote-ip=100.103.45.18
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 35729606A31C
	for <stable@vger.kernel.org>; Thu, 12 Nov 2026 02:58:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=Y4W3JUGk
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 2DB5C1F00A05;
	Thu, 12 Nov 2026 02:58:10 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1794452290;
	bh=3wwknJ1E5ztHiETDYKjWfcwp4caCIPZZ1NP+ZAX6Adw=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References;
	b=Y4W3JUGkK6H8xvouZ+Ltdh4C11p9kqJsOhtjZen/t0TzTARLJjJOI+oPNlNOjBuZS
	 jZaq3BeSEMZvz4aGIz6HgXcW7LwGmdtOqVxiSF7ii2mp2XQ1qvDgz3pHBzwlCClB8R
	 KuZBTLgyDsoTsTPdYL4Mf+CfRf8vkOtDwU3xQgdEgZvUjPKnenP0vkW71+xWDAPz8I
	 tvhKrvzOGXfcbVQ9mIYokqi1/o3xeSQ1rR9BHyH7QDYGJETWjkHD8NR8YJqTBYF7lk
	 nOOial/6gAzAyfri8DxR3Q/422W/skRgwKWrO3dbuIVuFo4LdQ1y5cDQ+V6dYy3eM7
	 R4vlfB3gHI/7w==
From: Sasha Levin <sashal@kernel.org>
To: stable@vger.kernel.org
Cc: Jesse Zhang <Jesse.Zhang@amd.com>,
	=?UTF-8?q?Christian=20K=C3=B6nig?= <christian.koenig@amd.com>,
	Alex Deucher <alexander.deucher@amd.com>,
	Sasha Levin <sashal@kernel.org>
Subject: [PATCH 6.18.y] drm/amdgpu: sign extend the addresses GEM_OP(GET_MAPPING_INFO) returns
Date: Wed, 11 Nov 2026 21:58:09 -0500
Message-ID: <20261112025753.1442145-1-sashal@kernel.org>
X-Mailer: git-send-email 2.53.0
In-Reply-To: <20261109200532-failed-6.18-37cfaaa6b5e9@kernel.org>
References: <20261109200532-failed-6.18-37cfaaa6b5e9@kernel.org>
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

From: Jesse Zhang <Jesse.Zhang@amd.com>

[ Upstream commit 37cfaaa6b5e9448ef786342d470d0e0b8eb89fa6 ]

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
[ sashal: Omitted the unused adev declaration because amdgpu_gmc_sign_extend() is an inline function with fixed address limits. ]
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 drivers/gpu/drm/amd/amdgpu/amdgpu_gem.c | 6 ++++--
 1 file changed, 4 insertions(+), 2 deletions(-)

diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_gem.c b/drivers/gpu/drm/amd/amdgpu/amdgpu_gem.c
index 3b03157faa7e8..d9548f97986ea 100644
--- a/drivers/gpu/drm/amd/amdgpu/amdgpu_gem.c
+++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_gem.c
@@ -1118,7 +1118,8 @@ int amdgpu_gem_op_ioctl(struct drm_device *dev, void *data,
 
 		amdgpu_vm_bo_va_for_each_valid_mapping(bo_va, mapping) {
 			if (num_mappings < args->num_entries) {
-				vm_entries[num_mappings].addr = mapping->start * AMDGPU_GPU_PAGE_SIZE;
+				vm_entries[num_mappings].addr =
+					amdgpu_gmc_sign_extend(mapping->start * AMDGPU_GPU_PAGE_SIZE);
 				vm_entries[num_mappings].size = (mapping->last - mapping->start + 1) * AMDGPU_GPU_PAGE_SIZE;
 				vm_entries[num_mappings].offset = mapping->offset;
 				vm_entries[num_mappings].flags = mapping->flags;
@@ -1128,7 +1129,8 @@ int amdgpu_gem_op_ioctl(struct drm_device *dev, void *data,
 
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

