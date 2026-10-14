Received: from mail-pj1-f52.google.com (mail-pj1-f52.google.com [209.85.216.52])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B19593254B8
	for <stable@vger.kernel.org>; Wed, 14 Oct 2026 09:02:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.216.52
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1791968569; cv=none; b=X3H2ylKlqhQqcW4Fxxm6pVThF/ZZqGr3AEf2EksC91NbE08EVPfljhFYqcNSckwMa7PW1KMZey59GSI7h6MgY7e8M8EIGUVAPj1ib23Bhohc2Ud3QOxz22DKvhXlA6CZi3B2PsfZKCx3PaAtiWK+/ZQJlXMsNn6Ooqm3wn6wBHQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1791968569; c=relaxed/simple;
	bh=lHYdUy+fPjbDIamKXXSZVXQStz7GcmUwURwRKXS+W7Q=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=sojanjwPd1WwyOLwMx+zZ0cBMwNfEFo4G5V7dmdpsAJB424jRZ5ZVA3UjTp5s3lwcHThm+5keaZwvUP/vsf0s6KFuOv+C5hhfbxupAifn8JQH/5YVrHM5TmfVO2UjwKr+e1OGuaQHOq+U1G8plvctOOHa9qnqSViPzczdZF9suk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=tC+fjkXX; arc=none smtp.client-ip=209.85.216.52
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="tC+fjkXX"
Received: by mail-pj1-f52.google.com with SMTP id 98e67ed59e1d1-3ab60ff4273so3188903a91.0
        for <stable@vger.kernel.org>; Wed, 14 Oct 2026 02:02:43 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1791968563; x=1792573363; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to:content-type;
        bh=mvGRNBwDPobPO7nwXeOj3RUpnQAXQpmRmyxD4LJ1RXU=;
        b=tC+fjkXXbvq5eJSFTnotBr7+xWNHh3NFqqKKDMkgnpYtgtjeuN20fCst7enm4nyhQD
         zTgbcdEmj2LvoyWiArFQMnWrIR0EL9xM4AMcSiufKSrHgRLXKyAsg7V4nOpspgNGnztt
         gtlYLhScbq+gtrbpNJHVZC2E7V/F73u+REiWxs74rJCRmVDZ7X85cuUD2GVh61diw4aT
         xUJ+xmdFIsfg0zPZYPknJKxY5/sY6R1hgY77XvViR59AsYddICBRsrTzRXFFOU96nndO
         QtCvaRJ/XOCXlEUqdJ7Y/5fNk0nGCgKkMGph11c1RVnF3gxCUeqgVLkJ3fYdtI/z7gn8
         xzvw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1791968563; x=1792573363;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=mvGRNBwDPobPO7nwXeOj3RUpnQAXQpmRmyxD4LJ1RXU=;
        b=xgSzTVWj+NKCdpbJP636Cn1ydEyC63Op/2wIETUJADKh4NsVC+ZU+czAuLhTg8uqSJ
         H15HAyC4Fjqa0eqnEMN8Q+/5asKmX14iPj3ahCeMTJHbYmxa8iVmTckfYhzpTOXaP74D
         HegYlk3zfmf5FWIUo9ifRDn+w/rn9oOP11QTe2VRV3zVHnXdvnKqpeT3vPrpzbfy2Uoi
         eHFeYZw27cXSpwVxeb+3UFG61sja8sK/vlcakLgsn9Bm16bbDSNB175Ux0921ZOFkBKu
         ipJcSGrBWn3bE2Lng61eQ/5uxp77axiyaJmrk0LqBULeLsJO46WBQPyGHiZWKJbzT46C
         syJw==
X-Forwarded-Encrypted: i=1; AKwUvByVmrXY0Epc3WtlzMCU3xYUzeHSBbeptXEcJzLc5RuHnCKrzVub94Pe2vf2id8uvG7MxAz22fo=@vger.kernel.org
X-Gm-Message-State: AFq9FYJVSJmT6o41ilTbRMQe8/daXL9YL645haq1rZAesNFrabaDHShH
	fyG4PNXz2buse4LeDUTMufSpoyPrH4uxTfXCDgZRrSRVURQvGx4cqzIs
