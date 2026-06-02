Received: from mx1.secunet.com (mx1.secunet.com [62.96.220.36])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 972D03DB338;
	Tue,  2 Jun 2026 10:12:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=62.96.220.36
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1780395143; cv=none; b=aJZVHhZJMHYBa+A9kC0SYlyYBb137RRDBye1g9df+T2DFelPdVy75fQy7eaW30mJEgb2hcR8cqoe0CMDCNZJAjz/rxKyoFq1gWr13U9U9ZZEdl+zNfaklOFaKXyw2sgA/yXBN6s0mlUuTUX86HvuCK22z5NdJscfbUC+eL8rEDI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1780395143; c=relaxed/simple;
	bh=2NAio0MHv8BYG7XK3tUkFUn1ovnM+InLLL2mQgwAYTo=;
	h=Date:From:To:CC:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=pxzVxVjb7K7a1eyhfND9Lrri608lo6JUpRDwyQRRCel1Oubh+GML7mvhrwRjbhCy818mB5BlJlPHQvbYOSsD1snxEHZ/C+Eqor4f0HclhU+fQSUtNz6jtJzH97CmmbZoEWu8CzN9wdtaPsyjAJkVyXjqn7llD68x1gCMs6Gor7Y=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=secunet.com; spf=pass smtp.mailfrom=secunet.com; dkim=pass (2048-bit key) header.d=secunet.com header.i=@secunet.com header.b=jQlix4Dg; arc=none smtp.client-ip=62.96.220.36
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=secunet.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=secunet.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=secunet.com header.i=@secunet.com header.b="jQlix4Dg"
Received: from localhost (localhost [127.0.0.1])
	by mx1.secunet.com (Postfix) with ESMTP id B43902074F;
	Tue,  2 Jun 2026 12:12:19 +0200 (CEST)
X-Virus-Scanned: by secunet
Received: from mx1.secunet.com ([127.0.0.1])
 by localhost (mx1.secunet.com [127.0.0.1]) (amavisd-new, port 10024)
 with ESMTP id gZYpSn90M4hU; Tue,  2 Jun 2026 12:12:19 +0200 (CEST)
Received: from EXCH-01.secunet.de (rl1.secunet.de [10.32.0.231])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mx1.secunet.com (Postfix) with ESMTPS id 333142050A;
	Tue,  2 Jun 2026 12:12:19 +0200 (CEST)
DKIM-Filter: OpenDKIM Filter v2.11.0 mx1.secunet.com 333142050A
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=secunet.com;
	s=202301; t=1780395139;
	bh=MTsU1Y41x4+rjB1nFr7GfXqK79SwNq7FbfNTTogCOtA=;
	h=Date:From:To:CC:Subject:References:In-Reply-To:From;
	b=jQlix4DgD/WIIuRzp6z4h1Z86o3c3C7vAXydKvcN2cTKShwX10kDw2FTp3VDLerCA
	 QLo/ejzntWuI6IncrhBD6MpVkJcMoAcL97bhMFmJ3gYJFQVnV+ZMUuqTP1MfT2UOU5
	 mfYPuvYpsHOtnN/ylL0IQLpAyUH6gew1sh8lTyE0M8mPUnrFFNMSsYWbzSztu/um9L
	 QgXm54RlCIe6oab5/OoQG4m8ph/uVySA1BCwc3RS8UaHByTPg78amY+XlhLKRJyg2F
	 lJLd/XOPjDdisKXlpv83z/Kx1f4lQkIWWW1j7PIc4EYJdOiWBIw6N7UKkOOcZ9ZX0K
	 SpbTdBrdhCaCw==
Received: from secunet.com (10.182.7.193) by EXCH-01.secunet.de (10.32.0.171)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.37; Tue, 2 Jun
 2026 12:12:18 +0200
Received: (nullmailer pid 529991 invoked by uid 1000);
	Tue, 02 Jun 2026 10:12:17 -0000
Date: Tue, 2 Jun 2026 12:12:17 +0200
From: Steffen Klassert <steffen.klassert@secunet.com>
To: Takao Sato <takaosato1997@gmail.com>
CC: <netdev@vger.kernel.org>, <w@1wt.eu>, <davem@davemloft.net>,
	<herbert@gondor.apana.org.au>, <chopps@chopps.org>, <pfalcato@suse.de>,
	<stable@vger.kernel.org>
Subject: Re: [PATCH net v5] xfrm: iptfs: preserve shared-frag marker in
 iptfs_consume_frags()
Message-ID: <ah6sgVwMHiWVZsNB@secunet.com>
References: <20260526160957.1497109-1-takaosato1997@gmail.com>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Disposition: inline
In-Reply-To: <20260526160957.1497109-1-takaosato1997@gmail.com>
X-ClientProxiedBy: EXCH-03.secunet.de (10.32.0.183) To EXCH-01.secunet.de
 (10.32.0.171)

On Tue, May 26, 2026 at 01:09:57PM -0300, Takao Sato wrote:
> iptfs_consume_frags() transfers paged fragments from one socket buffer
> to another but fails to propagate the SKBFL_SHARED_FRAG flag. This is
> the same class of bug that was fixed in skb_try_coalesce() for
> CVE-2026-46300: when fragments backed by read-only page-cache pages are
> merged, the marker indicating their shared nature must be preserved so
> that ESP can decide correctly whether in-place encryption is safe.
> 
> Apply the same two-line fix used in skb_try_coalesce() to
> iptfs_consume_frags().
> 
> Fixes: b96ba312e21c ("xfrm: iptfs: share page fragments of inner packets")
> Cc: stable@vger.kernel.org # 6.14+
> Signed-off-by: Takao Sato <takaosato1997@gmail.com>

Applied, thanks a lot!
