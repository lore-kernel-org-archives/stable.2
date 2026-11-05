Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=202.12.124.153
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1793914033;
	b=1i1B7sgtiZCI0N5dStEVe2CM09y2LrTOgsTL7UogVt9ni1MBt8ldaSaY5HlS9pxYpnB+
	 kyiDjxgfVw0LZ/xMcxDnsbHZKxUIgo8dYCrv8otm/SlJejZeHnBT1AxHh0rXXag50ryNY
	 +rexxUAHjHfW0G7/ivBqbdGs9Ykj5Bhcp/JLROKFBO1TGCTCwu4OjpDNheelWhTvGrSAa
	 TlDl+FLhhMU0EeCw6ovZKSZS6ucBe/44o4hTlNE1pu0aRx0IS/PTNH7Zjm8QVlzjCgwBl
	 8i6+a8m6g1ekG9YSIZTnOWuH6hFrlZZ4fjVAr1rPwxFZeLpCGBWwe1taf4/kdBEQTZw==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1793914033;
	h=DMARC-Filter:Received:Received:DKIM-Signature:DKIM-Signature:
	 X-DKIM2-Info:DKIM2-Signature:X-DKIM2-Info:Message-Instance:
	 X-ME-Sender:X-ME-Received:X-ME-Proxy-Cause:X-ME-Proxy:Feedback-ID:
	 Received:From:To:Cc:Subject:Date:Message-ID:X-Mailer:In-Reply-To:
	 References:MIME-Version:Content-Transfer-Encoding;
	bh=RmXdb3aNeF12CFaNr3KqfL/OLmu9GGiLL93Jl82TTsU=;
	b=SI6CQBZbyEaSw9FajJNyvT9HeE5sKHR+zeaPws2YshCgLtz7yiaT7Sy4CeJIvSKTeqkQ
	 580zzZ7o1v/gzlHxp59bmBEypzXphxy2UHIaKRgfgQDXrnzIO/9zbrMLntOwxA046ILyt
	 spz6lDbu613rg9D2y53DTb01NBlmZ7689q/PQu8jvd8GXnUJnt6VTSdG+SHpZfKHrMXa7
	 88qoQgNJXYnhB2JRUSEFGf1gQSsi1XePIP+bew4oYJqiFQAcWoOBv2TaLwpHGXaJvLhaB
	 BovxTGVrMUjuvJF2dyjY1AM5MzVDtrBbB+ByLjhEV+0XH0NG9wS5Am4aYqm8XWCPExw==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=fastmail.org;
	spf=pass smtp.mailfrom=fastmail.org;
	dkim=pass header.d=fastmail.org header.i=@fastmail.org header.a=rsa-sha256 header.s=fm3 header.b=yjBOfcg3;
	dkim=temperror header.d=messagingengine.com header.i=@messagingengine.com header.a=rsa-sha256 header.s=fm3 header.b=JJX7w23R;
	arc=none smtp.remote-ip=202.12.124.153
Received: from fhigh-b2-smtp.messagingengine.com (fhigh-b2-smtp.messagingengine.com [202.12.124.153])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 13EC1606A32E
	for <stable@vger.kernel.org>; Thu,  5 Nov 2026 21:27:07 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 13EC1606A32E
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=fastmail.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=fastmail.org
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=fastmail.org header.i=@fastmail.org header.a=rsa-sha256 header.s=fm3 header.b=yjBOfcg3;
	dkim=temperror header.d=messagingengine.com header.i=@messagingengine.com header.a=rsa-sha256 header.s=fm3 header.b=JJX7w23R
Received: from phl-compute-03.internal (phl-compute-03.internal [10.202.2.43])
	by mailfhigh.stl.internal (Postfix) with ESMTP id 5B8DF7A0123
	for <stable@vger.kernel.org>; Thu,  5 Nov 2026 16:27:07 -0500 (EST)
