Received: from mail-vs2-f12.google.com (mail-vs2-f12.google.com [74.125.227.12])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1B12A40BCDF
	for <stable@vger.kernel.org>; Tue, 15 Sep 2026 16:01:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=74.125.227.12
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1789488068; cv=none; b=iRvl5fPJU+8MPG+k1MwsadRWgZRSvYbQnZHILeaDeiqh3vfjLMe93RRsih+yjw5XH1Cj48qnrZxyRNf9oh66nBMb4CfC0arafQhw1+oayTi8zVOh2oLMVfriIArhcZKKxTX6GzQ7+qvHAsKa3w8sj8LN/3xv0la2Gh5x65FXdVo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1789488068; c=relaxed/simple;
	bh=TP8vzZNqYTvpqyiQsP8/kzXcvof+WkIv9WsLTDcnXlU=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=j5b9YnToBNpIo/cnYhUozPZYnVf7bmG7l9RGKsU5G+RRvV5jHbCNKB4KvyJbc+MI/U1SFSA3ARgbKWb9CSDwCnNLsrjPF4Ff9dM8gNKSU3qIo6I7jGVajFa7Zk8aHzoGx6vLBQALaJtxH63+tMPGs2NIeBNgm43Jqeb/ZYxbjzo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=PgNDW5/1; arc=none smtp.client-ip=74.125.227.12
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="PgNDW5/1"
Received: by mail-vs2-f12.google.com with SMTP id ada2fe7eead31-78ffc0e2f23so1087779137.0
        for <stable@vger.kernel.org>; Tue, 15 Sep 2026 09:01:05 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1789488065; x=1790092865; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to:content-type;
        bh=kHnSyuLANDxKOE15RlXzsARxBU9yDC28z60+XrDSb1o=;
        b=PgNDW5/1++gfdfkWd8E334FRbkdy7GHOa3tyFNmXzjuT6ndnKM0M1WQLDa4RRY3wkU
         xSifHRlOj3cNv87VHVspiP2uuiHfqwUyaWHGFZDHDux9TkuFZqZLrK2iHyiyfYF6XRM/
         Rl+Xq/dsvT4nyyRxyZnvrKODwL6NsvO8v9rnIY8kjvtnZNM9UGJw4ETBJzN4++lM083G
         ASwWHMhgmLIkHCLgDhM//9lchCnW4oWIat6rvzHgicwWvszFYg0no3daVSToEefyU97M
         Ds2HT7qSjw/IP0LDdqrMMlgzbKu1W8P6W9WaPDF/SGp0xNkwOb4kk20wlfi9Ve1xwvZp
         EmUQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1789488065; x=1790092865;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=kHnSyuLANDxKOE15RlXzsARxBU9yDC28z60+XrDSb1o=;
        b=QRSkE208EyUKXOFDolq6baUg28/UtkKBeYbVUKOYM0W+p3+iaxj/vLJ+PErFAokgGN
         eZpq/vcwqHTY9PTAa93ySc8W5IqCvcTJ+xaxTGHn3S3Mf9T8vcYab6ROnFMSowfMIoVz
         WuCJgWAcHLunrJlQIfwl92E54xtS7FxZ+cHh6iw1IcK8gOomb8x1b8eYaEPJNsdnZ9Yh
         Cr4RTWVXtXg5bpgTwyrK7R2YyqqLX3JyvUn5Jshui4Gjy04hL5o5VisXo1RR6jARlza+
         RlTgSC0T/F32SPVtf6Oe7egi2m3bp7ENzfhIk/JHeNz55y1oLVZx1mCxcrKTTwCca+ve
         Mvrg==
X-Forwarded-Encrypted: i=1; AKwUvBziS5pubmuSRg0iAfJa673M6xi3rOGIhWimI8PTrVjedGi6KjITyCHWN0Am2FNIRu7xlhUo4XI=@vger.kernel.org
X-Gm-Message-State: AFuF++njoDEhzEDgcRlklSfIoSIqXcJNW+TTk48xZsLblbwvYDDhXesZ
	coNqa3uTeGRwm820F2cwZynqRSPeFZbctuU9WzmC/8X5lYYvijO6/WgJ
