Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=209.85.216.47
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1793843116;
	b=myXet/BR+0+zSJcfmUH8C0ZFj3QhU8394Cl6q+ORn/sKQVe36c7zRB5i2TFCa74dI9Ch
	 wFiE08KK1m9GUNr0YwZJAA45hOMH7ytT5UgHHxm5i9+1tEIP/VNcDIwn4i9FH2KzCXj8o
	 fwS7IL5zAxmVh4eOghjU4olRoFKjPGempLftIcGUkervo5YYcXPlePTbb3uYTf88erjP4
	 IdmbVucf4KxP+QdEjz+NNDJuKb8c/861GYVl/RpxLZubRXXz9V11ImP+IfBONM8F2j2BS
	 Gz6cYymQVVXBcYTAAhJvHiSUgKtZcZPE2i7IxCIWC+Wgj9QnmE2JHeac2CNpOGxMeNg==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1793843116;
	h=DMARC-Filter:Received:DKIM-Signature:X-Google-DKIM-Signature:
	 X-Forwarded-Encrypted:X-Gm-Message-State:X-Gm-Gg:X-Received:Received:
	 Message-ID:Date:MIME-Version:User-Agent:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type:Content-Transfer-Encoding;
	bh=aw1j/DMSrkeRfjbyviCP/rue4/RfxPKGIkftd8fC4p8=;
	b=S5i5EnxaxK7Ro20a8hiEOSlRHofpfsmfpch7yjXYKkUUkkRYTTyBri+l2vkbyW8gglLd
	 9wmXxx63vCdLvzqemRBK7B5wKuRw3fsYHr5iKjmeS1pGtsXpOfYyV7lodYDJEu4gPtqgx
	 lAXNbysKGaSCZLsSFSwUOcb8oRzjrGXhvFfY3gznhyCBdfnnWeaudNUxGP+ciNag+1/zn
	 pQuwozhZp8kSCXAxLxxlT8SgWejOfQ+RxFYG2dcHuKTQijR/PNrYJUTfL41vYs8+1zOeN
	 bXPOs1Pk6XY2O2LR+W+Xgm6wYtmKDbXezRzQzFZjM5RWbky9JhCKxPDBb9xAGy4bm+w==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=gmail.com;
	spf=pass smtp.mailfrom=gmail.com;
	dkim=pass header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20260707 header.b=bBAZvD7X;
	arc=none smtp.remote-ip=209.85.216.47
Received: from mail-pj1-f47.google.com (mail-pj1-f47.google.com [209.85.216.47])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7AF39606A328
	for <stable@vger.kernel.org>; Thu,  5 Nov 2026 01:45:16 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 7AF39606A328
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20260707 header.b=bBAZvD7X
Received: by mail-pj1-f47.google.com with SMTP id 98e67ed59e1d1-3adc4590de4so1187003a91.2
        for <stable@vger.kernel.org>; Wed, 04 Nov 2026 17:45:16 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20260707; t=1793843116; x=1794447916; darn=vger.kernel.org;
        h=content-transfer-encoding:content-type:in-reply-to:from:references
         :cc:to:subject:user-agent:mime-version:date:message-id:from:to:cc
         :subject:date:message-id:reply-to:content-type;
        bh=aw1j/DMSrkeRfjbyviCP/rue4/RfxPKGIkftd8fC4p8=;
        b=bBAZvD7X2qxqnVxmX3qR10bvg/TMHOASdti/3z/WlQubvrJcW/AVlrGVDFL7ny89QK
         wJHOC/gKEtr9M40oqv3wqysmzIa7sTBr7W6O6z2fnCq0gvanT+rDqZ+R1GkgnaYN0plw
         7iwahSPNtBUhXQw31Zw7Uk7jziiutQy/ol+W2fa+vJovbbsGLfY34D5JjIcYLoeWRgDO
         VepUNrFj2ceP6iZ5dLKpk5ssyrO6pLAS/lJXTPFQkZuth3+WOyBDS66aJ5U0oK+PQi8x
         wQQPSSZBHEtl+75Wn/h/ugqAV5cGd2blf6pVevC4FFtFwFN9UDyyKEf9ybcoLOtvWJ7n
         89tQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1793843116; x=1794447916;
        h=content-transfer-encoding:content-type:in-reply-to:from:references
         :cc:to:subject:user-agent:mime-version:date:message-id:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=aw1j/DMSrkeRfjbyviCP/rue4/RfxPKGIkftd8fC4p8=;
        b=bzV5gxuvPPnDj1m5gka8B0Mm09EQZl3d/d0GzTN0cm3IsKlpcQ2DnjXwO8GCLs/p0U
         N3ElXiSsr0TdwYiB1l9UhDav/iIqOxywUmoFjwD9185+MWjgpkT2JIXE7QWvqXnuUg3b
         hizruI8sZO50pTxh+/uwPnzchk7ovkww2rM3dd9QsgI+TWT3r2QCaBF5/PYuwaVfcww2
         HUtlDdgnvB594a/uQ6uME2D9elrACYdsBa/ODqbU6wlPM8THYrpIX0veiJ6Pg0gSqsCJ
         QusMrytWO26SoqEjSlhGW+pgUabdhx+XT73fspR3/g+9i5B9dWJGeMQg3mhHbPTMmGz9
         lAeg==
