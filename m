Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=87.76.132.165
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1792873922;
	b=PlnPs2yBrI+W8tak9h5SP1IKM74wUly7Ev4vzS7a5fnQssQO+WHhPCg2p2TyV4zMvGO7
	 V4IgASYDdtxWKKd19/bW8eRsqxqAkA3DTQUVMfdlcooqLaa+6KhWlWog3Nj64x2tKwnhC
	 diy3cDR+/5AWkvlZCly6746pWe/lQHiasdkmfefandevfpy/WIGSLuX9vYcIWKCNAv0Yj
	 qadk/SvCX41p9TxMx0GHI+wD27yR5ZIoGpE8jQyR5UB9rtoeJuNZDzCAZ+jQckvHgJVN7
	 mAhRXT/+SL5W57lNsAf659U4p9OgmDPqGez142VAU+T0C3RckK5JVtD9pit5n3Z/bbw==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1792873922;
	h=DMARC-Filter:Received:DKIM-Signature:Content-Type:Message-ID:Date:
	 MIME-Version:User-Agent:From:Subject:To:Cc:References:
	 Content-Language:In-Reply-To:X-Last-TLS-Session-Version;
	bh=l5wct3Hd9t4FUGB6vvm9V0pCMWIstiYpUK0gbi+P1wI=;
	b=m1j+VhUR7HImW0u3D/7V6fjDCW0RDZJCxXjHyFmBwUfJjHcCjtMf4LsrHRYI29YZfCmR
	 C0K5L5gbtwIPH84yAxfw2ZOQI11X78O032HI0Y4vSYsxMTbXrCFOUQQ4BytV2x4k1olNL
	 GpU3BvnINWFREvpAOPisWwSvQP/dHnOzErFREDgsU5ceI5OhtUcdaXYyCDw1L5TvUJ0Ln
	 CX+RkmcafKUbFENwWk3jZUe+rL/Ih4PHRpwXNOJ7+ppVyMublERycPZrdZhg8A5puU9l2
	 /wjNPXXzaqum0FkV3RnF4apArJFW9QLxhPyWUlmFscnyH5PA0oE++2ReKlufQt+l00A==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=auth.ink;
	spf=pass smtp.mailfrom=auth.ink;
	dkim=pass header.d=auth.ink header.i=@auth.ink header.a=rsa-sha256 header.s=dkim header.b=BP7KOaVI;
	arc=none smtp.remote-ip=87.76.132.165
Received: from mail.netskyway.net (mail.netskyway.net [87.76.132.165])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0D403606A31A;
	Sat, 24 Oct 2026 20:32:01 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 0D403606A31A
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=auth.ink
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=auth.ink
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=auth.ink header.i=@auth.ink header.a=rsa-sha256 header.s=dkim header.b=BP7KOaVI
Received: from [127.0.0.1] (localhost [127.0.0.1]) by localhost (Mailerdaemon) with ESMTPSA id 82E7D3001AF;
	Sat, 24 Oct 2026 17:31:46 -0300 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=auth.ink; s=dkim;
	t=1792873909; h=from:subject:date:message-id:to:cc:mime-version:content-type:
	 content-language:in-reply-to:references;
	bh=l5wct3Hd9t4FUGB6vvm9V0pCMWIstiYpUK0gbi+P1wI=;
	b=BP7KOaVIGjsPXCPhhE3SUK8qaN6aEGgHuH/eeCjJEouo5Hdw2py1BaNczUIQIFRSGrMoT5
	qEXDj7NsNMBMuUJfjKd7EI9tPef3eh7lg9R4yrlUjPF2SY/P2v/Lf54vm2gjki0d4rVjJ7
	+IsnWjR8vaaBezMzmA2IZgmMYZZKWLak2PsDf4z82lJp3jasi8q9/U9b2h+AM9P0p8BQ67
	m+E2zIal3pA0l0nfQYKTIMrlQNmGj5MDme713gw8z5QcSU5yvRDO8SvG/qlJcuNzucLdrz
	2wUjx89zmy0m2N5kDy0uccUDWR8bYliaiQl2VxzZicRiHldjviNCYEPKI0X+Fg==
Content-Type: multipart/mixed; boundary="------------Z18eoA5frGGVDyYc07TlEKcV"
Message-ID: <1685aeee-c65d-4a8f-9bfe-607e13e114a9@auth.ink>
Date: Sat, 24 Oct 2026 23:31:46 +0300
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
From: Tamir Awad <security@auth.ink>
Subject: Re: [PATCH 5.15.y] af_unix: Clear oob_skb in scan_inflight()
To: Sasha Levin <sashal@kernel.org>, stable@vger.kernel.org
Cc: lee@kernel.org, netdev@vger.kernel.org,
 Rodrigo Zaiden <rodrigo.zaiden@canonical.com>, kuniyu@amazon.com
References: <7fa31470-872a-4fb8-9c8f-51dce38e9190@auth.ink>
 <2026-10-24-1-daily-reply-0002-af-unix-oob-skb-5-15@kernel.org>
Content-Language: en-US
In-Reply-To: <2026-10-24-1-daily-reply-0002-af-unix-oob-skb-5-15@kernel.org>
X-Last-TLS-Session-Version: TLSv1.3

