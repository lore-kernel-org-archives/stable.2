Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=57.103.69.135
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1795845249;
	b=ziKT+QxSpA1CG1Y64aactJBOWoRFX1mijXU4tGc89FGcZ2DuMhhG/ZnZOL65+JSBLVNF
	 JVQh8xaCKCqG/R/05qAOAk61BtSyo3UCnWRFOl0F9v+6dMX0TuF3WD1gDiVx3EvDLd4F7
	 dCftVpSJy4qfZXb9zYKu5QbIWT0Jcl5Rw/uDqE/VTjXqzhKQI5n1WJYd6ict3d+5XX2oD
	 S5lGBELRORgs635Jb5GIwQCb9/ojBSny/8S319GeelwiwtQ7q8C7tW1JCKW1a6a0j7zAp
	 IY9fqjfb4+mGeF4fjQjShxJXhPMEryyIafJh2jV8817PNJz3doGPt+5E33jTd2PoqoA==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1795845249;
	h=DMARC-Filter:Received:X-ICL-RepId:Dkim-Signature:Received:
	 Content-Type:Content-Transfer-Encoding:From:Mime-Version:Date:Subject:
	 Message-Id:To:X-Mailer:X-Proofpoint-Spam-Info:X-Authority-Info-Out:
	 X-Proofpoint-GUID:X-Proofpoint-ORIG-GUID:
	 X-Proofpoint-Spam-Details-Enc:X-JNJ;
	bh=iTLkpjNBmUHTLxwjTXlDh5F48M6j0SlaFMr1rOOI49I=;
	b=eIn37FJPcoDXOgU2W8vj3VNXsUV/D4H7MSQcyffdWL926G9i9ZGpM8LDXgKhysuM/kmr
	 7FO/UcsSFjJWkct+SciLq2VFSeJD7Cqn/ksT1YLaKMKnLCthKMGZEoPvqNDu+/hA3ylkc
	 B2Otg0gvXC07DL3GMOqSGWTjFD+w8j+E3InYZ01HN4PTrEzYk2IwNVOyXuBQIZEs/4pvl
	 LkkaxcVuC7+r7Zg21ys6UlpzaC8RaJr8FtOpJ5RQpNuoA845l5sj+CSgzkenojajBKw/G
	 FOJs9ydoN2FwVjy7CmHvtSSG1PojItB0kWS8u66WJZi7YSH1K0GecFAIcgN/lJreAHQ==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=icloud.com;
	spf=pass smtp.mailfrom=icloud.com;
	dkim=pass header.d=icloud.com header.i=@icloud.com header.a=rsa-sha256 header.s=1a1hai header.b=QYqxexg6;
	arc=none smtp.remote-ip=57.103.69.135
Received: from outbound.mr.icloud.com (mr-2004k-snip4-4.eps.apple.com [57.103.69.135])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 84A92606A31C
	for <stable@vger.kernel.org>; Sat, 28 Nov 2026 05:54:09 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 84A92606A31C
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=icloud.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=icloud.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=icloud.com header.i=@icloud.com header.a=rsa-sha256 header.s=1a1hai header.b=QYqxexg6
Received: from outbound.mr.icloud.com (unknown [127.0.0.2])
	by p00-icloudmta-asmtp-us-west-2a-100-percent-0 (Postfix) with ESMTPS id D95D518001BB
	for <stable@vger.kernel.org>; Sat, 28 Nov 2026 05:54:07 +0000 (UTC)
