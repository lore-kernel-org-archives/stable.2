Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 76C8B534E31;
	Mon, 19 Oct 2026 14:25:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1792419934; cv=none; b=gpMhCtpF5swNb6kDn87jVxFqSmZ7+UuOPuuZsj7eI0NEqeIbDY7ENI3kJ8SN3lb1cukpLCSXZZA+oe5qGmdiJfENko4Kg+jP8QSKdA8QfaP/YvbKHQx2PHeZBVZzB4Qb0nXrxMwc1rCmKW9aRV1pmNC7ogegNhTIu14fnqoWpQc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1792419934; c=relaxed/simple;
	bh=Kx64SFh3Jb0BTzqp3WxsP+coqHjLqwybXpzqsfFUwrE=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=LqQ2VNhCtX++fZn5cW/WIGt4VeLCs3e7h8TYBtNWFBUo79/4v7qxNKU0/HaJfcOKtzjCmWVHGiDG2JL+OP4N/vHvadNXgDSjVLbdg6LchgZjTax4A2FFsjcR4vo7yE7icdmFJtqbFlWhfOLLQiUwZaep9gLVkdcqqUzv9gUwihc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=Z0qyMbvK; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="Z0qyMbvK"
Received: by smtp.kernel.org (Postfix) with UTF8SMTPSA id D31B61F000C4;
	Mon, 19 Oct 2026 14:25:32 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1792419933;
	bh=cUJOWQSnf1kc/h+TErRm+U68+rhKVlYLjqwQX8FWadA=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References;
	b=Z0qyMbvK9jJtcRcYktMTVmBi8VEaJVYT+Scczm2BBM+sz/Tc18rBnJYazuywXt6MQ
	 pejdL/lzTNTXjQ9fXZBOSc1U1YO7uhQCOvi2S8M+jDkXxSc73OVPdOm8Yt0ob3WAG5
	 /u4KIA5lqcqpq13b1q0dD7ZM5yFN9X0c/Eim8VRC9RiwLV52OCHen9o/vXla7x3TXz
	 enEBm8wel7/K0VFPeoj1shMyf3+Qsv99VMtkn94AcNzYaGXhcz273kU+c5SbErdADx
	 AsDum2iHwT6qKG3X7RSnGJcx7VdWsORBkDIJr/pK3cIbjgijQfgCtFgiUDoUpSFwfV
	 9IRntE4xxIELA==
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
Subject: [RFC PATCH 1/8] KEYS: Change the type of key->quotalen to unsigned int
Date: Mon, 19 Oct 2026 17:25:01 +0300
Message-ID: <20261019142516.300040-2-jarkko@kernel.org>
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

key_alloc() and key_payload_reserve() set key->quotalen with values,
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
index e40b5267658f..6729536a76b2 100644
--- a/include/linux/key.h
+++ b/include/linux/key.h
@@ -216,7 +216,7 @@ struct key {
 	kuid_t			uid;
 	kgid_t			gid;
 	key_perm_t		perm;		/* access permissions */
-	unsigned short		quotalen;	/* length added to quota */
+	unsigned int		quotalen;	/* length added to quota */
 	unsigned short		datalen;	/* payload data length
 						 * - may not match RCU dereferenced payload
 						 * - payload should contain own length
-- 
2.47.3

