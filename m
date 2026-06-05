Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E3A104071CD
	for <stable@vger.kernel.org>; Fri,  5 Jun 2026 19:37:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1780688271; cv=none; b=qcMTV4Zc2UV9F98t3bF7jYVIMC8G0n5bAtdFPBv3zyuMO2SbIVo5D61zajhrSdGhSZBYNXXWW6EL42k3eDlB2KG1lgMC9wIzaG2BqLKo2Eat5fPx5w7p3jKgljHIKNGAozhgDtVNJtQyqxfmjYviMuj8k+HJxph/XaVrKADnho4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1780688271; c=relaxed/simple;
	bh=iVW+Mbr5MeW/bez5cAkVHCUcvFiTQncJ68/BRBKCGY0=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=CCpY9M4rggh6SbIzknFRDMmcOtXkNRoMCKHpXrFxVPPZAbzD3DgCyJtfDg0C9vrtULyW3pmrLvtWHsJuaABtwdbcjzB09aups67syrzhpGn5OKcba+A5bDFfuTq2DpdYnQbMcsJGMRSIJP7n67qUOIF+m7JHZr+dn364lvBRfO4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=VB4SOiI8; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="VB4SOiI8"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 533191F0089A;
	Fri,  5 Jun 2026 19:37:50 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1780688270;
	bh=WplpVW73VeZ5SuFEh+ve8+G80Q5TzLBYK+gkAu1bxGI=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References;
	b=VB4SOiI8bI9bVOnG8JCrJNSzVtTDN2H9hI3/RM1sGbtZhVGFChalsr/IlrO0YAHJU
	 xHOwdReT/EfFlFl0bwoztq2OgyLekPHNHuMD7YMg0oYnRT8XaCXBsqm6EnUoCxLZ7D
	 Iz9y8cHESs26bi2Dnu63hmYXO4SiWso5Ymqvy8HKJ6CNHlAAp+JdFwZHbx0kbO7/zE
	 WlFDZDVI9Sm4GxVFEXD65J9AVEbwQZPMzNnr+udfv2yj/dfbuSdujnPqyVNXrk08vp
	 txpgqZGvuLtvnwwa+ucg/+Fw6AH3tar0QT++gmNppUow6N9TNg1aPz18oWMRMKfyNF
	 aO0V8RCDf9+zQ==
From: Sasha Levin <sashal@kernel.org>
To: stable@vger.kernel.org
Cc: Sasha Levin <sashal@kernel.org>,
	Johan Hovold <johan@kernel.org>,
	Greg Kroah-Hartman <gregkh@linuxfoundation.org>
Subject: Re: [PATCH 6.18.y] USB: serial: digi_acceleport: fix memory corruption with small endpoints
Date: Fri,  5 Jun 2026 15:37:25 -0400
Message-ID: <20260605-stable-reply-0018@kernel.org>
X-Mailer: git-send-email 2.53.0
In-Reply-To: <20260604120758.2769085-1-johan@kernel.org>
References: <2026060427-gossip-stony-dea7@gregkh> <20260604120758.2769085-1-johan@kernel.org>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

> [PATCH 6.18.y] USB: serial: digi_acceleport: fix memory corruption with small endpoints

Queued for 6.18.y, 6.12.y, 6.6.y, 6.1.y, 5.15.y and 5.10.y, thanks.

-- 
Thanks,
Sasha