X-ICL-RepId: 01a220b7-d347-7f16-8cc2-3c4abb797677
Dkim-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=icloud.com; s=1a1hai; t=1795845249; x=1827381249; bh=iTLkpjNBmUHTLxwjTXlDh5F48M6j0SlaFMr1rOOI49I=; h=Content-Type:From:Mime-Version:Date:Subject:Message-Id:To:x-icloud-hme; b=QYqxexg6Vwk9g51tE3uHydLr857qyqVpwpm3VglvKv5Lh7PZ1ZcmytahqbG5cdgEemFlygxVddItw/tgcw33w3YApV3+57x0u262LU+yRUSi9GIyi0BqS/6vZCxbMlqDCxAC4EbUJjMNFUI3xx/W7qOYyIRN/0unTdT3bYR5/yHwX4F9zozkK9DI3+AKH5EISowKBGSbd3qK6zwv3Eptp+CnSNx8KQLlPpbTzbIWyrh6PBR3uuhSqDTkyuIdVBrjoZ7ucO/iE2gfIRpFcJEuBONRJgWTh3+UwKxW4yPaLQIkY9ox3dGRrJYj/8BjPa4nr6aXl+toaNKXknQl8UzTDQ==
Received: from smtpclient.apple (unknown [17.156.200.36])
	by p00-icloudmta-asmtp-us-west-2a-100-percent-0 (Postfix) with ESMTPSA id 30B561800233
	for <stable@vger.kernel.org>; Sat, 28 Nov 2026 05:54:07 +0000 (UTC)
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: quoted-printable
From: Haden Sangree <hadensangree@icloud.com>
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Post: <mailto:stable@vger.kernel.org>
List-Help: <mailto:stable+help@vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
List-Owner: <mailto:stable+owner@vger.kernel.org>
Precedence: list
Mime-Version: 1.0 (1.0)
Date: Sat, 28 Nov 2026 00:54:02 -0500
Subject: [PATCH] Request to backport drm/ast: Handle framebuffer from dma-buf to 6.12.y
Message-Id: <62B1A359-C39D-49D6-AC40-0E057B4C430C@icloud.com>
To: stable@vger.kernel.org
X-Mailer: iPhone Mail (23F77)
X-Proofpoint-Spam-Info: AW1haW4tMjYxMTI4MDAyMyBTYWx0ZWRfX775e5rgUcNH5
 MPIzbNHckMQtLaMzUlDy/+iECcxBIm0/DEENK320Yy2GsKlNFsjXyH6AOvcGixnIAhTk/mBKLw3
 VoBUe+yrekT10RRGNAUGfBQQ1/oPZpc=
X-Authority-Info-Out: v=2.4 cv=PYZqFShd c=1 sm=1 tr=0 ts=6b0a6c80
 cx=c_apl:c_pps:t_out a=9mRn2PO/+PIrVdEbaIuMPg==:117
 a=9mRn2PO/+PIrVdEbaIuMPg==:17 a=kj9zAlcOel0A:10 a=zJRp6_cAMcgA:10
 a=x7bEGLp0ZPQA:10 a=YVh8C_dAnfoA:10 a=VkNPw1HP01LnGYTKEx00:22
 a=HxOO8S7qDNDRVQTpMkN7:22 a=1-P0SRgB0hgiDeu8hSP7:22 a=B0suUGUQxq8G-THUkd4A:9
 a=CjuIK1q_8ugA:10 a=zZCYzV9kfG8A:10
X-Proofpoint-GUID: Uog3-Tt8habcxyL5WoJa1UG8v3KhMXsm
X-Proofpoint-ORIG-GUID: Uog3-Tt8habcxyL5WoJa1UG8v3KhMXsm
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYxMTI4MDAyMyBTYWx0ZWRfX3PvNhA0H7721
 NKSGqOaNdrvbkU4/N4zIM1gNaASQbtIbY48HBeLFEQT1787D615ju7bAX4rXfMVXEAyXm2lqsm2
 kzjqcIEfSEcuLOzWQ9hggFdb9FwmIMyoIy5FAMx581KplE2lSWMOQ9ZTmq3AaRfsffHS5SeTmr0
 QakgouthpT+pW6j8FZYg+QqInndBJATqQSAtG0AKKRLT+tpXB/WbDzz8G/6ObGRPoSpPUlVWL+t
 bL/iZ+H2ZT5RPmaD2nSPZpm5q0QANISJg6nAguufGF0aFzMnpn3FS+CNzVWVR/n9cffwwpAzlsb
 cz7dzCnmnVQ08ZF80vE5Sejr1cS0tmZNNKH6skBJ4PK5PY/I4ikMHxDdyc+8C4=
