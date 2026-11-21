Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=202.12.124.158
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1795230465;
	b=VsTOvsjs5Vn0J82iHe5EEatgX6/YJzWfBlaJ+XWDwVMpTZRETJouFBMAuKDeDEkd3rSy
	 PEEO/mBrRyANnc5iRZbfQDDbXrZK0GTQ5z6uuZ8+c+JOGJ6QG4RWuzBXQHJ7MdOcJZ5gx
	 f4CCk8PEC4HlE3zsZtOYucQso/lcdkmNFbAfTbGbvix/Vp/DxgBrXN3eFejVWUNo+VkSl
	 VWEl6CeOQ/0zc+tdbAdVMce056qZsvgnJ9d5f//qwVN0QIS8Nb/Vw2D3VAYvXPMMvm7SY
	 zK6TtYkZ7BCsI1R9EoEd0j+Yv+gnNLPenP2o4/s+22KLgMp97S7h3qeGJJ6FfcqlKag==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1795230465;
	h=DMARC-Filter:Received:Received:DKIM-Signature:DKIM-Signature:
	 X-DKIM2-Info:DKIM2-Signature:X-DKIM2-Info:Message-Instance:
	 X-ME-Sender:X-ME-Received:X-ME-Proxy-Cause:X-ME-Proxy:Feedback-ID:
	 Received:Message-ID:Date:MIME-Version:User-Agent:Subject:To:Cc:
	 References:Content-Language:From:In-Reply-To:Content-Type:
	 Content-Transfer-Encoding;
	bh=J9Wo1LLPgZ0M2/7qgQRwy1GrGfua6oHX8t96KgKN3XI=;
	b=y0uxOXQaBP7SP2v3f0VGZkk+kvLjrjULCNC4TJocNxxOBELIUbN1nzxgEp/ERtq0EeL9
	 kUmB6b6QV6NY6FZMkFe7HWD8qReoAWHXDoFc6jLlaXypzplwp0i49XlCDRyHXHTUGdE7+
	 gsFFQn6h0FHn1C5FBX6PK3VLvuFbRmz/l2JhbA28Cn3hZO7xzOBWmVsTlqyX6GJ+jHilw
	 6U7nHaWuGf0r2/UV2uF2fWX4FozNG6YyA95mCsOGpD8A7QquZVZFTb6xwu9R1XKT4PJy6
	 RIQkE/4CK6rt29FVYRx9nR/siRd7VdDfXbY5NX8gEj7vOlenUo6rF6VtawIZQwQiTAw==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=pobox.com;
	spf=pass smtp.mailfrom=pobox.com;
	dkim=pass header.d=pobox.com header.i=@pobox.com header.a=rsa-sha256 header.s=fm2 header.b=Lmxs8yCT;
	dkim=pass header.d=messagingengine.com header.i=@messagingengine.com header.a=rsa-sha256 header.s=fm3 header.b=z6omCf2p;
	arc=none smtp.remote-ip=202.12.124.158
Received: from fhigh-b7-smtp.messagingengine.com (fhigh-b7-smtp.messagingengine.com [202.12.124.158])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7708D606A32C
	for <stable@vger.kernel.org>; Sat, 21 Nov 2026 03:07:35 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 7708D606A32C
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=pobox.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=pobox.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=pobox.com header.i=@pobox.com header.a=rsa-sha256 header.s=fm2 header.b=Lmxs8yCT;
	dkim=pass (2048-bit key, unprotected) header.d=messagingengine.com header.i=@messagingengine.com header.a=rsa-sha256 header.s=fm3 header.b=z6omCf2p
Received: from phl-compute-12.internal (phl-compute-12.internal [10.202.2.52])
	by mailfhigh.stl.internal (Postfix) with ESMTP id CB54D7A0421
	for <stable@vger.kernel.org>; Fri, 20 Nov 2026 22:07:34 -0500 (EST)
