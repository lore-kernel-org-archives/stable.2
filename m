Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=100.103.45.18
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1793968619;
	b=SVGdRuDYsGsR4QESIhHetlKGm+umlNH1YthkA2vjkYIca9W33jnok/+96ZQOh//Iq8E2
	 053E+DQK+AbvOvsPFUkIsjllUZNuKikosEeirN+YRld6nMXicwoqkOjkORWEUfgkcKhj/
	 BktvU1/t+RR+Sn4HZExttIOkmcjipfwpl8U50xTVaHbCxpDbjCbL2NYh/aZJDZZqU8tzM
	 Z0smDcHiJ2DIckNF0inGn4j445HU7RA4ZD0ynwI5sFYQTDTxtwgVtdHNwrp8yCSLi5ohe
	 CZ0wDIMk4G+8DP1qyquAOqceLzQGtM5D3nRArycVmmiFyh8rX/pRs2lg7oe3fvvQLDg==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1793968619;
	h=Received:DKIM-Signature:From:To:Cc:Subject:Date:Message-ID:X-Mailer:
	 In-Reply-To:References:MIME-Version:Content-Transfer-Encoding;
	bh=q2Q8QO4mzGlEGizZ2aYLlwjThM+xGigGOqxtdKwVl/U=;
	b=GmT0eM7yNCHVi+ymVTP6qwNGz6j+3MxiHDeI4AZDXd7y3MKK2yW0DgQrubS8wnZHrunu
	 anmZ52Yrq01dLe4LbiY0cmBBgk4dkDA96y2Oij6vIf+WSCBf9ATVcY58btbZs5YpYRnOr
	 /4Aufi+xDbeIoTW4kkr0iPG0dErp65XBMZnjm0GcmlSChicxqoYp+FMaJT2IXEqXFYXIh
	 qOo+ldYRTzj1u3GkXYjXS+HsWlEHsMJsgV9q4ccCd4UBsPVDkip19jZ4isK6bk0qQCGO5
	 +CDrCQLrobB6+rX55KMojhBO2Qeiy1HC3g7LaOxyK2/9Hz9lUPtwqvUG9Klv4L10+3A==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dkim=pass header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=DLzYucfr;
	arc=none smtp.remote-ip=100.103.45.18
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5BAFA606A329
	for <stable@vger.kernel.org>; Fri,  6 Nov 2026 12:36:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=DLzYucfr
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 713971F0089F;
	Fri,  6 Nov 2026 12:36:58 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1793968619;
	bh=q2Q8QO4mzGlEGizZ2aYLlwjThM+xGigGOqxtdKwVl/U=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References;
	b=DLzYucfrn7xcrd63GzZ535aSaLXkX/5UG0vPlyPDNipEjC0JbFe8zabC4B/UxJLHW
	 IKuiatqSEiMOxyyfzQVpkDjsiM+SAY7T7ts3uPTQCNgWgJD9SxwB6a+LFGIzl+X9rT
	 pJMiDZfcPiGbjAdhptm423F5uXBxSO8P7dUK2Ef5YUMWv3JYKZzjn2K2AccFk6ImUJ
	 rrI/2gsJokD/Mhm7iKJL0vhx5kPXpcxRSTdMjQPV9ajmQOAjT4mXwjAbil/lXY/Oqp
	 Bt20+b25oCXt4Sk6N23Sepc09iwFVshP9ivH4qjSFGXleFz21VkZDkKo0NghQXKvjI
	 cc1yzhTYnKc1A==
From: Sasha Levin <sashal@kernel.org>
To: stable@vger.kernel.org
Cc: Benjamin Coddington <ben.coddington@hammerspace.com>,
	Benjamin Coddington <bcodding@hammerspace.com>,
	Anna Schumaker <anna.schumaker@hammerspace.com>,
	Sasha Levin <sashal@kernel.org>
Subject: [PATCH 5.15.y] NFSv4/pnfs: bound the CB_NOTIFY_DEVICEID array count before allocating
Date: Fri,  6 Nov 2026 07:36:57 -0500
Message-ID: <20261106123624.3997652-1-sashal@kernel.org>
X-Mailer: git-send-email 2.53.0
In-Reply-To: <2026110400-plexiglas-ladder-a8f1@gregkh>
References: <2026110400-plexiglas-ladder-a8f1@gregkh>
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

From: Benjamin Coddington <ben.coddington@hammerspace.com>

[ Upstream commit 32f0967ea296d447925465c98e7eec71d4e2f755 ]

decode_devicenotify_args() hands the server's notification count
straight to kmalloc_objs() as the array length, without checking it
against the message that carried it.  Bound it the way nfs4xdr.c bounds
an attribute length, against xdr_stream_remaining().

Fixes: 1be5683b03a7 ("pnfs: CB_NOTIFY_DEVICEID")
Cc: stable@vger.kernel.org
Assisted-by: Claude:claude-fable-5
Signed-off-by: Benjamin Coddington <bcodding@hammerspace.com>
Signed-off-by: Anna Schumaker <anna.schumaker@hammerspace.com>
[ sashal: adjusted context for kmalloc_array() instead of kmalloc_objs() ]
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 fs/nfs/callback_xdr.c | 7 +++++++
 1 file changed, 7 insertions(+)

diff --git a/fs/nfs/callback_xdr.c b/fs/nfs/callback_xdr.c
index 6501459af0e57..29e43101b7158 100644
--- a/fs/nfs/callback_xdr.c
+++ b/fs/nfs/callback_xdr.c
@@ -272,6 +272,13 @@ __be32 decode_devicenotify_args(struct svc_rqst *rqstp,
 	if (n == 0)
 		goto out;
 
+	/* sanity check the count against the remaining stream */
+	if (n > xdr_stream_remaining(xdr) /
+		((4 * sizeof(uint32_t)) + NFS4_DEVICEID4_SIZE)) {
+		status = htonl(NFS4ERR_BADXDR);
+		goto out;
+	}
+
 	args->devs = kmalloc_array(n, sizeof(*args->devs), GFP_KERNEL);
 	if (!args->devs) {
 		status = htonl(NFS4ERR_DELAY);
-- 
2.53.0

