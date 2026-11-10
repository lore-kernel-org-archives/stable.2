Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=74.125.82.41
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1794349405;
	b=N1UVL0LsS2lBqS1Ta/bSYpGq/4ER67FJstc8NfPPozz8MuU3yyMLsh/iEgBdcvRvzVXW
	 TXn//ndXbdvmtRVH8y2aC/oYy5YUbzQYZH7xsTRSsgdroMErgv0wG670sOM7FP+N/x4FV
	 P0nPzMtHka0Xjcg/pN38pen/FxAQsloJFd5GKY5snT2/d0DINPdr6XJFL1BIKibN75nOT
	 8HJZNUGNsh51tHMbLYTrW/Na6G70oM2Nm/9Ki1hTrPNoTc4K+KoiD4CUvaWAjuBQdHUUs
	 D+Y5Sh46lV3zGflVh0N9z5QgQ/q+i4pWmZ1BdgDDF6mrB0JjcFqYwfBMke3D5Rv8vKA==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1794349405;
	h=DMARC-Filter:Received:DKIM-Signature:X-Google-DKIM-Signature:
	 X-Forwarded-Encrypted:X-Gm-Message-State:X-Gm-Gg:X-Received:Received:
	 From:X-Google-Original-From:To:Cc:Subject:Date:Message-Id:X-Mailer:
	 MIME-Version:Content-Transfer-Encoding;
	bh=otRyMeb75+VLZ1qPaOWUchAC2U7XAkcMMqGgLecGB9I=;
	b=JuWAZtaokJ2CX3ywzFDxv/PiRa4lzefL8ydae47uvR+LB/l2Qn4Qbo+lCzEzWWpR3qTm
	 ikAZHRIVtvvAvOTdYJbbHkXi7JAlg5ksUX3WOrGk2+Yc/tY2KLTgonhiTYSPblSFLunrq
	 O0UYX48q0chCGKwmsQxT9gtjQ/0v9mH+Mm7rHoQ1CF8xCuVq+XwMYqV46sTHWW4crJkIl
	 9M4eniQFQ/KPQQM5jz+IT/uY34OFn0p/t2ozhtE3H1qJo6aXvAz7YpmIZWR76DhplsR8B
	 r8AxVCsxdFAbG9IVlp676GBuBpXvclir1BNGlxVhJKQRoW3bHx7YTn0WVSVWQ6rMc+w==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=gmail.com;
	spf=pass smtp.mailfrom=gmail.com;
	dkim=pass header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20260707 header.b=lPq7O3Wk;
	arc=none smtp.remote-ip=74.125.82.41
Received: from mail-dl1-f41.google.com (mail-dl1-f41.google.com [74.125.82.41])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6492F606A321
	for <stable@vger.kernel.org>; Tue, 10 Nov 2026 22:23:25 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 6492F606A321
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20260707 header.b=lPq7O3Wk
Received: by mail-dl1-f41.google.com with SMTP id a92af1059eb24-1b3beeaf6f9so413965c88.0
        for <stable@vger.kernel.org>; Tue, 10 Nov 2026 14:23:25 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20260707; t=1794349404; x=1794954204; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to:content-type;
        bh=otRyMeb75+VLZ1qPaOWUchAC2U7XAkcMMqGgLecGB9I=;
        b=lPq7O3Wkj/vM9r3JNDdcLozDsq3fAdAlDjXIzdHKc8R4VLWraDlUVNMFGf4MnP5gIH
         QDgj/BCupkFkv/4PTDaAkiwxxLYF43/GxA/7Z7cRo00yhngqIfiiqtWjzD7+c/kg9Twm
         BotE7kiX/vYjzMykrFH89ewEElErt+gEsRuANUeih0aSi8tG82tpNSPS/9+jH7SMzLRm
         jAtkudGVXM/tA2CJZNtQ1OLIKKowgfIDNSZv6EdOOlJJBaYBIFb8qAwDipQJ9CrAZYEZ
         YeaN2gfAfbDQKCe6p488tiJov3ZwzwCjAUiA2+oMLuI2L/y1U5/TzsTfRBK4A5SpsfxV
         0cVg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1794349404; x=1794954204;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=otRyMeb75+VLZ1qPaOWUchAC2U7XAkcMMqGgLecGB9I=;
        b=ZraIlmOjfEM8s7rF7W90gGxxNm0guwlzPMqssJowpxwzFXgRJi5Mvc6hs4HAXXUvkn
         f30geK1clZ5Vc3bD+UpOMD3HTRdjKbOv9JLRwjymeWD8z1v9dqQFymIpxVmUyqAa5Xml
         EubT57Y64cWY4OEvZqyervSDcSM0L+QAyr5D3S1Dc+XGZAGLLkWYYMOSbIqYV6ZKuO2l
         Y+h8lsGhMDDZ4InLF+8HXUHtejo3/tcrZQD4JkaYGnwG+AXXQUIodCO+bgkq/U6V+qpK
         POf8Zp6h//iIwEsl62mdFXpxrj221zeso7hG4SexJqPw3/nf7tg912dQahihgwtk1lgq
         Kgtg==
