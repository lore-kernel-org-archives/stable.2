Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8D7B237E2ED
	for <stable@vger.kernel.org>; Sun,  9 Aug 2026 03:25:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1786245926; cv=none; b=KO23FjxzSUeCI0F3mX92pt50dg47ukJyaYgOKo1YZyFlquBcBbrS9bPTmTjX36nDX5HG6zkXb/1RHmwFWCf9JNbylZ0Sb+rXSKxPQ+7a4j79yxPu7i3j7afGIbWBwqcOV83T+Pp6XVGACFYEX2uAP3GGWoe0J1/jv4alEQfliOQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1786245926; c=relaxed/simple;
	bh=+FIEym62IJwB1RRySFm3lLSOuFRLJBAKrIUEkElR2/A=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=jCRbARKGqOUpADAm0gcDBwsJDcIEMiC48P5pweXgKJnTBFWgl771M1Z8W6M45IzuiDFBBB+YCL5m2NyamV1h/nshkk+MRjkv4qS3z2Rm7S5gbpPPJxMM+GQ4qctA0sLjgBUdpck0mXD3UtwflkwI3U6ON+3VXNpXwyARJxCFDl8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=Q7tyeAkZ; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="Q7tyeAkZ"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 4AA2C1F000E9;
	Sun,  9 Aug 2026 03:25:24 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1786245925;
	bh=djSI9C+Fb/ZlxMQxmNFXt4g5udrhkB/6EcrOhhh546g=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References;
	b=Q7tyeAkZEh4Puj7WZm+HUwPAN09LJuEvFCgJyWBDzT1Aezdnp5NIZi3ZLZV7P1EaA
	 g3ojNR98iKaw2WutT7FVEttGbB1JB+V7E6gZ80xR1qmFUgAeO/LEos239VD9WuZBAg
	 M4jJaQfwl385e1xrnrHqC+EG+GO7C+2PBV6Dodg6WJ6eAMrw3UzEZDB5sqHAijtIWF
	 iSylEnmdXJ+j3PJHA+Jpolk1pRBKWXujzuSZdM7V9aZscWLN/PYc2/yQtIDN39vvPc
	 C01RIXJd6r/RSOoG+diPVHskPy618munJuiPvnYKY5lCJbtpQQuwBYmzGok/0mgpcp
	 oRG7Ms1bg312A==
From: Sasha Levin <sashal@kernel.org>
To: stable@vger.kernel.org
Cc: Sasha Levin <sashal@kernel.org>,
	kernel-team@android.com,
	Lee Jones <lee@kernel.org>,
	Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
	Siwei Zhang <oss@fourdim.xyz>,
	Luiz Augusto von Dentz <luiz.von.dentz@intel.com>,
	Marco Elver <elver@google.com>,
	Todd Kjos <tkjos@google.com>
Subject: Re: [PATCH 5.15.y, 5.10.y] Bluetooth: L2CAP: Fix UAF in channel timeout by holding conn ref
Date: Sat,  8 Aug 2026 23:25:18 -0400
Message-ID: <20260808221923.stable-0007-sashal@kernel.org>
X-Mailer: git-send-email 2.53.0
In-Reply-To: <20260807185801.2070943-1-tkjos@google.com>
References: <20260807185801.2070943-1-tkjos@google.com>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

On Fri, Aug 07, 2026 at 06:58:01PM +0000, Todd Kjos wrote:
>-	if (conn) {
>-		struct amp_mgr *mgr = conn->hcon->amp_mgr;
>+	if (!test_and_set_bit(FLAG_DEL, &chan->flags)) {
>+		struct amp_mgr *mgr = chan->conn->hcon->amp_mgr;

Hmm... I don't think that dropping the "conn" NULL check is safe on these trees. 5.15 and
5.10 still have net/bluetooth/a2mp.c, and a2mp_chan_open() calls
l2cap_chan_del(chan, 0) on the l2cap_ertm_init() failure path, before
__l2cap_chan_add() has run - so chan->conn is still NULL there. With
this hunk that dereferences chan->conn->hcon->amp_mgr and then list_del()s
a zeroed list_head. Upstream is only safe because BT_HS and a2mp.c were
removed before b66774b48dd9 ("Bluetooth: L2CAP: Fix UAF in channel
timeout by holding conn ref") landed.

It's also missing a follow-up fix:

  d38eaf611839 ("Bluetooth: 6lowpan: Fix using chan->conn as indication to no remote netdev")

-- 
Thanks,
Sasha
