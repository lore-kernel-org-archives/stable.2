Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C07173DA5C5
	for <stable@vger.kernel.org>; Mon, 17 Aug 2026 17:16:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.129.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1786987018; cv=none; b=IYZkx8wtq49bHtjSLHNrDMgUuW62EHNGpJ9ZgABrZXSpL2fVYlSPDecKYD5ImZoJ8Ud4lsCnEmi44b1AVNnEXKlq+8e8taXeRq6Qt87VCBS0cAdeGMHqNP2luD47LOPyFru0V6jmNI02mAjXzvO/0umAZYp3qxGsWTmf/ZnBfl8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1786987018; c=relaxed/simple;
	bh=lRYoPmV0LW14tEpSfCnlYYSJ4dk5knGBrnW7LNwSzbo=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=XkXTYQgJ05kQer0VcTsBkpD1UaI3i6fbHKCEbovZMxIU0w1O+cunc63yQ0cxLOnYQFuZdYCZYg+yQiLrQlrNjCTAVyffsDtDjMlOTsazf1AogN6KgQu8C+AM3+Dcd16hkYxTPVpBk+sopCWOnz2XHe0Ow+ykw9FHuP7egHNe054=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=G47n6OWS; dkim=pass (2048-bit key) header.d=redhat.com header.i=@redhat.com header.b=EhTht0Kj; arc=none smtp.client-ip=170.10.129.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="G47n6OWS";
	dkim=pass (2048-bit key) header.d=redhat.com header.i=@redhat.com header.b="EhTht0Kj"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1786987015;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding;
	bh=pvxgPz+LBnG3ZfLOKG1tZ8Ig6q31TfKHpwszxp39SfA=;
	b=G47n6OWSe0UNyBnqtHRK6FDqX2u4vF3+Hz6YlzXUDiwgUcKV0K2uZsS+NkR3iaqyoTWSVo
	mhxmZ28VI0ur+Jo8Woi86SHOewHA+DAxRxpSH87/qmk0aSiFF6g46yEO3WLSQIN44hgpQ8
	rXrcz4z1w5fvYV4h79egF1QIiF/xsGM=
