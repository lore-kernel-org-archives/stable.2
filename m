Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=216.40.44.15
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1793912262;
	b=lt6rt2qxl4Zxpg7aS8xtV6Nv5hZdnQNhK4sY93Ok22vapMZV8T8LHjpd3M94a1tXrVDQ
	 IpU54qfB4z/T2xzfIiW2CNnaLwuZNS8zdn2fzWpbkPAjcuetLezDpxut6rlYmssw1d6/S
	 jEj/gbFxJCKoWNFGhMvZK8VFQzVVoyNnGxGxtlpOM3PbgCs+OA8Ve9gfKavVziWllekYz
	 0EEvjRGY9iYVep0WW4a80r2Y3dpNAmVyxzVCOmtjfBONbKLlhfawpMOOPK0V56id3ja6L
	 BW1LcsSmCvF+X2xOMNyIKj08LneELh+leul/U57a3Zj4vsFmumVx3jlOaqESgi0R89g==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1793912262;
	h=DMARC-Filter:Received:Received:Date:From:To:Cc:Subject:Message-ID:
	 In-Reply-To:References:X-Mailer:MIME-Version:Content-Type:
	 Content-Transfer-Encoding:X-Rspamd-Server:X-Rspamd-Queue-Id:
	 X-Stat-Signature:X-Spam-Status:X-Session-Marker:X-Session-ID:
	 DKIM-Signature:X-HE-Tag:X-HE-Meta;
	bh=blozq/9ueN/weaanR6fA4D8Rh3f233RzyvTmlM0ePmw=;
	b=JUj3U26/DFkYTCppnh2B/lt2zW4UhNnY1LZpkVthJhxafE5UZkfyOGEA2gowVG4NYCiC
	 MncrPlr+Lg1uIWFhTreCdKQIn0vDzo+u6q0Y/smsOIBWinKHYvKUqDEPTyBHX9UCb1lrk
	 t+95fSy0FRdkZYA8aWD0mzrjyuhwXrDhr+8/7hmQdWkP4VDS2o0EXNt/CTtNnrWYQaFuB
	 OmcXVll2pfdWNpJIi78Rmeo1pQffFz83H2OehVGvRv/pMMpZhCQNMNG26RHN24lBEZfEF
	 TfckC58E0OxHS0bI3URWRi06sigNGamKmcquIjbxxPkgyIv1B+ehpJQR/ld9XoneMJA==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=goodmis.org;
	spf=pass smtp.mailfrom=goodmis.org;
	dkim=pass header.d=goodmis.org header.i=@goodmis.org header.a=rsa-sha256 header.s=dkim1 header.b=It9CE4lv;
	arc=none smtp.remote-ip=216.40.44.15
Received: from relay.hostedemail.com (smtprelay0015.hostedemail.com [216.40.44.15])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4A459606A31B;
	Thu,  5 Nov 2026 20:57:41 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 4A459606A31B
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=goodmis.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=goodmis.org
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key, unprotected) header.d=goodmis.org header.i=@goodmis.org header.a=rsa-sha256 header.s=dkim1 header.b=It9CE4lv
Received: from omf01.hostedemail.com (lb01a-stub [10.200.18.249])
	by unirelay09.hostedemail.com (Postfix) with ESMTP id 32065809DE;
	Thu,  5 Nov 2026 20:57:33 +0000 (UTC)
Received: from [HIDDEN] (Authenticated sender: rostedt@goodmis.org) by omf01.hostedemail.com (Postfix) with ESMTPA id 105FE60010;
	Thu,  5 Nov 2026 20:57:30 +0000 (UTC)
Date: Thu, 5 Nov 2026 15:57:29 -0500
From: Steven Rostedt <rostedt@goodmis.org>
To: Breno Leitao <leitao@debian.org>
Cc: Vincent Donnefort <vdonnefort@google.com>, Masami Hiramatsu
 <mhiramat@kernel.org>, Mathieu Desnoyers <mathieu.desnoyers@efficios.com>,
 linux-kernel@vger.kernel.org, linux-trace-kernel@vger.kernel.org, Steven
 Rostedt <srostedt@redhat.com>, kernel-team@meta.com, stable@vger.kernel.org
Subject: Re: [PATCH v2] ring-buffer: Handle a reader taking the new head in
 rb_handle_head_page()