Received: from phl-frontend-04 ([10.202.2.163])
  by phl-compute-03.internal (MEProxy); Thu, 05 Nov 2026 16:27:07 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=fastmail.org; h=
	cc:cc:content-transfer-encoding:content-type:date:date:from:from
	:in-reply-to:in-reply-to:message-id:mime-version:references
	:reply-to:subject:subject:to:to; s=fm3; t=1793914026; x=
	1794000426; bh=RmXdb3aNeF12CFaNr3KqfL/OLmu9GGiLL93Jl82TTsU=; b=y
	jBOfcg3sSc6Z5cLjKsYMBuffMhP8cMGufagsEwULfWH9ewPP5E3l6dNEWj2sClui
	YmFB44qy68jLK3W5UmOm4pPxq6KlwUBSVKv47Qf/a0EfUAKMR2EH933puoUS0Jhj
	TKVYUTQToqrsaj1K63XvlLDT+1uC8KCQDha1bxR7jFJSL2961rWmVBRiRLzOGi9n
	QwPasosc7jALxZ8Raa1DodRva00riZqwyXuYK4ruv9/D6fxwj/IReUhSZv3Hvg01
	3exs7Elcuoq5WiAxwXOmEYEtk2NVGKX8OaelXQF++hqfyCyaXToE5tgOrPL4ZKqM
	CI8CtLM0j+WE+P/r8y2mg==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:cc:content-transfer-encoding
	:content-type:date:date:feedback-id:feedback-id:from:from
	:in-reply-to:in-reply-to:message-id:mime-version:references
	:reply-to:subject:subject:to:to:x-me-proxy:x-me-sender
	:x-me-sender:x-sasl-enc; s=fm3; t=1793914026; x=1794000426; bh=R
	mXdb3aNeF12CFaNr3KqfL/OLmu9GGiLL93Jl82TTsU=; b=JJX7w23RfDecFC0TV
	Tpu7KwqByUJezX3Zt/lMw0akdrAxTdSy/LnFTPwIJy8TeiNkO7tpjInqg9wK4n/A
	4SsCSQ1ZcNvTE1qmBMZySWZed1T6IqO9SDcZ7uLnGDCFn+QxeLa5CkvQPVvQEWxu
	VT5vTCl+WoPJatFJ10AmDh4vrBBaRQqByvCHxjfrwJCHQezspyQ2f0dBDDzLB9Vy
	HWFcReBKdx1At8oEmPUb2A3+xoovRZzmrFGmAdzzExLyZLVHroVqzYgdXNiKC+7n
	f7AnXuUmnF/OmjY/KZiL06yXOWOd8b6AxkXc7YO45yjXGEQU93Ne6z6Ys+ddcuUj
	/HiUg==
X-DKIM2-Info: draft=ietf-dkim-dkim2-spec-09;
	repo=github.com/dkim2wg/interop; date=2026-11-03; sw=lmtpprox;
	action=sign d=fastmail.org a=rsa-sha256;
DKIM2-Signature: i=1; m=1; t=1793914026; d=fastmail.org;
	mf=PGljYkBmYXN0bWFpbC5vcmc+;
	rt=PHN0YWJsZUB2Z2VyLmtlcm5lbC5vcmc+;
	s=fm3:rsa-sha256:PMiLxqPbT5oWnfHHBxsLjgTYB3kLV6AJZnkuGrxvWK89XBR
	eisoyalM7mj5EwzjhsNGf4fThf70YXtTEOHZe38WiGH1y60tyB2Ok7lhA3rdAZf8
	O74RI6gWuBzPNLkBACnrRbWVzQpXyvP1/16w9onhvBWDwsSMPI0cDslR2Ld/XmSa
	MC+FGPiV3UgNP85yRYRAIqd9DKeTztKBUxoRH+8so5b0wTKLfRy3S7ANOz3RwIMM
	w+9V7lYDdauLfbzNLWe/mpFa0iNtZH6kNnmU2qK4w0b6vIW8T8V33tkBrlDrytiT
	1zJgUKc94pcJJeBIu3/jlWxaYvo8EVe1LrvslXA==;
X-DKIM2-Info: draft=ietf-dkim-dkim2-spec-09;
	repo=github.com/dkim2wg/interop; date=2026-11-03; sw=lmtpprox;
	action=mi-m=1; hc=11;
	hn=cc,content-transfer-encoding,date,feedback-id,from,
	in-reply-to,message-id,mime-version,references,subject,to;
Message-Instance: m=1; h=sha256:3OxlkttHmcTKeqh59aIGi58yqsXy4YiY2+yTqZmokSM=:RmXdb3aNeF12CFaNr3KqfL/OLmu9GGiLL93Jl82TTsU=;
X-ME-Sender: <xms:qvTsauG8K4nyvnpITOjwO4vbbLq6l7lx4Kn9MQepvm49ACRUx47WTg>
    <xme:qvTsarWPddFvbtX0Xr8SNzkEfWZ0Xw5zz9ZmuWL6oBcdfYuM3c_BmYSW1SpKHqWZq
    qFVHZ8E03G9fYdN-2KQAtHbC0TwL1HUJZE8ksWNztMFIQq8GicGZ4c>
