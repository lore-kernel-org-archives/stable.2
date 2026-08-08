Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 49EAB3DD528
	for <stable@vger.kernel.org>; Sat,  8 Aug 2026 12:29:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1786192148; cv=none; b=U7lciOnq1pLyKkSpEapAuv9g7MclW9R8sJ82izkZ/N1lU+3WUinBuVUng3EvOZ1f66e8PH41BqOk8xhS8FeJLLFEp+egwwNpI0eINPKtc8qk7nP8utsxmVxuioi8cBsRWNfD9HzeAyVUX2+yHRTMrxOYaidWD8mPCrnh6BeW1C0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1786192148; c=relaxed/simple;
	bh=EkwY1Uik3MR9XhF66mmUMtKp9yklwSwlFXKXZwB92Kc=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=KfKtTQHa5OJqSkFZF7Ywz+FrOuvGLqZlWzAn5jGxOkpaFS4ZnCd8g1Ob7quBUY1GfaIVOT+GAv/Rz3vt/TuXBvyMnFjzYqwsbRL1t3Di6+zgOzS4xTJeFOg9fMqw5P7tVw/R+PFfDSghWjTZhkAGtKpsVxcWYimtfZV15iMjpoE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=iijh9JcM; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="iijh9JcM"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id BA36B1F000E9;
	Sat,  8 Aug 2026 12:29:02 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1786192143;
	bh=sPZPx/oxYTacmoiTkLT6TsVJ5MdmxBuXY8TsqWbY0ik=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References;
	b=iijh9JcMwU1yyG2vU1Q+OI8aAD6A6OqDTFN9BMK73hqtDiRWFRowl+S+VXuhhnfKG
	 h9e41EbRYySue/C/QsnnLG22pMKUfXdZ9y5ck70wbUST78txe6kQA/syystVyaPMgs
	 rEPnKn7gc1UKL/QGwP/vEy01S3iVilJH377ysyhD+oSTtrvCHnOGZvt3LdG1dQXVJ6
	 Exb9FCr1qAbMsTYkmtX9INhsDRMbu12oDlnUYrKs549eSOvNMVH3mLyg7RusINxsfN
	 gS1GN5VE/KZo/x6HlLA/LqNxdFeSPGgqrndnQ7ZzAgtIXR1dHlx426UQYQkacU7BFp
	 NERb0vm3Eqlzg==
From: Sasha Levin <sashal@kernel.org>
To: stable@vger.kernel.org
Cc: James Montgomery <james_montgomery@disroot.org>,
	Namjae Jeon <linkinjeon@kernel.org>,
	Steve French <stfrench@microsoft.com>,
	Sasha Levin <sashal@kernel.org>
Subject: [PATCH 5.15.y] ksmbd: defer destroy_previous_session() until after NTLM authentication
Date: Sat,  8 Aug 2026 08:29:01 -0400
Message-ID: <20260808122901.253582-1-sashal@kernel.org>
X-Mailer: git-send-email 2.53.0
In-Reply-To: <2026072903-union-lagging-6c3f@gregkh>
References: <2026072903-union-lagging-6c3f@gregkh>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

From: James Montgomery <james_montgomery@disroot.org>

[ Upstream commit c74801ee524f477c174a1899782b6c3b6918d407 ]

In ntlm_authenticate(), destroy_previous_session() is called using a
user pointer resolved from the client-supplied NTLM blob username field
before the NTLMv2 response is validated. An authenticated attacker can
set the NTLM blob username to match a victim account and set
PreviousSessionId to the victim's session ID; destroy_previous_session()
destroys the victim's session while ksmbd_decode_ntlmssp_auth_blob()
subsequently rejects the request with -EPERM.

Move destroy_previous_session() and the prev_id assignment to after
ksmbd_decode_ntlmssp_auth_blob() returns success and use sess->user
rather than the pre-authentication lookup result. This matches the
ordering already used by krb5_authenticate(), where
destroy_previous_session() is called only after
ksmbd_krb5_authenticate() returns success.

Fixes: e2f34481b24d ("cifsd: add server-side procedures for SMB3")
Cc: stable@vger.kernel.org
Link: https://lore.kernel.org/linux-cifs/20260702155449.3639773-1-james_montgomery@disroot.org/
Signed-off-by: James Montgomery <james_montgomery@disroot.org>
Acked-by: Namjae Jeon <linkinjeon@kernel.org>
Signed-off-by: Steve French <stfrench@microsoft.com>
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 fs/ksmbd/smb2pdu.c | 9 ++++-----
 1 file changed, 4 insertions(+), 5 deletions(-)

diff --git a/fs/ksmbd/smb2pdu.c b/fs/ksmbd/smb2pdu.c
index f7eeb79be48ab..f012b85e1d0d9 100644
--- a/fs/ksmbd/smb2pdu.c
+++ b/fs/ksmbd/smb2pdu.c
@@ -1495,11 +1495,6 @@ static int ntlm_authenticate(struct ksmbd_work *work,
 		return -EPERM;
 	}
 
-	/* Check for previous session */
-	prev_id = le64_to_cpu(req->PreviousSessionId);
-	if (prev_id && prev_id != sess->id)
-		destroy_previous_session(conn, user, prev_id);
-
 	if (sess->state == SMB2_SESSION_VALID) {
 		/*
 		 * Reuse session if anonymous try to connect
@@ -1537,6 +1532,10 @@ static int ntlm_authenticate(struct ksmbd_work *work,
 		}
 	}
 
+	prev_id = le64_to_cpu(req->PreviousSessionId);
+	if (prev_id && prev_id != sess->id)
+		destroy_previous_session(conn, sess->user, prev_id);
+
 	/*
 	 * If session state is SMB2_SESSION_VALID, We can assume
 	 * that it is reauthentication. And the user/password
-- 
2.53.0

