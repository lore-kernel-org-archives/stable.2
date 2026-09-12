Received: from out28-173.mail.aliyun.com (out28-173.mail.aliyun.com [115.124.28.173])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id EF46B37FF60;
	Sat, 12 Sep 2026 11:57:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=115.124.28.173
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1789214256; cv=none; b=kkV4/j2uJh6iyGiBzUvwG3K3IX//lN1stOCUsfIst4XdPxY/KerzI1b5mBXwvCYS0OB134Egi1M2v/Uz2Qv3j10psoltjdV3JVh3bOawor+xA9cEWu66luu1AG4B8XZZcEvH3OHsSzYGkMWX2uxfLovILgR5sZGKyd/kMpfanxw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1789214256; c=relaxed/simple;
	bh=oxnaw/S07fLZLNhfUCmG8Jdfft9O1LmkILUr998ltG0=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=YWCrAow+l6qEl+s185Tf4Dubli/q82VRhB/9l3NV/uyPvmypccfEsHwikRhHKy6MHpeAKJCeCqJQoSeoIQRW9CYKW9djbMod22hJCa8sHXdKalQTSvgOQ+kpM8fn3ziPyMrElcp0PVp0Fl/5LApwXpFiAebknJzBXHVZInsqBLU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=xiaopeng.com; spf=pass smtp.mailfrom=xiaopeng.com; dkim=pass (1024-bit key) header.d=xiaopeng.com header.i=@xiaopeng.com header.b=dwoFo4OL; arc=none smtp.client-ip=115.124.28.173
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=xiaopeng.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=xiaopeng.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=xiaopeng.com header.i=@xiaopeng.com header.b="dwoFo4OL"
DKIM-Signature:v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=xiaopeng.com; s=default;
	t=1789214244; h=From:To:Subject:Date:Message-ID:MIME-Version;
	bh=1dmRRpmX7RaifRKwzqGF3Fys4RZt3UY5YzhrH7tJyOg=;
	b=dwoFo4OL+itgG3gQroTAdkNsgt9ihk5c8IjvRG8PKZFgNsWa1noDldiffr4GVqLd/kvX1zX/AKkHVi/Z/jT0TtNB1WKZ5oiNMkQuHWP3aMeZ06bxsGSddfm5W5rN3Mo6ozQZVBpM/GhMzpScS250/E352Uc7FMLDimQA7xdDj1Y=
X-Alimail-AntiSpam:AC=CONTINUE;BC=0.1221488|-1;CH=green;DM=|CONTINUE|false|;DS=CONTINUE|ham_regular_dialog|0.00565148-0.00223755-0.992111;FP=12569559143964794011|0|0|0|0|-1|-1|-1;HT=maildocker-contentspam033037071049;MF=liuc63@xiaopeng.com;NM=1;PH=DS;RN=12;RT=12;SR=0;TI=SMTPD_---.jC.MeCA_1789214242;
Received: from localhost(mailfrom:liuc63@xiaopeng.com fp:SMTPD_---.jC.MeCA_1789214242 cluster:ay29)
          by smtp.aliyun-inc.com;
          Sat, 12 Sep 2026 19:57:23 +0800
From: Liu Chao <liuc63@xiaopeng.com>
To: David Heidelberg <david@ixit.cz>
Cc: "David S . Miller" <davem@davemloft.net>,
	Eric Dumazet <edumazet@google.com>,
	Jakub Kicinski <kuba@kernel.org>,
	Paolo Abeni <pabeni@redhat.com>,
	Simon Horman <horms@kernel.org>,
	Dan Carpenter <dan.carpenter@linaro.org>,
	oe-linux-nfc@lists.linux.dev,
	netdev@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	Liu Chao <liuc63@xiaopeng.com>,
	stable@vger.kernel.org
Subject: [PATCH net] nfc: hci: add bounds checking in nfc_hci_create_pipe()
Date: Sat, 12 Sep 2026 19:57:20 +0800
Message-ID: <20260912115720.530715-1-liuc63@xiaopeng.com>
X-Mailer: git-send-email 2.50.1
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

The "pipe" value comes from the controller ADM_CREATE_PIPE response
and can be anything in the 0-255 range, while hdev->pipes[] only has
NFC_HCI_MAX_PIPES (128) entries.  A response carrying a pipe id above
127 makes the caller, nfc_hci_connect_gate(), write past the end of
hdev->pipes[].

The response length is also not validated before the cast to struct
hci_create_pipe_resp, so a short response leads to reading past the
end of the received data.

The notification path in nfc_hci_cmd_received() already validates both
the length and the pipe id for the very same structure; do the same
for the command response path.  Set *result so that the caller does
not mistake a rejected pipe for success, which is why this differs
slightly from the NCI side fix, commit 110b43ef0534 ("NFC: nci: Add
bounds checking in nci_hci_create_pipe()").

Fixes: 118278f20aa8 ("NFC: hci: Add pipes table to reference them with a tuple {gate, host}")
Cc: stable@vger.kernel.org
Signed-off-by: Liu Chao <liuc63@xiaopeng.com>
---
 net/nfc/hci/command.c | 9 +++++++++
 1 file changed, 9 insertions(+)

diff --git a/net/nfc/hci/command.c b/net/nfc/hci/command.c
index af6bacb3b..9c8bcb98b 100644
--- a/net/nfc/hci/command.c
+++ b/net/nfc/hci/command.c
@@ -225,10 +225,19 @@ static u8 nfc_hci_create_pipe(struct nfc_hci_dev *hdev, u8 dest_host,
 	if (*result < 0)
 		return NFC_HCI_INVALID_PIPE;
 
+	if (skb->len < sizeof(*resp)) {
+		kfree_skb(skb);
+		*result = -EPROTO;
+		return NFC_HCI_INVALID_PIPE;
+	}
 	resp = (struct hci_create_pipe_resp *)skb->data;
 	pipe = resp->pipe;
 	kfree_skb(skb);
 
+	if (pipe >= NFC_HCI_MAX_PIPES) {
+		*result = -EINVAL;
+		return NFC_HCI_INVALID_PIPE;
+	}
 	pr_debug("pipe created=%d\n", pipe);
 
 	return pipe;

base-commit: e6b6078ea1731b05b3b552497b3bce4bf8b014ae
-- 
2.50.1

