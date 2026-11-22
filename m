Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=100.103.45.18
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1795332582;
	b=CdwcChLk40Vyc4sZ3mlyuyBui+px+57BsgW3CGy3PMkH8Un6UPK5qQa45b+1RXdOF1C7
	 Sj8x8dEjTFE99gsrUEjdU24rF6Bwbh7A1HC69ObHl9qUr1RZeaLLQ08/Ze73BcxxJ/+va
	 xMssudE5iByen6VYyJhxRPvz0x+3XgRdZbifhYso3Un9vRLya16Q+jJtuo475P4tMtcSn
	 mG/FZfHlg2hP5F8LieR9o0hst0tZO62TkQ9WOHLW/91W24EH7pDD1ARkf0wdj2NuHulLZ
	 HlYVjNBHRNyr7x1BDiLS4SGRmjT+jHFrLyZCCPcVoAowCKdkpnua8DruV1MeGuZNxRw==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1795332582;
	h=Received:DKIM-Signature:Subject:From:To:Cc:Date:Message-ID:
	 In-Reply-To:References:X-sashiko-severity:Content-Type:
	 Content-Transfer-Encoding:MIME-Version;
	bh=HiA9PYZbAt9pSqWEX/fj1U6pPBAqKzZsNmZT9z0VVZs=;
	b=sXLy9q4/wt+N1AZxClYrk4doGvUJuLd0p8k5qKTUXLG0g6Ew4LZZaA4IRX+k20CUYDic
	 908TnJuAAlkXQ5yWCWGJ71RKTSmtUZnwYJczB5nMBegR74OayI1cVih+HJMi1cquUqGIV
	 LRQ9+yMdnbGi7dtqMB7f3W6GdM26cdq5plE2PlpIENO2MtF8RT+jMQJ1OxJmoyRUHMQE/
	 aVOMDbELlfpImvi9ZSk2X03N/50v80OLFtU0nbPrrxeY4USlo0KoU64sYItt8TY18061k
	 7m4G0w4QgM9XJHRpZPT3a4kSylIuTHVFIXO88vGEsPkVHI/dKdgA1jLywOq75/d5U3Q==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dkim=pass header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=MRiyKbKO;
	arc=none smtp.remote-ip=100.103.45.18
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D4361606A339;
	Sun, 22 Nov 2026 07:29:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=MRiyKbKO
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 06D8A1F000C0;
	Sun, 22 Nov 2026 07:29:41 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1795332582;
	bh=HiA9PYZbAt9pSqWEX/fj1U6pPBAqKzZsNmZT9z0VVZs=;
	h=Subject:From:To:Cc:Date:In-Reply-To:References;
	b=MRiyKbKO6PQN6irifYg0CjjvrKrfqPk+LTEePHIgOcpSd2Ntwpr69j+XfY6rWMPVG
	 XJzvHvuJf2rChX5yusT6p1/rsGJ8u97Q803jTEVmUaEDkVboBvruXN1M9gE2PKJsxZ
	 U8tyz8da3mH6BbVENKZqz+Bu6dGMdYZ5CMl64V9H7SK0X+JfTRWbq4iEwg0/beslre
	 9UO7YOuOytQ0lekIbAPp7McbtsBrMG2uqoWbfF+NpC3+jHxkEIV6lGfscckHlf+zdi
	 pEP6qlMC2NEJjvy4oqwa+dtqGRj78eH+t7srb/nWefIhDCgq3gwUyqvSVId5Eu6v2d
	 cqTxqqvKqUfPg==
Subject: Re: [PATCH net v5 2/2] selftests/net/openvswitch: check that a failed
 set keeps the features
From: netdev-bot+sashiko@kernel.org
To: houminxi@gmail.com
Cc: netdev@vger.kernel.org, aconole@redhat.com, echaudro@redhat.com,
 i.maximets@ovn.org, davem@davemloft.net, edumazet@kernel.org, kuba@kernel.org,
 pabeni@redhat.com, horms@kernel.org, shuah@kernel.org,
 linux-kselftest@vger.kernel.org, stable@vger.kernel.org, matttbe@kernel.org
Date: Sun, 22 Nov 2026 07:29:41 +0000
Message-ID: <179533258159.3135.906610390890565632@kernel.org>
In-Reply-To: <20261118065435.2367014-3-houminxi@gmail.com>
References: <20261118065435.2367014-3-houminxi@gmail.com>
X-sashiko-severity: Low
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

Thank you for your contribution! Sashiko AI review found more severe
issue(s) in other patches of this series. This mail is only an FYI, in case
you want to address the nit picks below when you respin.

Low priority / nit picks for your consideration:

- [Low] The Reported-by trailer probably does not belong on this commit.
- [Low] A comment in the new set-dp branch of main() in ovs-dpctl.py says
  something the kernel does not do.

