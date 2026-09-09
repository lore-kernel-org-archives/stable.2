Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CBA505581EE;
	Wed,  9 Sep 2026 12:35:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1788957312; cv=none; b=AwuvN7uGyPPCGphybyNbYrM3hll82MICnB1+sJmL8+dKrCLbcXnx0ZTAmXuuWyq8NN2Z7X0VLL02nm96iHjGBrrHGRKN+HUNMt/fmbHSmlaIQ2yiwmQQkoIFGTtq185Hpbg7JnfA1lOJ7uVFvqGd7Bwdp0vnkZ4hhZI9sD1DkkY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1788957312; c=relaxed/simple;
	bh=aLEhDg09bgTUasecHByCkze5LmoohSVDOa3QJ+q3fiU=;
	h=From:To:Cc:In-Reply-To:References:Subject:Message-Id:Date:
	 MIME-Version:Content-Type; b=W5qJ3vQS3WOXhD7SyFa7sGzL3rMVra7yIMg3B761CsbRtOUKF9HY8MxSs+4r0QwxvLuHeZTAM1BrPKCt+KGIgWSX0b3x/srnodi0ryQzW1dapWHoIoRflbHZyzH17a46TvSKpsOi2pkbDcy2f2/f8dsT1odlUusLre7Q7rprEsQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=j12fQjBq; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="j12fQjBq"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id CA2C41F00A3A;
	Wed,  9 Sep 2026 12:35:08 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1788957311;
	bh=mJoAyXLU+gq93Hg0D0pH4EKfCCnj6hvdcJzCIDVF9kc=;
	h=From:To:Cc:In-Reply-To:References:Subject:Date;
	b=j12fQjBqku/Nd3b8iH/+HSt0a+56YuXDQfBMTpAjO5rlDw+3jV/Slv5pzOJr+pNKu
	 weYAsllKWZjydyWNl7qYgN0wAmJ8WSq1pV7tUwcYgHjpmeAukLKM/Rje8nOA+uYS0t
	 wVpl9R444LJxHBw3YzD4jyr0BC6BEL9ps1+2gHkaq0x74KqRoQ09NLRw6QKQN2Pokz
	 cnP4xNYQhYR36ugNb5hTvXUOCT7oOK9vqxAR31P7L4EM3k96zyjOSm58G3VDPPJVqO
	 Ju26Fx/f84xdCIuZusElgm9vUlALU3ozk3Gkd435H7PpIgckVl/DbWSDWVaCVnw98h
	 jaTiAtyVnt6kA==
From: Vinod Koul <vkoul@kernel.org>
To: Frank Li <Frank.Li@kernel.org>, Logan Gunthorpe <logang@deltatee.com>, 
 Andrew Morton <akpm@linux-foundation.org>, Shivank Garg <shivankg@amd.com>
Cc: stable@vger.kernel.org, dmaengine@vger.kernel.org, 
 linux-kernel@vger.kernel.org, Frank Li <Frank.Li@nxp.com>, 
 Sashiko <sashiko-bot@kernel.org>
In-Reply-To: <20260822-dmaengine-kref-fix-v5-0-d4a4ee47d927@amd.com>
References: <20260822-dmaengine-kref-fix-v5-0-d4a4ee47d927@amd.com>
Subject: Re: [PATCH v5 0/4] dmaengine: fix kref underflow and UAF in
 dma_chan_put()
Message-Id: <178895730837.2164851.14814950154989384320.b4-ty@kernel.org>
Date: Wed, 09 Sep 2026 18:05:08 +0530
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
X-Mailer: b4 0.14.3


On Sat, 22 Aug 2026 19:22:02 +0000, Shivank Garg wrote:
> Fix bugs related to dma_chan_put(), found while testing with SDXI[1].
> 
> [1]: https://lore.kernel.org/dmaengine/20260605-sdxi-base-v3-0-4d38ca2bdffe@amd.com
> 
> 

Applied, thanks!

[1/4] dmaengine: add dma_device_get() helper
      commit: 424103642d009f5a7dc33300a49d5606d1bf4fb5
[2/4] dmaengine: Fix device kref underflow in dma_chan_put()
      commit: 44dab659064eb5c10adb0306510eebe848ed592d
[3/4] dmaengine: fix use-after-free in dma_chan_put() and dma_release_channel()
      commit: e873c74132f0c5f1452816cd9bb26208f0bba1e1
[4/4] dmaengine: wait for RCU readers before releasing dma_device
      commit: dc750422170a563c7a81f6e49d36bb02c62ae37f

Best regards,
-- 
~Vinod


