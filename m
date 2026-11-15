Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=103.168.172.142
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1794784586;
	b=Bcy91EMUAYozGRrRDR4TN9Pbg0tTh3BB0UX8KoyFv2LYXbOKrixPCYdyJg+2gnsfMo9g
	 moSeVa8W/xuksUllMuDC+dnSUsLYGXLygOD8tp/sr4BsDPdtdeGpCcyHVZT0TfF7S07UP
	 aai0UqStM/917ZsnMdi+GqZ+IfSVqNWNfko8jAyjOnkZf3zU/kcHEXLdaAb2HP34VHiLU
	 s9Cf6LPrljLdxw2O980lSOv8ZVhKPpz3V5wkE2//cFXp74fiIKupWiYkS1mbTRlbS0F54
	 LDZMXJ0+jm5FPDEYqhuHqQVirfmDgJcyVUbJ22U6D7WZJukzxgt5nM+7baKDDw0eGjQ==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1794784586;
	h=DMARC-Filter:Received:Received:DKIM-Signature:DKIM-Signature:
	 X-DKIM2-Info:DKIM2-Signature:X-DKIM2-Info:Message-Instance:
	 X-ME-Sender:X-ME-Received:X-ME-Proxy-Cause:X-ME-Proxy:Feedback-ID:
	 Received:Message-ID:Date:MIME-Version:User-Agent:Subject:To:Cc:
	 References:Content-Language:From:In-Reply-To:Content-Type:
	 Content-Transfer-Encoding;
	bh=RN/3fXeM2+xKt2BFTyhemhSMOG3iX6F2K0uQ1TvJpqQ=;
	b=rS8pionWBNtOPc8m6IpimHPOLNuexa1SDpnZKo17rnIpL7Db1dAWe/1El37OutZm1M38
	 pQkZjEPF5UT37mOzumgaVB8prZKsMQ1dDzKvVwjP7xOIv7vlr+pkIOyADgosvZ7LmYQ9Q
	 6OAPW6ShPD1dptlRHBR9TkfxxYqrZjHF+ppbvJdbmNnnrnm0uZFgKMlY0wLPmS2YfBxwy
	 BYW4TL+imAId7RcNQ3DPeZbiyW0f1WT7a7qaxca0Pe+4kXTVGtctO6f0IyZVR9gVg6Dgf
	 64fH96+/KPYRZvJ1kw3MRTzBE4MdhPoXNSAc6FsR9mRobu/ngj+xnsaxtfI15CwUZfg==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=pobox.com;
	spf=pass smtp.mailfrom=pobox.com;
	dkim=pass header.d=pobox.com header.i=@pobox.com header.a=rsa-sha256 header.s=fm2 header.b=D1A91VOk;
	dkim=pass header.d=messagingengine.com header.i=@messagingengine.com header.a=rsa-sha256 header.s=fm3 header.b=Xg3eTaGe;
	arc=none smtp.remote-ip=103.168.172.142
Received: from flow-a7-smtp.messagingengine.com (flow-a7-smtp.messagingengine.com [103.168.172.142])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5FA4A606A32C
	for <stable@vger.kernel.org>; Sun, 15 Nov 2026 23:16:25 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 5FA4A606A32C
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=pobox.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=pobox.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=pobox.com header.i=@pobox.com header.a=rsa-sha256 header.s=fm2 header.b=D1A91VOk;
	dkim=pass (2048-bit key, unprotected) header.d=messagingengine.com header.i=@messagingengine.com header.a=rsa-sha256 header.s=fm3 header.b=Xg3eTaGe
Received: from phl-compute-06.internal (phl-compute-06.internal [10.202.2.46])
	by mailflow.phl.internal (Postfix) with ESMTP id 7044A1381C9A
	for <stable@vger.kernel.org>; Sun, 15 Nov 2026 18:16:24 -0500 (EST)