X-Gm-Gg: AYBFou1y5EULhYb+Rf7hvfbv4zh3iIH7gR+wS1NcaYQdmn98hN8iV2z0eL/n/xT+vay
	5AU7GSGOKo+dD+ssqD8YL6MYQ1GzFg5DthJm405fIw526hqr+yh8M+2+WBrcUeiqMnyepRzAYru
	s1+vl2BG9dMMXlMnS4Nx0C7Q+OJGikuB9GjDcYWkyQQISTgxArNMeBxIlMa/J47hERDDYnP+vez
	27OLftzKhpNmGhVWZxDUNqsnmyxsjKU73lQNWduu/5yRcSJu1tBxNRyuaaCSUA2tq3huVgbCSMp
	kKQgN6q+KuVXQXeIiLbb/tPDbghMP1Ce/0Cj5+A1KgeI4YQJXP+IkjZDPZ3YfxpW+NxX/gdywLU
	kYB/ItWFADsS8cMHiAEQ6tlAXdG//09LvC0MVgjfLvUhTEHRsNEsCUMOEvHzElVmpwrsLh514qU
	A2FUSgI7VTU5padLUkI33JVv8NXpzKMqEivZBh0mb/gB3LLRj5IWxu+9e9i0K5Pw92bXz6FDVHD
	atl/i0RQTRgY+SBRAInILOwKgk7Xptk/g==
X-Received: by 2002:a17:90b:4b:b0:3ab:1e1c:837f with SMTP id 98e67ed59e1d1-3ab3ac59383mr11813233a91.47.1791968562735;
        Wed, 14 Oct 2026 02:02:42 -0700 (PDT)
Received: from DESKTOP-UCPRL76.localdomain ([113.200.174.120])
        by smtp.gmail.com with ESMTPSA id 98e67ed59e1d1-3ac84150036sm440921a91.17.2026.10.14.02.02.40
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 14 Oct 2026 02:02:42 -0700 (PDT)
From: vienna-0FFH <viennaoffh@gmail.com>
To: Alexander Aring <aahringo@redhat.com>,
	David Teigland <teigland@redhat.com>
Cc: gfs2@lists.linux.dev,
	linux-kernel@vger.kernel.org,
	stable@vger.kernel.org,
	viennaoffh@gmail.com,
	syzbot+04dfbd15d442517e713a@syzkaller.appspotmail.com
Subject: [PATCH] dlm: don't warn when closing a node without a connection
Date: Wed, 14 Oct 2026 17:02:37 +0800
Message-ID: <20261014090237.395-1-viennaoffh@gmail.com>
X-Mailer: git-send-email 2.43.0
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Opening and closing a configfs comm entry without ever configuring an
address for it triggers the following warning:

  mkdir /sys/kernel/config/dlm/cluster
  mkdir /sys/kernel/config/dlm/cluster/comms/1
  rmdir /sys/kernel/config/dlm/cluster/comms/1

  dlm: closing connection to node 1
  ------------[ cut here ]------------
  !con
  WARNING: fs/dlm/lowcomms.c:1455 at dlm_lowcomms_close+0x12d/0x470, CPU#1

Since commit 6f0b0b5d7ae7 ("fs: dlm: remove dlm_node_addrs lookup list")
the lowcomms connection has the same lifetime as the configfs comm
entry, but a connection is only created when an address is configured
via the addr attribute. Removing a comm entry for which no address was
ever set up is valid and the resulting close call has simply nothing
to do, so it must not warn.

Reported-by: syzbot+04dfbd15d442517e713a@syzkaller.appspotmail.com
Closes: https://syzkaller.appspot.com/bug?extid=04dfbd15d442517e713a
Fixes: 6f0b0b5d7ae7 ("fs: dlm: remove dlm_node_addrs lookup list")
Cc: stable@vger.kernel.org
Signed-off-by: vienna-0FFH <viennaoffh@gmail.com>
---
 fs/dlm/lowcomms.c | 6 +++++-
 1 file changed, 5 insertions(+), 1 deletion(-)

diff --git a/fs/dlm/lowcomms.c b/fs/dlm/lowcomms.c
index 2aff1c7..86c7af9 100644
--- a/fs/dlm/lowcomms.c
+++ b/fs/dlm/lowcomms.c
@@ -1452,7 +1452,11 @@ int dlm_lowcomms_close(int nodeid)
 
 	idx = srcu_read_lock(&connections_srcu);
 	con = nodeid2con(nodeid, 0);
-	if (WARN_ON_ONCE(!con)) {
+	/* case of dlm_midcomms_close() for a node which never had an
+	 * address configured, so no connection was ever created and
+	 * there is nothing to close
+	 */
+	if (!con) {
 		srcu_read_unlock(&connections_srcu, idx);
 		return -ENOENT;
 	}
-- 
2.43.0

