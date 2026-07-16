Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 31CDC3019D8
	for <stable@vger.kernel.org>; Thu, 16 Jul 2026 15:37:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1784216231; cv=none; b=OJkVhdOD4Mkhqjqu1pasi9GU3lbOCg8dRv1XnoGVz0VNksBEE4ugNF8EjMyTj2N/kcBN5pIwOk2ujoYsZMHz/Nho0ArxGTlsaluwZ6VQilAiIep8CYktPxCDdyeoB9gvCInwl5M4EUwXHzQjVcNMQT45tzRiFkMK4tysxiGEqb0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1784216231; c=relaxed/simple;
	bh=LiHwCCJA2KTISk3qpifnsnLW5OqnwC9y2o/NwklIeJo=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=lBgKqadGS8D+Sa04pbskcbpecUzEIUGfB6TDMhuZQKNqLIOJo0rXnSAxrTnuaOMWSJvY/XS2krz9BN8dT+IS1BMCyFIdl5FGuU2YIPuKlkNULgbHGRMrZIlPVScZUzE9qPsALSMvt1T1uU0bgfTTevmo7HhyVl+OTH28gMd7A7w=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=ZLYQsKXY; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="ZLYQsKXY"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 8A9521F00A3E;
	Thu, 16 Jul 2026 15:37:09 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1784216230;
	bh=4wY+gWKM78RSLoCfVUtyeEnJzqZHpNI3dwEjAALpdjg=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References;
	b=ZLYQsKXYb8Cp4cmZvSmKqAyFNTquriR/2OsJIot4JMsGgagEASoBZ9YoGXUPnuDSS
	 JbUQ+civoy2fUSd4YXsv81502Ia/J7GoITMYRqpRS/KQo6xiSXB6t9xOnfmkCR7zGO
	 ASdRVySZzaJWTVKAuU8+BNuCtrEbewqzl/1qvfjOC65AC4O3Bq1Jui84G/9+xd67b4
	 0gAPNMXeMoKUlTIuRgZWfntjkHsfJi1lHmdqC/RWtAc2c7fnrPTwMD94xXSOF9H5Ld
	 pC1vsMPpF7eSmVpXhA/I3fkqFNQFNg6ZR545FrGvqnnO6p54+Eav+56hujWh3ObdxH
	 BsMUNh7YYOCUA==
From: Sasha Levin <sashal@kernel.org>
To: stable@vger.kernel.org
Cc: DaeMyung Kang <charsyam@gmail.com>,
	Namjae Jeon <linkinjeon@kernel.org>,
	Steve French <stfrench@microsoft.com>,
	Sasha Levin <sashal@kernel.org>
Subject: [PATCH 6.1.y 5/7] ksmbd: destroy async_ida in ksmbd_conn_free()
Date: Thu, 16 Jul 2026 11:37:02 -0400
Message-ID: <20260716153704.583869-5-sashal@kernel.org>
X-Mailer: git-send-email 2.53.0
In-Reply-To: <20260716153704.583869-1-sashal@kernel.org>
References: <2026071414-kosher-parsley-920b@gregkh>
 <20260716153704.583869-1-sashal@kernel.org>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

From: DaeMyung Kang <charsyam@gmail.com>

[ Upstream commit b32c8db48212a34998c36d0bbc05b29d5c407ef5 ]

When per-connection async_ida was converted from a dynamically
allocated ksmbd_ida to an embedded struct ida, ksmbd_ida_free() was
removed from the connection teardown path but no matching
ida_destroy() was added.  The connection is therefore freed with the
IDA's backing xarray still intact.

The kernel IDA API expects ida_init() and ida_destroy() to be paired
over an object's lifetime, so add the missing cleanup before the
connection is freed.

No leak has been observed in testing; this is a pairing fix to match
the IDA lifetime rules, not a response to a reproduced regression.

Fixes: d40012a83f87 ("cifsd: declare ida statically")
Signed-off-by: DaeMyung Kang <charsyam@gmail.com>
Acked-by: Namjae Jeon <linkinjeon@kernel.org>
Signed-off-by: Steve French <stfrench@microsoft.com>
Stable-dep-of: c1016dd1d8b2 ("ksmbd: track the connection owning a byte-range lock")
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 fs/smb/server/connection.c | 1 +
 1 file changed, 1 insertion(+)

diff --git a/fs/smb/server/connection.c b/fs/smb/server/connection.c
index ae21de810e5870..2133db6ed80de5 100644
--- a/fs/smb/server/connection.c
+++ b/fs/smb/server/connection.c
@@ -40,6 +40,7 @@ void ksmbd_conn_free(struct ksmbd_conn *conn)
 	kvfree(conn->request_buf);
 	kfree(conn->preauth_info);
 	kfree(conn->mechToken);
+	ida_destroy(&conn->async_ida);
 	kfree(conn);
 }
 
-- 
2.53.0

