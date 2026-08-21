Received: from mailgw.kylinos.cn (mailgw.kylinos.cn [124.126.103.232])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 44A8A3655DA;
	Fri, 21 Aug 2026 03:12:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=124.126.103.232
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1787281985; cv=none; b=FOSKsvqZD2Y+L7lMjsOC+LIhFhDeCjRbKeX06NCPz+7sCZMmLF6hqONd3l9pWVxppWJI4QPdy7wkrxXutOmq3S4zlr8NNeXmqgdZG/JW/zfY+lmCRMbNovqJrue7FEFIZgrx5bhEydylY+b72iX63z+fqKEHMZMRIaQ1rxrhBgc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1787281985; c=relaxed/simple;
	bh=9zS/2feqMiv79UKOVzQeNFiSXCLysMoiQeH4/+8878g=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=AMQonm9shFqVqEQsVirwXTFdrxinFuNZDJDJjtx3ftismxFfAV0MWUpAfo+JVQlwpstcQoQbAXTVdHvgkIIb0tUL/Dr0rJJW8YGKfw/Gy6yOCbIsRBUYSeH+H6qIeJSBGvaDby3GLXklSCgtw3ykkwP23hA8RKaBC/qWLdbUIbE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=kylinos.cn; spf=pass smtp.mailfrom=kylinos.cn; arc=none smtp.client-ip=124.126.103.232
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=kylinos.cn
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=kylinos.cn
X-UUID: 2f4f0a9c9d0e11f19a56ed5b684f684d-20260821
X-CID-P-RULE: Release_Ham
X-CID-O-INFO: VERSION:1.3.19,REQID:6cf76035-92f0-4f5e-b684-00ec14b7a182,IP:0,U
	RL:0,TC:0,Content:-5,EDM:25,RT:0,SF:0,FILE:0,BULK:0,RULE:Release_Ham,ACTIO
	N:release,TS:20
X-CID-META: VersionHash:7db8b62,CLOUDID:1a790a648c11cc52d3ac3ef1976b3b02,BulkI
	D:nil,BulkQuantity:0,SF:81|82|83|102|850|865|898,TC:nil,Content:0|15|50,ED
	M:5,IP:nil,URL:0,File:nil,RT:nil,Bulk:nil,QS:nil,BEC:nil,COL:0,OSI:0,OSA:0
	,AV:0,LES:1,SPR:NO,DKR:0,DKP:0,BRR:0,BRE:0,ARC:0
X-CID-BVR: 2,SSN|SDN
X-CID-BAS: 2,SSN|SDN,0,_
X-CID-FACTOR: TF_CID_SPAM_SNR
X-CID-RHF: D41D8CD98F00B204E9800998ECF8427E
X-UUID: 2f4f0a9c9d0e11f19a56ed5b684f684d-20260821
X-User: gonglinkai@kylinos.cn
Received: from localhost.localdomain [(10.44.16.150)] by mailgw.kylinos.cn
	(envelope-from <gonglinkai@kylinos.cn>)
	(Generic MTA with TLSv1.3 TLS_AES_256_GCM_SHA384 256/256)
	with ESMTP id 888229237; Fri, 21 Aug 2026 11:12:47 +0800
From: Linkai Gong <gonglinkai@kylinos.cn>
To: Jonathan Cameron <jic23@kernel.org>
Cc: Remi Buisson <remi.buisson@tdk.com>,
	David Lechner <dlechner@baylibre.com>,
	=?UTF-8?q?Nuno=20S=C3=A1?= <nuno.sa@analog.com>,
	Andy Shevchenko <andy@kernel.org>,
	linux-iio@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	stable@vger.kernel.org
Subject: Re: [PATCH] iio: imu: inv_icm45600: clamp FIFO packet count to buffer size
Date: Fri, 21 Aug 2026 11:12:44 +0800
Message-Id: <20260821031244.364478-1-gonglinkai@kylinos.cn>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20260821025105.4739d76b@jic23-huawei>
References: <20260820070208.3891851-1-gonglinkai@kylinos.cn> <20260821025105.4739d76b@jic23-huawei>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Hi Jonathan

On Fri, 21 Aug 2026 02:51:05 +0100, Jonathan Cameron wrote:
> I believe this is fixed in the iio tree (and shortly upstream), though
> in a slightly different way.

Sorry, I missed that. I'll drop this patch.

Thanks,
Linkai
