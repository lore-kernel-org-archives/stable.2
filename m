Received: from mailgw.kylinos.cn (mailgw.kylinos.cn [124.126.103.232])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id AE29E3DB983;
	Wed,  5 Aug 2026 06:19:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=124.126.103.232
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1785910800; cv=none; b=VRI6Fk65mOu7VASQG/PeXlFhZe8DwC6dWSmY1tQQF36hJBR9XiVFOEp4XFNfFndYxYX3lIBt+7nqxaSogbfnU+2SOtLjyY7ulWRpygullsqfHsmygvgwnqIY4n4coyRkKauAwwPmsdV9fIPsm7Mi/h6HEiIOBDbWeLmNI8n/px0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1785910800; c=relaxed/simple;
	bh=MDlDMSK9Fe5zd5PKe9gUeQRQD8s0u7xOUCFniDNxhDg=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 Content-Type:MIME-Version; b=ZRde0+7VyyKwVdVqiL6VA+NobAtHGUgSe9oTZMpj83a4ODJCG142/lWL+2k0s6CbrCDZNXci+wBxkRe9SmnnIiEAaaasY0KHSntzvAjVgEl+yv29eF2WZUOklWOLQBVQTK664GLXT8ikNs5PFhHdr8NeYIxOeizxaDz7t6kCwrQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=kylinos.cn; spf=pass smtp.mailfrom=kylinos.cn; arc=none smtp.client-ip=124.126.103.232
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=kylinos.cn
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=kylinos.cn
X-UUID: a8050052909511f1aa26b74ffac11d73-20260805
X-CID-P-RULE: Release_Ham
X-CID-O-INFO: VERSION:1.3.12,REQID:19aa8231-c243-447c-85a7-396ede712dc7,IP:0,U
	RL:0,TC:0,Content:-5,EDM:0,RT:0,SF:0,FILE:0,BULK:0,RULE:Release_Ham,ACTION
	:release,TS:-5
X-CID-META: VersionHash:e7bac3a,CLOUDID:a393da99755c2632cb557be8aad85497,BulkI
	D:nil,BulkQuantity:0,Recheck:0,SF:81|82|83|102|136|865|898,TC:nil,Content:
	0|15|50,EDM:-3,IP:nil,URL:0,File:nil,RT:nil,Bulk:nil,QS:nil,BEC:nil,COL:0,
	OSI:0,OSA:0,AV:0,LES:1,SPR:NO,DKR:0,DKP:0,BRR:0,BRE:0,ARC:0
X-CID-BVR: 2,SSN|SDN
X-CID-BAS: 2,SSN|SDN,0,_
X-CID-FACTOR: TF_CID_SPAM_SNR
X-CID-RHF: D41D8CD98F00B204E9800998ECF8427E
X-UUID: a8050052909511f1aa26b74ffac11d73-20260805
X-User: xiongweimin@kylinos.cn
Received: from [127.0.1.1] [(10.44.16.150)] by mailgw.kylinos.cn
	(envelope-from <xiongweimin@kylinos.cn>)
	(Generic MTA with TLSv1.3 TLS_AES_256_GCM_SHA384 256/256)
	with ESMTP id 1752520482; Wed, 05 Aug 2026 14:19:46 +0800
From: Xiong Weimin <xiongweimin@kylinos.cn>
To: "Michael S. Tsirkin" <mst@redhat.com>
Cc: virtualization@lists.linux.dev, linux-kernel@vger.kernel.org,
 Gerd Hoffmann <kraxel@redhat.com>, Jason Wang <jasowangio@gmail.com>,
 Jason Wang <jasowang@redhat.com>, Xuan Zhuo <xuanzhuo@linux.alibaba.com>,
 Eugenio =?utf-8?q?P=C3=A9rez?= <eperezma@redhat.com>, stable@vger.kernel.org
Subject:
 Re: [PATCH] virtio_input: reset device if input_register_device() fails
Date: Wed, 05 Aug 2026 14:19:46 +0800
Message-ID: <178591078653.1650419.14707193519784639369@kylinos.cn>
In-Reply-To: <20260805012846-mutt-send-email-mst@kernel.org>
References: <20260805032931.1606652-1-xiongweimin@kylinos.cn>
 <20260805012846-mutt-send-email-mst@kernel.org>
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0

On Wed, Aug 05, 2026 at 01:29:28AM -0400, Michael S. Tsirkin wrote:
> for each of these patches: is this a real or a theoretical issue?
> stable rules preclude the later kind.

For this virtio_input patch: theoretical for stable.

On the failing path, virtio_device_ready() has run, but
virtinput_fill_evt() has not, so the event queue still has no buffers.
I have no evidence of device DMA into torn-down queues here; the change
is lifecycle hygiene matching remove/freeze (clear DRIVER_OK before
del_vqs()).

I will drop Cc: stable on a v2 and keep the fix for mainline only.
I will answer the same question separately on the virtio_pci and
virtio_mmio threads.

Thanks,
Xiong
