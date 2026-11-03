Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=103.168.172.150
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1793736486;
	b=OeFWJWvDM61aUNYsKTZg1P7HpyQtOz9eYCNRxerW/34OIXbDzaSe2jEKol/B9J2BlgSs
	 DS7q5TIyIGjkmqC+WZRSrqR7kNV/7tMr9VrZspEjy8ePJ+sdbvpJunLciJucdlNQVb1cY
	 dIIvDBy8yxn0efEIiIUu06RDVqaQdL6zs1ZpsPvySm0rOb3FHi/GVKmDJh9DuJnlBKn4r
	 MXHNxo9QEBRG6ihrb4EAt6VnKhSWOz2o/4CVEEsfoVE/MHJfLCRihVQoPaZ+DB7KNvhMH
	 vZeJ7m7GWZiZ1S3I821SlWUlehrsAtZPbQQ+28Emz10gORKJV90L1xAnfTvGuEPaLqA==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1793736486;
	h=DMARC-Filter:Received:Received:DKIM-Signature:DKIM-Signature:
	 X-DKIM2-Info:DKIM2-Signature:X-DKIM2-Info:Message-Instance:
	 X-ME-Sender:X-ME-Received:X-ME-Proxy-Cause:X-ME-Proxy:Feedback-ID:
	 Received:Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To;
	bh=SqCMJqdbcuE3dxyuIYL71YEmgFby0czZ2Kvgqp0XsTs=;
	b=JUSQ7G4bpEtqaSzvQ0D1i2ealTTfUAV2IbbfJe7ExsEomjVBy6WfVPRrdEC5HyIwHXgU
	 KbgwUXg1xTB9b9uT0pf7tEZzNxs1wZxnRmTlKTYuUdje63qz5lk9m9eZ5tYgPFwc84haZ
	 mja+JDvuF3S0foydepD6r/TVASOi20puGb9tTewtGFCEjfwYTBFjJzk44fNsXoCgFhgnG
	 zE8O5MsYvAt59gkv6nQlFnpLacTPX8hbO82FF71V0jcqtbgFzNAI0aPyR8GoVPe3oPalq
	 y4prWtGZDfjCRcdR6fcm6h4lZ99nHsojZ1RMQImrX85vXVokRypvjg8WcA2ediOJY7g==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=kroah.com;
	spf=pass smtp.mailfrom=kroah.com;
	dkim=pass header.d=kroah.com header.i=@kroah.com header.a=rsa-sha256 header.s=fm3 header.b=OnlEWLfv;
	dkim=pass header.d=messagingengine.com header.i=@messagingengine.com header.a=rsa-sha256 header.s=fm3 header.b="T3f/deaD";
	arc=none smtp.remote-ip=103.168.172.150
Received: from fout-a7-smtp.messagingengine.com (fout-a7-smtp.messagingengine.com [103.168.172.150])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7D489606A329
	for <stable@vger.kernel.org>; Tue,  3 Nov 2026 20:08:05 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 7D489606A329
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=kroah.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=kroah.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=kroah.com header.i=@kroah.com header.a=rsa-sha256 header.s=fm3 header.b=OnlEWLfv;
	dkim=pass (2048-bit key, unprotected) header.d=messagingengine.com header.i=@messagingengine.com header.a=rsa-sha256 header.s=fm3 header.b=T3f/deaD
Received: from phl-compute-04.internal (phl-compute-04.internal [10.202.2.44])
	by mailfout.phl.internal (Postfix) with ESMTP id 9A1D2EC067E
	for <stable@vger.kernel.org>; Tue,  3 Nov 2026 15:08:04 -0500 (EST)
