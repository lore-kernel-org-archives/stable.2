Received: from mailgw.kylinos.cn (mailgw.kylinos.cn [124.126.103.232])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7AEFB282F29;
	Mon, 17 Aug 2026 15:08:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=124.126.103.232
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1786979304; cv=none; b=Ipjb/bIKACBfuzKGEDxD/Q0Sw+i00TUqeqEXzx/KWqCB1c3e5dRVNbSsGO4iOoFyFNdAAvrW9PzMVdSZvGxytgLRNp2U0fyST1kkXEShWcGt9ybgpjz966Vk0B/g/AQIicA8Pg3iyQFfNMHtSegJxLTYAgNqb4KDYaT6XqSeozA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1786979304; c=relaxed/simple;
	bh=3Dbnf81DlTvOhBKc3YeNtE9LHJf2vgsv4s56g89ccI8=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=H3xQGN1AzvJylKFxXssXxXLz6hrBKiVBxGoyfczMOG+fm0+/NxSUHtK4reY69d3catDZUwzS6TiU9gTwIo8HTZbKo5cXAoL2uBGXV+v2h1wn5yNC1f8IcSNDWxGCLHSprdCxNogT8Cqj97DYdH99+MD38oKXnz0Ss4N3oqtu74U=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=kylinos.cn; spf=pass smtp.mailfrom=kylinos.cn; arc=none smtp.client-ip=124.126.103.232
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=kylinos.cn
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=kylinos.cn
X-UUID: 75bf92309a4d11f19a56ed5b684f684d-20260817
X-CTIC-Tags:
	HR_CC_COUNT, HR_CC_DOMAIN_COUNT, HR_CC_NO_NAME, HR_CTE_8B, HR_CTT_MISS
	HR_DATE_H, HR_DATE_WKD, HR_DATE_ZONE, HR_FROM_NAME, HR_SJ_DIGIT_LEN
	HR_SJ_LANG, HR_SJ_LEN, HR_SJ_LETTER, HR_SJ_NOR_SYM, HR_SJ_PHRASE
	HR_SJ_PHRASE_LEN, HR_SJ_PRE_RE, HR_SJ_WS, HR_TO_COUNT, HR_TO_DOMAIN_COUNT
	HR_TO_NO_NAME, IP_UNTRUSTED, SRC_UNTRUSTED, IP_UNFAMILIAR, SRC_UNFAMILIAR
	DN_TRUSTED, SRC_TRUSTED, SA_TRUSTED, SA_EXISTED, SN_TRUSTED
	SN_EXISTED, SPF_NOPASS, DKIM_NOPASS, DMARC_NOPASS, CIE_GOOD_SPF
	CIE_UNKNOWN, GTI_FG_BS, GTI_RG_INFO, GTI_C_BU, AMN_GOOD
	ABX_MISS_RDNS
X-CID-P-RULE: Release_Ham
X-CID-O-INFO: VERSION:1.3.19,REQID:ed513693-d1e6-433a-b655-ec47fe9fb2c4,IP:10,
	URL:0,TC:0,Content:0,EDM:0,RT:0,SF:0,FILE:0,BULK:0,RULE:Release_Ham,ACTION
	:release,TS:10
X-CID-INFO: VERSION:1.3.19,REQID:ed513693-d1e6-433a-b655-ec47fe9fb2c4,IP:10,UR
	L:0,TC:0,Content:0,EDM:0,RT:0,SF:0,FILE:0,BULK:0,RULE:Release_Ham,ACTION:r
	elease,TS:10
X-CID-META: VersionHash:7db8b62,CLOUDID:cd91e54b751dffd8321282ed21a43d8c,BulkI
	D:2608172308141DPS8EUO,BulkQuantity:0,SF:10|64|66|78|80|81|82|83|102|127|8
	17|841|850|865|898,TC:nil,Content:-10|-8|-5|14|50,EDM:-3,IP:-2,URL:0,File:
	nil,RT:nil,Bulk:nil,QS:nil,BEC:nil,COL:0,OSI:0,OSA:0,AV:0,LES:1,SPR:NO,DKR
	:0,DKP:0,BRR:0,BRE:0,ARC:0
X-CID-BVR: 2,SSN|SDN
X-CID-BAS: 2,SSN|SDN,0,_
X-CID-FACTOR: TF_CID_SPAM_SNR
X-CID-RHF: D41D8CD98F00B204E9800998ECF8427E
X-UUID: 75bf92309a4d11f19a56ed5b684f684d-20260817
X-User: yijiangshan@kylinos.cn
Received: from localhost.localdomain [(120.227.38.248)] by mailgw.kylinos.cn
	(envelope-from <yijiangshan@kylinos.cn>)
	(Generic MTA with TLSv1.3 TLS_AES_256_GCM_SHA384 256/256)
	with ESMTP id 956572860; Mon, 17 Aug 2026 23:08:10 +0800
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
Subject: Re: Re: [PATCH] bnx2x: fix NULL pointer dereference in bnx2x_free_mem_bp()
Date: Mon, 17 Aug 2026 23:08:04 +0800
Message-Id: <20260817150804.759629-1-yijiangshan@kylinos.cn>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <a7360a7e-6c42-4891-a01c-a349d1cb803a@linux.dev>
References: <a7360a7e-6c42-4891-a01c-a349d1cb803a@linux.dev>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

> > +	if (bp->fp) {
> there is no need to put this defensive code ...
> > +		for (i = 0; i < bp->fp_array_size; i++)
> > +			kfree(bp->fp[i].tpa_info);
> > +	}
> ......
> > -	bp->fp_array_size = fp_array_size;
> > -	BNX2X_DEV_INFO("fp_array_size %d\n", bp->fp_array_size);
> > +	BNX2X_DEV_INFO("fp_array_size %d\n", fp_array_size);
> >   
> > -	fp = kzalloc_objs(*fp, bp->fp_array_size);
> > +	fp = kzalloc_objs(*fp, fp_array_size);
> >   	if (!fp)
> >   		goto alloc_err;
> >   	bp->fp = fp;
> > +	bp->fp_array_size = fp_array_size;
> ... when you have fixed the root cause of the issue


Hi Vadim,

Thanks for the review. You're right - once the bp->fp_array_size assignment is moved after bp->fp is set, the loop in bnx2x_free_mem_bp() naturally won't execute
when bp->fp is NULL, since bp->fp_array_size remains zero. The if (bp->fp) guard is indeed redundant. I'll remove it and send a v2 with only the assignment-order
fix.

Best regards,
Jiangshan Yi
