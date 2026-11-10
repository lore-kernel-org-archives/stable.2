Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=212.227.15.14
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1794316128;
	b=Ana5ynxx74gIjW1QDGaJT0LJbZjrVsARMQIDJl40z7LenOGB3jCwLmx85PjbjKjJ6xmm
	 dCikfDMBwhVDClBbWkeE2YIrGOBSgbNxqRkXu6L4R6XjmhUKxxyqjnyWGdc5X5m5699ga
	 J8fZxRFX+0Q2eg8cEizijIkLtm39iqJ663w0jn6KX05wZ/pWFMFogfokjqvhOPcQ3TmCq
	 H18oV4vin8dN1ZZpoiT6eubJV0zD5dyy526IERFGAkPxj6ruNcfelnH0ZxfBicOcocNTk
	 19uHYRUWo7KA5ADaCPOhVh80WN3FfLFAfMm6cTU8w+iZKflsj2v3nker1+oQV16KZrg==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1794316128;
	h=DMARC-Filter:DKIM-Signature:X-UI-Sender-Class:Received:Message-ID:
	 Date:MIME-Version:User-Agent:To:Cc:References:Subject:
	 Content-Language:From:In-Reply-To:Content-Type:
	 Content-Transfer-Encoding:X-Provags-ID:X-Spam-Flag:UI-OutboundReport;
	bh=+KtXmG4lJ1Wx1e+VuY6k2DDrDm2OdumMvWJsmwzIb7o=;
	b=Sf5OkUblgxuqXtFG50RzMklbdb+vW/IGN3Kmotaztwc2vw5uz7mcw9LXpsOVKw413mV+
	 nkowr7l6FshdNfwcMdBhBvyo04WL2HpVaoXGQHF8f7X+KouDIjTsBjIFoetf8lGbPDZBm
	 yeCquqRvcKyjY49VNfup6vOTSHzw28VIHNcfdOt2Em48Atslu4HJGMevcT4YPLVbabgCi
	 Gk30JkyEY2gtSBNRu8uqoeOqduB8sR8Ne50UG8b0caU1cCHtX22z6WwVR2i1qS48lrIuA
	 HVFomcL9qg9RIK9ORKEOWNt5l0+kSPyqwrriQ31LWojGwdG21iHJReftQ8QyU0z8w/w==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=web.de;
	spf=pass smtp.mailfrom=web.de;
	dkim=pass header.d=web.de header.i=markus.elfring@web.de header.a=rsa-sha256 header.s=s29768273 header.b=NG7zTPur;
	arc=none smtp.remote-ip=212.227.15.14
Received: from mout.web.de (mout.web.de [212.227.15.14])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange ECDHE (prime256v1) server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B7209606A31C;
	Tue, 10 Nov 2026 13:08:46 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org B7209606A31C
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=web.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=web.de
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=web.de header.i=markus.elfring@web.de header.a=rsa-sha256 header.s=s29768273 header.b=NG7zTPur
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=web.de;
	s=s29768273; t=1794316117; x=1794920917; i=markus.elfring@web.de;
	bh=+KtXmG4lJ1Wx1e+VuY6k2DDrDm2OdumMvWJsmwzIb7o=;
	h=X-UI-Sender-Class:Message-ID:Date:MIME-Version:To:Cc:References:
	 Subject:From:In-Reply-To:Content-Type:Content-Transfer-Encoding:
	 cc:content-transfer-encoding:content-type:date:from:message-id:
	 mime-version:reply-to:subject:to;
	b=NG7zTPurk2Q//MqqiiA2y5xtu6lCBlt6y3Vl7R7Md6xWGcLB24AfJHs+S+4kFBTQ
	 LLx9Kltydegrrj75QGTFjZCp9v1qT1hY3efyq54EW0HfzZvVjH+unoxtfFDJOyPoE
	 pk2NpbbYRKOAPqmtAi58jorhxqRzQsoeY1SFG0mhfNp9lA0PvoA9kdhjyDTKs7iBX
	 lX/y0nn608VCNVBuy3rZdNlMmzGwQWLS4xsuttmfBbJI6HghiBMTZ4fwwSPJcvNyu
	 p7tiK+Zq21ddo9Ihf/YN9fLzYogmX9lWr6lAs1MTV9uK8qOmd/uj+brP3fpXP8/nW
	 JWgShLk46nx/QkwoUA==
