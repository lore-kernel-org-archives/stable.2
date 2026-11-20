Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=202.12.124.145
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1795192483;
	b=ANC3y/IgINCEjalDLzTy9lVHa7Ok9YS5m+lN88s+jzpETB7NO3mSI8E/rOHYzPRDHsyM
	 FiOxWPBrzwqU9j9p8v4aaQSlrR7Gg7QULNKFJPPz+b29PaQQuiwnJnni+w5kRBy3ya+yN
	 XlknR/GX22t4xGhb1dLjkpvaSN/KdsDzAk0Yh6NunI0TkauYtb/sVp+EEHgjlkv01WHKN
	 dcf1toD6q38gtdVPJ5ujiFg3L3kuAaCNBZjaK8qsuIb4W6bSZF8yz2Arc7nPZ2tH0+qYo
	 7fSOJ8xCCxZgDvLz8w6wVizRqu9FbEJ1oY60iL9aJnRDNfAT+T76t054Lprc5l/RnoQ==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1795192483;
	h=DMARC-Filter:Received:Received:DKIM-Signature:DKIM-Signature:
	 X-DKIM2-Info:DKIM2-Signature:X-DKIM2-Info:Message-Instance:
	 X-ME-Sender:X-ME-Received:X-ME-Proxy-Cause:X-ME-Proxy:Feedback-ID:
	 Received:From:To:Cc:Subject:Date:Message-ID:X-Mailer:MIME-Version:
	 Content-Transfer-Encoding;
	bh=X24ex3EiipTM1kpb/Q/yNZUtD7740LWhK2VF6n9GGrk=;
	b=UnDeZ7jEpEdBR7zrqXVNGFoc59VzG2Q2pqKbwkYRKkEIZ0WOY5cHw5/8y003VrX116A1
	 WB4V7Q4+dGwvMYen/vGYIWRvPc19gQImrPYEe9K8u8m6C63VJAnrLnPBiAYLP3YeNzlmI
	 cV3bHb7+pMBwz65OdSi7MGBzc2q2Q4TpXXwIE2uuVmBjxFmUwpRzs8gaJbU9ct8O5KM0/
	 EG2acdrCfp73uN6iFyYgRRvyEVnNNPlXrHgZ0bJ2bQOfttQUPgh24UdYO7nr+pp08XMgw
	 DXi/NyrZVadLTrt2OkQttAuCNfH/cE46T2C4NOmkoxmIvArzDV2bDZW9/Gg+QnOJfHg==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=fastmail.org;
	spf=pass smtp.mailfrom=fastmail.org;
	dkim=pass header.d=fastmail.org header.i=@fastmail.org header.a=rsa-sha256 header.s=fm3 header.b=TfoQ8RwO;
	dkim=pass header.d=messagingengine.com header.i=@messagingengine.com header.a=rsa-sha256 header.s=fm3 header.b=MXgXgh9e;
	arc=none smtp.remote-ip=202.12.124.145
Received: from fout-b2-smtp.messagingengine.com (fout-b2-smtp.messagingengine.com [202.12.124.145])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 71ED5606A320
	for <stable@vger.kernel.org>; Fri, 20 Nov 2026 16:34:43 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 71ED5606A320
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=fastmail.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=fastmail.org
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=fastmail.org header.i=@fastmail.org header.a=rsa-sha256 header.s=fm3 header.b=TfoQ8RwO;
	dkim=pass (2048-bit key, unprotected) header.d=messagingengine.com header.i=@messagingengine.com header.a=rsa-sha256 header.s=fm3 header.b=MXgXgh9e
Received: from phl-compute-03.internal (phl-compute-03.internal [10.202.2.43])
	by mailfout.stl.internal (Postfix) with ESMTP id DFB6D1D004D7
	for <stable@vger.kernel.org>; Fri, 20 Nov 2026 11:34:42 -0500 (EST)
