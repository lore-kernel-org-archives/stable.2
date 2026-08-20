Received: from mailgw.kylinos.cn (mailgw.kylinos.cn [124.126.103.232])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A3CE923ED60;
	Thu, 20 Aug 2026 08:55:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=124.126.103.232
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1787216119; cv=none; b=ldHgOO8spprxO0A6dfN3d4KFPlT9zoZQgIPQxgH9A5uhnExPSo23gDpXLVXUAg1J45aVjaBgVSguIyOuGAa+aVa1DJu+zeTIpNrkHKbdSBlrbQw7EEREGcKIMOM0M63EAtpkk/kmg7eUAr83w0NWvBRDH4MYSzijuMhJIV6A+Qg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1787216119; c=relaxed/simple;
	bh=2dHpovJRuIPpyFvRKNb2g/87fsfOyd4qaCANK448KAo=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version:Content-Type; b=lrYEs1K8thTo6tY4KfqvsElJX81dquyfNuNIHhQ+qFB8OCAV6V0CXEEBAKt5I+h/BRaVi/E7zX+01Wwv0DkMOMFz5sqIpsW3zREVS4O/LpWn38Lwlf0mTNY/9cTZ30K5PR5K7njLcunXcgDeV9qFw5B6fqx3cEetvje+FI6IX24=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=kylinos.cn; spf=pass smtp.mailfrom=kylinos.cn; arc=none smtp.client-ip=124.126.103.232
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=kylinos.cn
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=kylinos.cn
X-UUID: d7fa5be69c7411f19a56ed5b684f684d-20260820
X-CTIC-Tags:
	HR_CC_COUNT, HR_CC_DOMAIN_COUNT, HR_CC_NO_NAME, HR_CTE_8B, HR_CTT_TXT
	HR_DATE_H, HR_DATE_WKD, HR_DATE_ZONE, HR_FROM_NAME, HR_SJ_DIGIT_LEN
	HR_SJ_LANG, HR_SJ_LEN, HR_SJ_LETTER, HR_SJ_NOR_SYM, HR_SJ_PHRASE
	HR_SJ_PHRASE_LEN, HR_SJ_PRE_RE, HR_SJ_WS, HR_TO_COUNT, HR_TO_DOMAIN_COUNT
	HR_TO_NO_NAME, IP_TRUSTED, SRC_TRUSTED, DN_TRUSTED, SA_TRUSTED
	SA_EXISTED, SN_TRUSTED, SN_EXISTED, SPF_NOPASS, DKIM_NOPASS
	DMARC_NOPASS, UD_TRUSTED, CIE_BAD, CIE_GOOD, CIE_GOOD_SPF
	GTI_FG_BS, GTI_C_CI, GTI_FG_IT, GTI_RG_INFO, GTI_C_BU
	AMN_GOOD, ABX_MISS_RDNS
X-CID-P-RULE: Release_Ham
X-CID-O-INFO: VERSION:1.3.19,REQID:2d148b48-3ec6-4666-8803-a364987f67b4,IP:15,
	URL:0,TC:0,Content:0,EDM:0,RT:0,SF:0,FILE:0,BULK:0,RULE:Release_Ham,ACTION
	:release,TS:15
X-CID-INFO: VERSION:1.3.19,REQID:2d148b48-3ec6-4666-8803-a364987f67b4,IP:15,UR
	L:0,TC:0,Content:0,EDM:0,RT:0,SF:0,FILE:0,BULK:0,RULE:Release_Ham,ACTION:r
	elease,TS:15
X-CID-META: VersionHash:7db8b62,CLOUDID:5b2cc51f1a065d8843a5b9d12d3b3499,BulkI
	D:260820165510OS6TMSDL,BulkQuantity:0,SF:10|64|66|78|80|81|82|83|102|127|8
	17|841|850|865|898,TC:nil,Content:-10|-8|-5|14|50,EDM:-3,IP:-2,URL:99|1,Fi
	le:nil,RT:nil,Bulk:nil,QS:nil,BEC:nil,COL:0,OSI:0,OSA:0,AV:0,LES:1,SPR:NO,
	DKR:0,DKP:0,BRR:0,BRE:0,ARC:0
X-CID-BVR: 2,SSN|SDN
X-CID-BAS: 2,SSN|SDN,0,_
X-CID-FACTOR: TF_CID_SPAM_SNR,TF_CID_SPAM_ULS
X-CID-RHF: D41D8CD98F00B204E9800998ECF8427E
X-UUID: d7fa5be69c7411f19a56ed5b684f684d-20260820
X-User: yijiangshan@kylinos.cn
Received: from localhost.localdomain [(116.128.244.171)] by mailgw.kylinos.cn
	(envelope-from <yijiangshan@kylinos.cn>)
	(Generic MTA with TLSv1.3 TLS_AES_256_GCM_SHA384 256/256)
	with ESMTP id 1316331338; Thu, 20 Aug 2026 16:55:07 +0800
From: Jiangshan Yi <yijiangshan@kylinos.cn>
To: vadim.fedorenko@linux.dev
Cc: 13667453960@163.com,
	andrew+netdev@lunn.ch,
	ariele@broadcom.com,
	davem@davemloft.net,
	dmitry@broadcom.com,
	edumazet@google.com,
	eilong@broadcom.com,
	kuba@kernel.org,
	linux-kernel@vger.kernel.org,
	manishc@marvell.com,
	netdev@vger.kernel.org,
	pabeni@redhat.com,
	sashiko-bot@kernel.org,
	skalluru@marvell.com,
	stable@vger.kernel.org,
	yijiangshan@kylinos.cn,
	yuvalmin@broadcom.com
Subject: Re: Re: [PATCH v2] bnx2x: fix NULL pointer dereference in bnx2x_free_mem_bp()
Date: Thu, 20 Aug 2026 16:54:38 +0800
Message-Id: <20260820085438.148916-1-yijiangshan@kylinos.cn>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <d88017c7-7089-4e85-b56e-21175310db93@linux.dev>
References: <d88017c7-7089-4e85-b56e-21175310db93@linux.dev>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit

> Please, review netdev contribution rules at
> https://docs.kernel.org/process/maintainer-netdev.html
>
> Especially patch formatting and 24h cool-down period

Hi Vadim,

Thank you for the review and the pointers.

I will remove the Suggested-by tag in the next version. I also appreciate
you directing me to the netdev contribution rules — I will carefully read
through https://docs.kernel.org/process/maintainer-netdev.html and make
sure to follow the patch formatting guidelines and respect the 24h
cool-down period for subsequent submissions.

Best regards,
Jiangshan Yi
