Received: from mail-wr1-f46.google.com (mail-wr1-f46.google.com [209.85.221.46])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9C4194DDB58
	for <stable@vger.kernel.org>; Sun, 18 Oct 2026 22:17:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.221.46
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1792361835; cv=none; b=pif3rellRZiKmBEVYTbrHMkl63el33gbZdENUu9vwtmB8aUicZJWpAKk1fDVbKJJDHj91KAyLCPdRr/mpNu4Squ1pe0DUUDpCnCH46ka0W8s1a3rjJSej7V8MnENaS3c5nw8I+G+aJcdVf+3ZK2KwUHW2UKHXhJvlUNdE5GZ884=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1792361835; c=relaxed/simple;
	bh=VKNbwgcEhxTZb7+Gkey0ITWYcvK/kIrzZaY1olhv+WU=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=ofdWiIb8irm0WsBLEEY3KN8SrnwhIQvFrSOQj8+fEt49RX18zupfV5cUfh+k7cxXxkFUpzmek01kMC3z1til+NvFop3MhIH7MFQXZ1MUouWBHYvHNlNfG8O5a8F3dwaFBVFG6VnPFMuGqt3IRD3YMIoP+Y6dVmtah2mrqNzzGlU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=Y/jTXRn9; arc=none smtp.client-ip=209.85.221.46
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="Y/jTXRn9"
Received: by mail-wr1-f46.google.com with SMTP id ffacd0b85a97d-48dee593f18so1021460f8f.3
        for <stable@vger.kernel.org>; Sun, 18 Oct 2026 15:17:13 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1792361832; x=1792966632; darn=vger.kernel.org;
        h=content-type:mime-version:references:in-reply-to:message-id:date
         :subject:cc:to:from:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=exx9vnO6Bda4i2g0FCDaNxaa3NTc6XzPUEQjxDZ7cFo=;
        b=Y/jTXRn905UVrDawiNBxJEkCvxkDyItlnpLBiNs9DnrLN/Q0QZw2Lddg79DJH7leDl
         NP/Q6AwULkCXWVcf8yma97rm2PZp+qPCIKez+CmjN9qSkxMPv4F4k7PaWhNqZNvarw0H
         45F5j9/pOdnQQl9mll3BdA46wmsr/Z4t1Lo6Zz0O5BIuc8p85pYm3pOwgSJugpo6W0+u
         XbL48Opdvm7GjLUzK9/3vy5O7AKUl0HrDEJ5OhO1rN4fH0pJ/+ZK3TgDA5yhWgyEuy9Q
         tosyj4dgCs7IKh0odaCdp1TjQisscCDaCdgkktq3jd4LmRumkBRFQ4/RFqNDMzsqim5q
         PbAg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1792361832; x=1792966632;
        h=content-type:mime-version:references:in-reply-to:message-id:date
         :subject:cc:to:from:x-gm-gg:x-gm-message-state:from:to:cc:subject
         :date:message-id:reply-to:content-type;
        bh=exx9vnO6Bda4i2g0FCDaNxaa3NTc6XzPUEQjxDZ7cFo=;
        b=xsHGfVV8APqs9wjMnAzBH3/UhTxC2wtYhxlzDqlO2HfWvz7wgs9D6+H+7TJO1suu4m
         CmKvLRYKE8cPEJz7u3f2M9/NJDC83kOTlB34rmYyn/29gAtW5BkeYe3jZymKnpvG7Yq9
         ZnGQuw+8ReSIxj0+gkf3kO6+BTCFTKdKjdbh7fkHifm6NyHRpZkpDAnU7Q9BXpqkpwyd
         J/tWTzKWiPl3ZgTRod5omqT2zBbkdVQgK8JDhPp1yG7FpAPPKR6TDL80+WFY5q85wlV7
         mPYvdpsfuM3kSOY26b82u91R0eDLLrO50hb2CJD8e7EUntPeWML4ARS/GbT5LHkap5I7
         Znug==
X-Forwarded-Encrypted: i=1; AKwUvBwRCiJLQqXaSgdZIzg77tPm2Bhk74ee9TscLXT3z7a4xm6sL+iqbmpLxRf23eqEK4yUf/dUMoI=@vger.kernel.org
X-Gm-Message-State: AFq9FYLwbd5ERBy/Bx5A/BFor0dJiSlrfr6aJ8ospK+2FjXYZ/Gw4De3
	OS7QMKNKHCGoJ6kyjSTSYHSZZBImYw4crAVA/5TrUvgUseLOd3Ihhvbj4W5QACtDRZM=
X-Gm-Gg: AYBFou0awK3Aojc/kkS/pSv/LwoHuoGgr4YqWL1dzQXV+Eja7/w+CD22k7y29AQwLqc
	/EFUodvb5FpwJsdYVnntRPL61z0LJbSk1BggIRUmewdwfjWKcBEzgOTUNRLaoTfHShi7PIYUZYP
	B2pUCv+05xzWBIldmZ88kkWH81/t21hjb8Iw8zAQOKuLsn4Y/8W22e/+x+5Qdq+G609W0rhp8zq
	w2dp315zoyB9fg6DlFdiCrJPMBSybEhbRynJv1gcfak6X+ADs5SgVXRr04LcE8dlLZ1HgJbMorv
	HOXGhnoZHOrbdFsTmQz4DpV3RyHouz0fwsOTWbjUXA1hT9UK2AV0p7nHANEZcFYxVzDsbxEzH7/
	1Tnjs2uacAWdtf/l7InutdAiWu7gL2yop0eox4qRA/J6UG4KQ1eXyIASQYCqsgpOSWOeqYHA8QZ
	vkQ1enZoUAdGsU/kRM71O1McrXaJQ31pBoIbd4b9kFKBfIN8iHMNGknIMa3D/GMilvsRbaAx+Jk
	U/8OP/2vjsX53JB4kkS8DDnpg25c/2CmXNXvygBVIGFXSOc1u4=
