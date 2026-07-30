Received: from mout.web.de (mout.web.de [212.227.17.11])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 19BE936212D;
	Thu, 30 Jul 2026 05:17:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=212.227.17.11
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1785388670; cv=none; b=m/olnGTbiD8h1AB3zgMtZlpZFnAfav0xoD8wt6aMSECJsE4aA45KFRXEqONjQph7/wchr2vT/22+//s+YCGUZKF3GXLN+cKdNB16E3yTbky+nKxFATbzyB98ljdruM+7cvVMWwoS5HNtGXwquH1iBmgGwZooCU84Mqwl1gaITsU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1785388670; c=relaxed/simple;
	bh=NMeOn2iscgsid/jdNEVVnFPjiKY8OR1+448qjI5W5qM=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=lpQUny+kY2uf9yDAHEipZHHftgKiQF3Mtk0pCquMFBNqzK6hNR3k6eE9oRMKCf9RPuVvdvosTwLPWQbulg4PUOoHJdKKXtzGK+I4gtwB+YxIpjW6egyzNpuYhdhQJuAtQpKSlAiJX2IpShqeTtVXBJc89ipuJ0kzJ/+ZsWvygg4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=web.de; spf=pass smtp.mailfrom=web.de; dkim=pass (2048-bit key) header.d=web.de header.i=markus.elfring@web.de header.b=rKnuW7ac; arc=none smtp.client-ip=212.227.17.11
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=web.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=web.de
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=web.de header.i=markus.elfring@web.de header.b="rKnuW7ac"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=web.de;
	s=s29768273; t=1785388643; x=1785993443; i=markus.elfring@web.de;
	bh=NMeOn2iscgsid/jdNEVVnFPjiKY8OR1+448qjI5W5qM=;
	h=X-UI-Sender-Class:Message-ID:Date:MIME-Version:Subject:To:Cc:
	 References:From:In-Reply-To:Content-Type:
	 Content-Transfer-Encoding:cc:content-transfer-encoding:
	 content-type:date:from:message-id:mime-version:reply-to:subject:
	 to;
	b=rKnuW7acc+WkJebAaYLGCHSaRWLARjDyAYqgSn60Cwq5Ae78mZx8TfPYtQRa+Hbm
	 wkJZTjw2yjneHnCd7Q15Q1CpASC3ekRm8h8UGbL29fceEf52p+ZJ4Fa8koDObvjuv
	 DIp8YiU7SEhocS8yEFDc817RVqEZZ/3mbVbsVy42PD4BvDye6tAbhS7Ilz7ukzhkk
	 xvkAFeeT7plLew3UgIwPizqq7XTKzgmRc9eb6+1X7n0S9Su+iVJS5Hx1ziWPeYFJ4
	 bXLjJuxi+Oz2n5y3HAT8C64Ia3pegp8yT1oQgMXspsZzIkJLz6cPyruHqXZqLy8YK
	 AapS96gVyb7uARiyxQ==
X-UI-Sender-Class: 814a7b36-bfc1-4dae-8640-3722d8ec6cd6
Received: from client.hidden.invalid by smtp.web.de (mrweb105
 [213.165.67.124]) with ESMTPSA (Nemesis) id 1Mf3qK-1xPzTt1PY2-00lEur; Thu, 30
 Jul 2026 07:17:23 +0200
Message-ID: <a7b3b9c3-8568-4acf-8ccc-e92eff73a3bd@web.de>
Date: Thu, 30 Jul 2026 07:17:20 +0200
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v5 05/15] media: redrat3: Error path leaves device in
 transmitting state
To: Sean Young <sean@mess.org>, linux-media@vger.kernel.org,
 Mauro Carvalho Chehab <mchehab@kernel.org>
Cc: stable@vger.kernel.org, linux-kernel@vger.kernel.org,
 kernel-janitors@vger.kernel.org, Hans Verkuil <hverkuil@kernel.org>,
 Julia Lawall <julia.lawall@inria.fr>,
 Wolfram Sang <wsa-dev@sang-engineering.com>
References: <cover.1785338381.git.sean@mess.org>
 <92bf1bf1bbdcac248de159a1670bb8bc1c7fab14.1785338381.git.sean@mess.org>
Content-Language: en-GB, de-DE
From: Markus Elfring <Markus.Elfring@web.de>
In-Reply-To: <92bf1bf1bbdcac248de159a1670bb8bc1c7fab14.1785338381.git.sean@mess.org>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: quoted-printable
X-Provags-ID: V03:K1:QVBuoFUyl+UCI2dN0iSHuNeg9Ls/LZCBwYFczlkCTk3W3xi9mMo
 erX+3Znv5n6exgKCifx87tVMZGnkS9EinburfHFGJu4ipadenSfp2c6v7af5bJ8WdI3QkeE
 52hFGaW9EcxpKHk0Ejz3EyHfu5aRoRfmzCjTyUwHgESPzQ29IA1xGDLRA7hSj6nqNfyrTJ9
 uY0nPsxvfgifyGIQeSZ6A==
X-Spam-Flag: NO
UI-OutboundReport: notjunk:1;M01:P0:kKQVWC5wqXs=;Y66ANT8aOvCqi9+j63jeoAUOqiE
 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

=E2=80=A6
> Fix the error path by moving the assignment statement.

How do you think about to increase the application of scope-based resource=
 management
also for such a function implementation?


=E2=80=A6
> Fixes: fac59136bc22 ("[media] RedRat3: Return directly after a failed kc=
alloc() in redrat3_transmit_ir()")"=E2=80=A6

Would a revert be needed for this commit before further adjustments will b=
e considered?

Regards,
Markus
