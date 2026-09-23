Received: from mail-dy2-f12.google.com (mail-dy2-f12.google.com [74.125.229.12])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DCE5A233149
	for <stable@vger.kernel.org>; Wed, 23 Sep 2026 02:57:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=74.125.229.12
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1790132222; cv=pass; b=pkrDs6DWyZ6hmwHYA3e3E2k1xSSxOpMxf4yvSUHwGfPDnHvy9rSD2PH5FqsSl/plfju+X00Oiq98Kv9KrcdxQe9zmDGYVtvAoQAQM5koLFzEuxyLhIXcNxH5C8DYWrepFbgmUe732Bbrrl+zucdpZ5/YxwVRcd4S2JfgOCJ7NgQ=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1790132222; c=relaxed/simple;
	bh=8UDl0UsNZXOhetgbFCY+EYL1CkOSiSWB+iFE1wcb9D0=;
	h=In-Reply-To:References:MIME-Version:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=QRcLsfeHe18d4Srykqh3KfbkRnkxm8meDQqhdv+Z11IqmRXlhqz9OkfTSEDte14H5G9xXViu8JotkkI5gDVYsKXlITfGDJfZn4al3DlfEMVXA9ru93eX1Fx53chba71JsihFbzUM0EBcyGpdh8FGrNjMosToF1bQt8IU6uoKuTM=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=cGo313f3; arc=pass smtp.client-ip=74.125.229.12
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="cGo313f3"
Received: by mail-dy2-f12.google.com with SMTP id 5a478bee46e88-3396cec93b6so498791eec.3
        for <stable@vger.kernel.org>; Tue, 22 Sep 2026 19:57:00 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1790132220; cv=none;
        d=google.com; s=arc-20260327;
        b=sr0Sxi58Kq1HtPkhC9YkhPXautJ9tzlfs76JMS/ZMaq5BSTvT+j3/dkHn6PLoPFj36
         zVGLW9mpyMTvLJ0a3fhRcqzmhKUr8zbeguh+4AE3ZT8A1O2D9k3Lnw9r06q4GNc2h9I+
         1YYcagDSJ9ilxTPNJ/02zf1AM68kJhrxOAeV0C/baaMzjOV9eWT/rOo0/t6+R+7Xt7vf
         JTTMeysksKEqn8XmhsoTMPFtPtYqem4hTHtYu3vJjBD8C/8JJHe/eCuDB37MvrbZtTZB
         6B+k+1z2HI5reQtubGoOmxHrVfaKS/qGm9Rs+NOSAGxQkAC8/zuw3kcmw3RRgh2Msp9j
         4PTw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20260327;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :mime-version:references:in-reply-to:dkim-signature;
        bh=8UDl0UsNZXOhetgbFCY+EYL1CkOSiSWB+iFE1wcb9D0=;
        fh=RikvGLUabmp63ZtfvDEraaAg/UoIpcKx8JEU9Y3n0p0=;
        b=WwjfAlgROVnz8GwZn5Ka5mbvdIWUjcFoNLdtbt7HdnIJLgN5rXH2uaJDpwAqgSfd1G
         AGvuRsvLbNSnjb3lbZCNRPouiXwnQWZMtpANdkMlzLqhPAnHYr38DJ4o8MKTKafrSSI4
         NMVSVEaxkqE+dFynjVc9olgcsJItHFIHq9IsNLO40AW+JLtWkZc55A6Ns7DAibZW3usg
         MYeSBXQ3Y99dWmidveVA60OcP7QIq6+RPUrdXTGBGka2NiziVUyWj0p5miCZ5MpoK7c2
         EV5qSwadsew4gLznsQ50giaP+BSmNcHekJfhSeeX3JpcBDRO0QegccU82fAJxNoQNxDz
         Gp2w==;
        darn=vger.kernel.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1790132220; x=1790737020; darn=vger.kernel.org;
        h=content-transfer-encoding:content-type:cc:to:subject:message-id
         :date:from:mime-version:references:in-reply-to:from:to:cc:subject
         :date:message-id:reply-to:content-type;
        bh=8UDl0UsNZXOhetgbFCY+EYL1CkOSiSWB+iFE1wcb9D0=;
        b=cGo313f39wjW8l8JqWpFvfifnbViY0341h/pKGO18cl2hVYaDqVJxSjTZ1aAVCqT2G
         yek2nuu2peYhZiRmcgcTPLM9sN5OYkVu8d8JFBu6+q3LoAeht3AXrpCNkN9qfgh4jpXd
         4AlpleXrZChXRSREZ2Kxt8cfrFZLGKUEobjRxGGJNVK+HIiIjBgmJ1lBs/tEu0omx5q6
         hc5lvGy2x3kf0vEYWhiuKwWLyllcl+1Wz6wJdB7uHQAA3t10EXu7EOmiel/vbOdTvRjU
         SEBf6kZ4JEMJAFZqZ2EQVUcBb1gyFRTjoP5NGcI2uU8lycRR6NijSWofKKgzqvJLeLsH
         923w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1790132220; x=1790737020;
        h=content-transfer-encoding:content-type:cc:to:subject:message-id
         :date:from:mime-version:references:in-reply-to:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=8UDl0UsNZXOhetgbFCY+EYL1CkOSiSWB+iFE1wcb9D0=;
        b=PPPWY2Jsui7VfP1djk71YCqSdR1Hof7+Pc8LqRkZGBATVUwbU2gFbghwHDFaqtyYwt
         rk1vSl4Nf+U+GwPJyjgv2O8tr10YVjUVpwQSb70tkZjoSYxUSrN4lOtRQVzmxFJQfkM1
         aCP33Jwcm+aGdcKzMImTuKDyzR8+TUCp5guHfg/FwlrOjbtMs2NrFNSuXk/tG4IFftue
         fu8jOzrRF/j+qvR4aVop3dMgZTnOpO7DT/BgCgHVFlLOzOtH8xCtADuSTvnkkxXPYV1Z
         QyZeWki8c27TNweUGOvVTXiLPUN6JO+ydYg6REZHamnV/U6oBpm7VylG8srT1enR3tI5
         cxOw==
