Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=148.163.135.74
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1793548490;
	b=1PVsKmVbajLjOcFm03kwc7aYLJaI0qrRMITJdrb54bZVxpt5vy3tubaXeglDTYm8fGz5
	 ZjpUYs5Fk7eC6CRDfcaezrmBS4ZNGOd+NkoZLidUJmY3b6aynYFui19Lm4dgwXnmOuD/i
	 q8wM1OF0FwFTtPK0CUEjVWl7uytQppzfdZix92v1EomQjk6B6SFLzsoiqdYiTd9cG7qFG
	 npmmyriMf5fam/v2iX2oS7hOnhFyM1baPo5qARmJFoDQ52LoF5zsJeVhiNqlcKO20Rmmk
	 6d29y5E3vdkalCVsYR3MasYbf4gNFt6y4v0iM9f1JfiIP47PX5F2jIxwl4qpo84bqPQ==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1793548490;
	h=DMARC-Filter:Received:DKIM-Signature:Received:Received:
	 DKIM-Signature:X-Google-DKIM-Signature:X-Forwarded-Encrypted:
	 X-Gm-Message-State:X-Gm-Gg:X-Received:X-Received:Received:Message-ID:
	 Date:MIME-Version:User-Agent:Subject:To:Cc:References:
	 Content-Language:From:In-Reply-To:Content-Type:
	 Content-Transfer-Encoding:X-Proofpoint-Spam-Info:
	 X-Proofpoint-ORIG-GUID:X-Authority-Analysis:X-Proofpoint-GUID:
	 X-Proofpoint-Spam-Details-Enc:X-Proofpoint-Virus-Version:
	 X-Proofpoint-Spam-Details;
	bh=ESraT188hHqeA/eG2HAU4aWg3ncS/DlKucSFgZXYCzQ=;
	b=bJUOewKnx/ygxd4X6SwkPJdczxgxYaBzdag9t9bbXt2cvNMVVl4FKxFhcPRdDFelcDAl
	 c2TEnVuClLR/3wrr4hlqQixRRGHeI02bgCBSRxvYuMoJhNqYJyTqEzO2UdY1vEHbQWG3L
	 C9HAJepy+kfL0geS9mhjZ6QRrb+TifTAPqwlJE056Eoa9Dqs56eG2lw8jRbpiTYsJsIsO
	 4Z3ODuS4LqIpMpBwh0EBdfxVVFMHvbiKDc3cmu/7K00bl+Nc3RmEXGUuxGNLmkvguBTMz
	 RsaCdpHhh5wxweOprCEnIXPeu96t0qhJTL68Gr5IC+dzREnGY8DsuKPlvoejgPyyHSg==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=columbia.edu;
	spf=pass smtp.mailfrom=columbia.edu;
	dkim=pass header.d=columbia.edu header.i=@columbia.edu header.a=rsa-sha256 header.s=pps01 header.b="P/K5G4Mq";
	dkim=pass header.d=columbia.edu header.i=@columbia.edu header.a=rsa-sha256 header.s=lionmail header.b=uYDYlGG8;
	arc=none smtp.remote-ip=148.163.135.74
Received: from mx0a-00364e01.pphosted.com (mx0a-00364e01.pphosted.com [148.163.135.74])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id ACEDB606A324
	for <stable@vger.kernel.org>; Sun,  1 Nov 2026 15:54:49 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org ACEDB606A324
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=columbia.edu
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=columbia.edu
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=columbia.edu header.i=@columbia.edu header.a=rsa-sha256 header.s=pps01 header.b=P/K5G4Mq;
	dkim=pass (2048-bit key, unprotected) header.d=columbia.edu header.i=@columbia.edu header.a=rsa-sha256 header.s=lionmail header.b=uYDYlGG8
