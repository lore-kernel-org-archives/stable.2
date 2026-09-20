Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 593AD2D7DF1;
	Sun, 20 Sep 2026 18:51:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1789930306; cv=none; b=Ec0CXmXBmlsUh6+S+t5eL/IKmMxoROS1K/P3uS3P50iZQBIjBAVNP9tw2VyBIckdRaqR27xarJt7Uz3L8VqZsE29hGprtp2KHVWCCbtwUZSEpSdzzDXKaLzYQgLXLyvpSjlkF3mYpagxMJzoFa2UhKN1QlXoX4/jt5EeMgp/vnc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1789930306; c=relaxed/simple;
	bh=yupjcFiF888qQ6s/RhFsq4GEqxV6BBecFU93bLoqefs=;
	h=Message-ID:Subject:From:To:Cc:Date:In-Reply-To:References:
	 Content-Type:MIME-Version; b=Mao/NR5LtWRlBxiTrWsVhoP5+9esBiVG9+wEOv6NK0R7e1Dr9xjFc6tE87/YVUyC3HqhtNj/KAQ4HsuVjmNcfM5c1ZY8cKfSaiA1rlJNtZEh2XWU0K0kbfoBP94lE4qaOQBXmMgoSCVu6JTbqX7EroEFCiwGiPO689CPpbLFTV8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=gQVP0YCx; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="gQVP0YCx"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 14A511F000FF;
	Sun, 20 Sep 2026 18:51:44 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1789930304;
	bh=l8wyK5rGQiilit/7Eoem6kt/ItoMqeWVRQd+2zBDtHk=;
	h=Subject:From:To:Cc:Date:In-Reply-To:References;
	b=gQVP0YCxLHR8Ik+3LiwgnLxA+gJN3yCOAz+EfuMM2ud8+7tabxUX/RZ+M1eAF76Zz
	 amgIntvwY2lGqQEW3Yk/2OnNhq7S0MEc21OCg8+aAH1KPLnWo6ksqGPP4klcxLUooq
	 Ah9Kaao/pqQWY5D/q9ArtucbE7uMhY0cyC7UEWrkQnavH2fGJKCS2s8zsqn00jNuKt
	 rLyW4AwuTOnc3mjDV0zZK/Vtfrh3vO37VY8DYeKT8Co7nAYPMkPT5NovBZFxRswA6v
	 3/Cd7RDoDkGmWnz+uwKrEiaxwUmv8+mf9XDzlua/X5LrJLdi5kaXVXvGU5SMFhSspJ
	 ANos2L4I54s8Q==
Message-ID: <e204e8181190813f58382ec359c6ffe1ba7a9aca.camel@kernel.org>
Subject: Re: [PATCH] tracing: Save the event file instead of the compatible
 histogram
From: Tom Zanussi <zanussi@kernel.org>
To: Donggeun Yoo <donggeunyoo.kernel@gmail.com>, Steven Rostedt
	 <rostedt@goodmis.org>, Masami Hiramatsu <mhiramat@kernel.org>
Cc: Mathieu Desnoyers <mathieu.desnoyers@efficios.com>, Sashiko
	 <sashiko-bot@kernel.org>, linux-trace-kernel@vger.kernel.org, 
	linux-kernel@vger.kernel.org, stable@vger.kernel.org
Date: Sun, 20 Sep 2026 13:51:43 -0500
In-Reply-To: <20260914234754.3676905-1-donggeunyoo.kernel@gmail.com>
References: <20260914234754.3676905-1-donggeunyoo.kernel@gmail.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
User-Agent: Evolution 3.52.3-0ubuntu1.1 
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0

On Tue, 2026-09-15 at 08:47 +0900, Donggeun Yoo wrote:
> create_field_var_hist() creates a histogram on the matched event to
> supply a field variable, and records it on the target so it can be torn
> down later:
>=20
> 	hist_data =3D find_compatible_hist(target_hist_data, file);
> 	...
> 	/* Save the compatible histogram information */
> 	var_hist->hist_data =3D hist_data;
>=20
> hist_data is not the histogram it creates. It is one that was already
> there, whose keys the new one copies. The saved pointer has a single
> user, unregister_field_var_hists(), which runs when the target is
> removed:
>=20
> 	file =3D hist_data->field_var_hists[i]->hist_data->event_file;
>=20
> find_compatible_hist() matches on keys alone, so it can pick one with no
> variables of its own. check_var_refs() then returns false and the user
> can remove it while the target still points at it:
>=20
> =C2=A0BUG: KASAN: slab-use-after-free in event_hist_trigger_free+0x2b2/0x=
320
> =C2=A0Read of size 8 at addr ffff8880093b90e0 by task init/1
>=20
> =C2=A0Freed by task 1:
> =C2=A0 kfree+0x154/0x420
> =C2=A0 event_hist_trigger_free+0x1d5/0x320
> =C2=A0 event_hist_trigger_parse+0x35f3/0x69e0
> =C2=A0 trigger_process_regex+0x1a6/0x250
>=20
> Save the event file instead. It is all the dereference ever wanted, and
> it does not go away when the user removes a trigger.
>=20
> Reported-by: Sashiko <sashiko-bot@kernel.org>
> Link: https://lore.kernel.org/all/20260914110753.221E61F000FF@smtp.kernel=
.org/
> Cc: stable@vger.kernel.org
> Fixes: 02205a6752f2 ("tracing: Add support for 'field variables'")
> Signed-off-by: Donggeun Yoo <donggeunyoo.kernel@gmail.com>
> Assisted-by: Claude:claude-fable-5