Received: from phl-frontend-04 ([10.202.2.163])
  by phl-compute-04.internal (MEProxy); Tue, 03 Nov 2026 15:08:04 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kroah.com; h=cc
	:cc:content-type:content-type:date:date:from:from:in-reply-to
	:in-reply-to:message-id:mime-version:references:reply-to:subject
	:subject:to:to; s=fm3; t=1793736484; x=1793822884; bh=SqCMJqdbcu
	E3dxyuIYL71YEmgFby0czZ2Kvgqp0XsTs=; b=OnlEWLfv0twqQFE2j/GumEhpZ3
	oYKRrWRjBdsCZ7FLMn9J3+xduGrQ20ulSyYHQeuG7qGUP1uIkP+bAWCGlg8e5zJt
	3raGqi0Ry2pGiCWnEgwi8tXMeyveO8RDPREcTGZtL18RJ+c7TkqEmsU+nQIt/oZB
	ik31R6pWhRUAcnDTQvC99nQdB3fuJ8of+lqH9bMfDdbV96dLhnKGdqkiDhaLcer8
	uNi5kmk1uX7Up9S/mmNNKMrMGLTp2VpCRNGyWn47q5MUZ1sipZeQTYy8tl6xoc1Z
	nxk1MNP/ll1lRnyjZ1XFIURnqVp7QXuXjhWyD1oLwJC1kHom/I059aDBnmdg==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:cc:content-type:content-type:date:date
	:feedback-id:feedback-id:from:from:in-reply-to:in-reply-to
	:message-id:mime-version:references:reply-to:subject:subject:to
	:to:x-me-proxy:x-me-sender:x-me-sender:x-sasl-enc; s=fm3; t=
	1793736484; x=1793822884; bh=SqCMJqdbcuE3dxyuIYL71YEmgFby0czZ2Kv
	gqp0XsTs=; b=T3f/deaDZ679sREsyiEXETUA85XkiWrsUfTuJ66AVM5YDI3QoXW
	IZlml7faB1g5wWONCZMFbJilC6d1C71BQQRh41tHPSzBF0TN7JK9zprusmCIQjIK
	npUs59qtx0h/tgDITtYjs/JPhP7YhziUnU6Xs+AnJcd2c/kGprwYzYgycQ5oUbr9
	KzaUoEFn+B7XC8JJSskPG8CXfUHeJqbZcyPQBUAc8iqOde7oH4o/vjyw/Rg8CUBe
	vGLHmAT3B0VmXDbeOQm7Pn0DragYKYQxJWRY1bDWQsmcwj5TEpi5DcmT8LHwiVK0
	jLr7+sA+vLCJZOhsZcpL6mUN2NOvueaBIfA==
X-DKIM2-Info: draft=ietf-dkim-dkim2-spec-08;
	repo=github.com/dkim2wg/interop; date=2026-10-28; sw=lmtpprox;
	action=sign d=kroah.com a=rsa-sha256;
DKIM2-Signature: i=1; m=1; t=1793736484; d=kroah.com;
	mf=PGdyZWdAa3JvYWguY29tPg==;
	rt=PHN0YWJsZUB2Z2VyLmtlcm5lbC5vcmc+;
	s=fm3:rsa-sha256:vW2+AIYuRQvbHqnGBzujG0W1XguIzT9blEdOaMh+qkHsLXv
	Stu2X2W9c2LZPfHXi7r7UlXoZPISSzLeVIW+rq7FZR6d1rfQt2rXwdph6DxilV5I
	Pdx+gn5KMLbjiuOMXHyq3ZdsEzNvYYAA8HE85dzBvPtL1COvsUT4EjPTJCGwAji5
	aIXsI/+3LW52VO05y2jfd0NX144JpiYxzYW1+lJt08Ti2MGL7oayqL0b39fANE1k
	6bsBqxmZEApUNCWQtfvkbjo+JyWVFUZ3iV1T/h7q2LdqJiurM2QMunnuAr0nhNWS
	USeaqrjKUJWJOecEyMFDtl3y6BIRocg5T3dE7Eg==;
X-DKIM2-Info: draft=ietf-dkim-dkim2-spec-08;
	repo=github.com/dkim2wg/interop; date=2026-10-28; sw=lmtpprox;
	action=mi-m=1; hc=12;
	hn=cc,content-disposition,content-type,date,feedback-id,from,
	in-reply-to,message-id,mime-version,references,subject,to;
Message-Instance: m=1; h=sha256:mT4z9dYTUt/qPsY6ean5sPmA7mJlLEOqXuE8QLbBFO0=:7q8CmXjL0fo0RDoRZZHTP/Up7w083quCwuGvbEuddvo=;
X-ME-Sender: <xms:JD_qambZwEYoq_BercHE63N7J0BAeFt_funWc-lghO6GiFl6XjtC5g>
    <xme:JD_qalQHWzjxVrtpmofpzzoRfuCB3cMyoVZb5xdZlGieJH4R9ZMONDTT67720Abg4
    uVCPoUr4iSdnnShi9GWNSURXoC5OKy_Qh5nn38KzL-JfAIAxg>
