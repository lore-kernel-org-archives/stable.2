Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=90.155.50.34
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1795618891;
	b=TAP1AKaxnRXVUmL/cL9c++AKDW9SvzJqXMkAzXbTaHRXxfjXAjyiRQT1zbbQHifwgg/C
	 iY+44ytQcbpIFop1xQxdON6SZJIL4D14ewpYtekw4OFRrCGkZ+qSctirK63Mzw+brjPFU
	 LTK6iO8loGNFgmJIpAbdo7llQ3UANPfBzcMqMPjDQNA959YKo3wi337AleGJiJCenEFbx
	 Y4BqADrRJX98opZxCgcfsk8I2OGtCiFZMRRUbFzHR5HjLpM/ljGgeTwjxyDz32bnw4X+E
	 zQIbbSJhTsFLZ2B4J8I4RI9U429dkFzb3fuDYfACx8BfzphY60ywoC7FJj2L3FAwt6A==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1795618891;
	h=DMARC-Filter:DKIM-Signature:Received:Message-ID:Subject:From:To:Cc:
	 Date:In-Reply-To:References:Content-Type:User-Agent:MIME-Version:
	 X-SRS-Rewrite;
	bh=IkADng/l4Z8H3hkfoEhQoHEQBniUbrZ9k0nNnkDcv2w=;
	b=QqtPsgK8NbswfrEa267yEYI2wSBJNno/CBIyw71DuDrMLG5Y8W1VYPyXuPhoT3u+2dqk
	 jPH9OCK3yzIOsghCatxJB+ZegbSxQSOcV54pWzld6uskIyRfDyqbDxmsqaSvQOAr3FBY5
	 eemH81qZkgbdhdF1oQZVyiivF74MPKDihr/KWbYmoxgrumbzRi3Sc90NKcODotiLNCaJ2
	 WVAht2z8BDgjLRKolKcgcaIRKqsJRbGsjgx4CSTvHsX+aSXwFxAYj5WyugHy6x0CRwcKf
	 rp0gbgRn7pzy7OswXUMP8t0YEXgHler2SV0If7/VCiHhNibnBhlhcJOHWokns6rnrfQ==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=infradead.org;
	spf=none smtp.mailfrom=casper.srs.infradead.org;
	dkim=pass header.d=infradead.org header.i=@infradead.org header.a=rsa-sha256 header.s=casper.20170209 header.b=vGqWfDWX;
	arc=none smtp.remote-ip=90.155.50.34
Received: from casper.infradead.org (casper.infradead.org [90.155.50.34])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DCDD1606A330;
	Wed, 25 Nov 2026 15:01:29 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org DCDD1606A330
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=infradead.org
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=casper.srs.infradead.org
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=infradead.org header.i=@infradead.org header.a=rsa-sha256 header.s=casper.20170209 header.b=vGqWfDWX
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=infradead.org; s=casper.20170209; h=MIME-Version:Content-Type:References:
	In-Reply-To:Date:Cc:To:From:Subject:Message-ID:Sender:Reply-To:
	Content-Transfer-Encoding:Content-ID:Content-Description;
	bh=IkADng/l4Z8H3hkfoEhQoHEQBniUbrZ9k0nNnkDcv2w=; b=vGqWfDWXADy6QJdQtNfQuBH96V
	OSBBYpuAFgobtyv+qLH0HpvAymftUgR6LXUa57oRzSHXWJh9hV1XU6Kqh4Q4OtwOt2pWd3Ojzqu7c
	49b5Y3+tpPzr01gJShgDddUrQhjaAQ3rpiY7Dxg8LgcqutSVt6ML3i/G1K5e0Z3YuzoKKGWMglh2D
	tDIf+SjtpDLlLjrmwlDKLfqMJGDcfxDm20+UMM8o/mpJrZuHGvadjVGwy1nIG98UuL2uzbNEc+TpJ
	NdDz0vFi3mnhMnPWcf6W2h54dZCcqxUXTEjVOWeM/NEpkImplYelkcL9etv020FjPbKYrZv60zYrm
	z7uClcag==;
