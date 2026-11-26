Authentication-Results: smtp.subspace.kernel.org; arc=pass header.oldest-pass=0 smtp.remote-ip=165.173.180.11
ARC-Seal: i=2; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=pass;
	t=1795730295;
	b=owVN9DafT6Ng479/rs6hajRUOFgnsmkGMDn20xPhfL64iUzbVZtBss4IIh/4VatMVY2p
	 yrJxkcsDHx+vIsAx2+tR+j2bjQWoP09W1ZxnlQJhK5UKvzX9iTE3JbTqExed+W1UnJRmr
	 nJVVSL69VROPq6nnjtRbZPv59yhOvhOjjw/tKTXyaQ0f0GWAubQ7Wh0qwFvbQ7E+Lsl25
	 CedDV+lIUrmNFJJyzESka/KbCL5fDz52aWVQfDqvV7olPlGEjxuOdTOgJrwbB1Gk7TIf8
	 bI75USiJTBlqmKAFmPDZaDMDHWwfABRmh8nHdBp2Ma0PjYQKcR/FybzONqAeeZtXlHg==
ARC-Message-Signature: i=2; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1795730295;
	h=DMARC-Filter:DKIM-Signature:Received:Date:From:To:Cc:Subject:
	 Message-ID:References:MIME-Version:Content-Type:Content-Disposition:
	 In-Reply-To:X-Zoho-Virus-Status:X-Zoho-AV-Stamp;
	bh=cv1jcP2NCWHHaTZoGDPS2zYOxgzsyVEhti5NT28c/KQ=;
	b=UjvLEyNEc2WsBpjPhoHjylvkpQlk+rIK6C5FdFgPjQknEFD/m89sS89YuZF9kuDrPrMs
	 X8bCAnAQZWgRH6hvp3zrwHwlwJT7PyihOMnCQFCDvsFEhx5zxlthmnBGKTj3f7hliTKQE
	 BiGacRetqgo6B+JB5KVL9aScMsJj2za6znD3WG3y9NZZc3oj3nmxI8NoXs+o1m00FC5QZ
	 a/LgDFzCp86uFy0YmfH9yCuhJ24O0YsaqbnTCwuCZA3IVuJe7PiJH9cOEkTtH6nWKdcZk
	 yRiSTbDz1/1dXf1smMiRhcnnOYoGE9qsDXqcOrhbnpveNlleXFCsfl2rr61CbSbd2XQ==
ARC-Authentication-Results: i=2; smtp.subspace.kernel.org; 
	dmarc=pass header.from=collabora.com;
	spf=pass smtp.mailfrom=collabora.com;
	dkim=pass header.d=collabora.com header.i=@collabora.com header.a=rsa-sha256 header.s=zohomail header.b="NoP/VQTS";
	arc=pass header.oldest-pass=0 smtp.remote-ip=165.173.180.11
Received: from sender6-op-o11.zoho.com (sender6-op-o11.zoho.com [165.173.180.11])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B2E80606A331;
	Thu, 26 Nov 2026 21:58:09 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org B2E80606A331
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=collabora.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=collabora.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=collabora.com header.i=@collabora.com header.a=rsa-sha256 header.s=zohomail header.b=NoP/VQTS
ARC-Seal: i=1; a=rsa-sha256; t=1795730230; cv=none; 
	d=zohomail.com; s=zohoarc; 
	b=iTcwd8Xp/547Iv+8Q9NX/RmRc95tagyBsdqLCDhbKDajX4OUly5OSStcrTf/w4H5mugysRCVanw0OBvcJzCnM/bp8BwT5YFsl2FiWPnCf1/D2ccADCvc7GXoRgItHtWNwi/93EDH/OY8OCDJhgqp3vsmnEZFpeN8+SRsuGdlbos=
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=zohomail.com; s=zohoarc; 
	t=1795730230; h=Content-Type:Cc:Cc:Date:Date:From:From:In-Reply-To:MIME-Version:Message-ID:Subject:Subject:To:To:Message-Id:Reply-To; 
	bh=cv1jcP2NCWHHaTZoGDPS2zYOxgzsyVEhti5NT28c/KQ=; 
	b=T+WPMLmhxBBu/rh4Ip6+c1YYGaWnrLMvz3aI0LyQsIPlV2oXNZIox1oHKlxN2F2cYwj669M4bQ37UKdMieAvhb7GmtBU3mV9vVGI8bLwkYSMBTfakbzepIgD1eJt6tUFggE0WaWGD4lTUGtxgoWcB10eh37ZKfHocnn8PWLZN9I=
