Received: from mailgw.kylinos.cn (mailgw.kylinos.cn [124.126.103.232])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B05E53E008F;
	Wed,  5 Aug 2026 06:47:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=124.126.103.232
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1785912435; cv=none; b=ElgiOORxAPgb74UMZCdVAZpApeyNve5yc8jpuof4A/FWa9UTnm6Cn2F7Y9fkEJxXM7jQaDXnYOY5VFk3gYp7zX4dIKj7tcFJq8cyC2SJA0hIztOWxD80A7lSBL63QPUFdIeUXxMPeIyZ20uG1tcrl9DsNGQOYQDSnAPMctTk8RI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1785912435; c=relaxed/simple;
	bh=lWr7G8ys+M3kPj4gAb+C9BR5uKbmc/81diT7ThWkQtA=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 Content-Type:MIME-Version; b=to4MpS8mEsbhDNuXvRvP+yK8S/M64xJxNi9Hh5O2xT5vadxhhIdU7RdntLEG4yMivqh6J+oOsrMYVu5SWiyFx/BnEjUi9OLA63iJb2q2hFW8AeMw5M/6az5FUZ63AipuLLOxjA6/7NGjKoGSN5jLKAuhGxTUv2usXntJx1JwgoI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=kylinos.cn; spf=pass smtp.mailfrom=kylinos.cn; arc=none smtp.client-ip=124.126.103.232
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=kylinos.cn
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=kylinos.cn
X-UUID: 7b09a3e2909911f1aa26b74ffac11d73-20260805
X-CID-CACHE: Type:Local,Time:202608051419+08,HitQuantity:1
X-CID-P-RULE: Release_Ham
X-CID-O-INFO: VERSION:1.3.12,REQID:945385b1-100e-4354-93ab-120d9d7a9245,IP:0,U
	RL:0,TC:0,Content:0,EDM:0,RT:0,SF:0,FILE:0,BULK:0,RULE:Release_Ham,ACTION:
	release,TS:0
X-CID-META: VersionHash:e7bac3a,CLOUDID:956a6a86f20eb4449240837b94ee29b1,BulkI
	D:nil,BulkQuantity:0,Recheck:0,SF:81|82|83|102|865|898,TC:nil,Content:0|15
	|50,EDM:-3,IP:nil,URL:0,File:nil,RT:nil,Bulk:nil,QS:nil,BEC:nil,COL:0,OSI:
	0,OSA:0,AV:0,LES:1,SPR:NO,DKR:0,DKP:0,BRR:0,BRE:0,ARC:0
X-CID-BVR: 2,SSN|SDN
X-CID-BAS: 2,SSN|SDN,0,_
X-CID-FACTOR: TF_CID_SPAM_SNR
X-CID-RHF: D41D8CD98F00B204E9800998ECF8427E
X-UUID: 7b09a3e2909911f1aa26b74ffac11d73-20260805
X-User: xiongweimin@kylinos.cn
Received: from [127.0.1.1] [(10.44.16.150)] by mailgw.kylinos.cn
	(envelope-from <xiongweimin@kylinos.cn>)
	(Generic MTA with TLSv1.3 TLS_AES_256_GCM_SHA384 256/256)
	with ESMTP id 1972465785; Wed, 05 Aug 2026 14:47:09 +0800
From: Xiong Weimin <xiongweimin@kylinos.cn>
To: "Michael S. Tsirkin" <mst@redhat.com>
Cc: virtualization@lists.linux.dev, linux-kernel@vger.kernel.org,
 Jason Wang <jasowangio@gmail.com>, Jason Wang <jasowang@redhat.com>,
 Xuan Zhuo <xuanzhuo@linux.alibaba.com>,
 Eugenio =?utf-8?q?P=C3=A9rez?= <eperezma@redhat.com>, stable@vger.kernel.org
Subject: Re: [PATCH] virtio_pci: do not mutate caller irq_affinity.pre_vectors
Date: Wed, 05 Aug 2026 14:47:06 +0800
Message-ID: <178591242683.1657366.2004019380773321385@kylinos.cn>
In-Reply-To: <20260805013203-mutt-send-email-mst@kernel.org>
References: <20260805032934.1606700-1-xiongweimin@kylinos.cn>
 <20260805013203-mutt-send-email-mst@kernel.org>
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0

On Wed, Aug 05, 2026 at 01:37:01AM -0400, Michael S. Tsirkin wrote:
> "tmp" in what sense? if we can come up with a sensible name, just
> "affinity" will do.
>
> We do not need a comment arguing with previous version of the code.
>
> just assign to desc, instead?

Thanks, will do. I will post a fresh [PATCH v2] as a new standalone
mail (not threaded under this one) with:
- a local "affinity" copy
- that comment dropped
- desc = &affinity, and keep passing desc

On the virtio_input thread you also asked whether this is real or
theoretical for stable. For this virtio_pci patch: real when the caller
passes irq_affinity and MSI-X policy falls back.

vp_find_vqs() retries EACH -> SHARED_SLOW -> SHARED. A failed
vp_request_msix_vectors() currently does desc->pre_vectors++ in place,
so a later successful attempt sees a polluted pre_vectors and gets the
wrong affinity layout. That fallback path is unconditional in the
driver.

I have not collected a userspace failure log yet. Please let me know if
you still want Cc: stable on the v2.

Thanks,
Xiong
