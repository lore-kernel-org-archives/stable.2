Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5D889372ED0
	for <stable@vger.kernel.org>; Sun, 13 Sep 2026 21:45:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.129.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1789335926; cv=none; b=af6b6biNsAUYvVKW5BPz3aLGmKeATz3KxgdxrrNnEPa4ZXsEpqkI3HMqmI7GMX9Z5HhGNEp1wqIbanu1d2SQ9VX74kLHLxnN/C/KD+NHAK7mmVPKce3r9C6XXTkad4xBA6S4bzinzeKwSht8ICEjfECD3TM+JtPoOUchCkTO0wM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1789335926; c=relaxed/simple;
	bh=f+YJXylF+jELmM3YL8b/3zgaQ/j7J8cGlBlt+c/+tZQ=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=pGVKMk4sEaOjTdAs8C5nxs3zqWG/0VxZV0zEWoiumN4gBUs8IzTJ2E4KRoPKe6rm/V0CiZ6FDiD5d+DZQeQyfUaRuS08vGLKsxz28F1/YfkRmDA4xRZgLQ9rFQUmdjzD5mQPqSA2lzxD32aa84r+2kYVC0NxtR34Dw3gQsEgJik=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=jOZJSiJy; dkim=pass (2048-bit key) header.d=redhat.com header.i=@redhat.com header.b=AG2MPAVa; arc=none smtp.client-ip=170.10.129.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="jOZJSiJy";
	dkim=pass (2048-bit key) header.d=redhat.com header.i=@redhat.com header.b="AG2MPAVa"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1789335923;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=KKqvOsVDrJRPcyxb6Szb7e0yhM454WCjOV2ZQ8hI9uY=;
	b=jOZJSiJypIE2PA3M1TAb/irwO1QYnZ4hzbcs83uQo2ENjWOCBuXT9hdx5nv4mJTasGNUek
	iCFvoozLxeI68T/pkHV0AzlzsNp+LgjlMtxZmg5q5fLO0S3QV8zKp2iMhuvei3KW0NIzqE
	wLQrLy1seVCaYpOl4F180YJlTx4yrzE=
