Authentication-Results: smtp.subspace.kernel.org; arc=pass header.oldest-pass=0 smtp.remote-ip=74.125.230.73
ARC-Seal: i=2; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=pass;
	t=1795437723;
	b=OWq3q614ujuyq0u9Sjx75JkuQ9BpflHexDkaxHpCYcauNm5Ege3AQKV1aohEnS49n/EB
	 Qqz7jxatpDvDhaTqIRz8OQ91JvVz78DyNzIdxBXszbRXcZPgEMc5cBZUG3QMpC28WJBYr
	 ffxSvR/JdWgUVfIMBEKhHyKboql+XxUv9perFGM4YXqiYhCWOyqlteWFB9xs6VMcrsBly
	 fjYzRGFb3gwObw6Ks9EIanhaoYT8oIpK7WA/sHxNltnevagcW4UfwMGmBArrZ96/oruZc
	 dyD0lzqJeEobs0CkQ+aaEDmiJQ2uF2qB4YeCln07XWCGYYOkrAgAg5v4imivs9D4xrg==
ARC-Message-Signature: i=2; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1795437723;
	h=DMARC-Filter:Received:DKIM-Signature:X-Google-DKIM-Signature:
	 X-Forwarded-Encrypted:X-Gm-Message-State:X-Gm-Gg:X-Received:
	 MIME-Version:References:In-Reply-To:From:Date:X-Gm-Features:
	 Message-ID:Subject:To:Cc:Content-Type:Content-Transfer-Encoding;
	bh=zk/zRd/DSWOo4ZU+uiseKdBg5SqPyN64+INmafD407Q=;
	b=IYPnS71bIDKHubUmCMWu7yPTl7OKsKz+mqEcq0xWtCZe+LBn0Ufg8YEe1SpZhTDDuf1v
	 C3V6QejLr6ZHeR1Yg3PIs3os1HO2xW8+uucC5mSN0wKPIgUp6FE4gtmo0pNsoChFfiD/4
	 pUNuTaBBlhvF9KjtbTKUkAcMKg+beW+f90Oj48gHv/WC+R22Ltwn0Bn05Ys/TEcga/ai0
	 1XfE3+s95q5k8+zXT8oWhnKWPRVdnCwzwmkQIOwFTzKi5wyPUbOzqKYR/5Ks+VSql2HCA
	 CpZe4IopyxpP26J41JRAJouHh0w/eOWlwg3JejLpNgeDRuoKmTLLcytmOzE9H68heFg==
ARC-Authentication-Results: i=2; smtp.subspace.kernel.org; 
	dmarc=pass header.from=gmail.com;
	spf=pass smtp.mailfrom=gmail.com;
	dkim=pass header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20260707 header.b=TNSWdwkN;
	arc=pass header.oldest-pass=0 smtp.remote-ip=74.125.230.73
Received: from mail-lr2-f9.google.com (mail-lr2-f9.google.com [74.125.230.73])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3AEC6606A31A
	for <stable@vger.kernel.org>; Mon, 23 Nov 2026 12:42:03 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 3AEC6606A31A
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20260707 header.b=TNSWdwkN
Received: by mail-lr2-f9.google.com with SMTP id 38308e7fff4ca-3adfb70f9dcso15124111fa.1
        for <stable@vger.kernel.org>; Mon, 23 Nov 2026 04:42:03 -0800 (PST)
