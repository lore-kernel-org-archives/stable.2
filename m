Received: from mail-wr1-f44.google.com (mail-wr1-f44.google.com [209.85.221.44])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 494B541B8D5
	for <stable@vger.kernel.org>; Tue, 14 Jul 2026 20:53:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.221.44
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1784062387; cv=none; b=h19b0RgL42dtgWX2GEyyVqz3GAy2Yc8vjeQ9J6GFUYmuAvS0tn8Z+zRebkeZOUeC/on8EJw8pQcU+fZsf0g7lXrO2dtrW0AlWYGjmwCdyI7w3C7nKRAX8eVM8MOW8pHW797jD3fVHnt3vRn+Op6w50Fv2cm1mfgDNNQxOxdLW6Q=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1784062387; c=relaxed/simple;
	bh=JYol08YXW91ovkNpZaJIz1Ed+fcIPymArOeW437uj6E=;
	h=Date:From:To:Cc:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=BDoRJSA8PzkkfEL8eggHDIgEzJeSxxYiMoKGbI/ChVzK7cK3rtKbwJ+Fp29hyJq+uZ/F+eSo0byeMZ8tnZQj65Z926NL79XLvMmjFS7gnD/KtW+Sca+CFEuTTqj/YAHAMo49/GIRGIw0fxKKUMMNlRLJ+4vmkJNYcmXH8ysbHEA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=ZbZtBtow; arc=none smtp.client-ip=209.85.221.44
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="ZbZtBtow"
Received: by mail-wr1-f44.google.com with SMTP id ffacd0b85a97d-47de0093c42so1175000f8f.3
        for <stable@vger.kernel.org>; Tue, 14 Jul 2026 13:53:06 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1784062384; x=1784667184; darn=vger.kernel.org;
        h=content-transfer-encoding:content-type:mime-version:references
         :in-reply-to:message-id:subject:cc:to:from:date:from:to:cc:subject
         :date:message-id:reply-to:content-type;
        bh=hPy+9VG/Wk31EHh/SoTTpkYEXwE1ur2uoLWA6FIrzb4=;
        b=ZbZtBtowHnKVwWhiD6W4WpkjM1/b4ytWELp6smlEUBB5giX4gp8gZHd7HyjyC1OOfY
         LajJeYuFBpaPRAz/L2bwLnCrsOv9cynhodMK8KYLSmwYVLKbULpao6pQorQUGizkzhFD
         JHoSvOCriqdFWVhmgBO09XVh8RYV5HHEa9jiLW9uV0vydVAzmdLou8TZe3jLJSGIj8d6
         J3mA3HToUkf9CvaEpLyUM5uBV9rag6Ga6RIZi/TLvYG+aANH8NqVz6O0yQK453L8GIMt
         4ewJDnzml3D2e9wQR+aEJGFHcoKbQYlv1gVoCoRhiOa+lyTFgmq3Lysw51/MfiOh3DgU
         60RQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1784062384; x=1784667184;
        h=content-transfer-encoding:content-type:mime-version:references
         :in-reply-to:message-id:subject:cc:to:from:date:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=hPy+9VG/Wk31EHh/SoTTpkYEXwE1ur2uoLWA6FIrzb4=;
        b=iJtMc2jx1i1w6FPn8ctB/j5yYV7+Z5X61kBTyYGb8p0aV4ADe/8BcLoKerHnhZT+sU
         oZXc0TBN6sQ5TjmSiEN7+PUTk/7rDpc3NemkOiHE+EWSq96bU5/eYpOrASxNxM0Mc8h3
         ZO0fBRwWOwnn5CVGQcSrEgbzpX3Wq1B8aohHCjZl8FnjQFrstB02lgUQi0naPxck0eBM
         7jip3oYKnvL/UH3vqYmCbdkw7otCgKh0SlWzTLjCf+n9ZXeTUU6u9UTH0NHrdv2tQHiC
         HcJw7IKz9NWNfOBktb4buO7WAQk6HI0Dp7+xIPPvNjLoWVudY/w9dctMSdEyA0MGZMVU
         8JHA==
X-Forwarded-Encrypted: i=1; AHgh+RoBzy/PVrnjaoZKfAcvrg0fPI5/LsponvNV+PjConVs0qeXOVMvrDDVjTiIbF67dZ11V+Gf/3k=@vger.kernel.org
X-Gm-Message-State: AOJu0YysxCyU+tmek+DNHwRH1g5UMAKT1jOG9Kj9CrME0CDMNHHQIKrE
	To5n1Mbbm23BdNxv+eVin/Awkqw1iIalc9RLTkLHDpKrKxsuT/ZaLDp8
