Received: from mailgw.kylinos.cn (mailgw.kylinos.cn [124.126.103.232])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4CA5F448D11;
	Wed, 23 Sep 2026 10:56:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=124.126.103.232
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1790160992; cv=none; b=sURPtAvxHIc9aYOaoDKUnai4/2qyjs2gnFRmeYSKckaCYFhLYEsH4wMniwlLq1uS5JlBNPWQx0ZHiwxO4WqLN2uLPB4HntvREUAny4OV6YRl+OzrsTveJk223E9EjoVx4gYConAyoRdnSsjfQYrgQ+Y9r+i8d5TuI7bFQ60nVSI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1790160992; c=relaxed/simple;
	bh=n8OjBNLKaUn2NcXoreYPkNpVilLJ4zLqB9BemhOLfn0=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=Kbh+z0uHPbUB+YFOyJAhrDrnnBMdLX6LzbIu52dPT3Rxu5S6sr1CAf4u06vXfXlSex42/M8brgUsplfz4dCpFuopx5JWyC++eNgOyiHGADzNmHF0Yados28ZCQp7Gb3IFwKwzRFDXRdg+2GxHDCiqH/mISU9bHTBYUSyASyg5K4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=kylinos.cn; spf=pass smtp.mailfrom=kylinos.cn; arc=none smtp.client-ip=124.126.103.232
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=kylinos.cn
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=kylinos.cn
X-UUID: 671850fcb73d11f19a56ed5b684f684d-20260923
X-CID-CACHE: Type:Local,Time:202609231842+08,HitQuantity:1
X-CID-P-RULE: Release_Ham
X-CID-O-INFO: VERSION:1.3.19,REQID:ac7e1227-de99-4291-b660-b9d02d04b6cc,IP:0,U
	RL:0,TC:0,Content:0,EDM:25,RT:0,SF:0,FILE:0,BULK:0,RULE:Release_Ham,ACTION
	:release,TS:25
X-CID-META: VersionHash:7db8b62,CLOUDID:d31e98d2dc5902b90057bdc7252be9fe,BulkI
	D:nil,BulkQuantity:0,SF:82|83|102|850|865|898,TC:nil,Content:0|15|50|99,ED
	M:5,IP:nil,URL:0,File:nil,RT:nil,Bulk:nil,QS:nil,BEC:nil,COL:0,OSI:0,OSA:0
	,AV:0,LES:1,SPR:NO,DKR:0,DKP:0,BRR:0,BRE:0,ARC:0
X-CID-BVR: 2,SSN|SDN
X-CID-BAS: 2,SSN|SDN,0,_
X-CID-FACTOR: TF_CID_SPAM_SNR
X-CID-RHF: D41D8CD98F00B204E9800998ECF8427E
X-UUID: 671850fcb73d11f19a56ed5b684f684d-20260923
X-User: zhangyunfei1@kylinos.cn
Received: from localhost.localdomain [(10.44.16.150)] by mailgw.kylinos.cn
	(envelope-from <zhangyunfei1@kylinos.cn>)
	(Generic MTA with TLSv1.3 TLS_AES_256_GCM_SHA384 256/256)
	with ESMTP id 1318847510; Wed, 23 Sep 2026 18:56:17 +0800
From: Zhang Yunfei <zhangyunfei1@kylinos.cn>
To: netdev@vger.kernel.org
Cc: leitao@debian.org,
	jiawenwu@trustnetic.com,
	mengyuanlou@net-swift.com,
	andrew+netdev@lunn.ch,
	davem@davemloft.net,
	edumazet@google.com,
	kuba@kernel.org,
	pabeni@redhat.com,
	aleksandr.loktionov@intel.com,
	weirongguang@kylinos.cn,
	u.kleine-koenig@baylibre.com,
	linux-kernel@vger.kernel.org,
	stable@vger.kernel.org
Subject: Re: [PATCH net v2 2/2] net: ngbe: clear DRV_LOAD bit when ngbe_open() fails
Date: Wed, 23 Sep 2026 18:56:14 +0800
Message-Id: <20260923105614.1524583-1-zhangyunfei1@kylinos.cn>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20260923104251.1514090-1-zhangyunfei1@kylinos.cn>
References: <20260923104251.1514090-1-zhangyunfei1@kylinos.cn>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Resend with the full Cc list; the previous reply inadvertently dropped
the Cc recipients.

Hi Breno,

Not silly at all -- txgbe's approach is indeed cleaner, and you read it
right: wx_control_hw(wx, true) lives at the top of txgbe_up_complete()
(txgbe_main.c:160), so txgbe's open error paths never have to unwind
the bit.

For ngbe I kept the claim where the vendor put it (top of ngbe_open())
and added the missing rollback, because moving the claim into
ngbe_up_complete() changes the driver-firmware handshake timing: the
whole setup/configure window would then run while the NCSI/OOB
firmware still believes it owns the port. Whether ngbe's management
firmware tolerates that window is a firmware-contract question I
cannot answer from the code alone (txgbe is a different product line),
so Jiawen/Mengyuan are better placed to judge it. Deferring the claim
into ngbe_up_complete() would look like the cleaner long-term shape;
this patch only closes the existing inconsistency.

Thanks for the suggestion!

Zhang Yunfei
