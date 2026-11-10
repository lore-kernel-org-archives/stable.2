Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=209.85.217.52
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1794278036;
	b=kSB4T7ImUsqeHll//HFTm6KG72kk7D7CvjCUE/XERWy27HuqSqrlGU221b5eToTYmN3c
	 LIc7gpbpboV+xVmqqkjIwYQ4TG2RAZx1q121pMGavgcVSeM4zs1q5rOt2SZRfnm5HZyvp
	 giQS7y+s3fejz6sW4co1sKewTnSPX/Dv1RloBsOynsf4547WiqEUr1taPOlMZwMnneD2K
	 0vZ1iaQOKW+MUyAJVHdwuXTLFEtlj/Xg2EEWF9cs9odogWKtqM3GAnPeRSKjcg8Bq/uIg
	 zpN0IDPenNkg2XbIhMUcPOaeirqVIcosicE2UowVLfLcHRVY7oSq8pzAhkgAqOXfBuw==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1794278036;
	h=DMARC-Filter:Received:DKIM-Signature:X-Google-DKIM-Signature:
	 X-Forwarded-Encrypted:X-Gm-Message-State:X-Gm-Gg:X-Received:Received:
	 Date:From:To:Cc:Message-ID:In-Reply-To:References:Subject:
	 MIME-Version:Content-Type:Content-Transfer-Encoding;
	bh=onDRaLguTUW2a83jMl1YZiAlaHNlpOxn5ahgZIssCS4=;
	b=utOuXjFTIfZpP08ujMsc/OzCmyfWDXL/lHdo7aZfoITQkTPf5vB7S7IIzT0b3vSd0X8e
	 vj5OwbWUmlz2ZUdrw9vDMhw54ajRp1KwEJ8Pt2KwjVWE/G/gaN/nBrJIcIDPG/wbVEo7d
	 k11G+HtRwh5N4m+sAD+HeLzM6e7/XCmtyohHYce/3e2tney8VPBHbmJzqs4QYzqWhfpLt
	 2Ytd1CVmezOoiTLarvBgA6GJRRySFCoGWSrh+haC/lmt3psatfojYlRFO+1Jb/7xD4das
	 BjvTEw/nclavFiUNTnDwO9s/SyZaN7inNtNOzHH5a4TK7h3iLM8/jjieDpVTj6ghZOw==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=gmail.com;
	spf=pass smtp.mailfrom=gmail.com;
	dkim=pass header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20260707 header.b=G1obDVAS;
	arc=none smtp.remote-ip=209.85.217.52
Received: from mail-vs1-f52.google.com (mail-vs1-f52.google.com [209.85.217.52])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8295E606A331
	for <stable@vger.kernel.org>; Tue, 10 Nov 2026 02:33:56 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 8295E606A331
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20260707 header.b=G1obDVAS
Received: by mail-vs1-f52.google.com with SMTP id ada2fe7eead31-7cc1cf48a39so579502137.1
        for <stable@vger.kernel.org>; Mon, 09 Nov 2026 18:33:56 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20260707; t=1794278035; x=1794882835; darn=vger.kernel.org;
        h=content-transfer-encoding:content-type:mime-version:subject
         :references:in-reply-to:message-id:cc:to:from:date:from:to:cc
         :subject:date:message-id:reply-to:content-type;
        bh=onDRaLguTUW2a83jMl1YZiAlaHNlpOxn5ahgZIssCS4=;
        b=G1obDVASqefxB6poYdjSmxCFHjae9eYxJSNGGnlEYlbaEUEJivW7JDtmuGERQcgQmN
         jLQt9g2DSx1yyia37PP/ykKwYVfjHoNMpAsBsWcx1xnqRLrrH9i6dHgRXVgwLRphQ3mg
         Y6aMvkPKSa0PJn/FT/cPJaxDossiDDXv6D6d/28oQy6ndp/q9nQBiOQYer/iTR21B9JE
         Xr+gk/exekmfyJoJTVs6SVqVjtObZYwFB8IzkdhjCRTYi9wYeI0qdVL1DDvdM8XQyPki
         oglumqrNc6J2a2pRN8Z7kaLNm6XEJZwSAv7/NPRMsrQ1PX8GwtTNfs5q91PjawEY7Mxj
         2T+A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1794278035; x=1794882835;
        h=content-transfer-encoding:content-type:mime-version:subject
         :references:in-reply-to:message-id:cc:to:from:date:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=onDRaLguTUW2a83jMl1YZiAlaHNlpOxn5ahgZIssCS4=;
        b=q/6GCSKszYYT86ahHz/BT3KVBSq9prG68h1XTwZglC4EBiRxPzsJe5GORWy9EW9Nk3
         lInQdi4cru+uioi3Rc2aL3fc+oPQy5yS3hf+0ejt3uEMy8qJ1S5fgc12HxKaS8krvr5A
         XGj8d9HQftK6edh4jqrL3EhGNv+6otFLWkp4HvT8yJsnktPW7+IO2LdIxTCYqoEr8vK1
         pLyQR9Lv54sfXtk1+pXgZKeTUHBLCTlJcAe+P+LUTFznVzbGPVNiuBhBJzwRqbJVSAQk
         IVuA7D2US65LvxcC15iXp/GFhNftLV3Ybi/ztpsSLrnKCsNyp3d+YkQ+YxqwYQZeRqlw
         tfjw==
