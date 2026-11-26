Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=209.85.210.51
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1795710001;
	b=mTb4o5VBjRhQGbkElHYhu5K19g3wPIrEQdfPKcyrpEOExhPkfGrTBf5QIlMLJIVo9ZoQ
	 l/yzafOay1INNWuq7WNWXuS06Zu1tw2gqWttMucgxmPBsrFf6I9zYMzYnB1vE0ubbghgs
	 VQHTmyNBhyGM2oH96BNq5epuaP0ANx4MtN3EUZaL1YSAj0JUp4oIacJyYOk0oYHYlCNwV
	 nK9hQ4qdRuM6NHHekn5Q+yCNX+8Ix4Y6qcH0XJXnP9IwThBcRE1rKRkbeogfYWB9Eyw+/
	 VvJhbrmCnvfuVBOCdWQKXHQEF1UW/OqiD8L3poqb7TwXx7HPr+HEsyVORBDXD3Rzueg==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1795710001;
	h=DMARC-Filter:Received:DKIM-Signature:X-Google-DKIM-Signature:
	 X-Forwarded-Encrypted:X-Gm-Message-State:X-Gm-Gg:X-Received:Received:
	 From:To:Cc:Subject:Date:Message-ID:X-Mailer:MIME-Version:
	 Content-Transfer-Encoding;
	bh=Lkgre5qcJ5JDJ83VWMY/EoHEK7uMhR2UbEpH1fCBixw=;
	b=5PRJTW4TrfIrn95xTvzv6ZLMKvif3IdCuTcL5Fb8qC9G4GYZiGKR6Nm7f5e0AmPmSYUw
	 b/ugnIn9cguNHwKaHeKQLKu9SOL4NvvxEFXX8ln/WZ+6Y2yfjf9SsVTqPBe+WsIOpiGmz
	 Y8y2xix6QZeOMx+Bo5Yp9C6tjE4j6u7onNJvElyx6xclJcEiJZXh5jZcnrJ++G6Ank/NE
	 WnABoPkW4HQtqTZ37ae4Ai3+1NoUsybtA6vEnE0cRvmDdFPsG4NBS7bWe9ZyCTGfNEbf6
	 qDpa7DwFeEBHfuyAVXbTTFPMdt8M2uHBG0TuXLJErl06FRBIjcv1jJq3xDigGxmQOzg==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=gmail.com;
	spf=pass smtp.mailfrom=gmail.com;
	dkim=pass header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20260707 header.b=Udz6qZjS;
	arc=none smtp.remote-ip=209.85.210.51
Received: from mail-ot1-f51.google.com (mail-ot1-f51.google.com [209.85.210.51])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 65F14606A31C
	for <stable@vger.kernel.org>; Thu, 26 Nov 2026 16:20:00 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 65F14606A31C
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20260707 header.b=Udz6qZjS
Received: by mail-ot1-f51.google.com with SMTP id 46e09a7af769-862ab66fbb5so832938a34.3
        for <stable@vger.kernel.org>; Thu, 26 Nov 2026 08:20:00 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20260707; t=1795709999; x=1796314799; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to:content-type;
        bh=Lkgre5qcJ5JDJ83VWMY/EoHEK7uMhR2UbEpH1fCBixw=;
        b=Udz6qZjSXZQmDOFyEhkHpyTSm68l/7h7IzU964hcapON0wdPfXoLuQpMQWoThd+++u
         Y+Ey7MF570dSADArqyOpiPYgz2BsXvqUWu6eYwHJMCCzZ0mGz5pRAqsTn1/iSXRVQulQ
         UhcBodEcPK3nFJfBjHDBkF378mh7ttCzH8jK/+Mt137d+30ckHAfPHHRoo/nqD74EMOo
         QUeWyhPzk1LzMMyH+YVR7Da8tvj1igWWoUr7PMTHQ5IZ0uWFQt/C5JLX1s3RKIZSIdWU
         7c+0qHCZ2kv2Xs4uVnG9sjntSO+gA2GaN4C/spQUqcXljKpgHQPbXE/G4sC01dQzK0zY
         Z2Hg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1795709999; x=1796314799;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=Lkgre5qcJ5JDJ83VWMY/EoHEK7uMhR2UbEpH1fCBixw=;
        b=kczGqBxctLwgLCRSU6J3As5uREXj/s+2+U/9Hao7QNNFxtaNvCTB038huZun9D2wP7
         MDLN6pd7lkY8lvAfSxcTN7BRj6mTrJ5DrwKpXe7NXW3EW9yQJM1HpZf25xAHhlBI0ATP
         xz0IbebAGoN5u5sjhjQ2OXLJgtmQuLYTleG0DUWoj+0brl+QvCnfY82B7Do/LRC4gSYm
         Tp3lb3DBXVWwjvd8ZIJeyzfVXYwPa3wvtZ+XHqTroOMnX6xrOeeuz1wL0Qx+3U/jBV2d
         lVzollyVRzLnNP/XQplapS3EEwk+jOqrc80h4tbLVRW9CBSCCwqHPftb6DopHeT8eVSD
         qrwg==