X-Gm-Gg: AfdE7clyt92CUuNMt1YBIY6j/sBBa/k+mE6+ZAccYoyr9ZDQW9TNaYNkldidLb8C0Bm
	wkU8vOCqBW58tqOy0+U6xfZL+WRmePa5wDXYMPZbe0PEC0JOQAq7h2zaJu+f5Nl1D8ZZ7jKjZki
	kskqovBywDuPgGIdmlcbEq4Gio3gK9QhxL0SLf3fgMsIQT6fPRxSZfChQxejxL9bHYN4rMoTltL
	scrN9uYMUNwgZ2cxsMO90hW6YLOtxuxgYAZi2BJgnrqF3U+NJzZpPs1ohyRy1pgf1oTHTY4uXWk
	S4Okt2mBCejIfw1F4Uu0lvFd2hrhJm432dHhX1+Q2EZU1afFcdvd+QDvhTiePZyqC1D5aQiET1v
	25ingFz3yqsdcG0ICDrDZzkJqudvgQRq6Au/qGPwzIzmC1Liab5VcJFWkhhHhqMSRLbmm4PCl6A
	4n4XVtcXB8Mi19JeXp78dwc8J+YIhl4mkh1L7xQe3chE0qkhvzHA==
X-Received: by 2002:a05:6000:1866:b0:475:f0d1:eb56 with SMTP id ffacd0b85a97d-47f2dd0d63fmr18015724f8f.49.1784062384331;
        Tue, 14 Jul 2026 13:53:04 -0700 (PDT)
Received: from pumpkin (82-69-66-36.dsl.in-addr.zen.co.uk. [82.69.66.36])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-47f4634debesm10998794f8f.8.2026.07.14.13.53.03
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 14 Jul 2026 13:53:04 -0700 (PDT)
Date: Tue, 14 Jul 2026 21:53:02 +0100
From: David Laight <david.laight.linux@gmail.com>
To: Doruk Tan Ozturk <doruk@0sec.ai>
Cc: david@ixit.cz, vadim.fedorenko@linux.dev, horms@kernel.org,
 oe-linux-nfc@lists.linux.dev, netdev@vger.kernel.org,
 linux-kernel@vger.kernel.org, stable@vger.kernel.org
Subject: Re: [PATCH net v2] nfc: llcp: reject PDUs shorter than the LLCP
 header
Message-ID: <20260714215302.75d8bf72@pumpkin>
In-Reply-To: <20260714164629.75051-1-doruk@0sec.ai>
References: <20260713221556.13a830b8@pumpkin>
	<20260714164629.75051-1-doruk@0sec.ai>
X-Mailer: Claws Mail 4.1.1 (GTK 3.24.38; arm-unknown-linux-gnueabihf)
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit

On Tue, 14 Jul 2026 18:46:29 +0200
Doruk Tan Ozturk <doruk@0sec.ai> wrote:

> > Is there a similar problem with non-linear skb?
> > Maybe they can't get into this code, but who knows what can happen
> > with unusual configs.  
> 
> Good question. Today every skb that reaches __nfc_llcp_recv() is
> linear: the target path (nci_rx_data_packet -> nci_add_rx_data_frag ->
> nfc_tm_data_received) and the initiator path (nfc_data_exchange ->
> nfc_llcp_recv) both build the frame with alloc_skb()/nci_skb_alloc()
> plus skb_put()/skb_put_data(), and NCI reassembly uses skb_cow_head()
> and skb_push() into the linear area. Nothing on the NFC receive side
> attaches page frags or a frag_list, so skb->len == skb_headlen() and the
> v2 skb->len test was in fact sufficient for the in-tree drivers.
> 
> But relying on that is fragile: the parser reads the header out of the
> linear area (pdu->data[0]/data[1]) while skb->len is the total length,
> so a non-linear skb with a short linear head would slip past a skb->len
> test and still over-read the linear buffer. pskb_may_pull() is the
> right guard here -- it also covers the non-linear case, and it matches
> how the sibling NCI and HCI receive paths already validate their
> headers.
> 
> I will send a v3 that uses:
> 
> 	if (!pskb_may_pull(skb, LLCP_HEADER_SIZE)) {
> 		kfree_skb(skb);
> 		return;
> 	}
> 
> That is strictly stronger than the v2 check and does not reject any
> valid frame -- pskb_may_pull() pulls the two header bytes into the
> linear area when needed.

Does that help any code further down the rx path?
It might be better to drop non-linear packets with a comment that
they aren't expected to happen.

	David


> 
> Thanks,
> Doruk

