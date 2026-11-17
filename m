Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=103.168.172.146
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1794923545;
	b=NQfwgIsygf6J/9R2J+ixe4mgjgocHh8lFdd0/iyJANt0eIN7HODWZxDb+zyODncpZwyH
	 yVg8hxk8nkuVSXM61jFjWVpqmSskNwkJByBtYC2oS+7l1pnmWfpX3Qfn5/z1J8pN/mxUN
	 7K7QozGyTXrReg0AzTQZ4yo3U6UlTeiADQJu5cd2vqzbxJQriGvc3I2ZEW3gXPhanMBPH
	 9J0DSEHCH4GFWizs6UysBMwPO/GPR6HlZjQku0UGhiPQ2KDnyIKVyg+kB8JUiG8rJo6AG
	 BdATTnoAsfEXiPwCfmhZcLYHRyG/7IxkFqsy5vidyGjy9ya2NL/ICugMdZjVja70pAA==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1794923545;
	h=DMARC-Filter:Received:Received:DKIM-Signature:DKIM-Signature:
	 X-DKIM2-Info:DKIM2-Signature:X-DKIM2-Info:Message-Instance:
	 X-ME-Sender:X-ME-Proxy-Cause:X-ME-Proxy:Feedback-ID:Received:X-Mailer:
	 MIME-Version:X-ThreadId:Date:From:To:Cc:Message-Id:In-Reply-To:
	 References:Subject:Content-Type:Content-Transfer-Encoding;
	bh=70DfZfFKXRaieDq8Pk9B90fU5z9WYAvkXhfACEP3qcs=;
	b=GRAjD0mb8QnZZt7M6UTV/5GRaS/xSsRELNMYOi4ANDYuNkNrf5ZtB99VwyNbr4kn39j/
	 xXa9kHJ1iQNO/VFJ4k1tFLWiBeHRZy3Xe1zWcSmLpDb6wXr/WKk7deNO6OsbJrAgiHRQK
	 DCffQQzBfSan8DptC8eF86HnQwHUXLHUEdKsgIW27fTBj3CTM5rEPPCAFwIuehI74gipo
	 kWaXahuOBijpTzMmq0QVsAXCLA6ntRTYdqG7WXyBivcJb2ysYTjspSOCgktiYzbafgv2T
	 bAg7j8xLetTw7SlV9fMFMjtNru3Z5gNdtQoN8im87ltW2WlpKRrFQy8xzAUQxPsHFmQ==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=arndb.de;
	spf=pass smtp.mailfrom=arndb.de;
	dkim=pass header.d=arndb.de header.i=@arndb.de header.a=rsa-sha256 header.s=fm2 header.b="Eh/Ms1hA";
	dkim=pass header.d=messagingengine.com header.i=@messagingengine.com header.a=rsa-sha256 header.s=fm3 header.b=i0F0Kliz;
	arc=none smtp.remote-ip=103.168.172.146
Received: from fout-a3-smtp.messagingengine.com (fout-a3-smtp.messagingengine.com [103.168.172.146])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A0871606A323
	for <stable@vger.kernel.org>; Tue, 17 Nov 2026 13:52:23 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org A0871606A323
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=arndb.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=arndb.de
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=arndb.de header.i=@arndb.de header.a=rsa-sha256 header.s=fm2 header.b=Eh/Ms1hA;
	dkim=pass (2048-bit key, unprotected) header.d=messagingengine.com header.i=@messagingengine.com header.a=rsa-sha256 header.s=fm3 header.b=i0F0Kliz
Received: from ams-compute-02.internal (ams-compute-02.internal [10.64.2.62])
	by mailfout.phl.internal (Postfix) with ESMTP id BC284EC001C
	for <stable@vger.kernel.org>; Tue, 17 Nov 2026 08:52:22 -0500 (EST)
