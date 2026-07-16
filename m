Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1275D2F0661;
	Thu, 16 Jul 2026 15:08:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1784214505; cv=none; b=WUN4h+YuA0LKCt9IYQlYiHAXZ4h1GomvAS27EndxF/g4sXF+I09XmproCc5ULUjvjNjfY3C9veHPzVPE80bhRcM1hlRLvToDzQwW6DzSbH/xjLIKR5VpUzCxuH5M1dbmkDRwz9IZvFEq32Lzl+Qe0dIqZw32ElS3KBnbNDBZELE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1784214505; c=relaxed/simple;
	bh=UnmCeSpWTrFB9pMjeVcp3Vi1onWsJIOCLmfLttlyAI4=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=Hg6pokX1ZN6jKx19Vq1TWVAcEqF/8VpP0CcANqa//XEUrdtjlB5vY7ujOBQ1nVulhkYN/Y/5SfYYfxWQ7W7NeC34F+Vn5ltx6RFBnD7C1w7Yr02ZkVJDXLq3R65fpTF6LzmJIuQJXVlU7A783YZQAqslBNEr4XE7Y0bJtLNF0JI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=nKPJanKM; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="nKPJanKM"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id BD5E91F000E9;
	Thu, 16 Jul 2026 15:08:22 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1784214503;
	bh=UnmCeSpWTrFB9pMjeVcp3Vi1onWsJIOCLmfLttlyAI4=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To;
	b=nKPJanKMqWlfr4Cg01Ru1RCmWoIdOp8s5ec6GY0eoZgKmCazCWol3bnuJ3d1KwbVV
	 vjerMy0an6udXS8z0ua8sajBj88MDWXVnLpl1+qED2Iijun9/XAnJ+4G8H1ixmHrZB
	 GlKTsdCDrKL85asz+wIncnZYusoa8NGwUJsvtvLfWuqTKdUXdfPhuHIeP9X7+MqXQa
	 joqCu1WTLzrJGozlJT/yoaZWBu7Mfq8Vl0sY81buI4RNGlQxzERG9cB0aRPK6liUgO
	 LiX0D4AaRfJLnuijjHbEFD+tvBNJMaDg1ybj20uYDr9s5SqBUXR2XqAW6G3Th0TIcg
	 qUp3qxgPE9q3w==
Date: Thu, 16 Jul 2026 17:08:20 +0200
From: Andi Shyti <andi.shyti@kernel.org>
To: "H. Nikolaus Schaller" <hns@goldelico.com>
Cc: linux-kernel@vger.kernel.org, stable@vger.kernel.org, 
	linux-mips@vger.kernel.org, Paul Cercueil <paul@crapouillou.net>, linux-i2c@vger.kernel.org, 
	Discussions about the Letux Kernel <letux-kernel@openphoenux.org>
Subject: Re: [Letux-kernel] [PATCH] i2c: jz4780: Cache clock rate at probe to
 prevent CCF prepare_lock deadlock
Message-ID: <aljysQFgUHuVDAgK@zenone.zhora.eu>
References: <c69ca6511780aa4759a428cb7fb70de43ee5211b.1783666715.git.hns@goldelico.com>
 <alf7rSWaLBO8WBkR@zenone.zhora.eu>
 <36148F30-156F-4E74-8765-D718F6FE7E76@goldelico.com>
 <aliLbNJ51Ns0dIHX@zenone.zhora.eu>
 <9421BB47-EFC8-4D82-989F-82A84FE46749@goldelico.com>
 <aljCGkhZEQHzZVSW@zenone.zhora.eu>
 <500EE2C0-B916-47DF-874F-EBB2CF1C779D@goldelico.com>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <500EE2C0-B916-47DF-874F-EBB2CF1C779D@goldelico.com>

Nikolaus,

> Therefore I consider this as a fundamental design flaw which is solved
> by this patch.

I'm not arguing the patch here. I haven't even mentioned a single
line from the code. I made a simple question and you keep
hammering on the same argument: in the commit message you say
that when the clock changes it generates a deadlock through
i2c_xfer. I simply asked if the clock changes how is the new
clock value taken by the i2c?

If the commit message is leaving room for questions then you need
to make your commit message clearer.

Andi
