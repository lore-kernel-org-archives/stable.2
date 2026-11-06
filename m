Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=115.124.28.196
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1793929791;
	b=p4BX1EGMNBBYvBi4FmNNpXs9iYUgq/nQq4W91Ff+RT4ecSk+4IT5rzFe3oABIC5OdK/D
	 mIoRlh9WTimzMU3/gQtTRq7eFmo0DHyBpxZPcu3I7eCw/kHauxjw3xN9o/+WgYsuUpAt0
	 Dl2/sEV9nICRITqZjYmIYhykcQc+nFa3ANcV/CMNY+MQd88RWWr77MaAOQm3DGY1DEI0c
	 73oQ3v97839jnDYncUCT5yZRoY84VWOEP7QSSfKEFxGlXvYLb0dGpNrdn2MvYv/Nw2nzW
	 SUM/ieVHiW5rA9rbwuhLXbWwD1nuHZ+lZXM/VjzzuVxZSYyVscjb4fKxSgqSOz2aE3g==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1793929791;
	h=DMARC-Filter:DKIM-Signature:X-Alimail-AntiSpam:Received:From:To:Cc:
	 Subject:Date:Message-ID:X-Mailer:MIME-Version:
	 Content-Transfer-Encoding;
	bh=FDEdvRW2qMYa9xxlAN0aPEzctXRxc4Lt0+J1Enj5sqc=;
	b=BFxpf8myR+OHGqE0RGunWu5TOWPJud2qOIDVpSBDxG1vvGDwA/P8PctzOAHWAigYG6ZQ
	 b62AFtQ0031A5IXzynYUJ1+OZUmWBH9hME8r/8kboOUC6VlI/IUZHxVrlXfHGLu3guRvR
	 wPJ6aoAxaWBAsXOAAQUui6YUWbNqOeTPQj1gcj/yF5y4zpMfteHndAehV8I7sgwHMoLtZ
	 GQXe1NNVTsbM55OhXlFeG/wcdUqn41ucDJW228dbIiMlXkSH3OHA3mLQG3n84L6B1ux0K
	 1AH575RAra4Li+aBdL84+h5+6Ol4+riOn6wIsB+/owrTnjgtTiqadLjduwAjejB4ZUg==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=none header.from=xiaopeng.com;
	spf=pass smtp.mailfrom=xiaopeng.com;
	dkim=pass header.d=xiaopeng.com header.i=@xiaopeng.com header.a=rsa-sha256 header.s=default header.b=CTSKEtoJ;
	arc=none smtp.remote-ip=115.124.28.196
Received: from out28-196.mail.aliyun.com (out28-196.mail.aliyun.com [115.124.28.196])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1CE3C606D803;
	Fri,  6 Nov 2026 01:49:49 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 1CE3C606D803
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=xiaopeng.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=xiaopeng.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key, unprotected) header.d=xiaopeng.com header.i=@xiaopeng.com header.a=rsa-sha256 header.s=default header.b=CTSKEtoJ
DKIM-Signature:v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=xiaopeng.com; s=default;
	t=1793929787; h=From:To:Subject:Date:Message-ID:MIME-Version;
	bh=FDEdvRW2qMYa9xxlAN0aPEzctXRxc4Lt0+J1Enj5sqc=;
	b=CTSKEtoJMy6T5RYIqYD19AHvezcw0RRCLuIe2GZ86uuzE6kGACELMd37iMZjvIYCW+ygtOHPR+r7I/G+ak4pCQuqr/uT4OsWVRE4rr3D4htLJe6cRNjw0PQDLxCZC0747iYcERtQIrtyVx6KMiBcl3e0HZrrx2Sx/MnE6IJCe8Q=
X-Alimail-AntiSpam:AC=CONTINUE;BC=0.07680749|-1;CH=green;DM=|CONTINUE|false|;DS=CONTINUE|ham_regular_dialog|0.00595435-0.00433875-0.989707;FP=13129445745589044890|0|0|0|0|-1|-1|-1;HT=maildocker-contentspam033032065030;MF=guozh23@xiaopeng.com;NM=1;PH=DS;RN=9;RT=9;SR=0;TI=SMTPD_---.jxsQSWC_1793929786;
Received: from localhost(mailfrom:guozh23@xiaopeng.com fp:SMTPD_---.jxsQSWC_1793929786 cluster:ay29)
          by smtp.aliyun-inc.com;
          Fri, 06 Nov 2026 09:49:47 +0800
From: Guo Zihao <guozh23@xiaopeng.com>
To: Peter Huewe <peterhuewe@gmx.de>,
	Jarkko Sakkinen <jarkko@kernel.org>
Cc: Jason Gunthorpe <jgg@ziepe.ca>,
	Ashley Lai <adlai@linux.vnet.ibm.com>,
	Kent Yoder <key@linux.vnet.ibm.com>,
	linuxppc-dev@lists.ozlabs.org,
	linux-integrity@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	stable@vger.kernel.org
Subject: [PATCH] tpm: ibmvtpm: check the response size against the buffer size
Date: Fri,  6 Nov 2026 09:49:46 +0800
Message-ID: <20261106014946.4128696-1-guozh23@xiaopeng.com>
X-Mailer: git-send-email 2.50.1
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

The send path validates the transfer size against the size of the
RTCE buffer:

	if (count > ibmvtpm->rtce_size) {
		dev_err(ibmvtpm->dev,
			"Invalid size in send: count=%zd, rtce_size=%d\n",
			count, ibmvtpm->rtce_size);
		return -EIO;
	}

The receive path has no such check: the response length is whatever
the hypervisor reported in the completion CRQ, and it is only
compared against the size the caller asked for before being used to
copy and clear the RTCE buffer:

	len = ibmvtpm->res_len;

	if (count < len) {
		...
		return -EIO;
	}

	spin_lock(&ibmvtpm->rtce_lock);
	memcpy((void *)buf, (void *)ibmvtpm->rtce_buf, len);
	memset(ibmvtpm->rtce_buf, 0, len);

A response length larger than the RTCE buffer makes the memcpy read
past the buffer and the memset clear past it.

Reject a response that does not fit in the RTCE buffer, mirroring
the check the send path already performs.

Fixes: 132f76294744 ("drivers/char/tpm: Add new device driver to support IBM vTPM")
Cc: stable@vger.kernel.org
Signed-off-by: Guo Zihao <guozh23@xiaopeng.com>
---
 drivers/char/tpm/tpm_ibmvtpm.c | 7 +++++++
 1 file changed, 7 insertions(+)

diff --git a/drivers/char/tpm/tpm_ibmvtpm.c b/drivers/char/tpm/tpm_ibmvtpm.c
index 6fb4d30eb..bfef4bc14 100644
--- a/drivers/char/tpm/tpm_ibmvtpm.c
+++ b/drivers/char/tpm/tpm_ibmvtpm.c
@@ -121,6 +121,13 @@ static int tpm_ibmvtpm_recv(struct tpm_chip *chip, u8 *buf, size_t count)
 		return -EIO;
 	}
 
+	if (len > ibmvtpm->rtce_size) {
+		dev_err(ibmvtpm->dev,
+			"Invalid size in recv: res_len=%d, rtce_size=%d\n",
+			len, ibmvtpm->rtce_size);
+		return -EIO;
+	}
+
 	spin_lock(&ibmvtpm->rtce_lock);
 	memcpy((void *)buf, (void *)ibmvtpm->rtce_buf, len);
 	memset(ibmvtpm->rtce_buf, 0, len);
-- 
2.50.1