X-Forwarded-Encrypted: i=1; AL+hErGtaKd2J3gsiplMWhrgQpzZ05eaBDp8NxjotoRse8U/rRiOzpAzqm123LOu4oGDVVffhXrL4vM=@vger.kernel.org
X-Gm-Message-State: APuU4Z8mlQ9GOBnv9erlB68xfRaAiNeHOJ03TOZKzENLAi/QbifcDZ5l
	jHdG19F+bq0+PrqTA3ZUBEPbLRWPD4vdXZkg7M/19a62hxj2aTM5J4oc
X-Gm-Gg: AYBFou0UH6Pl09XOJhAzJgj/gHBcTjitikuJEJ0BQgtVaELcJLz3maGofVxeyrz0LeW
	zY9OuupR2SsV349ht0L7Zu0wZOFIx1I44CvL3DKqsFZbzSFzry9JwSrxxIp/UoyC3ORTsE1x2sm
	v/VU2wLlb9YzbSf8oy1Lmhmowk+OnaZ/rMkSPpu2SI0WpwpCEDlsYOFtDDkLTh67Z+wrANSyMNZ
	gU2Mqd6DzJ8LGp532+zRrjcTCNjIdwSltyMycQ4ryqoLbsnIyR2jLFss13AiihBpKktbqXj7+d8
	f8M2YIP9An31uQE+6ktJAOxH8vOp+8bhFyxs+t0dOoTDN8M68Mpky00TABJrc0LHrkxZHQa66n1
	zvIjNuVLSnm2pDB36H7aoxV7thhiqxYfzDXi3gi2STtbp5pbHbA2NawaGc+Oy/c/Aep0+8gdMqc
	FDOV0Away8VNze90YLp2BHV5GckmyjpEjTvb2x1b0NPCsmKfqjNzW3kLD/z7CMvbh+QZsI5YoSF
	bBJoHEgJ3OXjh0If0KD289PVzelm0cIoT4VhR27crqbHN4tpMP1H/OBYf9ghaORaswcW6o6FKeC
	rIlosTFH6jZphBHmVENmsdS67wvKMLU/+hi83Fezks1i2lD+VQ4KYWQt7BI=
X-Received: by 2002:a05:701b:2903:b0:136:c443:80e5 with SMTP id a92af1059eb24-1b3c023c9aamr353445c88.6.1794349404165;
        Tue, 10 Nov 2026 14:23:24 -0800 (PST)
