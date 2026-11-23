Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=100.103.45.18
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1795466370;
	b=pqvKZJF9MwDXZM6PTl8D/s9ZtxtI67ttP+pGL8dicJBWK8CPadNNj1YM5XEag4wU2pcC
	 mJNCmx9EMeat1oj6TPbMz7OkCqoCmwyVamX/8/mAd3OGa1UmS8zkWnTvANCYBA7WjnfA6
	 CxVGjMbuQyYanWlbOf8aSI9ILZyx+HEmt9yxr5rhKV75deOacCZ9VivtbDK+E1mtP/sbp
	 hrff9Pk6Swcr4Ylj4cCqazh7Lva7yHU6smw88KXWtSdy1tovuE55iFjClbop8Wxf/BZrF
	 MK85XQPVU3TnvtzkuaXVjtjq6nqPpIoQDlM//XCEL9Hj0qDWkED96dJQZiIdBbGtkxg==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1795466370;
	h=Received:DKIM-Signature:Subject:From:To:Cc:Date:Message-ID:
	 In-Reply-To:References:X-sashiko-severity:Content-Type:
	 Content-Transfer-Encoding:MIME-Version;
	bh=D0KHOZVofruhcg+Qn5VOsyQ2WExJk7PqsXpAACuiVqE=;
	b=BvIhOi0iiqFeHK/b7dpbwOfodh4NKbmxa+O2cdcUXofhRcORX7q4vA9EMsgwfBsBesji
	 /OmiHbgL4xMsCU7NjjpKUU8pp4Q6PXE4h8V53tQYS9e5hGXmgHT8zjWgEZrlCkt8lG7Gl
	 tivyfF9u8VqRqprrOuEWovQMS90UqfILyRHmbSQ4bUWrFCDuES4U8P00t1uNMo9uLB0uT
	 JM3ihIKDy6AU//41W7LBn0i6PG2JCYqiHEMwdbM3bYSs17rc3f7VQ9Jun3zW/PIpsVlFl
	 ifwz6GBb6pxRNr8aTJ+94zAuxe9RpLYJyiAzQF1dmE2qtjaBeYpyiOfg0uxjl8DMLGA==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dkim=pass header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b="MpDsk/hw";
	arc=none smtp.remote-ip=100.103.45.18
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7F07B606A31E;
	Mon, 23 Nov 2026 20:39:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=MpDsk/hw
Received: by smtp.kernel.org (Postfix) with ESMTPSA id F2C211F000CF;
	Mon, 23 Nov 2026 20:39:28 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1795466369;
	bh=D0KHOZVofruhcg+Qn5VOsyQ2WExJk7PqsXpAACuiVqE=;
	h=Subject:From:To:Cc:Date:In-Reply-To:References;
	b=MpDsk/hwN3owQGvNzZWYAKicAT0ixjii36t2u7FvQ1EgmI0kYjmTQjUQDNlw0SutF
	 AY0aLpiTywNgmri8RAif1ewAI2ZR9XSsHcsJww+n+3FwojAbrnzgBGYa7Gnc+X+WrM
	 pfVDsQLjr2bQjjjTyKqzqqUh+g08dJyTikcVwK6S9tx55ilda0VhJUzQEpCNlmJ4Ye
	 EVwTTwgztAcxZvV3iJkF4PznnP4eyMRMVZbayQrzV2yEaXIt46YCl1kI3rPJlUgbmv
	 Nekr2EWB40MysIGpiJkQAPb7q2qzrUliYQKfpwzI7guhVoM82r5t5g0JQPSDM32QMK
	 EnKWNB1JwKAHw==
Subject: Re: [PATCH net v2 2/3] selftests: net: py: add a bkg() timeout and
 kill the child when it expires
From: netdev-bot+sashiko@kernel.org
To: rjethwani@purestorage.com
Cc: netdev@vger.kernel.org, stable@vger.kernel.org, john.fastabend@gmail.com,
 kuba@kernel.org, sd@queasysnail.net, davem@davemloft.net, edumazet@kernel.org,
 pabeni@redhat.com, horms@kernel.org, tariqt@nvidia.com,
 alice.kernel@fastmail.im
Date: Mon, 23 Nov 2026 20:39:28 +0000
Message-ID: <179546636853.3135.5221989489890379101@kernel.org>
In-Reply-To: <20261119191341.4089157-2-rjethwani@purestorage.com>
References: <20261119191341.4089157-2-rjethwani@purestorage.com>
X-sashiko-severity: Medium
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Post: <mailto:stable@vger.kernel.org>
List-Help: <mailto:stable+help@vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
List-Owner: <mailto:stable+owner@vger.kernel.org>
Precedence: list
MIME-Version: 1.0

Thank you for your contribution! Sashiko AI review found 5 potential
issue(s) to consider.

Critical: 0 · High: 0 · Medium: 2 · Low: 3

If you believe none of the issues are legitimate, please reply to each
issue of Medium severity or higher and explain why the AI is wrong.
If any of them are legitimate and you plan to respin, please let patchwork
know by including "pw-bot: cr" as a separate line at the end of your reply
(one such reply per series is enough).

- [Medium] In tools/testing/selftests/net/lib/py/utils.py,
  cmd._process_terminate() handles a communicate() timeout by calling…
- [Medium] In cmd._process_terminate(), when the second
  communicate(timeout=1) times out after self.proc.kill(), the code…
- [Low] The commit message describes a bkg()-only change, but the
  modified helper cmd._process_terminate() is shared.
- [Low] The new comment in cmd._process_terminate() says "bkg() with
  exit_wait or ksft_wait never sends one [terminate()]".
- [Low] The new comments in cmd._process_terminate() describe which
  backends leave processes behind after kill().

