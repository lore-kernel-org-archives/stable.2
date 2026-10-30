Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=202.12.124.152
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1793349722;
	b=Erz+ymSjv/CC0/0PPN6zDVCHnlvvXV8mYd+ktvaximJ+T6WZG6e8MnBRBoRpofF8MOp1
	 vFmxlLyb1b0yYewcL7XQTabmNKcEtpMUir0qCxSR3bR/AkAPh1NBtiTcMkpAtgtzmGvcy
	 Mh5o+JExZmZUCWFK+4PiPdjZXSViF+ds/A7q5uegiHy2HUx5I9nxfQFM8DTIrRQFJW+tv
	 ZZNUNbG09CYuRZejZ9yHm9F1Xm4vt3T4nJtGE19KPksFwChAhcNJfv/JlerOd145ag7o4
	 rqU5gWINcwMvA57s6fcri/hQn/x3KQML1gU4X8xmvrXYnB2iEx2KQ3rc0pz7SgprxRg==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1793349722;
	h=DMARC-Filter:Received:Received:DKIM-Signature:DKIM-Signature:
	 X-DKIM2-Info:DKIM2-Signature:X-DKIM2-Info:Message-Instance:
	 X-ME-Sender:X-ME-Received:X-ME-Proxy-Cause:X-ME-Proxy:Feedback-ID:
	 Received:Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To;
	bh=ARJ15mdeREyNnE2u2kKZxdnkAPx9bQsf/6ya3TNK7hE=;
	b=KMDbKwcH19H7NPy8yWRtztmqh72beyyLo8ClTJ2SJQMhCTHIM/P+uK54BBhJlUs8hnp3
	 YBYQhdqt+7oDybSB6+9JOFR4pfFniphHI8vLlQASOMe0TqJwZ+NJ3COsJafHdJHLNO6+Y
	 IVViGDGHVRpDdXLUTkfpgH5auWFjPCTgZ2dAHNXf7CFHWtugyF7nDbZiDJl6oZsro4E4b
	 cobFJSkHuWp3njRs2ULkIiM5YIJnoWUX5ZtnRON4P9lHIouJRm57uls0LzcgjR22QBws7
	 GLkQ5RU9lujHPNBdwrl+IT0UlMIUZHrpKh6e5k/97tXa556G9IJHzOiHiGLpcIQImaQ==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=kroah.com;
	spf=pass smtp.mailfrom=kroah.com;
	dkim=pass header.d=kroah.com header.i=@kroah.com header.a=rsa-sha256 header.s=fm2 header.b=OAYXyZMN;
	dkim=pass header.d=messagingengine.com header.i=@messagingengine.com header.a=rsa-sha256 header.s=fm2 header.b=fXkhUOdi;
	arc=none smtp.remote-ip=202.12.124.152
Received: from fhigh-b1-smtp.messagingengine.com (fhigh-b1-smtp.messagingengine.com [202.12.124.152])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C36B9606A31A
	for <stable@vger.kernel.org>; Fri, 30 Oct 2026 08:42:01 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org C36B9606A31A
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=kroah.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=kroah.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=kroah.com header.i=@kroah.com header.a=rsa-sha256 header.s=fm2 header.b=OAYXyZMN;
	dkim=pass (2048-bit key, unprotected) header.d=messagingengine.com header.i=@messagingengine.com header.a=rsa-sha256 header.s=fm2 header.b=fXkhUOdi
Received: from phl-compute-11.internal (phl-compute-11.internal [10.202.2.51])
	by mailfhigh.stl.internal (Postfix) with ESMTP id 1D1FC7A0126
	for <stable@vger.kernel.org>; Fri, 30 Oct 2026 04:42:01 -0400 (EDT)
