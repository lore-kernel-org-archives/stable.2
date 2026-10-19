Received: from mail-wm1-f47.google.com (mail-wm1-f47.google.com [209.85.128.47])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 016014570EC
	for <stable@vger.kernel.org>; Mon, 19 Oct 2026 06:08:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.47
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1792390129; cv=none; b=DxTkb7HV+kofKBJw+cmN2GYUbvLZbkrf6jxlL/Yte2UZBy85op7sLeMN7naHlYeHfB+q+W1a00dZTZ9JwpAzMtv8K/NWHgfWIre5z/IbTOD1LnosApsAcsP8X1yrOernwq38WVYS7SF8hAh7hxodMVJ48OVeIVQQDKjUJF803jA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1792390129; c=relaxed/simple;
	bh=UjCUnwx/FguYqLfcuFZ1cuAazQ4BUij5ZJQ76FsVhfU=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=dnt5uZ30tQcuqgetcnNJV+FAI2F1bJxhP4ppRhG7crBcflkvH0Di34fC/7asJwuJMapZDz8lLoDYGbQEXzwDmAriZurY6apnaQAaQC/FgFJYa27C7ePOrIIKKDk7U6rHyHampmpiZ9VtxEPbiF0x1eYk2MRQbQ7vnGFYnaDLvt8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=BYS3VCru; arc=none smtp.client-ip=209.85.128.47
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="BYS3VCru"
Received: by mail-wm1-f47.google.com with SMTP id 5b1f17b1804b1-4a16af2a232so12411735e9.1
        for <stable@vger.kernel.org>; Sun, 18 Oct 2026 23:08:47 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1792390126; x=1792994926; darn=vger.kernel.org;
        h=content-type:mime-version:references:in-reply-to:message-id:date
         :subject:cc:to:from:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=WC+8JtpjrX55EcWyWHxMmBFBWDgtGsM7hQLNF5GQHnw=;
        b=BYS3VCru1Q1sdAC0d4r3WwCUKckhl8b/+uYImNYFiQ/LsAWjR+PhrNmPNZi3OZ6ACe
         SerIFk1OpX7RP2HlU9g6wEpBB4XZexJQ8u6DEkwVPSsQ5VJ1k53pPtBdJ5c6Z3SiUOBp
         hcQtwcrRqLj4U4/M8hye+oFTw/6BPSO5jxGyCQIjcNsQRe218g9BJsPWTtL+3IlcOtio
         EzOS8kiW33gtYDAdairRi85vxKZ/MYxi3RbRtr1GoiVH0RLb4OuA+FvdV6fh/sajHnx1
         +0RqMr5ASdlqpBLqsEz3JivGmZ8GXyZLb/rnBlUXsGf95GL3CSIyi+qJ94pKp0SPo+2O
         PY4w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1792390126; x=1792994926;
        h=content-type:mime-version:references:in-reply-to:message-id:date
         :subject:cc:to:from:x-gm-gg:x-gm-message-state:from:to:cc:subject
         :date:message-id:reply-to:content-type;
        bh=WC+8JtpjrX55EcWyWHxMmBFBWDgtGsM7hQLNF5GQHnw=;
        b=iI0veF1Q7LOY0BpAj4Lgnk1RCLTWlk3vAI1FUs5RGtPvc2+UJyYXys4Fvhx+aezW3K
         FDbjF4lQ15atGMCkGOq0bSrAClJ8FETPn84j5Eyj3DwvKU7oQPEmOmLvHUYUmcRj3py1
         eB1BuSfLQ0rgZjVR5LhPCuAPFpOlmkWLUqDKZBsRUGkX8CTJ0dZiCncxnkYEvxVirppt
         O5KdUC+QTugDlm8yl1wC0PKdlHDs0tBDr5rnoz3eZOjxtrTrRIiz/EbDqj2GB1rNGJNk
         85ruulIYkrDXX/mKMQ64rbPHYoRIU1A1P6g2Q9Xvdl3+dXo6tgD8ma+vuNuPUtDPe/b2
         2U2g==
