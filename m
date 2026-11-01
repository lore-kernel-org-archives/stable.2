Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=209.85.214.182
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1793514197;
	b=JVq1ckC6NfnPC1ivl4aTOy6QYlXXnsh1kv0J4uZ518dM1V4xvlO/PGekFrkiBEP4xEug
	 o93LcmQB+16Ik8Tm4YpvdApX6YKZw9hzVWBFG3T19RV7/1ZyBOuu2SAvF4z5lwhOIxO3d
	 8bMMsFJjVQzqSE8GjLuAU16D4GAp93XbiPt6yteKlMz1bPfQDdASQbiBYs97Onu/AFjP0
	 4O2Bh2XpjjiaFcZOmXGP10L2yxu9LG2F+46Itww2mDtLkJ9YVOJtGwPnclm3HoAEJN4W3
	 W20nuzLlav0Zi+PMYcllSIh6Cvs8bPdmxuyyJFJJ0xvFsQgrNA0zdosRyhaXpTF4PUQ==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1793514197;
	h=DMARC-Filter:Received:DKIM-Signature:X-Google-DKIM-Signature:
	 X-Forwarded-Encrypted:X-Gm-Message-State:X-Gm-Gg:X-Received:Received:
	 From:To:Cc:Subject:Date:Message-ID:X-Mailer:MIME-Version:
	 Content-Transfer-Encoding;
	bh=r5JhajIzD9ubXl5M8tJbplpixiasXJVLRaVa00eXAjQ=;
	b=ydSClncBRkiuKx9SU7ATqPeHXMcQ+IiTJdT2n5KgKX6LWS6qzepHcKW5P1e81QxClG/s
	 7kBbuvLR8Zb/vZObaTs7aDeWzre/eUmIcFDw8tBh361Msq3Rn5KzEZiZmHf4bBFDFCoWi
	 wnq8ML4WF+1RW2H2DSD3fn/ZSmCCs9w3q8y0dct/gi7HiWNdNu4dMth/T52LTnXwiy0PW
	 d6J5FxXJd9R/nVOlAzt6vv9JfnFYJNtCWiTTwqFy9rx5hC4LmmJPRRf/iORRd7JT2qdYc
	 O/ZI8QK5PdYZuOUcqR+vgj+tlIJmF+b3+eaHdgF6CbgOXxAslVXbPayOPBgAkIXuzjg==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=gmail.com;
	spf=pass smtp.mailfrom=gmail.com;
	dkim=pass header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20260707 header.b=NoSqufGz;
	arc=none smtp.remote-ip=209.85.214.182
Received: from mail-pl1-f182.google.com (mail-pl1-f182.google.com [209.85.214.182])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1808A606A324
	for <stable@vger.kernel.org>; Sun,  1 Nov 2026 06:23:16 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 1808A606A324
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20260707 header.b=NoSqufGz
Received: by mail-pl1-f182.google.com with SMTP id d9443c01a7336-2e940d5d2beso7288135ad.0
        for <stable@vger.kernel.org>; Sat, 31 Oct 2026 23:23:16 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20260707; t=1793514196; x=1794118996; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to:content-type;
        bh=r5JhajIzD9ubXl5M8tJbplpixiasXJVLRaVa00eXAjQ=;
        b=NoSqufGzNtrHCJzWqkLelGubERrGQOSlrCqyXZd/fOCZxBvIqDVAy/Wms1m4X6xNPi
         KQ8yi4bm7dkuXwOUpqCYlNYmCWY1Z4qnhRyrAaLLk2QHE4wsuC3XrN+kFq5YGxIhz5z2
         1lchgQn5znNJTSGVc49Q4+Bcla5oWygzotjQlwUQuHHR0bipU20tjMwqryKj+O9qLcn2
         ctYNi8rcuRASdkz2tvFLUZWlDiBqeBPrK9MFundNCtt4xHyr9eJAMh/EX2G2w5B2fTM8
         PAN4t8BWLMsBNjOcj03C4mHOfysX7fqZL9XE5151gQFvXdyrREmyqPQu6gzcNKtzYX1G
         M6Rw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1793514196; x=1794118996;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=r5JhajIzD9ubXl5M8tJbplpixiasXJVLRaVa00eXAjQ=;
        b=pqyzf9vXue6pTVpUfWXWzsVJg18XdkMNQ5a96eCLx9UybMybcftKa5AFZK6o7uu9Md
         qcWpXzRZ0ZGuSEdk0iRDlu/xo1MW8dOD4+VP7HgwGtTFyfzDgDFaOKuiCJcOOMWn923s
         KuOFiUxO4er5G5m6Qpl3iRTOL0TJd6qQCYJNR7KE5Tvjai6fvWApcfmoqsM7l497WP+l
         Of294PGYFsqMdt1cJV/GQAec9ekl+eMT6CqtzxvmJ6rkg5cksn/ut9E3rfrV998Ds2Ge
         9iEq6fIpZT5VU05yWSHnJAs/lKmNSDQoDeJFiEb2JwC1fWu4wGtMbFgfa0PPY3Rdvd/s
         TFeA==
