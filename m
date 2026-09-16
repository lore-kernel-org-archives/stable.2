Received: from mg.richtek.com (mg.richtek.com [220.130.44.152])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 01F8644470C;
	Wed, 16 Sep 2026 08:55:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=220.130.44.152
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1789548931; cv=none; b=mgmUF0RKUSeMliTvWe7kZK2Kjc2WElwIREUbcX9iCcwnsCXw2C5QQHu+VsCk/ox9sbU1jVRqCDhlZXyfGESUyWWZG5CDUHwhz7cUfUoLlrCZC/RD+idqPjtJdzOWcf8A7Gi+mvfNiiCB7wM0s2dVhhmo6SZqCL4eqTwcDcac+oY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1789548931; c=relaxed/simple;
	bh=iXN+Sh+bwYpl3welJ9hu09Y3EyI9AOckRYnYg4jZ+Sw=;
	h=Date:From:To:CC:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=dMom3uvBnYDTn2HbXA51SeOfiQS6Blhv+Dm1hvP1HvODHmkZWJo8S9SYzwAwljBpaTA4WAPkY4JoCnhntUDPYfKpEfx/YtoTzTNhfb3YS1qePl216FSjR6ngipKSxP5yfGMsr/U1MFLPoX/DxtWYOfXq8aQp3m6C3R9EK6QU5BY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=richtek.com; spf=pass smtp.mailfrom=richtek.com; dkim=pass (2048-bit key) header.d=richtek.com header.i=@richtek.com header.b=vIDoyYJ7; dkim=pass (2048-bit key) header.d=richtek.com header.i=@richtek.com header.b=CjdggX5U; arc=none smtp.client-ip=220.130.44.152
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=richtek.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=richtek.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=richtek.com header.i=@richtek.com header.b="vIDoyYJ7";
	dkim=pass (2048-bit key) header.d=richtek.com header.i=@richtek.com header.b="CjdggX5U"
X-MailGates: (SIP:2,PASS,NONE)(compute_score:DELIVER,40,3)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=richtek.com;
	s=richtek; t=1789548916;
	bh=fWXGWTLCR3g/zPREm0UVOFTy/M2mYEGMRik76M93k9U=; l=687;
	h=Date:From:To:Subject:Message-ID:MIME-Version;
	b=vIDoyYJ7sr/zBQnZLgq/MJ7RyYGP58LZREGIzc/OjWwgyEwY7smrDsB6OkMtXFAjB
	 Q+f5PRppnmefVLhp60cbUX+qTsshSQzdrRcAnDKUkYNf8UraXZ7uWwOp0CIv3iDCvW
	 A3l3MGWXk0SrdIhV3TVCn8VAPH1Ag/SYkxK7AqqEGqx4oyYCM4Q1z0gITd64O1Fa+Z
	 CL/jb62BbV/BDeOlfh5iKNvPE66CVoeCQoZ2k9mT/z8Pi9sSZ3XP81uqs1q/cEGqTm
	 BYiv0vmEBhDRxO97sNxiVcCVO1DReesYbs+jH5EbOKEzi7+XbZZXjgmGsYIXD7dLhf
	 ya33EdGtQaVfg==
Received: from 192.168.8.21
	by mg.richtek.com with MailGates ESMTP Server V3.0(1128083:0:AUTH_RELAY)
	(envelope-from <prvs=1716486475=cy_huang@richtek.com>); Wed, 16 Sep 2026 16:55:13 +0800 (CST)
X-MailGates: (compute_score:DELIVER,40,3)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=richtek.com;
	s=richtek; t=1789548913;
	bh=fWXGWTLCR3g/zPREm0UVOFTy/M2mYEGMRik76M93k9U=; l=687;
	h=Date:From:To:Subject:Message-ID:MIME-Version;
	b=CjdggX5UKGrF0ra0KeyD9RSikYqrV+6HnPDprJ4vqjExsHqGEK5R05ILXE0LaHVs9
	 lrA1UZ3zwM0lJx+cwXD6qx8nIK6sTfQAk94U8rSz8uH4HbPUa+lMQO9zmr19GVKi04
	 LrGd3Rs4gwmLvKHjsqQ70IbFrBozOTu8rNDQ79OjK+wA+N5H3Af7QDupTCYh5zCIJN
	 1eZlmFkvNZEojCv+rM9Z1jFJQ4tqxnemY6vusZKwahNIeESC39u8VUNm7sYRr77tVZ
	 nU1cTA31n/FcP8+ooPZksgAqkIRaHKYC1WEtDrXxQTLnxtlR7FhFZwSW2Kwnlge1OG
	 Lb15O9W+AIb1A==
Received: from 192.168.10.46
	by mg.richtek.com with MailGates ESMTPS Server V6.0(3787405:0:AUTH_RELAY)
	(envelope-from <cy_huang@richtek.com>)
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256/256); Wed, 16 Sep 2026 16:46:59 +0800 (CST)
Received: from ex4.rt.l (192.168.10.47) by ex3.rt.l (192.168.10.46) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.1748.26; Wed, 16 Sep
 2026 16:46:59 +0800
Received: from git-send.richtek.com (192.168.10.154) by ex4.rt.l
 (192.168.10.45) with Microsoft SMTP Server id 15.2.1748.26 via Frontend
 Transport; Wed, 16 Sep 2026 16:46:59 +0800
Date: Wed, 16 Sep 2026 16:46:59 +0800
From: ChiYuan Huang <cy_huang@richtek.com>
To: Wentao Liang <vulab@iscas.ac.cn>
CC: <broonie@kernel.org>, <lgirdwood@gmail.com>,
	<linux-kernel@vger.kernel.org>, <stable@vger.kernel.org>
Subject: Re: [PATCH] regulator: rt6190: Fix runtime PM imbalance in
 rt6190_out_enable()
Message-ID: <aqpXg1TfV4ghoShD@git-send.richtek.com>
References: <20260916072541.1968033-1-vulab@iscas.ac.cn>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Disposition: inline
In-Reply-To: <20260916072541.1968033-1-vulab@iscas.ac.cn>

On Wed, Sep 16, 2026 at 07:25:41AM +0000, Wentao Liang wrote:
> In rt6190_out_enable(), pm_runtime_get_sync() is called at the start of
> the function. However, if any subsequent regmap or regulator operation
> fails, the function returns directly without dropping the runtime PM
> reference, causing a runtime PM reference leak.
> 
> Add an error handling path with pm_runtime_put() to keep the reference
> count balanced on failure.
> 
> Fixes: e6999e7cca7e ("regulator: rt6190: Add support for Richtek RT6190 regulator")
> Cc: stable@vger.kernel.org
> Signed-off-by: Wentao Liang <vulab@iscas.ac.cn>
Reviewed-by: ChiYuan Huang <cy_huang@richtek.com>

Thanks for the fix.
