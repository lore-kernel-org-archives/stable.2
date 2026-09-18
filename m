Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C96552D3EEB
	for <stable@vger.kernel.org>; Fri, 18 Sep 2026 00:33:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.129.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1789691623; cv=none; b=fK+mINfIhoDJmHsALVmD89KdI+vBcn8YLsoMVfYGEYS78xE8BNTd2E9breolvADGTOvzmBucjLGoVo0FjIjzD1+GeWyLrvpfPxM3ih00FoGBSruQa4OZtlD6RzH/9eoBqUGEvXOe+uZnhP4fxzX2vaK9Br8QYnj5vvE5TVnzMxY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1789691623; c=relaxed/simple;
	bh=OaRiEJu4atHniZ69WA7py5r58HEAXTPcIoVxpK3a2d0=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=uxtQ1GqusQdzaBO/3kZBmYSRIR2tNJdiZ+aTGHbUzqN9P6xMvb6QGKkWSaJUlqMf+neOB0xvlwgiyGJL5URqHsUDyt35W9CXQnlzi9uJ+SHjGsKQO37MSnKL4lzv3WTP6HITNLO+XtIFudMyKaJ98Y4ZbBK6zZh+LfqMUZVh1KE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=e1EuvSy9; dkim=pass (2048-bit key) header.d=redhat.com header.i=@redhat.com header.b=IUEYkSf9; arc=none smtp.client-ip=170.10.129.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="e1EuvSy9";
	dkim=pass (2048-bit key) header.d=redhat.com header.i=@redhat.com header.b="IUEYkSf9"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1789691620;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding;
	bh=Mr7JPQ7cAKM9KbsSYSken92+dByUvyo6IiwGLWbzzyk=;
	b=e1EuvSy9GjZkA0Vyf+4izFN/Sx0SZitjqzEJq3wH4/zx3Es6TfACpdsDfKreExH8TtokZJ
	speigz2cVyQtrTM2cWBUVbr+i8REQ8oGrz+JFhcTty3UKmRAk1wzj3iJ13b9fWtBy4/CBq
	HutPJFBviER+xKywZQPrv9xtnhZaHUc=