X-Forwarded-Encrypted: i=1; AKwUvBwTOOYlqE1f0Qe1W+nQi4vdQIbOWidmD/E3UllMKaRbW3+khgtiyUlGXMfK2tI1u/eLlIDW+wM=@vger.kernel.org
X-Gm-Message-State: AFuF++nrG4inAP0oBCOEFD08pU78px9KuruElTyiKx3Zr8V+px1gBUwN
	EzIct4RRv8D6lsqxWvlFax7EdlCaj/60G3AuS3jxx0rIgv7upyGam7FQszXwQz/hhX1oUuq8Ewd
	2/x9Q5Hd2mboom0ymGvL3UDNAoeMRTHOGkg+/
X-Gm-Gg: AYBFou0EDF9zeqonbYdwX5YCgkQ8AF17halal5JJnoA7GVsQ4DpsCa9iDNLt1Hm4PXE
	dv7/bTiqvWgB+n1Ii5GBZRwjFqTkpEIFt9lndWfA+7Zh5glhQ7XfzHXFRyY7e8k6Wl9py091/qG
	CA/CfD4Iv5QJSvENO5lUg25PSaduD92SQfjf99PD7j6cEdk6HWfNApy+gLRW37781juJR091x9j
	tyG2P7UB5OsoJgwIqDBoAF/YfOL5WewGG49PH+bAnKHPPwBgLyFbKb3QoCTwhuEEZxj3WHOn/38
	UfZZvUriXzy0fxLqe8DvEWSJxIzVcRjUd4FvaXjCHh9wGC3jeInS8Q==
X-Received: by 2002:a05:7301:71a8:b0:33b:ea8c:811b with SMTP id
 5a478bee46e88-33e8b88d912mr1165068eec.5.1790132219742; Tue, 22 Sep 2026
 19:56:59 -0700 (PDT)
Received: from 77377267392 named unknown by gmailapi.google.com with HTTPREST;
 Tue, 22 Sep 2026 19:56:58 -0700
Received: from 77377267392 named unknown by gmailapi.google.com with HTTPREST;
 Tue, 22 Sep 2026 19:56:58 -0700
In-Reply-To: <ap6mHnPJKKJFapsO@black.igk.intel.com>
References: <20260903030356.58597-1-ivanrwcm25@gmail.com> <20260903232121.271776-1-ivanrwcm25@gmail.com>
 <ap6mHnPJKKJFapsO@black.igk.intel.com>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
