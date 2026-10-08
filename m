Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C911A547075;
	Thu,  8 Oct 2026 00:08:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1791418105; cv=none; b=RILJvHqPkYiXzKBqLp8xRCd+xPuwuDt5t9wrkwyUNzlrwxtaDNpwcoXbBDQ7Nuyfh7evBP2RwQWiZ2nEvT/pJ6F3q6mm2rsEM3uOSOlNt9f1EbUiWCQt/xclk0WDuD69pi0IWDzZhodQfoi47gSw4JDEN6GLM3/i0bGPOCc2Ln4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1791418105; c=relaxed/simple;
	bh=bjdIpFjVbri68ioROi58o5xZPMVRM9A13esvgsFfEG0=;
	h=Date:From:To:Cc:Subject:Message-Id:In-Reply-To:References:
	 Mime-Version:Content-Type; b=iOe83sA7kuUuu/YJSuNUIZauOMIE1e+Qfx2qJdZeO9ABD58izaTC117fR9mXhc84m5i0oBw1nSXkDO2ssnbmiuvrJtOzSsnytdO+t6hILDrCChF4lO7WlmIa+AqNMo6f6+rwa34BmZRttMgvl+slXRfeCy2pc+pLmYk3E5HwlXQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (1024-bit key) header.d=linux-foundation.org header.i=@linux-foundation.org header.b=mvxovzML; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux-foundation.org header.i=@linux-foundation.org header.b="mvxovzML"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 32B481F000FF;
	Thu,  8 Oct 2026 00:08:24 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=linux-foundation.org; s=korg; t=1791418104;
	bh=jrFegUxIR4iV1bOcE+Var2Mj4AX7TlBHsWZNelWxYKU=;
	h=Date:From:To:Cc:Subject:In-Reply-To:References;
	b=mvxovzMLtUCfZ/G0A7sRSbAmf16+Dzvec3AZylKefJcmvqA5uoS4GhGF4yra6usQz
	 e91ZPWGnJgKhxVlGGaJaTXRtPbM5Su5rdIqcU1J+V9GxiTYRwMMLQTMLUdZJmtOzth
	 Ig0by4du0j5+PV3a0zmHj1epFAs59YMnjL/oYsn4=
Date: Wed, 7 Oct 2026 17:08:23 -0700
From: Andrew Morton <akpm@linux-foundation.org>
To: Armaan Sandhu <armaan.sandhu0504@gmail.com>
Cc: LZ <lzsx618@gmail.com>, Andy Shevchenko <andriy.shevchenko@intel.com>,
 linux-kernel@vger.kernel.org, stable@vger.kernel.org
Subject: Re: [PATCH] lib/cmdline: fix get_options() count and overflow with
 large ranges
Message-Id: <20261007170823.ecfc71e75b3bc416713d5a1e@linux-foundation.org>
In-Reply-To: <CANVJMCFQr9r5-_z3MKkX3G56DWBQTBK8XHW8+YBmme4=F+Cb5A@mail.gmail.com>
References: <20261005213945.359905-1-armaan.sandhu0504@gmail.com>
	<20261007150007.c7c6f2a4e41fd9f950c8427c@linux-foundation.org>
	<CAGD6qbSfTmHq7Y_jM7-QS26at=w6OQwfOZjCU8n4PnnFmqgDNg@mail.gmail.com>
	<20261007160856.c97b2d48db0fea0b3744d6aa@linux-foundation.org>
	<CAGD6qbRJFPX9dYHokumQat3q0AZiG7bgC3hr8rMpCc_BUS6f2g@mail.gmail.com>
	<CANVJMCFQr9r5-_z3MKkX3G56DWBQTBK8XHW8+YBmme4=F+Cb5A@mail.gmail.com>
X-Mailer: Sylpheed 3.8.0beta1 (GTK+ 2.24.33; x86_64-pc-linux-gnu)
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit

On Wed, 7 Oct 2026 19:50:38 -0400 Armaan Sandhu <armaan.sandhu0504@gmail.com> wrote:

> On Wed, 7 Oct 2026 Andrew Morton <akpm@linux-foundation.org> wrote:
> > Armaan, can you please check the regression tests, see if there's
> > anything to be incorporated into yours?
> 
> Leizhen's two cases pass with my patch. "0-2147483647" in validation
> mode is already in my table, but "1,0-2147483647" isn't, and it is worth
> adding since it hits the overflow guard with a value already parsed, which
> none of my cases do. It's one extra row:
> 
> { "1,0-2147483647", { 3, 1, 0, 1, }, 1, },
> 
> Earlier you asked what would change in a v2. Nothing else, so I can
> send a v2 with that row, or you can fold it in, whichever is easier.
> 
> Thanks Leizhen for the review.

Yes, thanks both.  I queued Armaan's patch and appended this:

--- a/lib/tests/cmdline_kunit.c~lib-cmdline-fix-get_options-count-and-overflow-with-large-ranges-fix
+++ a/lib/tests/cmdline_kunit.c
@@ -151,6 +151,7 @@ static const struct {
 	{ "0-2147483647",  { 3, 0, 1, 2, },    0,          },
 	{ "-5-2147483647", { 3, -5, -4, -3, }, 0,          },
 	{ "2147483647--5", { 0, 2147483647, }, 0,          },
+	{ "1,0-2147483647", { 3, 1, 0, 1, },   1, },
 };
 
 static void cmdline_test_range_overflow(struct kunit *test)
_

