Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A27E338758C
	for <stable@vger.kernel.org>; Sun, 13 Sep 2026 21:45:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.129.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1789335923; cv=none; b=G9kJ+IYoP4DRMhCHwWp2LM4yyhc6PTih+4zOTxOBLTw70k+2FrvlIwv+DOGbTG7nE3GvVrECiptWNHauq6iTB7CaMGZi9X0sAwKfK+rND5H8uIGEb+J5WvPPyKI7FhJjo/+QnaYPVpDUjAGsV2JV3GvGpdtc3DM1K0eF1fCXg6E=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1789335923; c=relaxed/simple;
	bh=qqqqhAcoTazT3zDcG36T/OFmfZ0W7gsqaDYv/oilvnM=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=hGaj1aVEzA9oZ6ogDZdbLS3hH3I4HC9G0QdcGts7DeYaTfB73RFyafTWLBAOnnpM+MJjJH8hcWQS4UGeRcfglHkRQ7Nwe4ULmv75wzVDAXFH9k8DCsqx+2fUKj3NaVVdHi2f6f+Ld0WeXS7P+mbk43UVcZWpoQnKOgUx+wiXNIY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=J5/X6zrY; dkim=pass (2048-bit key) header.d=redhat.com header.i=@redhat.com header.b=Ol+27LzM; arc=none smtp.client-ip=170.10.129.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="J5/X6zrY";
	dkim=pass (2048-bit key) header.d=redhat.com header.i=@redhat.com header.b="Ol+27LzM"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1789335920;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=jDQ6J6doFiv43Hl1XC1fv6A2Y0AiG/CVhsbe9ThB2Cs=;
	b=J5/X6zrYCu83rrt9d/PJ4vCTKZ89nAcw3WmCqM8YMvmsgywxxyWr6Ijl5IbdJOI/9Aww6r
	yXaxE1EgjIywoWS5txbUD44f3ymtPenBG7AkpiqHYetQEaznDE8hGJmn9pmyGcKT3O56wT
	3tEehyVDPjViaQ7yYBnDOR85jv9lec8=