Received: from phl-frontend-02 ([10.202.2.161])
  by phl-compute-12.internal (MEProxy); Fri, 20 Nov 2026 22:07:34 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=pobox.com; h=cc
	:cc:content-transfer-encoding:content-type:content-type:date
	:date:from:from:in-reply-to:in-reply-to:message-id:mime-version
	:references:reply-to:subject:subject:to:to; s=fm2; t=1795230454;
	 x=1795316854; bh=J9Wo1LLPgZ0M2/7qgQRwy1GrGfua6oHX8t96KgKN3XI=; b=
	Lmxs8yCT3kQR5DYslADig4HlNI6WwLgHdmY41GNOzFs49szI7qiWR3uxaup+VA3i
	9z2457CgwGWwKMEEVcuavIsmBI279x7ZDKRrV9z3WRSjLj1NCbVYL/jtTy2Brn6j
	e20TahmM5mzWKg9x+IufVpj2J4XtIYNiZzKk2beHoqgLELl+mMjgSrmMcMkaOhm2
	iyeznuax2//Y5WMJVRZtcFn3V68e+tDeEF7IhTuRcgSIPg15K13kpLq9UN5Z5nqk
	6i0mzVjwU5CEkl+cz9jxbZceDqbmTMVH/idzwYHnIaYp/yMLakeLdQqb9lNFLNV5
	r2SK7lV66Xr7S4igtgmp5w==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:cc:content-transfer-encoding
	:content-type:content-type:date:date:feedback-id:feedback-id
	:from:from:in-reply-to:in-reply-to:message-id:mime-version
	:references:reply-to:subject:subject:to:to:x-me-proxy
	:x-me-sender:x-me-sender:x-sasl-enc; s=fm3; t=1795230454; x=
	1795316854; bh=J9Wo1LLPgZ0M2/7qgQRwy1GrGfua6oHX8t96KgKN3XI=; b=z
	6omCf2pzRb5ltPzb6LdOizokrVLdiUSe7pWhh3KOTPnnd5cCDAWb6Vnsi4rCKp9J
	4pXGVi02mlKp90PWlfnnCVAeFNx+/f1NQF5wGOZQxyx+H2CpSNAImUsEYDvx24Iq
	s00Kzr8litmonhnVWwMrpHVIq8vblOBGn/VK0mDs1kJwzkNpQLhlDX6D0PAHxgDp
	6RyIM5q4I4OIN5FUwf4cagfltzM4SfgZDZja8MWqmu2p2bRFb6JXpX8b04kaF8V1
	z8Ayf5mH096iuxgA/YWVhL7D/89oak4v1Jr5qm7/QDkqYIo6Na/NbUgUIu/Ol6l1
	Oig3bhh7ru28Q2P+dBNoA==
X-DKIM2-Info: draft=ietf-dkim-dkim2-spec-09;
	repo=github.com/dkim2wg/interop; date=2026-11-03; sw=lmtpprox;
	action=sign d=pobox.com a=rsa-sha256;
DKIM2-Signature: i=1; m=1; t=1795230454; d=pobox.com;
	mf=PGJhcnJ5bkBwb2JveC5jb20+;
	rt=PHN0YWJsZUB2Z2VyLmtlcm5lbC5vcmc+;
	s=fm2:rsa-sha256:CSQzw4tEyGiP9A1HOmRNXqfExlvYn+1t4z6gK1zzBVt2jqe
	vkq7UsQvhJCF5YBBPUL578bIZqqhH8r0kBSFEh43bL+HLaVoiMMc03sM9IaYskNe
	9yavWsC/E0xQv7zpNNszCN69U1vV8fpbtSPVg+e8kVWviAzp+dKnAV5DMcC8ZaV7
	XmZN6GzpaV4zTkz57Q9iwXKBNo3bmaH7ZY600wEjHy7/4BTYBNiqw9pHK3uGam4/
	zl8m282HJ6VUAQ01qHDNmOhmiu2/s/pgmRwnWjY8dvXv6sziNfndgUhVGaUx2SiO
	vItp1BWMqLzNGZDkA7KqsL8gZWWE275D8m30ZGg==;
X-DKIM2-Info: draft=ietf-dkim-dkim2-spec-09;
	repo=github.com/dkim2wg/interop; date=2026-11-03; sw=lmtpprox;
	action=mi-m=1; hc=14;
	hn=cc,content-language,content-transfer-encoding,content-type,
	date,feedback-id,from,in-reply-to,message-id,mime-version,
	references,subject,to,user-agent;
Message-Instance: m=1; h=sha256:I09901pHR4NWv3tPw63KpbQgEj0LoAhrK7VIY9URF7o=:bE6K/d0CVO9JyMKrakrnNgv3ETaOBmQDJ118Xg8omA8=;
X-ME-Sender: <xms:9QoBayrEYiwOUL4A_NxWwCEjgTtsy8YsPkP0BJw0TZmDhxDnFNOYEQ>
    <xme:9QoBazMitxdzZl1zmnOz1RLwos7bgJlvIGplxSUr0Ej2fAYKwBs3Bw0gcq51N1ce0
    r0qk_rBmF87krZmwvVWMU99c6zV0aUSR8EGBHtn4xcFE0QycEqI0Fc>