From: =?UTF-8?Q?Iv=C3=A1n_Rodriguez?= <ivanrwcm25@gmail.com>
Date: Tue, 22 Sep 2026 19:56:58 -0700
X-Gm-Features: AclHuK9gOEvYhNFnYgsJAMnp-CmaWTD9ecsuEllOd8FEpYc9E0hTm7bR2mR3W0s
Message-ID: <CAO4EdiSv-hqc4WMoTa9F-ODs+TCzDG8ZEmAvx0z55wGhLdFJCA@mail.gmail.com>
Subject: Re: [PATCH v2] usb: typec: ucsi: acpi: fix use-after-free on driver removal
To: Heikki Krogerus <heikki.krogerus@linux.intel.com>, 
	Greg Kroah-Hartman <gregkh@linuxfoundation.org>
Cc: Fan Wu <fanwu01@zju.edu.cn>, Wei Huang <huangwei@kylinos.cn>, linux-usb@vger.kernel.org, 
	linux-kernel@vger.kernel.org, stable@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

Hi,

Little ping on this patch. It has received RB tags from Wei Huang and
Heikki Krogerus, and I don't believe there are any outstanding
comments.

Please let me know if anything else is needed from my side.

Thanks,

Iv=C3=A1n

On Mon, 7 Sep 2026 13:55:10 +0200, Heikki Krogerus
<heikki.krogerus@linux.intel.com> wrote:
> On Thu, Sep 03, 2026 at 08:21:21PM -0300, Iv=C3=A1n Ezequiel Rodriguez wr=
ote:
> > ucsi_acpi_remove() destroys the UCSI instance before removing the ACPI
> > notify handler:
> >
> > ucsi_unregister(ua->ucsi);
> > ucsi_destroy(ua->ucsi);
> >
> > acpi_remove_notify_handler(...);
> >
> > ucsi_acpi_notify() dereferences ua->ucsi, so a notify arriving after
> > ucsi_destroy() uses freed memory:
> >
> > CPU0 CPU1
> > ---- ----
> > ucsi_acpi_remove()
> > ucsi_unregister()
> > ucsi_destroy()
> > kfree(ucsi)
> > ucsi_acpi_notify()
> > ua->ucsi->ops->read_cci() <-- UAF
> >
> > Simply removing the handler before ucsi_unregister() is not correct
> > either. ucsi_unregister() drains work that needs the notify path to mak=
e
> > progress: ucsi_handle_connector_change() issues GET_CONNECTOR_STATUS an=
d
> > ucsi_unregister_port() drains and destroys con->wq, and those commands
> > block in wait_for_completion_timeout() on ucsi->complete for up to
> > UCSI_TIMEOUT_MS. That completion is signalled only from
> > ucsi_notify_common(), i.e. from the notify handler. Tearing the handler
> > down first would leave cancel_work_sync() and destroy_workqueue()
> > waiting the full timeout for a completion that can no longer arrive.
> >
> > Moving the removal between ucsi_unregister() and ucsi_destroy() is not
> > sufficient on its own: at that point the connector array has already
> > been freed, so a late notify reaching ucsi_connector_change() would
> > queue work on a freed connector.
> >
> > Teardown therefore needs two properties at the same time: no new
> > connector changes once connectors start going away, but the notify path
> > still available for command and acknowledge completions until that work
> > has been drained. Whether the PPM actually produces those completions i=
s
> > a firmware matter; what changes here is that the path able to deliver
> > them is no longer torn down first.
> >
> > Introduce a quiescing state, local to the ACPI backend, that provides
> > both. ucsi_acpi_remove() sets ua->quiescing under ua->notify_lock befor=
e
> > calling ucsi_unregister(); ucsi_acpi_notify() takes the same lock and,
> > when quiescing, reduces the CCI to the bits that ucsi_notify_common()
> > consumes for completions. ucsi_notify_common() looks at exactly
> > UCSI_CCI_BUSY, the connector number, UCSI_CCI_ACK_COMPLETE and
> > UCSI_CCI_COMMAND_COMPLETE; keeping the first and the last two preserves
> > the completion and bogus-data behaviour unchanged, while clearing the
> > connector number makes ucsi_connector_change() unreachable. The CCI tha=
t
> > the command path inspects is unaffected, because
> > ucsi_sync_control_common() re-reads it from the interface after the
> > completion.
> >
> > The resulting order is:
> >
> > mutex_lock(&ua->notify_lock);
> > ua->quiescing =3D true; -- no new connector work
> > mutex_unlock(&ua->notify_lock);
> >
> > ucsi_unregister(); -- drains work, notify path still
> > available for completions
> >
> > acpi_remove_notify_handler(); -- unlinks, then flushes
> > kacpi_notify_wq
> >
> > ucsi_destroy(); -- no notify can be in flight
> >
> > which gives the following happens-before chain:
> >
> > - A notify that acquires notify_lock before ucsi_acpi_remove() runs to
> > completion while remove() waits on the lock, so any schedule_work() it
> > performs happens before ucsi_unregister() starts cancelling.
> > - A notify that acquires notify_lock after remove() released it observe=
s
> > quiescing =3D=3D true, so it cannot reach ucsi_connector_change() and
> > cannot touch ucsi->connector.
> > - acpi_remove_notify_handler() unlinks the handler and then calls
> > acpi_os_wait_events_complete(), which flushes kacpi_notify_wq, so a
> > notify already dispatched on another CPU has returned before
> > ucsi_destroy() frees the instance.
> >
> > notify_lock is never held across ucsi_unregister() or
> > acpi_remove_notify_handler(); holding it there would deadlock against
> > the notify work those calls wait for. It is only ever taken as a leaf:
> > ucsi_notify_common() and ucsi_connector_change() take no locks, so it
> > cannot invert against ucsi->ppm_lock or con->lock, which the drained
> > work holds while waiting for the completion. The handler runs from
> > kacpi_notify_wq via acpi_os_execute(OSL_NOTIFY_HANDLER, ...), i.e. in
> > process context, so sleeping on the mutex is allowed.
> >
> > The probe error path already removes the handler before ucsi_destroy()
> > and is left unchanged.
> >
> > Fixes: f56de278e8ec ("usb: typec: ucsi: acpi: Move to the new API")
> > Cc: stable@vger.kernel.org
> > Reported-by: Fan Wu <fanwu01@zju.edu.cn>
> > Link: https://lore.kernel.org/all/20260718021142.3146566-1-fanwu01@zju.=
edu.cn/
> > Signed-off-by: Iv=C3=A1n Ezequiel Rodriguez <ivanrwcm25@gmail.com>
>
> You could have used guard(mutex) in ucsi_acpi_notify(), but that's
> not a huge problem.
>
> Reviewed-by: Heikki Krogerus <heikki.krogerus@linux.intel.com>
>
> > ---
> >
> > Notes:
> > Hi Heikki, Greg,
> >
> > v2 is a rewrite rather than an incremental fixup. v1 moved
> > acpi_remove_notify_handler() ahead of the teardown, and that ordering i=
s
> > wrong for the reason Fan Wu had already documented in [1]: the work tha=
t
> > ucsi_unregister() drains can be waiting for a completion that only the
> > notify path delivers. This version keeps the handler installed across
> > ucsi_unregister() and adds an ACPI-local quiescing state instead.
> >
> > Wei Huang asked on v1 whether acpi_remove_notify_handler() waits for a
> > callback that already entered on another CPU. It does: for
> > ACPI_DEVICE_NOTIFY it calls acpi_os_wait_events_complete() after
> > unlinking the handler (drivers/acpi/acpica/evxface.c), that flushes
> > kacpi_notify_wq (drivers/acpi/osl.c), and device-notify dispatch runs o=
n
> > that same workqueue through acpi_os_execute(OSL_NOTIFY_HANDLER, ...).
> > So the raw call is already the barrier, and acpi_dev_remove_notify_hand=
ler()
> > would only add a second flush. Chasing that question is what surfaced t=
he
> > harder half of the problem, which is what this version is about.
> >
> > On [1]: that patch kept the handler installed across ucsi_unregister()
> > for exactly the right reason, and this version preserves that property.
> > What it did not cover is the window you described in that thread, where=
 a