Received: from mail-qt1-f199.google.com (mail-qt1-f199.google.com
 [209.85.160.199]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-121-82ZjstcNO6u6yH9oClqGxA-1; Thu, 17 Sep 2026 20:33:32 -0400
X-MC-Unique: 82ZjstcNO6u6yH9oClqGxA-1
X-Mimecast-MFC-AGG-ID: 82ZjstcNO6u6yH9oClqGxA_1789691611
Received: by mail-qt1-f199.google.com with SMTP id d75a77b69052e-51bf321d786so1760621cf.1
        for <stable@vger.kernel.org>; Thu, 17 Sep 2026 17:33:31 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=redhat.com; s=google; t=1789691611; x=1790296411; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to:content-type;
        bh=Mr7JPQ7cAKM9KbsSYSken92+dByUvyo6IiwGLWbzzyk=;
        b=IUEYkSf9mVdLPfvSbbjMzKOxYBF29C4H6wxSShDl9OMuQI4Lp5kM2gvy/Q0uhxWcYN
         r9Ifio+xWwJbi+ealOKdJj4fDDeRrVGLx+W557VVi0MbE3gJhNqA93dpQMswaWnpUrdT
         OlrsvPxFpJ64cf5bHqP9Qr6Z6W1pfP1YHv3ZMwznoAfRzqwPneq0VViDQlkQP1E5Xid9
         fica6h7WYLV6TiPgnQVRyUVcrxcIq63oEAnFBOvwBMUyj4LO6InoSOgadUYMoga5S6oR
         Y+z9ll8FNma9i8zFIvXgQABXfax+g+ZpCDSVd/MK8ErhSRa24VL65+k1GpGqeTra0XOy
         9mLA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1789691611; x=1790296411;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=Mr7JPQ7cAKM9KbsSYSken92+dByUvyo6IiwGLWbzzyk=;
        b=p/suCqPR8RoadocngPpChDBIzQ2CNKAA6xCuTLEYSRCpyEuO6im/Z0Ic2Xws2CKWr4
         pUZczdapuzXi7Dgh9vNMWVFmgyss3pJjs3GbnuBqXMboH27pXXKOrzPnPP85+p0HKxja
         89OP7wWxTPBaUPi+a/8AzlFKIhXP+vJUriG4v9RWgD+p85jtk0GUtQrWnabrwNq7GZjM
         VFvIxxb0gRvxdJ7Ma0HbQ+4nxC9R9ougS5E/0QCGPHg3bZqtTxDB9xViV08VPdnuoNpd
         MqOF/my+RTyEv/dOTW/Uvo6TTwCApLPVMQ8d8e66tZb9PRxFAswd4avdGTXNVBe2Ndn+
         cYBw==
X-Forwarded-Encrypted: i=1; AKwUvByOBeJubpawJ8h4PaX55GTNhi52CyCe1uH4cW3P2Ymv6lKQmgNXQI9ylaGNgZvcRpIozhoSJ6c=@vger.kernel.org
X-Gm-Message-State: AFuF++njdd2xDKfRfQgY0MMZA4Pl9n+2Ud8JuJEU8iawwr7wZBWWAxyk
	ZwXMfk8mj9V+8AJvYmzN40PmhTtQWb+6srCZJgqeGIJY4JX12DmfGMAe7Dl2hmROwXVa5o5CgNg
	1vr24KoX+gTJ7SS1D2RfJhkMLoBMPchQNi85BVO9oIoYvzsE4QZ1yPGGxbzXdSXJ7Fg==
X-Gm-Gg: AYBFou0EIaPNl742MetzgQW3VoVKjRnh/vXTskaywOjAUShLY+3oIw2D0BmrCZdkCaa
	j6OgrPF7MXsHNgJwKyULGzJZaa0GqW8/3napwGDch1t13HzEWcrsbYQsEAF0dcstfDpy/xZRcx3
	VsR+CY56g2stdh5SWGQpu2+zjb2IogqlT32ZiltXKj7fobG7gx5gsqzuhnvadgTYItEYwa50dcP
	we2evEadJaEjUgYxp+9b7RfVTBIt5S6FPvVr1zZcambI5QDh0Cqgx8hmZN0JPXSAjGJAtpLXauv
	fnjtLlSrbaL4Pp6IJiVuP0gzb4ivgBzgZw1rewPUA2XCdQWwcFmSRj97GK+67jroYu3KgEkC1FA
	gKq9fTxVokjZ6C2U4MNvGlmAgS8QOyczTU60iHx+xnDZ77XkyRqgNimmX4Fax+U4RSQ==
X-Received: by 2002:a05:622a:1648:b0:530:b2e1:8e42 with SMTP id d75a77b69052e-5329e512f81mr15558121cf.61.1789691611300;
        Thu, 17 Sep 2026 17:33:31 -0700 (PDT)
X-Received: by 2002:a05:622a:1648:b0:530:b2e1:8e42 with SMTP id d75a77b69052e-5329e512f81mr15557661cf.61.1789691610776;
        Thu, 17 Sep 2026 17:33:30 -0700 (PDT)
Received: from bearskin.sorenson.redhat.com.com (c-98-227-24-213.hsd1.il.comcast.net. [98.227.24.213])
        by smtp.gmail.com with ESMTPSA id d75a77b69052e-532a19d261asm729761cf.18.2026.09.17.17.33.29
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 17 Sep 2026 17:33:29 -0700 (PDT)
From: Frank Sorenson <sorenson@redhat.com>
To: linux-cifs@vger.kernel.org,
	pc@manguebit.org
Cc: linkinjeon@kernel.org,
	stable@vger.kernel.org
Subject: [PATCH] smb: client: fix potential use-after-free with TCP_Server_Info->hostname
Date: Thu, 17 Sep 2026 19:33:19 -0500
Message-ID: <20260918003327.2539470-1-sorenson@redhat.com>
X-Mailer: git-send-email 2.55.0
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

The TCP_Server_Info->hostname pointer may be updated during a reconnect
event. Accessing ses->server->hostname outside of the srv_lock is
unsafe and can lead to a use-after-free if another thread reallocates
the hostname string.

Fix this by replacing instances of cifs_dbg() that print the hostname
with cifs_server_dbg() across multiple files (smb2ops.c, sess.c, and
smb2pdu.c).  cifs_server_dbg() correctly acquires the srv_lock before
printing and standardizes the output by prepending the server hostname
to the message.

Fixes: 4659f01e3cd9 ("smb3: do not log confusing message when server returns no network interfaces")
Fixes: a6d8fb54a515 ("cifs: distribute channels across interfaces based on speed")
Fixes: f591062bdbf4 ("cifs: handle servers that still advertise multichannel after disabling")
Cc: stable@vger.kernel.org
Signed-off-by: Frank Sorenson <sorenson@redhat.com>
---
 fs/smb/client/sess.c    | 5 ++---
 fs/smb/client/smb2ops.c | 7 +++----
 fs/smb/client/smb2pdu.c | 5 ++---
 3 files changed, 7 insertions(+), 10 deletions(-)

diff --git a/fs/smb/client/sess.c b/fs/smb/client/sess.c
index e095f41b5882..5c2c9cabf7ef 100644
--- a/fs/smb/client/sess.c
+++ b/fs/smb/client/sess.c
@@ -192,8 +192,7 @@ int cifs_try_adding_channels(struct cifs_ses *ses)
 		spin_lock(&ses->iface_lock);
 		if (!ses->iface_count) {
 			spin_unlock(&ses->iface_lock);
-			cifs_dbg(ONCE, "server %s does not advertise interfaces\n",
-				      ses->server->hostname);
+			cifs_server_dbg(ONCE, "server does not advertise interfaces\n");
 			break;
 		}
 
@@ -395,7 +394,7 @@ cifs_chan_update_iface(struct cifs_ses *ses, struct TCP_Server_Info *server)
 	spin_lock(&ses->iface_lock);
 	if (!ses->iface_count) {
 		spin_unlock(&ses->iface_lock);
-		cifs_dbg(ONCE, "server %s does not advertise interfaces\n", ses->server->hostname);
+		cifs_server_dbg(ONCE, "server does not advertise interfaces\n");
 		return;
 	}
 
diff --git a/fs/smb/client/smb2ops.c b/fs/smb/client/smb2ops.c
index 3464470d3297..08ea340f01b6 100644
--- a/fs/smb/client/smb2ops.c
+++ b/fs/smb/client/smb2ops.c
@@ -632,6 +632,7 @@ static int
 parse_server_interfaces(struct network_interface_info_ioctl_rsp *buf,
 			size_t buf_len, struct cifs_ses *ses, bool in_mount)
 {
+	struct TCP_Server_Info *server = ses->server;
 	struct network_interface_info_ioctl_rsp *p;
 	struct sockaddr_in *addr4;
 	struct sockaddr_in6 *addr6;
@@ -666,10 +667,8 @@ parse_server_interfaces(struct network_interface_info_ioctl_rsp *buf,
 	if (bytes_left == 0) {
 		/* avoid spamming logs every 10 minutes, so log only in mount */
 		if ((ses->chan_max > 1) && in_mount)
-			cifs_dbg(VFS,
-				 "multichannel not available\n"
-				 "Empty network interface list returned by server %s\n",
-				 ses->server->hostname);
+			cifs_server_dbg(VFS,
+					"multichannel not available - Empty network interface list returned by server\n");
 		rc = -EOPNOTSUPP;
 		goto out;
 	}
diff --git a/fs/smb/client/smb2pdu.c b/fs/smb/client/smb2pdu.c
index dea05aeb53a1..bb30cfa156aa 100644
--- a/fs/smb/client/smb2pdu.c
+++ b/fs/smb/client/smb2pdu.c
@@ -173,9 +173,8 @@ cifs_chan_skip_or_disable(struct cifs_ses *ses,
 	unsigned int chan_index;
 
 	if (SERVER_IS_CHAN(server)) {
-		cifs_dbg(VFS,
-			"server %s does not support multichannel anymore. Skip secondary channel\n",
-			 ses->server->hostname);
+		cifs_server_dbg(VFS,
+				"server does not support multichannel anymore. Skip secondary channel\n");
 
 		spin_lock(&ses->chan_lock);
 		chan_index = cifs_ses_get_chan_index(ses, server);
-- 
2.55.0

