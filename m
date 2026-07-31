Received: from relay.hostedemail.com (smtprelay0015.hostedemail.com [216.40.44.15])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DFA21288AD;
	Fri, 31 Jul 2026 00:08:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=216.40.44.15
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1785456523; cv=none; b=MD3MD4XSqP+JQUTFmNPO8bt/QEeu0x8+ufMD7fF8tFc+PKYYen8X/8DpZMtcMC9Pt5C/j1vrOIHCNifXkylSmAdkBMDbvvnfAR8QGuogcdh/OD1A7zKKG5dF2rpysTgfw3wDs+KTH0BX5tzSmHIjXOoro2slcOfRq479CylU7yA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1785456523; c=relaxed/simple;
	bh=lV4Y4nf5AeHDdQZbAkGFS1iUqCawwFfne4/QCeMicwM=;
	h=Date:From:To:Cc:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=krPu7f+Top8XxtRoZk8jm5vouBriX20zuGJTCaXecRn2tEIE47RpGEnOfkvRkf619r2lngy1d+Y6R7hedgOkKOukvOtrd9WasKa9Yqc8t0aDlgJSEJ0srwaNrRTbdNQ1x3SbF6wRHZsCO3K6XKOexhugEola+HjiNKxZS7L83sY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=goodmis.org; spf=pass smtp.mailfrom=goodmis.org; arc=none smtp.client-ip=216.40.44.15
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=goodmis.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=goodmis.org
Received: from omf01.hostedemail.com (lb01a-stub [10.200.18.249])
	by unirelay04.hostedemail.com (Postfix) with ESMTP id CC3A71A0329;
	Fri, 31 Jul 2026 00:08:37 +0000 (UTC)
Received: from [HIDDEN] (Authenticated sender: rostedt@goodmis.org) by omf01.hostedemail.com (Postfix) with ESMTPA id 0CC7D60010;
	Fri, 31 Jul 2026 00:08:34 +0000 (UTC)
Date: Thu, 30 Jul 2026 20:09:13 -0400
From: Steven Rostedt <rostedt@goodmis.org>
To: Andrey Grodzovsky <andrey.grodzovsky@crowdstrike.com>
Cc: <bpf@vger.kernel.org>, <linux-trace-kernel@vger.kernel.org>,
 <live-patching@vger.kernel.org>, <linux-kselftest@vger.kernel.org>,
 <linux-doc@vger.kernel.org>, <corbet@lwn.net>, <jpoimboe@kernel.org>,
 <shuah@kernel.org>, <jolsa@kernel.org>, <mbenes@suse.cz>,
 <mhiramat@kernel.org>, <stable@vger.kernel.org>,
 <linux-open-source@crowdstrike.com>
Subject: Re: [RFC PATCH bpf-next 2/2] selftests/livepatch: update
 test-ftrace.sh for deprecated ftrace_enabled
Message-ID: <20260730200913.59a541db@gandalf.local.home>
In-Reply-To: <20260730163544.2042327-3-andrey.grodzovsky@crowdstrike.com>
References: <20260730163544.2042327-1-andrey.grodzovsky@crowdstrike.com>
	<20260730163544.2042327-3-andrey.grodzovsky@crowdstrike.com>
X-Mailer: Claws Mail 3.20.0git84 (GTK+ 2.24.33; x86_64-pc-linux-gnu)
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
X-Rspamd-Server: rspamout05
X-Rspamd-Queue-Id: 0CC7D60010
X-Stat-Signature: dary9efr8fa175tbga7ng7rcqoyinkxm
X-Session-Marker: 726F737465647440676F6F646D69732E6F7267
X-Session-ID: U2FsdGVkX18OUhYxQpcApacRfZUnO8zlNndNAgZBitI=
X-HE-Tag: 1785456514-63941
X-HE-Meta: U2FsdGVkX18kfK7tNELfjIWCMK1BpCKR7uHnwmI96UwuVZdrw77nEqub+9YRLdQ+gGofUnBkclMbECoYWg6XA9j17jHgeIklcgRslgDlRNvM3SZOLnysNysD0hqx5V6n0no5cc91Zl5vLwI6PdZ+TCfg1nDWOZNOTvl0jx+A2gvNMBZDQKdDzvs6LriK8C2ku0sGSJpZKb0jpdM7eJVsD0Fzz3ubMLDBWRby0e5KUwWRTjjIPrkF+GBMj/5CnlZxr4s5suf5J8+6T3gYa3WsYu7FQvedpBYQa13ao74T9dqpXLtRYtKp33Toy9A9rT7bWetuIYcLWwhm5tk/5u2eUlSVFka/AiXt

On Thu, 30 Jul 2026 12:35:44 -0400
Andrey Grodzovsky <andrey.grodzovsky@crowdstrike.com> wrote:

