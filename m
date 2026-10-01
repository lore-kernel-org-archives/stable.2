Received: from fhigh-b3-smtp.messagingengine.com (fhigh-b3-smtp.messagingengine.com [202.12.124.154])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id EA3FF3F8252
	for <stable@vger.kernel.org>; Thu,  1 Oct 2026 11:46:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=202.12.124.154
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1790855169; cv=none; b=OvX0lXVHbZJDtLwZ8cU/ISv9DgTNpOJtoZ9TUmNbNglS8qfMYOPRJ4KABSif67WqEGOlmIdA82RueoOAlhoyyP9ZXD7u8CRZfOCdHJ6b1cljldEn+uD/oDLrtHSC1bOOyluf6Bomrsipyn3AV0tLOE9/534+RZ8mbB8+L8V2hNY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1790855169; c=relaxed/simple;
	bh=uCaFXrRSWgBbNuRZ+FS6WZ69wowC+4yvUu2mcdgzmpY=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=Swl9Gp6o4cXudmngm1jBBA4Q8v2j22/jB2HdXkE1BtADST8dCYqpwP+A3x6iZFPkEvD3tKwCg/wzRwY3iavZUSpaTDlApPehddNeam23RA5DhRfYF/MmIFwTww9xUUJU7nJHzu/4DRvSGiwccVlLCcze57rDJElUoftn8DA7aNs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=queasysnail.net; spf=pass smtp.mailfrom=queasysnail.net; dkim=pass (2048-bit key) header.d=queasysnail.net header.i=@queasysnail.net header.b=hg2ra3c6; dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b=U8cGB6MV; arc=none smtp.client-ip=202.12.124.154
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=queasysnail.net
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=queasysnail.net
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=queasysnail.net header.i=@queasysnail.net header.b="hg2ra3c6";
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="U8cGB6MV"
Received: from phl-compute-01.internal (phl-compute-01.internal [10.202.2.41])
	by mailfhigh.stl.internal (Postfix) with ESMTP id 503767A0134
	for <stable@vger.kernel.org>; Thu,  1 Oct 2026 07:45:59 -0400 (EDT)
Received: from phl-frontend-03 ([10.202.2.162])
  by phl-compute-01.internal (MEProxy); Thu, 01 Oct 2026 07:45:59 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=queasysnail.net;
	 h=cc:cc:content-transfer-encoding:content-type:content-type
	:date:date:from:from:in-reply-to:in-reply-to:message-id
	:mime-version:references:reply-to:subject:subject:to:to; s=fm2;
	 t=1790855157; x=1790941557; bh=MH80e3dRRo9fMz59NK1445PV26W0qmPi
	n5V8PiCsTMU=; b=hg2ra3c6lw5E/DDwg9JaAbAujIXc2+0hinQDPO8ticdlgIDB
	C/vG16sMc448yvxceEgXpiDPoXBHNJRhq4Xz9sLyY4Kt2J+NZecHVCylsQ4KzCmy
	i7LSLcxMLG6jf/Ux/q8+4LWMlYCAi+RwEPI1AuPDmjp60VRRn9/p599tYRuXlftc
	Nmb3ng6YgZshrzc5TQzMHRNw7ORocYYwrJ1zN2cVQgzpD7d8hdzLD3K4XePoFiri
	NCz2pj37gwG536ktKxqUxf8Eq8zH4t7lcvTQA+/4ldHKLDjNMxw4q91af3YAGuBd
	7zsQpx9HaP3JyfQ4+J14zWZzQ5zI4qoBpMEKew==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:cc:content-transfer-encoding
	:content-type:content-type:date:date:feedback-id:feedback-id
	:from:from:in-reply-to:in-reply-to:message-id:mime-version
	:references:reply-to:subject:subject:to:to:x-me-proxy
	:x-me-sender:x-me-sender:x-sasl-enc; s=fm1; t=1790855157; x=
	1790941557; bh=MH80e3dRRo9fMz59NK1445PV26W0qmPin5V8PiCsTMU=; b=U
	8cGB6MVY3+jBY3eils2F5bLn3csHNEndvt0WuJrpwO7ETu/ShbB0udUGauvbH3Ra
	Q4vWq0PHCpH1mjQS0x9NrxzLjcX5w+6EqO8h1mP/2/HY9dcem46Xe6wDNB9b5amc
	/G52Qj8/CeHpWHKXO8PnaXzI6+tiRKfgt/8vZkDTjenmDz0H2ZIg3+QrD6W2rENG
	y3JJsP1Sa3UDPOZvweauf9FFsn9pOjwZS6+v8eHS2wOnT1P+++ecAby27ugU1Oy8
	KWQfDgAl9n4N66/PDT3o054IcSw0OuoUWQVJWs0e+HtuSl07A48iroIT6V6+OrPA
	Y4WGZFbnBiFS5/uGT2w6A==