ARC-Seal: i=1; a=rsa-sha256; t=1795437721; cv=none;
        d=google.com; s=arc-20260327;
        b=d6Zw4EB0DHVvv6i3qAkUnMnk9A4FheZg1ASPl6N+PpMJb4uewRG9OoTV8fNqfezk84
         NqNlv5DPOM/8YHHIMbxrm2f03mDYYdS8EcKyS9HB6cpbpLiDo258Mvi7/PEoP6CNAIVB
         nDEen4kOCF6Fi9fpWZRdjT8OmzJxG6jFZZOugc9vf202j2l1bMcwEwFKoOJvUZcv/J+F
         HCW4ZpRD/z0O5qslstf4eXCUEm2x/Jd9Vyb39UcF54syAMa108/JsvXXpA5cYiuX0FCR
         R6j3AzWubKRh7ac6urtG1HKlqUxapaxev/TrNWNjaumz/34O2eTONk2xSdnUspNxmicS
         rMRQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20260327;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:dkim-signature;
        bh=zk/zRd/DSWOo4ZU+uiseKdBg5SqPyN64+INmafD407Q=;
        fh=tC5BCbKwd+LGSOfE129W2z79Al4wf+s1iES5zxpfHqQ=;
        b=JGuAZTWwxLQhrJSROf4v7zK9iGo77TKMBkFxmiNqSiC6wLSvsYtbZGwml/n41aBpXe
         NCsibRtQVBRmi06DiSvkBbwD4GckfDsoj1CmZxeDs+IPiYj/lVXG/ccXQqvm9jLT5uox
         3t4Y5rdHyIX7lTfvhrdXiXNrXyX2NrbY2aNlzN8aFAvAJuJ9CoiVkTySmJD0vrlx73QK
         6e3+OdaOQyPmOdwUhQCTC4vv2OTxAu5Jxf6e+F+v7hiAwNY04qaNa7BwE1r/60fB2O5g
         eJOxFrxdmLFxSnr4nHbgpeXNnl8zKl/yEZGxJyItGuT2EJqA8xWVlTpbmx6NJ6sjelgu
         6KlA==;
        darn=vger.kernel.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20260707; t=1795437721; x=1796042521; darn=vger.kernel.org;
        h=content-transfer-encoding:content-type:cc:to:subject:message-id
         :date:from:in-reply-to:references:mime-version:from:to:cc:subject
         :date:message-id:reply-to:content-type;
        bh=zk/zRd/DSWOo4ZU+uiseKdBg5SqPyN64+INmafD407Q=;
        b=TNSWdwkN2sZFJfb2o1DNIIW5NUjk6MAMdfjUvXTiance+EI03fRfY5EEj2JPt40F+F
         ADqhWMqHMeV68+Nr286UlbvyyrRPWgWPUwDZBmkEFKau1T6geBFlkz8mX/dtCU7LdgOV
         RwAVgiTgNurVXyid6nEQn7JNPlyfKlcq4oD6BhalW9KNudPTx4uJax1VIW2aMpZ8lMrW
         Ll6+3QI1GEWLAtgoXfZ/oOOKrN4puL01o5/iBjpju9B6ziM3oiRHfRem3FkGBZIKSQlD
         6r3DeDKkNVyT95X34RBf6VEmDzcQTGbWRHDmPbrvpvlEMkg73x+Zy4Y65H3tdeR6AM4D
         i9MQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1795437721; x=1796042521;
        h=content-transfer-encoding:content-type:cc:to:subject:message-id
         :date:from:in-reply-to:references:mime-version:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=zk/zRd/DSWOo4ZU+uiseKdBg5SqPyN64+INmafD407Q=;
        b=n1G/pnbDFGhTVWRQg8Uodw9Eovx3q9oTpN4py6ndnQNz5nIPwg/tACGC5KGVOnM6iF
         jKQwmPEk34vJXZT6oSzEsitadT8kgU4wgMHygwYfuYrmJE7qtLpeiklMcS4qLTvCR8+l
         IDZna+IDPnXVEW8+81mLLgFG1lvy29Qs78FHdlVDxOl55XAYkPG6Vy3JC2s4wxBOkjgE
         wOmI2S2shkFrSeedLaDua0c0BJ7MyjMCfE/1bGt1lK4H8OsrK+X3+aaPlTpBimhDXHxP
         LXiCEpandlPQOFcbIUasFnb86shdSOaIok9Z7auJM+Nh8QsTqHutz3WovEtCi5ixfjef
         sYZQ==
X-Forwarded-Encrypted: i=1; AL+hErFe7l6r6x8ocCXX7URzHYySvyW/5AfzNWcTKARK4uxwzUbV7lHpmS4GobLcfXPg0+CxoYpuNtU=@vger.kernel.org
X-Gm-Message-State: APuU4Z8s3XZI5CXRyXrjLOAsVa8AtDjSSr4aSIKbP+zSmMGCtsRSdV/z
	pNViyNjErwQXb//t1s0ecmINYQ1ag+px5BJIlTzm3ZQMingwRBLzWZCH9yeRZjlXY8eCjuWeeWp
	fd/lDb09Be0UuFesOQvtCiFlVCeLDMQs=
