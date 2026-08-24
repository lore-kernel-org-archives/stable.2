Received: from mail-24424.protonmail.ch (mail-24424.protonmail.ch [109.224.244.24])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0045A49365C;
	Mon, 24 Aug 2026 11:00:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=109.224.244.24
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1787569228; cv=none; b=DM1hDL/q1MaL16jQRP49BAKm9gqOI6+GZSR2I9e9LsLei7XHZXq1SEmAMwt4QwR7I66w09PzEnd2yhHnzejkr8hWTe6jai9UT9l/twCkwl99cC7kIOqhT/qROtVIQ/RVj23kU0vSJ64ruRyIUcog+ncIfpzi8OV8qzCR5tmtGUU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1787569228; c=relaxed/simple;
	bh=AE/GYNDmPO64JSgx6/zT48l/9P6AenBcx8poL6MX2Q4=;
	h=Date:To:From:Cc:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=lbp76DlBgCwjSeizX2w0kGlCoGvS3lWoqjATq9vmxf/92toyY+66yTsWXvaOqQPK/O1edU2ES7N08kx9mcDgzCLj9wZk1UyrD3VW/3FKK7CM3/rMSAtD9gB6OI7PRc9SrQ56ciGXXfcFKr8WFBdKwFvT++JxSbAWFdvx3MXoZ2k=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=proton.me; spf=pass smtp.mailfrom=proton.me; dkim=pass (2048-bit key) header.d=proton.me header.i=@proton.me header.b=N6FkMMsG; arc=none smtp.client-ip=109.224.244.24
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=proton.me
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=proton.me
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=proton.me header.i=@proton.me header.b="N6FkMMsG"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=proton.me;
	s=protonmail; t=1787569219; x=1787828419;
	bh=Z8/gyZvq1K/bBhlZ6sGYTHpFeJ3lOrpPEPV9gdmTfXA=;
	h=Date:To:From:Cc:Subject:Message-ID:In-Reply-To:References:
	 Feedback-ID:From:To:Cc:Date:Subject:Reply-To:Feedback-ID:
	 Message-ID:BIMI-Selector;
	b=N6FkMMsGFmSwNpXYvMYTch+rKN9KJQFrlJ7FAXQz4U3kmTvmGvoPijT8TTAMYEZZW
	 R0EJhHLeYIA4mNYD3OP9iIMhPDHWKeRKRhqGxbl6U8J+SN8d+wy1e9wlFJ4r98gmnk
	 +b5Aguzw12U0Um/uaw5g5wRsi24bmm8oeI9+fOzLku0PJO4cCdRLT340+AMqR+abfc
	 hIy9MzTLgr6OJWO5BKXzdBM449LIVfUMMxiKWyXWoUoz6spHv7BlmBncqFiAYLUeBY
	 oyCQy6zkZ8j0A50jFNXUX9NXNkrPR78vFCH6blH5DKp5nsrMLohAl4/KnISLr40bDg
	 OLJbw83SRRUVw==
Date: Mon, 24 Aug 2026 11:00:15 +0000
To: "gregkh@linuxfoundation.org" <gregkh@linuxfoundation.org>
From: nirbhayykumarr@proton.me
Cc: "arnd@arndb.de" <arnd@arndb.de>, "alexander.usyskin@intel.com" <alexander.usyskin@intel.com>, "w@1wt.eu" <w@1wt.eu>, "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>, "stable@vger.kernel.org" <stable@vger.kernel.org>
Subject: Re: [PATCH v3] misc: mei: fix race condition between client teardown and read completion
Message-ID: <nAKQ1OCohroK1IDDGOCNsI3rhxnpOt-dQp4PRQUgdPCJ13DjUIXHdp_mmdu_juNtAn5AgqR-hkQnMY0vllSuVDRyIGyzk-K-FOgOUmC8h1o=@proton.me>
In-Reply-To: <2026082401-spoken-nag-acf7@gregkh>
References: <2oKLyY1tm4g6xwyvmh7loQ1t1EBr1rNjMzfiXN-b0q8BbO_4vjW0xcxR_aTEielTWx5ma4f1NCO4Y5LG98PRKseN6WLUbnXR9zGtcQVR9zY=@proton.me> <2026082401-spoken-nag-acf7@gregkh>
Feedback-ID: 172828574:user:proton
X-Pm-Message-ID: 09f3c15f341ef96f7a43e7b2fd37cb89fbd0cfa7
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable

Hi Greg,

