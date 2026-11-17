Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=103.168.172.144
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1794929326;
	b=5NJfEBOIRpB21Wdzr6ag2HEo2RuZyCDrjkRvPDBrZJphNMN4XjejVeOhcgXkXt3B84rt
	 /lZdMcyp9/8kuHVCX3BJuumN7fGgcKtPNJnVyZh0oM+TcQNM+YXjheJFcSn7kqjgy0/1b
	 TZXG0/id2zvqdWwkgfjPv9fBMkXRTsbfU7zmE3sZhrzKg2eWNG9S/CoW7fOTBeBqPr1y4
	 ibIRkNdKzdVD+UtgY3akTm/L90Hzk1hu1oM5qsb2yfWjm77qj0QkLlEd8FLJF7o2e0uEC
	 NYyVUnxDKnDAOS0lRySg21NzK2sTeYlEbCauy4QIyO1X8biOn6+tMU0x4fCptDe9bfQ==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1794929326;
	h=DMARC-Filter:Received:Received:DKIM-Signature:DKIM-Signature:
	 X-DKIM2-Info:DKIM2-Signature:X-DKIM2-Info:Message-Instance:
	 X-ME-Sender:X-ME-Proxy-Cause:X-ME-Proxy:Feedback-ID:Received:X-Mailer:
	 MIME-Version:X-ThreadId:Date:From:To:Cc:Message-Id:In-Reply-To:
	 References:Subject:Content-Type:Content-Transfer-Encoding;
	bh=q6pyCr0GkLU3KUX4qf5YaMe8wc/vHjeUENbzf1v2mk8=;
	b=KVwAdjDFhJ5KgmDlmInLXfj6VTvFr1kgTFoEKIHWxjnm8I/YdK4Se8oB0zYRMbb5Xgoc
	 kvPmhngapUInmVM0RIVZuHGHnaqb8+j72WJ6g0Q6efPwKFu5kNA23IGsXHiaBw26QYFuR
	 lwBIkpupPnhV/p89rLLM8i0l9/f6+eZC53BSbf++WJzwpVckMW8tvj57KiJLzykg7MzX9
	 gIxqaO2rzZDI9KQ16lcH8zm2YbBgcjDIKn23yS6RPyHnm1h1H26xZ7eo/IXsKYCB7Jksc
	 zh6TROtMlm1bfT2wYoKyupQ1eooe1643pQYTsQyRsgJXiapHduC91w97gE+SLONhIKQ==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=arndb.de;
	spf=pass smtp.mailfrom=arndb.de;
	dkim=pass header.d=arndb.de header.i=@arndb.de header.a=rsa-sha256 header.s=fm2 header.b=V9FWSG7K;
	dkim=pass header.d=messagingengine.com header.i=@messagingengine.com header.a=rsa-sha256 header.s=fm3 header.b=FhNMVdAr;
	arc=none smtp.remote-ip=103.168.172.144
Received: from fout-a1-smtp.messagingengine.com (fout-a1-smtp.messagingengine.com [103.168.172.144])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id ACD84606A32A
	for <stable@vger.kernel.org>; Tue, 17 Nov 2026 15:28:45 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org ACD84606A32A
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=arndb.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=arndb.de
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=arndb.de header.i=@arndb.de header.a=rsa-sha256 header.s=fm2 header.b=V9FWSG7K;
	dkim=pass (2048-bit key, unprotected) header.d=messagingengine.com header.i=@messagingengine.com header.a=rsa-sha256 header.s=fm3 header.b=FhNMVdAr
Received: from ams-compute-02.internal (ams-compute-02.internal [10.64.2.62])
	by mailfout.phl.internal (Postfix) with ESMTP id C99F6EC0610
	for <stable@vger.kernel.org>; Tue, 17 Nov 2026 10:28:44 -0500 (EST)
