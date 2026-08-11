Received: from mail-wr1-f49.google.com (mail-wr1-f49.google.com [209.85.221.49])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id AEB43418340
	for <stable@vger.kernel.org>; Tue, 11 Aug 2026 08:59:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.221.49
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1786438744; cv=none; b=CB8cRLULAcdqZ4cl6jMXioVNu/+pS5MPWN/JubTiE3JBtcHJl46NAsH9v9Ze09nofH+ztYR5Sr5VZG98/GF69oo9d/rZm7j83qNwlWqZa4ROJelMPTqhtJrkhrc8izb5dNGiIFc3L1R/yQt/opKGPyXfjikzZS8vYY/+2Soowyw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1786438744; c=relaxed/simple;
	bh=TXi53rFxJBdFlfbvVAj6cdgBdIHIpDbeFqnTTLRscO8=;
	h=Date:From:To:Cc:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=fHJo+HOf2IBv1GK+oHujyBTJlAt+Pb71a4inbek7C/D0tGO6FQAgcF+FWu7ExLei6Pv4aZQY0yuHOYh1RtdIoO+fRHlJ0If5utzpv/1fXgwXGsT6K1dO3LoSA2b5fVJewzbqBsY7+oDXyqbwhrGHPzn7rwit7iC+FIyrRf2GTRs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=WKRYvd+i; arc=none smtp.client-ip=209.85.221.49
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="WKRYvd+i"
Received: by mail-wr1-f49.google.com with SMTP id ffacd0b85a97d-480033bdcf4so1604239f8f.2
        for <stable@vger.kernel.org>; Tue, 11 Aug 2026 01:59:02 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1786438741; x=1787043541; darn=vger.kernel.org;
        h=content-transfer-encoding:content-type:mime-version:references
         :in-reply-to:message-id:subject:cc:to:from:date:from:to:cc:subject
         :date:message-id:reply-to:content-type;
        bh=QQXpNuQQFm5sUEBX0kmz785dyNklSUIJrRxHt7Y1I18=;
        b=WKRYvd+iBsE4DRjApi0nWIjrW4MI7XuzwabqJIj4DJKiX+u4Rudf8ecp0aZ+ZcHiUs
         VhRITZSHX5YbLTzlbJbhc0Hk6KXKg0wyh9Z2ipJBSOQ1GRnd7kOxLD1gntSbjLwwA5Z0
         aew2NteWedx7wEMbT6vcFgQ8Zrjf6C4zFizQ+t1kL41Wu/a9SdRequigQGg//1Yzx3KW
         F4gdhD2A+LkKnsgl52EDnVrg6lZNQrLfgyNUQoBPspOUORW+V8n6dybrcRIDWEYyNQW6
         JwwsQUgokzldBWYPZ3P+t4llhB0vMJh2Stl4gIjkHAxPb5HAx0fmxWtJDR1iXY9DJRRZ
         OI5Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1786438741; x=1787043541;
        h=content-transfer-encoding:content-type:mime-version:references
         :in-reply-to:message-id:subject:cc:to:from:date:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=QQXpNuQQFm5sUEBX0kmz785dyNklSUIJrRxHt7Y1I18=;
        b=DKicPJW5VVIHFCY29948WQiUO7om4DdqPRcLSOHMHsC0d1w4ien04cmwWMg/GhoA9n
         CCr7OGUJx/PIznTh0Pw4+/C6OfC3RpPxthiL+gnEEr8FuzCaf4wtKQjec/2vf/pl2aVT
         Umi8sUuSMlkhuAFQrh8XilCAcjtHWt8EFhufKeUEtd1jjM+g6ypw61NPvWisadt4Mfql
         GvoxbWLF3Mb9SQCPDYofdIhSqjCxe1CrkQWTItwGKbQcSCBDgYmz/4rhXB6ikr9NYpGD
         IoroRvh0zBpyLXMexgmzUM1H3oNv9rVOhqYQl3ExDxnfh7zHwPeHstZIk93vAT74Pfhl
         0hRw==
X-Forwarded-Encrypted: i=1; AHgh+RrsSRl7ArSgIBC9MIhzPV9TwJOKeDJs/LYCStJvvDhAyqh41cdwjD+WJpEX+tF2M8vGREXodhc=@vger.kernel.org
X-Gm-Message-State: AOJu0YyhWnwEAppa7qLUu/isHCQ6a6qmfY6TPcEpn1FHzbciLUcy5aAP
	NRsapum7uP+TsQcL5mQY8cYzrBRkK8170Rq4Dg75NZ2ab5lzH0bODtHG8kAfNQ==
