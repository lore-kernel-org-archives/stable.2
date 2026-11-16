Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=209.85.128.45
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1794824627;
	b=b1dn3LXYn3/LQ6Ke4idPD8+D/gU62E0z2hN58dotSAJZec/H5MClarNhKbN5yqViMcNZ
	 nzmLcmgMkQsPwq93TT26KUzyQgqdd7L9dQo/FA3imUossjSC1m1MVAOWArqHqNcbFDj3k
	 08bf3BP0m7DG6YMSdtPDJoL/Fu7Na8o4Xqoa6GcIrfMzp7BAepMcu9aVMubjVpNsL4Hny
	 lMyb+OKtCtzjrNAiSSYitsRuxF6dDHaEg4GvFgS1AUKLXhDtaecr0PiWJUSyjeiylmFUj
	 kRJju4JXq/C29cdcs/X1zCUsuwgmXjhsJA7tAOlSdDLyiV0G21mxdbknQTktPLL6g3w==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1794824627;
	h=DMARC-Filter:Received:DKIM-Signature:X-Google-DKIM-Signature:
	 X-Gm-Message-State:X-Gm-Gg:X-Received:Received:From:To:Cc:Subject:
	 Date:Message-ID:X-Mailer:MIME-Version:Content-Transfer-Encoding;
	bh=9q/zYfokBxKaBTPYcerPDmA3MfY1ZL37DCfWtL2KbVM=;
	b=hNw+qJ2dXIxgYN+hRAHN0qmb1qfolGDIJU+4/6HZ2HzIU+qVkCF+PFMsZa97SDeQ3PHk
	 XoWishDTPEl4EbiwDW00M+8kooSlVg8HS4/JtxVboRNf9rZ9Z9Q+YDL3SoFqiz7c4N7XB
	 khOzH5Pldh9NhplHyrLuZW/fr9nMK76+0tz8V5MSixar3FxXsLYJelgwaATaluKdL8kvS
	 3bx1k7rOjlGJalzHvZOOtP33mFFS9k7nbNgSVLhGAGT2dTdItQrKI+prikZRLb4/IS18L
	 qflGnobHLm7W3naHaI+cKMsUJs4lmvnXcTykkAIblFfVM5Hy3WQWIQaT3IdHc/PcEUQ==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=gmail.com;
	spf=pass smtp.mailfrom=gmail.com;
	dkim=pass header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20260707 header.b=nlwp1ta5;
	arc=none smtp.remote-ip=209.85.128.45
Received: from mail-wm1-f45.google.com (mail-wm1-f45.google.com [209.85.128.45])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9CFE8606A891
	for <stable@vger.kernel.org>; Mon, 16 Nov 2026 10:23:44 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 9CFE8606A891
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20260707 header.b=nlwp1ta5
Received: by mail-wm1-f45.google.com with SMTP id 5b1f17b1804b1-4a210470b49so26204475e9.2
        for <stable@vger.kernel.org>; Mon, 16 Nov 2026 02:23:44 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20260707; t=1794824623; x=1795429423; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to:content-type;
        bh=9q/zYfokBxKaBTPYcerPDmA3MfY1ZL37DCfWtL2KbVM=;
        b=nlwp1ta5SDEnakttiqWxdmNJS38raYe5iE7G79agIpBYLhpLANEdpEp8DcRTIZeMpN
         bogWAayszJMdKU+SePBWmx4W7Tnq4dL2QSzWiWxe8dpAmxr30RWcECUKJLlRxt8sAJa/
         UxLI4DvIYigUXepwY+2uiEgOm5qNI+oCd9imaotrC8l3HIShcGnk7nvECW7V+8ITcWC2
         SqKu4siD3nUV85hlP3i6bvYohTFXXq7NT9gWUsDGVgrgO0+d8gsDj/camLCiUAhpAf+J
         zWFG9ycTDvA9iLwAgrU3LldqLMCRf00pO4bMzSjTthvzT1bNxIEXda3oWAJHaRYo0tv6
         1MUA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1794824623; x=1795429423;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=9q/zYfokBxKaBTPYcerPDmA3MfY1ZL37DCfWtL2KbVM=;
        b=EKIZ7jltaXsp9uHls8HlBtqHbJA8oa04Ur7YiEU2S+oNx8goV+rffmUlEXZz+yXBJw
         QjhEY+DOZsPo3IFm8J+I1VCZG8cG6gyHxWnU+Vxx/s5n3jLABCDpVP+tT09p3lX0MobZ
         mthVcr4se+6Fz8IC36Vf3mHcSkmIoV5FScdjUbIw1GZutL+d4nfUDuC93omxozJaXhHS
         IcsSURwqR/8Ao0u7yDz+u0C3pbgOw8v/w9iqMsrrFU8hxJLvv0/lWjayR9TYmSlo4AoF
         1EW2GmXbyvDSBraA6kttMJ6odt/uhfTPybHfYkqSHXFmVmvawnSBoh2xpGu7k6dXDPJu
         AeXg==
X-Gm-Message-State: APuU4Z8QjQK44qmLXIf2mi4GP58BECPzb19QC3hfdLZQixx00NAn9fN8
	jA5uV+N6X62eJU07Ij+Ven8t1St1+r4Y4sQrV4dmzCubPIHXWX14Jx40PSUMno1w
