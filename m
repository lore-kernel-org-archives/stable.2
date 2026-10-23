Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=100.103.45.18
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1792757851;
	b=poKZTc3qs1/joJF2GPgc7gbUOPY+BHS9ouacAT/35f+mCGL6ioB7d8tQngKm4sKToJd3
	 MRmkLY2UwjEGO3oykHF/c9Lm5CjEo8sjPhlbQcPFazBhWvQsdXtHl5XjUbDuui4U3n/W2
	 q/Y1a9oWIXjo7Tc+f6f8bUpJn1Z9W/Qhdl8U81OAJ1mq9lsuFj64zMHM3MJ/a2Ixzn0FX
	 Lf7kDiHgPnce3ODKKE76tsWLjTiiajKrk10Ioroned1HW74+BPfzRaNyKX1uRHslQG1PA
	 jcAGxMhISTahXHZizNhMt4q9D8lFYso5yGWE6Rc8P4XQZ44QehJ1zff4K89cIi2SIuw==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1792757851;
	h=Received:DKIM-Signature:Subject:From:To:Cc:Date:Message-ID:
	 In-Reply-To:References:X-sashiko-severity:Content-Type:
	 Content-Transfer-Encoding:MIME-Version;
	bh=ZS0tn8pzkY5HcTliLlyUVVAHnTt7rsmSXjxCSEoW0tY=;
	b=2xu9nTIyuSPt5QQ2eh/FYcV/uCWIgZwMaj/1Dx9Wrsrpz00zOD9or6pvVqifVKpNuGDL
	 S+kG1T6qLgbvEn3ACPWIM2Gypb7w6HqQXUKhjQoizo1x1hBW4fk5wcmw2Yby/q6lFqnSZ
	 K7RwI8vFw58MRW9gI9kneK+Mwt1YN1kJjYD+4DoHD0txXlohMwbcasw7ghbCz7VK9EuSU
	 cYtAM0nlNqj+6970rZOohcusy9V7OYW2o9rMH/nneLBCnLGUsDX7+QYPlIC6/KVCeXUwT
	 WiRZbMImffYWfgLrQJplCOO/wJz5DWjiqA4Otc/tleCSxRtb9Af9u1bbrSkLENFcikw==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dkim=pass header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=VGsDioPt;
	arc=none smtp.remote-ip=100.103.45.18
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3272460A382D;
	Fri, 23 Oct 2026 12:17:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=VGsDioPt
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 50E961F01825;
	Fri, 23 Oct 2026 12:17:30 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1792757850;
	bh=ZS0tn8pzkY5HcTliLlyUVVAHnTt7rsmSXjxCSEoW0tY=;
	h=Subject:From:To:Cc:Date:In-Reply-To:References;
	b=VGsDioPt2yF8NSWQwxO6dGAiED0swBBTttENZgSF5VJMprvGVzbkmlqIPI5N+ePko
	 ySymTd96KuQu+MGJi5ufr3fw4Wsv4OmyEfPCSNwTVDSorJpGMgiAA9iRGwqvQpBYfa
	 7rs2vd1l2W4oQuJvF612JUWeeEdgdIIsJMLnLqi33j/fgDZIZDWSezGnbyr7CxBSRK
	 0buO91fKABTT4g0/XZcWX/39eljU3moUSj9DITvkHPY7PA146Cx3fCzf5x0p1NSHZE
	 jVCQ/M/JshqV5wM7PlaM29yl7Fm4uu+h3OWDrhxx2UCsBZkBcMocGZJdnYSWw9wHUQ
	 FrzDKWuH14j0w==
Subject:
 Re: [PATCH net 7/7] selftests: ovpn: avoid calling freeaddrinfo() on NULL
From: netdev-bot+sashiko@kernel.org
To: antonio@openvpn.net
Cc: netdev@vger.kernel.org, ralf@mandelbit.com, sd@queasysnail.net,
 kuba@kernel.org, pabeni@redhat.com, andrew+netdev@lunn.ch,
 davem@davemloft.net, edumazet@google.com, stable@vger.kernel.org
Date: Fri, 23 Oct 2026 12:17:29 +0000
Message-ID: <179275784988.3134.15557022121900385681@kernel.org>
In-Reply-To: <20261022121606.732029-8-antonio@openvpn.net>
References: <20261022121606.732029-8-antonio@openvpn.net>
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

- [Low] The Fixes: tag in commit "selftests: ovpn: avoid calling
  freeaddrinfo() on NULL" names the wrong commit.

--

selftests: ovpn: avoid calling freeaddrinfo() on NULL

This patch changes the exit path of ovpn_parse_remote() in
tools/testing/selftests/net/ovpn/ovpn-cli.c so that freeaddrinfo() is
called only when result is non-NULL. On musl, passing NULL to
freeaddrinfo() makes ovpn-cli segfault.

> ovpn_parse_remote() always calls freeaddrinfo() on its exit path, but
> result is NULL when no vpnip was passed (with or without a remote host).

[ ... ]

> Fixes: 959bc330a439 ("testing/selftests: add test tool and scripts for ovpn module")
> Cc: stable@vger.kernel.org

[Severity: Low]
Does this Fixes: tag point at the right commit?

In 959bc330a439, result had no initializer, and the host branch in
ovpn_parse_remote() did not free or reset it:

    struct addrinfo *result;
    ...
        memcpy(&ovpn->remote, result->ai_addr, result->ai_addrlen);
    }

So with a host and no vpnip, the out: label freed the valid list that
getaddrinfo() returned. The CMD_CONNECT path in main() is one such caller:

    ret = ovpn_parse_new_peer(ovpn, argv[3], argv[4], argv[5],
                              argv[6], NULL);

With no host and no vpnip, out: received an uninitialized pointer, not
NULL.

The NULL case looks like it came from commit 0bd9cfebc1c9
("selftests/net: ovpn: fix getaddrinfo memory leak in
ovpn_parse_remote()"). That commit added both of these:

    struct addrinfo *result = NULL;
    ...
        freeaddrinfo(result);
        result = NULL;

The commit message of 0bd9cfebc1c9 also describes the no-host, no-vpnip
case in 959bc330a439 as an uninitialized pointer.

So the statement "result is NULL when no vpnip was passed (with or
without a remote host)" only holds once 0bd9cfebc1c9 is applied. Should
the tag be this instead?

    Fixes: 0bd9cfebc1c9 ("selftests/net: ovpn: fix getaddrinfo memory leak in ovpn_parse_remote()")

The context of the modified hunk has not changed since 959bc330a439. With
Cc: stable, the patch would also apply cleanly to stable trees that lack
0bd9cfebc1c9.

In those trees, wouldn't the new if (result) check test an uninitialized
pointer on the no-host, no-vpnip path, so the patch fixes nothing there?

-- 
Sashiko AI review · https://netdev-ai.bots.linux.dev/sashiko/#/patchset/20261022121606.732029-2-antonio%40openvpn.net