--

selftests: net: py: add a bkg() timeout and kill the child when it expires

This adds a timeout argument to bkg() for its exit-time wait. It also
changes cmd._process_terminate() so that, when communicate() times out,
the child gets SIGKILL before TimeoutExpired is re-raised. The goal is to
stop a timed-out background command from outliving the devices and
namespaces the test tears down.

> diff --git a/tools/testing/selftests/net/lib/py/utils.py b/tools/testing/selftests/net/lib/py/utils.py
> index 1727bc4180733..7a3fc39db3348 100644
> --- a/tools/testing/selftests/net/lib/py/utils.py
> +++ b/tools/testing/selftests/net/lib/py/utils.py
> @@ -104,13 +104,32 @@ class cmd:
>      def _process_terminate(self, terminate, timeout):
>          if terminate:
>              self.proc.terminate()
> -        stdout, stderr = self.proc.communicate(timeout=timeout)
> +        timed_out = None
> +        try:
> +            stdout, stderr = self.proc.communicate(timeout=timeout)
> +        except subprocess.TimeoutExpired as exc:
> +            # terminate() is only a request, and bkg() with exit_wait or
> +            # ksft_wait never sends one, so kill rather than leave the child

[Severity: Low]
Is this comment accurate for exit_wait? When the with-body raises and the
child is still running, bkg.__exit__() in this same file does send
terminate for an exit_wait bkg():

    if self.proc.poll() is None:
        terminate = terminate or (self._exit_wait and ex_type is not None)

Callers can also call process(terminate=True) on an exit_wait bkg()
directly. The next patch in the series does this in run_tls_test() with
pending.process(terminate=True, ...).

The statement seems to hold only for ksft_wait, and for exit_wait when no
exception is in flight.

> +            # running. That does not stop a command run over ssh on the
> +            # remote; it needs a bound of its own.
> +            self.proc.kill()

[Severity: Medium]
Does this kill() reach the process that is actually doing the work?
Popen.kill() sends SIGKILL only to the direct child pid. cmd.__init__()
creates the Popen without start_new_session or a process group, so the
whole tree can't be killed with os.killpg().

In several setups the workload is not the direct child:

remote_ssh.py Remote.cmd():
    return subprocess.Popen(["ssh", "-q", self.name, comm],

Here only the local ssh client is killed, and the remote command keeps
running.

remote_netns.py Remote.cmd():
    return subprocess.Popen(["ip", "netns", "exec", self.name, "bash", "-c", comm],

With compound commands (pipelines, ;, &&, or loops such as the for loop in
rss_flow_label.py), bash forks children that survive SIGKILL to bash. The
same is true of bkg(shell=True) with a compound command.

In these cases the inner except branch below reaps the dead direct child,
drops the output and re-raises. The workload is still alive when the
caller's defer/teardown runs. Isn't that the same ordering problem the
commit message says this patch fixes?

The code comment mentions the ssh case, but the commit message doesn't
mention any limitation. Would a complete local fix need start_new_session
plus os.killpg()?

> +            try:
> +                stdout, stderr = self.proc.communicate(timeout=1)
> +            except subprocess.TimeoutExpired:
> +                # A grandchild (shell=True, ssh) still holds the pipes.

[Severity: Low]
Should this comment, and the ssh comment above it, also mention the
remote_netns backend? remote_netns.py Remote.cmd() wraps every remote
command in ip netns exec <ns> bash -c comm. The forked parts of compound
commands can survive kill(), keep the pipes open, and take this same path
while the workload keeps running inside the namespace.

> +                self.proc.wait()

[Severity: Medium]
Can this wait() block forever? It has no timeout. The comment assumes that
only a grandchild can still hold the pipes here, but the direct child may
still be alive too.

SIGKILL doesn't act on a task in uninterruptible sleep until the task
leaves that state. Two examples: an ip command blocked in
mutex_lock(&rtnl_mutex) while RTNL is held indefinitely, or ip link del
stuck in the msleep() loop of netdev_wait_allrefs_any() because of a
leaked netdev refcount.

In that case the child still holds its own stdout/stderr, so
communicate(timeout=1) times out. wait() then blocks for as long as the
task stays in D state.

Before this patch, _process_terminate() always returned or raised
TimeoutExpired within timeout. Now the harness hangs instead of reporting
a failure. ksft_run can't record the failure, run defer() cleanup, or move
on to later cases.

The helper is shared, so this affects foreground cmd() as well as bkg().
Would a bounded wait be safer here?

> +                stdout, stderr = b"", b""
> +            timed_out = exc
> +
>          self.stdout = stdout.decode("utf-8")
>          self.stderr = stderr.decode("utf-8")
>          self.proc.stdout.close()
>          self.proc.stderr.close()
>          self.ret = self.proc.returncode
>  
> +        if timed_out:
> +            raise timed_out
> +

[Severity: Low]
The commit message describes a change to bkg() only, but
_process_terminate() is shared. Foreground cmd() reaches it through
cmd.__init__() when background is False:

    if not background:
        self.process(terminate=False, fail=fail, expect_fail=expect_fail,
                     timeout=timeout)

The ksft_ready init-failure path also calls it directly with timeout=1.

With this patch, any foreground cmd() that hits its timeout now gets
SIGKILL, and ret/stdout/stderr are filled in before TimeoutExpired is
re-raised. Before, the child was left running and those fields stayed
None.

No in-tree caller seems to rely on the old behaviour. Could the commit
message mention this change?

[ ... ]

-- 
Sashiko AI review · https://netdev-ai.bots.linux.dev/sashiko/#/patchset/20261119191341.4089157-1-rjethwani%40purestorage.com