X-ME-Received: <xmr:9QoBa6021enrwpC13DmYAbJnjm6nFMsu4ffl5iv4JQvdOUY3l52oE6-ntFXhSoRtjOOXi0grS9lz9tVD_ezoR0bG_3Zk6v3C>
X-ME-Proxy-Cause: dmFkZTF73W6XvnW3/sgv8AYOLneXpXLnNrt0sgIJOGt1T133vMgQby97HXEjs22lOwgey5
    NGftX/J9V0Z8Cv3wY4x3CURqA6X+HKWZ7r8qQo87MrKku5/hqm5/ExxN0VpMyTY6biEqvk
    ujj4Ax1RLUCGabxEA969POXGBXQL+UXDTvx7DlYMGWLkZY9Usik+EfK6HGr9H+baLmMgtu
    t5OuEw6/6XFlxPd+oQrwZxWDBldpr+77scFS/ZBBhEWgm+H46hivy2Am9U6ak8MGa1cK+y
    vVkPen1YUTeHZvDZHi31EtG9JGacbONCa7HtwqWRL4PnYnPUjoDXZYwflGiT4Is6okibae
    ofl1a9knIj7O+fxIpB6cheb+AUpGxIB9Zb+ZZHlRFDxd93k5CwsLHM2AtI50hrG3kBT8Mu
    MFHwJbMziSRpnlsac9zPYYNICxH884hKB73SJw8hqnITIBv3Q9Dx+o2/SOPWL5iSJYWrZ+
    dLFBUUnKE9SiAQZu+jLNyUB/dfw9TpKIQmm0dC5INGYUhKKUWwVRw5/+9JqkQvRwLpubGs
    Sg1kDGod2gktjlV6m5UV7VzuaCCbUfE0k0Zxf3lfArXqnFct5GcDrmez7cDjBx11IFVegj
    P/0XkMMSbN01C1a+HUbYwKCEYd/XAzT6TgXjnlR+OVGw2pOV/0xfUuDgCqpw
X-ME-Proxy: <xmx:9QoBayBr8JkAA9YxfY7gT5WoG1f8rGbjS064QyGVfEBvc7RFzkMOvA>
    <xmx:9QoBa3KMnI4dRTootzF2LiS0V8Wp72PGcVHgryMM8SSeLlVwnlCBRQ>
    <xmx:9QoBa7nuj8V3iI5ez8JyI8YgvmpuHjTsDvAVWRsMQ7_B5ueWoWt8yg>
    <xmx:9QoBawbXVbgEp2GWt-XDQwSJJD01dchHRmhUtvoLs7eH0WC1W0gaOg>
    <xmx:9goBa4LaVlwAFbi91TXMMCAi7YzL2pVUyi9E0xJZtfprXos4BXXGyyhI>
Feedback-ID: i6289494f:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Fri,
 20 Nov 2026 22:07:31 -0500 (EST)
Message-ID: <049338b0-ce72-45a7-a8f4-efa7f3f85444@pobox.com>
Date: Fri, 20 Nov 2026 19:07:30 -0800
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
Subject: Re: [PATCH 7.3 1870/2651] Bluetooth: L2CAP: take chan->lock for
 l2cap_chan_add/ready/del
To: Sasha Levin <sashal@kernel.org>,
 Greg Kroah-Hartman <gregkh@linuxfoundation.org>, stable@vger.kernel.org
Cc: patches@lists.linux.dev, Pauli Virtanen <pav@iki.fi>,
 Eulgyu Kim <eulgyukim@snu.ac.kr>, Jaeyoung Chung <jjy600901@snu.ac.kr>,
 Luiz Augusto von Dentz <luiz.von.dentz@intel.com>
References: <42da5e9b-1db9-410e-9c72-9f9f4e9489f7@pobox.com>
 <2026-11-20-1-daily-reply-0001@kernel.org>
Content-Language: en-US
From: "Barry K. Nathan" <barryn@pobox.com>
In-Reply-To: <2026-11-20-1-daily-reply-0001@kernel.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit

On 11/20/26 12:38 PM, Sasha Levin wrote:
>> Now I get the following when building the current 7.3 stable-queue
>> (commit 5252483124e6cf016c4a6f41fe1e44f5e1949648) with clang 23.1.6,
>> same config as before:
>>
>> net/bluetooth/l2cap_core.c:128:9: error: mutex
>>         'l2cap_chan_hold_unless_zero(c).lock' is not held on every path through
>>         here [-Werror,-Wthread-safety-analysis]
> Requeued the L2CAP/6lowpan patches for 7.3 together with 15ad901d92a2
> ("Bluetooth: L2CAP: avoid maybe-return-locked in l2cap_get_chan_by_scid/dcid"),
> thanks.

I have now retested 7.3.5 + the current stable-queue (commit
3dd4b2d3c1f7915277082781d6dfbe71d7d41800) on my ThinkPad T14 Gen 1
and my arm64 VM. Builds successfully, works well, no regressions
observed. Thanks!

Tested-by: Barry K. Nathan <barryn@pobox.com>

-- 
-Barry K. Nathan  <barryn@pobox.com>
