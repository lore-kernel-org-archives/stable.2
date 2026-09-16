Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 10B04483BE3
	for <stable@vger.kernel.org>; Wed, 16 Sep 2026 21:34:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.129.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1789594480; cv=none; b=Y/53/AroFkmFmNtE2QYUO9Q5j9nwnGT9xggGPStNZsmE/y3aNmj+flOQt417FVzr8U/OAIIiS96GANeAVYEOWzPtXyEDq/H7Yn6i6fxZMlQmAPCgWFw5nJl/6O5HZ+W+ExCPplfrsaDa029aPQ+eHo6Yppx7bRRKrVcs/y19qG4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1789594480; c=relaxed/simple;
	bh=OFmUR5n12qboMmyBDS8aJ5gQxbHGee425Wkk4EjiRoo=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=VpAgryIRICjrPAKCda1T34exVdZ1MZzF5zdPr0S7wMmK2HUV8Yb91KdAtopbkfbuOEBVzbAqMf43O40nHN7kaBwLi9UCgoYk22Dd7MgAY3hFiDjURfV1sgBXgz0VuXSD7Pryy9PBW0gESRw4XzJq4YL0h+uWDue3l0SuWkWeO9E=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=bLBGkcAD; dkim=pass (2048-bit key) header.d=redhat.com header.i=@redhat.com header.b=YH/dMVKv; arc=none smtp.client-ip=170.10.129.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="bLBGkcAD";
	dkim=pass (2048-bit key) header.d=redhat.com header.i=@redhat.com header.b="YH/dMVKv"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1789594459;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=6OnhzbABUYbzzJKN8af0lhPKwu8S8OBp+evSnROGSRk=;
	b=bLBGkcAD2WhV2y5oUFTEUrEAAG2YG4qdAHxjE1aBE4KpRFAvGA6xwdWMwCGJI/fMwooxGc
	YfE9ARtbq+NeKG3dBfs/3HpB3WZPXw9SSNq4+O5Zhoyp4ChgH45HLEoQk4CNC9WMVWBRPl
	o7xA1q3JA6SCHZ7hzAjUeSgd6b6EMow=