ARC-Authentication-Results: i=1; mx.zohomail.com;
	dkim=pass  header.i=collabora.com;
	spf=pass  smtp.mailfrom=deborah.brouwer@collabora.com;
	dmarc=pass header.from=<deborah.brouwer@collabora.com>
DKIM-Signature: a=rsa-sha256; b=NoP/VQTSLJwgXVjcQCQu5SFK6wqD/i8LWv+j3KcLB5vO59ezzBk0xo03BXzFiGhtwnAVOQ9JMCt/g3mGrI/WTJ/r2ua7W08TsRTL0jqq3bsBRtNNjF6WiWGKq+NUKiQ84pWB1x+3/ttZKHj3F7KULpSNmk0pjKO05Lw5N08vfJQ=; c=relaxed/relaxed; s=zohomail; d=collabora.com; v=1; bh=cv1jcP2NCWHHaTZoGDPS2zYOxgzsyVEhti5NT28c/KQ=; h=Content-Description:Content-ID:Content-Type:Content-Transfer-Encoding:Cc:Date:From:In-Reply-To:List-Subscribe:List-Post:List-Owner:List-Id:List-Archive:List-Help:List-Unsubscribe:MIME-Version:Message-ID:Resent-Sender:Resent-Cc:Resent-Date:Resent-To:Reply-To:Resent-Message-ID:Resent-From:Sender:Subject:To:Date:From:Message-Id:Reply-To:Subject:To:Cc;
Received: by smtp.zohomail.com with SMTPS id 1795730228027378.1289641848697;
	Thu, 26 Nov 2026 13:57:08 -0800 (PST)
Date: Thu, 26 Nov 2026 14:57:06 -0700
From: Deborah Brouwer <deborah.brouwer@collabora.com>
To: Janne Grunau <j@jannau.net>
Cc: Miguel Ojeda <ojeda@kernel.org>, Boqun Feng <boqun@kernel.org>,
	Gary Guo <gary@garyguo.net>,
	=?iso-8859-1?Q?Bj=F6rn?= Roy Baron <bjorn3_gh@protonmail.com>,
	Benno Lossin <lossin@kernel.org>,
	Andreas Hindborg <a.hindborg@kernel.org>,
	Alice Ryhl <aliceryhl@google.com>, Trevor Gross <tmgross@umich.edu>,
	Danilo Krummrich <dakr@kernel.org>,
	Daniel Almeida <daniel.almeida@collabora.com>,
	Tamir Duberstein <tamird@kernel.org>,
	Alexandre Courbot <acourbot@nvidia.com>,
	Onur =?iso-8859-1?Q?=D6zkan?= <work@onurozkan.dev>,
	David Airlie <airlied@gmail.com>, Simona Vetter <simona@ffwll.ch>,
	Sami Tolvanen <samitolvanen@google.com>,
	Lyude Paul <lyude@redhat.com>,
	Maarten Lankhorst <maarten.lankhorst@linux.intel.com>,
	Maxime Ripard <mripard@kernel.org>,
	Thomas Zimmermann <tzimmermann@suse.de>,
	rust-for-linux@vger.kernel.org, linux-kernel@vger.kernel.org,
	dri-devel@lists.freedesktop.org, nova-gpu@lists.linux.dev,
	stable@vger.kernel.org, stable+noautosel@kernel.org
Subject: Re: [PATCH v2 0/5] Fix import of dma-buf buffers as DRM GEM shmem
 objects
Message-ID: <awirMlJMlyqKwPQq@um790>
References: <20261124-rust-drm-gem-shmem-imported-sgt-v2-0-000f7a9ccb8d@jannau.net>
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Post: <mailto:stable@vger.kernel.org>
List-Help: <mailto:stable+help@vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
List-Owner: <mailto:stable+owner@vger.kernel.org>
Precedence: list
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20261124-rust-drm-gem-shmem-imported-sgt-v2-0-000f7a9ccb8d@jannau.net>
X-Zoho-Virus-Status: 1
X-Zoho-AV-Stamp: zmail-av-0.2.13.1.5.4/295.709.99

