Received: from mout.web.de (mout.web.de [212.227.15.3])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 83DF941D222;
	Mon, 27 Jul 2026 15:57:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=212.227.15.3
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1785167849; cv=none; b=bw3OBc1Y41n1WDZL/JknXScl95nkHf+qRZTvQXP8A+1/JiEm/JvhHO4DuQb7Txkta6u+gZkngDXhPllal1K8TvLOigDjOlRT0qho906XXUcRJF3Ow4FpJP/XR1qrOB/UDBWJg66q01RbNxC+BdPCHDMj8txtIe4HpIlOWr258TM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1785167849; c=relaxed/simple;
	bh=o8iqj1MVqbzrMrZP0DWQjncIZlZZledL59iYx78veSg=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=fKhEhABFURifpMsflvIijlf28FJ8m9tV4bl9yOaJTM/3RgD/B6gkR8vk07NAygyDq6k6ay68TSyu5aWJWL5sCgVqqRtv86P/dEkjnyhG8AmnDQOezNFPySTIGL8bZtlzL+rvp6ypE+I3Fc1qFcklXDWyx2p9crsFK/BFeH8NsWE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=web.de; spf=pass smtp.mailfrom=web.de; dkim=pass (2048-bit key) header.d=web.de header.i=markus.elfring@web.de header.b=Hx5tjtjT; arc=none smtp.client-ip=212.227.15.3
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=web.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=web.de
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=web.de header.i=markus.elfring@web.de header.b="Hx5tjtjT"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=web.de;
	s=s29768273; t=1785167845; x=1785772645; i=markus.elfring@web.de;
	bh=ZkGqPORVblicHw8sjrF/RvGx754D946vEaO2WkbS8N8=;
	h=X-UI-Sender-Class:Message-ID:Date:MIME-Version:Subject:To:Cc:
	 References:From:In-Reply-To:Content-Type:
	 Content-Transfer-Encoding:cc:content-transfer-encoding:
	 content-type:date:from:message-id:mime-version:reply-to:subject:
	 to;
	b=Hx5tjtjTNY2SLlAdjgroDF1kxaphkwaPpB/7pJIraMc4UhyklyVYY8DHBj9Zt6/k
	 Ezi+jAUspv8glf284SUAECbO+DsbD1TAGbHJTL4yiT5t3z3JVikEyf07+JczNz28n
	 9DMtpx769C47aG+GLVolDS+4D7eKOh0pAtrfZlbmYk6FwBRSl9NwKDjTxbM3tvoK/
	 vt+UY2KaknzHOZkUcopZSWQEDFKbmcAmWD+xvga1ZAQXXutjVIQFgKtTMNRa9xfDu
	 5FtHJNW8L/y9geOKg1iCoeCZJUDmDeymcLHkX1pDqia1Q5fYyEAYtkanb12jAlKwo
	 32xPMdgD7zKW2RmQCw==
X-UI-Sender-Class: 814a7b36-bfc1-4dae-8640-3722d8ec6cd6
Received: from client.hidden.invalid by smtp.web.de (mrweb005
 [213.165.67.108]) with ESMTPSA (Nemesis) id 1MPKFF-1wbuIa1VC1-00MOEe; Mon, 27
 Jul 2026 17:57:25 +0200
Message-ID: <d59b23fd-0d97-471b-8af4-0379349829ce@web.de>
Date: Mon, 27 Jul 2026 17:57:23 +0200
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v4 05/15] media: redrat3: Error path leaves device in
 transmitting state
To: Sean Young <sean@mess.org>, linux-media@vger.kernel.org,
 Mauro Carvalho Chehab <mchehab@kernel.org>
Cc: stable@vger.kernel.org, linux-kernel@vger.kernel.org
References: <cover.1785158244.git.sean@mess.org>
 <d22b8dac679cc4b4713dd03875576d71305e3912.1785158244.git.sean@mess.org>
Content-Language: en-GB, de-DE
From: Markus Elfring <Markus.Elfring@web.de>
In-Reply-To: <d22b8dac679cc4b4713dd03875576d71305e3912.1785158244.git.sean@mess.org>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: quoted-printable
X-Provags-ID: V03:K1:BLgg2jn4Td/J9hnBBWwzHCMygjeYY3PgzdnwMjVjMt0WEmmu6Sl
 JuDnvGAL1DTbSyHZJJPQ3NOZo+AL/rrMbjY2sk8+bRifIRF+fGEFb2OVhd6z6f6MEEQq0Vs
 9m4P6QbWLTKXGXkz2YUV6tIr/XG6xedwl2NLfwilAhrqJBYbRImYwqigb0kBW1NUtjKy+lk
 EMjdaFYfjii3nVdGc+BTQ==
X-Spam-Flag: NO
UI-OutboundReport: notjunk:1;M01:P0:FYCUzsSAuhc=;aEL9VcjsjF7vNFHbqM+zEsXrdW7
 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
 ksxDuVz/D+0o9BQxhPC1s

> If the allocation fails, transmitting is left as true and the transmitte=
r
> cannot be used any more.

See also once more:
https://git.kernel.org/pub/scm/linux/kernel/git/torvalds/linux.git/tree/Do=
cumentation/process/submitting-patches.rst?h=3Dv7.2-rc5#n94


=E2=80=A6
> ---
>  drivers/media/rc/redrat3.c | 6 +++---=E2=80=A6

Some contributors would appreciate patch version descriptions.
https://lore.kernel.org/all/?q=3D%22This+looks+like+a+new+version+of+a+pre=
viously+submitted+patch%22
https://git.kernel.org/pub/scm/linux/kernel/git/torvalds/linux.git/tree/Do=
cumentation/process/submitting-patches.rst?h=3Dv7.2-rc5#n310

Regards,
Markus
