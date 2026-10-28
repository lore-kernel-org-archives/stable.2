Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=100.103.45.18
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1793224914;
	b=GKvyv3hqYXkIDuzAofDWS9/j8c4D+ItSUUR5wxJIbcndp6X1elhtP+PYFvTGX8fb6+2A
	 ROiVUsXAlKFXi83H/eohJl9VTWbpenAuccN0XuDrAYZ1tAjaQDCkk1CnZm868ONUQBc2f
	 9KqDAKlJEOXsc64N8fqKvq171v70laKoyiwf0Rxd8Qq+3WeGwQUvme4AOVTYOAUSE0U7f
	 NNEajUWqeSXJVp9cWEEc4/v7iSknhIMECzUBTjCENEGN50dOVzWUn95INlxtT2JrmJU34
	 w1LuC8Kyji2Z2nyPHwq7o6nkB9ywbIr0OwKunhchs6O9K/eokqhjDdaayTAsQIUFrFw==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1793224914;
	h=Received:DKIM-Signature:From:To:Cc:Subject:Date:Message-ID:
	 In-Reply-To:References:Auto-Submitted:Content-Type:
	 Content-Transfer-Encoding:MIME-Version;
	bh=Z9zRtXHe/J1k/4/9wAeq1n+PwAt+ioXmV3zyjSNrjDw=;
	b=olz9/JuFGtTWQqY0Xh4tmWjM5lmLEdh9/zXH3C2ydprrMZf+/l+e4LZlDxMViopeq5sA
	 ba8YB1qDg/unaqXEYnqreesRyfIVBJ/Mmfuub5AOPYfWBR+jH5bBTtJHvVyqRgRXr2vxX
	 gADu7Aqwots5s6R/ITsVrvgbfcEbbxkoORzAjbxKzjpsR1rczVqO+ubwKAtxQQAiaAIaM
	 GhPGHXjARsqiJ67JbY4Rl3rHz7eQHM3Zfk4mw6if1fYNxUO0H33YZe5o5owfyhnhQZeE+
	 yvNH7bbGAKSB8hJIQWHj6KcAul29waJbaUf+tm1qOEMs6NAkeaHTcpQHo8aW4dZdyEg==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dkim=pass header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b="XKMO+/FM";
	arc=none smtp.remote-ip=100.103.45.18
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id ACEEB606A31D;
	Wed, 28 Oct 2026 22:01:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=XKMO+/FM
Received: by smtp.kernel.org (Postfix) with ESMTPSA id BD84D1F01828;
	Wed, 28 Oct 2026 22:01:52 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1793224913;
	bh=Z9zRtXHe/J1k/4/9wAeq1n+PwAt+ioXmV3zyjSNrjDw=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References;
	b=XKMO+/FMDZApYX6lUaZ2BM1xTBQ2S47xscp94+yOWwHlemFhFSs1MfP00E0gtxlmu
	 OOVEhd7CsJhVjPEld2gKvct6qmX1sl/8C82xtmbmY0A/+whIreBjwfwF+TcC5J+ykv
	 4TCZ+PF1464Ngo0CPDHvospQPTtfw11QoSrH+y5TKyuLGT4VLJSW6QEGvwiaiTOygX
	 lLUPbMHeUbByOvHP1gxo5PPomxnEwL2M09hTVWzXW0yMf00aTLsaPMS9Z8MU/YsAGa
	 NT8/LmLzhlQxxeHcL8cxY1o9hlf+ReFeuZt+F0/iQh9E7Ykiloa/S7S8DMT1m+wYez
	 Btf+E0h09tm0g==
From: netdev-bot+sinfo@kernel.org
To: Manjunath Patil <manjunath.b.patil@oracle.com>
Cc: "netdev@vger.kernel.org" <netdev@vger.kernel.org>,
 Eric Dumazet <edumazet@kernel.org>, "David S. Miller" <davem@davemloft.net>,
 Jakub Kicinski <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>,
 Simon Horman <horms@kernel.org>, Alexei Starovoitov <ast@kernel.org>,
 Daniel Borkmann <daniel@iogearbox.net>, Willem de Bruijn <willemb@google.com>,
 "bpf@vger.kernel.org" <bpf@vger.kernel.org>,
 "stable@vger.kernel.org" <stable@vger.kernel.org>
Subject: Re: [PATCH net] tcp: restrict SO_ATTACH_BPF to privileged users
Date: Wed, 28 Oct 2026 22:01:52 +0000
Message-ID: <179322491231.3327.15319780841099571485@kernel.org>
In-Reply-To: =?utf-8?q?=3CCY8PR10MB66609715D3216D1B10CC186ACF6F2=40CY8PR10MB?=
 =?utf-8?q?6660=2Enamprd10=2Eprod=2Eoutlook=2Ecom=3E?=
References: =?utf-8?q?=3CCY8PR10MB66609715D3216D1B10CC186ACF6F2=40CY8PR10MB6?=
 =?utf-8?q?660=2Enamprd10=2Eprod=2Eoutlook=2Ecom=3E?=
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