X-JNJ: AAAAAAABdtV5Xf5w2GG6AgnsvjLg0t9WoRhv3fazoL1ni50yfWpE5B2UnyhrqP1Z1cxVjO
 6l9wHOKUobP8+Zb2S6JGBCrokjYTxYkxJaCBTsN8HpOJE6loQ/LlYboT0qT3fRfxbM3izM
 28LALbq/wm6zcisikLNuQyhi91GWsKj3WJIMVPuGs4lg+ULYLXXlhEBRugKt6bIfUCIDlX
 G9P4rxq2ikK1zScZmh8xFu4RKG4+b1bY4XR5nJ1NFLSrWVQO1aKPtAW5IUnjb3Azg3hsoc
 h3aoNSbUCVmuUcR8SxuvkcVFCegFXeh1aF9N9nD8hCjXCiLiy8G+uh/R/pZOHmpRbd4G50
 WpvxkejHsJVbuvjffoKjmf3Eu45bK0Br8UDa2uoqab4XNIE5vXVULEYe2oeqwv+ts2qLCg
 l9acEXJGMldTETOeMy+YIyG1VoCrBA+srJS9Dx9JfWH02q9hIWS3KlxBgh2qCN62pqEPNS
 rPa8qtpku9VvcYsKR4JZR+q17a5rMUf4Ti+QKZ3R/fUcOMfKm7qDmxTQjL2dUZTzovohrs
 gKFcvshH7W0j8XHhW0Gj71L6Kw4FIPecykzKVJEZ9t6ulsfxH6ejbF/ZEGZ01lB7WplFRl
 RqEw++P1duHy6z+K6tW6VNPlXlcNjcfFv8AIs4h2ZrH1hnTCJFxVDom8G5bwIW7D14xdDk
 G4tk1QcEqQKZFNShvnGNkEj5r+OydkPJy34gG4JvPow4M+oOr2TSZDli3sBCRZgcrui8UH
 e6kxhT7SVnrwRVUx0fwjTlgePhcUm2kDHMrCiD6ERHx/lUjxR3JD784+h66I3esJ98nQ7g
 Io0umLFfHu2FMpvZpVStlWzkokXwf23USQvY55ntgVGWPO7dHfK7pgtaSEDbVF8MYrNRtE
 awWxlEC/YAYwV0jeyEYkTdwjZEFsnOa8S05o/hfHGZUHFAo7AaCC/vffndAq04Um+ygQ7j
 0dy01pK9RxX0uuV2ZbopXQvWDPx4peoKpI5brCNQyO0hhyaJJvqiHEE21IlxBdoaxQIVye
 Klf86FGlHJuyA1tvOrUolDj9vbvpVSngoR9JCUQXkgnJe20si4hfngzlSHA5K6qbi9yC+a
 WDPhpsQpQ0yOYES9KxnenDu9H4vNj258TOnYIz4P2L9kZ9A6NDU8RYMyYBXmz8gY2jbYGg
 2bNYh9ZTHNZUqVly88IAGOttlVfXE+w8D6P+LgxXlNU9k/nMBd5O7KIICYe8vF9afXo+wr
 KTZkPno5z3wi/xDO1OiOwbZypmbfWjXf

Hello,

I would like to request that the following upstream commit be considered for=
 backporting to the Linux 6.12.y stable series:

Commit: 3dd0be7a301bb0adcca4f7021cfd2e366ca90a0e
Subject: drm/ast: Handle framebuffer from dma-buf
Author: Jocelyn Falempe

I am running kernel 6.12.y on a system with an Intel Arrow Lake processor an=
d an ASPEED BMC graphics controller.

I encountered display corruption affecting both the physical VGA output and t=
he IPMI remote KVM when using the Intel i915 graphics driver. The issue appe=
ars related to framebuffer sharing between the Intel GPU and the ASPEED disp=
lay controller.

The upstream commit addresses synchronization of CPU access to framebuffers o=
riginating from another device by adding calls to drm_gem_fb_begin_cpu_acces=
s() and drm_gem_fb_end_cpu_access().

This appears directly relevant to the issue I encountered. I would appreciat=
e consideration of this commit for inclusion in the 6.12.y stable series.

Thank you.

-Haden Sangree=