Received: from ams-imap-03 ([10.64.2.23])
  by ams-compute-02.internal (MEProxy); Tue, 17 Nov 2026 10:28:44 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=arndb.de; h=cc
	:cc:content-transfer-encoding:content-type:content-type:date
	:date:from:from:in-reply-to:in-reply-to:message-id:mime-version
	:references:reply-to:subject:subject:to:to; s=fm2; t=1794929317;
	 x=1795015717; bh=q6pyCr0GkLU3KUX4qf5YaMe8wc/vHjeUENbzf1v2mk8=; b=
	V9FWSG7KanChbguql1pGqVTYgsdbLO1OHzoGg0ROQEmhmowoYZ+lzYk6Zx1bt7bG
	Iho+o4laZKPQW3h1rWhM3pIH6rH0ZvmrIoC2Y5/HCY9vGTFzbZNz80Qv3tMWBYIj
	JBGNJTcGSDkvfRHl9P8w0lJl5DzKndXikm6/WeKukHUCIR3G+K9+d0dzGaL2GjbD
	t+thYQm2X2tNr0XRdaV/TJUEilGvRbUWBwfdiINMrFHKl0gc8swyHj1URI9LNFPb
	z9+bAbrIzt0u5YAROyv4ZzVXJ59yZD/PGt/4T8zyQbQdLiqPyDECLJX/M7vEiL/q
	DvqyjAdfFfBVxvwR5AXsVQ==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:cc:content-transfer-encoding
	:content-type:content-type:date:date:feedback-id:feedback-id
	:from:from:in-reply-to:in-reply-to:message-id:mime-version
	:references:reply-to:subject:subject:to:to:x-me-proxy
	:x-me-sender:x-me-sender:x-sasl-enc; s=fm3; t=1794929317; x=
	1795015717; bh=q6pyCr0GkLU3KUX4qf5YaMe8wc/vHjeUENbzf1v2mk8=; b=F
	hNMVdArSi1j2Edq114cYAtkzv0SHGyv3MeNUEb/U86X44P1Fj0H0v2F8H0U0ZU5P
	ms1EpD/UugrFLJ1H53UIqNPPdBHzewSalQ9qNIInM/FppxMKUIw3Q/wQpotVwRd6
	UZ+iJUmDjmpj8DJ6WBNUkyPRaqnqEI1BOmfcKEIOZwoPrC+HFmqzOgBaPKWmc3lw
	PhRSfBGtV0lKOs9NzW/yJJ/IRQr0PDmomaIjCC+GlzLGRg+GetIv9tZjJsHDHEsV
	jX2Eui3Tgq4D3SmSIY7uE1AEIyOjap4iXi+SKJuF4dZW0VYUoP+V7mVcIwNbigD2
	2g6JScK2kv74Sa7NrqBiQ==
X-DKIM2-Info: draft=ietf-dkim-dkim2-spec-09;
	repo=github.com/dkim2wg/interop; date=2026-11-03; sw=lmtpprox;
	action=sign d=arndb.de a=rsa-sha256;
DKIM2-Signature: i=1; m=1; t=1794929317; d=arndb.de;
	mf=PGFybmRAYXJuZGIuZGU+; rt=PHN0YWJsZUB2Z2VyLmtlcm5lbC5vcmc+;
	s=fm2:rsa-sha256:IyTEkwHRq9ziP2u/F0L7Mk7k2dUi9yEU8RYj11XC7Z5Mndz
	NCfTMdwnvmAU5WnY0I+MKfoRW4bWEAZYB299KSOo+H2kt1c1cm4xcrKMaGCEO3Vb
	JNPCIX43VKHfxho0LhEwY0njBShf1+8rcy6qd4Uc6JyHW6G/rQ5KrTJtb/iYXppS
	+bc4azdOL2KWQ/g1rAzo3D75z8PzRnmoEa5MNP1h6xzS1S+RTAUcFHiAnqvWoy1N
	ZWrqbkGRE1+jeKvoAc0eFj6gO6/DLlnJLgrgr4dhDgnUXDVKOn+rl9b8ZfhzKRtl
	mAPAxc+1d9CuXuYYiEMTEFcOIL7QHvEjHgrKV4Q==;
X-DKIM2-Info: draft=ietf-dkim-dkim2-spec-09;
	repo=github.com/dkim2wg/interop; date=2026-11-03; sw=lmtpprox;
	action=mi-m=1; hc=12;
	hn=cc,content-transfer-encoding,content-type,date,feedback-id,
	from,in-reply-to,message-id,mime-version,references,subject,to;
Message-Instance: m=1; h=sha256:wFlr+fT8EushZmCi/A62q7w2Btos2NKAwyaUzeqjiLk=:H9WGOLfPjUk/h+N3lN1a6Jp7duIUy/dutpF8qeTu8z8=;
X-ME-Sender: <xms:nXL8an35Jmtlsuk8surVwkqw1hxD9jGwHParnPrZczExG-fY4Jb-rA>
    <xme:nXL8ag5cieQ8MbNSxREODQc322J7zjuPLZbZK25MKuS3fZ3Zgq7ndYcdgebsGhQIg
    e7-f-h0PJLMyI2MOzAnDpIMtgQrXGAtKGqsJ5e_hyoGspiUe9kNVtHr3w>
