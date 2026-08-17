Received: from sender4-op-o12.zoho.com (sender4-op-o12.zoho.com [136.143.188.12])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 10B7233A6F1;
	Mon, 17 Aug 2026 17:46:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=136.143.188.12
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1786988763; cv=pass; b=QDZI7EZIK1TO2aWgqLPdJjP9SMTD8F8r+WZWfT5wvXSQkaryEFUC93zdT5O/61D5Z9WmGyqI0DoK0lejMqcJmppB7SKfmFbQZLA6/g9qLZFExyC0OCxJvm+pmADzqj/v147UwSshd+8s8/QutWk50X2anoeKkpJzsvDPi/etXss=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1786988763; c=relaxed/simple;
	bh=fcVjRaOh4uZVmU2qn27MI5GgKvqFd87cyenClV5K7ls=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=Q1XUBDhMVkEh23x0gHscf9XxM8zS9EfyitTMeZp71pTatHRHJJus4M/93PMruWh0HMrdD0mI0Sutq4qpRc6MHGAXgK0P1P1yfGsUtBjaNVm3C5IoLn5V9i1Xdn1u1JchnUsaUOvq2dBP3TkNnEYuN2HTPj4EgiqRaH+QsQghG58=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=yoavmoshe.com; spf=pass smtp.mailfrom=yoavmoshe.com; dkim=pass (1024-bit key) header.d=yoavmoshe.com header.i=linux@yoavmoshe.com header.b=BXKxUt9l; arc=pass smtp.client-ip=136.143.188.12
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=yoavmoshe.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=yoavmoshe.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=yoavmoshe.com header.i=linux@yoavmoshe.com header.b="BXKxUt9l"
ARC-Seal: i=1; a=rsa-sha256; t=1786988726; cv=none; 
	d=zohomail.com; s=zohoarc; 
	b=kiiysDlY08xI+13vcEh0ELmwguZBCTuNeVGPce9UiqyLB76PuRf07HvYi/d4/2PN5o4NpplgKQo0YVtFQ11eizPV08cB+v0quRb1KZl+XxvvHGWMVfUC9pZHx/UYVJTwOsSCvAVkiyq9iRPXl49fK41apZHAtTXr3Bn0uucaaig=
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=zohomail.com; s=zohoarc; 
	t=1786988726; h=Content-Type:Content-Transfer-Encoding:Cc:Cc:Date:Date:From:From:In-Reply-To:MIME-Version:Message-ID:Subject:Subject:To:To:Message-Id:Reply-To; 
	bh=2l4J+dUreXi4HDK22EG6FGwZCpdoMeAtRZ6lNLT7i3I=; 
	b=H4tiFwR3ASxQn2Gdcaih/4GUcWqkEmyOEd6XejZhLogNRAHTMorKi7H8SXbaIrUZqHwTZKYKhU45jDSGv2Gg8HA4Sp+60jKKmUgpPUXDc2uVyOMoKSoui8omb7n8LJ2dhCUNAP5SWfIWKQysmSMtGZwF3ZyNhNfn7/c9pq4feOg=
ARC-Authentication-Results: i=1; mx.zohomail.com;
	dkim=pass  header.i=yoavmoshe.com;
	spf=pass  smtp.mailfrom=linux@yoavmoshe.com;
	dmarc=pass header.from=<linux@yoavmoshe.com>
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; t=1786988726;
	s=zoho; d=yoavmoshe.com; i=linux@yoavmoshe.com;
	h=Message-ID:Date:Date:MIME-Version:Subject:Subject:To:To:Cc:Cc:From:From:In-Reply-To:Content-Type:Content-Transfer-Encoding:Message-Id:Reply-To;
	bh=2l4J+dUreXi4HDK22EG6FGwZCpdoMeAtRZ6lNLT7i3I=;
	b=BXKxUt9lwRV7o128/E8vX7B+EQ0nrVmUojBnSWIhgLmAB3dyK6N10NHmXkABYFlj
	3Y6GjpB4qhm3pDG/2q4uh+GYtrwPL46eVCey6cCNaMUqUW63QedMF/iO+orK1SVL0GF
	YGSBfL1VlXumA9k2+I1+R1Mhc1eLtif16ysG8RkM=
