Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=51.250.56.165
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1794986956;
	b=VH9j8Rh6Hq7pGNfaiHASLR7QgdlQs0pNPzDuSr2YxVkS5kFTxlhonVvGcBDj359kR1+A
	 Vf+aAozWnIm7KI9ywt5FtQW+fFBbWt9z3wCD9gIqcwc/yv+QiV+P02ukNdMCRQAMrM16s
	 4bH0KkBmn+pb2XoqgrYtynCcQMRt7sgoccDyvXLChnzYAxaAw3jiIdwMzevyMIoZMx9xW
	 /0FZeYdpfCcT1qCT38Sto2zzJYIsPULj91Ir4l57OU8S50xPcm972b0cBR17+3H5IuAGm
	 vpe5ZWg+WqhwBjgy+OU+DPqrEIu61Sd20Uw9Lq6+7oRNQxyFSugbYWwDjQGLZd756dg==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1794986956;
	h=DMARC-Filter:Received:Received:DKIM-Filter:DKIM-Signature:From:To:Cc:
	 Subject:Date:Message-ID:X-Mailer:MIME-Version:
	 Content-Transfer-Encoding;
	bh=FdJ71Vw//fMcipdbWiSKxx1q6kfXMoaJMvIEeY+EiAk=;
	b=Xgdzgju0IFMeoPrllW8tGZ8cBITUEw3nnran8RNa7qHT2iXMylKFtFsabTFDMVILjN0x
	 PT8QliJnBzlP/QFER1/CbI48LWiNO4HebdkaO3DOnCdMDtpYRMSV/nNudtIwMKW/SQwgL
	 I9dbikua47T7j49I2/l4EERpuKbZZus24iDRXdubr+x/iZk/9qgBW1eZghoa1csXzGVCb
	 YLa5qM2PvZF3bvQJ+ErVPv6JArAY/8zQvckqdrYEUErlvpZ9/FNFAvMZBEb74CdcOIb7H
	 5dvQqFuERaZDcqVgri0Gjr3Vx6AXJG+fzeljI2zIZwEIqpRFWNX3YCGoW9fINn350lQ==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=ideco.ru;
	spf=pass smtp.mailfrom=ideco.ru;
	dkim=pass header.d=ideco.ru header.i=@ideco.ru header.a=rsa-sha256 header.s=ics header.b=VfXmx7W0;
	arc=none smtp.remote-ip=51.250.56.165
Received: from smtp.ideco.ru (smtp.ideco.ru [51.250.56.165])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 939DF606A31C;
	Wed, 18 Nov 2026 07:29:15 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 939DF606A31C
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=ideco.ru
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=ideco.ru
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=ideco.ru header.i=@ideco.ru header.a=rsa-sha256 header.s=ics header.b=VfXmx7W0
Received: from [169.254.254.254] (localhost [127.0.0.1])
	by smtp.ideco.ru (Postfix) with ESMTP id 8FACD26BC0;
	Wed, 18 Nov 2026 12:29:06 +0500 (+05)
Received: from fedora (5cfcd9fa.dynamic.mv.ru [92.252.217.250])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange x25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by smtp.ideco.ru (Postfix) with ESMTPSA id 2CEDB26BC5;
	Wed, 18 Nov 2026 12:29:04 +0500 (+05)
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp.ideco.ru 2CEDB26BC5
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ideco.ru; s=ics;
	t=1794986945; bh=FdJ71Vw//fMcipdbWiSKxx1q6kfXMoaJMvIEeY+EiAk=;
	h=From:To:Cc:Subject:Date;
	b=VfXmx7W0sL3gKH6r0keBxbX5Y00Kt9kaoopxDQkcJcEygtoOsqu0UdluJxHqdoR+f
	 Iz5d6T9YpXa38/vqlsjoZz6bo40HO62COV1XXhC55pNyPVXrfEEkek++DCmoq+fP+n
	 jOFR+2/wp+YV2MeHtWmZ9NaWe8WoatVCDnN+yd3IyiJwMga+Ed1bXQypXuCNg3vapt
	 scjNlWD0/+4r8cDyPS3JnjQ6JiRmLgnU0mYEoGf3ubJC2oWiMt9N2yeQgvZuO19ow8
	 MDp57NvnWdvArTJc0QROy6wUPQdK8Tfk7MIHczm+XlKwxyNT1UAHxZaQEn63t9Q06Z
	 pQ4HMXzlX45UQ==
From: Alex Kazinsky <a.kazinsky@ideco.ru>
To: Daniel Thompson <danielt@kernel.org>
Cc: Alex Kazinsky <a.kazinsky@ideco.ru>,
	Douglas Anderson <dianders@chromium.org>,
	Naveen Kumar Chaudhary <naveen.osdev@gmail.com>,
	Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
	Tim Bird <tim.bird@sony.com>,
	Martin Hicks <mort@sgi.com>,
	kgdb-bugreport@lists.sourceforge.net,
	linux-kernel@vger.kernel.org,
	lvc-project@linuxtesting.org,
	stable@vger.kernel.org
Subject: [PATCH v2] kdb: Reject non-positive BYTESPERWORD before division
Date: Wed, 18 Nov 2026 11:28:52 +0400
Message-ID: <20261118072853.1578323-1-a.kazinsky@ideco.ru>
X-Mailer: git-send-email 2.56.0
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

kdb_md() uses BYTESPERWORD as a divisor when calculating the initial
repeat count, before validating the word width. A zero width causes a
division by zero. kdbgetintenv() also casts an unsigned long to int,
so the resulting width can be negative. If the width is -1 and the
scaled count is INT_MIN, the quotient overflows and raises a divide
error on x86.

Return KDB_BADWIDTH for non-positive widths before calculating the
repeat count.

Found by Linux Verification Center (linuxtesting.org) with SVACE static
analysis tool.

Fixes: 5d5314d6795f ("kdb: core for kgdb back end (1 of 2)")
Cc: stable@vger.kernel.org
Signed-off-by: Alex Kazinsky <a.kazinsky@ideco.ru>
---
v1: https://lore.kernel.org/all/20261113111152.4190309-1-a.kazinsky@ideco.ru/

Changes in v2:
- Reject negative BYTESPERWORD values as well as zero.
- Explain the signed division overflow in the commit message.

 kernel/debug/kdb/kdb_main.c | 3 +++
 1 file changed, 3 insertions(+)

diff --git a/kernel/debug/kdb/kdb_main.c b/kernel/debug/kdb/kdb_main.c
index 40c332d2179d..b1719382144b 100644
--- a/kernel/debug/kdb/kdb_main.c
+++ b/kernel/debug/kdb/kdb_main.c
@@ -1527,6 +1527,9 @@ static int kdb_md(int argc, const char **argv)
 	kdbgetintenv("RADIX", &radix);
 	kdbgetintenv("BYTESPERWORD", &bytesperword);
 
+	if (bytesperword <= 0)
+		return KDB_BADWIDTH;
+
 	/* Assume 'md <addr>' and start with environment values */
 	repeat = mdcount * 16 / bytesperword;
 