Received: from ams-imap-03 ([10.64.2.23])
  by ams-compute-02.internal (MEProxy); Tue, 17 Nov 2026 08:52:22 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=arndb.de; h=cc
	:cc:content-transfer-encoding:content-type:content-type:date
	:date:from:from:in-reply-to:in-reply-to:message-id:mime-version
	:references:reply-to:subject:subject:to:to; s=fm2; t=1794923536;
	 x=1795009936; bh=70DfZfFKXRaieDq8Pk9B90fU5z9WYAvkXhfACEP3qcs=; b=
	Eh/Ms1hAquDDHtVZ27m9uvf0+ko9AoxxkgdcpMIbdyNynTXyFvMOo1JDhyt3voka
	bV2Ek+qXrVJxOmNU0z6iH4m4eTlPwHPRMEk3GSoZPhT76s9DIpnxqx+3AygDPwra
	FTdo1ngLGnCQfEQTOKL5jpO122Vx/wBe8u8DFFmssmuf9WKv11duwMJi4bPmJVoU
	6Kf3YjURyqulH9uLBgSmn4PN7d3Fdd1q/DW3EoBLDmr8kqg5/BShFS9tgnhiTgFW
	TH6AhpZuJ9F9ovqVUvf2SLoLoRqI7IpkxLSewDOyUfz+vMuHgaYwWtzjqhpDpIyb
	TBRSghl1yrrUVNoF7O5vtA==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:cc:content-transfer-encoding
	:content-type:content-type:date:date:feedback-id:feedback-id
	:from:from:in-reply-to:in-reply-to:message-id:mime-version
	:references:reply-to:subject:subject:to:to:x-me-proxy
	:x-me-sender:x-me-sender:x-sasl-enc; s=fm3; t=1794923536; x=
	1795009936; bh=70DfZfFKXRaieDq8Pk9B90fU5z9WYAvkXhfACEP3qcs=; b=i
	0F0KlizY9fYR05xWMNMBDU/8d+P0ofG+d4tvdoDPn097lZjwC7GZpPp7E6zPF1q4
	6Q9gr7ayD2pP9bdTDpzmldv4N/7TKyfQkcHYsPeSrKmrHaeOnR7SHcbqr8g5XzmA
	R8FMqm/SylMZDd17dUOZJqOOtKVAERWrk4iMk1hRgisRfKAoEQdHnWSQFiuj6gGL
	d3OxvvwaW6TF3xi50PzIixbgQbGe2jWd07Jxu9frtcJYCOVk0GlgZASxUnJ6VxlR
	bSUfl0rh0Umbq105poGhM79DGYu122515kXpllMJiwK0q+lNpwDWCBrk35Gg14vU
	/ds3bAGYu0TZNhJD9MFeA==
X-DKIM2-Info: draft=ietf-dkim-dkim2-spec-09;
	repo=github.com/dkim2wg/interop; date=2026-11-03; sw=lmtpprox;
	action=sign d=arndb.de a=rsa-sha256;
DKIM2-Signature: i=1; m=1; t=1794923536; d=arndb.de;
	mf=PGFybmRAYXJuZGIuZGU+; rt=PHN0YWJsZUB2Z2VyLmtlcm5lbC5vcmc+;
	s=fm2:rsa-sha256:Ue0xD5ZC4TNhu7wEN/X5lMSe0FCr2lZ6VkLAMabCEfk0xxu
	vr7e0SuOBqHt/H7somU7e6xndyiK1GR+opJmrkQolaAHUu0cEAkhtNurOJrqh4iJ
	9Q4xmYflzi7mE/r6wSZNz7QBfVlijDmk1jUM99/QnjITozSeuAWu+Y5CslxNZqUL
	wF9TE2F7TJB9ObT4llPTsPQr4qBM0a0SJdyCtMReE4ouGJloqvvPeP9ECdY+2+50
	3T8VVr28sgY4Jn91O0Bv5M8L6ups/pyM68Wc8CYJzXvcIfvq5hWaAc/9cZBy5YNG
	NtTP11bf4fC6sVYCG0hqtrYL5UXAM6oIuSRYsiA==;
X-DKIM2-Info: draft=ietf-dkim-dkim2-spec-09;
	repo=github.com/dkim2wg/interop; date=2026-11-03; sw=lmtpprox;
	action=mi-m=1; hc=12;
	hn=cc,content-transfer-encoding,content-type,date,feedback-id,
	from,in-reply-to,message-id,mime-version,references,subject,to;
