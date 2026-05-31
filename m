Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9F7351A8F7B;
	Sun, 31 May 2026 02:49:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1780195771; cv=none; b=XFMMjW7oPEViqWE/q7DJ6qtLvU0fNKFFcTqNiMon3hFF0NZJsB2h+A5ja9+g20VcJ5hlagXg2trw4Dzz2IGfF4ypWskuE6WuZ9Id5jo1DNsKQh+ztl75mP+7mxtTRG/S0vwVY978ehInEhJG2Tsgaouxvq/S3QnWBUqsr0lHUhk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1780195771; c=relaxed/simple;
	bh=bDYDvx2V7+tK7aqgpPuEk9coQxxvk/0vDczFqp0Vzxw=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=NfSVeDENYyNXOmiNFQc5DFVDqgVl6FI7ER35VhwiBHN7Zr3C6LnzStwxZLpuQIq0x+53GBhSsSI2aC9DBp4pWqYrOVeuUPCgLY82nJQgKCuX1fNzDz6K8WBu/z34cgF445DqfwyAde6DkwBJpdZ06S/X+NbdEgDV+DGOkh9s7nw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=fo3Gd6yG; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="fo3Gd6yG"
Received: by smtp.kernel.org (Postfix) with UTF8SMTPSA id 87ED81F00893;
	Sun, 31 May 2026 02:49:29 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1780195770;
	bh=A6IeEdZpvBmCUKsi3lq5RQ6kZ8FtktixPi29MeB6WaM=;
	h=From:To:Cc:Subject:Date;
	b=fo3Gd6yGK5rlRh94E12l1f+mMWiD64xwZS8GKxP7YcBwUvaHXo53nXdYx1EjrQW8r
	 xz/YPbN+nVPm6eRN0ScCD9Y4qvZzFvHGjWmNqUI+VAetWM77oDGoPvX5M/uzLCJojN
	 7j3Auy9yPihmbzbchwuS4nd8GCAtEC6nZQLUzIA7oU0G0nwFbZYcwSTg6cMiIcCzrT
	 bINaEIsPtb6CDKnhvy+DqZ49eVJpbJjIKHBtsekU3/g2JimFMrnVKn4r0SHgB73emf
	 kO10HM80S2SfcfOpHLCy+EGqJS/JtkMPnEXj/2s1Fqezf7olXEkMHOsWkRKI66j/HN
	 nAbkkNZURT1iQ==
From: Jarkko Sakkinen <jarkko@kernel.org>
To: keyringsy@vger.kernel.org
Cc: Jarkko Sakkinen <jarkko@kernel.org>,
	stable@vger.kernel.org,
	Alessandro Grupp <ale.grpp@gmail.com>,
	David Howells <dhowells@redhat.com>,
	Paul Moore <paul@paul-moore.com>,
	James Morris <jmorris@namei.org>,
	"Serge E. Hallyn" <serge@hallyn.com>,
	Denis Kenzior <denkenz@gmail.com>,
	Marcel Holtmann <marcel@holtmann.org>,
	keyrings@vger.kernel.org,
	linux-security-module@vger.kernel.org,
	linux-kernel@vger.kernel.org
Subject: [PATCH] KEYS: fix overflow in keyctl_pkey_params_get_2()
Date: Sun, 31 May 2026 05:49:13 +0300
Message-ID: <20260531024914.3712130-1-jarkko@kernel.org>
X-Mailer: git-send-email 2.47.3
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

The length for the internal output buffer is calculated incorrectly, which
can result overflow when a too small buffer is provided.

Fix the bug by allocating internal output with the size of the maximum
length of the cryptographic primitive instead of caller provided size.

Cc: stable@vger.kernel.org # v4.20+
Fixes: 00d60fd3b932 ("KEYS: Provide keyctls to drive the new key type ops for asymmetric keys [ver #2]")
Reported-by: Alessandro Grupp <ale.grpp@gmail.com>
Signed-off-by: Jarkko Sakkinen <jarkko@kernel.org>
---
Alessandro, please correct if I put the last name correctly (and
sincere apologies if not).
 security/keys/keyctl_pkey.c | 9 ++++++++-
 1 file changed, 8 insertions(+), 1 deletion(-)

diff --git a/security/keys/keyctl_pkey.c b/security/keys/keyctl_pkey.c
index 97bc27bbf079..ba150ee2d4a3 100644
--- a/security/keys/keyctl_pkey.c
+++ b/security/keys/keyctl_pkey.c
@@ -138,28 +138,35 @@ static int keyctl_pkey_params_get_2(const struct keyctl_pkey_params __user *_par
 		if (uparams.in_len  > info.max_dec_size ||
 		    uparams.out_len > info.max_enc_size)
 			return -EINVAL;
+
+		params->out_len = info.max_enc_size;
 		break;
 	case KEYCTL_PKEY_DECRYPT:
 		if (uparams.in_len  > info.max_enc_size ||
 		    uparams.out_len > info.max_dec_size)
 			return -EINVAL;
+
+		params->out_len = info.max_dec_size;
 		break;
 	case KEYCTL_PKEY_SIGN:
 		if (uparams.in_len  > info.max_data_size ||
 		    uparams.out_len > info.max_sig_size)
 			return -EINVAL;
+
+		params->out_len = info.max_sig_size;
 		break;
 	case KEYCTL_PKEY_VERIFY:
 		if (uparams.in_len  > info.max_data_size ||
 		    uparams.in2_len > info.max_sig_size)
 			return -EINVAL;
+
+		params->out_len = info.max_sig_size;
 		break;
 	default:
 		BUG();
 	}

 	params->in_len  = uparams.in_len;
-	params->out_len = uparams.out_len; /* Note: same as in2_len */
 	return 0;
 }

--
2.47.3