On Tue, Nov 24, 2026 at 12:37:42PM +0100, Janne Grunau wrote:
> Hej,
> 
> this series is triggered by the discussion of gem/shmem.rs SGTableMap
> issues in [1] which has an additional issue with imported objects.
> Imported objects are supported since GEM shmem's AllocOps use
> drm_gem_shmem_prime_import_sg_table() as gem_prime_import_sg_table which
> sets the same function pointer field in struct drm_driver.
> 
> The code is broken in two ways. SGTableMap::drop() calls
> __drm_gem_shmem_free_sgt_locked() uncondiftionally which it must not do
> for imported objects as the object does not own `sgt`.
> The second issue is that the imported object is allocated by
> __drm_gem_shmem_create() with sizeof(struct drm_gem_shmem_object) as
> size instead of the size of Rust's Object<T>.
> 
> The first issue is fixed in the Asahi downstream driver together with a
> drm_gem_is_imported() wrapper change taken from the Tyr downstream
> driver.
> The second issue is fixed by avoiding to allocate Rust GEM objects
> from C. In addition to size issue v1 addressed Rust gem objects may
> contain fields with non-trivial `Drop` implementations. Those fields
> won't be destroyed in error paths in C code which "destroys" the objects
> with `kfree(obj)`. Solve this by re-implementing
> gem_prime_import_sg_table() in Rust.
> The same issues apply to drm_gem_shmem_dumb_create(). As Asahi and Tyr
> as render only devices do not use the `dumb_create` callback just drop
> it. When a future driver uses the callback drm_gem_shmem_dumb_create()
> needs to be re-implemented in Rust as well.
> 
> The series is tested in the Asahi downstream driver. As the prime import
> code path is unused in-tree I marked the fixes as not suitable for stable
> backports. The known downstream users of the code are aware of the
> issues and carry fixes downstream. I don't expect new Rust DRM drivers
> to be based on (old) stable trees.
> 
> Link: https://lore.kernel.org/rust-for-linux/20261019-rust-shmem-fixes-v1-1-3f7f6de5b5e7@google.com/ [1]
> Signed-off-by: Janne Grunau <j@jannau.net>

Thank you Janne for this series, I tested it on my rock 5B
by running the igt tests [1]
with the proposed ioctl changes to tyr [2]
and it is working great.

So, for the whole series:

Tested-by: Deborah Brouwer <deborah.brouwer@collabora.com>

[1] https://gitlab.freedesktop.org/drm/igt-gpu-tools/-/tree/master/tests/panthor
[2] https://lore.kernel.org/rust-for-linux/20261122-tyr-ioctls-v7-0-3a2af624b992@linux.dev/

> ---
> Changes in v2:
> - Switch to Rust gem_prime_import_sg_table() implementation
> - Drop unsound drm_gem_shmem_dumb_create() as well
> - Add `#[inline] annotation to BaseObject::is_imported()
> - Drop typoed mail address from To:
> - Added Alice's Reviewed-by tags
> - Link to v1: https://lore.kernel.org/r/20261026-rust-drm-gem-shmem-imported-sgt-v1-0-36f15ace04b1@jannau.net
> 
> ---
> Janne Grunau (4):
>       rust: drm: gem: shmem: Do not use drm_gem_shmem_dumb_create()
>       drm/gem/shmem: Initialize private objects via drm_gem_shmem_init() too
>       rust: drm: gem: shmem: Implement prime_import_sg_table callback
>       rust: drm: gem: shmem: Do not free SG table of imported objects
> 
> Sami Tolvanen (1):
>       rust: drm: gem: add an is_imported() accessor
> 
>  drivers/gpu/drm/drm_gem_shmem_helper.c | 34 +++++++-------
>  drivers/gpu/drm/nova/gem.rs            |  4 ++
>  drivers/gpu/drm/tyr/gem.rs             |  4 ++
>  include/drm/drm_gem_shmem_helper.h     |  3 +-
>  rust/helpers/drm.c                     |  6 +++
>  rust/kernel/drm/gem/mod.rs             | 17 +++++++
>  rust/kernel/drm/gem/shmem.rs           | 81 ++++++++++++++++++++++++++++++++--
>  7 files changed, 126 insertions(+), 23 deletions(-)
> ---
> base-commit: 3497a403264b094ebd61b8b755165d56e7d9dc37
> change-id: 20261026-rust-drm-gem-shmem-imported-sgt-85c4a45be283
> 
> Best regards,
> -- 
> Janne Grunau <j@jannau.net>
> 