Received: from mail-qv1-f71.google.com (mail-qv1-f71.google.com
 [209.85.219.71]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-449-JObFJauSOQ2EZ1tadr7sHQ-1; Sun, 13 Sep 2026 17:45:22 -0400
X-MC-Unique: JObFJauSOQ2EZ1tadr7sHQ-1
X-Mimecast-MFC-AGG-ID: JObFJauSOQ2EZ1tadr7sHQ_1789335921
Received: by mail-qv1-f71.google.com with SMTP id 6a1803df08f44-9103f4ddce5so31797776d6.3
        for <stable@vger.kernel.org>; Sun, 13 Sep 2026 14:45:21 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=redhat.com; s=google; t=1789335921; x=1789940721; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=KKqvOsVDrJRPcyxb6Szb7e0yhM454WCjOV2ZQ8hI9uY=;
        b=AG2MPAVak6OeIfAQNylyYx5uYp4f7Jk1VwsD7hB/LEkz2/LRXztVr4H3dtHYlxE+98
         smMcffsme+Kmc0aPW2O8udosqi8l5Ml3wBX1ZduaODi/YxNYmYTEN1TwOxFpGDM3yYAN
         mYiQrHgI1nu6YJ7NAhzeVPKi7ZzWYZsUp1DgEMHbZmFqpQ/kl1zz/As1iffgFyG51S8r
         /XDlrWoJmBUSPHXfs7/2X+8qH++DveWi4Y5ZvOnI+fu/evT7I5svGosgZZVG8ii4QOxE
         e3u1PKhscpYxptxIYn2zrzJ8IIzRGXBaWlch8WPxBX8pJW0M2m7CF7uE3dCXrcFN/Zfa
         6sRg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1789335921; x=1789940721;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to:content-type;
        bh=KKqvOsVDrJRPcyxb6Szb7e0yhM454WCjOV2ZQ8hI9uY=;
        b=miyYT76EwxgxSbcg62r+GoJmIKWxzPKdnoGPs+04qL0odSATRm69wC2G0Pnx4P3nyE
         SzwY4YoPeiRV3noYHw98vL7hB2RMoqBw95gIcGDUfalOLRphu4l04rObqRguXTe+laMQ
         JLos0YySpjT+vkSsAGomAAIzCrez0OXB+enoBmS6StzyRJzEa/31FLMMwaA/3TI7/b+H
         V73pIetYpuQKfxluKkHUwKPplWdhKB7XuswazTlsJw9ZG4CyLTjnGml31XeZqSmdiEfg
         WBV19+R0Tuor0hCw1ETZKlBDsX9Nxlv+Q0pNAYNxMq3ZkDz4HblVM35TksnLUrDEj0Md
         8vdw==
X-Forwarded-Encrypted: i=1; AKwUvBwiUb+G/OwYNAZ0cTffCREGJeI2PiPPbjo/xR5rCkIvY9a+Dcdix7LBK9PgaOh/3LuTNtNk7V4=@vger.kernel.org
X-Gm-Message-State: AFuF++mGpTSKzHA7dGQ8IVLOToxJIaxg8T8KVbMjLgeDme+7einK7Zrz
	mbRtXbH/NA8WP9FJgP/WEomcJdqvZAc32pfkmLO3o+i5iKW6NdtNKdiIWwY/jawaNfuePAqxKRN
	GDn5qk+4+kWQQbLo+LnIcH0NVSaa/unLOTclIaaC5cITr/tesjio+yMG5bQ==
X-Gm-Gg: AYBFou2kmPm3UrZMJnajgLzNllIKHpK1D2VkaTEkQWwcvzcgmp/uXzyH3CAC2nM/b9V
	XUW8KfBLz7yp7aEibEHWU9zwiactffc4PiER3/RP8WqIaWO/nqW2DUY7gEgW6SEGnU18DMGFSyH
	yB8yW4ac//nU5t3FDwcXe6qP2pYE9QQVHpV4OgUiYSG8SRRYO6Z0YXbw6uwUts6B5GMqrD2jkQY
	0Y2Dg5keyUJvltxabgGmk6INOHPF2OKLO0+PZTuVJoGZ2mA+V8H2ROhR77urTMNcd07XlohYSV5
	74b2smIIoQUek+0KtcWQiuU0N5QBKkoQ0siJcikY4sMjFvuvdbQvmU60Sdr3jSfBEa6jEjV0IBl
	sco6zyhwQWNgVGDwtv7PBw9ZF5jkZFVsFh9RiwhQnoc30Q/Y1Ex8ujtmKqsR9CvUh8g==
X-Received: by 2002:a05:6214:4a05:b0:910:3988:b3b with SMTP id 6a1803df08f44-9121210a899mr243747506d6.36.1789335921382;
        Sun, 13 Sep 2026 14:45:21 -0700 (PDT)
X-Received: by 2002:a05:6214:4a05:b0:910:3988:b3b with SMTP id 6a1803df08f44-9121210a899mr243747136d6.36.1789335920941;
        Sun, 13 Sep 2026 14:45:20 -0700 (PDT)
Received: from bearskin.sorenson.redhat.com.com (c-98-227-24-213.hsd1.il.comcast.net. [98.227.24.213])
        by smtp.gmail.com with ESMTPSA id 6a1803df08f44-9120f49444bsm78581126d6.29.2026.09.13.14.45.18
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 13 Sep 2026 14:45:19 -0700 (PDT)
From: Frank Sorenson <sorenson@redhat.com>
To: linux-cifs@vger.kernel.org,
	pc@manguebit.org
Cc: linkinjeon@kernel.org,
	ronniesahlberg@gmail.com,
	sprasad@microsoft.com,
	tom@talpey.com,
	bharathsm@microsoft.com,
	stable@vger.kernel.org
Subject: [PATCH v4 04/10] smb: client: fix missing lower-bound check on DFS referral string offsets
Date: Sun, 13 Sep 2026 16:45:02 -0500
Message-ID: <20260913214510.3071370-5-sorenson@redhat.com>
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

parse_dfs_referrals() checks that DfsPathOffset and NetworkAddressOffset
do not exceed the buffer end, but fails to check that they don't point
inside the referral header itself.

If a server provides an offset smaller than sizeof(struct dfs_referral_level_3),
the derived string pointer overlaps with the struct fields, causing
cifs_strndup_from_utf16() to interpret header data as UTF-16 strings.

Fix this by enforcing that string offsets are at least sizeof(*ref).

Fixes: 4ecce920e13a ("CIFS: move DFS response parsing out of SMB1 code")
Cc: stable@vger.kernel.org
Signed-off-by: Frank Sorenson <sorenson@redhat.com>
---
 fs/smb/client/misc.c | 12 ++++++++++--
 1 file changed, 10 insertions(+), 2 deletions(-)

diff --git a/fs/smb/client/misc.c b/fs/smb/client/misc.c
index 945194fe7a97..05168284f205 100644
--- a/fs/smb/client/misc.c
+++ b/fs/smb/client/misc.c
@@ -788,7 +788,11 @@ parse_dfs_referrals(struct get_dfs_referral_rsp *rsp, u32 rsp_size,
 		node->ref_flag = le16_to_cpu(ref->ReferralEntryFlags);
 
 		/* copy DfsPath */
-		if (le16_to_cpu(ref->DfsPathOffset) > data_end - (char *)ref) {
+		if (le16_to_cpu(ref->DfsPathOffset) < sizeof(*ref) ||
+		    le16_to_cpu(ref->DfsPathOffset) > data_end - (char *)ref) {
+			cifs_dbg(VFS, "%s: DfsPathOffset %u out of range [%zu, %td]\n",
+				 __func__, le16_to_cpu(ref->DfsPathOffset),
+				 sizeof(*ref), data_end - (char *)ref);
 			rc = -EINVAL;
 			goto parse_DFS_referrals_exit;
 		}
@@ -802,7 +806,11 @@ parse_dfs_referrals(struct get_dfs_referral_rsp *rsp, u32 rsp_size,
 		}
 
 		/* copy link target UNC */
-		if (le16_to_cpu(ref->NetworkAddressOffset) > data_end - (char *)ref) {
+		if (le16_to_cpu(ref->NetworkAddressOffset) < sizeof(*ref) ||
+		    le16_to_cpu(ref->NetworkAddressOffset) > data_end - (char *)ref) {
+			cifs_dbg(VFS, "%s: NetworkAddressOffset %u out of range [%zu, %td]\n",
+				 __func__, le16_to_cpu(ref->NetworkAddressOffset),
+				 sizeof(*ref), data_end - (char *)ref);
 			rc = -EINVAL;
 			goto parse_DFS_referrals_exit;
 		}
-- 
2.55.0

