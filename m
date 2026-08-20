Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 446D73D9DAC
	for <stable@vger.kernel.org>; Thu, 20 Aug 2026 21:22:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.129.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1787260942; cv=none; b=hGdy9zRGbqPwWFo3jl9NrLaP1SnOLTwCbbrU2LGTPIYKH4SW/2C2sftlK7olz51spsRrqk9Eu4XvXAYqutaTYpWvcIdq07Ce/tJ7RoEI/9cX07/0XxOLaSqo+NjDQ8M4um5strdAro3mpZUvqM5UDSRJv/oobP4YVrGBPjQL2+M=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1787260942; c=relaxed/simple;
	bh=53slcbkbEBL8Rm79rTcFv4mLcds1G4ZiVKbzMQvXQmE=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=umZ+z3sd5CZged7u/ksmHvTtg0JCVoP8ZAxDG2G0Ym0NV5I6/q+g9xDJSY86nqphx4UlaISPaWjDdK38Bu1sNGlh2IlFTqyNns6qTQDHkdTdXV4LZno4jzJIshD284nY9cmnJpM4jCkif0qVB0zQBrmtmj9LsVYCSGauYtUpfaU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=K8yehdOv; dkim=pass (2048-bit key) header.d=redhat.com header.i=@redhat.com header.b=klznEBpj; arc=none smtp.client-ip=170.10.129.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="K8yehdOv";
	dkim=pass (2048-bit key) header.d=redhat.com header.i=@redhat.com header.b="klznEBpj"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1787260940;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding;
	bh=a6ae+9Zx+uC5nDUKbM59YHQRGfjeCrCTMYZZummnApE=;
	b=K8yehdOvMNz/T1BJNI1robumhzkpftHqEmJN8cWPc/kmUrB65FB0tC3i1c/QUkfz8jZSYk
	dbvdmbVHsGeEki00gLXZyww9jt+t3CQ426ykzIhBoXBrWA9h1+eF1Mv7NdPYMmsh9JGHiQ
	MMpG85pk7pCjtmsVvIUYBwDneB9QrzQ=
