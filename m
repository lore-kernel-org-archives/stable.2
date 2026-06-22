Received: from mail-oa1-f41.google.com (mail-oa1-f41.google.com [209.85.160.41])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E372624293C
	for <stable@vger.kernel.org>; Mon, 22 Jun 2026 01:12:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.160.41
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1782090775; cv=none; b=mYkDBuAAXiiKfkLQgOS9AIvNczKZ/TT3CBOgZqGHWXfbrDUZu4k/CRaBezVIgWbdqMkpdWQ0BFB8XDvh3H7vJQWFIEC8XIJYu8B34XFj2mVs3BXujNKOVUpe6Fckved//TMJJPmQ1QZfJbonS9RHg+CDpt4QCNXfDxcd2+sYtRc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1782090775; c=relaxed/simple;
	bh=j94HQK6oZ0r8NQs9hVhnpkh1dynCNV5NjnR+rHJVplU=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=WflAHuUhLYz5xrbV28m38G9uE2ozmCg9AvawCisOueGRyyyS72k3esUmzxVWMEfEX2efW9ji0hW2AO81AygLSdkcVvBY2cWUXAQD9WCXv5ITRKtiGdC8IujVhEn7VylGnV5hGJZj8iyseXX+IIkClPl0GQqqVUuyr3EhqGzm4fU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=l+wPjFOD; arc=none smtp.client-ip=209.85.160.41
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="l+wPjFOD"
Received: by mail-oa1-f41.google.com with SMTP id 586e51a60fabf-447134764f7so1860956fac.2
        for <stable@vger.kernel.org>; Sun, 21 Jun 2026 18:12:53 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1782090773; x=1782695573; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=v3a9PPciCr47HimGYz06wh3ROlaOsQ1tPkQ9F4Y9Wec=;
        b=l+wPjFODwGgs5jlwHXUNR3MWbjzGgF6okEFyWO1Q2k+ByBwVEJla4p+H6wxWjBQ3zz
         DAK0tP+3pmnGEuw8zlaN+/GO/0lb59qw9bv4Wf0LZ7hVc2GO0d8d1qG0i2dHqaa/Jzcc
         UdsG0FbGkelsmEdXN6wyBnJs23rCGpuh7xL2U5X2aE77NaFtbl8NEi16M+OEhsoBjf21
         T9VSjVSxx0xMzOWIEMttKamhErF7sSfbdbkstm/bSsnquX2oU2Vwg6J0hioTOuftVVes
         7/1CThrzVSvJDtJDTi8qh/wbPDs3tWosd2Qsvfe0Wcngbc9go3E0W5mzQLZkf40FYyRb
         L+yQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1782090773; x=1782695573;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=v3a9PPciCr47HimGYz06wh3ROlaOsQ1tPkQ9F4Y9Wec=;
        b=Mz2ojN9awbM8ZFUzMMZeeZtEdlkApFGkpmCm/0LJVhJaE6X3LC5w9/elb3j+8vSyV+
         g4QWsqC1B9kN4Ddu/YmhMEH9Xc/ujzXMLV9Wkas+Sehc4zGNFhFuUV54VnsZ0YPD2153
         gtNlH0NJjXMfEFk+rOgBRAWhuROLTYWmORnOCmTf7rOYloaapGZV6w3EzzkGRXIlfKTo
         mRna1roIAjEREEaTdGBby+97kLy4RDGTaPesbA+pxW/odKxL6b2pZOwYMzEUm5E5rMeo
         QOcgXRCFKo5V4LinMBoql5xk/IWIurEUv712NZDQm5Lc6IhjszCo521EnUOOdgZzRRv1
         Alyw==
X-Forwarded-Encrypted: i=1; AFNElJ+9DqrWe6WDZUJ/0nbDmlR8WmcezN256mkPMIj5QXDZNZj6uCXpP4odS+0WWsydfcBmStGmOo0=@vger.kernel.org
X-Gm-Message-State: AOJu0YxTDlOxBaOfF49/DykP+8rOnUKkdaq/T1xSzwQfi/xek0rx8YOO
	xmrXlFoX2IVhXpkbpCiMXVa87lGW98kQl7ggrrs213LNY2lNEtdKIJxT5u7xqHqg