X-Gm-Gg: AR+sD10fpLuDfpktZh77QKy+ytqdQuQ6ePNOhGh2XXfDYA1Tnyx/Rah2eYU/bnIHK/y
	MrNSBLK/tRBUPtvAWQx4Vv90fEa+Dt4s1BWyxFzXXzSrGraD2X1elNAqA1kO7qBastq8UU8Mkrv
	Z4LhNjwfm2ks3pfDhkAL1eixVmzr1DHtST4QwF2UIz/07c4VzI504QiTE+LjEeKnHzmhcsOkZ51
	3c9xgwfecRFRQ4DQb0dIWVnc7rWMydu2NIxTSUtlkm41XH2QSHtmlF+psYZFzFTv+VuhXvdgnBM
	OzuNsLmF+I1Qo/TKG4lRbxXSk9EYefQVw2Ox4Wx4bd+7YfCU75P0zGtyxKSgAtAapQW9sSK8u4o
	isXL5/ERoJi9cbElHNGHcR+HMJhXkkyw1h0I6bfgKWqVxVgObVb2QJKjZFZatbUwbEnMTpeg50s
	mQTmht8TSYx4V3wTxD2pUqQeJ81aj/I4bYiW36Gn3aiJXTrRZvlj6eovd4sP9YEKjIKcY=
X-Received: by 2002:a05:6000:2c08:b0:481:46d2:19a4 with SMTP id ffacd0b85a97d-4814adc5fdemr2626276f8f.24.1786438740785;
        Tue, 11 Aug 2026 01:59:00 -0700 (PDT)
Received: from foxbook (bfg7.neoplus.adsl.tpnet.pl. [83.28.44.7])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-4814a5be1b7sm2701403f8f.14.2026.08.11.01.58.59
        (version=TLS1_2 cipher=AES128-SHA bits=128/128);
        Tue, 11 Aug 2026 01:59:00 -0700 (PDT)
Date: Tue, 11 Aug 2026 10:58:56 +0200
From: Michal Pecio <michal.pecio@gmail.com>
To: Arthur Gautier <baloo@superbaloo.net>
Cc: linux-usb@vger.kernel.org, Mathias Nyman
 <mathias.nyman@linux.intel.com>, stable@vger.kernel.org
Subject: Re: [PATCH] xhci: fix lost bounce buffers on TDs spanning several
 ring segments
Message-ID: <20260811105856.75d5a7dd.michal.pecio@gmail.com>
In-Reply-To: <20260811104237.4500b578.michal.pecio@gmail.com>
References: <20260811033508.1050148-1-baloo@superbaloo.net>
	<20260811104237.4500b578.michal.pecio@gmail.com>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit

On Tue, 11 Aug 2026 10:42:37 +0200, Michal Pecio wrote:
> The code looks correct, though I would do it differently: store the
> last bounce_seg and run the loop from td->start_seg to td->bounce_seg.
> This avoids adding the 'if' during enqueue, and still works correctly
> if the TD wraps around the whole ring so that end_seg == start_seg.
> 
> The driver is never supposed to create such TDs (they break the ring
> expansion procedure) but I prefer more robust code if it costs nothing.
> Bugs happen, or expansion could theoretically become more flexible.
> 
> Regards,
> Michal
> 
> > +	seg = td->bounce_seg;
> > +	for (i = 0; i < ring->num_segs; i++) {
> > +		if (seg->bounce_len)
> > +			xhci_unmap_one_bounce_buffer(xhci, ring, td, seg);
> > +		if (seg == td->end_seg)
> > +			break;
> > +		seg = seg->next;
> > +	}

Oops, sorry, Mathias is right, this loop may incorrectly unmap a buffer
belonging to a later TD which starts somewhere in td->end_seg.

I think the alternative procedure I suggested is free of this problem.

- if td has bounce_seg, then it surely spans beyond start_seg, so we
  can safely unmap start_seg's bounce buffer
- if start_seg == bounce_seg then this was the last bounce to unmap,
  because it's impossible for end_trb to also be a bonuce.
- otherwise, we can continue to blindly unmap until reachng bounce_seg
- after unmapping bounce_seg, there is nothing more left to unmap

Regards,
Michal
