Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=103.168.172.150
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1793825492;
	b=h9zLNya0m2r38T1tCYNJG4BTGaEyZyESxQMVR8ud0TIPOrwN2BTXA4xDG4Qluheb67fI
	 lKcy+bsY/n5PM+k5hApp6K9kKLRDsqHT4WxFC/EAXInEVqQierEuzpGVKyif0EylExZ+6
	 I/6Q1UgDi7Vc1j78QnB26EIF+fbfaY/1zJiWVsbP+gnr/52OEpzWVO86ADin3TLONS7zQ
	 0g6rKhmUIT1pLir1fjJbbm8VdaO7s07oMv20EmPzbl1FH37DTV4XcfY/OFS3FtnRctVmb
	 Z1/+mcsiiL0vq3R5EWlActI6V4rgzyaILpDihoWtFJcQoQ1g8VWENiW1Hab+uzNRdtg==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1793825492;
	h=DMARC-Filter:Received:Received:DKIM-Signature:DKIM-Signature:
	 X-DKIM2-Info:DKIM2-Signature:X-DKIM2-Info:Message-Instance:
	 X-ME-Sender:X-ME-Received:X-ME-Proxy-Cause:X-ME-Proxy:Feedback-ID:
	 Received:Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To;
	bh=5ARNwOdvrYvQiGx4TlYJQhp07t3CqrBtqMxbX6T0d5o=;
	b=zhk0EF6uqeYzCwxzP8g9fd9R5sd1uZcrPams/S4j5Q9lGTNtJ5mNy3pab+S5CDYZBCHB
	 MfUoVLL8LduBpeMtwRLEjO6H7G5B/aovNAurZigPmp4vy042L6VUgMQuE84H66m5fHdKe
	 1yVYSk7FE82ezJ1yCLI0jBSSxpCPi/PDuIxTr3LM2h1bLItpNe+j8Xpis6nvQ3bEdDhD8
	 kh3CqTUkQcdueTm/vYXnxuzN16JhyzLspt1F2pyPV97Q8bDbCr7hzQSbUx372AfD8DmGt
	 R6ZZIgdd6SkJUmGHqKphqnDZ5R2805KgoBj7W5Nn1EYnw2BXtHVD6YprQsL3rYZsnKw==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=kroah.com;
	spf=pass smtp.mailfrom=kroah.com;
	dkim=pass header.d=kroah.com header.i=@kroah.com header.a=rsa-sha256 header.s=fm3 header.b=l0ZFLaRY;
	dkim=pass header.d=messagingengine.com header.i=@messagingengine.com header.a=rsa-sha256 header.s=fm3 header.b=KvpfMkI1;
	arc=none smtp.remote-ip=103.168.172.150
Received: from fout-a7-smtp.messagingengine.com (fout-a7-smtp.messagingengine.com [103.168.172.150])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 975256078037
	for <stable@vger.kernel.org>; Wed,  4 Nov 2026 20:51:31 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 975256078037
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=kroah.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=kroah.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=kroah.com header.i=@kroah.com header.a=rsa-sha256 header.s=fm3 header.b=l0ZFLaRY;
	dkim=pass (2048-bit key, unprotected) header.d=messagingengine.com header.i=@messagingengine.com header.a=rsa-sha256 header.s=fm3 header.b=KvpfMkI1
Received: from phl-compute-06.internal (phl-compute-06.internal [10.202.2.46])
	by mailfout.phl.internal (Postfix) with ESMTP id C89E7EC0223
	for <stable@vger.kernel.org>; Wed,  4 Nov 2026 15:51:30 -0500 (EST)
