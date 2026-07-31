Received: from smtp-out1.suse.de (smtp-out1.suse.de [195.135.223.130])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6DF4E334C3D
	for <stable@vger.kernel.org>; Fri, 31 Jul 2026 09:05:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=195.135.223.130
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1785488709; cv=none; b=YYIoVA1uEb9a+wnyanNKCYDySpj2gQryNZNYwfu1Dd/ULHVw9dwqhR9hfyHhUsps7o7QhKaOQ9eRZPqTbpbWF3YloOGVLJeUmoQrK4gK3gXRtAad6l6n7VqXRKB3MxSMygPF9cY2x0SZv+1tgup2TUcTgBXLf/reRmaGsfOWze8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1785488709; c=relaxed/simple;
	bh=Rgvp+VDe50RFmnt3GDcvFMv2kutgcrdQ+nvZuRjgL4s=;
	h=Date:From:To:cc:Subject:In-Reply-To:Message-ID:References:
	 MIME-Version:Content-Type; b=hojDBIMSTnI/QKFk9f2Lg66zGcQBWJfJQW7oTWVDmPuDWLL4QEV4KwPsa3pGid/0b5gFpLMeP6XYfvuyRdp1EIXnCu4K0Ru4uWHHmyAs7AgvnPpZw9EbqcCDrXZSiZVYD5ETeRvBo2PGOsqYd3Adw60XwGe2vwmzuHse0dyEgNc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=suse.cz; spf=pass smtp.mailfrom=suse.cz; dkim=pass (1024-bit key) header.d=suse.cz header.i=@suse.cz header.b=TUXBFs5V; dkim=permerror (0-bit key) header.d=suse.cz header.i=@suse.cz header.b=+OoQnUju; dkim=pass (1024-bit key) header.d=suse.cz header.i=@suse.cz header.b=hQ+MEyAl; dkim=permerror (0-bit key) header.d=suse.cz header.i=@suse.cz header.b=ygQvoYlP; arc=none smtp.client-ip=195.135.223.130
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=suse.cz
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=suse.cz
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=suse.cz header.i=@suse.cz header.b="TUXBFs5V";
	dkim=permerror (0-bit key) header.d=suse.cz header.i=@suse.cz header.b="+OoQnUju";
	dkim=pass (1024-bit key) header.d=suse.cz header.i=@suse.cz header.b="hQ+MEyAl";
	dkim=permerror (0-bit key) header.d=suse.cz header.i=@suse.cz header.b="ygQvoYlP"
Received: from pobox.suse.cz (unknown [10.128.32.1])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp-out1.suse.de (Postfix) with ESMTPS id 6BE037DE66;
	Fri, 31 Jul 2026 09:04:56 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.cz; s=susede2_rsa;
	t=1785488700; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=EJQ4tixhl8ptjgMIavI7XAafyovWW2/pjPwbVKZ9qCs=;
	b=TUXBFs5VU4QTjJ+ld+ZEO+/kbccW6Xfo9yJzPfmjqQXN7kS2TBcqB9mcEn4RkkrVyXylZG
	DhYhywXSLPn4MqMQ43Sn2jiVzWX1N8eCGoKCm2kI3KU+B+9BigZ2BD0mt7tMf+SYrMExom
	zNEByG513PJJFgJ8jEvkYjzhmQSDAZ0=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.cz;
	s=susede2_ed25519; t=1785488700;
	h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=EJQ4tixhl8ptjgMIavI7XAafyovWW2/pjPwbVKZ9qCs=;
	b=+OoQnUju4OO0pobXcUva5FKg1kkdWogjmFncP+88WfSsFhsBMQMAzKThEv9VIH2LdoxlcS
	Rvq6SSbvr/0W2qBw==
Authentication-Results: smtp-out1.suse.de;
	none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.cz; s=susede2_rsa;
	t=1785488696; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=EJQ4tixhl8ptjgMIavI7XAafyovWW2/pjPwbVKZ9qCs=;
	b=hQ+MEyAldBM3OnOxkZvz0PXovu0b5pRHrWcxgPegN3SUgZaZQPQ7f2CKWCLs5Pnq+G+H53
	JuZcmDScHAPtmeF+E6G2Uuw4G1ku0Fvk/vYStYnu35YG3COZmHrUp25VFB/eUMRo0zNhRx
	WzAWY0AUtpAxxSllkPNiwLcKL8akwQI=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.cz;
	s=susede2_ed25519; t=1785488696;
	h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=EJQ4tixhl8ptjgMIavI7XAafyovWW2/pjPwbVKZ9qCs=;
	b=ygQvoYlPBIn2DiLAe2c2Epc/QF3L6r5f6dFatvmbq+efUxC8NvNidn8c6thYfMJLIy/d9f
	erPub4HH5gDlCnCg==
