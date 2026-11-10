Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=100.103.45.18
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1794287078;
	b=RdU3XW5ghvOzLc8p2BJdS2wWgISVj70bZCY4t1Qv4JRlYa0I6MioKe3OyzpasO9+GWLA
	 o6njcL0XvcL4cv6A/b9Rg639qoI+82ZMGje+SoWQwp7Cq5mbRQ42aGJNt3TO054KAgAcq
	 NeupJcjfDcKBdlI5TQ6eqcmNkH0JsG3XMynto7u+w9l0iSWVUMGB98rTlYgADvFpIrC4S
	 f5xdHTmktRRrgmTdN82kMCxcLo1t/c3ziKhtYitTr9hzPeE5lJK6FjeGAxRRim/WUkiUH
	 Bv2ZeYECD93Col1pqCwaZSt5t+dGkKPZy6F8LnK6oHEViJHz9t7cQPxgjeV2sFZRhnA==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1794287078;
	h=Received:DKIM-Signature:From:To:Cc:Subject:Date:Message-ID:
	 In-Reply-To:References:Auto-Submitted:Content-Type:
	 Content-Transfer-Encoding:MIME-Version;
	bh=ZCAoLYZlSrLohEk+mBrzJi43HvKosm2TxiN/tMhp9/s=;
	b=A7VAmT/5Fjf2UiwXcrHSxHtn7vt9TlSiYB2Kmii8p9ZCcwp0IpbgvhEja9sCb6xobMaB
	 sBXw1YozxKg192QtBV20cuFf/mU/DjwJIDBgAviZy7GdKG38A81zbDqfkRhKe8mzsiL0H
	 ThcqQwiR4ioYcJ3lXMPUM5AlZH3+OhHbz9b/4X+d2gJFZ/zlxOV9sn64vhpLBBG70co/7
	 O2cZkweJt2GZBpDRn3NauuSRcZIe5xRk/vxQaE41N4dV4uouf1AyMVw4VGzhbQJAWun/W
	 ZEbAvi613q0sPYl7ck3DhJ9iKzbxeDRJfQjoOG76Pr2G1UqOaQ86aYBeeRzlpZ2BR2w==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dkim=pass header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=V543rgRt;
	arc=none smtp.remote-ip=100.103.45.18
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 227D9606A331;
	Tue, 10 Nov 2026 05:04:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=V543rgRt
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 5E7CF1F008A3;
	Tue, 10 Nov 2026 05:04:37 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1794287077;
	bh=ZCAoLYZlSrLohEk+mBrzJi43HvKosm2TxiN/tMhp9/s=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References;
	b=V543rgRtMchqg9yVcmkLQFPKzHTcPL30ryMDIZcfY5drnfr6Lx8RBk6u3oSoQ1Lde
	 V0VV0AH+/U1w6YmxGDYTswXQO0Jw2cfj/+O430bUPPvqQD1dGfs5CKYEbZ/WCM7o6K
	 viliuVgFma09zK+bRrgJgrcOPGP7dB/GVd6fNzE+d3rSO84iGNrTivig4lKOI35ZBS
	 3ro1qIQ9MLzu+/S3CQUJXyxKm+36NQgyY/v/v3fDZbThwafiTNqBiesdWRfkY10+n3
	 VWqmtU/HHhTD9gWAOgtMKVqtvvf4fqTB+fqmXmuscJYu3/b/si+dAu5XdZbTP6PSfh
	 NBkNQKuxaT+OQ==
From: netdev-bot+sinfo@kernel.org
To: joasantonio108@gmail.com
Cc: david@ixit.cz, krzk@kernel.org, oe-linux-nfc@lists.linux.dev,
 netdev@vger.kernel.org, linux-kernel@vger.kernel.org, stable@vger.kernel.org
Subject: Re: [PATCH RESEND v2] nfc: s3fwrn5: validate firmware header pointers
 against file size
Date: Tue, 10 Nov 2026 05:04:36 +0000
Message-ID: <179428707695.488859.7152705179257041373@kernel.org>
In-Reply-To: <20261110-s3fwrn5-v2-v2-1-e8f154a5613e@gmail.com>
References: <20261110-s3fwrn5-v2-v2-1-e8f154a5613e@gmail.com>
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
