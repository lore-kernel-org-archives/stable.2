Received: from mail-wm1-f41.google.com (mail-wm1-f41.google.com [209.85.128.41])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4677B30DD11
	for <stable@vger.kernel.org>; Thu, 18 Jun 2026 20:35:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.41
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1781814942; cv=none; b=gcKZiIRRzuQXM9or6nvz3oVV3K7Y1Jn0P+gve9ULqHTRHA9d9x5NZxcYGtvOYzQS1b5Z7FnZ3tZpy93Sbq/OoBB/uFPY2vhn0fiNBxfLKkUs3FsYgAHVHXDbKlY9urzKuVGOG2VYQoJz00T8T3Sdcfqe/FVxjK/Kuu21N3gWbog=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1781814942; c=relaxed/simple;
	bh=rlNzpkvf5TaB1kuI5D5dZfuSx58VuZ5dYBJMUFiTcbk=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=I3Ggh7eR2IccboKCwLIDfySRLhsdJKf1rXmBJtF6mdawUrV4DJ3VhbmvgNvj33ymiyYck75lH9k+7ncJym2PgaRgRFRyRDIS/ofw5n7xpQva3RzJDbWtc845nwzypGp03m48RBToWUeRkM1SNE8/L0/LnYt+Gjv0+S3Ft59R+Fk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=suse.com; spf=pass smtp.mailfrom=suse.com; dkim=pass (2048-bit key) header.d=suse.com header.i=@suse.com header.b=M7qbtCCX; arc=none smtp.client-ip=209.85.128.41
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=suse.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=suse.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=suse.com header.i=@suse.com header.b="M7qbtCCX"
Received: by mail-wm1-f41.google.com with SMTP id 5b1f17b1804b1-490aebf33e9so6629695e9.3
        for <stable@vger.kernel.org>; Thu, 18 Jun 2026 13:35:41 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=suse.com; s=google; t=1781814940; x=1782419740; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=+YhBDKclcp9zxleiGadSELRGFuYTxQeocDmhDejXUgo=;
        b=M7qbtCCXVMwhNnn/9u0yEmYnVUABgO6Ld/NnhCubfVz1Xi47yZB8aYe7OLnB+UuX5D
         jQCHk+RpxniS+2VG9VqjJchW9xACvqBwpiE0Ey0tlnoMctELyAO9SXeJ2aZAg9eIrkA4
         d2rSHAPnsvhnZ//ZS4oRz7IsiSuwbkeEy2loqnF6arND/2RowWxcwowFEV5MMiiPjWH6
         eCv2rxSaQcHx4qLsZNsAB+Jp9xwOxaRisFzKkz0dD2ufcapNpL71jHJKI/VvxNe8xjtL
         //oo4dSqA5yUBiFWnAHJHxkqMftVyWRvTXMSdy0ulsyVwq0tnsako7J4Sa4T54dT7XPP
         5Dlw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1781814940; x=1782419740;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=+YhBDKclcp9zxleiGadSELRGFuYTxQeocDmhDejXUgo=;
        b=Zs+2+qz4d5q1I/7i/tcJPPdzO38cLv9b7Ip2GD27BsH95sz5y9F3imPeqQQKSylzoH
         HdnVhM/F8HEJKZ5ShvvLhpHGgUETenlAjKwec3B8V4QaXlXYYo/JltrZP57i9RLSv6oZ
         hQPKm4u+QWNIJaMQHaFigyLyDF1XLGRFfUSBUb0ZUuw6BgaXeWnbd9Oz7owR3HiUGyRx
         MY/D4398Gc8gcmGOGNrHiVR9mhZJbuNVAHmJWEMig6lv/NukagsPI6d2S5EZ2Xsc6owp
         qNJ3hB6Ll+q7o6NZr+HEH6RKYm/jpila+7DizQfpqJ3aflnxxxaOWm9niD8i/oGQ3j+c
         pynA==
