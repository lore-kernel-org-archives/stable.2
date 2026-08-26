Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 29530279907
	for <stable@vger.kernel.org>; Wed, 26 Aug 2026 15:32:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.133.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1787758348; cv=none; b=gbJtxjFDDsSWYVtplTl3r9X7ds5H+OOTz14y5gxRJxOf7S6dKIn9Zx+rVqu2M0qpkSbSAgdCTKERpKdrx+w7aKm3Rt6LPTySbt13fQzcZgeL7lksDVX8L7P73sLZgrcFaQYFy1kbmesoCJsG24rE0Dec18ufFQk86Y8P5rtCNiY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1787758348; c=relaxed/simple;
	bh=EhvDNaCN4ln1V4VGK64WbgDj53Eqm+A//1Pik0bbpSk=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=dDN4MPiwbTJ8K5PtFp2BLDW7Q0PDl/iE8wezcIANIwBj1WmukAMHFHQQOH6AShUh89reILqinznjCjUDASuQDrE2NWshklC9TIraY02be7SWg264zHhpUzsZYpO0xGt4sFW0EsYJqhXgLeKScWDaSLIv8lruS9e4Yd5cnLOgKZk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=hrctbcBS; dkim=pass (2048-bit key) header.d=redhat.com header.i=@redhat.com header.b=CpRC58fg; arc=none smtp.client-ip=170.10.133.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="hrctbcBS";
	dkim=pass (2048-bit key) header.d=redhat.com header.i=@redhat.com header.b="CpRC58fg"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1787758342;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=PIVhAaiWo8zlaMZvR5jj4DeJp4hplmxQu8aOHpcJh6Q=;
	b=hrctbcBSVQSLB/GeiHMHBhPFVkO2po6uJB1e+sB8eHIIz7nfUp92ZYZa6I0b2HhyunzlR2
	WtkxgaJj/M0M4IjU9drYkhdPy42dkHjk3RPcBZCBVA92KShdY4Q0NCHOzmbnpuCAjXCK/A
	PjZ2HPDCgyBtIT2WnjZne/CasNVWVwc=