Received: from mail-qt1-f197.google.com (mail-qt1-f197.google.com
 [209.85.160.197]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-433-ZIUNVjMAPOqWJBU6IlsdJQ-1; Wed, 16 Sep 2026 17:34:17 -0400
X-MC-Unique: ZIUNVjMAPOqWJBU6IlsdJQ-1
X-Mimecast-MFC-AGG-ID: ZIUNVjMAPOqWJBU6IlsdJQ_1789594457
Received: by mail-qt1-f197.google.com with SMTP id d75a77b69052e-5328cdb38bcso1610171cf.3
        for <stable@vger.kernel.org>; Wed, 16 Sep 2026 14:34:17 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=redhat.com; s=google; t=1789594457; x=1790199257; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=6OnhzbABUYbzzJKN8af0lhPKwu8S8OBp+evSnROGSRk=;
        b=YH/dMVKv4J4ArpzehpohS6zF5rxON7BzvxZ3nfa5+yqsQ4OxSqFuXLD6fhM011ub0N
         SfS/2oYWYPUuKsQfQBAmC00mrzY3Kh3ZSBdr3b9uLlO/DI8a+qkQuv1mSa4lmxGf3Xql
         sIclYXSflO2UcD14dFmqfV3WNWjxXfWzxgw+1Q0QxE4zSFwznxVqYbP53hwEa/FAU7EO
         CL/aa5GmL2hQTYS9vYNjzfTmpr3SWd9h5aIAyycRYwU9CC6xTyUM6oYgtbz+hdWH7Yuw
         pi/raviolet1zSvxEgkam6AT4CRSDTYcyweTVyPV019qSnTwiOsrH/ANg7oJ703wE40j
         t/bw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1789594457; x=1790199257;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to:content-type;
        bh=6OnhzbABUYbzzJKN8af0lhPKwu8S8OBp+evSnROGSRk=;
        b=MdksnzYk77YTJFieTfqgTWN1zdXoxEUmb2iZb1lE97jgZdtbTmHuYhB5SIqvuN2T5y
         yKieu0QrtyY0T5FipG3GZLE4vAbFJ4u2VO31Hf5zz/8btyps+YOjKgP94TvCmK7JiFWj
         0GiHPFzD58nOkm34gSYzJMgqNujn/D7g7Uz/9jr5uSQadW5XyqAQH6EmmUhA+Qgt14VX
         TBG6/jQcX6vVabhnwwXUoAWvTasegrhyFteVaXJKOTRvxVSyDrdm6AblCFa5E2+0zE++
         TcBZ+MDZnsrv3X3zj2CUZbWNU2lyv3+WxApwtutq4kiFFpuI4FxSX+1stpYjeADAUPo5
         Q1zg==
X-Forwarded-Encrypted: i=1; AKwUvBxV+/EK36ilynDYBRAFgDu7fAhnCRTNA4rWMC2V6bp/kYXqccZO/KjncQ6vVAUMfQLyuUi704A=@vger.kernel.org
X-Gm-Message-State: AFuF++lJCWzw4ggRfa98S2gSsRXpRTU/VINbVHLYrxfgKQM2BZExHj9y
	pN8G4KfXuXkcnsGNGR9wyCGclU/ANW0X4u+ZMZBZNzxXjds7PHLkO4+9Epvyrzdff8elOVVqDow
	lgHTSWMQx2a463sYY00i8isZYg7sCAPhSJr+dT1UOPqWGEBaLT08BPmFBRQ==
X-Gm-Gg: AYBFou3spZQExiJldjIZX7hAR9UBR1CbYICLH2IAtxDWBLaU/4CCeYpro2+IuQpIVdz
	YyLytqleQcM6LvnHYJIv1L1gooOHu7fnjySWndxKWTH5snjGGRTSVKiXW2EzaGREzGsTBucXhjA
	7bHUNre8rLtijGcbZGTUa8DkIqTYPaDwwPWvJo7k99P5NMAs2AorInOG9mfmrKxObM8J68PT5Sy
	Ji7SJSIlHDTis9I57j0/X+IUCKh+0sPrCnnUuRO9D9gEE3ZVuSQY0KbuLCScmc8avx7vLEdBwi/
	437x3w5oaM8ND7XLhxENbfCUc5qjkvi81xzNMZA6FckWYS2p/wQgzhnRJNTOPYjjr1fKv9+C4+u
	U14ZtmDz/SZCGaYIrJWFOEqKlyrflef7sxazM3WPtLjNAVSMvAHy2fcgE+o5XXxvMIg==
X-Received: by 2002:ac8:5916:0:b0:52e:467e:ea75 with SMTP id d75a77b69052e-5327eeaf0f2mr75155681cf.31.1789594457257;
        Wed, 16 Sep 2026 14:34:17 -0700 (PDT)
X-Received: by 2002:ac8:5916:0:b0:52e:467e:ea75 with SMTP id d75a77b69052e-5327eeaf0f2mr75155081cf.31.1789594456723;
        Wed, 16 Sep 2026 14:34:16 -0700 (PDT)
Received: from bearskin.sorenson.redhat.com.com (c-98-227-24-213.hsd1.il.comcast.net. [98.227.24.213])
        by smtp.gmail.com with ESMTPSA id d75a77b69052e-532620d4cbbsm32447431cf.28.2026.09.16.14.34.15
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 16 Sep 2026 14:34:16 -0700 (PDT)
From: Frank Sorenson <sorenson@redhat.com>
To: linux-cifs@vger.kernel.org,
	pc@manguebit.org
Cc: linkinjeon@kernel.org,
	ronniesahlberg@gmail.com,
	sprasad@microsoft.com,
	tom@talpey.com,
	bharathsm@microsoft.com,
	stable@vger.kernel.org
Subject: [PATCH v5 5/9] smb: client: reject short Next offsets in parse_server_interfaces()
Date: Wed, 16 Sep 2026 16:33:56 -0500
Message-ID: <20260916213406.1496960-6-sorenson@redhat.com>
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

In parse_server_interfaces(), the server-supplied Next offset is
validated against bytes_left, but not against the size of the interface
structure itself.

A small, non-zero Next value can pass the bounds check but advance the
pointer by less than sizeof(*p). This causes the next iteration of the
loop to read misaligned, overlapping structure fields.

Fix this by ensuring the Next offset is at least sizeof(*p).

Fixes: 7d34ec36abb8 ("smb3: fix for slab out of bounds on mount to ksmbd")
Cc: stable@vger.kernel.org
Signed-off-by: Frank Sorenson <sorenson@redhat.com>
---
 fs/smb/client/smb2ops.c | 6 +++---
 1 file changed, 3 insertions(+), 3 deletions(-)

diff --git a/fs/smb/client/smb2ops.c b/fs/smb/client/smb2ops.c
index 7f2177f6fc01..bda940cb3784 100644
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

