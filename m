Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=103.168.172.146
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1795017329;
	b=MFTvvJ7cNZv72XV7HUg+q3PCc17+IrY24TymniWt84H9N3UmthPFa2Oyqi6NWUbcGWnT
	 SajvFvBEUaGK7qK+8Ar9aCBjs0mhmjxaaAK4KrKtczmvx/MJ5SHwX8rMndlADZouOqKkf
	 ld5v4rz/CyGp/ZlnRmofgrTWHjfEO5Q2OyI9kSUdK6zRrvOmml+Oxwe6UjI0cVMnn9OiY
	 GXCvH85BUN/1WTuvLRXNcZP6DTHQtlqKVbFEfNsFLc1e8K4hsnpSIXVtQAXydOvG0Nub0
	 znIfe4o6YJUT9ZLtrkZs0T2Asm5+7kdO2Lzk8UvsK7txtkjrK8KFckU79+49e/LK//w==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1795017329;
	h=DMARC-Filter:Received:Received:DKIM-Signature:DKIM-Signature:
	 X-DKIM2-Info:DKIM2-Signature:X-DKIM2-Info:Message-Instance:
	 X-ME-Sender:X-ME-Received:X-ME-Proxy-Cause:X-ME-Proxy:Feedback-ID:
	 Received:From:To:Cc:Subject:Date:Message-ID:X-Mailer:MIME-Version:
	 Content-Transfer-Encoding;
	bh=1tS67bCUwoJG/QZK2bvrIJTbgYuji/yc/2nuV8sBM4A=;
	b=4K2XGTmiYAjgM8lNaWkrUYhFi2OyVjxdoS+jf3Y5aGqs2yA/XqcF/FMSc6srIAzUMrCG
	 szdO8kUumS02f3jrtBpfeBLxqQc9lW8WAGoFCV7UTXTTuzMn0noiBwEz0s1aBX6LGiRiE
	 duPUR5TzGWR58TAhUDR3aGQDHo+siwO38IYz0CjMB/2ZhQ/eNElXZWo6l9m3rYI/3hduB
	 xSjLnSIZYDUUVrdsXGpcIqWkdYwMZxx80viKgpha1l9+cDm1sxotSCAptZJB1js2fohaP
	 /gge8dk1xXEBidAwSt3dpyvrJQViHVPUzITS39gaX/4GBaF6mX9pHR2Lsb5TNCvTJNw==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=fastmail.org;
	spf=pass smtp.mailfrom=fastmail.org;
	dkim=pass header.d=fastmail.org header.i=@fastmail.org header.a=rsa-sha256 header.s=fm3 header.b=tayDF9Sn;
	dkim=pass header.d=messagingengine.com header.i=@messagingengine.com header.a=rsa-sha256 header.s=fm3 header.b=UkjQtvqL;
	arc=none smtp.remote-ip=103.168.172.146
Received: from fout-a3-smtp.messagingengine.com (fout-a3-smtp.messagingengine.com [103.168.172.146])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0EFF8606A32F
	for <stable@vger.kernel.org>; Wed, 18 Nov 2026 15:55:27 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 0EFF8606A32F
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=fastmail.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=fastmail.org
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=fastmail.org header.i=@fastmail.org header.a=rsa-sha256 header.s=fm3 header.b=tayDF9Sn;
	dkim=pass (2048-bit key, unprotected) header.d=messagingengine.com header.i=@messagingengine.com header.a=rsa-sha256 header.s=fm3 header.b=UkjQtvqL
Received: from phl-compute-02.internal (phl-compute-02.internal [10.202.2.42])
	by mailfout.phl.internal (Postfix) with ESMTP id 1BB6AEC0B86
	for <stable@vger.kernel.org>; Wed, 18 Nov 2026 10:55:27 -0500 (EST)
Received: from phl-frontend-03 ([10.202.2.162])
  by phl-compute-02.internal (MEProxy); Wed, 18 Nov 2026 10:55:27 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=fastmail.org; h=
	cc:cc:content-transfer-encoding:content-type:date:date:from:from
	:in-reply-to:message-id:mime-version:reply-to:subject:subject:to
	:to; s=fm3; t=1795017327; x=1795103727; bh=1tS67bCUwoJG/QZK2bvrI
	JTbgYuji/yc/2nuV8sBM4A=; b=tayDF9SnxDCDDW+6mr/M64mbOBCtn3qjUhgWt
	YNwT9ilnrAbc92IwzXk0Bk0XpaYgWAm0UJl6Zk8m66ZSYY5AIG5tzrBI8n/c0i6B
	J9WH3i5JgW4lK0UQOVaWu+CNwsYzA3VyB/xm1QB5B/LT6pz0ADX3xUw1fryuPbZ/
	ZBgya7Hn9zRwy4iQvrGm19nPI1T8TYipwriJxwgdm95U+oei+mr3fXV9mczpSTAO
	BjY/wVkpowgOUUxMrKpGOCEBRUrt9gpw0ldRrlvdMiPvUym/ctjkdt6LfpSH3EPR
	rjiOI6toS0cr4bXrT7ccna0MEWKnJGlUN4hmkknG3Yglp0/rg==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:cc:content-transfer-encoding
	:content-type:date:date:feedback-id:feedback-id:from:from
	:in-reply-to:message-id:mime-version:reply-to:subject:subject:to
	:to:x-me-proxy:x-me-sender:x-me-sender:x-sasl-enc; s=fm3; t=
	1795017327; x=1795103727; bh=1tS67bCUwoJG/QZK2bvrIJTbgYuji/yc/2n
	uV8sBM4A=; b=UkjQtvqLSv4pHlDh45I+gd7a2PWBZwP/v790vZpApLsepHHu8JL
	FXQku8L5V43ojREYoOlZ0UBaUPtV00OoWRSoKmcHfdCOGHIbLPAAhDjVAi1nU6tR
	3dD8HsHQmOIr2fKISnR16QqCbwk+WFozMeMA2tE8e+RkSINMRA25ybxyRUM3x2Rz
	74flJWxbXcUMidgCxFqerHE/Q6QRGzLatA8WbAKf8tnKYdkYsEnxyD/VYntsUsHF
	xhvvaxkPbKXS4EI7ItsDJyZjXIZPpfxy/cr7GRk4Oj0KlptCKNpIReVr31vr+Pls
	Wvl75ejS1LZVMu+qoqOJNmCjJdFolK6AJiQ==
