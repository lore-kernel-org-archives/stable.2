Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=202.12.124.147
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1794980781;
	b=ZbsuU+lpm6fzYFkta4wGcuvq+JQpwpIFKu+To3ZUUIOY2t+iY067xILqesc/P6SQ6sVm
	 HtyQV2Wx88w58wqKbAc6SRSxvw9LBq4LXHqqmK7z7bjS+RqgoI5rv0R+f65PEcHO1Sqb9
	 PT3QeD+6ediu+AKzKjB2oWe7qYpV2nv087DtEWINnyY+TC2/ozF6clBVb+32y84f7AsgU
	 2XlBzS0oVWo+27ijMagVD0cAQu0vFv7c5Bc8CWRG5n9GNJm20hoHw8rB4uh3K39hAFxer
	 yW4e0NUOsnw+bnE+KufogZeA70xRQfs71xfMwiBzW72iYOBoMxNjuzHuUk51GHGsLiQ==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1794980781;
	h=DMARC-Filter:Received:Received:DKIM-Signature:DKIM-Signature:
	 X-DKIM2-Info:DKIM2-Signature:X-DKIM2-Info:Message-Instance:
	 X-ME-Sender:X-ME-Received:X-ME-Proxy-Cause:X-ME-Proxy:Feedback-ID:
	 Received:Message-ID:Date:MIME-Version:User-Agent:Content-Language:To:
	 Cc:From:Subject:Content-Type:Content-Transfer-Encoding;
	bh=4PGhncW7N254BHhuI+X+ylprn6wTF6rmx27dV8++hJw=;
	b=d+FGv6TpHU/ahu5F9JPVl9MsdUk+SOTq6SRBbgrIi1yUZoNX7a03yNl16M7MM1KIuey4
	 1ln3IJYpKDFxdEzKQ9y7mVdgPnT0xxT6u54JdB0NfHYzaTlRsAza+c/DwvtGse5XeIB90
	 qvmOPeiBDzllWB7b7/CjJqyU1FuLDFojI/May1omIdR8QQGrjXCgdjzLDSweJo+iVlAsC
	 LkpgcI6mG7T3Gfk1tdJuNNi0CqYk1VOpILh2kGwYzRe8F5lGu5ECE+OmEFFQJjc67ZxyR
	 NG2JImraV3fS8RUFsynOj7qUriQbU4fdlDWfAxO/cfAAHtA0RWXYHUsKSQRLeXxmyfg==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=pobox.com;
	spf=pass smtp.mailfrom=pobox.com;
	dkim=pass header.d=pobox.com header.i=@pobox.com header.a=rsa-sha256 header.s=fm2 header.b=e+zKZHIt;
	dkim=pass header.d=messagingengine.com header.i=@messagingengine.com header.a=rsa-sha256 header.s=fm3 header.b=h8A93scB;
	arc=none smtp.remote-ip=202.12.124.147
Received: from fout-b4-smtp.messagingengine.com (fout-b4-smtp.messagingengine.com [202.12.124.147])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6BBEC606A31C
	for <stable@vger.kernel.org>; Wed, 18 Nov 2026 05:46:20 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 6BBEC606A31C
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=pobox.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=pobox.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=pobox.com header.i=@pobox.com header.a=rsa-sha256 header.s=fm2 header.b=e+zKZHIt;
	dkim=pass (2048-bit key, unprotected) header.d=messagingengine.com header.i=@messagingengine.com header.a=rsa-sha256 header.s=fm3 header.b=h8A93scB
Received: from phl-compute-06.internal (phl-compute-06.internal [10.202.2.46])
	by mailfout.stl.internal (Postfix) with ESMTP id 91F751D001A7
	for <stable@vger.kernel.org>; Wed, 18 Nov 2026 00:46:19 -0500 (EST)
