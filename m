Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=74.125.82.53
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1792429692;
	b=LENVGgc3nQEhBocYy/jhembXMwqen/jv5H2qUVwCzHjCqpOmRR9lDvKLLP+Uxm6TNOSG
	 6L6k6FOs6UKy3MM+D+z69WKn22pzcRR6S7/LjQgp5SOOCgcTvK2fOanuXIsX73DwKMjZG
	 f+RWGcmnzkfFZh3cFkJ0vxeGmPpopE+ckMSPJTIdIG2vRn/YxHGSUI4oXIJWnixKM5SI1
	 2cDxX0IT6qBfWHRKnaEdJoIvs9foi/61FAy4u6QFuBF1xwcAKNgWuhV1zCIkwxo77InNn
	 QGxw7BOizhqdTVcXoyBYfrV//+IgAwe3FHlqQnaeXSnWQKkr51kWxqTyJ148dvXVE5w==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1792429692;
	h=DMARC-Filter:Received:DKIM-Signature:X-Google-DKIM-Signature:
	 X-Forwarded-Encrypted:X-Gm-Message-State:X-Gm-Gg:X-Received:Received:
	 From:To:Cc:Subject:Date:Message-ID:X-Mailer:In-Reply-To:References:
	 MIME-Version:Content-Transfer-Encoding;
	bh=j4/7Kgm4XZXwlNXK7i/XyrsG1PgqZdxrffszkRMdy3o=;
	b=XzWfkeklICsucq00ct9w/FzR0a/iydsPX7gHblmmyTpqyGqKhUSnUH/RvF4j1hMpGc2D
	 /1inb6mHE656vxU6iTneXkOAqdZ3+5rJVCHfRaXuRwRrFoshBMp3Dlvfp21c7bvLapd5G
	 BebWQu2K7jFOMkTQLfPiZX9AyVBx+h15tU5Xb8QNyG51vJN/WGhTyDLwIMilYew3rUQ2/
	 ir87aCa455yBO6hvQV50KSc1hlWMOeQB0jaBaUk+pH5EhM6psraT6Yc5+uzN3RTV+embF
	 3a3IDX9JI3zdS8IEDMqAfVhNE3ltNtoyzR6MDSTF3dBdeuacEJGifC2CxyvzJXM+LRw==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=gmail.com;
	spf=pass smtp.mailfrom=gmail.com;
	dkim=pass header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20251104 header.b=cVc19Aom;
	arc=none smtp.remote-ip=74.125.82.53
Received: from mail-dl1-f53.google.com (mail-dl1-f53.google.com [74.125.82.53])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C8C99606A31C
	for <stable@vger.kernel.org>; Mon, 19 Oct 2026 17:08:11 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org C8C99606A31C
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20251104 header.b=cVc19Aom
Received: by mail-dl1-f53.google.com with SMTP id a92af1059eb24-15354aa70e8so1846678c88.1
        for <stable@vger.kernel.org>; Mon, 19 Oct 2026 10:08:11 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1792429691; x=1793034491; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=j4/7Kgm4XZXwlNXK7i/XyrsG1PgqZdxrffszkRMdy3o=;
        b=cVc19Aomo64aR16ix/R5O5dyM3I4GAAw6gk0VtSIwZ+2h/vt2KDFbChvMaztwqgi0m
         aiplcbokenloB48gyTcdJ/bERcLODSBtfUYXSI7iH0d/f8+o2cJMEm0Raiz0N2MeHhGH
         foxK1ojjKzhA9dossH6qkI8VKVp2A1D5Uq7wb/PuyIh1cR0bDuYpRfYkBp2jlSYY+/QR
         0d64ZkosW7NBpnN5tYj/Hyz5Ak/r+l7JA8xHGOnVpr0EhMo1p0lNoj5r+P3Gc10N5koT
         kBJXd3ZL6Wr6aIhwVDujHvMOfEX0kkirAzOl080dVRSIEo1VGu7cCtiCEH6yBYBPUULG
         QSMw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1792429691; x=1793034491;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to:content-type;
        bh=j4/7Kgm4XZXwlNXK7i/XyrsG1PgqZdxrffszkRMdy3o=;
        b=PityYYRWXPXcKs1eSCtaz68v9YFUMXs1MYhp3fSV+Ptiwqlnms0B76N/UJcZJEXJJd
         QQZ7HxFqj0/3KX28l3d6+Fw3d1jYRE9hwYHsgW+eO+SAzmXOxlVoGcLStIyEZm3jSJLY
         m2s3NsYNnFpddWYnAV1/enIebJ1oDi6yAG5hCFxBtfqtKCya9HOGyoWBV4tWLbHiPzoB
         e/wFHhjqhi+gmy0YiZHWa67c9Ud78ujkvE0YUFf5TOCpXD3UsXR2ESd8ntkXkqxEcGbV
         zs0EwZgmO6z15ukAqrCPsZ3Ecv2ErE3/OLePPi8Hg4IfGaEYUlVyrYMvqTccnmqN7VgY
         jDEw==
X-Forwarded-Encrypted: i=1; AKwUvBzcfwRek6/KA0j8Ea+LOPzM/m9cuGuk/c8OCJW60xF539PxQ/QP2tsntxzYS7BtAhTd3Oj1VmE=@vger.kernel.org
X-Gm-Message-State: AFq9FYKYoBy1v5wCMKfjHn9P8WOOxLxk8uPVJCXARnrzOp9p2rGbJ7Ep
	Eh+Pw+fXeH4TGSTzxCCI6dOxKtIsbE0BvYW660i00BoY+mE7hoyhshJltEJ88w==
