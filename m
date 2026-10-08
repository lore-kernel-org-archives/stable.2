Received: from mail-oo2-f8.google.com (mail-oo2-f8.google.com [74.125.231.136])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 06E3F31C567
	for <stable@vger.kernel.org>; Thu,  8 Oct 2026 16:38:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=74.125.231.136
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1791477538; cv=none; b=nrbBXFdC9AcC1f1itMEtHQ0K8I2NwLnX6ELJo2D5nJ7rcDsNDSmkMtYRtg9Y+KrNee7JitG9EigG2NgL3rY50mklunkMstNbWGVPC1ynjTku1iG4w18Xd+IGn0U1qJQwa1hwsQMOdx7yX+W6l4OyPW/y42Ahe5IEERrPWVeimHI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1791477538; c=relaxed/simple;
	bh=B7/RTXGw6xEkN4S3aF0mbacVGPs2NY7fb3eIo7Z50+k=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=GD8d1CFTlu4vLRRBveas2matYnZ/u5m71M7n7mXnztjTMVO4RjAwFcMBSEY6zrpbq1Thv1wWBTR2deNav6dL9jAkAxxd5cP9pXutcfrKypDxYMT8B+GDRfFqgD84BCTKu9gwKz+ZAJpkr2ZjwPh3yHzvKYUx51plNYLZVrDN9Mw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=bd12I3zl; arc=none smtp.client-ip=74.125.231.136
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="bd12I3zl"
Received: by mail-oo2-f8.google.com with SMTP id 006d021491bc7-6de822d01f0so2183127eaf.1
        for <stable@vger.kernel.org>; Thu, 08 Oct 2026 09:38:56 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1791477536; x=1792082336; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to:content-type;
        bh=wcr1e3DelCZYM4o9phxk5vNklRMQLSyAKhNB5dBEr6o=;
        b=bd12I3zlGqyad1SU1bgON32oKdVg4UULWAImb6h+3sJnng3qlhcbkplvxvAkvuk4wy
         n7fxfP1/TRsOZqH/+7c4BzFXKjP7Yl7k4wliFAro8W/8j4Ze7RHGVoEkYBB+dVGXF17n
         BLwdE4Shb1LzlCR1TKekFl1fF25eYKIUcJFPEhPfUDv/lqxm7tqe0kvYFFRxCB3Vdm0l
         QJtS3AU2q4FwEkuhBWyr8qSG119ifKefVvF7EDPdv+EHNIvbwuPN5hTqBlZdsCX3IlcQ
         U1+KL5Z7GdhuL5BUi6Xnz65klnYNoncYECenOGTtbQSbSnh62anWF8f9bUzli/prkDxi
         dWeQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1791477536; x=1792082336;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=wcr1e3DelCZYM4o9phxk5vNklRMQLSyAKhNB5dBEr6o=;
        b=YspHGuAfhY7l3RygGABR+txi3x42XbM/dD/BC/PvkdWRUIQMKLCksl6Mh6zE+dWpxz
         r5O2Rv5sE7ivYp2dRnT60qn4XLs+YdW/8EqDVu+19iV6XGQufaRC5Z66W7dkd04mtLht
         mPaN5nq2kohaGFHt2LBftF9R0TVeSLskFis/5Ffh0Q8aCJnb7Vuka9xoEkMqj4KFZEQT
         Sjunik5hInZXlMHGqRi8aHjtpFwtDOeeEvbEbxAbkFiOnkfUSMXvepQVT2wUM8P9Nl5/
         3taslCh/rFbNxWVRoI3fvYItCiXJuck4Lhn/ISUsulC/g/QHtzls3wnQItQmOoZf+pNQ
         wBFQ==
X-Forwarded-Encrypted: i=1; AKwUvBz6VERoNzxPumzQQnHL/JHVV9qiPZ5qXfGla0gzktNnyitE5Qr09j62RzsmQP9fqNB2ubEWVg4=@vger.kernel.org
X-Gm-Message-State: AFuF++kDcFFUFPlUF3GBqgl+sINmgAcVDWLT5DlUl5afuaplD5+uZFmR
	zi9m9UZzGFj40WarI8iMuP3HTCzzEcGWZxLK6nY+VNr80ph5yNmiNrabpXtzI0chE6l42g==