X-DKIM2-Info: draft=ietf-dkim-dkim2-spec-09;
	repo=github.com/dkim2wg/interop; date=2026-11-03; sw=lmtpprox;
	action=sign d=fastmail.org a=rsa-sha256;
DKIM2-Signature: i=1; m=1; t=1795017327; d=fastmail.org;
	mf=PGljYkBmYXN0bWFpbC5vcmc+;
	rt=PHN0YWJsZUB2Z2VyLmtlcm5lbC5vcmc+;
	s=fm3:rsa-sha256:JG3waZzVsuNjzqlwcB+KA5LheXAVBnktdWsugcaQ89zLvYI
	APAtgMENlAGukDNMc+6k6qGd7kp1jKoU0FVkwzSoA4DLDMLN8mrHyj2wNguCTHFK
	BSrtlc48oG1nTL/u+LJNeHoe+9DGx9UmcyX4IIydlniA6P2AdBjMnRkqkWxjdlAS
	MbhsEwwpHAgfm7ZyNP/uCLY6fZKScDdk9Hkmw01kbX59RqPTVe58UkiAEmc4S1Br
	8mNVMePQONGzhGGiLkumbX661JRiB8I0iXdBYcAq+tDE5MkTn665/ph9XoIiS5vG
	vovKD90kqNozzmYUmYAPJ3+7+FXSXjykYGbzyew==;
X-DKIM2-Info: draft=ietf-dkim-dkim2-spec-09;
	repo=github.com/dkim2wg/interop; date=2026-11-03; sw=lmtpprox;
	action=mi-m=1; hc=9;
	hn=cc,content-transfer-encoding,date,feedback-id,from,
	message-id,mime-version,subject,to;
Message-Instance: m=1; h=sha256:zSQ08SB0YDiGX+LZf9asuJBcoLufiYYjhjSs/fNXaN0=:9+VyJJq/wPHhkaOd0j3w+YWPD8nuaKGB3v3MNW6dbq4=;
X-ME-Sender: <xms:bsr9ajpmNW9-FCEXjXuGiuWmU17fMfADZIxcUFEGZslffmqdxRmtMw>
    <xme:bsr9apqgxL3DDvKPakZvlPOv3hvvAMXHXL_n-l6oJBRKJrH-KwoR8S0tnCob74vcF
    6qvVAwZriWhiYTbvqVjZ-ocdVUzz0AIIRpOc9wxhhBXNmxWw_kGSwfq>
X-ME-Received: <xmr:bsr9aiYOvpENJ9mK8_e0Pzd-4SsPvwiVnvN_4UHNJTKRkptXP0F1BVI0bknREedW>
X-ME-Proxy-Cause: dmFkZTEaF8Tb080CrFkH3EZ5cmP2Vkp5cmhyZjH2uPuOuXlZoCaqmAbkdsXXjNl6SYEeHR
    5TNFs9G/XnYbKIKONUOulsOoVTyDdZYWvFaG/y8NhrlmE5shB6SRv9F5+yvWxBhHKg3srM
    nJzCQzfORaKkFt0ZC0VVm3IzJiQCA8flLztgqzgwL/DJORKIR83TSlb/aKyivXhwTzhdvh
    dSYhCXgRTYABM11xVUPM/PL+3HamI6oKxoyLdsMue6MCS0mPyexkm9bWYseCqnS7yWtnoV
    +TgqwSHuNSbgPERCOphR3DYcAu0RR+X2ySdk/dNlq5M3Hid2zfHtaerY1TZOnxIty4BkXJ
    caThcY2YPwOg8eBCtxSjYY5p+3Y5WLIY0TRaInP2Vu7qtSrGBk5hOV/2ZJylNP5u9AV7Fs
    XOZJWm0aataEFhYnOfflzW9C0OfT01UO9W09xsrqs0yBmflxODkVQIfVXnWLVtgezIWGP/
    DV+wm5YpepTMHkJfRNFxC5hZKPozJxKf6nsuEFOxTK96FgiS6ukYwFfV/GDV04QoFAVRmA
    pOTW/uw/fltTPL3Um4YyigafrKipDsOUy+ZJ+1OxuNU25PooHFKBUbayeQMowmayiVDWPe
    uaBZpsnyI9eYZjYWo0FVtD3y9zRiRYboFwFL8iKxOENnZcTyTGLor0GgKl/A