X-Gm-Gg: AYBFou3OqW7IyJUWLCnVpK+25lC+tNb4odGDRvzvQb9VZQfCUp7pXpjaQ9UMMN7OAnq
	1NDA6JO3dhShJvGvPGvioJn4TCedni2PHXlRzwivM8tCixsyz1VkSh6rEZ0zTiaZBjw9PyV2484
	FcxKuXgXA3v6fVhGNbxrWX92UpIgW7e63o3L9GXf1Qralcu/bkbcJ35IsHVao7HnSap1mSFxjiw
	Bznth6dmOBLdr9pSCepiBbLYdJstb2AdNlZYjQ7w5sOWLbPdnxCiaB3X6zss0BXlnrAlEKRtAho
	15RCJuKPYWzCfqQ8vTNz4a9iCXYpON7HgC0QW4O1oHxxF/8aHFE2W2jHSecH+GR7xQH3fNCCT+Z
	yW/h0HJkMxGVX0SKhwaUQujQaa8oAE4Stiux6i7alAGUd3umNy695B0SZ5V6IzbasL6cUjheXpm
	tUZxPnvh17aB0wizlDGRHJ/TaNEI5Vitw3skb5+EgIlKf9ebOHGpwM/gYcubkJDYZcVDFk4guMS
	xlz3sIOgwJO207YNV6XtR9yv1ovaSCWozcT5Cq60d7ye4N0oO2xnIoo18gBniSt7DQFYTGzfD+I
	xzx35q4oSjOrocRphuY6
X-Received: by 2002:a05:600c:5395:b0:4ab:e27d:e241 with SMTP id 5b1f17b1804b1-4bb55a95d09mr204699015e9.15.1794824622940;
        Mon, 16 Nov 2026 02:23:42 -0800 (PST)
Received: from fedora ([5.131.7.59])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-4bb571f6a40sm108149375e9.2.2026.11.16.02.23.40
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 16 Nov 2026 02:23:42 -0800 (PST)
From: Petr Vaganov <petrvaganoff@gmail.com>
To: stable@vger.kernel.org,
	Greg Kroah-Hartman <gregkh@linuxfoundation.org>
Cc: Petr Vaganov <petrvaganoff@gmail.com>,
	Alexander Viro <viro@zeniv.linux.org.uk>,
	Christian Brauner <brauner@kernel.org>,
	Jan Kara <jack@suse.cz>,
	Su Hui <suhui@nfschina.com>,
	linux-fsdevel@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	lvc-project@linuxtesting.org
Subject: [PATCH 5.15] fs/stat.c: avoid harmless garbage value problem in vfs_statx()
Date: Mon, 16 Nov 2026 17:23:23 +0700
Message-ID: <20261116102324.81107-1-petrvaganoff@gmail.com>
X-Mailer: git-send-email 2.55.0
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

From: Su Hui <suhui@nfschina.com>

commit 0fac3ed473dd2955053be6671cdd747807f5e488 upstream.

Clang static checker(scan-build) warning:
fs/stat.c:287:21: warning: The left expression of the compound assignment is
an uninitialized value. The computed value will also be garbage.
  287 |                 stat->result_mask |= STATX_MNT_ID_UNIQUE;
      |                 ~~~~~~~~~~~~~~~~~ ^
fs/stat.c:290:21: warning: The left expression of the compound assignment is
an uninitialized value. The computed value will also be garbage.
  290 |                 stat->result_mask |= STATX_MNT_ID;

When vfs_getattr() failed because of security_inode_getattr(), 'stat' is
uninitialized. In this case, there is a harmless garbage problem in
vfs_statx_path(). It's better to return error directly when
vfs_getattr() failed, avoiding garbage value and more clearly.

Signed-off-by: Su Hui <suhui@nfschina.com>
Link: https://lore.kernel.org/r/20250119025946.1168957-1-suhui@nfschina.com
Signed-off-by: Christian Brauner <brauner@kernel.org>
[ Petr: There is no vfs_statx_path() in this tree. The fix is applied
  directly in vfs_statx() by jumping to path_put() via a new out_path
  label, preserving the reference drop and the ESTALE retry. ]
Fixes: fa2fcf4f1df1 ("statx: add mount ID")
Signed-off-by: Petr Vaganov <petrvaganoff@gmail.com>
---
 fs/stat.c | 3 +++
 1 file changed, 3 insertions(+)

diff --git a/fs/stat.c b/fs/stat.c
index 246d138ec066..43c4a60b773f 100644
--- a/fs/stat.c
+++ b/fs/stat.c
@@ -223,11 +223,14 @@ static int vfs_statx(int dfd, const char __user *filename, int flags,
 		goto out;
 
 	error = vfs_getattr(&path, stat, request_mask, flags);
+	if (error)
+		goto out_path;
 	stat->mnt_id = real_mount(path.mnt)->mnt_id;
 	stat->result_mask |= STATX_MNT_ID;
 	if (path.mnt->mnt_root == path.dentry)
 		stat->attributes |= STATX_ATTR_MOUNT_ROOT;
 	stat->attributes_mask |= STATX_ATTR_MOUNT_ROOT;
+out_path:
 	path_put(&path);
 	if (retry_estale(error, lookup_flags)) {
 		lookup_flags |= LOOKUP_REVAL;
-- 
2.55.0

