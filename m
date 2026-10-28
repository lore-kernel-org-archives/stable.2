Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=209.85.210.200
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1793210515;
	b=3MVdKygbyCz+AvYQT/FUUCErjM1OaO9biZbMFBT/0zDeqN7zwrn43NJn5OW84kvGH+FI
	 LnQGIPVcwjpPB+gBVZR4NhuDra1FJPwUqD3ivWTp2PIlxnoCE9rWew7zgiF4oVQQPmhGH
	 VPl0AjfsGq164EkTHUrAlgng7cBajDKLWc7A0yKHESYlvb6mTKWF2Lln+5dM9bebI7LcC
	 VOdIOuyzrN7N2T1c3cm4Gf6dPwWePa6/VSeS9ztP2LsExHT7pfTKkgaHGOq2ys/CA4qfw
	 Va8Ov5oA2IOvtayTvLsSkO/exlNr101CJjrzDoeOgGtJv9jNYeXqMUF5kkFy3N5JZrA==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1793210515;
	h=DMARC-Filter:Received:DKIM-Signature:X-Google-DKIM-Signature:
	 X-Forwarded-Encrypted:X-Gm-Message-State:X-Received:Date:In-Reply-To:
	 Mime-Version:References:Message-ID:Subject:From:To:Cc:Content-Type:
	 Content-Transfer-Encoding;
	bh=IFh8UvNS1giZHEP2EPha+DPG33RQP8My3fS1LV0elXo=;
	b=iB1ufki3rreiuG+wWWKIk6hUIJ9hDL3iZKmgsdyM/MzMRq+eA+YxTGP6gP3Z36XyTteG
	 9YXHi5cBLdVVALXNsEGnWEYd7/s85/pDPxDztm6yX4jzevA3H+/fyMbMANfllMIBqUs8C
	 SvhkOvnYTz57pxpirQAWa5rcyRk8YuVDfEuOZQDqYugJuPlveopH5hHvO3eXjy9CuVLnQ
	 kz0hj/6npK2+FyOm6ClWpaK0rCNMDEjW9JNusQhyX7mJnfX3GYuiQ7KiuBWTIiLjM2VKb
	 d5hEJMwzm3rzAMdm+DulqFP8Pas/XvIds+99bt9xLcCsXCt9BIh9NUBuXVIoJoxIjhQ==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=google.com;
	spf=pass smtp.mailfrom=flex--seanjc.bounces.google.com;
	dkim=pass header.d=google.com header.i=@google.com header.a=rsa-sha256 header.s=20260707 header.b="CLu/Ci5K";
	arc=none smtp.remote-ip=209.85.210.200
Received: from mail-pf1-f200.google.com (mail-pf1-f200.google.com [209.85.210.200])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 70903606A323
	for <stable@vger.kernel.org>; Wed, 28 Oct 2026 18:01:55 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 70903606A323
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=flex--seanjc.bounces.google.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=google.com header.i=@google.com header.a=rsa-sha256 header.s=20260707 header.b=CLu/Ci5K
Received: by mail-pf1-f200.google.com with SMTP id d2e1a72fcca58-89fb6a45c48so1656560b3a.1
        for <stable@vger.kernel.org>; Wed, 28 Oct 2026 11:01:55 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20260707; t=1793210515; x=1793815315; darn=vger.kernel.org;
        h=content-transfer-encoding:content-type:cc:to:from:subject
         :message-id:references:mime-version:in-reply-to:date:from:to:cc
         :subject:date:message-id:reply-to:content-type;
        bh=IFh8UvNS1giZHEP2EPha+DPG33RQP8My3fS1LV0elXo=;
        b=CLu/Ci5KG1AFekKdu3rDgXoDWhM0y76czwwVT6oQO1nEd87AcvM/FgztRHEkZvFmEk
         HdbQrb5rRu4JuBMuBt3qNPvD75HnvfEX5dx9gQS1p4Zpl5ObmVX8rRpEjIjAZQUnuXNr
         RiQsWY7XmGwx0eQ9VLAqho10NXytMEGxWV6rxJHMinGMd7kN/581NX5T3alcYnennFZk
         C2AqC2eaHHE78DEu+QBBe3xILGE4Ui4+l7tdpnbIy+4ZADJCHzYpmh+61td1Gu7sR8R1
         e2T7FIDeZlbpp1+DkIGwNH+M/VdSpWcRhd3Xkt992fCmlRWUX0ee1YOkzGOa6gEH86I+
         r0wA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1793210515; x=1793815315;
        h=content-transfer-encoding:content-type:cc:to:from:subject
         :message-id:references:mime-version:in-reply-to:date
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=IFh8UvNS1giZHEP2EPha+DPG33RQP8My3fS1LV0elXo=;
        b=25JMQ4KyJWVRa5GQgoNX0L9tmu6ziJIWGqMti5nBw6sEHXtIIHUWZy07EBnj2qTyR3
         ak3mH4G/gfn/BitXpYNppRK4C51+edLsiF1OFhqVGUVR0+7URwvEqlTLqT8R7NWWdrQ9
         QBa2pcY/nJv++lbn7YsIfmHigCI8DqV6QOO1ZFkbnawtQ9XlCzj4R6CVVxDsqeh6YdtR
         /GU0uGPNuUChF9vku8L3l4RDd4n8sYBQlZNkjCnNLkDrJ4qGps6ZoVbR45CZlGs6VuvB
         zOUj1wJldH0FWlhqxS+ZW+n67CEUpg0SlELrvQAyixrsqA33eAt+5QewUWTlfgXEL1Mu
         7OyA==
