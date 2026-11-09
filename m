Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=209.85.128.42
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1794230312;
	b=Bnn105i3OA0aitZGYNHimvWcutD3np/S10LcO81B8xSMYG66rkmWPARpqMEdw7vlQSa8
	 osLer2e6gPnyINXpJdFPO+LIZ+Nn07/VxBUVn6MdDSrvH67nqjiiEBfFT3pmMpfWRrii2
	 arVWuAS4aP/lD+XCfXX4Rh+tdAQBGBSZa6nBhYKbweVKFTSqgV7QFewcD2Y3f6q2INeNX
	 rloFGUXUgYpI4ZvELsXj/NJ53lfACESezl2yRM6ByUrWEwCDFYdu95dTylsSclkWYGYAO
	 pZeTV89VIiNCR17pBsrv7mtEUCvcdBgUhCDsboWel1t+wcVvvMXhqDgZGManBMPVHDw==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1794230312;
	h=DMARC-Filter:Received:DKIM-Signature:X-Google-DKIM-Signature:
	 X-Gm-Message-State:X-Gm-Gg:X-Received:Received:From:To:Cc:Subject:
	 Date:Message-ID:In-Reply-To:References:Content-Type:
	 Content-Transfer-Encoding:MIME-Version;
	bh=KaLSMFTIg6GEmiyqe9A1hSxRN1yb6B0K/ZZgPMpWE5A=;
	b=f3RziIN6yjbzSExCqNN5Vvsn4IU+8V4OxcymSJLNzzTfixNS2QAR/ue60ZQK1Ko4AIU8
	 Cj/urxge8X5tBs1DjXSFZ1OnGMeOjtjZwAhNr6t4sRbqEGUB0GhrnVdQYm+eHyevWUc3U
	 5wNskX6phIZ07dLvTAt6CHF26fHjzvTRc1EPrD0Z4e079ge2ZQReb9zmlp/Oigvy2LTSU
	 fL8v0VKnBsihSjV/HCOPGK+UzeoizAwqgNhvy/kCdO/ulmK5qqaS2fAbEHatSAGK4oSIH
	 LzMP4eh2lh2ZtLWZIS1b4Yn077RD0qudR7khXSNB5BZtGTfS+qVa7qrqr0H9IJ8d1Gw==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=gmail.com;
	spf=pass smtp.mailfrom=gmail.com;
	dkim=pass header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20260707 header.b=R5mcB2+p;
	arc=none smtp.remote-ip=209.85.128.42
Received: from mail-wm1-f42.google.com (mail-wm1-f42.google.com [209.85.128.42])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D7D7B606A323
	for <stable@vger.kernel.org>; Mon,  9 Nov 2026 13:18:31 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org D7D7B606A323
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20260707 header.b=R5mcB2+p
Received: by mail-wm1-f42.google.com with SMTP id 5b1f17b1804b1-4a2167bd087so8537445e9.3
        for <stable@vger.kernel.org>; Mon, 09 Nov 2026 05:18:31 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20260707; t=1794230310; x=1794835110; darn=vger.kernel.org;
        h=mime-version:content-transfer-encoding:content-type:references
         :in-reply-to:message-id:date:subject:cc:to:from:from:to:cc:subject
         :date:message-id:reply-to:content-type;
        bh=KaLSMFTIg6GEmiyqe9A1hSxRN1yb6B0K/ZZgPMpWE5A=;
        b=R5mcB2+ps+cc841xD/JxX5koU7sQevx0Jx2gPZc/ViXCIIQFofSvvTapqXiGP/taK8
         cSiZTkNJ+5EL7IsJvV4ymHArIKk/7JIU++FNXaquzgmbMirJECrp80uqorngl77iBIEq
         cc35+hHblg+KdgAR3fTQH+z+H/Vsc0j1JCRzWWWsqEFc8E4fZUbnIX1ZMb2zzPRKM0wx
         P69rYoJgjuGtMGsTrvs6SwYtTKhoMz7ostncBdlr7JrkSkz69yac0+gX6E3isdkYyooQ
         DxySABQI07BFbj30Y8zSmts1Cjx/iT3Ugp9gpNOY7Ikg0KIHK+LZP4vigsgetGpxIWyS
         6iQA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1794230310; x=1794835110;
        h=mime-version:content-transfer-encoding:content-type:references
         :in-reply-to:message-id:date:subject:cc:to:from:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=KaLSMFTIg6GEmiyqe9A1hSxRN1yb6B0K/ZZgPMpWE5A=;
        b=lAJ17lDVeC2bWesRr7r80ITgNRz4NLIaHuEwex1sAVI8HbY0zTqTfxsW+LYsQPWfTc
         ss7R2u8D8ss95ujHVBavwuNqjw99KL0jengIKtMYzQ1I6QSjM+8C0Fcv4L/AfsAVIj7w
         naItHAHD6nsTZwdCiCHBg0T4gAALKxElzAKarWKgPEtlURRzgr+cr3Pyax3fpQ5vEmt4
         uJzfS84k7B9xhHNgLKe46i3z+cTtPL8C4gIZYGs+o041Xse4dQsknh6i8VrHbJnAzmKJ
         9suqCCxtPIzSg5OWpRRZq2q76p8hZUsRIfRZselBDNin25TIlaHGegIT/RDr0cCAKRi0
         L9rA==