Received: from phl-frontend-03 ([10.202.2.162])
  by phl-compute-03.internal (MEProxy); Fri, 20 Nov 2026 11:34:42 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=fastmail.org; h=
	cc:cc:content-transfer-encoding:content-type:date:date:from:from
	:in-reply-to:message-id:mime-version:reply-to:subject:subject:to
	:to; s=fm3; t=1795192481; x=1795278881; bh=X24ex3EiipTM1kpb/Q/yN
	ZUtD7740LWhK2VF6n9GGrk=; b=TfoQ8RwO1pch4QcOnvEGHvX1QeFE96y7uZz1L
	1XaSDRfZxYZEyWEXrSQavfr8JYENK+3YpcQeFkvK/KBVesUVjxCkg1HT+qtkt7UD
	+gUt81pHCwSMbDgl/6WYqoKJ9I7gMcU7td5/ySyUKtVrFqgkoDHwtnU2CeKjxflz
	TSTy3q0duTN9aFKn4uQlviiOGhZL2ZL++1oWR3yjGcFkwO2FTHWwFG5u6YbhHMe8
	71scowOJgqQr/ZEYi0fxFzrz/FGQaI8t3BEQd6DEMdS/LLvi/73hRhyl4BaxEeqC
	9vrriHKdOUr88fe1YfJDln7GGmQfTAlwFbxQdZgx4z9zFg1Jg==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:cc:content-transfer-encoding
	:content-type:date:date:feedback-id:feedback-id:from:from
	:in-reply-to:message-id:mime-version:reply-to:subject:subject:to
	:to:x-me-proxy:x-me-sender:x-me-sender:x-sasl-enc; s=fm3; t=
	1795192481; x=1795278881; bh=X24ex3EiipTM1kpb/Q/yNZUtD7740LWhK2V
	F6n9GGrk=; b=MXgXgh9eFGCI2wu4bAamHMEATGkgYbhm0qyWz70q5qhWuP/vwDi
	eK5qCqQlCbjo6ob7Qd+16BmuAp+xz1CKZD0Apluoiq6HxHGBWbZrYkb+HflTnA/8
	wxbJ7Bkn7NgvhFSuJi1Msoe57f1c3dA7g35VPqng32xseLYVzRvK+6b2DMLAb9jV
	3CXEBCYatP2exoYEuZQC4ppzbQVGBG3k4UMfnC9BiGsZKLE8DeMhmXlQK0WctY1R
	/xqpIKw9Jtb4vjpNs+PZY8PY5MF/V5BdgT3lumfoZxYC8KqXMqjW/KLq759r0w7H
	JV+gjx3vNrXEIhz+MyrcwtYSmZU8UUCbdSQ==
X-DKIM2-Info: draft=ietf-dkim-dkim2-spec-09;
	repo=github.com/dkim2wg/interop; date=2026-11-03; sw=lmtpprox;
	action=sign d=fastmail.org a=rsa-sha256;
DKIM2-Signature: i=1; m=1; t=1795192481; d=fastmail.org;
	mf=PGljYkBmYXN0bWFpbC5vcmc+;
	rt=PHN0YWJsZUB2Z2VyLmtlcm5lbC5vcmc+;
	s=fm3:rsa-sha256:a03ts3B86d1kNSrfLH24K2Bws/pjyMxPnolxRhsTeb6A2kd
	gHzkv9irB9FcjNSwF5Ne24S8Qvn9lpWSs4fNcDkAnn0SYSLTiJHzGQBpwJOlQQ5F
	VUkLpxyfdgnJWEHVdOuxOz0GGg/tep62SAjjvsT36xZP09rykVrRCoYmPxLlTELA
	Nmm205TwFZbvL0HFbO047+UpqeclSAhcZRGiRtClxX3O2sgYLd4JZFN3eQbydySo
	60BtOmfyvsJLARH3DLop2xnkpuzHWMbRpzhqZjS8Rt2Rffp70N0AvO/KCk3KUKrP
	H7IpNb8OTRUgPUKkA0wDZhqeB/YKFHqrBbbko5A==;
X-DKIM2-Info: draft=ietf-dkim-dkim2-spec-09;
	repo=github.com/dkim2wg/interop; date=2026-11-03; sw=lmtpprox;
	action=mi-m=1; hc=9;
	hn=cc,content-transfer-encoding,date,feedback-id,from,
	message-id,mime-version,subject,to;
Message-Instance: m=1; h=sha256:JcELUK1mRSVKZmul57Bf+sPAlhQG7bw42KA3EeF1KBU=:AVSk4usgP9AFACwtF1OgxfkX1T/1w8ClXhe4VPr+RSo=;
X-ME-Sender: <xms:oXYAa6QJFCPl8ZglO0o35DI2TaoitIYlHhR_ahxhn3-IeVLFoIB5mw>
    <xme:oXYAa7xwGexuhnplpo5uN-L0P8Pv_LzBAn3rsnuM1Ji07saZF7j8H3ZK-D3ekrIsO
    5KvVSXXPeN7v4w1zKPFfgSVXxhfaIaKup_G_pnXN0O73poarlFsObbC>
X-ME-Received: <xmr:oXYAa6A4MdpxHetorv25MrJ6KZLEHJNl-bVjFXF0m_s-KQANKPGxRUrFbIFV4OqJ>
X-ME-Proxy-Cause: dmFkZTFrkt/592cIW6zcd2cS90fBkY8ChIF5aAyielgKNPXc04zGaX1wr3H7zzRLVOYXn4
    efXnbS0uveYupx8bTn2lQpurYHX1dDS6bFeaiFk+tAF0Kl827CKa2P2n3+lnW3m7mvCzlf
    CGCg7Pgio/PSOjAb+9BudjeBkgpjJhwYq46AMewWMxfW8Lp+MyHGl90pl7O2CMgndtTOv4
    5jKJvxROSjZhIbU6R6dIHlZX8b3FvVlv3mLix3JMZxvI9QMfNWSMAjJmb4Ym7PqjNFJ9Hg
    UoNDdkARhFhTIVkuOGKaBq1JnJ/xECjyGz35WglkTEoc0junbgq3jWdMS0FJDqau9tnEWR
    fqiqKnBT6liUR/Feb5Flx6Lr3hHQ7X4XXktYdXl0es6L8YzALhxualXwn1//T7PdT1nOFu
    oXohMeVkW/+XQ1AlSraUDU+QnNuCFrtown481mov8MMiA5x6pMwav2kwN4AiDSju5nTbD9
    y9blwkTCnSoUDpWELBMDJQ+Ja3mV6T3RA+UScJY3mXJDW6zZFXewtwcMrhAVLX166dlIaa
    R0W+FbaBIcZe356ateuU3RHU5JAcQwbUIPAmBt352pS+h/mhkNlZQ/YBaRi786OlLvH2tE
    Q2ThuCfkttn0Gtq3Vc7M8YlR8k4PKPRshX90AgX2FBRqn4UzN2TyDrEROV0g