X-Forwarded-Encrypted: i=1; AL+hErGf39vgmxcKyoR3klldJLDNWzouuaADaYN+uYP+59xXeNgQJubLjjVnVsDkXFCxgrL6ZaEJ61s=@vger.kernel.org
X-Gm-Message-State: APuU4Z8/tL9qrleX+Ui1C/NipiK5VOppmCDi2Rw/ZQmGybkLRVFJor9E
	NbIE5QPemoOX38B88UlCBDE7Phn9HpS6MD7N5b2mnl2KlhJsJs7mCR/M
X-Gm-Gg: AZFdTZcV2r1J4N9bUxF7RZqNqK9gzpCnjrWdAW4PGnSBvW0y7sjpOmfKjHTVrbqThl3
	lJrA8obWMWEnylsUPHUm3N0gchooAq2Oea6UHlBZq0Sfl0b3gRYV7VV8TpuQ9wDybuap+26GkzM
	zBpmerlQEG4fn4x7+Mz3Il6FU926V5jV5wDlf0TQvOBs87FkcImYgxwhCFwKkTZGcMWEm/M10wa
	FLxP/NTiiLCuFvAG6xW53lkZh0fe92Lqhbd6aGxQKOr+FWZppTqBT4VnIE7wOZlCY0zh0oIJcyp
	eUrmrUpWTpomTlll7ruBjmHXLtc/iHGnoO5MGHcf6qYuUc2O7HS/OM7XG7RGkF1y/BsC0G73zlC
	JfwokHN9+Vh7xi+Q2TQ3mguXu6WYyStps1WNwrAxcW6AJpTDurol7+RgKXb/SyOD850voMt38N1
	dGjgNg0Zwvttjv49gFBnaaI01c0piLoJE6Mnwy+JIxt8TSzeenDdrox35fDSTRVDbOLGgrRVMlb
	biQOccQzzgAS9OXVkFi80J9PwA2E+oJjhLW0PYTsR6+wJ05zXFsaFeRla7eHFFbFk6oHldO9mDO
	/LiADqfLnIpw6m+gaCiz9Bj1SCiaC3e+PQFgIntLS0uUOphZL+t9dniaGW837t0NHH9wNuBvf3i
	SL0WoIkuX
X-Received: by 2002:a05:6830:2a88:b0:845:3cfe:5f2 with SMTP id 46e09a7af769-86314ff95bemr34495862a34.0.1795709999247;
        Thu, 26 Nov 2026 08:19:59 -0800 (PST)
