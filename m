Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1AE463644C1
	for <stable@vger.kernel.org>; Sat,  1 Aug 2026 01:40:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1785548415; cv=none; b=HbfpC95sk5YzfPMj/082vA5FGHEqKixiwyND/yxdHmozUsRKu0T2OTCqw1/QDQBZkHChgLPFMsyC+Sh22R8OZjhQs6LAOwtDALHeeVR07LXzkzpQ+zKglPU+X1vTSEpgiD3lXKSeH7SQyuRcj5x5Wp/MrunFXOBQepbDd6Iglak=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1785548415; c=relaxed/simple;
	bh=k7Gk1ZwVtnnMh/wfIvbDCf+ZR32UFFXhpcjVEY4MEf4=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=E8n0bMsAU+wmqFOkdAAKnYrf1OcP7GLVOLa9/iulyBUrq7i65bpH9HsMN+PphL9/I1E9HwxXP3mVhNI7P8GZVPsqmTePy3Q4emiYduuahH528fRWmqyriDau/usNTYS32nvF8A4o+fTP01A/qfsvCPA3p1ObX7LsCEt53OEm5OY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=fp70GDSA; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="fp70GDSA"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 51A761F00ACA;
	Sat,  1 Aug 2026 01:40:13 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1785548414;
	bh=vfkjKLw8JdHQSOqWcvZneJvPqZEp5FDuiAiR5nsV44Y=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References;
	b=fp70GDSAIb+aBzo1ZzHumrNVIuDo0PQ3Q0BzsKwmkt2jPbe2IFqBQhbkYel5sD4aj
	 UJ8Gp6yxgKZoUsJizLPuvvYWLBb9Z23LGYUiW1XHy061vKXmW3Ssxy5Fi74JclM6LG
	 e/kjMRCdrqDYEWmOK1vDI1YagxczL9GJhvtB4SHPem63dDIf3cvYYN9DsQqQseo9b4
	 dNVfrCHwKGzHlQFVUyrCzIVWExRC1+LhUNIRtWryHStDIS2Jsx6rzaZTV/ciHpI11e
	 ceBkwAsGrhAjPQQ5eKGvvO3PkSl+lKerTDVXmfutSIZpH4NZ81IoCGel26ki0z4ONv
	 6LKPi+ryRcKfQ==
From: Sasha Levin <sashal@kernel.org>
To: Greg KH <greg@kroah.com>
Cc: Sasha Levin <sashal@kernel.org>,
	stable@vger.kernel.org,
	"Wayen.Yan" <win847@gmail.com>,
	Lorenzo Bianconi <lorenzo@kernel.org>,
	Jakub Kicinski <kuba@kernel.org>
Subject: Re: [PATCH 6.12.y] net: airoha: Fix register index for Tx-fwd counter configuration
Date: Fri, 31 Jul 2026 21:40:03 -0400
Message-ID: <20260731211001.stable-0002@kernel.org>
X-Mailer: git-send-email 2.53.0
In-Reply-To: <2026073041-radiation-atonable-b8d2@gregkh>
References: <2026072102-stack-mardi-5c7c@gregkh> <20260729203537.447604-1-sashal@kernel.org> <2026073041-radiation-atonable-b8d2@gregkh>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

On Thu, Jul 30, 2026 at 02:46:49PM +0200, Greg KH wrote:
> >  drivers/net/ethernet/mediatek/airoha_eth.c | 2 +-
>
> This file isn't in 6.12.y :(

You're right, and that patch was written against the released tree. The 6.12
queue already carries fb3dda82fd38 ("net: airoha: Move airoha_eth driver in a
dedicated folder"), which came along as a dependency of 86e51aa24686 ("net:
airoha: Fix skb->priority underflow in
airoha_dev_select_queue()"), so the driver lives in
drivers/net/ethernet/airoha/ there and the plain upstream cherry-pick of
1402ecccf563 ("net: airoha: Fix register index for Tx-fwd counter
configuration") applies without any adaptation.

Queued for 6.12 that way...

-- 
Thanks,
Sasha