X-Gm-Gg: AYBFou0GoIE6S015luxA8E8KSkyguyZOOFl65otcvZRMJDmbZ+73G7dUOlJMvxlhTPT
	IhLGfpr8PetzZ0BA8U9GCjhBCfmOWHShkMVCVwX8h9gWloXKD7qXkwjNerscHQrk+lJBSz7S8+i
	bXvxRDRf6e9PAsOFqfMs4Nqi8nDCE8U60QIVCFUNWk4HcumWvX+At/mpD03wkzsFZ93RNOW6i6b
	n8c752KmXq6aDE38+m/v34xDSOqcOoz/PXPC0Yib8QdCgyuKpbxnaDCn0Xglo/UBHjrfIeOJBkl
	X6f/etH6LXofgv+j6+j6MN37WPvy84A5ZcanXLSjwMoNyHsMKf2UuQC2bnW25HRHJHSLwQ0z5xa
	ZSlH9VaKS6gI2zUNjaaHLbxlXokH5xYrzDofjJJ6WMan+oZYgtMGGbdsmpTk4KMbeIIJAkV1A0a
	eiXPvuPm22PkX3Xs3zDC4Oyc4NbKdPAQu7JjTNGC7DnbZMmSOu/FFPN3Lp4z7sZBEN
X-Received: by 2002:a05:6102:a184:20b0:79c:cf1:723d with SMTP id ada2fe7eead31-79c0cf17cf0mr7667253137.6.1789488064765;
        Tue, 15 Sep 2026 09:01:04 -0700 (PDT)
Received: from beelink.. ([187.13.206.89])
        by smtp.gmail.com with ESMTPSA id ada2fe7eead31-79fb1148f57sm79049137.4.2026.09.15.09.01.03
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 15 Sep 2026 09:01:04 -0700 (PDT)
From: Aldo Ariel Panzardo <qwe.aldo@gmail.com>
To: Chuck Lever <chuck.lever@oracle.com>,
	Jeff Layton <jlayton@kernel.org>
Cc: linux-nfs@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	stable@vger.kernel.org,
	Aldo Ariel Panzardo <qwe.aldo@gmail.com>
Subject: [PATCH] nfsd: zero NFSv4 COMPOUND tag padding
Date: Tue, 15 Sep 2026 13:00:49 -0300
Message-ID: <20260915160049.3105481-1-qwe.aldo@gmail.com>
X-Mailer: git-send-email 2.43.0
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

nfs4svc_encode_compoundres() copies the tag bytes into reserved XDR space
and skips directly to the aligned end of the field. xdr_reserve_space()
rounds the reservation up but does not initialize the padding bytes.

A remote client can choose a tag length that is not a multiple of four,
causing one to three stale bytes from the response page to be returned in
the COMPOUND reply.

Use xdr_encode_opaque_fixed() to copy the tag and clear its XDR padding.

Fixes: 1da177e4c3f4 ("Linux-2.6.12-rc2")
Cc: stable@vger.kernel.org
Signed-off-by: Aldo Ariel Panzardo <qwe.aldo@gmail.com>
---
 fs/nfsd/nfs4xdr.c | 3 +--
 1 file changed, 1 insertion(+), 2 deletions(-)

diff --git a/fs/nfsd/nfs4xdr.c b/fs/nfsd/nfs4xdr.c
index e17488a911..9377f42dfd 100644
--- a/fs/nfsd/nfs4xdr.c
+++ b/fs/nfsd/nfs4xdr.c
@@ -6480,8 +6480,7 @@ nfs4svc_encode_compoundres(struct svc_rqst *rqstp, struct xdr_stream *xdr)
 
 	*p++ = resp->cstate.status;
 	*p++ = htonl(resp->taglen);
-	memcpy(p, resp->tag, resp->taglen);
-	p += XDR_QUADLEN(resp->taglen);
+	p = xdr_encode_opaque_fixed(p, resp->tag, resp->taglen);
 	*p++ = htonl(resp->opcnt);
 
 	nfsd4_sequence_done(resp);
-- 
2.43.0

