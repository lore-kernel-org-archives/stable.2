Received: from smtpbguseast3.qq.com (smtpbguseast3.qq.com [54.243.244.52])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5C8F6367F4D;
	Mon, 13 Jul 2026 07:26:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=54.243.244.52
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1783927597; cv=none; b=InQbwMLB7KRtQX7WopGuPTf4z8jojrOe+gxkOiWUkT3ZRNcCqxDKhYKP062N89nYMDVY3BTWZCOni0HigD1e6lBTqngXwZmu7O5GgKzSzVWgBN2a8OFQARH+4Ezlf6QSlmIBVyZoNcVoUA3DpuVaC46vWPF/afQm0UPUqJ79i7o=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1783927597; c=relaxed/simple;
	bh=L7xoaJrUdDXlvGuljK/J3/a4RlGKUVh9PitZfk3Islc=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=G00qdkDgirlEXGQKafVX4oRR6dxcx7V3DhpYpsfw4GK9MWQw8iPy8AK8oW6GvZAzx2mnBZbvCJrVsuGKMsKycTsGKVFyQngxcrpNy7qenaahjCbK+oP65Ge8jqZcbIigMUxUgGHGMkZ0hMZUWAofpMCBUX4YiQ5gKAPUXElrZNo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=uniontech.com; spf=pass smtp.mailfrom=uniontech.com; dkim=pass (1024-bit key) header.d=uniontech.com header.i=@uniontech.com header.b=AxB4HHZD; arc=none smtp.client-ip=54.243.244.52
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=uniontech.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=uniontech.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=uniontech.com header.i=@uniontech.com header.b="AxB4HHZD"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=uniontech.com;
	s=onoh2408; t=1783927553;
	bh=v5zHyTWnlXl2131UmamubukTuUePJf2rxwslkzR5zyE=;
	h=From:To:Subject:Date:Message-ID:MIME-Version;
	b=AxB4HHZDb2NYqK8qyKuRzBYwOLMAoZ+II24Zs1BWZx3a4VJ7Cmi2FoHXXzztYIhk9
	 P16pAnzbjmxtETVfdiOKTEWvnwiR4AtDQ1QVi4CQ96yCv0VQG7QiyU7gAzVAobbrzm
	 eOgCyA5tOmRG1kz88k4mQN5i5m3sCFeS8hRA5yCQ=
X-QQ-mid: zesmtpgz6t1783927546t46037448
X-QQ-Originating-IP: aUH+avv7FL44AIbU3VNg7RDj7c57+bpD6izfgXkE3Sc=
Received: from PEN202512010004 ( [113.57.152.160])
	by bizesmtp.qq.com (ESMTP) with 
	id ; Mon, 13 Jul 2026 15:25:44 +0800 (CST)
X-QQ-SSF: 0000000000000000000000000000000
X-QQ-GoodBg: 1
X-BIZMAIL-ID: 8809296686197180074
EX-QQ-RecipientCnt: 8
From: raoxu <raoxu@uniontech.com>
To: brgl@kernel.org
Cc: marcel@holtmann.org,
	luiz.dentz@gmail.com,
	linux-arm-msm@vger.kernel.org,
	linux-bluetooth@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	raoxu@uniontech.com,
	stable@vger.kernel.org