X-ME-Proxy-Cause: dmFkZTGX7EIyx6vqTiIUSojs4OE9UyzzF5IPpKLC/H9pXDy5+hYRXbaHgdTstjLDjvMmhO
    qbAYAlIvMiVnHtDqch6S2ijYZkkekrM3/ArR9PA/spuF4E7hrOTr5s7AGdWBRYjLtYVhFZ
    A6zQUQvadLqOVzG5RPjUPTyokUGYMG5nIB5IQBmTJh8LLE8uIysOkjdAhH1cwXx4/lteMH
    Q2G/gqTAlRw03FumW41oadDeDqE8aeWzRuerjySLAFiGaMp3medyEgVUkw5HGWMwbFmRBC
    eP2NL21nvxUmL6fC11LJLiDrfUMdSDJs3PkUB6e4FL9JZsYANauAdJDIqVpCTNiqEsMQtX
    h+1us8HsYJJpAgERTWHljsadE0gqJ2WyPwytwdsRTlMRhKTZPOYPvzafDSIqFNbthNEhxJ
    y4hlVwbMMGI8OV34xeMlhhk6GSLEDjBsjLKXwjuplylLAT6rr7Sz/jWTtCC/JIsIhyWkHI
    gZiGDu4NpF0s4XpTimoCT315Qm421C4MTmCw8OKLinN99yTDsKqBMn20n//eM5906bj1IY
    JLzWlNh2TH2Hx+UcwJCmtbgasdyecTYy9XBgA86AFdUr72j5PcvFCMpDkiQDao/x8716ZX
    /fyUXSP6/otBnjqFgNqlWrtH8QfkIYXV6UQ9y4hHoGZaSMiNzPlLdPDuek2g
X-ME-Proxy: <xmx:n3L8anibFLfxet3kbA_7wgEMyzg7sa0frsq0EcErQF5egzbGaXUwgA>
    <xmx:oHL8aihAmrkaGYtvOzXx7l-iDJaePyEh76yA5xOTqDnSAu_qqbDTQg>
    <xmx:oHL8at5cLefG1GGlYhYLzqYMQa99S-3Dvib5WDe9xk4ejoT-mKnEgg>
    <xmx:oHL8akRKziG_meZAeRPYAezd2quBKbcNSaHu1TFvkPRBQhAYucwsGA>
    <xmx:pXL8aqta1EgWS4SY7AgRo9hTPnwfA2h8IKUvmRhEVacjyn1epzT-wpbL>
Feedback-ID: i56a14606:Fastmail
Received: by mailuser.ams.internal (Postfix, from userid 501)
	id 2D8D432A0099; Tue, 17 Nov 2026 10:28:29 -0500 (EST)
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
X-ThreadId: AXxIX-uOARoc
Date: Tue, 17 Nov 2026 16:26:48 +0100
From: "Arnd Bergmann" <arnd@arndb.de>
To: "Lorenzo Stoakes" <ljs@kernel.org>, "Arnd Bergmann" <arnd@kernel.org>
Cc: "David Hildenbrand (Red Hat)" <david@kernel.org>,
 "Gregory Price" <gourry@gourry.net>,
 "Andrew Morton" <akpm@linux-foundation.org>, larips <larips950@gmail.com>,
 stable@vger.kernel.org, "Zi Yan" <ziy@nvidia.com>,
 "Joshua Hahn" <joshua.hahnjy@gmail.com>, "Rakie Kim" <rakie.kim@sk.com>,
 "Ying Huang" <ying.huang@linux.alibaba.com>,
 "Brendan Jackman" <brendan.jackman@linux.dev>,
 "Johannes Weiner" <hannes@cmpxchg.org>, "Jackie Liu" <liuyun01@kylinos.cn>,
 linux-mm@kvack.org, linux-kernel@vger.kernel.org
Message-Id: <541a67af-3b45-4d5d-ac4b-c741850f92e1@app.fastmail.com>
In-Reply-To: <avxnIQTcFni9G4IN@gremlin>
References: <20261117142628.3931151-1-arnd@kernel.org>
 <avxnIQTcFni9G4IN@gremlin>
Subject: Re: [PATCH] mm/mempolicy: fix copy_nodes_to_user() for odd inputs
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable

On Tue, Nov 17, 2026, at 15:59, Lorenzo Stoakes (ARM) wrote:
> On Tue, Nov 17, 2026 at 03:25:53PM +0100, Arnd Bergmann wrote:
>> From: Arnd Bergmann <arnd@arndb.de>
>> For compat syscalls, the effect is worse, as the actual calculation f=
or
>> the size does include the extra word, but the check for the input size
>> does not take it into account and can leak a word of stack data.
>>
>> In addition, the size calculation rounds up to multiples of 64 bits
>> instead of multiples of word size as documented in the man page and
>> expected by numactl.
>>
>> Fortunately numactl always passes multiples of 64 here, so none of
>
> (Claude) went looking at numactl source (e.g. via libnuma) and it seem=
s it
> passes size + 1 matching the convention?

