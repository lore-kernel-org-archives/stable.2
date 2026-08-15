Received: from cstnet.cn (smtp25.cstnet.cn [159.226.251.25])
	(using TLSv1.2 with cipher DHE-RSA-AES256-SHA (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3077323643F;
	Sat, 15 Aug 2026 13:48:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=159.226.251.25
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1786801716; cv=none; b=c5Ar6IK/7o4lThzsCXzNGFFB6TxUINOl3Tcon/2NFBqqeh5u5QBJspril6c9fOy+l4fwZU1TGij5t2hdP8qxXmyXQZoN0Ah6iI0cWiSaTq8HgQi9BEXs8qzvhCYsc9v1REnGcD4g0MYmiAINhhfmuk4fSyyaVpTlGXzXCF1T/OE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1786801716; c=relaxed/simple;
	bh=7UV2D4vpN/KBruWZwdioP8alSCGT965QmckpccyECIc=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version:Content-Type; b=r8gszftMj2m+cIn2iH4JFRijMeWu/MdDtaHtI2My7WXdrxgxAWI6myHGIJky52OB8oX+0jqz/AQ/KgRRkZMq0pHjV4sGHLdVcnAvtU5uGyqoPj4H753CiAnF0HMF/pEA0FN7aEoJTMeGGKUEfxi49VKINbuqvHrW9uUrRJLzIGQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=iscas.ac.cn; spf=pass smtp.mailfrom=iscas.ac.cn; arc=none smtp.client-ip=159.226.251.25
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=iscas.ac.cn
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=iscas.ac.cn
Received: from localhost.localdomain (unknown [111.196.241.250])
	by APP-05 (Coremail) with SMTP id zQCowAAHcTspboBqB13RBQ--.2466S2;
	Sat, 15 Aug 2026 21:48:25 +0800 (CST)
From: Pengpeng Hou <pengpeng@iscas.ac.cn>
To: david@ixit.cz
Cc: Pengpeng Hou <pengpeng@iscas.ac.cn>,
	Kees Cook <kees@kernel.org>,
	Doruk Tan Ozturk <doruk@0sec.ai>,
	Eric Lapuyade <eric.lapuyade@linux.intel.com>,
	Samuel Ortiz <sameo@linux.intel.com>,
	oe-linux-nfc@lists.linux.dev,
	linux-kernel@vger.kernel.org,
	stable@vger.kernel.org
Subject: [PATCH v3] nfc: microread: validate target discovery payload lengths
Date: Sat, 15 Aug 2026 21:48:25 +0800
Message-ID: <20260815134825.48593-1-pengpeng@iscas.ac.cn>
X-Mailer: git-send-email 2.50.1
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 8bit
X-CM-TRANSID:zQCowAAHcTspboBqB13RBQ--.2466S2
X-Coremail-Antispam: 1UD129KBjvJXoWxJFyrZrWkKFyDKw1xCrW3Jrb_yoWrAr1Dpa
	yUWr1DKrW5JrW7Gw13ZFn7ZF1UJw4xuwsF9F1xJwsaya1Yk34DJas3W3y2vF4UAF98urW2
	kF1vv39xGa9rAa7anT9S1TB71UUUUU7qnTZGkaVYY2UrUUUUjbIjqfuFe4nvWSU5nxnvy2
	9KBjDU0xBIdaVrnRJUUUkE14x267AKxVW8JVW5JwAFc2x0x2IEx4CE42xK8VAvwI8IcIk0
	rVWrJVCq3wAFIxvE14AKwVWUJVWUGwA2ocxC64kIII0Yj41l84x0c7CEw4AK67xGY2AK02
	1l84ACjcxK6xIIjxv20xvE14v26r4j6ryUM28EF7xvwVC0I7IYx2IY6xkF7I0E14v26F4j
	6r4UJwA2z4x0Y4vEx4A2jsIE14v26F4UJVW0owA2z4x0Y4vEx4A2jsIEc7CjxVAFwI0_Cr
	1j6rxdM2AIxVAIcxkEcVAq07x20xvEncxIr21l5I8CrVACY4xI64kE6c02F40Ex7xfMcIj
	6xIIjxv20xvE14v26r126r1DMcIj6I8E87Iv67AKxVWUJVW8JwAm72CE4IkC6x0Yz7v_Jr
	0_Gr1lF7xvr2IYc2Ij64vIr41lF7I21c0EjII2zVCS5cI20VAGYxC7MxkF7I0En4kS14v2
	6r1q6r43MxAIw28IcxkI7VAKI48JMxC20s026xCaFVCjc4AY6r1j6r4UMI8I3I0E5I8CrV
	AFwI0_Jr0_Jr4lx2IqxVCjr7xvwVAFwI0_JrI_JrWlx4CE17CEb7AF67AKxVWUtVW8ZwCI
	c40Y0x0EwIxGrwCI42IY6xIIjxv20xvE14v26r1j6r1xMIIF0xvE2Ix0cI8IcVCY1x0267
	AKxVWxJVW8Jr1lIxAIcVCF04k26cxKx2IYs7xG6r1j6r1xMIIF0xvEx4A2jsIE14v26r1j
	6r4UMIIF0xvEx4A2jsIEc7CjxVAFwI0_Gr0_Gr1UYxBIdaVFxhVjvjDU0xZFpf9x0JUL0e
	dUUUUU=
X-CM-SenderInfo: pshqw1xhqjqxpvfd2hldfou0/

microread_target_discovered() parses target discovery payloads from
skb->data according to the HCI gate. The fixed field offsets and UID
copies were checked only against the destination nfc_target buffers, not
against the actual skb length.

Validate that each gate-specific payload contains the fixed fields and
UID bytes before reading or copying them.

Fixes: cfad1ba87150 ("NFC: Initial support for Inside Secure microread")
Cc: stable@vger.kernel.org
Assisted-by: Codex:gpt-5
Signed-off-by: Pengpeng Hou <pengpeng@iscas.ac.cn>
---
Changes since v2:
https://lore.kernel.org/all/20260723103508.1-microread-v2-pengpeng@iscas.ac.cn/
- no code changes
- revalidate the patch against current mainline
- add the required coding-assistant attribution

Changes since v1:
https://lore.kernel.org/all/20260701053709.45176-1-pengpeng@iscas.ac.cn/
- add the Fixes tag and stable Cc requested during review
- rebase onto the current net tree

 drivers/nfc/microread/microread.c | 31 +++++++++++++++++++++++++++++--
 1 file changed, 29 insertions(+), 2 deletions(-)

diff --git a/drivers/nfc/microread/microread.c b/drivers/nfc/microread/microread.c
index 4149c5d735bd..dfa2490db545 100644
--- a/drivers/nfc/microread/microread.c
+++ b/drivers/nfc/microread/microread.c
@@ -483,13 +483,19 @@ static void microread_target_discovered(struct nfc_hci_dev *hdev, u8 gate,
 
 	switch (gate) {
 	case MICROREAD_GATE_ID_MREAD_ISO_A:
+		if (skb->len <= MICROREAD_EMCF_A_LEN) {
+			r = -EINVAL;
+			goto exit_free;
+		}
+
 		targets->supported_protocols =
 		      nfc_hci_sak_to_protocol(skb->data[MICROREAD_EMCF_A_SAK]);
 		targets->sens_res =
 			 be16_to_cpu(*(u16 *)&skb->data[MICROREAD_EMCF_A_ATQA]);
 		targets->sel_res = skb->data[MICROREAD_EMCF_A_SAK];
 		targets->nfcid1_len = skb->data[MICROREAD_EMCF_A_LEN];
-		if (targets->nfcid1_len > sizeof(targets->nfcid1)) {
+		if (targets->nfcid1_len > sizeof(targets->nfcid1) ||
+		    targets->nfcid1_len > skb->len - MICROREAD_EMCF_A_UID) {
 			r = -EINVAL;
 			goto exit_free;
 		}
@@ -497,13 +503,19 @@ static void microread_target_discovered(struct nfc_hci_dev *hdev, u8 gate,
 		       targets->nfcid1_len);
 		break;
 	case MICROREAD_GATE_ID_MREAD_ISO_A_3:
+		if (skb->len <= MICROREAD_EMCF_A3_LEN) {
+			r = -EINVAL;
+			goto exit_free;
+		}
+
 		targets->supported_protocols =
 		      nfc_hci_sak_to_protocol(skb->data[MICROREAD_EMCF_A3_SAK]);
 		targets->sens_res =
 			 be16_to_cpu(*(u16 *)&skb->data[MICROREAD_EMCF_A3_ATQA]);
 		targets->sel_res = skb->data[MICROREAD_EMCF_A3_SAK];
 		targets->nfcid1_len = skb->data[MICROREAD_EMCF_A3_LEN];
-		if (targets->nfcid1_len > sizeof(targets->nfcid1)) {
+		if (targets->nfcid1_len > sizeof(targets->nfcid1) ||
+		    targets->nfcid1_len > skb->len - MICROREAD_EMCF_A3_UID) {
 			r = -EINVAL;
 			goto exit_free;
 		}
@@ -511,11 +523,21 @@ static void microread_target_discovered(struct nfc_hci_dev *hdev, u8 gate,
 		       targets->nfcid1_len);
 		break;
 	case MICROREAD_GATE_ID_MREAD_ISO_B:
+		if (skb->len < MICROREAD_EMCF_B_UID + 4) {
+			r = -EINVAL;
+			goto exit_free;
+		}
+
 		targets->supported_protocols = NFC_PROTO_ISO14443_B_MASK;
 		memcpy(targets->nfcid1, &skb->data[MICROREAD_EMCF_B_UID], 4);
 		targets->nfcid1_len = 4;
 		break;
 	case MICROREAD_GATE_ID_MREAD_NFC_T1:
+		if (skb->len < MICROREAD_EMCF_T1_UID + 4) {
+			r = -EINVAL;
+			goto exit_free;
+		}
+
 		targets->supported_protocols = NFC_PROTO_JEWEL_MASK;
 		targets->sens_res =
 			le16_to_cpu(*(u16 *)&skb->data[MICROREAD_EMCF_T1_ATQA]);
@@ -523,6 +545,11 @@ static void microread_target_discovered(struct nfc_hci_dev *hdev, u8 gate,
 		targets->nfcid1_len = 4;
 		break;
 	case MICROREAD_GATE_ID_MREAD_NFC_T3:
+		if (skb->len < MICROREAD_EMCF_T3_UID + 8) {
+			r = -EINVAL;
+			goto exit_free;
+		}
+
 		targets->supported_protocols = NFC_PROTO_FELICA_MASK;
 		memcpy(targets->nfcid1, &skb->data[MICROREAD_EMCF_T3_UID], 8);
 		targets->nfcid1_len = 8;

base-commit: dac3e89a2c90c2feeb471e1f22a2512ad424b792
-- 
2.50.1 (Apple Git-155)