X-ME-Received: <xmr:JD_qat-xkjBtL6IDfft5krFCfIzpBhEcRAL9dBA4QSnKLhbk728rkL7YPdwwrdkLYvlrdR-DC61uRxyRIDhBl-fB4w>
X-ME-Proxy-Cause: dmFkZTFs6w/8zjAcmvHgG+y0ye07qTguRk9KO8Tc84YgCJmsHp5nIbFTtvJDYH/Z8I7Lkn
    4gFSdT0zermog49yrp6syOeEVd78Gxxo7OqahdQ+8nDzicYw1qwshMacAXYEnHgW15kPtf
    4tlIB7p/r1DIGA7ZbYQ4Htv1zUhjxtGAkPHqWDha+UVq8V8QAiMcrj0+y0jo4iiMPBkwY7
    8PKtMJlyd0KpMwAqhbulBlSsQG3jGml3YwEIMM3d2b8Tv5F8hOL4GsgEzomTGlTNE/DQbN
    /berg3pQSWfjQ8V8xrHcy8FPcOwE+JVSAUnwN84Hl9dvhs2n8hCR5uNNBQdUnz1s/SoWM7
    Hn1rJaHzvxxdJBf5fua7BIJvBJfnty+nFlbKfko2Ax9R4bktp+Qk/H/9jmtWh8YC9Vb0QC
    ijsFdDMhovj5oHVS/1AHlnIi9HOBjO6TYJNgrwxhrAs9RA3+ig4rE4W7Vv0c8pBKaLO+8K
    n6tgwswudP7z3dUXjvA8UxSftgcb79q4wgFHmrxz1hQSOSM7cNCaO0qhk2ODQ9kTfX/0LR
    EEBZvqIBVe7b+x0CkyIBsFMjwkVRAcG20xg1M/lux7Z8UaZjwhsqds4C4zmtphlAk+J50P
    dGIU23PxKcFz7/xsqzklBpW7LgDIrNNVWfQyAuNFaRS0CAol2nfBM/kSLoOw
X-ME-Proxy: <xmx:JD_qatiACZNAMAEz8urrWSHRsOSPRaTXvL20b2icRGUNuPaFNvGJFw>
    <xmx:JD_qamYlPwTbB5ygk1qcJX5JVEQkJ-CSXVcQrKriHloXunM4Jae-Fg>
    <xmx:JD_qaq_NMqv2QF_ubZF6UQ99RLaJcdKOLqhw_yoYKawGJZ-ie7ZweQ>
    <xmx:JD_qagNkSy-4WhpIAugPP_W4x6X8TD1zeItnNgpSPf2sk60MPU0XSg>
    <xmx:JD_qap2HSSTa8FVstm2qZhvbX3HNIUbAalingVlPYOUsl-h_BK-iSC0H>
Feedback-ID: i787e41f1:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Tue,
 3 Nov 2026 15:08:04 -0500 (EST)
Date: Tue, 3 Nov 2026 21:07:49 +0100
From: Greg KH <greg@kroah.com>
To: Fexiven <kernel@picomail.one>
Cc: Ulf Hansson <ulfh@kernel.org>, linux-mmc@vger.kernel.org,
	linux-kernel@vger.kernel.org, stable@vger.kernel.org
Subject: Re: [PATCH] mmc: core: clear MQRQ_XFER_SINGLE_BLOCK for new requests
Message-ID: <2026110338-tarmac-national-fdd0@gregkh>
References: <20261103192345.647483-1-kernel@picomail.one>
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
In-Reply-To: <20261103192345.647483-1-kernel@picomail.one>

On Tue, Nov 03, 2026 at 08:23:45PM +0100, Fexiven wrote:
> mmc_blk_mq_complete_rq() and mmc_blk_cqe_complete_rq() set
> MQRQ_XFER_SINGLE_BLOCK in the request PDU when a transfer fails, so the
> retry is done one block at a time. Nothing ever clears the flag again.
> 
> The PDU belongs to the blk-mq tag and is reused for later requests, while
> mmc_mq_queue_rq() only resets ->retries for a new request. Every tag that
> has seen a single transfer error therefore keeps issuing single-block
> transfers (CMD17/CMD24) for the rest of the uptime.
> 
> On an RK3576 board (HS400ES eMMC) with occasional data CRC errors, which
> are recovered correctly, sequential direct reads dropped from ~200 MB/s
> after boot to 3-10 MB/s within minutes and never recovered. The host
> registers showed only CMD17 with a 512 byte block size. With this change
> the read throughput stays at ~200 MB/s and writes at 60-90 MB/s while the
> data CRC errors continue to be retried.
> 
> Reset the flags together with the retry counter when a request is
> prepared for the first time. Requeued requests keep RQF_DONTPREP, so the
> single-block retry of the failing request itself is unchanged.
> 
> Fixes: d34124edffdb ("mmc: block: Use MQRQ_XFER_SINGLE_BLOCK for both read and write recovery")
> Cc: stable@vger.kernel.org
> Signed-off-by: Fexiven <kernel@picomail.one>

Real name please.

thanks,

greg k-h
