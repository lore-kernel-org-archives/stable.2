Received: from mailgw.kylinos.cn (mailgw.kylinos.cn [124.126.103.232])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9751417993;
	Fri, 21 Aug 2026 07:20:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=124.126.103.232
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1787296829; cv=none; b=ScJjwzCPxqjU71naVpLz2ClSnAtnCUAblkWw6qdxmXeSucqiGXImNuE52ZJ5ITdhXn9wkyAyAi+TTjoHo28/KGat1npaIryekGDiJmLQv7ynDe9/b5ucrXGEt9PjLeBvK+KD9UYkDGIQu0Bb3H1AdFu+wRiqz+vdACMYUGDJPTc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1787296829; c=relaxed/simple;
	bh=ihglh/BV1L5dR2vwRA8WGkA9nnfdonNlIQVz+Jk0CtM=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=tcfIEfyCflzhx/nxV86g1VpFLU2PLyEShl8zhgb9UtkaTlb26Nju4P9ftOLPItR2fHRJofyzdGtia0Xd4/m8wBc9C+zDxqTFKp9cqW97Nq0zPDy2bIh9nLqphXs10Jjl6I8u+33xTNNBpd8yLAt/gYPKWKMzqfb517DRkdUOZfw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=kylinos.cn; spf=pass smtp.mailfrom=kylinos.cn; arc=none smtp.client-ip=124.126.103.232
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=kylinos.cn
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=kylinos.cn
X-UUID: c54b9a529d3011f19a56ed5b684f684d-20260821
X-CID-P-RULE: Release_Ham
X-CID-O-INFO: VERSION:1.3.19,REQID:ff5e3140-4ae5-47b0-ab6f-a80c14e2634c,IP:0,U
	RL:0,TC:0,Content:0,EDM:25,RT:0,SF:0,FILE:0,BULK:0,RULE:Release_Ham,ACTION
	:release,TS:25
X-CID-META: VersionHash:7db8b62,CLOUDID:bdce7af041bcd8f91c663cf6b5163349,BulkI
	D:nil,BulkQuantity:0,SF:81|82|83|102|850|865|898,TC:nil,Content:0|15|50,ED
	M:5,IP:nil,URL:0,File:nil,RT:nil,Bulk:nil,QS:nil,BEC:nil,COL:0,OSI:0,OSA:0
	,AV:0,LES:1,SPR:NO,DKR:0,DKP:0,BRR:0,BRE:0,ARC:0
X-CID-BVR: 2,SSN|SDN
X-CID-BAS: 2,SSN|SDN,0,_
X-CID-FACTOR: TF_CID_SPAM_SNR
X-CID-RHF: D41D8CD98F00B204E9800998ECF8427E
X-UUID: c54b9a529d3011f19a56ed5b684f684d-20260821
X-User: yijiangshan@kylinos.cn
Received: from localhost.localdomain [(10.44.16.150)] by mailgw.kylinos.cn
	(envelope-from <yijiangshan@kylinos.cn>)
	(Generic MTA with TLSv1.3 TLS_AES_256_GCM_SHA384 256/256)
	with ESMTP id 922733272; Fri, 21 Aug 2026 15:20:21 +0800
From: Jiangshan Yi <yijiangshan@kylinos.cn>
To: kuba@kernel.org
Cc: 13667453960@163.com,
	andrew+netdev@lunn.ch,
	ariele@broadcom.com,
	davem@davemloft.net,
	dmitry@broadcom.com,
	edumazet@google.com,
	eilong@broadcom.com,
	linux-kernel@vger.kernel.org,
	manishc@marvell.com,
	netdev@vger.kernel.org,
	pabeni@redhat.com,
	sashiko-bot@kernel.org,
	skalluru@marvell.com,
	stable@vger.kernel.org,
	vadim.fedorenko@linux.dev,
	yijiangshan@kylinos.cn,
	yuvalmin@broadcom.com
Subject: Re: Re: [PATCH v2] bnx2x: fix NULL pointer dereference in bnx2x_free_mem_bp()
Date: Fri, 21 Aug 2026 15:20:18 +0800
Message-Id: <20260821072018.366835-1-yijiangshan@kylinos.cn>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20260820124102.41d18d4b@kernel.org>
References: <20260820124102.41d18d4b@kernel.org>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

> This patch does not apply to net/main, please rebase and repost.
> -- 
> pw-bot: cr


Hi Jakub,

Thanks for the review. While rebasing onto net/main I found this was
already fixed by Abdun Nihaal in commit e354f7d60f14 ("bnx2x: fix null
pointer dereference in bnx2x_free_mem_bp()"), which you merged on
2026-07-20. The fix is functionally identical to this v2 (move
bp->fp_array_size after bp->fp is set, use the local fp_array_size),
so there is nothing left for me to resend.

The duplicate came in because the bug was reported through Sashiko's
automated reporting on 2026-08-15, after Abdun's fix had already
landed. Withdrawing this patch to avoid the duplication -- apologies
for the extra noise.

Best regards,
Jiangshan Yi
