Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 68BD237F74C
	for <stable@vger.kernel.org>; Sun, 23 Aug 2026 18:58:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.133.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1787511537; cv=none; b=Yu9rsNAjmKFn5tfS3GVgyeB63LC/2jD0hzuAbwtrDOXfThy8fulG37Dn2XF1ud5ULIUSVb6C7ZHjX55R62KsrCllhN/djv1aUi3LQaMVQHv8EZRbwZKmNcMWEiL0b+d+WTuDhGU/Q1aEntrPlvZihK2Hcqh0YkQ2EcM7yLphsv0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1787511537; c=relaxed/simple;
	bh=34K/FoU7abAOYLlPQo+u98BXpk6bD/cNXKkoSIw24xY=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=fTYIDPUCFNmfjLTRYH+H/PRUyjPfZ2mvTs7EpWrfbOXTWrEL6oOpYFbmMUQUoTACixXnoY0EiqO++72LbbFmCErXye+Tg857c/N7TWS4otzAbZrBBVCru46wJOpK0kd4ZIqCgtEbC1RVNDW5xeopWBUK5XXV/IzV/ukRK9/ecuQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=EAtKdxNd; dkim=pass (2048-bit key) header.d=redhat.com header.i=@redhat.com header.b=m4F5QXUa; arc=none smtp.client-ip=170.10.133.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="EAtKdxNd";
	dkim=pass (2048-bit key) header.d=redhat.com header.i=@redhat.com header.b="m4F5QXUa"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1787511535;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=MsXHiYkvLJ5Dfkmh4RbCEqIEWI8MfAZu25u27dTcaQk=;
	b=EAtKdxNd2umX9+4DQPFYD82Dm/+Lj1mwu0IJkOL33+smC16DzJ8zzmsZltpZx/lxgOcpz/
	COeII2LTeSy5L38jsSE/JvjD8ucfuEK0dircdVgFnmgYeGrS3lGBcMsvmoLDf5dz/UtbPr
	CaiipvF0nrHUx9+DCc+ZcJYMD3KYriY=