X-UI-Sender-Class: 814a7b36-bfc1-4dae-8640-3722d8ec6cd6
Received: from client.hidden.invalid by smtp.web.de (mrweb006
 [213.165.67.108]) with ESMTPSA (Nemesis) id 1MPrLL-1x3zVP49Hn-00MExw; Tue, 10
 Nov 2026 14:08:37 +0100
Message-ID: <265240b9-c9d9-4dcf-aea3-b31c460a0e3a@web.de>
Date: Tue, 10 Nov 2026 14:08:33 +0100
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Post: <mailto:stable@vger.kernel.org>
List-Help: <mailto:stable+help@vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
List-Owner: <mailto:stable+owner@vger.kernel.org>
Precedence: list
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
To: Joas Antonio dos Santos <joasantonio108@gmail.com>,
 netdev@vger.kernel.org, osmocom-net-gprs@lists.osmocom.org,
 Andrew Lunn <andrew+netdev@lunn.ch>, "David S. Miller"
 <davem@davemloft.net>, Eric Dumazet <edumazet@kernel.org>,
 Harald Welte <laforge@gnumonks.org>, Jakub Kicinski <kuba@kernel.org>,
 Pablo Neira Ayuso <pablo@netfilter.org>, Paolo Abeni <pabeni@redhat.com>
Cc: stable@vger.kernel.org, LKML <linux-kernel@vger.kernel.org>
References: <20261110-gtp-echo-rsp-leak-v1-1-192c032f3dfa@gmail.com>
Subject: Re: [PATCH net] gtp: free the skb after handling an echo response
Content-Language: en-GB, de-DE
From: Markus Elfring <Markus.Elfring@web.de>
In-Reply-To: <20261110-gtp-echo-rsp-leak-v1-1-192c032f3dfa@gmail.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: quoted-printable
X-Provags-ID: V03:K1:HeVayAa2KrEcOqstVPg4EgmvefaHAhOk7cFpThm52hpSQLPuNt8
 UnlTGJbg4OH6lUVsI3c9pR9tNTpQqqzlE1d1+Zodr5LzHjKMRS+KNy8rFkiuG7v23ezR3fh
 q3gUEn9E72xqWg6Oh6uNmFMCqxLZYG6YuJi2rZX/kWS+vg7UAe9Fe+cCMtqXo2DhUp1O/uH
 SlhWdS5/JS1Upww508zeQ==
X-Spam-Flag: NO
UI-OutboundReport: notjunk:1;M01:P0:l/NAFTUjf9M=;sZOIV2CAxRLAk9SU/XYI/MOtvPf
 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

=E2=80=A6
> +++ b/drivers/net/gtp.c
> @@ -561,16 +561,19 @@ static int gtp0_handle_echo_resp(struct gtp_dev *g=
tp, struct sk_buff *skb)
=E2=80=A6
> -	return genlmsg_multicast_netns(&gtp_genl_family, dev_net(gtp->dev),
> -				       msg, 0, GTP_GENL_MCGRP, GFP_ATOMIC);
> +	genlmsg_multicast_netns(&gtp_genl_family, dev_net(gtp->dev),
> +				msg, 0, GTP_GENL_MCGRP, GFP_ATOMIC);
> +	consume_skb(skb);
> +
> +	return 0;
>  }
=E2=80=A6

I suggest to reconsider the error detection a bit more.
https://elixir.bootlin.com/linux/v7.3.1/source/drivers/net/gtp.c#L541-L573
https://cwe.mitre.org/data/definitions/252.html

Regards,
Markus
