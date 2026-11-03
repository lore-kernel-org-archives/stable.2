Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=100.103.45.18
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1793719232;
	b=sCHKXIKm1wUyrQEbiU684EU6rWBKr9pKRWjFvtayqIfL5aGMkNCHRW6yX6ZxTUv91yCX
	 BzktGI8jTn/JCmP7z10QIzdlwyRXjmihDcf2Fq1rIOJJhMuqsFMiOrr+segErlwvt+5fI
	 gfWQ2r+eEesj5uhO6MO6npxj8vb4n4+Eoulr8RO2q5AXyfDUa8JEsRivZOWWyyHrrfFWw
	 u/Vq7dgbnYYdfaJYoJnlh32l+O/OKD+lsxNPNs3+0tPZru5OvwHLDoxFruvCwjh19jq2H
	 y8OclSsLjzlxoizOyh55sjGlrrf2qMrW3UzgrIy4+wECnHw4x181KbA/UnTVAP5ZJzA==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1793719232;
	h=Received:DKIM-Signature:From:To:Cc:Subject:Date:Message-ID:X-Mailer:
	 In-Reply-To:References:MIME-Version:Content-Transfer-Encoding;
	bh=TTu5uKWZbqs7La8xRv9JcxdhlL/aiFG3QQqDM967/tw=;
	b=pwllQdX8nSzq/3PsPwR2k+x4Gj0LdG/spKfI1KK7qB1aFNr7yxXD06YPKn2CkV21u3Ta
	 eHN77cUyZJOE+d3BzdqUykl5bYjuP7tvkHdSRstbg7yq/wMMyUZi6x48AkGNim2J0Dh2E
	 bUZCDCENon4N0cNEgY276mUcu2FZVnKGEa3yEX7jT71wXk7RWT03LOg0hxzxkmZu58sDy
	 8qWyHQ7UjrMqLWIsI7KHRxzMC5p9qUkYVHb6zYzq5W8ciEDgSqkt0/b9si0xphr23kKiT
	 YzZE/lKXE6ejK9R+RAwTg6rjUrfvs2zFPTxQ7ufU8yPs6VdlLll3COBcNi24fEcNUHQ==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dkim=pass header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b="cH/QIhi+";
	arc=none smtp.remote-ip=100.103.45.18
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2CBDA606A328
	for <stable@vger.kernel.org>; Tue,  3 Nov 2026 15:20:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=cH/QIhi+
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 4C7E51F000C1;
	Tue,  3 Nov 2026 15:20:31 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1793719231;
	bh=TTu5uKWZbqs7La8xRv9JcxdhlL/aiFG3QQqDM967/tw=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References;
	b=cH/QIhi+kkQ9fOqseQz8XTeTmH6eSxuG8CONrXA2F0i+28XF/DlLDSndLjQRY0CcR
	 gk+FxTASguwupWoQKReNjmx9m1/xLAcXzJ1LeU+Fs7wTEMzGxmbtP49Uy/W/KVyjDp
	 amSyOYzX939+9FJAz8jtSM1oFXagB3IUNEVGQg4tHAwXRSXYYDumTbqLeZidmv/rW1
	 MprgA2Gct7dnzT7tXFtqxrqzRJGV/gXLn2Uyl0Nq5W4Zb/mXXegBpjGm4r0km3Kw2e
	 3IPPldee4PFV0dRkAItjT6T7tqowb/TJe3RXIQRWii+L2goQU42FwGxaVx6t5uV41X
	 3uT15MRhX455A==
From: Sasha Levin <sashal@kernel.org>
To: stable@vger.kernel.org
Cc: Abdifatah Suruur <suruurism@gmail.com>,
	Namjae Jeon <linkinjeon@kernel.org>,
	Sasha Levin <sashal@kernel.org>
Subject: [PATCH 5.15.y] ksmbd: reserve space for the UTF-16 terminator in stream info
Date: Tue,  3 Nov 2026 10:20:30 -0500
Message-ID: <20261103152019.378557-1-sashal@kernel.org>
X-Mailer: git-send-email 2.53.0
In-Reply-To: <2026110318-lanky-disallow-4cf3@gregkh>
References: <2026110318-lanky-disallow-4cf3@gregkh>
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

From: Abdifatah Suruur <suruurism@gmail.com>

[ Upstream commit a025c4991a7d83edc4dd339e3ea86d8ff6226eca ]

smb_strtoUTF16() always writes a terminating zero UTF-16 unit after the
converted characters, but get_file_stream_info() budgets only
sizeof(struct smb2_file_stream_info) + streamlen * 2 for a stream entry
and sizeof(struct smb2_file_stream_info) + 7 * 2 for the trailing
"::$DATA" entry. When an entry exactly fills the 448-byte small response
buffer, the terminator is written two bytes past the allocation.

Reserve one extra UTF-16 unit in both budget checks. The terminator is
not part of the wire format, so the reported lengths are unchanged.

Cc: stable@vger.kernel.org
Signed-off-by: Abdifatah Suruur <suruurism@gmail.com>
Signed-off-by: Namjae Jeon <linkinjeon@kernel.org>
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 fs/ksmbd/smb2pdu.c | 5 +++--
 1 file changed, 3 insertions(+), 2 deletions(-)

diff --git a/fs/ksmbd/smb2pdu.c b/fs/ksmbd/smb2pdu.c
index 4c42205fe5261..0346305edf8a4 100644
--- a/fs/ksmbd/smb2pdu.c
+++ b/fs/ksmbd/smb2pdu.c
@@ -4773,7 +4773,8 @@ static void get_file_stream_info(struct ksmbd_work *work,
 				     ":%s", &stream_name[XATTR_NAME_STREAM_LEN]);
 
 		next = sizeof(struct smb2_file_stream_info) + streamlen * 2;
-		if (next > buf_free_len) {
+		/* smbConvertToUTF16() also writes a terminating UTF-16 unit. */
+		if (next + sizeof(__le16) > buf_free_len) {
 			kfree(stream_buf);
 			break;
 		}
@@ -4795,7 +4796,7 @@ static void get_file_stream_info(struct ksmbd_work *work,
 
 out:
 	if (!S_ISDIR(stat.mode) &&
-	    buf_free_len >= sizeof(struct smb2_file_stream_info) + 7 * 2) {
+	    buf_free_len >= sizeof(struct smb2_file_stream_info) + (7 + 1) * 2) {
 		file_info = (struct smb2_file_stream_info *)
 			&rsp->Buffer[nbytes];
 		streamlen = smbConvertToUTF16((__le16 *)file_info->StreamName,
-- 
2.53.0

