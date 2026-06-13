Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BC2C730AD0A;
	Sat, 13 Jun 2026 21:32:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1781386377; cv=none; b=ggx0yZXvi4nJfvZ2VY6AskxIpEq3ecK4j54Ju9LgLXfv/KWMmqFuc3l2sRaZXDyfqWcasB5LOuLMz14RF6Roc1DN777gl2fqkKwtMNTnG3LP/JlsuNvN6vM69EC4cuh84WszPoN21XtOhASSb7y7RpCS1F+2aUxOg4ZuYRm91r8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1781386377; c=relaxed/simple;
	bh=1ePKK1uBddvt8IcbqEa6hzeh6HaEwuiVvRdF2I8sBcM=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=Ocf5SD7MHpdnc10RUM6jq8I/EV0f/NfUXLeKwU1Ixnc318UntQchnfMsWP11IV7JuCDWmDwYWLhJ/vENgwzqSXCF/Qje6CbszgghZ1OPuNpazWw/9Zgni0EEDhFjyJNooc7wIfv/asQtqAmj9bQD/o5BbhkmPKuxhEElWVcSDt8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=JdQF043+; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="JdQF043+"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id A2DF71F000E9;
	Sat, 13 Jun 2026 21:32:55 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1781386376;
	bh=YB1JXlPzAQ3TuwLY8z4xGmL3KXEI9zb1N75EJCQ/LDs=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References;
	b=JdQF043+uFhcasM3V54cbTs4EzE6labIe/wpvptCORM/1C3CaYDEQ36gDWTJ0eNUn
	 OMfRrxmNDYWptiEL6V92MgFj2/9zm8Gi4vEkGKv5lhWl52ank5AETAMC/Jqq5aGe9W
	 X7rOgenKPCOcAM4g6w1Q/WXH5FUInVw+7UEmQQOpPsLr/b3ZDuuYvP5gYxWISTQ8Hl
	 iD3sff/Ky5OBXpP4fVqtEFxEAmkxSePdIOtqLa5KQaAuXoPFu+DnI31uOXrnxooums
	 03Ci9inpN+CopkXP/8B2chRm6Heqjzie+6G8UQYCUORuitTGRfpAfvO2ij1S3yaNZd
	 dGhyZTys2No3w==
From: Jakub Kicinski <kuba@kernel.org>
To: ross.porter@canonical.com
Cc: Jakub Kicinski <kuba@kernel.org>,
	linux-kselftest@vger.kernel.org,
	netdev@vger.kernel.org,
	stable@vger.kernel.org,
	edoardo.canepa@canonical.com,
	davem@davemloft.net,
	edumazet@google.com,
	pabeni@redhat.com,
	horms@kernel.org,
	shuah@kernel.org,
	oscmaes92@gmail.com,
	bacs@librecast.net,
	linux-kernel@vger.kernel.org
Subject: Re: [PATCH 1/1] selftests: net: fix file owner for broadcast_ether_dst test
Date: Sat, 13 Jun 2026 14:32:54 -0700
Message-ID: <20260613213254.174421-1-kuba@kernel.org>
X-Mailer: git-send-email 2.54.0
In-Reply-To: <20260610062230.71573-2-ross.porter@canonical.com>
References: <20260610062230.71573-2-ross.porter@canonical.com>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

This is an AI-generated review of your patch. The human sending this
email has considered the AI review valid, or at least plausible.
---
selftests: net: fix file owner for broadcast_ether_dst test

This commit ensures the tcpdump output file in the broadcast_ether_dst test
is always owned by root by passing the -Z root argument.

> diff --git a/tools/testing/selftests/net/broadcast_ether_dst.sh b/tools/testing/selftests/net/broadcast_ether_dst.sh
> --- a/tools/testing/selftests/net/broadcast_ether_dst.sh
> +++ b/tools/testing/selftests/net/broadcast_ether_dst.sh
> @@ -44,7 +44,7 @@ test_broadcast_ether_dst() {
>  	# tcpdump will exit after receiving a single packet
>  	# timeout will kill tcpdump if it is still running after 2s
>  	timeout 2s ip netns exec "${CLIENT_NS}" \
> -		tcpdump -i link0 -c 1 -w "${CAPFILE}" icmp &> "${OUTPUT}" &
> +		tcpdump -i link0 -c 1 -w "${CAPFILE}" icmp -Z root &> "${OUTPUT}" &

[Severity: Medium]
Will this tcpdump command fail with a syntax error in test_broadcast_ether_dst()
on systems that use musl libc or when POSIXLY_CORRECT is set?

By placing the -Z root option after the positional filter expression icmp,
standard POSIX option parsing will stop at the first non-option argument.

While this works on glibc systems because getopt() permutes arguments by
default, on strict POSIX systems tcpdump might treat -Z root as part of the
filter expression. This would concatenate the arguments into "icmp -Z root"
and cause a fatal pcap filter compilation error, breaking the selftest
unconditionally in those environments.

Could the -Z root argument be moved before the icmp filter expression?
-- 
pw-bot: cr