To answer your first question directly: Yes, I used an LLM to help polish m=
y changelog and commit description, and learn the strict kernel mailing lis=
t etiquette. This is my very first kernel contribution, and I used it to he=
lp navigate the patching process. However, the core technical work, finding=
 the bug, root causing it, writing the C patch, and testing it is entirely =
my own.

Regarding how this was found: This came out of a broader research project c=
entered around systematic fuzzing and interface testing of /dev/mei0. As pa=
rt of testing various subsystem boundaries, I wrote a custom multi-threaded=
 C stress utility that rapidly hammers the driver, more specifically, one t=
hread streaming asynchronous MKHI requests while a second thread concurrent=
ly drives rapid open/close/reconnect cycles.

During this stress test, dmesg caught the WARNING at drivers/misc/mei/clien=
t.c:698 (mei_cl_unlink) because cl->rd_completed was not empty. Then I trac=
ed the driver source code in drivers/misc/mei/ to understand why rd_complet=
ed was non-empty at unlink time: mei_release() called mei_cl_flush_queues()=
 before mei_cl_disconnect(), but mei_cl_disconnect() temporarily drops dev-=
>device_lock while waiting for firmware response. During that lock-drop win=
dow, deferred read completions on the interrupt thread re-populated cl->rd_=
completed before mei_cl_unlink() ran. Moving the queue flush inside mei_cl_=
unlink() under the link state lock resolved the race and silenced the WARN_=
ON.

And my colleague simply helped me sanity check the trace to ensure it was a=
 legitimate kernel driver bug and not a misunderstanding on my end before r=
eporting it.

Thanks,
Nirbhay Kumar


On Monday, August 24th, 2026 at 3:10 PM, gregkh@linuxfoundation.org <gregkh=
@linuxfoundation.org> wrote:

> On Mon, Aug 24, 2026 at 09:32:27AM +0000, nirbhayykumarr@proton.me wrote:
> > In mei_release(), a host client is torn down upon close(). During this
> > teardown sequence, mei_cl_disconnect() is invoked, which releases
> > dev->device_lock while waiting for the firmware response.
> >
> > If an in-flight read request was previously submitted, an incoming
> > completion interrupt processed concurrently by the MEI interrupt
> > handler can add a completed callback into cl->rd_completed via
> > mei_cl_add_rd_completed().
> >
> > Because mei_cl_flush_queues(cl, NULL) was invoked before mei_cl_unlink(=
cl),
> > an incoming completion callback can slip into cl->rd_completed after th=
e
> > flush has completed but before the client is unlinked from dev->file_li=
st.
> > When mei_cl_unlink() is subsequently called, the invariant check at
> > drivers/misc/mei/client.c:698 triggers:
> >
> >   WARN_ON(!list_empty(&cl->rd_completed) ||
> >           !list_empty(&cl->rd_pending) ||
> >           !list_empty(&cl->link));
> >
> > Call trace:
> >   WARNING: CPU: 2 PID: 5056 at drivers/misc/mei/client.c:698 mei_cl_unl=
ink+0xaa/0x140 [mei]
> >   RIP: 0010:mei_cl_unlink+0xaa/0x140 [mei]
> >   Call Trace:
> >    <TASK>
> >    mei_release+0x202/0x270 [mei]
> >    __fput+0x105/0x2e0
> >    __x64_sys_close+0x90/0x140
> >    do_syscall_64+0xaa/0x660
> >    entry_SYSCALL_64_after_hwframe+0x77/0x7f
> >    </TASK>
> >
> > Immediately following mei_cl_unlink(), mei_release() calls kfree(cl).
> > If any remaining or deferred callback references the freed client, a
> > use-after-free occurs.
> >
> > Fix this by flushing queues after unlinking the client from dev->file_l=
ist
> > inside mei_cl_unlink(), preventing concurrent IRQ completions from
> > populating the client's completed queue during teardown.
> >
> > Fixes: f35fe5f47ed0 ("mei: add a vtag map for each client")
> > Signed-off-by: Nirbhay Kumar <nirbhayykumarr@proton.me>
> > Cc: stable@vger.kernel.org
> > ---
> > v3:
> >  - Removed non-standard Helped-by tags.
> >  - Omitted Assisted-by: No AI or co-authors were used. The "we" in my o=
riginal report referred to a colleague who merely verified and confirmed th=
e bug.
>=20
> Just to confirm, the original bug report, and test program, and this
> hugely long changelog were not generated by any sort of LLM at all?
>=20
> So how was this issue found?  What tool was used to poke around on the
> mei codebase?
>=20
> thanks,
>=20
> greg k-h
> 
