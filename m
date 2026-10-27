Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=100.103.45.18
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1793108317;
	b=uBnKVW2TgfAwUQhw0n2XRFfqL1Dw57pKTv7EYFdhgzvhHpkQqVfxf0p3/GWjlG57cL84
	 LRb8J/4djR6KDA7QnbtlRoUe3sYRQcj82OvU88yYryPAZ4cJPXhpmVSQrMJKOGJxdapX3
	 6J7rclLNf0prWB0aO3RFjWVmexrSFM/hiUM/OBTcykg8Eih5GbYz0LgXcsjqIbRghwjVK
	 RCO0XEIFFYGXSzzW4KC0IqCvt04lDIcSpTBi9ltJuJqboeyYXNakZxexYhYFnJMFbgbFY
	 BVzJsZ84mR+94AfY7ec/zBszVD/ap7eUhu8hp7gHKayPL4hfM3daUT4N0Wm/F9FVbWw==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1793108317;
	h=Received:DKIM-Signature:Received:Received:X-ME-Sender:
	 X-ME-Proxy-Cause:X-ME-Proxy:Feedback-ID:Received:X-Mailer:
	 MIME-Version:X-ThreadId:Date:From:To:Cc:Message-Id:In-Reply-To:
	 References:Subject:Content-Type:Content-Transfer-Encoding;
	bh=4wgyAUtxoYsHUq2vOhTXGeF7hsURu9DbNvr2JxybX0U=;
	b=PKDxES+A1Pqd5OaCnvJlbTR6wLSHAUn9QKG4zMbyZZ/Kg18nUGry0vfGTj7B7DaYgSGf
	 0dRhtxAebHYgjuCOkHXjwsPAKkTJT2W47QCqYunSnInfSw/WmVJyIzFj8UFQZPs5xfyl4
	 60zUTmJlWHCPtqQ0fhk4L2150IZ+MXe7IswCULAN9lVs2qds2CKYev4Cj5yLK9h/e83Cn
	 igx/tHeYlR2IgqA/jv2dregC97dykexAZvmDJmg0qMfiVE9JYS/VnRlQ6622v8u6dDAQY
	 i2jtRbRwI0MUqW9OAxs9gdfgRyua4io2Wui8DpggN4Z/YnoUr4YyNSFXBI7QQRe19Cg==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dkim=pass header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=G4ae4xnw;
	arc=none smtp.remote-ip=100.103.45.18
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4A9C0606A32E
	for <stable@vger.kernel.org>; Tue, 27 Oct 2026 13:38:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=G4ae4xnw
Received: by smtp.kernel.org (Postfix) with ESMTPSA id BD53B1F031ED;
	Tue, 27 Oct 2026 13:38:36 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1793108317;
	bh=4wgyAUtxoYsHUq2vOhTXGeF7hsURu9DbNvr2JxybX0U=;
	h=Date:From:To:Cc:In-Reply-To:References:Subject;
	b=G4ae4xnwEdXBCWGKKU7U7I5L7kKV265KYk1LAGWi8CVy/D94DWyv1O6Bq6sRqhXnW
	 gwzwMlLi5+BAB6pMFTRrZlBQzo+GyBZO6unw/uCNiFGII0nL142ivBgY4fv0o/AQzi
	 l90tZUSPg6fZkS3D6hoeJrm9lqK398DeIx9xXMPjhyL6E7HfcJ56Vjam3lq3V6BfBM
	 r9aNX65cLv6cgCXm/ZK2o+CA+ylHVDWxqYS/HLg/FwQJlx+d7hclBsnf1CwxNNihjG
	 ucZ6SRoc0Uq9WZB2PhTax6TaMS/2fx8/oPMqFdpAH/aWKGnkrkSedFqYNJ2unqSrIL
	 WE0cb8WJwUTXg==
Received: from phl-compute-10.internal (phl-compute-10.internal [10.202.2.50])
	by mailfauth.phl.internal (Postfix) with ESMTP id 0EB37F40066;
	Tue, 27 Oct 2026 09:38:36 -0400 (EDT)
Received: from phl-imap-15 ([10.202.2.104])
  by phl-compute-10.internal (MEProxy); Tue, 27 Oct 2026 09:38:36 -0400
X-ME-Sender: <xms:W6ngagsCdM8wggJU5eEqw23mkTSHnR5VimuP5CbvzaKjN3oqkm_Cig>
    <xme:W6ngaoSU7dW4mVPF59dOMvLr1U4beRggSDPvIcAlg8pAN5pw65LruEWurlg9FMAZq
    dDHF91D0I-ODuWxun9o3L65H4eBNzR-5FGRUAor2G79y6DWk0NRPB-K>
