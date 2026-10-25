Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=212.227.17.12
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1792929979;
	b=gUfsMiY902d/AeQxJTzunb232tS5vmYlAbCQSfWHKkp2ZKC0KkAOCurUpLVvDPGgQBS/
	 vq2Hl/GKmcWwA425LoJ38mU0H7v6dVs4NaAIRJWdjlKrr0ig8SzNR35+Yrtm/ncbxUiVJ
	 bFyBlkbTz4+GRtWgRPP0w5KWs4IEusEfIca3BJ/CjpKvXI6zQgXftH78XM3RhF9YhKXu/
	 dYR7EyKVoSd41K9Z/YgnjbLfSP9ucAI2L0VfO+3+Ck8+IqM35VnrDLsFvHhZlaBZZdriw
	 q6Z68Vg2k19xxDUqwgZ1GjfwirtiXRNFywu+APF3hKlZmpQi7hikhoks97hRFciS57Q==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1792929979;
	h=DMARC-Filter:DKIM-Signature:X-UI-Sender-Class:Received:Message-ID:
	 Date:MIME-Version:User-Agent:Subject:To:Cc:References:
	 Content-Language:From:In-Reply-To:Content-Type:
	 Content-Transfer-Encoding:X-Provags-ID:X-Spam-Flag:UI-OutboundReport;
	bh=AEqnYiQaRp11PSDWd+g/ZMi6Ri0peYMYcJvCEEGGhuo=;
	b=tHCsaovGszkI8y03gjfou9m6EAA55ruHD3SbW5arm46ZfaK1nCyuAaWpLgWti/Ua4/y1
	 12KzHxOcFlXVVDzzrK6TjkYs6urjG2PABU8II+MdSs8UFbRFyLBxVeWry+6jdVMb4UouG
	 RBooz+6lK4Pykg7DYv99G/Q2dyqmXkjaNpXVRdTgxjwMi6fVMa6goEdzSi19GrBTee5L9
	 iGvvkkwEJPzAjjlFuGeWW82l77RLHR5J69li1zqNlny2l8vTGB3hdGv9soqEMkxGrcOMY
	 XuslZrK7zEsQrf7tCWaHIe1JVGnmTKtJPj1dcOb8tWucbnB3KiEyzD7fzdUrKdUYduQ==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=web.de;
	spf=pass smtp.mailfrom=web.de;
	dkim=pass header.d=web.de header.i=markus.elfring@web.de header.a=rsa-sha256 header.s=s29768273 header.b=KNMjOZK5;
	arc=none smtp.remote-ip=212.227.17.12
Received: from mout.web.de (mout.web.de [212.227.17.12])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange ECDHE (prime256v1) server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3A73D606A31A;
	Sun, 25 Oct 2026 12:06:17 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 3A73D606A31A
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=web.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=web.de
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=web.de header.i=markus.elfring@web.de header.a=rsa-sha256 header.s=s29768273 header.b=KNMjOZK5
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=web.de;
	s=s29768273; t=1792929968; x=1793534768; i=markus.elfring@web.de;
	bh=AEqnYiQaRp11PSDWd+g/ZMi6Ri0peYMYcJvCEEGGhuo=;
	h=X-UI-Sender-Class:Message-ID:Date:MIME-Version:Subject:To:Cc:
	 References:From:In-Reply-To:Content-Type:
	 Content-Transfer-Encoding:cc:content-transfer-encoding:
	 content-type:date:from:message-id:mime-version:reply-to:subject:
	 to;
	b=KNMjOZK50AeytUt4mBuL+GiqAh2fj5GyiCPbgeSN1T7vKXkSQF82Sw7dD4K9tXz4
	 r4iWT5iat2WRE1+K9WZw4921ww3z5RnM89GNKNQBG0eiltnHOY0UdYM9+1Urk4vlP
	 jG5SXqCt7H+z+yrTK4/h6xPTGwrLiZWOhlYZhSu4uIDBNsSNkJCXmX4cfDKPLlxz9
	 3qtkvPw+duK1K70Gf2u/ZmulZtKAIaZuePSXCkVwFJuneCJj7UflzvKHE59KRfUyY
	 gI6UeISOnE3sex79bq1mOOX7DLP+OZyFuRnOYXLcXsp/pBAICEtAoa8duoEDcQz62
	 TwHnLR28T3bq8tvKxA==
X-UI-Sender-Class: 814a7b36-bfc1-4dae-8640-3722d8ec6cd6
Received: from client.hidden.invalid by smtp.web.de (mrweb105
 [213.165.67.124]) with ESMTPSA (Nemesis) id 1MbkSC-1wisbp3gOk-00dDTW; Sun, 25
 Oct 2026 13:06:07 +0100
Message-ID: <1a172ffb-d823-4a8a-bf4e-7b8edf9f146a@web.de>
Date: Sun, 25 Oct 2026 13:06:04 +0100
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
Subject: Re: soc: mediatek: SVS: fix device reference leak in
 svs_add_device_link()
To: Coia Prant <coiaprant@gmail.com>, linux-mediatek@lists.infradead.org,
 linux-arm-kernel@lists.infradead.org,
 Angelo Gioacchino Del Regno <angelogioacchino.delregno@collabora.com>,
 Matthias Brugger <matthias.bgg@gmail.com>
Cc: stable@vger.kernel.org, LKML <linux-kernel@vger.kernel.org>,
 kernel-janitors@vger.kernel.org, Kevin Hilman <khilman@baylibre.com>,
 Roger Lu <roger.lu@mediatek.com>
References: <20261023082948.1854252-1-coiaprant@gmail.com>
 <fa60e7c4-d8ca-4ff4-a56f-6a6e2bfbf3cf@web.de>
 <9AE974CC-F342-42F0-84A3-D72C3A0326C2@gmail.com>
 <230b2dd8-8d8f-4b1c-ac9f-2c1eac636751@web.de>
 <2E8D967C-6CC3-44C9-B447-9D977E7A6538@gmail.com>
Content-Language: en-GB, de-DE
From: Markus Elfring <Markus.Elfring@web.de>
In-Reply-To: <2E8D967C-6CC3-44C9-B447-9D977E7A6538@gmail.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: quoted-printable
X-Provags-ID: V03:K1:yYiGuSIOaIc7+wkm/5TAfCtnc9q06ZxrSaPb9OXGiAYVL0TF0Q1
 Q8RRdtfJfoxu4HXuhj0SfjtwpWrPOw/k/dZXoR/mgIjdDNpp43TO+QoW7ugp+QP+cMqhfao
 aCz5+Bmj/iZMYZnPeJTggAbFvjoefU/M/B5rbaqWTH3UP64gG1SsMnzgRt9SBjzO2Dl1pjy
 pbLwW+I7BsFZFh8WoLSKQ==
X-Spam-Flag: NO
UI-OutboundReport: notjunk:1;M01:P0:7FZS7137QCo=;swtgiOJxiRNRZc5bkHV1X4ZZh4U
 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
 m/TXk4

=E2=80=A6
> PCS is where most of my remaining TODO list is, so that's where I'll
> spend the next chunk of time. If I get through that and still have room,
> I'll take a look at the other () call sites that have the
> same missing-put_device pattern. There seem to be a few.=E2=80=A6

Would you be looking for further software improvements?
https://git.kernel.org/pub/scm/linux/kernel/git/next/linux-next.git/tree/s=
cripts/coccinelle/free/put_device.cocci?h=3Dnext-20261023#n2
https://elixir.bootlin.com/linux/v7.3/A/ident/device_link_add

Regards,
Markus