Received: from phl-frontend-04 ([10.202.2.163])
  by phl-compute-11.internal (MEProxy); Fri, 30 Oct 2026 04:42:01 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kroah.com; h=cc
	:cc:content-type:content-type:date:date:from:from:in-reply-to
	:in-reply-to:message-id:mime-version:references:reply-to:subject
	:subject:to:to; s=fm2; t=1793349720; x=1793436120; bh=ARJ15mdeRE
	yNnE2u2kKZxdnkAPx9bQsf/6ya3TNK7hE=; b=OAYXyZMN4E9BdlaJETuSRUVd09
	SWGHqIDP8M47GxRfSi7HhgOTnndIsjXrcQLBjAdwax09/hoBV2j2xnTBLMc+b9JP
	Z9Q1hYPXGcNTObhpGN0ri7hwXNIIich7rsxzXZ4B74/tGymmKcINSKK7EII+E+AQ
	kqbzYnun9fLJmWZsZpozoph5oPxiR71LtizWkgxEw2yqrTYBI+mYa2jqns4uT+z4
	3unVECIbHHhkmsb4fsgKue956sMMf763aRYH2nX99ewnQQxDiL5H6FJ8IM0rBHEn
	2YPd6sB3in/M2R7sB7rQdrI9oHZ8ju8gM5o+ogYwczOZdYwdKKqcE+AY30sA==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:cc:content-type:content-type:date:date
	:feedback-id:feedback-id:from:from:in-reply-to:in-reply-to
	:message-id:mime-version:references:reply-to:subject:subject:to
	:to:x-me-proxy:x-me-sender:x-me-sender:x-sasl-enc; s=fm2; t=
	1793349720; x=1793436120; bh=ARJ15mdeREyNnE2u2kKZxdnkAPx9bQsf/6y
	a3TNK7hE=; b=fXkhUOditHjCZyJbUFzTxKjML8ox5We2xQv+rBIiyHzF0hoDb6O
	usr/V1NN6PDAbNUhb94Ro4QOy44y72DUiTcWJwtKAJOzMysrNnuqb5iaZy1xfHNw
	ZEyqNPvYa0IPAoE3SAKlt4IuB+avwhhmzPYdIY4aFt9jFAeBZ5HH5EZWwHMkPl9L
	Fk23a+pnQ3CfpWclLy/ZN4a48YgTBNkXYQDJii+qZDn8+TgK0IozJr/aadU5l0sU
	znUo9JU+1w8WOKnbKodYtZ2SASUagDwKE3LbocoTnGZ05p4MhvMvFBTjz3RCVOcm
	t6UxOBJpahEzCORJYRvyrExZl7veD4PJTOg==
X-DKIM2-Info: draft=ietf-dkim-dkim2-spec-08;
	repo=github.com/dkim2wg/interop; date=2026-10-28; sw=lmtpprox;
	action=sign d=kroah.com a=rsa-sha256;
DKIM2-Signature: i=1; m=1; t=1793349720; d=kroah.com;
	mf=PGdyZWdAa3JvYWguY29tPg==;
	rt=PHN0YWJsZUB2Z2VyLmtlcm5lbC5vcmc+;
	s=fm2:rsa-sha256:SXOY5hHgsXmGsWSSvNW6seHPlynJN0xYwaeylNz75EysC+8
	uTkhXBjafxZd1V9KMGKlhd4LHDdJNGnp9WggldW60+L7ajRibQ0rskFxuQGhqg10
	k5+GAAtBAwUPYnHGcfFoM0vSnlwplshYEs1l0mX45i39yIKaTbySehMG3ukDLPdz
	tA8CkdJnt6hE39bRxV0I0CJrBZgx1QUhxkM9XP9ljIcHw6Yjkj2uZLvzmm7FOuD3
	dh5Buwtk/c4tYwS/xsS3BBd2nUMFIrlZq0BVJ3DUmgXL+u3oQdfavbXYGOeEQwL+
	gT6fKGBNmY/u/UlU9pgtnqjo2n1s781VNpzHa9Q==;
X-DKIM2-Info: draft=ietf-dkim-dkim2-spec-08;
	repo=github.com/dkim2wg/interop; date=2026-10-28; sw=lmtpprox;
	action=mi-m=1; hc=12;
	hn=cc,content-disposition,content-type,date,feedback-id,from,
	in-reply-to,message-id,mime-version,references,subject,to;
Message-Instance: m=1; h=sha256:p94mfcIOuvnJpouhvaSuVwXoCoRAQzIH68/n4A6P6WE=:bx+BtOH9ORjGd3/2gM5+0yFHzfErtv3GEEckvgbQRMU=;
X-ME-Sender: <xms:WFjkagJRhN-gGdjfo6xwB0zcVXML-1z-R69b7R5H8fpWrIHIO-eITA>
    <xme:WFjkape541mHImEiJyUGFu1GZlGVcQspe1Bv5_PZ6cQZWy7q8WZ9ui5yB9jyh4l5N
    4lU0_TwSBGJbTb7sbYDdP9PhUChnA9aZKl2IaC1sLDUKCPLvyw>
