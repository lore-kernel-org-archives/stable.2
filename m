Received: from mailgw.kylinos.cn (mailgw.kylinos.cn [124.126.103.232])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0ACCE3E009D;
	Wed,  5 Aug 2026 06:47:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=124.126.103.232
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1785912441; cv=none; b=lK8/LWfArWsvDJPB1FroRALC6HO6fXgndkpED1HBIHCiiih1FV9hzywAAYrWv9Pq0JrSaShqh1fxd26C8xGCibuelPtdzLOL7IVNXbG0ZkcqngpR8hqAGjA0Wuji6lr0mpHNSKHMublDr/AVXsEqbXok9rYsyXtJq+aLj/lR7i0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1785912441; c=relaxed/simple;
	bh=Cw3Le7HKYS1EgLz3s9q5QD0m+A8XUeHgzG8lDfw1idA=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 Content-Type:MIME-Version; b=Uvrd6Z51RhtgnV1db2dxaadHDo17j33o10dbdJuZPASlg2n8zgAdVkz0ROSjB/Y5yjQ/XmpObim+2+0Sh2irOtfG4MPBAebPFnrvaCd4NSjkrTE+Eay/SFXXoIIgeH4RwzcW0ndwgk+iqpidnF18drhTH6siwVBCQ+KIXW/Rdp4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=kylinos.cn; spf=pass smtp.mailfrom=kylinos.cn; arc=none smtp.client-ip=124.126.103.232
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=kylinos.cn
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=kylinos.cn
X-UUID: 7cb2e1f4909911f1aa26b74ffac11d73-20260805
X-CID-CACHE: Type:Local,Time:202608051419+08,HitQuantity:1
X-CID-P-RULE: Release_Ham
X-CID-O-INFO: VERSION:1.3.12,REQID:3bde287d-4d1c-44aa-9ab0-afdac663e821,IP:0,U
	RL:0,TC:0,Content:0,EDM:0,RT:0,SF:0,FILE:0,BULK:0,RULE:Release_Ham,ACTION:
	release,TS:0
X-CID-META: VersionHash:e7bac3a,CLOUDID:2e3763338239d60f27c80c304aa4a576,BulkI
	D:nil,BulkQuantity:0,Recheck:0,SF:81|82|83|102|865|898,TC:nil,Content:0|15
	|50,EDM:-3,IP:nil,URL:0,File:nil,RT:nil,Bulk:nil,QS:nil,BEC:nil,COL:0,OSI:
	0,OSA:0,AV:0,LES:1,SPR:NO,DKR:0,DKP:0,BRR:0,BRE:0,ARC:0
X-CID-BVR: 2,SSN|SDN
X-CID-BAS: 2,SSN|SDN,0,_
X-CID-FACTOR: TF_CID_SPAM_SNR
X-CID-RHF: D41D8CD98F00B204E9800998ECF8427E
X-UUID: 7cb2e1f4909911f1aa26b74ffac11d73-20260805
X-User: xiongweimin@kylinos.cn
Received: from [127.0.1.1] [(10.44.16.150)] by mailgw.kylinos.cn
	(envelope-from <xiongweimin@kylinos.cn>)
	(Generic MTA with TLSv1.3 TLS_AES_256_GCM_SHA384 256/256)
	with ESMTP id 1386616065; Wed, 05 Aug 2026 14:47:12 +0800
From: Xiong Weimin <xiongweimin@kylinos.cn>
To: "Michael S. Tsirkin" <mst@redhat.com>
Cc: virtualization@lists.linux.dev, linux-kernel@vger.kernel.org,
 Jason Wang <jasowangio@gmail.com>, Jason Wang <jasowang@redhat.com>,
 Xuan Zhuo <xuanzhuo@linux.alibaba.com>,
 Eugenio =?utf-8?q?P=C3=A9rez?= <eperezma@redhat.com>, stable@vger.kernel.org
Subject: Re: [PATCH] virtio_mmio: disable IRQ wake before free_irq
Date: Wed, 05 Aug 2026 14:47:09 +0800
Message-ID: <178591242945.1657366.12043874648568847249@kylinos.cn>
In-Reply-To: <20260805032937.1606737-1-xiongweimin@kylinos.cn>
References: <20260805032937.1606737-1-xiongweimin@kylinos.cn>
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0

On the virtio_input thread, Michael asked whether each of these patches
is a real or a theoretical issue for stable. For this virtio_mmio patch:

Real when the DT node has "wakeup-source".

vm_find_vqs() may enable_irq_wake() on the shared IRQ, and vm_del_vqs()
used to free_irq() without disable_irq_wake(), which leaves a wake
reference and can warn on later free/request cycles. Platforms without
that property do not hit it.

Please let me know if you still want Cc: stable on this one.

Thanks,
Xiong
