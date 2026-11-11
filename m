Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=209.85.214.199
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1794412122;
	b=gpHPkciRqjQg0gCALQPSdW0qgRQ2IzrwyRMdqv6OsIzHqOIBxCpJr9cN3AKB4nP8cmY4
	 GAPtkHYw0NaIpzoigPW0vfv4X8DvAes3JOj2zk7dSL0qxehXDw1yaeqDb4qwpLUkQIPS9
	 RFVkp+SFdF9VJTi4DqxMZY5Rr/o6x+Lfn/eH9srA8imWlc4dqk8vxG9SE9Ue9RVph6bRy
	 m7nRdWFeqTDhz3UjfVpoo1azJIPxTIkvJJyF/DAgeRHX0k22OdTXmItYKQTk5PvoS0KuC
	 VFJwB9I8TWTXzGKPqc37OYGixQNp6GznAB3fRjFfnD6zSrkEhyx81Mv4r2h2arVxvYg==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1794412122;
	h=DMARC-Filter:Received:DKIM-Signature:X-Google-DKIM-Signature:
	 X-Gm-Message-State:X-Received:Date:In-Reply-To:Mime-Version:
	 References:Message-ID:Subject:From:To:Cc:Content-Type;
	bh=sD5m9wxfAmqGy8WqksgAdciSi6Tv7++VHAS17t0B3XU=;
	b=JmKmK5mDQPcWGgE9hqzRfnEzsnJCl7/lomF8dTlpIIA2thv//pjKoGtfZgBvnP5qkkvu
	 RlTahz5SRGdqf5VLUQLpsPM2y1NM23ILkLq8BIrPCDuyCdXdu0jv/ndPjFLbbPtqWRIiQ
	 nhfma/bbsxGi4w6wfaFmxl7K6PQg1LU0X014fOPcbZpHSxVn+0JdrNnpNmSBRirV+mEnt
	 CPct0htJ7StX1Uk7Tp1YK3UFzEp0TfCF7m4+aRtIi2EsYl+bCRf6VgTcKlsLRHPJF/dFC
	 39luwfaAtGqQqDddFoX3W9/X91jRH82RdtqyD6KQljamkTbJoY8EwycILhdzyeH9PdA==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=google.com;
	spf=pass smtp.mailfrom=flex--seanjc.bounces.google.com;
	dkim=pass header.d=google.com header.i=@google.com header.a=rsa-sha256 header.s=20260707 header.b=Uc+hRBnH;
	arc=none smtp.remote-ip=209.85.214.199
Received: from mail-pl1-f199.google.com (mail-pl1-f199.google.com [209.85.214.199])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 645D9606A32E
	for <stable@vger.kernel.org>; Wed, 11 Nov 2026 15:48:42 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 645D9606A32E
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=flex--seanjc.bounces.google.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.a=rsa-sha256 header.s=20260707 header.b=Uc+hRBnH
Received: by mail-pl1-f199.google.com with SMTP id d9443c01a7336-2e95f8543c9so45605105ad.3
        for <stable@vger.kernel.org>; Wed, 11 Nov 2026 07:48:42 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20260707; t=1794412122; x=1795016922; darn=vger.kernel.org;
        h=content-type:cc:to:from:subject:message-id:references:mime-version
         :in-reply-to:date:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=sD5m9wxfAmqGy8WqksgAdciSi6Tv7++VHAS17t0B3XU=;
        b=Uc+hRBnHHYIgSwUkS0XBHT0Sxs7P+lytC9FrK+WNlIKU/JrTkkE64vZG4il0+UEYNl
         cNdQL44OlTzgO7QzMEVtg2NjeHcADhOaC4Ib72Eu5jpdnb0E/6DI4wdTL+WHFLhSGXLN
         mI0OFnL9yfsG/QXqTJaIyWmcTD3zEceOnWupQ9gWMobMJMbaz+cE2ZQO7qdC6qJwD07U
         y5BpZSf0czdzKlaAl602dCnw5BJSMOH6el7P8R8FFjYS+raWEObV7j19xCjNLMVhDQz/
         puZUF5USPYsYvPylFOK6hBO9LXgg7Tp7xmvYgO/DgVHgvazc4xOLjd+Iwo0hcVQ5a27P
         qKEw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1794412122; x=1795016922;
        h=content-type:cc:to:from:subject:message-id:references:mime-version
         :in-reply-to:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=sD5m9wxfAmqGy8WqksgAdciSi6Tv7++VHAS17t0B3XU=;
        b=QaZ/YYrTuIIRvA2XBTdUcLJwf0Ao8BwNGjkUFrRhL45robKqymRqrdmig0T30B8UML
         9c9lurQYYyLJcaQ5BiK9K5tGheV/37ArlArqLvov4lQAYd2QR1IHl+3fbBbACgTp8U6g
         Hs8dTeHWJP/QK6RLMX/vmASuwXX2JfuM+gcFxLfwnErNOcYKDOeS7b5F/QyHqwvzpbQy
         7YxN0h//fAobyKWKfTY4qWxEj3lZTh5lMA5MmJH2TiaDUPcxwvUT5uAQc+GRHNVwzbzO
         zEGL6m25V4BTDBVa1+fehddFpr1hJbUAbtu7LTsnmqkuJYubfltxdSoVqo980vnDV0B7
         cdHA==