Received: by mx.zohomail.com with SMTPS id 1786988722655882.7718161276589;
	Mon, 17 Aug 2026 10:45:22 -0700 (PDT)
Message-ID: <2056b473-4175-4383-926d-d15b566f0dd5@yoavmoshe.com>
Date: Mon, 17 Aug 2026 19:45:18 +0200
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v3] ARM: imx: Fix suspend/resume crash with Clang CFI
To: Sascha Hauer <s.hauer@pengutronix.de>, Frank Li <Frank.Li@nxp.com>
Cc: Nathan Chancellor <nathan@kernel.org>,
 Russell King <linux@armlinux.org.uk>,
 Nick Desaulniers <ndesaulniers@google.com>,
 Pengutronix Kernel Team <kernel@pengutronix.de>,
 Fabio Estevam <festevam@gmail.com>, Bill Wendling <morbo@google.com>,
 Justin Stitt <justinstitt@google.com>, imx@lists.linux.dev,
 linux-arm-kernel@lists.infradead.org, Sami Tolvanen
 <samitolvanen@google.com>, llvm@lists.linux.dev, stable@vger.kernel.org,
 linux-kernel@vger.kernel.org
References: <20260718111340.159896-1-linux@yoavmoshe.com>
 <CABCJKudqGL+BFFcz3qsuoJB6S_OAt-vs2yqePC_=oy+JzmPpVw@mail.gmail.com>
 <3046e60d-509f-471f-bd15-3ce78c87500b@yoavmoshe.com>
 <20260721180950.GA3684684@ax162>
 <180001f5-bddd-4e58-8442-f7ef3c979500@yoavmoshe.com>
 <CABCJKufhvTxmVm8y7xr4RWWKsoZk0h8UGBnem+F5fknnimaqPA@mail.gmail.com>
 <7f273a08-b29c-4e15-b340-898b251efe57@yoavmoshe.com>
 <CABCJKud+GsBVv+XMTsi_4QAaTHo7jXD2Hyvi9wqKd7x3i2xyAg@mail.gmail.com>
 <415ffa24-a30b-43b2-aa6a-a1cde3bd4ef0@yoavmoshe.com>
 <CABCJKud9B8vB-J8f0HLHw6EgEKVWzy+Q1PrNxpO_6yCGtEyi8A@mail.gmail.com>
 <12a46993-82a5-4109-87fa-61b8fcf764aa@yoavmoshe.com>
 <CABCJKufoQ0fX797M01t7CkTgMEwNCELY1=ptZsxr=jWOR-KAyA@mail.gmail.com>
 <CAKwvOdnaOy-nyZ=8oLw4N-_hA9JZVdP2BhR8cweCAOhsy4VG6w@mail.gmail.com>
 <91cb0f21-e78a-4931-b123-937c6a01592c@yoavmoshe.com>
Content-Language: en-GB, sv-SE
From: Yo'av Moshe <linux@yoavmoshe.com>
In-Reply-To: <91cb0f21-e78a-4931-b123-937c6a01592c@yoavmoshe.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-ZohoMailClient: External

On 2026-07-26 5:36 PM, Yo'av Moshe wrote:
> Yes, I tried that as well and it unfortunately didn't work.
> 
> I tested Nathan's change along with explicitly copying the 4-byte
> prefix from before imx6_suspend into OCRAM right before calling fncpy().
> However, when checking the compiled binary, "&imx6_suspend - 4" just
> contained padding rather than the hash, so the copied 4-byte value
> didn't match what the call site expected.
Hi Sascha, Frank,

Gentle ping on this patch. Is there anything else needed from my end?

Best regards,
Yo'av
