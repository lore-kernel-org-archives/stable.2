Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 431AC3B1034;
	Tue, 21 Jul 2026 20:32:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1784665939; cv=none; b=eBJ/5XAs6UwUckCNuvjQdCBfgI90fPCqaWyNRzoqpuc75lBrOdyIt5d6L+7LA6BhIgEM7EH/hzMAZASfONC5A/3lho4JZH54iC760nuB84VoMuAzCXGzNpT8lGvxqss6kC02n1OPF7OM8eagH++Zf0YW2juAFPL8LHFTjK6I88Q=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1784665939; c=relaxed/simple;
	bh=DykyDuyFEhbCHnz5TNzBUt+AgXAt91BGfLPp8Ip5eKA=;
	h=Date:From:To:Cc:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=GShBUwop5asl0E0rbNm/qZLgwVOa1x3crfQ3c7363YnydgQYRjAoaKNWRrxn4bX3zQJeDAD0NCl1PSqc13d/tE7Vya0YjxeLX0kZvU8gzEi07y31++qAxr/cu6/14HTPQiEnodPd/80KlOtYhdprwWA2z4lwAWicmxaLu5zaIUM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=NM8vrpcs; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="NM8vrpcs"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id C08391F00A3A;
	Tue, 21 Jul 2026 20:32:17 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1784665938;
	bh=fXcBVne5ohici36n5TWRcWXwxZvSHVl+8Sm6paAv9D8=;
	h=Date:From:To:Cc:Subject:In-Reply-To:References;
	b=NM8vrpcsTfZq6e4fmZZgoDqORndUHB7Cg0MAkTZ8hcpYPDlLwtVclyK3IEqB31ZRw
	 QPoipikTZcTg85DZG9f2CMIUSZWlSrKRtcIBLwl1CBmQs9wFVF0eSTvktCFMAg+0e8
	 Uo9MwQCQ/IZzjBLFMbVLm5IQrVfTFZUzUH7AbuZlodfhEJ9iQmEu/PiKy1yDeMaL92
	 Tfv1LEUNBZmLTXYdC7FXP0RyUH5Gp0SasWZ6B/zwxMV2iMfD9Dl0R6A7VS7kubuVVE
	 TsldK3p1hsu30A1nn+nR13fK652AVfuGFIArvAomw+H3ogobP9JzvU3lFcDESMyABW
	 Wm9FZYQ60sMEA==
Date: Tue, 21 Jul 2026 13:32:16 -0700
From: Jakub Kicinski <kuba@kernel.org>
To: Doruk Tan Ozturk <doruk@0sec.ai>
Cc: Chandrashekar Devegowda <chandrashekar.devegowda@intel.com>, Ricardo
 Martinez <ricardo.martinez@linux.intel.com>, Liu Haijun
 <haijun.liu@mediatek.com>, Loic Poulain <loic.poulain@oss.qualcomm.com>,
 Sergey Ryazanov <ryazanov.s.a@gmail.com>, Johannes Berg
 <johannes@sipsolutions.net>, netdev@vger.kernel.org,
 linux-kernel@vger.kernel.org, stable@vger.kernel.org
Subject: Re: [PATCH] net: wwan: t7xx: validate control-message data_length
 against the skb
Message-ID: <20260721133216.459fc2c9@kernel.org>
In-Reply-To: <20260711071338.58345-1-doruk@0sec.ai>
References: <20260711071338.58345-1-doruk@0sec.ai>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit

On Sat, 11 Jul 2026 09:13:38 +0200 Doruk Tan Ozturk wrote:
> Fixes: da45d2566a1d ("net: wwan: t7xx: Add control port")
> Cc: stable@vger.kernel.org
> Assisted-by: 0sec:claude-opus-4-8

AFAIU the general guidance is that it's okay to assume that PCIe
devices respond with sane data. And AFAIU^2 this is a PCI device.
-- 
pw-bot: reject
