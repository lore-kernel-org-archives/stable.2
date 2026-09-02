Received: from mail-pj1-f43.google.com (mail-pj1-f43.google.com [209.85.216.43])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 534BE4A9D47
	for <stable@vger.kernel.org>; Wed,  2 Sep 2026 16:02:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.216.43
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1788364931; cv=none; b=Txo3ScZCLYkzep90WxOEMo9WBLJn4Hjt86icsNG1Hwza3wXg56rdlFB+revsZS5yX7Os67NIwaAULb3K/MTfZh5LEGSWuvweU3LVL+FN58+XiFRLyXulcpM6SwMSANcjmOpigoRfUzpLrgWA5GZ84sFdnWBGCWhOPWjIag/3tJA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1788364931; c=relaxed/simple;
	bh=9I5oO8TVViSsNr3FLB77YmEfXkz8YCapbGx08I+BRDA=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=NmLl6WWobGLB/HA/WzU1wIg0LmjVIyJ4C4CdtfEBbl2XSq46F2Qxbyj26jDTqSrrQ+yUo8FrG65OHyiNfRJxl80k7QtAZQU2+9p2SoVtgaClkf/X6FMxVQJiTDFAJrQ+FiwGZmcu77UrW/eX3mOVJtxDW5DzuaugSc5XdqOnG8s=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=Pxr2xSDe; arc=none smtp.client-ip=209.85.216.43
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="Pxr2xSDe"
Received: by mail-pj1-f43.google.com with SMTP id 98e67ed59e1d1-398fb0feb91so201002a91.0
        for <stable@vger.kernel.org>; Wed, 02 Sep 2026 09:02:10 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1788364929; x=1788969729; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=E7cxQhTuF/zlwGqFHEIGDFyrMuVMlwIxDUes+hhhsEM=;
        b=Pxr2xSDe9WrSbBSlpowKdyBu5yBzYgLTcWtUS7ucA/ZKWvy0jUUfwerlAH0QSyAUrC
         +CviPk47XGBGSRKlPJLOoREWjYqEJNyWf54AVldoHgW3v20saDJC4a2SrYZmmuYGxSCp
         YADGvoxAIgAc4Q8GxhfgpBBXBJemUZhjQVXHZEe/HBP6EVkuK+ofu4vROQc/MgxJXQQi
         BrrqfV1CnQWRbE6YT0HSTs13QWdKOe2T1dpAUuVrT7hW8ll8O9PQ2XIX6EI6KrQS8TyS
         +rSsAmvL9/nCLfDgNw1tcPnTDelKgidItVFccqiPOSRK81GCfZwlKC2HKxscpw7JI7sP
         0SPg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1788364929; x=1788969729;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to:content-type;
        bh=E7cxQhTuF/zlwGqFHEIGDFyrMuVMlwIxDUes+hhhsEM=;
        b=ghmyLWJHl5iHmGnLlYvhkSS6nNpsKOXps3yVGzqUGAeTZ9e7lX2YC/tvEcuQ/sqMnL
         HLXXf5lP/MywhTG45TctGtnbqxI7QxkHgPmUnCPIj+T5OTBHA9xI2eIha8vsaxYjTnNP
         nXE7b5KVp3HzawNE5iJzPzOv7lYqdRN4MqhB/9BDqMN+fbSsgkihOkGtL2GmQLNOX24u
         3U8kCxy+7dr+pPMKw1jszJOVjVmeZH/HBDMBwp0QOC4dhxgq+zJPPiKKhUkDThTTs9RZ
         BtmT0dmZo9Crgm7JBDWQWzO5VJA4bwNLSh3SGVDR5lkSN2XPNDHxQw61n8NL/LdDD9Cw
         4ZNQ==
X-Forwarded-Encrypted: i=1; AKwUvBwGPfCEwh0ddpfJWhD4oQWl4mCEMvtFA6tKsQni2h5pzZrhyTAIUAaQumSkpnEFo0Z2W0HusNk=@vger.kernel.org
X-Gm-Message-State: AFuF++l8nFlVGE0Gzar6suaSi0c1RK881auLolHK38hM1COX/3vk50ux
	tjywO5V2wGxGFQ6RWwdwcOEpSGYpnZSvAm+JvLrZ+ZKsNpdJKoBjBi86
X-Gm-Gg: AYBFou0Yd57P1FBGFjTTpj5EHDMTRikz0FJ5Q4De+1p2oW6EkuO5Q+HtAwfDlYs6jeF
	q6h2l5XD8If0uYWIdD9w14/QDOedvZuB7iErARrVziCBgXW/3Y5busD7hrRyshTRPOBegJ5XXMK
	KromkaoAUxV5ZY6MmeGLtI4NgK1jQXms5BComAJ840RU4GONqGAewo5N2eYkTam37USOBmK8Thp
	kq0yuABEFkuCniu8y9XSzxA13/q4bKBWav87afXUVob+bxyp95WPRVNkNIYCOBHsv34zR+f3Hir
	aoYvfArX1srD/QYVCsxFOByQTwh7T8IhS6a2Al3IE7uyi2uuryDovzHHDoSjqSNe0R1fMl96orQ
	plEf6nNf4vGLvnY2lftNp8DIiybH+VIwGseXWDOgqdBtZQq3Ityeka4Q8SMHQfBbbgRtUl4AQAk
	/wyzfcZypAY21zkCe8/4W/9v0loziViX/H6EG7IJEl70ZZ2vVZ7b09FZzfhlb5bJ/aVuRSiyy3R
	VNVYIaXhbP+k0W+F1l2kt44kBHeorMOF3MHyeb6cyhf+tQcxQF5W25OlhtP1z8=