Received: from phl-frontend-02 ([10.202.2.161])
  by phl-compute-06.internal (MEProxy); Sun, 15 Nov 2026 18:16:24 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=pobox.com; h=cc
	:cc:content-transfer-encoding:content-type:content-type:date
	:date:from:from:in-reply-to:in-reply-to:message-id:mime-version
	:references:reply-to:subject:subject:to:to; s=fm2; t=1794784584;
	 x=1794791784; bh=RN/3fXeM2+xKt2BFTyhemhSMOG3iX6F2K0uQ1TvJpqQ=; b=
	D1A91VOk0Zxln7h3TlNOo4fP+LEtfSMDSU8EKV34gsd9e17q0xitjp1OQEBaQg2e
	OJ2z37AG3dRILi8jREHY5JMuM8lKbjjTio1NcmKf+WM4x2jSrA4BV6QuwGXyUVDo
	bJxMunkFFAFuej16T14vBlmzyTNS8SW73e6l6x//9BZMkCobzLTGtxYKr9lg4i37
	7oeqNCq9E4kOvn/1b6ACpx+9Xvv2LlLtYBynD7kXiqyUqS+LC93xrM6wrDF0Y2Zn
	Xsickhd2bcgYnW1s5ube/AYXkt2GQrSPwtrt81mY2VFRZ1j+ecpUATQ7xeKe/MPo
	AZn3VrPSkGGF1sdsXtSHkA==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:cc:content-transfer-encoding
	:content-type:content-type:date:date:feedback-id:feedback-id
	:from:from:in-reply-to:in-reply-to:message-id:mime-version
	:references:reply-to:subject:subject:to:to:x-me-proxy
	:x-me-sender:x-me-sender:x-sasl-enc; s=fm3; t=1794784584; x=
	1794791784; bh=RN/3fXeM2+xKt2BFTyhemhSMOG3iX6F2K0uQ1TvJpqQ=; b=X
	g3eTaGei4RnxXf4/UdoVsuwWFyIg3Z93guaUgQ5iTcBAm/HlwwWmwZ6s1aoFSSHr
	T9OREC/Zth4UDvJnC+kmrZQkOH2M8LdEGlDsAJ9eAcXFOxNB/Vvje9ZXL9g7MmgG
	D0J2j5ECBNe535n8y9jdghwOrYrCxit4uLC5HoL+A0IcwJwURVxFKRGjwEY6ZTCQ
	p+how2cPC+2vWVerOi8uFlB2yeB22id07hYLzncGzWbkxOs71bYA9w61DDOwgDdh
	3Qj1H60+eowxZ6oCIr//sIT5UM+evCfF/LZeQo8tkiNOY/M85kIrAdWs633vWs8I
	et76LY/luirOtMji2eqbQ==
X-DKIM2-Info: draft=ietf-dkim-dkim2-spec-09;
	repo=github.com/dkim2wg/interop; date=2026-11-03; sw=lmtpprox;
	action=sign d=pobox.com a=rsa-sha256;
DKIM2-Signature: i=1; m=1; t=1794784584; d=pobox.com;
	mf=PGJhcnJ5bkBwb2JveC5jb20+;
	rt=PHN0YWJsZUB2Z2VyLmtlcm5lbC5vcmc+;
	s=fm2:rsa-sha256:bFWa88rbnRsZCOwZ4JkgWTvvlj4Fzz038Cwh1K0cA3GzT33
	iqxY9Kb2eLwPG44jBihK91Y01tHvxMXqgxg9QB2djBlvdmhLeMl+qtacDFn1zwW+
	1K4A3HEbtAv/7xCP+HwXIhc17jySOOPII7nb8VtZNheoQR5SlwF/QwvFIucLG63a
	c8HhO6IT67dbottwUbAyH5lmUPXRzoFcC57F4T4IErYcWkxmx7ZXnkpIUP1jcfcp
	MUiix0NzhLFRBjvoLoo3XUU+3Z5/oAfuHjHs89xzjZW7R2kPPoZa7EYuFA2TT5zX
	2WHXVU33lix3caCUjtZhxGvkJmK9JG6yv8qu7EQ==;
X-DKIM2-Info: draft=ietf-dkim-dkim2-spec-09;
	repo=github.com/dkim2wg/interop; date=2026-11-03; sw=lmtpprox;
	action=mi-m=1; hc=14;
	hn=cc,content-language,content-transfer-encoding,content-type,
	date,feedback-id,from,in-reply-to,message-id,mime-version,
	references,subject,to,user-agent;
Message-Instance: m=1; h=sha256:OoxCaaWlGNd6f33tVbYFJ7cTJgr9FDOxwqeM4fKN3tE=:Fj3WeHWijoIWEgIC9txmLGtkvkfBT0/gYGaoc75Safg=;
X-ME-Sender: <xms:Rj36aoJFUdcQ1kOgHZ-4cl5rapO3rUWpYo6dQ_g1QPtutHR-hvOf5A>
    <xme:Rj36aonXj7V07r-ZwQVbnzAzCSWfvXdVIevwgkwkKB_xBS1sr7sdhQLUfsnH-MT8r
    eJB5L2mGd7wEelMVOWpxLi6y0muX4zyR4GA7EPGOrQLaUI18d1Fa15Y>