Received: from mail-ot1-f69.google.com (mail-ot1-f69.google.com
 [209.85.210.69]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-8-s_xFcDEXPB6yX10iJ3Su1g-1; Sun, 23 Aug 2026 14:58:52 -0400
X-MC-Unique: s_xFcDEXPB6yX10iJ3Su1g-1
X-Mimecast-MFC-AGG-ID: s_xFcDEXPB6yX10iJ3Su1g_1787511532
Received: by mail-ot1-f69.google.com with SMTP id 46e09a7af769-7eb641eaf5eso5375719a34.1
        for <stable@vger.kernel.org>; Sun, 23 Aug 2026 11:58:52 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=redhat.com; s=google; t=1787511532; x=1788116332; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=MsXHiYkvLJ5Dfkmh4RbCEqIEWI8MfAZu25u27dTcaQk=;
        b=m4F5QXUaoYegkjQ8ZC53OzDS+SnoON7wOW3DM1Lj/xoR7TMULb4QkrQP6whDnEEzWh
         tOAk4p8XBPHtufjK0xiaEqcB89RL3s+3YPKRFxjGluwL8FPPm/jfihCFG1lXDw7TKtVt
         e/gOFRu71Ob/t++EVhVjafzFi01gV3uDG1tYA4fcJgQvTNYr2E+ffLJcfO1pnvfEm2ci
         BW/9h5RTiI5cyNTuD2sHGjtbLLyGlCbgmoxeTVpJSnxZvavV4xkvFqmKbUemNc7vbyQR
         oZo5ByKY5rZ2IZqJOutdUyjbYIsNiwgKnG4nBIXs/W4d6NZ6Y8Dq/MMMNNBCFJ3WZclP
         8NBw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1787511532; x=1788116332;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to:content-type;
        bh=MsXHiYkvLJ5Dfkmh4RbCEqIEWI8MfAZu25u27dTcaQk=;
        b=W2kPb8QiOhpK3OZvLxn2IG89pZsNJjOe9MDg9/5KQIdHYjxkqrirSy2JoAtGz9xpdY
         IsfBD1EFWv+HgrJ4RsL/aIWiKGxnn5KSh6NaylUD6trGN2lh61r/iG+mtZ6IzFd5dl5e
         JX/vTUtpdJ9KFhTBWh4f1o8cpkUgfFTDlkPSLpN5hPTAiulVU4W5A6JXnt4fMcQ/sWr5
         njnoy6IP5I+NTD/vUxwRpkZyIMHR6jIelVTjQH6agYmfFkZRXDzoS/5inGzOs6Hn08Em
         3ZonzALR5BhOjwZzHpacIwE+q/c94S++C3yGPV7xa+OpYc9clsjWkpUmJHq//iDqTmkK
         ctqQ==
X-Forwarded-Encrypted: i=1; AHgh+Rqsu0lSIY2Y2nSu2gQ/vq3mCoAiWZ6OBa1+ruKMUMd29xM0YH9TJh5+zghPidQDsCE5m3IZ9kQ=@vger.kernel.org
X-Gm-Message-State: AFuF++nVN4PyTf8v7xiyuII0Hcmvpdmw7+e62CpSv8alIDAGLZo0NpB+
	JkM/2NrTSfcc4SHfUEREV16vVRfmRKc4vnnc9naBL9kwEWLJmMMHtLZgXbv61usljLUlAb8ZmHU
	wHnYO2TxgbbkW56ybexHc5bn3F2Y+U3QD275WJ+yoDSSzn8yMWQ1WgczUuQ1LgRV6KA==
X-Gm-Gg: AR+sD11hr0Y0SjkdhV0E0mDRyfmDwm+aFO1CLhNHM2j6znvHcZNZtKDV45GhL8OqJBS
	i5dJKgBkXEg7Y7EGz1QB7P8g9lceTwzvQMOi/Xq47QcXCB1jfUSklPl/+v3yWqIDg0yOBQa3OfU
	sO1iqq0g7jnDp+OGjpciHGvZT3mdPhZB78x57BViuZtGR6ofMP6h1Ls4jBPnWC5CaSkHEmhHk9Z
	B8VhzyTdoZw7tX2+Pzw6txS6ZsPVOIOPYSPAVFpBzXfRrD7cq8sqAgCGu5aCuvH0F21Bx97qp0E
	c3GauHlZnXbKFwVuA0BSKFLLYQhVeCk+PHxliEYhHdTQEaoGngeKtpcXrc1Ro7JtVh95xRi6YLD
	YsjFZyWtPROGandNqHwmdJVHEBbtxQuH7XSObtfTrfvOA+YVeb761GELVfzPQPscijA==
X-Received: by 2002:a05:6830:6aa1:b0:7e6:e385:4c1e with SMTP id 46e09a7af769-7f461311b5fmr23973820a34.4.1787511531933;
        Sun, 23 Aug 2026 11:58:51 -0700 (PDT)
X-Received: by 2002:a05:6830:6aa1:b0:7e6:e385:4c1e with SMTP id 46e09a7af769-7f461311b5fmr23973794a34.4.1787511531571;
        Sun, 23 Aug 2026 11:58:51 -0700 (PDT)
Received: from bearskin.sorenson.redhat.com.com (c-98-227-24-213.hsd1.il.comcast.net. [98.227.24.213])
        by smtp.gmail.com with ESMTPSA id 46e09a7af769-7f48fb1db63sm2518710a34.12.2026.08.23.11.58.50
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 23 Aug 2026 11:58:50 -0700 (PDT)
From: Frank Sorenson <sorenson@redhat.com>
To: linux-cifs@vger.kernel.org
Cc: pc@manguebit.org,
	linkinjeon@kernel.org,
	stable@vger.kernel.org
Subject: [PATCH 10/11] smb: client: fix incomplete bounds check on reparse buffer in cifs_query_reparse_point()
Date: Sun, 23 Aug 2026 13:58:06 -0500
Message-ID: <20260823185807.3115901-11-sorenson@redhat.com>
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

The start >= end check before casting to struct reparse_data_buffer *
ensures the pointer is in range but not that end - start >= sizeof(*buf).
A server-supplied DataOffset leaving fewer than 8 bytes passes the check
but allows OOB reads of ReparseTag and ReparseDataLength.

Fold the minimum-size check into the existing condition using `end`.

Fixes: c13b779d26b3 ("cifs: Fix validation of SMB1 query reparse point response")
Cc: stable@vger.kernel.org
Signed-off-by: Frank Sorenson <sorenson@redhat.com>
---
 fs/smb/client/cifssmb.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/fs/smb/client/cifssmb.c b/fs/smb/client/cifssmb.c
index f5aad5f61dce..acb533383a3e 100644
--- a/fs/smb/client/cifssmb.c
+++ b/fs/smb/client/cifssmb.c
@@ -3064,7 +3064,7 @@ int cifs_query_reparse_point(const unsigned int xid,
 
 	end = 2 + get_bcc(&io_rsp->hdr) + (__u8 *)&io_rsp->ByteCount;
 	start = (__u8 *)&io_rsp->hdr.Protocol + data_offset;
-	if (start >= end) {
+	if (start >= end || (size_t)(end - start) < sizeof(*buf)) {
 		rc = smb_EIO2(smb_eio_trace_qreparse_data_area,
 			      (unsigned long)start - (unsigned long)io_rsp,
 			      (unsigned long)end - (unsigned long)io_rsp);
-- 
2.55.0

