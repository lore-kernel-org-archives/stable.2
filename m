Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=209.85.219.45
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1792596487;
	b=AXeQbG5PrNyuZK5fK5kCvPexSs2yIA/FOIlKKP5Do7DtqwpB+Fk+xsFdbEjymLHba8GH
	 y6CHODE76yC4Znd8ptQS/ZWqRYdsOuBdlebwI3kBAQnnvqgSnQl46Z3ZrFSJT7q+0cFsN
	 zsH83Ky8OIOg6v8/zxOGQYroZgIcl6lri8DBa+Ovey+O5vSNOxqOQKZix1V0XB2geBsF6
	 DaigbFxeM591jSvP32mQ822gv25QObD9x7VTC755el+2qoA8hk6+Xn1cod57mgrEfpiib
	 cnSjsc3As231F9EnCufalAeU7Kt27obbH8tdCTn8IB0kGetCbeyxNk1696NTSwvTffQ==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1792596487;
	h=DMARC-Filter:Received:DKIM-Signature:X-Google-DKIM-Signature:
	 X-Forwarded-Encrypted:X-Gm-Message-State:X-Gm-Gg:X-Received:Received:
	 Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To;
	bh=J7iM+yhWKMhlaRTv9Dtyn+iVYrKHxFutAHJMBB4EGzM=;
	b=E58A8JRis9D7mELZLKLGw5VlKpSkNX2BWWuqIR2ij5E3P9cZrBIm6mbiMZQm0EInDP9n
	 sHCLZGFwn31dlwZxdfqdsTQWJDNZv/WQj1FlrehW7n5SQHutaa/cVrjfjaDQpZcICxRHT
	 xx35+8Np1wXx+OyagoqdK3/9i4hGaO3+jkrCyA/hFY21O++6G7+61FN0kNTahHc6ObgjG
	 B8cBHzkTRY0CElfzCaGyLFBIv03ENtFZ5x/AAz69d1QJOChICrKrDfeYO1SkMSTERFz00
	 UYEsbgaPLPFIHomQbokalhOdIHE3P5RPDsDLA5G3lLS0kPX7s7mUrEsLRuGTRaCK8jQ==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=none header.from=gourry.net;
	spf=pass smtp.mailfrom=gourry.net;
	dkim=pass header.d=gourry.net header.i=@gourry.net header.a=rsa-sha256 header.s=google header.b=NjkSxdlR;
	arc=none smtp.remote-ip=209.85.219.45
Received: from mail-qv1-f45.google.com (mail-qv1-f45.google.com [209.85.219.45])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9D0DC606A31D
	for <stable@vger.kernel.org>; Wed, 21 Oct 2026 15:28:06 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 9D0DC606A31D
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=gourry.net
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gourry.net
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=gourry.net header.i=@gourry.net header.a=rsa-sha256 header.s=google header.b=NjkSxdlR
Received: by mail-qv1-f45.google.com with SMTP id 6a1803df08f44-917b78dfe30so12176066d6.0
        for <stable@vger.kernel.org>; Wed, 21 Oct 2026 08:28:06 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gourry.net; s=google; t=1792596485; x=1793201285; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:content-type:mime-version
         :references:message-id:subject:cc:to:from:date:from:to:cc:subject
         :date:message-id:reply-to:content-type;
        bh=J7iM+yhWKMhlaRTv9Dtyn+iVYrKHxFutAHJMBB4EGzM=;
        b=NjkSxdlRV0YeVz9c7b6C/ObSO3CV0F/hk+ur2ybp4U3aMmAsWcP+bU7/dNr90v16f4
         lzE1t8ilfOMbXED2Faep7Yp5B95D2uUr/qMIEx5Oyw95DKLXGoh3caabdUt2LHq+Fi0j
         vSya0ZD3VKvWY/eLMka4vEoMzAqmA7visb1VKBind7HuYq2Q86IXrdGSvBvLC4hjJMO4
         aZXCGMpGcQKicHLpdJvPEmLzWgdSH16GK3pwIzAwfObU1r7I4EGPOadc8keV1VdF0i4+
         KqPkYtVuJ9RYGRLHuNTHl+cgUIe3yW4bKzYvltjnytDJ3oAKPykNIzKqUiWhpgU+lh6v
         376w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1792596485; x=1793201285;
        h=in-reply-to:content-disposition:content-type:mime-version
         :references:message-id:subject:cc:to:from:date:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=J7iM+yhWKMhlaRTv9Dtyn+iVYrKHxFutAHJMBB4EGzM=;
        b=k/q6Aq/sLFg/mafKmUS/9eAp2uTx0koK21WJhfSL1LYKD6drLP4nvlxKoifNi4oyGt
         QX/8zG8U/qGeujkwtCUivi/IL95rPhc48RZ2rcjfRuQEZmqep1P59JnBkINEjfscjsks
         XzdLisA/bkAvtMvocLgc8fnqBvWTo7oNKFQdvMeeaw5N+eMhKlsl9x1OaYeDCyu3dDkm
         hp2KQOZbyL1KAaRnNzu8NtPphoxq4F/cbiLmHjnMsF9OE5L83RanCSwgXT+EZMCOlhGr
         k9WXSDRPr3j6xtBOZGN0Evj0czZpI7v4SEVlTLE6e6VIcuk0tvBl/4jv8BoQt5qBldkx
         oHMw==
