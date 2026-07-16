Received: from mailgw.kylinos.cn (mailgw.kylinos.cn [124.126.103.232])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CEF103DDDC0;
	Thu, 16 Jul 2026 08:25:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=124.126.103.232
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1784190366; cv=none; b=hvkDJwK93S2rbScuRD6C2VIKonUY6VnHZfUZL/l+ylTBpPwj3ZSGbr/0HJu4MK0Hnn/3zgJzd+vUWj3ZLJ+3Fs9ko2LF+ScihJwEJsUjYnGcfdkwlDT+tnWT+dHf3eXsAiaRY11FrV5r58L7w89q30S/vigbWmnwSSNQ3QuB7IE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1784190366; c=relaxed/simple;
	bh=e18CscmtYwGiykERUkSbEgjrytqbgjvm6xykrJFYynY=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=CnWtwMN9mg/ftEuoVRfZzglM656W4mZU8HHoVQhiWWnHBkDOvrQ3Zves2PUkvvciAJtrGYBHbdfrcqThOqbKH73/SqC/X29ekdy+kUK/TGdA7k/I/VT9bhz2XPuXmCMF3bsrJX66rzfwysoT9ooh8iY3QbdbwWnceWFAU3Gg9ps=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=kylinos.cn; spf=pass smtp.mailfrom=kylinos.cn; arc=none smtp.client-ip=124.126.103.232
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=kylinos.cn
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=kylinos.cn
X-UUID: f610de4880ef11f1aa26b74ffac11d73-20260716
X-CID-P-RULE: Release_Ham
X-CID-O-INFO: VERSION:1.3.12,REQID:9a6ddbad-1e50-491d-a2eb-6eae3ccbac01,IP:15,
	URL:25,TC:0,Content:0,EDM:0,RT:0,SF:0,FILE:0,BULK:0,RULE:Release_Ham,ACTIO
	N:release,TS:40
X-CID-INFO: VERSION:1.3.12,REQID:9a6ddbad-1e50-491d-a2eb-6eae3ccbac01,IP:15,UR
	L:25,TC:0,Content:0,EDM:0,RT:0,SF:0,FILE:0,BULK:0,RULE:Release_Ham,ACTION:
	release,TS:40
X-CID-META: VersionHash:e7bac3a,CLOUDID:a91f91feecac09139382caf1843c88a0,BulkI
	D:260716162555F78DSFHR,BulkQuantity:0,Recheck:0,SF:10|38|66|78|102|123|127
	|136|865|898,TC:nil,Content:0|15|50,EDM:-3,IP:-2,URL:93|82|11|1,File:nil,R
	T:nil,Bulk:nil,QS:nil,BEC:nil,COL:0,OSI:0,OSA:0,AV:0,LES:1,SPR:NO,DKR:0,DK
	P:0,BRR:0,BRE:0,ARC:0
X-CID-BVR: 2,SSN|SDN
X-CID-BAS: 2,SSN|SDN,0,_
X-CID-FACTOR: TF_CID_SPAM_SNR,TF_CID_SPAM_ULN
X-CID-RHF: D41D8CD98F00B204E9800998ECF8427E
X-UUID: f610de4880ef11f1aa26b74ffac11d73-20260716
X-User: zhaoguohan@kylinos.cn
Received: from zgh-vmware-virtual-platform.localdomain [(116.128.244.171)] by mailgw.kylinos.cn
	(envelope-from <zhaoguohan@kylinos.cn>)
	(Generic MTA with TLSv1.3 TLS_AES_256_GCM_SHA384 256/256)
	with ESMTP id 1403865239; Thu, 16 Jul 2026 16:25:53 +0800
From: zhaoguohan@kylinos.cn
To: "Rob Herring (Arm)" <robh@kernel.org>,
	Tomeu Vizoso <tomeu@tomeuvizoso.net>,
	dri-devel@lists.freedesktop.org
Cc: Oded Gabbay <ogabbay@kernel.org>,
	Frank Li <Frank.Li@nxp.com>,
	Thomas Zimmermann <tzimmermann@suse.de>,
	linux-kernel@vger.kernel.org,
	stable@vger.kernel.org
Subject: [PATCH 0/3] accel/ethosu: fix probe and job cleanup errors
Date: Thu, 16 Jul 2026 16:25:27 +0800
Message-ID: <20260716082530.1023538-1-zhaoguohan@kylinos.cn>
X-Mailer: git-send-email 2.43.0
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

From: GuoHan Zhao <zhaoguohan@kylinos.cn>

Fix error handling and cleanup issues in the Arm Ethos-U driver.

Sashiko reported these issues while reviewing the Ethos-U MMIO mapping fix.
The report is available at:

https://sashiko.dev/#/patchset/20260716065219.931088-1-zhaoguohan@kylinos.cn?part=1

The first two patches unwind scheduler, runtime PM, and SRAM state when
probe or SRAM setup fails. The final patch fixes completion fence ownership
across submit failures and scheduler early exits.

GuoHan Zhao (3):
  accel/ethosu: clean up resources on probe failure
  accel/ethosu: propagate SRAM initialization errors
  accel/ethosu: fix job completion fence cleanup

 drivers/accel/ethosu/ethosu_drv.c | 39 +++++++++++++++++++++++++------
 drivers/accel/ethosu/ethosu_job.c |  8 ++++++-
 2 files changed, 39 insertions(+), 8 deletions(-)

-- 
2.43.0
