Received: from pdx-out-007.esa.us-west-2.outbound.mail-perimeter.amazon.com (pdx-out-007.esa.us-west-2.outbound.mail-perimeter.amazon.com [52.34.181.151])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7A51E1E47C5;
	Tue, 30 Jun 2026 22:37:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=52.34.181.151
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1782859051; cv=none; b=dervKNvE1bZKhgIRLV4ORmvVyuooUjzc8CHo4gsU0ZOhIShMzSfr8dOrlo8D1HcAIuwgmWnf6d63gu2rGIdcNLZ17r/w4PoWnFr6rMLAAuKdJqu18PMTptip4/JqPvmuoPumF4Zb1wVtFedX64yhynFgYARiCk1PUyflA2Y6/f8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1782859051; c=relaxed/simple;
	bh=in7mPo4C6ACXr0Pq9kDFAU6aCviXWc4Kzq1KHs1G980=;
	h=From:To:CC:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=f1pIJ8uVsARLa2lj7xgNGPaTr0XAHLFhomdEFBKaX08l4w1SB2r9LFBeajxAPfOUNO+Rf8eaSwkHh5gxyaErXejnTA+qnRV8OYMPX4oI2yjG4HdflyHxi2+LVvG6XLzjy5sKwZ5043K/+OwCX09Id8qIJz7d67Wpe2YvItQb1JU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amazon.com; spf=pass smtp.mailfrom=amazon.com; dkim=pass (2048-bit key) header.d=amazon.com header.i=@amazon.com header.b=P25bn9D4; arc=none smtp.client-ip=52.34.181.151
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amazon.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=amazon.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=amazon.com header.i=@amazon.com header.b="P25bn9D4"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
  d=amazon.com; i=@amazon.com; q=dns/txt; s=amazoncorp2;
  t=1782859050; x=1814395050;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references:mime-version:content-transfer-encoding;
  bh=5YkH6Qf/i5JrCI3DdmIDJDZi0IXbWa1/DAyXW2C45Io=;
  b=P25bn9D4TGVxvAPe077pXcK1QrfNW3O2JuN754Sl1FAjMXWOfVF3qbwg
   6Rdm+z3W/B8+2tYlpDZ/h7uPBOpUQ4Iqu2YrP9fYyvbA020MzM/YNodO1
   BaJ54/5DcFwJLqFCUTgpRz4UAz2TWTH0nF+9Iq2S2dJW4UqdZ03LDyE/1
   C7H09STulJMLZb17AeDO2SkXtmRRytOH5vPyT+OUYTTnSlExW4sl3xfIJ
   30B+Ebhx9kgQV8kolI8YDpE1crKiQbaEccpJnZ1MUVK1fGhH7rCHch7hU
   P2o2qOt8ByF0NhxJmx3JWCYu8vduxqgOSVoVgfQpaLEgCT/V1AQz1h7rY
   g==;
X-CSE-ConnectionGUID: nsOYh9xXRzGrNxXoiVRK5g==
X-CSE-MsgGUID: V8Mp3iX5QqaEeZO6P8I05w==
X-IronPort-AV: E=Sophos;i="6.24,234,1774310400"; 
   d="scan'208";a="22792786"
Received: from ip-10-5-0-115.us-west-2.compute.internal (HELO smtpout.naws.us-west-2.prod.farcaster.email.amazon.dev) ([10.5.0.115])
  by internal-pdx-out-007.esa.us-west-2.outbound.mail-perimeter.amazon.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 30 Jun 2026 22:37:30 +0000
Received: from EX19MTAUWA001.ant.amazon.com [205.251.233.182:4678]
 by smtpin.naws.us-west-2.prod.farcaster.email.amazon.dev [10.0.4.192:2525] with esmtp (Farcaster)
 id b662b5e3-5bb4-443f-925f-bbee2fbe9f4d; Tue, 30 Jun 2026 22:37:29 +0000 (UTC)
X-Farcaster-Flow-ID: b662b5e3-5bb4-443f-925f-bbee2fbe9f4d
Received: from EX19D001UWA001.ant.amazon.com (10.13.138.214) by
 EX19MTAUWA001.ant.amazon.com (10.250.64.217) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA) id 15.2.2562.43;
 Tue, 30 Jun 2026 22:37:29 +0000
Received: from 6c7e67c92ceb.amazon.com (10.187.170.26) by
 EX19D001UWA001.ant.amazon.com (10.13.138.214) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA) id 15.2.2562.43;
 Tue, 30 Jun 2026 22:37:29 +0000
From: Nathan Gao <zcgao@amazon.com>
To: <pbonzini@redhat.com>
CC: <bkov@amazon.com>, <doebel@amazon.de>, <fgriffo@amazon.co.uk>,
	<kvm@vger.kernel.org>, <linux-kernel@vger.kernel.org>, <seanjc@google.com>,
	<stable@vger.kernel.org>, <zcgao@amazon.com>, <awallace@redhat.com>
Subject: Re: stable backports for "KVM: x86: Fix shadow paging use-after-free due to unexpected GFN"
Date: Tue, 30 Jun 2026 15:37:23 -0700
Message-ID: <20260630223723.83727-1-zcgao@amazon.com>
X-Mailer: git-send-email 2.50.1
In-Reply-To: <CABgObfawkiKRDz0to=oCjo1vygVAkHyZXAzpsLWT2GXwkszV_A@mail.gmail.com>
References: <CABgObfawkiKRDz0to=oCjo1vygVAkHyZXAzpsLWT2GXwkszV_A@mail.gmail.com>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: EX19D046UWA001.ant.amazon.com (10.13.139.112) To
 EX19D001UWA001.ant.amazon.com (10.13.138.214)

We identified commit a955cad84cda ("KVM: x86/mmu: Retry page fault if root is invalidated by memslot update")
may be the missing piece. After backporting this patch, it's no longer reproducible after 20 consecutive attempts.  

Thanks to Nicolas Saenz Julienne <nsaenz@amazon.com> who found this regression initially.

Best,
Nathan
