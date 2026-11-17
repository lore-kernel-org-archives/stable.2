Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=35.83.148.184
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1794959549;
	b=OLlFYzUYeSS+x7QOnUAtP77l1jTTup9g4ujX+j/KtT4bjq9V84DBruzbLdOyT9r9M1Av
	 7L9WuPCfoUaXokxks44xEjM3rqsP18UtYsV2w0R4K8a/CwTjMPnDKRGb94kzZQdc69Z7j
	 bW4503PhwZ3xEkG/GhgOkKJvBHuq1Gate8xadhtOEC8UK7tlpUMPJ2Qo6RvshjS6kI+ku
	 8gcfxZPz/uwR9rJxPn1cDYc/Hf9GoO7+0ywl0kPdCtCTS62aFo5MzTPWLtwYIbJs1k7Gh
	 70dSixRMmBU/RQyYGztIsisGvAyufwr2JE8xqoiDQmPASDOMTr/R8DKo08EdmHJWcuw==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1794959549;
	h=DMARC-Filter:DKIM-Signature:X-CSE-ConnectionGUID:X-CSE-MsgGUID:
	 X-IronPort-AV:Received:Received:X-Farcaster-Flow-ID:Received:Received:
	 From:To:CC:Subject:Date:Message-ID:X-Mailer:MIME-Version:
	 Content-Transfer-Encoding:Content-Type:X-Originating-IP:
	 X-ClientProxiedBy;
	bh=Oj27ZoZRGO6f9l0rOjkFlS9AJ/pIHpImGA5GqGadkpg=;
	b=qflNjBpJo3NK/Fgdv0u0HEvdpKhZQvV1ep3mdAl65z9Ist5zkDvn1sVRf8INnoO3zDAL
	 WmDEaOixvutHzNQL5FzaMj8jHH4IJjNr+5fKGBwXp5R9OVL2p7cJmcADroZVPPAEozxEi
	 j7bXI19rsgdMmdIdJmf0Z5wotR/jtqw4BCoWhkYqBGNKJa6YIT6NZSiaHqzPLlk+sFCo6
	 lp7V9Aj+wyHFp+tO9PGajjvyBQapwGztFOaQvU20Ai07iu/AUycgXCX9d1r+61gVET3GY
	 c4lZ0XUI5QcNiFyJTgvvcfxNmItjL1P/XKD9GCNlePNiHERGJgQHvMwoCQr47rjtgxw==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=amazon.com;
	spf=pass smtp.mailfrom=amazon.com;
	dkim=pass header.d=amazon.com header.i=@amazon.com header.a=rsa-sha256 header.s=amazoncorp2 header.b=OccpqJs4;
	arc=none smtp.remote-ip=35.83.148.184
Received: from pdx-out-014.esa.us-west-2.outbound.mail-perimeter.amazon.com (pdx-out-014.esa.us-west-2.outbound.mail-perimeter.amazon.com [35.83.148.184])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 713CF606A31C
	for <stable@vger.kernel.org>; Tue, 17 Nov 2026 23:52:29 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 713CF606A31C
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amazon.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=amazon.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=amazon.com header.i=@amazon.com header.a=rsa-sha256 header.s=amazoncorp2 header.b=OccpqJs4
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
  d=amazon.com; i=@amazon.com; q=dns/txt; s=amazoncorp2;
  t=1794959549; x=1826495549;
  h=from:to:cc:subject:date:message-id:mime-version:
   content-transfer-encoding;
  bh=Oj27ZoZRGO6f9l0rOjkFlS9AJ/pIHpImGA5GqGadkpg=;
  b=OccpqJs4uBysUHB7bEuEQPha6tZlRWfkjY2OHmKlJzY5XE9mLympcUsZ
   wh9qhFnNclDElk8sv9FhQyx/5QSVxbm+sZlmE/xwc14P4z22Ywxn861oI
   CiCaVeutLmgls92+XwCf8jhYmKwTA9JGPDB3SIYcapW/lQkhzJJtBAlEa
   CPOhps9VWuP/+ROhxl2yYpkfwAOb31exlxEvj4T6cpFvDovx5tgYmTxhj
   dULNNcSkHHR+8VveVNXJMZ2ce4495Vc1IU6+SXOB10sX7OrrIqakQUXTe
   iVW1SVwdeO5Xm5eqSzRjgOaQgV7pFg2VYwrBSJlNoiiP3MLF2u2CmPUmv
   A==;
X-CSE-ConnectionGUID: fmMcoQ5VT62lG8jwNs3LlA==
X-CSE-MsgGUID: czK9VFvASzWdzQIKIcqR8Q==
X-IronPort-AV: E=Sophos;i="6.27,219,1787011200"; 
   d="scan'208";a="34206782"
Received: from ip-10-5-0-115.us-west-2.compute.internal (HELO smtpout.naws.us-west-2.prod.farcaster.email.amazon.dev) ([10.5.0.115])
  by internal-pdx-out-014.esa.us-west-2.outbound.mail-perimeter.amazon.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 17 Nov 2026 23:52:29 +0000
Received: from EX19MTAUWB001.ant.amazon.com [205.251.233.104:9137]
 by smtpin.naws.us-west-2.prod.farcaster.email.amazon.dev [10.0.10.61:2525] with esmtp (Farcaster)
 id 03650fc5-501f-48bc-beb0-d7f5c1123645; Tue, 17 Nov 2026 23:52:28 +0000 (UTC)
X-Farcaster-Flow-ID: 03650fc5-501f-48bc-beb0-d7f5c1123645
Received: from EX19D001UWA001.ant.amazon.com (10.13.138.214) by
 EX19MTAUWB001.ant.amazon.com (10.250.64.248) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA) id 15.2.2562.56;
 Tue, 17 Nov 2026 23:52:28 +0000
Received: from dev-dsk-mkbund-2b-9ea2efba.us-west-2.amazon.com (10.2.100.138)
 by EX19D001UWA001.ant.amazon.com (10.13.138.214) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA) id 15.2.2562.56;
 Tue, 17 Nov 2026 23:52:28 +0000
From: Mark Bundschuh <mkbund@amazon.com>
To: <stable@vger.kernel.org>
CC: Mark Bundschuh <mkbund@amazon.com>
Subject: [PATCH 6.6.y 0/2] netfilter: nft_ct: move custom expectation support to helper
Date: Tue, 17 Nov 2026 23:52:14 +0000
Message-ID: <20261117235214.366021-1-mkbund@amazon.com>
X-Mailer: git-send-email 2.50.1
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Post: <mailto:stable@vger.kernel.org>
List-Help: <mailto:stable+help@vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
List-Owner: <mailto:stable+owner@vger.kernel.org>
Precedence: list
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: EX19D031UWC004.ant.amazon.com (10.13.139.246) To
 EX19D001UWA001.ant.amazon.com (10.13.138.214)

Also in this series:
  - 6fb421bd07f1 ("netfilter: nft_ct: expectation timeouts are passed in
    milliseconds") from v7.2-rc1 is included because it fixes the
    timeout unit bug this branch has, and the fix's moved code uses its
    jiffies timeout.