X-Forwarded-Encrypted: i=1; AFNElJ/asPf23g6wKrR0+Bb8DLdBLf05jOyGgAb+MvpSE5MuNxgo3NNoomrb25rdmchOlgBt+mbVFQQ=@vger.kernel.org
X-Gm-Message-State: AOJu0YxmR4szPbnTZFgmdXDPzOtFakYOxPOEtx+f9KZz/xzDpxXujL+3
	mLQAboDF9Pt0wbM10Cj0jI1AX2zVoaxgtVWXlVWlTMlVBn6vRa0r7xLwAkn8dI8tzvY=
X-Gm-Gg: AfdE7cnW8ASCC6J3xtCLEEzZ0PLh3hOnoxki1s+swwK8Bw855SexMNfYfzjg93YGuKb
	xFt+Vp30m6xqIi47mtXq5ARBsRnzPtj5edjumN/T9KUTOtaiSOWxecIfYZXjO2VZC6W1S+D8bfX
	Pqd4J6md1XYS2JXaq62hYPmm0L9eAhxJsrKr5KJXLrcNXwVcM8FEhs1yiC4j4EEjG6gE8lGR3ca
	Nlf+WdAkHeaOpOva2QlOX4RCTPN0m+RVDtVRpAFi4x4pIuKZyJDimu/exsJXPpQVojJppETp20b
	nWs4B4WyiJAT33vmL6y5ZL5skoFpYD7w9CDoqa+6f5tZ2zXha6LFUS2nQvcaz5isIMlQexjxrz2
	HKDYqO9ZRKGEC1XUcGOQK7zvc+MmUijZLpCPIsFlZrcOTF6BJ1nDQnvcSGEqG7EY82HuXPHQW9V
	2t/MKBmP0Q+flpo2qyeO8g
X-Received: by 2002:a05:600c:5784:b0:492:3778:d452 with SMTP id 5b1f17b1804b1-49240e42865mr6663165e9.14.1781814939569;
        Thu, 18 Jun 2026 13:35:39 -0700 (PDT)
Received: from precision ([2804:7f0:6401:b508:d1d9:f1f3:d91c:79af])
        by smtp.gmail.com with ESMTPSA id a1e0cc1a2514c-966fc32849fsm439109241.5.2026.06.18.13.35.36
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 18 Jun 2026 13:35:38 -0700 (PDT)
From: Henrique Carvalho <henrique.carvalho@suse.com>
To: sfrench@samba.org
Cc: pc@manguebit.org,
	ronniesahlberg@gmail.com,
	sprasad@microsoft.com,
	tom@talpey.com,
	bharathsm@microsoft.com,
	ematsumiya@suse.de,
	linux-cifs@vger.kernel.org,
	stable@vger.kernel.org
Subject: [PATCH 6/6] smb: client: fix query directory replay double-free
Date: Thu, 18 Jun 2026 17:34:38 -0300
Message-ID: <20260618203438.667881-6-henrique.carvalho@suse.com>
X-Mailer: git-send-email 2.54.0
In-Reply-To: <20260618203438.667881-1-henrique.carvalho@suse.com>
References: <20260618203438.667881-1-henrique.carvalho@suse.com>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

A response-bearing attempt can return a replayable error and free its
response buffer. If SMB2_query_directory_init() fails before the next send,
cleanup retains the previous buffer type and frees that response again.

Reset response bookkeeping before each attempt to prevent the stale free.

Fixes: 4f1fffa23769 ("cifs: commands that are retried should have replay flag set")
Cc: stable@vger.kernel.org
Signed-off-by: Henrique Carvalho <henrique.carvalho@suse.com>
---
 fs/smb/client/smb2pdu.c | 2 ++
 1 file changed, 2 insertions(+)

diff --git a/fs/smb/client/smb2pdu.c b/fs/smb/client/smb2pdu.c
index 7d4b37b776c5..85642ea992d5 100644
--- a/fs/smb/client/smb2pdu.c
+++ b/fs/smb/client/smb2pdu.c
@@ -5720,6 +5720,8 @@ SMB2_query_directory(const unsigned int xid, struct cifs_tcon *tcon,
 
 replay_again:
 	/* reinitialize for possible replay */
+	resp_buftype = CIFS_NO_BUFFER;
+	memset(&rsp_iov, 0, sizeof(rsp_iov));
 	flags = 0;
 	server = cifs_pick_channel(ses);
 
-- 
2.54.0

