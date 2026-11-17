Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=111.22.67.135
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1794886187;
	b=pTeDrdsDW1BJxnn3l8HszW/hQLNtrHUsq1Jwg1dirpseQqlTFHxRtkbb2Oexi0/b9ho3
	 IEF3rn9oY1gk/g4VbSU/l0Es6U2fhBvmgsiQwANpTpgMxqq3vTvcYC5QjhxRz/fJEDPDz
	 HyDcWFTTa54+ev8G6xqCSBoroMNzOQWDB4alE4sbyxwPCALECWArumo9Nr0jDpOT4UO6x
	 peNbB03HkWxSYiQ6sSOu+Y1n287b4I6uH3erq/JgT8jUSxBB7X6nxY76xE9f9NIBKC2tC
	 ElgHY2FEn4x7ZH8Ves/zuCScDRqSZZh6beMt1zf6mdd/1/j7Kk4EB08gI5ZQLiWR5bw==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1794886187;
	h=DMARC-Filter:DKIM-Signature:X-RM-TagInfo:X-RM-SPAM-FLAG:Received:
	 X-RM-TRANSID:X-RM-TagInfo:X-RM-SPAM-FLAG:Received:X-RM-TRANSID:From:
	 To:Cc:Subject:Date:Message-ID:X-Mailer:MIME-Version:
	 Content-Transfer-Encoding;
	bh=Y8wKiGuzX25eLnanDcoXEPChhaOMr2nZTEmPGyBD0hw=;
	b=uuYWKGfiT2r4aN/SK22iXcpQyFcyr8IpvCNvY7LeSSWgNvdW9hZKbyfypfCdw7eVIOTw
	 x81e1q5D8NLlGG6KjFRCYUnWMCaT5M8dPr411Vh4rqvmagfSAf0fLqfwdi8WbNS/uBSiH
	 tIqnv4fsu0FXXTAzTU1bhv64OEACujKQJG2ecl32HgZTHYrSP1hBYFI7YMZHuEUMtRxGJ
	 Fw79YrRfjbAufsdHLXiEwnizc55QkUoD/XOKoK8ZYOgBNXiDeWgrztdR05yvWasA/+Ki5
	 f3IswMJaGS9P8xE/SNISyIy1Tjar5Se5CE0OMB1XU3mTcXbINd+Nf30Fszt/nrLhoUg==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=cmss.chinamobile.com;
	spf=pass smtp.mailfrom=cmss.chinamobile.com;
	dkim=pass header.d=cmss.chinamobile.com header.i=@cmss.chinamobile.com header.a=rsa-sha256 header.s=default header.b=vvq+Ezog;
	arc=none smtp.remote-ip=111.22.67.135
Received: from cmccmta2.chinamobile.com (cmccmta2.chinamobile.com [111.22.67.135])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 9C12F606A8AD;
	Tue, 17 Nov 2026 03:29:40 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 9C12F606A8AD
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=cmss.chinamobile.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=cmss.chinamobile.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=cmss.chinamobile.com header.i=@cmss.chinamobile.com header.a=rsa-sha256 header.s=default header.b=vvq+Ezog
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=cmss.chinamobile.com; s=default; l=0;
	h=from:subject:message-id:to:cc:mime-version;
	bh=47DEQpj8HBSa+/TImW+5JCeuQeRkm5NMpJWZG3hSuFU=;
	b=vvq+Ezog5SoOviNJNBNIk+grJ6fyhK+IwTXMIwWM+xN3CXZeDyzhvHFrUMMFLMHozttCyJddbzR5E
	 3YwpX5eqBgMSWmhKjlyQxNUK4jf+a4uSTdy5sF17ZjmjoxuoCL6CpP1LCyPz/VjUpFFLmg804PTGuw
	 d6+J/5LZJeILVTbs=
X-RM-TagInfo: emlType=0                                       
X-RM-SPAM-FLAG:00000000
Received:from spf.mail.chinamobile.com (unknown[10.188.0.87])
	by rmmx-syy-dmz-app07-12007 (RichMail) with SMTP id 2ee76afbca22e95-05c60;
	Tue, 17 Nov 2026 11:29:38 +0800 (CST)
X-RM-TRANSID:2ee76afbca22e95-05c60
X-RM-TagInfo: emlType=0                                       
X-RM-SPAM-FLAG:00000000
Received:from localhost.localdomain (unknown[223.112.32.189])
	by rmsmtp-syy-appsvr02-12002 (RichMail) with SMTP id 2ee26afbca214b2-a19cf;
	Tue, 17 Nov 2026 11:29:38 +0800 (CST)
X-RM-TRANSID:2ee26afbca214b2-a19cf
From: guohongyu <guohongyu@cmss.chinamobile.com>
To: lachlan.hodges@morsemicro.com,
	dan.callaghan@morsemicro.com,
	arien.judge@morsemicro.com,
	johannes@sipsolutions.net
Cc: linux-wireless@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	stable@vger.kernel.org,
	13057616121@163.com
Subject: [PATCH 1/2] wifi: mm81x: clamp command-response copy to the received skb length
Date: Tue, 17 Nov 2026 11:22:26 +0800
Message-ID: <20261117032227.154874-1-guohongyu@cmss.chinamobile.com>
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

mm81x_cmd_resp_process() copies a synchronous command response from
the received skb into the caller-provided buffer:

	length = min_t(int, length,
		       le16_to_cpu(src_resp->hdr.len) +
			       sizeof(struct host_cmd_header));
	memcpy(dest_resp, src_resp, length);

src_resp->hdr.len is the inner host_cmd_header length of the firmware
response.  The skb, however, was sized by the *outer* mm81x_skb_hdr.len
(mm81x_yaps_read_pkt(), yaps.c:186-199: skb_len = sizeof(*hdr) +
hdr->offset + le16_to_cpu(hdr->len); skb_trim(skb, skb_len)), and
nothing ties the inner header length to the outer one.  A buggy or
malicious firmware can therefore declare an inner hdr.len far larger
than the payload actually present, and the memcpy reads past the end of
the skb's data into adjacent heap memory, leaking it into the command
response buffer.

Clamp the copy to skb->len so we never read past the data actually
received.

Fixes: b1906cea00b0 ("wifi: mm81x: add mm81x Wi-Fi HaLow driver")
Cc: stable@vger.kernel.org
Signed-off-by: guohongyu <guohongyu@cmss.chinamobile.com>
---
 drivers/net/wireless/morsemicro/mm81x/command.c | 1 +
 1 file changed, 1 insertion(+)

diff --git a/drivers/net/wireless/morsemicro/mm81x/command.c b/drivers/net/wireless/morsemicro/mm81x/command.c
index afb7ee9bb236..591e5ba10753 100644
--- a/drivers/net/wireless/morsemicro/mm81x/command.c
+++ b/drivers/net/wireless/morsemicro/mm81x/command.c
@@ -209,6 +209,7 @@ int mm81x_cmd_resp_process(struct mm81x *mors, struct sk_buff *skb)
 		length = min_t(int, length,
 			       le16_to_cpu(src_resp->hdr.len) +
 				       sizeof(struct host_cmd_header));
+		length = min_t(int, length, skb->len);
 		memcpy(dest_resp, src_resp, length);
 	} else {
 		ret = le32_to_cpu(src_resp->status);
-- 
2.43.0



