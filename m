Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 14AB25650ED;
	Wed,  9 Sep 2026 12:41:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1788957681; cv=none; b=ZMYq7ZqM4fy/Zn5aYanqlE92kULhSpZDUjkURCpGAos/FobgLj2f0/Z6s/6Z4VcozjONqLtZ9wGtXpC371N6Gra1X60N2zOpeDPwsha1mtDkVKZV5muxt5dSTx2u1Dbg/wWW2fnFFgU4ET3pY4sa2FSJW2v3tqlJGrZBOliRyIk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1788957681; c=relaxed/simple;
	bh=hx4eILKh5VrjHyoFlaiPhueOOTFVAoiXbsSw9YkfavI=;
	h=From:To:Cc:In-Reply-To:References:Subject:Message-Id:Date:
	 MIME-Version:Content-Type; b=qu3Bo2i0z+ZJqirI/hRnLcOpDxMdy4SCmU4PIjX1+xNxqKQoqu7rfHZy+qQFQGjytag7bUKilif4+EZAJr/lqpV32q9j6/1rT6CnSD2TtXoxv8mjOqx7szIaJ1VNx5k7JYyG99g+jFNTOli6CR9kGe6wiMtxil9NxyDHwzhLs5g=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=V/IuvnW3; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="V/IuvnW3"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id EB1591F00A3E;
	Wed,  9 Sep 2026 12:41:16 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1788957679;
	bh=1C2NCF/Uu4nouzWOcxL2yOqc09Ob2Y1y9fUg61NcF2M=;
	h=From:To:Cc:In-Reply-To:References:Subject:Date;
	b=V/IuvnW3AMl12JAtaJZAc1FBLJv/+k8zId5YzxOzJzY8qRCb7j61LT2fVCT4eWiMW
	 UKkNwZOCaIPJY1xxlS40v/N5XPVoU3Y5fWOMn57sQ7AKYBI4mujKMpD5u6YsMTS9ff
	 LbcUIQ48o/sg3Jsgtvo44cS2ohY8FOr7ViEMVN3EzbRpWjnnHdHh2bMkXorxAfRTwO
	 hc9K5mQg0m+ImgYXV/N3M+J6cJyxYGU13M2a+SHnf0L/H1CZbQpbaEqltMwt+pDwSi
	 U4nGE0KaFTOb9bw9FRQEWykaFqjG9n/k4wYe0sIvcvQMDcYwUUr+u96LqE3AWvotWL
	 7dl+XxwGvRhdg==
From: Vinod Koul <vkoul@kernel.org>
To: adrian.ho.yin.ng@altera.com, Runyu Xiao <runyu.xiao@seu.edu.cn>
Cc: sr@denx.de, Frank.Li@kernel.org, dmaengine@vger.kernel.org, 
 linux-kernel@vger.kernel.org, stable@vger.kernel.org, jianhao.xu@seu.edu.cn
In-Reply-To: <20260830053308.2190597-1-runyu.xiao@seu.edu.cn>
References: <20260830053308.2190597-1-runyu.xiao@seu.edu.cn>
Subject: Re: [PATCH] dmaengine: altera-msgdma: initialize state before
 requesting IRQ
Message-Id: <178895767650.2174329.17302227915572733785.b4-ty@kernel.org>
Date: Wed, 09 Sep 2026 18:11:16 +0530
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
X-Mailer: b4 0.14.3


On Sun, 30 Aug 2026 13:33:08 +0800, Runyu Xiao wrote:
> msgdma_probe() registers the IRQ before initializing the tasklet, lock,
> and descriptor lists used by the interrupt handler. A pending interrupt
> can access incomplete state during probe.
> 
> Initialize the handler state before requesting the IRQ so the interrupt
> path observes ready software state.
> 
> [...]

Applied, thanks!

[1/1] dmaengine: altera-msgdma: initialize state before requesting IRQ
      commit: 4cfa625b60d55b81bc6620113f213349bcc85a4e

Best regards,
-- 
~Vinod