Received: from phl-frontend-03 ([10.202.2.162])
  by phl-compute-06.internal (MEProxy); Wed, 04 Nov 2026 15:51:30 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kroah.com; h=cc
	:cc:content-type:content-type:date:date:from:from:in-reply-to
	:in-reply-to:message-id:mime-version:references:reply-to:subject
	:subject:to:to; s=fm3; t=1793825490; x=1793911890; bh=5ARNwOdvrY
	vQiGx4TlYJQhp07t3CqrBtqMxbX6T0d5o=; b=l0ZFLaRY1Gpx1kf0xF8AhMpeTW
	JxD0Iyg6HaPhWFQNhvnZQ60Lx6YAhC+1B18byH8H84Atxhdm0/JbkqPc19Hj/rqD
	khZktPnlYKYvL8IHHSQUELkR4mq9o4AG3EElk7dS09AyMMUCmmXAiwF+fTbc8BJg
	mG1Brpl0FpjI6bGQPw+4+Hbe5vTfgtngW+rC0SbxLRa3rsI8xlm6VDmSnqyOem2B
	QxWAOtHobm3iRqMvJ5N4d9HX/UNZTCtaMljuLPKpd2itTVJ4QKPJB8p+qW7LcQch
	4oNG6cHcdzlQMSPfjaTgNA2r90jeruE4KyFUe+4AH9VvPuucw9xFA/beeWaw==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:cc:content-type:content-type:date:date
	:feedback-id:feedback-id:from:from:in-reply-to:in-reply-to
	:message-id:mime-version:references:reply-to:subject:subject:to
	:to:x-me-proxy:x-me-sender:x-me-sender:x-sasl-enc; s=fm3; t=
	1793825490; x=1793911890; bh=5ARNwOdvrYvQiGx4TlYJQhp07t3CqrBtqMx
	bX6T0d5o=; b=KvpfMkI1UN4zz6YkNrWQd1SDgVnnk4hlOOd8L7kTg1rTfPZbDT9
	6V1zKS4FJu8gaKFi4Os+DI1wgoEtQJUGXGuuzH9Fcx3tBkZfFuqAIuXuiNW2GiVu
	iZNYk8blTddzYiNk92qtG64Ssl8UvR41bwJ6hwZbYRNdGtWQou9FRog4aPRP+oqr
	oDui/sxh6XfzKWxihZY2zOtzpeyAt6Pb/4G7tc3Ja9HYfyCezgkXX+M66nCwV+WO
	6aCgb2fUHt1QEPFlCJs0utZodLaLtPUCoiAkh7gfLZWul+nYXBBECYfCFyu/VJ67
	8a9gHndgfOSFNTYxyD5nJ2clPU7XJm3fU6w==
X-DKIM2-Info: draft=ietf-dkim-dkim2-spec-08;
	repo=github.com/dkim2wg/interop; date=2026-10-28; sw=lmtpprox;
	action=sign d=kroah.com a=rsa-sha256;
DKIM2-Signature: i=1; m=1; t=1793825490; d=kroah.com;
	mf=PGdyZWdAa3JvYWguY29tPg==;
	rt=PHN0YWJsZUB2Z2VyLmtlcm5lbC5vcmc+;
	s=fm3:rsa-sha256:sltd0Zsv064iHPD9qPv/ayo7x8XYQeaJU0sUcQsXVqIGkda
	Wry5+NH3dnTRj8//7qZ0hUJI+i/XsW50Ppwn3Pqk7QVBJohDXj3pZf4lAgYBbeu/
	Vn1/LxBd0ldxZ/zO1T81Mkqw4htNRc22NqIkMe51pv/pGttrUKh9G0/gU8p3MY1h
	epzP0wDWv8sMu+sEjoQMIIFOTWk/IM5VoBdLalL5AqOlcAw8eRWQZbHTmPMPSn+V
	Kg988y1LI6iVc2a1gH4zSph6XR2LDa3FrDP+MrgNkhUkhqg7VgHfF0UwD8YsR57J
	1uvE09bPtCt74TWGFI5AK8vzsxc/lF5cqWDKSfQ==;
X-DKIM2-Info: draft=ietf-dkim-dkim2-spec-08;
	repo=github.com/dkim2wg/interop; date=2026-10-28; sw=lmtpprox;
	action=mi-m=1; hc=12;
	hn=cc,content-disposition,content-type,date,feedback-id,from,
	in-reply-to,message-id,mime-version,references,subject,to;
