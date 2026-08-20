Received: from relay.hostedemail.com (smtprelay0014.hostedemail.com [216.40.44.14])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6AD7F367287
	for <stable@vger.kernel.org>; Thu, 20 Aug 2026 22:20:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=216.40.44.14
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1787264429; cv=none; b=pnUyh9GMyLnGcvKKcJ6TTfvM2wXU+QFg14AYduU7fkay6gdsHAbOXv+/jF/A8nRU7s+d70aaHUUvYTja0gZYa0Se/a+8lYLKqbp91QGogs27KYOiycyDQsIOYahRCwKGGnZwkwH3xM4drh4EfQxMh3EgVQi2ljSmsKKkX3dgDM0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1787264429; c=relaxed/simple;
	bh=ADW4x/8m91ZpUvqdctJ/nkHWER5fJ/Za+mv0FZMdUm8=;
	h=Date:From:To:Cc:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=NGkUXXPjWTiPbdXZvxORKr2mivhmQF0ypmAyzavixQUnOl06vhoWtgTOSjmHhW5MXoZQ7p2iBp/8p3SDUdHrqGTAYDSA/oWXCRecPnATXEC94PLMc5w393aPJ7Ilbhw/AF1IXcNDEWMNzhg1wIahARhlQattCUyshK+EQF2XTcw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=goodmis.org; spf=pass smtp.mailfrom=goodmis.org; dkim=pass (1024-bit key) header.d=goodmis.org header.i=@goodmis.org header.b=OVFkaq3q; arc=none smtp.client-ip=216.40.44.14
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=goodmis.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=goodmis.org
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=goodmis.org header.i=@goodmis.org header.b="OVFkaq3q"
Received: from omf04.hostedemail.com (lb01a-stub [10.200.18.249])
	by unirelay08.hostedemail.com (Postfix) with ESMTP id 79EE7140301;
	Thu, 20 Aug 2026 22:20:19 +0000 (UTC)
Received: from [HIDDEN] (Authenticated sender: rostedt@goodmis.org) by omf04.hostedemail.com (Postfix) with ESMTPA id 61BB82002B;
	Thu, 20 Aug 2026 22:20:17 +0000 (UTC)
Date: Thu, 20 Aug 2026 18:20:15 -0400
From: Steven Rostedt <rostedt@goodmis.org>
To: Andrey Grodzovsky <andrey.grodzovsky@crowdstrike.com>
Cc: stable@vger.kernel.org, Greg KH <gregkh@linuxfoundation.org>,
 sashal@kernel.org, DL Linux Open Source Team
 <linux-open-source@crowdstrike.com>
Subject: Re: [STABLE REQUEST] ftrace: deprecate the ftrace_enabled disable
 switch
Message-ID: <20260820182015.4272b7a4@fedora>
In-Reply-To: <CAOu3gNgTSWE84fgdc1iUNKwes7E6u_X6b8pjZKBULEJWB=RAqQ@mail.gmail.com>
References: <CAOu3gNgTSWE84fgdc1iUNKwes7E6u_X6b8pjZKBULEJWB=RAqQ@mail.gmail.com>
X-Mailer: Claws Mail 4.4.0 (GTK 3.24.52; x86_64-redhat-linux-gnu)
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
X-Rspamd-Server: rspamout01
X-Rspamd-Queue-Id: 61BB82002B
X-Stat-Signature: hwnothpwqu1gg4hozwi65xe5kooara8h
X-Session-Marker: 726F737465647440676F6F646D69732E6F7267
X-Session-ID: U2FsdGVkX19PiwckstjcTn9z1OGlAHhys6lQGyvXTnY=
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=goodmis.org; h=date:from:to:cc:subject:message-id:in-reply-to:references:mime-version:content-type:content-transfer-encoding; s=dkim1; bh=rEpaCeHZZ1UYYsJpvhTIRBCnGC9Dl0pVA+AVJEeExQc=; b=OVFkaq3qgTmXPRVJvOM5SwrqcFJMevxBPygyRITgnrddv+ulUeSBRKwuSnS1UUivU1Z+NDij98i4lWVngLbGknDfu5jg8FoH4Tx4AVspgpT2RRxYg0DI5qsP8Z/7wXq8HbVEe2Bkpf4wLqJcu4Iq2QKmkZNjMtTMsIVOtEbPme8=
X-HE-Tag: 1787264417-7882
X-HE-Meta: U2FsdGVkX1/V3i6AMLepIXHqwhZvNcfGguAcPXFIcqYs6JRaIxRKqtIu1EcBveq6khp3dz3ioC635lzHepmeMYVn3uItAIn5y2KTXPlhSxFcscBZIZRIsblWtAKQQsiq36FHiAR/tGwGRHhcYrSGbyrBAYM8xYq9RJ/MuSlLMyJXp+53y4xVMlsUxGwInwoHma94f37sbuo9fw/ZUH/+/xB2MeRqG2b+P5j15NMv+yjv82wmGqX7vf11b3kzT56NaHHboWdAn19O98eR/D/MZvjeVlVfOuEubu2JhHl5XVIZIFr5pQGllTI3fG3hYaWO56Y6kOhl1MqVM56IS03xaiceosQnbaa0IDV8HJxbIMzrrufmPSyiiw==

