Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=103.168.172.144
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1795391139;
	b=4mIGoXSTQ6mE+Yv9VCacH7u/BKw8c3NvngSr3nVWrB5OFjGJxqsphgnJBwPLlwCRSId7
	 p7CZsFzfBHN/rHK2bwSqxRRAPj5Dp3x9HpVdvwKgD6Wm1bYIjMjrDERDMfGD3UVgdPAfi
	 2c1hWkAuRPnECHE8/cIYwonx8lo3rUSa5NCdU1bsmaAGFBMrkZYX1XJwFMwBOEEvn7URV
	 fT7JPy85VausTjBcSMbNY/5oX4A0e3lcTrHSs7I9HKt4Ii7cfQ4NTfwxFLHmgmm8mCGsg
	 zqttf+F9j656NGhgwjCc0ht4AN9U0teyouFz36NJ6lc2YD3Av5OwnzaOnx3T2t/151Q==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1795391139;
	h=DMARC-Filter:Received:Received:DKIM-Signature:DKIM-Signature:
	 X-DKIM2-Info:DKIM2-Signature:X-DKIM2-Info:Message-Instance:
	 X-ME-Sender:X-ME-Received:X-ME-Proxy-Cause:X-ME-Proxy:Feedback-ID:
	 Received:From:To:Cc:Subject:Date:Message-ID:X-Mailer:In-Reply-To:
	 References:MIME-Version:Content-Transfer-Encoding;
	bh=1fjKKCEnZwYosmBHPEBZrD2de+0UdG6NDmDLNg2rOq4=;
	b=UVysGhvs9wZsHFPYKefbr3pdLHAoGaU6gc0qkzSlxESvCS4dh1zWy6vXzQAAZ/Sh4SFs
	 s6Lsk80di0Y9dHTNuQMmoe/Uf2vZwEQnqo+CLOaEnw97qiYsMuBtw1eChvoOOlXBVNzH3
	 Pbqhgm7lsfMgLG/Lq8vNqG6PE8s8849BTn6J21VK9wY0pk1YlWpV7WNboXzqAeSr6n7oj
	 7hYkX95h414wyeO/melRO8YdebPPs6BD7wMWKmjNyffo8eLwoyTgJXHzYdD8s//wYxJuS
	 881DeGErrt3j1RYcbDVbpLXZn+/77HLPOFnkqU7n1jNl0oorb2u5rqBhYAmtrlqB2ow==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=none header.from=exultantmonkey.co.uk;
	spf=pass smtp.mailfrom=exultantmonkey.co.uk;
	dkim=pass header.d=exultantmonkey.co.uk header.i=@exultantmonkey.co.uk header.a=rsa-sha256 header.s=fm2 header.b=cli9yrWu;
	dkim=pass header.d=messagingengine.com header.i=@messagingengine.com header.a=rsa-sha256 header.s=fm3 header.b=fVumczo+;
	arc=none smtp.remote-ip=103.168.172.144
Received: from fout-a1-smtp.messagingengine.com (fout-a1-smtp.messagingengine.com [103.168.172.144])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8F64C606A31D
	for <stable@vger.kernel.org>; Sun, 22 Nov 2026 23:45:38 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 8F64C606A31D
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=exultantmonkey.co.uk
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=exultantmonkey.co.uk
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=exultantmonkey.co.uk header.i=@exultantmonkey.co.uk header.a=rsa-sha256 header.s=fm2 header.b=cli9yrWu;
	dkim=pass (2048-bit key, unprotected) header.d=messagingengine.com header.i=@messagingengine.com header.a=rsa-sha256 header.s=fm3 header.b=fVumczo+
Received: from phl-compute-01.internal (phl-compute-01.internal [10.202.2.41])
	by mailfout.phl.internal (Postfix) with ESMTP id C11B6EC08F2
	for <stable@vger.kernel.org>; Sun, 22 Nov 2026 18:45:37 -0500 (EST)
