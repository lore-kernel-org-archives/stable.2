Received: from mailgw.kylinos.cn (mailgw.kylinos.cn [124.126.103.232])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id EDF2F3E49E0;
	Mon, 17 Aug 2026 09:36:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=124.126.103.232
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1786959378; cv=none; b=Y4cPE7/qMxOi8vGM7VgAsi/qBvsd890fLhFmBbYWDJPk78vgYhCO5ZPq85/8FuWDm3GnYKMpjLPN0PWDyM4vau7b99u8GY9bQbTCm4HRahxK1Isu6mQbxj8VgopuUeWXEzBIse0nDeVJ3HWXGFu5RoYEO74rY7guvuHhDAY8k6w=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1786959378; c=relaxed/simple;
	bh=MMBbMyAfD5/BSR3ygUoe8YF0t88db4CYBoj84yqBI4I=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=TADf2pNjbajWnjn3Fzw1JfX8wXOotczGez7kMNfWtowdsrDixwbr34pIG0w4+BThhlsh+ytJ6Q4+1hYQKf7ArguHYDqfyBW+waypeHRpZvbwLwqtwCpnCvw/N/wFUTF2t4GO1L3YznyafYQ+Bpyz8q+5AXSvr1StaujFDDGZSvk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=kylinos.cn; spf=pass smtp.mailfrom=kylinos.cn; arc=none smtp.client-ip=124.126.103.232
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=kylinos.cn
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=kylinos.cn
X-UUID: 1083f4029a1f11f19a56ed5b684f684d-20260817
X-CID-P-RULE: Release_Ham
X-CID-O-INFO: VERSION:1.3.19,REQID:b3fcc05e-5f9c-46bd-b2c0-6d7660565000,IP:0,U
	RL:0,TC:0,Content:-5,EDM:25,RT:0,SF:0,FILE:0,BULK:0,RULE:Release_Ham,ACTIO
	N:release,TS:20
X-CID-META: VersionHash:7db8b62,CLOUDID:339458c6648417d1d4e756f2dd9a31a2,BulkI
	D:nil,BulkQuantity:0,SF:81|82|83|102|850|865|898,TC:nil,Content:0|15|50,ED
	M:5,IP:nil,URL:99|1,File:nil,RT:nil,Bulk:nil,QS:nil,BEC:nil,COL:0,OSI:0,OS
	A:0,AV:0,LES:1,SPR:NO,DKR:0,DKP:0,BRR:0,BRE:0,ARC:0
X-CID-BVR: 2,SSN|SDN
X-CID-BAS: 2,SSN|SDN,0,_
X-CID-FACTOR: TF_CID_SPAM_SNR,TF_CID_SPAM_ULS
X-CID-RHF: D41D8CD98F00B204E9800998ECF8427E
X-UUID: 1083f4029a1f11f19a56ed5b684f684d-20260817
X-User: huangwei@kylinos.cn
Received: from localhost.localdomain [(10.44.16.150)] by mailgw.kylinos.cn
	(envelope-from <huangwei@kylinos.cn>)
	(Generic MTA with TLSv1.3 TLS_AES_256_GCM_SHA384 256/256)
	with ESMTP id 965690353; Mon, 17 Aug 2026 17:36:03 +0800
From: Huang Wei <huangwei@kylinos.cn>
To: Heikki Krogerus <heikki.krogerus@linux.intel.com>
Cc: Huang Wei <huangwei@kylinos.cn>,
	Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
	Fedor Pchelkin <boddah8794@gmail.com>,
	Benson Leung <bleung@chromium.org>,
	Pooja Katiyar <poojakatiyar@google.com>,
	linux-usb@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	stable@vger.kernel.org
Subject: Re: [PATCH] usb: typec: ucsi: use UCSI_TIMEOUT_MS for sync command completion
Date: Mon, 17 Aug 2026 17:36:00 +0800
Message-Id: <20260817093600.245921-1-huangwei@kylinos.cn>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <anMvC16L57IAiBZo@black.igk.intel.com>
References: <20260805085725.389761-1-huangwei@kylinos.cn> <anMvC16L57IAiBZo@black.igk.intel.com>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Hi Heikki,

Thanks a lot for the review!

One small thing in case you haven't queued this yet: the second Link
tag in the commit message,

    Link: https://bugzilla.kernel.org/show_bug.cgi?id=2183790

has a typo in the bug ID (2183790 does not exist - kernel.org bugzilla
IDs are six digits). Please feel free to drop that line when applying;
the first link (bug 221740) is the relevant one.

Best regards,
Huang Wei
