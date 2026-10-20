Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=100.103.45.18
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1792468089;
	b=jmLkvkxzEDcZIv896odtJqnZ33zMbfv+GfUEWw3UYhEmwo30pdZg+bk4c3kb9r7KvwnX
	 gwAm/7npZXO4v1z3uIRv0jcq+W7ybE4LsHdmng8VR7VV4R/4QckgZDnN17bDGwdH8F/fB
	 oFTr6uf7dsMu7bsGKlH8l4c/0vFv8EQOI2M6t0r6xwBs3cWmHH2ji+s3Re1c+PTwGl7jq
	 1/otC+vgM4z2BR7pdRxRvIT4u1jZlf8DP+H7JrL4xRcgH3Yh5fmRt9Amuoh3/VdeXzk1R
	 HSAUTGCmXQ2IqJx4b/3Z9FDx7sLo1uIU4xOpJRaTBJ539RYpVMtiwm5TDCEbTWySJ9Q==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1792468089;
	h=Received:DKIM-Signature:From:To:Cc:Subject:Date:Message-ID:
	 In-Reply-To:References:Auto-Submitted:Content-Type:
	 Content-Transfer-Encoding:MIME-Version;
	bh=ZCAoLYZlSrLohEk+mBrzJi43HvKosm2TxiN/tMhp9/s=;
	b=Bc7z7/t8ceUF4M0DlG7shX2EyfNSQkfigq4lZk5vt81yWbDtx9ywMGNryan+H+PNsoj5
	 QBLESbVFlJhZBMtFiBozCKnOuKUUcxYUUPOrtAl3LR6w2gkYQiAN9O+r4BFj1+r9eRQFm
	 jj5noE5v0WEtWNIy9Myy2UjDlpDuptVC00h4tCdsboD6gl7V8WOksgyDgqxJbt3IC6seV
	 fZhhqJFIoYZ3iL+sxD83vMfc4vkonpldlc1/ki/5vSYrVPlvtfAt/xmY3GLxzIUCr5zL4
	 yNl/vXjodTBTt12w+J2AZsUYfrq24PEGCfxEvWUTfTKSQNqoVrLNmx/omPgWCI65A1g==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dkim=pass header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=TX2qi0ZP;
	arc=none smtp.remote-ip=100.103.45.18
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 56217606A319;
	Tue, 20 Oct 2026 03:48:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=TX2qi0ZP
Received: by smtp.kernel.org (Postfix) with ESMTPSA id DB2EC1F000C4;
	Tue, 20 Oct 2026 03:48:07 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1792468088;
	bh=ZCAoLYZlSrLohEk+mBrzJi43HvKosm2TxiN/tMhp9/s=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References;
	b=TX2qi0ZPaD/9PxYAwt/dOgQmAEkIYvN4zOvspgJGmh3DtZ9T6i2JzeP/HVyuCFSn1
	 +C0UQo1WjuCsrfTYJ3jcqliDHZSd7X1mc+KO+6HiiCdjMSxNgfuAu+K0cQpaaNtgNy
	 6R/fMycg28ae36ddVnr21lKiBS07Bk+ZmndrRZtat63RgKQ1NdRAnXNqpMEd+yQXVw
	 kwUGbP6P3VfdZWccAsH3s4YJGRXs0N1r+WOA/DU0GYFEF4fmOjhNHOdfw8uvdWe49t
	 f4rf6UFNX832ENG7c+KFFiJzui7VSYOMPCohmzse1xLGJ4faWjn0tnWgcAmJBy77ts
	 rM5Jz9IzGZxWw==
From: netdev-bot+sinfo@kernel.org
To: Henry Martin <bsdhenrymartin@gmail.com>
Cc: "David S . Miller" <davem@davemloft.net>, Jakub Kicinski <kuba@kernel.org>,
 Eric Dumazet <edumazet@kernel.org>, Paolo Abeni <pabeni@redhat.com>,
 Andrew Lunn <andrew@lunn.ch>, Simon Horman <horms@kernel.org>,
 Kuniyuki Iwashima <kuniyu@google.com>, Ido Schimmel <idosch@nvidia.com>,
 Petr Machata <petrm@nvidia.com>, Ferruh Yigit <ferruh.yigit@amd.com>,
 Antoine Tenart <atenart@redhat.com>, Ilya Maximets <i.maximets@ovn.org>,
 Seungwon Bae <qotmddnjs@gmail.com>, netdev@vger.kernel.org,
 linux-kernel@vger.kernel.org, stable@vger.kernel.org
Subject: 
 Re: [PATCH net v2] vxlan: reject adding a remote to a nexthop fdb entry
Date: Tue, 20 Oct 2026 03:48:07 +0000
Message-ID: <179246808735.3290.16512552225994896963@kernel.org>
In-Reply-To: <20261020034531.1420194-1-bsdhenrymartin@gmail.com>
References: <20261020034531.1420194-1-bsdhenrymartin@gmail.com>
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
