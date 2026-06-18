Received: from mail-wm1-f46.google.com (mail-wm1-f46.google.com [209.85.128.46])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 740A1302163
	for <stable@vger.kernel.org>; Thu, 18 Jun 2026 20:35:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.46
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1781814937; cv=none; b=qPeq7JM/hfF9o4vbXXq6lMetoKikKgi2ChNgUcuzi4nRaTR49ZfFqUUwniGE+eO9XW0FZnS3oQHZdfQR3PB35zt8xzCs2KIgsGjxfftakihvIZBbidyt71z7K8YaRZQq9dke0rHEJ9eeg+75q4KccQtHlbqVjfKJG9g/tGk6xE8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1781814937; c=relaxed/simple;
	bh=0IkNhknHyz4mHuG1nCg8NC8U/vDkU9MvLlYtFKktuSw=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=M8BI2Th6QUHMzbQ+Ycvd1kRszSmPinA6wIeLmiYplfTO6/o84C9i7/3YtdRskrCZ/RiL3ZYG4MlsdHsYfzt+faDvZSSCc1cD/mAGll+X/gIz2P6H+gK/QIYO9H/Sh0I1meJ+oU596i6Hm4ksMmCbjT9PTVEhGSMIaNDjHP8ICNs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=suse.com; spf=pass smtp.mailfrom=suse.com; dkim=pass (2048-bit key) header.d=suse.com header.i=@suse.com header.b=LOUSgmzZ; arc=none smtp.client-ip=209.85.128.46
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=suse.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=suse.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=suse.com header.i=@suse.com header.b="LOUSgmzZ"
Received: by mail-wm1-f46.google.com with SMTP id 5b1f17b1804b1-490b64c8311so12237275e9.3
        for <stable@vger.kernel.org>; Thu, 18 Jun 2026 13:35:36 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=suse.com; s=google; t=1781814935; x=1782419735; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=m+j+mSbuQFwug618Cnlh928hf/0zUiXE/zDnbLuqUE4=;
        b=LOUSgmzZKeNrXSmmqr95xc2Gi1wqU4XW+uL6pRDZ5PyUycB6lgoWtqcIBLm2XtnuX5
         fEz2kR3Bmn8HS9fl97KGevhju/vZ/73x4XYGaEYP8y5YKRLXCi1/Azni32ERdIoPnfb5
         qNK5o0oWvwTuJ+vZvnVPO1R1mVuc4CwMXcVIxZ29hms/PP/5qiSc9wN/BoQxOTsj5AEd
         uNGQW5ARR3PiDpvnR3tsLaCIdqSltOcfMOBz7GrLoT+MQbmdDXDAaO6nwc2IJDWKpB8P
         h7zKdJh+1mmDQIudUtzzM0L1RrnaDwRsrCPReUElF/1WfHyuUS8iyjsOh9E8sxNsj3Id
         RRyA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1781814935; x=1782419735;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=m+j+mSbuQFwug618Cnlh928hf/0zUiXE/zDnbLuqUE4=;
        b=K/kiJj1hrrRyCPmfAT4BvnjGNrbt8zAETm7gjL8WIVM4avaDikvsVbiqNSCzW9xK6z
         PIE+g3lo9MsZLmzl8LCh7UCrxg3xZk2s9nUxA4mL8KDB4yC/Kb74sMf738NpBFmYUyWB
         HanN3rm9s3687DoBguwBAscA9jG0y0F85t1AQBAsta03k0FNeJuQ5w0DD3qXFq/1ohh2
         7adsIDG9qKrr+2p4LXOwTnvRaZBPzI9BZMSuvBxD3SwgmvPiBbLFE32vKamvAWEzDT6A
         mvf2H10EeMj176mfCyAz+iBa4eMMFMLdNrBRilOGvp/aQHeXT0Z7R1GDEf8vrLGNJVXA
         /vmw==
X-Forwarded-Encrypted: i=1; AFNElJ99tymNy1pgxkGu6GwP8WfDQSU0T7f5o9i+0lYQmSsNl09uAhyXco66MjtYSbZB//6VIXYPeZQ=@vger.kernel.org
X-Gm-Message-State: AOJu0YyP2EbVqrjMlJa/uur/TBoJPTPTnRVZo5k3sAOB6vNp9mDfUIt8
	v+lzumXzC2knxjMKexulKXuaW4lDHchPj0Q/txTPviBUGg5GzbYDBHJzMQGSfICn46k=
X-Gm-Gg: AfdE7ckfZU1pY2GRwawlnBio8MaxyD0fHnTmhXzsDD0NB2gRF7RmwWMp/U788iMrGHn
	I/Juk9LMcagzmA8zS6boahjA1BMPWwYS49678toveUG1TRKa4YpCgb6NV9gn2KwV+MqX9pF2XxG
	wYppKZziBn3o7EiK2/Rggilmckq2mI1wU90m8PlBdrGNf3vRmVRJRX1B7Ys8eW00gqQIhqX/zHt
	tNNMDqH5/LBlRfhMvqqSvKbB+GHO0G/tphFBwGs5e1XUKiNqk40vsCMWGIYbjraYS7mNzaX7zFP
	PLGigyatlVumvqnbNPZqIgqJW1UqU0M9rl+nKZfosyjHvF0lO1CgJsxz0qj60EY9WZao4oXZsVf
	4KyJmPozxxiv776iY0dlHRtwI9NQ9Vrz+vDQGgieY4/T8chJeg2cYRANl2KT7YtKIpUOcxKn+JU
	Dcr+3XmSTG5oV3lKyyrwJS
X-Received: by 2002:a05:600c:628f:b0:490:bd66:e522 with SMTP id 5b1f17b1804b1-49240e72434mr7528595e9.29.1781814934792;
        Thu, 18 Jun 2026 13:35:34 -0700 (PDT)
Received: from precision ([2804:7f0:6401:b508:d1d9:f1f3:d91c:79af])
        by smtp.gmail.com with ESMTPSA id a1e0cc1a2514c-966fc32849fsm439109241.5.2026.06.18.13.35.31
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 18 Jun 2026 13:35:33 -0700 (PDT)
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
Subject: [PATCH 5/6] smb: client: fix change notify replay double-free
Date: Thu, 18 Jun 2026 17:34:37 -0300
Message-ID: <20260618203438.667881-5-henrique.carvalho@suse.com>
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
response buffer. If SMB2_notify_init() fails before the next send, cleanup
retains the previous buffer type and frees that response again.

Reset response bookkeeping before each attempt to prevent the stale free.

Fixes: 4f1fffa23769 ("cifs: commands that are retried should have replay flag set")
Cc: stable@vger.kernel.org
Signed-off-by: Henrique Carvalho <henrique.carvalho@suse.com>
---
 fs/smb/client/smb2pdu.c | 2 ++
 1 file changed, 2 insertions(+)

diff --git a/fs/smb/client/smb2pdu.c b/fs/smb/client/smb2pdu.c
index 6e6aed87ab0a..7d4b37b776c5 100644
--- a/fs/smb/client/smb2pdu.c
+++ b/fs/smb/client/smb2pdu.c
@@ -4116,6 +4116,8 @@ SMB2_change_notify(const unsigned int xid, struct cifs_tcon *tcon,
 
 replay_again:
 	/* reinitialize for possible replay */
+	resp_buftype = CIFS_NO_BUFFER;
+	memset(&rsp_iov, 0, sizeof(rsp_iov));
 	flags = 0;
 	server = cifs_pick_channel(ses);
 
-- 
2.54.0

