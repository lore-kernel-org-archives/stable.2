Received: from mailgw.kylinos.cn (mailgw.kylinos.cn [124.126.103.232])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 02FB1126BE1;
	Mon, 12 Oct 2026 03:16:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=124.126.103.232
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1791774981; cv=none; b=jYx1Zixd3jFzFP0mYMXzRRiFLZDpqdflXxQQyd6C+W5pfCcCHGaY2YHLgOcOQWf+UACA3Z3BMRr7IyAmRVRR9/veeg03YwqIStK4k2RwByJ5m6fmLGPUHA0vvSGDAFo7gdIpap14kWyB+srA60eSW0bZMIPvYEIP/qbCMnkSH6c=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1791774981; c=relaxed/simple;
	bh=3p5WTVA2pOH2YHLPjmO3MjRmdIDi+rOuQxWLhvQ1IQY=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=gjmnoEkqyX+9zE3KwuleB76erBnfgkAG3/5ghLXy4NO15Kw3f3wglWcJa0vQ6nCvBAs2q3xpHnG0au/5kfb/k+69pl375cd/OEohYnHcQgUb5c0X8PFttKvr6vjrA0dhmkLjXENITafDQ0v1v9bkNPkgh7oGpIqM/TN7vzVAlYY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=kylinos.cn; spf=pass smtp.mailfrom=kylinos.cn; arc=none smtp.client-ip=124.126.103.232
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=kylinos.cn
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=kylinos.cn
X-UUID: 44dd2ebac5eb11f19a56ed5b684f684d-20261012
X-CID-P-RULE: Release_Ham
X-CID-O-INFO: VERSION:1.3.19,REQID:23d6faa1-bfdb-414e-8e12-f268d10a601c,IP:0,U
	RL:0,TC:0,Content:0,EDM:25,RT:0,SF:0,FILE:0,BULK:0,RULE:Release_Ham,ACTION
	:release,TS:25
X-CID-META: VersionHash:7db8b62,CLOUDID:de48f01b6d707df912f49ff6c23cc641,BulkI
	D:nil,BulkQuantity:0,SF:81|82|83|102|850|865|898,TC:nil,Content:0|15|50|99
	,EDM:5,IP:nil,URL:0,File:nil,RT:nil,Bulk:nil,QS:nil,BEC:nil,COL:0,OSI:0,OS
	A:0,AV:0,LES:1,SPR:NO,DKR:0,DKP:0,BRR:0,BRE:0,ARC:0
X-CID-BVR: 2,SSN|SDN
X-CID-BAS: 2,SSN|SDN,0,_
X-CID-FACTOR: TF_CID_SPAM_SNR
X-CID-RHF: D41D8CD98F00B204E9800998ECF8427E
X-UUID: 44dd2ebac5eb11f19a56ed5b684f684d-20261012
X-User: huangwei@kylinos.cn
Received: from localhost.localdomain [(10.44.16.150)] by mailgw.kylinos.cn
	(envelope-from <huangwei@kylinos.cn>)
	(Generic MTA with TLSv1.3 TLS_AES_256_GCM_SHA384 256/256)
	with ESMTP id 49622387; Mon, 12 Oct 2026 11:16:08 +0800
From: Huang Wei <huangwei@kylinos.cn>
To: Bertrand Jacquin <bertrand@jacquin.bzh>
Cc: Heikki Krogerus <heikki.krogerus@linux.intel.com>,
	Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
	Venkat Jayaraman <venkat.jayaraman@intel.com>,
	linux-usb@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	stable@vger.kernel.org,
	huangwei@kylinos.cn
Subject: Re: [PATCH] usb: typec: ucsi: Fix NULL pointer dereference in power level debugfs
Date: Mon, 12 Oct 2026 11:16:05 +0800
Message-Id: <20261012031606.2858685-1-huangwei@kylinos.cn>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20261010120357.4937-1-bertrand@jacquin.bzh>
References: <20261010120357.4937-1-bertrand@jacquin.bzh>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Hi Bertrand,

I checked this over. The window is real - ucsi_register() creates the
debugfs entries right away while ucsi->connector is only assigned at
the end of ucsi_init(), so on the PPM-init-failed path those three
files stay reachable with a NULL connector.

I also grepped debugfs.c for other ucsi->connector dereferences - the
three show functions the patch guards are the only ones (ucsi_resp
and the command interface go through ucsi->debugfs), so the fix is
complete.

One thing I'd note in favour of guarding rather than moving
ucsi_debugfs_register() after connector assignment: the command and
response files are exactly what you want available when the PPM is
misbehaving, so keeping the early registration and just making the
power-level reads fail cleanly looks like the better shape to me.

Reviewed-by: Huang Wei <huangwei@kylinos.cn>

Thanks,
Huang Wei