Message-Instance: m=1; h=sha256:a4sh5katwY3sk4nluWL68Ro8t3huMRlOF0IEQTQsYMo=:TWxQp3xG7bFeorA66FGctaC8sTOSNUIbVqQqm9Wca38=;
X-ME-Sender: <xms:Clz8anWDkquIeRmPpaMC8pZGm-EbL2puLbs6CkabcerL_BCOz5RplQ>
    <xme:Clz8aqbq5zAftxvDghU5hH1yCDKywIUASeS0Ej_kwQH130wsQdfJbBPDB65hyKCqM
    iZ43XLeCCBFlPm8Bd4chXJtfvCwXAMavlzLbP3ckaea-FWUvnDMuAgp>
X-ME-Proxy-Cause: dmFkZTErj3UNL1H8vGxcIV9waJUX7Kb4aDL90O1n6cyapaglOpbqhZOQHRL4N9Of3vEnk0
    8Lq6myvF4mYoxTQq9CL5EOgkvK/82hT5/T5f4aKsrXe7EfGOtRJjJ8h7VctaTG3sQeNBAf
    F3xW8RId3M0d3vKpfwT5opIXqB58oltuQaN6JJQR+RcaJPof7TAoZPTEoEpGSQHWw4SLOQ
    o8lImCOOujg+ehqfhrhGAUcxXuXbuaU3WPwEohNaqepY54bYDvsMb2W2S5ZKxL4AJPTgY8
    X67Nv8qI+ozjTEzRSyewaU5AfK5fl5kMXCITJfMMs0FY3F4MFdv+77OfgKdCFFEP7u10M0
    Gb/3bO2hBba/HSRs1F19loLPydSszZF58tpIbbvhJkmYTN3yI3TPFQTWr+jsrrNM3WDAEY
    nHjA0SRHcFr4b3rqIXsoh3PRSe8Wz5DG69nNweJ0VJcAe4lIkVl3ue84ebIjjNv2DxfjXz
    bw3QbNLYAGVTyOPhpdptMW2k2AnPxOP43B4rH962wgyWDT39UVqIuDR4SFZXX3J0NYmquF
    QcME7r+w732IQ7FRJNpR2DW5p4dTLYk+ZxhHlPrnCTsFXkOLEkmt5SrUiAUkVo9EOgJubV
    WXIVeZCpQtihtEzmb45WEHEVw+e5H6N+3FM6t5CsQ8z/kUV1yS1rXn34ODhQ
X-ME-Proxy: <xmx:DFz8avR48OzdtK6IPGxqK5xkTUy4IWbCcrb9QymI_xRvJ8vQ4hKXxw>
    <xmx:DFz8anI2aVo7LJvln8G6ohYcXtwbsj2VR134nHam9AmOPVfUKuJm8w>
    <xmx:DFz8ahG8vo86pBxJBlVeopVBl41CvjJdCZedjbtcP1_q-lMRTa6-Xg>
    <xmx:DFz8as34RhQTeAUnYPP6HbyG7pqjwRomuz9gnjzSMuuafdsOhL_HFw>
    <xmx:EFz8aq_gFF2O1G8MurySICHSgLzeGIYlq6FQXxG4MiDSbNrkSLkEH2u9>
Feedback-ID: i56a14606:Fastmail
Received: by mailuser.ams.internal (Postfix, from userid 501)
	id 058D032A009E; Tue, 17 Nov 2026 08:52:10 -0500 (EST)
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
X-ThreadId: AqUefEB18S3J
Date: Tue, 17 Nov 2026 14:51:49 +0100
From: "Arnd Bergmann" <arnd@arndb.de>
To: "Gregory Price" <gourry@gourry.net>, linux-mm@kvack.org
Cc: linux-kernel@vger.kernel.org, kernel-team@meta.com,
 "David Hildenbrand (Red Hat)" <david@kernel.org>, "Zi Yan" <ziy@nvidia.com>,
 "Joshua Hahn" <joshua.hahnjy@gmail.com>, rakie.kim@sk.com,
 "Ying Huang" <ying.huang@linux.alibaba.com>,
 "Andrew Morton" <akpm@linux-foundation.org>, larips <larips950@gmail.com>,
 stable@vger.kernel.org