Received: from 54-240-197-238.amazon.com ([54.240.197.238] helo=freeip.amazon.com)
	by casper.infradead.org with esmtpsa (Exim 4.100.1 #2 (Red Hat Linux))
	id 1xWEUn-0000000GLOm-3Iza;
	Wed, 25 Nov 2026 15:01:18 +0000
Message-ID: <a724a94bef81dec39150a2d24201194e98ecc096.camel@infradead.org>
Subject: Re: [PATCH net v3] ptp: vmclock: keep the device state until the
 last file is closed
From: David Woodhouse <dwmw2@infradead.org>
To: Paolo Abeni <pabeni@redhat.com>, Chad Aldreda <ca@modelmiser.com>, 
 Richard Cochran <richardcochran@gmail.com>, Wen Gu <guwen@linux.alibaba.com>
Cc: Andrew Lunn <andrew+netdev@lunn.ch>, "David S. Miller"
 <davem@davemloft.net>,  Eric Dumazet <edumazet@kernel.org>, Jakub Kicinski
 <kuba@kernel.org>, Shuangpeng Bai	 <shuangpeng.kernel@gmail.com>,
 netdev@vger.kernel.org, stable@vger.kernel.org, 
	linux-kernel@vger.kernel.org
Date: Wed, 25 Nov 2026 15:01:16 +0000
In-Reply-To: <fdc005b9-e48a-4550-b66b-0f58db82babe@redhat.com>
References: <20261119061517.1142436-2-ca@modelmiser.com>
	 <1f77fa9014f8dfafb2be9cf15a66c5541880656a.camel@infradead.org>
	 <fdc005b9-e48a-4550-b66b-0f58db82babe@redhat.com>
Content-Type: multipart/signed; micalg="sha-256"; protocol="application/pkcs7-signature";
	boundary="=-ifNNgHR31pmqYObLjYoP"
User-Agent: Evolution 3.62.0-0ubuntu1~ppa1~24.04 
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Post: <mailto:stable@vger.kernel.org>
List-Help: <mailto:stable+help@vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
List-Owner: <mailto:stable+owner@vger.kernel.org>
Precedence: list
MIME-Version: 1.0
X-SRS-Rewrite: SMTP reverse-path rewritten from <dwmw2@infradead.org> by casper.infradead.org. See http://www.infradead.org/rpr.html


--=-ifNNgHR31pmqYObLjYoP
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Wed, 2026-11-25 at 12:38 +0100, Paolo Abeni wrote:
> On 11/24/26 20:44, David Woodhouse wrote:
> > On Thu, 2026-11-19 at 06:15 +0000, Chad Aldreda wrote:
> > > vmclock_probe() allocates struct vmclock_state with devm_kzalloc_obj(=
)
> > > and maps the shared page with devm_memremap(), so both are released
> > > when the driver is unbound, but an open /dev/vmclockN keeps using the=
m
> > > through its file state. After an unbind, read() runs on the freed
> > > struct and reads through the released mapping, and a poll() in
> > > progress sleeps on a wait queue in the freed struct. KASAN reports a
> > > slab-use-after-free in vmclock_miscdev_read(). In testing, the same
> > > read() faulted on the unmapped page once the device had been bound
> > > again.
> > >=20
> > > Allocate the state with kzalloc_obj() and map the page with memremap(=
),
> > > and release both on the last reference: open() takes a reference and
> > > release() drops it, and a devm action drops the device's own referenc=
e
> > > after vmclock_remove() has called misc_deregister(). misc_open() call=
s
> > > open() with misc_mtx held, and misc_deregister() takes misc_mtx, so
> > > open() always runs while the device's reference is held.
> > >=20
> > > vmclock_remove() now marks the device as removed and wakes every wait=
er
> > > on the wait queue. A read() or mmap() on a file that is still open fa=
ils
> > > with -ENODEV once it sees the mark. On a device that supports
> > > notifications, poll() returns EPOLLHUP | EPOLLERR, including a poll()
> > > that was already waiting; it tests the mark after poll_wait(), so it
> > > cannot miss the wake-up. The wake-up uses wake_up_interruptible_all()=
,
> > > because no later notification will reach a waiter that the remove-tim=
e
> > > wake-up skips, such as a second epoll instance that registered the fi=
le
> > > with EPOLLEXCLUSIVE. Without notifications poll() already returns
> > > POLLHUP.
> > >=20
> > > Separately from the report below, the bug was also found by a
> > > Coccinelle script that reports device nodes in devm-allocated memory,
> > > posted at
> > > https://lore.kernel.org/r/20261106193517.3267013-2-ca@modelmiser.com,
> > > and reproduced in QEMU 10.2.4 with -device vmclock. There is no acces=
s
> > > to EC2 hardware with this device, so the fix has only been tested in
> > > QEMU. QEMU's device has no notifications, so the poll() path was test=
ed
> > > with a local change that lets poll() wait without them.
> > >=20
> > > Fixes: 205032724226 ("ptp: Add support for the AMZNC10C 'vmclock' dev=
ice")
> > > Reported-by: Shuangpeng Bai <shuangpeng.kernel@gmail.com>
> > > Closes: https://lore.kernel.org/all/178144969601.60470.14493569608271=
069160@gmail.com/
> > > Cc: stable@vger.kernel.org=C2=A0# 7.0+
> > > Signed-off-by: Chad Aldreda <ca@modelmiser.com>
> >=20
> > Reviewed-by: David Woodhouse <dwmw@amazon.co.uk>
> >=20
> > We did have a plan to pull the PHC-only drivers out into drivers/phc
> > and leave only the *real* PTP in drivers/ptp. I kind of stalled on that
> > because I wasn't sure I had consensus especially from Richard and the
> > net maintainers. Shall I revive that and repost it?
>=20
> I'm sorry but that conversation is way of my context window. Do you have =
a
> pointer to the prior discussion? why such separation would be useful?

I think
https://lore.kernel.org/netdev/20251127083610.6b66a728@kernel.org/ is
the key answer to that.

The latest update (which I'm suggesting I should dust off) is at
https://lore.kernel.org/all/14969e704fb8e70deb549b2e1c8670f6756a8da7.camel@=
infradead.org/

--=-ifNNgHR31pmqYObLjYoP
Content-Type: application/pkcs7-signature; name="smime.p7s"
Content-Disposition: attachment; filename="smime.p7s"
Content-Transfer-Encoding: base64

MIAGCSqGSIb3DQEHAqCAMIACAQExDzANBglghkgBZQMEAgEFADCABgkqhkiG9w0BBwEAAKCCE8Ew
ggWvMIIEl6ADAgECAhANkOKMSmGXhF5eMl0rsRhvMA0GCSqGSIb3DQEBDAUAMGUxCzAJBgNVBAYT
AlVTMRUwEwYDVQQKEwxEaWdpQ2VydCBJbmMxGTAXBgNVBAsTEHd3dy5kaWdpY2VydC5jb20xJDAi
BgNVBAMTG0RpZ2lDZXJ0IEFzc3VyZWQgSUQgUm9vdCBHMjAeFw0yNDAzMTMwMDAwMDBaFw0zNDAz
MTIyMzU5NTlaMGIxCzAJBgNVBAYTAlVTMRcwFQYDVQQKEw5EaWdpQ2VydCwgSW5jLjE6MDgGA1UE
AxMxRGlnaUNlcnQgQXNzdXJlZCBHMiBTTUlNRSBSU0E0MDk2IFNIQTM4NCAyMDI0IENBMTCCAiIw
DQYJKoZIhvcNAQEBBQADggIPADCCAgoCggIBAOfSIeC0vv1xPQ+dgSxbIIrkaru6skAWJYaGFzmv
q4Kq+2wU2jxhcWlJg/JeP5jEkq/LM3pn5aaLao79j+XRmS7J1ZpJKUODJVoM4s9MQJhTMvo4qS5Z
S64g6QR7Obkz3I1Lr3aWeSBmDDEyzue+NKtuWZ1Cxy3RdXo/w5HgRc3l2AercOM3Gt1XonTzEtTb
Z/Hwc0Sn9Gz8RmGRK6Ka4hVDl8q/2l110KaV233Kh5etP0csXS8MIMdVRfRu3sc5hp13DG7lCKzK
72a2GEpI8Wpl26G6I1/LMzz/98T+FqjTqxsdquk7Cj7m2vKGLW1BorpQH7WFGPdJQXJe1hfbfiZA
CcVdCtl4nAacFacmsiArZBfX7AQGL7isvHUwwYFEtcApyGW4p2Lt+t8nvU0CANA6BHOpOz1xOP8W
mAESbUriIjyuTUf3fJ9oDNCurVqhASMJCDaWI3lYX/QAoiAzt6akqbbZxo2ujW7mGGqc0KxqE2cs
h2T79v7pC8aUtHBfwNrTR19GnZVxE0eQ7ViIQhR6mpSaUQFA9sG+cmD2G8TnCgYsLa0q8De6F61a
CBevQGHNzrbZ3JAMneveYg/Jy1XxQHDRcvrMfWKe0jjcWbdKYlaGVPm5V1ILwYz7Yv5ewo3NUrxI
GJiywe9qPhuJSDZs7VehTuI0FxGIsgKzVjgbAgMBAAGjggFcMIIBWDASBgNVHRMBAf8ECDAGAQH/
AgEAMB0GA1UdDgQWBBT3m6JO05fF9DQPQw6Bhc6RkzKv+TAfBgNVHSMEGDAWgBTOw0q5mVXyuNtg
v6l+vVa1lzan1jAOBgNVHQ8BAf8EBAMCAYYwHQYDVR0lBBYwFAYIKwYBBQUHAwQGCCsGAQUFBwMC
MHkGCCsGAQUFBwEBBG0wazAkBggrBgEFBQcwAYYYaHR0cDovL29jc3AuZGlnaWNlcnQuY29tMEMG
CCsGAQUFBzAChjdodHRwOi8vY2FjZXJ0cy5kaWdpY2VydC5jb20vRGlnaUNlcnRBc3N1cmVkSURS
b290RzIuY3J0MEUGA1UdHwQ+MDwwOqA4oDaGNGh0dHA6Ly9jcmwzLmRpZ2ljZXJ0LmNvbS9EaWdp
Q2VydEFzc3VyZWRJRFJvb3RHMi5jcmwwEQYDVR0gBAowCDAGBgRVHSAAMA0GCSqGSIb3DQEBDAUA
A4IBAQA+b8Uw53sDspdZgukU+qzLyyHkcjlxGGhHlP+zrmDLKm1wEFvCRS2pili3Hy67i8N4N5NU
vw5Rg6kv3lxb9S9Rktxk43k+tvm68pl7OxQE55ZjVY87P0lUPGwEqOOwLLyH02ZQcsfq5p5LrOH9
0JvmvZ1yy73HS+VpDAqOlytE0NSvTIRqFFkKQGQwfjvtql9YflujuNNvJztjBaHKYZsnNSg+J38o
jYq4TP3pSg3UdVH0PncVjPQyqxC9xef5Xae92Kbkzol3x7Nel3A1bwAkalrDMspvTHvey6LfiBks
FIqviTnoy7fgjaRAJgHS+RXx/cmuRd3rUAclSVVrYu8RMIIHAzCCBOugAwIBAgIQAzUotrsybJHx
HTjKOIVdIDANBgkqhkiG9w0BAQsFADBiMQswCQYDVQQGEwJVUzEXMBUGA1UEChMORGlnaUNlcnQs
IEluYy4xOjA4BgNVBAMTMURpZ2lDZXJ0IEFzc3VyZWQgRzIgU01JTUUgUlNBNDA5NiBTSEEzODQg
MjAyNCBDQTEwHhcNMjYwNzE4MDAwMDAwWhcNMjgwMTA0MjM1OTU5WjAeMRwwGgYDVQQDDBNkd213
MkBpbmZyYWRlYWQub3JnMIICIjANBgkqhkiG9w0BAQEFAAOCAg8AMIICCgKCAgEA2pYux73kdbYX
sWF8f1u6DJP91qcqaZetsyfPkZk0B+MmXmAEv0kVes5n15V2mbDThOnpoPFly0UugQO9JYqLfrtD
tKD5yL58fgrDB9Dw+LQikgrHafl6YSCds5AvUu/8hw2J6noKrcOLJpKlKn9Fl/4IB9Q3JIdLx5aa
EtTqMalIPqHFOlgrJ7s+aua8xbB8YQ9ahqYBXWRJNv3P/2b1DYtdrz1oqZPE3CcB8Pc6Gf2a1Tcm
6TAgtEx7Cf1BFcrsrMz7TWHmGQITieNb2r9UYWSc2Gp+GtYFNJCgT0JJXKUBIauPMKBLteYrL8Fo
ff/uY44dC/mDWjdCP/5x0qelPQjlBvWdHL5zvBTOj06rJ0m3HNI/hnIcDh0Qu2j9reb9rLVcdym6
bWmBM4uDEB8Zv9Ph0KTBFSy1IosyakuD1j1Os30EzjGfbi0EUXIvnOcYbTBAbM5UAzrxEHMhBvoX
Pvnx+OyvjJmc9tWxTX6AcSz+m40esbT17URBeZS18afgieiikm5TynlUYP1LciR3hSgGVzvGXnKO
02VDFR5itGWdRKZ2W5wIShNfWfhSa0D0K5UdIDt5Qc7sjzwK1Yb1sY5Tu0uA5mhIS82q1ov83uxB
sFkriNnhGv/M1NCDVLBiOMsHu73qUM+yKmgKLwF9Hfn9WI25glbAMI4S5r3hYzcCAwEAAaOCAfcw
ggHzMB8GA1UdIwQYMBaAFPebok7Tl8X0NA9DDoGFzpGTMq/5MB0GA1UdDgQWBBRcYhqbcGzn1jrT
JOZaB8O7qllDpzAwBgNVHREEKTAngRNkd213MkBpbmZyYWRlYWQub3JngRBkYXZpZEB3b29kaG91
LnNlMBQGA1UdIAQNMAswCQYHZ4EMAQUBAjAOBgNVHQ8BAf8EBAMCBeAwHQYDVR0lBBYwFAYIKwYB
BQUHAwIGCCsGAQUFBwMEMIGpBgNVHR8EgaEwgZ4wTaBLoEmGR2h0dHA6Ly9jcmwzLmRpZ2ljZXJ0
LmNvbS9EaWdpQ2VydEFzc3VyZWRHMlNNSU1FUlNBNDA5NlNIQTM4NDIwMjRDQTEuY3JsME2gS6BJ
hkdodHRwOi8vY3JsNC5kaWdpY2VydC5jb20vRGlnaUNlcnRBc3N1cmVkRzJTTUlNRVJTQTQwOTZT
SEEzODQyMDI0Q0ExLmNybDCBjQYIKwYBBQUHAQEEgYAwfjAkBggrBgEFBQcwAYYYaHR0cDovL29j
c3AuZGlnaWNlcnQuY29tMFYGCCsGAQUFBzAChkpodHRwOi8vY2FjZXJ0cy5kaWdpY2VydC5jb20v
RGlnaUNlcnRBc3N1cmVkRzJTTUlNRVJTQTQwOTZTSEEzODQyMDI0Q0ExLmNydDANBgkqhkiG9w0B
AQsFAAOCAgEAocabrh1cPd5s3vY5rnlBVQSTc7zs2ZWs67dAIltR+05WELrYClVzzUhMs/LOJPlr
EUo45UDDomXq38DxFepaPd9+iNLjXfn33EX/IG44j04lU/oF/Rg9VeQILkYLbCZ/x9wOjNHZc4SN
ydY7Dhvf/sT5aBz88u7D5+azZJ7Qf1U57wYseCH1Mt0nDrtr5y19IJ8D9xJJ33RFL6vfpHZBBAQ8
+3RqkKNxLoV2aFvQhxdhjNLDqTv3LjUIdicwPraN7JkxEu7CV2Lka7eRqJgkWL7SK0YmBjGpRafs
+icP/ON5RCCKTTb6VlX8eTG2sJJfsFhvJNCCt6xexbWzWtIrfP7NvPBvwBB737AyEGBZkS5aNizT
McURJGTv9UKvBh1LF/+tNhYtLvPCN7oecGzhCHht9jcwSkygTo3Y6YlK3QgOu+ncmiBbfeuwlLZ1
LxbYvG6hgNqXv7u6YyADbYajAQJXJ2OQen39pm3Q/AQSyLYG+B8lDglWsM8tYXPlEdrYJcksGK6F
nqIX6Bumn43rBooLJdiZp4WmfWdL2pxe+LxRDjprmqu1WprixDxULSTOKJZoqTlugs6y3Bc+if+s
gHnBBtz9WQ6MtPHkh7zONDAFIKcBmv8OqPQCx0F3Wv3OEybwMpXx0OsKgK8wLldaX1pXcMuyDgTL
Sqs0AV0OHUgwggcDMIIE66ADAgECAhADNSi2uzJskfEdOMo4hV0gMA0GCSqGSIb3DQEBCwUAMGIx
CzAJBgNVBAYTAlVTMRcwFQYDVQQKEw5EaWdpQ2VydCwgSW5jLjE6MDgGA1UEAxMxRGlnaUNlcnQg
QXNzdXJlZCBHMiBTTUlNRSBSU0E0MDk2IFNIQTM4NCAyMDI0IENBMTAeFw0yNjA3MTgwMDAwMDBa
Fw0yODAxMDQyMzU5NTlaMB4xHDAaBgNVBAMME2R3bXcyQGluZnJhZGVhZC5vcmcwggIiMA0GCSqG
SIb3DQEBAQUAA4ICDwAwggIKAoICAQDali7HveR1thexYXx/W7oMk/3Wpyppl62zJ8+RmTQH4yZe
YAS/SRV6zmfXlXaZsNOE6emg8WXLRS6BA70liot+u0O0oPnIvnx+CsMH0PD4tCKSCsdp+XphIJ2z
kC9S7/yHDYnqegqtw4smkqUqf0WX/ggH1Dckh0vHlpoS1OoxqUg+ocU6WCsnuz5q5rzFsHxhD1qG
pgFdZEk2/c//ZvUNi12vPWipk8TcJwHw9zoZ/ZrVNybpMCC0THsJ/UEVyuyszPtNYeYZAhOJ41va
v1RhZJzYan4a1gU0kKBPQklcpQEhq48woEu15isvwWh9/+5jjh0L+YNaN0I//nHSp6U9COUG9Z0c
vnO8FM6PTqsnSbcc0j+GchwOHRC7aP2t5v2stVx3KbptaYEzi4MQHxm/0+HQpMEVLLUiizJqS4PW
PU6zfQTOMZ9uLQRRci+c5xhtMEBszlQDOvEQcyEG+hc++fH47K+MmZz21bFNfoBxLP6bjR6xtPXt
REF5lLXxp+CJ6KKSblPKeVRg/UtyJHeFKAZXO8Zeco7TZUMVHmK0ZZ1EpnZbnAhKE19Z+FJrQPQr
lR0gO3lBzuyPPArVhvWxjlO7S4DmaEhLzarWi/ze7EGwWSuI2eEa/8zU0INUsGI4ywe7vepQz7Iq
aAovAX0d+f1YjbmCVsAwjhLmveFjNwIDAQABo4IB9zCCAfMwHwYDVR0jBBgwFoAU95uiTtOXxfQ0
D0MOgYXOkZMyr/kwHQYDVR0OBBYEFFxiGptwbOfWOtMk5loHw7uqWUOnMDAGA1UdEQQpMCeBE2R3
bXcyQGluZnJhZGVhZC5vcmeBEGRhdmlkQHdvb2Rob3Uuc2UwFAYDVR0gBA0wCzAJBgdngQwBBQEC
MA4GA1UdDwEB/wQEAwIF4DAdBgNVHSUEFjAUBggrBgEFBQcDAgYIKwYBBQUHAwQwgakGA1UdHwSB
oTCBnjBNoEugSYZHaHR0cDovL2NybDMuZGlnaWNlcnQuY29tL0RpZ2lDZXJ0QXNzdXJlZEcyU01J
TUVSU0E0MDk2U0hBMzg0MjAyNENBMS5jcmwwTaBLoEmGR2h0dHA6Ly9jcmw0LmRpZ2ljZXJ0LmNv
bS9EaWdpQ2VydEFzc3VyZWRHMlNNSU1FUlNBNDA5NlNIQTM4NDIwMjRDQTEuY3JsMIGNBggrBgEF
BQcBAQSBgDB+MCQGCCsGAQUFBzABhhhodHRwOi8vb2NzcC5kaWdpY2VydC5jb20wVgYIKwYBBQUH
MAKGSmh0dHA6Ly9jYWNlcnRzLmRpZ2ljZXJ0LmNvbS9EaWdpQ2VydEFzc3VyZWRHMlNNSU1FUlNB
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
yI0hlaaNiLgkI8rK1W70b/IAAAAAAAA=


--=-ifNNgHR31pmqYObLjYoP--
