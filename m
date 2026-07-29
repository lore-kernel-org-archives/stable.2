Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BC07F4949F7
	for <stable@vger.kernel.org>; Wed, 29 Jul 2026 13:55:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1785333322; cv=none; b=iUedUv9VURBl1nOJwAY3zGWQtccDOJ5A2eKiT4+2FV1pwx8tBX/Qv91F/ZnLKiugsEXb7+q2eKy476qZAeR8Np4jEFeGXUXBywyWLVUBFG5ZrxOeyqgkIwXDs42s6vIdhWKJdznyK9xrxGZZ3cl81X+wGiusuU1hDOAyF0iXOfk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1785333322; c=relaxed/simple;
	bh=bNNTKeRpxaNegufHnK7tqA+HzH1ez6DI2LwZ3r6HKck=;
	h=Subject:To:Cc:From:Date:Message-ID:MIME-Version:Content-Type; b=ErrJPQew8J5F3C82VXhh/e5UepQQyrLR5ZEBI/8bLEnYyJYR+CdMTpdsWeZG/CLuxS6rAaa9YLioV/tVQJGX/pWosZI2NfBNpvKt82zsuJ3rOyJI3Vx9LhzLcgXM9TIWgnoAfeLFIKM1ReQOBAYikEj12tWTzDghoT7axo3aLYM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b=uRIwgrCZ; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b="uRIwgrCZ"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id C8C571F00A3A;
	Wed, 29 Jul 2026 13:55:16 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linuxfoundation.org;
	s=korg; t=1785333317;
	bh=6D5BDUMCjKtFRyibZjSB/d0168M8zh9+oAKIec+yO3A=;
	h=Subject:To:Cc:From:Date;
	b=uRIwgrCZs06ORc8FQdoagGJ7XR34q9Vud/uoTzXjsGj6InsgK0GGk/TQHmb6VGJDT
	 BFOy4U4VsapNpIceuHebS1TSc17nFkkHar8a/7h8Pvg//mBkLuAsb2cq0M9V8o1YyO
	 zbEtV/+7YhZn6WrDHpXSZpshJHcCny6nuOnYjaxc=
Subject: FAILED: patch "[PATCH] ksmbd: defer destroy_previous_session() until after NTLM" failed to apply to 5.15-stable tree
To: james_montgomery@disroot.org,linkinjeon@kernel.org,stfrench@microsoft.com
Cc: <stable@vger.kernel.org>
From: <gregkh@linuxfoundation.org>
Date: Wed, 29 Jul 2026 15:55:04 +0200
Message-ID: <2026072903-union-lagging-6c3f@gregkh>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=ANSI_X3.4-1968
Content-Transfer-Encoding: 8bit


The patch below does not apply to the 5.15-stable tree.
If someone wants it applied there, or to any other stable or longterm
tree, then please email the backport, including the original git commit
id to <stable@vger.kernel.org>.

To reproduce the conflict and resubmit, you may use the following commands:

git fetch https://git.kernel.org/pub/scm/linux/kernel/git/stable/linux.git/ linux-5.15.y
git checkout FETCH_HEAD
git cherry-pick -x c74801ee524f477c174a1899782b6c3b6918d407
# <resolve conflicts, build, test, etc.>
git commit -s
git send-email --to '<stable@vger.kernel.org>' --in-reply-to '2026072903-union-lagging-6c3f@gregkh' --subject-prefix 'PATCH 5.15.y' 'HEAD^..'

Possible dependencies:



thanks,

greg k-h

------------------ original commit in Linus's tree ------------------

From c74801ee524f477c174a1899782b6c3b6918d407 Mon Sep 17 00:00:00 2001
From: James Montgomery <james_montgomery@disroot.org>
Date: Fri, 3 Jul 2026 15:26:41 -0400
Subject: [PATCH] ksmbd: defer destroy_previous_session() until after NTLM
 authentication

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

diff --git a/fs/smb/server/smb2pdu.c b/fs/smb/server/smb2pdu.c
index d54b714cc36c..c1ba5e01aa7f 100644
--- a/fs/smb/server/smb2pdu.c
+++ b/fs/smb/server/smb2pdu.c
@@ -1717,11 +1717,6 @@ static int ntlm_authenticate(struct ksmbd_work *work,
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
@@ -1761,6 +1756,10 @@ static int ntlm_authenticate(struct ksmbd_work *work,
 		}
 	}
 
+	prev_id = le64_to_cpu(req->PreviousSessionId);
+	if (prev_id && prev_id != sess->id)
+		destroy_previous_session(conn, sess->user, prev_id);
+
 	/*
 	 * If session state is SMB2_SESSION_VALID, We can assume
 	 * that it is reauthentication. And the user/password