Received: from pps.filterd (m0499199.ppops.net [127.0.0.1])
	by mx0a-00364e01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 6A1DVvsB2338499
	for <stable@vger.kernel.org>; Sun, 1 Nov 2026 10:54:49 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=columbia.edu; h=
	cc:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=pps01; bh=ESra
	T188hHqeA/eG2HAU4aWg3ncS/DlKucSFgZXYCzQ=; b=P/K5G4MqEuZj9+6+RC9s
	jnCwKpynXG5iiq0cGPCeDjgJ54gVhUu9AfrGHD3HwtbCoiAcHToOPbuUz6LWJFTD
	9FIjOEFgB1+fgFZtNSTc7RfNrR356rGOgHrSdZ5vT3vLxkmoIN4eS/27VThq0Rf6
	JEbNc+8tuvdUQaAUoabBGaZX4w46BM1trPb+2QQYS2fnJHoorpvX84dR2zD3OLIn
	l/KRnqYFddnkjJIrglo5U85zxeVyyANYOOiEaj+ILTcfJAqqNNkDRY6eqHecnujN
	nItLYO7BXQ/j3zV0DNPBftKyL8rj+nSO32tYdtaDouydEVQI6wJwko6Sm2dfMGbh
	Gw==
Received: from mail-qt1-f198.google.com (mail-qt1-f198.google.com [209.85.160.198])
	by mx0a-00364e01.pphosted.com (PPS) with ESMTPS id 4hnxrrt3t8-1
	(version=TLSv1.3 cipher=TLS_AES_128_GCM_SHA256 bits=128 verify=NOT)
	for <stable@vger.kernel.org>; Sun, 01 Nov 2026 10:54:48 -0500 (EST)
Received: by mail-qt1-f198.google.com with SMTP id d75a77b69052e-533928ef33aso28346531cf.1
        for <stable@vger.kernel.org>; Sun, 01 Nov 2026 07:54:48 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=columbia.edu; s=lionmail; t=1793548488; x=1794153288; darn=vger.kernel.org;
        h=content-transfer-encoding:content-type:in-reply-to:from
         :content-language:references:cc:to:subject:user-agent:mime-version
         :date:message-id:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=ESraT188hHqeA/eG2HAU4aWg3ncS/DlKucSFgZXYCzQ=;
        b=uYDYlGG8d/0I6GlyEkyukBYsbOH6CXVC2ZY3iC3EnzdyNYjyc/+kuRT47u29ku7Rvs
         5ES6/SmPMC3MfNT2XKagvqkiBHwxvoov6x4nWXpvjLKonHVkSstt2qBGnZ5gzJGcDjyS
         3vw3LJS7s0qQ5zDC/0XMrjV49TfZu8QH7Doqd4R0hVQH+h7rGjdYxtSJn+T6pVISt+Ar
         tY9flTKjgbe4xgvYnH2p3RL7asolYnpTL4O1wsanqJHkf5SV59MoUSlgieSS154nFqtQ
         60H+aNH3j7rUj2Lc+IN5JdSj2uIkggM6XwK7ooymh7tyHsTK0sCE3eTPRytTYJswpnit
         suCg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1793548488; x=1794153288;
        h=content-transfer-encoding:content-type:in-reply-to:from
         :content-language:references:cc:to:subject:user-agent:mime-version
         :date:message-id:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=ESraT188hHqeA/eG2HAU4aWg3ncS/DlKucSFgZXYCzQ=;
        b=kGl7fGxQ9fAJ5GshO0I5Wc7/Pr5ubq3cUV2YKeaeiaXtIrdNlnuSEPYA64lOBsS71a
         WzxaTZ+jCXuVCMP/PYxPmU3gPaA205jNy3VZYyH407J5FLivO+6sRO2glACVtr1jKzG7
         bst/P20wdzX2ECkHb0w0PQiv/SsLcgzT6UDcr4/f56yol60l3PyzzOA7OkXyrqD5ZYBG
         dMKownoKvXejPRqaUfff1AmCHb+QIwSpbrSpZrzslQ7teM3f1T6uDui6YlUl1yVTxMkw
         1u0jo0UPEqTbPxAR/N5B8XfjnpWzvPsbjVyfl2zCYpqq5PYrtbIQppkdMUC7Vsi13BPX
         GwCA==
X-Forwarded-Encrypted: i=1; AKwUvBz54oIxWOfohulOKKVB1oO0lhemoCWo1xZsunKFiCiM6nYSrbClQvrLyKmrZVFkSQuWBl5FCcc=@vger.kernel.org
X-Gm-Message-State: AFq9FYKktsTZrP39oaHWfRyFzeTt6dLX8zspHkmoXcWhx6nkwQTFr/0R
	PxxTmC9gkz/v0eEm/qRhwxs3m17346b5dNQqXsa3BYYKbbeDIijKPvTDAzx3xU3pwd7Yjfm5CbH
	tsgFi+zOQfTVGk5ph6ub8Wzpwq17dlGN0Qc/H74wFrsC/ZsjBkuybhw==
