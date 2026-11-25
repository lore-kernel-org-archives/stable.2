Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=209.85.128.51
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1795603346;
	b=vpSOSuI9bY3jt9dHW10kUEFmAKeU32dkGZbi33SeRWUkV8neVHGAdbxtrDNusJLpgFj+
	 0m6DcsvwERMNYmdHO6gn7LKclCOQSEqEeweYcXbcSd1A0bjwt7LbEqYT6uMVycPD0/wn7
	 hNuuXqtIWg4QjbZ2yXnARtkTIAWwVa/6/v+9y91hhjQGaJgxBpntulEAODo9F9G7+KC3m
	 u+3g3wM+/00K9TD7jWwV81q7EAGvNqc4Yg6PxkcPQfLzni34td6HXYceJvDXZ691ljkN5
	 ttVmn2iKrqTYE9ZgOy3Z8SRg/DmXuFJcx3E/5idVuhZphZNvIUNq7RxhAHRloeY52AQ==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1795603346;
	h=DMARC-Filter:Received:DKIM-Signature:X-Google-DKIM-Signature:
	 X-Forwarded-Encrypted:X-Gm-Message-State:X-Gm-Gg:X-Received:Received:
	 From:To:Cc:Subject:Date:Message-ID:X-Mailer:In-Reply-To:References:
	 MIME-Version:Content-Transfer-Encoding;
	bh=2itv7AcVBputKhN6p3kMxHNEdUzZvUrvuaoBxgjz4ao=;
	b=mI9sUQtkaKZ9trrIeYA1wZWXa4J1H5GRXAsKBgg0UDVZ4vw7PCekgkBjq+a4utwG2dGA
	 yTNEGihaVpKCmt9Gzyb+dSU05bdoaQaa3ytTV0k3EQu2XdLlu0d4HKQek1QjtwBxO659P
	 ohp3WW1uoPiLe0f52yQzCgwG/AaT+sf2G7dKs4ogbHK8q+La8BXfBVU6F/al5B7F5UguQ
	 RH85dgiz8/+SeN8VLa8mut7H3Q21x0twD04CZzjTGH1yNR0FP7kwLxQBVQLnJ/EcRYQyV
	 BWPOPCiA9O5ziq6e2nBknNpmRm9PyUPGvYXZvi/yO7DW85V5lp6DY6PGKDfPGK/0j0Q==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=gmail.com;
	spf=pass smtp.mailfrom=gmail.com;
	dkim=pass header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20260707 header.b=GTOC9omH;
	arc=none smtp.remote-ip=209.85.128.51
Received: from mail-wm1-f51.google.com (mail-wm1-f51.google.com [209.85.128.51])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4E649606A321
	for <stable@vger.kernel.org>; Wed, 25 Nov 2026 10:42:26 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 4E649606A321
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20260707 header.b=GTOC9omH
Received: by mail-wm1-f51.google.com with SMTP id 5b1f17b1804b1-4a9a8d6cea8so71917005e9.1
        for <stable@vger.kernel.org>; Wed, 25 Nov 2026 02:42:26 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20260707; t=1795603344; x=1796208144; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=2itv7AcVBputKhN6p3kMxHNEdUzZvUrvuaoBxgjz4ao=;
        b=GTOC9omHlN755K9A45vsxlj2kZzH2TydJr26tT2j1VdKH9AuU2YpjdDZrdVu+PvyNw
         FjD3/41LirizaeyE51QeopzgMvhb00wccT5F+DmamieIWvGOpYd8mhXlkklBrAqpUEPB
         eX1cFlBg0IZ6I06TcveXFCS1CsxjnhOYxeTOJv/4P/fYS21byIWQa0uWI0wcCYEoJiY7
         I3xO4QUwcocd5fZN31rbnVLiZejYU+mGtwBRIKZNz3IGyN1ZLOE+eEorxL5pA/9p7YkJ
         6/w4cqjt8ZnhZ/zTdb6HCv5SxBGWFIMsWYgQeArmIA2xsnkr7bLOSmuHz9mG4+ftnZsX
         Qaew==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1795603345; x=1796208145;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to:content-type;
        bh=2itv7AcVBputKhN6p3kMxHNEdUzZvUrvuaoBxgjz4ao=;
        b=GvxGlCM3awGoaZeTzXV/msqI9Zs8Jw2blGPDFEtVCc1g5XIKEbvIs0GQVZs7thGrhL
         8y/C91H5nUq1m5DDHZaZqAkGmDLwpSX9iIWU/zesQ12sNbrlb6L20mqysjLXRCseDtg/
         Xu8vwUelVs4v7lT6jqbPNfEqczmvCBj8VNikXRstYVxZkVXkWJs1nnnSghGv1UpvpP7A
         cFEikn+oEPaq5e7GLnXNDtq9YRAlr4rD4qdLBBMA51XhkzTXtQZGNJknuac7DcDRnlpA
         h3dw+07NuHsSUVnSP2sLmi7YnMOZkTLPuKjtEK4GJSdviY1vfq3yIPiBtu8CdveXAOTj
         s8Sg==
X-Forwarded-Encrypted: i=1; AL+hErGIKEMGSrUqVHzzTwKes9R4RzZhWBtxnrIKAwmyiKWQlBOK8nztjwud7r5/kv76T39+H1PC4rQ=@vger.kernel.org
X-Gm-Message-State: APuU4Z9uZRXTJd/P+Ix1Louxrn2YX1PPlVvKwyhIh1DYJh6XnbZnFeDo
	aY7yPWzO8E3wiLGY3rxSz7yfLJ1ygIGlwOlzbxxFeYhG0g58YW/l5+Pf
