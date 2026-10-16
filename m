Received: from gentwo.org (gentwo.org [62.72.0.81])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8EDA8563FA2
	for <stable@vger.kernel.org>; Fri, 16 Oct 2026 17:21:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=62.72.0.81
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1792171317; cv=none; b=hn+lK6Oufq0UUcpPvNHarLtBXZW439BR7WdgtnIvjzrK3N/NA8zxdpRd81qdHWBGRcgF9St5Xjs391/WDxLRNEGi0F4jcklklQ799ZuMzPaI9HsoqlJtkY5qgEnC+9CKTK5lc+q+v0lc/oiCwd7oGmLCHSOHIbevY1hIyxattJc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1792171317; c=relaxed/simple;
	bh=zLf4n78l1h3bFu2neIcXuiZTO4IVRDeWTVRUwmBGKyI=;
	h=To:Subject:References:In-Reply-To:Message-Id:Date:From; b=op9hYjyUq0Pg0WmLtsQRX/d33peSiwphNw8snwl+oC8d0hbfnZndOHPS2XBYg+plYPZMKIWQQIkK5xfBN21cMIq7+YTtCe0eHri7WPz55wWleq2qNVHr6n+BH0I2HWxcmLSiQMohbmxLkoLUFL7GP+QXAuRjw07+sjL1JJUob1o=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=gentwo.org; spf=pass smtp.mailfrom=gentwo.org; dkim=pass (1024-bit key) header.d=gentwo.org header.i=@gentwo.org header.b=hJTa6aBi; arc=none smtp.client-ip=62.72.0.81
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=gentwo.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gentwo.org
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=gentwo.org header.i=@gentwo.org header.b="hJTa6aBi"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=gentwo.org;
	s=default; t=1792171316;
	bh=zLf4n78l1h3bFu2neIcXuiZTO4IVRDeWTVRUwmBGKyI=;
	h=To:Subject:References:In-Reply-To:Date:From:From;
	b=hJTa6aBikuQScxtw26etS9yatsH40MJ3SJ8eo4lJ3Yllyq+4A46+VkepPxmjIq02k
	 SQPNYEMuiEod/F5wsaqtDoHgzzaa6bEHRvuulnSctRG9DPlueXqFve3pNOxQSbyO7n
	 YONH8ydqKtLbIS8YOgrLaYMddzL/tpZUs1Irk+k8=
Received: by gentwo.org (Postfix, from userid 1006)
	id 1D51A40B13; Fri, 16 Oct 2026 10:21:56 -0700 (PDT)
To: stable@vger.kernel.org
Subject: Re: Patch "mm/slub: avoid zeroing outside-object freepointer for single free" has been added to the 6.6-stable tree
References: <20261016172152.3999481-1-sashal@kernel.org>
In-Reply-To: <20261016172152.3999481-1-sashal@kernel.org>
X-Loop: christoph@linux.com
Message-Id: <20261016172156.1D51A40B13@gentwo.org>
Date: Fri, 16 Oct 2026 10:21:56 -0700 (PDT)
From: Christopher <cllinux@gentwo.org>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>

From: Christoph Lameter <christoph@linux.com>
Subject: Email address change

My email address has changed to christoph@gentwo.org. The email at linux.com will be decommissioned on May, 1st 2026.

Regards,

   Christoph


