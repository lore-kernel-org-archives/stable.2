Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5BC9923BCEE
	for <stable@vger.kernel.org>; Wed, 26 Aug 2026 15:32:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.133.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1787758351; cv=none; b=kluYLDJxr/NrdtjaunoEPWVthpd3qxFVZRH0ZWnOVl8nOHQJPXOb6pSUFPeiMw6O6AqmRDNSem5h77LrxqSUfmd0T1lu54wVdxTw80BajV71DraBRJCZdBzKoh6HS3PEu8kRbUPwEwsuLYWBAMN8Qp/WwG8rYbL6nbpymZxZVSU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1787758351; c=relaxed/simple;
	bh=9c9AsfWadPeBpODKRouw11+EtIsyWqscZ8UgTDEVl3U=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=X1EcqmHZS659utpkSuGsH8jgfyPxfZ177WWTUsYkWKiv5UxVUmtjvxivRvhZ0rt+XG+8i5qkJymly74eBMeYa5zXPgxbMaOxCjCPbnCvvqQc+HCykWVw0eR8AdKHXatSIRwp3kJq+rMqJvApg+tiAZniMhyQS9T6eRWqszbTr+U=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=XGkIewlb; dkim=pass (2048-bit key) header.d=redhat.com header.i=@redhat.com header.b=gz7ukAk/; arc=none smtp.client-ip=170.10.133.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="XGkIewlb";
	dkim=pass (2048-bit key) header.d=redhat.com header.i=@redhat.com header.b="gz7ukAk/"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1787758346;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=zvrMF4Yjtz78iJTbYFy+PaftufYsw+A3Sx0I/KyH0+s=;
	b=XGkIewlbU3d5mQ4ir4krDN+2fZXh37OKrfz8Mbzk9vUEXOnPCGcss9QgH2br/t7w+eiQmA
	8bWcTpD1ApJc5s3TAeCcopAt7NSK3WgzEHpLNE5Ff+eQE9YKFadIOgsQk0bPPhYUL6sRAs
	lW15s0kLEoClEtYA4kCKTmwCckAV7xQ=