Subject: [PATCH] Bluetooth: btqcomsmd: destroy RPMsg endpoints before freeing hci_dev
Date: Mon, 13 Jul 2026 15:25:43 +0800
Message-ID: <0CB2D8D715AB9933+20260713072543.3348755-1-raoxu@uniontech.com>
X-Mailer: git-send-email 2.50.1
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-QQ-SENDSIZE: 520
Feedback-ID: zesmtpgz:uniontech.com:qybglogicsvrgz:qybglogicsvrgz6b-0
X-QQ-XMAILINFO: NU4e3V92LJuQ9l5gE0EGAvqalUZ1/hFlYUh31zQ9FdX8lx6a86yPen5b
	EClUpMl2HJyNeydsSc88dqA3DqUIG2bCEJFUXeTCk+Subr3EtxXBCiGsUDYjqerUoqN6x3j
	HtnmVF+mw7Fzro35EsUUQ5lWT+5YLedGe/O3u+pThDonU03Hm+zZ9LDAOQYctTvbjUoXWIc
	wBX78JO77BAYFctuF3KK2Hy/C+wLn4R+Ihdq3iEkmgSllqqfj1i4r4l5qBTUX4em3EQ0cVy
	Czc9aD1m3JDD+lw0ZZw+/nlSbYo5Ba8uOTOpkfCIfNIq2YtResI0xSGBVmzeYqZLDk5DOQs
	jKqbEQBo3S2KzsplznS7NTf3Yn6Ic3DstKE48+7Nt/5vfz0SP3NoXTf/Y7o6VfOkFQr9jZN
	2/kivbhVF/mqlciZ7I1Nxiu0ZYm8uG88+FDwoCCwx9viC42IZ+Gujn+NCpCVCBCutt/Sfqn
	+PNIkPU5IHqvWQzg3hTf56dvZpTxK5iyWzNUe/UDaPvgpjQkJM+F2aIyU3xdvXmpnpuEU77
	55uha1gKN5ZTuSZuoXnYIDx8Nbt/OUeHgAkQvtcI+r2QqWoh9CDFasD59/fEjOWgXs7Mmaa
	WW7n7mupa4ZKtWajwtQZfBIteDRbbHW2ZVVr01rmMjGLciNgX10hHIkydJ25U3Z587W7qz6
	1oMg0es+9ol0fh8X4Tn0fzE1KZx7IOfHb/UDi4K5VrbSHZWZI2r9wDkqVjixfAUq/VvyEmp
	Y/QrEgUt6kayVzS/gpwFIjr/+aqKXOBU26xQTMAbs4l3dfTkESAdyqMuBH4AMa9+UVLfEb3
	ageoJkUNesXGGcIhGVcomwE/+7t5Dj3ZDkcGYzxTaDaFRhulbDxHVXcWBeYYwuz3URinldW
	rktJyltNuSxJ1heuaL8gk7eLiLhRgXcQHnT65t0i7zDkR0b6haIa2ysUlENjrNyf7o6DBTb
	Xx1JsU/V8STpz4TRok6P9io4jspzjV6YDwTq3QlsXHPB2Aw9wuCu1/JmBHApD3TM4vSuCxS
	J0s9//hbf8Lwfv3c/J9aPeA2gSyFsM0AfAkSsS8NRocvFNYM3WUL66iHXVHPIbdPM2wXjcB
	A==
X-QQ-XMRINFO: OWPUhxQsoeAVwkVaQIEGSKwwgKCxK/fD5g==
X-QQ-RECHKSPAM: 0

From: Xu Rao <raoxu@uniontech.com>

The command and ACL RPMsg endpoints store struct btqcomsmd as their
callback private data.  The receive callbacks dereference btq->hdev
without taking an hci_dev reference.

The current teardown order frees the hci_dev before destroying the RPMsg
endpoints in both the hci_register_dev() error path and the driver remove
path.  If WCNSS delivers data in that window, the endpoint callback can
run with an already freed hci_dev and pass it to the Bluetooth core.

For qcom_smd endpoints, rpmsg_destroy_ept() closes the channel and clears
the callback under the channel recv_lock.  The receive path holds the same
lock while invoking the callback, so destroying the endpoints first both
prevents new callbacks and serializes with any callback already running.

Destroy the command and ACL endpoints before hci_free_dev().  Keep
hci_unregister_dev() first during remove so the HCI core stops issuing
operations before the transport endpoints are shut down.  In the full
registration-error cleanup path, return directly after freeing the hci_dev
to avoid falling through to the partial-construction labels and destroying
the endpoints twice.

Fixes: 5052de8deff5 ("soc: qcom: smd: Transition client drivers from smd to rpmsg")
Fixes: 9a39a927be01 ("Bluetooth: btqcomsmd: Fix a resource leak in error handling paths in the probe function")
Cc: stable@vger.kernel.org
Signed-off-by: Xu Rao <raoxu@uniontech.com>
---
 drivers/bluetooth/btqcomsmd.c | 6 +++++-
 1 file changed, 5 insertions(+), 1 deletion(-)

diff --git a/drivers/bluetooth/btqcomsmd.c b/drivers/bluetooth/btqcomsmd.c
index d2e13fcb6bab..d669ea4eb3eb 100644
--- a/drivers/bluetooth/btqcomsmd.c
+++ b/drivers/bluetooth/btqcomsmd.c
@@ -188,7 +188,10 @@ static int btqcomsmd_probe(struct platform_device *pdev)
 	return 0;

 hci_free_dev:
+	rpmsg_destroy_ept(btq->cmd_channel);
+	rpmsg_destroy_ept(btq->acl_channel);
 	hci_free_dev(hdev);
+	return ret;
 destroy_cmd_channel:
 	rpmsg_destroy_ept(btq->cmd_channel);
 destroy_acl_channel:
@@ -202,10 +205,11 @@ static void btqcomsmd_remove(struct platform_device *pdev)
 	struct btqcomsmd *btq = platform_get_drvdata(pdev);

 	hci_unregister_dev(btq->hdev);
-	hci_free_dev(btq->hdev);

 	rpmsg_destroy_ept(btq->cmd_channel);
 	rpmsg_destroy_ept(btq->acl_channel);
+
+	hci_free_dev(btq->hdev);
 }

 static const struct of_device_id btqcomsmd_of_match[] = {
--
2.50.1