X-ME-Received: <xmr:qvTsaqUeysFi_XX4w4s2nWB7CNzSNOvbjtN069ZzkOdG9N1gQxGlIqj2tnisMLRi>
X-ME-Proxy-Cause: dmFkZTEWTdBxq9vHdWNf+AUmNYF8/no6ggmE2LrE9JgdzXjmDerwoDlTfiChh1wZ/nsZ7l
    /+2KTJUBeEvdvGC4qI/zbIzFTWUdqbEFor5cbGWIiVGtv1LcT77Ijyo7KbAgIy4Dqi/2vF
    Ctv1Q0FPpPokKxec8exlaP3eV+oTSdRLT+nU12hCpQbKMzYvBn4oKOm4zUruwttghegw0q
    naZ4PNDVXHisY7jSTlgfiMqlXHo4REQzmpCnHU+oMLd7ZJdIYENKDEZhHnK4TdU5zRr1cH
    3DLpkoB+wk0tL/Epj+vBy2Psy4siMP94+VGUYCFGnBS4uWscc++HNjOiAcX7tdsmdAEbDq
    d1RMMPpSr7e9OkpvUpvD8E62quw/hwMmVuoNr7/vQYqw4c9qDwTEgKUMNyjDbUp6LqOPif
    pjefsgBbWCsfNrn9QqXArraFOX+F6nM1OoX3e3DEZtWmmccQJMJdDi2bEZ6dVsUj3daaoB
    5BKEVl6EDW+9iGNLk12BdTwwXztPO7vRQbltTPKYA4Wzxmhr/GuJpqHPLCxpkx+9KrpFLL
    ASDVXE5U943Gl6NEWkAHA3Jt6yAaulfDWSLaRhY632cccVqYe9iNTI2KeX8HoiealLeFTx
    +anYFmYGi8x2qA9Et359eUJykrw2pwTN6aaiRErvHlsBEtQEkANiieEXKVaQ
X-ME-Proxy: <xmx:qvTsapIqZ6OJz74zVW6CDc5MQJLAiVSixGKY67OPgpuXHpiqkmksbA>
    <xmx:qvTsaiAh4qTC_DFKP8lYuJCIUAN6iHojPlAlUgVjmbkv-eSez0BHLA>
    <xmx:qvTsaheQF7Uh9uoS13QKYAByANVSquPsibX5LKVoz7hzcDMk1E2HrA>
    <xmx:qvTsap0zMY9D-XPp9sEtW6Ja7Qk3C9MQBwu4EU5Rsvi25cVKP0oAcQ>
    <xmx:qvTsauMYrOLsAjECJIemieRvmF0fa3dVyhI_6YqaYxXzvyAFhPlKr2wM>
Feedback-ID: ib53e4b78:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Thu,
 5 Nov 2026 16:27:05 -0500 (EST)
From: Ian Bridges <icb@fastmail.org>
To: linkinjeon@kernel.org
Cc: senozhatsky@chromium.org,
	tom@talpey.com,
	chenxiaosong@chenxiaosong.com,
	linux-cifs@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	stable@vger.kernel.org,
	Ian Bridges <icb@fastmail.org>
Subject: Re: [PATCH 1/2] ksmbd: skip metadata-only opens in sharing checks
Date: Thu,  5 Nov 2026 15:26:52 -0600
Message-ID: <20261105212652.697079-1-icb@fastmail.org>
X-Mailer: git-send-email 2.47.3
In-Reply-To: <CAKYAXd-a+UH4q65J9K4e=EscH7tkHC+eEu_HC_oEeVzBdi0Kog@mail.gmail.com>
References: <20261104183702.192452-1-icb@fastmail.org> <20261104183702.192452-2-icb@fastmail.org> <CAKYAXd-a+UH4q65J9K4e=EscH7tkHC+eEu_HC_oEeVzBdi0Kog@mail.gmail.com>
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

Hi Namjae,

You're right. With this patch a CREATE for READ_CONTROL with
FILE_OVERWRITE or FILE_SUPERSEDE skips the sharing check, and
smb2_open() then truncates the file. In your example, with an existing
FILE_READ_DATA open at ShareAccess 0, the second CREATE for
READ_CONTROL and FILE_OVERWRITE at ShareAccess 0 succeeds and the
file's data is lost. A test that runs smb2_open() confirms it.

I'll send a v2 that does what you suggest: the sharing check counts an
open that truncates the file as holding FILE_WRITE_DATA, and the
returned handle keeps the open's own access. An open of a directory or
a named stream, or one for attributes only, gets O_TRUNC but is not
truncated, so it is not counted.

A truncating open is already on the inode's open list before it
truncates, so v2 also counts it as holding FILE_WRITE_DATA, for as long
as it is open, when deciding whether a later open is checked against
it. Patch 2 does not change.

Thanks,
Ian
