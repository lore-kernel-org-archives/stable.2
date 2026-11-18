Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=52.42.203.116
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1795023082;
	b=hHP9Kr63jKLAvqEvhBFIwfMzod7ICn5f4GVqzIxlhFuOI1r6VRKfbuF+Cmoj7V9rmQZb
	 xaApKPVV00TzHmiE/PgWCm96XAuWjgD7tdu0L6/IoDSHuddtmxZX+QAqcFXsauaeaBS4K
	 u4D8+Wlq2EIREE0Ozrt/3xYEg1F9tZlrwXdLWNZXYCczta9Sali2jzHKtpv3VASbTUjHx
	 GcEZ0AzuXM8CoHj3sFsT0SeFB8HFopeK/t/W7pb1U3WstOA/VFi/ZTTHKyjrA3ru+dcLZ
	 R+hEGP2bKTHJyBEDnVtBoKhph3qnYBoArNIDETBIt+9RaHDr3/RVFA+O0Mo7IHnPFqQ==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1795023082;
	h=DMARC-Filter:DKIM-Signature:X-CSE-ConnectionGUID:X-CSE-MsgGUID:
	 X-IronPort-AV:Received:Received:X-Farcaster-Flow-ID:Received:Received:
	 From:To:CC:Subject:Date:Message-ID:X-Mailer:In-Reply-To:References:
	 MIME-Version:Content-Transfer-Encoding:Content-Type:X-Originating-IP:
	 X-ClientProxiedBy;
	bh=QC9eOPe1WwxJRyuNeUbiRCss2KgxzgNVgYI0OWNkJHg=;
	b=rXfTvQOmcNYHJCxl+UsfwjA6k8V0sanG+2vjJtjgVQafqRRWHQztdYyPJdr6xNpKe8oP
	 pUarEU6L6OFvWTOWfZlUvpdGDqn6/fSz3KV6081bKUaPD9OGdBOzPhacbrN4g0naBvOst
	 O21dp3K2hbZcWEQ9LrHYIUVr2PvWy+tOuCAqDdJELabxHGgtKGGpRXPq9wpEttE5aQz7e
	 tDEJSyDEkG1GWx+bxuRrKn7qrjnUeEz+RVrmU2+BZtIhQxAI8/wS1TmNRxz4+1M8RA+mE
	 77grOOg+qFZ3Abc1/npLmLCVvocWcNEYDpPEJMCiMfsERvDatQsK118gM4GKopG/fEw==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=amazon.com;
	spf=pass smtp.mailfrom=amazon.com;
	dkim=pass header.d=amazon.com header.i=@amazon.com header.a=rsa-sha256 header.s=amazoncorp2 header.b="k/t8ocWi";
	arc=none smtp.remote-ip=52.42.203.116
Received: from pdx-out-008.esa.us-west-2.outbound.mail-perimeter.amazon.com (pdx-out-008.esa.us-west-2.outbound.mail-perimeter.amazon.com [52.42.203.116])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0C352606A325
	for <stable@vger.kernel.org>; Wed, 18 Nov 2026 17:31:21 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 0C352606A325
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amazon.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=amazon.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=amazon.com header.i=@amazon.com header.a=rsa-sha256 header.s=amazoncorp2 header.b=k/t8ocWi
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
  d=amazon.com; i=@amazon.com; q=dns/txt; s=amazoncorp2;
  t=1795023082; x=1826559082;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references:mime-version:content-transfer-encoding;
  bh=QC9eOPe1WwxJRyuNeUbiRCss2KgxzgNVgYI0OWNkJHg=;
  b=k/t8ocWi9Ce8z3Vz9MYk/sBZZzrMcvixGD92qjA/5l17+osYbkKhGK95
   qAKzmxb9F2ZC1F9z6d9EevWoSDRuJR9M+JNb0enewJthzpI79R+k8EnUg
   llhkdun+xaHweE5ytVZplBXpc/JRe3Xstw8OsqkKtMGvgpY8ftzm/xNOa
   Zj3v6FPBnrGRCUpDSpPznKUieQ5s+VO1ydRC6f/nxH4fqbvtGVUvYxJ1P
   CFowpmvSKOBn8nb2SyG2bGy4mKi7Lk3mI7fRSYBgZtyY4sKAvyb3bqfKh
   9qwUa8MkMxOnrgjr/22QpPU8Jg2/ZupGoYqMNsUzE2y6RLL+LkVIOBWnT
   w==;
X-CSE-ConnectionGUID: LV2vKm9LSy+FRmFefx1i5w==
X-CSE-MsgGUID: BFWb2UlQQ/Cmc3PK1z7hzQ==
X-IronPort-AV: E=Sophos;i="6.27,219,1787011200"; 
   d="scan'208";a="34521324"
Received: from ip-10-5-9-48.us-west-2.compute.internal (HELO smtpout.naws.us-west-2.prod.farcaster.email.amazon.dev) ([10.5.9.48])
  by internal-pdx-out-008.esa.us-west-2.outbound.mail-perimeter.amazon.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 18 Nov 2026 17:31:21 +0000
Received: from EX19MTAUWB001.ant.amazon.com [205.251.233.104:17247]
 by smtpin.naws.us-west-2.prod.farcaster.email.amazon.dev [10.0.16.231:2525] with esmtp (Farcaster)
 id 84a2dc32-0278-4aa5-b0f2-ed81cdc57b83; Wed, 18 Nov 2026 17:31:21 +0000 (UTC)
X-Farcaster-Flow-ID: 84a2dc32-0278-4aa5-b0f2-ed81cdc57b83
Received: from EX19D001UWA001.ant.amazon.com (10.13.138.214) by
 EX19MTAUWB001.ant.amazon.com (10.250.64.248) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA) id 15.2.2562.56;
 Wed, 18 Nov 2026 17:31:20 +0000
Received: from dev-dsk-mkbund-2b-9ea2efba.us-west-2.amazon.com (10.2.100.138)
 by EX19D001UWA001.ant.amazon.com (10.13.138.214) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA) id 15.2.2562.56;
 Wed, 18 Nov 2026 17:31:20 +0000
From: Mark Bundschuh <mkbund@amazon.com>
To: Greg KH <gregkh@linuxfoundation.org>
CC: <stable@vger.kernel.org>
Subject: Re: [PATCH 6.12.y 0/2] netfilter: nft_ct: move custom expectation support to helper
Date: Wed, 18 Nov 2026 17:31:09 +0000
Message-ID: <20261118173109.232034-1-mkbund@amazon.com>
X-Mailer: git-send-email 2.50.1
In-Reply-To: <2026111826-nuptials-sculpture-23e3@gregkh>
References: <2026111826-nuptials-sculpture-23e3@gregkh>
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
X-ClientProxiedBy: EX19D031UWC003.ant.amazon.com (10.13.139.252) To
 EX19D001UWA001.ant.amazon.com (10.13.138.214)

On Wed, Nov 18, 2026 at 11:46:38AM +0100, Greg KH wrote:
> Did yo uforget to include a 6.18.y series?

I sent it a bit earlier as a separate thread (it's the same as 6.12):
https://lore.kernel.org/all/20261117232211.stolba-3679da4ad8be-linux-6.18.y-v1-0@amazon.com

Thanks,
Mark
