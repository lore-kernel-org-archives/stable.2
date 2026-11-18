Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=100.103.45.18
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1794995139;
	b=YnpoQwEPCszRFS+Dwg4NgZRuc3RMxUONocBYbjHsxuS99eyxnvygWIFcM/VdHLpeT5n7
	 2iRcyJsDQDX6H58F76o7IkE69C0k+P83GkKZX/v7XCdxTshnbGvSZKxFsuhTpq82Gomhe
	 Smg9Djk2ub1HftGE0VKJz/f8UUi6ALu5l5gu70Cq1+Qm3bhuEoiq7LVdN9VsIDYCG6AgP
	 PEq/wTUdsFkL+hMZqdS0wShUIbkd/iZfKaGpR+GJStEo/nFITM8wkmseihaPJJtekDQWI
	 1MNXEzpXifPkd4N4Qnb8WLEc9TW32QqklnhHy3Oq/at7fToBUs0t/j0PG/Vu9G+jbCw==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1794995139;
	h=Received:DKIM-Signature:Message-ID:Date:MIME-Version:User-Agent:
	 Subject:Content-Language:To:Cc:References:From:Autocrypt:Organization:
	 In-Reply-To:Content-Type:Content-Transfer-Encoding;
	bh=SbmhG6G9qez50HTqQGGBfci3phOw/cU5LI2SYmmFKKg=;
	b=1TUbfR0ySX6h2PLLsp8ZSojahrfO+z6eAxZAAq523gypxxXpea7hvBLjfcnChbENz+fs
	 ARZ9ba5vf8ZGygeXJ2LslwXbMvDakngdV3cJg0TxvmF6rPS18ag3mcyCi99uMEcg+K5r4
	 FHkwVocH3ZXcJBhTjehzpWUqo0BOpAUs6CwTZ54Ojb0yEp+k0xbzyf7QfW/budpHUpNAQ
	 28dtqOhKE0Y4LAKDMhWAet0zI0aeEddzR3QiIXvSvCLmUrQTHY2tjzfO4vk9rBPqG2H3z
	 0AA3+i2p6/1s44LPF4qcGtPhQWCjF1U9QSUQ4roeeY5VCwqHIBdttOJZEqrPgQfKCgA==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dkim=pass header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=owgIeihV;
	arc=none smtp.remote-ip=100.103.45.18
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 568DE606A32A;
	Wed, 18 Nov 2026 09:45:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=owgIeihV
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 5276D1F000C8;
	Wed, 18 Nov 2026 09:45:36 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1794995138;
	bh=SbmhG6G9qez50HTqQGGBfci3phOw/cU5LI2SYmmFKKg=;
	h=Date:Subject:To:Cc:References:From:In-Reply-To;
	b=owgIeihVihI+3CRb0lPoo2dqm8FMlfJm9nNM0JT1TchugvidsgbGgB9D8at6pF3mN
	 J3yVPZ9lYVKSrk/DkRNWqXgFQzVUUpVIoGfgwK70CVWQKY7gSmuphpHsuNEOChwvpX
	 1kdNTV8MuNMi7ah8wXuP7fFBfhXEDoLGoMdcD1eQjBU51lirCtfzCJyhe9/O2uxgOn
	 4TafjK37/JQFpv5AZBPpzwDd82Sk284BZ/6LPR5ZDgRR3AI+4u63rpgMMALazc/FEK
	 aFsq7CKbuUmdW4VEkuXyrm3MjyBYEr5mc7RNSdOX2pnx9qPn2V8zVQV6+FZqYOa2bB
	 cOrPzZZX2dX6Q==
Message-ID: <119b21d2-31de-4416-aeed-d1f04ffcfd82@kernel.org>
Date: Wed, 18 Nov 2026 10:45:32 +0100
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Post: <mailto:stable@vger.kernel.org>
List-Help: <mailto:stable+help@vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
List-Owner: <mailto:stable+owner@vger.kernel.org>
Precedence: list
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird Beta
Subject: Re: [PATCH net v5 2/2] selftests/net/openvswitch: check that a failed
 set keeps the features
