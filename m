Received: from mail.mainlining.org (mail.mainlining.org [5.75.144.95])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6BB074503F0;
	Thu, 27 Aug 2026 12:45:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=5.75.144.95
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1787834712; cv=none; b=Gc5s848LIv8uAig10FNSeVrZhOclnKuzWJpOrrZ0mA44HpN/8BuNUwOTtCLHg0lQHORSbyP94g10q6MteBOQYUhxJIGMW9QeB7XITOFjnkdpASivmBvVczeFif06sS+mLdqtk3Il9I8I8mX6Y9u52yssEMbzy8CjzKdp40FYzro=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1787834712; c=relaxed/simple;
	bh=9CO6XPws66LC487FgaRgDop5rE/nPJskI5F38LvJY/k=;
	h=Date:From:To:CC:Subject:In-Reply-To:References:Message-ID:
	 MIME-Version:Content-Type; b=I5UxQVbb3X8khQqCx/kAx2Hk3t2nbpwAmjebmK9xq/MH1+VDoHcwhJ+JnIjET4c6KQX/noVMDXdUyokmxyYt1rkAZauTTVmA/Z6t0RnkAmPBC+aTVP4/Fgf87omdEmVZtUpKGxDWySLNcc1KoEoYRC/HCX2suVFQ+FocUxnFUwk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=mainlining.org; spf=pass smtp.mailfrom=mainlining.org; dkim=pass (2048-bit key) header.d=mainlining.org header.i=@mainlining.org header.b=klSciWqx; dkim=permerror (0-bit key) header.d=mainlining.org header.i=@mainlining.org header.b=tsDSy6WB; arc=none smtp.client-ip=5.75.144.95
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=mainlining.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=mainlining.org
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=mainlining.org header.i=@mainlining.org header.b="klSciWqx";
	dkim=permerror (0-bit key) header.d=mainlining.org header.i=@mainlining.org header.b="tsDSy6WB"
DKIM-Signature: v=1; a=rsa-sha256; s=202507r; d=mainlining.org; c=relaxed/relaxed;
	h=Message-ID:Subject:To:From:Date; t=1787834653; bh=qmczfJJgEwvbZO3x8rHiMlF
	+znFs8ONYjHZmCN/ThRY=; b=klSciWqxMtqsoJWx1TECDSEfxO2Uw+5EPKx0ecGx2Q8b6cNxHd
	cCvkngGlFPq4yfJkJeymy88YCRL6zGOh4SepZV3vB0XF4hp+hAX4M94nuIbeg9WFFrQ5R0Yj0/G
	0DD9zQjCdub6SKwnCxq0UVqhGGKUQ8acZaJgf+IOstmM4AqtRCWk17R0iPv3sUM6CTUUWKy0peu
	oKHSEu/0vVJYesRrllvDph10FhbJ4IyFN5ao6Fzvh8gE+UqfTbiWujh2mw4QMVZjnS4j4gh5IlA
	mp10ogEs+kdKH6nd6QfeNMVREB+/T3JMb0KPL5ehJhgUvsGwQ1TkugN22HmYxAqU9XQ==;
DKIM-Signature: v=1; a=ed25519-sha256; s=202507e; d=mainlining.org; c=relaxed/relaxed;
	h=Message-ID:Subject:To:From:Date; t=1787834653; bh=qmczfJJgEwvbZO3x8rHiMlF
	+znFs8ONYjHZmCN/ThRY=; b=tsDSy6WBC6MWyDJn2An4rMNmNTxKrhXvTaN7TUG+HJCHteXW8C
	TbOAwiXG9WRamWPW3tkD54uRfgsGAllYbCDQ==;
Date: Thu, 27 Aug 2026 13:44:13 +0100
From: Bradley Morgan <brads@mainlining.org>
To: Steven Rostedt <rostedt@goodmis.org>
CC: =?ISO-8859-1?Q?J=E9r=E9my_Jean?= <jeremy.jean@oss.cyber.gouv.fr>,
 mhiramat@kernel.org, mathieu.desnoyers@efficios.com,
 linux-kernel@vger.kernel.org, linux-trace-kernel@vger.kernel.org,
 stable@vger.kernel.org
Subject: =?US-ASCII?Q?Re=3A_=5BPATCH_v2=5D_tracing/user=5Fevents=3A_Clear_c?=
 =?US-ASCII?Q?opied_tracing_state_before_fork_duplication?=
In-Reply-To: <20260827084306.54c13b60@gandalf.local.home>
References: <20260826214414.1971632-2-Jeremy.Jean@oss.cyber.gouv.fr> <20260827080839.35e44d04@gandalf.local.home> <A4F580CE-2211-4D05-9D3D-15AB427C74A4@mainlining.org> <20260827081915.320fe2c3@gandalf.local.home> <3beb0339407a35c0b995856eae74d870@oss.cyber.gouv.fr> <CE51AB37-6584-4001-9375-24AA00C8B79D@mainlining.org> <20260827084306.54c13b60@gandalf.local.home>
Message-ID: <E35157CB-DB14-4195-87A5-FD411D9E464A@mainlining.org>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain;
 charset=utf-8
Content-Transfer-Encoding: 8bit

On 27 August 2026 13:43:06 BST, Steven Rostedt <rostedt@goodmis.org> wrote:
>On Thu, 27 Aug 2026 13:29:20 +0100
>Bradley Morgan <brads@mainlining.org> wrote:
>
>> I review on
>> 
>> 
>> 1: does this do what it's intended
>> 2: does it fix X?
>> 3: Any comments, any new functions used instead, any way to get the line
>count shorter?
>> 
>> 
>> And others, I apologise if I'm wrong. I just review in a different
>style.
>
>Please just focus on correctness, until you understand what the
>maintainer's preferences are.
>

Yep, I already do, I focus on if the code is actually correct too.

So don't panic. :)

>-- Steve

--- Thanks!
https://lore.kernel.org/all/EE579805-42F2-4C58-B752-F28779EEB717@grrlz.net/