Received: from mail-yw1-f198.google.com (mail-yw1-f198.google.com
 [209.85.128.198]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-686-a5zqeBQ-NPCoO19n9LoJcg-1; Wed, 26 Aug 2026 11:32:25 -0400
X-MC-Unique: a5zqeBQ-NPCoO19n9LoJcg-1
X-Mimecast-MFC-AGG-ID: a5zqeBQ-NPCoO19n9LoJcg_1787758344
Received: by mail-yw1-f198.google.com with SMTP id 00721157ae682-822ce245c5aso34595117b3.1
        for <stable@vger.kernel.org>; Wed, 26 Aug 2026 08:32:25 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=redhat.com; s=google; t=1787758344; x=1788363144; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=zvrMF4Yjtz78iJTbYFy+PaftufYsw+A3Sx0I/KyH0+s=;
        b=gz7ukAk/wn/PmhvTsZ6g8iSt4NWvw6W32PVHwD7Rx0g18ewnU1CpwFk14lB5CvpCPL
         Vn9TG0/TAMpymk8JphCKpkHy2ou/pH27RjCe8V+MOwdqtYhKNx5pzHQ1rr7I7Rv4bhSs
         JVQYAA8tJ+8u4q2pkUXdDGysLfYwWJG0wk6shRFUdsqczDHuMSHKbZBFGNAvWtekG36c
         AF4r6LSkd9EYCyoUnCU4Y55vJO0VLHHTI+/5e4KEiahMtjmNhMCvhs92LrwJy7JrXwWY
         ob+eV38mwrq7CZ6c7IMHagaLn4e20Ry8hJ84gwYWfPH5V8YPfE+Jcm++TZ1GWhLh6eAH
         Cskg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1787758344; x=1788363144;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to:content-type;
        bh=zvrMF4Yjtz78iJTbYFy+PaftufYsw+A3Sx0I/KyH0+s=;
        b=bMeZTlpq7PqJdXVW9oe0PDRowZaUOKc5matI8RrFKpWIgewI2w1l1K3kQ/swO89oly
         iJz5JAhDfRZHuSd9whrCO+1YARiJaqPoudJEe16N647Op+X6SZA62335EKtgtyGSXshU
         0hrru90217GS2yjQpkQL3Uaz0iNv2bZ1fTVOWZIU+AgxYkxyTwDfdckIzlN7bHmxuT6o
         dnyR7Flc7iz5QUjhp5D1CEbTwCYf9BOGeuPJA0iAdDOmJN8jdBOZtuWKr0g3KvHJqG1B
         Pie0gE3lix43QYt9xZRp/GnQtJB/FX7jVu3CzUMY4Nz1ybabX35+w22gvE7YdNcPnNI3
         tiQw==
X-Forwarded-Encrypted: i=1; AHgh+RrCf/tGyozNfEsN/u6YrSxNgpH7W6sweTT1PVHxvXMDFSiI8pm8rfXK4/MIenPdJCYjqeAVLGM=@vger.kernel.org
X-Gm-Message-State: AFuF++njo7twsBnvoh28PHc8OAJl0EYN7zl0AYO+Xh/5TPAQ7leICAzm
	sJoMl1H+l91WoWQQOa8cVR1bmtO1uBWNXwBr0qUcjTcmHYErsSyp68cB3Lf85ujgoU2YYKlKcDW
	VKS9up/sR2ha+prxyI5IMhN7cHGYy3BklOip8WKelJbQyeT0JlGayZSCAKCkT+T6oUg==
X-Gm-Gg: AR+sD13GZlItwTzEnRjIWoDoGca67ZZCR+u1BEYbhwfiCTlHgZMD1ePqdeJppjJrhhk
	/oBD8UMhWTHYP+Smyepb2k5nPi0RfluPP2FRttYAHUFnFhbJOaovun5msc4pgXcnIjfplDcmNrB
	oz77fHJfJsic+lvjRry/u44g0ZoW5bwJtnxJLPImH59OPDQthzy9JF2j0aJw5uKde+2kxWGs/yj
	cexeq+DQC0WNOLetqzxZlh+h8S6OwT9hpDo61qmZFhw1d+8LnmJvgKdqYaJLcy09CUN5nWVjywx
	Ey+740E3M1b0IT0DRT/Hz0RJ0wPgsPKxjQOeN515IyIlFRuobFexnDI1L9szDoetM05HmgA5Api
	uvCDmQNXU2MwhExMcrcnJ0BKuXhP7kENDZgApVFhbWOpaWsuhQMX/H4FfRBSIAARsFw==
X-Received: by 2002:a05:690e:2056:b0:664:c81c:d1 with SMTP id 956f58d0204a3-66d2582f9a9mr2155117d50.45.1787758344449;
        Wed, 26 Aug 2026 08:32:24 -0700 (PDT)
X-Received: by 2002:a05:690e:2056:b0:664:c81c:d1 with SMTP id 956f58d0204a3-66d2582f9a9mr2155088d50.45.1787758343865;
        Wed, 26 Aug 2026 08:32:23 -0700 (PDT)
Received: from bearskin.sorenson.redhat.com.com (c-98-227-24-213.hsd1.il.comcast.net. [98.227.24.213])
        by smtp.gmail.com with ESMTPSA id 956f58d0204a3-66d24592f24sm1598209d50.6.2026.08.26.08.32.20
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 26 Aug 2026 08:32:20 -0700 (PDT)
From: Frank Sorenson <sorenson@redhat.com>
To: linux-cifs@vger.kernel.org
Cc: pc@manguebit.org,
	linkinjeon@kernel.org,
	stable@vger.kernel.org
Subject: [PATCH v3 08/11] smb: client: fix underflow in is_valid_oplock_break() notify offset check
Date: Wed, 26 Aug 2026 10:31:44 -0500
Message-ID: <20260826153147.4112943-9-sorenson@redhat.com>
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

