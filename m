Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=100.103.45.18
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1792489708;
	b=YQGMWsfl2PZqHpuzxvsXhiQK91mMRFKKUQigK0uWq1LmWUD70ao7Sz3KEqmSnSo+wH/+
	 sXfyC9nm2r615qVknGar/hxaCc401qqlEH3TwE5tuhZ/lEWT+8Gf9LUGOwEkR7lMN1zta
	 q/73tZTK+dDmdvnIwUTqGqUuVSQm9DkyMtkDkcHvpzeQHTaCRVS+IQZLlLBWdmXCARgwL
	 FmlMZYTCMj5KaVBasIj76ojItJLWkcdlOMdZttL82MuFN1F3v67DXmlGWqH3V5Y4l+cgD
	 oS+gyaBYD0IO91FGv4An8QyK80c3g4dnxfMUA3V+x6jhbp29gX0m3XcY5Z5q/5pObaA==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1792489708;
	h=Received:DKIM-Signature:From:To:Cc:Subject:Date:Message-ID:
	 In-Reply-To:References:Auto-Submitted:Content-Type:
	 Content-Transfer-Encoding:MIME-Version;
	bh=Z9zRtXHe/J1k/4/9wAeq1n+PwAt+ioXmV3zyjSNrjDw=;
	b=T2pUOwULdMQRQF2BRI5DkMaNkVBjQIe+0hhO00dCMT6F9yLrFSVDUC9JoIusKVdxgoQu
	 8K0eoAhYSqkP0liYbFAEZsFtZdkZpFEWW9XFkfRXHPS3lfhx/joOC2SxrZpc9gOi1ZRkl
	 4znVGQPh2tozNDxzdmLJnvy3mQq3Vjgshaq4FpTJ38DHkt7lNgcRvcwE9fyP1BDKjrDY8
	 yObFWDMAzDGofdklhXTcl4UmmyevL46oCGeSi6KqIPdzHIK1BoUYURg90C+rhSbY160cL
	 U0hWlEHzPU238Q0xcCzfV7fmWo5s/bOX42l/Imczsl/sk7Ut/1U1chl+przGowcnDNA==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dkim=pass header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=bY9VA6dS;
	arc=none smtp.remote-ip=100.103.45.18
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1DA8A606A319;
	Tue, 20 Oct 2026 09:48:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=bY9VA6dS
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 1F5241F000C4;
	Tue, 20 Oct 2026 09:48:27 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1792489707;
	bh=Z9zRtXHe/J1k/4/9wAeq1n+PwAt+ioXmV3zyjSNrjDw=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References;
	b=bY9VA6dSEs2HbxjGvNK9JohXLPYVMAmF0EG/I++H4TG/w6oCtTmOPY16Whh/4+2bl
	 CUs4PSpHuwCDwGEnbI2LtYeCZ9a5Ye6FTUWG2DRvjzqlHQ+Z7Cy+gmp9zqMpjxVLE4
	 p4iPtwY/pmPi7l4HVmvu1mhseCk9+TyxpXJIzQoH8CyugTiIYUKnI0GKg3YyYUHXAD
	 baaG4/Jb9gP+X+BAqW8EwcjKgLxA5Y33Kbpc7yJQFrR10EQN5CuewQpn8d/wB28H0p
	 D/c0FJbd9VLuHCHQojnHJdTIxZrk1gaxjzrRF7C/WM7ue4RsjmIPjzEDCyd+pYiOtg
	 9NgKEE7CM5YSQ==
From: netdev-bot+sinfo@kernel.org
To: liuc63 <liuc63@xiaopeng.com>
Cc: M Chetan Kumar <m.chetan.kumar@intel.com>,
 Loic Poulain <loic.poulain@oss.qualcomm.com>,
 Sergey Ryazanov <ryazanov.s.a@gmail.com>,
 Johannes Berg <johannes@sipsolutions.net>, Fang Xieyan <fangxy@xiaopeng.com>,
 netdev@vger.kernel.org, linux-kernel@vger.kernel.org, stable@vger.kernel.org
Subject: 
 Re: [PATCH] net: wwan: iosm: validate msg_head before indexing msg_ring
Date: Tue, 20 Oct 2026 09:48:26 +0000
Message-ID: <179248970663.3290.12171983741901955198@kernel.org>
In-Reply-To: <20261020094254.4017726-1-liuc63@xiaopeng.com>
References: <20261020094254.4017726-1-liuc63@xiaopeng.com>
Auto-Submitted: auto-generated
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Post: <mailto:stable@vger.kernel.org>
List-Help: <mailto:stable+help@vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
List-Owner: <mailto:stable+owner@vger.kernel.org>
Precedence: list
MIME-Version: 1.0

Hi!

This is an automated message. This series looks like a fix, but its
commit messages seem to be missing some information:

 - How the issue was discovered, e.g. hit in production, hit during
   development, syzbot report, manual code inspection, LLM or static
   analysis tool scan.

 - Whether the issue was actually triggered, or is only theoretical
   (e.g. found by code inspection). If it was triggered please include
   the symptoms, like the stack trace or error messages.

Please do not repost the series just to address the above. Instead,
reply to this email with the missing information, so that reviewers
can take it into account. If the series needs another revision for
other reasons, please include the information in the commit messages
then.

The evaluation is done by an LLM so it may be wrong, if you think
that is the case please reply and explain.
