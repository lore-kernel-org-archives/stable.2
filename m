Received: from mailgw.kylinos.cn (mailgw.kylinos.cn [124.126.103.232])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7A5B23CB56F;
	Wed,  5 Aug 2026 06:19:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=124.126.103.232
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1785910800; cv=none; b=nPUJmJnHWHd+h0kKxlR+Bet4HZSbR5QIX7JM0GR89qvUAND1HWC//PRtpX+oxaQSBtYPx27e/R11iD4nTAf0h6ki9lLr6PPvFxmnQ5GyeOp97EFJkGHlM7BJS72KrO+0wHMg7meZd2JW41nhwwSu/9oC2moFOwto1sFyPwRfZ9s=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1785910800; c=relaxed/simple;
	bh=0XOw1C9ItgiCeTFM3DaE2CekoPAexQ5WY5de2GlW7us=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 Content-Type:MIME-Version; b=bkn/zT7qxVnQ79cqwIgvZ1vIkMjic80K2F9AmQJ2it2A5mW/wVoFznSm2bj82/myJ407tX4hc4I4LxGs//qQJyfRon7H1drNUpzj5rarCYol+9/VqwVheq6JCddRyzggMqbBsCUKurUG79EJEg7YoUeXmVgZAFn5xyKa4rjGEoA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=kylinos.cn; spf=pass smtp.mailfrom=kylinos.cn; arc=none smtp.client-ip=124.126.103.232
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=kylinos.cn
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=kylinos.cn
X-UUID: a83aa36a909511f1aa26b74ffac11d73-20260805
X-CID-P-RULE: Release_Ham
X-CID-O-INFO: VERSION:1.3.12,REQID:3dbfcf06-89cc-4a55-a469-1bdbe9dd8c01,IP:0,U
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
X-UUID: a83aa36a909511f1aa26b74ffac11d73-20260805
X-User: xiongweimin@kylinos.cn
Received: from [127.0.1.1] [(10.44.16.150)] by mailgw.kylinos.cn
	(envelope-from <xiongweimin@kylinos.cn>)
	(Generic MTA with TLSv1.3 TLS_AES_256_GCM_SHA384 256/256)
	with ESMTP id 254697198; Wed, 05 Aug 2026 14:19:47 +0800
From: Xiong Weimin <xiongweimin@kylinos.cn>
To: "Michael S. Tsirkin" <mst@redhat.com>
Cc: virtualization@lists.linux.dev, linux-kernel@vger.kernel.org,
 Jason Wang <jasowangio@gmail.com>, Jason Wang <jasowang@redhat.com>,
 Xuan Zhuo <xuanzhuo@linux.alibaba.com>,
 Eugenio =?utf-8?q?P=C3=A9rez?= <eperezma@redhat.com>, stable@vger.kernel.org
Subject: Re: [PATCH] virtio_pci: do not mutate caller irq_affinity.pre_vectors
Date: Wed, 05 Aug 2026 14:19:46 +0800
Message-ID: <178591078690.1650419.2787765521595164465@kylinos.cn>
In-Reply-To: <20260805032934.1606700-1-xiongweimin@kylinos.cn>
References: <20260805032934.1606700-1-xiongweimin@kylinos.cn>
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0

On the virtio_input thread, Michael asked whether each of these patches
is a real or a theoretical issue for stable. For this virtio_pci patch:

Real, when affinity is requested and MSI-X policy falls back.

vp_find_vqs() retries EACH -> SHARED_SLOW -> SHARED. Each failed
vp_request_msix_vectors() currently does desc->pre_vectors++ in place,
so a later successful attempt sees a polluted pre_vectors and gets the
wrong affinity layout. That fallback path is unconditional in the
driver.

I have not collected a userspace/IRQ-affinity failure log yet. Please
let me know if you still want Cc: stable on this one.

Thanks,
Xiong