X-DKIM2-Info: draft=ietf-dkim-dkim2-spec-06;
	repo=github.com/dkim2wg/interop; date=2026-09-30; sw=lmtpprox;
	action=sign d=queasysnail.net a=rsa-sha256;
DKIM2-Signature: i=1; m=1; t=1790855157; d=queasysnail.net;
	mf=PHNkQHF1ZWFzeXNuYWlsLm5ldD4=;
	rt=PHN0YWJsZUB2Z2VyLmtlcm5lbC5vcmc+;
	s=fm2:rsa-sha256:nXbMnBghloNGSqhV0vsxrAGRG/AslsKqvYXSG/XDwNkG5HH
	5KWtDiyE/7XAe+Xr2qfbun+RAd2c8U12NS5WTQl55cIKcuMICkNFDzfHFwKt0AaN
	HkDvTpu2LIGyJb4jV83UvF957ZyojlGGXmiO/rbkPujq2Y1ADFdi7H/uh421dzmx
	eIHOPLZKN3d/W9oVuFnY/Pfam2Ihvxfj8W0y+Fv/qN5gyKHSPTaWDCSvowG/gobW
	ynxhxfeqYnGpbem3Xho+GDAurpH9tbgrzGnCdcWT34bP23Ttt8bC/qy2vs+AvkSo
	j8JOxVZxUErG0HVaTxtokGnkX/GLBCcluQNluuA==;
X-DKIM2-Info: draft=ietf-dkim-dkim2-spec-06;
	repo=github.com/dkim2wg/interop; date=2026-09-30; sw=lmtpprox;
	action=mi-m=1; hc=13;
	hn=cc,content-disposition,content-transfer-encoding,
	content-type,date,feedback-id,from,in-reply-to,message-id,
	mime-version,references,subject,to;
Message-Instance: m=1; h=sha256:AErVP2vqZsLPTtmzuijl9PJjlvoKjKp4izsN9E4Tj48=:uCaFXrRSWgBbNuRZ+FS6WZ69wowC+4yvUu2mcdgzmpY=;
X-ME-Sender: <xms:9Ue-anzJy5nSSoSxFasVOvviOmg3Tl7I1WwRU7VMHp4R5nkAN28YjA>
    <xme:9Ue-anYDGQQ2_w7o_ZLVIyertGQaO14TIEXRihjRgT0t2zgJc4UNeE0iHpXMzAwOE
    U0SM0X0t9pLbAylwUfzILI6AFZuypaAEnR0eh1dflW_PkVshQQk5GGs>
X-ME-Received: <xmr:9Ue-ag2LI4bRVzqq7TLrz6UtBD5PxTszOQybvKxtuyT4PhjoAYbNR5-x-pak>
X-ME-Proxy-Cause: dmFkZTEpKCh++LvY+MGXEOeao6y8uB+iXc9Br0/SigM05yLe0MBdGyCxR44UiCOoRnPcsA
    5WBFlF2RrrF5GpiPaEArN8SOk2/e+TWB+ueEEbgvSBV4IQrBLsWzjiAAA/N9SwRdSCAQGY
    gpoflFmQLKAzfh/Y4A9i0SXw4dyXamwXnB2o7XvApfYrHZtDfAvr2KD5SCA6PsfYbew4MS
    +Cb7mvR9MUZseP1rdElNWbVZJHMXKNGy2+ZW9DRToNMEbnOQw1/9g/pkwyYHXul76T3q4H
    35Lrh9tGfDO4f1KzTfCqYUB8uTkyt/cbXM6CKmKDsmYX4Ci/M+u5LsR1LH+d4gN8Xc8dNl
    Ju4tcYBcPvgEOXfmBRNZODrrIJ5fBii5R13+tJCRzqcG6oA4rMEbAzD+gom2ofQcLrI2mv
    7xewxY+uDJKvLy6YRmb4TGH7jyvirNVNWq8GYB5zRrzlr6L0bbMMgsdjOpNkDv2nbZcE5I
    SvsdncLt6NPZBqpDok9kQXBrSq/21sObbERaPE/DV4lJ35hB/IJhi7m/vsYYLpcHvaS58b
    LRW5JVgWLxR7Jq1DqKHsy1022tgAD+eBISuR36TsURHtNORa/Kk+aij/0Lbkt5oTUYphqy
    2eU0ra8KQ6JTl3WZulfPCo0Ho6hAVebxwIYOMyvz7H6+cP/TTabzbacMa/hg