X-ME-Received: <xmr:WFjkan9-XU5g8FDYJ7MqpfeTs4qnmiDjI_sNpNwZDgdZEYl-mQ8wyhPvHBWdqhmr2p4LUQKJcl9VXq-WQTTW8a8v-7BKlWFrgw68FAUyyVU>
X-ME-Proxy-Cause: dmFkZTFpUuSM5RrsrW6yGSEwkkhmhRoPFXd5DJWbcBnD5ksJ5uqje7PMThUh9QqCT4vaMH
    vMioUiAiTdcDoUbaifAfyk6rZYVaTL3uuuTcFGglJsJcowKosDTm+aVjqZG8kdMQaQH2pA
    xFCKl0Bzk9cDkerH3gMJB9Nn11DtIA/3lAZX2Xu5L3SrntcOjE0FLp/OETaOst0NCCVKOs
    eLbBQmvK8e9TUBM3PJfyreo4J8sgTwacwyK7n4hJiXPcwUDUFPmCDPOU5UDlYmvbY8uLYx
    T5dmZ9fdWrYY9KG665pImJ0REXf3D6mSpF29YRQfHqvL7ogU9ecxPw/wZZ1oNjjzaAfaOz
    BhBx22BnXw4uon0e7DuZJpvrILyYHO/V6Uj6voAME7ETW0SUdcX07RtMD97DbhACz/nLr0
    duRztjnAhchEjxnVyBnAydgYs0c6gqFw5gEtX27LFtbwKTZLJGY2R5UOK2KeHON/WsSgrU
    FFvrphZcAfrB2LU22S+SLcuYRj0eYnUtIH8tMwQmCB5g7FvumPZ8Hzx+0iYrZlow+2kYt9
    SE6gpwg3/gR9imq6nGc1IzEEMcqIvse6SBnmBwvbKQlh4P056I/EcBkmGr4xw7ZY6fOauE
    EE6FT08YlX6/0XtEuMXfziLZ7Ad8PQrwuUNzn+JaBU/hP+Czz61wKWyyp4mQ
X-ME-Proxy: <xmx:WFjkauoUuasqeMKscCBo_PVr7_Ij-4w89GQvSdwJYbLJhgt-0kKp-g>
    <xmx:WFjkakCaWKhRhxF15nq4az818rjuI57c36uYOA0dUUd8F0t6C4W8kg>
    <xmx:WFjkaowxHfq9pDMUrUyVoSNOlNi_4dtvlFBr4RRgJXYGLfGp9dgO1A>
    <xmx:WFjkap28Rbl_pHRUA4Pgf-IOBUVSLOZJtdngfwmzkLDYD0NTszBD8w>
    <xmx:WFjkauZelrJ5N04k4gXQ0lZs4ChXp_JZt8V7nywhhv4BNRXZ2EBnZQRq>
Feedback-ID: i787e41f1:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Fri,
 30 Oct 2026 04:42:00 -0400 (EDT)
Date: Fri, 30 Oct 2026 09:41:57 +0100
From: Greg KH <greg@kroah.com>
To: Jean Delvare <jdelvare@suse.de>
Cc: stable@vger.kernel.org, Guenter Roeck <linux@roeck-us.net>
Subject: Re: [PATCH linux-6.18.y] hwmon: (lm90) Consistently use our own mutex
Message-ID: <2026103057-sinuous-halves-9ba7@gregkh>
References: <20261030092410.0e585c82@endymion>
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
In-Reply-To: <20261030092410.0e585c82@endymion>

On Fri, Oct 30, 2026 at 09:24:10AM +0100, Jean Delvare wrote:
> The backport of commits b09a45601094 ("hwmon: (lm90) Stop work before
> releasing hwmon device") and 873e919e3101 ("hwmon: (lm90) Add lock
> protection to lm90_alert") to stable branch 6.18 makes use of the
> hwmon_lock()/hwmon_unlock() API. While this API is available in
> kernel v6.18, the lm90 driver was not ported to it until v6.19.
> Mixing the use of different locking models within the same driver is
> unsafe and should be avoided.
> 
> Update the backports to consistently use the driver's own mutex.

Oh that's going to cause problems over time, right?  Why can't we take
the change that did the port instead to make this easier to maintain,
otherwise we will be hitting this problem constantly for any changes for
the next X years that this kernel is alive.

thanks,

greg k-h