Message-Id: <6695bd2a-5450-48b6-8ebc-8b847e7c1dad@app.fastmail.com>
In-Reply-To: <3b9d974c-18d3-4113-b7a6-1f785f19b318@app.fastmail.com>
References: <20261117101910.1820066-1-gourry@gourry.net>
 <3b9d974c-18d3-4113-b7a6-1f785f19b318@app.fastmail.com>
Subject: Re: [PATCH] mm/mempolicy: limit compat bitmap reads to the source nodemask
Content-Type: text/plain
Content-Transfer-Encoding: 7bit

On Tue, Nov 17, 2026, at 13:44, Arnd Bergmann wrote:
> On Tue, Nov 17, 2026, at 11:19, Gregory Price (Meta) wrote:
>> A 32-bit get_mempolicy() call can read past the kernel's stack nodemask.
>> With 64 possible nodes and maxnode=65, copy_nodes_to_user() computes an
>> eight-byte copy, but compat_put_bitmap() reads two native words.
>
> I don't quite follow the explanation yet:
>
> if maxnode=65, shouldn't that result in copying 16 bytes on x86-64
> and 12 bytes on compat mode?
>
> It looks like compat mode adjusts the wrong variable and we should
> be doing this instead:
>
> diff --git a/mm/mempolicy.c b/mm/mempolicy.c
> index 6d662a9a8c74..f9a7be9f4432 100644
> --- a/mm/mempolicy.c
> +++ b/mm/mempolicy.c
> @@ -1749,12 +1749,12 @@ static int get_nodes(nodemask_t *nodes, const 
> unsigned long __user *nmask,
>  static int copy_nodes_to_user(unsigned long __user *mask, unsigned 
> long maxnode,
>  			      nodemask_t *nodes)
>  {
> -	unsigned long copy = ALIGN(maxnode-1, 64) / 8;
> +	unsigned long copy = ALIGN(maxnode-1, BITS_PER_LONG) / 8;

I guess this would be an ABI change for 32-bit userspace asking for
maxnum that results in an odd number of 32-bit words. The man
page documents this as "The value specified by maxnode is always
rounded to a multiple of sizeof(unsigned long)*8", while the
code here has always rounded it up to a multiple of 64 in
both native (no longer supported on 32-bit) and compat syscalls.

numactl (1) always uses 128 or 2048 bit masks and won't notice
it either way, so we can possibly change the ABI here and
do what the man page says, or keep the current behavior and update
the man page.

It looks like the other part of the problem is the off-by-one
error: the "ALIGN(maxnode-1, 64) / 8" rounds down maxnode=65
to copy=8 which is the same as nbytes, but the compat_put_bitmap()
treats it as a 65-bit map that needs 96 bytes. 

This means we have a related bug on native syscalls as well:
asking for a 65 bit mask in mempolicy only returns 8 bytes
without clearing the next word like it would for a 66 bit mask.
If we just fix the off-by-one and keep the 64 bit alignment
(with a manpage update), the version below be should be sufficient.

   Arnd

--- a/mm/mempolicy.c
+++ b/mm/mempolicy.c
@@ -1749,13 +1749,10 @@ static int get_nodes(nodemask_t *nodes, const unsigned long __user *nmask,
 static int copy_nodes_to_user(unsigned long __user *mask, unsigned long maxnode,
                              nodemask_t *nodes)
 {
-       unsigned long copy = ALIGN(maxnode-1, 64) / 8;
+       unsigned long copy = ALIGN(maxnode, 64) / 8;
        unsigned int nbytes = BITS_TO_LONGS(nr_node_ids) * sizeof(long);
        bool compat = in_compat_syscall();
 
-       if (compat)
-               nbytes = BITS_TO_COMPAT_LONGS(nr_node_ids) * sizeof(compat_long_t);
-
        if (copy > nbytes) {
                if (copy > PAGE_SIZE)
                        return -EINVAL;

