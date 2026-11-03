Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=100.103.45.18
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1793700967;
	b=If7l6rG7sHZHTmuo31Dy3PgIazRXHm4jdkLjIuMIbwPbKqUcEI+9SoQoNl8gJf/7JSW5
	 /GwGreZw4/ck2DF0ILZN7eiMjFMABrEB1tFZB+TWHwAbPLMId8XKNXiqYCyS1yxnfUrwV
	 lZACCJYZMb5OnlcCxiOTe0TXaCnxrNV6s1/KdrkSyg8vCfytZ/lvNaSB7315Nh9aC0ZAm
	 s21qCwFGk8TsiYR8IctaUAfiKgwQUYbq+PX108lp50ayOJhKz5KqZwLS77M2bgvZJ3Qgx
	 5oE9wPBmQc0RBZEQsg9osAYrs4o9rqhOEj0cIIWOptkcjc640qWntDQsgzyJkhNMJKA==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1793700967;
	h=Received:DKIM-Signature:Subject:To:Cc:From:Date:Message-ID:
	 MIME-Version:Content-Type:Content-Transfer-Encoding;
	bh=lM/zvcR3+rcjBZ1Ne9UIEH/Tks5BLX3uRMNXCRbrWCw=;
	b=I3MIEGVbmMC6LOpD3bflJ5yiRx35oAZjBxQfDCFimiZuo1LUsv9LhZ64CzVPAucoE9L3
	 CrUvM3o05YRv+OupAhe73cZLJUGrv4X1k8E/709Qw13EEgqB1KTjaAKG1KaNvgNl20Uo3
	 nVdxiLU8VBWsJilWhpsPhg9psmRAodXxVfe6AD/xrwnabR9TJf4QYjT6UESWRUJ/hm31G
	 +rf4caqMDzkB0Kg5Rgrrffi+n6qVzaWRUGxgOYcLau2DXzzNlvlgHehIEHf1//w/5dieB
	 jLTlKLKfOIkt3oNZXIQMSysXQd+mnNqZK0IyruQGFOjfkuaSD88g1shGGN7k1Fzji1w==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dkim=pass header.d=linuxfoundation.org header.i=@linuxfoundation.org header.a=rsa-sha256 header.s=korg header.b=Fzu9rtux;
	arc=none smtp.remote-ip=100.103.45.18
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7CB76606A324
	for <stable@vger.kernel.org>; Tue,  3 Nov 2026 10:16:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key, unprotected) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.a=rsa-sha256 header.s=korg header.b=Fzu9rtux
Received: by smtp.kernel.org (Postfix) with ESMTPSA id D0B7B1F000C1;
	Tue,  3 Nov 2026 10:16:06 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linuxfoundation.org;
	s=korg; t=1793700967;
	bh=lM/zvcR3+rcjBZ1Ne9UIEH/Tks5BLX3uRMNXCRbrWCw=;
	h=Subject:To:Cc:From:Date;
	b=Fzu9rtuxRJa30RSTbtCVjAMdXTPYPFk6HGN3TmsKb8uYgAfFCV1c/7ydr47y3SpZH
	 eMVFjQYvsEaW48YOfJ+wssbC9VK3DKmvfjzE8BezUY0q6z9g/UMRsTRV/VXAxL3f2h
	 cOYgKKAXo3t+gqp7MlfAQ9y1seO1ObrSDttDaWYs=
Subject: FAILED: patch "[PATCH] ksmbd: fix extended session security negotiation for raw" failed to apply to 5.15-stable tree
To: linkinjeon@kernel.org,tealaforgia+alias@gmail.com
Cc: <stable@vger.kernel.org>
From: <gregkh@linuxfoundation.org>
Date: Tue, 03 Nov 2026 11:16:05 +0100
Message-ID: <2026110305-blimp-nape-e4b2@gregkh>
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Post: <mailto:stable@vger.kernel.org>
List-Help: <mailto:stable+help@vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
List-Owner: <mailto:stable+owner@vger.kernel.org>
Precedence: list
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
git cherry-pick -x 6868f857514bbfd2ed10b9b566664dc4a8ca039d
# <resolve conflicts, build, test, etc.>
git commit -s
git send-email --to '<stable@vger.kernel.org>' --in-reply-to '2026110305-blimp-nape-e4b2@gregkh' --subject-prefix 'PATCH 5.15.y' 'HEAD^..'

Possible dependencies:



thanks,

greg k-h

------------------ original commit in Linus's tree ------------------

From 6868f857514bbfd2ed10b9b566664dc4a8ca039d Mon Sep 17 00:00:00 2001
From: Namjae Jeon <linkinjeon@kernel.org>
Date: Sun, 4 Oct 2026 09:42:27 +0900
Subject: [PATCH] ksmbd: fix extended session security negotiation for raw
 NTLMSSP

ksmbd_build_ntlmssp_challenge_blob() only advertises extended session
security when conn->use_spnego is true. As a result, raw NTLMSSP
negotiation drops NTLMSSP_NEGOTIATE_EXTENDED_SEC from the challenge even
when the client requested it.

A Windows capture shows an initial SPNEGO authentication succeeding,
followed by a raw NTLMSSP negotiation on the same TCP connection. The raw
challenge omits extended session security, and the client does not send
an AUTHENTICATE message. The unfinished session then occupies the pending
session slot, causing subsequent SESSION_SETUP requests to fail with
STATUS_INSUFFICIENT_RESOURCES.

Set NTLMSSP_NEGOTIATE_EXTENDED_SEC whenever the client requests it,
independently of the SPNEGO wrapper, as required by [MS-NLMP].

Fixes: e2f34481b24d ("cifsd: add server-side procedures for SMB3")
Cc: stable@vger.kernel.org
Reported-by: Tea La Forgia <tealaforgia+alias@gmail.com>
Signed-off-by: Namjae Jeon <linkinjeon@kernel.org>

diff --git a/fs/smb/server/auth.c b/fs/smb/server/auth.c
index 1b24eb3f3998..88953315b160 100644
--- a/fs/smb/server/auth.c
+++ b/fs/smb/server/auth.c
@@ -336,8 +336,7 @@ ksmbd_build_ntlmssp_challenge_blob(struct challenge_message *chgblob,
 	if (cflags & NTLMSSP_REQUEST_TARGET)
 		flags |= NTLMSSP_REQUEST_TARGET;
 
-	if (conn->use_spnego &&
-	    (cflags & NTLMSSP_NEGOTIATE_EXTENDED_SEC))
+	if (cflags & NTLMSSP_NEGOTIATE_EXTENDED_SEC)
 		flags |= NTLMSSP_NEGOTIATE_EXTENDED_SEC;
 
 	if (cflags & NTLMSSP_NEGOTIATE_KEY_XCH)

