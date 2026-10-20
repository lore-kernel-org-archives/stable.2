Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=103.168.172.148
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1792532194;
	b=LgMo0K5XlAJI2mKsNAkg4C/0saoaH77rryxdYHMHR4Nla1cDKjsl3wBSqbA1oME9tR85
	 77I4Dmqn/xzPvly5BZ4NuNiWLExZlNiC7vGGn7GpPzKqed6VL69yZk99RoAnWqQSr1YIc
	 fyox4uMBH8VztnLeAMYhw+kCPfX3nwIbqB2Nkoz4mSEGZVVYAL6kipzFnu0YiryDNCCFy
	 jBKeEEZnpr0rfS2ctC7veHkfwplxllsy4++rf7p1lcKmyBbt6frz7jv/i4wI7yqtHSsdY
	 HMZNG/W6qZEiEmrC4bZLKg9WJ7oWS1qwbldiKJEJdoxNhTI6KsIGi19vQTPUFMoy9xA==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1792532194;
	h=DMARC-Filter:Received:Received:DKIM-Signature:DKIM-Signature:
	 X-DKIM2-Info:DKIM2-Signature:X-DKIM2-Info:Message-Instance:
	 X-ME-Sender:X-ME-Proxy-Cause:X-ME-Proxy:Feedback-ID:Received:X-Mailer:
	 MIME-Version:X-ThreadId:Date:From:To:Cc:Message-Id:In-Reply-To:
	 References:Subject:Content-Type:Content-Transfer-Encoding;
	bh=0GbSbxcF7mqk/j5zgXa6M00AnGq+z6SkEGan9KfTiYE=;
	b=gsTp52dn7k/Vy0147B+ltlAXFeVJkzAYU5YRbA7bTBb3EZ7h5CjyVls+QeLUqgnwaLWe
	 QqHyaXbLVX3c+VyrpO79JBTU0f+gTE8svwdCmb/FtXicktuKhgBHS1gbjhU4+v3yAAhL7
	 GLq43zIqStrT8lJv/mxzIRTISUhRmY7AlKm9bIr/gfGkGgn9G+gdjhAFwKF6udkVFBFGa
	 kBNntSrsSw/BV6yg+JUPHYJrFFIV/OIGY5wvzrvXL7LWSm74jl7i17Zku0e8bqRhJlD55
	 ZCxti5H44DFP3IxLi0/KL34i6E5Kz0Z/oA6pz7nowW0T9vXy/MbjxAbfk279tNvLXiA==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=arndb.de;
	spf=pass smtp.mailfrom=arndb.de;
	dkim=pass header.d=arndb.de header.i=@arndb.de header.a=rsa-sha256 header.s=fm1 header.b=AdVZBQoz;
	dkim=pass header.d=messagingengine.com header.i=@messagingengine.com header.a=rsa-sha256 header.s=fm2 header.b="e79WIh/L";
	arc=none smtp.remote-ip=103.168.172.148
Received: from fout-a5-smtp.messagingengine.com (fout-a5-smtp.messagingengine.com [103.168.172.148])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id ECC94606A323
	for <stable@vger.kernel.org>; Tue, 20 Oct 2026 21:36:33 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org ECC94606A323
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=arndb.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=arndb.de
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=arndb.de header.i=@arndb.de header.a=rsa-sha256 header.s=fm1 header.b=AdVZBQoz;
	dkim=pass (2048-bit key, unprotected) header.d=messagingengine.com header.i=@messagingengine.com header.a=rsa-sha256 header.s=fm2 header.b=e79WIh/L
Received: from ams-compute-02.internal (ams-compute-02.internal [10.64.2.62])
	by mailfout.phl.internal (Postfix) with ESMTP id 187A3EC04EC
	for <stable@vger.kernel.org>; Tue, 20 Oct 2026 17:36:33 -0400 (EDT)