> > notify arriving after ucsi_unregister() has freed the connectors still
> > reaches ucsi_connector_change(). You also asked to keep the solution
> > inside ucsi_acpi.c rather than redesigning the core, which is what this
> > does.
> >
> > Changes since v1:
> > - Do not remove the notify handler before ucsi_unregister().
> > - Add the quiescing state, so connector changes stop while the notify
> > path stays available for completions.
> > - Drop the ucsi.c changes from v1 (ntfy =3D 0, connector =3D NULL, cap =
=3D 0).
> > I could not show they were needed for the other backends, and they do
> > not belong in the same patch as the ACPI lifetime fix.
> > - Correct the Fixes: tag. v1 pointed at 8243edf44152, which added the
> > driver; the current ordering came from f56de278e8ec.
> > - Credit Fan Wu, who reported the underlying use-after-free first.
> > - Use mutex_init() rather than devm_mutex_init(), which only appeared i=
n
> > 4cd47222e435 (2024) and would be a needlessly modern dependency for a
> > fix tagged for stable from a 2019 commit.
> >
> > Testing
> >
> > I have no machine that exercises the UCSI ACPI path, so this was tested
> > with a software PPM backend that drives the real UCSI core
> > (ucsi_create/ucsi_register/ucsi_unregister/ucsi_destroy/
> > ucsi_notify_common) and reproduces the ACPI notify protocol, including
> > the deferral to a percpu workqueue. All three candidate teardown
> > orderings were run against it: the one from v1, the one from [1] and th=
e
> > one in this patch. v7.3-rc2, KASAN + lockdep + PROVE_LOCKING +
> > DEBUG_MUTEXES, QEMU, oops=3Dpanic.
> >
> > Each case below parks a connector work in wait_for_completion_timeout()
> > before teardown starts, and asserts that precondition rather than
> > assuming it.
> >
> > teardown ordering result
> > ------------------------------------ ----------------------------
> > quiesce, unregister, unlink (this) 148 ms, clean, with a late
> > connector notify fired after
> > ucsi_unregister() returned
> > unlink, unregister (v1) 10595 ms stall
> > unregister, unlink (as in [1]), a KASAN slab-use-after-free in
> > connector notify landing in the queue_work_on(), then a GP
> > window fault in the kworker that
> > picked up the freed work
> > nothing in flight (this) 146 ms, clean
> >
> > Repeated with the teardown starting while ucsi_init_work() is still
> > running, so that cancel_delayed_work_sync(&ucsi->work) has to drain an
> > init command parked on the completion: this patch takes 2299 ms and
> > completes cleanly, of which 1500 ms is the injected command delay, whil=
e
> > the v1 ordering stalls for 10089 ms and the init gives up with
> > -ETIMEDOUT.
> >
> > Two deterministic checks of the properties the patch claims:
> >
> > - CCI mask. A single CCI carrying both connector 1 and COMMAND_COMPLETE
> > (0x80000002) is delivered while quiescing: the completion is signalled
> > and EVENT_PENDING stays clear, i.e. ucsi_connector_change() is not
> > reached. The same CCI with quiescing off sets EVENT_PENDING, so the
> > check is sensitive to the path it claims to block.
> >
> > - notify_lock as a barrier. A notify that has entered the handler is
> > held inside it for 1200 ms; the store of quiescing in the teardown
> > path blocks for 1215 ms behind it. This is what makes "a notify that
> > started before teardown finishes its schedule_work() before
> > ucsi_unregister() begins cancelling" an ordering guarantee rather
> > than a likelihood.
> >
> > Soak: 1000 teardown cycles with four threads hammering the notify path
> > concurrently with the quiesce sequence, repeated at 1, 2, 4 and 8 vCPUs=
,
> > so 4000 teardowns in total. No stall, no KASAN report and no lockdep
> > splat in any configuration. A separate KCSAN build ran 200 of those
> > cycles at 4 vCPUs with no data race reported in any UCSI path.
> >
> > What this does not cover: no real ACPI hardware, so the ACPICA drain
> > described above is established by reading evxface.c and osl.c rather
> > than by execution; and the LG gram quirk path is untouched and
> > unexercised.
> >
> > The harness is not part of this patch. I can post it separately if it
> > is useful.
> >
> > [1] https://lore.kernel.org/all/20260718021142.3146566-1-fanwu01@zju.ed=
u.cn/
> >
> > drivers/usb/typec/ucsi/ucsi_acpi.c | 53 ++++++++++++++++++++++++++++--
> > 1 file changed, 51 insertions(+), 2 deletions(-)
> >
> > diff --git a/drivers/usb/typec/ucsi/ucsi_acpi.c b/drivers/usb/typec/ucs=
i/ucsi_acpi.c
> > index 18286d3e9cc5..61bba7625d17 100644
> > --- a/drivers/usb/typec/ucsi/ucsi_acpi.c
> > +++ b/drivers/usb/typec/ucsi/ucsi_acpi.c
> > @@ -24,6 +24,15 @@ struct ucsi_acpi {
> > bool check_bogus_event;
> > guid_t guid;
> > u64 cmd;
> > + /*
> > + * notify_lock serialises ucsi_acpi_notify() against the start of
> > + * teardown, so that @quiescing is observed by every notify that has
> > + * not yet run. It must not be held across ucsi_unregister(), whose
> > + * drained work may depend on the notify path, nor across
> > + * acpi_remove_notify_handler(), which flushes notify work.
> > + */
> > + struct mutex notify_lock;
> > + bool quiescing;
> > };
> >
> > static int ucsi_acpi_dsm(struct ucsi_acpi *ua, int func)
> > @@ -179,11 +188,31 @@ static void ucsi_acpi_notify(acpi_handle handle, =
u32 event, void *data)
> > u32 cci;
> > int ret;
> >
> > + mutex_lock(&ua->notify_lock);
> > +
> > ret =3D ua->ucsi->ops->read_cci(ua->ucsi, &cci);
> > if (ret)
> > - return;
> > + goto out_unlock;
> > +
> > + /*
> > + * Once teardown has started the connectors are being unregistered and
> > + * freed, so a connector change must not be reported any more. Command
> > + * and acknowledge completions must still be able to reach the core:
> > + * ucsi_unregister() drains connector and partner work that can be
> > + * blocked in wait_for_completion_timeout() on ucsi->complete, and tha=
t
> > + * completion is only signalled from here. Keep exactly the bits that
> > + * ucsi_notify_common() needs for that, which drops the connector
> > + * number and with it the path to ucsi_connector_change(). The busy
> > + * indicator is kept so that bogus CCI data is still ignored.
> > + */
> > + if (ua->quiescing)
> > + cci &=3D UCSI_CCI_BUSY | UCSI_CCI_ACK_COMPLETE |
> > + UCSI_CCI_COMMAND_COMPLETE;
> >
> > ucsi_notify_common(ua->ucsi, cci);
> > +
> > +out_unlock:
> > + mutex_unlock(&ua->notify_lock);
> > }
> >
> > static int ucsi_acpi_probe(struct platform_device *pdev)
> > @@ -219,6 +248,8 @@ static int ucsi_acpi_probe(struct platform_device *=
pdev)
> >
> > ua->dev =3D &pdev->dev;
> >
> > + mutex_init(&ua->notify_lock);
> > +
> > id =3D dmi_first_match(ucsi_acpi_quirks);
> > if (id)
> > ops =3D id->driver_data;
> > @@ -256,11 +287,29 @@ static void ucsi_acpi_remove(struct platform_devi=
ce *pdev)
> > {
> > struct ucsi_acpi *ua =3D platform_get_drvdata(pdev);
> >
> > + /*
> > + * Stop reporting connector changes, but keep the notify handler
> > + * installed so that the work ucsi_unregister() drains can still be
> > + * reached by the command completions it may be waiting for. Any notif=
y
> > + * that already passed this point runs to completion first, so no
> > + * connector work can be queued once ucsi_unregister() starts.
> > + */
> > + mutex_lock(&ua->notify_lock);
> > + ua->quiescing =3D true;
> > + mutex_unlock(&ua->notify_lock);
> > +
> > ucsi_unregister(ua->ucsi);
> > - ucsi_destroy(ua->ucsi);
> >
> > + /*
> > + * Now that no work is left to serve, drop the handler. This unlinks i=
t
> > + * and then calls acpi_os_wait_events_complete(), which flushes
> > + * kacpi_notify_wq, so a notify running on another CPU has returned
> > + * before ucsi_destroy() frees the instance that it dereferences.
> > + */
> > acpi_remove_notify_handler(ACPI_HANDLE(&pdev->dev), ACPI_DEVICE_NOTIFY,
> > ucsi_acpi_notify);
> > +
> > + ucsi_destroy(ua->ucsi);
> > }
> >
> > static int ucsi_acpi_suspend(struct device *dev)
> > --
> > 2.43.0
>
> --
> heikki
