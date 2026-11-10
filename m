Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=216.40.44.17
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1794297333;
	b=WoNtSzFYytAuc5gajRZgUGJfjl2YJyOjPwMaAQhDc/Wrbm4ejkTD53VF7ctns/exEIHF
	 eXKF2TsNhibv2FhpVn2S2FWU/xYJuGvCSgZQMNgDqgV4Fr785Xkbx6EQdzoUd+0utj0k5
	 KSVjyVCJy4hi/IK+qaSGA+m++znWULiHWqYm8g+BCwSQzZzrJFpbKHo7r4eQebDHWctUW
	 M0tSZJ3ta/61+4WjIKzMNc9WOCPqkjhKLVkTdODkXPRDbZJ6SbCGEfRKm0hshLC1rxLXr
	 pHUkFizl8aoaJUpkgB73sPcno7yByV8yFVO7QWhGEvLC4kq7jUCs4L+Ez55r9B3NuhQ==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1794297333;
	h=DMARC-Filter:Received:Received:Date:From:To:Cc:Subject:Message-ID:
	 In-Reply-To:References:X-Mailer:MIME-Version:Content-Type:
	 Content-Transfer-Encoding:X-Rspamd-Server:X-Rspamd-Queue-Id:
	 X-Stat-Signature:X-Spam-Status:X-Session-Marker:X-Session-ID:
	 DKIM-Signature:X-HE-Tag:X-HE-Meta;
	bh=/dw8tqJnozMzOasRMjBMDX6slYfTi2Jc/2gRtK/CL9I=;
	b=osmck0XNdBmZJWxoTNMHJ33BFVeJHsxqkolG0HwxCOYB0rJmUX2ZHD3Vc9AbiIr6qvEJ
	 sd1JsUr3Y3nFKr1bI7bRiyasJjWaDQC0D+YLR3j28LJEK+8XYREIP8+c/vyruXEm3e2Qb
	 VVCAtp31METkmznyRLkvZ2tmE2VTrfi8+3yfHkyR/XKQjLByojOWivhcXoBF2B/gDV6L8
	 2QQldC0PKdfU+L2FF6ErTNTIGYBO4vH+/nRE+zcN7kzWKQ1hJ1s2XfLiKdzbKzJfVUI5j
	 fvzOHuwwvylNFJwpJ52vhTmcBjN6oCwb1jK4Y9yCSBr2JP8fbtiwA5JqgMOdL8rrxjQ==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=goodmis.org;
	spf=pass smtp.mailfrom=goodmis.org;
	dkim=pass header.d=goodmis.org header.i=@goodmis.org header.a=rsa-sha256 header.s=dkim1 header.b=ahDNsSkJ;
	arc=none smtp.remote-ip=216.40.44.17
Received: from relay.hostedemail.com (smtprelay0017.hostedemail.com [216.40.44.17])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3EB72606A31C;
	Tue, 10 Nov 2026 07:55:32 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 3EB72606A31C
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=goodmis.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=goodmis.org
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=goodmis.org header.i=@goodmis.org header.a=rsa-sha256 header.s=dkim1 header.b=ahDNsSkJ
Received: from omf08.hostedemail.com (lb01a-stub [10.200.18.249])
	by unirelay06.hostedemail.com (Postfix) with ESMTP id 8A3FAA85F9;
	Tue, 10 Nov 2026 07:55:30 +0000 (UTC)
Received: from [HIDDEN] (Authenticated sender: rostedt@goodmis.org) by omf08.hostedemail.com (Postfix) with ESMTPA id 516D920025;
	Tue, 10 Nov 2026 07:55:26 +0000 (UTC)
Date: Tue, 10 Nov 2026 02:55:21 -0500
From: Steven Rostedt <rostedt@goodmis.org>
To: Breno Leitao <leitao@debian.org>
Cc: Vincent Donnefort <vdonnefort@google.com>, Masami Hiramatsu
 <mhiramat@kernel.org>, Mathieu Desnoyers <mathieu.desnoyers@efficios.com>,
 linux-kernel@vger.kernel.org, linux-trace-kernel@vger.kernel.org, Steven
 Rostedt <srostedt@redhat.com>, kernel-team@meta.com, stable@vger.kernel.org
Subject: Re: [PATCH v2] ring-buffer: Handle a reader taking the new head in
 rb_handle_head_page()
