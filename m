Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=209.85.218.47
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1793622874;
	b=1bwLst/pxXw16oVc3XQqH0EDYMuMIkoQipCK8jgmvEbLAiC4SvgBv1pFWF0D8EGa7CjX
	 3dJf7WdOIA0PuUxC6ap6yWik9+WxsaR9bRVArlbzAFDIa8OO4xboecsXxqeK31klMvBS0
	 jr1GYEiQk2YbWl107fNj2mnKdXMKapKkio8wHZirhW5U1tV8AI6Y9raoyBSjd6vRD9wLb
	 EkW+F290jzFgQs4d/3g4ftrEh4NwKjJwLbpghvZhTmU9TZuQR+9RGZgSP6jd6LoQ72htr
	 TntuqHqLUxyO9nJc8H4QPNzNq5+WqxpRgKn21jR/dM2hnWPDeod3FDVLcUK3JLzgZfQ==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1793622874;
	h=DMARC-Filter:Received:DKIM-Signature:X-Google-DKIM-Signature:
	 X-Gm-Message-State:X-Gm-Gg:X-Received:Received:From:To:Cc:Subject:
	 Date:Message-ID:X-Mailer:MIME-Version:Content-Transfer-Encoding;
	bh=8WgZokOso5GKBkB6b1tRUojAeIrmq+wx4vK3BoCOZdA=;
	b=gmTZjQvHuYEdFECmRcALNDopoHfE3Cuz/tfoYVg6jICiTcKCDJBL40RvHaz0BP4Vp5ws
	 6XBeLSj050pxuXNKTdcGGHetGNK+Ws2Csp0mcvzzqW6DbHDTaxcbG4mEjILRaKvu7eWTX
	 t+vmG46EXWfzLIuXSTeIP++hy2OSZpsH6tufu5KnjJf4kRFhA7KvqeyQbyuLu5dWbbcA1
	 h2jMZLwPt8hbAg/GxT9ZvxWOHcnwzEK4TJeKY6JHyhOnZ4+IvuYf0zwGyXGpjQJPDvUUG
	 IhH+6VdO/AiahX71FmlEyozVeunq6Nus+IXMOopiJx0gl3NeCkDxOSfvjiJFOuLOVCg==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=cloudlinux.com;
	spf=pass smtp.mailfrom=cloudlinux.com;
	dkim=pass header.d=cloudlinux.com header.i=@cloudlinux.com header.a=rsa-sha256 header.s=google header.b=Mgit0CiU;
	arc=none smtp.remote-ip=209.85.218.47
Received: from mail-ej1-f47.google.com (mail-ej1-f47.google.com [209.85.218.47])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C4893606A334
	for <stable@vger.kernel.org>; Mon,  2 Nov 2026 12:34:33 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org C4893606A334
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=cloudlinux.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=cloudlinux.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=cloudlinux.com header.i=@cloudlinux.com header.a=rsa-sha256 header.s=google header.b=Mgit0CiU
Received: by mail-ej1-f47.google.com with SMTP id a640c23a62f3a-c3f04e0e65fso430288166b.2
        for <stable@vger.kernel.org>; Mon, 02 Nov 2026 04:34:33 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=cloudlinux.com; s=google; t=1793622872; x=1794227672; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to:content-type;
        bh=8WgZokOso5GKBkB6b1tRUojAeIrmq+wx4vK3BoCOZdA=;
        b=Mgit0CiUXJF476mkGjG/UtMwaxX5JUjdiFfVeAGAOLUguFT72B03MvLcGth7CIhu60
         V4Gn27EVgzsiGSRLwcwuLr1xO05TwrG2o987Da+SFncL2BQDYpeZGNQVgeNR1PYu7zb7
         xmyAE1d2jGl9WxYLW1E8o/ueQpm9/V2tbgo7/DgQYrhqs/rZBM938LeGunPsi9MW+3We
         avvT78CrOOo5XxKUKkTOm9FZdaRutToVtKMLD1rwLue/8dh6peQYMz6HKDbS9PkyKCL+
         6iZbJNoPvr8JVnMWPUPn4X2cx8DuGaqWqtmObQdVTsPeHz5l2eNZukYD1bDpIhKmrSLR
         oB3A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1793622872; x=1794227672;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=8WgZokOso5GKBkB6b1tRUojAeIrmq+wx4vK3BoCOZdA=;
        b=GXnweUwDg3cUOjNskncWj4NN1Iu+xkRTx+s2zwSFM6aaTi0hW+y8GHPfe9gSQiq0qJ
         5FLAdU+gosOSyAFoL+uttf0UlQCrGv+HYH/Z5j/H+OQzoalWLGKVXaNHAse8fyZuPPe8
         HFh0p8OZfrBp4vzK/1kbUq6VLvFYaTiFwuqj+pGIKG1uAt5eHsDHhU+7fqJu7hHiW/Tx
         JcSDAQ8qs7dbzxCqjfLH9wr112tpTFNRTubj3zEAr4POswNDDRu2fw9BT+pM7oDlXa0t
         k4W3Fzrfor/TcQVXrqa3il0NewF3DXDugSlbuKh1kX4Rm2zSbi/Ojp/xgJy8hU9TkYaP
         Qu5Q==
