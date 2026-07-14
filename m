Received: from mail-wr1-f54.google.com (mail-wr1-f54.google.com [209.85.221.54])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5DECE2C0F8C
	for <stable@vger.kernel.org>; Tue, 14 Jul 2026 16:46:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.221.54
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1784047594; cv=none; b=JWDVibp6u/mcil1xv0H7lHJQT07FT+GsEXqHqqhbKUyRvDbTcWfjzvqN0mTA3IwWHUcLukCiBXWRVHTY773/go/+2zRqL3MUALF0RJ3Y1Z9AoKBroFkjkrHzL2EVf4/paPmH39VyKEqbxrQMTugmFaZvvCkHr+waM0jaywPPqZg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1784047594; c=relaxed/simple;
	bh=VzArmT7nUp//GvC7u1Ew+TKOM8ByFP4IkQWLiZaejoU=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=ocBYzTz65kpHDOG0d2X/gWYS0sqIy2Z1DTrHS7EAeryREqquzHJ3cIwNHIfmmjfbjjxbZx6dAEJVzg9gaIXRnfEau4ph08WnHHHBVyBwERh2xWI74o/v3lR9AzEJmMkyHDGnp/iBbXRYwgkeJakAf7J/lOFDmqz+HCt4ObDlsUg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=0sec.ai; spf=pass smtp.mailfrom=0sec.ai; dkim=temperror (0-bit key) header.d=0sec.ai header.i=@0sec.ai header.b=qmLtb2/+; arc=none smtp.client-ip=209.85.221.54
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=0sec.ai
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=0sec.ai
Authentication-Results: smtp.subspace.kernel.org;
	dkim=temperror (0-bit key) header.d=0sec.ai header.i=@0sec.ai header.b="qmLtb2/+"
Received: by mail-wr1-f54.google.com with SMTP id ffacd0b85a97d-47f3b39f2a1so844156f8f.2
        for <stable@vger.kernel.org>; Tue, 14 Jul 2026 09:46:33 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=0sec.ai; s=google; t=1784047592; x=1784652392; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=nGZqGZVOotZvIfQ16pDrwhVFuI0Zyt/cSEfsEhB0qUo=;
        b=qmLtb2/+zdCD4ZDNoQ8SY+H4VpKIh1QOB77sNLkle//2+Ee5Ybxr4a+B7uk3OY8WLk
         h3diZPIVKkbWJFKXYtwZ7dpC7a0sWtzmCgCE+eiqfWII5vriIzdD9P1bsCK1YezOH9To
         CWq4bXgRD6V4cu/ivcpZ1Q0Sp9oZgpyfjjrk+5u6ZnRCz72BP+aTLWCF03rsTMsuSq55
         xeOmcGsvwLAA7VobDHn9y+poJC6qG0frlz7CuItJSYHV287GjTAjlzHge7wqLRqwJxAJ
         Ehi6a9Wn8tzTb+x7xH9KK1x+/hlsC4kDgL8SQpWfvYBKNHn+6BMRAqg7DQJ/cHboarU2
         YQ1A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1784047592; x=1784652392;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to:content-type;
        bh=nGZqGZVOotZvIfQ16pDrwhVFuI0Zyt/cSEfsEhB0qUo=;
        b=Nidf2vJx36N4GPC7++ihxZvuuxcommwxCH17WQVXhXNnSaeodmYtWNb7oJZI03T7mY
         moMFIbrL/NhrmPFAWWt0kh48zQV5fZKYiki5jBkUonDLcOu5F02PSLAdqjz740R44pB7
         15j3Q/rxTkuGLolwqS3hczvkyoptEfYLI/8MYHj41cskiGjiFP9n5a9tHiTVeBamWORz
         NmYWUAyibzx7jTd7IxxsBNPB7FnmqgLBJGMWFi9qkrMTiIgCevFyBRZ6kyahvGziRst+
         YWIbGlXjekYMHcfg1vO/XVK7+MJBmy+z9fHFi4qd7n1K2OoOoicLoO/SYrW8/I5zB9x3
         jcPQ==
X-Forwarded-Encrypted: i=1; AHgh+RrEDUe4CE36LGV+eMrpBLMwgTeNDlauNf0+Zy4fSs1B7uTattZd0SVyGSXEvUrJOisn+3v/R4w=@vger.kernel.org
X-Gm-Message-State: AOJu0Yzu+if6ZzgJfyRh28cT3yJ08lHCuPQbbXgPK5qtSAHZ1GECSo7W
	gPmxzURzVIhf/XDPtoJn/PydBF+R1uMe8c/QqDox95JGCuKpevvx9ajoYg1UYgxHLx5GYGAaWoc
	Zq4qmo77/
