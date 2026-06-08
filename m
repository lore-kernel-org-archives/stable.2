Received: from mail-dy1-f178.google.com (mail-dy1-f178.google.com [74.125.82.178])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E624031A81C
	for <stable@vger.kernel.org>; Mon,  8 Jun 2026 20:01:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=74.125.82.178
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1780948909; cv=none; b=a2U1wKCaYYKsGr5RpSQQTRG6JgZenAe66JZoYlU/CeSO62Wq32IBNNmul5fl4500BeynFi2p9TgqS4scuVEECXHIhPQ2fwSrFtPz4iuIwLSJNa8f1wxjpNrhZiI7ymgP+xT/uighYGRiJIxAMYCg7jNApHn/UMIyycxdZZ6PcXM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1780948909; c=relaxed/simple;
	bh=TXnwBHRGekJNCNs6l6QYmnGYpiNGy3SB2AnSS2LrOcw=;
	h=Message-ID:Subject:From:To:Cc:Date:In-Reply-To:References:
	 Content-Type:MIME-Version; b=u9JtjitqMsWgqOqY54kMGar3n8OOistN49yuO31UHSwNG2ZrMxnGZBXo1nmYznnTbUmDkxriVVuA52FdCTO0lrMSpcTrp5yDvwHW1FW/zWmuflvCAxM2Vl/F8zzIDkOcHWMZOfBXrKIQkpvcIlmKWNJm8rqWaXm87o/8IWLTqsI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=eZAWrj49; arc=none smtp.client-ip=74.125.82.178
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="eZAWrj49"
Received: by mail-dy1-f178.google.com with SMTP id 5a478bee46e88-3075ce9c05aso8723769eec.1
        for <stable@vger.kernel.org>; Mon, 08 Jun 2026 13:01:47 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1780948907; x=1781553707; darn=vger.kernel.org;
        h=mime-version:user-agent:content-transfer-encoding:references
         :in-reply-to:date:cc:to:from:subject:message-id:from:to:cc:subject
         :date:message-id:reply-to;
        bh=TXnwBHRGekJNCNs6l6QYmnGYpiNGy3SB2AnSS2LrOcw=;
        b=eZAWrj49hX9Vepu8XP/+7VQF2hp1DhvY6a2SyjcSfGxiXmIhrOyVyLGBTC4+a95NOX
         dybKpvV2fygRL9pDl2uxIewFpkXphr1zQTomJ69RXdKRlwaZBLLdaCItNDXrsU9jM11H
         Sm+e+hqJks3aGhkRrgreGdILe5lCo4K1/5ZsmvBlLwy50MvJJqniyGsc9FBcWTUCpXH7
         qLF1Zs8qL5cwYt1RLNSVZwB43m8N9D/s60DvRf8EGS4pNb8i+PdRqNIdPviskJi+Y0pm
         mJq6HxdbBiSKrKRI9J+APV4KTJWG78qZbIpP9Y1IrjyPta8uA0QAJ17N4O9w30MuulKU
         1v/g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1780948907; x=1781553707;
        h=mime-version:user-agent:content-transfer-encoding:references
         :in-reply-to:date:cc:to:from:subject:message-id:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=TXnwBHRGekJNCNs6l6QYmnGYpiNGy3SB2AnSS2LrOcw=;
        b=BbdsM6jGpPU1G9O/VMN1MaFMaPyk0k6ABLFpxhkJMZprZjBRAAs2RdMJoExsHsKCsS
         omx78ifBkwHU1ojqopdKIY/kE50w03gUtX+gR1uUzU4DSOYbb3EdHJBfkKn2dlVHKLUI
         NoBYhNffyrQeY5ZGWVw+LkCkcNkqJ5sZP6wkXmEV8RmM0boFJ0ELVVuZrj9JwqIPl5An
         ANEOkpxWAWU/VgjL58ChLPw6ggUWkImoPWGqfRXi+R3NWrQtxyfQmwJtt/nrr1SCkeV8
         ZmUn+YkGHwnZDIJysaAqJz33/d3vaIJIZ8ghC6tQOa+Eqi3ZiBXtp2uBeaK/i35CsS6v
         Zw5g==