X-ME-Proxy: <xmx:9Ue-ahdhdtQ1TUSUPNSCuJQpmprvXghGf4icJxepDJBxqtQEj8gwoA>
    <xmx:9Ue-alIixsGb-Auy3eJ8F7ac51xe6Q_EZGaED8MGi1Og9rsZyEkoRw>
    <xmx:9Ue-anroN6l7WGcGSVc9u4OIMRZmtyfp9qK6nbWnKLf7-rH3EPPuVQ>
    <xmx:9Ue-aruiDf3M825bzHgKgGEykGtQFW-Bma7lzO5deERLnv7DJicg5A>
    <xmx:9Ue-asgkvXT0MsegyGUghN9bVNh356wr8MJaAcGeiQXbpZVhAAEcAxIO>
Feedback-ID: i934648bf:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Thu,
 1 Oct 2026 07:45:56 -0400 (EDT)
Date: Thu, 1 Oct 2026 13:45:55 +0200
From: Sabrina Dubroca <sd@queasysnail.net>
To: =?utf-8?B?SsOpcsOpbXk=?= Jean <jeremy.jean@oss.cyber.gouv.fr>
Cc: Steffen Klassert <steffen.klassert@secunet.com>,
	Herbert Xu <herbert@gondor.apana.org.au>,
	"David S . Miller" <davem@davemloft.net>,
	Saeed Mahameed <saeedm@nvidia.com>,
	Leon Romanovsky <leon@kernel.org>, Tariq Toukan <tariqt@nvidia.com>,
	Mark Bloch <mbloch@nvidia.com>, Boris Pismenny <borisp@nvidia.com>,
	netdev@vger.kernel.org, stable@vger.kernel.org
Subject: Re: [PATCH ipsec 7/7] xfrm: leave the sequence counter unchanged on
 ESN overflow
Message-ID: <ar5H87hRaIpERAZ4@krikkit>
References: <20260930144523.435271-2-Jeremy.Jean@oss.cyber.gouv.fr>
 <20260930144523.435271-9-Jeremy.Jean@oss.cyber.gouv.fr>
 <ar5C8DDMwWn-30iV@krikkit>
 <69f80ed58e34f787305f85b12eb3ecdb@oss.cyber.gouv.fr>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <69f80ed58e34f787305f85b12eb3ecdb@oss.cyber.gouv.fr>

2026-10-01, 13:37:54 +0200, Jérémy Jean wrote:
> Hello Sabrina,
> 
> On 2026-10-01 13:24, Sabrina Dubroca wrote:
> > 2026-09-30, 14:45:24 +0000, Jérémy Jean wrote:
> > > When the 64-bit ESN counter overflows,
> > > xfrm_replay_overflow_offload_esn()
> > > rejects the packet and rolls back the stored counter. It decrements
> > > replay_esn->oseq even though only the local oseq has advanced, which
> > > can later induce a reuse of the last sequence number and the
> > > corresponding AES-GCM nonce. Both IPv4 and IPv6 are affected, yet,
> > > processing about 2^64 packets under a single key is required to
> > > trigger this bug, which is highly unlikely in regular use cases.
> > > 
> > > Leave the stored low word unchanged on overflow. The high word still
> > > needs to be restored because it was already incremented.
> > 
> > nit: using "low word" and "high word" instead of the actual variable
> > names doesn't help the readability of your commit messages
> 
> Right, I could specify that. How do you suggest I do that? Should I send
> a v2 for this single 7/7 patch, resend a v2 for the full 7-patch series
> (possibly in a couple of days in case there are some other public
> comments), or another option? Thanks.

Unless there are other reasons to send a v2 (ie some more important
issues in a patch/in the series), or if someone requests it, then no,
it's not necessary. That's just a preference in wording (and possibly
just mine, maybe it doesn't bother anyone else).

In general, do not resend a single patch, always the full series.

-- 
Sabrina