Message-ID: <20261105155729.0f9c7e4d@gandalf.local.home>
In-Reply-To: <20261105-ring-buffer-head-moved-v2-1-05da40cebccc@debian.org>
References: <20261105-ring-buffer-head-moved-v2-1-05da40cebccc@debian.org>
X-Mailer: Claws Mail 3.20.0git84 (GTK+ 2.24.33; x86_64-pc-linux-gnu)
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
Content-Transfer-Encoding: quoted-printable
X-Rspamd-Server: rspamout07
X-Rspamd-Queue-Id: 105FE60010
X-Stat-Signature: 6qfsq7daudr6yyda71ijchhsf35r7559
X-Session-Marker: 726F737465647440676F6F646D69732E6F7267
X-Session-ID: U2FsdGVkX1+4Bg73+KnseAa5PLXLoS9cef7i0GghHeQ=
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=goodmis.org; h=date:from:to:cc:subject:message-id:in-reply-to:references:mime-version:content-type:content-transfer-encoding; s=dkim1; bh=blozq/9ueN/weaanR6fA4D8Rh3f233RzyvTmlM0ePmw=; b=It9CE4lv+r3Uipb69ba2Za5u/pZmyJcCxz4re8T+sOE3Gr3BgCmIYaCPfb/xnPE+Hk5s3SJi4LaYySSpRaDba3dfBdUlneZzZVNW8dSOxrrMEl/SdIqnbwab2su9RPx8liRflmpcgYY3xXhz07xFWqpE633XIXUncP5bCKDxgTg=
X-HE-Tag: 1793912250-675543
X-HE-Meta: U2FsdGVkX1+Fu2fFcimacg/INWUVEqvFi2pTYqwZUUwVJY5vabqITdCd9b46KkJUUZbTkotHeKC/j+G9Xu2XUfLiisCJ3H75FAC3oA9SLradMCeWENpbOeUcGhRmZ1aP0ZNQ6j/m7ihVPbo52Tt7HIDU0OrPALad9lUlu069cy0xIfq15AkMEQqXFfX7WumiCrKtOE/es19IjC5KmRHM+3kQ98kKgWPDOh8nLESBntDk9vntr35sqSj/ngfXoDcvAH3GQxADfHfI00sFGrfmSKIjl3Oaa5mM1AKkcE2rXE+3xvBTeQSwxUTCycCk1dxtgQAXxB9UIB681YcCEHL+iuqG6/Iqmf8VTEOokcpr0m5rVPDYhJNBD8hY0v092hpKssa5tp3Nfh5sRWwrUs/xVHwmf6y9eRjtEEbbh2Rm520QNA84HdGcCAtV4c2LgkvcZG2OsVFBkk6GTtJcDMSHZC1sNb/IKMdr

On Thu, 05 Nov 2026 03:12:42 -0800
Breno Leitao <leitao@debian.org> wrote:

> The following warning occasionally fires on a KASAN-enabled debug
> kernel in Meta's fleet:
>=20
>   WARNING: kernel/trace/ring_buffer.c:3793 at rb_move_tail+0xf78/0x1050
>   Call trace:
>    rb_move_tail+0xf78/0x1050 (P)
>    __rb_reserve_next+0x648/0xac0
>    ring_buffer_lock_reserve+0xd00/0xf00
>    trace_buffer_lock_reserve+0x28/0x188
>    trace_graph_return+0x220/0x3e8
>    ftrace_return_to_handler+0x2bc/0x5a8
>    return_to_handler+0x20/0x48
>    __arm64_sys_sched_yield+0x18/0x30 (F)
>=20
> rb_handle_head_page() moves the head page forward in two steps: it marks
> the pointer to the old head page UPDATE, then marks the pointer to the
> page after it (new_head) HEAD. The second cmpxchg is assumed to return
> only HEAD or NORMAL, but it can also return RB_PAGE_MOVED:
>=20
>   CPU 0 (writer)                        CPU 1 (reader)
>   ------------------------------------  --------------------------------
>   rb_handle_head_page()
>     old head ptr: HEAD -> UPDATE
>     new_head =3D page after old head
>     <interrupt: nested write>
>       sees UPDATE, marks new_head
>       HEAD and moves the tail page

Wait? The interrupt should never change UPDATE to HEAD.

Something else is broken here. Because only the one that set HEAD to update
is allowed to set it back to NORMAL.

>     </interrupt>
>                                         rb_get_reader_page()
>                                           swaps new_head out for the
>                                           reader page

				This should not happen. The entire point of
				setting the pointer to UPDATE is to prevent
				swaps from happening when any commit is in
				progress.

The rb_handle_head_page() even states this:

	/*
	 * If this was the outer most commit (the one that
	 * changed the original pointer from HEAD to UPDATE),
	 * then it is up to us to reset it to NORMAL.
	 */
	if (type =3D=3D RB_PAGE_HEAD) {
		ret =3D rb_head_page_set_normal(cpu_buffer, next_page,
					      tail_page,
					      RB_PAGE_UPDATE);
		if (RB_WARN_ON(cpu_buffer,
			       ret !=3D RB_PAGE_UPDATE))
			return -1;
	}



