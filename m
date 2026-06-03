Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9C3173D3324
	for <stable@vger.kernel.org>; Wed,  3 Jun 2026 15:14:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1780499677; cv=none; b=iony6rW1Xgdqa2qLV85goePhV3MgrhIgRMVRcGR+1627S8nM+a9JuSKT10rSWzgRwR1joc+f8DBDvs6E/je8ko1Km09FOg914PcuVPQ6dmRKgkG9TxBnoYUlhJhFPgDO2/BBV0bDBZOIcHIeMKSNEjvD0UE4QD/uffP5YOTpw20=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1780499677; c=relaxed/simple;
	bh=sSg1Bp2Q7gxa9Rm/Bu/ydi2z7TgHKY4GL1qs4g3TuNI=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=k2GU9U7XK8AQWWxgrk43A2SBi/Cf1wkUf/xLI4GwzkFh+TwQ2Z9+HRiQt+c8MElQyBzd0WqTQ8fMTXnsmYBjeKuU9U7pAJN63fnXA2g59jer3nkBPZQ1PPYPlnOEWYP4293sz2zgEDdiY6A4ZS48bop96AYYzuyAOM8hGmWcQbo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=CyV2MDWS; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="CyV2MDWS"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 835201F00899;
	Wed,  3 Jun 2026 15:14:35 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1780499676;
	bh=pX7WEF6IeTgp1VCOrtgpExlDWue20UoEpxE6XPci39M=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References;
	b=CyV2MDWSCTG8RkuNHzfmhLLIdF4Avr+kIrAi4N0ukTCDptgN3S8pRi6dIQ3g8ibnS
	 72ZMqTXhS/MqfmBOzyyYeZ4df43fu8MtE013TDOWiAS56WlupCcDrrushLx1ItP/FG
	 beZzFh61eZpE49SYumsIF0xZ3wRtgPowzl6ylvP+UJCWojajrYgEmA1A/PpsTjRd98
	 qArFY6Rlk5gJAifrLRyUE31Nx1OEAqH/B2cyKJayvQQ+NF9njRyQsdv35S0lGoERUZ
	 Nfi6d7UKyefGAOCcAn5nIT1jNT4AFsy6+eiB/JK3urIwY3fFg/QFasjZWqNm1xIeIl
	 HMp1/Vq4bte0Q==
From: Sasha Levin <sashal@kernel.org>
To: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
Cc: Sasha Levin <sashal@kernel.org>,
	Jiasheng Jiang <jiashengjiangcool@gmail.com>,
	Zhu Yanjun <yanjun.Zhu@linux.dev>,
	Leon Romanovsky <leon@kernel.org>,
	stable@vger.kernel.org,
	Ben Hutchings <benh@debian.org>
Subject: Re: [PATCH 5.10 1/2] Revert "RDMA/rxe: Fix double free in rxe_srq_from_init"
Date: Wed,  3 Jun 2026 11:14:01 -0400
Message-ID: <20260603111500.item005@kernel.org>
X-Mailer: git-send-email 2.53.0
In-Reply-To: <ahghwxSf9me8PHM4@decadent.org.uk>
References: <ahghwxSf9me8PHM4@decadent.org.uk>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Queued for 6.1.y, 5.15.y, and 5.10.y, thanks.

-- 
Thanks,
Sasha
