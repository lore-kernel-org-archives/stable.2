Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=100.103.45.18
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1793900109;
	b=YMfcJ7l1t60fQIuA4SD/z7GtQYD7eLPZ0sYN4+SaaAnfsxUx+snlJCSwLiPZV54vHbkl
	 2VvORTl3maHZh5T+JlaKcs+GG41x7jV/33USY561Gi/Gvug+oyeYR5VEs8NN0LPjjdikJ
	 l5oos0JmrvLx1dAsFjHLCoDu5IpA/uXtKxCLfr1LkKzN6bDhlejlDhA/gxvkkeTlKswkq
	 UBi2/gDZgQy5aj3p2Rpypxlr4zQO1Wdj0rMlicnu80IlDDJPsBuJE83FW+S5MbNUD+4Mi
	 zNwSYWqYTHLqNO+37euOG6XetED2+I84N6uBSU6hoUriqFqD4Az+ywlKwNXd2a+0U8A==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1793900109;
	h=Received:DKIM-Signature:From:To:Cc:Subject:Date:Message-ID:X-Mailer:
	 In-Reply-To:References:MIME-Version:Content-Transfer-Encoding;
	bh=JsNGi9fRa1d2aO+0IIAcP/kSAKk1mIoBHm2Ho3BnKnA=;
	b=P4uRLYfUIrCrE8srM/u6erUlPd7OxDKv82eSCcocFNKEBdAh8yCbD1Mjf822z75R1ErJ
	 iclNSr8VibEeMuDmzwVJLk0BOuP3MCUF/X/sY0fwSt5nz0dLHwC/fKwQZIX59J4OMit/8
	 rUehz1H9HbtJnLp6WFhfgMDEQGzZlzNj3GEuaLvOszmVUyjlbjMl6RRmI2OPgNDJGf2J6
	 l0XBPWAW9h+2hkrO8UQMwqVv7d0WlLCTmB/tfayaZuQ81pb8c94oqlDgAszb028uogjuS
	 z4d3fyjR1h/0jK9HbfEbV9TfMlwrj0dEtYAijfeLiBcT5dtHnQT8/nK0jMg7jc8hk3w==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dkim=pass header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=YCxUhNQV;
	arc=none smtp.remote-ip=100.103.45.18
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id ECC24606A33D
	for <stable@vger.kernel.org>; Thu,  5 Nov 2026 17:35:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=YCxUhNQV
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 0DB3D1F000C1;
	Thu,  5 Nov 2026 17:35:07 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1793900108;
	bh=JsNGi9fRa1d2aO+0IIAcP/kSAKk1mIoBHm2Ho3BnKnA=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References;
	b=YCxUhNQVBARJBhHfAXhkpEuVUsp7i0YXIThIj99Y3CmwhQdM+X4Nwf1t5B+W3kztj
	 /NcM164ToQPpiqJdoikM6sRBNmIk4r2a03vOCTeUXBdk51MJlpUSUlgunwOnU5zLUT
	 pXZtqAqeEQVlvz4uKU2NDe6/FgY2LApcYg1SFS9qIXhByOLs09yKJkNpH7lYXHYEzc
	 uVNREkxVJGg6wJD8j1pO5eboIOjX0sqH0rWyb2FsRxaQNFl7NlCi27udwk5H1AHlXy
	 3yVpeXmh7zCWOtM4lwj/xgQ0coi9gclYF89Updbz2LOoW+GJK7PRDeCBEFSunEXmLC
	 nyQ4TVrtnrCfw==
From: Sasha Levin <sashal@kernel.org>
To: stable@vger.kernel.org
Cc: Stefan Metzmacher <metze@samba.org>,
	zdi-disclosures@trendmicro.com,
	Namjae Jeon <linkinjeon@kernel.org>,
	Sasha Levin <sashal@kernel.org>
Subject: [PATCH 6.6.y] smb: smbdirect: fix buffer length underflow in RDMA transfers
Date: Thu,  5 Nov 2026 12:35:06 -0500
Message-ID: <20261105173454.2185013-1-sashal@kernel.org>
X-Mailer: git-send-email 2.53.0
In-Reply-To: <2026110437-flagpole-glitch-eff0@gregkh>
References: <2026110437-flagpole-glitch-eff0@gregkh>
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

From: Stefan Metzmacher <metze@samba.org>

[ Upstream commit 7193241a49c958782ba4b8df06da3734d1e317d2 ]

When a remote buffer descriptor is larger than the remaining local
buffer, smbdirect_connection_rdma_xmit() clamps its length and sets
buf_len to zero. The common accounting code then subtracts the clamped
length from buf_len, causing it to underflow. If another descriptor
follows, the loop processes it with a wrapped remaining length and
includes memory beyond the local buffer in the RDMA transfer.

A client can trigger an out-of-bounds kernel write with an SMB WRITE
request, or an out-of-bounds kernel read with an SMB READ request, by
supplying multiple RDMA buffer descriptors with an oversized descriptor
before the last one.

Remove the premature assignment to buf_len. Subtracting the clamped length
already consumes the remaining buffer, so the next iteration stops and
only descriptors within the local buffer are used to build work requests.

Fixes: e628bf939aaf ("ksmbd: reduce descriptor size if remaining bytes is less than request size")
Cc: stable@vger.kernel.org
Reported-by: zdi-disclosures@trendmicro.com # ZDI-CAN-33549
Signed-off-by: Stefan Metzmacher <metze@samba.org>
Signed-off-by: Namjae Jeon <linkinjeon@kernel.org>
[ sashal: adjusted context to apply the change in smb_direct_rdma_xmit() ]
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 fs/smb/server/transport_rdma.c | 1 -
 1 file changed, 1 deletion(-)

diff --git a/fs/smb/server/transport_rdma.c b/fs/smb/server/transport_rdma.c
index 8987b1167a38c..5178c7443ebb7 100644
--- a/fs/smb/server/transport_rdma.c
+++ b/fs/smb/server/transport_rdma.c
@@ -1388,7 +1388,6 @@ static int smb_direct_rdma_xmit(struct smb_direct_transport *t,
 		if (desc_buf_len > buf_len) {
 			desc_buf_len = buf_len;
 			desc[i].length = cpu_to_le32(desc_buf_len);
-			buf_len = 0;
 		}
 
 		credits_needed += calc_rw_credits(t, desc_buf, desc_buf_len);
-- 
2.53.0