X-Gm-Message-State: APuU4Z+gf+ABtpkGjvOMcU011FEUGgzWhbwhWwfORzSEyEkhUOHKjlQb
	nx9o4zi7pvQspnNG/WBUWzB88ss7bQpz6zYTxdFLEFCObskmJmm7bKAbhyBIgPzw
X-Gm-Gg: AYBFou2MJtendDXHg4sXpWWpwL7aIU3BsRFHXy7Z7NYvMouLm4oDkaQgG/OjMZvbXcV
	VhhWJ3FhZm5t/C1QZ+uztSF4oAD2zR00IgkZt78RJ/MiUtgUeMe1xanMQVaaFiQtANUL8dE8ivg
	zaMBOdXTlySAodArxSbqzpej3g9/gEW6EigI+4bc3CDNH4YA7EQCqhNBMSU+o5PT2lKaHwsa14m
	EdGoJWdreKz7H4RyNulPnAp7TFKcOXDPd7KKsQY888S6Mtzii4+7xgph/C/SzBIAh24pEXE0zdt
	luXUtfuKgBHSNqzDIynYGObYIEOdJZCDAvylHM/Zj6DXjfc1N6hfUQIjuDsVeQj7oIpQK7giH9W
	xRjvZWAUo7iLArT71F9vsAU1YZAf7SGvLtK2Q3tpAEksiyDnjc24quvcRtD6zsO5OZRiIapUiUE
	0T/Z8B41LSWFatgpo3oWbl1lKPE0j5kLpSTvGp1ziFhnmgZBtGJaSJ4w66dysRoSYGOt2rh9hDU
	28FPQDTyIIwbY5SAoIF8TLX//TugN1Vsd54aN+14zsnmYRb8XLt3ocB14FcsDJgEMgdWse5yR8P
	pb6Kveo5X9/x852U0zhkHC2tEm/DftYj/h5gOhiocZhuhsnxUoZbwQ9oG261/+vFSxkfZ3Rm2cG
	cLIBqW9k=
X-Received: by 2002:a05:600c:5251:b0:4a1:9663:7639 with SMTP id 5b1f17b1804b1-4b963c85e1bmr81206955e9.34.1794230310201;
        Mon, 09 Nov 2026 05:18:30 -0800 (PST)
Received: from SurHub.localdomain ([196.188.113.144])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-4b8af10dd35sm226642875e9.4.2026.11.09.05.18.28
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 09 Nov 2026 05:18:29 -0800 (PST)
From: Abdifatah Suruur <suruurism@gmail.com>
To: stable@vger.kernel.org
Cc: Pablo Neira Ayuso <pablo@netfilter.org>, Florian Westphal <fw@strlen.de>,
 Greg KH <gregkh@linuxfoundation.org>, Sasha Levin <sashal@kernel.org>
Subject: Re: [PATCH 6.18.y 1/2] Revert "netfilter: nft_byteorder: remove
 multi-register support"
Date: Mon, 09 Nov 2026 16:18:27 +0300
Message-ID: <179423030778.5673.580608642581842846@gmail.com>
In-Reply-To: <avG-BZ1c3lcjyZuG@chamomile>
References: <179422702104.5131.8115555421206983838@gmail.com>
 <179422702651.5131.4174988605567778384@gmail.com>
 <avG71wG3PHvRQT0B@chamomile> <avG-BZ1c3lcjyZuG@chamomile>
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Post: <mailto:stable@vger.kernel.org>
List-Help: <mailto:stable+help@vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
List-Owner: <mailto:stable+owner@vger.kernel.org>
Precedence: list
MIME-Version: 1.0

Hi Pablo,

Thanks for the review and the correction. The series is unchanged: the
revert restores multi-register support and 2/2 closes the uninitialised
read with the in-place guard.

Please queue the 6.18.y series when you get a chance.

Thanks,
Abdifatah