>     cmpxchg(new_head|NORMAL ->
>             new_head|HEAD) -> MOVED
>     RB_WARN_ON()
>=20
> A nested writer that interrupts the outer one after the second cmpxchg
> still sees the old head pointer UPDATE and repeats the second step. If
> the reader swaps new_head out just before that cmpxchg, it returns
> RB_PAGE_MOVED too.
>=20
> RB_WARN_ON() permanently disables recording on the whole ring buffer,
> and the outer writer returns without clearing its UPDATE flag.
>=20
> In both cases another writer has already moved the head off the old
> head page, as when the cmpxchg returns HEAD. Treat RB_PAGE_MOVED the
> same way and fall through: the outer writer still clears its UPDATE
> flag, and the caller updates the tail page as usual.
>=20
> Fixes: 77ae365eca89 ("ring-buffer: make lockless")
> Cc: stable@vger.kernel.org
> Signed-off-by: Breno Leitao <leitao@debian.org>
> ---
> Changes in v2:
> - Fall through on RB_PAGE_MOVED instead of returning 1, so a nested
>   writer still moves the tail page (Vincent)
> - Drop the duplicated UPDATE clear (Vincent)
> - Document RB_PAGE_MOVED in the "Valid returns" comment (Vincent)
> - Commit message improvements
> - Link to v1: https://patch.msgid.link/20261102-ring-buffer-head-moved-v1=
-1-165973790be4@debian.org

=46rom your v1 comment:

> A nested writer and a consuming reader can race so that the second
> cmpxchg of a head page move in rb_handle_head_page() returns
> RB_PAGE_MOVED. That trips RB_WARN_ON(), which disables the ring buffer
> and leaves the old head pointer flagged UPDATE. The patch handles the
> return like the RB_PAGE_MOVED case of the first cmpxchg: clear the
> UPDATE flag if this writer set it, and retry.
>=20
> Testing, on arm64 KVM guests under virtme-ng (32 vCPUs, KASAN config,
> next-20261030; kernel/trace/ring_buffer.c is identical in v7.4-rc1):
> - Setup: function_graph tracer filtered to "*sched*", buffer_size_kb=3D7
>   (two pages per CPU), overwrite on, a trace_pipe_raw reader on every
>   CPU plus a trace_pipe reader, and stress-ng --yield/--timer/--futex.

OK, I think I see the issue here. I believe the reader is finding the wrong
head page. Making the buffer really small can make this scenario happen
more often.

The problem is where the reader thinks the "head_page" is. When the reader
swaps out the page, it first looks for the "head_page". The head page
always has flags set in the pointer to it, so before the swap, the reader
will search for the head page.

It starts with the cpu_buffer->head_page pointer which is where it found it
last. It then searches for the head page and when it finds it, it tries the
swap. The swap will only succeed if the pointer is HEAD.

The issue I think you hit was that we have two HEAD pages, when interrupts
come in. That is, we can get a state of:

  --> subbuf --UPDATE--> subbuf --> subbuf --HEAD--> subbuf -->

With the expectation that the reader will never be between those two
pointers and it will always find the UPDATE before it sees the new HEAD. But
since only the reader moves the cpu_buffer->head_page around and the writer
does not, we can have a stale pointer of this:


  --> subbuf --UPDATE--> subbuf --> subbuf --HEAD--> subbuf -->
                                      ^
                                      |
                            cpu_buffer->head_page

And when the reader looks for the new head, it will find this:


  --> subbuf --UPDATE--> subbuf --> subbuf --HEAD--> subbuf -->
                                                       ^
                                                       |
                                             cpu_buffer->head_page

And possibly swap out the head page before it is allowed to.

To prevent this, I believe having the writer move this pointer will keep it
from being stale and ending up between the two.

Can you try this?

diff --git a/kernel/trace/ring_buffer.c b/kernel/trace/ring_buffer.c
index c64e001c3fc0..f0bb2d23d818 100644
--- a/kernel/trace/ring_buffer.c
+++ b/kernel/trace/ring_buffer.c
@@ -3721,6 +3721,14 @@ rb_handle_head_page(struct ring_buffer_per_cpu *cpu_=
buffer,
 		local_sub(rb_page_commit(next_page), &cpu_buffer->entries_bytes);
 		local_inc(&cpu_buffer->pages_lost);
=20
+		/*
+		 * To prevent a stale head_page from being between
+		 * the UPDATE and new HEAD pages, set it here to have
+		 * the reader check always find the update before
+		 * finding the HEAD page.
+		 */
+		cpu_buffer->head_page =3D next_page;
+
 		if (cpu_buffer->ring_meta)
 			rb_update_meta_head(cpu_buffer, next_page);
 		/*

We may need to add memory barriers here, but for now, I think this could
fix it. As it should prevent the search from ever starting in between the
two heads.

-- Steve

