Received: from m16.mail.163.com (m16.mail.163.com [117.135.210.5])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 488673BB673;
	Sun, 27 Sep 2026 08:52:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=117.135.210.5
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1790499148; cv=none; b=f0k63agg+JAO9qVQxg/1l5iMVylcM556pCanaDW8lL84OMDW0+OMFqS9rFUSdcizpj3F+eko9v/RNMyByhUEi5fuSNfyhYA+rZSua9tgel87gN5LWK1HQwbR7LGSU+VkABKgdJuYA+s7KNe/nY2Lpax9NiubGftrsq2ewJJlz5Y=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1790499148; c=relaxed/simple;
	bh=TecmvBNd8yJ1krtCzl4y8PCs81k2pHGHLTSt6ZxyuzQ=;
	h=Date:From:To:Cc:Subject:In-Reply-To:References:Content-Type:
	 MIME-Version:Message-ID; b=gcDD+uejGst9V6UJhkiaXeLij3N+59DyATwJwuls4YL+d82v4EdHGC805GnYqgEH3C8vlmTZtR55EInaK2bHT98kmEDwuBHfGSIlgQx9P4vyg/S//xJktOgN3Ch6cTnwaBVQ0ioZMLSHWFueEpSNdMLOvjHh0bSTLwhrU9gSVx4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=163.com; spf=pass smtp.mailfrom=163.com; dkim=pass (1024-bit key) header.d=163.com header.i=@163.com header.b=RJX4r89t; arc=none smtp.client-ip=117.135.210.5
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=163.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=163.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=163.com header.i=@163.com header.b="RJX4r89t"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=163.com;
	s=s110527; h=Date:From:To:Subject:Content-Type:MIME-Version:
	Message-ID; bh=TecmvBNd8yJ1krtCzl4y8PCs81k2pHGHLTSt6ZxyuzQ=; b=R
	JX4r89tZ6vgqLHLkPm58Cnxb6juftMBxpOnZ/jlJCa+Thsii2OaabY/+X3lOCnKe
	JYUm317aX6iHJ7xkt25YAbcHPD7QCPjckqYKK4RtS8eTiM01q03FnawCCwQRvFct
	QN3ceMOcFhOi5z18NQ569+1KTAT1H5u0xeVwxAve0c=
Date: Sun, 27 Sep 2026 16:52:04 +0800 (CST)
From: "jiale yao" <19888972804@163.com>
To: "Guenter Roeck" <linux@roeck-us.net>
Cc: "Aleksa Savic" <savicaleksa83@gmail.com>, linux-hwmon@vger.kernel.org,
	linux-kernel@vger.kernel.org, stable@vger.kernel.org
Subject: Re: [PATCH] hwmon: (gigabyte_waterforce) reject short input reports
X-Priority: 3
X-Mailer: Coremail Webmail Server Version 2023.4-cmXT build
 20260511(2e539873) Copyright (c) 2002-2026 www.mailtech.cn 163com
In-Reply-To: <5b8b6c95-693a-4472-93c4-c54d22280b79@roeck-us.net>
References: <20260924151133.1233860-1-yaojiale02@163.com>
 <5b8b6c95-693a-4472-93c4-c54d22280b79@roeck-us.net>
X-NTES-SC: AL_Qu2SAviStkkp4iaRZOkcn08ShO49XMOyvfoi2YFTc+sEvBLV6y4KRnFjOn7G1NC9FgmWtRGvdzV/wflkUIdSKezsb7zcAXOahCYFYsXe0w==
Content-Transfer-Encoding: 7bit
Content-Type: text/plain; charset=GBK
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Message-ID: <563e3463.1869.1a0e21075da.Coremail.19888972804@163.com>
X-Coremail-Locale: zh_CN
X-CM-TRANSID:ZCgvCgD3Xxs12bhqikFPAA--.19W
X-CM-SenderInfo: x1dryxhdohiji6rwjhhfrp/xtbC8BVMhmq42TVXeAAA3+
X-Coremail-Antispam: 1U5529EdanIXcx71UUUUU7vcSsGvfC2KfnxnUU==

v2 in: https://lore.kernel.org/all/20260927084959.893708-1-yaojiale02@163.com/