Received: from localhost.localdomain (wood.seclab.cs.ucsb.edu. [128.111.49.37])
        by smtp.gmail.com with ESMTPSA id a92af1059eb24-1b3b5b2eeffsm9882751c88.9.2026.11.10.14.23.23
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 10 Nov 2026 14:23:23 -0800 (PST)
From: Praneeth Balasubramanian <praneethb2002@gmail.com>
X-Google-Original-From: Praneeth Balasubramanian <praneeth@ucsb.edu>
To: Luiz Augusto von Dentz <luiz.dentz@gmail.com>,
	Marcel Holtmann <marcel@holtmann.org>
Cc: linux-bluetooth@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	Manish Mandlik <mmandlik@google.com>,
	Miao-chen Chou <mcchou@google.com>,
	Praneeth Balasubramanian <praneeth@ucsb.edu>,
	stable@vger.kernel.org
Subject: [PATCH] Bluetooth: hci_core: Hold hdev->lock when freeing an adv monitor
Date: Tue, 10 Nov 2026 14:21:44 -0800
Message-Id: <20261110222144.204736-1-praneeth@ucsb.edu>
X-Mailer: git-send-email 2.25.1
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

hci_free_adv_monitor() removes a monitor from hdev->adv_monitors_idr and
frees it, and its comment says the caller must hold hdev->lock. Readers
such as read_adv_mon_features() walk adv_monitors_idr and dereference
each monitor under hdev->lock.

Since commit 7cf5c2978f23 ("Bluetooth: hci_sync: Refactor remove Adv
Monitor"), MGMT_OP_REMOVE_ADV_MONITOR runs from the cmd_sync work, which
holds only hci_req_sync_lock. On the HCI_ADV_MONITOR_EXT_NONE path, which
is also taken while the controller is powered off,
hci_remove_adv_monitor() then calls hci_free_adv_monitor() without
hdev->lock. A concurrent MGMT_OP_READ_ADV_MONITOR_FEATURES can load a
monitor pointer from the IDR and read monitor->handle after the monitor
has been freed.

The MSFT path already frees the monitor under hdev->lock, in
msft_le_cancel_monitor_advertisement_cb(). Take hdev->lock around
hci_free_adv_monitor() in hci_remove_adv_monitor() too. None of its
callers hold hdev->lock.

The missing lock was found with an LLM-based tool that checks callers
against the locking rules stated in kernel comments.

Fixes: 7cf5c2978f23 ("Bluetooth: hci_sync: Refactor remove Adv Monitor")
Cc: stable@vger.kernel.org
Signed-off-by: Praneeth Balasubramanian <praneeth@ucsb.edu>
---

Notes:
    This was found by an LLM-based static analysis (GPT-5.6) that checks
    kernel code against the rules stated in its comments, as part of research
    at UCSB SecLab. The patch and changelog were drafted with Claude Opus 5.5.
    I reviewed the patch and take responsibility for it.
    
    MGMT commands need CAP_NET_ADMIN in the initial user namespace, so I am
    sending this as a regular fix rather than a security report.
    
    Testing: builds without new warnings with W=1 (x86_64, KASAN and lockdep
    config). Not runtime-tested.
    
    The patch applies to mainline 9ba46df34488 and to next-20261109.

 net/bluetooth/hci_core.c | 3 +++
 1 file changed, 3 insertions(+)

diff --git a/net/bluetooth/hci_core.c b/net/bluetooth/hci_core.c
index 74d9865e08c2..b66d3c295e5e 100644
--- a/net/bluetooth/hci_core.c
+++ b/net/bluetooth/hci_core.c
@@ -1966,7 +1966,10 @@ static int hci_remove_adv_monitor(struct hci_dev *hdev,
 	if (status == -ENOENT)
 		bt_dev_warn(hdev, "Removing monitor with no matching handle %d",
 			    monitor->handle);
+
+	hci_dev_lock(hdev);
 	hci_free_adv_monitor(hdev, monitor);
+	hci_dev_unlock(hdev);
 
 	return status;
 }
-- 
2.25.1