X-Forwarded-Encrypted: i=1; AL+hErFfPQOAS/fJzjojBsaEmMdzc5nouKXfWyGPDTgA7xwUF77zxj7CBA5pS+tmp4zfXJ1GDnZ5KRk=@vger.kernel.org
X-Gm-Message-State: APuU4Z+DTvJRX6U2OfWyNmf+OQ2CuDJN9SwNEy13xNFWdUbMjr//7HQ3
	wvflMM4QcJ9Xi2CLC1/I6asXWq8H813bzXKK3ebYZzvlk3e1mP6sM4eL
X-Gm-Gg: AYBFou07dlO5A2CzpIAUKRSa/Gj7jQ+poCZ0f+6zFkmTanFwogQNZ18ijq+wtu/FRU8
	FNJF3tsQHvOYeM9aKO8z/m4DuJEGidA87ATBHPCdzHdTZIu2a1RlCcUy5JGpemxAUsQ9bdNkSiB
	MWM9Oz1s5tdKESF+l62tiBAo5QDD1fz0WzaApqKtJGP2SgxormETRcwcYhYgFG/68nK26FDbaPz
	LoHx7yA4KS0SQhNEfr0R11CzwSOkpnu6k1cEJ3k+/1WG0x974DUUS2l9Jt1HUHFac29zDnV+hOt
	N0usK9+SfpseVtXYa932CWNv67Z/b72GGSGGfVtNTLMs44vSyl7oiVL3fGOXpAl1gZghUJ7iEIS
	9jlfZcnpwy1xS/sQkSOZuM6jzJrdMOv/t7lDkZInrGSYO+7ulBw+jt7lIj3ZjAR9X2LhHVIhjF6
	xXWaayO2IIkUxhQDI65dSiOay4HPVsvmv9VIB4kzAVtMDaGuw2t1BetWG61mjsQXylqgGiPhX8C
	5SUdasHulvZnLbJbmsQjl4c/myDTkcM3xqnzhoLA/ZM30cqhuTeJWMqZhavDL6jrqd1mrAfGhC8
	DXvyUlQIJEcYUlp3t1/8qlmOnfq3M/IChWg7hTUY5nHLDoCWbiJSZ2haSch4qCSQiwEoOTN3dpl
	4JU3nCMdYHee4V8BEbFpNfk0fy41Blrgu8Od7AUHdzriDSxVgnpvKOAzanuZANYGbpmrBV8Q=
X-Received: by 2002:a05:6102:2912:b0:7d2:7c63:5a0a with SMTP id ada2fe7eead31-7d301bcae2cmr373574137.23.1794278035436;
        Mon, 09 Nov 2026 18:33:55 -0800 (PST)
Received: from gmail.com (223.230.150.34.bc.googleusercontent.com. [34.150.230.223])
        by smtp.gmail.com with ESMTPSA id ada2fe7eead31-7d302359221sm877564137.6.2026.11.09.18.33.54
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 09 Nov 2026 18:33:54 -0800 (PST)
Date: Mon, 09 Nov 2026 21:33:54 -0500
From: Willem de Bruijn <willemdebruijn.kernel@gmail.com>
To: Xia Yan <yanxia@cmss.chinamobile.com>, 
 netdev@vger.kernel.org
Cc: dsahern@kernel.org, 
 idosch@nvidia.com, 
 davem@davemloft.net, 
 edumazet@kernel.org, 
 kuba@kernel.org, 
 pabeni@redhat.com, 
 horms@kernel.org, 
 willemdebruijn.kernel@gmail.com, 
 linux-kernel@vger.kernel.org, 
 stable@vger.kernel.org, 
 yana06070@163.com, 
 shuah@kernel.org, 
 linux-kselftest@vger.kernel.org, 
 willemb@google.com, 
 tpluszz77@gmail.com
Message-ID: <willemdebruijn.kernel.136b3b685931d@gmail.com>
In-Reply-To: <20261109014400.9025-1-yanxia@cmss.chinamobile.com>
References: <20261109014400.9025-1-yanxia@cmss.chinamobile.com>
Subject: Re: [PATCH net v3 1/2] ipv6: fix cached route reuse for control
 messages
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Post: <mailto:stable@vger.kernel.org>
List-Help: <mailto:stable+help@vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
List-Owner: <mailto:stable+owner@vger.kernel.org>
Precedence: list
MIME-Version: 1.0
Content-Type: text/plain;
 charset=utf-8
Content-Transfer-Encoding: 7bit

Xia Yan wrote:
> A connected IPv6 UDP or ping socket can reuse its cached route when an
> SO_MARK cmsg requests another mark. A packet can then bypass a prohibit
> rule instead of failing with EACCES.
> 
> ip6_sk_dst_lookup_flow() reads the cache even when connected is false.
> UDP clears connected after parsing IP or socket control messages. Ping
> always passes false.
> 
> Only read the cache when connected is true. Ordinary connected UDP
> sends keep using the cache. Ping sends do a fresh lookup.
> 
> Found during code review of IPv6 UDP route caching. On UML, the same
> connected-socket selftest fails four IPv6 cases before the fix and
> passes all 54 with it.
> 
> Fixes: c6af0c227a22 ("ip: support SO_MARK cmsg")
> Suggested-by: Willem de Bruijn <willemdebruijn.kernel@gmail.com>
> Link: https://lore.kernel.org/netdev/willemdebruijn.kernel.1e0038bcc3ef8@gmail.com/
> Cc: stable@vger.kernel.org
> Signed-off-by: Xia Yan <yanxia@cmss.chinamobile.com>

Reviewed-by: Willem de Bruijn <willemb@google.com>