X-Forwarded-Encrypted: i=1; AKwUvBwm2iGPJm5aCPEvd7H31FUnV9GTni7alqxrTHex7eYiqSp8iX6+FMnqA4bB+8lxS+mWyKrgn8Y=@vger.kernel.org
X-Gm-Message-State: APuU4Z/uVLPLMFgw1NrU700UHaE8bXXQ3iH2iw9KR0q1nHhdg2SlVAr0
	6bMRbs+I1PoWuk+PIrYuwdac7W67Eqs58VbcibAWqCZBt1UDlcF/z7LUjafAG7mF
X-Gm-Gg: AYBFou35/y4dCgT/4s5J2IZXlgcW4HqOprnyni5SJYGuzz97/1i5nWxSIQGiL1ocfLw
	AHoBzfWdlsGOE7/e7bZ1jxu8MfWka6j6gnJXL07WwZLbhTxZGqpVZzf3dqm9lvrAFRRZyhfAq0L
	VLd3tYUCK1F1r9yYup33uRcw63Wkphqwg21KWgbL5+lF2wFF25nmPOQr39j4xN9lKzrpgme/doP
	JfrS87TAYxHoCMR8QHPfazW3b4S3HkS/m4gbjWarphN5uK8qT/py3sFuyn3j6dKganQYvqeE5e/
	SZ9xhkb5FSBL5yqXcwNZK8XFSbr1ps2o8FjnCLtEfSku7Fp/Ta8mZ0A+Ix5/eQ8SRjwYciNJbj/
	oTUGsasy7w71Wtq4iPB86/RVKGThO3Tq4Fb6/XUxF5yxBaBbfNxJtNekbS3D2ckUA52Qw44ZZBu
	uw9yFncr4uR+4j7Af1VJlyNFEL9uqGdjYpvPTXqvkZxlEMlFs4ClOMolgMYRNPPOl2J1XABdwyB
	exlnJfEDVnU4ubVQtnXDbYsCP+aQ4YiW6v2yPDNeQGOs4bzvnw2tGmSZtT67H0TyLSW5t/K7Zro
	wkOZw6u24iFfumFQhJUHkW9rXx2alAad9PgS44uN+qwz5/6FLU10tA9cCz9xCt3KIyaR2tzp7FJ
	pQqONrOsPdbiEaL0mAbCk+G8w6+73+Jy59xx5B38FVWEuhXBGV9175RPP7jYqhAfj8x4/sFbusQ
	Sk0S5ypMSqraUeW5KU10s=
X-Received: by 2002:a17:90b:1d47:b0:3ac:2788:cab1 with SMTP id 98e67ed59e1d1-3ae897c3dc6mr5582405a91.30.1793514196302;
        Sat, 31 Oct 2026 23:23:16 -0700 (PDT)
Received: from EAIT-H54D9Q2FJQ.eait.uq.edu.au ([130.102.10.191])
        by smtp.gmail.com with ESMTPSA id 98e67ed59e1d1-3ae845ae5b9sm9505181a91.12.2026.10.31.23.23.09
        (version=TLS1_3 cipher=TLS_CHACHA20_POLY1305_SHA256 bits=256/256);
        Sat, 31 Oct 2026 23:23:15 -0700 (PDT)
From: Yu Zhang <yuz08559@gmail.com>
To: Alexander Shishkin <alexander.shishkin@linux.intel.com>
Cc: Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
	linux-kernel@vger.kernel.org,
	stable@vger.kernel.org
Subject: [PATCH] stm class: fail stm_lookup_protocol() when the protocol module is going away
Date: Sun,  1 Nov 2026 16:22:53 +1000
Message-ID: <20261101062253.16528-1-yuz08559@gmail.com>
X-Mailer: git-send-email 2.55.0
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

stm_lookup_protocol() returns 0 whenever a protocol entry with the given
name exists, even if stm_get_protocol() failed because the protocol
module is being unloaded. In that case *pdrv and *node_type are left
untouched and stp_policy_make() goes on to install two uninitialised
stack pointers as stm->pdrv and stm->pdrv_node_type, and its error path
and stp_policy_unbind() later dereference them to drop a module
reference that was never taken.

Return -ENOENT unless the protocol was found and its module reference
taken.

Fixes: c7fd62bc69d0 ("stm class: Introduce framing protocol drivers")
Cc: stable@vger.kernel.org
Signed-off-by: Yu Zhang <yuz08559@gmail.com>
---
 drivers/hwtracing/stm/core.c | 4 +++-
 1 file changed, 3 insertions(+), 1 deletion(-)

diff --git a/drivers/hwtracing/stm/core.c b/drivers/hwtracing/stm/core.c
index f48c6a8..5fbea4e 100644
--- a/drivers/hwtracing/stm/core.c
+++ b/drivers/hwtracing/stm/core.c
@@ -468,6 +468,7 @@ int stm_lookup_protocol(const char *name,
 			const struct config_item_type **node_type)
 {
 	const struct stm_pdrv_entry *pe;
+	int ret = -ENOENT;
 
 	mutex_lock(&stm_pdrv_mutex);
 
@@ -475,11 +476,12 @@ int stm_lookup_protocol(const char *name,
 	if (pe && pe->pdrv && stm_get_protocol(pe->pdrv)) {
 		*pdrv = pe->pdrv;
 		*node_type = pe->node_type;
+		ret = 0;
 	}
 
 	mutex_unlock(&stm_pdrv_mutex);
 
-	return pe ? 0 : -ENOENT;
+	return ret;
 }
 
 static int stm_char_open(struct inode *inode, struct file *file)
-- 
2.43.0