> kernel.ftrace_enabled=0 is now always refused, so the old scenario
> (disable, fail to load a livepatch, re-enable, load) no longer applies.
> Replace it with a single check that the write is refused with the new
> error, and drop the now-stale disable/reload flow.
> 
> Assisted-by: Claude:claude-sonnet-5
> Signed-off-by: Andrey Grodzovsky <andrey.grodzovsky@crowdstrike.com>
> ---
>  .../selftests/livepatch/test-ftrace.sh        | 49 ++-----------------
>  1 file changed, 3 insertions(+), 46 deletions(-)
> 
> diff --git a/tools/testing/selftests/livepatch/test-ftrace.sh b/tools/testing/selftests/livepatch/test-ftrace.sh
> index d2c3dea63104..c88f4d13a134 100755
> --- a/tools/testing/selftests/livepatch/test-ftrace.sh
> +++ b/tools/testing/selftests/livepatch/test-ftrace.sh
> @@ -9,56 +9,13 @@ MOD_LIVEPATCH=test_klp_livepatch
>  setup_config
>  
>  
> -# - turn ftrace_enabled OFF and verify livepatches can't load
> -# - turn ftrace_enabled ON and verify livepatch can load
> -# - verify that ftrace_enabled can't be turned OFF while a livepatch is loaded
> +# - verify that kernel.ftrace_enabled=0 is refused (deprecated knob)
>  
> -start_test "livepatch interaction with ftrace_enabled sysctl"
> +start_test "ftrace_enabled sysctl write is refused (deprecated)"
>  
> -set_ftrace_enabled 0
> -load_failing_mod $MOD_LIVEPATCH
> -
> -set_ftrace_enabled 1
> -load_lp $MOD_LIVEPATCH
> -if [[ "$(cat /proc/cmdline)" != "$MOD_LIVEPATCH: this has been live patched" ]] ; then
> -	echo -e "FAIL\n\n"
> -	die "livepatch kselftest(s) failed"
> -fi
> -

This test should work for both old and new kernels. I would have it still
do everything here but if setting ftrace_enabled returns -EOPNOTSUPP then
do the simple path.

-- Steve


> -# Check that ftrace could not get disabled when a livepatch is enabled
>  set_ftrace_enabled --fail 0
> -if [[ "$(cat /proc/cmdline)" != "$MOD_LIVEPATCH: this has been live patched" ]] ; then
> -	echo -e "FAIL\n\n"
> -	die "livepatch kselftest(s) failed"
> -fi
> -disable_lp $MOD_LIVEPATCH
> -unload_lp $MOD_LIVEPATCH
>  
> -check_result "livepatch: kernel.ftrace_enabled = 0
> -% insmod test_modules/$MOD_LIVEPATCH.ko
> -livepatch: enabling patch '$MOD_LIVEPATCH'
> -livepatch: '$MOD_LIVEPATCH': initializing patching transition
> -livepatch: failed to register ftrace handler for function 'cmdline_proc_show' (-16)
> -livepatch: failed to patch object 'vmlinux'
> -livepatch: failed to enable patch '$MOD_LIVEPATCH'
> -livepatch: '$MOD_LIVEPATCH': canceling patching transition, going to unpatch
> -livepatch: '$MOD_LIVEPATCH': completing unpatching transition
> -livepatch: '$MOD_LIVEPATCH': unpatching complete
> -insmod: ERROR: could not insert module test_modules/$MOD_LIVEPATCH.ko: Device or resource busy
> -livepatch: kernel.ftrace_enabled = 1
> -% insmod test_modules/$MOD_LIVEPATCH.ko
> -livepatch: enabling patch '$MOD_LIVEPATCH'
> -livepatch: '$MOD_LIVEPATCH': initializing patching transition
> -livepatch: '$MOD_LIVEPATCH': starting patching transition
> -livepatch: '$MOD_LIVEPATCH': completing patching transition
> -livepatch: '$MOD_LIVEPATCH': patching complete
> -livepatch: sysctl: setting key \"kernel.ftrace_enabled\": Device or resource busy
> -% echo 0 > $SYSFS_KLP_DIR/$MOD_LIVEPATCH/enabled
> -livepatch: '$MOD_LIVEPATCH': initializing unpatching transition
> -livepatch: '$MOD_LIVEPATCH': starting unpatching transition
> -livepatch: '$MOD_LIVEPATCH': completing unpatching transition
> -livepatch: '$MOD_LIVEPATCH': unpatching complete
> -% rmmod $MOD_LIVEPATCH"
> +check_result "livepatch: sysctl: setting key \"kernel.ftrace_enabled\": Operation not supported"
>  
>  
>  # - verify livepatch can load