This is a multi-part message in MIME format.
--------------Z18eoA5frGGVDyYc07TlEKcV
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit

i sent the patch as a file, Thanks for letting me know.

On 24/10/2026 23:11, Sasha Levin wrote:
>> This resends Kuniyuki Iwashima's March 2025 fix for the old GC. The
>> code diff is unchanged.
>>
>> @@ -102,13 +102,14 @@ static void scan_inflight(struct sock *x, void
>> (*func)(struct unix_sock *),
> The patch is whitespace-mangled and does not apply: the indentation is
> non-breaking spaces instead of tabs, blank context lines lost their leading
> space, and the @@ line above is hard-wrapped, so git am fails with a corrupt
> patch.
>
--------------Z18eoA5frGGVDyYc07TlEKcV
Content-Type: text/plain; charset=UTF-8; name="af_unix-5.15.y-patch.txt"
Content-Disposition: attachment; filename="af_unix-5.15.y-patch.txt"
Content-Transfer-Encoding: base64

RnJvbSA1OGY3ZjBjZjk0OTVkNGI3NGNmZjgwMTViZDYwOWE3ZTU5NDcxOGM1IE1vbiBTZXAg
MTcgMDA6MDA6MDAgMjAwMQpGcm9tOiBLdW5peXVraSBJd2FzaGltYSA8a3VuaXl1QGFtYXpv
bi5jb20+CkRhdGU6IE1vbiwgMyBNYXIgMjAyNSAxOTowMTo0OSAtMDgwMApTdWJqZWN0OiBb
UEFUQ0ggNS4xNS55XSBhZl91bml4OiBDbGVhciBvb2Jfc2tiIGluIHNjYW5faW5mbGlnaHQo
KQoKdW5peF9nYygpIGFjY2Vzc2VzIG9vYl9za2IgYWZ0ZXIgZHJvcHBpbmcgc2tfcmVjZWl2
ZV9xdWV1ZS5sb2NrLiBUaGlzCmNhbiByYWNlIHdpdGggcXVldWVfb29iKCkuIENsZWFyIG9v
Yl9za2IgaW4gc2Nhbl9pbmZsaWdodCgpIHdoaWxlIHRoZQpsb2NrIGlzIGhlbGQuCgpUaGlz
IHJlc2VuZHMgS3VuaXl1a2kgSXdhc2hpbWEncyBNYXJjaCAyMDI1IGZpeCBmb3IgdGhlIG9s
ZCBHQy4gVGhlCmNvZGUgZGlmZiBpcyB1bmNoYW5nZWQuCgpPbiA1LjE1LjIyMywgdGhlIHJl
cHJvZHVjZXIgcGFuaWNrZWQgdGhyZWUgdW5wYXRjaGVkIFFFTVUgZ3Vlc3RzLiBUaHJlZQpw
YXRjaGVkIGd1ZXN0cyBjb21wbGV0ZWQgOCwwMDAgcm91bmRzIGVhY2ggd2l0aG91dCBhIGtl
cm5lbCB3YXJuaW5nLgpCb3RoIGJ1aWxkcyB1c2VkIHRoZSBzYW1lIGNvbmZpZyBhbmQgZ3Vl
c3QgaW1hZ2UuIEFuIGluc3RydW1lbnRlZCBydW4KdHJhY2VkIHRoZSBoYXJuZXNzJ3MgZmFp
bGVkIHJhY2luZyBzZW5kcyB0byBFUElQRSBhbmQgRUNPTk5SRVNFVCBhbmQKY29uZmlybWVk
IGFsbCA4LDAwMCBpdGVyYXRpb25zIHJlYWNoZWQgdGhlIHJhY2UuCgpGaXhlczogMzE0MDAx
ZjBiZjkyICgiYWZfdW5peDogQWRkIE9PQiBzdXBwb3J0IikKTGluazogaHR0cHM6Ly9sb3Jl
Lmtlcm5lbC5vcmcvYWxsLzIwMjUwMzA0MDMwMTQ5LjgyMjY1LTEta3VuaXl1QGFtYXpvbi5j
b20vClJlcG9ydGVkLWJ5OiBMZWkgTHUgPGxsZmFtc2VjQGdtYWlsLmNvbT4KU2lnbmVkLW9m
Zi1ieTogS3VuaXl1a2kgSXdhc2hpbWEgPGt1bml5dUBhbWF6b24uY29tPgpTaWduZWQtb2Zm
LWJ5OiBUYW1pciBBd2FkIDxzZWN1cml0eUBhdXRoLmluaz4KLS0tCiBuZXQvdW5peC9nYXJi
YWdlLmMgfCAyMCArKysrKysrKysrLS0tLS0tLS0tLQogMSBmaWxlIGNoYW5nZWQsIDEwIGlu
c2VydGlvbnMoKyksIDEwIGRlbGV0aW9ucygtKQoKZGlmZiAtLWdpdCBhL25ldC91bml4L2dh
cmJhZ2UuYyBiL25ldC91bml4L2dhcmJhZ2UuYwppbmRleCBkMmZjNzk1Li5hNzMzZDBkIDEw
MDY0NAotLS0gYS9uZXQvdW5peC9nYXJiYWdlLmMKKysrIGIvbmV0L3VuaXgvZ2FyYmFnZS5j
CkBAIC0xMDIsMTMgKzEwMiwxNCBAQCBzdGF0aWMgdm9pZCBzY2FuX2luZmxpZ2h0KHN0cnVj
dCBzb2NrICp4LCB2b2lkICgqZnVuYykoc3RydWN0IHVuaXhfc29jayAqKSwKIAkJCS8qIFBy
b2Nlc3MgdGhlIGRlc2NyaXB0b3JzIG9mIHRoaXMgc29ja2V0ICovCiAJCQlpbnQgbmZkID0g
VU5JWENCKHNrYikuZnAtPmNvdW50OwogCQkJc3RydWN0IGZpbGUgKipmcCA9IFVOSVhDQihz
a2IpLmZwLT5mcDsKKwkJCXN0cnVjdCB1bml4X3NvY2sgKnU7CiAKIAkJCXdoaWxlIChuZmQt
LSkgewogCQkJCS8qIEdldCB0aGUgc29ja2V0IHRoZSBmZCBtYXRjaGVzIGlmIGl0IGluZGVl
ZCBkb2VzIHNvICovCiAJCQkJc3RydWN0IHNvY2sgKnNrID0gdW5peF9nZXRfc29ja2V0KCpm
cCsrKTsKIAogCQkJCWlmIChzaykgewotCQkJCQlzdHJ1Y3QgdW5peF9zb2NrICp1ID0gdW5p
eF9zayhzayk7CisJCQkJCXUgPSB1bml4X3NrKHNrKTsKIAogCQkJCQkvKiBJZ25vcmUgbm9u
LWNhbmRpZGF0ZXMsIHRoZXkgY291bGQKIAkJCQkJICogaGF2ZSBiZWVuIGFkZGVkIHRvIHRo
ZSBxdWV1ZXMgYWZ0ZXIKQEAgLTEyMiw2ICsxMjMsMTMgQEAgc3RhdGljIHZvaWQgc2Nhbl9p
bmZsaWdodChzdHJ1Y3Qgc29jayAqeCwgdm9pZCAoKmZ1bmMpKHN0cnVjdCB1bml4X3NvY2sg
KiksCiAJCQkJfQogCQkJfQogCQkJaWYgKGhpdCAmJiBoaXRsaXN0ICE9IE5VTEwpIHsKKyNp
ZiBJU19FTkFCTEVEKENPTkZJR19BRl9VTklYX09PQikKKwkJCQl1ID0gdW5peF9zayh4KTsK
KwkJCQlpZiAodS0+b29iX3NrYikgeworCQkJCQlXQVJOX09OX09OQ0Uoc2tiX3VucmVmKHUt
Pm9vYl9za2IpKTsKKwkJCQkJdS0+b29iX3NrYiA9IE5VTEw7CisJCQkJfQorI2VuZGlmCiAJ
CQkJX19za2JfdW5saW5rKHNrYiwgJngtPnNrX3JlY2VpdmVfcXVldWUpOwogCQkJCV9fc2ti
X3F1ZXVlX3RhaWwoaGl0bGlzdCwgc2tiKTsKIAkJCX0KQEAgLTI5OSwxNyArMzA3LDkgQEAg
dm9pZCB1bml4X2djKHZvaWQpCiAJICogd2hpY2ggYXJlIGNyZWF0aW5nIHRoZSBjeWNsZShz
KS4KIAkgKi8KIAlza2JfcXVldWVfaGVhZF9pbml0KCZoaXRsaXN0KTsKLQlsaXN0X2Zvcl9l
YWNoX2VudHJ5KHUsICZnY19jYW5kaWRhdGVzLCBsaW5rKSB7CisJbGlzdF9mb3JfZWFjaF9l
bnRyeSh1LCAmZ2NfY2FuZGlkYXRlcywgbGluaykKIAkJc2Nhbl9jaGlsZHJlbigmdS0+c2ss
IGluY19pbmZsaWdodCwgJmhpdGxpc3QpOwogCi0jaWYgSVNfRU5BQkxFRChDT05GSUdfQUZf
VU5JWF9PT0IpCi0JCWlmICh1LT5vb2Jfc2tiKSB7Ci0JCQlrZnJlZV9za2IodS0+b29iX3Nr
Yik7Ci0JCQl1LT5vb2Jfc2tiID0gTlVMTDsKLQkJfQotI2VuZGlmCi0JfQotCiAJLyogbm90
X2N5Y2xlX2xpc3QgY29udGFpbnMgdGhvc2Ugc29ja2V0cyB3aGljaCBkbyBub3QgbWFrZSB1
cCBhCiAJICogY3ljbGUuICBSZXN0b3JlIHRoZXNlIHRvIHRoZSBpbmZsaWdodCBsaXN0Lgog
CSAqLwotLSAKMi41Ni4wLndpbmRvd3MuMgoK

--------------Z18eoA5frGGVDyYc07TlEKcV--