Received: from phl-frontend-04 ([10.202.2.163])
  by phl-compute-01.internal (MEProxy); Sun, 22 Nov 2026 18:45:37 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	exultantmonkey.co.uk; h=cc:cc:content-transfer-encoding
	:content-type:date:date:from:from:in-reply-to:in-reply-to
	:message-id:mime-version:references:reply-to:subject:subject:to
	:to; s=fm2; t=1795391137; x=1795477537; bh=1fjKKCEnZwYosmBHPEBZr
	D2de+0UdG6NDmDLNg2rOq4=; b=cli9yrWucWhH9/2waEFmvQGC+WTRzXvnEAgu6
	iYvtYv0xiDYuM69gBjKfrDtVBTP0qVTCmpbM7ixjvpkzlb17k3m+doSrCBFgiRjn
	GTDYzAagGNzFApNWqx+MWH7NjoYvw9WxmTvMcqAFJlK2u04nFr1Vu4EF9WHIeg/3
	j42ZwX3nu5i8HFsAwFvFk1YmGMIG1iD6fHFa7Fr0LEh2vtgZiJmqL5eWwe2RXExZ
	JGImyDBQgiJ3KYLEf5VXcCIF1+73NrD1ujfp1Uwsj71NGflDm0Bq9T0orWvQMJqF
	3bg5zQbJ6oeJJIGqlbthntrXslfrdp2aTgwUhjCjh0Nothe8w==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:cc:content-transfer-encoding
	:content-type:date:date:feedback-id:feedback-id:from:from
	:in-reply-to:in-reply-to:message-id:mime-version:references
	:reply-to:subject:subject:to:to:x-me-proxy:x-me-sender
	:x-me-sender:x-sasl-enc; s=fm3; t=1795391137; x=1795477537; bh=1
	fjKKCEnZwYosmBHPEBZrD2de+0UdG6NDmDLNg2rOq4=; b=fVumczo+eHO912pw0
	kbM3CuxBk46E1Pz/TEzqbB8/5Qdh4SBcuvN7EdhHZJtowNru51W0KV/1Vx2bnNGw
	uWkJfJBhXY+apGlbkNAl9j2ZM4PShUGTegSDGKj6sWhAB54oWKN5kw2JIQTy+ffW
	6yhjgDfj+ZhYADYGYcmrNQNaTdjHesHPUbZeO7j04ubIdjuH+W47vZr+bZdfCxXX
	PfOtBS0OhVnYJDqyQPeMUjJrZVACcB+3NKuAHnhxhErvWUbziJ/4QVhqDwtR4djM
	hWQWGWoNCkVm4O4tJXqhr5OMSIWRs3dU600AGd1i+P56k6zVOL+5rQAJwfJpmLCC
	KXT0w==
X-DKIM2-Info: draft=ietf-dkim-dkim2-spec-09;
	repo=github.com/dkim2wg/interop; date=2026-11-03; sw=lmtpprox;
	action=sign d=exultantmonkey.co.uk a=rsa-sha256;
DKIM2-Signature: i=1; m=1; t=1795391137; d=exultantmonkey.co.uk;
	mf=PGRhdmlkQGV4dWx0YW50bW9ua2V5LmNvLnVrPg==;
	rt=PHN0YWJsZUB2Z2VyLmtlcm5lbC5vcmc+;
	s=fm2:rsa-sha256:SuOZdnorfE7kUZ8F6BgDj2Iuaa5F+AzKCgxZJFeM5oqaO8f
	2V8wsbdUtlmCFErnI1Z8SLA76NCBcEvYZfSJnMI6YiTaTg+qjlFq+0skNdkFSRF2
	2Uk176RIydWYN/+ZKydhXUy8gbZd2mzoHk8eFzsQfMqyiYfHUHjANA2fVmIZ0/KR
	ba4uewcaIrJNCEQlV2SD9UaiCRhbKa7DWeHlw0pa+WdTudZii+hg0uENuGjFJyQg
	N9SV9JVvTMoAiISaNCrG2VI+s17c3eMKRj/jwdcOSBcMNX2og43LD5NQYDBd0GKO
	VST2vSde/ivNTgnmTPmvO7iR1ux/gzkrwzybblw==;
X-DKIM2-Info: draft=ietf-dkim-dkim2-spec-09;
	repo=github.com/dkim2wg/interop; date=2026-11-03; sw=lmtpprox;
	action=mi-m=1; hc=11;
	hn=cc,content-transfer-encoding,date,feedback-id,from,
	in-reply-to,message-id,mime-version,references,subject,to;