On Thu, 20 Aug 2026 17:30:40 -0400
Andrey Grodzovsky <andrey.grodzovsky@crowdstrike.com> wrote:

> Hello stable team,
> 
> Please consider backporting the following two commits to the stable trees:
> 
>   - b0c857049153680e1b6ccb59abf359a4ca523561 ("ftrace: deprecate
> disabling via ftrace_enabled sysctl")
>   - 88b3e7fedc07d940c32eb5c0733a780e944b6b47 ("selftests/livepatch:
> update test-ftrace.sh for deprecated ftrace_enabled")
> 
> Both commits were merged into mainline in v7.3 via the 'ftrace-v7.3' tag.
> 
> This change addresses a long-standing issue: setting
> kernel.ftrace_enabled=0 silently disables BPF trampolines
> (fentry/fexit) and ftrace-based kprobes/kretprobes. The write succeeds
> and the hooks stop firing without error, while re-enabling silently
> restores them. Livepatch resolved this via FTRACE_OPS_FL_PERMANENT,
> which blocks disabling ftrace while a permanent ops is registered and
> blocks registration while ftrace is disabled. Trampolines had this
> same protection from 2019 to 2022 while sharing a global direct_ops
> marked permanent, but lost it during the 2022 per-trampoline-ops
> split. ftrace based Kprobes never had this protection.
> 
> The breakage was introduced in commit 00963a2e75a8 ("bpf: Support
> bpf_trampoline on functions with IPMODIFY (e.g. livepatch)").
> 
> With these commits, writing 0 is refused with -EOPNOTSUPP and a
> one-time warning is logged; reads and writing 1 are unaffected. Steven
> Rostedt requested and reviewed this change on the mailing list,
> including the follow-up selftest update.
> 
> We would like to backport this to LTS branches starting with 6.1.y,
> where the breaking commit already exists.
> 
> Mailing list threads for reference:
> 
>   - RFC v1: https://lore.kernel.org/bpf/20260730163544.2042327-1-andrey.grodzovsky@crowdstrike.com/
>   - RFC v3 (final):
> https://lore.kernel.org/bpf/20260806153000.4184871-1-andrey.grodzovsky@crowdstrike.com/
> 
> I can provide rebased backports for any trees where these commits do
> not apply cleanly.

I'm really nervous about backporting patches that may be reverted
upstream. These change user space API and if anything depends on the
old behavior, it will be reverted. That would also mean stable would
need to revert it too.

Instead, please post the first two patches of your original series:

  https://lore.kernel.org/all/20260729005959.3853865-1-andrey.grodzovsky@crowdstrike.com/

I rather push these upstream even if they are not really needed. But
those are much safer to backport because it "fixes" the problem even if
the main fix gets reverted.

-- Steve