Message-Instance: m=1; h=sha256:aVUhEEwxRsVS9f+gS61A4f1PBPl9ETmDGyVqsxHcp20=:F5sbrnoy/BIfctAE0xWVoa+mrJjXGBBtcBiHjNuC9Ls=;
X-ME-Sender: <xms:0prragnYLRJzhmCIzIzoX_zZ-B4NxR-KKSK4GvRS75tG5b8lDOSvyw>
    <xme:0prratofCb3ktQs-Ej-mkLuJmeDEzFdyeAY_KWrgM9gdo84aX_1Q_FZXoAceReKCQ
    7vDmkTgDriJ2Z3HzDAfZp9Qqrw83qsFbhiZeS1BQjgADvBZ8EE>
X-ME-Received: <xmr:0prrapGhucW6uq0YUfroHdCvVYEHgvV0iVJpCJw774eTbtH12aAzuIEgZmjOQg>
X-ME-Proxy-Cause: dmFkZTGljoZjnEU+DgRZoCFzHqd+hrasLg5mDnvldzMjo+MDPkJ9b0k80O9OpRKKu5KgpJ
    GjOSlghqPeWW/8OhWvTC1Grdwcu08kaqeCiQQNmMrOk8EXXweGoRUVSacUl5p7b9GiO9cQ
    sXEsfSkXcgytXZmJ0Sf9rKq1AXcDFU1Rek3V4r6TQf3EUxFDN0DhR3JXbzpK7/m1Q9MuI0
    leecPM/OLF5pzjzSo7kKbvYreLuJGW51YSepG6GRFpnDtapzpq9yztQOaNRlJ57fv6hpc6
    Rg3ktt83tlfBsEskQ/HuYeKTSSD/eLt2GSseY03HBQBrJmI8KY11SwOUs2p0bLOYRHlMEz
    XU7jP/7A2OD/L0q2Cgl4C4vtYLOdBrJq4XlpVdBZOUAYfFD6T7DftfW6BrnBrJbDRra4cq
    z3ZGPBVq6w8ZJyETi0aL+Th5pcr4aCKLaGD3vGrievtSYRcBIdLwsoMLZFw0Sw+fw2Z/Kp
    +2OJzNClcG/DlTX+vkN0vI5VbbkS/CV+UkJuuNnSBB2Ia7GyDHFPy6wOH8yw7RrriqTF9u
    z/ix7JIabWm3PgZO4vuRkEGkzCuAO7HE/vLdFEh6yp4+4Z2uKpZ22T+Tq5xT31yM0cUlPV
    04qBf/dSheWHk9GjWKB+wkW167XlX8aRp0kjTsmvITc5RZmyq3Iv5qfSFjqA
X-ME-Proxy: <xmx:0prrapxedPWddPq6o5tPcQUp9gMGcoKpWKzRsWVojgTBZFhbXtNqiw>
    <xmx:0prrauqDRxdpQLJLr1PJ2fGi97WGvKROYY2Sq_QM7wet4CcPeL73rw>
    <xmx:0prrajhN3Mw1iQYLapA3GQl42xDgl8nELZ9zw8dj2itQcVQ3NJWggA>
    <xmx:0prrarjD34nvOtvPgZy-Nt4rNmW_dRYjfAJMRURFFplcTY6E-UJ7lA>
    <xmx:0prraowCr9XQC0C_w6jMIA6nCOp47fPM7za8i9rdq0Ngq6UQbOeIYSRr>
Feedback-ID: i787e41f1:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Wed,
 4 Nov 2026 15:51:30 -0500 (EST)
Date: Wed, 4 Nov 2026 15:51:22 -0500
From: Greg KH <greg@kroah.com>
To: Jens Axboe <axboe@kernel.dk>
Cc: stable@vger.kernel.org
Subject: Re: [PATCH 6.1.y 0/8] io_uring fixes for 6.1-stable
Message-ID: <2026110410-coasting-snowplow-6509@gregkh>
References: <20261104184328.516206-1-axboe@kernel.dk>
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
In-Reply-To: <20261104184328.516206-1-axboe@kernel.dk>

On Wed, Nov 04, 2026 at 11:43:20AM -0700, Jens Axboe wrote:
> Hi Greg,
> 
> Here are io_uring fixes for 6.1-stable.

Thanks for all of these different series, all now queued up!

greg k-h