X-Received: by 2002:a17:90b:164b:b0:38e:7069:7117 with SMTP id 98e67ed59e1d1-39aedbeae14mr5212388a91.0.1788364929158;
        Wed, 02 Sep 2026 09:02:09 -0700 (PDT)
Received: from localhost.localdomain ([119.127.198.196])
        by smtp.gmail.com with ESMTPSA id 98e67ed59e1d1-39b08bcc081sm77979a91.6.2026.09.02.09.02.05
        (version=TLS1_3 cipher=TLS_CHACHA20_POLY1305_SHA256 bits=256/256);
        Wed, 02 Sep 2026 09:02:08 -0700 (PDT)
From: Qihang <q.h.hack.winter@gmail.com>
To: john.johansen@canonical.com,
	georgia.garcia@canonical.com
Cc: security@kernel.org,
	Qihang <q.h.hack.winter@gmail.com>,
	stable@vger.kernel.org
Subject: [PATCH] apparmor: make unpacked rename and attach strings owned copies
Date: Thu,  3 Sep 2026 00:01:38 +0800
Message-ID: <20260902160138.74264-1-q.h.hack.winter@gmail.com>
X-Mailer: git-send-email 2.50.1
In-Reply-To: <CAH78GvvERK9_hkKDa=Td8vK_89kZ4SPRb9J6UW5L0sMRPiUOBA@mail.gmail.com>
References: <CAH78GvvERK9_hkKDa=Td8vK_89kZ4SPRb9J6UW5L0sMRPiUOBA@mail.gmail.com>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

unpack_profile() stores the optional rename and attach strings using
aa_unpack_str(), which returns pointers into the policy blob.
profile->rename is later freed with kfree_sensitive(), causing an
invalid free of an interior pointer on the failed-unpack path.
profile->attach.xmatch_str can instead become a dangling pointer when
the original policy blob is freed after compressed binary policy export.
Use aa_unpack_strdup() for both strings and free xmatch_str with the
attachment.

Fixes: 736ec752d95e9 ("AppArmor: policy routines for loading and unpacking policy")
Cc: stable@vger.kernel.org
Signed-off-by: Qihang <q.h.hack.winter@gmail.com>
---
 security/apparmor/policy.c        | 1 +
 security/apparmor/policy_unpack.c | 7 +++++--
 2 files changed, 6 insertions(+), 2 deletions(-)

diff --git a/security/apparmor/policy.c b/security/apparmor/policy.c
index 94b4a7e727cc1..e9993cd53c903 100644
--- a/security/apparmor/policy.c
+++ b/security/apparmor/policy.c
@@ -281,6 +281,7 @@ static void free_attachment(struct aa_attachment *attach)
 	for (i = 0; i < attach->xattr_count; i++)
 		kfree_sensitive(attach->xattrs[i]);
 	kfree_sensitive(attach->xattrs);
+	kfree_sensitive(attach->xmatch_str);
 	aa_put_pdb(attach->xmatch);
 }
 
diff --git a/security/apparmor/policy_unpack.c b/security/apparmor/policy_unpack.c
index d9dcff167c480..9b534d56e38a5 100644
--- a/security/apparmor/policy_unpack.c
+++ b/security/apparmor/policy_unpack.c
@@ -1120,6 +1120,7 @@ static struct aa_profile *unpack_profile(struct aa_ext *e, char **ns_name)
 	size_t ns_len;
 	struct rhashtable_params params = { 0 };
 	char *key = NULL, *disconnected = NULL;
+	char *rename = NULL, *attach_str = NULL;
 	struct aa_data *data;
 	int error = -EPROTO;
 	kernel_cap_t tmpcap;
@@ -1159,10 +1160,12 @@ static struct aa_profile *unpack_profile(struct aa_ext *e, char **ns_name)
 	rules = profile->label.rules[0];
 
 	/* profile renaming is optional */
-	(void) aa_unpack_str(e, &profile->rename, "rename");
+	(void) aa_unpack_strdup(e, &rename, "rename");
+	profile->rename = rename;
 
 	/* attachment string is optional */
-	(void) aa_unpack_str(e, &profile->attach.xmatch_str, "attach");
+	(void) aa_unpack_strdup(e, &attach_str, "attach");
+	profile->attach.xmatch_str = attach_str;
 
 	/* xmatch is optional and may be NULL */
 	error = unpack_pdb(e, &profile->attach.xmatch, false, false, &info);
-- 
2.50.1 (Apple Git-155)

