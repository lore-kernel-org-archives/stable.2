Received: from mout.kundenserver.de (mout.kundenserver.de [212.227.126.187])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 90C1D360EDE;
	Tue, 18 Aug 2026 17:15:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=212.227.126.187
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1787073351; cv=none; b=U9XhZV4j6nCRDE2bMLr7LLJ8grvPo4Tj/6SQB43/bbKPW8cKRp+M40nBe3iN3GIxUm7O17AaYcfMaSV7dWkxzj2llm/oXvDaqZsw900KZxR86Nc1Xe1GUV8lXmQXjtM/cmrX5llki2pYhWoGD09JgQavSzGylyRGGPQx5duWvjw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1787073351; c=relaxed/simple;
	bh=FjcPOeyQsVBBfsTumh+zwyAM5XY94zI8TsKPASqL5hc=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=H1uazATAH30Zi3ErwTURPWMd6Ekv5YIS3BVguKwqfuX8CKMsFzcM9YPoZKlQMRrB+UqNoAKx+HSkb447bKjJYzP5vxCKpUjelMWKj4NJyvKYDdIRunzV0D7CBO+eBlD3jTt1QBBJU1CufZ8uRmtUAlB+KoP6oiryV4qzwx2MGeU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=oldschoolsolutions.biz; spf=pass smtp.mailfrom=oldschoolsolutions.biz; dkim=pass (2048-bit key) header.d=oldschoolsolutions.biz header.i=jens.glathe@oldschoolsolutions.biz header.b=BjEuJ4Lj; arc=none smtp.client-ip=212.227.126.187
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=oldschoolsolutions.biz
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oldschoolsolutions.biz
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=oldschoolsolutions.biz header.i=jens.glathe@oldschoolsolutions.biz header.b="BjEuJ4Lj"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=oldschoolsolutions.biz; s=s1-ionos; t=1787073340; x=1787678140;
	i=jens.glathe@oldschoolsolutions.biz;
	bh=FjcPOeyQsVBBfsTumh+zwyAM5XY94zI8TsKPASqL5hc=;
	h=X-UI-Sender-Class:Message-ID:Date:MIME-Version:Subject:To:Cc:
	 References:From:In-Reply-To:Content-Type:
	 Content-Transfer-Encoding:cc:content-transfer-encoding:
	 content-type:date:from:message-id:mime-version:reply-to:subject:
	 to;
	b=BjEuJ4Ljx3UD4Ank3Yhc0W5PIulVXXvFA3TzUPwCXA1LJ6k0t1HuLIWCI/MXsak4
	 xTWXDb+hqhuUCZjMCoarb5lb5sXHeehMxAhKqptxOGlNnkd+oQDtSH1vONbB35ECt
	 orXCKeQ+BLtRKnI1L01/wOonUqv5/E95v38WgbfzUfa7PzKHq8lYbT+akmQXK2Xmt
	 nKwMUvVCqgc0c/2nrC+4B6eQet3PSJ/xDawIStgYqEeZqwhshYNXwGAB504xhPkZj
	 DafL/B6dNE2nHqBuOwE228QQPJRIJEr+dQIzlgXJL6fKTPZlErT1P7YYXjVLKIpBp
	 VjuD0VQ6t3fy7drfxg==
X-UI-Sender-Class: 55c96926-9e95-11ee-ae09-1f7a4046a0f6
Received: from client.hidden.invalid by mrelayeu.kundenserver.de (mreue009
 [212.227.15.167]) with ESMTPSA (Nemesis) id 1MQ5nE-1xISPk0jyK-00T4uF; Tue, 18
 Aug 2026 19:01:48 +0200
Message-ID: <96111481-7c06-47b3-b0de-5039bdd790d6@oldschoolsolutions.biz>
Date: Tue, 18 Aug 2026 19:01:46 +0200
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH] usb: typec: mux: Fix typec_switch_match()
To: Sebastian Reichel <sebastian.reichel@collabora.com>,
 Marek Vasut <marex@nabladev.com>
Cc: linux-usb@vger.kernel.org, stable@vger.kernel.org,
 Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
 Heikki Krogerus <heikki.krogerus@linux.intel.com>,
 kernel@dh-electronics.com, linux-kernel@vger.kernel.org
References: <20260817182302.146546-1-marex@nabladev.com>
 <aoSFjbydIiu4KyW0@venus>
Content-Language: en-US
From: Jens Glathe <jens.glathe@oldschoolsolutions.biz>
In-Reply-To: <aoSFjbydIiu4KyW0@venus>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: quoted-printable
X-Provags-ID: V03:K1:bfnKMpzRLoB2zmfT5sS9ytEcTOtKjt2AXj4omwFwzUtTc4Ddae7
 k6BVHOgFHbBO1sL0LofxppwqEtLkOcdAvvHbfE6XvYPaf/5vvLPcTsb+aP7hX/dvgHOwVmf
 m7QJmx/ycU1/IR8e5L5V0p/2Nwz8mk5d9JgDmhue1m8tyE6Y0jY5VlEACvphDalKVwDPYuH
 cLpQaZuESp8T3eVR+ksCA==
X-Spam-Flag: NO
UI-OutboundReport: notjunk:1;M01:P0:n8yCyDFqNcQ=;0FRmrti7rq081jUfpnvXq4omMic
 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

Hi, Sebastian,

On 8/18/26 18:24, Sebastian Reichel wrote:

[...]

> This revert negatively affects Rockchip once my USB-C rework for
> USB-DP lands and I undid it locally. I've just not yet found the
> time to investigate why it regresses the X1E platform to reintroduce
> the feature. Maybe you found the root cause and fix already, but
> investigating with my T14s Gen6 Snapdragon is on my TODO list.

The T14s Gen6 Snapdragon has ps8830 redrivers, your patch works with=20
them. Probably because they register as retimer-switch which takes a=20
different path then mode-switch.

I observed the issues with models that don't have the redriver chip,=20
like Ideapad 5 14Q8X9 and Thinkbook 16 G7 QOY. They have a separate=20
gpio-sbu-mux which don't get the mode-switch call when the patch is in.=20
I could test on sc8280xp which also has separate gpio-sbu-mux switches=20
if that brings some light to the issue.

with best regards

Jens

