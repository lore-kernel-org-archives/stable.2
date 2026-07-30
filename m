Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 953CA37AA70
	for <stable@vger.kernel.org>; Thu, 30 Jul 2026 02:40:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1785379256; cv=none; b=uxQ7w5wDlEUBLhERGLXbvU15w0/DZ7Sa/DsNjFPBqopcgnbA+qPC1puN4Uu7DudElZG02/Beyqk9+vGedCf9CLjuUoVnqlSumhmv1tRL4MhSgcxMEL3zX0dodPxrmUvb86NUx9ClepZd42/TizioVaRTO8qoracJ3BS84VAYKC8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1785379256; c=relaxed/simple;
	bh=cbhuWOhOxAKoffXqy5Q6fHGBM/u1meWrnP5zhqv7q64=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=a1FJ1s+KWUYXT/6t2qPVbU8rdSF1Ovh14f1Kw38pxeGePpJnyOXwH3IRZ3CnkNqfXZIm/yUIWEB+3V+p7W3/ALR0cmZovE7FbhqOFikhTFtjnLt4YdShVDX1q0JJsSBzaPDg1HXoz2IU0UoNvbDRyF8o6wkCybkGy/oMHeGbnSg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=VUyy7C4E; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="VUyy7C4E"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id CC6591F00ACA;
	Thu, 30 Jul 2026 02:40:54 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1785379255;
	bh=/sqnbWuzWVPV3A4SihYrzeIPVzmCLrjAk2sEMRtPh3w=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References;
	b=VUyy7C4EofS9Vfqv0QELqREtjGeQdRBBBgYOGeXODkXfZJ+/IU+UT0bWXUBODzjGR
	 TwUrfFDn7RMYfnI8q3CcBmtEmCMWrOSfr2aeJUj46c4w3SNBiH6yPI/SSaXeU/+B8e
	 ThZMUhguKZpCwH+skUhY/dpfOXgl3oLGXeeG619Dgq0fKTHRY60aKbx3ObNPs/AZqV
	 S93ankyx50n9ANAEVVa5iapvoCwDtYIxwuTC7myMtGSn/eP0DxOjVkF1pNrUDt0MCw
	 JATFBjdExfg4g4cfGRIqRwjd6pAw8bjoU0V14yvSqCjv0jGc2/6LExEswAlW0CvdqC
	 k3uX9QPgViRJA==
From: Sasha Levin <sashal@kernel.org>
To: stable@vger.kernel.org
Cc: Sasha Levin <sashal@kernel.org>,
	Coia Prant <coiaprant@gmail.com>,
	Jiawen Wu <jiawenwu@trustnetic.com>,
	Maxime Chevallier <maxime.chevallier@bootlin.com>,
	Jakub Kicinski <kuba@kernel.org>
Subject: Re: [PATCH 6.12.y] net: pcs: xpcs: fix SGMII state reading
Date: Wed, 29 Jul 2026 22:40:21 -0400
Message-ID: <20260729223316.stable-0028@kernel.org>
X-Mailer: git-send-email 2.53.0
In-Reply-To: <20260729191425.3176146-2-coiaprant@gmail.com>
References: <20260729191425.3176146-2-coiaprant@gmail.com>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

> [PATCH 6.12.y] net: pcs: xpcs: fix SGMII state reading

Queued for 6.12 and 6.6, thanks.

-- 
Thanks,
Sasha