Received: from mail-ot1-f70.google.com (mail-ot1-f70.google.com
 [209.85.210.70]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-629-MABBSy1lPLi26y-YU2Bq8g-1; Thu, 20 Aug 2026 17:22:19 -0400
X-MC-Unique: MABBSy1lPLi26y-YU2Bq8g-1
X-Mimecast-MFC-AGG-ID: MABBSy1lPLi26y-YU2Bq8g_1787260938
Received: by mail-ot1-f70.google.com with SMTP id 46e09a7af769-7f4071ad0d0so502269a34.2
        for <stable@vger.kernel.org>; Thu, 20 Aug 2026 14:22:19 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=redhat.com; s=google; t=1787260938; x=1787865738; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to:content-type;
        bh=a6ae+9Zx+uC5nDUKbM59YHQRGfjeCrCTMYZZummnApE=;
        b=klznEBpjtrK/IY6Y5DjDrhrawRU6wNSPpfw0XNwWzyqmSHNKN5cWHJdnPfP1Us6s1/
         Ziz9noOZxvXG23Diq1m30Hyj0X4Bln0VHs3Mhqwq/mUm4k1ImNbsFFpDZpPsgfygRYEh
         YUBUsC1AvIrv615zAl8lxL6MncxEMWAuSKCyxCYut/kYgQUxbuMjeoWaU9mjzhVjf3Ku
         VCwV/+1dePwWrN5Ry9zREAMI5STAx3kbHbVmp34u3TnwQWzjv7eOwt69MkfllVcH1ETA
         tO1IelFKZX3V939XoAFCzfVX4bCqdEZtmcyc2Y1JWbuNDviIRA/n6JrqxKrpAvMtHWBs
         WOMw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1787260938; x=1787865738;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=a6ae+9Zx+uC5nDUKbM59YHQRGfjeCrCTMYZZummnApE=;
        b=pXx+1P1aVduaqhssS16IS9YxiQ+KjzOX7JKV55MDSIGVC/rDLpc/KED8TTdWDzgZHM
         ZJTp2uzqjx6h3v7ljPibuCYSS+WcrQdRW/lOmUNXsqnPCpwW0RZBG1/qT0r99m/qaU53
         Nikf10YJAiffuazTGQeBO1/pdwoQbHfBNXeoW533JCUS2cdGNDSCqP27tON3FFGwSX0v
         YYHDAJbwErNM40eCpm4gAJ03cC21QkzNtB5CeZmnI6sk9k4+qLtDqaaK2mEI7XeScboQ
         I2FbwrT6XP6twX4ijP4QDB5H13dO9JECw4LO0Zu2Lf4WHRNCwDhCulwl84/hagRLoSg5
         fOEA==
X-Forwarded-Encrypted: i=1; AHgh+RqurwOlyrhqv9VLvsFcapf5z3Jo6NOAahm0nRE4SnepDOIdGomHLFaKpdQfVE311jHU2I/Qxfk=@vger.kernel.org
X-Gm-Message-State: AOJu0Yxlu8eRi/zUUFdDTO00fvFjeEumJqlgtgIo1qrJaJKroDZicwul
	necLDIQDFwHo5aiSmLZftVXk+eqI3wEPpN2m6ZfTEoYKZ9ig7ngoFetoeKVviqb1Fq5lF7OkEuQ
	Y7rXp6I53RaP1o+pl3tp6H6li5oFpth8xY1dVlteuAINtBk6giv1bAfxk8Q==
X-Gm-Gg: AR+sD10ASPhhz51eIj8VpoyagUnKL2+Y7WnAvb70JfZDaALCoZz+mJ3svMR/rgzAjHm
	33RsMTyQSHrTRc8ESNsuuGzOmlRn2SK7qzWZfX/JQP60aJpBNUJTOwpi5BXeNmiLXHlL+wuv5n8
	7aN2M0YIUgRFsIZQycbiNPSSZxFm0EqauJ3VMhSRDSHcE2n4/NsMeCKBGtjOI11p0REeKSZgGqy
	sh9Y0VzX8pDUJxRkDA8cszs/NxoHSDz6YhEen7o0M8NnN+vBAgBdfY0iQluzCIQo6ANnFacpezD
	xm8rIqxLvPokA9om/hYuaZZQ6ZpVmjgOdn9aBbHEB5gVVlAc8FbOGv6EENpIlTJ89WUwG/BtU0/
	Bdb6yNNHIwKSvPskljwk2QGKJu/IHhLBdIf79e4BplLBebQthPtBZzrhpn/GdG78bpQ==
X-Received: by 2002:a05:6830:6187:b0:7e9:e257:81cb with SMTP id 46e09a7af769-7f461845b89mr1875203a34.7.1787260938417;
        Thu, 20 Aug 2026 14:22:18 -0700 (PDT)
X-Received: by 2002:a05:6830:6187:b0:7e9:e257:81cb with SMTP id 46e09a7af769-7f461845b89mr1874530a34.7.1787260933167;
        Thu, 20 Aug 2026 14:22:13 -0700 (PDT)
Received: from bearskin.sorenson.redhat.com.com (c-98-227-24-213.hsd1.il.comcast.net. [98.227.24.213])
        by smtp.gmail.com with ESMTPSA id 46e09a7af769-7f440023019sm5816925a34.15.2026.08.20.14.22.12
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 20 Aug 2026 14:22:12 -0700 (PDT)
From: Frank Sorenson <sorenson@redhat.com>
To: linux-cifs@vger.kernel.org
Cc: pc@manguebit.org,
	linkinjeon@kernel.org,
	stable@vger.kernel.org
Subject: [PATCH] smb: client: fix copy-paste error in WSL EA length accounting for $LXDEV
Date: Thu, 20 Aug 2026 16:22:10 -0500
Message-ID: <20260820212210.1475817-1-sorenson@redhat.com>
X-Mailer: git-send-email 2.55.0
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

The LXDEV block in cifs_query_path_info() uses SMB2_WSL_XATTR_MODE_SIZE
(4) instead of SMB2_WSL_XATTR_DEV_SIZE (8), undercounting eas_len by 4
bytes per $LXDEV EA.

eas_len is used only as a zero/non-zero presence flag so there is no
current functional impact, but the value is incorrect and misleading.

Fixes: 97db41604555 ("smb: client: parse uid, gid, mode and dev from WSL reparse points")
Cc: stable@vger.kernel.org
Cc: Paulo Alcantara <pc@manguebit.org>
Signed-off-by: Frank Sorenson <sorenson@redhat.com>
---
 fs/smb/client/smb1ops.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/fs/smb/client/smb1ops.c b/fs/smb/client/smb1ops.c
index 7e2b29060f51..3ac4126267f6 100644
--- a/fs/smb/client/smb1ops.c
+++ b/fs/smb/client/smb1ops.c
@@ -721,7 +721,7 @@ static int cifs_query_path_info(const unsigned int xid,
 			ea->ea_value_length = cpu_to_le16(SMB2_WSL_XATTR_DEV_SIZE);
 			memcpy(&ea->ea_data[0], SMB2_WSL_XATTR_DEV, SMB2_WSL_XATTR_NAME_LEN + 1);
 			data->wsl.eas_len += ALIGN(sizeof(*ea) + SMB2_WSL_XATTR_NAME_LEN + 1 +
-						   SMB2_WSL_XATTR_MODE_SIZE, 4);
+						   SMB2_WSL_XATTR_DEV_SIZE, 4);
 			rc = 0;
 		} else if (rc >= 0) {
 			/* It is an error if EA $LXDEV has wrong size. */
-- 
2.55.0