X-Received: by 2002:a05:6000:4021:b0:48e:cd3:b3ec with SMTP id ffacd0b85a97d-48e0cd3b575mr9163350f8f.28.1792361831605;
        Sun, 18 Oct 2026 15:17:11 -0700 (PDT)
Received: from SurHub.localdomain ([102.218.50.130])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-48dfd4edea3sm19938569f8f.28.2026.10.18.15.17.09
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 18 Oct 2026 15:17:11 -0700 (PDT)
From: Abdifatah Suruur <suruurism@gmail.com>
To: Florian Westphal <fw@strlen.de>, Pablo Neira Ayuso <pablo@netfilter.org>
Cc: security@kernel.org, Willy Tarreau <w@1wt.eu>, stable@vger.kernel.org
Subject: Re: [SECURITY] netfilter: nft_byteorder leaks uninitialised kernel
 stack on 6.12.y with CONFIG_INIT_STACK_NONE (CWE-457)
Date: Mon, 19 Oct 2026 01:17:07 +0300
Message-ID: <179236182769.4914.3317139682579833845@gmail.com>
In-Reply-To: <atU2brRgmeb6ght2@1wt.eu>
References:
 <179235055956.10524.6485282696272965887@gmail.com> <atU2brRgmeb6ght2@1wt.eu>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: multipart/mixed; boundary="===============5449592912516909087=="

--===============5449592912516909087==
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit

Willy, thanks for the guidance. I have Cc'd Florian (author of bb061d3) and
Pablo as you suggested.

Florian, Pablo,

Mainline closed this only as a side effect of bb061d3de4170741 ("netfilter:
nft_byteorder: remove multi-register support", 2026-05-12), which is marked
Cc: stable+noautosel and is not in 6.12.y.  Was it left out of stable because
it is not backportable, or because it was judged not worth backporting?

I verified the gap on 6.12.113: nft_byteorder_eval() writes len / size whole
elements, while nft_parse_register_store() marks DIV_ROUND_UP(len, 4) full
32-bit words as initialised.  With size 2 and len 1 the control plane marks
one word and eval writes none of it; a later load from another expression is
accepted and reads the uninitialised struct nft_regs slot in nft_do_chain().

To be precise about scope, since Willy rightly noted that distro kernels are
not the point: the official 6.12.y source itself has the unvalidated store.
With the default CONFIG_INIT_STACK_ALL_ZERO the register file is zeroed at
nft_do_chain() entry and the stale bytes are masked; with
CONFIG_INIT_STACK_NONE they are exposed.  nft_byteorder should not depend on
the stack-init configuration either way.  My SUSE run was only where I could
observe it.

Attached is a minimal format-patch against 6.12.113 that zeroes the
destination span the control plane marks as written.  It is semantically
neutral for existing rules and preserves multi-register support, unlike
backporting bb061d3's removal.  I have verified that it applies cleanly to
6.12.113; I can build and boot-test the patched kernel and provide the logs
if that helps.

If you agree, would you ack it for 6.12.y?  If you prefer the full bb061d3
removal or a different fix, I will follow your preference.  security@ is kept
in Cc for the stable-integration discussion, as Willy suggested.  I have read
Documentation/process/cve.rst and will use the documented CVE process; no
public disclosure has been made, and I ask that the thread stay private until
a fix is agreed.

Thanks,
Abdifatah Suruur
suruurism@gmail.com

--===============5449592912516909087==
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
YWlsLmNvbT4KLS0tCiBuZXQvbmV0ZmlsdGVyL25mdF9ieXRlb3JkZXIuYyB8IDIgKysKIDEgZmls
ZSBjaGFuZ2VkLCAyIGluc2VydGlvbnMoKykKCmRpZmYgLS1naXQgYS9uZXQvbmV0ZmlsdGVyL25m
dF9ieXRlb3JkZXIuYyBiL25ldC9uZXRmaWx0ZXIvbmZ0X2J5dGVvcmRlci5jCmluZGV4IDc0NDg3
ODcuLjYzOGY4M2EgMTAwNjQ0Ci0tLSBhL25ldC9uZXRmaWx0ZXIvbmZ0X2J5dGVvcmRlci5jCisr
KyBiL25ldC9uZXRmaWx0ZXIvbmZ0X2J5dGVvcmRlci5jCkBAIC0zMyw2ICszMyw4IEBAIHZvaWQg
bmZ0X2J5dGVvcmRlcl9ldmFsKGNvbnN0IHN0cnVjdCBuZnRfZXhwciAqZXhwciwKIAl1MTYgKnMx
NiwgKmQxNjsKIAl1bnNpZ25lZCBpbnQgaTsKIAorCW1lbXNldChkc3QsIDAsIERJVl9ST1VORF9V
UChwcml2LT5sZW4sIDQpICogc2l6ZW9mKHUzMikpOworCiAJczE2ID0gKHZvaWQgKilzcmM7CiAJ
ZDE2ID0gKHZvaWQgKilkc3Q7CiAKLS0gCjIuNTMuMAoK

--===============5449592912516909087==--