X-ME-Received: <xmr:Rj36aodLE2ulBEWgnSU4uXFvXwBCnkgPOFHycPvGjYEEot_azoEPssRRE1xe6ZnHBfq14upzURMNij7IVvkdLyDL3lwOattF>
X-ME-Proxy-Cause: dmFkZTGytscWlBp6Q61xt2UBMOQZTppLWEuUTX+3OheypkeiBywDHyqzPXB9EdcpvYsTqE
    tSAW9tKZu0lt5B3h3nD40iIfFNglBDfz3heDSzoEO9E9uJ5fhHAEhi7gxcwtcKiW4QnTo7
    972bCb17OVHyrmLXPoXby88tG578mvl0EfODjvThDbifNdUat4ogugJAsrrR0uKyJ7qeTP
    rfo3WD1Fb1XEF4o8npTtkcQDfDfAoWWOVdJBRm5Ht0b/9vqd4671HDeRJSGPWZgtKYuchM
    g/NtKebK8xXjxG1qfikwKZX/8i9rtBG4HtGNclldom8zfcD8YMUebZquripD7TaPUHcbYM
    so7YJcUfEB1SFs7Hgk6S43qIK00Y7iVHrRae9OFQBqMHjQgwNCll9NlGO02Tc20LH0Nw9b
    aXVJMnqXWfVL8h5oMyJS3BY/52cM0FZWKvIpltj9iDRw7slUT1Ep3PY4qGvVhZXaDIzi4G
    Uj4Rh87uJKZbXD6NzXhiEQnY0GeILBX9N1CIAA1U5oT/bhRd1qMdpbVCEgrpkI5qea18UK
    HkM5M4L2zcUK6zrtFkqaFJg3lU48Sv2QUWiq+KNyd8NuE7tgqu2yWzFhJAYnqtxkW9lWUf
    HhYMvkcxYtsoJ+ZyLas5XPhvKMJ49xOo5cDfY3/OwVX1LUE28YkS/138YrjA
X-ME-Proxy: <xmx:Rj36ahxCGPZvYf0D4K2OW7vALeiMiWFQbonS6FEVNHuGK9JfUthyCQ>
    <xmx:Rj36apJYNOhm8MNar1_hGNtZUA9eNmOC3MdhtdIoxvcLceKJW6RVtQ>
    <xmx:Rj36aqtBKNzciD5wqR9Yphm8u9K9SE1BhJgfbiTtALA9zPJXu_ix5g>
    <xmx:Rj36arQfGdCP-UgZKv_FUDiBrUO_jaUAlnFJ71sAgr09VnHd-VdzZA>
    <xmx:SD36ashB3qgmH0cwE3NWg13xymj6D3LaJHJ-X0-6EmAxSCWCGGlZ-klX>
Feedback-ID: i6289494f:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Sun,
 15 Nov 2026 18:16:21 -0500 (EST)
Message-ID: <2e149d01-c932-42d3-9698-c1555e542cb1@pobox.com>
Date: Sun, 15 Nov 2026 15:16:20 -0800
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
Subject: Re: [REGRESSION 6.12.117] CPA detected W^X violation:
 0000000000000121 -> 0000000000000123 range: 0xffffffffc0477000 -
 0xffffffffc0477fff PFN 109c1f and WARNING at arch/x86/mm/pat/set_memory.c:665
 __change_page_attr_set_clr+0xf62/0xfb0
To: Sasha Levin <sashal@kernel.org>, Mike Rapoport <rppt@kernel.org>,
 Nathan Chancellor <nathan@kernel.org>,
 Dave Hansen <dave.hansen@linux.intel.com>, Andy Lutomirski
 <luto@kernel.org>, Peter Zijlstra <peterz@infradead.org>,
 Thomas Gleixner <tglx@kernel.org>, Ingo Molnar <mingo@redhat.com>,
 Borislav Petkov <bp@alien8.de>
Cc: x86@kernel.org, "H. Peter Anvin" <hpa@zytor.com>,
 linux-kernel@vger.kernel.org, stable@vger.kernel.org,
 regressions@lists.linux.dev, Salvatore Bonaccorso <carnil@debian.org>
References: <avdb9EPXBv2hRCzQ@eldamar.lan>
 <draft-agent5-0008-re-pat-wx-regression-612@kernel.org>
Content-Language: en-US
From: "Barry K. Nathan" <barryn@pobox.com>
In-Reply-To: <draft-agent5-0008-re-pat-wx-regression-612@kernel.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit

On 11/14/26 9:42 AM, Sasha Levin wrote:
> On 2026-11-13, Salvatore Bonaccorso<carnil@debian.org> wrote:
>> One followup to this. Reverting
>>
>> Fixes: 091c44b2d3c3 ("x86/mm/pat: Use pr_warn() for early W^X warnings")
>> Fixes: 11d1ba991c07 ("x86/mm/pat: Fix effective RW computation in lookup_address_in_pgd_attr()")
> Thanks for testing. Queued reverts of both for 6.12.

I see that in the current stable-queue (commit
3b8ff7f280433e6fb085dbc4f44ac6a138f352a0, "Fixes for all trees"),
these two reverts are queued in staging-6.12, not queue-6.12, so
queued up for 6.12.119 not 6.12.118 as far as I can tell.

I don't know if this was some kind of oversight or if it's
intentional, so I just wanted to bring it to your attention.
-- 
-Barry K. Nathan  <barryn@pobox.com>
