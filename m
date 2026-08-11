Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 84EA13DA5C1
	for <stable@vger.kernel.org>; Tue, 11 Aug 2026 18:56:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1786474564; cv=none; b=c7f4IycMo3Xrhb723U0h7V2RIA7CoeuRUnqscg1Cj7scKbTe4z5i9ALrwNGeRB7qBJvSY3Xe1LfjI1LfNDaUpZjhxxCFUzW9nLJy0DxNhRbus3Uoa05sQWELrJoJf5fTTmPAYslYPt22esue/juBofVzK+TqD7mIY7WoozXDCHU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1786474564; c=relaxed/simple;
	bh=uIP7VnUtobs10mEtSjNcNF5mTpKBej78tMLgcqBfI1E=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=B/AJimO3LzNJGPk8RS7aysTgOX499q3DfqbNd6bXeniEPA/BXf1cnIT+A36xB2NBam0FAAtPfhVXLwL0854wysKSm6G4R9b6oKiRuAmRcu0tEQkWGHtGnAyv+GzILHmCHxezVMnEV9xSw2yimw0igfsmO9sQKGokkN3JLRwbYKo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=QBsoYndo; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="QBsoYndo"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 82E441F00A3E;
	Tue, 11 Aug 2026 18:56:02 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1786474563;
	bh=8Rc3+pfMzAn3EDmEx9jxx9DGi83qVzp8FDQMgHuBq+I=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References;
	b=QBsoYndoc34luIoSWzZ0SCPWugeX8v5vL9gfdAAw8s0nzhfVPrPEg1QP0Cl8u0Ssi
	 +7OD6/BRvmHniUu1opavxYJJ02/G6tw4byMGdIilg9YT7HKtqgPllcydh7I7rstwM8
	 ohppnKGBaQlosBlqSAk8ZYRH6MPTL1pQ6Mju9OMf8g/ZxDKHWHacFQx63t+l71NWjV
	 2os9vtK+juGXe/DtLAyFvrfLYmVFYGJdYFOVFi3V4THCYFXdlVobPqJvDhZDmab2I/
	 qbIlcv6kxnhAOn2RA9Z3yYieWFVcPInfgQTswY2PnZszGXPRF8SjcLJI+ifghLgrbW
	 Wv5XVgvvzp1Cw==
From: Sasha Levin <sashal@kernel.org>
To: stable@vger.kernel.org
Cc: Sasha Levin <sashal@kernel.org>,
	Harald Freudenberger <freude@linux.ibm.com>,
	Holger Dengler <dengler@linux.ibm.com>,
	Vasily Gorbik <gor@linux.ibm.com>
Subject: Re: [PATCH 6.1.y] s390/zcrypt: Fix missing mem scrub at clear key import in cca_clr2cipherkey()
Date: Tue, 11 Aug 2026 14:55:48 -0400
Message-ID: <20260811184500.stable-0003-sashal@kernel.org>
X-Mailer: git-send-email 2.53.0
In-Reply-To: <20260810140030.485804-1-dengler@linux.ibm.com>
References: <20260810140030.485804-1-dengler@linux.ibm.com>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

> Extend the _ip_cprb_helper() function with another parameter 'scrub'
> used to steer scrubbing of this buffer. So now the caller has the
> opportunity to decide if scrubbing is needed or not.

Queued for 6.1, thanks.

-- 
Thanks,
Sasha
