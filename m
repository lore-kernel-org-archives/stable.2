Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 481F7534E37;
	Mon, 19 Oct 2026 14:25:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1792419940; cv=none; b=QcZxRdwqXZSNeVTl1SJeJRMvbcGng9PPwbBTai8rDVX2yAM0F+pbS78Iu+Q+/CZJhxkEKS++qKyYI/diDedG98W4SX1DruqVUutArTA4Rc4AJcoB3GyUuE3PAv/9M/2KkU9x6dX3IHEerzkqicp8FjMB606W0ZdLwN9ILRFTD3M=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1792419940; c=relaxed/simple;
	bh=h32VLu/TXB4zECfrvOfSjss4WoUO7k5m0oAjpeUtc0A=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=vFi4Qa1awYbrBH5BMIgMg9I1u+Cyswty+rQZFqpcNACx4ZmTZ4fndX88oT18zzvZte6j9ZXcO7u9saFkR2MOUVyOFMy6oED7EbinyVB4zIHPtJIK8FtWc8DKLuYHLCWKbfC74WFnU54S6VJvB2w0gJWqcacl4QKQbxQsQ1H+bKU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=GTRDPjVz; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="GTRDPjVz"
Received: by smtp.kernel.org (Postfix) with UTF8SMTPSA id 995781F000C4;
	Mon, 19 Oct 2026 14:25:38 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1792419939;
	bh=9Wi0UYa4NSZ25zUYv1HgSXPQdq1JjHYOk4LOu9/icqI=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References;
	b=GTRDPjVztR/kkOU+foxQRYLn/4UIsjvQiH2qqGZ7YOZaAuqHJttMPR8dafyueE4sQ
	 rF1DhEvz4YTJTbQervfQClJcseUeMqZzY1EVtf/XoZfz40j24KqgD146mTMfbthzxK
	 kthqNL5p71GiIkhHIpIt9bsB2gcdd6Du0lo7/qcSV/VSrfU1zis12c+VQffrUDoNAg
	 6tOBPtcVRg5IKbe4V18nfN/8eZD86WqX4Qv8Se49+1qX193KedQsCE4CLN0/fuWGwi
	 ZcjzNRNz9kGFuAg7RvmkRlV7CLJPPVE0+IHy4EIoLx4QaEZa6pQkEH0GuWK8+wI60b
	 z+U5XJOON7Gmw==
From: Jarkko Sakkinen <jarkko@kernel.org>
To: David Howells <dhowells@redhat.com>
Cc: keyrings@vger.kernel.org,
	Eric Biggers <ebiggers@kernel.org>,
	Jarkko Sakkinen <jarkko@kernel.org>,
	stable@vger.kernel.org,
	Paul Moore <paul@paul-moore.com>,
	James Morris <jmorris@namei.org>,
	"Serge E. Hallyn" <serge@hallyn.com>,
	linux-kernel@vger.kernel.org (open list),
	linux-security-module@vger.kernel.org (open list:SECURITY SUBSYSTEM)
Subject: [RFC PATCH 2/8] KEYS: Change the type of key->datalen to unsigned int
Date: Mon, 19 Oct 2026 17:25:02 +0300
Message-ID: <20261019142516.300040-3-jarkko@kernel.org>
X-Mailer: git-send-email 2.47.3
In-Reply-To: <20261019142516.300040-1-jarkko@kernel.org>
References: <20261019142516.300040-1-jarkko@kernel.org>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

key_alloc() and key_payload_reserve() set key->datalen with values,
which can be larger than USHRT_MAX.

Change the type from unsigned short to unsigned int.

Cc: stable@vger.kernel.org
Assisted-by: LLM
Fixes: 1da177e4c3f4 ("Linux-2.6.12-rc2")
Signed-off-by: Jarkko Sakkinen <jarkko@kernel.org>
---
 include/linux/key.h | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/include/linux/key.h b/include/linux/key.h
index 6729536a76b2..26139c3adf62 100644
--- a/include/linux/key.h
+++ b/include/linux/key.h
@@ -217,7 +217,7 @@ struct key {
 	kgid_t			gid;
 	key_perm_t		perm;		/* access permissions */
 	unsigned int		quotalen;	/* length added to quota */
-	unsigned short		datalen;	/* payload data length
+	unsigned int		datalen;	/* payload data length
 						 * - may not match RCU dereferenced payload
 						 * - payload should contain own length
 						 */
-- 
2.47.3

