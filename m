Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1B40E3749EB
	for <stable@vger.kernel.org>; Tue,  4 Aug 2026 01:05:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1785805554; cv=none; b=ro2ykypAp/CfUOSmflURvtFbsDWa/TdW4cVowSZWhiY2cZuEwf83XWDHj94CocZTGW7RAbc4DAAL2Z8qvTYXijH5vAeOj0aj5JeG9/5uOIbVXanm2jaSSbyc97ljBKlPD4JCJz7pDJGyqJvpU2t/OAPaWtLR/Q7eCDajrcAUNsk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1785805554; c=relaxed/simple;
	bh=xpcrTrXvL3w4GtO5g7iQ9Vt0FSR87caBLqqAmeTZNhs=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=AZYqCF1aiaZkBTMoc3FGDblIw4R2jMIeDEav5XfwrYnOzwPEygaPBAhRZjVB+5rIxsCAlNGyVQvXfX8GzwN5o5CfBR/9VLasI3WZsr78lbZIZZlg2Po6p91ISiJ+NoqMPcBRJHLoYsk4ZyqJk9kLB3mluPeKrl4VlOfLJYYSc3Y=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=cwDTZDOs; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="cwDTZDOs"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id CB53B1F00A3D;
	Tue,  4 Aug 2026 01:05:51 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1785805552;
	bh=8MaVAXtQRc0Xp1HLpVf714lXOa6hw8Hmq1bDQrXCUmg=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References;
	b=cwDTZDOs8XRcWnRCE732BDQJLRkTtVESfpW+gY/W8aYsoxft0w6rxf5xnUxk+wmlL
	 jVitcJbNgE4X8Ppc98lqL81QCde0qgMIapMk5wuIgTPKScC/UzVG9GaPLYoQ5+YMIr
	 THe3WnWadHZZP+AJ8p5OFlqDp3OflcqdWNTsqnOQUcGWns7l/h4NNuJGdSxjnRjXVs
	 T3zpSrGPubgI9Yj3bZxc1ph99X6wuQXwWuEVU5wnV7SmyPZ3HzlayooHwEY3iv7ib2
	 9/Eg4/rul412Chjwi9ziGEwcL7fo5khnYNBtV1O36XYBL5BAmOltcskXXycD9kho2/
	 /bi9UDpyvkn/Q==
From: Sasha Levin <sashal@kernel.org>
To: stable@vger.kernel.org
Cc: Sasha Levin <sashal@kernel.org>,
	wen.gang.wang@oracle.com,
	borisp@nvidia.com,
	john.fastabend@gmail.com,
	daniel@iogearbox.net,
	kuba@kernel.org,
	davem@davemloft.net
Subject: Re: [PATCH 5.15.y] tls: separate no-async decryption request handling from async
Date: Mon,  3 Aug 2026 21:05:45 -0400
Message-ID: <20260803210502.stable-0003@kernel.org>
X-Mailer: git-send-email 2.53.0
In-Reply-To: <20260803193216.98111-1-wen.gang.wang@oracle.com>
References: <20260803193216.98111-1-wen.gang.wang@oracle.com>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

On Mon, Aug 03, 2026 at 12:32:16PM -0700, Wengang Wang wrote:
>Subject: [PATCH 5.15.y] tls: separate no-async decryption request handling from async

Queued for 5.15, thanks.

-- 
Thanks,
Sasha