Message-ID: <20261110025521.289f4303@fedora>
In-Reply-To: <avHFeq9GjAVN_OnF@gmail.com>
References: <20261105-ring-buffer-head-moved-v2-1-05da40cebccc@debian.org>
	<20261105155729.0f9c7e4d@gandalf.local.home>
	<avHFeq9GjAVN_OnF@gmail.com>
X-Mailer: Claws Mail 4.4.0 (GTK 3.24.52; x86_64-redhat-linux-gnu)
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Post: <mailto:stable@vger.kernel.org>
List-Help: <mailto:stable+help@vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
List-Owner: <mailto:stable+owner@vger.kernel.org>
Precedence: list
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
X-Rspamd-Server: rspamout05
X-Rspamd-Queue-Id: 516D920025
X-Stat-Signature: f5nj7sx98k9oh4bxfyo5p5scwemqf7uh
X-Session-Marker: 726F737465647440676F6F646D69732E6F7267
X-Session-ID: U2FsdGVkX18LlQVdSe/llmR6eyGwqmEkVrZR4ddjRR4=
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=goodmis.org; h=date:from:to:cc:subject:message-id:in-reply-to:references:mime-version:content-type:content-transfer-encoding; s=dkim1; bh=/dw8tqJnozMzOasRMjBMDX6slYfTi2Jc/2gRtK/CL9I=; b=ahDNsSkJIgyJ47fxISJyj+gEjNgiwUDmgrlBLD+hENhW2DNOILvY2gsnFmev84sVcL0c0Repl4b4EsKWrxC5iBq8FyTUAevN4wwW0MxwjaRLZ4kMyXqUk7yuNbcKYvqSlp+4biLlUzb2t0Agar9V7CL8Z5DTteKlEpnqMtJnRgU=
X-HE-Tag: 1794297326-556820
X-HE-Meta: U2FsdGVkX18pQjV0ACwk4c4CChPSTIIp+hTJyfGnnazCMgE1a9tyqV9fv84UzICG1xxPEOFPa2UGIyYg+swwcEmhxlqeBJuETlSvO+Bs1sXQsvPtdI5R/0MJFzt/BqqRkbryIezYm82gI/Xw/dT2SsqoyPOcSUPNOrPFr45EtOyka/h3tx78FYpeY6GsWEfu1Xu0WcAU9hoVrtd2SFE5uPZAw2ut2CTFkh7Ny1OBP4YZh1j93N5BE07t9jgTvHTlsyt9Rja1T5qS98WsxtON/vldoQenOhe/12sSIDEwEZEgPWXBwZm7g4F9j/e0fmhQJCewO6htAoGhTbb9bePS8A5fMHMZyAWK

On Mon, 9 Nov 2026 05:10:37 -0800
Breno Leitao <leitao@debian.org> wrote:

> Hello Steven,
> 
> On Thu, Nov 05, 2026 at 03:57:29PM -0500, Steven Rostedt wrote:
> > Can you try this?
> > 
> > diff --git a/kernel/trace/ring_buffer.c b/kernel/trace/ring_buffer.c
> > index c64e001c3fc0..f0bb2d23d818 100644
> > --- a/kernel/trace/ring_buffer.c
> > +++ b/kernel/trace/ring_buffer.c
> > @@ -3721,6 +3721,14 @@ rb_handle_head_page(struct ring_buffer_per_cpu *cpu_buffer,
> >  		local_sub(rb_page_commit(next_page), &cpu_buffer->entries_bytes);
> >  		local_inc(&cpu_buffer->pages_lost);
> >  
> > +		/*
> > +		 * To prevent a stale head_page from being between
> > +		 * the UPDATE and new HEAD pages, set it here to have
> > +		 * the reader check always find the update before
> > +		 * finding the HEAD page.
> > +		 */
> > +		cpu_buffer->head_page = next_page;
> > +
> >  		if (cpu_buffer->ring_meta)
> >  			rb_update_meta_head(cpu_buffer, next_page);
> >  		/*
> > 
> > We may need to add memory barriers here, but for now, I think this could
> > fix it. As it should prevent the search from ever starting in between the
> > two heads.  
> 
> This seems to be racy as well. Sashiko found the race, and it can be
> reproduced by adding some delays in the code.

Yeah, I'm currently traveling and didn't have time to do a deep dive
into a real fix and decided to be lazy and post the patch and see what
sashiko found ;-)

Thanks for verifying the issue with this "fix" that Sashiko pointed out.

I need to spend a bit of time looking deeper into it to come up with a
real solution.

-- Steve