X-ME-Proxy-Cause: dmFkZTGZxu4SiG05ueDQEZeu+6fWxwmYtcso3/rWUUsricWFIQPIRp+cXnTf9MUKOQ39eG
    7IRalJBKNW2RcTxBqwgtPhH82bDVZBrEwtsGaJl29X6DsOuB7dee+NnxD2B0/hocz7Zwjf
    LJFO0dauFX3JLKyvo+0ohP3loERyH6y9LxqDOZTN+adCqummkoCeMpDbc99/cU9tRQMNR7
    X7Gm2bd7Lg+V/bK28HsQ3Vjk63oXVi31kCkl3PJ+z2AnZmjtzp69af+70YIIqcZTJYQwP9
    4x1kNSIhYVAUsfSvKmKUmcBJKxHDrEfWqaoJpL4WdSE6rt+mWJqfkt9hOsIMBOHKKcozY/
    7ncGFTJhFOWjm+D4bhvitSTpy3CzoN9UiZ6j1JagrcUPBl2i7wHxY5GtRvl0nET6mGBKJ5
    ++SXBLN6uPWsHN5NiVOxFANpRV7cOBzqJcGBK5TE2BDFS+nBIlALLhrA5PH2smzUsJpzZO
    5G3pQjPXhyVSCmDzq5FXoT85bD9LM2Vj4oOZiNUWY4BboyPIoz/ARqPA6UiqEFsuiUOFcB
    NpNY5b6z1EvfNJQr6lz3SjhqFUVncCn+mbbOAD+W8SbKU30p3jnpkSQKDYSNOeAVJhdZWF
    kXYBc6c3xPzpGO4clYKAoWrBczmrswZIUf0yFFH4okrOdZwvUv6r0OuljoPQ
X-ME-Proxy: <xmx:W6ngavSqpIKKirkF3A-T0g2pu-fWP0AygY50ju8nPJSDOZSxlifyWA>
    <xmx:XKngao8SFoUVv1wzyDKKA7k-KuqVs08b9AeXXdB-T7QLS9dS1001aw>
    <xmx:XKngagYjYSYDDt_GXvYQJqcKNeSUOC8PSL96AHi0xJbCShI1boXXPg>
    <xmx:XKngaprT03yc_kMFvhWAgnKhX3k51q-eB2dukGEBSNlNL2yDSYyulw>
    <xmx:XKngakS4kws4ZvHWWDp_C_A-Rukk3QK3IkB5VyGeM0Ltbmmg76D1ICvP>
Feedback-ID: ifa6e4810:Fastmail
Received: by mailuser.phl.internal (Postfix, from userid 501)
	id D861A78273B; Tue, 27 Oct 2026 09:38:35 -0400 (EDT)
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
X-ThreadId: AhcSeGgFL0jV
Date: Tue, 27 Oct 2026 09:38:15 -0400
From: "Chuck Lever" <cel@kernel.org>
To: "Tristan Madani" <tristmd@gmail.com>
Cc: "Jeff Layton" <jlayton@kernel.org>, NeilBrown <neil@brown.name>,
 "Olga Kornievskaia" <okorniev@redhat.com>, "Dai Ngo" <Dai.Ngo@oracle.com>,
 "Tom Talpey" <tom@talpey.com>, linux-nfs@vger.kernel.org,
 linux-kernel@vger.kernel.org, stable@vger.kernel.org,
 tristan@talencesecurity.com
Message-Id: <cc343ef0-1277-4c57-8db7-bd9d80e1429f@slotpi15m67>
In-Reply-To: <20261026230151.2474608-1-tristan@talencesecurity.com>
References: <20261026230151.2474608-1-tristan@talencesecurity.com>
Subject: Re: [PATCH] nfsd: pin client reference across async copy reaper cleanup
Content-Type: text/plain
Content-Transfer-Encoding: 7bit

On 10/26/26 7:01 PM, Tristan Madani wrote:
> nfsd4_async_copy_reaper() detaches completed async copies from the
> client list and later calls cleanup_async_copy(), which eventually
> drops the stid reference via nfs4_put_stid().  That path accesses
> stid->sc_client unconditionally, but the client is not pinned during
> the cleanup phase.

Thanks for the report. The same bug is already fixed here:

  0941ff1cda56 ("nfsd: hold client reference while reaping async copies")
  https://lore.kernel.org/linux-nfs/20260928083050.642664-1-bint4b13@gmail.com/

For future NFSD submissions, please base on the nfsd-testing
branch at

  https://git.kernel.org/pub/scm/linux/kernel/git/cel/linux.git

per Documentation/filesystems/nfs/nfsd-maintainer-entry-profile.rst.


-- 
Chuck Lever (Come to NFS bake-a-thon! https://nfsv4bat.org)