Received: from phl-frontend-01 ([10.202.2.160])
  by phl-compute-06.internal (MEProxy); Wed, 18 Nov 2026 00:46:19 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=pobox.com; h=cc
	:cc:content-transfer-encoding:content-type:content-type:date
	:date:from:from:in-reply-to:message-id:mime-version:reply-to
	:subject:subject:to:to; s=fm2; t=1794980779; x=1795067179; bh=4P
	GhncW7N254BHhuI+X+ylprn6wTF6rmx27dV8++hJw=; b=e+zKZHIt56pZGUueFu
	6/7sRUf6ytsx9O+Q1lVweOYjs1eVZgyAiZXMPFXWapq7o6cu843VDDcCEm0laJbG
	6x6gUH/EOY3QsKIaMceF80cw5fjxMbEFMInUMWPsde6zEoR91RyqOyqw/luhCo85
	HNwYF1ae/VEdD4/rnLiIFdeOOBU3wiHh+/wYEU1rzL+bud7+wHHGhQh3GTX19IHi
	FSMNIoDZW/F4PS68bNxA/i8zkMnckprLaxKqwAzEo10sBGxxLAj8+jhogkDyT8lL
	GGOBvZZTlUw5k37McEH63641M/8ov+zODkvJ6f8wR+y96YgGuzaW8wEhk0HYdf4X
	aGsA==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:cc:content-transfer-encoding
	:content-type:content-type:date:date:feedback-id:feedback-id
	:from:from:in-reply-to:message-id:mime-version:reply-to:subject
	:subject:to:to:x-me-proxy:x-me-sender:x-me-sender:x-sasl-enc; s=
	fm3; t=1794980779; x=1795067179; bh=4PGhncW7N254BHhuI+X+ylprn6wT
	F6rmx27dV8++hJw=; b=h8A93scBUH3VvuyV/i2yXE6mt+Ya3HXJTq5bBTTxjqr4
	v5scOwAz1W0bWCXNE4c5IU5jJHVHHZzVJ3gr6ROUksltVGN6BbmNyzHaPjWKNddS
	sFcYboMQLqZu16rH0bZmMb9U9DlDKu1h2a0dxZMRCM/xNms+UOTnsgoEoBhM0PIO
	ywQJRBzySjXLGqhpk6Z4Uq5PhYU9eeeNhJuIdnCnxFgi1VXZJ3gho2BoS0q2UHnP
	Nd7DxUn6lcGVmi2BCDL3D/DSHbh87hUvGK6fDs7eoWZZUsWf54iCFwtnUEx9YUxi
	i0Si3YEabVDR0Q58PLziOILgmy2gC5heckV8EP3+Bw==
X-DKIM2-Info: draft=ietf-dkim-dkim2-spec-09;
	repo=github.com/dkim2wg/interop; date=2026-11-03; sw=lmtpprox;
	action=sign d=pobox.com a=rsa-sha256;
DKIM2-Signature: i=1; m=1; t=1794980779; d=pobox.com;
	mf=PGJhcnJ5bkBwb2JveC5jb20+;
	rt=PHN0YWJsZUB2Z2VyLmtlcm5lbC5vcmc+;
	s=fm2:rsa-sha256:NtLHJ5c7O/apKm5nrTiMao6/NcPhEoI2L1gd6Pb/RO1Ij1U
	l54Zz+kZvvcNv40gZ2WCgbgAJ6rZRY5+3T1qrj9vZ6xdSxZWAVemoIku/rjL3NgI
	85G8Z8OlVZS6L4TjJ/GsmtHL0O/2i+FEcw8KcnJ01HM3QrGC/mlZmlj/YBtCF1Bk
	7Kwdty0DpaXekMW3Sv2s/csgqK2fklLowMWJu6wh2I39rkoHk5YhPpqaSmdXpahK
	c2Qi7mJbMXmUF/jRv++o6cVUqxumnBWEWBU8M8wu+TQgsdPYJiqEu4mt7EwP3YOU
	tXAgCzP2eNVb05XtQGYIadnfagXt4DkYru7Y6Ag==;
X-DKIM2-Info: draft=ietf-dkim-dkim2-spec-09;
	repo=github.com/dkim2wg/interop; date=2026-11-03; sw=lmtpprox;
	action=mi-m=1; hc=12;
	hn=cc,content-language,content-transfer-encoding,content-type,
	date,feedback-id,from,message-id,mime-version,subject,to,
	user-agent;
Message-Instance: m=1; h=sha256:YqRDAbMZP5ZWB5Ze7phEkMI/84mAmKX5ZFXvsdE2tXM=:O0PRFVuMTsEHZYKnmzI6aG+lABhavA5E9ecPBMEFR+k=;
X-ME-Sender: <xms:qzv9aimTVYv9yDN2uIBGOuPlM38Uj4GgKo6HbV_QQqBZzZP2llntvA>
    <xme:qzv9akaMXNtldnI5dPlWYp9b5Hxw7F6LYjWSc0_EYHiUqvam_MxpeKuJrPPSflF5a
    w9ohb7R57F2hQzNJZAGPajEDZ2STKsNSWNBbpsiXRBD-UnjQDcG_dc>
