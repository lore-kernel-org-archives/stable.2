Received: from mail.mainlining.org (mail.mainlining.org [5.75.144.95])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A5CDA35201B;
	Mon, 31 Aug 2026 12:10:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=5.75.144.95
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1788178205; cv=none; b=mCIzgmTtTwQca9FLxotMx19MQb7sSDOLmTc+Ty7QSSAFC6OQic0umIpYrJViWVQekuWvWBvrHqWVDZ0OBCHUMKGiH9AZYgsPfy1Y6brZ0rnMA1td1zKtkYSSGwkIbr3QelX5HZfC00xn6vHsPCpyNPxOFkJq4eX+L6SBgAqFKiA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1788178205; c=relaxed/simple;
	bh=eBSNaFSOLCz+04hqpn6qSgW2cL9lUyMhIKis3RfqKiQ=;
	h=Date:From:To:CC:Subject:In-Reply-To:References:Message-ID:
	 MIME-Version:Content-Type; b=T8NQuGd01prJj0B+8Y12SokEzqGzxbQx6cGLKnPbgFBVdO8nEsy68THtvZUfoerIJXM7S+P2IWu/eXPJvYKB2IMa/v+avt3jz0APMhkAhn5vPZ6bNxCZ5jjzVZlq6Q6gOYBYjiGp+cUs372rmRiA5j3PE0yJZ6n/F+jP7ciwT6k=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=mainlining.org; spf=pass smtp.mailfrom=mainlining.org; dkim=pass (2048-bit key) header.d=mainlining.org header.i=@mainlining.org header.b=ovpKuail; dkim=permerror (0-bit key) header.d=mainlining.org header.i=@mainlining.org header.b=P54Kkp4K; arc=none smtp.client-ip=5.75.144.95
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=mainlining.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=mainlining.org
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=mainlining.org header.i=@mainlining.org header.b="ovpKuail";
	dkim=permerror (0-bit key) header.d=mainlining.org header.i=@mainlining.org header.b="P54Kkp4K"
DKIM-Signature: v=1; a=rsa-sha256; s=202507r; d=mainlining.org; c=relaxed/relaxed;
	h=Message-ID:Subject:To:From:Date; t=1788178167; bh=gOlZhrf6+IhJJICS9Ylfglm
	3zkons1JuSC186WJA+Ps=; b=ovpKuailNsWC7h7xL8Xb5fSO47x298lVBAU4ytYQsoBqgoJ5A/
	aDXYcotq1GrjQuC3X4vzVsiIaIKvdLO3GAYhqBoBx3GboHGxfmq7rC5LROB5DY+dqJZzrvFCfUF
	KZc785uOaWWIrJH0anD7Qo2rzkGiVnjGbWsMfI5AWLBvLeYHimuaSbF+75RzGGW+NfOU+ZJ6s/7
	zHOviDKZZs7AnOo8qV1lSxuG6XQR+nEBLB71dTvnsJd+Rwg1GXAOImsVfqycSaMCa/xhqxISbno
	IdWMjrez6RBx0aYUvwQxk2oSuItM3+dckM9PeoJUBbmkNi8KYSZTkEpOxepFEGJT8oQ==;
DKIM-Signature: v=1; a=ed25519-sha256; s=202507e; d=mainlining.org; c=relaxed/relaxed;
	h=Message-ID:Subject:To:From:Date; t=1788178167; bh=gOlZhrf6+IhJJICS9Ylfglm
	3zkons1JuSC186WJA+Ps=; b=P54Kkp4KZbdV/Eyn5OXoL6B6TULMdcEqu+yx4UEEiXbGntbI3H
	8o2ZViICGIt+zvkBv2xiXxvmNX5gowTr5yAg==;
Date: Mon, 31 Aug 2026 13:09:27 +0100
From: Bradley Morgan <brads@mainlining.org>
To: Yuanhe Shu <xiangzao@linux.alibaba.com>
CC: tglx@kernel.org, mingo@redhat.com, bp@alien8.de, dave.hansen@linux.intel.com,
 x86@kernel.org, hpa@zytor.com, xin@zytor.com, luto@kernel.org,
 jpoimboe@kernel.org, peterz@infradead.org, rostedt@goodmis.org,
 akpm@linux-foundation.org, rdunlap@infradead.org, elver@google.com,
 andreyknvl@gmail.com, glider@google.com, gor@linux.ibm.com,
 kasan-dev@googlegroups.com, linux-kernel@vger.kernel.org,
 stable@vger.kernel.org
Subject: Re: [PATCH 1/2] stacktrace: Provide arch_in_irqentry_text() hook
In-Reply-To: <20260831120621.2882700-1-xiangzao@linux.alibaba.com>
References: <20260827150022.1618235-1-xiangzao@linux.alibaba.com> <20260827150022.1618235-2-xiangzao@linux.alibaba.com> <58EF0ADB-E7CC-4A15-B124-B5A870281D55@mainlining.org> <20260831120621.2882700-1-xiangzao@linux.alibaba.com>
Message-ID: <11763F21-E76F-4AC9-94E7-37CDA0340D37@mainlining.org>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain;
 charset=utf-8
Content-Transfer-Encoding: 8bit

On 31 August 2026 13:06:19 BST, Yuanhe Shu <xiangzao@linux.alibaba.com>
wrote:
>On Thu, Aug 27, 2026 at 06:04:48PM +0100, Bradley Morgan wrote:
>> LGTM, thanks
>>
>> Reviewed-by: Bradley Morgan <brads@mainlining.org>
>
>Thanks for reviewing v1.  I dropped the tag in v2 since the patch changed
>materially: Peter asked for the #ifndef macro override pattern instead of
>a Kconfig symbol, so the hook and its fallback now sit next to their only
>user in kernel/stacktrace.c and x86 defines the macro in <asm/sections.h>.
>The helper and the hook are also renamed to in_event_entry_text() and
>arch_in_event_entry_text().  Please have another look if you get the
>chance:
>
> 

Hmmm. Good opinion, it's varied imho. But I'm not conflicted. My tag
stands.
 https://lore.kernel.org/r/20260831120221.2874445-1-xiangzao@linux.alibaba.com
>
>Thanks,
>Yuanhe

--- Thanks!
https://lore.kernel.org/all/EE579805-42F2-4C58-B752-F28779EEB717@grrlz.net/