Looks fine to me, thanks.

Acked-by: Tom Zanussi <zanussi@kernel.org>

> ---
> x86_64 under QEMU/KVM, CONFIG_KASAN=3Dy, 2 CPUs, base 587858367581.=C2=A0=
 One
> kernel config; one initramfs image per arm, differing only where stated.
>=20
> A compatible histogram on sched_waking, an onmatch() target on
> sched_switch naming sched_waking's prio so a field variable is forced,
> then the compatible histogram removed, then the target:
>=20
> =C2=A0 echo 'hist:keys=3Dpid' > events/sched/sched_waking/trigger
> =C2=A0 echo 'hist:keys=3Dnext_pid:onmatch(sched.sched_waking).my_synth(pr=
io)' \
> =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 > events/sched/sched_switch/trigger
> =C2=A0 echo '!hist:keys=3Dpid' > events/sched/sched_waking/trigger
> =C2=A0 echo '!hist:keys=3Dnext_pid:onmatch(...)' > events/sched/sched_swi=
tch/trigger
>=20
> =C2=A0 unfixed=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=
=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=
=C2=A0 1 KASAN slab-use-after-free, above
> =C2=A0 unfixed, 3rd command omitted=C2=A0=C2=A0 0
> =C2=A0 patched=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=
=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=
=C2=A0 0
>=20
> The second arm is the control: the other three commands are identical, so
> the report is the removal and not the harness.
>=20
> The read is on freed memory rather than a pointer that is reliably wrong
> -- whether the '!hist' still reaches the right file depends on what the
> slab has handed out since.
>=20
> trigger-field-variable-support.tc covers this path, and its removal step
> goes through the line this patch changes.=C2=A0 Run by hand against both =
arms,
> since the initramfs carries no ftracetest: inter-event histogram PASS,
> field variable created PASS, field variable removed PASS, on both, with
> no KASAN report on either.
> =C2=A0kernel/trace/trace_events_hist.c | 8 ++++----
> =C2=A01 file changed, 4 insertions(+), 4 deletions(-)
>=20
> diff --git a/kernel/trace/trace_events_hist.c b/kernel/trace/trace_events=
_hist.c
> index 8af97fd4ee2d..cc22bba011b2 100644
> --- a/kernel/trace/trace_events_hist.c
> +++ b/kernel/trace/trace_events_hist.c
> @@ -549,7 +549,7 @@ struct field_var {
> =C2=A0};
> =C2=A0
> =C2=A0struct field_var_hist {
> -	struct hist_trigger_data	*hist_data;
> +	struct trace_event_file		*file;
> =C2=A0	char				*cmd;
> =C2=A0};
> =C2=A0
> @@ -3118,8 +3118,8 @@ create_field_var_hist(struct hist_trigger_data *tar=
get_hist_data,
> =C2=A0		return ERR_PTR(-ENOMEM);
> =C2=A0	}
> =C2=A0
> -	/* Save the compatible histogram information */
> -	var_hist->hist_data =3D hist_data;
> +	/* Needed to remove the histogram when the target goes away */
> +	var_hist->file =3D file;
> =C2=A0
> =C2=A0	/* Create the new histogram with our variable */
> =C2=A0	ret =3D event_hist_trigger_parse(&trigger_hist_cmd, file,
> @@ -6344,7 +6344,7 @@ static void unregister_field_var_hists(struct hist_=
trigger_data *hist_data)
> =C2=A0	int ret;
> =C2=A0
> =C2=A0	for (i =3D 0; i < hist_data->n_field_var_hists; i++) {
> -		file =3D hist_data->field_var_hists[i]->hist_data->event_file;
> +		file =3D hist_data->field_var_hists[i]->file;
> =C2=A0		cmd =3D hist_data->field_var_hists[i]->cmd;
> =C2=A0		ret =3D event_hist_trigger_parse(&trigger_hist_cmd, file,
> =C2=A0					=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 "!hist", "hist", cmd);
>=20
> base-commit: 587858367581b9c55c3690f4e63382ad622719d4

