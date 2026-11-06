Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=100.103.45.18
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1793969556;
	b=AWsLDIoL5Ncfh1e5YMI49f+1oGPJzlckQif7ftBlxCozlNhKDRVNAGWQHh3ICfN5os+N
	 oUDP308kiH4CyyMxyQPNsm6LrtLvB7K8+f6MwDivSnKU7WfBtC5FgHSTnO1YtH1Cvveju
	 K6T2qpCW+Dj3HiejJHoggyRfL+7bILpW70hSQ5BzUcle+NH+2IM8zT8R4irf9tkz6Z01g
	 WpWvI3At5m0grLdEsf0nz07eDmXzPfQ61u/W6635joW1+M0Q0wgo3iptJHPaHDOqMU82R
	 qVvKS8rw0sM+0es5fvXNB7rgySeEYCu8/ZimQj1/SkIUnlGRDT+fuThaRWawDccFNcg==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1793969556;
	h=Received:DKIM-Signature:From:To:Cc:Subject:Date:Message-ID:X-Mailer:
	 In-Reply-To:References:MIME-Version:Content-Transfer-Encoding;
	bh=K7/av7MRJz7auEBrTGOUHB2MfJyUfw6rflrBVlKSIt4=;
	b=l/G5lzQdViJoaG+JV4kWmhTBzFBrFRK+RJWY+lbY3dSwc3m078asKOucWqcqgYQSyWuE
	 N6hPqk//vxPWT1N6J6Dge9enD/0Sekgv7j7fLjWmplfQcyPC5dwXE0lHIpHshQVsAWXqv
	 HbIA+BCNRH6QT53jnhoXwv5lJsy8t6JCekoApfhsdPGTxqlut9RXNjO6DU7fvgxnELBV5
	 uTs+iVjZJ4RZJzg4LsJVEF0VbLUfOu35wFi5umn0bvHI1at1IgrnP2f3tzyegJ+kuVuDU
	 TxXWFaNUs34FX0N+/1CZOWxdlY4m+srV/aQ1E4frYPIHBvMRZ01MzM9IkxzBhFy7QMw==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dkim=pass header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=OcOr4UBj;
	arc=none smtp.remote-ip=100.103.45.18
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B6297606A32C
	for <stable@vger.kernel.org>; Fri,  6 Nov 2026 12:52:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=OcOr4UBj
Received: by smtp.kernel.org (Postfix) with ESMTPSA id DED6C1F008A6;
	Fri,  6 Nov 2026 12:52:34 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1793969555;
	bh=K7/av7MRJz7auEBrTGOUHB2MfJyUfw6rflrBVlKSIt4=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References;
	b=OcOr4UBjvk0ZqqSfF/Nzb3v9UHEjknkbSbe//823kYBoaJWNKze+zdY5GCyow5ok7
	 f4JsNCmqCHXpa7D3Ou6wgs/cEoHRNUTNuPmhoa7m2rWdTRqGHZ/XaOjALMACAm7Nbd
	 CdXN3w17ni0miDpQ5bR9Uz52JMJMOYFFN2HCj87iLpjnmwZctwcWfjwzS0HFGjTh8P
	 skroto8iqon3fM1Dx5/KwRAOxvaiOoDzJqAYoXmFhMcp5Q4tfRPkoyP1MomwQcbquB
	 GSsXVQC+Fa6N8le3Ghd5m6F194+Y25QNT5hduXFeI89aaRnPj7iLCbZBZOaeL2PXyo
	 Tq0iqZ8Lc5vWw==
From: Sasha Levin <sashal@kernel.org>
To: stable@vger.kernel.org
Cc: Chuck Lever <cel@kernel.org>,
	Sasha Levin <sashal@kernel.org>
Subject: [PATCH 5.15.y] NFSD: Complete a cld upcall when copying its reply fails
Date: Fri,  6 Nov 2026 07:52:33 -0500
Message-ID: <20261106125221.14973-1-sashal@kernel.org>
X-Mailer: git-send-email 2.53.0
In-Reply-To: <2026110446-unshipped-footing-bcc5@gregkh>
References: <2026110446-unshipped-footing-bcc5@gregkh>
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

From: Chuck Lever <cel@kernel.org>

[ Upstream commit 8cef2b0a01d28647facc57501a3df7ccd8d13ccd ]

cld_pipe_downcall() removes the matching upcall from cn_list before
copying the daemon's reply. When that copy_from_user() faults, the
downcall returns -EFAULT without completing the upcall, and a
retried write cannot reach it because its xid is no longer on the
list. __cld_pipe_upcall() waits on cu_done uninterruptibly, so the
nfsd thread that sent the upcall is stuck, and nfsd shutdown hangs
behind it. The pipe is mode 0600, so only a broken or hostile
nfsdcld can trigger the fault.

Record the fault in the upcall's pipe message and complete it, so
the waiter returns the error to its client tracking operation.

Fixes: f3f8014862d8 ("nfsd: add the infrastructure to handle the cld upcall")
Cc: stable@vger.kernel.org
Link: https://patch.msgid.link/20260901-alemi-v2-3-e163f94a3a6e@kernel.org
Signed-off-by: Chuck Lever <cel@kernel.org>
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
Depends on <20261106123630.4042374-1-sashal@kernel.org>

 fs/nfsd/nfs4recover.c | 5 ++++-
 1 file changed, 4 insertions(+), 1 deletion(-)

diff --git a/fs/nfsd/nfs4recover.c b/fs/nfsd/nfs4recover.c
index 4dbf1e72c1232..257803877a8ae 100644
--- a/fs/nfsd/nfs4recover.c
+++ b/fs/nfsd/nfs4recover.c
@@ -909,8 +909,11 @@ cld_pipe_downcall(struct file *filp, const char __user *src, size_t mlen)
 	if (status == -EINPROGRESS)
 		return __cld_pipe_inprogress_downcall(cmsg, nn);
 
-	if (copy_from_user(&cup->cu_u.cu_msg_v2, src, mlen) != 0)
+	if (copy_from_user(&cup->cu_u.cu_msg_v2, src, mlen) != 0) {
+		cup->cu_pipe_msg.errno = -EFAULT;
+		complete(&cup->cu_done);
 		return -EFAULT;
+	}
 
 	complete(&cup->cu_done);
 	return mlen;
-- 
2.53.0

