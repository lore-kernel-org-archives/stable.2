Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=115.124.28.49
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1793695312;
	b=OGNzjq3k7bXpUkPThQgikoX4QmCUiC2AzUVFDiZcs1sNPEv0BMd1AsHpPqinr4lp2ke/
	 WpI1aIDM6s0ulYFBMNNnO8yaYfjk00dnsrquuOvHi3eV4jA282iz1ecS5ugZmkP6Stq5O
	 lLg1iEkyHef1Nfbgdpj7oIhcG23XMIb57F5w8HO4foJx6xJzzZ4oMopdpyKk/Lr7jCk3x
	 2QhOWUUYn9/OfRq2uccWsSLYkEhNSEUEZ4M6JdtiSc5j82J0tswHgq+2mss3l8Y3aLdTc
	 p3J+RW0hVEfcV0OfOM5IMCymbKd/7Jbka1eFv5O6Rg2pkoqJQKV6fwvl5t5d0UfnPQA==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1793695312;
	h=DMARC-Filter:DKIM-Signature:X-Alimail-AntiSpam:Received:From:To:Cc:
	 Subject:Date:Message-ID:X-Mailer:In-Reply-To:References:MIME-Version:
	 Content-Transfer-Encoding;
	bh=8CIrgaXndQnqL2HM+oSlJz+sPXUA2Zb6s1i/b+BZtis=;
	b=GTjwuPcYlNCnVxKSAblB7sC/HlY75yvybEdKn2VEhrBW7GFx91xCI7I2fDdnHGuXaQAq
	 w0Lovmu6TrtiOTgmLjyAJjhlfj0gvruFNrAvssMkJYvyzAtt22ihIQQDepfPPTbWiQyEb
	 x2FY0YafbyYRwLongLUzKXltUMaGbyuV8b8VHit2oEsW3Vmw1xvkDVgddQ/3tHTzTlNbx
	 7sOSPvp2pkGgUJqM66uohPwHFRppB+vZgtsgMNqMM6+xV0PjySZESAL7N0VCqA7nqEfqB
	 ytgYCvaY6X+25YfLm8vOYg4HGQTPLwow8fKUQ/bABl8l4oHlufQCjOszpPrlMI8tXAg==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=none header.from=xiaopeng.com;
	spf=pass smtp.mailfrom=xiaopeng.com;
	dkim=pass header.d=xiaopeng.com header.i=@xiaopeng.com header.a=rsa-sha256 header.s=default header.b=BGzFdAnd;
	arc=none smtp.remote-ip=115.124.28.49
Received: from out28-49.mail.aliyun.com (out28-49.mail.aliyun.com [115.124.28.49])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4DF64606A326;
	Tue,  3 Nov 2026 08:41:44 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 4DF64606A326
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=xiaopeng.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=xiaopeng.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key, unprotected) header.d=xiaopeng.com header.i=@xiaopeng.com header.a=rsa-sha256 header.s=default header.b=BGzFdAnd
DKIM-Signature:v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=xiaopeng.com; s=default;
	t=1793695297; h=From:To:Subject:Date:Message-ID:MIME-Version;
	bh=8CIrgaXndQnqL2HM+oSlJz+sPXUA2Zb6s1i/b+BZtis=;
	b=BGzFdAndbaxDTxrjytVOJpP0vb4wCbyMTkialOSYhOdz3q8puqv2kgWb15vHtRVSpM3LZk+Qf9NZIUX2wVS/vAkzD8+jGg8VxapL5AvD7OsHdegLXzEqoNqVdmZGwCfpkODCacG5XgD3Ar+JqaPOdRhHjzTqf/7V22S5fImvLe0=
X-Alimail-AntiSpam:AC=CONTINUE;BC=0.07682214|-1;CH=green;DM=|CONTINUE|false|;DS=CONTINUE|ham_system_inform|0.00414259-0.00043581-0.995422;FP=10121813016418332378|0|0|0|0|-1|-1|-1;HT=maildocker-contentspam033037033194;MF=zhugl3@xiaopeng.com;NM=1;PH=DS;RN=5;RT=5;SR=0;TI=SMTPD_---.jvUy9Da_1793695296;
Received: from DESKTOP-UL5U09E.xiaopeng.local(mailfrom:zhugl3@xiaopeng.com fp:SMTPD_---.jvUy9Da_1793695296 cluster:ay29)
          by smtp.aliyun-inc.com;
          Tue, 03 Nov 2026 16:41:37 +0800
From: Guanglei Zhu <zhugl3@xiaopeng.com>
To: dmitry.torokhov@gmail.com
Cc: linux-input@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	liuc63@xiaopeng.com,
	stable@vger.kernel.org
Subject: [PATCH] Input: db9 - enlarge the Saturn multitap packet buffer
Date: Tue,  3 Nov 2026 16:41:31 +0800
Message-ID: <20261103084135.426629-4-zhugl3@xiaopeng.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20261103084135.426629-1-zhugl3@xiaopeng.com>
References: <20261103084135.426629-1-zhugl3@xiaopeng.com>
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

The Saturn multitap path fills the packet buffer block by block:

	for (i = 0; i < 60; i += 10) {
		data[i] = db9_saturn_read_analog(port, type, powered);
		if (data[i] != 0xff)
			/* read each pad */
			for (j = 0; j < (data[i] & 0x0f); j++)
				data[i + j + 1] = db9_saturn_read_analog(port, type, powered);
	}

Each block is ten bytes apart, and the low nibble of the block
header - taken from the device - allows up to fifteen more bytes,
so the last block can write up to data[65]. The buffer, however,
is sixty bytes, and the six bytes past it belong to the rest of
the stack frame.

Give the buffer the size the protocol layout actually requires.

Fixes: 1da177e4c3f4 ("Linux-2.6.12-rc2")
Cc: stable@vger.kernel.org
Signed-off-by: Guanglei Zhu <zhugl3@xiaopeng.com>
---
 drivers/input/joystick/db9.c | 5 +++--
 1 file changed, 3 insertions(+), 2 deletions(-)

diff --git a/drivers/input/joystick/db9.c b/drivers/input/joystick/db9.c
index e5d9b71aab99..73d1e7a296bb 100644
--- a/drivers/input/joystick/db9.c
+++ b/drivers/input/joystick/db9.c
@@ -253,7 +253,8 @@ static unsigned char db9_saturn_read_packet(struct parport *port, unsigned char
 /*
  * db9_saturn_report() analyzes packet and reports.
  */
-static int db9_saturn_report(unsigned char id, unsigned char data[60], struct input_dev *devs[], int n, int max_pads)
+static int db9_saturn_report(unsigned char id, unsigned char data[66],
+			      struct input_dev *devs[], int n, int max_pads)
 {
 	struct input_dev *dev;
 	int tmp, i, j;
@@ -321,7 +322,7 @@ static int db9_saturn_report(unsigned char id, unsigned char data[60], struct in
 
 static int db9_saturn(int mode, struct parport *port, struct input_dev *devs[])
 {
-	unsigned char id, data[60];
+	unsigned char id, data[66];
 	int type, n, max_pads;
 	int tmp, i;
 
-- 
2.50.1