X-Gm-Gg: AfdE7cn0+bFtLmzu3UsHoBKfEdwzkHEKv4K2xhEven3riNMynqYlxRIfEQ0AKIQdoOk
	ZINPH+Vm42Nk49trgH1lRxP3FE7P/gDleLp0x9cDHvP52e5ypeicpK7tp4bzj300fPKOvjGwkgb
	407ZY3GxYMaTeOfEx9hfgoo/1FSZ1lURDWu8e6gn2ukDhnra3hq32BPeVGcCU4e50p99z0z+V0n
	+g27VWpEJPSecn0XCB8U6IHA+qz7P6lupVxf5TEyd0s6HbqeUKdATgxBH6/CdPF28hmMyGmXO9Y
	XQmrB9y2hZROcPWoOujly26LXr7XdEOla+Uc25sw2wKHACthP1Qink0gTbi0TFSPLPxKSpV6Bba
	tu4RTQ+SujzCzcPc8yH9uCNACHooD9Hef4uHtAHWlmDMUkOePuXNJ4aklC/X2RFAghWAvYo97c5
	pyvwnAdQwMalGYQw511+iweREXvSTpRi/cGqJTuRxnLUnXZHdD7vlTFayWE7N9Rdum9CuiLVnb/
	Pd1hPZ2pDJR8ex8gDM6yXc8lxR/0Tn0HSxJr5wexcRPfg==
X-Received: by 2002:a05:6000:470a:b0:475:f0d1:eb61 with SMTP id ffacd0b85a97d-47f2dd1ec66mr16303746f8f.60.1784047591553;
        Tue, 14 Jul 2026 09:46:31 -0700 (PDT)
Received: from PeakBook-Mini.tail8e484.ts.net ([178.197.218.188])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-47f464b7f84sm9164956f8f.27.2026.07.14.09.46.30
        (version=TLS1_3 cipher=TLS_CHACHA20_POLY1305_SHA256 bits=256/256);
        Tue, 14 Jul 2026 09:46:31 -0700 (PDT)
From: Doruk Tan Ozturk <doruk@0sec.ai>
To: david.laight.linux@gmail.com
Cc: david@ixit.cz,
	vadim.fedorenko@linux.dev,
	horms@kernel.org,
	oe-linux-nfc@lists.linux.dev,
	netdev@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	stable@vger.kernel.org
Subject: Re: [PATCH net v2] nfc: llcp: reject PDUs shorter than the LLCP header
Date: Tue, 14 Jul 2026 18:46:29 +0200
Message-ID: <20260714164629.75051-1-doruk@0sec.ai>
X-Mailer: git-send-email 2.53.0
In-Reply-To: <20260713221556.13a830b8@pumpkin>
References: <20260713221556.13a830b8@pumpkin>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

> Is there a similar problem with non-linear skb?
> Maybe they can't get into this code, but who knows what can happen
> with unusual configs.

Good question. Today every skb that reaches __nfc_llcp_recv() is
linear: the target path (nci_rx_data_packet -> nci_add_rx_data_frag ->
nfc_tm_data_received) and the initiator path (nfc_data_exchange ->
nfc_llcp_recv) both build the frame with alloc_skb()/nci_skb_alloc()
plus skb_put()/skb_put_data(), and NCI reassembly uses skb_cow_head()
and skb_push() into the linear area. Nothing on the NFC receive side
attaches page frags or a frag_list, so skb->len == skb_headlen() and the
v2 skb->len test was in fact sufficient for the in-tree drivers.

But relying on that is fragile: the parser reads the header out of the
linear area (pdu->data[0]/data[1]) while skb->len is the total length,
so a non-linear skb with a short linear head would slip past a skb->len
test and still over-read the linear buffer. pskb_may_pull() is the
right guard here -- it also covers the non-linear case, and it matches
how the sibling NCI and HCI receive paths already validate their
headers.

I will send a v3 that uses:

	if (!pskb_may_pull(skb, LLCP_HEADER_SIZE)) {
		kfree_skb(skb);
		return;
	}

That is strictly stronger than the v2 check and does not reject any
valid frame -- pskb_may_pull() pulls the two header bytes into the
linear area when needed.

Thanks,
Doruk