Message-Instance: m=1; h=sha256:G0GCyGbexGc/D8VW5PXNRPAiCnzCwSi2m7sH+nN0ibk=:1fjKKCEnZwYosmBHPEBZrD2de+0UdG6NDmDLNg2rOq4=;
X-ME-Sender: <xms:oX4DaxINla0HgcZeYwOI0l-yr_w9pQEYDXxtpw-EhrpTsjBevlKtSQ>
    <xme:oX4Da_bAmnn-dOA6kjQ6KgtFb0fqldZIx4SgwcU7bHuPjXe2lB7fBynIXdbo03ETF
    SP2tH2w3ap7gw5gGctIU1wCZ4Px0aBAcXBoB7bZK-ZzxkjAHNcxsgV1>
X-ME-Received: <xmr:oX4Da78ITfIu0qYFSuwhfIzlR0SZvYuavN_wBb6oxYx1C4UA6FWT2GalDSyTitQpNTkI42o>
X-ME-Proxy-Cause: dmFkZTGLo4htkBeGweAzxLoOR8g74zf4vF4R/EJ7bPJfkEMuMPo52T+7HEdJdeljAsumUs
    yy1F2//hSMakJVv2yxrqfiWB1WhmFUbJx+bAqRcrRgKjRQ18acWCt3paLYUl7x0wet92un
    iRrKYtXDlfWBCYdzg6B3STRM4rLcMaspN4tBvnDdL6jgbPCTn4MA8UKYzW+ufDWlpBBUMT
    YGL9NXPzdUAQTfy5fhHjvZa7TA7OCXzrHE6ydTDWftrZ1OEMW0inw0NKz7mgCc6Xhos7uz
    N5tvgff6gTQHuWavIrAkWPxwliuLVp8xSBG35zHVDa355qr+I6lHQqMMoJzQS2l6r78dct
    U+ZFaC9VzeEDwsPfVLrgE0bGjOYdOIX1oKI6Qs4Gc9mHLxE0eSORoiHZ73Dq6XQfTDljPM
    xQ8AspQNdbWc9+HAC73bCPwjTIqLM6HxSeyIQLcU/GHv9qPqTukB6ZC8e2R5xZXoiBwaDC
    hgweP0q2a9DiTCZgQsgcB3sKc1JoN/+frIbHpN7f0UtmcoYOMqxUdOR+d2RuTf25bmDLWE
    rfFKX8f1Y5j0VHNxvYCSpZFzE51Wdi2ZfoU72j+jSdbRCySo6rfbAaSSa1JZMubjbeTtUE
    h6OUCn434I5twvn8qxPnumB94CdcLO30yBruaGUw94F/F2EZwNlKnhIjQp9g
X-ME-Proxy: <xmx:oX4Da4bBa6FEdJFCsenfFwvj8GAovRLoMF2YF-Wfrtg0QOVpq3INEw>
    <xmx:oX4Da3Oe_G2vop2rLMab8SKhBDmLwNQVt7eljH3hbV76f6j3FGwOMQ>
    <xmx:oX4Da8AoPOkrNr4SenJBMN5ewlZbFWN3mB_jvhZJwKRrx6n4PiGZgg>
    <xmx:oX4Da2I1FOB7SCI_OSjT_VAhUbEW3ln00-5C4caHcVvehIwPf9x9pA>
    <xmx:oX4Da4VDKJgssMvliq7Uq0gJ21FHEZWC_LhO5YR-x3DnT9U-ot-Zz02n>
Feedback-ID: i8d5147ae:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Sun,
 22 Nov 2026 18:45:36 -0500 (EST)
From: David William Richmond Davies-Jones <david@exultantmonkey.co.uk>
To: Krishna Chomal <krishna.chomal108@gmail.com>
Cc: Hans de Goede <hansg@kernel.org>,
	=?UTF-8?q?Ilpo=20J=C3=A4rvinen?= <ilpo.jarvinen@linux.intel.com>,
	platform-driver-x86@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	stable@vger.kernel.org
