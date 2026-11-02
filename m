Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=100.103.45.18
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1793633631;
	b=lPYxRo8JPCsmKy9upqnIHYNfRNsrM9ITVSisKnLeA2EFouiNQXkQMYO+cY9qMFZc2X+2
	 0Xy71lETOvOuKT4RMLxAUTC6GRXvvIEr3f45CCx2prZDl4CW0c0cVwECloAzQeMWWYi/2
	 06dlAOFdhczyDTSxt0TyGqusCgtnhAiVTYasE+4PE9ZsFd0A3qo2TR/s2mjhYC7z51No1
	 9U96WAtT1OP+6h/mxCsFVUjJUQS6t2+kFcBvIETUBSWlyJaLmKRZ9VLdPVYdOPvLKLUDD
	 I9kpcF+FkqDUcb/nhhJvgjRNX0RZX4idgK8dQIupic2C46smtj/gLdyr8EPhVTYCgdg==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1793633631;
	h=Received:DKIM-Signature:From:To:Cc:Subject:Date:Message-ID:X-Mailer:
	 In-Reply-To:References:MIME-Version:Content-Transfer-Encoding;
	bh=Eyp6T51/32QnJYJemSX4gOvOFzILBHN+PdCWPBKPPKY=;
	b=RH4JQGg/QbtoAmRvw24hM6Ce/oTXxExE/dF42620vhhhO++enwcIYnOeEdlglpJf3uMF
	 k4rjlMDYtiyFa08cgxf0Y4yZf1rx/tSo3SYJzc75ofLjSX1jvGg5dsKHAnRt0kD9hOcVB
	 LEYYLf2Aq0ln8BEEI8LyOp66nvbS+4lV9Ao9opNE3Oxi96za5KQ1ze4JavBiuZ4EFcWu5
	 RXCdmF/BUK/0FZwremugLeTixtnRqRATC1wBg3vLWT0zVf74jvkRQIlrdjYO04GwpN91c
	 GBAbc7eO2CKtRnacnYdpzA/qGTfIMXMGwYmw6OPSahUTLoi/pFW3KaDni/ibLGSHG1g==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dkim=pass header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=jloO+X9s;
	arc=none smtp.remote-ip=100.103.45.18
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2E54A609FD80
	for <stable@vger.kernel.org>; Mon,  2 Nov 2026 15:33:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=jloO+X9s
Received: by smtp.kernel.org (Postfix) with ESMTPSA id F2C461F00A21;
	Mon,  2 Nov 2026 15:33:49 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1793633630;
	bh=Eyp6T51/32QnJYJemSX4gOvOFzILBHN+PdCWPBKPPKY=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References;
	b=jloO+X9sb9+zARHZNiAEeXIDrYsnlGmOzB1dM2bduHba8Ydkud3h0X0L51lsJev/1
	 k+QjHiiVSLFo/sD7cvr6O0X+te/0WysWAy6dc+6QlbsddNYur7nxvq0S8dSjT337EN
	 hKTjDNAc2ukG+PNChAnBezQQZ0npPphXlGlnq83fP0Ri7d9pYCCPrp0uKZwatjdXPJ
	 W7UrtYUYX5GO4Jeosno7NPKW6ciI6vwv7zTMzuTSGGOvSoBStoTse5lrvyv9bzguVf
	 rbi4RmHupVvmQIxJt7kbL+3hrYvDZb29TrIa4DbutWxATRk3SQAEAa95lWi3MalNuR
	 NMPy5EryUOfEw==
From: Sasha Levin <sashal@kernel.org>
To: stable@vger.kernel.org
Cc: Sasha Levin <sashal@kernel.org>,
	Christoph Hellwig <hch@lst.de>,
	Mark Tinguely <mark.tinguely@oracle.com>,
	"Darrick J. Wong" <djwong@kernel.org>,
	Carlos Maiolino <cem@kernel.org>,
	Srikanth C S <srikanth.c.s@oracle.com>,
	Harshit Mogalapalli <harshit.m.mogalapalli@oracle.com>
Subject: Re: [PATCH 5.15.y 11/11] xfs: remove xfs_attr_leaf_hasname
Date: Mon,  2 Nov 2026 10:33:35 -0500
Message-ID: <2026-11-02-1-daily-reply-0009-xfs-attr-leaf-hasname-5-15-needs-ack@kernel.org>
X-Mailer: git-send-email 2.53.0
In-Reply-To: <20261102101239.1557688-12-harshit.m.mogalapalli@oracle.com>
References: <20261102101239.1557688-12-harshit.m.mogalapalli@oracle.com>
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Post: <mailto:stable@vger.kernel.org>
List-Help: <mailto:stable+help@vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
List-Owner: <mailto:stable+owner@vger.kernel.org>
Precedence: list
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

> [Srikanth: Fix the additional leaf-add caller retained in 5.15 and
> adapt leaf reads to the four-argument API.]

I did not queue this one. It is a hand-adapted XFS backport, and no XFS
maintainer has acked this 5.15 version.

-- 
Thanks,
Sasha
