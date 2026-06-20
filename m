Received: from mx.nabladev.com (mx.nabladev.com [178.251.229.89])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 098D71C84D0
	for <stable@vger.kernel.org>; Sat, 20 Jun 2026 15:25:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=178.251.229.89
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1781969116; cv=none; b=SE6AKZNaZH0gVlIN/zbFu0cFTQjswb0CS1ifF6EBwOR1CxkhzaaN7RdxdIDpnXwgfc8VJ/Y41y4omrByBGb11KB7tyydZ6LnTCUWmzeW8oAEqjE9o3Jcw1tbxWxWgckJBo80CQqsTKvnGULHgwgRStHb4T7fKvb9ztpOrrJUS1E=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1781969116; c=relaxed/simple;
	bh=UpjqJmW84xyAES4CQ03mgWNXY9R2Za2asMrW969qUlw=;
	h=Message-ID:Date:MIME-Version:Subject:To:References:From:
	 In-Reply-To:Content-Type; b=kQCKthQCtnwlZaFlXdRGYUuJ2dPjjvbIFwIG+LZxttVp++eIF1NYytDf6iVeb+LI/6I9E1stMH+su7bABZ1+FzBTIPpmKxAM+ZNwEAqmzje+l5jFWQIxDeUVUi7hm+ewntzLRrfyw/6HnDOlMCflj2o0EdpkXfteJVrf90KuUww=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nabladev.com; spf=pass smtp.mailfrom=nabladev.com; dkim=pass (2048-bit key) header.d=nabladev.com header.i=@nabladev.com header.b=bTU8a32b; arc=none smtp.client-ip=178.251.229.89
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nabladev.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=nabladev.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=nabladev.com header.i=@nabladev.com header.b="bTU8a32b"
Received: from [127.0.0.1] (localhost [127.0.0.1]) by localhost (Mailerdaemon) with ESMTPSA id D665911599F;
	Sat, 20 Jun 2026 17:25:06 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nabladev.com;
	s=dkim; t=1781969107; h=from:subject:date:message-id:to:mime-version:content-type:
	 content-transfer-encoding:content-language:in-reply-to:references;
	bh=Mw9jcn999gJOxmRDng+/YDzs9QjoxCYwt/PZqRyCCnw=;
	b=bTU8a32bW1v3b/FnE6OjOYt8k8BbsslCxyAg3fjRyf3GWwbjbyuEs0QlsktMiVsCnaU/K9
	soEZCLAWdhOzPtOps0aT6S+Ljki9F6z22h3MOTmRv3zb4PewAn/4u5j6A9WCc2Ehs6sFaq
	vriPh9Q+GlZyNxcIVymjD3RvfgTm+W+HwtLLGEyVFCmdEWplS7OKolotir4CXlMC+O0ACP
	1q2UEHmizECZjWq69/Po9+B786fbBcXIOYdNpAxSeNJqDVP6He2YKPONHl8eEf3rQ8GlBT
	Emk112Ta9ZVsizYkkCyUr4tc1Qkpyp8Y3uhr/YyxKXIHtV5UnCMpRFsoVM3LKA==
Message-ID: <9d7c554b-2851-4321-aa7d-20253608e9bb@nabladev.com>
Date: Sat, 20 Jun 2026 17:25:05 +0200
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: dbbec8c5a79f ("net: stmmac: fix stm32 (and potentially others)
 resume regression")
To: Sasha Levin <sashal@kernel.org>, linux-stable <stable@vger.kernel.org>
References: <6b4fb2b3-8af4-4963-aef3-ff55797b9954@nabladev.com>
 <20260619.0008.reply@kernel.org>
Content-Language: en-US
From: Marek Vasut <marex@nabladev.com>
In-Reply-To: <20260619.0008.reply@kernel.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-Last-TLS-Session-Version: TLSv1.3

On 6/20/26 1:54 PM, Sasha Levin wrote:
>> dbbec8c5a79f ("net: stmmac: fix stm32 (and potentially others) resume regression")
> 
> Queued for 6.18, thanks.
Thank you.