X-Gm-Gg: AZFdTZeRKm1RUuYzUDlDFqg0tgM7XMjXNrA47mqR9Xaoi3TlPUvojC46IsverNFfxzp
	B85Yfh2kLv4OlRa0DxM9MV92g0UrdrRZR2KryiYLGs/WRX+RkZF3gx1aQzu15nf8K5vCKap6CPo
	Aanlqu0ayDZwUlus8EBdvNsji5KmISp/EsMpJkupwkzg2oVLuHh8n3G3C6qYIGZjEY5rWn+VX65
	G+vTdZ9PvB5OBo3OIu5f+edP+V0DIKMIqVvKX3uIsCcEUE3x9c57PuE/wLuxRsayAQZ4Z1LJQr1
	HwfFwgtWIetFQ+fg2Olo5euid4PgeHCH0ZgzKmYDRRn+HvlOw5iOlcmvy8nDyXimXwEH1yco7gt
	7FVIHi3nHFCMX+utu0Zkf0OF72+SJpD+wdEZ5uA==
X-Received: by 2002:a05:6512:3d24:b0:5c1:4c4b:6b68 with SMTP id
 2adb3069b0e04-5c1bc802f62mr3414265e87.31.1795437721087; Mon, 23 Nov 2026
 04:42:01 -0800 (PST)
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Post: <mailto:stable@vger.kernel.org>
List-Help: <mailto:stable+help@vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
List-Owner: <mailto:stable+owner@vger.kernel.org>
Precedence: list
MIME-Version: 1.0
References: <20261120060254.3766851-1-bsdhenrymartin@gmail.com> <20261123062752.27920-1-yanhaishuang@cmss.chinamobile.com>
In-Reply-To: <20261123062752.27920-1-yanhaishuang@cmss.chinamobile.com>
From: henry martin <bsdhenrymartin@gmail.com>
Date: Mon, 23 Nov 2026 20:41:49 +0800
X-Gm-Features: Aa3M54rsv5iRHUZ4GpMcRr3DikcwBbormgnkk3CHb8Xdr0aMtIvQVeT5aCPkttg
Message-ID: <CAEnQdOqAQ12A9NdwTWrgfyUVHMvSua1DLTbWbsmGWGUMMhv_FQ@mail.gmail.com>
Subject: Re: [PATCH net] ip_gre: fix stale header length after erspan version change
To: Haishuang Yan <yanhaishuang@cmss.chinamobile.com>
Cc: dsahern@kernel.org, idosch@nvidia.com, davem@davemloft.net, 
	edumazet@kernel.org, kuba@kernel.org, pabeni@redhat.com, horms@kernel.org, 
	netdev@vger.kernel.org, stable@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

Thanks -- v2 is posted with hlen sampled before
ipgre_newlink_encap_setup(), so the delta is now correct:

https://lore.kernel.org/netdev/20261123123529.3183627-1-bsdhenrymartin@gmai=
l.com/

Henry

Haishuang Yan <yanhaishuang@cmss.chinamobile.com> =E4=BA=8E2026=E5=B9=B411=
=E6=9C=8823=E6=97=A5=E5=91=A8=E4=B8=80 14:28=E5=86=99=E9=81=93=EF=BC=9A
>
> On Fri, Nov 20, 2026 at 02:02:54PM +0800, Henry Martin wrote:
> > +     if (data && data[IFLA_GRE_ERSPAN_VER]) {
> > +             int len =3D t->hlen;
>
> The bug is real (on 0 -> 1 the GRE sequence number even overwrites the
> GRE base header), and the patch fixes the packets. But t->hlen has
> already been reset to tun_hlen + encap_hlen by ipgre_newlink_encap_setup(=
),
> so the delta is wrong. iproute2 always sends IFLA_GRE_ERSPAN_VER, so
> each "ip link set erspan1 type erspan ttl N" on a ver 1 device lowers
> the MTU by 8 (1450, 1442, 1434, ...) and raises needed_headroom by 8.
>
> Saving t->hlen before ipgre_newlink_encap_setup() and always
> recomputing it fixes that in my tests:
>
>         erspan_calc_hlen(dev);
>         hlen =3D t->hlen - hlen;
>         if (hlen) {
>                 dev->needed_headroom +=3D hlen;
>                 if (!tb[IFLA_MTU])
>                         WRITE_ONCE(dev->mtu, max_t(int, dev->mtu - hlen, =
68));
>         }
>
>