--

selftests/net/openvswitch: check that a failed set keeps the features

This adds a set-dp subcommand to ovs-dpctl.py that sends OVS_DP_CMD_SET.
It also adds two selftests, dp_features and dp_features_recirc. They check
that a set rejected for an empty per-cpu-pids leaves the datapath features
unchanged. The config fragment also enables NET_SCHED, NET_CLS_ACT and
NET_TC_SKB_EXT for the recirc test.

Link: https://lore.kernel.org/netdev/998d522f-e61d-420f-9834-6bdcbaab1361@kernel.org/

> Reported-by: Matthieu Baerts <matttbe@kernel.org>
> Link: https://lore.kernel.org/netdev/998d522f-e61d-420f-9834-6bdcbaab1361@kernel.org/

[Severity: Low]
Does this Reported-by belong on this commit? The commit adds the set-dp
subcommand, the two new tests and three config lines. It doesn't fix an
existing defect.

The kernel bug these tests cover is fixed in the parent commit "net:
openvswitch: do not record user features when the change fails". That
commit has no Reported-by.

The commit message describes two problems:

- a run that hangs when stdout is duplicated
- a FAIL with no reason when the reason only goes to debug.log

Neither can happen with the baseline openvswitch.sh, because the
dp_features tests don't exist there yet. The report was probably about an
earlier, unmerged revision of this patch. The linked message couldn't be
checked from the tree.

Documentation/process/submitting-patches.rst says the tag "is intended for
bugs". Could feedback on an earlier revision be credited in the changelog
below the --- line instead? If Matthieu reported the kernel bug, the tag
could go on the kernel fix.

> diff --git a/tools/testing/selftests/net/openvswitch/ovs-dpctl.py b/tools/testing/selftests/net/openvswitch/ovs-dpctl.py
> index 1615843c225e4..efad71649a630 100644
> --- a/tools/testing/selftests/net/openvswitch/ovs-dpctl.py
> +++ b/tools/testing/selftests/net/openvswitch/ovs-dpctl.py

[ ... ]

> @@ -2961,6 +2980,23 @@ def main(argv):

[ ... ]

> +    setdpcmd.add_argument(
> +        "-p",
> +        "--per-cpu-pids",
> +        type=str,
> +        default=None,
> +        help="Comma separated upcall pids, an empty string sends none",
> +    )

[ ... ]

> @@ -3057,6 +3093,35 @@ def main(argv):
>              ovspk.upcall_handler(ovsflow)
>      elif hasattr(args, "deldp"):
>          ovsdp.destroy(args.deldp)
> +    elif hasattr(args, "setdp"):
> +        rep = ovsdp.info(args.setdp, 0)
> +        if rep is None:
> +            print(f"DP '{args.setdp}' not found.")
> +            return 1
> +        pids = None
> +        if args.per_cpu_pids is not None:
> +            # Empty entries are typos in a list the user did write, so drop
> +            # them. An empty string leaves pids as [] and not None, which
> +            # set() sends as an attribute with no payload: the kernel refuses
> +            # that with EINVAL, and the selftest counts on the refusal.

[Severity: Low]
Is this comment accurate? The kernel only looks at OVS_DP_ATTR_PER_CPU_PIDS
when the requested features include OVS_DP_F_DISPATCH_UPCALL_PER_CPU:

net/openvswitch/datapath.c:ovs_dp_change() {
    ...
	if (user_features & OVS_DP_F_DISPATCH_UPCALL_PER_CPU &&
	    a[OVS_DP_ATTR_PER_CPU_PIDS]) {
		/* Upcall Netlink Port IDs have been updated */
		err = ovs_dp_set_upcall_portids(dp,
						a[OVS_DP_ATTR_PER_CPU_PIDS]);
    ...
}

The !nla_len(ids) check that returns -EINVAL is inside
ovs_dp_set_upcall_portids(), so it only runs on this path.
datapath_policy[] has no entry for OVS_DP_ATTR_PER_CPU_PIDS.

That means set-dp <dp> --per-cpu-pids "" gets an ACK when --features lacks
bit 0x8. It also gets an ACK when --features is left out and the datapath
doesn't report 0x8. In both cases the tool prints "DP '...' updated" and
exits 0, not 22.

Both current tests pass --features 8, so they do get EINVAL. Could the
comment say that the refusal depends on the dispatch bit?

The --per-cpu-pids help text "an empty string sends none" has a similar
problem. An empty attribute is still sent, so the text reads as if no
attribute were sent.

-- 
Sashiko AI review · https://netdev-ai.bots.linux.dev/sashiko/#/patchset/20261118065435.2367014-1-houminxi%40gmail.com