X-Gm-Gg: AYBFou1z9NCF05rLNWMdCwcXbFtyYWdbXb17Q0kKqUWyUbhFJdq+2sW9uaOr1Ir+ToC
	coGLpR9gs4kaFg3oUfdmfuotcVo/uWgbvBeXaVifKAnfOBI1Ys98wWwkxDBUv8KjkefrzhH9XUr
	6/b0lbwMZdMUKz6nAoF2MPw0zhZBLNix0ciR6zSzMBKxsYNWyJfKH/aIGAsmU9a3BX2/P2qRluq
	289Hcc1gzFXeP6Fq5vAPXoQ11YfBHIuD73W7tCOmqM5DDxhj0amI5IAEpGbeFgssTorjL496uIS
	7RCDAjsnLVcaxWQqIUUAcC4hlgq2Kots5GynsiPb1jz91kby/3VBNBzB5IdpJCg6EK1gr8BIbsM
	92TjLb6sTXTnuKGezVftRwgTHayYfJ4mvpypTKtt3pX49jE6OGexGaFrLqe5cXh0oZ2gyLcpDqR
	6ih5M62jAg7t/CW3mfQkFR4Et+gb+a7Fqa+8LWNbxI9olDtiehS2QcHNxPo80m4ulZDuSbAZtT1
	a3hLAEQ5SLoLErtexqxQ8bDZV81vMMUyTdnTCIY+WorvAi7XFIjc0fw2vuVahBDsmJWKwBBkqFT
	Hy4rIIBukz9qZ80VJ4Q=
X-Received: by 2002:a05:622a:649:b0:536:6946:748c with SMTP id d75a77b69052e-542b771ed82mr132792361cf.53.1793548487888;
        Sun, 01 Nov 2026 07:54:47 -0800 (PST)
X-Received: by 2002:a05:622a:649:b0:536:6946:748c with SMTP id d75a77b69052e-542b771ed82mr132791951cf.53.1793548487394;
        Sun, 01 Nov 2026 07:54:47 -0800 (PST)
Received: from [192.168.1.187] (ool-18e492e0.dyn.optonline.net. [24.228.146.224])
        by smtp.gmail.com with ESMTPSA id d75a77b69052e-54311f75fd7sm63339941cf.11.2026.11.01.07.54.46
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Sun, 01 Nov 2026 07:54:47 -0800 (PST)
Message-ID: <b12ae064-012d-44b9-9d27-461e4af83f3f@columbia.edu>
Date: Sun, 1 Nov 2026 10:54:46 -0500
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
Subject: Re: [PATCH] mm/swapfile: drop a large unmapped swap-in folio in
 unuse_pte()
To: Kairui Song <ryncsn@gmail.com>, Andrew Morton <akpm@linux-foundation.org>
Cc: Chris Li <chrisl@kernel.org>, Kemeng Shi <shikemeng@huaweicloud.com>,
        Nhat Pham <nphamcs@gmail.com>, Baoquan He <baoquan.he@linux.dev>,
        Barry Song <baohua@kernel.org>, Youngjun Park <youngjun.park@lge.com>,
        David Hildenbrand <david@kernel.org>, linux-mm@kvack.org,
        linux-kernel@vger.kernel.org, tz2294@columbia.edu,
        stable@vger.kernel.org
References: <20261030-swapin-large-unmapped-v1-1-41e4ae378e6c@columbia.edu>
 <20261030155419.b10056c8fb37bc784b0d2778@linux-foundation.org>
 <CAMgjq7AUvsHVKkHmLzL-KKf+MBed6e4TeVP7jcGMLM22xO+=5g@mail.gmail.com>
Content-Language: en-US
From: Mani Tofigh <mt4022@columbia.edu>
In-Reply-To: <CAMgjq7AUvsHVKkHmLzL-KKf+MBed6e4TeVP7jcGMLM22xO+=5g@mail.gmail.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-Proofpoint-Spam-Info: AW1haW4tMjYxMTAxMDA2MyBTYWx0ZWRfX//Rr8lStsX5v
 I6xu5KeH7qtBuXhMp3GG65MNVhupdwucyfMJ+KsnLmH/9zhHO1JB0XkN3vfiOZaPuzl5jwGnYgA
 P3dshlZTYhBDv0okc4bpVv7GnTzwYOEppNcCv8xsol2p7ZLwZqQL
