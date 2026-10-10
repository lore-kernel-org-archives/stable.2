Received: from sender6-op-o11.zoho.com (sender6-op-o11.zoho.com [165.173.180.11])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3916C362120;
	Sat, 10 Oct 2026 20:19:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=165.173.180.11
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1791663563; cv=pass; b=DrB4bJcI3bXzoQoSezk1jP/q7ct3ZNiqRDWLalpqInlfUOlNY6vml1Zgjr+vOGeR0Lcl/hAQ+HjJnS5WgSWzCNccLLZUJutuWQODLFE4ncIGItfsLKo2nglXKMV3bSmlcc2Jsnv+njcuQpHxTlk8RUTm4F0EB00rUy19mWmTsHU=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1791663563; c=relaxed/simple;
	bh=tzURnxnQ2R/KUu8hxuMAJnmspyGBKVtIUV8hHbAJ8kU=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=iK86CX1jh+YWPhKPLx0Hc7liFfpEy0uSF8VChmrIDP7MOx/+aMWxds1PHlqbFDjRhJ/KaKpeXM7hJ0QfjWm7e2tF7ERlcBa07b5Xiwy7dqXhcSZH+nnl9SwLyDtnqv3LPHgN1aeNTbf8g09+iURnDMuHlC0rR8YUN6BQGVEIRyQ=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=collabora.com; spf=pass smtp.mailfrom=collabora.com; dkim=pass (1024-bit key) header.d=collabora.com header.i=dmitry.osipenko@collabora.com header.b=bKepcU/U; arc=pass smtp.client-ip=165.173.180.11
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=collabora.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=collabora.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=collabora.com header.i=dmitry.osipenko@collabora.com header.b="bKepcU/U"
ARC-Seal: i=1; a=rsa-sha256; t=1791663546; cv=none; 
	d=zohomail.com; s=zohoarc; 
	b=DQ2vfMmhnUm4hE/dkcpkXKloV4x4qCl3l4A2sqrmocj0ng7dkRwd97nJCNw2yYq1sfumR1unGvaG+W0DpxzxqMboFATzAA0QzMujt43hLMBzQPGQCyx6a8r976o336URr+ESWuhqdbZmFitQ7T1umnI7h65s8qU2OSAk2FsOdFw=
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=zohomail.com; s=zohoarc; 
	t=1791663546; h=Content-Type:Content-Transfer-Encoding:Cc:Cc:Date:Date:From:From:In-Reply-To:MIME-Version:Message-ID:Subject:Subject:To:To:Message-Id:Reply-To; 
	bh=vrWGR9SAVLhrNl8QfDeyWpcETJt0y8/ezyo4jgasdzI=; 
	b=CR5PWmnmakhEyzpOo2Y0ljlVaCLB8fvY7Fy11n8va+FBVeurtXSala4dnPiLIbpZ31hLoCkQciTFgzS6atzN3aumeVYRF5LeTEi1uf6s4ReXVi1AD2CRbpkHbnVx8f7aFgtD79FOfbQ50fLQEkoXf1juwxbv7U1QMhc7DpT2/dI=
ARC-Authentication-Results: i=1; mx.zohomail.com;
	dkim=pass  header.i=collabora.com;
	spf=pass  smtp.mailfrom=dmitry.osipenko@collabora.com;
	dmarc=pass header.from=<dmitry.osipenko@collabora.com>
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; t=1791663546;
	s=zohomail; d=collabora.com; i=dmitry.osipenko@collabora.com;
	h=Message-ID:Date:Date:MIME-Version:Subject:Subject:To:To:Cc:Cc:From:From:In-Reply-To:Content-Type:Content-Transfer-Encoding:Message-Id:Reply-To;
	bh=vrWGR9SAVLhrNl8QfDeyWpcETJt0y8/ezyo4jgasdzI=;
	b=bKepcU/UlgnVQZv5wRS1OSjU6I/XAqZ/qEM7+AXewsM5xwqE+QNwMwfRxt1hqqjF
	22kvcdqovT7vFl6Yy7zCIC4026+kcneJnsQc3/6VVE7bzSUj8XNaQ34rs6zhmQtq7LJ
	cbpf2Zh54sp5c9kftV+EyIqdWymqmIsf0hSKJHJA=
Received: by smtp.zohomail.com with SMTPS id 1791663545919289.48010554267705;
	Sat, 10 Oct 2026 13:19:05 -0700 (PDT)
Message-ID: <8393a8a2-2ed5-4d63-b937-5d837c1bb1aa@collabora.com>
Date: Sat, 10 Oct 2026 23:19:01 +0300
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH] drm/virtio: reject mappable HOST3D blobs without
 host-visible memory
To: Henry Martin <bsdhenrymartin@gmail.com>, David Airlie
 <airlied@redhat.com>, Gerd Hoffmann <kraxel@redhat.com>,
 Chia-I Wu <olvaffe@gmail.com>, Gurchetan Singh
 <gurchetansingh@chromium.org>,
 Maarten Lankhorst <maarten.lankhorst@linux.intel.com>,
 Maxime Ripard <mripard@kernel.org>, Thomas Zimmermann <tzimmermann@suse.de>,
 Simona Vetter <simona@ffwll.ch>, Junrui Luo <moonafterrain@outlook.com>
Cc: dri-devel@lists.freedesktop.org, virtualization@lists.linux.dev,
 linux-kernel@vger.kernel.org, stable@vger.kernel.org
References: <20261010081059.3096312-1-bsdhenrymartin@gmail.com>
Content-Language: en-US
From: Dmitry Osipenko <dmitry.osipenko@collabora.com>
In-Reply-To: <20261010081059.3096312-1-bsdhenrymartin@gmail.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-ZohoMailClient: External

On 10/10/26 11:10, Henry Martin wrote:
> virtio_gpu_resource_create_blob_ioctl() -> verify_blob() validates
> blob flags, memory type, context and alignment, but never checks
> VIRTGPU_BLOB_FLAG_USE_MAPPABLE against vgdev->has_host_visible.
> 
> For blob_mem == VIRTGPU_BLOB_MEM_HOST3D the blob is created via
> virtio_gpu_vram_create(), and on a device without host-visible
> memory (plain virtio-gpu-pci,blob=on with no hostmem) the failure
> comes too late: the GEM object has been allocated, a host resource
> id taken and the create_blob command issued when
> virtio_gpu_vram_map() returns -EINVAL, and the cleanup calls
> virtio_gpu_vram_free(), which is a no-op while bo->created is still
> false (the host response has not been processed yet).  Every such

virtio_gpu_cmd_resource_create_blob() is invoked before
virtio_gpu_vram_map() in virtio_gpu_vram_create(), hence bo->created is
always true, how come it's false?

-- 
Best regards,
Dmitry
