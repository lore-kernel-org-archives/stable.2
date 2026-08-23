Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 086813A3834
	for <stable@vger.kernel.org>; Sun, 23 Aug 2026 18:58:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.129.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1787511531; cv=none; b=EddWjZnNqZSynRadWikjKdDCYwg5QV7jOdBlikqkaQmVHocVhCxfFf2x0WJ43LOxJ4ZRGq/wsuh0WO/VjRJdF1n2Jz0PrjIH9NzSXJqjBVDAyJ/UhpuMeI+OXgYNZDBLRPoj4i4F7o+wEFSeBuNf7KmWoSHLK/Nj8YFE0K8H/I8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1787511531; c=relaxed/simple;
	bh=9c9AsfWadPeBpODKRouw11+EtIsyWqscZ8UgTDEVl3U=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=U0u3pazW18vS0cHyH4LVUkEU0tbEg0uccuiugeNmBsgLtzirjB6zyGdC3Aagm22zMWOYU0hGeTDwhBmua7jiu2GpXYUUvxn31rlHtUYDrOoTQgp/K+0e2dVu8zZvO4Zuc6oyHkSR7CwPa28uA7xo4x6zinIW+hSKadDr1d6NSds=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=X/bVc7t3; dkim=pass (2048-bit key) header.d=redhat.com header.i=@redhat.com header.b=uNpLppXy; arc=none smtp.client-ip=170.10.129.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="X/bVc7t3";
	dkim=pass (2048-bit key) header.d=redhat.com header.i=@redhat.com header.b="uNpLppXy"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1787511529;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=zvrMF4Yjtz78iJTbYFy+PaftufYsw+A3Sx0I/KyH0+s=;
	b=X/bVc7t3MLhE2T3YaYKSb0GQS6S2Uy13qeGSQKlUh8ka0zIK8GYyD+KRUS8Dcywh0Lb20b
	8vcO8WofeKNE1sVs+J4fGUXXiz/BBSmP7LhyLihDyb405+8ytHUzNzzWlTd/fmW8UpsQVO
	4WmWFVAq6j/cGHRXjEhUXQEKL5cVDVM=