X-Proofpoint-ORIG-GUID: MQiiUkwt_zvpqjfSM4Dfb8rTxwL1D8Xt
X-Authority-Analysis: v=2.4 cv=HYaB3SE8 c=1 sm=1 tr=0 ts=6ae760c8 cx=c_pps
 a=mPf7EqFMSY9/WdsSgAYMbA==:117 a=FE+fbgsriwsnvVT5CFHM3g==:17
 a=IkcTkHD0fZMA:10 a=zJRp6_cAMcgA:10 a=x7bEGLp0ZPQA:10 a=A0y_DWxS2BwA:10
 a=VkNPw1HP01LnGYTKEx00:22 a=Da8U98TiO7q1upZEImrf:22 a=G--0XuH5328wxK7v7Suf:22
 a=Z4Rwk6OoAAAA:8 a=CbAtmpW2TtMjExKzJAEA:9 a=3ZKOabzyN94A:10 a=QEXdDO2ut3YA:10
 a=dawVfQjAaf238kedN5IG:22 a=HkZW87K1Qel5hWWM3VKY:22
X-Proofpoint-GUID: MQiiUkwt_zvpqjfSM4Dfb8rTxwL1D8Xt
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYxMTAxMDA2MyBTYWx0ZWRfX4IRLXpeCknuH
 ZsmBiFan/SKl+5DCg1DAd/P3a/eZLtzOYve5kj7MGlEMeYe5iDEY3Ubzv2WQ0Nr5R3lwlHFN6OJ
 2T2ONnC08nCScblhnswwmsUSVlLiv02OInadZ1angj4gr3HO6tDZ0wKb/sdHmKn+ujbGtMlf68T
 bqF62UtVNL0qlLm3P3dG1ZjeukliSGzIRlpsWvWfb+GB6CEl5clW6QYEf1xyFsLPh0Zg1iWtjYM
 Y1wS3AEqDKDjJEBv+zEZX2GdP0Su5jObZJIvVtAyHh5rP/5ERV0Dzn22XBmB6qfQDy8ZzB3G+0k
 zo3h9TqB63Kfs+whjYDWL4hXLQZ4991NRtFr/xENxad8ViByNeF0RRtceitPLMvy7Am8/hZhOuF
 qfxSHuEJOknni6e4WB+rFQou12THArjBsmHMm5+kTSTzKsffjtK3uPFkRj19KK4YpTwZkiuA2fE
 QVCw7gkLJ5Yt7FgjoBg==
X-Proofpoint-Virus-Version: vendor=nai engine=6900 definitions=11953
 signatures=596817
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 priorityscore=1501 lowpriorityscore=10 adultscore=0 bulkscore=10
 impostorscore=10 phishscore=0 spamscore=0 suspectscore=0 malwarescore=0
 clxscore=1015 classifier=typeunknown authscore=0 authtc= authcc=
 route=outbound adjust=0 reason=mlx scancount=1 engine=8.22.0-2610300000
 definitions=main-2611010063

On 10/31/26 1:54 AM, Kairui Song wrote:
> On Sat, Oct 31, 2026 at 6:54 AM Andrew Morton <akpm@linux-foundation.org> wrote:
>> Also, won't this change cause try_to_unuse() to keep spinning away until
>> someone kills it?  Might be better to return -EBUSY and fail the
>> swapoff?
> 
> It seems fine? The folio is removed from the swap cache, so the next pass
> will go on. But you're right about the dirty and WARN case, it spins, so
> maybe:
> 
>     if (unlikely(folio_test_large(folio) && !folio_test_anon(folio))) {
>        if (WARN_ON_ONCE(folio_test_dirty(folio)))
>           return -EBUSY;
>        swap_cache_del_folio(folio);
>        return 0;
>     }


Right, in the normal case the next pass of try_to_unuse() just swaps the
entry in as a small folio, so only the dirty case would spin.

David suggested a VM_WARN_ON_ONCE() since a dirty folio here would mean
a bug elsewhere, so for v2 I'm thinking of combining the two.  It'd be
a VM_WARN_ON_ONCE() for the dirty case, and the folio stays in the swap
cache with -EBUSY returned.

Thanks for taking a look!

Mani