X-Gm-Message-State: AFq9FYKEJ1wnogVeTY8PqR94SzrySbMpwh1RFQ6QkfdvuxaHGHlBe3bh
	SPe1NFXRDhmFHHUmhk56gHyK9aEH5RrnTNCr9xmO0YbfFsMf2Riz9xpISWfmwzkz
X-Gm-Gg: AYBFou1UHtnc7EKbtvN9FgXeKFOF02GMXqZSwG3+qj2vuNq76KeSjDVIRfTJu7fAtAJ
	rmbyvo8n4dzPFrIVHs50/gn/PiyhQUfhhcI80zAXROZ02yg7KOa5n8mnsCifhCnrUiqKnHHA2mE
	JVpiOhE+uFvvGnZR+20BbZXQn2XxXZSGR3jAzxyC44Wryb2v5Q+eTf/FirFAqT9CAPC6vMJiJnC
	eToUWcOQfnLIniemwcDTCLtCAveQ4Aw7FtvxnWW4zN98qwcnT6F7QK1khSZ+kR/vsOYNO/Dtdok
	NR17WFzT46VNShOajYKFYZ2BavxrGBOtNQiFU3Z34Npa2y9c7z5zrCVmv8+nWfVzQA0v/6GsILN
	MXi0Ozezhr7DgGWVzocNaATuaEbTjasqdT/c+dcgg0ePdJ/fqqoAEM0B3nu6mhS1E/0H+ZKe8iz
	1pshCZEfRmiHnXPUUp+xlt6Bq4b3404CLDzofrRYw1Oq3hXbVdK8apaWoiGxiHBP9oG4SD3vihf
	Hp+DCQlwBHCxbjWZseW7hBUCGHKrT0zqYJKhTOs2V3wOi0veA==
X-Received: by 2002:a05:600c:1da1:b0:49f:ce78:3562 with SMTP id 5b1f17b1804b1-4a1d76011ffmr142908495e9.19.1792390125878;
        Sun, 18 Oct 2026 23:08:45 -0700 (PDT)
Received: from SurHub.localdomain ([102.213.69.15])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-4a1ebeccda5sm19940905e9.3.2026.10.18.23.08.43
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 18 Oct 2026 23:08:45 -0700 (PDT)
From: Abdifatah Suruur <suruurism@gmail.com>
To: stable@vger.kernel.org
Cc: Florian Westphal <fw@strlen.de>, Pablo Neira Ayuso <pablo@netfilter.org>,
 security@kernel.org, Willy Tarreau <w@1wt.eu>
Subject: Re: [SECURITY] netfilter: nft_byteorder leaks uninitialised kernel
 stack on 6.12.y with CONFIG_INIT_STACK_NONE (CWE-457)
Date: Mon, 19 Oct 2026 09:08:41 +0300
Message-ID: <179239012164.14465.16534329674629579851@gmail.com>
In-Reply-To: <atWvQFXJzJ434qGd@strlen.de>
References: <179235055956.10524.6485282696272965887@gmail.com>
 <atU2brRgmeb6ght2@1wt.eu> <179236182769.4914.3317139682579833845@gmail.com>
 <atWvQFXJzJ434qGd@strlen.de>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: multipart/mixed; boundary="===============6291285800075240126=="

--===============6291285800075240126==
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit

Hi Florian, stable,

Thanks for the explanation and the Ack.  The explicit memset patch is
attached with your Acked-by; it applies cleanly to 6.12.113.

Stable maintainers: would you prefer this minimal init patch or a backport
of bb061d3de4170741?  Either works from my side.  The memset preserves the
existing multi-register ABI and is the smaller change; Florian is fine with
either.

I will request a CVE via cve@kernel.org once this is queued, per the
documented process.

Thanks,
Abdifatah Suruur
suruurism@gmail.com