X-Gm-Message-State: AFq9FYKaQQNenoHCrryPQOgTqPAn2R884N/9mAfqV0TR3TwnyllGzju3
	RQaH2vSRCZpO/bnz/yy38J9apPWrNvShYgidX8W1TaoodniRLbey+YcXPXHhDmqr88mBH4QckEY
	td/3SzaVzduti
X-Gm-Gg: AYBFou2EUDKSJSMbWTviHXeX10K/+YSuF5dvuE5fPl9ytP62JJomkh5/1zGTVimCVIa
	UTMZwBSM6aI3sZU/PqNgbVYapdTMz2ryWMVva9QG9ilti3vuKH/UzqEJBrOjQZ1HMMkfYfecZL0
	JoiQQmcRHTH5ZKNofb80Z8FX3ZoZrQdZ8t3PeSRTARPsO3Ws66rjWihp+YN39k0dbg/OXBiCh2Q
	F2AUtv1wOh+1h2/f58VoMY3OXgIWnqgxzJhHqxqQmAMkcPEHSEzI0MLK3RuqWfZx1cJZxi1H+m+
	2LsLRa7h4Uy00qQhaz9V0pChmgYOkaD/moVwdrpRF2frmioVGP4AbZWw8hybyYYX+h9dFDzVYtG
	3cqMIoUxGQ1ZInGn7edJ+GR8Yj15iYw6OzZdk1lCDBeOXXGCUpuu/aKRPFvsZNp06ca7gpjOAAM
	/bSx3FffRwttrYcmwuntoei37yNZWXSCVzDuOSxJAmfUQThvo6t5avtFRRqx2igfL0Z3RdCZcaQ
	rt/BHT0EjQxCDk0ErJdkZBB6FrQC8fi3ZJi3T65Ppaj6uppwWVf+MxI8AdtQiZ3fnwqQ/yJCek1
	b1ECaYaVFw==
X-Received: by 2002:a17:907:868a:b0:c2e:2baa:a642 with SMTP id a640c23a62f3a-c4ca7a820acmr832014066b.30.1793622872158;
        Mon, 02 Nov 2026 04:34:32 -0800 (PST)
Received: from dev1.kernelcare.com ([2a01:4f8:172:1c85::2])
        by smtp.gmail.com with ESMTPSA id a640c23a62f3a-c4cabe4aa07sm396884866b.63.2026.11.02.04.34.29
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 02 Nov 2026 04:34:30 -0800 (PST)
From: Andrey Misiurov <amisiurov@cloudlinux.com>
To: stable@vger.kernel.org
Cc: gregkh@linuxfoundation.org,
	sashal@kernel.org,
	luiz.dentz@gmail.com,
	luiz.von.dentz@intel.com,
	marcel@holtmann.org,
	johan.hedberg@gmail.com,
	linux-bluetooth@vger.kernel.org,
	2122295973@qq.com,
	Andrey Misiurov <amisiurov@cloudlinux.com>
Subject: [PATCH 6.1.y] Bluetooth: ISO: drop unbalanced sock_put() in iso_conn_ready()
Date: Mon,  2 Nov 2026 13:34:18 +0100
Message-ID: <20261102123418.363320-1-amisiurov@cloudlinux.com>
X-Mailer: git-send-email 2.43.7
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

Commit 1702f12cf59a ("Bluetooth: ISO: fix use-after-free of listener
socket in iso_conn_ready"), the 6.1.y backport of upstream 560bef609fa5,
puts the listener when it is no longer listening. Upstream that put
balances the reference taken by iso_get_sock(). On 6.1.y
iso_get_sock_listen() takes no reference (it got one only in v6.8 with
fa224d0c094a), and no other exit of iso_conn_ready() puts the parent.

No race is needed to hit it: shutdown() of a bound socket sets
SOCK_ZAPPED and keeps BT_BOUND, so listen() still succeeds and the
listener stays BT_LISTEN with SOCK_ZAPPED. Every incoming connection
then takes the new branch, and the second one frees the listener while
it is still on iso_sk_list and attached to its file.

Drop the put.

Found while reviewing a backport of this fix; not reproduced at
runtime.

Fixes: 1702f12cf59a ("Bluetooth: ISO: fix use-after-free of listener socket in iso_conn_ready")
Signed-off-by: Andrey Misiurov <amisiurov@cloudlinux.com>
---
6.1.y only: 6.6.y and later have the reference-taking lookup.

The closed-listener race that 560bef609fa5 fixes does not free the
listener on 6.1.y: iso_sock_release() calls sock_orphan() before
iso_sock_kill(), which then returns early on SOCK_DEAD, so a released
ISO socket is never freed (fixed upstream by ce57442a3792 "Bluetooth:
ISO: fix leaking sk after socket release", not in 6.1.y). If that
commit is backported, iso_get_sock_listen() needs to take a reference
as upstream does.

 net/bluetooth/iso.c | 1 -
 1 file changed, 1 deletion(-)

diff --git a/net/bluetooth/iso.c b/net/bluetooth/iso.c
--- a/net/bluetooth/iso.c
+++ b/net/bluetooth/iso.c
@@ -1536,7 +1536,6 @@ static void iso_conn_ready(struct iso_conn *conn)
 		if (parent->sk_state != BT_LISTEN ||
 		    sock_flag(parent, SOCK_ZAPPED)) {
 			release_sock(parent);
-			sock_put(parent);
 			return;
 		}