X-Gm-Gg: AZFdTZdODGIKY63QeYQp0AlyEEq44qzLCHxcDt4pTWtT9WGRv0CDKNJvB27CmAu7ZxF
	NZPu8DSi/jLObaZG3u0iwV1vXjsH+7LQ77bukrCjXNhf0/NNNlEoVldnCjQo7keUaA3cAvvGs1C
	k08E/KpIlMJecGNIUdT1gSMRsNlt575u5rm4gmvS7Ilqm07m3qZG1PYxay37ZLYfGjONB0VZlZr
	LurKG8XToGZpO2SDCYq+yCnoDtrzeZJJrjnMLgn2gE6zNpLSjaiDeUO+mjnI4jBJ+HZBzufknmg
	LABtn7L7G5+1J/6BdMixFR8yfxxL/AyyJLbqdKDanolX4AR2nMdZC6Ch1Um84psNz5mRoCIiNZa
	v9otYRsdmYm/dgIMiQPEZrqAVZPMfmBoFo8TgCSYqYDFuhUeS+esz/u80YEHN0hYxV0xw09bxBM
	rhwFSvEiCHtbn+f6K8QMjkV0/hz7MongbUmTY7J8NeqBQi23LjYsyBZSnCRLIeuTmpDiwKmixEN
	yfW38ZAdujYLdGTSCZIbEV6qXJOm79s11g2TY7y8Q6twDbkKEX7iEjelF+UJFRl8XHLNdRBs/+k
	MLX4ugFfKrTu5gj/DgHcq8o/bph2J2tOv+IOySvs/DNIh3yoqTALGBWxYTT4DB7Cs8ibO9fEDIG
	ShV3C7w==
X-Received: by 2002:a7b:cbc8:0:b0:4a1:d49e:9ce with SMTP id 5b1f17b1804b1-4bb860f6ae9mr298157935e9.2.1795603344300;
        Wed, 25 Nov 2026 02:42:24 -0800 (PST)
Received: from ubuntu-f6bvp (lfbn-idf1-1-304-238.w86-195.abo.wanadoo.fr. [86.195.26.238])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-4ab6b2050f1sm33160630f8f.38.2026.11.25.02.42.23
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 25 Nov 2026 02:42:23 -0800 (PST)
From: Bernard Pidoux <bernard.f6bvp@gmail.com>
To: ertanuj96@gmail.com
Cc: Greg KH <gregkh@linuxfoundation.org>,
	davem@davemloft.net,
	edumazet@google.com,
	kuba@kernel.org,
	pabeni@redhat.com,
	horms@kernel.org,
	ralf@linux-mips.org,
	netdev@vger.kernel.org,
	linux-hams@vger.kernel.org,
	stable@vger.kernel.org
Subject: Re: [PATCH] net: rose: fix OOB read in CCITT facility parsing
Date: Wed, 25 Nov 2026 11:41:57 +0100
Message-ID: <20261125104157.265662-1-bernard.f6bvp@gmail.com>
X-Mailer: git-send-email 2.53.0
In-Reply-To: <2026112418-freebee-tasting-68ba@gregkh>
References: <20261123183818.24508-1-ertanuj96@gmail.com> <2026112418-freebee-tasting-68ba@gregkh>
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Post: <mailto:stable@vger.kernel.org>
List-Help: <mailto:stable+help@vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
List-Owner: <mailto:stable+owner@vger.kernel.org>
Precedence: list
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Hi Tanuj,

Thank you for the fix. I take care of the ROSE code in the out-of-tree
repository Greg mentioned, and I run these modules on a small ROSE/FPAC
network, so here is a review.

The bug is real. rose_parse_ccitt() never checks that the 0xC0 entry
fits in what is left of the facilities field, while
rose_parse_national() does. I reproduced it in user space by building
rose_parse_facilities(), rose_parse_national() and rose_parse_ccitt()
unchanged with AddressSanitizer: a 4-byte facilities field
"00 0F C9 0A" (CCITT, DEST_NSAP, l = 10, the 10 bytes missing) at the
end of the buffer gives a heap-buffer-overflow read in
rose_parse_ccitt() (the memcpy() from p + 7). With your patch the entry
is rejected and AddressSanitizer stays quiet.

Two points in the commit message are not right, though:

- It is not only 6.12 and older. 6.18.y has the same code (checked in
  v6.18.65), and so does the out-of-tree repository.

- The data read past the buffer does not reach user space. When
  rose_parse_ccitt() returns more than it was given,
  rose_parse_facilities() catches it with
  WARN_ON(len >= facilities_len) and returns 0. Both callers,
  rose_rx_call_request() and rose_route_frame(), then clear the call,
  and the facilities struct, a local variable, is dropped. getsockname()
  and getpeername() never see it. The user-space test above goes the
  same way: the WARN_ON fires and the parse fails.

So the effect is an out-of-bounds read of up to about 20 bytes past the
facilities field, and a WARN that any ROSE neighbour can trigger from
the air or over AXUDP with a crafted CALL REQUEST, which means a reboot
on a system with panic_on_warn set. That is still worth fixing, and
your two lines are the right fix.

As Greg said, please open a pull request at

  https://github.com/linux-netdev/mod-orphan

with the commit message updated as above (and the answer to the netdev
bot's question about how the bug was found). Once it is merged there,
it will go to the stable maintainers for 6.12.y and 6.18.y with the
next batch of fixes from that repository. If you would rather not deal
with GitHub, tell me and I will carry it there with you as the author.

Reviewed-by: Bernard Pidoux <bernard.f6bvp@gmail.com>

73 de Bernard, F6BVP