--===============6291285800075240126==
Content-Type: text/x-patch
Content-Transfer-Encoding: base64
Content-Disposition: attachment;
 filename*0*=us-ascii''0001-netfilter-nft_byteorder-initialise-marked-destina;
 filename*1*=tion-span.patch
MIME-Version: 1.0

RnJvbSA4MzY4M2JlYWRkMTBjYTZhODFiOWY3OGMwZGQ3OWM0ODljODY4ZWQ4IE1vbiBTZXAgMTcg
MDA6MDA6MDAgMjAwMQpGcm9tOiBBYmRpZmF0YWggU3VydXVyIDxzdXJ1dXJpc21AZ21haWwuY29t
PgpEYXRlOiBNb24sIDE5IE9jdCAyMDI2IDAxOjE1OjI3ICswMzAwClN1YmplY3Q6IFtQQVRDSF0g
bmV0ZmlsdGVyOiBuZnRfYnl0ZW9yZGVyOiBpbml0aWFsaXNlIHRoZSBtYXJrZWQgZGVzdGluYXRp
b24KIHNwYW4KCm5mdF9ieXRlb3JkZXJfZXZhbCgpIHdyaXRlcyBvbmx5IHByaXYtPmxlbiAvIHBy
aXYtPnNpemUgd2hvbGUgZWxlbWVudHMsCndoaWxlIG5mdF9wYXJzZV9yZWdpc3Rlcl9zdG9yZSgp
IG1hcmtzIERJVl9ST1VORF9VUChwcml2LT5sZW4sIDQpIGZ1bGwKMzItYml0IHdvcmRzIGFzIGlu
aXRpYWxpc2VkLiAgRm9yIGxlbi9zaXplIGNvbWJpbmF0aW9ucyB0aGF0IGRvIG5vdCBmaWxsCnRo
ZSBsYXN0IG1hcmtlZCB3b3JkIC0tIGZvciBleGFtcGxlIHNpemUgMiB3aXRoIGxlbiAxLCB3aGlj
aCB3cml0ZXMgbm8KZWxlbWVudCBhdCBhbGwgLS0gdGhlIGNvbnRyb2wgcGxhbmUgc3RpbGwgYWNj
ZXB0cyBhIGxhdGVyIGxvYWQgb2YgdGhlCndob2xlIHdvcmQgZnJvbSBhbm90aGVyIGV4cHJlc3Np
b24uICBUaGF0IGxvYWQgcmVhZHMgc3RhbGUgYnl0ZXMgZnJvbQp0aGUgc3RydWN0IG5mdF9yZWdz
IHN0YWNrIHNsb3QgaW4gbmZ0X2RvX2NoYWluKCksIHdoaWNoIGlzIG5vdAp6ZXJvLWluaXRpYWxp
c2VkLgoKTWFpbmxpbmUgY2xvc2VkIHRoaXMgaW5jaWRlbnRhbGx5IGluIGJiMDYxZDNkZTQxNzA3
NDEgKCJuZXRmaWx0ZXI6Cm5mdF9ieXRlb3JkZXI6IHJlbW92ZSBtdWx0aS1yZWdpc3RlciBzdXBw
b3J0IikgYnkgcmVtb3ZpbmcgdGhlIGZlYXR1cmUKdGhhdCBhbGxvd2VkIHBhcnRpYWwgbXVsdGkt
cmVnaXN0ZXIgc3RvcmVzLiAgVGhhdCBpcyBhIGZ1bmN0aW9uYWwgY2hhbmdlCmFuZCB3YXMgbWFy
a2VkIG5vYXV0b3NlbCwgc28gc3RhYmxlIDYuMTIueSBzdGlsbCBhY2NlcHRzIHRoZSBzYW1lCmxl
bi9zaXplIGNvbWJpbmF0aW9ucyBhbmQgc3RpbGwgbWFya3MgdGhlIHVud3JpdHRlbiBzcGFuLgoK
WmVybyB0aGUgc3BhbiB0aGF0IHRoZSBjb250cm9sIHBsYW5lIG1hcmtzIGFzIGluaXRpYWxpc2Vk
IGJlZm9yZSBkb2luZwp0aGUgY29udmVyc2lvbi4gIFRoaXMgZG9lcyBub3QgY2hhbmdlIHRoZSBy
ZXN1bHQgb2YgYW55IGV4aXN0aW5nIHJ1bGU7Cml0IG9ubHkgcmVtb3ZlcyB0aGUgZGVwZW5kZW5j
eSBvbiBzb21lIG90aGVyIGluaXRpYWxpc2F0aW9uIG9mIHRoZQpyZWdpc3RlciBmaWxlLiAgVGhl
IGxlYWsgaXMgbWFza2VkIHdoZW4gQ09ORklHX0lOSVRfU1RBQ0tfQUxMX1pFUk8KemVyb2VzIG5m
dF9kb19jaGFpbigpJ3MgcmVncywgYnV0IG5mdF9ieXRlb3JkZXIgbXVzdCBub3QgcmVseSBvbiB0
aGF0OgpidWlsZHMgdXNpbmcgQ09ORklHX0lOSVRfU1RBQ0tfTk9ORSBleHBvc2UgdGhlIHN0YWxl
IGJ5dGVzLgoKU2luY2UgbWFpbmxpbmUgbm8gbG9uZ2VyIGhhcyB0aGUgbXVsdGktcmVnaXN0ZXIg
cGF0aCBhZnRlciBiYjA2MWQzLAp0aGlzIGluaXQgZml4IGlzIHByb3Bvc2VkIGZvciA2LjEyLnkg
b25seS4KCkZpeGVzOiAxNGZiMDcxMzBjN2QgKCJuZXRmaWx0ZXI6IG5mX3RhYmxlczogYWxsb3cg
bG9hZHMgb25seSB3aGVuIHJlZ2lzdGVyIGlzIGluaXRpYWxpemVkIikKQ2M6IHN0YWJsZUB2Z2Vy
Lmtlcm5lbC5vcmcKU2lnbmVkLW9mZi1ieTogQWJkaWZhdGFoIFN1cnV1ciA8c3VydXVyaXNtQGdt
YWlsLmNvbT4KQWNrZWQtYnk6IEZsb3JpYW4gV2VzdHBoYWwgPGZ3QHN0cmxlbi5kZT4KLS0tCiBu
ZXQvbmV0ZmlsdGVyL25mdF9ieXRlb3JkZXIuYyB8IDIgKysKIDEgZmlsZSBjaGFuZ2VkLCAyIGlu
c2VydGlvbnMoKykKCmRpZmYgLS1naXQgYS9uZXQvbmV0ZmlsdGVyL25mdF9ieXRlb3JkZXIuYyBi
L25ldC9uZXRmaWx0ZXIvbmZ0X2J5dGVvcmRlci5jCmluZGV4IDc0NDg3ODcuLjYzOGY4M2EgMTAw
NjQ0Ci0tLSBhL25ldC9uZXRmaWx0ZXIvbmZ0X2J5dGVvcmRlci5jCisrKyBiL25ldC9uZXRmaWx0
ZXIvbmZ0X2J5dGVvcmRlci5jCkBAIC0zMyw2ICszMyw4IEBAIHZvaWQgbmZ0X2J5dGVvcmRlcl9l
dmFsKGNvbnN0IHN0cnVjdCBuZnRfZXhwciAqZXhwciwKIAl1MTYgKnMxNiwgKmQxNjsKIAl1bnNp
Z25lZCBpbnQgaTsKIAorCW1lbXNldChkc3QsIDAsIERJVl9ST1VORF9VUChwcml2LT5sZW4sIDQp
ICogc2l6ZW9mKHUzMikpOworCiAJczE2ID0gKHZvaWQgKilzcmM7CiAJZDE2ID0gKHZvaWQgKilk
c3Q7CiAKLS0gCjIuNTMuMAoK

--===============6291285800075240126==--
