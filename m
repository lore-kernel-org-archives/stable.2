Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9D71249CF3C
	for <stable@vger.kernel.org>; Wed, 16 Sep 2026 21:34:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.129.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1789594478; cv=none; b=WRl9VCW9Je2gtFeHWTVyQR27Sog9dDRSUpqhjFgfANQmqAs45MFe0G0muytJwPm37QYWya7KEDpwNwv/51rHw2THLJhAbLcXyZ58qzmOlUiH3hd+iEKUrojxV9eI5Li6UC9yUDSpInIEgVChAgoQUoK4qrRlHm/v49dmFe+G2I8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1789594478; c=relaxed/simple;
	bh=V3hRYaC6tmgdcsZ5yGYav0Xh/yfqqFN1hacg6eKFoxw=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=J4OSubU6l+r/8Xkg+6lr55aH+MY7blKOx0j22wrW7ZKf6sMDyeYg+sHNFVGuXCZTLWSZvVsGO4tCuM4sE0GMbpnunoj0EBzBtGib3jWEOfff8F8Ve3UoppDgDMwSNNdbQcLXs0gJAu22kBQsBZ118ufnDoMHp8WuTj66PBe0sZc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=SvmWznw3; dkim=pass (2048-bit key) header.d=redhat.com header.i=@redhat.com header.b=oYh2+SWT; arc=none smtp.client-ip=170.10.129.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="SvmWznw3";
	dkim=pass (2048-bit key) header.d=redhat.com header.i=@redhat.com header.b="oYh2+SWT"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1789594462;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=CVRh5kukn/D6rYTpnAmlPzdqiIatWEMIIV6vU5NUkSQ=;
	b=SvmWznw35VvUGQddGL8yhGrdvajAJIe/PnN9S9ULUfwPFY2tqzsBR1jX+BVxSk9mtq/F6S
	VYSkS4VWFiMSSBDJ/hBty3oZUGVXpIpdgxu1M2uJleTKjQfaZU37WogZNlhzkNJLjqtYqQ
	qI0a1vgdMXFZwK1+MEvvO70z/BmP9d0=