Received: from mail-qv1-f71.google.com (mail-qv1-f71.google.com
 [209.85.219.71]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-617-k4S-pHSnP-yRjenPumiTFA-1; Sun, 13 Sep 2026 17:45:19 -0400
X-MC-Unique: k4S-pHSnP-yRjenPumiTFA-1
X-Mimecast-MFC-AGG-ID: k4S-pHSnP-yRjenPumiTFA_1789335919
Received: by mail-qv1-f71.google.com with SMTP id 6a1803df08f44-90e87478402so68718926d6.1
        for <stable@vger.kernel.org>; Sun, 13 Sep 2026 14:45:19 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=redhat.com; s=google; t=1789335919; x=1789940719; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=jDQ6J6doFiv43Hl1XC1fv6A2Y0AiG/CVhsbe9ThB2Cs=;
        b=Ol+27LzMZdauGe+b4tCHmEfatBH2+fkaDl+DXCRPH2mhb2e9rTgduXOj4cKRMQBsKV
         EIbdWkgDkYTUTtgJme05XPzQjcLqEew8dcjMNu4YJhfYkBHj2I9aZcqnspaJ9u+/sXHv
         cog/j+Vy/LAahdby4tglYCxMY0decUg49HEwq2Pu7OOdzhX9uMvKovI3NHUH9MFPswn3
         +WAEkZ40u3nEpHD6A4HmliUCtI2CbLG750TUh9mB9Bl0ROuhgWluNeiMjy4a2QG7XXLV
         3rqZxv3elJ6ilG8sy3DOrL5N4q0oVaCWj/TfFhrP+G4PnLUu1HVWslv8kyx8rjBrlXgy
         6EeQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1789335919; x=1789940719;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to:content-type;
        bh=jDQ6J6doFiv43Hl1XC1fv6A2Y0AiG/CVhsbe9ThB2Cs=;
        b=Xu122nSOvmQ3/pMyAfq81pwoNUvBc9HL1B3F6zw89fudwhoom4ToLQexFUE1sdA738
         6HgPnXanCPY8kBTITxra7rDhM9ltbzjvPfG0ykKGA3eIuq35k3RpXbFUg7koN5DyEj9c
         ZagJWZm1xaoCYkLAjFv5Hgc7BQp6/Rp3qflx2ppsrVnUGr8LqWC6Ome/b2WjfQA5nXNe
         XxDpD1+FinrgrBPYGJ2GHuvL6t8qq8yiHk/IgMsrAcfbAxKw8XWTzM91qnE9HBD/S/NE
         VT+Lj+G6IrZPXSERKMoXWakYF/69zG6wX8XnjNXS9CKa2Rd0CwXejj4ci1xj8p6yv25h
         IN/Q==
X-Forwarded-Encrypted: i=1; AKwUvBwQVTwwGlc9x+TNsOrco5cp8llTWifE7i5dF+tQ9UyhZMBZueuiwmF+YTYTAzJVY0HdS4T5q3A=@vger.kernel.org
X-Gm-Message-State: AFuF++lVg36I5zE9exZZL4BSX6gg6tkfyBiknRkeFrOck3SVeHeJJpe3
	1AJgP7OyOLxfLrgJyZj5bmWxPngYjomqJkyFm/sDDxX+aXZ7Kyg4tp4iWKhIRzBgxsDmmIEj1M7
	di/4Q8XJgGReDjS0QT4lQ45CHnfgnGkxd8qZCUgyQiO1jydNdB0zG2X2Srw==
X-Gm-Gg: AYBFou3e7cy+5cjLzUfx/OYrGPR2Ha5fPHsQkDmKr28zsuFG16w9pKemUwnDE2boGyf
	PwnehstgoZm8jYOqY3B0tCJ1DGFU+HD7/SyZpnV2cX2V7987SDFTV00SKIkpHIZtQTKR19125AP
	UknXS7iZk/JN4Rp61hyF3zm4Cc06Sa0dqiNfpY5LJP6VkxMSeo0/9AjNbjaw8TLd+4mAbchzgbI
	hHr59Jkzp2vfTFkYas2lz7EGLJKrC0ZzvNa5Z1PS+A9jglt1UHX+hmJ7MPqQG3+05cIJOm5DVZ1
	JY/FhSnH7rYuvkhN07mwW+n+fTamozVLwO7Rw7obSHJ3xaP5z4Ejb/MZX0G8blVhPN3ZJYu8hde
	Glbh4mkx6ijfbFew4/QEx8W20ayaRpbBmCUyff+66IEzsa3cK5ZCaZ9Gr8DYVxjmsuw==
X-Received: by 2002:a05:6214:5087:b0:910:47af:7b5b with SMTP id 6a1803df08f44-9121da764f3mr135221966d6.20.1789335918714;
        Sun, 13 Sep 2026 14:45:18 -0700 (PDT)
X-Received: by 2002:a05:6214:5087:b0:910:47af:7b5b with SMTP id 6a1803df08f44-9121da764f3mr135221436d6.20.1789335918250;
        Sun, 13 Sep 2026 14:45:18 -0700 (PDT)
Received: from bearskin.sorenson.redhat.com.com (c-98-227-24-213.hsd1.il.comcast.net. [98.227.24.213])
        by smtp.gmail.com with ESMTPSA id 6a1803df08f44-9120f49444bsm78581126d6.29.2026.09.13.14.45.17
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 13 Sep 2026 14:45:17 -0700 (PDT)
From: Frank Sorenson <sorenson@redhat.com>
To: linux-cifs@vger.kernel.org,
	pc@manguebit.org
Cc: linkinjeon@kernel.org,
	ronniesahlberg@gmail.com,
	sprasad@microsoft.com,
	tom@talpey.com,
	bharathsm@microsoft.com,
	stable@vger.kernel.org
Subject: [PATCH v4 03/10] smb: client: fix server->total_read for compound encrypted PDUs
Date: Sun, 13 Sep 2026 16:45:01 -0500
Message-ID: <20260913214510.3071370-4-sorenson@redhat.com>
X-Mailer: git-send-email 2.55.0
In-Reply-To: <20260913214510.3071370-1-sorenson@redhat.com>
References: <20260913214510.3071370-1-sorenson@redhat.com>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

In receive_encrypted_standard(), server->total_read is left at the
full decrypted frame size when walking sub-PDUs of a compound encrypted
frame. As a result, cifs_handle_standard() passes this full size
to smb2_check_message(), causing the PDU length guards to incorrectly
validate the entire compound frame instead of the current sub-PDU.

This allows truncated non-last sub-PDUs to bypass length validation,
leading to out-of-bounds reads in smb2_get_data_area_len().

Fix this by setting server->total_read to the true length of the
current sub-PDU: next_cmd for non-last sub-PDUs, and the remaining
pdu_length for the last one.

Fixes: b24df3e30cbf ("cifs: update receive_encrypted_standard to handle compounded responses")
Cc: stable@vger.kernel.org
Signed-off-by: Frank Sorenson <sorenson@redhat.com>
---
 fs/smb/client/smb2ops.c | 1 +
 1 file changed, 1 insertion(+)

diff --git a/fs/smb/client/smb2ops.c b/fs/smb/client/smb2ops.c
index fcf7033889c7..7f2177f6fc01 100644
--- a/fs/smb/client/smb2ops.c
+++ b/fs/smb/client/smb2ops.c
@@ -5371,6 +5371,7 @@ receive_encrypted_standard(struct TCP_Server_Info *server,
 one_more:
 	shdr = (struct smb2_hdr *)buf;
 	next_cmd = le32_to_cpu(shdr->NextCommand);
+	server->total_read = next_cmd ? next_cmd : pdu_length;
 
 	if (*num_mids >= MAX_COMPOUND) {
 		cifs_server_dbg(VFS, "too many PDUs in compound\n");
-- 
2.55.0