X-Gm-Gg: AYBFou3dzakmndDz4zX6PplBeyf6z43tJkw6G+WCS2EwcNcpLhlrDcrPjAf3ngStUgi
	IZQ78zpLTA7VTAQw7sKiFdayCPJdYMYSl6nRQRhT0JnYmYBnXljP1t6lN5AuJ8qjsNaFDx0vq6S
	f/FSh0fdujOBVqXhhJw26R6s4gCNciQaNgZmb7m4mYMUKUtX0wCNHMTlSSp9MShbXxMxs0SD1QC
	7Pwm5z93Pv1SBCL2XKoaZuDK3SGBqIcA05ZCTPOi29DHthocjxv1E+qnG0wG8L6/fJX/jqfDlRh
	pmSJ74wK4FyXGCliBQapI0wfWMOrs7q/9KM9gVpudzsEJWgEufS1v+2V0QwY3P/DKzql/co9IdQ
	ln/qf78J+PNcVT6bRq+KJXnitBmoB256uIdSN0O5pBr2Hsev/1YRLa2LHKT0H4DYyoABXqSjR1k
	jnDvwyNdAQ41vs6HCv7s1eAerB14/XNd07seRzezho54pNVGWnyNBpILGISoG4UTRgl946EAfZM
	6cVjK8nxWxgiy9IO+n155XN8i7arYr3Zu4+
X-Received: by 2002:a05:6820:1628:b0:6d7:a13d:fd7d with SMTP id 006d021491bc7-6e7a727cb87mr5941490eaf.53.1791477535895;
        Thu, 08 Oct 2026 09:38:55 -0700 (PDT)
Received: from localhost.localdomain ([14.22.11.164])
        by smtp.gmail.com with ESMTPSA id 46e09a7af769-82fc7cc8ad4sm64328a34.7.2026.10.08.09.38.49
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 08 Oct 2026 09:38:55 -0700 (PDT)
From: Henry Martin <bsdhenrymartin@gmail.com>
To: Allison Henderson <achender@kernel.org>,
	"David S . Miller" <davem@davemloft.net>,
	Eric Dumazet <edumazet@kernel.org>,
	Jakub Kicinski <kuba@kernel.org>,
	Paolo Abeni <pabeni@redhat.com>,
	Simon Horman <horms@kernel.org>
Cc: netdev@vger.kernel.org,
	linux-rdma@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	Henry Martin <bsdhenrymartin@gmail.com>,
	stable@vger.kernel.org
Subject: [PATCH] rds: fix out-of-bounds conn_path access via handshake NPATHS
Date: Fri,  9 Oct 2026 00:38:43 +0800
Message-ID: <20261008163843.957325-1-bsdhenrymartin@gmail.com>
X-Mailer: git-send-email 2.43.7
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Connections on the IB transport (t_mp_capable unset) own exactly one
rds_conn_path slot, but the peer can still claim eight lanes through
the NPATHS extension header of a handshake packet, and every
subsequent fan-out path then treats all eight entries as real: the
mp-start helper iterates conn->c_path[0..7], dereferencing cp->cp_conn,
taking cp->cp_lock and queueing delayed work on cp->cp_wq at 504-byte
strides into whatever comes after the single allocated slot (KASAN:
"Read of size 8 in rds_conn_path_connect_if_down").

The negotiated lane count is now clamped to the same value the
transport was allocated with (trans->t_mp_capable ?
RDS_MPATH_WORKERS : 1), so a peer can never ask us to walk lanes that
do not exist.

This vulnerability was discovered by Tencent CodeBuddy Security.

Cc: stable@vger.kernel.org
Fixes: ba3d1f480c7a ("net/rds: size a connection's path set by the transport it ends up with")
Signed-off-by: Henry Martin <bsdhenrymartin@gmail.com>
---
 net/rds/recv.c | 3 ++-
 1 file changed, 2 insertions(+), 1 deletion(-)

--- a/net/rds/recv.c
+++ b/net/rds/recv.c
@@ -224,7 +224,8 @@
 		/* Process extension header here */
 		switch (type) {
 		case RDS_EXTHDR_NPATHS:
-			new_npaths = min_t(int, RDS_MPATH_WORKERS,
+			new_npaths = min_t(int, conn->c_trans->t_mp_capable ?
+					   RDS_MPATH_WORKERS : 1,
 					   be16_to_cpu(buffer.rds_npaths));
 			break;
 		case RDS_EXTHDR_GEN_NUM:
--
2.43.7