Received: from mail-ot1-f69.google.com (mail-ot1-f69.google.com
 [209.85.210.69]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-373-BeHDirMPP7eueLWhOYueZQ-1; Sun, 23 Aug 2026 14:58:47 -0400
X-MC-Unique: BeHDirMPP7eueLWhOYueZQ-1
X-Mimecast-MFC-AGG-ID: BeHDirMPP7eueLWhOYueZQ_1787511527
Received: by mail-ot1-f69.google.com with SMTP id 46e09a7af769-7e9fc6dc091so2396864a34.2
        for <stable@vger.kernel.org>; Sun, 23 Aug 2026 11:58:47 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=redhat.com; s=google; t=1787511527; x=1788116327; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=zvrMF4Yjtz78iJTbYFy+PaftufYsw+A3Sx0I/KyH0+s=;
        b=uNpLppXyvFEgQAAg0HFuDP39UNoQA4+pfJiOQwIAkUMoYktqAbStqY5SyVv/tCr6nw
         F+sxIYFAzQiNIWruagP1qYqZ98ImPDO+ESyi/x0LbR2SJltuDgycmT0qgp+rx08Zo8BR
         PK43RFKs6jlz9nsJojFDouWZUILiPR3/PkwnaeUYaLKLIwZgz8G2TSTU3NzQj4eBPA1j
         FJeRkjX6o/F40aIm0ppknDQiVNt7oW9n4/quGuZegZ6b3JLrbXipQxeFJhbWZuolRei2
         dUF0rykl10CP8WxSXqozrnqXHM8q3Jmg4NpZzvyAXAC0HQLJ5ha9TEKwBRTuVcKkyqkK
         Qyvg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1787511527; x=1788116327;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to:content-type;
        bh=zvrMF4Yjtz78iJTbYFy+PaftufYsw+A3Sx0I/KyH0+s=;
        b=dGTvmo3OUz1CbJnODOR+43f18sj5B+9lxlMUTpxESnJXU/SCByDHL5tH4OxE975HGO
         0TGhMP+T3jHVbpIRmLTVxxe+FkzePSVQewXn8RyCXyZW0c51o7vYly9hxoSNKn2TDO1a
         zZEgQ/WBmQhHrN1MEBlidOJg29xSWwUQSD+Dr3HFejs/XGkVq0gaEPd88DX8zPeCta4o
         89ARgkxdVP9q0ryxQqzh+PcQaX5UrBomDRbO2TEw8PxG+xC/iIP9PZwMPUqJiHjfjkWg
         iCUFexlPvNj+9+4KZFeWLzMLlFFbDJwi2JfuvU+JNK2EdowGlV1AMDoXmY2Mc8l1HqAb
         9xtA==
X-Forwarded-Encrypted: i=1; AHgh+RqNcAI8A4XtViLr1zvIDhk9HG/Nz3gjEdhAyVeNi1VnlBI4Y5eH0NI5GjOsktkw5MJXL1qVPzg=@vger.kernel.org
X-Gm-Message-State: AFuF++lQ7tiDoqie88y3PH64irrCzoniDe13RdFHnLs+cTegyHhR2uFJ
	JiBE2Am29pFKUNyuHWLGWZGrbgoer6qQu0BGWzW79bpH09ldxszvx4o06Pas7lOg0c/nrpeZUns
	1Zdq9tHiyggMih+6Peyes4iGmZagAxASxr5eJuuuctS+tpQEwkPuZ4a2szpWM8WTCgg==
X-Gm-Gg: AR+sD10lYYIB4CP7rSlni1uR1AAM3D2eBnQlXUMMePJ+bNKcszFq28nzAlhKtM+wql6
	LKasSGCZARffrTte6OFvDjpcER4A8akZvanhMhP6QxyHAm4WE70twUPehA4bBfmbruYHiSC5TI+
	vohMLsHMKgFJIhxPe5fzqL2vqBYAriNf6R8VaQbTeFBoXDhamt8RvPR6EsMiafTUgMyz393nLCQ
	QNV1oenX+PQ9D2bJNWn9LocS7qzU6uoiUj7pODXpbT63E3idCk4pjmuYWotq0iQ+9/8ZJNsH3Ka
	KWUIIFpGRMFrj9pSfXaNusGcPsIiI3qki6LMeHivu7o/g5IPioyOHgdA4dC04mYqBLwGwiXLMlf
	a43EZ5L4I05wedJUTNtY7v1qWU16F8Ya/uEaMkLBkuSKKYRbqUcQq7VvtxxoR96tK4w==
X-Received: by 2002:a05:6820:8590:20b0:6b1:4173:ca4a with SMTP id 006d021491bc7-6b16b2293eemr8828231eaf.11.1787511526639;
        Sun, 23 Aug 2026 11:58:46 -0700 (PDT)
X-Received: by 2002:a05:6820:8590:20b0:6b1:4173:ca4a with SMTP id 006d021491bc7-6b16b2293eemr8828213eaf.11.1787511526231;
        Sun, 23 Aug 2026 11:58:46 -0700 (PDT)
Received: from bearskin.sorenson.redhat.com.com (c-98-227-24-213.hsd1.il.comcast.net. [98.227.24.213])
        by smtp.gmail.com with ESMTPSA id 46e09a7af769-7f48fb1db63sm2518710a34.12.2026.08.23.11.58.44
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 23 Aug 2026 11:58:45 -0700 (PDT)
From: Frank Sorenson <sorenson@redhat.com>
To: linux-cifs@vger.kernel.org
Cc: pc@manguebit.org,
	linkinjeon@kernel.org,
	stable@vger.kernel.org
Subject: [PATCH 08/11] smb: client: fix underflow in is_valid_oplock_break() notify offset check
Date: Sun, 23 Aug 2026 13:58:04 -0500
Message-ID: <20260823185807.3115901-9-sorenson@redhat.com>
X-Mailer: git-send-email 2.55.0
In-Reply-To: <20260823185807.3115901-1-sorenson@redhat.com>
References: <20260823185807.3115901-1-sorenson@redhat.com>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

The check intended to bound data_offset against the received frame:

    if (data_offset > len - sizeof(struct file_notify_information))

underflows when len < sizeof(struct file_notify_information): the
subtraction wraps to a large value, the condition is false, and pnotify
is constructed from an unchecked data_offset.

Check len < sizeof(struct file_notify_information) first.

Fixes: 097f5863b1a0 ("cifs: read overflow in is_valid_oplock_break()")
Cc: stable@vger.kernel.org
Signed-off-by: Frank Sorenson <sorenson@redhat.com>
---
 fs/smb/client/smb1misc.c | 3 ++-
 1 file changed, 2 insertions(+), 1 deletion(-)

diff --git a/fs/smb/client/smb1misc.c b/fs/smb/client/smb1misc.c
index cdfbbff24b72..a39c9140ceca 100644
--- a/fs/smb/client/smb1misc.c
+++ b/fs/smb/client/smb1misc.c
@@ -86,7 +86,8 @@ is_valid_oplock_break(char *buffer, struct TCP_Server_Info *srv)
 		if (get_bcc(buf) > sizeof(struct file_notify_information)) {
 			data_offset = le32_to_cpu(pSMBr->DataOffset);
 
-			if (data_offset >
+			if (len < sizeof(struct file_notify_information) ||
+			    data_offset >
 			    len - sizeof(struct file_notify_information)) {
 				cifs_dbg(FYI, "Invalid data_offset %u\n",
 					 data_offset);
-- 
2.55.0