X-Gm-Gg: AfdE7clc0vjIWqoybZu7a36Za/Y3273raqyRXNn8GL+ZdKjPnmD8JWeW7+rkhymC23H
	g5pPUa3leMRfnI+quSGbwWmBpYEbkGY32J1vTAbLd8X188akijRXRUpyu7N3JO8cLlkCg1AAMD1
	+iT+LobAV0xkfqh7HuuLeobSW2beIkQoJnxUqcQlMn6ZLz8mVv1guxcQipPqXIOe3xAN7pwg8e0
	GEdwuiReBwbLFwgOm2T+xk67RsyQUTkpAlFwLT0OKw01ugz9ggLpRlUBAyTTXSK7Led2nwM/0s4
	Ar7TpN6W3Ux7yJhLjLtlnT60lu6JOoktZUrVrhPjVaL6OpA7xXbI6dRBpdIpKYockqeOEFYpBhv
	JcUODS3kshB3IPn958KbeLNTGa0I1Kr7BC3Vum/PcMlg9kL6PTRrX/HrVEF1OCykVXLLZ8ybEuH
	NcHizFm+bL6b+jTZIwx+BNyJphi/DavsjPzYkdV1HP3mCbxOYuvc6TJtX5JRt1oA9aHgiImAOhy
	h0v/PJPNFNeE5SVXxBSOptXCFkKWzIs5p2XjbThbn5PYBNZsZBK8p4JVQYMPTLEnCF2m+cyW1da
	tmgaS8Un/RMCtTe9xXsoGc/0+oN2jfzdB1B/hA==
X-Received: by 2002:a05:6820:905:b0:69e:b788:36e0 with SMTP id 006d021491bc7-6a0d8cd341cmr9696671eaf.34.1782090772772;
        Sun, 21 Jun 2026 18:12:52 -0700 (PDT)
Received: from smfrench-ThinkPad-P16s-Gen-2 ([2603:8080:2200:13fc:fe9d:7f65:95c3:3c73])
        by smtp.gmail.com with ESMTPSA id 586e51a60fabf-4472ec52815sm5206853fac.1.2026.06.21.18.12.51
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 21 Jun 2026 18:12:52 -0700 (PDT)
From: Steve French <smfrench@gmail.com>
X-Google-Original-From: Steve French <stfrench@microsoft.com>
To: linux-cifs@vger.kernel.org
Cc: Ralph Boehme <slow@samba.org>,
	stable@vger.kernel.org,
	Steve French <stfrench@microsoft.com>
Subject: [PATCH 3/3] smb/client: fix chown/chgrp with SMB3 POSIX Extensions
Date: Sun, 21 Jun 2026 20:08:17 -0500
Message-ID: <20260622010838.107524-3-stfrench@microsoft.com>
X-Mailer: git-send-email 2.53.0
In-Reply-To: <20260622010838.107524-1-stfrench@microsoft.com>
References: <smfrench@gmail.com>
 <20260622010838.107524-1-stfrench@microsoft.com>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

From: Ralph Boehme <slow@samba.org>

Ownership (chown) and group (chgrp) modifications were being ignored when
mounting with SMB3 POSIX Extensions unless CIFS_MOUNT_CIFS_ACL or
CIFS_MOUNT_MODE_FROM_SID were also explicitly set.

Fix this by checking for posix_extensions in cifs_setattr_nounix() when
updating UID and GID, ensuring that id_mode_to_cifs_acl() is called to map
and set the ownership/group information on the server.

Cc: stable@vger.kernel.org
Signed-off-by: Ralph Boehme <slow@samba.org>
Signed-off-by: Steve French <stfrench@microsoft.com>
---
 fs/smb/client/inode.c | 3 ++-
 1 file changed, 2 insertions(+), 1 deletion(-)

diff --git a/fs/smb/client/inode.c b/fs/smb/client/inode.c
index 51fb7c418d52..56b0f109e41b 100644
--- a/fs/smb/client/inode.c
+++ b/fs/smb/client/inode.c
@@ -3376,7 +3376,8 @@ cifs_setattr_nounix(struct dentry *direntry, struct iattr *attrs)
 	if (attrs->ia_valid & ATTR_GID)
 		gid = attrs->ia_gid;
 
-	if (sbflags & (CIFS_MOUNT_CIFS_ACL | CIFS_MOUNT_MODE_FROM_SID)) {
+	if ((sbflags & (CIFS_MOUNT_CIFS_ACL | CIFS_MOUNT_MODE_FROM_SID)) ||
+	    cifs_sb_master_tcon(cifs_sb)->posix_extensions) {
 		if (uid_valid(uid) || gid_valid(gid)) {
 			mode = NO_CHANGE_64;
 			rc = id_mode_to_cifs_acl(inode, full_path, &mode,
-- 
2.53.0