Received: from mail-qt1-f197.google.com (mail-qt1-f197.google.com
 [209.85.160.197]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-31-91plGHghMsmhtS_i-chySg-1; Wed, 16 Sep 2026 17:34:21 -0400
X-MC-Unique: 91plGHghMsmhtS_i-chySg-1
X-Mimecast-MFC-AGG-ID: 91plGHghMsmhtS_i-chySg_1789594461
Received: by mail-qt1-f197.google.com with SMTP id d75a77b69052e-530d43c9a55so1769431cf.2
        for <stable@vger.kernel.org>; Wed, 16 Sep 2026 14:34:21 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=redhat.com; s=google; t=1789594461; x=1790199261; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=CVRh5kukn/D6rYTpnAmlPzdqiIatWEMIIV6vU5NUkSQ=;
        b=oYh2+SWTcbCYrIshkV7BBwSKWeN6i6QVkzs3LdFAlDJliL2peQqvuBnMoSPCUcf2jC
         6wWaS2Z8uOmWFuGfJGNd0h/UfKxw4Wb3HaK+hvuANeAC5aPvbyjs9KCQsR51qhtjYPim
         js5krc2zy3nTNx2ydBK8PfLDgKbpnXsVXaCu/UBPlcSG0GEz2hOwWsFGsKhDZgAM/cNu
         Sh6g3N97Rrwo2FBBLCDTe/phh+VFr9dnwppx4Xvj2cFGM+XCNKHOygRDJv6USktFW/bc
         W0duUhBWerwic9YxrUCQtI5t3167k1eqquocTo1yeDaGhZypOhS69zYb3DRLY684hsKx
         DRxg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1789594461; x=1790199261;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to:content-type;
        bh=CVRh5kukn/D6rYTpnAmlPzdqiIatWEMIIV6vU5NUkSQ=;
        b=ZnmPFc/FCwj+AN7AvN9xz84/6NtiXlSutHIjjsjygHVbXms15JXYbGOoWEpBDbb7MZ
         QvCFp93rIaY/wVwRtitsF31otASqvI1Y2YO09iGTd2xVHUHWDJqsVlqedsnuqfs8pWlY
         evOGuIB4umbpEmzA0FvDCXnN6v3YNfobFDjR3ht2ZjtSRY2Nskhdwiq5tUfr0bdIdIdn
         avJzxWWo8w24IKS4/YevZczB64Cda4tQZA2g+393F4Ng1HfS7djSH/Wwx8UFIEwQigF7
         An8+mE1hGcZPy3YyJDomHQ0Wa0gMRrQNIGvQVdy6o9pyetHxlPqVcOpEZJ3LkJPDOHy6
         kk9A==
X-Forwarded-Encrypted: i=1; AKwUvBwUsQGfp6ZYhX3gGcBM5cFFg/XnCR+7ybgiJ5ktC8ODXWDe9WxRIl96rtSfx3fO7rzEOgR62mc=@vger.kernel.org
X-Gm-Message-State: AFuF++liKxgVx9wwaiddaEmdVp/+0rLwyQy+rGUzaDSJaNuF6wtRbtWl
	IP2GQAj7ofJCH2D2u+mFhYXWEwZ/RpGSaB+rFPPBNzYycvRNM4lgGWin+TGn3o41v4CZASkpYjO
	wNCzhXYlUpfmKCGmNZrNG+SbPbytUGDUKvVl9v/wNQJCgYFhS/sFN5TlwTk7gno+E8w==
X-Gm-Gg: AYBFou0b4+mC/rfGKZtDa8eQdjkWpSYEyHP8p2MkYqSvlLAevePCs7EFsnRYZKkAfTz
	m4fBgc2OjapjNsa0c9S59p1JrVQ7IqTu7pdo3BUMxRvLKRO70/lar3jO7ie5ApjP2NazxEBuLZN
	6AUQzy5oALn0llSclNmwF5cDzNF7seZOGJrR/g2m23G3Tw7FKS0TE1E6zCsnDLQePFhgfRzvSCA
	MA+KysEoxSFsTG+DXy6iRXHunXIdJcYXX60kylVN+KG92cV3rbjPtw9UFN21CVGdCrbH1NnDgG+
	i4QpC6PIaCS6ECJwFzEIC9f56GwPxsaVnX2ElgCJv6ChKKU3d8KQUV0orJOGz06KvsyeFgyXUp3
	A3Ht/GYcJIoF4TQJtjUkbFiG3YtZ5Qm4B5mLLhkVRGvo76cP9RcAzNLACuuZRb6vkiA==
X-Received: by 2002:ac8:5a13:0:b0:52d:28f8:578c with SMTP id d75a77b69052e-5327ef20911mr72606051cf.31.1789594460590;
        Wed, 16 Sep 2026 14:34:20 -0700 (PDT)
X-Received: by 2002:ac8:5a13:0:b0:52d:28f8:578c with SMTP id d75a77b69052e-5327ef20911mr72605671cf.31.1789594460121;
        Wed, 16 Sep 2026 14:34:20 -0700 (PDT)
Received: from bearskin.sorenson.redhat.com.com (c-98-227-24-213.hsd1.il.comcast.net. [98.227.24.213])
        by smtp.gmail.com with ESMTPSA id d75a77b69052e-532620d4cbbsm32447431cf.28.2026.09.16.14.34.18
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 16 Sep 2026 14:34:19 -0700 (PDT)
From: Frank Sorenson <sorenson@redhat.com>
To: linux-cifs@vger.kernel.org,
	pc@manguebit.org
Cc: linkinjeon@kernel.org,
	ronniesahlberg@gmail.com,
	sprasad@microsoft.com,
	tom@talpey.com,
	bharathsm@microsoft.com,
	stable@vger.kernel.org
Subject: [PATCH v5 7/9] smb: client: fix missing iov bounds check in parse_posix_sids()
Date: Wed, 16 Sep 2026 16:33:58 -0500
Message-ID: <20260916213406.1496960-8-sorenson@redhat.com>
X-Mailer: git-send-email 2.55.0
In-Reply-To: <20260916213406.1496960-1-sorenson@redhat.com>
References: <20260916213406.1496960-1-sorenson@redhat.com>
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