Received: from ams-imap-03 ([10.64.2.23])
  by ams-compute-02.internal (MEProxy); Tue, 20 Oct 2026 17:36:33 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=arndb.de; h=cc
	:cc:content-transfer-encoding:content-type:content-type:date
	:date:from:from:in-reply-to:in-reply-to:message-id:mime-version
	:references:reply-to:subject:subject:to:to; s=fm1; t=1792532190;
	 x=1792618590; bh=0GbSbxcF7mqk/j5zgXa6M00AnGq+z6SkEGan9KfTiYE=; b=
	AdVZBQoz9zsHKbgJiLmILkcBFD/venW3C5T3k9bUEIndHesl4KHxluW+DbDXh8KZ
	+gtbsJkrmK7JIr7+urE1mmb4I8QVCwwcQKQ++OKLrii8oYE16w2kCcmpi3Pr9MPp
	b9ev6u5EvAMlrDHoBYZwG4skgEFT2bGUax2J+XTozD/RyAwVsdW8ooLMO3Ulg0wJ
	r43BIJzMWXW6EmSggnntRlYqVhoLUCRKeIWb4yxFGhMDaTdkjkH95kSm7ZWeN0gA
	sBkBGgBQqsLlJU448Hoo9DCyVcN7oSn1JrxPOVSfIVrbOX34eY0oUVMaZilgAV47
	1XEK2cdid+y32yRfJzRL/w==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:cc:content-transfer-encoding
	:content-type:content-type:date:date:feedback-id:feedback-id
	:from:from:in-reply-to:in-reply-to:message-id:mime-version
	:references:reply-to:subject:subject:to:to:x-me-proxy
	:x-me-sender:x-me-sender:x-sasl-enc; s=fm2; t=1792532190; x=
	1792618590; bh=0GbSbxcF7mqk/j5zgXa6M00AnGq+z6SkEGan9KfTiYE=; b=e
	79WIh/L9qGP+EpT3hI2k5R+OQW6pDK44kNwimyu7VucRFyQZQvfNvooMHUgIiyRT
	C6juuHaqwq7wmb/yP3ImvX42UJTPu6wNovRmDiVSxkBHzpbvzoBJoIDiltpNqEia
	ozYlGHiumWEBiYnHpXxAM7yW1Q7nb9IkKnYH90XHQBNWCpc5WofDSksJoTdSx7vb
	lqjPfPa0YHdEFMV4ovz/pE9fboyxQgScbdOxzp+Nksh+pbA4cIZ9Ysn0z3upghsW
	gKw58EuxTw7DEMrqbB/9wBcx5aBUinteCSfDKoWJ85I/B2YNuK75pvAIjOBdyFrn
	9GcuTWdSSU7wPDRZwbJVA==
X-DKIM2-Info: draft=ietf-dkim-dkim2-spec-06;
	repo=github.com/dkim2wg/interop; date=2026-10-08; sw=lmtpprox;
	action=sign d=arndb.de a=rsa-sha256;
DKIM2-Signature: i=1; m=1; t=1792532190; d=arndb.de;
	mf=PGFybmRAYXJuZGIuZGU+; rt=PHN0YWJsZUB2Z2VyLmtlcm5lbC5vcmc+;
	s=fm1:rsa-sha256:D/OeaYaD5myiYWli+UxJqfAsPdOrQm7PTKse9hGae9WWj29
	9Ts2CriQ8BNFOt6mxmDeQ70/BV1P1Q+QMoVoE1bUPY1LOgbv/98oDObgA9mw3D/R
	uf8LMDtzmfQj+/CKykx9LunbY6ypwDOc8RpCcKTkN+4Q85M0ALKEu/tsLlHyp3ha
	alZSy2qH2XvPoXopYveup+h227S3h2KddAvDXhpehAFljJPG1ovMgdT24CDlHZyk
	GhiLrolc+CJq9b1lKECTwMh8556R1LqiOUcOfPYUgA/sF4lz8vk9MCfjQaGn+ciP
	xcEA3Ok+vZcMw/oSTvPHwFFEub8gWNHUfUC1Kbw==;
X-DKIM2-Info: draft=ietf-dkim-dkim2-spec-06;
	repo=github.com/dkim2wg/interop; date=2026-10-08; sw=lmtpprox;
	action=mi-m=1; hc=12;
	hn=cc,content-transfer-encoding,content-type,date,feedback-id,
	from,in-reply-to,message-id,mime-version,references,subject,to;
Message-Instance: m=1; h=sha256:1Ens3Vb2WEJuo5l6XGUwlSnDxgUirZOBZ7zFmckBBZI=:ef+akXHVMDf7SQcMykZ96WWptyVk1nyIOnthQ8jSqBc=;
X-ME-Sender: <xms:3N7XakNwf5lqCwskTIUcQ18HtZ11ZM5tI9STjrfJxWivbzRKyW7lJg>
    <xme:3N7XalzScU0ue0jbSQADmRNomaEwZ6YuaUqdxv2m_Y_gtnERB4_uF_PPAzumf9UIP
    9nMCfVCYD34lsQMAUfHgGCsqt4Sg5XLhwPegGmVmuwtYPSjjfCc8Xq->
