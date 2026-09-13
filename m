Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4D16B26FD9B
	for <stable@vger.kernel.org>; Sun, 13 Sep 2026 21:45:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.129.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1789335933; cv=none; b=BVMpv2vakdxc9XuSTNmAWLuJ7amSQ+Qi8SKVMiI4wO4F/aQjZ9qNxEUeU1UOLQksBeOByBAXbu0D89hyxXNmQ5eKnx3RhL42IWVZu+sXBAGeRReK0FiPkD6z5u8ryugtWum1qTPyGt+S95a01HmPlFhPR6/nHGZcUWUUWnkNt2s=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1789335933; c=relaxed/simple;
	bh=V3hRYaC6tmgdcsZ5yGYav0Xh/yfqqFN1hacg6eKFoxw=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=mMg2BaGoU6K1VeDR52q8VAYXTIA+hT3/HtmW2X9SFUYa0eVIcftbTWqU09BKyt7WdnwDuzFC33QtWLcY/1QsgGxPsfsNxwetmcotJCzpb3fx6CcmozvmQxRqft78dfw7i71j9TyUa/IXyhLnd1kz4xdG10e1MApQoSJnuiw0oKE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=LJiA+zBN; dkim=pass (2048-bit key) header.d=redhat.com header.i=@redhat.com header.b=aTE2TeHk; arc=none smtp.client-ip=170.10.129.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="LJiA+zBN";
	dkim=pass (2048-bit key) header.d=redhat.com header.i=@redhat.com header.b="aTE2TeHk"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1789335931;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=CVRh5kukn/D6rYTpnAmlPzdqiIatWEMIIV6vU5NUkSQ=;
	b=LJiA+zBN4bE7qPPou+AhvNyiZ/LZxfsdaBYGWTOF4FO4uWbNO4uwlruOlPVC5ewO4uhUjR
	E05n97Bbvk21DRcOv98eNPZBlD4dIFnXjhyXr7idEIkJkyUex7npDOhPcgWioAvvDzErkX
	pYWAr6u4XLgs/pGX3Qsb6W2SOWMdVqQ=