X-ME-Proxy: <xmx:oXYAa3G8CEa4nLmJ-IayIO9Vij-tucdCfpwidKQS-GKLwUZhjlGpgQ>
    <xmx:oXYAaxOXT-jzp3IknGFN68DupBVKsql1Gs7TJIvmukE71sR_QXLAAw>
    <xmx:oXYAa44arzgfeQbSXebKNIV8nwV5pjLAqQQzax9qZvwaupqn7a8XAw>
    <xmx:oXYAa0gS0pS6JI7k_0uQtftgs-Eb1bb0CPs5eUYIjVu_71-j3CyyXA>
    <xmx:oXYAa94YIsB55I3WztOPyVsoig-p69q7mHldhd5wz_rHgM5wqluouppS>
Feedback-ID: ib53e4b78:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Fri,
 20 Nov 2026 11:34:40 -0500 (EST)
From: Ian Bridges <icb@fastmail.org>
To: linkinjeon@kernel.org
Cc: senozhatsky@chromium.org,
	tom@talpey.com,
	chenxiaosong@chenxiaosong.com,
	linux-cifs@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	Ian Bridges <icb@fastmail.org>,
	stable@vger.kernel.org
Subject: [PATCH] ksmbd: check the ACEs after an NFS mode ACE in a DACL
Date: Fri, 20 Nov 2026 10:34:36 -0600
Message-ID: <20261120163436.15296-1-icb@fastmail.org>
X-Mailer: git-send-email 2.47.3
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

An allow ACE with SID S-1-5-88-3-<mode> supplies the POSIX mode
directly, and parse_dacl() stops walking the ACEs at the first one.
The same walk checks each ACE and maps its generic rights, so the ACEs
after the NFS mode ACE are neither checked nor mapped. set_info_sec()
still stores the entire DACL and the request succeeds, but part of
that DACL can have no effect.

Continue checking the remaining ACEs and mapping their generic rights,
while preserving the mode from the first NFS mode ACE.

Fixes: e2f34481b24d ("cifsd: add server-side procedures for SMB3")
Cc: stable@vger.kernel.org
Signed-off-by: Ian Bridges <icb@fastmail.org>
---

Without this patch, an ACE allowing GENERIC_READ after the NFS mode
ACE grants no access, because the right stays unmapped. A malformed
ACE after the NFS mode ACE is stored instead of being refused. The
access check and QUERY stop at it, so the ACEs after it are neither
applied nor returned.

Tested on ksmbd-for-next 2ef9bd9fa819 with KASAN. CREATE now rejects a
malformed ACE after an NFS mode ACE with STATUS_INVALID_PARAMETER.
GENERIC_READ in a later ACE is stored as the mapped rights, 0x120089,
and now grants read access. Other tested descriptors are stored
unchanged, and smbtorture results match the base.

This patch was developed with LLM assistance.

 fs/smb/server/smbacl.c | 7 ++++++-
 1 file changed, 6 insertions(+), 1 deletion(-)

diff --git a/fs/smb/server/smbacl.c b/fs/smb/server/smbacl.c
index 58b74b95246e..7bb28ea195c8 100644
--- a/fs/smb/server/smbacl.c
+++ b/fs/smb/server/smbacl.c
@@ -401,6 +401,7 @@ static int parse_dacl(const struct mnt_idmap *idmap,
 	struct posix_acl_state acl_state, default_acl_state;
 	umode_t mode = 0, acl_mode;
 	bool owner_found = false, group_found = false, others_found = false;
+	bool nfs_mode_found = false;
 
 	if (!pdacl)
 		return 0;
@@ -479,13 +480,17 @@ static int parse_dacl(const struct mnt_idmap *idmap,
 		ppace[i]->access_req =
 			smb_map_generic_desired_access(ppace[i]->access_req);
 
+		/* ACEs after an NFS mode ACE do not change the POSIX mapping */
+		if (nfs_mode_found)
+			continue;
+
 		if (ppace[i]->type == ACCESS_ALLOWED &&
 		    ppace[i]->sid.num_subauth >= 3 &&
 		    !(compare_sids(&ppace[i]->sid, &sid_unix_NFS_mode))) {
 			fattr->cf_mode =
 				le32_to_cpu(ppace[i]->sid.sub_auth[2]);
 			fattr->cf_posix_mode = true;
-			break;
+			nfs_mode_found = true;
 		} else if (!compare_sids(&ppace[i]->sid, pownersid)) {
 			acl_mode = access_flags_to_mode(fattr,
 							ppace[i]->access_req,
-- 
2.47.3

