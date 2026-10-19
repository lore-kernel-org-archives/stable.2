Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B477F547057;
	Mon, 19 Oct 2026 14:26:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1792419962; cv=none; b=BFZpTdTcqkKfyOdMB9iEvSK2rEZNvQWXwhWa5U9qrLkF5wCxUkpj0BVuIK78DGvDVQXqggLuHsvUhLxv1h21LpMevWYufK0NZMotTtJfTp1zJE2ENoo+UFRsEOW05VpuGuFSVY4fvLpi7/Os1Hq4el7PY33f9RlRoPlJihb2Xe4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1792419962; c=relaxed/simple;
	bh=VdE7kNdCWzMUy9Bt5Yz+m1YMOQWiQOyBBZJA1zVPvZ0=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=VlMW7oVNJA1rdyfpXeUonhYn3IRhDE7mSFDWGNAxIasOoNhvHibgxHKw5VzrFtDZYjRGmcsHM+1+ybuJmoz/jy5Jm+quXt5BPtqRRxSn4DfuOCV5Xtis3tLckut2I/nv612hyFDUAr3brb1EG3DsWXbGkNHhIF7Tn3FGdaGBRtE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=Yn/kPW94; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="Yn/kPW94"
Received: by smtp.kernel.org (Postfix) with UTF8SMTPSA id D87EB1F000C5;
	Mon, 19 Oct 2026 14:26:00 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1792419961;
	bh=+AWRgm7uNfmxNtSmNdc0nNffI7T6ptp8+S/m/3OZGDM=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References;
	b=Yn/kPW94Gvy7VssWQJfY95APzHRvXkftxIxl+BYwwxYJ81UroAkx1z5EaCf6XbLEA
	 9Wb4t2ELnVV7Aoxc0k4t4ok+aCexeC2oAtB/VjZi/mp2g86U5MTpvnr1aCzytNx+N/
	 nnueIkNrzgNlTHqBYQBVmJJCdEFnunNOayz1pVndCiGC5huYPr0kdB8rVRSStSoJsl
	 t8DqYV6xe/MJW6C3383qijsufUkXjk55JQPcCGm5Gysmrug4MXCeAXkG1DzVFBURx9
	 vgjsaI2Jbgi1n7Ejl8m9ynNJxDeqJiH0WRR8YgTaBO48iIAfJAUkPg0NMujUwzYfkS
	 mBLYHVJ5UGhAg==
From: Jarkko Sakkinen <jarkko@kernel.org>
To: David Howells <dhowells@redhat.com>
Cc: keyrings@vger.kernel.org,
	Eric Biggers <ebiggers@kernel.org>,
	Jarkko Sakkinen <jarkko@kernel.org>,
	stable@vger.kernel.org,
	Paul Moore <paul@paul-moore.com>,
	James Morris <jmorris@namei.org>,
	"Serge E. Hallyn" <serge@hallyn.com>,
	linux-security-module@vger.kernel.org (open list:SECURITY SUBSYSTEM),
	linux-kernel@vger.kernel.org (open list)
Subject: [RFC PATCH 7/8] KEYS: Reject @datalen values over INT_MAX
Date: Mon, 19 Oct 2026 17:25:07 +0300
Message-ID: <20261019142516.300040-8-jarkko@kernel.org>
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

Protect quota from overflowing by rejecting @datalen values that
surpass over INT_MAX.

Cc: stable@vger.kernel.org
Assisted-by: LLM
Fixes: 1da177e4c3f4 ("Linux-2.6.12-rc2")
Signed-off-by: Jarkko Sakkinen <jarkko@kernel.org>
---
 security/keys/key.c | 7 ++++++-
 1 file changed, 6 insertions(+), 1 deletion(-)

diff --git a/security/keys/key.c b/security/keys/key.c
index 5afc16425daf..5718ae7b80e5 100644
--- a/security/keys/key.c
+++ b/security/keys/key.c
@@ -379,11 +379,16 @@ EXPORT_SYMBOL(key_alloc);
  */
 int key_payload_reserve(struct key *key, size_t datalen)
 {
-	int delta = (int)datalen - key->datalen;
+	int delta;
 	int ret = 0;
 
 	key_check(key);
 
+	if (datalen > INT_MAX)
+		return -EINVAL;
+
+	delta = (int)datalen - key->datalen;
+
 	/* contemplate the quota adjustment */
 	if (delta != 0 && test_bit(KEY_FLAG_IN_QUOTA, &key->flags)) {
 		unsigned maxbytes = uid_eq(key->user->uid, GLOBAL_ROOT_UID) ?
-- 
2.47.3