X-ME-Proxy: <xmx:bsr9an8KXgAXLSVshB-HsL4yEaQtFVHbHRxhSs3fEcUtVNpUwyrxug>
    <xmx:bsr9aglnqvumfjJObC2s7IngLSjBYacVOExnwjWWgB47CJoQ8lKExA>
    <xmx:bsr9akyq-BcCnFKsy3TOjZM7m1sPuEOCmXO0WRjtsS5n-fH_byhe2g>
    <xmx:bsr9ai76cAU_zWZTrV3JnNF6wMJTvDzzfkuAByyrlAfk264fFdCjkQ>
    <xmx:b8r9amTapJZUt_WhH1Smzdz6VVP9Me-LYYWCMYEX6OClcH4Rtir6CfFr>
Feedback-ID: ib53e4b78:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Wed,
 18 Nov 2026 10:55:25 -0500 (EST)
From: Ian Bridges <icb@fastmail.org>
To: linkinjeon@kernel.org
Cc: senozhatsky@chromium.org,
	tom@talpey.com,
	chenxiaosong@chenxiaosong.com,
	linux-cifs@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	Ian Bridges <icb@fastmail.org>,
	stable@vger.kernel.org
Subject: [PATCH] ksmbd: fail SET_INFO when the security descriptor cannot be stored
Date: Wed, 18 Nov 2026 09:55:21 -0600
Message-ID: <20261118155521.70611-1-icb@fastmail.org>
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

set_info_sec() removes the stored security descriptor and then stores
the new one with ksmbd_vfs_set_sd_xattr(), but it ignores the result of
the store. When the store fails, SET_INFO still reports success. The
old descriptor is gone and the new one is missing, so access falls back
to the POSIX permissions. Deny ACEs the client just set do not apply.

A client can make the store fail at will. It only has to send a
descriptor larger than the xattr space the filesystem has for the file.
On the ext4 filesystem with 4 KiB blocks used in testing, a DACL of 86
ACEs was already too large, and the store failed with -ENOSPC.

Return the store's error from SET_INFO, so the client gets
STATUS_DISK_FULL in that case. Keep returning success when the
filesystem does not support the xattr. Keep it for a CREATE with a
security descriptor context too, because the file already exists at
that point.

Fixes: e2f34481b24d ("cifsd: add server-side procedures for SMB3")
Cc: stable@vger.kernel.org
Signed-off-by: Ian Bridges <icb@fastmail.org>
---

This is a narrow fix. It only stops SET_INFO from reporting success
when the store fails. It does not make the request atomic. By the time
the store fails, the owner, group, mode and POSIX ACLs are already
changed and the old descriptor is gone. Restoring them would mean
saving the old state and writing it back on every failure path, and
those writes can fail as well. That is a much larger change than this
fix, so it is left for later.

Tested on ksmbd-for-next 267029b35ad1 with KASAN. A SET_INFO whose
DACL does not fit in the xattr space now fails with STATUS_DISK_FULL.
A store that fails for lack of memory also fails the SET_INFO. A small
SET_INFO stores the same descriptor as before. On a filesystem without
xattr support, SET_INFO and a CREATE with a security descriptor context
still succeed. A CREATE whose descriptor context cannot be stored still
succeeds and creates the file. smbtorture results match the base.

This patch was developed with LLM assistance.

 fs/smb/server/smbacl.c | 9 ++++++++-
 1 file changed, 8 insertions(+), 1 deletion(-)

diff --git a/fs/smb/server/smbacl.c b/fs/smb/server/smbacl.c
index a87c22fa9a6e..3770dda2b3ed 100644
--- a/fs/smb/server/smbacl.c
+++ b/fs/smb/server/smbacl.c
@@ -1984,7 +1984,14 @@ int set_info_sec(struct ksmbd_conn *conn, struct ksmbd_tree_connect *tcon,
 	if (test_share_config_flag(tcon->share_conf, KSMBD_SHARE_FLAG_ACL_XATTR)) {
 		/* Update WinACL in xattr */
 		ksmbd_vfs_remove_sd_xattrs(idmap, path);
-		ksmbd_vfs_set_sd_xattr(conn, idmap, path, pntsd, ntsd_len);
+		rc = ksmbd_vfs_set_sd_xattr(conn, idmap, path, pntsd, ntsd_len);
+		/*
+		 * The CREATE context (type_check) stays best effort because
+		 * the file exists already. A filesystem without the xattr is
+		 * not an error either.
+		 */
+		if (type_check || rc == -EOPNOTSUPP)
+			rc = 0;
 	}
 
 out:
-- 
2.47.3

