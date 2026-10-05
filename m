Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C3225303C8A
	for <stable@vger.kernel.org>; Mon,  5 Oct 2026 18:01:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.133.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1791223277; cv=none; b=OVHdCaDFdthVGAxmSwg2bGZt+MjGOL/rDBxW3nQW7vGqO5KAQuVfY/gyjUwmNVffz72aD8i4W0hPMpivtTqqn52w+/Zj4nR5BwIA4CDtinjxByCksNvsodVgbeLdCB4I0Azq/ZJZ5lGEboe1pAdRARQWgs0E5RYQY73Pm/UDFsw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1791223277; c=relaxed/simple;
	bh=81vfYV5TOagwpFVdscsaZpT186hf2zZp3KNJK+187EI=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=juXu7n3qLrrqRh+3aMn8SqKAsjdfV+29W1pVxoLa6ugtztPGXqk73KDmwA8zG2/k0tmXuGPmywnlf1mGJrWnf4HlIR0jQcU0TTuAqQxXpvqmf7jsowDKLApiOyQjJBe2I9HVm5zTYL/a0K/2ycFTrfHxtHQG1iBU6bcmieakbIA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=EPwcsBzY; dkim=pass (2048-bit key) header.d=redhat.com header.i=@redhat.com header.b=jGLKw+1Z; arc=none smtp.client-ip=170.10.133.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="EPwcsBzY";
	dkim=pass (2048-bit key) header.d=redhat.com header.i=@redhat.com header.b="jGLKw+1Z"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1791223274;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=QJepOKO9SMOEdU9WwD4yz29xGrgQCpaOXUKK8EHvPNg=;
	b=EPwcsBzYeBwOrH0RxZtnGOIWNLSUKmWHajoXf9XxsvVWsxsYIUVUlRzCLj31cNkzCFNgGg
	IHnb+xfuefPxMeewCi9t/pNGkW1Ho3EaBD9/l8kFq6j7a8M28TCqmWR9xtwbbKS6Vqnuda
	jWUQE9iJ2IaRTBVw3UEX6Pl0JSQ/Gus=