X-Gm-Message-State: APuU4Z8F3SaTSeshWNNWKC2rW9RLMtqTzeKIfM1WQSMszi4eNWIl9zEy
	rdktFDOhyUbD+c27kfMJcasufdqVGMo5Du5AxNH1Dcw/3dbJAzD+rrDarK65k1sA/B2qHpsHojd
	4lgaNTg==
X-Received: from plty11.prod.google.com ([2002:a17:902:864b:b0:2ea:f122:5203])
 (user=seanjc job=prod-delivery.src-stubby-dispatcher) by 2002:a17:902:e80c:b0:2ed:102c:f24
 with SMTP id d9443c01a7336-2edd7af5ee4mr31522735ad.53.1794412121550; Wed, 11
 Nov 2026 07:48:41 -0800 (PST)
Date: Wed, 11 Nov 2026 07:48:40 -0800
In-Reply-To: <20261111024039.676658-4-sashal@kernel.org>
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Post: <mailto:stable@vger.kernel.org>
List-Help: <mailto:stable+help@vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
List-Owner: <mailto:stable+owner@vger.kernel.org>
Precedence: list
Mime-Version: 1.0
References: <20261107052838-failed-6.6-eacdb76c5f04@kernel.org>
 <20261111024039.676658-1-sashal@kernel.org> <20261111024039.676658-4-sashal@kernel.org>
Message-ID: <avSOWHlEF4NnMZ0t@seanjc-mac.roam.internal>
Subject: Re: [PATCH 6.6.y 4/5] KVM: s390: Refactor kvm_is_error_gpa() into kvm_is_gpa_in_memslot()
From: Sean Christopherson <seanjc@google.com>
To: Sasha Levin <sashal@kernel.org>
Cc: stable@vger.kernel.org
Content-Type: text/plain; charset="us-ascii"

On Tue, Nov 10, 2026, Sasha Levin wrote:
> From: Sean Christopherson <seanjc@google.com>
> 
> [ Upstream commit 9e7325acb3dc8df8a6370ebc18aef107aae17ef0 ]
> 
> Rename kvm_is_error_gpa() to kvm_is_gpa_in_memslot() and invert the
> polarity accordingly in order to (a) free up kvm_is_error_gpa() to match
> with kvm_is_error_{hva,page}(), and (b) to make it more obvious that the
> helper is doing a memslot lookup, i.e. not simply checking for INVALID_GPA.
> 
> No functional change intended.
> 
> Link: https://lore.kernel.org/r/20240215152916.1158-9-paul@xen.org
> Signed-off-by: Sean Christopherson <seanjc@google.com>
> Stable-dep-of: eacdb76c5f04 ("KVM: x86/xen: Enforce 4-byte alignment of vcpu_info registration")

NAK.  AFAICT, there are no dependencies, i.e. the patch failed to apply purely
because of the resolved conflict:

   [ sashal: Omitted the HVA alignment check because only GPA registration is supported. ]