Ok, I see it now as well. The man page again says "maxnode specifies
the number of node IDs that can be stored into  nodemask=E2=80=94=E2=80=94=
that is,
the maximum node ID plus one.", which I'd na=C3=AFvely interpret as mean=
ing
that a system with 64 nodes would have a "maximum node ID" of 63 and
require passing one more (64), but clearly the implementation on
both sides expects a 65 here.

>> diff --git a/mm/mempolicy.c b/mm/mempolicy.c
>> index 6d662a9a8c74..f318e1155770 100644
>> --- a/mm/mempolicy.c
>> +++ b/mm/mempolicy.c
>> @@ -1749,12 +1749,12 @@ static int get_nodes(nodemask_t *nodes, const=
 unsigned long __user *nmask,
>>  static int copy_nodes_to_user(unsigned long __user *mask, unsigned l=
ong maxnode,
>>  			      nodemask_t *nodes)
>>  {
>> -	unsigned long copy =3D ALIGN(maxnode-1, 64) / 8;
>> +	unsigned long copy =3D ALIGN(maxnode, BITS_PER_LONG) / 8;
>
> This looks like it'll be broken given the convention of passing bits +=
 1,
> e.g. ALIGN(1025, 64) / 8 !=3D ALIGN(1024, 64) / 8.
>
> Then later that could case a buffer overflow potentially?

Right, this would then overflow the user buffer.

> Overall it seems the issue is that e130242dc351 (understandably!) pass=
es maxnode
> rather than maxnode-1.
>
> So a really small fixup would be something like:
>
> diff --git a/mm/mempolicy.c b/mm/mempolicy.c
> index fb627b37afcb..051d411c04ee 100644
> --- a/mm/mempolicy.c
> +++ b/mm/mempolicy.c
> @@ -1733,12 +1733,12 @@ static int copy_nodes_to_user(unsigned long=20
> __user *mask, unsigned long maxnode,
>  		if (clear_user((char __user *)mask + nbytes, copy - nbytes))
>  			return -EFAULT;
>  		copy =3D nbytes;
> -		maxnode =3D nr_node_ids;
> +		maxnode =3D nr_node_ids + 1;
>  	}
>
>  	if (compat)
>  		return compat_put_bitmap((compat_ulong_t __user *)mask,
> -					 nodes_addr(*nodes), maxnode);
> +					 nodes_addr(*nodes), maxnode - 1);
>
>  	return copy_to_user(mask, nodes_addr(*nodes), copy) ? -EFAULT : 0;
>  }
>
> Maybe doing that's the easiest route for this?

I would still try to fix the other mistakes (aligning to 64 instead
of BITS_PER_LONG/BITS_PER_COMPAT_LONG and the incorrect nbytes).
Maybe it's clearer to just pass the adjusted maxnode into the
function directly and keep that extra '-1' in one place?

     Arnd

diff --git a/mm/mempolicy.c b/mm/mempolicy.c
index 6d662a9a8c74..931194421c4f 100644
--- a/mm/mempolicy.c
+++ b/mm/mempolicy.c
@@ -1749,12 +1749,12 @@ static int get_nodes(nodemask_t *nodes, const un=
signed long __user *nmask,
 static int copy_nodes_to_user(unsigned long __user *mask, unsigned long=
 maxnode,
 			      nodemask_t *nodes)
 {
-	unsigned long copy =3D ALIGN(maxnode-1, 64) / 8;
+	unsigned long copy =3D ALIGN(maxnode, BITS_PER_LONG) / 8;
 	unsigned int nbytes =3D BITS_TO_LONGS(nr_node_ids) * sizeof(long);
 	bool compat =3D in_compat_syscall();
=20
 	if (compat)
-		nbytes =3D BITS_TO_COMPAT_LONGS(nr_node_ids) * sizeof(compat_long_t);
+		copy =3D ALIGN(maxnode, BITS_PER_COMPAT_LONG) / 8;
=20
 	if (copy > nbytes) {
 		if (copy > PAGE_SIZE)
@@ -2030,7 +2030,7 @@ static int kernel_get_mempolicy(int __user *policy,
 		return -EFAULT;
=20
 	if (nmask)
-		err =3D copy_nodes_to_user(nmask, maxnode, &nodes);
+		err =3D copy_nodes_to_user(nmask, maxnode-1, &nodes);
=20
 	return err;
 }
