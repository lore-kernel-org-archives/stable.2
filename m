Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 19A7A37F305;
	Mon, 28 Sep 2026 08:15:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1790583320; cv=none; b=Lu+lNIDG4a+Wi3bSzjdiG313lD8cs2qSl6Vvhx50T3nuYBqoNhNrC8nKLKqo2R0Y3ZT61k19o7w7okTm4CT6HZW12R5yChB8VzaTjxF+2TUY9DH3w8XjZ3Lsl3DhJHbv8rxWBNVyWyWF7rfQUcozF3MihDnZgPPpCtzyPt1X+FQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1790583320; c=relaxed/simple;
	bh=x8GQ9TqAFu5driuvo38kqzYt3n324pebOlaNmEELI+s=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 Content-Type:MIME-Version; b=jzBm9PWY/VoNK3/BRmP+GHP4ostCzmmxfryjKPC0Gc2/3BEd1JTyokXjCmYh6JeCEvd6dsI4iy8s8lqGsyoBHEMAvrL3LZZoCeEzOl4rHyktmBd2l8c8jrPiNFMH/nPCMH5KCPWrMA0J/Z1ODHxm3dbETcHZacyE74Ux3VEUw4E=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=KfoURJHT; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="KfoURJHT"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 54A1D1F0089A;
	Mon, 28 Sep 2026 08:15:18 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1790583319;
	bh=PJRu7W6/Or1we5Gv3BgoLEtby0D0Y0UGgfjBHfRc5+k=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References;
	b=KfoURJHTKnGTycGLdokkXjCLzPpfb47p+LY+pSJ0ghwKfh7Vbt5SeCqimAcFOZc2o
	 G83KjA50GfGr937arduWWd7wiaNsGY3w9xAoFEYVysdZi65VSawr3s4LEvyti+Cs7Q
	 8MJ6Zyvrx0xwhmkXKRSDQu7U907cTD7Ktenjv+1KvqdyYcq/4UR22tFsWCUkKotzwv
	 ZPIccZtbnamXuWqRelLH/qYK+ZUGNWMF75SldmPnju23vSkMkCckFZpBx3RUJ9HJvv
	 a6qggAZrjnGQHyFGfry2bqBIHhCinsmzxl7mY5sFE9iR86Ea1zHmme6a5N/+TDnLp0
	 Zza2zsPliN7WQ==
From: netdev-bot+sinfo@kernel.org
To: Quchaosheng <quchaosheng000406@163.com>
Cc: Willem de Bruijn <willemdebruijn.kernel@gmail.com>,
 "David S. Miller" <davem@davemloft.net>, Eric Dumazet <edumazet@google.com>,
 Jakub Kicinski <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>,
 Simon Horman <horms@kernel.org>, netdev@vger.kernel.org,
 linux-kernel@vger.kernel.org, Marc Kleine-Budde <mkl@pengutronix.de>,
 Oliver Hartkopp <socketcan@hartkopp.net>, stable@vger.kernel.org
Subject: 
 Re: [PATCH v2 net] net/packet: guard the ll header push in packet_rcv_spkt()
Date: Mon, 28 Sep 2026 08:15:17 +0000
Message-ID: <179058331782.31693.12350465700616409287@kernel.org>
In-Reply-To: <20260928080919.1888649-1-quchaosheng000406@163.com>
References: <20260928065000.1749383-1-quchaosheng000406@163.com>
 <20260928065000.1749383-2-quchaosheng000406@163.com>
 <a56a3e49-ffdf-4285-bca6-992b12127289@hartkopp.net>
 <20260928080919.1888649-1-quchaosheng000406@163.com>
Auto-Submitted: auto-generated
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0

Hi!

This is an automated message. This series looks like a fix, but its
commit messages seem to be missing some information:

 - How the issue was discovered, e.g. hit in production, hit during
   development, syzbot report, manual code inspection, LLM or static
   analysis tool scan.

Please do not repost the series just to address the above. Instead,
reply to this email with the missing information, so that reviewers
can take it into account. If the series needs another revision for
other reasons, please include the information in the commit messages
then.

The evaluation is done by an LLM so it may be wrong, if you think
that is the case please reply and explain.