Content-Language: fr
To: Minxi Hou <houminxi@gmail.com>
Cc: netdev@vger.kernel.org, Aaron Conole <aconole@redhat.com>,
 Eelco Chaudron <echaudro@redhat.com>, Ilya Maximets <i.maximets@ovn.org>,
 "David S . Miller" <davem@davemloft.net>, Eric Dumazet
 <edumazet@kernel.org>, Jakub Kicinski <kuba@kernel.org>,
 Paolo Abeni <pabeni@redhat.com>, Simon Horman <horms@kernel.org>,
 Shuah Khan <shuah@kernel.org>, linux-kselftest@vger.kernel.org,
 stable@vger.kernel.org
References: <20261118065435.2367014-1-houminxi@gmail.com>
 <20261118065435.2367014-3-houminxi@gmail.com>
From: Matthieu Baerts <matttbe@kernel.org>
Autocrypt: addr=matttbe@kernel.org; keydata=
 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
 lzVbFe7fduHbABmYz9cefQpO7wDE/Q==
Organization: NGI0 Core
In-Reply-To: <20261118065435.2367014-3-houminxi@gmail.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit

Hi Minxi,

Thank you for the new version.

On 18/11/2026 07:54, Minxi Hou wrote:
> Add a set-dp command to ovs-dpctl for the kernel's datapath SET command,
> and two tests that use it.
> 
> The first test clears the features of a fresh datapath, sets the dispatch
> bit with a valid pid list, and clears them again. It then sends a set that
> would set that bit with an empty per-cpu-pids. The request has to fail
> with EINVAL, and the datapath has to keep reporting the features it had,
> which a kernel that records them before the change reads as 0x8 instead of
> 0x0. A second request sends OVS_DP_CMD_NEW for that name from an outdated
> client, which makes the kernel drop the features, and a further set has
> to work.
> 
> The second test covers the recirc bit. It sets that bit on a fresh datapath
> and sends a set that would set the dispatch bit with an empty per-cpu-pids.
> The rejected request has to leave the recirc bit in place. A kernel that
> records the features first reads 0x8 there instead of 0x4. A datapath
> holds that bit only when the tc skb extension is compiled in, so the test
> prints the reason and skips when the kernel answers EOPNOTSUPP, and any
> other failure of that request fails the test. CONFIG_NET_TC_SKB_EXT
> depends on CONFIG_NET_CLS_ACT and both sit under CONFIG_NET_SCHED, so the
> selftest config fragment selects all three.
> 
> The reference count itself is not visible from user space, so the steps
> that use an outdated client only show that those paths run and that a
> datapath keeps working across them.
> 
> set-dp sends the features it is given. When --features is left out it
> sends the features the datapath reports, and it refuses to send the
> request when the datapath reports none. A pid list that is not a list of
> numbers is reported as such, and empty entries are dropped.
> 
> A failing run deletes debug.log, and ovs_sbx sends a command's stdout into
> that same file, so the tests report a failure reason on stderr. stderr
> still reaches the test runner from inside ovs_sbx, and unlike a duplicated
> stdout it is not a second handle on the runner's pipe. The daemons the
> suite starts outlive the script, and one that inherits such a handle keeps
> the pipe open after the script exits, which leaves the run hanging until
> the harness times out.
> 
> Every step that can fail says why it did. A datapath that cannot be read
> is reported as that rather than as a feature mismatch: ovs-dpctl prints a
> missing datapath and exits 0, and it leaves the features line out when the
> kernel does not report them, so the check reads both cases from the output.
> 
> Reported-by: Matthieu Baerts <matttbe@kernel.org>

No need to send a new version for that, but next time, I think it would
be better to include an individual changelog per patch in the notes
(under '---'). There, you can mention that the v5 addresses the error
visible on the CI that I reported, instead of adding my Reported-by tag
here: I didn't report the whole issue that makes you write the patch.

(I didn't review the patch, but I can see you did some modifications)
 https://netdev-ctrl.bots.linux.dev/ansiview.html?f=/logs/build/1214612/diff/b4-diff.ansi

Cheers,
Matt
-- 
Sponsored by the NGI0 Core fund.

