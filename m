Received: from mailgw.kylinos.cn (mailgw.kylinos.cn [124.126.103.232])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id F31C3137750;
	Mon, 21 Sep 2026 03:03:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=124.126.103.232
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1789959841; cv=none; b=rtY8l9GtM+++7GZTm+3xSgG4DMLk8Guf7+cpoTsL4cfWLTYbGmPu974qBhs2G216T3/5yVntTYIs7u7z4+qBb/sj+gx1hlBmDS05m9MKW7xVJyQC5QLNbu+oloMNYVNavdD6IF1c1kzk7ZrrbO0CuZHiTunhX3g/DEnDN0+488k=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1789959841; c=relaxed/simple;
	bh=KWhuBjbwfi7WglSaWQxbY7xHHh2NdcCSZEaFi15ytcY=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=iJqThsfD9MZ7vurAAxLXFG4iI4QBz6RS++D6xD5pnDTGF9UiBsDL4nMo1dO7Bmz06WcfmmrKrCycbn7jhfm3Ju5yn2Mzd1fkGplS43sTrAg19ej4uVijoRvgpxdhn4pDoKGHZ840B7UkRLBbaNL18Z8TpuWrnYyFpvgJ6cS7w6E=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=kylinos.cn; spf=pass smtp.mailfrom=kylinos.cn; arc=none smtp.client-ip=124.126.103.232
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=kylinos.cn
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=kylinos.cn
X-UUID: 1313cf0cb56911f19a56ed5b684f684d-20260921
X-CID-P-RULE: Release_Ham
X-CID-O-INFO: VERSION:1.3.19,REQID:0847bfae-4d02-4db8-b78b-09d15df366d2,IP:0,U
	RL:0,TC:0,Content:-5,EDM:25,RT:0,SF:0,FILE:0,BULK:0,RULE:Release_Ham,ACTIO
	N:release,TS:20
X-CID-META: VersionHash:7db8b62,CLOUDID:17243fed589d5c9f9e8e997ee710885f,BulkI
	D:nil,BulkQuantity:0,SF:81|82|83|102|850|865|898,TC:nil,Content:0|15|50|99
	,EDM:5,IP:nil,URL:0,File:nil,RT:nil,Bulk:nil,QS:nil,BEC:nil,COL:0,OSI:0,OS
	A:0,AV:0,LES:1,SPR:NO,DKR:0,DKP:0,BRR:0,BRE:0,ARC:0
X-CID-BVR: 2,SSN|SDN
X-CID-BAS: 2,SSN|SDN,0,_
X-CID-FACTOR: TF_CID_SPAM_SNR
X-CID-RHF: D41D8CD98F00B204E9800998ECF8427E
X-UUID: 1313cf0cb56911f19a56ed5b684f684d-20260921
X-User: huangwei@kylinos.cn
Received: from localhost.localdomain [(10.44.16.150)] by mailgw.kylinos.cn
	(envelope-from <huangwei@kylinos.cn>)
	(Generic MTA with TLSv1.3 TLS_AES_256_GCM_SHA384 256/256)
	with ESMTP id 922778612; Mon, 21 Sep 2026 11:03:52 +0800
From: Huang Wei <huangwei@kylinos.cn>
To: Yogesh Gaur <yogeshgaur.83@gmail.com>
Cc: Heikki Krogerus <heikki.krogerus@linux.intel.com>,
	Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
	linux-usb@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	stable@vger.kernel.org,
	syzbot+e7aa19176573a6992617@syzkaller.appspotmail.com,
	huangwei@kylinos.cn
Subject: Re: [PATCH] usb: typec: ucsi: acpi: don't dereference a missing ACPI companion
Date: Mon, 21 Sep 2026 11:03:46 +0800
Message-Id: <20260921030346.1996820-1-huangwei@kylinos.cn>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20260920090711.300-1-yogeshgaur.83@gmail.com>
References: <20260920090711.300-1-yogeshgaur.83@gmail.com>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Hi Yogesh,

I checked this over. The fix is correct - the sysfs bind path can
indeed hand a non-ACPI platform device to ucsi_acpi_probe(), and
adev->dep_unmet is the first dereference.

I also went and checked the "only unchecked ACPI_COMPANION() in
drivers/usb/typec" claim. port-mapper.c looked like a second candidate
at first glance, but typec_link_ports() bails out early when the port
has no ACPI companion, so typec_port_match() never runs with
con_adev == NULL. The claim holds.

Fixes: 1f3546ff3f0a is also the right one for the stable backport -
that commit added the dep_unmet check back in 2020, so the deref has
been there a while.

Reviewed-by: Huang Wei <huangwei@kylinos.cn>

Thanks,
Huang Wei
