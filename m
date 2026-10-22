Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=100.103.45.18
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1792697241;
	b=XFpuS0QV8qTgAB6vpm2GfkdzzUc9ke71LMBNmsdJZ9ClHM00qfVmshStHEbBfpW2kzSf
	 bOiLegy8/GpQoaXjIQ6B+61malBE1Ron0qtQoJekENihIAEXYBKOzE9xPXmXaZvKlH6vF
	 sR08N82f6sBmrTP+ZCv8RdmVAbzTD0+y/gRNOMeO8+1gjYoPubUOKbdHK3XZ1bQSY/y2X
	 99x7PMtZr4ITzddOMOk9+dP9GvC8Lmj/y12aLidBYX1jx9icBzL/vompnWUdNaBWzkpV1
	 nYcFaINGMfHRkG9gSKsmzknRgkbp4PcBmaIQXZZD/fkJcd2PF1z+p9EzJC6BFCui/2Q==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1792697241;
	h=Received:DKIM-Signature:From:To:Cc:Subject:Date:Message-ID:X-Mailer:
	 In-Reply-To:References:MIME-Version:Content-Transfer-Encoding;
	bh=Qu7bXSTKz4yJk5jFpot5GqPTr4OCRen0F7LdG3C/gXs=;
	b=kH7Fxav/rgMcuAQB4e53fdwMhVg22hDC2xYzMAOaDz9t8f/Mi7X1PYYO7riJyOzHDAkX
	 hZN9Ro6Cu4fmoxFwPQKb04Iz7qHPTOSD1QJ7Wg2pN1TmVqFtGcwFas9EiHwzTobTZvd7k
	 sQ9/HrOjRAPKQF8bppYBFAcAT6hFY33w8vds5k/zm5E/oBm1E2h7DDD45BlQ8uUxJ2zmw
	 a3QyesFpL6Y8m4j+6LrtKf03SuUAxG/rvp2+Us6B0xdlO5gQXBrP2ssyStXE70p5azoeB
	 fqA6y4cY7PzoqKxgvI4HdV4SQJooo5tvIjsNgAa46v25jr5DZjD2FrWNSosS9OQXP6Q==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dkim=pass header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b="Yr/F+5Zj";
	arc=none smtp.remote-ip=100.103.45.18
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E22BC606A31F
	for <stable@vger.kernel.org>; Thu, 22 Oct 2026 19:27:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=Yr/F+5Zj
Received: by smtp.kernel.org (Postfix) with ESMTPSA id D1E101F01825;
	Thu, 22 Oct 2026 19:27:19 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1792697240;
	bh=Qu7bXSTKz4yJk5jFpot5GqPTr4OCRen0F7LdG3C/gXs=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References;
	b=Yr/F+5Zjs3dctQ29NnTPwiSEbjCWs0bUcJLVnyWh6jis1dt8fTBTsW0Wsi3f84SEZ
	 ge6dB0tKt2TpNIC2w1e++GQf3brYUYgMDVLA7bPBFKcIxDX2MyvpvqaZ90qyUfwDxs
	 tNVjdh39lvoR8cVX0lo9BsF3Ons9hc/X/LOErv+5zsNZLf7ZtweEMwT5SPusNbB1M1
	 NNCSc0d8eO12HHHI0MQoRtfQ24yyHZ6SnObbYYyH6ZGW72KrIn1lvJyDq9llD0py2v
	 E5U15X16DX531pPfHtpUtZjQoRqMXLftXI+WjCrQZ/SZxR41Esdw+ay7rWQ3OtOjir
	 SFLxy+RRtIlVw==
From: Sasha Levin <sashal@kernel.org>
To: stable@vger.kernel.org
Cc: Aleksandr Khromov <haa@amicon.ru>,
	ChenXiaoSong <chenxiaosong@chenxiaosong.com>,
	Namjae Jeon <linkinjeon@kernel.org>,
	Sasha Levin <sashal@kernel.org>
Subject: [PATCH 5.15.y] ksmbd: zero the FS_OBJECT_ID_INFORMATION buffer before filling it in
Date: Thu, 22 Oct 2026 15:27:17 -0400
Message-ID: <20261022192708.1985263-1-sashal@kernel.org>
X-Mailer: git-send-email 2.53.0
In-Reply-To: <2026102212-scanner-refinery-9bbf@gregkh>
References: <2026102212-scanner-refinery-9bbf@gregkh>
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

From: Aleksandr Khromov <haa@amicon.ru>

[ Upstream commit 399aa12450a61a5c73dc77e73f069ece9687c95d ]

smb2_get_info_filesystem() reports 64 bytes for FS_OBJECT_ID_INFORMATION,
that is the whole of struct object_id_info, but writes only 46 of them:

 - objid[] is 16 bytes, and when the volume UUID is not available only
   sizeof(stfs.f_fsid) (8) bytes are copied into it;
 - extended_info.version_string[] is STRING_LENGTH (28) bytes, and only
   strlen("1.1.0") (5) bytes are copied into it.

The response buffer is zeroed on allocation (kvzalloc() in
smb2_allocate_rsp_buf()), so for a standalone request the remaining 31
bytes are zero.  In a compound request they need not be.  The offset of
the next response is advanced by the length pinned for the previous one,
so if a preceding command wrote its reply into the buffer and then
failed, smb2_set_err_rsp() pins only the short error response and the
next reply lands inside the area that has already been written.  Only
the header is cleared there:

	memset((char *)rsp_hdr, 0, sizeof(struct smb2_hdr) + 2);

The client then receives up to 31 bytes of a response it was not meant
to see, including one that failed with an access denied error.

Clear the structure before filling it in.  As a side effect
version_string is now NUL terminated.

Fixes: e2f34481b24d ("cifsd: add server-side procedures for SMB3")
Suggested-by: ChenXiaoSong <chenxiaosong@chenxiaosong.com>
Cc: stable@vger.kernel.org
Signed-off-by: Aleksandr Khromov <haa@amicon.ru>
Signed-off-by: Namjae Jeon <linkinjeon@kernel.org>
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 fs/ksmbd/smb2pdu.c | 1 +
 1 file changed, 1 insertion(+)

diff --git a/fs/ksmbd/smb2pdu.c b/fs/ksmbd/smb2pdu.c
index de03750a2b0c9..f6ebcc31d92bf 100644
--- a/fs/ksmbd/smb2pdu.c
+++ b/fs/ksmbd/smb2pdu.c
@@ -5196,6 +5196,7 @@ static int smb2_get_info_filesystem(struct ksmbd_work *work,
 		struct object_id_info *info;
 
 		info = (struct object_id_info *)(rsp->Buffer);
+		memset(info, 0, sizeof(*info));
 
 		if (!user_guest(sess->user))
 			memcpy(info->objid, user_passkey(sess->user), 16);
-- 
2.53.0