Received: from mail-yx1-f72.google.com (mail-yx1-f72.google.com
 [74.125.224.72]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-694-BgTjiCU4OTGscqu1UnCgkg-1; Wed, 26 Aug 2026 11:32:20 -0400
X-MC-Unique: BgTjiCU4OTGscqu1UnCgkg-1
X-Mimecast-MFC-AGG-ID: BgTjiCU4OTGscqu1UnCgkg_1787758340
Received: by mail-yx1-f72.google.com with SMTP id 956f58d0204a3-66cd27a5468so2586718d50.3
        for <stable@vger.kernel.org>; Wed, 26 Aug 2026 08:32:20 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=redhat.com; s=google; t=1787758340; x=1788363140; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=PIVhAaiWo8zlaMZvR5jj4DeJp4hplmxQu8aOHpcJh6Q=;
        b=CpRC58fgtW6O1+9VWXPK8ELxRiEMpj+89IclG1kbGVO+4+AvZFQ21M5WdqErVzNSBu
         n9madz8W323kkWlpZaPKiT3eVQV7koQ3h6Wf2J7VwrdXN4fTsNmNoG9Baqrexugw8vua
         HOjhHwxicMvCpif4jJ++BhRKR1ketkGZ/P5ikLwDzTJm5y0esKspzj4FKseezvpbLBDq
         CaBXetsox9fPF1s4oGkMi8kCZiFmxdRGQ2hXJE0qAfpITs/1pgvy+SGX1KxsL59aC3nX
         dN7xm/Wx/EjlbIZn06zWvElEDSWOKlkhz7iFdIuBMrMUMNW+XotzEd1whxQ8DYYzFZx7
         /hrw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1787758340; x=1788363140;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to:content-type;
        bh=PIVhAaiWo8zlaMZvR5jj4DeJp4hplmxQu8aOHpcJh6Q=;
        b=HhRXThiZVxGAE7CITj/f5P5gpsqiOWkBcOXiEi1Zk1OKDFS/jaIJQNuwZRBmcb74BL
         ogEn8cOC4o6RVdz3oq5lJB7sIVoG3+mrxIdFxOLPLifckoHtckhoP8XKA3QZ42mdjiiw
         m95oyZ9PgQCmAZ3GZ6yLDzZXikgBjlBsxkGxojPQkUAIhfgC5PSsp2m2H2etTF2qek2p
         JKRCdUxNMMaSYXFU1o0CQhTegCE42KitSxdBJPwRabnUlLFocm7NjdR4udrap1IgbNQJ
         VurJnBB1VYQl2nSNPG+mVETd8TWkz3MK8ajHXOmzyT6cWjOSojMFQAQIzTNeW8CBRYAd
         IcKQ==
X-Forwarded-Encrypted: i=1; AHgh+Rqd0H2CM0KI9HE1pQTlmARRofYH7EMUCaTrQbkU4PVSwsVA1y5r33iV8bDiUNr5yrR5OHKzVCQ=@vger.kernel.org
X-Gm-Message-State: AFuF++n8Welv1dMgl2JiJIFvZbBk63ipg6UY8RSvc2ugEjVjZLAQZ5r/
	lGbxt+JUeR8R5qMIBTZSgM9gUU7f+cyeBGHujidibblqUJUTxOmyjFeLNKt8cnzrngTGGfv3/Rw
	B5mqLH/aDV95nKepii4yQIK7z50NEYa97PzvUweJQrIzSVGwqFmu8Wo22Lg==
X-Gm-Gg: AR+sD10Dfo+GbkmVTtdLpDrRvVvPVYVmReDx0Dlz2Vjv/JKrYYQ5cKW6POPJt+pIGGy
	e2Nvyfl01B+G2/xoTw/7uGUKpKBelI5DlFczNeejkCLskEXjDnsSdccxls0TykuEtif1aP0j7/a
	q80uWQlG7t5w6WliQ0WiWbNimBP3qhaQEmZqMnSQlqReh3D2XbEni8QNLvsmoCYbQxa7LtwftzX
	agfMcNeNwU/fssTaIT2XVKlkplMPJWsi1nUzp+JB9j9t1WZZOmqYNC+3WweRBDaLljvFu4tM4Kd
	F8JVU+gDrDi6W3UD1gBuhNtihqaCXWzRceGsH7rOLV0B/oL0EU5EXCxoIyqME3wYSaXvxhv+pKY
	MgkT9ZgSShxevk4e4+QhmvFQ8Qdh21+6BLlZK+/E23D/vFIsVAq8SvalWvXWbG/cQyg==
X-Received: by 2002:a05:690e:dc2:b0:667:a285:7624 with SMTP id 956f58d0204a3-66d257cb15dmr2890847d50.35.1787758339335;
        Wed, 26 Aug 2026 08:32:19 -0700 (PDT)
X-Received: by 2002:a05:690e:dc2:b0:667:a285:7624 with SMTP id 956f58d0204a3-66d257cb15dmr2890778d50.35.1787758338012;
        Wed, 26 Aug 2026 08:32:18 -0700 (PDT)
Received: from bearskin.sorenson.redhat.com.com (c-98-227-24-213.hsd1.il.comcast.net. [98.227.24.213])
        by smtp.gmail.com with ESMTPSA id 956f58d0204a3-66d24592f24sm1598209d50.6.2026.08.26.08.32.17
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 26 Aug 2026 08:32:17 -0700 (PDT)
From: Frank Sorenson <sorenson@redhat.com>
To: linux-cifs@vger.kernel.org
Cc: pc@manguebit.org,
	linkinjeon@kernel.org,
	stable@vger.kernel.org
Subject: [PATCH v3 05/11] smb: client: fix missing lower-bound on Next field in parse_server_interfaces()
Date: Wed, 26 Aug 2026 10:31:41 -0500
Message-ID: <20260826153147.4112943-6-sorenson@redhat.com>
X-Mailer: git-send-email 2.55.0
In-Reply-To: <20260826153147.4112943-1-sorenson@redhat.com>
References: <20260826153147.4112943-1-sorenson@redhat.com>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

parse_server_interfaces() validates the server-supplied Next offset
against bytes_left but not against sizeof(*p).  A small non-zero value
passes the upper-bound check yet advances p by less than one struct,
causing the next iteration to read misaligned, overlapping fields.

Add next < sizeof(*p) to the existing bounds check.

Fixes: 7d34ec36abb8 ("smb3: fix for slab out of bounds on mount to ksmbd")
Cc: stable@vger.kernel.org
Signed-off-by: Frank Sorenson <sorenson@redhat.com>
---
 fs/smb/client/smb2ops.c | 6 +++---
 1 file changed, 3 insertions(+), 3 deletions(-)

diff --git a/fs/smb/client/smb2ops.c b/fs/smb/client/smb2ops.c
index 1bc3f8266eda..9065c94e5ec6 100644
--- a/fs/smb/client/smb2ops.c
+++ b/fs/smb/client/smb2ops.c
@@ -785,9 +785,9 @@ parse_server_interfaces(struct network_interface_info_ioctl_rsp *buf,
 			break;
 		}
 		/* Validate that Next doesn't point beyond the buffer */
-		if (next > bytes_left) {
-			cifs_dbg(VFS, "%s: invalid Next pointer %zu > %zd\n",
-				 __func__, next, bytes_left);
+		if (next < sizeof(*p) || next > bytes_left) {
+			cifs_dbg(VFS, "%s: invalid Next pointer %zu out of range [%zu, %zd]\n",
+				 __func__, next, sizeof(*p), bytes_left);
 			rc = -EINVAL;
 			goto out;
 		}
-- 
2.55.0