X-Forwarded-Encrypted: i=1; AKwUvByVY59Zcbinft7OdX+WWQ/xVYCKML85ZS5cfUtJEyC1Tv50H5tLh2aEaSMT2r9Ara9laotJoGo=@vger.kernel.org
X-Gm-Message-State: APuU4Z8yJtTjFJT3mV15RsLpGJQqJz4hTtYSYS+z7o40ytFjVLo6dRhT
	D5L6LFASw5zY/MOR2JPvaEU0MyiIAJjkG6g4/GeSeww2krjMscaZqspN
X-Gm-Gg: AYBFou0Zz8IhxRvKHKLVs61v42xmcJFpxM/Ai4W+oZ4UU2NI5LwOAN54FE1ZMoBAmoB
	1mIpR4PRL5Ul2WgAnFsdGK+IDKEB4PRafHbcAVu2BqcVWnchK9Agf8FdsDxpkVQ5izuuFBV6VQ+
	Qc26Ean1XeCyeeUhBALGck7KXTmB6Taz/hHfnysL8sD3TNZpnVM+M45DSvr+QhQjKFhVBexpuWA
	S9/WE+WelaSxzdmQoLvSOO1axTZmvqp52ogX5q1890keag5OPP3IxfyTladag4wNwTOKFQkmein
	Uba7b5ALTRQuHKgvrWoaVBDHhTavABIkqg1gHANuyq+grqSizlBp9W2igfROjP/2q7h9Ozr96aL
	Mq/gYulTTbd3a7fMOajIkhTFeQ+v/xuXGQrWbdiYsaCkwkMaHcmmlocOPDjdInGa6Tfi3oClwsc
	NBCXn6DQElYas0m607zIWsHp1CCF2Oe4AkoixzKFAhSqeJeToJqvjFRnFuwr5Pbq/CMcMKMthKx
	0oQ3n7UV5gybJNjR+8biwFXiZIqBOtcVOAXAOQOtYeRdf3AEHeVhDtgs15+yoUi1mMZ/BsHTeEA
	yppJoRUPbjIwVTAw5CkOXTlSrqnrL7DfgUpx49UWGNyYXLkdoY5YgV8CzCYeo+EmTFdCf8TjOvA
	QyCADLWs35VdtJBfnbFa0eS4yfg==
X-Received: by 2002:a17:90b:2f08:b0:3ad:50a2:9abf with SMTP id 98e67ed59e1d1-3ae89835db3mr14659660a91.38.1793843115728;
        Wed, 04 Nov 2026 17:45:15 -0800 (PST)
Received: from [192.168.52.49] (ec2-13-158-86-59.ap-northeast-1.compute.amazonaws.com. [13.158.86.59])
        by smtp.gmail.com with ESMTPSA id 98e67ed59e1d1-3b0b3131f8csm1307297a91.2.2026.11.04.17.45.12
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Wed, 04 Nov 2026 17:45:15 -0800 (PST)
Message-ID: <0ee661a9-b642-424f-99a1-21c9731c53aa@gmail.com>
Date: Thu, 5 Nov 2026 09:45:10 +0800
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
Subject: Re: [PATCH] mm/damon/core: reject empty access pattern intervals on
 scheme commit
To: SJ Park <sj@kernel.org>
Cc: jm5905938@gmail.com, akpm@linux-foundation.org, david@kernel.org,
 ljs@kernel.org, error27@gmail.com, damon@lists.linux.dev,
 linux-mm@kvack.org, linux-kernel@vger.kernel.org, stable@vger.kernel.org,
 "Liam R. Howlett" <liam@infradead.org>, Michal Hocko <mhocko@suse.com>,
 Mike Rapoport <rppt@kernel.org>, Suren Baghdasaryan <surenb@google.com>,
 Vlastimil Babka <vbabka@kernel.org>
References: <20261105013653.88123-1-sj@kernel.org>
From: Wang Xiaolei <xiaoleiwangxiaolei@gmail.com>
In-Reply-To: <20261105013653.88123-1-sj@kernel.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit


在 2026/11/5 9:36, SJ Park 写道:
> On Wed, 4 Nov 2026 09:17:24 +0800 Wang Xiaolei <xiaoleiwangxiaolei@gmail.com> wrote:
>
>> Hi SeongJae and Aveline
>>
>>    Thank you both for the careful review.
>>
>> I appreciate the clarification that DAMON simply executes what
>>
>>    the user configured, and that this is more of an input validation
>>
>> improvement than a bug fix. Perhaps I was too aggressive in framing
>>
>> it as a bug.
> Thank you for clarifying.  But my point is that this change might be just
> unnecessary behavior change rather than an improvement.  What do you think?
Hi SeongJae

Thank you again for the clear explanation.

I agree with you . My earlier framing was wrong;

I won't push this patch further. Let me focus on the

other items that are genuine bugs instead.

thanks

xiaolei

>
>
> Thanks,
> SJ
>
> [...]