X-Forwarded-Encrypted: i=1; AKwUvBzuL7rzxvkcXiEQuEJWS5wy+/ZFFSRvotMJ6nzkDg6tmaNjf0m3CWrwGM/r+d8Cww8fHcWTYAg=@vger.kernel.org
X-Gm-Message-State: AFq9FYKF5n1mfylATTgaKYhv+gpaohrstUni5/RLCPFqc327/5hCtIPl
	btk33YfwRCCdSOrnKQEGwfPKdpb5FVpFv+JFtfIkK7Mq3ZVJqUZDM2S72xqgHNGOJ2TJO0hB/mY
	wGTay
X-Gm-Gg: AYBFou3C+pGgP/A7ZsRlDyAxKn/Ft55w+wWqGqiss13Vqz37zB51urKtH+ffhbTfEtT
	Qq7xcMkL7+CbCTWX+sEV+M893oH1C+Biz18wZpihcnAD6HoAaHRophEtNCHeCkoCTs/BS9zEbIZ
	p7HfEdbISq4sMYEzSqKX/jwR3Yydlm2r4TOQYk92N2diWCer7+dHLRXkxk+2zF6wZWtObzvYLkX
	+taUbYv4RC+ZBlsIojFJlkVMXUpgqs2GagBBpunjsqwKJH1vFq/qpo1WgByVsVRmQpO1QjocZrp
	JW9njZDMZb6lQ8Aq5uoHkSChbQQa1+zeOekNGBH1vfb241KNL8bHoPOeRXiqNepWQcyFaIeTJht
	Qs7uibjg1+FK31mJUngWJw4HdpWr+YbpxjPORZzPzzgkSqMWqZREPBYWZiTZqrnsB9JEIZs90FG
	wxC2W7YCsWTXY2gZLNcgdzebm1mv65RC5VRgrI8ar4MdCpG/7V7BsDfRRCxAi7M5xwj08TQq8QO
	2TpdZIi2KIRRyJb9IsthboOCh6dRzVIEW5NNPxLqH79796BEYsytAk5cyyxut1Gypft7WGR5dH3
	6IiBIw3ngFIaXqJA8AnBFgXJH0S0UZpSk0G0
X-Received: by 2002:a05:6214:3a8c:b0:91b:d5d7:8c85 with SMTP id 6a1803df08f44-91c12eff3e3mr44319236d6.33.1792596485317;
        Wed, 21 Oct 2026 08:28:05 -0700 (PDT)
Received: from gourry-fedora-PF4VCD3F (pool-173-79-60-52.washdc.fios.verizon.net. [173.79.60.52])
        by smtp.gmail.com with ESMTPSA id 6a1803df08f44-91c10c3b500sm27151986d6.35.2026.10.21.08.28.04
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 21 Oct 2026 08:28:04 -0700 (PDT)
Date: Wed, 21 Oct 2026 11:28:03 -0400
From: Gregory Price <gourry@gourry.net>
To: Hungyu Lin <dennylin0707@gmail.com>
Cc: akpm@linux-foundation.org, willy@infradead.org, jack@suse.cz, 
	shr@devkernel.io, linux-fsdevel@vger.kernel.org, linux-mm@kvack.org, 
	linux-kernel@vger.kernel.org, stable@vger.kernel.org
Subject: Re: [PATCH v2] mm/page-writeback: avoid 32-bit overflow in dirty
 threshold shares
Message-ID: <atjZ6yadzSeqjozA@gourry-fedora-PF4VCD3F>
References: <20261021060654.27855-1-dennylin0707@gmail.com>
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Post: <mailto:stable@vger.kernel.org>
List-Help: <mailto:stable+help@vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
List-Owner: <mailto:stable+owner@vger.kernel.org>
Precedence: list
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20261021060654.27855-1-dennylin0707@gmail.com>

On Wed, Oct 21, 2026 at 06:06:54AM +0000, Hungyu Lin wrote:
> The ratios used by __wb_calc_thresh() are scaled to parts per million,
> but the threshold and ratio operands are unsigned long. On 32-bit
> kernels, their multiplication can wrap before the result is assigned
> to u64.
> 
> For example, with a threshold of 25600 pages and the default maximum
> ratio of 1000000, wb_max_thresh becomes 4125 pages instead of 25600.
> The shared threshold and minimum share calculations can overflow in
> the same way, producing incorrect per-writeback dirty limits.
> 
> Use a u64 threshold for the three ratio multiplications and div_u64()
> to retain the existing division order and rounding.
> 
> Fixes: ae82291e9ca4 ("mm: use part per 1000000 for bdi ratios")
> Cc: stable@vger.kernel.org
> Signed-off-by: Hungyu Lin <dennylin0707@gmail.com>

Reviewed-by: Gregory Price (Meta) <gourry@gourry.net>

