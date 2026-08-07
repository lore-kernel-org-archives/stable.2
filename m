Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6A9E934E741
	for <stable@vger.kernel.org>; Fri,  7 Aug 2026 02:42:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.133.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1786070527; cv=none; b=hMGoS+t7heC2Y7HL2LgTamaI9+jqADASKNKsI0Cl2rQWtkOjfzgfnnXrtP7YGXhj8d8XHfqqoLzhqySOcS5FWsvwAQMfREmdkaOvBpuqtvMDZFZ9TuF2ZacXbs7Sw8kv+hsL0hsHvGYc7b6a+9lNekEZY1WYbIIGhCqu+1zgl+4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1786070527; c=relaxed/simple;
	bh=ihYmXYag+Qm06J02IphUYEH6cOHEmnNInaqD255GJ2E=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=Pfr94oCzcBRGoX2UaDoOgTaVriGwPQabfm862rARfJIkzDURWt+KGNlKon2UyBNhRF0+BF4ZZUhtsns4wiTCA2IYuF4WFjVd6KojdNmRaWtkE8zF/T3+N8mDmyjaxz18pTqvEz9EHz8PoK0OnOr3wDSsjPVH0+wQCjAn2ziplVg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=U8mN/8X9; dkim=pass (2048-bit key) header.d=redhat.com header.i=@redhat.com header.b=L3TnJEOr; arc=none smtp.client-ip=170.10.133.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="U8mN/8X9";
	dkim=pass (2048-bit key) header.d=redhat.com header.i=@redhat.com header.b="L3TnJEOr"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1786070525;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=jUGoHbVISmT8U/yGzpSVUfjvQqCD4a7LjQIBARuhqwU=;
	b=U8mN/8X948rs3p9as4+vlxnzZA7Ig3+SNVT4NOiuhKNcyOL/3AblECGjvqsOeLdCF8HhT2
	07suHMjjWr14W4R3CHdcHoyvo6EQfBT/mQVfvHdz1LR57BC0tF4/AecSiihYxetYdV+ewU
	Oy0jtEDJI4e2cAPTCPnnmRslZ+/kycY=