Subject: Re: [PATCH] platform/x86: hp-wmi: Enable cTGP in performance mode on OMEN 15-en1xxx
Date: Sun, 22 Nov 2026 23:45:16 +0000
Message-ID: <20261122234516.279112-1-david@exultantmonkey.co.uk>
X-Mailer: git-send-email 2.56.1
In-Reply-To: <awMir9K1nuO772x4@archlinux>
References: <awMir9K1nuO772x4@archlinux>
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

Hi Krishna,

Thanks for the review. You were right on all points. I've sent v2 as a
new thread, "[PATCH v2 0/2] platform/x86: hp-wmi: Fix cTGP and power
limits on OMEN 15-en1xxx (88D2)".

On Sun, Nov 22, 2026 at 11:29:12PM +0530, Krishna Chomal wrote:
> So perhaps policy v1 is not entirely wrong? The HPCM == 1 check in GM1A
> only tells us how this particular method handles the performance mode
> value. Have you checked the other consumers of HPCM, particularly GM22
> and the NVIDIA-related SSDT methods?

Policy v1 is correct for this board. I went through the DSDT and all the
SSDTs, and GM1A is the only consumer of HPCM. GM22 doesn't look at HPCM
at all: it writes NPCF.CTGP and NPCF.DTGP directly from bytes 0 and 1 of
its input, notifies NPCF, then applies the D-state (byte 2) and GPST
(byte 3). GM21 reads them back. NPCF only reports the cTGP offset (ACBT)
when CTGP == 1, and only reports Dynamic Boost when DTGP == 1. So on v1
this firmware expects cTGP to be set with SET_GPU_THERMAL_MODES, and the
HPCM check in GM1A looks like the v0 route.

> However, have you considered adding an entry to hp_wmi_feature_boards[]
> and using the corresponding omen_v1_legacy_thermal_params mapping
> instead?

Done. v2 drops 88D2 from omen_thermal_profile_boards[] and adds it to
hp_wmi_feature_boards[] with the omen_v1_legacy thermal parameters. GM1A
stores the mode in EC 0x95, which matches
HP_OMEN_EC_THERMAL_PROFILE_OFFSET. The new list is gone.

> If I'm not mistaken, board 88D2 should also support fan curves, right?

Yes. GM2D, GM2E and GM2F are implemented on this BIOS. GM2F returns a
2-fan, 15-entry table with a maximum of 5900 rpm. With v2, manual PWM
goes from 1200 to 5900 rpm, and max and auto modes work.

> Why enable Dynamic Boost unconditionally when the firmware would almost
> certainly disable it in case of low-power/equivalent modes? Wouldn't it
> be better to make PPAB follow the selected platform profile instead?

Agreed. On the Victus S path PPAB now follows the profile: enabled in
performance and balanced, disabled in low-power. For what it's worth,
GM1A on this firmware never touches DTGP, so it stays at its default of
1 unless GM22 clears it.

Moving the board to the Victus S path turned up one more problem, which
is the new patch 1 in v2. When the power source changes in performance,
victus_s_powersource_event() sends SET_POWER_LIMITS with PL1 = PL2 = 0.
That was added for the 8C9C as "restore the defaults". On this AMD
firmware GM29 multiplies both values by 1000 and passes them to ALIB as
the SPPT and FPPT limits whenever the EC power level (OCPC) is 0. Under
full CPU load on battery that held the CPU at 399 MHz and below 5 W.
This firmware already sets these limits itself from the EC power-source
event (_Q20): 25 W on battery and up to 54 W on AC. So v2 adds a
per-board flag to skip the refresh and sets it for 88D2. With it the
CPU holds about 25 W on battery and recovers to about 50 W on AC.

Other AMD boards in hp_wmi_feature_boards[] may have the same GM29.
I've only been able to test 88D2, so I set the flag for that board
alone. It may be worth checking the others.

One user-visible change: on 88D2 the profile choices go from
cool/balanced/performance to low-power/balanced/performance. That's
consistent with the other feature boards, and I've noted it in the
commit message.

Tested on 88D2 (BIOS F.20, Ryzen 7 5800H, RTX 3070 Laptop GPU): 100 W GPU
limit in performance and 80 W in balanced and low-power, correct profile
readback in each, and the fan and power-source results above.

Thanks,
David