Received: from mail-ot1-f72.google.com (mail-ot1-f72.google.com
 [209.85.210.72]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-681-v8qkLpMvOH2hTmzo2YOWjw-1; Mon, 17 Aug 2026 13:16:54 -0400
X-MC-Unique: v8qkLpMvOH2hTmzo2YOWjw-1
X-Mimecast-MFC-AGG-ID: v8qkLpMvOH2hTmzo2YOWjw_1786987014
Received: by mail-ot1-f72.google.com with SMTP id 46e09a7af769-7e9e741693bso4681993a34.0
        for <stable@vger.kernel.org>; Mon, 17 Aug 2026 10:16:54 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=redhat.com; s=google; t=1786987014; x=1787591814; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to:content-type;
        bh=pvxgPz+LBnG3ZfLOKG1tZ8Ig6q31TfKHpwszxp39SfA=;
        b=EhTht0KjFXzpQN+LqvFJvHjggE30IBgPC7mwt/DfYAv0YyLOuxpdE6dYTW9kqLlvX1
         Ba8oDzsqyHNu4YDXnzHYfJ5T2J34b2iQHhCZshLa/bWdY+3UFKYzfLV4bWsUfzcCjyxv
         6ri4Ysh5KuS17N1mGkFo+5tRH+13+bKtqDTB8OVNQgAa3e3fhDhZc1PVAk7r7pMzBmDe
         fXZbNbCn2sb3bOc3RyUAsW8XGeCsrN86wmdbfNBkEt1ilQkMmIyVkT5GcLkWU53ilzVs
         AubUWexIUNsecxIIgKubxZ8kwRoVAnhdsrrn7QRt3nNUPTEKHsih03D+KronHPCZMvLc
         OdHQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1786987014; x=1787591814;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=pvxgPz+LBnG3ZfLOKG1tZ8Ig6q31TfKHpwszxp39SfA=;
        b=j0+HUjilHmC8yGZQClGnM/3DDwA5UHX2Qh0DlbBPH+SY9KdMDyc/Uaq+6o2gQJ0T0A
         0Vh87mV3b3WAx7wEtTSyKY8OujqDhhjUzWSUNOKyL1MYDKDmev883Zu65fKU6nyWjSRm
         We1w2ZhfakOo6H6uWbIMPEeWMQ/09DLvOQVJ+a/ZCezuYAUXzSrgllwxWgxAHYBaa/AA
         gMj2RGhrgbiTQw91AjVRNGOGq+B41Nn31Jtl6mqPjYT8oyCL6E26Q9S51z+7HvSJohT7
         TvR5O1CVdgdHI6P7QiQhAW1JMjYRZYiPQR8D04F0I82NanV0c3jqNvW3a1YYVQNMBprs
         HmCQ==
X-Gm-Message-State: AOJu0YyxmfgQsImNhO+9GoAuRP/drvx8gMNwlyx6pjghjYw9unvoUNJD
	jfwjZz6DTNng4N3CXraEP2ef8rHMqwwbpWnlvg5d+FAcyaMFWNKxVQKKU87/WU0tLrmpk5cmI11
	/KoVMOwxK4n7RJndHzuX5TiKQQvkU9zbQ8utr0VS5DTg3WNcZs/5aGwaNzg==
X-Gm-Gg: AR+sD11SWQYU34YsD40MLYSnLMivjoSIPDksq4u4rSiRYLRTagTcTaF3eqZaLwrizi9
	UNc3+jzxofHKJKKb82t6dxiNCsbUQw8ra0A8ItXxHO58uuLZgDeJGuEIWbAyTR5U+hhj8gh2K3P
	NXSFeywMcJPT/QxSKybqhH4719051ky1zQLcasJRo6gFFV+LbrPT1ZasEb9qgitPSFBKTarJ9Zo
	5sK9TQRsBHVgZKEwV8YPZaTRjnHI+zICKK9kuie/VXutU1/PbfyRj1+ziGCVHn7aHeD5hr05tiF
	AJ4D1HJCHZH8PdinysJjPO4HXpv/dW33/7iGvLEdzR0h4wD9Tg3BrTLHxzfJRZpw/GBD8M+Jqi9
	pi5229gdtzKk+9GhxmiPucnMUObn0JSoYH1SkFhBWaWTYeiLmUCNKU9Ts7bivqhmvnA==
X-Received: by 2002:a05:6820:811b:b0:69e:b8:ffe4 with SMTP id 006d021491bc7-6b11e366456mr1792248eaf.32.1786987013753;
        Mon, 17 Aug 2026 10:16:53 -0700 (PDT)
X-Received: by 2002:a05:6820:811b:b0:69e:b8:ffe4 with SMTP id 006d021491bc7-6b11e366456mr1792204eaf.32.1786987013354;
        Mon, 17 Aug 2026 10:16:53 -0700 (PDT)
Received: from bearskin.sorenson.redhat.com.com (c-98-227-24-213.hsd1.il.comcast.net. [98.227.24.213])
        by smtp.gmail.com with ESMTPSA id 46e09a7af769-7f41c0b9546sm2233876a34.16.2026.08.17.10.16.52
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 17 Aug 2026 10:16:52 -0700 (PDT)
From: Frank Sorenson <sorenson@redhat.com>
To: linux-cifs@vger.kernel.org,
	stfrench@microsoft.com
Cc: stable@vger.kernel.org
Subject: [PATCH] smb: client: fix ALIGN() overflow in symlink_data() error context loop
Date: Mon, 17 Aug 2026 12:16:51 -0500
Message-ID: <20260817171651.212730-1-sorenson@redhat.com>
X-Mailer: git-send-email 2.55.0
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

The check added by commit 7d9a7f1f96cd compared the post-ALIGN length
against the remaining buffer, but ALIGN() itself can overflow: for
ErrorDataLength near UINT32_MAX (e.g. 0xFFFFFFF9), ALIGN(x, 8) wraps
to 0, so the subsequent bounds check passes, and the loop advances by
zero bytes leaving 'p' pointing into stale data.

Fix by checking the raw ErrorDataLength against the remaining space
before applying ALIGN(), then checking again after.  Since raw_len is
bounded by the buffer, raw_len + 7 cannot overflow, so the second check
is an exact post-alignment bounds guard.

Fixes: 76894f3e2f71 ("cifs: improve symlink handling for smb2+")
Cc: stable@vger.kernel.org
Signed-off-by: Frank Sorenson <sorenson@redhat.com>
---
 fs/smb/client/smb2file.c | 5 ++++-
 1 file changed, 4 insertions(+), 1 deletion(-)

diff --git a/fs/smb/client/smb2file.c b/fs/smb/client/smb2file.c
index f35b6488d810..fb2fccbe8667 100644
--- a/fs/smb/client/smb2file.c
+++ b/fs/smb/client/smb2file.c
@@ -61,7 +61,10 @@ static struct smb2_symlink_err_rsp *symlink_data(const struct kvec *iov)
 			cifs_dbg(FYI, "%s: skipping unhandled error context: 0x%x\n",
 				 __func__, le32_to_cpu(p->ErrorId));
 
-			len = ALIGN(le32_to_cpu(p->ErrorDataLength), 8);
+			len = le32_to_cpu(p->ErrorDataLength);
+			if (len > end - ((u8 *)p + sizeof(*p)))
+				return ERR_PTR(-EINVAL);
+			len = ALIGN(len, 8);
 			if (len > end - ((u8 *)p + sizeof(*p)))
 				return ERR_PTR(-EINVAL);
 
-- 
2.55.0