X-ME-Proxy-Cause: dmFkZTGoMHb3d+Xh30/9DmivZ32y8pPIF08b/I3akBfROr1ndoXeA52Jr8CBxi2Yquzr+w
    c7QHtCaM6levoerK3vFkPRn7o1gkD1kDuIoK1wlQn0NxHtp67JeqdgnUbLLQptExQeDTiI
    7rTsRz5cdM4L1PzbaHKihqGeJs+2/CQMTG/oG6dvKe0zZEZQU5yGUgt8kPU1i9Ac1JRUFU
    zvCX8J5DuGNUFr36PJ0RHQrknGRECgTS3kz3WriSI364YVZnu/vjq26+/5/QNmki+qf/rD
    AxNrPuQKk1sPSvFmKmm6ExNJA6RK3767WlL5868MHwHOsBoV59KleOhz2I4AUIi3Iv99f1
    TBrBFnW0mXI0PeR0ivxLHNNsMTp2kBIfGVZIQ8AVekDJ9Gh1oicFPANCd/T4Xr6B9plMNi
    57GFTZQ4eBa/Nem119yvrbMe45i31fikkTXrtzqmJCgW3Q58DbwN1Y1EvvTs9pPYro0XcX
    M45QUtXXmQus2VHAMcZspY/OBEp/8GRLm2RnpQT0qIv7Tndkaz8+a2k644EIR72F7YwUFm
    GVG8AoN9BkL6TzY2p4P6Ov3Hy6zs8RHmKmBn1+mHUvKd67qZLa+M/b3Wp9RKAhsXWtZQj2
    Uwzedz368yXMYZqZnJ7pIuP5iMGH1URXl3tmKp5vrehS4OlT9N9VU+3Yd8Ag
X-ME-Proxy: <xmx:3d7XamZomFx1c83XVsdb24PLwPBgrhpFQ9mbVQPNkpJl1OSeBqymaw>
    <xmx:3d7XaiVxtBCSE2mnTenBfm3JUqZ-T6JromnBM2OMd0wQ4dmavrMNwg>
    <xmx:3d7Xasiy0PQcp12kYDykkqjiMaaoJp7_SNZ5Fpt9xyt-RuY3ezcTIw>
    <xmx:3d7XaosQTfUKZpZAKI64gBM9tKH5YH7a4lvlLdQ06Blu5sPKAh8vQQ>
    <xmx:3t7XamHEG5Jt2PSZa939BtR7aq-MEiEdJD9an6lBfQxovOP2Fs4VHvqu>
Feedback-ID: i56a14606:Fastmail
Received: by mailuser.ams.internal (Postfix, from userid 501)
	id 254B232A008F; Tue, 20 Oct 2026 17:36:28 -0400 (EDT)
X-Mailer: MessagingEngine.com Webmail Interface
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Post: <mailto:stable@vger.kernel.org>
List-Help: <mailto:stable+help@vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
List-Owner: <mailto:stable+owner@vger.kernel.org>
Precedence: list
MIME-Version: 1.0
X-ThreadId: AWltsBeAjQxZ
Date: Tue, 20 Oct 2026 23:36:06 +0200
From: "Arnd Bergmann" <arnd@arndb.de>
To: "Hungyu Lin" <dennylin0707@gmail.com>
Cc: "Andrew Morton" <akpm@linux-foundation.org>,
 "Thomas Gleixner" <tglx@kernel.org>, linux-kernel@vger.kernel.org,
 stable@vger.kernel.org
Message-Id: <735f670b-b93d-402b-8eb0-43826a05bfe9@app.fastmail.com>
In-Reply-To: <20261020210157.52057-1-dennylin0707@gmail.com>
References: <20261020210157.52057-1-dennylin0707@gmail.com>
Subject: Re: [PATCH] compat: Avoid double rounding in times()
Content-Type: text/plain
Content-Transfer-Encoding: 7bit

On Tue, Oct 20, 2026, at 23:01, Hungyu Lin wrote:
> do_sys_times() already converts CPU time to USER_HZ ticks. The compat
> path converts each value back to jiffies before converting it to
> COMPAT_USER_HZ. This round trip can lose precision even when the two
> userspace rates match.
>
> With HZ=250 and USER_HZ=COMPAT_USER_HZ=100, one user tick becomes two
> jiffies and then zero compat ticks. Every odd tick count loses one
> tick, so any of the four tms fields can underreport CPU time by an
> additional 10 ms.
>
> Return the value directly when the native and compat units match. Keep
> the existing conversion for differing rates.

Good catch!

> Fixes: f06febc96ba8 ("timers: fix itimer/many thread hang")

That one apparently just moved the code into a separate function, but
the bug was already there before 2.6.12:

+               tmp.tms_utime = compat_jiffies_to_clock_t(cputime_to_jiffies(utime));
+               tmp.tms_stime = compat_jiffies_to_clock_t(cputime_to_jiffies(stime));
+               tmp.tms_cutime = compat_jiffies_to_clock_t(cputime_to_jiffies(cutime));
+               tmp.tms_cstime = compat_jiffies_to_clock_t(cputime_to_jiffies(cstime));


>  #ifdef CONFIG_COMPAT
>  static compat_clock_t clock_t_to_compat_clock_t(clock_t x)
>  {
> +	if (USER_HZ == COMPAT_USER_HZ)
> +		return x;
> +
>  	return compat_jiffies_to_clock_t(clock_t_to_jiffies(x));

I don't think there are any architectures left that define USER_HZ
and COMPAT_USER_HZ differently. This was true on ia64 with x86 compat,
but that was dropped in v2.6.33 back in 2010.

   Arnd