Received: from mail-qk1-f197.google.com (mail-qk1-f197.google.com
 [209.85.222.197]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-302-yX_Jx16PN6-QO9UcaGkvTw-1; Mon, 05 Oct 2026 14:01:12 -0400
X-MC-Unique: yX_Jx16PN6-QO9UcaGkvTw-1
X-Mimecast-MFC-AGG-ID: yX_Jx16PN6-QO9UcaGkvTw_1791223272
Received: by mail-qk1-f197.google.com with SMTP id af79cd13be357-93cc7a6e4e1so538693785a.1
        for <stable@vger.kernel.org>; Mon, 05 Oct 2026 11:01:12 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=redhat.com; s=google; t=1791223272; x=1791828072; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=QJepOKO9SMOEdU9WwD4yz29xGrgQCpaOXUKK8EHvPNg=;
        b=jGLKw+1ZYj2VlCuq8cpq6D0ITnvj2LpAqwsnoLyEt6xL8IjqjC+GBD0JkhXJTPgxVz
         gLy5O+uJvkFP7yQ3yKbDfA9+ITE0CkqaHYYqJfCl5Prkwyi6tc7hLPTdySChtG/i4y6C
         ocSSkuw4t6T0eHKjegGacXaBZtTM66bhkARiH3+RnwY09IqHlVp0cQVM0db7OXfxqy20
         lW9L0tVEfgoRh3AesWejeXqBwKRpiD1Zw9rcgGKW5d5X1XLZ2BqPuK5+5xxNRBj/791p
         57iKDoIXHHa8lVKYFzlInp7DPn2gPuX6Y85+QcI5T6L5KMtXtH8LJucmCFirJkfR9mbg
         4T7w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1791223272; x=1791828072;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to:content-type;
        bh=QJepOKO9SMOEdU9WwD4yz29xGrgQCpaOXUKK8EHvPNg=;
        b=qpA1RVXbW1Nl2/eTDfpGbPENx52ApULsRup5q3tJJRwIUxZy+ffPXJBTNcC/IUfMYT
         8w5RecelCZLL+AqDsNpiJIEA3m/GYSENJxPQFHI53hy4plxhEUbhMZ+2nwKxHGMm2naY
         qsxOmy1lf6ev6dvBIGsIpxTYA554IyCHkOU/k1jM9+dGm99mdOzVmha5me43ktyTU9HL
         fhSBCCX103FUU1Z+2FUU3PyO05Jd4UPCk56vcHkIB6w+P8j+N/la/T00m+qu8Yka0XmQ
         vW+lJaipkbAHXcnEc3F1bksyx3LspKKM4HgHSV54zxP0UT4QBfkgx3M9S2XxZAoPspy4
         oHIA==
X-Gm-Message-State: AFuF++nUj55k1xvgEeAE9ZNalHzsjzVLg+kIV5lk2jisf+jwRFXL3mwq
	L3qWWLum1dk5o2GitbPkuk9FyZDnOH1g55raDRkAfUmlmItB6u6x1ufk17IMCnDyWvEleD7cWcL
	AV9r5xsRCiONhS+qq00Y8DnT8E6FOSvHQqHhLmhYriV6sNnmp6r/pO9qle3a7kOUpQc7robGlOX
	0v3nbdeFBAmyZ5wLzEtAXiZEDAMiSMVd+AbSvjsIKacw==
X-Gm-Gg: AYBFou1RJ2gvHQHBXnfxer7JuCTa1e+SWGlZiqLC9wbe4qz2LUmaVI3RV1/qM9mqpeH
	GSG41E4qoDof9/vqy673aqAu+gEMUjwqcRDVpsPL41XrRyBpsMv1W0XWWzeDzxDLvbwtEcv03R+
	ptneuBt3qtBnlLj/Zoh9D/hHPy5g2cDU1E4U0LVEqYEe5RzxmaOR2Je68vMw6pzmFYrHxPf7N8V
	muFS6/pnggT4cts9vs/Pl4GtWlkVzJHkOKQQ5RRsCV66RQljuSa/2qAY5LWkUEf8PHjNyImBs0D
	1eWEmQfLvOdqdY0oW+higthtMV04m2SVOWNXq195FkFz8Am2prDWqKwDwGCfAuzr6LwKLx+Bep6
	v4Bmekuy5egR0ZRwU/oVDWtgKk3uKEFD6ehryHwa0aITDatJeYjp2lEUE0KRTc42j
X-Received: by 2002:a05:620a:269d:b0:93e:7944:b869 with SMTP id af79cd13be357-93e7944cdbemr491436685a.42.1791223269926;
        Mon, 05 Oct 2026 11:01:09 -0700 (PDT)
X-Received: by 2002:a05:620a:269d:b0:93e:7944:b869 with SMTP id af79cd13be357-93e7944cdbemr491431085a.42.1791223269279;
        Mon, 05 Oct 2026 11:01:09 -0700 (PDT)
Received: from bearskin.echidna-sunfish.ts.net (c-98-227-24-213.hsd1.il.comcast.net. [98.227.24.213])
        by smtp.gmail.com with ESMTPSA id af79cd13be357-93cca26dae0sm932883885a.33.2026.10.05.11.01.08
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 05 Oct 2026 11:01:08 -0700 (PDT)
From: Frank Sorenson <sorenson@redhat.com>
To: stable@vger.kernel.org
Cc: Namjae Jeon <linkinjeon@kernel.org>
Subject: [PATCH 5.15.y] smb: client: split cifsFileInfo bitfields to avoid shared-byte RMW races
Date: Mon,  5 Oct 2026 13:01:02 -0500
Message-ID: <20261005180102.3978996-1-sorenson@redhat.com>
X-Mailer: git-send-email 2.55.0
In-Reply-To: <2026100538-wool-unveiled-ca0d@gregkh>
References: <2026100538-wool-unveiled-ca0d@gregkh>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

[ Upstream commit 19465a9aeb664f1d710d0d22c07c31bfb7c85446 ]

The invalidHandle, swapfile, oplock_break_cancelled, offload,
and status_file_deleted fields are stored in the same bitfield byte
in struct cifsFileInfo, but are updated in different code paths that
may run simultaneously, and are protected by different locks.  Since
bitfield assignments generate byte-level read-modify-write operations,
a modification to one flag can overwrite a concurrent modification to
another flag.

To avoid these races, convert these flags from a bitfield to
separate bool fields.

Closes: https://lore.kernel.org/r/7689764e-c0f6-4016-9557-b54cf4a3de4e@redhat.com
Fixes: 3bc303c254335 ("cifs: convert oplock breaks to use slow_work facility (try #4)")
Fixes: 4e8aea30f7751 ("smb3: enable swap on SMB3 mounts")
Fixes: ffceb7640cbfe ("smb: client: do not defer close open handles to deleted files")
Fixes: 173217bd73365 ("smb3: retrying on failed server close")
Signed-off-by: Frank Sorenson <sorenson@redhat.com>
Cc: stable@vger.kernel.org
Reviewed-by: Namjae Jeon <linkinjeon@kernel.org>
Signed-off-by: Paulo Alcantara <pc@manguebit.org>
(cherry picked from commit 19465a9aeb664f1d710d0d22c07c31bfb7c85446)
[ status_file_deleted and offload not present in kernel 5.15 ]
Signed-off-by: Frank Sorenson <sorenson@redhat.com>
---
 fs/cifs/cifsglob.h | 6 +++---
 1 file changed, 3 insertions(+), 3 deletions(-)

diff --git a/fs/cifs/cifsglob.h b/fs/cifs/cifsglob.h
index 9b08020634f1..be53b788ea4f 100644
--- a/fs/cifs/cifsglob.h
+++ b/fs/cifs/cifsglob.h
@@ -1265,9 +1265,9 @@ struct cifsFileInfo {
 	struct dentry *dentry;
 	struct tcon_link *tlink;
 	unsigned int f_flags;
-	bool invalidHandle:1;	/* file closed via session abend */
-	bool swapfile:1;
-	bool oplock_break_cancelled:1;
+	bool invalidHandle;	/* file closed via session abend */
+	bool swapfile;
+	bool oplock_break_cancelled;
 	unsigned int oplock_epoch; /* epoch from the lease break */
 	__u32 oplock_level; /* oplock/lease level from the lease break */
 	int count;
-- 
2.55.0

