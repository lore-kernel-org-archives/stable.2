Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0C73E47CC9C
	for <stable@vger.kernel.org>; Mon,  5 Oct 2026 13:51:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1791208279; cv=none; b=RXB9R1oX5BGub1dQDXKHco3n8G+zGJkCzi1ek/ov/CYT+qW3hHnFiCNscJ3acZpQhPAhpxze+DuqNIKg2bYDRaQTZh4y1FQV5qm1Ed45lPKyX18UfdI6Tz0nrG6eG0TEOLg/4fz5ptne7vHzG+1hOe1sow71wvD7jpNrrXWE8Aw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1791208279; c=relaxed/simple;
	bh=K5leOWo4jasek3NknP8ggT2WbkfHn/mXqxn7/M7/VAc=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=LbxN/dihSA76PTHTnFhqjcpznFwfi3T7zSJw3ioC+45NxAp6JLcHj9xTJ12nCcfOvgOGfmK78RqrGQHNNzRKU4CPnI1WneO/XkAp/L6CVIayzrO69xlqlVv+EIhc7wRDcOCQBAtH0+vwevk3myKgpPrDDOWgBCmOnMk/K9tbY8c=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=OTsPQ2S0; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="OTsPQ2S0"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 231371F000FF;
	Mon,  5 Oct 2026 13:51:15 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1791208277;
	bh=eDtme7ON0n6A6P7+Ljo0/HDfrTLvhePwdpi64e1D70k=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References;
	b=OTsPQ2S0pqKVlhMT0FtC1DgP94BpzKIVolVBByILKJ0Sy4Q5+YZIQDZDYY9dnqYkq
	 lLpMQYtTaZ1ZfjpLtr3iCXXUEqavWg4Zk3KmdHKiYNG6VZgvcBXzNa5029Q9X0P6Kl
	 pIzKWOm9wwQvi9F8R0COJlvhbpBUGUHuCcIRwEqk2D3dnyytxrFIqDXCDzJ/7eoa/H
	 TRM6BBeXHKDt9if+QoWePRuCLdt/Z30jt4IlHs4/2NKwnMN3aVUFlrrbyI1l1njTSg
	 zCMWM1jtx48CKUtmboafuAQcb0E7VFg9y4qiXL9kHbwe1qnLzcAL3JgQlhsQ8jlbet
	 BYHFEvDYvPzSA==
From: Sasha Levin <sashal@kernel.org>
To: stable@vger.kernel.org
Cc: Sasha Levin <sashal@kernel.org>,
	John Pavlick <jspavlick@posteo.net>,
	"Russell King (Oracle)" <rmk+kernel@armlinux.org.uk>,
	Marcin Nita <marcin.nita@leolabs.pl>,
	Jakub Kicinski <kuba@kernel.org>,
	Josef Schlehofer <pepe.schlehofer@gmail.com>
Subject: Re: [PATCH 6.6.y] net: sfp: add quirks for Hisense and HSGQ GPON ONT SFP modules
Date: Mon,  5 Oct 2026 09:50:24 -0400
Message-ID: <2026-10-05-1-daily-reply-0003-sfp-quirks-hisense-6.6@kernel.org>
X-Mailer: git-send-email 2.53.0
In-Reply-To: <20261004144528.54801-1-pepe.schlehofer@gmail.com>
References: <20261004144528.54801-1-pepe.schlehofer@gmail.com>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

> Add quirks for:
> - Hisense-Leox LXT-010S-H
> - Hisense ZNID-GPON-2311NA
> - HSGQ HSGQ-XPON-Stick

Queued for 6.6, thanks.

-- 
Thanks,
Sasha