X-Forwarded-Encrypted: i=1; AFNElJ8ZsNv4SOwbQMQJD4dZx1PCZaWRiJAHwBt+j0xibXMrdkUfQJ8Cs+fWlinxZEP1P+PrMx5Lsb4=@vger.kernel.org
X-Gm-Message-State: AOJu0Yy7Snvy3q7wQTwCxYqlp+V/mx7V8PAvUASmPq64ikVwN0sJYhVL
	Or0OcCHCn794LG3BXLEVeAPYS0wtz3da0rIns/wDA6xHiOdE5i0W/I65
X-Gm-Gg: Acq92OFjj4HlOU4CUGCQMxDmCEFfJ7+jiuNnblcTtBytHOcaNprDmk7fUprzUlE8qqM
	xhafc3jJBmOpsS0776SonuNSSpaZU/vWf4KZlfYBUbFnOn8ndWmosU6MDNTkqU2/Uw2RuWGV23x
	x0YAIJ7wgQZTD3nJBEfcRFMRnFRUhZ9Yz2oEV7GrlQkq9lO+4XSQ8ARqWFkfBSJaxJ6GamTVwHs
	MExsw0o0PRcAt6tbZNr4Cy0jW39n4iRwoOt+Z/IUdcwOM3ryjbvHeT6Fa3Vl2PsAeiLwPg/epeW
	x+m8GnsTn/rGWOfqx3RalGnXPTa/U+W/J9AgJUGdfLKWVT18nTcVFYU1WCYStI/TUQ5jNSsbFYD
	cqM6mLMoEoTaNzLyksxMwOlEduZeERBFulOeNUFFsMcRCWbY62sPRd8NnOX/NWNveVPEBV/jvKq
	16dCU+nY72nJNaEDg0ZVTyST9kz+8jyTUD6XCrlZabcNzw4b545kolnpaZayL2yC6zM8ugttLoL
	7ss3/Bh7vzb00w6
X-Received: by 2002:a05:7300:534f:b0:304:d32e:65f9 with SMTP id 5a478bee46e88-3077aee8646mr9878346eec.6.1780948907037;
        Mon, 08 Jun 2026 13:01:47 -0700 (PDT)
Received: from ?IPv6:2a03:83e0:115c:1:1875:35fb:3a7:e87f? ([2620:10d:c090:500::3:d25])
        by smtp.gmail.com with ESMTPSA id 5a478bee46e88-3078c1ac378sm10521461eec.1.2026.06.08.13.01.45
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 08 Jun 2026 13:01:46 -0700 (PDT)
Message-ID: <189a79443144cacf4a257f0627586f917d8d18a2.camel@gmail.com>
Subject: Re: [PATCH bpf] bpf: Validate BTF repeated field counts before
 expansion
From: Eduard Zingerman <eddyz87@gmail.com>
To: Paul Moses <p@1g4.org>, martin.lau@linux.dev, ast@kernel.org, 
	daniel@iogearbox.net, andrii@kernel.org, memxor@gmail.com,
 bpf@vger.kernel.org
Cc: song@kernel.org, yonghong.song@linux.dev, jolsa@kernel.org, 
	houtao1@huawei.com, linux-kernel@vger.kernel.org, stable@vger.kernel.org
Date: Mon, 08 Jun 2026 13:01:44 -0700
In-Reply-To: <20260605234301.1109063-1-p@1g4.org>
References: <20260605234301.1109063-1-p@1g4.org>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
User-Agent: Evolution 3.60.1 (3.60.1-1.fc44) 
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0

On Fri, 2026-06-05 at 23:43 +0000, Paul Moses wrote:
> btf_parse_struct_metas() walks user-supplied BTF during BPF_BTF_LOAD,
> and btf_repeat_fields() expands repeatable fields from array elements
> into the fixed BTF_FIELDS_MAX scratch array used by btf_parse_fields().
>=20
> The remaining-capacity check performs the expanded field count calculatio=
n
> in u32. A malformed BTF can wrap that calculation, causing the check to
> pass even when the expanded field count exceeds the scratch array
> capacity. The following memcpy() can then write past the end of the
> array.
>=20
> Use checked addition and multiplication before copying repeated fields
> and reject impossible counts.
>=20
> Fixes: 797d73ee232d ("bpf: Check the remaining info_cnt before repeating =
btf fields")
> Cc: stable@vger.kernel.org
> Signed-off-by: Paul Moses <p@1g4.org>
> ---

Regardless of the sibling email I sent, I think that this is a good
defensive practice to use check_{add,mul}_overflow() here.
Having said that, it would be nice to have a selftest in the patch-set.

Acked-by: Eduard Zingerman <eddyz87@gmail.com>

[...]
