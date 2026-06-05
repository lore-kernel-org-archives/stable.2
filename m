Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 292784071CA
	for <stable@vger.kernel.org>; Fri,  5 Jun 2026 19:37:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1780688271; cv=none; b=PZhGod/bP4EZkz4Sn3S2PcvFKvMdIoAd3FJOkY/OO/4cC5hS43oa9z5a6UXgP1rgpic+KkaJU6WVGy58wzc64SWBqFBc+bGPhlpg+faJK7sRMowRDn0bTKoDJBGEvSpUl2DBvjRx+2cGSHPcve5laHxEFuRU4Z7ZEbBInV2uztk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1780688271; c=relaxed/simple;
	bh=FToYJIQ8RdH6JxhRfoWMRJcXrIJD1WNJJYbuN1kj20M=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=s6F4Ep7alDs6GDz/jJ+9NYv1c2hregjLUqMAaXmlibRBrHWK5b90zVqVP/M0sGi3J3YVrDGkJyIKeRFbdJbJbQ7asPj4cd/xYlZVnoNIgp+37dUWI9uCZBT3ieKUh5oaT1xwkg71nBId2rhFFvkFGFHdN/3kflGK9MeKH+ortbQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=FoogILND; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="FoogILND"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 9E8A01F00899;
	Fri,  5 Jun 2026 19:37:49 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1780688270;
	bh=Cn3wo5zAEi7V+MeTEPkCM0Q/ykaUHIqraUi8VT4q5gU=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References;
	b=FoogILNDfzfQQxMX4p+8D3Fxch5k2QnAFevGrktL02zH8Jw5K5+00iv40/4PkMueF
	 MVctQPn8onQ7fnkaEPA3Fk5Sh08MY2GGMxmyV/hGWqm0O8jfEAVg+eqPL+QOeGZdy0
	 OszK4gyiK75f+K9pvWcOcywKi/gZxpV4skYnoNwz4pEGTncqjAHiVSlKY1i2FeR6bQ
	 kANQ6ULoMlIlXIeiQSpRrfzZgDr1RbW0BFNMrlPTn+aYzJDKLu8ibOE8H5CAQHBluL
	 jpxBmHAIp5Qcqo+0sKs3NHOI+ImNfqykeCkINSqnhrelFPhczkIewWJUcEA29FT7O1
	 ooGwbtrVQc6rQ==
From: Sasha Levin <sashal@kernel.org>
To: stable@vger.kernel.org
Cc: Sasha Levin <sashal@kernel.org>,
	weichengc@nvidia.com
Subject: Re: [PATCH 5.10.y] xhci: tegra: Fix ghost USB device on dual-role port unplug
Date: Fri,  5 Jun 2026 15:37:24 -0400
Message-ID: <20260605-stable-reply-0017@kernel.org>
X-Mailer: git-send-email 2.53.0
In-Reply-To: <20260604121918.150487-1-weichengc@nvidia.com>
References: <2026060435-implicate-henna-b77d@gregkh> <20260604121918.150487-1-weichengc@nvidia.com>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

> [PATCH 5.10.y] xhci: tegra: Fix ghost USB device on dual-role port unplug

Queued for 5.10.y, thanks.

-- 
Thanks,
Sasha