Received: from mail-qv1-f70.google.com (mail-qv1-f70.google.com
 [209.85.219.70]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-479-PuV5OaoTM4ebjzf4IMHWyA-1; Sun, 13 Sep 2026 17:45:29 -0400
X-MC-Unique: PuV5OaoTM4ebjzf4IMHWyA-1
X-Mimecast-MFC-AGG-ID: PuV5OaoTM4ebjzf4IMHWyA_1789335928
Received: by mail-qv1-f70.google.com with SMTP id 6a1803df08f44-9105be46009so61694456d6.1
        for <stable@vger.kernel.org>; Sun, 13 Sep 2026 14:45:29 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=redhat.com; s=google; t=1789335928; x=1789940728; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=CVRh5kukn/D6rYTpnAmlPzdqiIatWEMIIV6vU5NUkSQ=;
        b=aTE2TeHkFROFZHBhK+BsT7uyC2FGghfrQp5TfSOXW81zMd9cYqNEBHTdgi6qUrC5b2
         G5Po9cetF4a2FT+j+Jtm75OaFT15U+j+RAjTZpiI2Zqi2ICRt923k5u1qQsJhNvnjAVV
         omAqrk0eNaTmP79xzi8ozKV6/i6Q/eLl4fRBPrZxGBHeFuhOTo6Ih9IShbFSBfSS70G8
         8jZDde266m5sTqVua0rEfDOAQ8zomy+t1wG7Dxc5tzH8W2cQ0/Siqh+mw+Fyg3nr//h8
         qSbLkDw4HDaWemx9Wj8UPOAv4NZn3O18HUSvMApcqBX3+/S/pKwhK6JjBUNM2kLuW8Gy
         R9mA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1789335928; x=1789940728;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to:content-type;
        bh=CVRh5kukn/D6rYTpnAmlPzdqiIatWEMIIV6vU5NUkSQ=;
        b=Yj9i+PFaxXHef04zBBb49zTJV65SnPhTjvQ/2wMHBgsgr8v58Gol75+VNzFK4HWSnk
         3RuP4NI7527o/07KiRs/M3fQbYog2KP4Ot4ndJx4L3uRn3nLTOTD3sGaXG5pdAZeTojC
         5ky+zIeQF/+0+LY083eTpnCKdum4XeHo1hmdNUHTeHTBemOxyRglZdyFqktm4+H6GZGw
         tN2VKac8KRPGgDnA1EhjslZGmkjdOFl/VQAFl9DCsG8As4jdOR8k57YIBxGXAPRvIRDZ
         fe3gxwmLX4nte6avKrIjizAvpfnTwzQxF7FJMgu0xBxOYkwXI0BTz7QytezdZM+VicbL
         ByrQ==
X-Forwarded-Encrypted: i=1; AKwUvBy8Ze2rdNHFKrmbJsZWeKAYh0gU4sHmCY1fUXCoWVq8LFOxLdWdOThukQI/osTXWTd9x3XDgMI=@vger.kernel.org
X-Gm-Message-State: AFuF++kKj8N7IMywokFz3KbzfySYXWs5cPPkWIAE0Y2wHVKEom6OjDIT
	5mwHw8ETXp12l6HIuGDg8CVGq47aXbh/Dlf3zIFM2wSwo5JftxiPyWw41v49qs9qZSOZjVum3Iw
	UNLYco2pOBhNTB+IWF9wWWP8VbH0B5Gbj+LW3hnkdFJFPf0zadg+PlZ1dbA==
X-Gm-Gg: AYBFou0/Qo52mxe79PRM+edEt/GBul8cxKRzRSm9quAsf/efcB659LcWi1Q/VIT7kiO
	xIKtpO+Leclri2lPIcKUe5J3KbZT+Mz6rcK4Ztcr1DQ/px7UZXp+pWdx3p4Q/nkLvU0y1L4EL5J
	nP/m+HMgxhBDnieYelvSgrBElEtKdFgCj4pAj8FQWgftCzbn91Ht22YGGCCrmsGW/jrMGgEuY7E
	evszNJzGZXGx/KoyeeCg5E9pxV1zo0KIJTT5BFaaLKN8QU2abF0DiRw8lueCOeH4fYhLaamas8+
	NGcRsVSiSFMaVIDONt3HzInMavQ93r6HkPO6j8RIoM/pQSC8N4JJM3SuHKSy32ed3Dh0Qfq8l8I
	5hD0uecFvuCi/DH5EQFTartiIG8szZL4TOwOWt7Ccqygo7EmJgAB6l16JQ+MXMmvlGg==
X-Received: by 2002:a05:6214:860a:b0:910:3923:cc74 with SMTP id 6a1803df08f44-91226bdfedemr46565426d6.29.1789335928494;
        Sun, 13 Sep 2026 14:45:28 -0700 (PDT)
X-Received: by 2002:a05:6214:860a:b0:910:3923:cc74 with SMTP id 6a1803df08f44-91226bdfedemr46565196d6.29.1789335927993;
        Sun, 13 Sep 2026 14:45:27 -0700 (PDT)
Received: from bearskin.sorenson.redhat.com.com (c-98-227-24-213.hsd1.il.comcast.net. [98.227.24.213])
        by smtp.gmail.com with ESMTPSA id 6a1803df08f44-9120f49444bsm78581126d6.29.2026.09.13.14.45.25
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 13 Sep 2026 14:45:26 -0700 (PDT)
From: Frank Sorenson <sorenson@redhat.com>
To: linux-cifs@vger.kernel.org,
	pc@manguebit.org
Cc: linkinjeon@kernel.org,
	ronniesahlberg@gmail.com,
	sprasad@microsoft.com,
	tom@talpey.com,
	bharathsm@microsoft.com,
	stable@vger.kernel.org
Subject: [PATCH v4 07/10] smb: client: fix missing iov bounds check in parse_posix_sids()
Date: Sun, 13 Sep 2026 16:45:05 -0500
Message-ID: <20260913214510.3071370-8-sorenson@redhat.com>
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

In parse_posix_sids(), sidsbuf_end is calculated using the server-supplied
out_len without being validated against the actual length of the received
iov (iov_len).

If a server provides an inflated out_len, sidsbuf_end will point past the
end of the iov. This defeats the bounds guards in posix_info_sid_size(),
allowing out-of-bounds reads into adjacent kernel memory.

Fix this by rejecting responses where the calculated sidsbuf_end would
exceed the received iov boundaries or cause pointer wraparound.

Fixes: a90f37e3d7ac ("smb: client: parse owner/group when creating reparse points")
Cc: stable@vger.kernel.org
Signed-off-by: Frank Sorenson <sorenson@redhat.com>
---
 fs/smb/client/smb2inode.c | 11 +++++++++++
 1 file changed, 11 insertions(+)

diff --git a/fs/smb/client/smb2inode.c b/fs/smb/client/smb2inode.c
index 96063e355186..13fe8e3b48f3 100644
--- a/fs/smb/client/smb2inode.c
+++ b/fs/smb/client/smb2inode.c
@@ -77,6 +77,17 @@ static int parse_posix_sids(struct cifs_open_info_data *data,
 
 	sidsbuf = (u8 *)qi + le16_to_cpu(qi->OutputBufferOffset) + qi_len;
 	sidsbuf_end = sidsbuf + out_len - qi_len;
+	if (sidsbuf_end < sidsbuf) {
+		cifs_dbg(VFS, "%s: server-supplied out_len %u caused pointer wraparound\n",
+			 __func__, out_len);
+		return -EINVAL;
+	}
+	if (sidsbuf_end > (u8 *)rsp_iov->iov_base + rsp_iov->iov_len) {
+		cifs_dbg(VFS, "%s: server-supplied out_len %u overruns iov by %td bytes\n",
+			 __func__, out_len,
+			 sidsbuf_end - ((u8 *)rsp_iov->iov_base + rsp_iov->iov_len));
+		return -EINVAL;
+	}
 
 	owner_len = posix_info_sid_size(sidsbuf, sidsbuf_end);
 	if (owner_len == -1)
-- 
2.55.0