Received: from localhost.localdomain ([37.19.221.85])
        by smtp.gmail.com with ESMTPSA id 46e09a7af769-863168dd6besm15335990a34.11.2026.11.26.08.19.57
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 26 Nov 2026 08:19:58 -0800 (PST)
From: Iaroslav Voitovych <yaroslav.voytovych@gmail.com>
To: linux-bluetooth@vger.kernel.org
Cc: Marcel Holtmann <marcel@holtmann.org>,
	Luiz Augusto von Dentz <luiz.dentz@gmail.com>,
	Brian Gix <brian.gix@gmail.com>,
	stable@vger.kernel.org
Subject: [PATCH] Bluetooth: MGMT: Fix Read Advertising Features hiding instances
Date: Thu, 26 Nov 2026 17:19:33 +0100
Message-ID: <20261126161933.923041-1-yaroslav.voytovych@gmail.com>
X-Mailer: git-send-email 2.43.0
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

read_adv_features() is meant to report instances 1 to
le_num_of_adv_sets and to leave out the mesh instance, which is
numbered le_num_of_adv_sets + 1. Instead it compares each instance
number with the number of instances, so an instance numbered above
the current number of instances is left out: with instances 1 and 2
added and instance 1 removed, for example after its timeout, instance
2 remains active but is no longer reported.

Compare with le_num_of_adv_sets, as the comment says.

This was found with mgmt-tester while writing tests for advertising
instances, and reproduced in QEMU with a new mgmt-tester case that adds
only instance 2: without this patch the reply lists no instance.

Fixes: b338d91703fa ("Bluetooth: Implement support for Mesh")
Cc: stable@vger.kernel.org
Signed-off-by: Iaroslav Voitovych <yaroslav.voytovych@gmail.com>
---
Tested in QEMU with a new mgmt-tester case, "Read Advertising
Features - Success 3 (Instance 2 only)", which is being submitted to
BlueZ separately. The case adds only instance 2 and expects exactly
that instance in the reply. It fails in 3 of 3 runs without this
patch and passes in 3 of 3 with it, on bluetooth-next f57f78086ab5
and 5063a0717aa2, v7.4-rc4, 7.3.6, 6.18.65, 6.12.119, 6.6.163 and
6.1.193.

No other case in the Bluetooth kernel CI's eleven testers changed its
result on any of these kernels; the CI itself runs only mgmt-tester
and mesh-tester for this file. No test has a mesh instance present
during the read; it stays hidden because its number is
le_num_of_adv_sets + 1. l2cap-tester hangs on 6.18, 6.12 and 6.6, and
iso-tester on 6.12, the same way with and without this patch; the
cases after those hangs, run separately, give the same results with
and without it. The same KASAN and lockdep reports appear with and
without it on 6.1.193, and the same lockdep report on 6.12.119.

The bug also shows on real hardware: on a QCA9377 (USB 13d3:3503)
with Ubuntu's 7.0.0-43 kernel, Add Advertising for instance 2 alone
succeeds and the controller accepts LE Set Advertising Enable for it,
yet Read Advertising Features lists no instance. On the same hardware,
with this patch on Ubuntu's 7.0.0-44 kernel (whose mgmt.c is
unchanged from 7.0.0-43), it lists instance 2.

 net/bluetooth/mgmt.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/net/bluetooth/mgmt.c b/net/bluetooth/mgmt.c
index d21538634bc3..01969ab57339 100644
--- a/net/bluetooth/mgmt.c
+++ b/net/bluetooth/mgmt.c
@@ -9074,7 +9074,7 @@ static int read_adv_features(struct sock *sk, struct hci_dev *hdev,
 	instance = rp->instance;
 	list_for_each_entry(adv_instance, &hdev->adv_instances, list) {
 		/* Only instances 1-le_num_of_adv_sets are externally visible */
-		if (adv_instance->instance <= hdev->adv_instance_cnt) {
+		if (adv_instance->instance <= hdev->le_num_of_adv_sets) {
 			*instance = adv_instance->instance;
 			instance++;
 		} else {

base-commit: 5063a0717aa238f5242bf6b4abb8ddc1741ce682
-- 
2.43.0

