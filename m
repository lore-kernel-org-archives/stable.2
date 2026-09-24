Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 94BAB3D7D9B;
	Thu, 24 Sep 2026 02:42:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1790217722; cv=none; b=rTdc0CdRkof+2yUdIHWfZM/37w2IPRh54r8wzstwKn/g5ypa0y5wNFzDHyYNeUWuKN2Rkfn/Y452574p34sbERr/ISNM4p2gAwd/ujYW9r80+POrJ8MlV2GFuTtCLNhubab+JfD5mWyL7DaBSMDKZTW4j3jVV0lohRDwAucodOs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1790217722; c=relaxed/simple;
	bh=MxVMRMxOMcIm236WmJlc8v18apHkXOZ/p3Vh3lbzCTk=;
	h=Date:From:To:Cc:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=heGP3xqlWP3uhYGfEnMgUOLiUWxXgHVhNqI+8CJenVve7WHdYZXqxnNNttREnAZcl3nMQ+TKVWRfsLBRcJQ9hpm4QsJNHse79+TNYNSxnjUYXgPoyUFbbsLH45BoeiVXuJ+oTlojUO5KXlskXNGfGiPjJ2o5E1+MwAtcG9yIZAI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=WveTC055; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="WveTC055"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id A997F1F000FF;
	Thu, 24 Sep 2026 02:42:00 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1790217721;
	bh=P7XbvKMmH4XnJA95W4aG0uSGr8///oHvo/2Qv5ZMyiU=;
	h=Date:From:To:Cc:Subject:In-Reply-To:References;
	b=WveTC055i44OVEekAgscWWLflsQOelAgdxtNP/NTaT32BdM+0OstwmnjCzdYK1E7G
	 XrNGV8/fKf2Q6FcAIJLf1rnMOOOWDF/r96RKmAluv4DtyBEXIgpGCmN2u6oU+aRxUR
	 Yq+QJl1q46SCavln5tnf3wqKmucY9y+WGV/J9UwpZoCMU6eF3fiQ38EfefCOfc++mw
	 SLkigPAhD+tPr9U4l9NyeVBTU8wXIeqtRsY1yrSOogEGuG680yYG+GkCXQ0LXqLPHY
	 QY9iujeeRWYFdp8mCpoU2xPY50FyCOeRicKWTViphqts560LMCQNSIzyZPmE6R7iDs
	 3lLmd8vtZ5Q+Q==
Date: Wed, 23 Sep 2026 19:41:59 -0700
From: Jakub Kicinski <kuba@kernel.org>
To: netdev-bot+sashiko@kernel.org
Cc: yangshiji66@outlook.com, netdev@vger.kernel.org, nbd@nbd.name,
 lorenzo@kernel.org, andrew+netdev@lunn.ch, davem@davemloft.net,
 edumazet@google.com, pabeni@redhat.com, matthias.bgg@gmail.com,
 angelogioacchino.delregno@collabora.com, linux-kernel@vger.kernel.org,
 linux-arm-kernel@lists.infradead.org, linux-mediatek@lists.infradead.org,
 stable@vger.kernel.org
Subject: Re: [net PATCH] net: ethernet: mediatek: only enable WED for ARM64
 architecture
Message-ID: <20260923194159.264ca04b@kernel.org>
In-Reply-To: <179009659284.2160803.2402786454793152027@kernel.org>
References: <179009659284.2160803.2402786454793152027@kernel.org>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit

On Tue, 22 Sep 2026 17:03:12 +0000 netdev-bot+sashiko@kernel.org wrote:
> Is the Fixes: tag appropriate here?  The changelog does not describe a
> defect, only a hardware-scope observation and a prediction:
> 
>     Currently, only MT7622 and MT798x SoCs support WED features. They
>     are all ARM64 platforms. And it is unlikely that MediaTek will
>     release a new net chip based on ARM32 architecture in the future.
> 
> As far as I can tell nothing misbehaves on 32-bit today.

Not just the fixes tag, the whole commit seems rather pointless.
-- 
pw-bot: reject
