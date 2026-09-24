Received: from mailgw.kylinos.cn (mailgw.kylinos.cn [124.126.103.232])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DE56B3AFD0F;
	Thu, 24 Sep 2026 07:23:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=124.126.103.232
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1790234593; cv=none; b=DrM2maK4nvhg5e78beWFjHGI8oXBkcSFPuVB81Pa8KKh/5NVsTkKVgwdaGTtdHkuWJTgp04cmD1JmPihog2TVwTI45n0bBgklXXzkmmBRHlrGNeRZQ8FVeffr1tkvCBFnfjboJcrA35I3lG8pNHLi5YEBh762dqjdZdeNmfPi5I=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1790234593; c=relaxed/simple;
	bh=x9LDo+UipeUNtMrhE+Eb+JbCOWWQrSssAF42XWrgH80=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=Ug68BFsasjFy3vUd8PzQVG3aqiic/RMuZHWbXe1xpVTkELpLzEqLIThpiC9lB67DmoNp0ukAXUXiz4CQu4L/7siCd/SxLMp26REUR9iVTXe9bRnF7ccj6u6tiwuoGYOzqK4fSOhDuJFZMr8ttD8Vy213vLW65aXJAH69P6JR6l4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=kylinos.cn; spf=pass smtp.mailfrom=kylinos.cn; arc=none smtp.client-ip=124.126.103.232
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=kylinos.cn
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=kylinos.cn
X-UUID: c8e95a1eb7e811f19a56ed5b684f684d-20260924
X-CID-P-RULE: Release_Ham
X-CID-O-INFO: VERSION:1.3.19,REQID:7a431ce2-8505-4d6e-8b53-017c01f15f60,IP:0,U
	RL:0,TC:0,Content:-5,EDM:25,RT:0,SF:0,FILE:0,BULK:0,RULE:Release_Ham,ACTIO
	N:release,TS:20
X-CID-META: VersionHash:7db8b62,CLOUDID:83b1813c84353720e9892bcbb8f9e738,BulkI
	D:nil,BulkQuantity:0,SF:81|82|83|102|850|865|898,TC:nil,Content:0|15|50|99
	,EDM:5,IP:nil,URL:0,File:nil,RT:nil,Bulk:nil,QS:nil,BEC:nil,COL:0,OSI:0,OS
	A:0,AV:0,LES:1,SPR:NO,DKR:0,DKP:0,BRR:0,BRE:0,ARC:0
X-CID-BVR: 2,SSN|SDN
X-CID-BAS: 2,SSN|SDN,0,_
X-CID-FACTOR: TF_CID_SPAM_SNR
X-CID-RHF: D41D8CD98F00B204E9800998ECF8427E
X-UUID: c8e95a1eb7e811f19a56ed5b684f684d-20260924
X-User: huangwei@kylinos.cn
Received: from localhost.localdomain [(10.44.16.150)] by mailgw.kylinos.cn
	(envelope-from <huangwei@kylinos.cn>)
	(Generic MTA with TLSv1.3 TLS_AES_256_GCM_SHA384 256/256)
	with ESMTP id 1610454172; Thu, 24 Sep 2026 15:23:05 +0800
From: Huang Wei <huangwei@kylinos.cn>
To: Fan Wu <fanwu01@zju.edu.cn>
Cc: Heikki Krogerus <heikki.krogerus@linux.intel.com>,
	Song Li <songl@zju.edu.cn>,
	linux-usb@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	stable@vger.kernel.org,
	huangwei@kylinos.cn
Subject: Re: [PATCH] usb: typec: altmodes/displayport: Disable work before dp is freed
Date: Thu, 24 Sep 2026 15:22:58 +0800
Message-Id: <20260924072258.3630268-1-huangwei@kylinos.cn>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20260923024637.403624-1-fanwu01@zju.edu.cn>
References: <20260923024637.403624-1-fanwu01@zju.edu.cn>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Hi Fan,

I checked this over and the race is real - typec_remove() in the typec
bus only clears adev->ops after drv->remove() has returned, and it
even calls typec_altmode_set_state(adev, TYPEC_STATE_SAFE, NULL) in
between, so dp_altmode_vdm() and friends can definitely re-queue
dp->work after the cancel_work_sync() in dp_altmode_remove(). With dp
being devm-allocated that is a use-after-free waiting to happen.

disable_work_sync() is the right fix here - it drains the work and
rejects the late schedule_work() calls, and since probe always runs
INIT_WORK on a freshly allocated dp there is no risk of the disabled
state leaking into a later bind.

Reviewed-by: Huang Wei <huangwei@kylinos.cn>

Thanks,
Huang Wei