X-ME-Received: <xmr:qzv9atOrFmpnuoNZgWaQ_-UFNfRAR7gZORZjNby1uCmFunw7h49MDF8LdatRFPHXDzDp_cwwmRIzXOWZ-EZ4IIr5N1vC9KsE>
X-ME-Proxy-Cause: dmFkZTFt2b6l6LBKqtDnRJuBqrXtjWv+zZnCfHSUR/5nzqddxAcyKhhUQHZKO6dbduIzO2
    vn+EDcweZnoy6+WNxoGlaC9r2mf8rvjIkhxGW7d1m/qOi2MVkmQQ4cI9FZi9jx3WybFpwC
    e9eMIA9gz4+upz17G0UbJgh+squESqCBOPNTygSKknPFv5gO87cY+UooUtoLPfLEjbiZsc
    b4umbxp1PRTwoXUjCpkDyu0mL8Us0CgvKZjbAJnxSRbYwpRomnJKdWSt+VnrIT3tusZrwU
    4ZZgnklhqRPm7IHG8380VImflj1EDxuRUHaN8PqjmhheDQerEF0t9ZtOPazwBCnEUhonQ8
    4PlfD9apM8kMB1zH+LQ6Nbc/Ia8rLG/fErG3E9RqnlsRdy9MFwJnZQEa/ztQYyUbyTJOlp
    E2optNB0UQu4EoxJNBy0td1XE8yi+l7aVOLgWXRe6uRvuuUtF1ks/A1UUAGHWZF9oBQriO
    L4jfspAvBpdx1m0490SOD2sM8L+D/A/7r/wJK4ZoJ2ptAzvaOe0q74JpiFO6r4ANxoclHO
    AHTOGfAYjALpa7Hd9TVvpOQAmHps67t2LwNtS61kkHrfAbasIBuZvfqslLJ0TXSJlEbxkP
    u9EDiKHEO1V52yzbsSXSTEiknZMoqPbBGP2R88fP2FFQEWjppmoQpLlMj99A
X-ME-Proxy: <xmx:qzv9apbwy5eFrJRUIjsVW-J7cJ_TYBSPZjgIDP_lc9jBT6428_Scjw>
    <xmx:qzv9ar2B2gjom2yokbPlvcjLKTTe0RiTX3hawvteu8etESOL6ixxhQ>
    <xmx:qzv9avcewB3I6pyzx2c7mXrRYE6gmPedif8v2F-j7097yaZjU03wSg>
    <xmx:qzv9asH_fx98uILtGjnsBie2bnHppBed6zalEMeBOZ6bemcptKiKcA>
    <xmx:qzv9av6FiU4ZNap5QBP0v6vY9rFyAehQtnPrtWgKBBpqh7coOPU7CbLJ>
Feedback-ID: i6289494f:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Wed,
 18 Nov 2026 00:46:18 -0500 (EST)
Message-ID: <31a4ad36-33bd-4563-9eae-651e713adbdf@pobox.com>
Date: Tue, 17 Nov 2026 21:46:17 -0800
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Post: <mailto:stable@vger.kernel.org>
List-Help: <mailto:stable+help@vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
List-Owner: <mailto:stable+owner@vger.kernel.org>
Precedence: list
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Content-Language: en-US
To: stable <stable@vger.kernel.org>, Sasha Levin <sashal@kernel.org>
Cc: Josef Bacik <josef@toxicpanda.com>, Alexei Starovoitov <ast@kernel.org>
From: "Barry K. Nathan" <barryn@pobox.com>
Subject: [5.10.y] build broken by "bpf: Validate the SRH which End.DT6
 uncovers in End.BPF"
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit

To be clear, this report is about the current 5.10.y stable-queue. No
previously shipped 5.10.y release is affected.

After applying the current stable-queue on top of 5.10.274, the build
fails for me with the following error:

net/core/filter.c: In function ‘bpf_update_srh_state’:
net/core/filter.c:5867:26: error: implicit declaration of function ‘seg6_get_srh’ [-Werror=implicit-function-declaration]
  5867 |         srh_state->srh = seg6_get_srh(skb, 0);
       |                          ^~~~~~~~~~~~
net/core/filter.c:5867:24: warning: assignment to ‘struct ipv6_sr_hdr *’ from ‘int’ makes pointer from integer without a cast [-Wint-conversion]
  5867 |         srh_state->srh = seg6_get_srh(skb, 0);
       |                        ^

"bpf: Validate the SRH which End.DT6 uncovers in End.BPF" is the patch
that causes this error. Reverting it fixes the build.

(seg6_get_srh is present in 5.15.17, 5.16.0 and later, but not 5.10.y.)
-- 
-Barry K. Nathan  <barryn@pobox.com>