Received: from mail-oi1-f198.google.com (mail-oi1-f198.google.com
 [209.85.167.198]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-538-u2lCWPwPMlqLklhnJUXRew-1; Thu, 06 Aug 2026 22:42:03 -0400
X-MC-Unique: u2lCWPwPMlqLklhnJUXRew-1
X-Mimecast-MFC-AGG-ID: u2lCWPwPMlqLklhnJUXRew_1786070523
Received: by mail-oi1-f198.google.com with SMTP id 5614622812f47-495b8120909so3347219b6e.1
        for <stable@vger.kernel.org>; Thu, 06 Aug 2026 19:42:03 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=redhat.com; s=google; t=1786070523; x=1786675323; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=jUGoHbVISmT8U/yGzpSVUfjvQqCD4a7LjQIBARuhqwU=;
        b=L3TnJEOrPXssV2tV41LPFsS5lI4Xl5ZHYNXxUv24as20EANuKLrV6bV0qIlbtvpXxP
         L/ay7jQn5lj6I4fHCSEMWL2nn0VZWwltixo3vrNj3YLBdF6FmgyLYhe2CzdbPsvUjwpM
         6dfCcwhencABwHDAi5Bw/iIE1QAL+k9u4bBCDjTQ/HdUM8WChnjrFDPbcfdp5FMU8AGY
         0xMpyOgYUnfwb4WQR7MVVdXqRQAHsLQbl0Eg1Wus72PKhGJJ5K66Rf0muPXcEyfCDVJj
         Vs/TSA1svLQVRcZyBgQQc7EcZxL4hluD/AU7BlmAHRnltsoHWzkPlbIcrbPsGc37UEBT
         mkiQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1786070523; x=1786675323;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to:content-type;
        bh=jUGoHbVISmT8U/yGzpSVUfjvQqCD4a7LjQIBARuhqwU=;
        b=pZhwVcobAUo9AqKwza8gBN3J5Hi2LXa2c8pMh4gWLw//f2ORvYtVaCrDLz1u2fhoi9
         8wRLa9LsEn6yxGHLneR+jalKdyiHG7mnF5tKO5MsZwJYEOyDGoJTZm1y3ePTQ/5Qibmg
         STRZXlX2hjMLlAbYBxFe6qsdmjhl0S8+2kD4svHfKJfQ5GFBA1i0GjSv+6/mhQ8affZs
         JPeT4H+8supGSnKjQHZvcn24+8nzgF22TAcZEHw1WVtYd5FPTu2QzCjKtXcpmvhUnhjm
         ClUbZ9d0PV2YkbG6CDwchoJOS2YjdEYX5XgzGGNvJFzLvHN+/O31eYAApUoShCZQT1TF
         eUnw==
X-Gm-Message-State: AOJu0YxcnICMkCstcg3lhx5HlNuuoXjECP5mKBu4dRssq0LFba25rcpe
	EUo7p6G71cPiKi5ueAXyB+kc1UAa/bv/yG7HjtUti6/zs7D3lCF1ZsurNwyrD5pLK1Rbre4ZGqn
	DNObXkTjHVqKcIlvn6aWW6HSfXQZFtooUS2m6/ptZCZPCcxDnrSytb4IBeg==
X-Gm-Gg: AR+sD11BFY6HY/fhAlYPSKb/5RdVMaYYQv0ms6rrGilTPbMZjpPLGrXwLSCE7PcDnVa
	ql8QFtuv3U7xuTNc4MTbCDXpaaX9ry3twFZGudyNmZyASBrRn2EX1/5/y05+D0QHjk+y6lsfEHB
	LDHIrqK5EogsvYsfJQX1XXv79oGvXWXrgSUMk3ZVWZlMgRGxepS6RtERUQ8sCLWOpVdERxseGli
	TNGh2WbHsCfGf+dKIVyf2YfJJ+PsaPs4SzjuDvU1MQcur67LHUOEdb+Trmx+28KJYhIAcBrEQUF
	Sb8L0RRcA+HsyEvHg4ntK6PeV2vipwEyndp+E6zqr+uzVGdStSBrXJJSLpvbTf5E5u7Tr857uhD
	+X1xE5UiygNh7MPdsbiSrbJKDejyQlzWp15+7XhVozgKpxSTT9NbA5O0tIaWdVJEikQ==
X-Received: by 2002:a05:6808:1646:b0:496:559d:5474 with SMTP id 5614622812f47-4afadfb0140mr9833097b6e.8.1786070523038;
        Thu, 06 Aug 2026 19:42:03 -0700 (PDT)
X-Received: by 2002:a05:6808:1646:b0:496:559d:5474 with SMTP id 5614622812f47-4afadfb0140mr9833068b6e.8.1786070522531;
        Thu, 06 Aug 2026 19:42:02 -0700 (PDT)
Received: from bearskin.sorenson.redhat.com.com (c-98-227-24-213.hsd1.il.comcast.net. [98.227.24.213])
        by smtp.gmail.com with ESMTPSA id 46e09a7af769-7f35b563887sm356182a34.3.2026.08.06.19.42.01
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 06 Aug 2026 19:42:01 -0700 (PDT)
From: Frank Sorenson <sorenson@redhat.com>
To: linux-cifs@vger.kernel.org,
	stfrench@microsoft.com,
	pc@manguebit.org
Cc: stable@vger.kernel.org,
	Paulo Alcantara <pc@manguebit.com>
Subject: [PATCH v2 1/3] cifs: clear tcon after cifsFileInfo_put() in cifs_file_set_size()
Date: Thu,  6 Aug 2026 21:41:56 -0500
Message-ID: <20260807024158.3707995-2-sorenson@redhat.com>
X-Mailer: git-send-email 2.55.0
In-Reply-To: <20260807024158.3707995-1-sorenson@redhat.com>
References: <20260807024158.3707995-1-sorenson@redhat.com>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

When the else branch of cifs_file_set_size() finds a writable file handle
via find_writable_file(), it borrows tcon and server from the handle's
tlink, attempts the handle-based set_file_size() RPC, and then releases
the handle with cifsFileInfo_put().

If set_file_size() fails, execution falls through to the path-based
fallback, which reuses the borrowed tcon and server under the
"if (tcon == NULL)" guard.  Since tcon is not NULL at that point, the
guard is skipped.  If cifsFileInfo_put() dropped the last reference on a
tlink that was already removed from the tlink tree (TCON_LINK_IN_TREE
cleared, as happens during reconnection or session teardown),
cifs_put_tlink() will have freed tcon; the subsequent set_path_size()
call is then a use-after-free.

Setting tcon = NULL after cifsFileInfo_put() causes the existing guard
to take the cifs_sb_tlink() path, which acquires a fresh reference for
the path-based operation or fails cleanly if the session is gone.

Fixes: 110fee6b9bb5 ("smb: client: fix missing timestamp updates with O_TRUNC")
Cc: stable@vger.kernel.org
Cc: Paulo Alcantara <pc@manguebit.com>
Signed-off-by: Frank Sorenson <sorenson@redhat.com>
---
 fs/smb/client/inode.c | 1 +
 1 file changed, 1 insertion(+)

diff --git a/fs/smb/client/inode.c b/fs/smb/client/inode.c
index 0afff761aab9..5a4916259a04 100644
--- a/fs/smb/client/inode.c
+++ b/fs/smb/client/inode.c
@@ -3100,6 +3100,7 @@ int cifs_file_set_size(const unsigned int xid, struct dentry *dentry,
 							size, false);
 			cifs_dbg(FYI, "%s: set_file_size: rc = %d\n", __func__, rc);
 			cifsFileInfo_put(open_file);
+			tcon = NULL;
 		}
 	}
 
-- 
2.55.0