Date: Fri, 31 Jul 2026 11:04:56 +0200 (CEST)
From: Miroslav Benes <mbenes@suse.cz>
To: Steven Rostedt <rostedt@goodmis.org>
cc: Andrey Grodzovsky <andrey.grodzovsky@crowdstrike.com>, bpf@vger.kernel.org, 
    linux-trace-kernel@vger.kernel.org, live-patching@vger.kernel.org, 
    linux-kselftest@vger.kernel.org, linux-doc@vger.kernel.org, corbet@lwn.net, 
    jpoimboe@kernel.org, shuah@kernel.org, jolsa@kernel.org, 
    mhiramat@kernel.org, stable@vger.kernel.org, 
    linux-open-source@crowdstrike.com
Subject: Re: [RFC PATCH bpf-next 2/2] selftests/livepatch: update test-ftrace.sh
 for deprecated ftrace_enabled
In-Reply-To: <20260730200913.59a541db@gandalf.local.home>
Message-ID: <alpine.LSU.2.21.2607311104390.25165@pobox.suse.cz>
References: <20260730163544.2042327-1-andrey.grodzovsky@crowdstrike.com> <20260730163544.2042327-3-andrey.grodzovsky@crowdstrike.com> <20260730200913.59a541db@gandalf.local.home>
User-Agent: Alpine 2.21 (LSU 202 2017-01-01)
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
X-Spam-Score: -4.30
X-Spam-Level: 
X-Spam-Flag: NO
X-Spamd-Result: default: False [-4.30 / 50.00];
	BAYES_HAM(-3.00)[100.00%];
	NEURAL_HAM_LONG(-1.00)[-1.000];
	NEURAL_HAM_SHORT(-0.20)[-0.976];
	MIME_GOOD(-0.10)[text/plain];
	FROM_HAS_DN(0.00)[];
	MIME_TRACE(0.00)[0:+];
	RCPT_COUNT_TWELVE(0.00)[14];
	ARC_NA(0.00)[];
	RCVD_COUNT_ZERO(0.00)[0];
	MID_RHS_MATCH_FROMTLD(0.00)[];
	DKIM_SIGNED(0.00)[suse.cz:s=susede2_rsa,suse.cz:s=susede2_ed25519];
	TO_DN_SOME(0.00)[];
	FROM_EQ_ENVFROM(0.00)[];
	TO_MATCH_ENVRCPT_ALL(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[pobox.suse.cz:helo,pobox.suse.cz:mid,crowdstrike.com:email]

On Thu, 30 Jul 2026, Steven Rostedt wrote:

> On Thu, 30 Jul 2026 12:35:44 -0400
> Andrey Grodzovsky <andrey.grodzovsky@crowdstrike.com> wrote:
> 
> > kernel.ftrace_enabled=0 is now always refused, so the old scenario
> > (disable, fail to load a livepatch, re-enable, load) no longer applies.
> > Replace it with a single check that the write is refused with the new
> > error, and drop the now-stale disable/reload flow.
> > 
> > Assisted-by: Claude:claude-sonnet-5
> > Signed-off-by: Andrey Grodzovsky <andrey.grodzovsky@crowdstrike.com>
> > ---
> >  .../selftests/livepatch/test-ftrace.sh        | 49 ++-----------------
> >  1 file changed, 3 insertions(+), 46 deletions(-)
> > 
> > diff --git a/tools/testing/selftests/livepatch/test-ftrace.sh b/tools/testing/selftests/livepatch/test-ftrace.sh
> > index d2c3dea63104..c88f4d13a134 100755
> > --- a/tools/testing/selftests/livepatch/test-ftrace.sh
> > +++ b/tools/testing/selftests/livepatch/test-ftrace.sh
> > @@ -9,56 +9,13 @@ MOD_LIVEPATCH=test_klp_livepatch
> >  setup_config
> >  
> >  
> > -# - turn ftrace_enabled OFF and verify livepatches can't load
> > -# - turn ftrace_enabled ON and verify livepatch can load
> > -# - verify that ftrace_enabled can't be turned OFF while a livepatch is loaded
> > +# - verify that kernel.ftrace_enabled=0 is refused (deprecated knob)
> >  
> > -start_test "livepatch interaction with ftrace_enabled sysctl"
> > +start_test "ftrace_enabled sysctl write is refused (deprecated)"
> >  
> > -set_ftrace_enabled 0
> > -load_failing_mod $MOD_LIVEPATCH
> > -
> > -set_ftrace_enabled 1
> > -load_lp $MOD_LIVEPATCH
> > -if [[ "$(cat /proc/cmdline)" != "$MOD_LIVEPATCH: this has been live patched" ]] ; then
> > -	echo -e "FAIL\n\n"
> > -	die "livepatch kselftest(s) failed"
> > -fi
> > -
> 
> This test should work for both old and new kernels. I would have it still
> do everything here but if setting ftrace_enabled returns -EOPNOTSUPP then
> do the simple path.

Yes, please. It would be ideal.

Miroslav