X-Gm-Gg: AYBFou14lmU3kO6WGGy5ghpp8KcIEINM4CfbWmNUKhTs5xZiwke2SlDPAPISzv50u4q
	+SLBodA9Iav0j8wTBJoer+rjSOGAc3kvEmkSC2ZbGJkKXqgOu/HWkrZUJyXl9Mx2y0RLCpxg2mD
	DgwuJgST0QnOWp2Pil69HtlrjPaVZ3SBUb5CSsaC6XzxDOHkxHi8bm0DlK+PMVYwrzpbe8wM/aP
	y8/3c+8Aajq1ZN7Im8q2+pZuC+TzmctulJ5kPhojZWK1mPEM3T3IxwUiyNrhIDsfNjG1SEM7RnU
	3QOwAgTDhK2rRM1tjc+MvwggF+xHUDl3Fug4ITY+f5t+P+EHYvUQpMkftzL1905UHUovINpsgZg
	/07J+xGD80Sljj+B/vDxWcbg3fnbKweSzp4tkf+kdspRKTxyn2O1rllCXfUNlmygJ7kqykKscO3
	4odA+24U9f8PV3fAkqoBKEgRpv6InjoblNqaTUhl+aQPTEHpFCAgphQ0629BV91PvK68M0t1v7N
	67FYpvSQSChIgrhRQ==
X-Received: by 2002:a05:7022:1608:b0:16b:fdbf:4a9d with SMTP id a92af1059eb24-185139add2bmr10116222c88.27.1792429690701;
        Mon, 19 Oct 2026 10:08:10 -0700 (PDT)
Received: from vscode-11-19.w453y.xyz ([59.164.88.43])
        by smtp.gmail.com with ESMTPSA id a92af1059eb24-183190aa7bbsm29247207c88.5.2026.10.19.10.08.05
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 19 Oct 2026 10:08:08 -0700 (PDT)
From: Abdul Wasey <w453y.me@gmail.com>
To: mptcp@lists.linux.dev
Cc: Matthieu Baerts <matttbe@kernel.org>,
	Mat Martineau <martineau@kernel.org>,
	Geliang Tang <geliang@kernel.org>,
	Paolo Abeni <pabeni@redhat.com>,
	stable@vger.kernel.org
Subject: [PATCH mptcp-net 1/2] mptcp: pm: in-kernel: fullmesh: skip closed subflows
Date: Mon, 19 Oct 2026 17:07:50 +0000
Message-ID: <20261019170751.200446-2-w453y.me@gmail.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20261019170751.200446-1-w453y.me@gmail.com>
References: <20261019170751.200446-1-w453y.me@gmail.com>
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Post: <mailto:stable@vger.kernel.org>
List-Help: <mailto:stable+help@vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
List-Owner: <mailto:stable+owner@vger.kernel.org>
Precedence: list
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

With fullmesh endpoints, if the endpoint used by the initial subflow is
removed and then added back, no new subflow is created from it: the
connection never uses this local address again.

The initial subflow is kept in the conn_list once closed, and it keeps
the local ID 0, which is also the ID used by the re-added endpoint. In
fill_remote_addresses_fullmesh(), this closed subflow then marks its
remote ID as unavailable. When the peer has a single address, all
subflows use the remote ID 0, no remote address is left, and the
endpoint is skipped without trying to create a subflow.

Skip the subflows being closed when looking for the remote IDs already
in use, and when picking the remote addresses: the addresses of a
closed subflow are not reliable, e.g. its destination port can be reset
by tcp_disconnect(). __mptcp_subflow_active() cannot be used here:
subflows still being established have to keep their remote ID marked as
in use, to avoid creating duplicated subflows.

Without the fullmesh flag, the remote address is taken from the MPTCP
socket, so this issue is specific to fullmesh endpoints.

Fixes: 045e9d812868 ("mptcp: fix duplicate subflow creation")
Cc: stable@vger.kernel.org
Signed-off-by: Abdul Wasey <w453y.me@gmail.com>
---
 net/mptcp/pm_kernel.c | 10 +++++++++-
 1 file changed, 9 insertions(+), 1 deletion(-)

diff --git a/net/mptcp/pm_kernel.c b/net/mptcp/pm_kernel.c
index d3014bf57..ca794853d 100644
--- a/net/mptcp/pm_kernel.c
+++ b/net/mptcp/pm_kernel.c
@@ -216,11 +216,19 @@ fill_remote_addresses_fullmesh(struct mptcp_sock *msk,
 	 * already created by incoming ADD_ADDR
 	 */
 	bitmap_zero(unavail_id, MPTCP_PM_MAX_ADDR_ID + 1);
-	mptcp_for_each_subflow(msk, subflow)
+	mptcp_for_each_subflow(msk, subflow) {
+		/* The initial subflow stays in the list once closed */
+		if (subflow->closing)
+			continue;
+
 		if (READ_ONCE(subflow->local_id) == local->id)
 			__set_bit(subflow->remote_id, unavail_id);
+	}
 
 	mptcp_for_each_subflow(msk, subflow) {
+		if (subflow->closing)
+			continue;
+
 		ssk = mptcp_subflow_tcp_sock(subflow);
 		mptcp_remote_address((struct sock_common *)ssk, &addrs[i]);
 		addrs[i].id = READ_ONCE(subflow->remote_id);
-- 
2.43.0

