Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=212.227.17.12
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1792915103;
	b=VEwkFiHQg+Cm2CgX5eWPgb+wb4wIuFE5JEsOZhYNuvma/i/bxKdA4Ig2n9kgCrpnn0AC
	 djpNmDHdGWEbdVc05rTKpKbuvx4tHezpmxk9XdPXE7hyldMGv5693UkfVkfQtMvajolH3
	 8zX1MJ3hJ9stx9tgWoLyljyG1R9aP/f3JfE1KpPaC6jAHXm4iWUpXMfUd4PTuGwDyzQjp
	 +RQpRXSNzAQqnBclRWuWzSVBLxNuMk33jNFt4BMiZjqaSQFD82Z+gLzXjPrfPy+yywUFL
	 doRK4JD1TEc9AZnPMkGrvRVS01vIPNuyv6fO8gdFQspva9tHcfkKNrcTWuRUTdiUXZA==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1792915103;
	h=DMARC-Filter:DKIM-Signature:X-UI-Sender-Class:Received:Message-ID:
	 Date:MIME-Version:User-Agent:To:Cc:References:Subject:
	 Content-Language:From:In-Reply-To:Content-Type:
	 Content-Transfer-Encoding:X-Provags-ID:X-Spam-Flag:UI-OutboundReport;
	bh=BlV2T+q9mM9P/Dyp0XnJMitUT9+yk7oQfi+fya1bIXg=;
	b=yF82U5ilhtCo37XdHQmClQxJH1xkToLxGd9N6hhClwKEVxEzsB8FGcxhZE6sAQqTjKJi
	 4vY92/ItY80sMGBF+o52vxuWMFfNzP9y7MORouPnFQZSqchI9iCBBbMoSwFz6lvMvAW2/
	 3SPnt5kQzCdgoS6pGmptTsEy6x9xCHhKxsgoBjy0okvJm13obPOou5qWsZrJ0JJzWM5GC
	 fgvEMm1GDU9C3IFrydt8+LVtBYhtzxeR09s/hfUU2NZ0fMsasOg8ASQ/1f79MpPMe0rHn
	 gSggM6NlCpS6X9onJTl563KOff2jCKUJupD1MooFN23JSke3ei4xuaxvQFoO5dboBwQ==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=web.de;
	spf=pass smtp.mailfrom=web.de;
	dkim=pass header.d=web.de header.i=markus.elfring@web.de header.a=rsa-sha256 header.s=s29768273 header.b=bL0ULL9m;
	arc=none smtp.remote-ip=212.227.17.12
Received: from mout.web.de (mout.web.de [212.227.17.12])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange ECDHE (prime256v1) server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BDC91606A31A;
	Sun, 25 Oct 2026 07:58:22 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org BDC91606A31A
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=web.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=web.de
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=web.de header.i=markus.elfring@web.de header.a=rsa-sha256 header.s=s29768273 header.b=bL0ULL9m
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=web.de;
	s=s29768273; t=1792915092; x=1793519892; i=markus.elfring@web.de;
	bh=BlV2T+q9mM9P/Dyp0XnJMitUT9+yk7oQfi+fya1bIXg=;
	h=X-UI-Sender-Class:Message-ID:Date:MIME-Version:To:Cc:References:
	 Subject:From:In-Reply-To:Content-Type:Content-Transfer-Encoding:
	 cc:content-transfer-encoding:content-type:date:from:message-id:
	 mime-version:reply-to:subject:to;
	b=bL0ULL9m2b58izHCzXjh9cKvT1lmF60+KHANgNeuk4D4CBNzNZZJSJ+zGpyl5Ya3
	 a0yyrMNJKk+lVn5yB39mlSsf4+3GOpOEszoKjJeVaWg/UpS7TxMoT7Yl3sXdXbtC5
	 mtjTTcMl5w2X2tf+EYbqL8Q1poQJhl3UL5YroBHSDHxEPOvmWo9tP+IWJxxshlMk/
	 LxGMwy+HuMA3CkS7ht2MxXLJBE6rB7nMkzUhiL9G3J7+2iLrpI9ctXhTr5wrgxnT2
	 8ZJkp7gE6SQcR/qdlm1L3juS9BO3QV6/4yfLMUch0KIiIHD2X2jYQfhjErvubT9Zo
	 86hfLdKrYmtDlVRJyA==
X-UI-Sender-Class: 814a7b36-bfc1-4dae-8640-3722d8ec6cd6
Received: from client.hidden.invalid by smtp.web.de (mrweb105
 [213.165.67.124]) with ESMTPSA (Nemesis) id 1MlLE7-1wqkRN0zBF-00lkFe; Sun, 25
 Oct 2026 08:58:12 +0100
Message-ID: <fa60e7c4-d8ca-4ff4-a56f-6a6e2bfbf3cf@web.de>
Date: Sun, 25 Oct 2026 08:58:06 +0100
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
To: Coia Prant <coiaprant@gmail.com>, linux-mediatek@lists.infradead.org,
 linux-arm-kernel@lists.infradead.org,
 Angelo Gioacchino Del Regno <angelogioacchino.delregno@collabora.com>,
 Matthias Brugger <matthias.bgg@gmail.com>
Cc: stable@vger.kernel.org, LKML <linux-kernel@vger.kernel.org>,
 Kevin Hilman <khilman@baylibre.com>, Roger Lu <roger.lu@mediatek.com>
References: <20261023082948.1854252-1-coiaprant@gmail.com>
Subject: Re: [PATCH] soc: mediatek: SVS: fix device reference leak in
 svs_add_device_link()
Content-Language: en-GB, de-DE
From: Markus Elfring <Markus.Elfring@web.de>
In-Reply-To: <20261023082948.1854252-1-coiaprant@gmail.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: quoted-printable
X-Provags-ID: V03:K1:7PAQDvSkIoVoG9l6Xc514PDbWSozfg5ApFfUXDMA0pSlWVxkqjD
 6B5BF75VF0zb6cCEbfYO73VhcPoeuFVVx4QyBTJ+g4m5nedFa49HSKIYMascfRgaaa1MQJV
 drdy2A8nuy2srQtSe8+AkxksjK5YnOOVIBcGe4qi0pRPaqOxCreg1LnLU6aX9J6r34IWEye
 670Fw3xCasd1m6B2YIR3Q==
X-Spam-Flag: NO
UI-OutboundReport: notjunk:1;M01:P0:OEpGzE8F+u8=;1TVhvPh/36/7HFm/hVhe6gNy8ZO
 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

=E2=80=A6
> Drop the reference before returning on both paths.
=E2=80=A6

How do you think about to increase the application of scope-based resource=
 management?
https://elixir.bootlin.com/linux/v7.3/source/include/linux/device.h#L1363

Regards,
Markus