X-Forwarded-Encrypted: i=1; AKwUvByJr/ILqlQGrGjn29msGry4Dlhyi7SBSpfzPSAJRtYehTR5BMpaOIVkGq1l1cBt9z6F3xn0iVE=@vger.kernel.org
X-Gm-Message-State: AFq9FYI7+hEo46unMqejvt+65WW94/Eq5rWXpaOt6qIdPYNktoCzZSej
	KP1icag3qi72RHnVtJ8n1HJqSC+nwdjfrSChiKrRPYXmL/bArZFtJl6zhHb9ledCPenTgm6pfYq
	K2vt1Xw==
X-Received: from pfog22.prod.google.com ([2002:aa7:8756:0:b0:8a0:7e84:9992])
 (user=seanjc job=prod-delivery.src-stubby-dispatcher) by 2002:a05:6a00:288d:b0:89a:5:92a0
 with SMTP id d2e1a72fcca58-8a6e83aa848mr2462444b3a.46.1793210514345; Wed, 28
 Oct 2026 11:01:54 -0700 (PDT)
Date: Wed, 28 Oct 2026 11:01:53 -0700
In-Reply-To: <69437bf0-45fc-4701-9144-a208c12423e6@redhat.com>
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Post: <mailto:stable@vger.kernel.org>
List-Help: <mailto:stable+help@vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
List-Owner: <mailto:stable+owner@vger.kernel.org>
Precedence: list
Mime-Version: 1.0
References: <2026102314-CVE-2026-99082-e5b1@gregkh> <20261027124140.upuow4a3kv6kssvn@m.mifar.in>
 <auIy4UZMGxLhBCAn@google.com> <d4214249-5ec0-4600-91be-13632b180425@redhat.com>
 <69437bf0-45fc-4701-9144-a208c12423e6@redhat.com>
Message-ID: <auI4kViOXpqxT3wA@google.com>
Subject: Re: [REGRESSION] KVM: x86: OVMF boot hang with SMM enabled after
 commit b3e6212dea2e ("KVM: x86: Use active memslots for the per-vCPU MMIO cache")
From: Sean Christopherson <seanjc@google.com>
To: Paolo Bonzini <pbonzini@redhat.com>
Cc: Sami Farin <lkml20261027@mifar.in>, linux-kernel@vger.kernel.org, 
	Greg Kroah-Hartman <gregkh@kernel.org>, kvm@vger.kernel.org, kimjw04271234@gmail.com, 
	stable@vger.kernel.org
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: base64

T24gV2VkLCBPY3QgMjgsIDIwMjYsIFBhb2xvIEJvbnppbmkgd3JvdGU6Cj4gT24gMTAvMjgvMjYg
MTg6NDgsIFBhb2xvIEJvbnppbmkgd3JvdGU6Cj4gPiBPbiAxMC8yOC8yNiAxODozNywgU2VhbiBD
aHJpc3RvcGhlcnNvbiB3cm90ZToKPiA+ID4gPiBIb3dldmVyLCBhZGRyZXNzIHNwYWNlIDAgYW5k
IGFkZHJlc3Mgc3BhY2UgMSBtYWludGFpbiBzZXBhcmF0ZQo+ID4gZ2VuZXJhdGlvbiBjb3VudGVy
cwo+ID4gPiA+IHN0YXJ0aW5nIGZyb20gMC4KPiA+IAo+ID4gVGhpcyBpcyBhbHNvIGluY29ycmVj
dDoKPiA+IAo+ID4gIMKgwqDCoMKgwqDCoMKgIGZvciAoaSA9IDA7IGkgPCBrdm1fYXJjaF9ucl9t
ZW1zbG90X2FzX2lkcyhrdm0pOyBpKyspIHsKPiA+ICDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDC
oMKgwqAgZm9yIChqID0gMDsgaiA8IDI7IGorKykgewo+ID4gIMKgwqDCoMKgwqDCoMKgwqDCoMKg
wqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqAgc2xvdHMgPSAma3ZtLT5fX21lbXNsb3RzW2ldW2pd
Owo+ID4gCj4gPiAgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDC
oCBhdG9taWNfbG9uZ19zZXQoJnNsb3RzLT5sYXN0X3VzZWRfc2xvdCwKPiA+ICh1bnNpZ25lZCBs
b25nKU5VTEwpOwo+ID4gIMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDC
oMKgwqAgc2xvdHMtPmh2YV90cmVlID0gUkJfUk9PVF9DQUNIRUQ7Cj4gPiAgwqDCoMKgwqDCoMKg
wqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoCBzbG90cy0+Z2ZuX3RyZWUgPSBSQl9S
T09UOwo+ID4gIMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqAg
aGFzaF9pbml0KHNsb3RzLT5pZF9oYXNoKTsKPiA+ICDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDC
oMKgwqDCoMKgwqDCoMKgwqDCoMKgIHNsb3RzLT5ub2RlX2lkeCA9IGo7Cj4gPiAKPiA+ICDCoMKg
wqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgIC8qIEdlbmVyYXRpb25z
IG11c3QgYmUgZGlmZmVyZW50IGZvciBlYWNoCj4gPiBhZGRyZXNzIHNwYWNlLiAqLwo+ID4gIMKg
wqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqAgc2xvdHMtPmdlbmVy
YXRpb24gPSBpOwo+ID4gIMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoCB9Cj4gPiAKPiA+
IAo+ID4gPiA+IMKgwqDCoMKgwqDCoMKgwqAgQW4gTU1JTyBhY2Nlc3MgY2FjaGVkIGluIFNNTSAo
ZS5nLiwgR0ZOIDB4RkVENDAwMDAgd2l0aAo+ID4gPiA+IGdlbiA9IDQpIG1hdGNoZXMgaW4gbm9y
bWFsIG1vZGUgd2hlcmUgZ2VuIGlzIGFsc28gNC4KPiA+ID4gSG1tLCB0aGlzIGlzbid0IGFkZGlu
ZyB1cCBmb3IgbWUuwqAgSXQgc2hvdWxkIGJlIGltcG9zc2libGUgZm9yIHRoZQo+ID4gPiBnZW5l
cmF0aW9uIHRvCj4gPiA+IGJlICc0JyBmb3IgU01NLCBiZWNhdXNlIFNNTSBpcyBzdXBwb3NlZCB0
byB1c2Ugb2RkLW51bWJlcmVkCj4gPiA+IGdlbmVyYXRpb25zLsKgIEZyb20KPiA+ID4ga3ZtX3N3
YXBfYWN0aXZlX21lbXNsb3RzKCk6Cj4gPiAKPiA+IHZjcHVfY2FjaGVfbW1pb19pbmZvKCkgZG9l
cyBub3QgdXNlIHRoZSBhZGRyZXNzIHNwYWNlIGlkOgo+ID4gCj4gPiAgwqDCoMKgwqDCoMKgwqAg
dTY0IGdlbiA9IGt2bV9tZW1zbG90cyh2Y3B1LT5rdm0pLT5nZW5lcmF0aW9uOwo+ID4gCj4gPiBX
aWxsIHNlbmQgYSBwYXRjaCBzb29uLgo+IE5ldmVybWluZCwgd3JvbmcgdHJlZSAtIEkgd2FzIHJl
aW52ZW50aW5nIHRoZSAoYXBwYXJlbnRseSBidWdneSkgY29tbWl0Cj4gYmVjYXVzZSBpdCdzIHBh
c3QgNy4zLjAtcmM3Li4uIHN0aWxsIGxvb2tpbmcuCgpIZWgsIEkgZGlkIHRoZSBzYW1lIHRoaW5n
LiAgSSB3YXMgbGlrZSwgInRoaXMgY29kZSBkb2Vzbid0IGV4aXN0ISEhIiwgdGhlbgpyZWFsaXpl
ZCB0aGUgY29tbWl0IGlzbid0IGluIGt2bS9uZXh0LiAK
